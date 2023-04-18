Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE206E6CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjDRTOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjDRTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:05 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843357EE5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:40 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l11so30662352qtj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845220; x=1684437220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35b4U2+QOBa6ocJ8iDrcqYLn7rCBrGVWRfOUb6rO6cw=;
        b=NAETWyARHURXPOi9rz+E7BtKwnN/WCnP/+JO7LpCEDD8Yt6Nwt9wWNaKjVbRvN3xz2
         CI34kcfshgq+HARendk3lJbfoBE5MkvdQWSrlrPBJRjmqsIYk3kDyWnUU7Frq+txzTlS
         H4HITpALdNoddu4n6BLDIclxULAYQC3G62W5TzlCuce+rhSeoOwKcEgfrWQxqneeYLbo
         7wKg/+icg/zDzq1yq49DPPPiRs66pUC5NSRrssu+vBTZ4mZZ9Ce9QCpZuahqpc5imLz3
         XtNWiOATBaotDlzMFP51F9IOzwQmK3bigZcA6HkmSjex3STf6qkddtjV7o1GG3sIRsXg
         ppGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845220; x=1684437220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35b4U2+QOBa6ocJ8iDrcqYLn7rCBrGVWRfOUb6rO6cw=;
        b=CWPN/Py9jaL3C3BICvSHu68mK9Ews/X1mmtSyl9evjMJgLNEIgYR/oqdJ/QBMtYYFO
         +QaI2GcAm1l/TX76TINJLtZGuKblB+ZCtXzpqQ1ppqfjCwwB3E7ugzE4oM5Y6+8AXoX5
         HvxKrK3OLixMwwe/LAYrqax7aUsGvHlO1yu/l8cqxUDBVVlRfQUmI29eyOYS83f8VSlF
         jD6j5ByLoTHGv8cBvLP9L9isLmXLybNetO6/GW6TEi4V8ytCOkvQm2FINm5VBRtR5okc
         nfNS62pNB8untXuRoCXcbz55Fw0cM5+kUvmQEwPjlcWlXfk1jOtK1X2kO/STSYvIWnXl
         ux9g==
X-Gm-Message-State: AAQBX9e63tRKY/IA2cAVcd05joqVT+vqZ4IHwoQGrI3KoVmWl/Cs2mMx
        ydkIrxTU+xBX/12467RhTnW+Vg==
X-Google-Smtp-Source: AKy350Y9D95GmbNdWa9qjbsQ3a5RYAukR0KDWI7MiGw1X4tAzUYurG+5JZjzgpO5fAjmLVD2oLXHwg==
X-Received: by 2002:ac8:7fd6:0:b0:3bd:1081:b939 with SMTP id b22-20020ac87fd6000000b003bd1081b939mr2038244qtk.0.1681845220210;
        Tue, 18 Apr 2023 12:13:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id d14-20020a37680e000000b0074d1b6a8187sm2482147qkc.130.2023.04.18.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:39 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 18/26] mm: compaction: remove unnecessary is_via_compact_memory() checks
Date:   Tue, 18 Apr 2023 15:13:05 -0400
Message-Id: <20230418191313.268131-19-hannes@cmpxchg.org>
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

Remove from all paths not reachable via /proc/sys/vm/compact_memory.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 11 +----------
 mm/vmscan.c     |  8 +-------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index d4b7d5b36600..0aa2a0a192dc 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2265,9 +2265,6 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		unsigned long available;
 		unsigned long watermark;
 
-		if (is_via_compact_memory(order))
-			return true;
-
 		/* Allocation can already succeed, nothing to do */
 		watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 		if (zone_watermark_ok(zone, order, watermark,
@@ -2808,9 +2805,6 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 		if (!populated_zone(zone))
 			continue;
 
-		if (is_via_compact_memory(pgdat->kcompactd_max_order))
-			return true;
-
 		/* Allocation can already succeed, check other zones */
 		if (zone_watermark_ok(zone, pgdat->kcompactd_max_order,
 				      min_wmark_pages(zone),
@@ -2855,9 +2849,6 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (compaction_deferred(zone, cc.order))
 			continue;
 
-		if (is_via_compact_memory(cc.order))
-			goto compact;
-
 		/* Allocation can already succeed, nothing to do */
 		if (zone_watermark_ok(zone, cc.order,
 				      min_wmark_pages(zone), zoneid, 0))
@@ -2866,7 +2857,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (compaction_suitable(zone, cc.order,
 					zoneid) != COMPACT_CONTINUE)
 			continue;
-compact:
+
 		if (kthread_should_stop())
 			return;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a0ebdbf3efcf..ee8c8ca2e7b5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6076,9 +6076,6 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 		if (!managed_zone(zone))
 			continue;
 
-		if (sc->order == -1) /* is_via_compact_memory() */
-			return false;
-
 		/* Allocation can already succeed, nothing to do */
 		if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
 				      sc->reclaim_idx, 0))
@@ -6275,9 +6272,6 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	unsigned long watermark;
 	unsigned long free_pages;
 
-	if (sc->order == -1) /* is_via_compact_memory() */
-		goto suitable;
-
 	/* Allocation can already succeed, nothing to do */
 	if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
 			      sc->reclaim_idx, 0))
@@ -6287,7 +6281,7 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	if (compaction_suitable(zone, sc->order,
 				sc->reclaim_idx) == COMPACT_SKIPPED)
 		return false;
-suitable:
+
 	/*
 	 * Compaction is already possible, but it takes time to run and there
 	 * are potentially other callers using the pages just freed. So proceed
-- 
2.39.2

