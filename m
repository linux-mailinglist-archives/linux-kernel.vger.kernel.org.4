Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A19E5FE2B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJMTbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMTbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:31:17 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A2179388
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:31:15 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id g9so1915851qvo.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TjPreMRbl+DsOUCUiinLa3OKKpEheUYI+YsvrHyezzo=;
        b=a1gbuNuD82cmpVCbpj0pSUGnWd2k8qQY7zpQ4zqT9vzNquwtl+HXMK4keMrhadmv3S
         i8Vb+C2ct2Mr5yUFQaM4M33pulmoXicTmQul5yNAQeUaSj91XYaTLYnTzsFt1JJl0egm
         SC/pC4COp7KZ4OuyFK5VWrdlYzN/q8zjLg9v+yNtSQAQOG8pb2EsEXDXFXf0VCKDQbUA
         VoCZIdgxfVQEB2nZzOHf1IQA7muL2EanUOQfaYTOEBi9k8lC3shG+t3yjjTxbSckXBvC
         sDY7xjKOPKx4tjGS6HTFhBwMhcd8PmDP2cAQWpTFvs7CoQZGmF/u8Y3+uydWimFwHods
         7szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjPreMRbl+DsOUCUiinLa3OKKpEheUYI+YsvrHyezzo=;
        b=MFhEkVFEJ6vzjmKegZqynHOh0AbwC05/HoGWS1qFjY/FidG4gbO8v3veyByzMIbvim
         /x1CYPgKfwVdY6cUpDo2c1gKwdPfnE9zo+4DNeKQ14Qe2plqO0V8relJJX/Fb8caCYHe
         LpyUkQ+VJtbJzUDu6yFvAo5bucLhs4wGYxFA3ssVumByN69+OjQVSfsBvShtCBEQPjBo
         t6VNTPM4tBNtzxwiXyTC7jBZvW4TThh8U0SMDtSz/uPdyUA/BpLvAa+5G4IKL6+pzLG8
         ykxh/2fSNaoagYskaPBGYYgZ5a4n9AUrVbC78Y1FQL/2A07a8BSIXfnl3J/NK6DJFz9Y
         w6Mw==
X-Gm-Message-State: ACrzQf2QRobO79TE5XrACAF4AGoGGdfFr5f4XLgSpqK9tbWrXtzXMtFJ
        oe8W7zJhqyKOOA7bf/q1dBApgpQQhFrpdQ==
X-Google-Smtp-Source: AMsMyM5tE3LgPBQCNgHRpR1u9B3ktv2bfI1WRqI0ofEJpOmGq8xjVfe1D+pLkx5hhV/ukcMlaETm5A==
X-Received: by 2002:ad4:5cea:0:b0:4b4:1747:19da with SMTP id iv10-20020ad45cea000000b004b4174719damr1144897qvb.101.1665689475029;
        Thu, 13 Oct 2022 12:31:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::3a61])
        by smtp.gmail.com with ESMTPSA id bl16-20020a05620a1a9000b006bbc09af9f5sm481244qkb.101.2022.10.13.12.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 12:31:14 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: vmscan: make rotations a secondary factor in balancing anon vs file
Date:   Thu, 13 Oct 2022 15:31:13 -0400
Message-Id: <20221013193113.726425-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We noticed a 2% webserver throughput regression after upgrading from
5.6. This could be tracked down to a shift in the anon/file reclaim
balance (confirmed with swappiness) that resulted in worse reclaim
efficiency and thus more kswapd activity for the same outcome.

The change that exposed the problem is aae466b0052e ("mm/swap:
implement workingset detection for anonymous LRU"). By qualifying
swapins based on their refault distance, it lowered the cost of anon
reclaim in this workload, in turn causing (much) more anon scanning
than before. Scanning the anon list is more expensive due to the
higher ratio of mmapped pages that may rotate during reclaim, and so
the result was an increase in %sys time.

Right now, rotations aren't considered a cost when balancing scan
pressure between LRUs. We can end up with very few file refaults
putting all the scan pressure on hot anon pages that are rotated en
masse, don't get reclaimed, and never push back on the file LRU
again. We still only reclaim file cache in that case, but we burn a
lot CPU rotating anon pages. It's "fair" from an LRU age POV, but
doesn't reflect the real cost it imposes on the system.

Consider rotations as a secondary factor in balancing the LRUs. This
doesn't attempt to make a precise comparison between IO cost and CPU
cost, it just says: if reloads are about comparable between the lists,
or rotations are overwhelmingly different, adjust for CPU work.

This fixed the regression on our webservers. It has since been
deployed to the entire Meta fleet and hasn't caused any problems.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/swap.h |  5 +++--
 mm/swap.c            | 22 +++++++++++++++++-----
 mm/vmscan.c          |  4 +++-
 mm/workingset.c      |  2 +-
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a18cf4b7c724..369d7799205d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -384,8 +384,9 @@ extern unsigned long totalreserve_pages;
 
 
 /* linux/mm/swap.c */
-void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages);
-void lru_note_cost_folio(struct folio *);
+void lru_note_cost(struct lruvec *lruvec, bool file,
+		   unsigned int nr_io, unsigned int nr_rotated);
+void lru_note_cost_refault(struct folio *);
 void folio_add_lru(struct folio *);
 void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
 void lru_cache_add(struct page *);
diff --git a/mm/swap.c b/mm/swap.c
index 955930f41d20..2f12a2ee1d3a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -295,8 +295,20 @@ void folio_rotate_reclaimable(struct folio *folio)
 	}
 }
 
-void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
+void lru_note_cost(struct lruvec *lruvec, bool file,
+		   unsigned int nr_io, unsigned int nr_rotated)
 {
+	unsigned long cost;
+
+	/*
+	 * Reflect the relative cost of incurring IO and spending CPU
+	 * time on rotations. This doesn't attempt to make a precise
+	 * comparison, it just says: if reloads are about comparable
+	 * between the LRU lists, or rotations are overwhelmingly
+	 * different between them, adjust scan balance for CPU work.
+	 */
+	cost = nr_io * SWAP_CLUSTER_MAX + nr_rotated;
+
 	do {
 		unsigned long lrusize;
 
@@ -310,9 +322,9 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 		spin_lock_irq(&lruvec->lru_lock);
 		/* Record cost event */
 		if (file)
-			lruvec->file_cost += nr_pages;
+			lruvec->file_cost += cost;
 		else
-			lruvec->anon_cost += nr_pages;
+			lruvec->anon_cost += cost;
 
 		/*
 		 * Decay previous events
@@ -335,10 +347,10 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 	} while ((lruvec = parent_lruvec(lruvec)));
 }
 
-void lru_note_cost_folio(struct folio *folio)
+void lru_note_cost_refault(struct folio *folio)
 {
 	lru_note_cost(folio_lruvec(folio), folio_is_file_lru(folio),
-			folio_nr_pages(folio));
+		      folio_nr_pages(folio), 0);
 }
 
 static void folio_activate_fn(struct lruvec *lruvec, struct folio *folio)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04d8b88e5216..ffe402e095d3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2499,7 +2499,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
 	spin_unlock_irq(&lruvec->lru_lock);
 
-	lru_note_cost(lruvec, file, stat.nr_pageout);
+	lru_note_cost(lruvec, file, stat.nr_pageout, nr_scanned - nr_reclaimed);
 	mem_cgroup_uncharge_list(&folio_list);
 	free_unref_page_list(&folio_list);
 
@@ -2639,6 +2639,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	spin_unlock_irq(&lruvec->lru_lock);
 
+	if (nr_rotated)
+		lru_note_cost(lruvec, file, 0, nr_rotated);
 	mem_cgroup_uncharge_list(&l_active);
 	free_unref_page_list(&l_active);
 	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
diff --git a/mm/workingset.c b/mm/workingset.c
index ae7e984b23c6..d2d02978588c 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -493,7 +493,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	if (workingset) {
 		folio_set_workingset(folio);
 		/* XXX: Move to lru_cache_add() when it supports new vs putback */
-		lru_note_cost_folio(folio);
+		lru_note_cost_refault(folio);
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
 	}
 out:
-- 
2.37.3

