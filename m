Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F062A6464B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiLGXCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLGXCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:02:03 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD27E40E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:02:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so3184381pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nurryG7gVBJWg4R3e/q3KZp9RxkJsYW9MoP7t/y1faI=;
        b=QWjuDvsx7JlXe9jXENwXVfaXVWdDN8pp2PRVifSfiC5uewfqCcXo7a7QY5NClKN4jo
         XIYubaBMmt41X0S6tkEosOyXPlmKpSnefXHj4lrdnAshM3ZqoRsqR/RWso9mHzpVH2EP
         iyucwJCvCzBxNiS0DZOrs2OZQscCfv+Vqs9jHd/QNNIevSm+PEY54R+KQI0Exh/tMikx
         qtdFlLWc4RdRRyygzeNnWWu9/2rHRjBFNCd+iV5E2Thc6eAcGtYHsG3IJk4RraRP8FB6
         kttIG2u/RDgKJ/UB3+uT0UUAbXapXVCFd+u44YZpTHrUfNzXtdq4Pif7xxDj1ewuJ6pR
         jg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nurryG7gVBJWg4R3e/q3KZp9RxkJsYW9MoP7t/y1faI=;
        b=hjfYk8vkwlGFXrFCohuanLGHbN1cyIHMpUcrXeFKYULoTAr9JfWg2mTzjeZny0QbdZ
         sRty4W3NuQj4TZNYXErXj6lbpq2/5DoLCrCBYPFNd4i9cwervVWjDA/DXnXMK9ey6eIZ
         Bo1I93isYQlUeu91w+ln+WULPLDAfNt+rfS1+x+qBo1slUp1tJomFgEkUubTt4xJk0Ah
         4oUYeSjy0pWlNA9UQLxYxu8gMSj2TrV1N7FUSEziSDD0L7UIwIOLdZJPs/OuPbS7RMM6
         rZH9mi4NKhTiC5AVHgDN/9ZXkJUJuAxZ7UxfiR4DJ2xx80xVnskApIpXhol7Jmxvw5S8
         H5bA==
X-Gm-Message-State: ANoB5pmUl9Vtm8Hk2jccMN4qpNcmlPUG3E/nz+T9HDQPvlhi9ZkSdZYo
        AQsJgPtApci3W3kugyuBTTFQAf1l1kZfVw==
X-Google-Smtp-Source: AA0mqf4LqJeISyz/cbhdlvWeu+sYEbZmsVtecPsU/yjTK5+i5Cv6K7CeBXEmtSozwv/WhsZmrZ747A==
X-Received: by 2002:a17:90b:1913:b0:219:396c:9e30 with SMTP id mp19-20020a17090b191300b00219396c9e30mr1056306pjb.20.1670454120814;
        Wed, 07 Dec 2022 15:02:00 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id pc16-20020a17090b3b9000b00212cf2fe8c3sm5411033pjb.1.2022.12.07.15.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:02:00 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 3/3] mm/swap: Convert deactivate_page() to folio_deactivate()
Date:   Wed,  7 Dec 2022 15:01:52 -0800
Message-Id: <20221207230152.22938-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207230152.22938-1-vishal.moola@gmail.com>
References: <20221207230152.22938-1-vishal.moola@gmail.com>
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
index a18cf4b7c724..94aa709ed933 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -409,7 +409,7 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
-extern void deactivate_page(struct page *page);
+extern void folio_deactivate(struct folio *folio);
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
index b323672c969d..9667d052b52f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -397,7 +397,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(&folio->page);
+			folio_deactivate(folio);
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
@@ -487,7 +487,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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

