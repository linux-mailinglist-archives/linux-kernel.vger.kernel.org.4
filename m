Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255C96668FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjALCjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjALCjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:39:12 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B840874
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z4-20020a17090a170400b00226d331390cso19309478pjd.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxO3NMAhDGwGa5X2zGDE0i6ZC8nh/RTmvR+znDzc56E=;
        b=L7ms7+u8QSHi8Z/8RNakK19C6sRx4knfDzbqVR612CqX3qI3FV3zprkks2hu4DcC4y
         +VuUesvSeA8nJvx7n4xo8NWR6CISadidiIPsrjj2Q0RS5+V7R5XLUnj2A52mgtUgOhW9
         k9cPBwB185hjda01AqtyxF0O5a4XDEQbLCTQziL0QHZHRSLeniY87ebe7A5seFeH4J7A
         HNni9V9fB7/L3Iq02HIkKvQtts1SA0GEki9PS5yTq0b65rIJrXGvaMLs6+zZlrSwNZpm
         GpuQiC48DOGNeJWwDV91vSgm7qYlyEkdcrn9bOa4GI5TDwNwmZd6EZg6Tbbtjp2blh6R
         H7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxO3NMAhDGwGa5X2zGDE0i6ZC8nh/RTmvR+znDzc56E=;
        b=L4rrmCJ1HU489VqdlGWJP5N6SIs5vQECdq7nwFIy+/QoC1m3TUr33TUP+i3cQR5XHy
         C6aNatIN+k27sYApqpVsR6kHkK9RozuZns8Fx8wtPskGnSRLzUScjXMekyjnJ6Pimo2p
         pRr5ZGJ1VETMn9A+VSkUYv1sk4TURvlbSjFVvlsLQ2LobxMPH3rBdp9tFS4bw8K/Lpt8
         YQSLV/LVD+rnOPZmv49Nfsp/rbAGLzBEGI5R3IhAa/Pi+MCO3XrB3KjcxGU9lwHkCtXT
         UGGXa0Jx2ipBIP6TdMOitMbur45fX9DA1hMpbf1GkwTWGX1bLeKveefoUTXoU62U7ATR
         9XCg==
X-Gm-Message-State: AFqh2koOX/fR6Eo7YhwW1PaGVg5hRjBWa3P0u4ALQ7r3zCibyIuci/ge
        2mdUX4IdynuYuV/xXC/azRzaSw==
X-Google-Smtp-Source: AMrXdXuMfcnqymlqo5XUQfsnd/LLwhCwzAct3TWdVlWRd6At3sguvNRBgM25P7G1BSV9vvnS5bzO3A==
X-Received: by 2002:a17:902:bf45:b0:189:fa12:c98a with SMTP id u5-20020a170902bf4500b00189fa12c98amr65213379pls.66.1673491150506;
        Wed, 11 Jan 2023 18:39:10 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id w7-20020a1709027b8700b001944b1285easm2310331pll.198.2023.01.11.18.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:39:10 -0800 (PST)
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
Subject: [PATCH v7 1/7] arm64: Allow the definition of UNKNOWN system register fields
Date:   Thu, 12 Jan 2023 11:38:46 +0900
Message-Id: <20230112023852.42012-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112023852.42012-1-akihiko.odaki@daynix.com>
References: <20230112023852.42012-1-akihiko.odaki@daynix.com>
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
index c350164a3955..e1df4b956596 100755
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
index 184e58fd5631..f754265aec5f 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -15,6 +15,8 @@
 
 # Res1	<msb>[:<lsb>]
 
+# Unkn	<msb>[:<lsb>]
+
 # Field	<msb>[:<lsb>]	<name>
 
 # Enum	<msb>[:<lsb>]	<name>
-- 
2.39.0

