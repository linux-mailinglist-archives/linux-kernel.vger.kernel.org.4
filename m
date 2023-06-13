Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC21772ECC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbjFMUTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbjFMUSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:18:55 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BE61BEE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:37 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-462e3a806cbso2080910e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686687517; x=1689279517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maD2yOGQJNTXWHwU2THhq8K/NAnRKyLeT1qKuk6bZHU=;
        b=iU523P6258GfS/ZCsDirRt0LUgWdh+x78uL92gXfwqCf1O5MNCQCvcyNjF+WwJJDOm
         XdIsSAOMVuSAdaNC6l9OBiK3cTVAx06IypwJittnrw8yIbszhTSazBj6J6UOKE6iKUCp
         QEljYCfk0ahME2umWuYIUIjnr+OdsoHzZUNcWvzBZqwkq0iVvWq2Px2W6Q9u3PCR8e8V
         8+zoo565SSZQGmKAAYGk4wp4LL8W8ovaMUR734FCNOH/kgNxO0zVsir1ersME+g44p+5
         KI3lm+OsvGF8DVe/+QLxlpfo3DlxNa4wsG1yltBRopQEZ68n4CtssIfBK5l7/zxp7H3V
         bhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687517; x=1689279517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maD2yOGQJNTXWHwU2THhq8K/NAnRKyLeT1qKuk6bZHU=;
        b=KZwfhgvL1TrPHIAz+jcDU1RT4gUrLoh/NcO+zmWFQvHLBDEcRWbTW1kU78XrbPwZLX
         iw2Rd53tfRuS1mbmy47Yx8wqZAUpd9QAmu6cOTwCJ1N6wDbz525hvAxur98fx7XFsb+i
         +/MOCwWmBEyqUQrhOl2CfsWmXm7by+/RP/g5NJSaxA+2TrZ1IUDCsjZ9tvNmfpLL9hP/
         LbSCBZfaevTv+/TEdtcaaP0PDfKZIo2Hw9wFkeWiPlxLl3LqAxjrINKjE2ynczAwpYNR
         X8H15pQWXWzVm8YDUdfkn+tBRGwMotSAazESdHS+K2pUEhyZis1sEPLLF8IV1Wr+IWis
         niQQ==
X-Gm-Message-State: AC+VfDwtzGCk3bPF4IelXkaKpB0Sd/SHyclpq/TXlk2sWugmZtJg4bbV
        oboMHfxjBETh+c6ePlOVGD0=
X-Google-Smtp-Source: ACHHUZ4K3t4K9LE59exWoJJuUPcaKTyDnDyRL9hNFxfUDEDlOp7IvgA7PrzCPAPjm/qc0TVbyX0gOw==
X-Received: by 2002:a1f:e404:0:b0:45e:59c4:1e0a with SMTP id b4-20020a1fe404000000b0045e59c41e0amr7824199vkh.12.1686687516958;
        Tue, 13 Jun 2023 13:18:36 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id b72-20020a0dd94b000000b0056cea0480c6sm2509985ywe.2.2023.06.13.13.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:18:36 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 5/5] mm: Remove is_longterm_pinnable_page() and Reimplement folio_is_longterm_pinnable()
Date:   Tue, 13 Jun 2023 13:18:27 -0700
Message-Id: <20230613201827.9441-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613201827.9441-1-vishal.moola@gmail.com>
References: <20230613201827.9441-1-vishal.moola@gmail.com>
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

