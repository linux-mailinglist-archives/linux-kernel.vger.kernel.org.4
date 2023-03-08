Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017096AFF88
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjCHHQ5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Mar 2023 02:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCHHQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:16:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6D6498A6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:16:52 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PWkBD1XXCzrSWD;
        Wed,  8 Mar 2023 15:16:04 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 15:16:50 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.021;
 Wed, 8 Mar 2023 15:16:49 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [RFC] mm/slub: Reduce memory consumption in extreme scenarios
Thread-Topic: [RFC] mm/slub: Reduce memory consumption in extreme scenarios
Thread-Index: AQHZUM8n8Cz2r/0+O0WpGZE+2ntUXw==
Date:   Wed, 8 Mar 2023 07:16:49 +0000
Message-ID: <4ad448c565134d76bea0ac8afffe4f37@huawei.com>
References: <20230307082811.120774-1-chenjun102@huawei.com>
 <ZAdIJKkT8VHdbPs9@localhost>
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

Hi,

Thanks for reply.

$B:_(B 2023/3/7 22:20, Hyeonggon Yoo $B<LF;(B:
> On Tue, Mar 07, 2023 at 08:28:11AM +0000, Chen Jun wrote:
>> If call kmalloc_node with NO __GFP_THISNODE and node[A] with no memory.
>> Slub will alloc a slub page which is not belong to A, and put the page
>> to kmem_cache_node[page_to_nid(page)]. The page can not be reused
>> at next calling, because NULL will be get from get_partical().
>> That make kmalloc_node consume more memory.
> 
> Hello,
> 
> elaborating a little bit:
> 
> "When kmalloc_node() is called without __GFP_THISNODE and the target node
> lacks sufficient memory, SLUB allocates a folio from a different node other
> than the requested node, instead of taking a partial slab from it.
> 
> However, since the allocated folio does not belong to the requested node,
> it is deactivated and added to the partial slab list of the node it
> belongs to.
> 
> This behavior can result in excessive memory usage when the requested
> node has insufficient memory, as SLUB will repeatedly allocate folios from
> other nodes without reusing the previously allocated ones.
> 
> To prevent memory wastage, take a partial slab from a different node when
> the requested node has no partial slab and __GFP_THISNODE is not explicitly
> specified."
> 

Thanks, This is more clear than what I described.

>> On qemu with 4 numas and each numa has 1G memory, Write a test ko
>> to call kmalloc_node(196, 0xd20c0, 3) for 5 * 1024 * 1024 times.
>>
>> cat /proc/slabinfo shows:
>> kmalloc-256       4302317 15151808    256   32    2 : tunables..
>>
>> the total objects is much more then active objects.
>>
>> After this patch, cat /prac/slubinfo shows:
>> kmalloc-256       5244950 5245088    256   32    2 : tunables..
>>
>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>> ---
>>   mm/slub.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 39327e98fce3..c0090a5de54e 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2384,7 +2384,7 @@ static void *get_partial(struct kmem_cache *s, int node, struct partial_context
>>   		searchnode = numa_mem_id();
>>   
>>   	object = get_partial_node(s, get_node(s, searchnode), pc);
>> -	if (object || node != NUMA_NO_NODE)
>> +	if (object || (node != NUMA_NO_NODE && (pc->flags & __GFP_THISNODE)))
>>   		return object;
> 
> I think the problem here is to avoid taking a partial slab from
> different node than the requested node even if __GFP_THISNODE is not set.
> (and then allocating new slab instead)
> 
> Thus this hunk makes sense to me,
> even if SLUB currently do not implement __GFP_THISNODE semantics.
> 
>>   	return get_any_partial(s, pc);
>> @@ -3069,6 +3069,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   	struct slab *slab;
>>   	unsigned long flags;
>>   	struct partial_context pc;
>> +	int try_thisndoe = 0;
>>
>>   
>>   	stat(s, ALLOC_SLOWPATH);
>>   
>> @@ -3181,8 +3182,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   	}
>>   
>>   new_objects:
>> -
>>   	pc.flags = gfpflags;
>> +
>> +	/* Try to get page from specific node even if __GFP_THISNODE is not set */
>> +	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
>> +			pc.flags |= __GFP_THISNODE;
>> +
>>   	pc.slab = &slab;
>>   	pc.orig_size = orig_size;
>>   	freelist = get_partial(s, node, &pc);
>> @@ -3190,10 +3195,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   		goto check_new_slab;
>>   
>>   	slub_put_cpu_ptr(s->cpu_slab);
>> -	slab = new_slab(s, gfpflags, node);
>> +	slab = new_slab(s, pc.flags, node);
>>   	c = slub_get_cpu_ptr(s->cpu_slab);
>>   
>>   	if (unlikely(!slab)) {
>> +		/* Try to get page from any other node */
>> +		if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode) {
>> +			try_thisnode = 0;
>> +			goto new_objects;
>> +		}
>> +
>>   		slab_out_of_memory(s, gfpflags, node);
>>   		return NULL;
> 
> But these hunks do not make sense to me.
> Why force __GFP_THISNODE even when the caller did not specify it?
> 
> (Apart from the fact that try_thisnode is defined as try_thisndoe,
>   and try_thisnode is never set to nonzero value.)

My mistake$B!$(B It should be:
int try_thisnode = 0;

> 
> IMHO the first hunk is enough to solve the problem.

I think, we should try to alloc a page on the target node before getting 
one from other nodes' partial.

If the caller does not specify __GFP_THISNODE, we add __GFP_THISNODE to 
try to get the slab only on the target node. If it fails, use the 
original GFP FLAG to allow fallback.

> 
> Thanks,
> Hyeonggon
> 
>>   	}
>> -- 
>> 2.17.1
>>
>>
> 

Thanks,
Chen Jun
