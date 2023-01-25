Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28A67C108
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjAYXlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjAYXls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:41:48 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A257F2D79
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d3so418038plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1khdYzxT7PMCcz7jBx9VZXJLxnPij2EE71ujrUVxn1A=;
        b=UBtFM/nSuni9xqZ8qtJkIk8LKEjARrE386v/XFm4q/6iNHXQglwU92LD/bg63vOquU
         XtqMQys200RkZrhJtyGKmphdie9l9Zb+gcF0lR2o2q/lBs2t6ClE41cQ5XjRo+Edpf9h
         F/md9YBpcoz6dthRROooSVzXlPU/MVHdUIy7JULq17/ImoUOXg3nmk8rQMNBYRjdCoFE
         s0Ynvr4xdLyHXZRENkORJ/T5iABEwi93EyCQsVc6yO0tidjP/AUx8OD8A94a2VejPLdP
         H2+pU1CayBQrjSiZzZHcZ4Az8LmDqjh5OsliDpGe4V/0lp3jnPy/iqNSK2qSaG1aZ3rI
         sqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1khdYzxT7PMCcz7jBx9VZXJLxnPij2EE71ujrUVxn1A=;
        b=wBSKQDEB4j0vu/6xTh2Bm+90u+cR5urfhTnd4jZNAGPh+C7E3KEVSvaLH7Y8vYICI8
         wjTo5bTaOzevxkSSOZUG2EWMxPFAoDi7CCgeRWUb5bep7OLgLhLMjYYd/ikoaW5aOfER
         tg+zYtHRQaakOmc1iDRcvIX843mnp3KiWVwOGgFQo8PZSvlRdlg6Aq0PlF/fuIug79de
         7rT6+xUP4XIOZxQuw0ry3YtfhM25Ph4Ut/OnckyqyHEzJerntVfFRvuccNqiBM2eJkz6
         uOhhZld2ZYGMDb5iurvsPLHCamkfQ+s99/lIG85IqsEFGIgkMS/BeH2d1B9Q5eWK2cP/
         JFVA==
X-Gm-Message-State: AO0yUKVE9kYtTEFffA+Qlw1ITzrNH7YHwNrZhQnq9SIHQcyaiHNrejhi
        Q76qN5lhku9qYoAWKa9XMi4=
X-Google-Smtp-Source: AK7set+5Nv8G0rFVsuyjEbZtPNT4sTuxT0GinYLwHib3RTjsxtB9s5pk4/OGua0gnNYq1cTWnineZg==
X-Received: by 2002:a17:90a:14a5:b0:22b:b25a:d0a0 with SMTP id k34-20020a17090a14a500b0022bb25ad0a0mr4742pja.15.1674690107112;
        Wed, 25 Jan 2023 15:41:47 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id e8-20020a17090a630800b00219752c8ea5sm2226806pjj.37.2023.01.25.15.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 15:41:46 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v3 2/6] mm/mempolicy: Convert queue_pages_pmd() to queue_folios_pmd()
Date:   Wed, 25 Jan 2023 15:41:30 -0800
Message-Id: <20230125234134.227244-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230125234134.227244-1-vishal.moola@gmail.com>
References: <20230125234134.227244-1-vishal.moola@gmail.com>
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

