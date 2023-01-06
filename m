Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F5165F883
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbjAFBEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjAFBDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:03:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7272C6E427;
        Thu,  5 Jan 2023 17:03:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D72B15DB;
        Thu,  5 Jan 2023 17:04:36 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C53793F23F;
        Thu,  5 Jan 2023 17:03:51 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        =?UTF-8?q?Andr=C3=A1s=20Szemz=C3=B6?= <szemzo.andras@gmail.com>,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: sunxi: add Allwinner T113-s SoC .dtsi
Date:   Fri,  6 Jan 2023 01:01:53 +0000
Message-Id: <20230106010155.26868-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.5
In-Reply-To: <20230106010155.26868-1-andre.przywara@arm.com>
References: <20230106010155.26868-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner T113-s SoC is apparently using the same (or at least a very
similar) die as the D1/D1s, but replaces the single RISC-V core with
two Arm Cortex-A7 cores.
Since the D1 core .dtsi already describes all common peripherals, we
just need a DT describing the ARM specific peripherals: the CPU cores,
the Generic Timer, the GIC and the PMU.
We include the core .dtsi directly from the riscv DT directory.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/sun8i-t113s.dtsi | 59 ++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-t113s.dtsi

diff --git a/arch/arm/boot/dts/sun8i-t113s.dtsi b/arch/arm/boot/dts/sun8i-t113s.dtsi
new file mode 100644
index 0000000000000..804aa197a24f8
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-t113s.dtsi
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Arm Ltd.
+
+#define SOC_PERIPHERAL_IRQ(nr) GIC_SPI nr
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <riscv/allwinner/sunxi-d1s-t113.dtsi>
+#include <riscv/allwinner/sunxi-d1-t113.dtsi>
+
+/ {
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <0>;
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <1>;
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
+		};
+	};
+
+	gic: interrupt-controller@1c81000 {
+		compatible = "arm,gic-400";
+		reg = <0x03021000 0x1000>,
+		      <0x03022000 0x2000>,
+		      <0x03024000 0x2000>,
+		      <0x03026000 0x2000>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+	};
+};
-- 
2.35.5

