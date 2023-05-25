Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B567105F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbjEYHHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjEYHHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:07:46 -0400
X-Greylist: delayed 136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 May 2023 00:07:44 PDT
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net (p3plsmtpa12-03.prod.phx3.secureserver.net [68.178.252.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB8719D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:07:44 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id 252Mq3fY8svF6252NqWt8T; Thu, 25 May 2023 00:05:28 -0700
X-CMAE-Analysis: v=2.4 cv=SsxWqtC0 c=1 sm=1 tr=0 ts=646f08b8
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17
 a=IkcTkHD0fZMA:10 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=j-LfP5YGAAAA:8
 a=Uda1tbkDn9zVvUAUaBAA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
 a=pci6KG57UX3UzFLC8IW4:22
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Thu, 25 May 2023 08:05:26 +0100
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: [PATCH v8 01/13] vmstat: allow_direct_reclaim should use
 zone_page_state_snapshot
Message-ID: <20230525070526.5uhmh6zku5gzxyny@atomlin.usersys.com>
References: <20230515180015.016409657@redhat.com>
 <20230515180138.442505633@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515180138.442505633@redhat.com>
X-CMAE-Envelope: MS4xfFR1UFf+kSbpQNwP6Fw1448N7D2LwqquPSuM0YlBaOIm7wJbbUVwHw71ZPtd6nJhpJR69B/HBGQ/347cIzSRBQLxbXIVBdZXTDzSoVdvcjLl8tu9DlgI
 ogj2P0as2mSQpl7MNBn1MmnMuoGhqdHeHKaZ6STF4LWHKoYqaf/fJqlKy3xQ7lSl/lVe21Ztiraen8+hvu5B8eyzzww/Xdcj9dqXdJb3Vhw5UbCRZccwbgEx
 kBuqhMc1dBnb1NRGorrRBf7z4to6bvUthdcX1IHC8AlQ22iPIlP9tx/04FhsDKrs3hl9E0dFMkvIzOXjib9V7M1xQsFXVWTtYcaS85lh+XF0h4ul/G+10eQ4
 l6JwcjFhQcyIPvX9/7SKIs3jTh7693jWCIb9t/Ej4gQUxtUAmlv2JPi67WhV4o+seQ8gCfa8iyXHq9hr3Nvu4QZUcHBGH5W80S/cpOJaBE84UTrDiqWIp5JB
 b/DS8jqdUyFE6oh/OOw+DBu93h53AjBPnqWYhiGKK5VbK+rZJutLlZqZgHA5YaYU7jAmOJe/eTYA+HkU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 03:00:16PM -0300, Marcelo Tosatti wrote:
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
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
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
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
