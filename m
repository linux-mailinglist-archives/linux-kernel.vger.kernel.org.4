Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4C61189C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJ1RAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJ1Q76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:59:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF9213FA3;
        Fri, 28 Oct 2022 09:59:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y16so7379401wrt.12;
        Fri, 28 Oct 2022 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uwam57UrMly/7fzbCijndaabO19arvpUZgXGPs6USsk=;
        b=j3dE9iFZN3Q4xHL4MBNM8nTSfEpFB1Jd797KVcPXCUEbjqQv7rSf7t7uxd4Ozl+Qs9
         4B/lh3AjjZBXDs7JFchaMSVC/uS0oK36fuRi2jihGh2VY5s8QVGyZKX/0p7GQAIbpnRh
         lFSmHGTMWjeIyQQRPG/m45xIVo1fHR0cQS1BqJlJN4TmD6E7y78I2TyvVVz+RJMnPRgJ
         IMR9xHqmGSka2GeRcD85UaooRbjP56w3/jiSDG7MVixTxurH9au3BiRqEOter2XWUZA0
         QV13yHKvXniFfJLJwhL+MtzA5SWhiQnkQ13h5Y00lHIRAa9zw5+qoJRTlZt6jphZVsYL
         aESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uwam57UrMly/7fzbCijndaabO19arvpUZgXGPs6USsk=;
        b=2GsXoqHYWJ515GM2e7NPen0+HflUPrq645kHhleXWLOtXhuxdDFd1ehHhv89AYIcss
         pzocTkAlyy5gyPXWpyYAKbaE2h/b22PL32BgRN46f5UHWPRs+p+Tvw85FPxu4K2UYpp/
         RDOs36+D/pUcf6VGFk8n6QhIGEkKRAxaRNMpOa8Kb+wgK3D4dHR1RuUjAQYbn4Ub2C75
         kisl67mafZX67eeltkUoRA77/coJxjtYuzOLPcSWlQlEpVILZvVszBrOOpBLwtpKdS20
         Ebu2inhNXMZT3DaBfRRoR7PqkG/K+G1f2LqP4tsqyBgTguz80J/UqfBTu0BezPwqXazF
         pDsw==
X-Gm-Message-State: ACrzQf18EEGK3KpW6sN8t9rUqdhF7Yjp3D+q6xt0z3CHMyOuhkvTdnZI
        9rsrjtpIvxgbjGHp2cVMT/8=
X-Google-Smtp-Source: AMsMyM7DbSNI8CI2EApbdew+7+EcO6kav041DN522vtQ5/WtL6WLKYHE2a8xK22QDtxwBjo8WqYHwA==
X-Received: by 2002:a5d:47aa:0:b0:236:79cc:6d5f with SMTP id 10-20020a5d47aa000000b0023679cc6d5fmr176258wrb.391.1666976375559;
        Fri, 28 Oct 2022 09:59:35 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d53b:eaf9:15f:6a8a])
        by smtp.gmail.com with ESMTPSA id h2-20020adfe982000000b002322bff5b3bsm4939689wrm.54.2022.10.28.09.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:59:34 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 4/7] riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
Date:   Fri, 28 Oct 2022 17:59:18 +0100
Message-Id: <20221028165921.94487-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

RZ/Five SoC is almost identical to RZ/G2UL Type-1 SoC (ARM64) hence we
will be reusing r9a07g043.dtsi [0] as a base DTSI for both the SoC's.
r9a07g043f.dtsi includes RZ/Five SoC specific blocks.

Below are the RZ/Five SoC specific blocks added in the initial DTSI which
can be used to boot via initramfs on RZ/Five SMARC EVK:
- AX45MP CPU
- PLIC

[0] arch/arm64/boot/dts/renesas/r9a07g043.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4 -> v5
* Fixed riscv,ndev value (should be 511)
* Reworked completely (sort of new patch)

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
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 57 +++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
new file mode 100644
index 000000000000..50134be548f5
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/Five SoC
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#define SOC_PERIPHERAL_IRQ(nr)	(nr + 32)
+
+#include <arm64/renesas/r9a07g043.dtsi>
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <12000000>;
+
+		cpu0: cpu@0 {
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
+};
+
+&soc {
+	interrupt-parent = <&plic>;
+
+	plic: interrupt-controller@12c00000 {
+		compatible = "renesas,r9a07g043-plic", "andestech,nceplic100";
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		riscv,ndev = <511>;
+		interrupt-controller;
+		reg = <0x0 0x12c00000 0 0x400000>;
+		clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
+		power-domains = <&cpg>;
+		resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
+		interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9>;
+	};
+};
-- 
2.25.1

