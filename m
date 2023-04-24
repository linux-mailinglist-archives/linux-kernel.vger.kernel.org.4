Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E66EC3C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 04:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjDXCyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 22:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXCyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:54:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAE8211F;
        Sun, 23 Apr 2023 19:54:51 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q4V7z50zBzKtrQ;
        Mon, 24 Apr 2023 10:53:51 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 24 Apr
 2023 10:54:47 +0800
Message-ID: <f5b23bbc-6fb5-84d3-fcad-6253b346328a@huawei.com>
Date:   Mon, 24 Apr 2023 10:54:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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
 <36019eb3-4b71-26c4-21ad-b0e0eabd0ca5@intel.com>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <36019eb3-4b71-26c4-21ad-b0e0eabd0ca5@intel.com>
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

On 2023/04/05 23:15, Alexander Lobakin wrote:
> From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Date: Wed, 5 Apr 2023 21:26:47 +0900
> 
>> ...
>>
>> I'm not yet sure if this feature is appropriate for mainline kernel.
>>
>> I have few questions:
>>
>> 1) What is cost of this configuration, in terms of memory overhead, or
>> execution time?
>>
>>
>> 2) The actual cache depends on caller which is static at build time, not
>> runtime.
>>
>>     What about using (caller ^ (some subsystem-wide random sequence)),
>>
>>     which is static at runtime?
> 
> Why can't we just do
> 
> 	random_get_u32_below(CONFIG_RANDOM_KMALLOC_CACHES_NR)
> 
> ?

This makes the cache selection "dynamic", i.e. each kmalloc() will
randomly pick a different cache at each time it's executed. The problem
of this approach is that it only reduces the probability of the cache
being sprayed by the attacker, and the attacker can bypass it by simply
repeating the attack multiple times in a brute-force manner.

Our proposal is to make the randomness be with respect to the code
address rather than time, i.e. allocations in different code paths would
most likely pick different caches, although kmalloc() at each place
would use the same cache copy whenever it is executed. In this way, the
code path that the attacker uses would most likely pick a different
cache than which the targeted subsystem/driver would pick, which means
in most of cases the heap spraying is unachievable.

> It's fast enough according to Jason... `_RET_IP_ % nr` doesn't sound
> "secure" to me. It really is a compile-time constant, which can be
> calculated (or not?) manually. Even if it wasn't, `% nr` doesn't sound
> good, there should be at least hash_32().

Yes, `_RET_IP_ % nr` is a bit naive. Currently the patch is more like a
PoC so I wrote this. Indeed a proper hash function should be used here.

And yes _RET_IP_ could somehow be manually determined especially for
kernels without KASLR, and I think adding a per-boot random seed into
the selection could solve this.

I will implement these in v2. Thanks!

> 
> Thanks,
> Olek
> 
