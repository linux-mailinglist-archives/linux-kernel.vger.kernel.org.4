Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9570E709
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbjEWU7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEWU72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:59:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED28F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:59:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb52dbb00so380175276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684875567; x=1687467567;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oqzY22DU8hsochaAkiR/zou3nxJkIdpTHuQYEZ4euM0=;
        b=00x6wRrXLaQc4E3HL5TfDI5wMyAGjsMlESwMz+Ip4SzPcVjGJi/DmFI7yqcmjpIDXU
         pPCYsg34Ok7Qu3IWjFmttSP2QWAvyZvKR2As9PcQkIbMrWSB0Pqf43q9Fv05dgCWXA90
         8L/zBV0+LK7j5OKIqtev3NQqSaoWx7+MDW/HMzhoLZWiADmByxFVuQRAUjGTQJ8yZ72u
         07YFpJeOKKk+Y8azY6PMmooahKyJQF48a6TKVwhqgHWmHi5brLqbLRdX7yLsDCfoplvy
         gMa+0HxIHAn+ddNOkeS8dOuCqzS4SY/rdq3vouSURnGek+KmjC84DuvNK8RgrObbCYXG
         r2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875567; x=1687467567;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oqzY22DU8hsochaAkiR/zou3nxJkIdpTHuQYEZ4euM0=;
        b=iK8C8Ksx5060226Hsc9uDOu/qQGaIBe1JUJuOn2yFoVvTWDE3wle/0E27Hr4BgpPpN
         rep3x4pt4hcq2axKKjxGmI9rcAq9pcc7rJpZythlhC7YB/wnPwgFJC8hle5bupWlivNb
         jPhecmX5r36G6UQuW+mM4C0vIP9Ovw6mnAj7oVCsXuaeI2F3BONLXCJqOYyNuvNTcZco
         J6Toa95PzPsN1p0uIuZydeYPg15rEOCqp7mw8mhxGWzkzhx6U30bfCpObfMqvM+1ib1D
         N0UEgM83vpCNseGO3jpbCswMTi8Jf/n+1alJ+2VUWsV04ynZNqkHATplqOIYvnJ+OS8V
         Qq6Q==
X-Gm-Message-State: AC+VfDxX/9oXr7GYpye9Y6nRnLp+bvLXn9gepI1oleDi79c5uFgpo72N
        Va1C99MCWaoiMhKbFlylcnXyrcatOVH7pKySwQ==
X-Google-Smtp-Source: ACHHUZ6CXRzlSLLUEil2mIC1MEhVd9KbB1k8BRZTxoZezM54UzgFmX5aoe8mWHGRqKL8xAx7PpFCLEoULxy3kxBITA==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:1c60:f27:f83c:ef25])
 (user=kaleshsingh job=sendgmr) by 2002:a25:9786:0:b0:ba8:939b:3e04 with SMTP
 id i6-20020a259786000000b00ba8939b3e04mr6271389ybo.5.1684875566909; Tue, 23
 May 2023 13:59:26 -0700 (PDT)
Date:   Tue, 23 May 2023 13:59:21 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523205922.3852731-1-kaleshsingh@google.com>
Subject: [PATCH] mm-unstable: Multi-gen LRU: Fix workingset accounting
From:   Kalesh Singh <kaleshsingh@google.com>
To:     yuzhao@google.com, akpm@linux-foundation.org
Cc:     surenb@google.com, android-mm@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Android app cycle workloads, MGLRU showed a significant reduction
in workingset refaults although pgpgin/pswpin remained relatively
unchanged. This indicated MGLRU may be undercounting workingset
refaults.

This has impact on userspace programs, like Android's LMKD, that
monitor workingset refault statistics to detect thrashing.

It was found that refaults were only accounted if the MGLRU shadow
entry was for a recently evicted folio. However, recently evicted
folios should be accounted as workingset activation, and refaults
should be accounted regardless of recency.

Fix MGLRU's workingset refault and activation accounting to more
closely match that of the conventional active/inactive LRU.

Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
Cc: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/vmscan.c     |  1 -
 mm/workingset.c | 10 +++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index eeca83e28c9b..ef687f9be13c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4925,7 +4925,6 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
 			   lrugen->protected[hist][type][tier - 1] + delta);
-		__mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
 		return true;
 	}
 
diff --git a/mm/workingset.c b/mm/workingset.c
index 5796e927e6d7..4686ae363000 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -278,6 +278,7 @@ static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
 
 static void lru_gen_refault(struct folio *folio, void *shadow)
 {
+	bool recent;
 	int hist, tier, refs;
 	bool workingset;
 	unsigned long token;
@@ -288,10 +289,13 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 
 	rcu_read_lock();
 
-	if (!lru_gen_test_recent(shadow, type, &lruvec, &token, &workingset))
+	recent = lru_gen_test_recent(shadow, type, &lruvec, &token, &workingset);
+	if (lruvec != folio_lruvec(folio))
 		goto unlock;
 
-	if (lruvec != folio_lruvec(folio))
+	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + type, delta);
+
+	if (!recent)
 		goto unlock;
 
 	lrugen = &lruvec->lrugen;
@@ -302,7 +306,7 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 	tier = lru_tier_from_refs(refs);
 
 	atomic_long_add(delta, &lrugen->refaulted[hist][type][tier]);
-	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + type, delta);
+	mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
 
 	/*
 	 * Count the following two cases as stalls:

base-commit: cd255dae35f51ea33cb85d29720d6b4e5fa16365
-- 
2.40.1.698.g37aff9b760-goog

