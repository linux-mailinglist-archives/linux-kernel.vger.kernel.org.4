Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAD964775B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiLHUf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiLHUfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:35:12 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAEF86591
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:35:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so5863867pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgIdh8nt+mq77dQQNk9/S7rfV6TiIO4QqyG3Sqp+yaY=;
        b=iWudK4xr8eyn/01wdfoGvrxyUZ3k1Zp/c9SZe2LcNl4BOQDgNz1rrGJo+5CwWhbxsB
         ekFj/Vx5q+l+Er2zXRcjiwwJ7Org396Wm7q4Qi1iKNkG/8p8agHenkkce3pEZ2WWcyJv
         HWDgSY5KjyzddNWRNvF5+ItpMrECfjvrPJdosOTLsMFYLgac6nNGyRFOwiYuGbaC2MoE
         dbZNnKV4+iKB3vUXa9waapqdDgJkv+WDMARouAaHEBewwulZ+Bj8Q56TL7piK4KIKDcW
         C3m6/Gz0ZDe4U3xG2q8ctJWNYAp/WE2rQqaalZBdrEiETAX6nj01t2ihO7VPs3yUYnGw
         tn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgIdh8nt+mq77dQQNk9/S7rfV6TiIO4QqyG3Sqp+yaY=;
        b=prRkbBjLMrUTyUfnKjpoFPWElgobXo8r/uvPkuyNM6A6bxtIWvGkoA7hxsgkG1KHU5
         +ZDA9btaj/iZ68NVuFQWiVIGxVP/TLILJeWKJK2cPN/IEnhE44aab5e/hOx9yC9wJx5x
         gYy4myxO4Au3ZevjYT9VFJ1i8XpyWwL2KTAyCudGz4q8LhiONkfMQ7/hofBVI7O6vtpr
         I358U/374KJXQJYh3UHrS2uBmIobg31D7m/FIS+unnI/RhJaCyD/f5nOgo1sM84x+BKL
         H8yXeDcnhlZXUGV0/pWnXUUQ3jQSzg996lC6wBUi8lp/hP7hyA5sbvFHWK/QQXlcTrFD
         tjsg==
X-Gm-Message-State: ANoB5pkTS5A8ni+Z37BfDR8vCRP7DlituLhDa1QqVnz9mLlmjyLYq2LJ
        RlJ4HrCjjIwgCbNU+szEJIM=
X-Google-Smtp-Source: AA0mqf5LuEF6hw5v4QfYtY1YTYCQswEq2LvxbAKaP13F6C+lHoQVP968dI3AQN2b+rJ2dSyg/9P1qA==
X-Received: by 2002:a17:902:b289:b0:189:70c1:4ff5 with SMTP id u9-20020a170902b28900b0018970c14ff5mr3560139plr.37.1670531711111;
        Thu, 08 Dec 2022 12:35:11 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f5-20020a170902860500b00189951514c4sm16954349plo.206.2022.12.08.12.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:35:10 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 4/4] mm/swap: Convert deactivate_page() to folio_deactivate()
Date:   Thu,  8 Dec 2022 12:35:03 -0800
Message-Id: <20221208203503.20665-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208203503.20665-1-vishal.moola@gmail.com>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
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

Deactivate_page() has already been converted to use folios, this change
converts it to take in a folio argument instead of calling page_folio().
It also renames the function folio_deactivate() to be more consistent
with other folio functions.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/swap.h |  2 +-
 mm/damon/paddr.c     |  2 +-
 mm/madvise.c         |  4 ++--
 mm/swap.c            | 14 ++++++--------
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a18cf4b7c724..6427b3af30c3 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -409,7 +409,7 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
-extern void deactivate_page(struct page *page);
+void folio_deactivate(struct folio *folio);
 extern void mark_page_lazyfree(struct page *page);
 extern void swap_setup(void);
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 73548bc82297..6b36de1396a4 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -247,7 +247,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		if (mark_accessed)
 			folio_mark_accessed(folio);
 		else
-			deactivate_page(&folio->page);
+			folio_deactivate(folio);
 		folio_put(folio);
 		applied += folio_nr_pages(folio);
 	}
diff --git a/mm/madvise.c b/mm/madvise.c
index 2a84b5dfbb4c..1ab293019862 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -396,7 +396,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(&folio->page);
+			folio_deactivate(folio);
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
@@ -485,7 +485,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(&folio->page);
+			folio_deactivate(folio);
 	}
 
 	arch_leave_lazy_mmu_mode();
diff --git a/mm/swap.c b/mm/swap.c
index 955930f41d20..9cc8215acdbb 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -720,17 +720,15 @@ void deactivate_file_folio(struct folio *folio)
 }
 
 /*
- * deactivate_page - deactivate a page
- * @page: page to deactivate
+ * folio_deactivate - deactivate a folio
+ * @folio: folio to deactivate
  *
- * deactivate_page() moves @page to the inactive list if @page was on the active
- * list and was not an unevictable page.  This is done to accelerate the reclaim
- * of @page.
+ * folio_deactivate() moves @folio to the inactive list if @folio was on the
+ * active list and was not unevictable. This is done to accelerate the
+ * reclaim of @folio.
  */
-void deactivate_page(struct page *page)
+void folio_deactivate(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
 	    (folio_test_active(folio) || lru_gen_enabled())) {
 		struct folio_batch *fbatch;
-- 
2.38.1

