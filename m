Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC80E6E6CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjDRTPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjDRTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:05 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DDBAF0D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:43 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id dd8so17376824qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845222; x=1684437222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD8cI1T5Y1yip08nzZ5ycgmWClJik+UbLC7ebo3KxqY=;
        b=ABr/1kuC79+cxAX8L6WJR2/bWTqWb8HcQEjFbpPZF0HuB9YW1YJMuRW7gyOVzYVPRw
         03H6aLq7CX52ef2Om4hh96VGqT7TjGkiKZRVbtTbvnP86DodSH+fBT3Bg8K3RBiskmEn
         PBPAPvjvrcmBXvcXT5D1ENEFAgwZsOibeMRYfxOUHZ/XIjDWRlAOEno0v6h4ZjF413dj
         hOYeaOUBMh9OFP6N6OvsQe4bSQ4Xtq8Jibe8ALXvvyUnSx8zCdaZb/tqXiSYgET+QTx0
         uVr7LhBCB60jsNBnVVB4qFMsgKQHi2Oe9RlYbzhzQb172EdH3Z+Txzl+m/HRkKeizyY4
         nKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845222; x=1684437222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bD8cI1T5Y1yip08nzZ5ycgmWClJik+UbLC7ebo3KxqY=;
        b=VL6O/yF0K8RslDGzEcJ15tyXobMVjcc+H9LDn69CGMQS0+KCYKTjsYuuu/hjcb3tn+
         YfHjmSLba8JuqTrhFKkKGdc2fxsX57ycbjAou0RqhNvhh9FjWKUr3vgsAlyvgD2hhXe6
         OqhZ5YvqP5V+V2AaE5VcI4SDoN4g6SFPdlRrKpHQoywaFZWFAREXSNVd7sXUHklbYRkU
         UgkupnPVJ5nukjceX/hKYwy4EmBQeyOpGA6O7KwdBfv2829q76Yj9NnIWs1TKCkQ6IhC
         H+/SwJ3pkzjXmoNGNMr8esJ7JmH1TSgR+m6ETQldyIFUUJGZCjzpnhNhPTxHmkoS5noe
         88uA==
X-Gm-Message-State: AAQBX9fRqAIZbBkQAfhmTSVJtWsPuSZ78qk55Q+nchpaoic6H8LMKg5v
        qIDnAbDYcOoxDkCTg95Bp2wnAQ==
X-Google-Smtp-Source: AKy350ZedblEphVsszu1HNXxFw88IPawTMC/tacVCADIVXo/ITvdIoDkqo0MjIIYPO3ZAuvFaGP6+g==
X-Received: by 2002:a05:6214:e49:b0:5ef:564a:3296 with SMTP id o9-20020a0562140e4900b005ef564a3296mr17532356qvc.44.1681845222547;
        Tue, 18 Apr 2023 12:13:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id ep19-20020a05621418f300b005dd8b934594sm3931380qvb.44.2023.04.18.12.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:42 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 20/26] mm: vmscan: use compaction_suitable() check in kswapd
Date:   Tue, 18 Apr 2023 15:13:07 -0400
Message-Id: <20230418191313.268131-21-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kswapd currently bails on higher-order allocations with an open-coded
check for whether it's reclaimed the compaction gap.

compaction_suitable() is the customary interface to coordinate reclaim
with compaction.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 67 ++++++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 44 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ee8c8ca2e7b5..723705b9e4d9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6872,12 +6872,18 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 		if (!managed_zone(zone))
 			continue;
 
+		/* Allocation can succeed in any zone, done */
 		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
 			mark = wmark_pages(zone, WMARK_PROMO);
 		else
 			mark = high_wmark_pages(zone);
 		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
 			return true;
+
+		/* Allocation can't succeed, but enough order-0 to compact */
+		if (compaction_suitable(zone, order,
+					highest_zoneidx) == COMPACT_CONTINUE)
+			return true;
 	}
 
 	/*
@@ -6968,16 +6974,6 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 	 */
 	shrink_node(pgdat, sc);
 
-	/*
-	 * Fragmentation may mean that the system cannot be rebalanced for
-	 * high-order allocations. If twice the allocation size has been
-	 * reclaimed then recheck watermarks only at order-0 to prevent
-	 * excessive reclaim. Assume that a process requested a high-order
-	 * can direct reclaim/compact.
-	 */
-	if (sc->order && sc->nr_reclaimed >= compact_gap(sc->order))
-		sc->order = 0;
-
 	return sc->nr_scanned >= sc->nr_to_reclaim;
 }
 
@@ -7018,15 +7014,13 @@ clear_reclaim_active(pg_data_t *pgdat, int highest_zoneidx)
  * that are eligible for use by the caller until at least one zone is
  * balanced.
  *
- * Returns the order kswapd finished reclaiming at.
- *
  * kswapd scans the zones in the highmem->normal->dma direction.  It skips
  * zones which have free_pages > high_wmark_pages(zone), but once a zone is
  * found to have free_pages <= high_wmark_pages(zone), any page in that zone
  * or lower is eligible for reclaim until at least one usable zone is
  * balanced.
  */
-static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
+static void balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 {
 	int i;
 	unsigned long nr_soft_reclaimed;
@@ -7226,14 +7220,6 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	__fs_reclaim_release(_THIS_IP_);
 	psi_memstall_leave(&pflags);
 	set_task_reclaim_state(current, NULL);
-
-	/*
-	 * Return the order kswapd stopped reclaiming at as
-	 * prepare_kswapd_sleep() takes it into account. If another caller
-	 * entered the allocator slow path while kswapd was awake, order will
-	 * remain at the higher level.
-	 */
-	return sc.order;
 }
 
 /*
@@ -7251,7 +7237,7 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
 	return curr_idx == MAX_NR_ZONES ? prev_highest_zoneidx : curr_idx;
 }
 
-static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
+static void kswapd_try_to_sleep(pg_data_t *pgdat, int order,
 				unsigned int highest_zoneidx)
 {
 	long remaining = 0;
@@ -7269,7 +7255,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 	 * eligible zone balanced that it's also unlikely that compaction will
 	 * succeed.
 	 */
-	if (prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
+	if (prepare_kswapd_sleep(pgdat, order, highest_zoneidx)) {
 		/*
 		 * Compaction records what page blocks it recently failed to
 		 * isolate pages from and skips them in the future scanning.
@@ -7282,7 +7268,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 		 * We have freed the memory, now we should compact it to make
 		 * allocation of the requested order possible.
 		 */
-		wakeup_kcompactd(pgdat, alloc_order, highest_zoneidx);
+		wakeup_kcompactd(pgdat, order, highest_zoneidx);
 
 		remaining = schedule_timeout(HZ/10);
 
@@ -7296,8 +7282,8 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 					kswapd_highest_zoneidx(pgdat,
 							highest_zoneidx));
 
-			if (READ_ONCE(pgdat->kswapd_order) < reclaim_order)
-				WRITE_ONCE(pgdat->kswapd_order, reclaim_order);
+			if (READ_ONCE(pgdat->kswapd_order) < order)
+				WRITE_ONCE(pgdat->kswapd_order, order);
 		}
 
 		finish_wait(&pgdat->kswapd_wait, &wait);
@@ -7308,8 +7294,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 	 * After a short sleep, check if it was a premature sleep. If not, then
 	 * go fully to sleep until explicitly woken up.
 	 */
-	if (!remaining &&
-	    prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
+	if (!remaining && prepare_kswapd_sleep(pgdat, order, highest_zoneidx)) {
 		trace_mm_vmscan_kswapd_sleep(pgdat->node_id);
 
 		/*
@@ -7350,8 +7335,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
  */
 static int kswapd(void *p)
 {
-	unsigned int alloc_order, reclaim_order;
-	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
+	unsigned int order, highest_zoneidx;
 	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
@@ -7374,22 +7358,20 @@ static int kswapd(void *p)
 	tsk->flags |= PF_MEMALLOC | PF_KSWAPD;
 	set_freezable();
 
-	WRITE_ONCE(pgdat->kswapd_order, 0);
+	order = 0;
+	highest_zoneidx = MAX_NR_ZONES - 1;
+	WRITE_ONCE(pgdat->kswapd_order, order);
 	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
+
 	atomic_set(&pgdat->nr_writeback_throttled, 0);
+
 	for ( ; ; ) {
 		bool ret;
 
-		alloc_order = reclaim_order = READ_ONCE(pgdat->kswapd_order);
-		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
-							highest_zoneidx);
-
-kswapd_try_sleep:
-		kswapd_try_to_sleep(pgdat, alloc_order, reclaim_order,
-					highest_zoneidx);
+		kswapd_try_to_sleep(pgdat, order, highest_zoneidx);
 
 		/* Read the new order and highest_zoneidx */
-		alloc_order = READ_ONCE(pgdat->kswapd_order);
+		order = READ_ONCE(pgdat->kswapd_order);
 		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
 							highest_zoneidx);
 		WRITE_ONCE(pgdat->kswapd_order, 0);
@@ -7415,11 +7397,8 @@ static int kswapd(void *p)
 		 * request (alloc_order).
 		 */
 		trace_mm_vmscan_kswapd_wake(pgdat->node_id, highest_zoneidx,
-						alloc_order);
-		reclaim_order = balance_pgdat(pgdat, alloc_order,
-						highest_zoneidx);
-		if (reclaim_order < alloc_order)
-			goto kswapd_try_sleep;
+					    order);
+		balance_pgdat(pgdat, order, highest_zoneidx);
 	}
 
 	tsk->flags &= ~(PF_MEMALLOC | PF_KSWAPD);
-- 
2.39.2

