Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85CD681D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjA3VoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjA3Vn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:43:59 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1896EB1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:43:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e8-20020a17090a9a8800b0022c387f0f93so11913147pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfgb6gximncpFcsdfMQZVX+G30+IO/lhUGcO4BdjekA=;
        b=WG8BHcH4b1Q2VPyQkFR4MwsGeXdQ+pi68nFKuACv3H2cq9hquUdwYMOwfn5Clg75vW
         tdaTbnzo30g1mw2TSnN6h8Y6lgg1wtmy7ON2KRh8nI82wfIkH/LpFE2K2KGn9m0dQnK+
         EdiAMPBmX4di1Eob2v/sMtOoZQFb9TFmKbcFfBiMNz2GkEqkfEVm7j6AQvMvVO3QspMi
         i3x8iytVYGMWkQPh+NbcLozKU0gaNSS4IQgHkklSFDruW2i0iL46jgpRRq1X8wOYNoNT
         7PD2lsqw+ZNG9C1EUsY6JUPymqtXQAJyQWkqCphkWagIz21CNTfeNJSRmt5MinrcDjBU
         JrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfgb6gximncpFcsdfMQZVX+G30+IO/lhUGcO4BdjekA=;
        b=VsIEBx9FktOyJ5aR1TCT3n0xoRsIQBdUVR9G4UztHhEnTZxIRJJrFVTK0AV7d6lgxS
         S8/DcBqj/zBRsTz9uXfF64+qhqCV15OB8KfWNR8l5KhJwpmCV3JkyzNi+m8/DX1uQr7w
         IgvM9GFakQt27ifA2KotcgcNI/bdLmNfDTn8AvNAuvRDjCqnuOjp0O2N3zui4Eh3uBVk
         yh4PzpUW+5NlfNobGAgCm0bA3x26iUNxOQI+SVt+zyj0pQ7Nc+qIyIJPV0/UhtaadUoB
         UXekecCJrwp9Z+EhjiKPp70JOtpJhTNqw7ChvWKQxWs/6Cce1ULWf4RN1fzLtb1qoY8P
         Pziw==
X-Gm-Message-State: AFqh2kpZF92KSgCbir4uh6yF0rxKV+iNWnnWXkaqLAOQ33QayWupb9t9
        Ggavo3oUzzwall2pXZ6rtDAcNhEFYcs=
X-Google-Smtp-Source: AMrXdXui3s7CpN8ff+PUDq7P7VExTnu8iNhcubhGWvTur95s0s6deUUCtdeQOmlXVeR6u10FVmghBg==
X-Received: by 2002:a17:90a:2f89:b0:219:6619:848a with SMTP id t9-20020a17090a2f8900b002196619848amr53344104pjd.36.1675115037864;
        Mon, 30 Jan 2023 13:43:57 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id d5-20020a17090a628500b0022bbad75af6sm25156403pjj.1.2023.01.30.13.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:43:57 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 3/4] mm/migrate: Convert isolate_movable_page() to use folios
Date:   Mon, 30 Jan 2023 13:43:51 -0800
Message-Id: <20230130214352.40538-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230130214352.40538-1-vishal.moola@gmail.com>
References: <20230130214352.40538-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes 6 calls to compound_head() and prepares the function to take in a
folio instead of page argument.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/migrate.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index fcb2e9fa1953..c20d9f531db4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -60,6 +60,7 @@
 
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
+	struct folio *folio = folio_get_nontail_page(page);
 	const struct movable_operations *mops;
 
 	/*
@@ -71,11 +72,11 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	 * the put_page() at the end of this block will take care of
 	 * release this page, thus avoiding a nasty leakage.
 	 */
-	if (unlikely(!get_page_unless_zero(page)))
+	if (!folio)
 		goto out;
 
-	if (unlikely(PageSlab(page)))
-		goto out_putpage;
+	if (unlikely(folio_test_slab(folio)))
+		goto out_putfolio;
 	/* Pairs with smp_wmb() in slab freeing, e.g. SLUB's __free_slab() */
 	smp_rmb();
 	/*
@@ -83,12 +84,12 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	 * we use non-atomic bitops on newly allocated page flags so
 	 * unconditionally grabbing the lock ruins page's owner side.
 	 */
-	if (unlikely(!__PageMovable(page)))
-		goto out_putpage;
+	if (unlikely(!__folio_test_movable(folio)))
+		goto out_putfolio;
 	/* Pairs with smp_wmb() in slab allocation, e.g. SLUB's alloc_slab_page() */
 	smp_rmb();
-	if (unlikely(PageSlab(page)))
-		goto out_putpage;
+	if (unlikely(folio_test_slab(folio)))
+		goto out_putfolio;
 
 	/*
 	 * As movable pages are not isolated from LRU lists, concurrent
@@ -101,29 +102,29 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	 * lets be sure we have the page lock
 	 * before proceeding with the movable page isolation steps.
 	 */
-	if (unlikely(!trylock_page(page)))
-		goto out_putpage;
+	if (unlikely(!folio_trylock(folio)))
+		goto out_putfolio;
 
-	if (!PageMovable(page) || PageIsolated(page))
+	if (!folio_test_movable(folio) || folio_test_isolated(folio))
 		goto out_no_isolated;
 
-	mops = page_movable_ops(page);
-	VM_BUG_ON_PAGE(!mops, page);
+	mops = folio_movable_ops(folio);
+	VM_BUG_ON_FOLIO(!mops, folio);
 
-	if (!mops->isolate_page(page, mode))
+	if (!mops->isolate_page(&folio->page, mode))
 		goto out_no_isolated;
 
 	/* Driver shouldn't use PG_isolated bit of page->flags */
-	WARN_ON_ONCE(PageIsolated(page));
-	SetPageIsolated(page);
-	unlock_page(page);
+	WARN_ON_ONCE(folio_test_isolated(folio));
+	folio_set_isolated(folio);
+	folio_unlock(folio);
 
 	return 0;
 
 out_no_isolated:
-	unlock_page(page);
-out_putpage:
-	put_page(page);
+	folio_unlock(folio);
+out_putfolio:
+	folio_put(folio);
 out:
 	return -EBUSY;
 }
-- 
2.38.1

