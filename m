Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72D672C86
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjARXWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjARXW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:22:27 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B0A66F96
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:22:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d8so631981pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au6G63hab9343OwjwQffrlqu0KPUTVvJhczlUez6ZjA=;
        b=OpFvnNuBiURxuCLUuAX8gclebbcqS8tU6zG6zpK3Jg1ecyC6h3uLBzssNc1S9jHDHd
         1KSwYCTy5G+mPdu5exzax5tjqlvSskyGaPQSz2bLj5cGgUwau+nGTJtUhKx3c49NjoQy
         6GUqiA5ZMVqONluZBos2f4nk1GfO3iyRvN2BF6x2yt/bmDXB0HwztZcRcSZyiOq5rUtD
         hKmIpBI6UMGAta00Do7k5jjp5fbulHwkyARQBQXZlvhSh89iQcmRKh/lII9hc2hT7cQH
         YLp5ofBrxBLqctMsPDWQSaIABWdHl3KtCfopPF77zlY8V5mGSpD2ZgaD5AduVb1iIvjd
         tM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=au6G63hab9343OwjwQffrlqu0KPUTVvJhczlUez6ZjA=;
        b=Z98ga1MkStuGHSvEAup333ZeZHP9WpcIg+Job+TdOAevd7UVbNTS9+RiLGw4KJFRNU
         9KSO+nHRzZWJ50LL91O66rY/R+8YrdKUFlWgus9I9kUbTEgaSaEp39zYeVmB8P+9rWl3
         XYFF91jTfRncpUZOdGAgPzhoi2LJ6EgWLrCKl3lnC7xUcNKStRBhQfopxCK41svnI9jX
         pl31/QO2HKFkpzJW2e7BtuffSQEnyPSR8tWoYnkqYQsIrG7MfG/v5sW/2oAgkawN1VXl
         BlHtVlUq4vkzeV8iFkwYVgA3mrPuLZ20+xHDTtL5qbYKyS71NwnFNVCzQnrzyZMKlVXt
         NfIw==
X-Gm-Message-State: AFqh2krvKTVMSBN68Bdm7EsbXFV4TNruYJCDGw1XdzofMY2hRYeFTzDS
        arnTqmtVTQgy8e6oq63Vg/Y=
X-Google-Smtp-Source: AMrXdXtYJDKTLcIyyRdhdUAe0qzWWeGZAf+3g+OYbwB8HsvEU4ytSVpzypPZ2UghsoSvMOCw1+1M+Q==
X-Received: by 2002:a17:90a:e647:b0:229:5b13:d850 with SMTP id ep7-20020a17090ae64700b002295b13d850mr8776893pjb.5.1674084146362;
        Wed, 18 Jan 2023 15:22:26 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id k1-20020a17090a7f0100b00223f495dc28sm1862265pjl.14.2023.01.18.15.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:22:26 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable 4/5] mm/mempolicy: Convert queue_pages_required() to queue_folio_required()
Date:   Wed, 18 Jan 2023 15:22:18 -0800
Message-Id: <20230118232219.27038-5-vishal.moola@gmail.com>
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

Replace queue_pages_required() with queue_folio_required().
queue_folio_required() does the same as queue_pages_required(), except
takes in a folio instead of a page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0b82f8159541..0a3690ecab7d 100644
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

