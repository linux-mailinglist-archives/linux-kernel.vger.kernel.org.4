Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4168B336
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 01:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBFAV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 19:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBFAVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 19:21:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33F4D520;
        Sun,  5 Feb 2023 16:21:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso9662651wms.5;
        Sun, 05 Feb 2023 16:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qjr0azLLWyc/F0jSQSgAIjFGJ1vXgdojjuJl2+0tgn0=;
        b=d8UAhliMdxOqlFoOosQojJDV0O1El13F2gL/9AjRWUTExZqYSWwovsD+7qG7poT98Q
         XfLBr8ITA/kweSVh0RNn7tSg6uKavnXW3dh5qaJ9ta8ZUuaf4cgqN1vXRoZV+CfAdzHj
         V2ZBUq/auS/P6/r3Zuo4qq7Fan2YQm4fwCZ/odxXrQA1ax2iv2HaP1dMBzWcgl2O1zOU
         irWW/AaM9s8l1GNizHRE4OTMwRp3TZufLFtoGbbxTT9t+1jg2hbAbCNc7guuzwrFbJPC
         kY+ZjZ3ZkIS7sgQ3OjOv8x0fJLUhLfniAniHpBV7PBVGoSvvrNPnmh7Ha8n15Usp1J6Z
         0sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjr0azLLWyc/F0jSQSgAIjFGJ1vXgdojjuJl2+0tgn0=;
        b=0zSmBCPwULioXmkGKesn0TEGmQaraBzDqS36jzmGNTv7o1wLb6fZAiMVtpPq5pFzEt
         VewYZhV1UzdvqvKQLidfZ2HdGCKHkPBQhlB5zlQVvvWJzG8Og+cULwj/VRN2xwUTnm1b
         vsGSEv1x/SaQndwC46h/mBjq7Y6ITHbagep1Gxgi/uO478YhIJEuR6V0nKcFOu5zLhQV
         SmRSqmxkz0uPSI5xPEjvAhJcBzX9QVT0PXmEvdVvHkYS5X5Q3kooSImNLWNMkuQ/o8ch
         /Y3eaBSCtyX6gpOargCLvvNRpjaCpEy5n7U4UEZz6tVBDWgnP1PX54K0IasSzKiZTenF
         /zdQ==
X-Gm-Message-State: AO0yUKUP1Ql1UJvd9bnSygqeewU75x/Xo7FQSbVOz8PJls0svsflDZAO
        JY3oIcjrPrVXzaOnIJDFa9c=
X-Google-Smtp-Source: AK7set+sVpzNPUz3DlSlHFkPUJSeord1K/h7NAmogPFOmbl6j5Bc863cYVN2f1UQgTgxbbTeKNXmlA==
X-Received: by 2002:a05:600c:a51:b0:3df:f9e6:2c5c with SMTP id c17-20020a05600c0a5100b003dff9e62c5cmr3463935wmq.38.1675642909983;
        Sun, 05 Feb 2023 16:21:49 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:ad64:1263:d26a:39ae])
        by smtp.gmail.com with ESMTPSA id m40-20020a05600c3b2800b003dcc82ce53fsm9935504wms.38.2023.02.05.16.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 16:21:49 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: Drop specifying the GIC_CPU_MASK_SIMPLE() for GICv3 systems
Date:   Mon,  6 Feb 2023 00:21:36 +0000
Message-Id: <20230206002136.29401-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The GICv3 interrupts binding does not have a cpumask. The CPU mask only
applies to pre-GICv3. So just drop using them from GICv3 systems.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note, this patch applies on top of [0]

[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi    | 11 +++++------
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi    | 11 +++++------
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi    | 11 +++++------
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi  |  8 ++++----
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi   |  8 ++++----
 arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi |  7 -------
 arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi |  7 -------
 arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi |  7 -------
 8 files changed, 23 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
index 41fbb9998cf8..f04792baef80 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -2209,8 +2209,7 @@ gic: interrupt-controller@f1000000 {
 			interrupt-controller;
 			reg = <0x0 0xf1000000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x110000>;
-			interrupts = <GIC_PPI 9
-				      (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		fcpvd0: fcp@fea10000 {
@@ -2857,9 +2856,9 @@ sensor5_crit: sensor5-crit {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index f20b612b2b9a..52b09e347e13 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -1108,8 +1108,7 @@ gic: interrupt-controller@f1000000 {
 			interrupt-controller;
 			reg = <0x0 0xf1000000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x110000>;
-			interrupts = <GIC_PPI 9
-				      (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		prr: chipid@fff00044 {
@@ -1164,10 +1163,10 @@ sensor3_crit: sensor3-crit {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	ufs30_clk: ufs30-clk {
diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 7a87a5dc1b6a..e84153b18f39 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -1205,8 +1205,7 @@ gic: interrupt-controller@f1000000 {
 			interrupt-controller;
 			reg = <0x0 0xf1000000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x110000>;
-			interrupts = <GIC_PPI 9
-				      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		fcpvd0: fcp@fea10000 {
@@ -1347,9 +1346,9 @@ prr: chipid@fff00044 {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 1c9d3193e4ff..2ab231572d95 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -47,10 +47,10 @@ psci {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 2c848aad7aea..ed7f330e4a2a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -1070,9 +1070,9 @@ target: trip-point {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi
index 1d57df706939..56a979e82c4f 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi
@@ -15,13 +15,6 @@ cpus {
 		/delete-node/ cpu-map;
 		/delete-node/ cpu@100;
 	};
-
-	timer {
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-	};
 };
 
 &soc {
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi
index 9d89d4590358..9cf27ca9f1d2 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi
@@ -15,11 +15,4 @@ cpus {
 		/delete-node/ cpu-map;
 		/delete-node/ cpu@100;
 	};
-
-	timer {
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi
index c448cc6634c1..d85a6ac0f024 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi
@@ -15,11 +15,4 @@ cpus {
 		/delete-node/ cpu-map;
 		/delete-node/ cpu@100;
 	};
-
-	timer {
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-	};
 };
-- 
2.25.1

