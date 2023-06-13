Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7162F72ECC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbjFMUTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241102AbjFMUSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:18:55 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E98226AD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:37 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-45d3e523a43so2465178e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686687516; x=1689279516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amkbPFI+P7Pfwa/Tib2X8h1et/cH9zCscfc2pych/Qg=;
        b=MAhhKx2uS7CtxHxYidopGlbP50mkEqVOHFIPJKoj5ZOU1awqmCAZySq2DuJ4PVyvwg
         NDzdpU61axPHkbgwy/Y2ElyR0ktqDf33BW1AKFl/xU7NB5LA46T0GJmHmkvZXBDKcPcl
         kYmptMQ0XgUVBW119yk0+pHJJeUdN2rQvdUbCPLskahLtJ1NDrGQk09ZYYQROPT6i5kH
         XjdwUoPGnkS5/pQJyWEzn6WBdetGabgHMrCzlwO0Ziqalg0ukpQbM8MFXCzLE5iPi596
         3rcpmemEQcFBBqrfIWtEwnuM0nbjB8OD5Xlal27Ey2acFTT8jaHFTkIo/BYOwcK8NDny
         wVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687516; x=1689279516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amkbPFI+P7Pfwa/Tib2X8h1et/cH9zCscfc2pych/Qg=;
        b=VA2808r2IXv2sx8LWPZc2QryQ/jjMMRLJq4YXVJzxcpo2w/NNTyNUpNP21Ld3DemIO
         xLcWmlXKmNyBKguAGq2C83FoJe4OiOhu1M9A2VBvmKYOCYlFz5ILS/2zRKbsU/nXy/WA
         /8ciWzdIBW4SrCYDkma6gcmy3c40soeDvMHXwcnmex978vxPl2TuGmiSUYXvTlxCdEgV
         shvLjAXTdq29iH89+IGaP1nbN10C5RKHJPyPnmeLMFPOJHdxwAEuAPTxgBkuHHawOgtO
         n+GQyRp/a9kcKKq5pPpNIdKfT6qWjW/pr6g8EhocUReNNEX+oZl8HxNWQcayKYDc3GJG
         ZLAw==
X-Gm-Message-State: AC+VfDyAWO5H8eTofOxgWRB34czCxx3JAzcutuebgdpR/5+jEpSiXbEn
        wGppLR+LBSLyijKzcO8TU8I=
X-Google-Smtp-Source: ACHHUZ4LLhgbvxObZNDOLYg9OIjMPobYKsI88dGjSOVbRgCeIyTAYxBHlyg7Q/xF8YsEkkdXEeS+eA==
X-Received: by 2002:a1f:5f4d:0:b0:46e:70f8:c8ef with SMTP id t74-20020a1f5f4d000000b0046e70f8c8efmr1653501vkb.13.1686687516019;
        Tue, 13 Jun 2023 13:18:36 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id b72-20020a0dd94b000000b0056cea0480c6sm2509985ywe.2.2023.06.13.13.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:18:35 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 4/5] mm/gup.c: Reorganize try_get_folio()
Date:   Tue, 13 Jun 2023 13:18:26 -0700
Message-Id: <20230613201827.9441-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613201827.9441-1-vishal.moola@gmail.com>
References: <20230613201827.9441-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try_get_folio() takes in a page, then chooses to do some folio
operations based on the flags (either FOLL_GET or FOLL_PIN).
We can rewrite this function to be more purpose oriented.

After calling try_get_folio(), if FOLL_GET is set we can return the
result and end the function. If FOLL_GET is not set and FOLL_PIN is not
set then it's a bug so we warn and fail. Otherwise we simply proceed to
pin the folio and return that as well.

This change assists with folio conversions, and makes the function more
readable.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/gup.c | 88 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index bbe416236593..adbd81f888f5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -123,58 +123,62 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
  */
 struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 {
+	struct folio *folio;
 	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
 		return NULL;
 
+	folio = try_get_folio(page, refs);
+
 	if (flags & FOLL_GET)
-		return try_get_folio(page, refs);
-	else if (flags & FOLL_PIN) {
-		struct folio *folio;
+		return folio;
 
-		/*
-		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
-		 * right zone, so fail and let the caller fall back to the slow
-		 * path.
-		 */
-		if (unlikely((flags & FOLL_LONGTERM) &&
-			     !is_longterm_pinnable_page(page)))
-			return NULL;
+	if (unlikely(!(flags & FOLL_PIN))) {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
 
-		/*
-		 * CAUTION: Don't use compound_head() on the page before this
-		 * point, the result won't be stable.
-		 */
-		folio = try_get_folio(page, refs);
-		if (!folio)
-			return NULL;
+	/*
+	 * CAUTION: Don't use compound_head() on the page before this
+	 * point, the result won't be stable.
+	 */
+	if (!folio)
+		return NULL;
 
-		/*
-		 * When pinning a large folio, use an exact count to track it.
-		 *
-		 * However, be sure to *also* increment the normal folio
-		 * refcount field at least once, so that the folio really
-		 * is pinned.  That's why the refcount from the earlier
-		 * try_get_folio() is left intact.
-		 */
-		if (folio_test_large(folio))
-			atomic_add(refs, &folio->_pincount);
-		else
-			folio_ref_add(folio,
-					refs * (GUP_PIN_COUNTING_BIAS - 1));
-		/*
-		 * Adjust the pincount before re-checking the PTE for changes.
-		 * This is essentially a smp_mb() and is paired with a memory
-		 * barrier in page_try_share_anon_rmap().
-		 */
-		smp_mb__after_atomic();
+	/*
+	 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
+	 * right zone, so fail and let the caller fall back to the slow
+	 * path.
+	 */
+	if (unlikely((flags & FOLL_LONGTERM) &&
+		     !folio_is_longterm_pinnable(folio))) {
+		if (!put_devmap_managed_page_refs(&folio->page, refs))
+			folio_put_refs(folio, refs);
+		return NULL;
+	}
 
-		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
+	/*
+	 * When pinning a large folio, use an exact count to track it.
+	 *
+	 * However, be sure to *also* increment the normal folio
+	 * refcount field at least once, so that the folio really
+	 * is pinned.  That's why the refcount from the earlier
+	 * try_get_folio() is left intact.
+	 */
+	if (folio_test_large(folio))
+		atomic_add(refs, &folio->_pincount);
+	else
+		folio_ref_add(folio,
+				refs * (GUP_PIN_COUNTING_BIAS - 1));
+	/*
+	 * Adjust the pincount before re-checking the PTE for changes.
+	 * This is essentially a smp_mb() and is paired with a memory
+	 * barrier in page_try_share_anon_rmap().
+	 */
+	smp_mb__after_atomic();
 
-		return folio;
-	}
+	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 
-	WARN_ON_ONCE(1);
-	return NULL;
+	return folio;
 }
 
 static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
-- 
2.40.1

