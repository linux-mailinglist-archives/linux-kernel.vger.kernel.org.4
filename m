Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867126CBBA3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjC1J7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjC1J66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:58:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801AF55B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s8so7588127pfk.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679997513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXReBzDsI5mUppZ3rGyjpCu82GIXuKJKMV0lZiD0JNk=;
        b=GNYV/SpQ4PF1Rk9guHwx0aYyiVbzxvCe8LgWKY4fKwXFWvJ0gHYKR9uI9Hyt7SuIba
         lqZhGe+iNAZBDttHfVPfrJtzXlSY4W0BwXLoi8+mDBLpZrOaqvyR3cnJuUvQfnijfFWF
         DgXTjFXJbvdNpSpbmeMZZq9T6E47bY/Bfun3K0PrAfzuydbRgjCh+tcBC+yQ0FegohJ2
         LDusHWD4zsYHXyzzOsDLqMZyFzXOZExMZ6+6Nz5aE4HYnhqn7ndtS3fNHvJhBx1KBdK6
         QyPuMZMYaMgxyNGf7ut9mP8hd0RslzKwLhfQJ46QWZOfUXnZ+YLqil4EchVkeDWoIrO7
         Af0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXReBzDsI5mUppZ3rGyjpCu82GIXuKJKMV0lZiD0JNk=;
        b=oEWvUltUFHld7pUlLYVMLs/kcHcHaAvSzSkVCYu6e6xclZiTQswjNidqDuyFr0xP8k
         hRCX/okzEpqYmicLYvvlXvgZGyqgb2DPuftB+udH9PMxQHjAuZAr+AaMsTW2TSzacNoM
         nLpt1i5v/8gJ+Ik8u9QiMsmcBTm4kffGw9x82KUfXBO+BUjcQtNA6W/fMO/SRGhncwV0
         E+J8VpC/OmAe6dxwWkORxUsxOL0cZZoQb183PvJMg5tuftPQbMbH7/dM/evUe2K/DfiT
         fCMdD/G81bbTZXsUPs2NVz8dgcKIiTaYxpmQrEapDxCFLVC/4X+noGYZY3o3fQ1mE8Ps
         MRIw==
X-Gm-Message-State: AAQBX9ciAxl6pgDqYgogexxESNGXL2EO7SW5hGBt2Xs/1MR+byMfm9pc
        knbYtgofVG8zs5b1cMnlYSJquQ==
X-Google-Smtp-Source: AKy350a8z+tgtFIvSjXB4Jv/VaYEvsSRl5/1SyRdomnZTLXT1oaUTne7LXl5YF+58ZBqG0o4zrBD6g==
X-Received: by 2002:aa7:96f8:0:b0:600:cc40:2589 with SMTP id i24-20020aa796f8000000b00600cc402589mr3361407pfq.3.1679997512966;
        Tue, 28 Mar 2023 02:58:32 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b005a8a5be96b2sm17207556pfa.104.2023.03.28.02.58.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Mar 2023 02:58:32 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, jannh@google.com, sjpark@amazon.de,
        muchun.song@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/6] mm: kfence: simplify kfence pool initialization
Date:   Tue, 28 Mar 2023 17:58:02 +0800
Message-Id: <20230328095807.7014-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230328095807.7014-1-songmuchun@bytedance.com>
References: <20230328095807.7014-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three similar loops to initialize kfence pool, we could merge
all of them into one loop to simplify the code and make code more
efficient.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/kfence/core.c | 47 ++++++-----------------------------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 7d01a2c76e80..de62a84d4830 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -539,35 +539,10 @@ static void rcu_guarded_free(struct rcu_head *h)
 static unsigned long kfence_init_pool(void)
 {
 	unsigned long addr = (unsigned long)__kfence_pool;
-	struct page *pages;
 	int i;
 
 	if (!arch_kfence_init_pool())
 		return addr;
-
-	pages = virt_to_page(__kfence_pool);
-
-	/*
-	 * Set up object pages: they must have PG_slab set, to avoid freeing
-	 * these as real pages.
-	 *
-	 * We also want to avoid inserting kfence_free() in the kfree()
-	 * fast-path in SLUB, and therefore need to ensure kfree() correctly
-	 * enters __slab_free() slow-path.
-	 */
-	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
-		struct slab *slab = page_slab(nth_page(pages, i));
-
-		if (!i || (i % 2))
-			continue;
-
-		__folio_set_slab(slab_folio(slab));
-#ifdef CONFIG_MEMCG
-		slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
-				   MEMCG_DATA_OBJCGS;
-#endif
-	}
-
 	/*
 	 * Protect the first 2 pages. The first page is mostly unnecessary, and
 	 * merely serves as an extended guard page. However, adding one
@@ -581,8 +556,9 @@ static unsigned long kfence_init_pool(void)
 		addr += PAGE_SIZE;
 	}
 
-	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++, addr += 2 * PAGE_SIZE) {
 		struct kfence_metadata *meta = &kfence_metadata[i];
+		struct slab *slab = page_slab(virt_to_page(addr));
 
 		/* Initialize metadata. */
 		INIT_LIST_HEAD(&meta->list);
@@ -593,26 +569,15 @@ static unsigned long kfence_init_pool(void)
 
 		/* Protect the right redzone. */
 		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
-			goto reset_slab;
-
-		addr += 2 * PAGE_SIZE;
-	}
-
-	return 0;
-
-reset_slab:
-	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
-		struct slab *slab = page_slab(nth_page(pages, i));
+			return addr;
 
-		if (!i || (i % 2))
-			continue;
+		__folio_set_slab(slab_folio(slab));
 #ifdef CONFIG_MEMCG
-		slab->memcg_data = 0;
+		slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
 #endif
-		__folio_clear_slab(slab_folio(slab));
 	}
 
-	return addr;
+	return 0;
 }
 
 static bool __init kfence_init_pool_early(void)
-- 
2.11.0

