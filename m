Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6FD703BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbjEOSHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243053AbjEOSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C41F301
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684173825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=g+P2pLjwIHGTBC73R7sGDBbFogsWx67Df0W2nS+tUE4=;
        b=LPwbOa+FUHtn5dV0EVawj0fifNw7JpIAoitJ2UHiMyeGaeKJf7KcKgEpRrkn1+LfFLd7C0
        ctaphAaz/P07I+aHRO6n58/etDGoURVIXopA6jCPNbUwbxPu9rq9bcBfUpFPNpusfH7JBk
        WU1RKOnEMtW16pDxu/GRr8kquCZDcYQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-3Deovc6xNXishRmnvXFshg-1; Mon, 15 May 2023 14:03:43 -0400
X-MC-Unique: 3Deovc6xNXishRmnvXFshg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2844F87082B;
        Mon, 15 May 2023 18:03:43 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFB9040C6EC4;
        Mon, 15 May 2023 18:03:42 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 40D304161E50E; Mon, 15 May 2023 15:02:17 -0300 (-03)
Message-ID: <20230515180138.442505633@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 15 May 2023 15:00:16 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v8 01/13] vmstat: allow_direct_reclaim should use zone_page_state_snapshot
References: <20230515180015.016409657@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A customer provided evidence indicating that a process
was stalled in direct reclaim:

 - The process was trapped in throttle_direct_reclaim().
   The function wait_event_killable() was called to wait condition     
   allow_direct_reclaim(pgdat) for current node to be true.     
   The allow_direct_reclaim(pgdat) examined the number of free pages     
   on the node by zone_page_state() which just returns value in     
   zone->vm_stat[NR_FREE_PAGES].     
                                                
 - On node #1, zone->vm_stat[NR_FREE_PAGES] was 0.            
   However, the freelist on this node was not empty.     
                           
 - This inconsistent of vmstat value was caused by percpu vmstat on     
   nohz_full cpus. Every increment/decrement of vmstat is performed     
   on percpu vmstat counter at first, then pooled diffs are cumulated     
   to the zone's vmstat counter in timely manner. However, on nohz_full     
   cpus (in case of this customer's system, 48 of 52 cpus) these pooled     
   diffs were not cumulated once the cpu had no event on it so that     
   the cpu started sleeping infinitely.                       
   I checked percpu vmstat and found there were total 69 counts not         
   cumulated to the zone's vmstat counter yet.     
                                         
 - In this situation, kswapd did not help the trapped process.     
   In pgdat_balanced(), zone_wakermark_ok_safe() examined the number     
   of free pages on the node by zone_page_state_snapshot() which     
   checks pending counts on percpu vmstat.     
   Therefore kswapd could know there were 69 free pages correctly.     
   Since zone->_watermark = {8, 20, 32}, kswapd did not work because     
   69 was greater than 32 as high watermark.     

Change allow_direct_reclaim to use zone_page_state_snapshot, which
allows a more precise version of the vmstat counters to be used.

allow_direct_reclaim will only be called from try_to_free_pages,
which is not a hot path.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

Index: linux-vmstat-remote/mm/vmscan.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmscan.c
+++ linux-vmstat-remote/mm/vmscan.c
@@ -6886,7 +6886,7 @@ static bool allow_direct_reclaim(pg_data
 			continue;
 
 		pfmemalloc_reserve += min_wmark_pages(zone);
-		free_pages += zone_page_state(zone, NR_FREE_PAGES);
+		free_pages += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 	}
 
 	/* If there are no reserves (unexpected config) then do not throttle */


