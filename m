Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F16537A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiLUUkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:40:30 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DF46580
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:40:29 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 36so11140828pgp.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQ3SWUnwOxxOnluQcCUMkWWYY8S0x44bkExbOVLaC48=;
        b=CgjbPxzz9auLMc+QqmprvUFPDH+q6iP21BxhtqaBpaXAxvLKl4soPwOmL0ZEo0MI0k
         KG+MKaiZk/0N9CG4HI0O7IvoMWt2MzD+tFT1nDsDOYzd7X3iLT2q29nLi4QJ/NTUrUfR
         V/gWfviQJQ3qgz8BSvicuPCE9M08wgIffHkbZNfWu0tKK2VClHSMgqnylAhD3SJYUsbH
         M5HHR96e2Nrq/0f0kZzXCx33jk+iEgmjU0MSdDCDwuJUjQ2HgFspTOghq19nCjtgpsvE
         hzIJyCxO/9fxdKClg4Alt1YEF8wxdDunE/G4rExtnZDruZAQG0s6Ddgokony7C/LqSZH
         y1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ3SWUnwOxxOnluQcCUMkWWYY8S0x44bkExbOVLaC48=;
        b=5bV0XiBKLGJGXoOpqiWgADkay3/UdbpBc+3Ov/u/A0EeALHRhvphoVFYi6CcSBt3E5
         bJT2P9TMK3QCNAtIE7So4YhcnOxQdNfoHMxE/GoGree9cNmzS8MwfVKKvgyjf/3zgOTi
         z8+Qa1twC0XVm8JGp99R3zutbDI+6Fm7lWrV0kzkzNbOoKYQaD6398KhOONFprRq7CYT
         He8mNGA3Iv2mpTti53SQRpBaiRyZAPuDNlmpFrrBn0dTEkKRYw4gKWd7Eg6ndpR2VswB
         sxfWmkAPsqV7OoIMfqyicaIiS713b4zcomY7YDql1OiucL7Vm93GoAEURE6pK+S0SaSp
         rDow==
X-Gm-Message-State: AFqh2kpYNvSAOJlkP6EcEkjJJfQcEiU+D94DfkWZNUmN9fdPPbvUVK6a
        7guTdT7Ykj0kbEIzcTzSz9gF3w==
X-Google-Smtp-Source: AMrXdXsvHxaqMhj6KeXgcujSxTqkAFGj4CKZErT2Ui0ug8g6/X7PZckRkKE8DXINOZHbeLtIGBKJTA==
X-Received: by 2002:a05:6a00:d46:b0:566:94d0:8c8d with SMTP id n6-20020a056a000d4600b0056694d08c8dmr19340634pfv.17.1671655229192;
        Wed, 21 Dec 2022 12:40:29 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id r4-20020aa79884000000b005763c22ea07sm11017784pfl.74.2022.12.21.12.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 12:40:28 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH v4 1/7] arm64: Allow the definition of UNKNOWN system register fields
Date:   Thu, 22 Dec 2022 05:40:10 +0900
Message-Id: <20221221204016.658874-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221204016.658874-1-akihiko.odaki@daynix.com>
References: <20221221204016.658874-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

The CCSIDR_EL1 register contains an UNKNOWN field (which replaces
fields that were actually defined in previous revisions of the
architecture).

Define an 'Unkn' field type modeled after the Res0/Res1 types
to allow such description. This allows the generation of

  #define CCSIDR_EL1_UNKN     (UL(0) | GENMASK_ULL(31, 28))

which may have its use one day. Hopefully the architecture doesn't
add too many of those in the future.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/gen-sysreg.awk | 20 +++++++++++++++++++-
 arch/arm64/tools/sysreg         |  2 ++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
index db461921d256..f6909a6b8380 100755
--- a/arch/arm64/tools/gen-sysreg.awk
+++ b/arch/arm64/tools/gen-sysreg.awk
@@ -98,6 +98,7 @@ END {
 
 	res0 = "UL(0)"
 	res1 = "UL(0)"
+	unkn = "UL(0)"
 
 	next_bit = 63
 
@@ -112,11 +113,13 @@ END {
 
 	define(reg "_RES0", "(" res0 ")")
 	define(reg "_RES1", "(" res1 ")")
+	define(reg "_UNKN", "(" unkn ")")
 	print ""
 
 	reg = null
 	res0 = null
 	res1 = null
+	unkn = null
 
 	next
 }
@@ -134,6 +137,7 @@ END {
 
 	res0 = "UL(0)"
 	res1 = "UL(0)"
+	unkn = "UL(0)"
 
 	define("REG_" reg, "S" op0 "_" op1 "_C" crn "_C" crm "_" op2)
 	define("SYS_" reg, "sys_reg(" op0 ", " op1 ", " crn ", " crm ", " op2 ")")
@@ -161,7 +165,9 @@ END {
 		define(reg "_RES0", "(" res0 ")")
 	if (res1 != null)
 		define(reg "_RES1", "(" res1 ")")
-	if (res0 != null || res1 != null)
+	if (unkn != null)
+		define(reg "_UNKN", "(" unkn ")")
+	if (res0 != null || res1 != null || unkn != null)
 		print ""
 
 	reg = null
@@ -172,6 +178,7 @@ END {
 	op2 = null
 	res0 = null
 	res1 = null
+	unkn = null
 
 	next
 }
@@ -190,6 +197,7 @@ END {
         next_bit = 0
 	res0 = null
 	res1 = null
+	unkn = null
 
 	next
 }
@@ -215,6 +223,16 @@ END {
 	next
 }
 
+/^Unkn/ && (block == "Sysreg" || block == "SysregFields") {
+	expect_fields(2)
+	parse_bitdef(reg, "UNKN", $2)
+	field = "UNKN_" msb "_" lsb
+
+	unkn = unkn " | GENMASK_ULL(" msb ", " lsb ")"
+
+	next
+}
+
 /^Field/ && (block == "Sysreg" || block == "SysregFields") {
 	expect_fields(3)
 	field = $3
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 384757a7eda9..8f26fe1bedc6 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -15,6 +15,8 @@
 
 # Res1	<msb>[:<lsb>]
 
+# Unkn	<msb>[:<lsb>]
+
 # Field	<msb>[:<lsb>]	<name>
 
 # Enum	<msb>[:<lsb>]	<name>
-- 
2.38.1

