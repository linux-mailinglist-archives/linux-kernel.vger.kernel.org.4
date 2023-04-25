Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD5B6EDAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjDYDz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYDzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:55:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83575AD0F;
        Mon, 24 Apr 2023 20:55:21 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q57RK54VWzKvMB;
        Tue, 25 Apr 2023 11:54:21 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 25 Apr
 2023 11:55:18 +0800
Message-ID: <0f3abe0f-216b-dda6-38c4-26ffa79d966f@huawei.com>
Date:   Tue, 25 Apr 2023 11:55:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
CC:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
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
 <f5b23bbc-6fb5-84d3-fcad-6253b346328a@huawei.com>
 <ce1c307e-b7ae-2590-7b2e-43cbe963bc4d@intel.com>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <ce1c307e-b7ae-2590-7b2e-43cbe963bc4d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/04/24 21:46, Alexander Lobakin wrote:
> From: Gong, Ruiqi <gongruiqi1@huawei.com>
> Date: Mon, 24 Apr 2023 10:54:33 +0800
> 
> ...
> 
>>
>>> It's fast enough according to Jason... `_RET_IP_ % nr` doesn't sound
>>> "secure" to me. It really is a compile-time constant, which can be
>>> calculated (or not?) manually. Even if it wasn't, `% nr` doesn't sound
>>> good, there should be at least hash_32().
>>
>> Yes, `_RET_IP_ % nr` is a bit naive. Currently the patch is more like a
>> PoC so I wrote this. Indeed a proper hash function should be used here.
>>
>> And yes _RET_IP_ could somehow be manually determined especially for
>> kernels without KASLR, and I think adding a per-boot random seed into
>> the selection could solve this.
> 
> I recall how it is done for kCFI/FineIBT in the x86 code -- it also uses
> per-boot random seed (although it gets patched into the code itself each
> time, when applying alternatives). So probably should be optimal enough.
> The only thing I'm wondering is where to store this per-boot seed :D
> It's generic code, so you can't patch it directly. OTOH storing it in
> .data/.bss can make it vulnerable to attacks... Can't it?

I think marking the seed with __ro_after_init is enough, since we don't
mind it could be read by the attacker.

Given that the code paths the attacker can utilize to spray the heap is
limited, our address-related randomness in most cases prevents
kmalloc()s on these paths from picking the same cache the vulnerable
subsystem/module would pick. Although _RET_IP_ of kmalloc()s could be
known, without tampering the source code and rebuilding the image, the
attacker can't do anything to make those caches collide if the cache
selection algorithm says they don't.

So in my perspective the per-boot random seed is more like an
enhancement: if one day, by analyzing the open source code, the attacker
does find a usable kmalloc that happens to pick the same cache with the
vulnerable subsystem/module, the seed could make his/her effort wasted ;)

> 
>>
>> I will implement these in v2. Thanks!
>>
>>>
>>> Thanks,
>>> Olek
>>>
> 
> Thanks,
> Olek
