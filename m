Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9830960D6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiJYWG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiJYWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:06:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBB672EDB;
        Tue, 25 Oct 2022 15:06:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h9so12296129wrt.0;
        Tue, 25 Oct 2022 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/b2ry2eREZpQrayM8pLQ/WtjYgIHMF+G/lbwLaKSf4=;
        b=JQXfCBiqZbzP5yTTlxr3EGz53xce3Aa/Ku+J2ahBCt2LsI8outAK6yhmUvwoQ8ai11
         EfSuSLmRHmovOKTS4EotfYkVjUrh+ZWaIr6L7FlYqxhvvjMCM0rZ5XHniyqlqwQI6YCX
         KqRfsoRq83tdyzHsiGoexP4JbKTRr+FF0VSJgBbvTqw4e5z4yR3q2xF0MBj55eq0i8hZ
         QEarnRDuY4SyfRLHd3KlLamW/wM3Zr9cGCM1zHe8ttWbyywxZk8E4Nq4bQ819vbL4LOw
         WWzD6yOq0ecZamsyiHeZP8PbtGz8FeGfvOAsIftrv+CFEt1gSlLne9v3dE9WMdyW1W4X
         EjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/b2ry2eREZpQrayM8pLQ/WtjYgIHMF+G/lbwLaKSf4=;
        b=H/wDCOTq8Y/lV4eO8HYtW52VH5ouuo+tTC8rliecrsu0Dqe2a/BNvqybc4tRw+Y3NY
         DFU5smDyyl4Zj/mESwgl7Yz5YXMhPGGKHYhlIqBS4E4rioKAsbksiM+ipQILJKNozoFG
         GxA1E9oUinZzuQY2o/b0Gpnl6sxStSLjqVWZb4r6rr4sQQCpu4Ed9oGM9r4IUic3atDH
         UJElrXCqdmMgp7YG1eM3XB0V1Ya6w2bl74cD42dEwoOTOD4JTXdfiEmo+rWWPegS4GGJ
         d+kOBFl1Yvz1OvWJdYgJlwoidJQRXFOC53pRIKqSUOThpwW6UM10qfikQs9GRcBzMcDs
         OLQA==
X-Gm-Message-State: ACrzQf3ptu+3mTwQZfak0QYaVlV+cJxxLdIn48S+0aEcynM+UBBPDUNa
        u0TRDUPJCppmXdHHFLZm7pNXRhhfrGWMDA==
X-Google-Smtp-Source: AMsMyM4NxkIjCoW1jXtg0U6l6q46VarwvcbwRgKnXYT02v5kre0ykIeGSKQHaROp2OnA1S/1uKP71A==
X-Received: by 2002:adf:e88e:0:b0:236:792e:f2a2 with SMTP id d14-20020adfe88e000000b00236792ef2a2mr6494927wrm.220.1666735606305;
        Tue, 25 Oct 2022 15:06:46 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:1d2a:d2a2:361e:a475])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a342933727sm210534wms.3.2022.10.25.15.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:06:45 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/2] arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific parts
Date:   Tue, 25 Oct 2022 23:06:29 +0100
Message-Id: <20221025220629.79321-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025220629.79321-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221025220629.79321-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Move RZ/G2UL SoC specific parts to r9a07g043u.dtsi so that r9a07g043.dtsi
can be shared with RZ/Five (RISC-V SoC).

Below are the changes due to which SoC specific parts are moved to
r9a07g043u.dtsi:
- RZ/G2UL has Cortex-A55 (ARM64) whereas the RZ/Five has AX45MP (RISC-V)
- RZ/G2UL has GICv3 as interrupt controller whereas the RZ/Five has PLIC
- RZ/G2UL has interrupts for SYSC block whereas interrupts are missing
  for SYSC block on RZ/Five
- RZ/G2UL has armv8-timer whereas the RZ/Five has riscv-timer

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
* Updated commit message about timer
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi  | 54 +------------------
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 60 +++++++++++++++++++++
 2 files changed, 61 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index a7248204d2ba..3f7d451b1199 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /*
- * Device Tree Source for the RZ/G2UL SoC
+ * Device Tree Source for the RZ/Five and RZ/G2UL SoCs
  *
  * Copyright (C) 2022 Renesas Electronics Corp.
  */
@@ -68,36 +68,8 @@ opp-1000000000 {
 		};
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			compatible = "arm,cortex-a55";
-			reg = <0>;
-			device_type = "cpu";
-			#cooling-cells = <2>;
-			next-level-cache = <&L3_CA55>;
-			enable-method = "psci";
-			clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
-			operating-points-v2 = <&cluster0_opp>;
-		};
-
-		L3_CA55: cache-controller-0 {
-			compatible = "cache";
-			cache-unified;
-			cache-size = <0x40000>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-1.0", "arm,psci-0.2";
-		method = "smc";
-	};
-
 	soc: soc {
 		compatible = "simple-bus";
-		interrupt-parent = <&gic>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
@@ -550,12 +522,6 @@ cpg: clock-controller@11010000 {
 		sysc: system-controller@11020000 {
 			compatible = "renesas,r9a07g043-sysc";
 			reg = <0 0x11020000 0 0x10000>;
-			interrupts = <SOC_PERIPHERAL_IRQ(42) IRQ_TYPE_LEVEL_HIGH>,
-				     <SOC_PERIPHERAL_IRQ(43) IRQ_TYPE_LEVEL_HIGH>,
-				     <SOC_PERIPHERAL_IRQ(44) IRQ_TYPE_LEVEL_HIGH>,
-				     <SOC_PERIPHERAL_IRQ(45) IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "lpm_int", "ca55stbydone_int",
-					  "cm33stbyr_int", "ca55_deny";
 			status = "disabled";
 		};
 
@@ -608,16 +574,6 @@ dmac: dma-controller@11820000 {
 			dma-channels = <16>;
 		};
 
-		gic: interrupt-controller@11900000 {
-			compatible = "arm,gic-v3";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x0 0x11900000 0 0x40000>,
-			      <0x0 0x11940000 0 0x60000>;
-			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
-		};
-
 		sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g043",
 				     "renesas,rcar-gen3-sdhi";
@@ -883,12 +839,4 @@ target: trip-point {
 			};
 		};
 	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 96f935bc2d4d..b8bf06b51235 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -10,3 +10,63 @@
 #define SOC_PERIPHERAL_IRQ(nr)		GIC_SPI nr
 
 #include "r9a07g043.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a55";
+			reg = <0>;
+			device_type = "cpu";
+			#cooling-cells = <2>;
+			next-level-cache = <&L3_CA55>;
+			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		L3_CA55: cache-controller-0 {
+			compatible = "cache";
+			cache-unified;
+			cache-size = <0x40000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
+
+&soc {
+	interrupt-parent = <&gic>;
+
+	gic: interrupt-controller@11900000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x0 0x11900000 0 0x40000>,
+		      <0x0 0x11940000 0 0x60000>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&sysc {
+	interrupts = <SOC_PERIPHERAL_IRQ(42) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(43) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(44) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(45) IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "lpm_int", "ca55stbydone_int",
+			  "cm33stbyr_int", "ca55_deny";
+};
-- 
2.25.1

