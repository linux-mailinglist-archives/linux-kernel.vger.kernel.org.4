Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444A9676298
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjAUA4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjAUA4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:56:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA45B5B7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:56:28 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso10620382pjg.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sn9o4Cmt0XJxCzEv3cd/09WP6t7BNy+VXQN0hb/gQmY=;
        b=L7W7cMikTHvBje5bd7kfQZcvqe7I9YVqBuam/72E3VPsV4fW8Fz5HVOPOoM8ZCO2Vb
         RqblFxtiXWWheR6EI23wpxFqsJx+1nPFAs7ifLo/N/e00dmMCl8MyHMiB/0iFkYlMgh/
         PMhP3brtJ0ug4/IjaDJgT1x9G9VE47AiX8lRtwPJvHjZ1GQtwOke1W7gUTiSvvuaACB6
         I2lftS6Vz7IwApi0l+OHCIWshkXQ2Eie3SxSvHlptoVmmdY3zyNg7J2dpTub0jD50GD6
         4aIdOj0DgnaFsKArlq3sQ6wFqgXJVKkGW2AaSsvM77tEBCPC8miw1eczujeEJVZKgwnS
         HRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sn9o4Cmt0XJxCzEv3cd/09WP6t7BNy+VXQN0hb/gQmY=;
        b=lMMhvCRVCuR23pL2YuyzUtxmnYrB7ExXxGBHURH4fobC75WCET/Vq71wAMHX8dvFuH
         SYIt0dqC8UwW1B/fKlloMjjNC52p541t8t8wz1zDD0v2Rc4uiKqSdILCDX4bJZRC6WkA
         FMSt0apcgJzjqEGBS5hCwudrQm2H9csObZ9EDibjd2lifXwf+E7ZB6rMzXTJ/+Pn+7gS
         F6ghQHgltmQuwtZQchST7bOfSnL7s/yBmxETpG/R0wRNdyI5y/nuTGVSRXbsNz+HcuFa
         TjXPfytq/91ReUg9UiH9++a8D886W7S9JQOzKV2axSVuf/02TiudxgWh0d+Uys4D7mYG
         vLsw==
X-Gm-Message-State: AFqh2kridwYOOl2GPiUkkbUOuJ9cy8QAzcSIj4QiOVSTU5C6FxDrm3Vc
        2Frmpta9wOOu0JiV2yMAZEI=
X-Google-Smtp-Source: AMrXdXupG4jNmpCUVU0/GCYE088g0/9TDQgMX6l2qNXRcGzWrfWMP3+CEqCU/5KhCaxKXELoHEkDag==
X-Received: by 2002:a17:90a:67c2:b0:226:c364:2d1d with SMTP id g2-20020a17090a67c200b00226c3642d1dmr17331993pjm.41.1674262588360;
        Fri, 20 Jan 2023 16:56:28 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id pc3-20020a17090b3b8300b001fde655225fsm11314371pjb.2.2023.01.20.16.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:56:28 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/3] mm/migrate: Convert isolate_movable_page() to use folios
Date:   Fri, 20 Jan 2023 16:56:21 -0800
Message-Id: <20230121005622.57808-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121005622.57808-1-vishal.moola@gmail.com>
References: <20230121005622.57808-1-vishal.moola@gmail.com>
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
index 4c1776445c74..bcde3cbbc8c9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -60,6 +60,7 @@
 
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
+	struct folio *folio = page_folio(page);
 	const struct movable_operations *mops;
 
 	/*
@@ -71,11 +72,11 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	 * the put_page() at the end of this block will take care of
 	 * release this page, thus avoiding a nasty leakage.
 	 */
-	if (unlikely(!get_page_unless_zero(page)))
+	if (unlikely(!folio_try_get(folio)))
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

