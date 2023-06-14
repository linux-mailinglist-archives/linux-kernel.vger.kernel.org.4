Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F072F280
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbjFNCOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242157AbjFNCOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:14:30 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E9019B9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:29 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56d06711fccso2206407b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686708868; x=1689300868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oezw1x9OR5I9OrjQTv8pl4ceJsvnhhH8ZZxaxblQe1s=;
        b=O48zV0HJ8AnO6I45UUKI48I+tD/Vv23woacs9hKnlQUxpefbJbhzQLqPr5GRevY5g9
         QPj5DwIyXOvszZCwPQHWvb8S2Nec48dlPm76GAa7K/NYG3zynZ9iCijubGWPdTnPPLT0
         PNLSWXCh2boJweoP/O9U5JQj5ruvgnbTzpj5Co9lQHUdNgysNtGP9IcmCL13jGSnCTaN
         /r/5Gw13CrEJV0ZyM4DKdT6pAAe9yjoHrmua6tqXJZJ22cz/oxKC8YCvWk0BzhIevIVA
         qeMFjIYfkShTzuvIClUtOGRftTo40VJp9tIsll7NcDaok7XIcijeg4IZ0QOGEojV9+h0
         TJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686708868; x=1689300868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oezw1x9OR5I9OrjQTv8pl4ceJsvnhhH8ZZxaxblQe1s=;
        b=YgaPhH59v13Icu6UbZV8VUA1VWAPH4U1+RScT0BQtGZwPZSUInYjl2xRIZL/6E0t9S
         CSaijQgf7lQ095SrYRdusVRbOoVPdOqygCghpFJhBvbht9S3llFCP6sRaExUNCzQHfYw
         2oYkmNf+4Z58QFyBu/MwNdyObjTB/1H5u2usMhRdHWKA+mdT2lvMqS1ZiLbiRkwUu0LG
         YbVct+YpNWi8lv4FQ8hAXYr67jOJT1bUcc0nIk5WBWcVFTBBFk0yVXjxT3jM/Vu9Ozyx
         T5ZLK+V3MPRT0PH79jErZxxIyAGf0TPuNlmN02zWBwCcehtQNJoqMorfg9JVTssDvlpo
         u28g==
X-Gm-Message-State: AC+VfDwSVqmfQ+nk9AxEY+zOopm1F2OQOwC8ZZx2w5zUmzQlBuxI/dTN
        eiQKBl+tbgwNSWVtxhmTy5o=
X-Google-Smtp-Source: ACHHUZ4U+/TjEKVuJNFVPqHGiuvcd9miGd5mgokN6FTvX/wE87apwS8HCpWNLHMIde0JYtJVPLwbsg==
X-Received: by 2002:a0d:e6cc:0:b0:56d:3b1a:8641 with SMTP id p195-20020a0de6cc000000b0056d3b1a8641mr516908ywe.23.1686708868335;
        Tue, 13 Jun 2023 19:14:28 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id p3-20020a817403000000b0056d30f1b508sm1463931ywc.107.2023.06.13.19.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:14:28 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 5/5] mm: Remove is_longterm_pinnable_page() and Reimplement folio_is_longterm_pinnable()
Date:   Tue, 13 Jun 2023 19:13:12 -0700
Message-Id: <20230614021312.34085-6-vishal.moola@gmail.com>
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

folio_is_longterm_pinnable() already exists as a wrapper function. Now
that the whole implementation of is_longterm_pinnable_page() can be
implemented using folios, folio_is_longterm_pinnable() can be made its
own standalone function - and we can remove is_longterm_pinnable_page().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..e2d35e272e07 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1910,39 +1910,35 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 	return page_maybe_dma_pinned(page);
 }
 
-/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
+/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
 #ifdef CONFIG_MIGRATION
-static inline bool is_longterm_pinnable_page(struct page *page)
+static inline bool folio_is_longterm_pinnable(struct folio *folio)
 {
 #ifdef CONFIG_CMA
-	int mt = get_pageblock_migratetype(page);
+	int mt = folio_migratetype(folio);
 
 	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
 		return false;
 #endif
 	/* The zero page may always be pinned */
-	if (is_zero_pfn(page_to_pfn(page)))
+	if (is_zero_pfn(folio_pfn(folio)))
 		return true;
 
 	/* Coherent device memory must always allow eviction. */
-	if (is_device_coherent_page(page))
+	if (folio_is_device_coherent(folio))
 		return false;
 
-	/* Otherwise, non-movable zone pages can be pinned. */
-	return !is_zone_movable_page(page);
+	/* Otherwise, non-movable zone folios can be pinned. */
+	return !folio_is_zone_movable(folio);
+
 }
 #else
-static inline bool is_longterm_pinnable_page(struct page *page)
+static inline bool folio_is_longterm_pinnable(struct folio *folio)
 {
 	return true;
 }
 #endif
 
-static inline bool folio_is_longterm_pinnable(struct folio *folio)
-{
-	return is_longterm_pinnable_page(&folio->page);
-}
-
 static inline void set_page_zone(struct page *page, enum zone_type zone)
 {
 	page->flags &= ~(ZONES_MASK << ZONES_PGSHIFT);
-- 
2.40.1

