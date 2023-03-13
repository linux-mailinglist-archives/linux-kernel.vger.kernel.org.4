Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8586B7D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjCMQ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjCMQ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4757A90B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678724865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=s8sJ/cpBUh6LGMZ+lcAYSBuSqrBbcVYVRwc+yqWmsjw=;
        b=VmieFrNyXtV1VDpHI26EEzy1xpQogJpnGOLKPqHUO0caxC5K88HncBOcMdS36ruQFdrmMi
        W1epDBe7fA2cN6+I8pzuYluMOpcbHmSnVM80sWg0wHKyxSmtCxkGrKrQhxyTo3E1d6Wpks
        j2hOLxCBZ600HdSzkd2hgB/qxVqP+yM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-ZMuT39A6OHKSVs7hfn-Tvw-1; Mon, 13 Mar 2023 12:27:41 -0400
X-MC-Unique: ZMuT39A6OHKSVs7hfn-Tvw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4280818E0045;
        Mon, 13 Mar 2023 16:27:40 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15EC3492C14;
        Mon, 13 Mar 2023 16:27:40 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 467DB4038AB8F; Mon, 13 Mar 2023 13:26:44 -0300 (-03)
Message-ID: <20230313162634.561005765@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 13 Mar 2023 13:25:19 -0300
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
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v5 12/12] vmstat: add pcp remote node draining via cpu_vm_stats_fold
References: <20230313162507.032200398@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
 
@@ -2060,7 +2100,7 @@ static int refresh_all_vm_stats(void)
 
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
@@ -291,7 +291,7 @@ extern void __dec_zone_state(struct zone
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
@@ -8629,7 +8629,7 @@ static int page_alloc_cpu_dead(unsigned
 	 * Zero the differential counters of the dead processor
 	 * so that the vm statistics are consistent.
 	 */
-	cpu_vm_stats_fold(cpu);
+	cpu_vm_stats_fold(cpu, false);
 
 	for_each_populated_zone(zone)
 		zone_pcp_update(zone, 0);


