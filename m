Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1939678D44
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjAXBWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjAXBWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:22:17 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46CF8A7A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:16 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r18so10326005pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1khdYzxT7PMCcz7jBx9VZXJLxnPij2EE71ujrUVxn1A=;
        b=AQFA3PSKomBpZe5gurflYfaoGq6UO7+JSQrD/eFXn7DBVKYwU0lAuRqrv6GxCbLet2
         ZYY3M1EU7g5+hFtI0ELOwlQINs/vbumoHskfRHq5wnlvKsUF/l+Wu9dTzLGCbeC+yyLZ
         1IQGEjtGmR9Qv/BmzIV6kz5BRs1XM+FvZ9xTyoltiC/Jbz7hp1uo/CqieYoyGHbCRZkV
         cQuSasuhjAi4VrOVZ8FspI81LB1vNTSUlHIKh4KN4Ho8vG5ViS7RiguK2VdNCAheBcmT
         7yDjGx0eTBYwv9ulybCtiSf4t7DyfDQSO5+r6WLwoWyfqrKcDBphe0mryJEh58FaiuZK
         FTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1khdYzxT7PMCcz7jBx9VZXJLxnPij2EE71ujrUVxn1A=;
        b=t3TaT9Ngc/yJx+UfNu2qdwCDlIuRPuEUNUQVIu01RYDZ1VSwt6CvQMuY4PJDZ7Qp2b
         RzlXV/S8cZwT8+ya7y86FRNUwWFe0xxTgtqew7VICbgrZJcsCFPcen4tltuU64ZTIS8u
         zzmen8KS1UUnKV6h/bDtXn/60/hlb6NTAw8O4/xq7vopBWHVg5G1m3iDSoTeuvArs+2T
         kgBfjSvyHX70zm9UTtllHJhJ+r7mIFKzr7WoISQa8u4NfrmXSEWp/Qdw73m+sNwJ566Z
         /wp57AF2lYhbDUXkn3Tw4KPalzewVpxSH8RmnAZqcd34BC+/ErBQN0XebEdTj+iicd9K
         /u4g==
X-Gm-Message-State: AFqh2kqUXKhgsuVPtG+YKK9fH6PnPZEtI9AzM9KKpWGR39W6ekdG+7jy
        4WbGls7J2pfGEaE6VNDfL3Q=
X-Google-Smtp-Source: AMrXdXuX4J13uTAEIumzs2XPLcTlVHJgPNwGg7gH1qZU0DCzEzh0s6K/AVoOfbakTeWPmmGphfpZhQ==
X-Received: by 2002:aa7:96f7:0:b0:580:c223:90e9 with SMTP id i23-20020aa796f7000000b00580c22390e9mr28511220pfq.6.1674523336159;
        Mon, 23 Jan 2023 17:22:16 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id 68-20020a620547000000b005825b8e0540sm213335pff.204.2023.01.23.17.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:22:15 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 2/6] mm/mempolicy: Convert queue_pages_pmd() to queue_folios_pmd()
Date:   Mon, 23 Jan 2023 17:22:06 -0800
Message-Id: <20230124012210.13963-3-vishal.moola@gmail.com>
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

The function now operates on a folio instead of
the page associated with a pmd.

This change is in preparation for the conversion of
queue_pages_required() to queue_folio_required() and migrate_page_add()
to migrate_folio_add().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fd99d303e34f..00fffa93adae 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -442,21 +442,21 @@ static inline bool queue_pages_required(struct page *page,
 }
 
 /*
- * queue_pages_pmd() has three possible return values:
- * 0 - pages are placed on the right node or queued successfully, or
+ * queue_folios_pmd() has three possible return values:
+ * 0 - folios are placed on the right node or queued successfully, or
  *     special page is met, i.e. huge zero page.
- * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
+ * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
  *     specified.
  * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
- *        existing page was already on a node that does not follow the
+ *        existing folio was already on a node that does not follow the
  *        policy.
  */
-static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
+static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 	__releases(ptl)
 {
 	int ret = 0;
-	struct page *page;
+	struct folio *folio;
 	struct queue_pages *qp = walk->private;
 	unsigned long flags;
 
@@ -464,19 +464,19 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 		ret = -EIO;
 		goto unlock;
 	}
-	page = pmd_page(*pmd);
-	if (is_huge_zero_page(page)) {
+	folio = pfn_folio(pmd_pfn(*pmd));
+	if (is_huge_zero_page(&folio->page)) {
 		walk->action = ACTION_CONTINUE;
 		goto unlock;
 	}
-	if (!queue_pages_required(page, qp))
+	if (!queue_pages_required(&folio->page, qp))
 		goto unlock;
 
 	flags = qp->flags;
-	/* go to thp migration */
+	/* go to folio migration */
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 		if (!vma_migratable(walk->vma) ||
-		    migrate_page_add(page, qp->pagelist, flags)) {
+		    migrate_page_add(&folio->page, qp->pagelist, flags)) {
 			ret = 1;
 			goto unlock;
 		}
@@ -512,7 +512,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl)
-		return queue_pages_pmd(pmd, ptl, addr, end, walk);
+		return queue_folios_pmd(pmd, ptl, addr, end, walk);
 
 	if (pmd_trans_unstable(pmd))
 		return 0;
-- 
2.38.1

