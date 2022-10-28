Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D561189D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJ1RAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiJ1Q76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:59:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FC21581E;
        Fri, 28 Oct 2022 09:59:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bs21so7416005wrb.4;
        Fri, 28 Oct 2022 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmXIzlpO0gFQLKDuK9Y+/vStvG2XBv+k8tbLnLpI/QU=;
        b=NNeyX4eVp+vD3a/v2WLr4fhdRD8jG/m93zesdzYW/JoOkn3VBrCW94/p72lptdYMhh
         LKUj/oW8weroIIvzbtFDeZe7FEus8A7G+nLmZXysMh5M5fv7NGR0Bj3dcJALYmE/MEkT
         a15f5ebGYTCQdRgCnCXsVxR+ui0ptyZ1BSy2GHn+e5oE0+e7gHAN1djT7qSjvfb4OsNi
         2DoOX0EwyzOyiVIZNukWieHX8ZLmv69zKEZL+rJCfUoQDbC6anCCwfRiFXhb9LDTkIPA
         79UNbrJ0l6fES+INQ87w/sl47BNeqF2ejMSVOI/iZu52byZQLycWBeRsrWTbBqhOxeZn
         UZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmXIzlpO0gFQLKDuK9Y+/vStvG2XBv+k8tbLnLpI/QU=;
        b=JhAZejqBa8hfmWc+xwQyRqS+8cFLt1gPLqN0yDFfRomtnIMw5fkiv/5tvs/za38IwQ
         L7GLpHm+dlR7JFVifAKtnaMIFcbSHGs6RdLs+T/OYmK1pwR5s9nm0h1o5dlrW7rtYgg9
         nS3LIPZgyWBveXxTa8bBwFu6//+nAiuBXfncNXWbalNiE0G5zCSZMjXJI2Ukg18+pPCq
         tRDYKP9gn7DAloHOIUuoQ8nW5/XoDTYx6Pc+LCIC4d92OVdIKk0IV0p5MwVJkDD2onco
         sSYbSzIdV5AaFlqEK20+HFoY/x0LyGNSLjntWYEu3sDqrTvmEKl5KwJC0y8+0Gj8qNJA
         AgOw==
X-Gm-Message-State: ACrzQf1wfw3B0d2ijsUseXds+yUwJUGe5OO1Bx85MhH0mjFi15ws4gW8
        PbX0AlutcTSv4dmhojswkEs=
X-Google-Smtp-Source: AMsMyM4/d88zQ1rwA6shjvVG+I66Pv7iM990INblpkrcBN+AWGv0ngiDLIidPv35QgwBU7z9lCldlg==
X-Received: by 2002:a05:6000:1863:b0:22e:6946:be33 with SMTP id d3-20020a056000186300b0022e6946be33mr182553wri.630.1666976376943;
        Fri, 28 Oct 2022 09:59:36 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d53b:eaf9:15f:6a8a])
        by smtp.gmail.com with ESMTPSA id h2-20020adfe982000000b002322bff5b3bsm4939689wrm.54.2022.10.28.09.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:59:36 -0700 (PDT)
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
Subject: [PATCH v5 5/7] riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
Date:   Fri, 28 Oct 2022 17:59:19 +0100
Message-Id: <20221028165921.94487-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable the minimal blocks required for booting the Renesas RZ/Five
SMARC EVK with initramfs.

Below are the blocks which are enabled:
- CPG
- CPU0
- DDR (memory regions)
- PINCTRL
- PLIC
- SCIF0

As we are reusing the RZ/G2UL SoC base DTSI [0], RZ/G2UL SMARC SoM [1] and
carrier [2] board DTSIs which enables almost all the blocks supported
by the RZ/G2UL SMARC EVK and whereas on RZ/Five SoC we will be gradually
enabling the blocks hence the aliases for ETH/I2C are deleted and rest
of the IP blocks are marked as disabled/deleted.

[0] arch/arm64/boot/dts/renesas/r9a07g043.dtsi
[1] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
[2] arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4 -> v5
* Reworked completely (sort of new patch)

v3 -> v4
* Dropped deleting place holder nodes
* Updated SW1 settings comment
* Update commit message

v2 -> v3
* Dropped RB tags from Conor and Geert
* Now re-using the SoM and carrier board DTS/I from RZ/G2UL

v1 -> v2
* New patch
---
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/renesas/Makefile          |  2 +
 .../boot/dts/renesas/r9a07g043f01-smarc.dts   | 27 ++++++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 58 ++++++++++++
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 91 +++++++++++++++++++
 5 files changed, 179 insertions(+)
 create mode 100644 arch/riscv/boot/dts/renesas/Makefile
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
 create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
 create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index ff174996cdfd..b0ff5fbabb0c 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -3,5 +3,6 @@ subdir-y += sifive
 subdir-y += starfive
 subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
 subdir-y += microchip
+subdir-y += renesas
 
 obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
diff --git a/arch/riscv/boot/dts/renesas/Makefile b/arch/riscv/boot/dts/renesas/Makefile
new file mode 100644
index 000000000000..2d3f5751a649
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_R9A07G043) += r9a07g043f01-smarc.dtb
diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts b/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
new file mode 100644
index 000000000000..2aa8515451d3
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/Five SMARC EVK
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+
+/*
+ * DIP-Switch SW1 setting
+ * 1 : High; 0: Low
+ * SW1-2 : SW_SD0_DEV_SEL	(0: uSD; 1: eMMC)
+ * SW1-3 : SW_ET0_EN_N		(0: ETHER0; 1: CAN0, CAN1, SSI1, RSPI1)
+ * Please change below macros according to SW1 setting on the SoM
+ */
+#define SW_SW0_DEV_SEL	1
+#define SW_ET0_EN_N	1
+
+#include "r9a07g043f.dtsi"
+#include "rzfive-smarc-som.dtsi"
+#include "rzfive-smarc.dtsi"
+
+/ {
+	model = "Renesas SMARC EVK based on r9a07g043f01";
+	compatible = "renesas,smarc-evk", "renesas,r9a07g043f01", "renesas,r9a07g043";
+};
diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
new file mode 100644
index 000000000000..45a182fa3b4b
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/Five SMARC EVK SOM
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <arm64/renesas/rzg2ul-smarc-som.dtsi>
+
+/ {
+	aliases {
+		/delete-property/ ethernet0;
+		/delete-property/ ethernet1;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+	};
+
+	/delete-node/opp-table-0;
+	/delete-node/thermal-zones;
+};
+
+&adc {
+	status = "disabled";
+};
+
+&dmac {
+	status = "disabled";
+};
+
+&eth0 {
+	status = "disabled";
+};
+
+&eth1 {
+	status = "disabled";
+};
+
+&ostm1 {
+	status = "disabled";
+};
+
+&ostm2 {
+	status = "disabled";
+};
+
+&sdhi0 {
+	status = "disabled";
+};
+
+&tsu {
+	status = "disabled";
+};
+
+&wdt0 {
+	status = "disabled";
+};
diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
new file mode 100644
index 000000000000..e64f0e5f8e30
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/Five SMARC EVK carrier board
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <arm64/renesas/rzg2ul-smarc.dtsi>
+
+/ {
+	aliases {
+		/delete-property/ i2c0;
+		/delete-property/ i2c1;
+	};
+};
+
+&canfd {
+	status = "disabled";
+
+	channel0 {
+		status = "disabled";
+	};
+
+	channel1 {
+		status = "disabled";
+	};
+};
+
+&ehci0 {
+	status = "disabled";
+};
+
+&ehci1 {
+	status = "disabled";
+};
+
+&hsusb {
+	status = "disabled";
+};
+
+&i2c0 {
+	status = "disabled";
+};
+
+&i2c1 {
+	status = "disabled";
+};
+
+&ohci0 {
+	status = "disabled";
+};
+
+&ohci1 {
+	status = "disabled";
+};
+
+&phyrst {
+	status = "disabled";
+};
+
+&sdhi1 {
+	status = "disabled";
+};
+
+&snd_rzg2l {
+	status = "disabled";
+};
+
+&spi1 {
+	status = "disabled";
+};
+
+&ssi1 {
+	status = "disabled";
+};
+
+&usb0_vbus_otg {
+	status = "disabled";
+};
+
+&usb2_phy0 {
+	status = "disabled";
+};
+
+&usb2_phy1 {
+	status = "disabled";
+};
+
+&vccq_sdhi1 {
+	status = "disabled";
+};
-- 
2.25.1

