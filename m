Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4887F724D5F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbjFFTnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbjFFTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:42:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DA110F0;
        Tue,  6 Jun 2023 12:42:42 -0700 (PDT)
Date:   Tue, 06 Jun 2023 19:42:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686080558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2OAfaOG7LEGYjmivyQNzb7iRoU6c4jXctGJtYpNwaso=;
        b=MHr8GNwGRT6MTxBbGhnUWdQNK+dfJIgsotUU1TPSH1a61LjysYHv9WRzxblshNuINKXxgU
        QcJxa0p5BTsnAyOb6vybJgBicEpiEuSYEzjIYz2X5M/n1RUX2Iyw+M8ZjWHiyuc/dVx/tH
        ApBN9H1ILP1mG7Tzkr9azd4j1GeGSCiRe+aEv8B+KSfkrlBWMXs1VI44TX4jkWYG/RXkZ8
        dudvDs5ql1+y9y7iEu7GbXn04nUokQUDs4xCkUWyvGi0yIDXMY/72i9MVS5+QZaurhEpOT
        Cq97p/6qOC7NJBp1eOlPZCCOdRjeRGFDmV6o1i65abfmNko5WwbUaT+X1WoinQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686080558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2OAfaOG7LEGYjmivyQNzb7iRoU6c4jXctGJtYpNwaso=;
        b=oTFJKPZ3/ATWn4Vr/jBiBAwV2MhpTGCCn2bRzBWoj2HTxzhku7mBBAZ2aH6UwHNK4ZgtUl
        4EVgq1AxbdXWpcAg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/tdx: Refactor try_accept_one()
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230606142637.5171-9-kirill.shutemov@linux.intel.com>
References: <20230606142637.5171-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168608055842.404.11233367615561114327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     c2b353ae24d6fecddcc599529ad8319282494781
Gitweb:        https://git.kernel.org/tip/c2b353ae24d6fecddcc599529ad8319282494781
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 06 Jun 2023 17:26:36 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Jun 2023 17:38:50 +02:00

x86/tdx: Refactor try_accept_one()

Rework try_accept_one() to return accepted size instead of modifying
'start' inside the helper. It makes 'start' in-only argument and
streamlines code on the caller side.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20230606142637.5171-9-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e6f4c27..0d5fe6e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -713,18 +713,18 @@ static bool tdx_cache_flush_required(void)
 	return true;
 }
 
-static bool try_accept_one(phys_addr_t *start, unsigned long len,
-			  enum pg_level pg_level)
+static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
+				    enum pg_level pg_level)
 {
 	unsigned long accept_size = page_level_size(pg_level);
 	u64 tdcall_rcx;
 	u8 page_size;
 
-	if (!IS_ALIGNED(*start, accept_size))
-		return false;
+	if (!IS_ALIGNED(start, accept_size))
+		return 0;
 
 	if (len < accept_size)
-		return false;
+		return 0;
 
 	/*
 	 * Pass the page physical address to the TDX module to accept the
@@ -743,15 +743,14 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
 		page_size = 2;
 		break;
 	default:
-		return false;
+		return 0;
 	}
 
-	tdcall_rcx = *start | page_size;
+	tdcall_rcx = start | page_size;
 	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
-		return false;
+		return 0;
 
-	*start += accept_size;
-	return true;
+	return accept_size;
 }
 
 /*
@@ -788,21 +787,22 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	 */
 	while (start < end) {
 		unsigned long len = end - start;
+		unsigned long accept_size;
 
 		/*
 		 * Try larger accepts first. It gives chance to VMM to keep
-		 * 1G/2M SEPT entries where possible and speeds up process by
-		 * cutting number of hypercalls (if successful).
+		 * 1G/2M Secure EPT entries where possible and speeds up
+		 * process by cutting number of hypercalls (if successful).
 		 */
 
-		if (try_accept_one(&start, len, PG_LEVEL_1G))
-			continue;
-
-		if (try_accept_one(&start, len, PG_LEVEL_2M))
-			continue;
-
-		if (!try_accept_one(&start, len, PG_LEVEL_4K))
+		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
+		if (!accept_size)
+			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
+		if (!accept_size)
+			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
+		if (!accept_size)
 			return false;
+		start += accept_size;
 	}
 
 	return true;
