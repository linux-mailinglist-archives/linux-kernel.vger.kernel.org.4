Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA65BED24
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiITSvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiITSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:50:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9256E73324;
        Tue, 20 Sep 2022 11:50:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e16so5946445wrx.7;
        Tue, 20 Sep 2022 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F+U+9HASUguzmpfByxESYZfGfsGDjGZtXWu/REnOsCQ=;
        b=ESlU9epRCwjyPg2ztR7HkfE2zfEgyPamoYmpwf7vOKaBiim8u/X6WAAC+4YbixzUDl
         5kK6wxK31KbQpKNtF0JeFSSIJTDCVBcZ4ab4mc9MeWUMH5KdlEi4cIfXYgOY/7PP/zng
         3icNWJqhaAy6Lagj98/ToMrcFomezGG65qjzqqFW9uU0VZOTr8tpFvHQvuvlh7LCJDkA
         H38FhTDNIepsTlQiJ0DPUh9UrI0l4Wv7EWIjVMcYdACqlL+SDKy0P3D7ABQLgoNdHN18
         amGTbLn8Yeiy1wqIHTqn3SjcZaKXPF/CDsXNMVoU1ShD/RaWCR3fCnb7QF1/fcpJPL07
         o0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F+U+9HASUguzmpfByxESYZfGfsGDjGZtXWu/REnOsCQ=;
        b=YwbRbmX14++z6FVSMuTQW+eQpjW/NIgS+lZnW2TIELr1gwSnljs+WwQ9qjN2npll08
         eaug3bhiAu8BlCu1kdeVFb80e5slZ2SVlT5vAsDe9+EMCyhPZoT2mSBdB3YH7kQ+fwPu
         Dgon2VOCYCoIX2GEnEdAPmdgieAwDCOr0pabz/tl9yNLxz1LNKZzrQtEytqnUTV9lVIj
         +QwoKg2ZWchOnBTRw03C3okNKwrbAD5M05OHrefeVOAT4FxnXgwU4SKT0alPOWnhGac+
         9aicrLICBUk+tUe5xa/mLOLVq8Ppwoo2cdjKfXqdZ4p0dSdL5WJaTwelRpTm5NpqSHdf
         ZYAg==
X-Gm-Message-State: ACrzQf1Zr9SFodraIAA1cEgiXiOSMzwRtTr2uCYDep1i9hEhgkvc+8kJ
        4iObKDoLohF9BFPGmu7C6y8=
X-Google-Smtp-Source: AMsMyM77sdmDghsP1AaELojjA0F+2fQ8A44Kw2NxNF6WmQ8SlfWAbvvhw4+5lAFZbPAL8lYFaOy4IA==
X-Received: by 2002:adf:b646:0:b0:221:76eb:b3ba with SMTP id i6-20020adfb646000000b0022176ebb3bamr14598334wre.237.1663699816962;
        Tue, 20 Sep 2022 11:50:16 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e9a4:d6c9:505d:20d0])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b00228de351fc0sm582722wrb.38.2022.09.20.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:50:16 -0700 (PDT)
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
Subject: [PATCH v4 08/10] riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
Date:   Tue, 20 Sep 2022 19:49:02 +0100
Message-Id: <20220920184904.90495-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable the minimal blocks required for booting the Renesas RZ/Five
SMARC EVK with initramfs.

Below are the which are enabled:
- CPG
- CPU0
- DDR (memory regions)
- PINCTRL
- PLIC
- SCIF0

As we are reusing the RZ/G2UL SMARC SoM [0] and carrier [1] board DTSIs
which enables almost all the blocks supported by the RZ/G2UL SoC and
whereas on RZ/Five SoC we will be gradually adding the blocks hence the
aliases for ETH and I2C are deleted as support for these blocks is not
yet enabled on RZ/Five SoC.

[0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
[1] arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
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
 arch/riscv/boot/dts/renesas/Makefile          |  2 ++
 .../boot/dts/renesas/r9a07g043f01-smarc.dts   | 27 +++++++++++++++++++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 19 +++++++++++++
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 15 +++++++++++
 5 files changed, 64 insertions(+)
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
index 000000000000..487d0d5e6d2e
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
+#include "r9a07g043.dtsi"
+#include "rzfive-smarc-som.dtsi"
+#include "rzfive-smarc.dtsi"
+
+/ {
+	model = "Renesas SMARC EVK based on r9a07g043f01";
+	compatible = "renesas,smarc-evk", "renesas,r9a07g043f01", "renesas,r9a07g043";
+};
diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
new file mode 100644
index 000000000000..d8168eb920ab
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -0,0 +1,19 @@
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
+};
diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
new file mode 100644
index 000000000000..6f44a6946897
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
@@ -0,0 +1,15 @@
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
-- 
2.25.1

