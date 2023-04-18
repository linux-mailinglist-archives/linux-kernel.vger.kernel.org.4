Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AD36E66B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDROIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjDROIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:08:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8361025C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:08:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74AF562ACE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49A3C433D2;
        Tue, 18 Apr 2023 14:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681826922;
        bh=IIJAPadN5fPGUmVV67Tg/6FekfBFHUYC6SXh5jbkH+M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=h652EvVPz5wMZ0bbgUws/aesIPqSUlyLs3bL1iZP4d815g6xXOuS7ryz9vcpsWxos
         dGP06+QaB8oeduf3mxeBZuvv8kV8LOgH7+pr8j4Bu4mGYBGWIcfcja5nfchEgYh2nE
         e8pjghk3CWP8zGardGM0Yr+lzPMUUyAghUIvUI2frZdcR/YrlibGvba+H1T/37VhVk
         hfJj5U/Y86/yrMzNZeiXL8q7UZnMWyPCWnp1yF1sVgNR9ks/7I7mK1V7qp+PEz01Vg
         ZVqsoncj76NOwFg/gLtIFLun4B+yb/nV8wO/5+5+3ENGw8/LYuSwYiYVTE2+8p1yO4
         yYhydnUCk4KLw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 18 Apr 2023 14:57:32 +0100
Subject: [PATCH 2/2] arm64/esr: Add decode of ISS2 to data abort reporting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-arm64-iss2-dabt-decode-v1-2-2138b5668777@kernel.org>
References: <20230417-arm64-iss2-dabt-decode-v1-0-2138b5668777@kernel.org>
In-Reply-To: <20230417-arm64-iss2-dabt-decode-v1-0-2138b5668777@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=3367; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IIJAPadN5fPGUmVV67Tg/6FekfBFHUYC6SXh5jbkH+M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkPqRlDtHW6v6P3sn7sJZbXIsAo7cK+/2mmFo7QVkD
 XWzYMT+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZD6kZQAKCRAk1otyXVSH0KRIB/
 9EMfEFftbpDqjc9BKCFNb0IKD9L/AQgW1xA5b3+NglugINAqngFsZ0DnO+9JKXr3uEpZ7hjPfGW8Lw
 x/M6XaflfWK2tM2VCDiWJU6Cn/c7h+6X3rc5de1XzjldvsZwb4wz6tT48q59Eg+tGMrirgATOl1kJ7
 ICZ12xmw8RQqlU2S/TEvqGlCGSkCLkzsLXb6w/h8kYeerxHSar/PYnjbqcvTCJ2xr6LEjaAxB17pHr
 QaOPzkwq2m5ENt0aS6dZoSjBpZrcdhgn6/qlb3+dnse2Q/tjJyxhlBq9/MueDPRfqNBcVkQ2sWv+tD
 s9lG/oE9BZXhLkdtLqisJTroLP0Mbs
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
 arch/arm64/mm/fault.c        | 14 ++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 0bd879007168..17bc6536ffea 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -77,6 +77,9 @@
 #define ESR_ELx_IL		(UL(1) << ESR_ELx_IL_SHIFT)
 #define ESR_ELx_ISS_MASK	(GENMASK(24, 0))
 #define ESR_ELx_ISS(esr)	((esr) & ESR_ELx_ISS_MASK)
+#define ESR_ELx_ISS2_SHIFT	(32)
+#define ESR_ELx_ISS2_MASK	(GENMASK_ULL(55, 32))
+#define ESR_ELx_ISS2(esr)	((esr) & ESR_ELx_ISS_MASK)
 
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
index f4cb0f85ccf4..2e76dc613c86 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -66,6 +66,8 @@ static inline const struct fault_info *esr_to_debug_fault_info(unsigned long esr
 
 static void data_abort_decode(unsigned long esr)
 {
+	u64 iss2 = ESR_ELx_ISS2(esr);
+
 	pr_alert("Data abort info:\n");
 
 	if (esr & ESR_ELx_ISV) {
@@ -81,9 +83,17 @@ static void data_abort_decode(unsigned long esr)
 		pr_alert("  ISV = 0, ISS = 0x%08lx\n", esr & ESR_ELx_ISS_MASK);
 	}
 
-	pr_alert("  CM = %lu, WnR = %lu\n",
+	pr_alert("  CM = %lu, WnR = %lu, TnD = %llu, TagAccess = %lld\n",
 		 (esr & ESR_ELx_CM) >> ESR_ELx_CM_SHIFT,
-		 (esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT);
+		 (esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT,
+		 (iss2 & ESR_ELx_TnD) >> ESR_ELx_TnD_SHIFT,
+		 (iss2 & ESR_ELx_TagAccess) >> ESR_ELx_TagAccess_SHIFT);
+
+	pr_alert("  GCS = %lld, Overlay = %llu, DirtyBit = %llu, Xs = %llu\n",
+		 (iss2 & ESR_ELx_GCS) >> ESR_ELx_GCS_SHIFT,
+		 (iss2 & ESR_ELx_Overlay) >> ESR_ELx_Overlay_SHIFT,
+		 (iss2 & ESR_ELx_DirtyBit) >> ESR_ELx_DirtyBit_SHIFT,
+		 (iss2 & ESR_ELx_Xs_MASK) >> ESR_ELx_Xs_SHIFT);
 }
 
 static void mem_abort_decode(unsigned long esr)

-- 
2.30.2

