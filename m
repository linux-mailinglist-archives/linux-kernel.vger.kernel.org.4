Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F0B681B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjA3UTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjA3USs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:18:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54B6470AD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j5so12175747pjn.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJQ5OTdh+fc+ccMNlHyYjb+fYbFIfXaQUDxSd+sy4Ac=;
        b=PEUIZrC+RH5+9pYkh6XYzKYqbMb8jOHl+69QZ/Lb2+tXCHO+jqtbDIZKClYL68y3RO
         BbK/pZKsW5mscHpNz/jhxraDmx1IyeZPErllGnlJNJO99fUJZDIG01OCBA7AtlvXr2QZ
         tjXA4+oBey2Rie2dE8OW4bp/7ySNDizbDQGMfpcvuPSTBoblsldgyu8UYC0i/IncGdLQ
         N4ZuaojlXmmT5uNLUBr+NSJObiaW0CQ1NEu7yjMk7bToXSoQocoD0SAiNt7tFRgy3Zjt
         73B1duMYfMdMKFMX36MZn7wGnh/osd/8fYOdi2jqhKZyca30g8842xjxn5NY0WfkiXn0
         AMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJQ5OTdh+fc+ccMNlHyYjb+fYbFIfXaQUDxSd+sy4Ac=;
        b=uI9UgWEEYDd498mJUK1/1p/UiItV1HSUYoUDdSHdhEvX5nyJpJPIWxGy8+EYKAXki+
         R+DPxZGJKf43C87N7k4kyMoVKcYvvpc2dvKrnFWvUy/mGF0DY/IgF0HnC+oxI7oRqhRD
         9CIG5Ue+s5TKdqeuPhmH3mpWYrbX4bH0PTjFzSC7UfAO1CIYlf3Iy2Pww7wqT14bDs9K
         MukzuwCEB2EfoYCL1hohJwP7JwsdKtiVdNFZl2dLy4iumTm/bU4/JxIJeRaKikUQbCPj
         sa4dp2gRGnsGBAdpxu0RzPBjx6v6AR6sTygkBSbrakjj66y9Nbyqbm3rOeYV+pqVItf1
         DrrA==
X-Gm-Message-State: AO0yUKVs04UCweTH2lN18hVvMhUtoLLf+MsiKVN8rK9q7+Z3V6nfy7dK
        +CrK3sfdPQwaT9qsNs/10v0=
X-Google-Smtp-Source: AK7set/3xtBWdaXl/BxR1DUewvgNkf3u0eTu5c7YIlED/AQZjc6fr+VgNbYD76m5b1zy5IDlpUgKzg==
X-Received: by 2002:a05:6a20:4408:b0:bc:ae32:4d6e with SMTP id ce8-20020a056a20440800b000bcae324d6emr10770844pzb.54.1675109926167;
        Mon, 30 Jan 2023 12:18:46 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id g9-20020a056a000b8900b0058d9730ede0sm113262pfj.210.2023.01.30.12.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:18:45 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v4 5/6] mm/mempolicy: convert queue_pages_required() to queue_folio_required()
Date:   Mon, 30 Jan 2023 12:18:32 -0800
Message-Id: <20230130201833.27042-6-vishal.moola@gmail.com>
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

Replace queue_pages_required() with queue_folio_required().
queue_folio_required() does the same as queue_pages_required(), except
takes in a folio instead of a page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 668392493500..6a68dbce3b70 100644
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

