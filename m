Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84E571FFC7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjFBKxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbjFBKxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:53:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B43C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:53:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A82A621A2B;
        Fri,  2 Jun 2023 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685703226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1dyLmKV0kxq22TD/woGmtkSsobVVmJGaJxu9nNzdl5k=;
        b=T2o32muAymyCIBhDhH4q16e8fbOZm0bETCwx+0hgjxsCgL3sc+cbX7gKV1f4ovFKA5B/t0
        XCx2RaD8RfjgORG/4qO3Np04w6N577J4LqVLt4FxFxH3UmZ6bn9f4xbXf37un2fA/3Vq04
        c8bNqL9bp2KwLKS9xjioaPtP/6oihlk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8977613A2E;
        Fri,  2 Jun 2023 10:53:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wBY4HzrKeWR7YwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 02 Jun 2023 10:53:46 +0000
Date:   Fri, 2 Jun 2023 12:53:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 1/4] vmstat: allow_direct_reclaim should use
 zone_page_state_snapshot
Message-ID: <ZHnKOVfwHQXBwA4k@dhcp22.suse.cz>
References: <20230530145234.968927611@redhat.com>
 <20230530145335.677325196@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530145335.677325196@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, as I've stated in previously, this sounds like a reasonable
standalone fix worth taking independently of the rest.

On Tue 30-05-23 11:52:35, Marcelo Tosatti wrote:
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
> 
> Testing: Due to difficulties accessing the system, it has not been
> possible for the reproducer to test the patch (however its
> clear from available data and analysis that it should fix it).
> 
> Reviewed-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> 
> Index: linux-vmstat-remote/mm/vmscan.c
> ===================================================================
> --- linux-vmstat-remote.orig/mm/vmscan.c
> +++ linux-vmstat-remote/mm/vmscan.c
> @@ -6887,7 +6887,7 @@ static bool allow_direct_reclaim(pg_data
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
