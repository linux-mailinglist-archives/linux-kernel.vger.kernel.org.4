Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939D76FEB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjEKGFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbjEKGF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:05:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A775F49C0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:05:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4339B641DF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1858C433EF;
        Thu, 11 May 2023 06:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683785125;
        bh=ftSXav9Ld5ogo67kFrMUcEhOLLfmgBzzbXCcC+JfGpw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HQL5H4m0Wzj/U7Njw1nn8a7gHJIK335BMD+1LetfXWFHil0JkceKaXevAyAlEPDih
         WcJwFNWdIynu+u0uyH8yFOGv7YTY99g3+UApbRPFEWnWnPTengafk5QyQDFOvcqJ9b
         KNUceKBC1E/BY9v9JcmxdLlGJvm7WEJnoX3VEDAlJlV+F7em67iSByRfTnCk0bcEaa
         z2rR6b/XC+TYQpZnFjmsgHFmdQIhqzoZVJ9XmFz0Ny6uUH/1Ln+73Sm3PCcBHptjiI
         ThZqTf4O5/b3SqaQU0VQRvlQfh/hhzsXvqGQAUfI4MxzFoClICXDNE8w+l5yoOmXM9
         y/i3IxptazyRw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 11 May 2023 15:05:15 +0900
Subject: [PATCH v3 2/2] arm64/esr: Add decode of ISS2 to data abort
 reporting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-arm64-iss2-dabt-decode-v3-2-c1fa503e503a@kernel.org>
References: <20230417-arm64-iss2-dabt-decode-v3-0-c1fa503e503a@kernel.org>
In-Reply-To: <20230417-arm64-iss2-dabt-decode-v3-0-c1fa503e503a@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3602; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ftSXav9Ld5ogo67kFrMUcEhOLLfmgBzzbXCcC+JfGpw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkXIWe0Oyffq9ZSoFsahUxM3rf13kPwMbgRmfpD
 N3phpZ+UIuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZFyFngAKCRAk1otyXVSH
 0MJVB/0SQvqxdfVpYIug0h3Go0Oo/VwPK517sxDNDMtZ+F7lacYFO+9bF0UTn3vkxF5cZ+Qyx1e
 6HSNZ+UTNfujHnU7d7Kk9YgNWbATDiwmKZMf5pUt1VLQqf1HFaTt/KGd/Rn3mm/rNuXTNVY0tvL
 o9SlSLi81bNN61G08amP5oGimAkGXnJgTUBaq92VLzepXBy4PZrJ/N9nThExHt0odmPPdJHlBlF
 zOOzPuJ3QnNLSsOiD/jAXuYoPOa6kOTPfzGXa3pzt9snTNq3oKL+SZTfcpxuCZt9SeFCUlvjpEB
 bA0h0pZ1lMhUQK/INIAhfoYQeiv94Q2O8e6Mq/YLrFnPAZHD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The architecture has added more information about faults to ISS2 within
ESR. Add decode of this to our data abort fault decode to aid diagnostics.
Features that are not currently enabled are included here for completeness.

Since the architecture specifies the values of bits within ISS2 in terms
of ISS2 rather than in terms of the register as a whole we do so for our
definitions as well, this makes it easier to review bitfield definitions.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/esr.h | 17 +++++++++++++++++
 arch/arm64/mm/fault.c        | 17 ++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 0bd879007168..0552a29f026b 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -77,6 +77,9 @@
 #define ESR_ELx_IL		(UL(1) << ESR_ELx_IL_SHIFT)
 #define ESR_ELx_ISS_MASK	(GENMASK(24, 0))
 #define ESR_ELx_ISS(esr)	((esr) & ESR_ELx_ISS_MASK)
+#define ESR_ELx_ISS2_SHIFT	(32)
+#define ESR_ELx_ISS2_MASK	(GENMASK_ULL(55, 32))
+#define ESR_ELx_ISS2(esr)	(((esr) & ESR_ELx_ISS2_MASK) >> ESR_ELx_ISS2_SHIFT)
 
 /* ISS field definitions shared by different classes */
 #define ESR_ELx_WNR_SHIFT	(6)
@@ -140,6 +143,20 @@
 #define ESR_ELx_CM_SHIFT	(8)
 #define ESR_ELx_CM 		(UL(1) << ESR_ELx_CM_SHIFT)
 
+/* ISS2 field definitions for Data Aborts */
+#define ESR_ELx_TnD_SHIFT	(10)
+#define ESR_ELx_TnD 		(UL(1) << ESR_ELx_TnD_SHIFT)
+#define ESR_ELx_TagAccess_SHIFT	(9)
+#define ESR_ELx_TagAccess	(UL(1) << ESR_ELx_TagAccess_SHIFT)
+#define ESR_ELx_GCS_SHIFT	(8)
+#define ESR_ELx_GCS 		(UL(1) << ESR_ELx_GCS_SHIFT)
+#define ESR_ELx_Overlay_SHIFT	(6)
+#define ESR_ELx_Overlay		(UL(1) << ESR_ELx_Overlay_SHIFT)
+#define ESR_ELx_DirtyBit_SHIFT	(5)
+#define ESR_ELx_DirtyBit	(UL(1) << ESR_ELx_DirtyBit_SHIFT)
+#define ESR_ELx_Xs_SHIFT	(0)
+#define ESR_ELx_Xs_MASK		(GENMASK_ULL(4, 0))
+
 /* ISS field definitions for exceptions taken in to Hyp */
 #define ESR_ELx_CV		(UL(1) << 24)
 #define ESR_ELx_COND_SHIFT	(20)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9e0db5c387e3..6f08fd9686be 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -66,6 +66,8 @@ static inline const struct fault_info *esr_to_debug_fault_info(unsigned long esr
 
 static void data_abort_decode(unsigned long esr)
 {
+	unsigned long iss2 = ESR_ELx_ISS2(esr);
+
 	pr_alert("Data abort info:\n");
 
 	if (esr & ESR_ELx_ISV) {
@@ -78,12 +80,21 @@ static void data_abort_decode(unsigned long esr)
 			 (esr & ESR_ELx_SF) >> ESR_ELx_SF_SHIFT,
 			 (esr & ESR_ELx_AR) >> ESR_ELx_AR_SHIFT);
 	} else {
-		pr_alert("  ISV = 0, ISS = 0x%08lx\n", esr & ESR_ELx_ISS_MASK);
+		pr_alert("  ISV = 0, ISS = 0x%08lx, ISS2 = 0x%08lx\n",
+			 esr & ESR_ELx_ISS_MASK, iss2);
 	}
 
-	pr_alert("  CM = %lu, WnR = %lu\n",
+	pr_alert("  CM = %lu, WnR = %lu, TnD = %lu, TagAccess = %lu\n",
 		 (esr & ESR_ELx_CM) >> ESR_ELx_CM_SHIFT,
-		 (esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT);
+		 (esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT,
+		 (iss2 & ESR_ELx_TnD) >> ESR_ELx_TnD_SHIFT,
+		 (iss2 & ESR_ELx_TagAccess) >> ESR_ELx_TagAccess_SHIFT);
+
+	pr_alert("  GCS = %ld, Overlay = %lu, DirtyBit = %lu, Xs = %llu\n",
+		 (iss2 & ESR_ELx_GCS) >> ESR_ELx_GCS_SHIFT,
+		 (iss2 & ESR_ELx_Overlay) >> ESR_ELx_Overlay_SHIFT,
+		 (iss2 & ESR_ELx_DirtyBit) >> ESR_ELx_DirtyBit_SHIFT,
+		 (iss2 & ESR_ELx_Xs_MASK) >> ESR_ELx_Xs_SHIFT);
 }
 
 static void mem_abort_decode(unsigned long esr)

-- 
2.39.2

