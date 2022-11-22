Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447506349CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiKVWH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiKVWHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:07:34 -0500
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F409DAB;
        Tue, 22 Nov 2022 14:07:30 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id n188so11980416iof.8;
        Tue, 22 Nov 2022 14:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9Nr6gPVOX/6LCyJBvLH9UJlV747BhwLKeGilJxI7hM=;
        b=N4NJD2T4VN4ZSmNpR1G8QAQEE1Rp4cVHG85U6wUCFzH06m/MUvLT9mwWyQxqrBnF3C
         zfRRtLaAxJSawXc2XMIRyu8QmqS2GOWzTEi5putq5jE1YQZWXR+yY1GseUUWT7ZfvKZB
         aM2RXRiMXqoXgcEhwY/yy0+8g8NdmLDFzzbLKBt5xnvnYaOTPZWJIs0xLdAssmZwgAUA
         8RgQl15f7tmZb0ZE6puRl/RxczsSj2xEHuqJAqtXeazWo07zc1CImCSdXTMshh+YAOko
         GElzNjiXBSyPXZSh/B+IfXqtWCScp/5RRYWnsZRbWeX8JMHatVuwS4tG5Js8Mft4npFm
         ggrQ==
X-Gm-Message-State: ANoB5pnBrtdtiCZVbq/NCEQOdhn/CYQti1hUZGaJ+TkRN4lq+vlZAGu5
        dZze1bzPagoExi+ISa7z0A==
X-Google-Smtp-Source: AA0mqf4V6ppRkdKRqtlLw69vA65riP97JWiM8WcMjwXpElslevptzfWytkuNVAbmbvpQ/TcmgGNdEw==
X-Received: by 2002:a02:6662:0:b0:363:69a0:837f with SMTP id l34-20020a026662000000b0036369a0837fmr4983635jaf.57.1669154849246;
        Tue, 22 Nov 2022 14:07:29 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w11-20020a056638024b00b0037609ad8485sm5775812jaq.69.2022.11.22.14.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:07:28 -0800 (PST)
Received: (nullmailer pid 660771 invoked by uid 1000);
        Tue, 22 Nov 2022 22:07:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: apple: Add t600x L1/L2 cache properties and nodes
Date:   Tue, 22 Nov 2022 16:06:20 -0600
Message-Id: <20221122220619.659174-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The t600x CPU nodes are missing the cache hierarchy information. The
cache hierarchy on Arm can not be detected and needs to be described in
DT. The OS scheduler can make use of this information for scheduling
decisions.

The cache size information is based on various articles about the
processors. There's also an L3 system level cache (SLC). It's not
described here because SLCs typically have some MMIO interface which
would need to be described.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Based on apple dts changes in linux-next.

This fixes the warning: Unable to detect cache hierarchy for CPU %d
---
 arch/arm64/boot/dts/apple/t6002.dtsi        | 51 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t600x-common.dtsi | 51 +++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6002.dtsi b/arch/arm64/boot/dts/apple/t6002.dtsi
index 3b1677ba5262..731d61fbb05f 100644
--- a/arch/arm64/boot/dts/apple/t6002.dtsi
+++ b/arch/arm64/boot/dts/apple/t6002.dtsi
@@ -29,6 +29,9 @@ cpu_e10: cpu@800 {
 			reg = <0x0 0x800>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_3>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
 		};
 
 		cpu_e11: cpu@801 {
@@ -37,6 +40,9 @@ cpu_e11: cpu@801 {
 			reg = <0x0 0x801>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_3>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
 		};
 
 		cpu_p20: cpu@10900 {
@@ -45,6 +51,9 @@ cpu_p20: cpu@10900 {
 			reg = <0x0 0x10900>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_4>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p21: cpu@10901 {
@@ -53,6 +62,9 @@ cpu_p21: cpu@10901 {
 			reg = <0x0 0x10901>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_4>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p22: cpu@10902 {
@@ -61,6 +73,9 @@ cpu_p22: cpu@10902 {
 			reg = <0x0 0x10902>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_4>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p23: cpu@10903 {
@@ -69,6 +84,9 @@ cpu_p23: cpu@10903 {
 			reg = <0x0 0x10903>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_4>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p30: cpu@10a00 {
@@ -77,6 +95,9 @@ cpu_p30: cpu@10a00 {
 			reg = <0x0 0x10a00>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_5>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p31: cpu@10a01 {
@@ -85,6 +106,9 @@ cpu_p31: cpu@10a01 {
 			reg = <0x0 0x10a01>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_5>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p32: cpu@10a02 {
@@ -93,6 +117,9 @@ cpu_p32: cpu@10a02 {
 			reg = <0x0 0x10a02>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_5>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p33: cpu@10a03 {
@@ -101,6 +128,30 @@ cpu_p33: cpu@10a03 {
 			reg = <0x0 0x10a03>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_5>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		l2_cache_3: l2-cache-3 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x400000>;
+		};
+
+		l2_cache_4: l2-cache-4 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0xc00000>;
+		};
+
+		l2_cache_5: l2-cache-5 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0xc00000>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/apple/t600x-common.dtsi b/arch/arm64/boot/dts/apple/t600x-common.dtsi
index f5fac1926a25..e2568d914719 100644
--- a/arch/arm64/boot/dts/apple/t600x-common.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-common.dtsi
@@ -21,6 +21,9 @@ cpu_e00: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
 		};
 
 		cpu_e01: cpu@1 {
@@ -29,6 +32,9 @@ cpu_e01: cpu@1 {
 			reg = <0x0 0x1>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
 		};
 
 		cpu_p00: cpu@10100 {
@@ -37,6 +43,9 @@ cpu_p00: cpu@10100 {
 			reg = <0x0 0x10100>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p01: cpu@10101 {
@@ -45,6 +54,9 @@ cpu_p01: cpu@10101 {
 			reg = <0x0 0x10101>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p02: cpu@10102 {
@@ -53,6 +65,9 @@ cpu_p02: cpu@10102 {
 			reg = <0x0 0x10102>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p03: cpu@10103 {
@@ -61,6 +76,9 @@ cpu_p03: cpu@10103 {
 			reg = <0x0 0x10103>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p10: cpu@10200 {
@@ -69,6 +87,9 @@ cpu_p10: cpu@10200 {
 			reg = <0x0 0x10200>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_2>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p11: cpu@10201 {
@@ -77,6 +98,9 @@ cpu_p11: cpu@10201 {
 			reg = <0x0 0x10201>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_2>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p12: cpu@10202 {
@@ -85,6 +109,9 @@ cpu_p12: cpu@10202 {
 			reg = <0x0 0x10202>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_2>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
 		};
 
 		cpu_p13: cpu@10203 {
@@ -93,6 +120,30 @@ cpu_p13: cpu@10203 {
 			reg = <0x0 0x10203>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_2>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		l2_cache_0: l2-cache-0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x400000>;
+		};
+
+		l2_cache_1: l2-cache-1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0xc00000>;
+		};
+
+		l2_cache_2: l2-cache-2 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0xc00000>;
 		};
 	};
 
-- 
2.35.1

