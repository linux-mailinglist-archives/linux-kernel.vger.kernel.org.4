Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14976703BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245093AbjEOSHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbjEOSGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F42071EC0D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684173829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=RFL7dZ0ubDZf1tDjIuRkhAMaPrNe1DHD6pj/+UPZboc=;
        b=HGDm1vb4P7oeLIXHQ1mp1nGrWXOfIuI4cDDWr+V/SQgY3zPbuA1dnlRxYImQiU5AIheVs0
        FuzKDLERDpDSUM+7DB8okC+Vn7XcBYy9cFUdlO40QNXPmn7TE6IgyPWCYfJ2heOTQSHu5I
        zxYK67PyU68738Ij8auVpfF8T+z8/bY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-pdz-PnGCOay5sxJCDmG24w-1; Mon, 15 May 2023 14:03:43 -0400
X-MC-Unique: pdz-PnGCOay5sxJCDmG24w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A68188CC44;
        Mon, 15 May 2023 18:03:43 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 033C935453;
        Mon, 15 May 2023 18:03:43 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 8FD874161E532; Mon, 15 May 2023 15:02:17 -0300 (-03)
Message-ID: <20230515180138.742158693@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 15 May 2023 15:00:28 -0300
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
Subject: [PATCH v8 13/13] vmstat: add pcp remote node draining via cpu_vm_stats_fold
References: <20230515180015.016409657@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Large NUMA systems might have significant portions 
of system memory to be trapped in pcp queues. The number of pcp is                                                             
determined by the number of processors and nodes in a system. A system                                                              
with 4 processors and 2 nodes has 8 pcps which is okay. But a system                                                                
with 1024 processors and 512 nodes has 512k pcps with a high potential                                                              
for large amount of memory being caught in them.

Enable remote node draining for the CONFIG_HAVE_CMPXCHG_LOCAL case,
where vmstat_shepherd will perform the aging and draining via
cpu_vm_stats_fold.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -928,7 +928,7 @@ static int refresh_cpu_vm_stats(bool do_
  * There cannot be any access by the offline cpu and therefore
  * synchronization is simplified.
  */
-void cpu_vm_stats_fold(int cpu)
+void cpu_vm_stats_fold(int cpu, bool do_pagesets)
 {
 	struct pglist_data *pgdat;
 	struct zone *zone;
@@ -938,6 +938,9 @@ void cpu_vm_stats_fold(int cpu)
 
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat *pzstats;
+#ifdef CONFIG_NUMA
+		struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+#endif
 
 		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 
@@ -948,6 +951,11 @@ void cpu_vm_stats_fold(int cpu)
 				v = xchg(&pzstats->vm_stat_diff[i], 0);
 				atomic_long_add(v, &zone->vm_stat[i]);
 				global_zone_diff[i] += v;
+#ifdef CONFIG_NUMA
+				/* 3 seconds idle till flush */
+				if (do_pagesets)
+					pcp->expire = 3;
+#endif
 			}
 		}
 #ifdef CONFIG_NUMA
@@ -959,6 +967,38 @@ void cpu_vm_stats_fold(int cpu)
 				zone_numa_event_add(v, zone, i);
 			}
 		}
+
+		if (do_pagesets) {
+			cond_resched();
+			/*
+			 * Deal with draining the remote pageset of a
+			 * processor
+			 *
+			 * Check if there are pages remaining in this pageset
+			 * if not then there is nothing to expire.
+			 */
+			if (!pcp->expire || !pcp->count)
+				continue;
+
+			/*
+			 * We never drain zones local to this processor.
+			 */
+			if (zone_to_nid(zone) == cpu_to_node(cpu)) {
+				pcp->expire = 0;
+				continue;
+			}
+
+			WARN_ON(pcp->expire < 0);
+			/*
+			 * pcp->expire is only accessed from vmstat_shepherd context,
+			 * therefore no locking is required.
+			 */
+			if (--pcp->expire)
+				continue;
+
+			if (pcp->count)
+				drain_zone_pages(zone, pcp);
+		}
 #endif
 	}
 
@@ -2066,7 +2106,7 @@ static int refresh_all_vm_stats(void)
 
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
-		cpu_vm_stats_fold(cpu);
+		cpu_vm_stats_fold(cpu, true);
 		cond_resched();
 	}
 	cpus_read_unlock();
Index: linux-vmstat-remote/include/linux/vmstat.h
===================================================================
--- linux-vmstat-remote.orig/include/linux/vmstat.h
+++ linux-vmstat-remote/include/linux/vmstat.h
@@ -297,7 +297,7 @@ extern void __dec_zone_state(struct zone
 extern void __dec_node_state(struct pglist_data *, enum node_stat_item);
 
 void quiet_vmstat(void);
-void cpu_vm_stats_fold(int cpu);
+void cpu_vm_stats_fold(int cpu, bool do_pagesets);
 void refresh_zone_stat_thresholds(void);
 
 struct ctl_table;
Index: linux-vmstat-remote/mm/page_alloc.c
===================================================================
--- linux-vmstat-remote.orig/mm/page_alloc.c
+++ linux-vmstat-remote/mm/page_alloc.c
@@ -6250,7 +6250,7 @@ static int page_alloc_cpu_dead(unsigned
 	 * Zero the differential counters of the dead processor
 	 * so that the vm statistics are consistent.
 	 */
-	cpu_vm_stats_fold(cpu);
+	cpu_vm_stats_fold(cpu, false);
 
 	for_each_populated_zone(zone)
 		zone_pcp_update(zone, 0);


