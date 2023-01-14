Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A717866A76B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 01:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjANAQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 19:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjANAQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:16:31 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DBD26F1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:16:29 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9so24997105pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R11gpIsoLjoJPx/bJDZSX3qFzcN1YPIoVj3Kg++9jRA=;
        b=P3XFIbjS9O2iFLNHs9KwE1VQ8werQuyrNARUhLmH0lCVNRZJ2rk7sgZT+Zn/CV3aO9
         n8NosQbbujPD1yTLzY2UtT/orCnuHWy7JhAv4QCSPiGNheHs2ZNcWCweXjNj0NCFqodH
         Xz2SipLoimvA1UTBTssbm8XWZ8xtLfiLHZwIdk9wyWIUkEEnyVwoQOahZlGWgFgcbv1v
         vdMyCUandgKkyl6eDOY3ntLLrn6MzeGGOX03JuITzAcChJZuNGQh9FnQ05DZoIPVVoeT
         fH3iJEksq5Dz+dM+HeaMJPuXGVstuBYeICD8N7ANsSkrBqLXmgyUzhVmF9vR2+cf6V9N
         DOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R11gpIsoLjoJPx/bJDZSX3qFzcN1YPIoVj3Kg++9jRA=;
        b=aZGpfvk/wkE8tbmR0j/PO34m9DeBixGDuBL4lPdE7C2ju8WkUkj3wECnUzJIgpuC+D
         k3jDx7w+izq/EXuPSGQG12bja8Kff22hE/Vr0l+Pk/gU2no+tmYXXvMexTBdvNsJ2VSi
         WQ043haAMvFiovc0iK545+cJmGTmPoQLgeLU4301JNtvF+AXPt6uZ5AAmg3y6ImRJzjA
         rCLa9KErIbxVPWujtd2ctuex3lELuZPCpmlxbgeMCANhhUi9LxjSCMffNaapk2+Ejryq
         fWf0HW2bBdwaLIChCXjComdsOw7lH/KepOkpvSP4MYhrFxkwFWGz9KqKsNQUCWkMnK+W
         KTSQ==
X-Gm-Message-State: AFqh2krqx7Bgv21W7KlrwCmO1khlDOBmzojKvlc2x+vfFDca6u7QMV5J
        Qii7dmVgs2fEzA5zuO4IxlY=
X-Google-Smtp-Source: AMrXdXuuoqgSVenxCxLXxH+0fhWynqRedNaei9TXcehDD/NR+Z5Pd9hEF7ldxqIfPwbvyTb/zrcE3g==
X-Received: by 2002:a05:6a20:43a2:b0:b6:71f6:a4c0 with SMTP id i34-20020a056a2043a200b000b671f6a4c0mr9808650pzl.1.1673655388607;
        Fri, 13 Jan 2023 16:16:28 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2e58])
        by smtp.googlemail.com with ESMTPSA id nl5-20020a17090b384500b0020b21019086sm4064541pjb.3.2023.01.13.16.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 16:16:28 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/2] mm/khugepaged: Convert release_pte_pages() to use folios
Date:   Fri, 13 Jan 2023 16:15:56 -0800
Message-Id: <20230114001556.43795-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230114001556.43795-1-vishal.moola@gmail.com>
References: <20230114001556.43795-1-vishal.moola@gmail.com>
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

Converts release_pte_pages() to use folios instead of pages.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4888e8688401..27d010431ece 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -509,20 +509,20 @@ static void release_pte_page(struct page *page)
 static void release_pte_pages(pte_t *pte, pte_t *_pte,
 		struct list_head *compound_pagelist)
 {
-	struct page *page, *tmp;
+	struct folio *folio, *tmp;
 
 	while (--_pte >= pte) {
 		pte_t pteval = *_pte;
 
-		page = pte_page(pteval);
+		folio = pfn_folio(pte_pfn(pteval));
 		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
-				!PageCompound(page))
-			release_pte_page(page);
+				!folio_test_large(folio))
+			release_pte_folio(folio);
 	}
 
-	list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
-		list_del(&page->lru);
-		release_pte_page(page);
+	list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
+		list_del(&folio->lru);
+		release_pte_folio(folio);
 	}
 }
 
-- 
2.38.1

