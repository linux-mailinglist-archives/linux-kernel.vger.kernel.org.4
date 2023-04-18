Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B345F6E6CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjDRTPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjDRTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:05 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5C3B450
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:44 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id l17so9291333qvq.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845223; x=1684437223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsTBnxogc0dXbXldiQnTcfaSMnaw37pvCiHuIsUwhKs=;
        b=SD0CfPNo/FtA52mn8PTuMlWwsWPdBrYNWFQm6HroBkjTNWL2qXQf7wrFmhK/WWm7IP
         xcIXlFfLFGEf/BrGyHz+UE3kHnP2QzzQB7WXPEZFLWPxISNTxWhAaa0h1tT0olaHgEUs
         0hpjB9LzjiA5OHWB18U6c4fyqiiCG4R128OFbaQXw6cA+VNmAHuxaR45uultoYesSJx0
         CVUbWebDBfJA3QQt/c1BCijGivD+dCjM9agqh7+5bqifw5Letf8PMz5QSYbJeZ5UTCUP
         tSHckFJNQ1uiBdu7JKbqXKX13Y5T5FnoLNhX7VZobyOD8tLkxHSMFOnr57kBpsZRcWht
         QozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845223; x=1684437223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsTBnxogc0dXbXldiQnTcfaSMnaw37pvCiHuIsUwhKs=;
        b=JecI5p0UiMmOZEUqCo/7yw4MR+hxEQtZn+xSnGAjLpCYTfrA+Pv7KiI+WCfkTR1rGS
         pX8U9zo1dXhqFfauJ39UvqcKioefZ3RPtcnHHsATvk1AcSTyNrNNojs41UUzqmIswx9w
         brhgX7VR27ZSb0CYoFrQhyPwmYtVg53HyyW7lMsFSBsoQTGvbldpPbotE2cWdr43pWAg
         8fKadlPpRYwNS20lVIYbcxK6iRrbH62ycw9bXPGFjA8JFroaDjMDZAd+gveoYBjXAD+O
         kLgf8wJ5KvdKDNPlMTzDSpUi/p91DYgoTbqKe6hJR6J8lHZkBzaNfrgYhem3lGJ1QjeF
         fDPw==
X-Gm-Message-State: AAQBX9fcTFwk4CwWNCe1MSDHSHkuOHGUo/D0Gs9gcIc+Ng8YhZ8T2uo+
        aEJnRpD2L81PJNC8pPkKAZwREA==
X-Google-Smtp-Source: AKy350afvFhbEDO4u0w1iKrPXbytvWWwl+mYLWsq6qZEuaKTZTEbfiazBxZv7n8V0c8QP05wvdn3Kw==
X-Received: by 2002:a05:6214:2607:b0:5c2:a8b0:d71a with SMTP id gu7-20020a056214260700b005c2a8b0d71amr27349805qvb.43.1681845223606;
        Tue, 18 Apr 2023 12:13:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id x18-20020a0ce252000000b005dd8b934598sm3884188qvl.48.2023.04.18.12.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:43 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 21/26] mm: compaction: align compaction goals with reclaim goals
Date:   Tue, 18 Apr 2023 15:13:08 -0400
Message-Id: <20230418191313.268131-22-hannes@cmpxchg.org>
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

Kswapd's goal is to balance at least one zone in the node for the
requested zoneidx, but no more than that. Kcompactd on the other hand
compacts all the zones in the node, even if one of them is already
compacted for the given request.

This can hog kcompactd unnecessarily long on a requested zoneidx. It
also has kcompactd working on zones without the cooperation of
kswapd. There is a compaction_suitable() check of course, but whether
that is true or not depends on luck, risking erratic behavior.

Make kcompactd follow the same criteria as kswapd when deciding to
work on a node, to keep them working in unison as much as possible.

Likewise, direct reclaim can bail as soon as one zone in the zonelist
is compaction_ready(), so check up front before hammering lower zones
while higher zones might already be suitable. This matches
compaction_zonelist_suitable() on the compaction side.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c |  5 +++--
 mm/vmscan.c     | 35 +++++++++++++++++------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 52103545d58c..8080c04e644a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2798,12 +2798,13 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 		if (!populated_zone(zone))
 			continue;
 
-		/* Allocation can already succeed, check other zones */
+		/* Allocation can succeed in any zone, done */
 		if (zone_watermark_ok(zone, pgdat->kcompactd_max_order,
 				      min_wmark_pages(zone),
 				      highest_zoneidx, 0))
-			continue;
+			return true;
 
+		/* Allocation can't succed, but enough order-0 to compact */
 		if (compaction_suitable(zone, pgdat->kcompactd_max_order,
 					highest_zoneidx) == COMPACT_CONTINUE)
 			return true;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 723705b9e4d9..14d6116384cc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6277,7 +6277,7 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 			      sc->reclaim_idx, 0))
 		return true;
 
-	/* Compaction cannot yet proceed. Do reclaim. */
+	/* Compaction cannot yet proceed, might need reclaim */
 	if (compaction_suitable(zone, sc->order,
 				sc->reclaim_idx) == COMPACT_SKIPPED)
 		return false;
@@ -6357,6 +6357,21 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		sc->reclaim_idx = gfp_zone(sc->gfp_mask);
 	}
 
+	/* Bail if any of the zones are already compactable */
+	if (IS_ENABLED(CONFIG_COMPACTION) &&
+	    sc->order > PAGE_ALLOC_COSTLY_ORDER) {
+		for_each_zone_zonelist_nodemask(zone, z, zonelist,
+						sc->reclaim_idx, sc->nodemask) {
+			if (!cpuset_zone_allowed(zone,
+						 GFP_KERNEL | __GFP_HARDWALL))
+				continue;
+			if (compaction_ready(zone, sc)) {
+				sc->compaction_ready = true;
+				goto out;
+			}
+		}
+	}
+
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					sc->reclaim_idx, sc->nodemask) {
 		/*
@@ -6368,22 +6383,6 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 						 GFP_KERNEL | __GFP_HARDWALL))
 				continue;
 
-			/*
-			 * If we already have plenty of memory free for
-			 * compaction in this zone, don't free any more.
-			 * Even though compaction is invoked for any
-			 * non-zero order, only frequent costly order
-			 * reclamation is disruptive enough to become a
-			 * noticeable problem, like transparent huge
-			 * page allocations.
-			 */
-			if (IS_ENABLED(CONFIG_COMPACTION) &&
-			    sc->order > PAGE_ALLOC_COSTLY_ORDER &&
-			    compaction_ready(zone, sc)) {
-				sc->compaction_ready = true;
-				continue;
-			}
-
 			/*
 			 * Shrink each node in the zonelist once. If the
 			 * zonelist is ordered by zone (not the default) then a
@@ -6420,7 +6419,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 
 	if (first_pgdat)
 		consider_reclaim_throttle(first_pgdat, sc);
-
+out:
 	/*
 	 * Restore to original mask to avoid the impact on the caller if we
 	 * promoted it to __GFP_HIGHMEM.
-- 
2.39.2

