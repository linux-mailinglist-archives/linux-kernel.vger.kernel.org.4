Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910EE672C82
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjARXW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjARXWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:22:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA630654CA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:22:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g23so609345plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1khdYzxT7PMCcz7jBx9VZXJLxnPij2EE71ujrUVxn1A=;
        b=eTYkEu4QWiTBpQ5PZ5ETHC6H9jjOL0AHY/mzZ+lFwdXVq1tuyLj8P3E8ewR+ImEgsN
         2TKG+AYru0iFaf87vE/NcBHoRFaodj4Cq/jO5AHvjoFqicU95rVV+VCC4PEuK3cHjvzh
         GjJUtXwEbNPzRonxhAuHRRefgnS3GM3lnAbWbhZ0bjiRhRr1StSYxWesqcLL3iyignAo
         xGR7WE0QCGspcGOhpDXTO5lEolH12G/ONF8MoJTL+ZgQYmk/leR/bKANIOXBEaVBQt4W
         PiCDTuIL4Pqm+pTmwGQHbdrrM88Tmo/SToVqmP6+kV/l6w5fewFqt4VNShrV0AO2A3XS
         TJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1khdYzxT7PMCcz7jBx9VZXJLxnPij2EE71ujrUVxn1A=;
        b=uujuiou5Te7MFbWJC9YR2Koz2EQDOI8XFJyQiNVxTRnrYFxNANoEuYi0lrzyx2za+h
         97NI4JkE0bZVj8Ka40fbkbsffUhV8oM2kuNxZfMNAIcqVMIsuavLN2SzZcUdqh59iCMv
         mSBn99UjF52qW5dyTUfXs12NZFCx29tn0YdET+U2UilTA74OjMIYrtUDuJxCFp+HZF0D
         UKYS1rDrhzA2p+61I2C2OM9RPOnts5fg6B0N8HrM0+I0eIGm2Rzf+wd93ykpnllm2m8C
         jgYdpkbMIZSs91rTo1h/QYo3FobeglDWtXm7nDvVpnoy/zj2PMfXl4hMEOiaf/H6SbLv
         mSYQ==
X-Gm-Message-State: AFqh2kqDckqZKjjvIe1jTciCy6wtlLwwGnIAfbf9YhVQEhGmlOhE1DpQ
        R4k9AYdRYydDOV82rooOOlY=
X-Google-Smtp-Source: AMrXdXtOVaWZzLBo+o2TAej0yzsAKCSW+StQtUR8ucQfseE7GI7WjiYyBcPXOLDxSbj/hQ/ZHy51tQ==
X-Received: by 2002:a17:90a:d188:b0:227:e22:4a85 with SMTP id fu8-20020a17090ad18800b002270e224a85mr9314629pjb.9.1674084143365;
        Wed, 18 Jan 2023 15:22:23 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id k1-20020a17090a7f0100b00223f495dc28sm1862265pjl.14.2023.01.18.15.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:22:23 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable 1/5] mm/mempolicy: Convert queue_pages_pmd() to queue_folios_pmd()
Date:   Wed, 18 Jan 2023 15:22:15 -0800
Message-Id: <20230118232219.27038-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230118232219.27038-1-vishal.moola@gmail.com>
References: <20230118232219.27038-1-vishal.moola@gmail.com>
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

