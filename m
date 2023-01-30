Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12874681B38
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjA3UTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjA3USo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:18:44 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5039E93CA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:43 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q9so8500662pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y48CKbE3JT22h7yWw1CaLB5y4wyl8IVKXFn03JqpXa4=;
        b=Wl7zEv/H7Ojm0N8EkHS/Tvyo9Ekr63AoEgevn1M8sPtkvvYppkidaB9fQ9hosG51Mz
         VAuNl+BCp+5Nvi3wGhMGBG6zoThzCELD4w39zuOs5I+v3HyrYzPZoJ7RFBKACOCMEUIR
         Gc4WkpzCH1Ber5EQQoJnVxBVHNek3ot3YGeqJwTyc2+4p68hlG9LBHmMyNKqD0ezp9r0
         J132PTIIn9ZRd4wAFVkUahjshU0vA89lVPx1FwwChqRZpLp97jlinvFCla6xGd27tMwL
         ySmR6tewviI0124vTdnLIxgiZQIttehQNGUlE3I53cOGtvUDpBuptYhUExG9pqBz7tJ/
         H8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y48CKbE3JT22h7yWw1CaLB5y4wyl8IVKXFn03JqpXa4=;
        b=DfcrMFB3xsVNuGiUraJ+qQ6L+Q5uDZj2sqxzjNnREcdQ9Mfu2viBE/IUU9DTnZYVNW
         Zr2gSoaky2VNhfR8PhQdlX5V89rMc09VXqqr5H9FMzigQhkDRgDfp6N293S6bw6b2dew
         I8iSk8hQ6U1syaoTRJjyTA+drOAR3xgLxrITTL94OqPSIwil6qInaMboUiJ/lv8sMX5Q
         KM3vON3X811T/5Nd4dOzP+sJVidtdSC6rMT9q5CW9daPPd+fr/PxxrAuI92VUndeW6n/
         zzPzOC5ZS20EprXlA3Si+AVL+/GYZqQ3pR7hWsU1DkvzGqyVi6sh453QegnR0vq0DuX+
         JX7g==
X-Gm-Message-State: AO0yUKURNNz8hQO+hPeXIqO/4I4ypxhtc57jih0HlUw4rgwLrCtjKm9D
        hJrSYaD7maX4hCwt0B2T6M0=
X-Google-Smtp-Source: AK7set+DyQIA8npSLdFVb1C6aoLN+sbHw5JucCXJtvR5QA7iDsmOy5cg0rBq1nQf5Nj26FAkra7OTw==
X-Received: by 2002:aa7:950a:0:b0:592:568a:1f70 with SMTP id b10-20020aa7950a000000b00592568a1f70mr8887370pfp.25.1675109922725;
        Mon, 30 Jan 2023 12:18:42 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id g9-20020a056a000b8900b0058d9730ede0sm113262pfj.210.2023.01.30.12.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:18:42 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v4 2/6] mm/mempolicy: convert queue_pages_pmd() to queue_folios_pmd()
Date:   Mon, 30 Jan 2023 12:18:29 -0800
Message-Id: <20230130201833.27042-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230130201833.27042-1-vishal.moola@gmail.com>
References: <20230130201833.27042-1-vishal.moola@gmail.com>
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

The function now operates on a folio instead of the page associated with a
pmd.

This change is in preparation for the conversion of queue_pages_required()
to queue_folio_required() and migrate_page_add() to migrate_folio_add().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7686f40c9750..fc754dbcbbcd 100644
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

