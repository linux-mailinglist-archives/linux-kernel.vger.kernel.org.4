Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1616535E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiLUSKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiLUSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:10:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDD4252AA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:10:02 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 4so16313991plj.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxCbMv7vN+MZYskgQiQXZaUsiwZjC8DQb1oWsEzg+wg=;
        b=SVH+DMt9Og+wCpl3/C5BsDiXi0R8onKGMrhpkd4hAlX8bvnTiVKmDxskppX9IQkPrD
         8Sd4evv36aHQ13uRz8HuvrhsBcWuFhUALcpXcURwBX6tiFSJpCU0wdSdBmhHkx7XIrr/
         JyVRdZoqnokcrqk6Trie7l/7hWBpcvarMU2OLhZ6kJiKEYRNdIksrOfLjFawMwNn6O2p
         jCmneIA6JP/TtPv5fncfMTNDHOeJ+bi0Qpz3foORBcwYPuBPLReKoQaHUJw3l+w3OALk
         SUx0tixRN0rcqO5jTqxXfiyWmYW2jH8GSWHBLkGTNVr9roslowxH0YAB3zgJLd+OW8R5
         o8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxCbMv7vN+MZYskgQiQXZaUsiwZjC8DQb1oWsEzg+wg=;
        b=LNEgupzLEKj9ZPQUCngFf7UJOfTyBBbVX4PDfKqiVzShFfbyZD2iNLGtTJDtqf1Nrq
         Qh3o9auFepcZf5B513/rGIYc+bDSAQwdftLsLARhhTvq83m6NFMqMqwGRWluJk4w7sPB
         5jMYOdjO0t7sXoDvm9cMuJfGdC5c6uR4eFGWR8ZafJXbyXlUEDQf2mB96ZfGpoqsc0+3
         KZLQ3M6lUahKOTawJaB8Xko8K01vk43DzEl5wkeNr7kZv78DjIOkp9ARVqTNmQGE17iP
         RBMR1b1obuUe5SzB9kQF2x9sw7JwLljAa8MVugs+mSvNvHGrMpJJ4I43K0PNX3wNDsAJ
         GfKg==
X-Gm-Message-State: AFqh2krfAk604eBFH+1XdeefmQ+tyRHWSDio/UYTEe0ZtUk27Z+s4RgS
        XCMNTgnDQUxGZwHUJkdejfM=
X-Google-Smtp-Source: AMrXdXu7sLHZOSQkUqGfVCYqV1RGYszssajWNznlILD5f7tvBuIfHAUntNoH41lSWlaha/5S+8g8uQ==
X-Received: by 2002:a05:6a20:2a09:b0:ac:44ab:33fa with SMTP id e9-20020a056a202a0900b000ac44ab33famr3315612pzh.37.1671646202232;
        Wed, 21 Dec 2022 10:10:02 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id e26-20020a63745a000000b00477bfac06b7sm10110732pgn.34.2022.12.21.10.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 10:10:01 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org, willy@infradead.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 4/4] mm/swap: Convert deactivate_page() to folio_deactivate()
Date:   Wed, 21 Dec 2022 10:08:48 -0800
Message-Id: <20221221180848.20774-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221180848.20774-1-vishal.moola@gmail.com>
References: <20221221180848.20774-1-vishal.moola@gmail.com>
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
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 include/linux/swap.h |  2 +-
 mm/damon/paddr.c     |  2 +-
 mm/madvise.c         |  4 ++--
 mm/swap.c            | 14 ++++++--------
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f965786710b0..209a425739a9 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -401,7 +401,7 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
-extern void deactivate_page(struct page *page);
+void folio_deactivate(struct folio *folio);
 void folio_mark_lazyfree(struct folio *folio);
 extern void swap_setup(void);
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 884c8bf18b12..6334c99e5152 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -297,7 +297,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		if (mark_accessed)
 			folio_mark_accessed(folio);
 		else
-			deactivate_page(&folio->page);
+			folio_deactivate(folio);
 		folio_put(folio);
 		applied += folio_nr_pages(folio);
 	}
diff --git a/mm/madvise.c b/mm/madvise.c
index 851d977b9b03..025be3517af1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -416,7 +416,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(&folio->page);
+			folio_deactivate(folio);
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
@@ -510,7 +510,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(&folio->page);
+			folio_deactivate(folio);
 	}
 
 	arch_leave_lazy_mmu_mode();
diff --git a/mm/swap.c b/mm/swap.c
index 5e5eba186930..e54e2a252e27 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -733,17 +733,15 @@ void deactivate_file_folio(struct folio *folio)
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

