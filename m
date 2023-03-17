Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E366BE815
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCQLcV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 07:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCQLcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:32:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C7F442CE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:32:18 -0700 (PDT)
Received: from dggpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PdMQc0zh6zrS14;
        Fri, 17 Mar 2023 19:31:20 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 19:32:15 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.021;
 Fri, 17 Mar 2023 19:32:15 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     "xuqiang (M)" <xuqiang36@huawei.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Thread-Topic: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Thread-Index: AQHZVnGyqCLx+d0GeECeM+z9zE2Dsg==
Date:   Fri, 17 Mar 2023 11:32:15 +0000
Message-ID: <344c7521d72e4107b451c19b329e9864@huawei.com>
References: <20230314123403.100158-1-chenjun102@huawei.com>
 <0cad1ff3-8339-a3eb-fc36-c8bda1392451@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.43]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/3/14 22:41, Vlastimil Babka 写道:
> 
> On 3/14/23 13:34, Chen Jun wrote:
>> When kmalloc_node() is called without __GFP_THISNODE and the target node
>> lacks sufficient memory, SLUB allocates a folio from a different node
>> other than the requested node, instead of taking a partial slab from it.
>>
>> However, since the allocated folio does not belong to the requested
>> node, it is deactivated and added to the partial slab list of the node
>> it belongs to.
>>
>> This behavior can result in excessive memory usage when the requested
>> node has insufficient memory, as SLUB will repeatedly allocate folios
>> from other nodes without reusing the previously allocated ones.
>>
>> To prevent memory wastage,
>> when (node != NUMA_NO_NODE) && (gfpflags & __GFP_THISNODE) is:
>> 1) try to get a partial slab from target node with __GFP_THISNODE.
>> 2) if 1) failed, try to allocate a new slab from target node with
>>     __GFP_THISNODE.
>> 3) if 2) failed, retry 1) and 2) without __GFP_THISNODE constraint.
>>
>> when node != NUMA_NO_NODE || (gfpflags & __GFP_THISNODE), the behavior
>> remains unchanged.
>>
>> On qemu with 4 numa nodes and each numa has 1G memory. Write a test ko
>> to call kmalloc_node(196, GFP_KERNEL, 3) for (4 * 1024 + 4) * 1024 times.
>>
>> cat /proc/slabinfo shows:
>> kmalloc-256       4200530 13519712    256   32    2 : tunables..
>>
>> after this patch,
>> cat /proc/slabinfo shows:
>> kmalloc-256       4200558 4200768    256   32    2 : tunables..
>>
>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>> ---
>>   mm/slub.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 39327e98fce3..32e436957e03 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2384,7 +2384,7 @@ static void *get_partial(struct kmem_cache *s, int node, struct partial_context
>>   		searchnode = numa_mem_id();
>>   
>>   	object = get_partial_node(s, get_node(s, searchnode), pc);
>> -	if (object || node != NUMA_NO_NODE)
>> +	if (object || (node != NUMA_NO_NODE && (pc->flags & __GFP_THISNODE)))
>>   		return object;
>>   
>>   	return get_any_partial(s, pc);
>> @@ -3069,6 +3069,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   	struct slab *slab;
>>   	unsigned long flags;
>>   	struct partial_context pc;
>> +	bool try_thisnode = true;
>>   
>>   	stat(s, ALLOC_SLOWPATH);
>>   
>> @@ -3181,8 +3182,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   	}
>>   
>>   new_objects:
>> -
>>   	pc.flags = gfpflags;
>> +
>> +	/*
>> +	 * when (node != NUMA_NO_NODE) && (gfpflags & __GFP_THISNODE)
>> +	 * 1) try to get a partial slab from target node with __GFP_THISNODE.
>> +	 * 2) if 1) failed, try to allocate a new slab from target node with
>> +	 *    __GFP_THISNODE.
>> +	 * 3) if 2) failed, retry 1) and 2) without __GFP_THISNODE constraint.
>> +	 */
>> +	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
>> +			pc.flags |= __GFP_THISNODE;
> 
> Hmm I'm thinking we should also perhaps remove direct reclaim possibilities
> from the attempt 2). In your qemu test it should make no difference, as it
> fills everything with kernel memory that is not reclaimable. But in practice
> the target node might be filled with user memory, and I think it's better to
> quickly allocate on a different node than spend time in direct reclaim. So
> the following should work I think?
> 
> pc.flags = GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE
> 

Hmm, Should it be that:

pc.flags |= GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE
          ^
>> +
>>   	pc.slab = &slab;
>>   	pc.orig_size = orig_size;
>>   	freelist = get_partial(s, node, &pc);
>> @@ -3190,10 +3201,15 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   		goto check_new_slab;
>>   
>>   	slub_put_cpu_ptr(s->cpu_slab);
>> -	slab = new_slab(s, gfpflags, node);
>> +	slab = new_slab(s, pc.flags, node);
>>   	c = slub_get_cpu_ptr(s->cpu_slab);
>>   
>>   	if (unlikely(!slab)) {
>> +		if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode) {
>> +			try_thisnode = false;
>> +			goto new_objects;
>> +		}
>> +
>>   		slab_out_of_memory(s, gfpflags, node);
>>   		return NULL;
>>   	}
> 
> 

