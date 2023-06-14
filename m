Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2B672F27E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbjFNCOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242152AbjFNCO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:14:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774819B6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:28 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-56d0d574964so2341157b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686708867; x=1689300867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw61vajIkA6oxKB73VTHpA/VflnxZ90Ui6bDTaJJ3WI=;
        b=YVGVxBZ24BVkgipFXR1ege6SG0fquUM1JH7q42WM3bdfobtzIc/5hyKqeObocHTx9s
         YtuexTTE4n9ZN6g09ubR4ZWkQxBVPZrZ8m1eDguoe2G4wXW96CQ6FI8nblgkM5bY4jU+
         gUFK4MUuHGorqR4D0Vp98p+Kscxi4CjzlTH61wP3tNZNnMnXRyz9SHgK4NDbi2jc0QhP
         ASVH5Zm5MkUGhggDoxVovPSkseAh9bRkRrXskHJeRr2xlK3DyGjUP3H9bWMNiAXnEgNF
         ZDU9v507kHNPrF/05L1OOJKm9zQGf/tzfJKh2qSoF+lgxnCuOtSSp7Iq6vL0G8ISpxMP
         vRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686708867; x=1689300867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aw61vajIkA6oxKB73VTHpA/VflnxZ90Ui6bDTaJJ3WI=;
        b=jALGCBZqdwZRKhQeh50Mc9ZYZmR0RGXe4mvtZmePrDexDwV7TFXE9WaocLsQzUKnlb
         mDCW+q4DGyOoyZAKqatYRpkHZ3cOx9yipevv7eveB07t8no1x9r5Mg4iVZsWCvbR8JMZ
         AFFsz4nFc8ZVzeMkDbrGokfVFrYav3KIoq+6f3gwQj1+qGZSjuv0pgotUXXPl/+yzJ0a
         xhx+v8Ct1T1CvMdzzkoGkoaedd6n68kQ2Gd4Zsa2DsizIWRxZ1CdVJtPqD2xgRyzc2cY
         USm5c/xh4T+o+nNz0wlDtUQpRE42f6/5Um+xfS0SFacjniNGGtKSVP6sik12g53vUHn8
         lzUQ==
X-Gm-Message-State: AC+VfDxI6VfNmbYlPS+E/D8rxUIpkArLWrc+JmkAVoILkko91Zi1yBhN
        wdH27A/rKkW6qCxJraSRoTEB7yXSMZY=
X-Google-Smtp-Source: ACHHUZ44hRkvmSZRyOdyCv9N6hHgq9+NVCEiHaCWIGQfc+HCHZ7D1N44hd00/7Ix8TjS3ef0oKpmIw==
X-Received: by 2002:a81:84d3:0:b0:56d:5a2:89ff with SMTP id u202-20020a8184d3000000b0056d05a289ffmr488167ywf.33.1686708867379;
        Tue, 13 Jun 2023 19:14:27 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id p3-20020a817403000000b0056d30f1b508sm1463931ywc.107.2023.06.13.19.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:14:27 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 4/5] mm/gup.c: Reorganize try_get_folio()
Date:   Tue, 13 Jun 2023 19:13:11 -0700
Message-Id: <20230614021312.34085-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614021312.34085-1-vishal.moola@gmail.com>
References: <20230614021312.34085-1-vishal.moola@gmail.com>
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

After calling try_get_folio(), if neither FOLL_GET nor FOLL_PIN are set,
warn and fail. If FOLL_GET is set we can return the result. If FOLL_GET
is not set then FOLL_PIN is set, so we pin the folio.

This change assists with folio conversions, and makes the function more
readable.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/gup.c | 86 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index bbe416236593..6ec5c9629dc9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -123,58 +123,58 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
  */
 struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 {
+	struct folio *folio;
+
+	if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
+		return NULL;
+
 	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
 		return NULL;
 
-	if (flags & FOLL_GET)
-		return try_get_folio(page, refs);
-	else if (flags & FOLL_PIN) {
-		struct folio *folio;
+	folio = try_get_folio(page, refs);
 
-		/*
-		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
-		 * right zone, so fail and let the caller fall back to the slow
-		 * path.
-		 */
-		if (unlikely((flags & FOLL_LONGTERM) &&
-			     !is_longterm_pinnable_page(page)))
-			return NULL;
+	if (flags & FOLL_GET)
+		return folio;
 
-		/*
-		 * CAUTION: Don't use compound_head() on the page before this
-		 * point, the result won't be stable.
-		 */
-		folio = try_get_folio(page, refs);
-		if (!folio)
-			return NULL;
+	/* FOLL_PIN is set */
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

