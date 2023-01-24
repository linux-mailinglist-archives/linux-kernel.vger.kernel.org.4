Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1927B678D47
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjAXBWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjAXBWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:22:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A54139B9E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d3so13249919plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE+3UuHIJTsmxu1JqArGmSE4JP62IBIElITMZZ15/p0=;
        b=ZP/5bObP5pqsvaY9t0h8rIoT9dI9iJBk3mx62rI2nojE2rF17RJDpgzpAJ838bLs/U
         6kRuTVVhRzVrpXQBJQ78n2+00oBc8IN+Qr4UmE90EnJV14gUU4AKy9lGkW4u4LtenMm7
         nNmyb7o9J1AjOT0Yzvb5W29TbD6D52DH1LSYkfBlcnUV7VBOl5yKEIAG1RBVMFbc663g
         RLNNMG4tMyd0Qw6zqvgCGsrHo0cHg2hi/rBgbW25Jg1UoelSwenfNsqRSAJzZSPNwYsY
         HOZe0gaG/lQCzN42ApROK0PrZ8T/HL5yRfeRvFK0HwVF97BGf3YOY1mK9uyGsG2s0OVf
         zR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nE+3UuHIJTsmxu1JqArGmSE4JP62IBIElITMZZ15/p0=;
        b=m5dxDVK2wvRRDvZbJdRArxyx0sy7KmJT/5v63oLsZvrcI1CC5VUCXsR2V+khdXwcwh
         H2eWEH7bX2llE+dh6jY0IjrQeNCpUqqdiSudgdy/EH69JqC1o/aLKswkEzdbUe47nAHy
         onCcJRoESosGT/qiK3V9fQq3T8HSnrR643t6bv9BdZn6iC2FZncCmsuybG7dcAmcEF6u
         +hJnXlmKeVfKVe2kR1M/uazhLSs0oTsLyBJiGoUXelq6aF21j05C4RDKJhdawBrUVKnK
         a1tKv09h2WFo+2O1CDTz4gXKZjfnhH3aVJpoIZGOwm/qFcO3O8JQIKG/lwCm7fN5yphc
         2sig==
X-Gm-Message-State: AFqh2kpZmnSBUll+XccBt9WMXBLrkYSB0gvU20WqC3wJXab+KYentwzq
        DRQygYMUCD5dybiadCZ7/g/MaauES98=
X-Google-Smtp-Source: AMrXdXs0B1T1RoQ7VAB/8nsyU5key1ZZZZtdA3fPrHEjotnA1Vx130RbBWsgiLsAjdttNXdx7IZk6Q==
X-Received: by 2002:a05:6a20:4407:b0:b8:66f6:6263 with SMTP id ce7-20020a056a20440700b000b866f66263mr38103651pzb.23.1674523338995;
        Mon, 23 Jan 2023 17:22:18 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id 68-20020a620547000000b005825b8e0540sm213335pff.204.2023.01.23.17.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:22:18 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 5/6] mm/mempolicy: Convert queue_pages_required() to queue_folio_required()
Date:   Mon, 23 Jan 2023 17:22:09 -0800
Message-Id: <20230124012210.13963-6-vishal.moola@gmail.com>
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

Replace queue_pages_required() with queue_folio_required().
queue_folio_required() does the same as queue_pages_required(), except
takes in a folio instead of a page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ea8cac447e04..da87644430e3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -427,15 +427,15 @@ struct queue_pages {
 };
 
 /*
- * Check if the page's nid is in qp->nmask.
+ * Check if the folio's nid is in qp->nmask.
  *
  * If MPOL_MF_INVERT is set in qp->flags, check if the nid is
  * in the invert of qp->nmask.
  */
-static inline bool queue_pages_required(struct page *page,
+static inline bool queue_folio_required(struct folio *folio,
 					struct queue_pages *qp)
 {
-	int nid = page_to_nid(page);
+	int nid = folio_nid(folio);
 	unsigned long flags = qp->flags;
 
 	return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
@@ -469,7 +469,7 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 		walk->action = ACTION_CONTINUE;
 		goto unlock;
 	}
-	if (!queue_pages_required(&folio->page, qp))
+	if (!queue_folio_required(folio, qp))
 		goto unlock;
 
 	flags = qp->flags;
@@ -530,7 +530,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 		 */
 		if (folio_test_reserved(folio))
 			continue;
-		if (!queue_pages_required(&folio->page, qp))
+		if (!queue_folio_required(folio, qp))
 			continue;
 		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 			/* MPOL_MF_STRICT must be specified if we get here */
@@ -575,7 +575,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	if (!pte_present(entry))
 		goto unlock;
 	folio = pfn_folio(pte_pfn(entry));
-	if (!queue_pages_required(&folio->page, qp))
+	if (!queue_folio_required(folio, qp))
 		goto unlock;
 
 	if (flags == MPOL_MF_STRICT) {
-- 
2.38.1

