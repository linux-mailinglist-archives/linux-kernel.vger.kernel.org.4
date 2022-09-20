Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384B25BED23
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiITSu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiITSuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:50:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BFD606A6;
        Tue, 20 Sep 2022 11:50:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n12so5906479wrx.9;
        Tue, 20 Sep 2022 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/czCMHsS4vvXvkOouApY9xijO1GWSVmIcmtJMgUaxJs=;
        b=DSrA5MSKP7QNxVSvySg6B5TdyGFsncWvZ3Cq3Qf3fvO84vzUiGQn58JQm+uHwGHg1c
         m9H07XS18aVmy3FzpeoUz2NNVcoIhBUHl/bXKM8vsuLJwZKNmYX3/2axyHYnTsWxB7An
         qvAjTd+mCTEtEmZJzeDHnfTfsdDs80OUBUydZe9Yt7YAbjWsY2mHVfRV2fCjpAt5INth
         MEs216TOBDJhFOK4AwM4CzM5qeQ3ARuN8PP9dDN2QaiBVkoO/Sh01uh6FnOdZxie6We5
         u14AsVyz8Klhgo4Y2Jotz50GOS5cgzi3nMc3PyyqgV4X4+mltPMpySmgj+agG5ag1S4V
         BLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/czCMHsS4vvXvkOouApY9xijO1GWSVmIcmtJMgUaxJs=;
        b=SPiLqeVE30TeOP6+hwNiq5XQMCrvf5jktkrfbd/JxJZgDqy5JKM5rCIOvlJEKOLea3
         EWAn2Q48BdE7xzuuAodVeQGlHbrpqZsBIHF+6nhRmLSLmvq6+Uo4ALiTlQwKH/RE87UV
         UxJCVOfpe1PrAH209eij0IadmJ/UiuWW9z/AHLFRS2pZqsvn2yGMcNWO23pXRDjTBNSx
         nvta7grNiGPvuaCgXEewWmBmKNqJqiaDJavc4raIqq4lQ4eCrBhPHZKiT3Q7SSjSttp7
         rPhgZBeM2pLCYsA6So3Td6L5s+9bFj3d5aUlUlv7oehk3LWwkcLVuYvOOLo2mycw0p4L
         +1Tw==
X-Gm-Message-State: ACrzQf3tBRz7azBXbRe4NTio46ihuC2gXN/HYOiEs3A5h2/yFT/ZMQmN
        QC5+vOYJx3H3pBgMaOHUgvo=
X-Google-Smtp-Source: AMsMyM6TIUnRVx7XB2qJ2mmjne6k5QKjIga4gmXbwECy51kPgyQH/B33V3OT4aPEiMRcsEDn/wfQLA==
X-Received: by 2002:a5d:5010:0:b0:22a:4247:3be4 with SMTP id e16-20020a5d5010000000b0022a42473be4mr15707462wrt.270.1663699814810;
        Tue, 20 Sep 2022 11:50:14 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e9a4:d6c9:505d:20d0])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b00228de351fc0sm582722wrb.38.2022.09.20.11.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:50:14 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 06/10] riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
Date:   Tue, 20 Sep 2022 19:49:00 +0100
Message-Id: <20220920184904.90495-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
Single).

Below is the list of IP blocks added in the initial SoC DTSI which can be
used to boot via initramfs on RZ/Five SMARC EVK:
- AX45MP CPU
- CPG
- PINCTRL
- PLIC
- SCIF0
- SYSC

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v3 -> v4
* No change

v2 -> v3
* Fixed clock entry for CPU core
* Fixed timebase frequency to 12MHz
* Fixed sorting of the nodes
* Included RB tags

v1 -> v2
* Dropped including makefile change
* Updated ndev count
---
 arch/riscv/boot/dts/renesas/r9a07g043.dtsi | 120 +++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043.dtsi

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
new file mode 100644
index 000000000000..fb6733f3cc2b
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/Five SoC
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/r9a07g043-cpg.h>
+
+/ {
+	compatible = "renesas,r9a07g043";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <12000000>;
+
+		ax45mp: cpu@0 {
+			compatible = "andestech,ax45mp", "riscv";
+			device_type = "cpu";
+			reg = <0x0>;
+			status = "okay";
+			riscv,isa = "rv64imafdc";
+			mmu-type = "riscv,sv39";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <0x40>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <0x40>;
+			clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
+
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+	};
+
+	/* clock can be either from exclk or crystal oscillator (XIN/XOUT) */
+	extal_clk: extal-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scif0: serial@1004b800 {
+			compatible = "renesas,scif-r9a07g043",
+				     "renesas,scif-r9a07g044";
+			reg = <0 0x1004b800 0 0x400>;
+			interrupts = <412 IRQ_TYPE_LEVEL_HIGH>,
+				     <414 IRQ_TYPE_LEVEL_HIGH>,
+				     <415 IRQ_TYPE_LEVEL_HIGH>,
+				     <413 IRQ_TYPE_LEVEL_HIGH>,
+				     <416 IRQ_TYPE_LEVEL_HIGH>,
+				     <416 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A07G043_SCIF0_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G043_SCIF0_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		cpg: clock-controller@11010000 {
+			compatible = "renesas,r9a07g043-cpg";
+			reg = <0 0x11010000 0 0x10000>;
+			clocks = <&extal_clk>;
+			clock-names = "extal";
+			#clock-cells = <2>;
+			#reset-cells = <1>;
+			#power-domain-cells = <0>;
+		};
+
+		sysc: system-controller@11020000 {
+			compatible = "renesas,r9a07g043-sysc";
+			reg = <0 0x11020000 0 0x10000>;
+			status = "disabled";
+		};
+
+		pinctrl: pinctrl@11030000 {
+			compatible = "renesas,r9a07g043-pinctrl";
+			reg = <0 0x11030000 0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			gpio-ranges = <&pinctrl 0 0 152>;
+			clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G043_GPIO_RSTN>,
+				 <&cpg R9A07G043_GPIO_PORT_RESETN>,
+				 <&cpg R9A07G043_GPIO_SPARE_RESETN>;
+		};
+
+		plic: interrupt-controller@12c00000 {
+			compatible = "renesas,r9a07g043-plic", "andestech,nceplic100";
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			riscv,ndev = <512>;
+			interrupt-controller;
+			reg = <0x0 0x12c00000 0 0x400000>;
+			clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
+			interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9>;
+		};
+	};
+};
-- 
2.25.1

