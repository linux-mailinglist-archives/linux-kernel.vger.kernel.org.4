Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D356170F68D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjEXMe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjEXMex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:34:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36721A6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:34:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6AD231F8BF;
        Wed, 24 May 2023 12:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684931679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AiiMIvYGdbIRGL9zQDfeMCY6Hk4lfNGeYEXmOzeLdh0=;
        b=eDp4QudooCjdxpuWCFiomINeR63fpz11H/DfOnUwO7iR8RKbLClzPI9G1HSlFw/4jQUlLw
        U6y+szIJ3lKAPBGQBgvx4Amf9OQVgnABQBWTeI2fWxlZR93ByrtsD7q73sSG+GzkdVa8Sk
        n09CF444KiotVDN91YA0flskmKbWnIE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41FD313425;
        Wed, 24 May 2023 12:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t7NMDV8EbmQeawAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 24 May 2023 12:34:39 +0000
Date:   Wed, 24 May 2023 14:34:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v8 01/13] vmstat: allow_direct_reclaim should use
 zone_page_state_snapshot
Message-ID: <ZG4EXoyvGsZTu2jb@dhcp22.suse.cz>
References: <20230515180015.016409657@redhat.com>
 <20230515180138.442505633@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515180138.442505633@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15-05-23 15:00:16, Marcelo Tosatti wrote:
> A customer provided evidence indicating that a process
> was stalled in direct reclaim:
> 
>  - The process was trapped in throttle_direct_reclaim().
>    The function wait_event_killable() was called to wait condition     
>    allow_direct_reclaim(pgdat) for current node to be true.     
>    The allow_direct_reclaim(pgdat) examined the number of free pages     
>    on the node by zone_page_state() which just returns value in     
>    zone->vm_stat[NR_FREE_PAGES].     
>                                                 
>  - On node #1, zone->vm_stat[NR_FREE_PAGES] was 0.            
>    However, the freelist on this node was not empty.     
>                            
>  - This inconsistent of vmstat value was caused by percpu vmstat on     
>    nohz_full cpus. Every increment/decrement of vmstat is performed     
>    on percpu vmstat counter at first, then pooled diffs are cumulated     
>    to the zone's vmstat counter in timely manner. However, on nohz_full     
>    cpus (in case of this customer's system, 48 of 52 cpus) these pooled     
>    diffs were not cumulated once the cpu had no event on it so that     
>    the cpu started sleeping infinitely.                       
>    I checked percpu vmstat and found there were total 69 counts not         
>    cumulated to the zone's vmstat counter yet.     
>                                          
>  - In this situation, kswapd did not help the trapped process.     
>    In pgdat_balanced(), zone_wakermark_ok_safe() examined the number     
>    of free pages on the node by zone_page_state_snapshot() which     
>    checks pending counts on percpu vmstat.     
>    Therefore kswapd could know there were 69 free pages correctly.     
>    Since zone->_watermark = {8, 20, 32}, kswapd did not work because     
>    69 was greater than 32 as high watermark.     
> 
> Change allow_direct_reclaim to use zone_page_state_snapshot, which
> allows a more precise version of the vmstat counters to be used.
> 
> allow_direct_reclaim will only be called from try_to_free_pages,
> which is not a hot path.

I have asked this patch to contain a note about testing done for future
reference IIRC. You have said that the above scenario is not easy to
reproduce and therefore not much of testing has been done but this is a
valuable information on its own.

> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

I have also acked the patch. So let me repeat
Acked-by: Michal Hocko <mhocko@suse.com>

Btw. the patch should be routed separately as it is a potential fix.
> 
> ---
> 
> Index: linux-vmstat-remote/mm/vmscan.c
> ===================================================================
> --- linux-vmstat-remote.orig/mm/vmscan.c
> +++ linux-vmstat-remote/mm/vmscan.c
> @@ -6886,7 +6886,7 @@ static bool allow_direct_reclaim(pg_data
>  			continue;
>  
>  		pfmemalloc_reserve += min_wmark_pages(zone);
> -		free_pages += zone_page_state(zone, NR_FREE_PAGES);
> +		free_pages += zone_page_state_snapshot(zone, NR_FREE_PAGES);
>  	}
>  
>  	/* If there are no reserves (unexpected config) then do not throttle */
> 

-- 
Michal Hocko
SUSE Labs
