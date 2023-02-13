Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AFD693FED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjBMIrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMIrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:47:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90634E38E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:47:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F076207F2;
        Mon, 13 Feb 2023 08:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676278064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ThIY+Kusc5cYz5dt0TLou65VXJeAGw/wNqtBbWXvA4=;
        b=xjFN9EoB1Ax65WMusFmRZ9iiwLlzAjXYRqD2gU/eva8EL79E3pjk4khqVauZlAgUHrQc5J
        iNlHNQr9+pnIkNq1dLGyE6FAq1F85EpT8JKFK/X08RX9BahrxXbTfOQSECAAyWDBl1Yu2N
        j438z2LRvxB0GPl7PRyYo0W3S2v1m/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676278064;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ThIY+Kusc5cYz5dt0TLou65VXJeAGw/wNqtBbWXvA4=;
        b=kYqZFznObZRuPYv4yx8IwDhidOgoFfhkSP9skBF2/g3hdR8XTT/agix4vc8FICeqPgiVsb
        4NTX0A+n2srLHEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32F3B1391B;
        Mon, 13 Feb 2023 08:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m8nkCzD56WPZRQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Feb 2023 08:47:44 +0000
Message-ID: <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
Date:   Mon, 13 Feb 2023 09:47:43 +0100
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
        Oscar Salvador <osalvador@suse.de>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
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

On 2/12/23 12:03, Qi Zheng wrote:
> In x86, numa_register_memblks() is only interested in
> those nodes which have enough memory, so it skips over
> all nodes with memory below NODE_MIN_SIZE (treated as
> a memoryless node). Later on, we will initialize these
> memoryless nodes (allocate pgdat in free_area_init()
> and build zonelist etc), and will online these nodes
> in init_cpu_to_node() and init_gi_nodes().
> 
> After boot, these memoryless nodes are in N_ONLINE
> state but not in N_MEMORY state. But we can still allocate
> pages from these memoryless nodes.
> 
> In SLUB, we only process nodes in the N_MEMORY state,
> such as allocating their struct kmem_cache_node. So if
> we allocate a page from the memoryless node above to
> SLUB, the struct kmem_cache_node of the node corresponding
> to this page is NULL, which will cause panic.
> 
> For example, if we use qemu to start a two numa node kernel,
> one of the nodes has 2M memory (less than NODE_MIN_SIZE),
> and the other node has 2G, then we will encounter the
> following panic:
> 
> [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    0.150783] #PF: supervisor write access in kernel mode
> [    0.151488] #PF: error_code(0x0002) - not-present page
> <...>
> [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
> <...>
> [    0.169781] Call Trace:
> [    0.170159]  <TASK>
> [    0.170448]  deactivate_slab+0x187/0x3c0
> [    0.171031]  ? bootstrap+0x1b/0x10e
> [    0.171559]  ? preempt_count_sub+0x9/0xa0
> [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
> [    0.172735]  ? bootstrap+0x1b/0x10e
> [    0.173236]  bootstrap+0x6b/0x10e
> [    0.173720]  kmem_cache_init+0x10a/0x188
> [    0.174240]  start_kernel+0x415/0x6ac
> [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
> [    0.175417]  </TASK>
> [    0.175713] Modules linked in:
> [    0.176117] CR2: 0000000000000000
> 
> In addition, we can also encountered this panic in the actual
> production environment. We set up a 2c2g container with two
> numa nodes, and then reserved 128M for kdump, and then we
> can encountered the above panic in the kdump kernel.
> 
> To fix it, we can filter memoryless nodes when allocating
> pages.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reported-by: Teng Hu <huteng.ht@bytedance.com>

Well AFAIK the key mechanism to only allocate from "good" nodes is the
zonelist, we shouldn't need to start putting extra checks like this. So it
seems to me that the code building the zonelists should take the
NODE_MIN_SIZE constraint in mind.

> ---
>  mm/page_alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 588555754601..b9cce56f4e21 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4188,6 +4188,11 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  			(alloc_flags & ALLOC_CPUSET) &&
>  			!__cpuset_zone_allowed(zone, gfp_mask))
>  				continue;
> +
> +		/* Don't allocate page from memoryless nodes. */
> +		if (!node_state((zone_to_nid(zone)), N_MEMORY))
> +			continue;
> +
>  		/*
>  		 * When allocating a page cache page for writing, we
>  		 * want to get it from a node that is within its dirty

