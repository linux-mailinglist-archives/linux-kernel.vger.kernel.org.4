Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6260067C10C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbjAYXmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbjAYXlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:41:52 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0522298E2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so270801pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE+3UuHIJTsmxu1JqArGmSE4JP62IBIElITMZZ15/p0=;
        b=jQrVZxKeueZyKOX/9U6abED0nBNMUqF3gG1HIZMoK5tlZcQs9cJ/ODvbcqhthYHpKQ
         DWBlgZq8Tb2XiUpPQuMtypfYZ9+e6LBX9aHXQkiGdmyvdgULRvOsFnVYvZyBzK93TgON
         yT+3SjOAyRVIKqC2tyImtBCNxFkufKllds3KVdssuCQ158DP+AUXt5N9a7sXPIwJu0b7
         6NUR4WdIza3XMkpwmk7ebXCPL8ZC27KhnroLf9RZKkf8URh1kFoa0wxqKDWcfTalHBmd
         5ICDiFBJCDc915aV0MFz6KVHGYDjIaaj6cqBHLkLCcrCG7fiSVT8xzU8d7ZO0yGQVsMP
         GiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nE+3UuHIJTsmxu1JqArGmSE4JP62IBIElITMZZ15/p0=;
        b=K/9AGnEcVwn2xrHEm7y/QuAQ3UE1XyHv6Opemm4anIvYSOj77kkET4oIOe5w9gZJhY
         gnqxcmYjFpDeF4CjhHRNi2HP/aZWsHJqf9wjysiGVv0zRiHoIiOrWC6KlPE+5TfhN7Vn
         GLVq3Pi/z5WMJTEMu1l+BlDZzY5Q1CpTIClBNp1tiMUEwwLNlTFqBA6PPj7VHZFl3+Xk
         QPuz4XprQgALOxfHMIMa7kG86ls32A3HVdqtMxoBlFChqjwlG3ytoEwsS1AEOI6RpbJs
         27iVPFxfVVza7yQIM7q0Dxc+w4/F+hRwgA8PgTS7dmIwVrIhowHsk2cuz/D1mdvUc5r1
         DIjw==
X-Gm-Message-State: AFqh2krdm6A2/f5B2UylzhsgJb70yfv2F/SnBFsfUzn8xmnNTw5EtAQB
        54N46ZEF5TfRcODeI9YFWX4=
X-Google-Smtp-Source: AMrXdXv4oLc42hq8XgjfnjjhZaGW0OoALKHESNHJGGGtNWvyj5n5jowOYvkPnWGGVyUX9x1zr7AhOw==
X-Received: by 2002:a17:90a:7804:b0:229:912:1340 with SMTP id w4-20020a17090a780400b0022909121340mr34515942pjk.39.1674690110189;
        Wed, 25 Jan 2023 15:41:50 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id e8-20020a17090a630800b00219752c8ea5sm2226806pjj.37.2023.01.25.15.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 15:41:49 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v3 5/6] mm/mempolicy: Convert queue_pages_required() to queue_folio_required()
Date:   Wed, 25 Jan 2023 15:41:33 -0800
Message-Id: <20230125234134.227244-6-vishal.moola@gmail.com>
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

