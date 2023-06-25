Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6157973D06D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjFYLZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjFYLZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:25:37 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BED1E73;
        Sun, 25 Jun 2023 04:25:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QppYd5kgRz4f3jJK;
        Sun, 25 Jun 2023 19:25:25 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
        by APP2 (Coremail) with SMTP id Syh0CgCXpuclJJhkCzGzMQ--.30443S2;
        Sun, 25 Jun 2023 19:25:26 +0800 (CST)
Message-ID: <81a71d95-fa22-a423-b94a-4bc35e1454f9@huaweicloud.com>
Date:   Sun, 25 Jun 2023 19:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/1] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Jann Horn <jannh@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
References: <20230616111843.3677378-1-gongruiqi@huaweicloud.com>
 <20230616111843.3677378-2-gongruiqi@huaweicloud.com>
 <202306211111.4E70CD6@keescook>
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <202306211111.4E70CD6@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgCXpuclJJhkCzGzMQ--.30443S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4ftFykWry5uF1rZrW3Awb_yoW7uFyUpF
        WfAF17JFZ5Jry7Cr1jvryUZry3Xw4rJrWUC34aq3ykZFyjyr10grnYgrWrury8ZF98C3Wj
        qF4kKwn8Ww15AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/06/22 2:21, Kees Cook wrote:
> On Fri, Jun 16, 2023 at 07:18:43PM +0800, GONG, Ruiqi wrote:
>> [...]
>>
>> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
>> Co-developed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> I think this looks really good. Thanks for the respin! Some
> nits/comments/questions below, but I think this can land and get
> incrementally improved. Please consider it:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks, Kees!

>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index 791f7453a04f..b7a5387f0dad 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -19,6 +19,9 @@
>>  #include <linux/workqueue.h>
>>  #include <linux/percpu-refcount.h>
>>  
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +#include <linux/hash.h>
>> +#endif
> 
> I think this can just be included unconditionally, yes?
> 

True. Will change it.

>> [...]
>> +extern unsigned long random_kmalloc_seed;
>> +
>> +static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags, unsigned long caller)
>>  {
>>  	/*
>>  	 * The most common case is KMALLOC_NORMAL, so test for it
>>  	 * with a single branch for all the relevant flags.
>>  	 */
>>  	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +		return KMALLOC_RANDOM_START + hash_64(caller ^ random_kmalloc_seed,
>> +						      CONFIG_RANDOM_KMALLOC_CACHES_BITS);
>> +#else
>>  		return KMALLOC_NORMAL;
>> +#endif
> 
> The commit log talks about having no runtime lookup, but that's not
> entirely true, given this routine. And xor and a hash_64... I wonder how
> expensive this is compared to some kind of constant expression that
> could be computed at build time... (the xor should stay, but that's
> "cheap").
> 

To be precise, currently the random selection is static during each time
the system starts and runs, but not across different system startups. In
the commit log, I've added the following paragraph to explain this
feature, and will expand it a bit in the next version:

"Meanwhile, the static random selection is further enhanced with a
per-boot random seed, which prevents the attacker from finding a usable
kmalloc that happens to pick the same cache with the vulnerable
subsystem/module by analyzing the open source code."

As for the build-time hashing, I think theoretically it could be
achieved, as long as we can have a compile-time random number generator.
However afaik the compiler has no support on this at the moment, and I
can only find a few discussions about this (in the C++ community).

>>  
>>  	/*
>>  	 * At least one of the flags has to be set. Their priorities in
>> @@ -577,7 +589,7 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>>  
>>  		index = kmalloc_index(size);
>>  		return kmalloc_trace(
>> -				kmalloc_caches[kmalloc_type(flags)][index],
>> +				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>>  				flags, size);
>>  	}
>>  	return __kmalloc(size, flags);
>> @@ -593,7 +605,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
>>  
>>  		index = kmalloc_index(size);
>>  		return kmalloc_node_trace(
>> -				kmalloc_caches[kmalloc_type(flags)][index],
>> +				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>>  				flags, node, size);
>>  	}
>>  	return __kmalloc_node(size, flags, node);
> 
> The use of _RET_IP_ is generally fine here, but I wonder about some of
> the allocation wrappers (like devm_kmalloc(), etc). I think those aren't
> being bucketed correctly? Have you checked that?
> 

Yes, I checked the distribution of used slab caches by booting the
kernel in QEMU, and /proc/slabinfo shows that they are in general evenly
spread among the copies.

I think in most cases, hashing on _RET_IP_ can effectively diverge
allocation in different subsystems/modules into different caches. For
example, using devm_kmalloc() on different places will acquire slab obj
on different cache copies:

xxx_func () {
  devm_kmalloc() {
------------  always inlined alloc_dr()  ---------------
    __kmalloc_node_track_caller(..., _RET_IP_)
--------------------------------------------------------
  }
  next inst. of devm_kmalloc()     // where _RET_IP_ takes
}

There are cases like sk_alloc(), where the wrapping is deep and all
struct sock would gather into a few caches:

sk_alloc() {
  sk_prot_alloc() {
------------  always inlined kmalloc()  -----------------
    kmalloc_trace(... kmalloc_type(flags, _RET_IP_) ...) // A
    __kmalloc(...) {
      __do_kmalloc_node(..., _RET_IP_)                   // B
    }
--------------------------------------------------------
    next inst. of kmalloc()                             // where B takes
  }
  next inst. of sk_prot_alloc()                         // where A takes
}

But it's still better than nothing. Currently _RET_IP_ is the best
option I can think of, and in general it works.

>> [...]
>> @@ -776,12 +781,44 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
>>  #define KMALLOC_RCL_NAME(sz)
>>  #endif
>>  
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +#define __KMALLOC_RANDOM_CONCAT(a, b) a ## b
>> +#define KMALLOC_RANDOM_NAME(N, sz) __KMALLOC_RANDOM_CONCAT(KMA_RAND_, N)(sz)
>> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 1
>> +#define KMA_RAND_1(sz)                  .name[KMALLOC_RANDOM_START +  0] = "kmalloc-random-01-" #sz,
> 
> I wonder if this name is getting too long? Should "random" be "rnd" ?
> *shrug*
> 

Okay. Will do.

>> [...]
>> +#define KMA_RAND_16(sz) KMA_RAND_15(sz) .name[KMALLOC_RANDOM_START + 15] = "kmalloc-random-16-" #sz,
> 
> And if we wanted to save another character, this could be numbered 0-f,
> but I defer these aesthetics to Vlastimil. :)

Same with me ;)

> 
> -Kees
> 

