Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE006AE1CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCGOJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCGOIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:08:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11588867F0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F03AB818F3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD83C433A1;
        Tue,  7 Mar 2023 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198048;
        bh=SoZODBy3e6pBd6VVEQFBkwGASrxh7Q1UeOly8/M6eFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6vHoFygj0T9SHRspVnNeZkNyqEvvRmUqh2JLfhWYKsLHPiAq4RLn1hylVd6DyySr
         l6Bskgb3l8DhedzlzzJs0QE0QGVFMO1cLVgEHyGwPx4a1khXczJotkE6XRMpuQwlGW
         fg8+HMF7R0OcB71Xao+uUXf6TngveI7iZJR8ucvUmJLtdT4wE0u8b/Xpr9QffbTth7
         qZbZPOj0tQEoUhBOHrg3IbRKdEK8tSHsWsIK6eoEbnlNe2QzaLjvb5BXn2gTFN6QQx
         ER+32leoaVp8UWAFAQ8whZUy4vsQ5z9vPbpV84AV/RnoN3dv0ZcmVi0QJHsnqB6IDp
         S5ToOELo5vp/w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 21/60] arm64: idreg-override: Avoid sprintf() for simple string concatenation
Date:   Tue,  7 Mar 2023 15:04:43 +0100
Message-Id: <20230307140522.2311461-22-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2395; i=ardb@kernel.org; h=from:subject; bh=SoZODBy3e6pBd6VVEQFBkwGASrxh7Q1UeOly8/M6eFE=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxcjoZFmWf6zz8v36e+vaVbyFmPSMb+ZOteAwOKEv/ kPq+raOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJGn5xn+qT54KGDTlave6FxY d8JcYOqzzpuT1a+nJlwt5t1/4PeZZwz/E8+6mO/1Ztz187VXi92UufIn1TUWHXmb5Hww8oHGhtf /uAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using sprintf() with the "%s.%s=" format, where the first
string argument is always the same in the inner loop of match_options(),
use simple memcpy() for string concatenation, and move the first copy to
the outer loop. This removes the dependency on sprintf(), which will be
difficult to fulfil when we move this code into the early mini C
runtime.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/idreg-override.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 476dc3f0e9d90e22..58c02fe20e1050b4 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -195,14 +195,15 @@ static const struct {
 	{ "nokaslr",			"arm64_sw.nokaslr=1" },
 };
 
-static int __init find_field(const char *cmdline,
+static int __init find_field(const char *cmdline, char *opt, int len,
 			     const struct ftr_set_desc *reg, int f, u64 *v)
 {
-	char opt[FTR_DESC_NAME_LEN + FTR_DESC_FIELD_LEN + 2];
-	int len;
+	int flen = strlen(reg->fields[f].name);
 
-	len = snprintf(opt, ARRAY_SIZE(opt), "%s.%s=",
-		       reg->name, reg->fields[f].name);
+	// append '<fieldname>=' to obtain '<name>.<fieldname>='
+	memcpy(opt + len, reg->fields[f].name, flen);
+	len += flen;
+	opt[len++] = '=';
 
 	if (memcmp(cmdline, opt, len))
 		return -1;
@@ -212,15 +213,21 @@ static int __init find_field(const char *cmdline,
 
 static void __init match_options(const char *cmdline)
 {
+	char opt[FTR_DESC_NAME_LEN + FTR_DESC_FIELD_LEN + 2];
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
 		const struct ftr_set_desc *reg = prel64_to_pointer(&regs[i].reg_prel);
 		struct arm64_ftr_override *override;
+		int len = strlen(reg->name);
 		int f;
 
 		override = prel64_to_pointer(&reg->override_prel);
 
+		// set opt[] to '<name>.'
+		memcpy(opt, reg->name, len);
+		opt[len++] = '.';
+
 		for (f = 0; reg->fields[f].name[0] != '\0'; f++) {
 			u64 shift = reg->fields[f].shift;
 			u64 width = reg->fields[f].width ?: 4;
@@ -228,7 +235,7 @@ static void __init match_options(const char *cmdline)
 			bool (*filter)(u64 val);
 			u64 v;
 
-			if (find_field(cmdline, reg, f, &v))
+			if (find_field(cmdline, opt, len, reg, f, &v))
 				continue;
 
 			/*
-- 
2.39.2

