Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDFC716567
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjE3O6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjE3O55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30228A7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685458627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=N0hJfqn4EoxiBlmJOP3aHXOKCKD0R3BQJl7dwB2jg74=;
        b=EdHnI3jwQoOpnUVaihTNjUj165h94rj052qRldzCKoM7oe3lSBAZOnAO0BwW1pUSpcVx+h
        fHn1yiYWQqXgTeZSaznrj68u1aUqYXxrkasI6FFC6mcx1TxnBtC07lZdh881WfcCeENYk/
        K0QIybQGHqdirTPQQqqnSFsOw/Hhwvk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-uE-WUPsyOkefq9LDnYZpnw-1; Tue, 30 May 2023 10:56:56 -0400
X-MC-Unique: uE-WUPsyOkefq9LDnYZpnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74F20802E58;
        Tue, 30 May 2023 14:56:51 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F1B62166B25;
        Tue, 30 May 2023 14:56:51 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 49105401CE3ED; Tue, 30 May 2023 11:56:33 -0300 (-03)
Message-ID: <20230530145335.677325196@redhat.com>
User-Agent: quilt/0.67
Date:   Tue, 30 May 2023 11:52:35 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 1/4] vmstat: allow_direct_reclaim should use zone_page_state_snapshot
References: <20230530145234.968927611@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Testing: Due to difficulties accessing the system, it has not been
possible for the reproducer to test the patch (however its
clear from available data and analysis that it should fix it).

Reviewed-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

Index: linux-vmstat-remote/mm/vmscan.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmscan.c
+++ linux-vmstat-remote/mm/vmscan.c
@@ -6887,7 +6887,7 @@ static bool allow_direct_reclaim(pg_data
 			continue;
 
 		pfmemalloc_reserve += min_wmark_pages(zone);
-		free_pages += zone_page_state(zone, NR_FREE_PAGES);
+		free_pages += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 	}
 
 	/* If there are no reserves (unexpected config) then do not throttle */


