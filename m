Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4724F6C0924
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCTDBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCTDBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:01:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80B61027A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:01:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so14966058pjt.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679281271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1F7l7Tv9LSQ3FV0WZzvP63T8ZRGBiz+hyWwDqQtTFrk=;
        b=kXzMdTPb5N8Ul0z7u6rxOEloBxiKexaFqUxNDrFd30XOo5ezApsGP1HtNT7RTMyW2d
         u5frjVpkc8cDUx76Kc8r8EpcinCtNqlafHj6/p9HKvk2t3DgV6TdfJr+VH8COGR5jfS5
         1+l/SaT7tsU3hPnrjdAJYLtnnotXCs/CM+sdAsUFrUGltPDwWgcJhddB3iVNddxtgy0m
         XhIJY6eo263R8BypN1jp9hSISDpEiUE44siXWRE+mSDg5T+LU0zxkFicOQ9nkmJJIdCj
         J4tZx0uVCakPk3ryFGSR0Xe15X23pKRt3i8CJYiD0BuIUIOiT+H12/SDA6NKxBeORhlS
         l/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679281271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1F7l7Tv9LSQ3FV0WZzvP63T8ZRGBiz+hyWwDqQtTFrk=;
        b=lPA7saDS8bIyqiwoWSCJyjD2O+szWusXycEzjR+cI5/LnQoH5ASanVeLkm1aRYfdla
         gAU3pwlKVCYE5NEKAGgTl1dWGKI78nPX6uiSMY81kzJlIRpK1g3KM0W2tnl0zcc1d7Xm
         oh+ra5ifB9M8ITaEUMUzPg+fHWF0Wcm6C7UvwsU6ImTY87SNYhXEkD3zW1VCSsTTjwbF
         53Ye3P52ww0YKdGg24kE6MAoD1SC0+0q9gK5k9iADCaz0FVTZJxY7Nz8pz0sAoCL2GCq
         0EAs8l7gz7BfUWflNajJfA1+OM5eSYHjGr5espTLKK9s9m/8pNR7HF5UOdf9gHn063kh
         OPUw==
X-Gm-Message-State: AO0yUKVD7VHzdFoOTRFfkTxQ7PRe2MgQ4yz5k3fj2Me7txenTiCJcKG+
        8Tf9kQwwU2mxdOJX2HU2/n+uttUlkwVlPu3O5hhN0AHI
X-Google-Smtp-Source: AK7set+Uhy6In9jfIYEi7amqY8WsA4FKNiLfkNDTI7EQ+zRzGXAZfdS6XBLxKl8ikkYQ+MmFukE+Yg==
X-Received: by 2002:a17:90a:56:b0:23d:4e9d:2eb0 with SMTP id 22-20020a17090a005600b0023d4e9d2eb0mr16866142pjb.36.1679281271272;
        Sun, 19 Mar 2023 20:01:11 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902d65100b001a1c69cc0besm1844972plh.200.2023.03.19.20.01.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Mar 2023 20:01:10 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, sjpark@amazon.de, jannh@google.com,
        muchun.song@linux.dev, roman.gushchin@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: kfence: fix PG_slab and memcg_data clearing
Date:   Mon, 20 Mar 2023 11:00:59 +0800
Message-Id: <20230320030059.20189-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not reset PG_slab and memcg_data when KFENCE fails to initialize
kfence pool at runtime. It is reporting a "Bad page state" message when
kfence pool is freed to buddy. The checking of whether it is a compound
head page seems unnecessary sicne we already guarantee this when allocating
kfence pool, removing the check to simplify the code.

Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/kfence/core.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 79c94ee55f97..d66092dd187c 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -561,10 +561,6 @@ static unsigned long kfence_init_pool(void)
 		if (!i || (i % 2))
 			continue;
 
-		/* Verify we do not have a compound head page. */
-		if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
-			return addr;
-
 		__folio_set_slab(slab_folio(slab));
 #ifdef CONFIG_MEMCG
 		slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
@@ -597,12 +593,26 @@ static unsigned long kfence_init_pool(void)
 
 		/* Protect the right redzone. */
 		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
-			return addr;
+			goto reset_slab;
 
 		addr += 2 * PAGE_SIZE;
 	}
 
 	return 0;
+
+reset_slab:
+	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
+		struct slab *slab = page_slab(&pages[i]);
+
+		if (!i || (i % 2))
+			continue;
+#ifdef CONFIG_MEMCG
+		slab->memcg_data = 0;
+#endif
+		__folio_clear_slab(slab_folio(slab));
+	}
+
+	return addr;
 }
 
 static bool __init kfence_init_pool_early(void)
@@ -632,16 +642,6 @@ static bool __init kfence_init_pool_early(void)
 	 * fails for the first page, and therefore expect addr==__kfence_pool in
 	 * most failure cases.
 	 */
-	for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
-		struct slab *slab = virt_to_slab(p);
-
-		if (!slab)
-			continue;
-#ifdef CONFIG_MEMCG
-		slab->memcg_data = 0;
-#endif
-		__folio_clear_slab(slab_folio(slab));
-	}
 	memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
 	__kfence_pool = NULL;
 	return false;
-- 
2.11.0

