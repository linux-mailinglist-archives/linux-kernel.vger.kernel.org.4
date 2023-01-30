Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0F5681D10
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjA3VoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjA3VoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:44:00 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B613AAD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:43:59 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z1so5550570plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UBov3sv7172TVhYTWoSlpD7u+6AtPn48Pn1/2ZA2fU=;
        b=GGZic+SgYRe3M4jfPhEI4uBwZjpwo1LVgsuMKjaYJEcaof28Rdl8bIcKFRGFMOo/v1
         vp0jipI83f4E8yLw84AyXoFw7/AEoOEMI+BoFH6TyK7yw5bqlH0Folia7f0LDUPXUSJE
         sY+zofDSWUUjnW10KVNYHPtOqTI6aPq7W30CZzkt0G3OGeXkeyWsvPP7iC9ue60m7d00
         bjlF3UiLdcksT0VkBZi8djwpFJHz2Xc6LE1uP9ILm9lxEvvt1RGL5cpq++cvkTHcL/Vo
         SYDFpZ+xHAZLbBBZjx6hjNav9fmIUKe+EZvnLPpHqhYQ6AeAvHnAJyrSodxo/+yBRygT
         JotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UBov3sv7172TVhYTWoSlpD7u+6AtPn48Pn1/2ZA2fU=;
        b=t+5wMWVY9ONes9fF9rI1a2KC5kknt4XR+En4nIteiPedlfFH32nC0Nwbg83ygdkkaT
         K3f/9abFziniQYc/Z8vgl4SgtMNchOxwBx7dPQuBCr9E71tSxwd4/7NEa8TZZtROjoKw
         VA98fjgL4GZjezYNoyxhqQaVwuSJZEJ4s+Cz9mfhcZUZfZOKULyLUsemhDfYr33aSWGL
         X3u7FoyMm6jkli1f/3RFtBwRtd5aqLaCl7voOFGJBerXnkJVM1oduL0V1U09ByM6ZV5y
         x0SQqm0kTqoopKwxKCncscq/+2CS8RRiDmNl6Rj6aSD6RDRG0UzemGdeFIXzZQI8Ud1D
         zoDQ==
X-Gm-Message-State: AO0yUKW7wpSluv8qYZIun7xMFw0z+ji68kHGZ71xeWb/7TzCGZXIHY7b
        ZHWyzk4cT/xT3jEWh73xGh26AUxtbO4=
X-Google-Smtp-Source: AK7set/TKhPV3YcjWGwxjEFSpRV7C5X/JGvIQRGhQ6P+HCTujOoxc+xfB2YEufD5hkNCey2k4eu/Tw==
X-Received: by 2002:a17:90b:1b48:b0:22c:59c3:869a with SMTP id nv8-20020a17090b1b4800b0022c59c3869amr11510265pjb.21.1675115038671;
        Mon, 30 Jan 2023 13:43:58 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id d5-20020a17090a628500b0022bbad75af6sm25156403pjj.1.2023.01.30.13.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:43:58 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 4/4] mm/migrate: Convert putback_movable_pages() to use folios
Date:   Mon, 30 Jan 2023 13:43:52 -0800
Message-Id: <20230130214352.40538-5-vishal.moola@gmail.com>
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

Removes 6 calls to compound_head(), and replaces putback_movable_page()
with putback_movable_folio() as well.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/migrate.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c20d9f531db4..db480dc08bac 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -129,12 +129,12 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	return -EBUSY;
 }
 
-static void putback_movable_page(struct page *page)
+static void putback_movable_folio(struct folio *folio)
 {
-	const struct movable_operations *mops = page_movable_ops(page);
+	const struct movable_operations *mops = folio_movable_ops(folio);
 
-	mops->putback_page(page);
-	ClearPageIsolated(page);
+	mops->putback_page(&folio->page);
+	folio_clear_isolated(folio);
 }
 
 /*
@@ -147,33 +147,33 @@ static void putback_movable_page(struct page *page)
  */
 void putback_movable_pages(struct list_head *l)
 {
-	struct page *page;
-	struct page *page2;
+	struct folio *folio;
+	struct folio *folio2;
 
-	list_for_each_entry_safe(page, page2, l, lru) {
-		if (unlikely(PageHuge(page))) {
-			folio_putback_active_hugetlb(page_folio(page));
+	list_for_each_entry_safe(folio, folio2, l, lru) {
+		if (unlikely(folio_test_hugetlb(folio))) {
+			folio_putback_active_hugetlb(folio);
 			continue;
 		}
-		list_del(&page->lru);
+		list_del(&folio->lru);
 		/*
-		 * We isolated non-lru movable page so here we can use
-		 * __PageMovable because LRU page's mapping cannot have
+		 * We isolated non-lru movable folio so here we can use
+		 * __PageMovable because LRU folio's mapping cannot have
 		 * PAGE_MAPPING_MOVABLE.
 		 */
-		if (unlikely(__PageMovable(page))) {
-			VM_BUG_ON_PAGE(!PageIsolated(page), page);
-			lock_page(page);
-			if (PageMovable(page))
-				putback_movable_page(page);
+		if (unlikely(__folio_test_movable(folio))) {
+			VM_BUG_ON_FOLIO(!folio_test_isolated(folio), folio);
+			folio_lock(folio);
+			if (folio_test_movable(folio))
+				putback_movable_folio(folio);
 			else
-				ClearPageIsolated(page);
-			unlock_page(page);
-			put_page(page);
+				folio_clear_isolated(folio);
+			folio_unlock(folio);
+			folio_put(folio);
 		} else {
-			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -thp_nr_pages(page));
-			putback_lru_page(page);
+			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
+					folio_is_file_lru(folio), -folio_nr_pages(folio));
+			folio_putback_lru(folio);
 		}
 	}
 }
-- 
2.38.1

