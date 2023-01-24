Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A934678D45
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjAXBW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjAXBWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:22:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B344118AA3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:17 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso440724pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vZic6jN1vVBvksvwJz1xQpCGfyGjrm+SSW90x/iIgk=;
        b=qBPhBTvMV2Owf9VhJgprVatzzsuTmrmdgujWu+ZXhk/taMI+CI//vfjdnStMaEicO+
         eRgtXHtbKN7WoA1D0BW1aQx3ngg0C6oyKnkPB2n8LbLYUDvFVEEsQvMko7UurU0FYDrP
         rgmkiL0x6/F6KFse2M+VNc9uZfljnpTYBKUgzeZ1yUHeJQjjeCbIDNUZ/Lip+HXAfpnO
         4tlP4om8xgFnrzu1DFjHz/F68qaZoC4b7pEDtOxU940nWGKICHTJUPqT20Z07wsTUnI0
         pg4tdKzTzZA53en87NnjKZ8kjpBE7Zm2e0Jw98pVKixaY+TCAziFoR/c+QD2ckTpoMq2
         fkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vZic6jN1vVBvksvwJz1xQpCGfyGjrm+SSW90x/iIgk=;
        b=HPq6JQMvvwWG7yFezXJJQimD4ZGQG12Hs7xOa8U2loWlo0umhu8SRA9eS5YEnoDZ72
         tCqRGR/gO/OE23KKN+Sf4hrea0d62pTAZwki9WQepwTAhn35s7CASXrS69aF/2aBIz4L
         b4Zegum2mttbdfXTYFp9aNcvwpW3dYI743nYNB/NhiJP+7MRZW3qFVhvf/4MQACv7Q4m
         6go5zM9TGXZqiGfCAvxbiRXLLNUx4Qsh+cDGpAcozpQ1Y6s5FkpMlhM79KYo4jE1P3ZJ
         v87PNXT4N5LVJHEhjuWZv92t9cfYPa3Gbz+YAE1yQuJHuBBi8U2A6wKUJD4rv/WaYccS
         4Y+A==
X-Gm-Message-State: AFqh2krYa98F16OaRnwv9iiaUyCRGpDQh0M+di0Zg5Ca1c+FZ+fKxxAF
        sll/UEunxWmmAJgPVhSKejQ=
X-Google-Smtp-Source: AMrXdXudmDodnBv1VMH7m3m7RLcq8yi1x0STxfkEaumfHAX7TMVdKWRHhpFOBALkU+Vbi6tmSMYlaQ==
X-Received: by 2002:a05:6a20:9597:b0:af:7762:3c29 with SMTP id iu23-20020a056a20959700b000af77623c29mr28570275pzb.10.1674523337108;
        Mon, 23 Jan 2023 17:22:17 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id 68-20020a620547000000b005825b8e0540sm213335pff.204.2023.01.23.17.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:22:16 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 3/6] mm/mempolicy: Convert queue_pages_pte_range() to queue_folios_pte_range()
Date:   Mon, 23 Jan 2023 17:22:07 -0800
Message-Id: <20230124012210.13963-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230124012210.13963-1-vishal.moola@gmail.com>
References: <20230124012210.13963-1-vishal.moola@gmail.com>
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

This function now operates on folios associated with ptes instead of
pages.

This change is in preparation for the conversion of
queue_pages_required() to queue_folio_required() and migrate_page_add()
to migrate_folio_add().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 00fffa93adae..ae9d16124f45 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -491,19 +491,19 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
  * Scan through pages checking if pages follow certain conditions,
  * and move them to the pagelist if they do.
  *
- * queue_pages_pte_range() has three possible return values:
- * 0 - pages are placed on the right node or queued successfully, or
+ * queue_folios_pte_range() has three possible return values:
+ * 0 - folios are placed on the right node or queued successfully, or
  *     special page is met, i.e. zero page.
- * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
+ * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
  *     specified.
- * -EIO - only MPOL_MF_STRICT was specified and an existing page was already
+ * -EIO - only MPOL_MF_STRICT was specified and an existing folio was already
  *        on a node that does not follow the policy.
  */
-static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
+static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 			unsigned long end, struct mm_walk *walk)
 {
 	struct vm_area_struct *vma = walk->vma;
-	struct page *page;
+	struct folio *folio;
 	struct queue_pages *qp = walk->private;
 	unsigned long flags = qp->flags;
 	bool has_unmovable = false;
@@ -521,16 +521,16 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
-		page = vm_normal_page(vma, addr, *pte);
-		if (!page || is_zone_device_page(page))
+		folio = vm_normal_folio(vma, addr, *pte);
+		if (!folio || folio_is_zone_device(folio))
 			continue;
 		/*
-		 * vm_normal_page() filters out zero pages, but there might
-		 * still be PageReserved pages to skip, perhaps in a VDSO.
+		 * vm_normal_folio() filters out zero pages, but there might
+		 * still be reserved folios to skip, perhaps in a VDSO.
 		 */
-		if (PageReserved(page))
+		if (folio_test_reserved(folio))
 			continue;
-		if (!queue_pages_required(page, qp))
+		if (!queue_pages_required(&folio->page, qp))
 			continue;
 		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 			/* MPOL_MF_STRICT must be specified if we get here */
@@ -544,7 +544,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			 * temporary off LRU pages in the range.  Still
 			 * need migrate other LRU pages.
 			 */
-			if (migrate_page_add(page, qp->pagelist, flags))
+			if (migrate_page_add(&folio->page, qp->pagelist, flags))
 				has_unmovable = true;
 		} else
 			break;
@@ -703,7 +703,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 
 static const struct mm_walk_ops queue_pages_walk_ops = {
 	.hugetlb_entry		= queue_pages_hugetlb,
-	.pmd_entry		= queue_pages_pte_range,
+	.pmd_entry		= queue_folios_pte_range,
 	.test_walk		= queue_pages_test_walk,
 };
 
-- 
2.38.1

