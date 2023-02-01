Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15112686F51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjBATxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjBATxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:53:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75055399E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675281154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7C1hmy1E7+0MQkK/mZzmUZ/gKoFVIBd7d2YZY/3tmcQ=;
        b=K0TUK8Jf/YQ1ZfGDvVwedSuO7AIlE/pq6gzEq+CPDDSWHcwRiFTlrOlU80+LFz3rdlkZtR
        u2Lzi0aH89+0/KJs3q+8vjwf2V5XAyYZs/ODIHuEZGYiwFVXYw/ABjcM8DmImByOVhZbyE
        soCbd52DKRdXNFRK3eX9qVXTFuYXCZ4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-mZt9PK5VNHS2IdT6gYfx_w-1; Wed, 01 Feb 2023 14:52:31 -0500
X-MC-Unique: mZt9PK5VNHS2IdT6gYfx_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A1D73C02558;
        Wed,  1 Feb 2023 19:52:30 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 182731121339;
        Wed,  1 Feb 2023 19:52:30 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 0D1C1403C42BF; Wed,  1 Feb 2023 16:51:49 -0300 (-03)
Message-ID: <20230201195104.411744803@redhat.com>
User-Agent: quilt/0.67
Date:   Wed, 01 Feb 2023 16:50:14 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 1/5] mm/vmstat: remove remote node draining
References: <20230201195013.881721887@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Draining of pages from the local pcp for a remote zone was necessary
since:

"Note that remote node draining is a somewhat esoteric feature that is
required on large NUMA systems because otherwise significant portions
of system memory can become trapped in pcp queues. The number of pcp is
determined by the number of processors and nodes in a system. A system
with 4 processors and 2 nodes has 8 pcps which is okay. But a system
with 1024 processors and 512 nodes has 512k pcps with a high potential
for large amount of memory being caught in them."

Since commit 443c2accd1b6679a1320167f8f56eed6536b806e
("mm/page_alloc: remotely drain per-cpu lists"), drain_all_pages() is able 
to remotely free those pages when necessary.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/include/linux/mmzone.h
===================================================================
--- linux-vmstat-remote.orig/include/linux/mmzone.h
+++ linux-vmstat-remote/include/linux/mmzone.h
@@ -577,9 +577,6 @@ struct per_cpu_pages {
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
 	short free_factor;	/* batch scaling factor during free */
-#ifdef CONFIG_NUMA
-	short expire;		/* When 0, remote pagesets are drained */
-#endif
 
 	/* Lists of pages, one per migrate type stored on the pcp-lists */
 	struct list_head lists[NR_PCP_LISTS];
Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -803,7 +803,7 @@ static int fold_diff(int *zone_diff, int
  *
  * The function returns the number of global counters updated.
  */
-static int refresh_cpu_vm_stats(bool do_pagesets)
+static int refresh_cpu_vm_stats(void)
 {
 	struct pglist_data *pgdat;
 	struct zone *zone;
@@ -814,9 +814,6 @@ static int refresh_cpu_vm_stats(bool do_
 
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
-#ifdef CONFIG_NUMA
-		struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
-#endif
 
 		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 			int v;
@@ -826,44 +823,8 @@ static int refresh_cpu_vm_stats(bool do_
 
 				atomic_long_add(v, &zone->vm_stat[i]);
 				global_zone_diff[i] += v;
-#ifdef CONFIG_NUMA
-				/* 3 seconds idle till flush */
-				__this_cpu_write(pcp->expire, 3);
-#endif
 			}
 		}
-#ifdef CONFIG_NUMA
-
-		if (do_pagesets) {
-			cond_resched();
-			/*
-			 * Deal with draining the remote pageset of this
-			 * processor
-			 *
-			 * Check if there are pages remaining in this pageset
-			 * if not then there is nothing to expire.
-			 */
-			if (!__this_cpu_read(pcp->expire) ||
-			       !__this_cpu_read(pcp->count))
-				continue;
-
-			/*
-			 * We never drain zones local to this processor.
-			 */
-			if (zone_to_nid(zone) == numa_node_id()) {
-				__this_cpu_write(pcp->expire, 0);
-				continue;
-			}
-
-			if (__this_cpu_dec_return(pcp->expire))
-				continue;
-
-			if (__this_cpu_read(pcp->count)) {
-				drain_zone_pages(zone, this_cpu_ptr(pcp));
-				changes++;
-			}
-		}
-#endif
 	}
 
 	for_each_online_pgdat(pgdat) {
@@ -1864,7 +1825,7 @@ int sysctl_stat_interval __read_mostly =
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
 {
-	refresh_cpu_vm_stats(true);
+	refresh_cpu_vm_stats();
 }
 
 int vmstat_refresh(struct ctl_table *table, int write,
@@ -1928,7 +1889,7 @@ int vmstat_refresh(struct ctl_table *tab
 
 static void vmstat_update(struct work_struct *w)
 {
-	if (refresh_cpu_vm_stats(true)) {
+	if (refresh_cpu_vm_stats()) {
 		/*
 		 * Counters were updated so we expect more updates
 		 * to occur in the future. Keep on running the
@@ -1991,7 +1952,7 @@ void quiet_vmstat(void)
 	 * it would be too expensive from this path.
 	 * vmstat_shepherd will take care about that for us.
 	 */
-	refresh_cpu_vm_stats(false);
+	refresh_cpu_vm_stats();
 }
 
 /*


