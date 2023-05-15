Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A17024A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbjEOG05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239761AbjEOG0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:26:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981881FE8;
        Sun, 14 May 2023 23:26:35 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QKTr91CXhzLmJB;
        Mon, 15 May 2023 14:25:13 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 14:26:31 +0800
Message-ID: <fe79912f-3232-ffba-a191-477c80c703f4@huawei.com>
Date:   Mon, 15 May 2023 14:26:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
CC:     <linux-mm@kvack.org>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        <kasan-dev@googlegroups.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
 <75179e0d-f62c-6d3c-9353-e97dd5c9d9ad@intel.com>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <75179e0d-f62c-6d3c-9353-e97dd5c9d9ad@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/05/11 22:54, Alexander Lobakin wrote:

[...]

>> @@ -777,12 +783,44 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
>>  #define KMALLOC_RCL_NAME(sz)
>>  #endif
>>  
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +#define __KMALLOC_RANDOM_CONCAT(a, b, c) a ## b ## c
>> +#define KMALLOC_RANDOM_NAME(N, sz) __KMALLOC_RANDOM_CONCAT(KMALLOC_RANDOM_, N, _NAME)(sz)
>> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 1
>> +#define KMALLOC_RANDOM_1_NAME(sz)                             .name[KMALLOC_RANDOM_START +  0] = "kmalloc-random-01-" #sz,
>> +#define KMALLOC_RANDOM_2_NAME(sz)  KMALLOC_RANDOM_1_NAME(sz)  .name[KMALLOC_RANDOM_START +  1] = "kmalloc-random-02-" #sz,
>> +#endif
>> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 2
>> +#define KMALLOC_RANDOM_3_NAME(sz)  KMALLOC_RANDOM_2_NAME(sz)  .name[KMALLOC_RANDOM_START +  2] = "kmalloc-random-03-" #sz,
>> +#define KMALLOC_RANDOM_4_NAME(sz)  KMALLOC_RANDOM_3_NAME(sz)  .name[KMALLOC_RANDOM_START +  3] = "kmalloc-random-04-" #sz,
>> +#endif
>> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 3
>> +#define KMALLOC_RANDOM_5_NAME(sz)  KMALLOC_RANDOM_4_NAME(sz)  .name[KMALLOC_RANDOM_START +  4] = "kmalloc-random-05-" #sz,
>> +#define KMALLOC_RANDOM_6_NAME(sz)  KMALLOC_RANDOM_5_NAME(sz)  .name[KMALLOC_RANDOM_START +  5] = "kmalloc-random-06-" #sz,
>> +#define KMALLOC_RANDOM_7_NAME(sz)  KMALLOC_RANDOM_6_NAME(sz)  .name[KMALLOC_RANDOM_START +  6] = "kmalloc-random-07-" #sz,
>> +#define KMALLOC_RANDOM_8_NAME(sz)  KMALLOC_RANDOM_7_NAME(sz)  .name[KMALLOC_RANDOM_START +  7] = "kmalloc-random-08-" #sz,
>> +#endif
>> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 4
>> +#define KMALLOC_RANDOM_9_NAME(sz)  KMALLOC_RANDOM_8_NAME(sz)  .name[KMALLOC_RANDOM_START +  8] = "kmalloc-random-09-" #sz,
>> +#define KMALLOC_RANDOM_10_NAME(sz) KMALLOC_RANDOM_9_NAME(sz)  .name[KMALLOC_RANDOM_START +  9] = "kmalloc-random-10-" #sz,
>> +#define KMALLOC_RANDOM_11_NAME(sz) KMALLOC_RANDOM_10_NAME(sz) .name[KMALLOC_RANDOM_START + 10] = "kmalloc-random-11-" #sz,
>> +#define KMALLOC_RANDOM_12_NAME(sz) KMALLOC_RANDOM_11_NAME(sz) .name[KMALLOC_RANDOM_START + 11] = "kmalloc-random-12-" #sz,
>> +#define KMALLOC_RANDOM_13_NAME(sz) KMALLOC_RANDOM_12_NAME(sz) .name[KMALLOC_RANDOM_START + 12] = "kmalloc-random-13-" #sz,
>> +#define KMALLOC_RANDOM_14_NAME(sz) KMALLOC_RANDOM_13_NAME(sz) .name[KMALLOC_RANDOM_START + 13] = "kmalloc-random-14-" #sz,
>> +#define KMALLOC_RANDOM_15_NAME(sz) KMALLOC_RANDOM_14_NAME(sz) .name[KMALLOC_RANDOM_START + 14] = "kmalloc-random-15-" #sz,
>> +#define KMALLOC_RANDOM_16_NAME(sz) KMALLOC_RANDOM_15_NAME(sz) .name[KMALLOC_RANDOM_START + 15] = "kmalloc-random-16-" #sz,
> 
> This all can be compressed. Only two things are variables here, so
> 
> #define KMALLOC_RANDOM_N_NAME(cur, prev, sz)	\
> 	KMALLOC_RANDOM_##prev##_NAME(sz),	\	
> 	.name[KMALLOC_RANDOM_START + prev] =	\
> 		"kmalloc-random-##cur##-" #sz
> 
> #define KMALLOC_RANDOM_16_NAME(sz) KMALLOC_RANDOM_N_NAME(16, 15, sz)
> 

I tried this way of implementation but it didn't work: it did not
propagate from 16 to 1, but stopped in the middle. I think it's because
the macro is somehow (indirectly) self-referential and the preprocessor
won't expand it. Check this for more info:

https://gcc.gnu.org/onlinedocs/cpp/Self-Referential-Macros.html

> Also I'd rather not put commas ',' at the end of each macro, they're
> usually put outside where the macro is used.

It seems here we have to put commas at the end. Not only it's to align
with how KMALLOC_{RCL,CGROUP,DMA}_NAME are implemented, but also
otherwise the expansion of INIT_KMALLOC_INFO would in some cases be like:

{
	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,
	, // an empty entry with a comma
}

which would cause compilation error in kmalloc_info[]'s initialization.

>> +#endif
>> +#else // CONFIG_RANDOM_KMALLOC_CACHES
>> +#define KMALLOC_RANDOM_NAME(N, sz)
>> +#endif
>> +
>>  #define INIT_KMALLOC_INFO(__size, __short_size)			\
>>  {								\
>>  	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
>>  	KMALLOC_RCL_NAME(__short_size)				\
>>  	KMALLOC_CGROUP_NAME(__short_size)			\
>>  	KMALLOC_DMA_NAME(__short_size)				\
>> +	KMALLOC_RANDOM_NAME(CONFIG_RANDOM_KMALLOC_CACHES_NR, __short_size)	\
> 
> Can't those names be __initconst and here you'd just do one loop from 1
> to KMALLOC_CACHES_NR, which would assign names? I'm not sure compilers
> will expand that one to a compile-time constant and assigning 69
> different string pointers per one kmalloc size is a bit of a waste to me.

I'm not sure if I understand the question correctly, but I believe these
names have been __initconst since kmalloc_info[] is already marked with
it. Please let me know if it doesn't answer your question.

>>  	.size = __size,						\
>>  }
>>  
>> @@ -878,6 +916,11 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>>  		flags |= SLAB_CACHE_DMA;
>>  	}
>>  
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +	if (type >= KMALLOC_RANDOM_START && type <= KMALLOC_RANDOM_END)
>> +		flags |= SLAB_RANDOMSLAB;
>> +#endif
>> +
>>  	kmalloc_caches[type][idx] = create_kmalloc_cache(
>>  					kmalloc_info[idx].name[type],
>>  					kmalloc_info[idx].size, flags, 0,
>> @@ -904,7 +947,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>>  	/*
>>  	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
>>  	 */
>> -	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
>> +	for (type = KMALLOC_RANDOM_START; type < NR_KMALLOC_TYPES; type++) {
> 
> Can't we just define something like __KMALLOC_TYPE_START at the
> beginning of the enum to not search for all such places each time
> something new is added?

Yeah I'm okay with this. Before I apply this change I would like to know
more opinions (especially from the maintainers) about it.

> 
>>  		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
>>  			if (!kmalloc_caches[type][i])
>>  				new_kmalloc_cache(i, type, flags);
>> @@ -922,6 +965,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>>  				new_kmalloc_cache(2, type, flags);
>>  		}
>>  	}
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +	random_kmalloc_seed = get_random_u64();
>> +#endif
>>  
>>  	/* Kmalloc array is now usable */
>>  	slab_state = UP;
>> @@ -957,7 +1003,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
>>  		return ret;
>>  	}
>>  
>> -	s = kmalloc_slab(size, flags);
>> +	s = kmalloc_slab(size, flags, caller);
>>  
>>  	if (unlikely(ZERO_OR_NULL_PTR(s)))
>>  		return s;
> 
> Thanks,
> Olek
