Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0490F695D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjBNIma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBNIm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:42:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45B31E1F1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:42:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5081E1F38A;
        Tue, 14 Feb 2023 08:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676364138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+yPQ7STKZejEDaLV9A1Do+iJot5hAT6AJuIj39XP74=;
        b=bIaZlbTT0J5GZgWQ6v1rstZ+K4splt9J9xHbQutmbDS0RnvtOJT8tAqjClcq6tMVsBW5kg
        tXXgK1bSUphUg6StrYclV9TW7qXxUeP3TZQJcB2gizeJVRXNdDW3RmaV/CG2o7ZbzB+Rpj
        fKqPpVFisnTV7mZhkR8etB7kWWYUh2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676364138;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+yPQ7STKZejEDaLV9A1Do+iJot5hAT6AJuIj39XP74=;
        b=HOKv7N1GVT3WOe1QryExhDOlI0UIutz5jFlPxPvQIkeIA+PFuSliMa/0IoEZzklpxFbj7a
        yXwswkeq6w+5xyBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2569E138E3;
        Tue, 14 Feb 2023 08:42:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uJJ2CGpJ62P/LwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Feb 2023 08:42:18 +0000
Message-ID: <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
Date:   Tue, 14 Feb 2023 09:42:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
 <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 12:00, Qi Zheng wrote:
> 
> 
> On 2023/2/13 16:47, Vlastimil Babka wrote:
>> On 2/12/23 12:03, Qi Zheng wrote:
>>> In x86, numa_register_memblks() is only interested in
>>> those nodes which have enough memory, so it skips over
>>> all nodes with memory below NODE_MIN_SIZE (treated as
>>> a memoryless node). Later on, we will initialize these
>>> memoryless nodes (allocate pgdat in free_area_init()
>>> and build zonelist etc), and will online these nodes
>>> in init_cpu_to_node() and init_gi_nodes().
>>>
>>> After boot, these memoryless nodes are in N_ONLINE
>>> state but not in N_MEMORY state. But we can still allocate
>>> pages from these memoryless nodes.
>>>
>>> In SLUB, we only process nodes in the N_MEMORY state,
>>> such as allocating their struct kmem_cache_node. So if
>>> we allocate a page from the memoryless node above to
>>> SLUB, the struct kmem_cache_node of the node corresponding
>>> to this page is NULL, which will cause panic.
>>>
>>> For example, if we use qemu to start a two numa node kernel,
>>> one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>>> and the other node has 2G, then we will encounter the
>>> following panic:
>>>
>>> [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>> [    0.150783] #PF: supervisor write access in kernel mode
>>> [    0.151488] #PF: error_code(0x0002) - not-present page
>>> <...>
>>> [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>>> <...>
>>> [    0.169781] Call Trace:
>>> [    0.170159]  <TASK>
>>> [    0.170448]  deactivate_slab+0x187/0x3c0
>>> [    0.171031]  ? bootstrap+0x1b/0x10e
>>> [    0.171559]  ? preempt_count_sub+0x9/0xa0
>>> [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>>> [    0.172735]  ? bootstrap+0x1b/0x10e
>>> [    0.173236]  bootstrap+0x6b/0x10e
>>> [    0.173720]  kmem_cache_init+0x10a/0x188
>>> [    0.174240]  start_kernel+0x415/0x6ac
>>> [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>>> [    0.175417]  </TASK>
>>> [    0.175713] Modules linked in:
>>> [    0.176117] CR2: 0000000000000000
>>>
>>> In addition, we can also encountered this panic in the actual
>>> production environment. We set up a 2c2g container with two
>>> numa nodes, and then reserved 128M for kdump, and then we
>>> can encountered the above panic in the kdump kernel.
>>>
>>> To fix it, we can filter memoryless nodes when allocating
>>> pages.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> Reported-by: Teng Hu <huteng.ht@bytedance.com>
>> 
>> Well AFAIK the key mechanism to only allocate from "good" nodes is the
>> zonelist, we shouldn't need to start putting extra checks like this. So it
>> seems to me that the code building the zonelists should take the
>> NODE_MIN_SIZE constraint in mind.
> 
> Indeed. How about the following patch:

+Cc also David, forgot earlier.

Looks good to me, at least.

> @@ -6382,8 +6378,11 @@ int find_next_best_node(int node, nodemask_t 
> *used_node_mask)
>          int min_val = INT_MAX;
>          int best_node = NUMA_NO_NODE;
> 
> -       /* Use the local node if we haven't already */
> -       if (!node_isset(node, *used_node_mask)) {
> +       /*
> +        * Use the local node if we haven't already. But for memoryless 
> local
> +        * node, we should skip it and fallback to other nodes.
> +        */
> +       if (!node_isset(node, *used_node_mask) && node_state(node, 
> N_MEMORY)) {
>                  node_set(node, *used_node_mask);
>                  return node;
>          }
> 
> For memoryless node, we skip it and fallback to other nodes when
> build its zonelists.
> 
> Say we have node0 and node1, and node0 is memoryless, then:
> 
> [    0.102400] Fallback order for Node 0: 1
> [    0.102931] Fallback order for Node 1: 1
> 
> In this way, we will not allocate pages from memoryless node0.
> 
>> 
>>> ---
>>>   mm/page_alloc.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 588555754601..b9cce56f4e21 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -4188,6 +4188,11 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>>>   			(alloc_flags & ALLOC_CPUSET) &&
>>>   			!__cpuset_zone_allowed(zone, gfp_mask))
>>>   				continue;
>>> +
>>> +		/* Don't allocate page from memoryless nodes. */
>>> +		if (!node_state((zone_to_nid(zone)), N_MEMORY))
>>> +			continue;
>>> +
>>>   		/*
>>>   		 * When allocating a page cache page for writing, we
>>>   		 * want to get it from a node that is within its dirty
>> 
> 

