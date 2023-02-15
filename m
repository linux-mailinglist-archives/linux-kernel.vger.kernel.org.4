Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF83B698166
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBOQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBOQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:55:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA7B1E5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:55:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 76E7233A04;
        Wed, 15 Feb 2023 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676480103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJxg8jEcjxtYicFkZgjwZzVCWCIDZeFxQL4uhOskhM0=;
        b=u0l9r6ewpMcfPok5kKBnBNzepRzcbk57d2MySf9wycS55E5klR+ayrnBRlRYICdT5NzE72
        R9fJ5F2Bs+sb0Y9pXuSkimEuar30u/kf9oyrjfxbFy/FYh//JzXon/xx7OtKVIt2cMrLWG
        EIa3bUkt2jcpM098S3DMlO3TkN0d3V0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5666F13483;
        Wed, 15 Feb 2023 16:55:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qZaCEmcO7WO6SwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 15 Feb 2023 16:55:03 +0000
Date:   Wed, 15 Feb 2023 17:55:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Qi Zheng <arch0.zheng@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>, x86@kernel.org
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Message-ID: <Y+0OZjTLhZG/Fs7G@dhcp22.suse.cz>
References: <Y+tXrK/g1Nrd/q1h@kernel.org>
 <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
 <Y+t0Bhu7BCzH2Dp4@kernel.org>
 <a7f8be91-32c1-bfbe-7e81-5b1e818ba01d@redhat.com>
 <a09bfe3a-87e4-f8ce-89bb-c5fde8cc33c9@redhat.com>
 <Y+uO5IE7boORqsne@dhcp22.suse.cz>
 <Y+ymKw1eJaRcmDNN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+ymKw1eJaRcmDNN@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-02-23 11:30:19, Mike Rapoport wrote:
[...]
> >From b670120bcacd3fe34a40d7179c70ca2ab69279e0 Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Date: Wed, 15 Feb 2023 11:12:18 +0200
> Subject: [PATCH] x86/mm: drop 4MB restriction on minimal NUMA node size
> 
> Qi Zheng reports crashes in a production environment and provides a
> simplified example as a reproducer:
> 
>   For example, if we use qemu to start a two NUMA node kernel,
>   one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>   and the other node has 2G, then we will encounter the
>   following panic:
> 
>   [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>   [    0.150783] #PF: supervisor write access in kernel mode
>   [    0.151488] #PF: error_code(0x0002) - not-present page
>   <...>
>   [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>   <...>
>   [    0.169781] Call Trace:
>   [    0.170159]  <TASK>
>   [    0.170448]  deactivate_slab+0x187/0x3c0
>   [    0.171031]  ? bootstrap+0x1b/0x10e
>   [    0.171559]  ? preempt_count_sub+0x9/0xa0
>   [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>   [    0.172735]  ? bootstrap+0x1b/0x10e
>   [    0.173236]  bootstrap+0x6b/0x10e
>   [    0.173720]  kmem_cache_init+0x10a/0x188
>   [    0.174240]  start_kernel+0x415/0x6ac
>   [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>   [    0.175417]  </TASK>
>   [    0.175713] Modules linked in:
>   [    0.176117] CR2: 0000000000000000
> 
> The crashes happen because of inconsistency between nodemask that has
> nodes with less than 4MB as memoryless and the actual memory fed into
> core mm.
> 
> The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
> empty node in SRAT parsing") that introduced minimal size of a NUMA node
> does not explain why a node size cannot be less than 4MB and what boot
> failures this restriction might fix.
> 
> Since then a lot has changed and core mm won't confuse badly about small
> node sizes.
> 
> Drop the limitation for the minimal node size.
> 
> Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Yes, I would start with this. If the original reasoning to have a limit
still exists then we would need to have a closer look but right now I
would much rather drop this unexplained subtlety. If we hit the issue we
would get a more specific description at least.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  arch/x86/include/asm/numa.h | 7 -------
>  arch/x86/mm/numa.c          | 7 -------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> index e3bae2b60a0d..ef2844d69173 100644
> --- a/arch/x86/include/asm/numa.h
> +++ b/arch/x86/include/asm/numa.h
> @@ -12,13 +12,6 @@
>  
>  #define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
>  
> -/*
> - * Too small node sizes may confuse the VM badly. Usually they
> - * result from BIOS bugs. So dont recognize nodes as standalone
> - * NUMA entities that have less than this amount of RAM listed:
> - */
> -#define NODE_MIN_SIZE (4*1024*1024)
> -
>  extern int numa_off;
>  
>  /*
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..55e3d895f15c 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -601,13 +601,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>  		if (start >= end)
>  			continue;
>  
> -		/*
> -		 * Don't confuse VM with a node that doesn't have the
> -		 * minimum amount of memory:
> -		 */
> -		if (end && (end - start) < NODE_MIN_SIZE)
> -			continue;
> -
>  		alloc_node_data(nid);
>  	}
>  
> -- 
> 2.35.1
> 
> 
> > -- 
> > Michal Hocko
> > SUSE Labs
> 
> -- 
> Sincerely yours,
> Mike.

-- 
Michal Hocko
SUSE Labs
