Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5444E6EC3DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 05:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjDXDQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 23:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDXDP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:15:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ECB1AB;
        Sun, 23 Apr 2023 20:15:57 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q4VXY1krXzSvPZ;
        Mon, 24 Apr 2023 11:11:41 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 24 Apr
 2023 11:15:54 +0800
Message-ID: <8768d2ae-99ea-9890-83d9-7e1a35521aa3@huawei.com>
Date:   Mon, 24 Apr 2023 11:15:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     Roman Gushchin <roman.gushchin@linux.dev>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-hardening@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230315095459.186113-1-gongruiqi1@huawei.com>
 <b7a7c5d7-d3c8-503f-7447-602ec2a18fb0@gmail.com>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <b7a7c5d7-d3c8-503f-7447-602ec2a18fb0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply. I just came back from my paternity leave :)

On 2023/04/05 20:26, Hyeonggon Yoo wrote:
> On 3/15/2023 6:54 PM, GONG, Ruiqi wrote:
>> When exploiting memory vulnerabilities, "heap spraying" is a common
>> technique targeting those related to dynamic memory allocation (i.e. the
>> "heap"), and it plays an important role in a successful exploitation.
>> Basically, it is to overwrite the memory area of vulnerable object by
>> triggering allocation in other subsystems or modules and therefore
>> getting a reference to the targeted memory location. It's usable on
>> various types of vulnerablity including use after free (UAF), heap out-
>> of-bound write and etc.
>>
>> There are (at least) two reasons why the heap can be sprayed: 1) generic
>> slab caches are shared among different subsystems and modules, and
>> 2) dedicated slab caches could be merged with the generic ones.
>> Currently these two factors cannot be prevented at a low cost: the first
>> one is a widely used memory allocation mechanism, and shutting down slab
>> merging completely via `slub_nomerge` would be overkill.
>>
>> To efficiently prevent heap spraying, we propose the following approach:
>> to create multiple copies of generic slab caches that will never be
>> merged, and random one of them will be used at allocation. The random
>> selection is based on the location of code that calls `kmalloc()`, which
>> means it is static at runtime (rather than dynamically determined at
>> each time of allocation, which could be bypassed by repeatedly spraying
>> in brute force). In this way, the vulnerable object and memory allocated
>> in other subsystems and modules will (most probably) be on different
>> slab caches, which prevents the object from being sprayed.
>>
>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>> ---
> 
> I'm not yet sure if this feature is appropriate for mainline kernel.
> 
> I have few questions:
> 
> 1) What is cost of this configuration, in terms of memory overhead, or
> execution time? 

I haven't done a throughout test on the runtime overhead yet, but in
theory it won't be large because in essence what it does is to create
some additionally `struct kmem_cache` instances and separate the
management of slab objects from the original one cache to all these caches.

But indeed the test is necessary. I will do it based on the v2 patch.

> 
> 2) The actual cache depends on caller which is static at build time, not
> runtime.
> 
>     What about using (caller ^ (some subsystem-wide random sequence)),
> 
>     which is static at runtime?

Yes it could be better. As I said in my reply to Alexander, I will add a
the per-boot random seed in v2, and I think it's basically the `(some
subsystem-wide random sequence)` you mentioned here.
