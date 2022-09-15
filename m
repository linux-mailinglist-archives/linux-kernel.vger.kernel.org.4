Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FAE5BA0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiIOSSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiIOSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:17:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30EC9F1AD;
        Thu, 15 Sep 2022 11:17:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so18218071wma.2;
        Thu, 15 Sep 2022 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9s/CP7W96ES5VqAZt40rb7ebkGJqwcyexra6FnDdBm4=;
        b=PE89wCmeFqwCzQWhhn3ZmWfNZ7rGskKL4Irvmk+xnBDWcvWjPrIy4Dz8pKOnBPvqDD
         64PQ8ARWVUXDEZGyVTVWAUNdiSNeaNlyxaQ81g/w6n5yPMpTOJTQXwHh4k9MZj3chUJh
         dp4TfPUfpk7gQaon4ZRdUQEUjFrbKnghNNDmlsK26M0cpUmwzpyxovzmuty5Vf7vOppb
         MwqmZNQvhoahP6azxLGLwKTxBj0vzrAU4fnuLZnpPbmyX1FcEBxRbFJMpVaKnCpSEEoQ
         p9Y1YsDCaMxBBTQr9rY351wHLhsICoiRUWSRo/jz34ysf4Ul6dxA0Cfml862k8aTbqDa
         A5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9s/CP7W96ES5VqAZt40rb7ebkGJqwcyexra6FnDdBm4=;
        b=eIWQmDMNXCFmIshm3Fl8llhT1vZCwqqQh5OtfEJECpEwqhnVpsTnzzbR0a9s5GXcD7
         Fn9hcONfOwfX+EC5P/u6v/WeHdxYSGvvJc0p4QmVqSpaZD8RlepYaU0pAULniVcsUXV2
         035nPJligS4WdRiRFhQWPcbmX7ph1Gco/sz060ZO0z3Ycfm7VYHre5neNXrMdtXdFV/S
         Z4xXOWVCVbbuzEJUNwoFcqLD8y4nUhl0zAhBr4JAWKZDTlWqoqxdas9aYc6G8sC2g7l+
         eizSTnzgGRm8kHZZanTgUm/lU4+Z90PhqIgTh3Fo/I8MT0TgkALTpfv+Y8LBUtzq5eCd
         9p/A==
X-Gm-Message-State: ACrzQf2nd7ASS+aWmz6b1K6+pW0IByW1jFOaN30SSdKn/zPvoXoTNP+q
        WEsL19FBF2XcDZlc8gN5qm8=
X-Google-Smtp-Source: AMsMyM70ZmPPYK+FQLW2Pf4DXNNy9eAb7VvwpOkcQhZ+RdDrJgsAsWS1BDFxditUJ6b+qJqHEoPqWw==
X-Received: by 2002:a7b:ce97:0:b0:3b3:4136:59fe with SMTP id q23-20020a7bce97000000b003b3413659femr812119wmj.24.1663265858196;
        Thu, 15 Sep 2022 11:17:38 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d411:a48b:4035:3d98])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm4243151wmq.23.2022.09.15.11.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:17:37 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 08/10] riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
Date:   Thu, 15 Sep 2022 19:15:56 +0100
Message-Id: <20220915181558.354737-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Below are the blocks enabled:
- CPG
- CPU0
- DDR (memory regions)
- PINCTRL
- PLIC
- SCIF0

Note we have deleted the nodes from the DT for which support needs to be
added for RZ/Five SoC and are enabled by RZ/G2UL SMARC EVK SoM/carrier
board DTS/I.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3
* Dropped RB tags from Conor and Geert
* Now re-using the SoM and carrier board DTS/I from RZ/G2UL

v1->v2
* New patch
---
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/renesas/Makefile          |  2 +
 .../boot/dts/renesas/r9a07g043f01-smarc.dts   | 27 +++++++++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 42 ++++++++++++++
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 56 +++++++++++++++++++
 5 files changed, 128 insertions(+)
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
index 000000000000..9747f30c5db5
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
+ * Please change below macros according to SW1 setting on SoM
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
index 000000000000..8547c273f140
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -0,0 +1,42 @@
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
+
+#if (SW_SW0_DEV_SEL)
+/delete-node/ &adc;
+#endif
+
+#if (!SW_ET0_EN_N)
+/delete-node/ &eth0;
+#endif
+/delete-node/ &eth1;
+
+/delete-node/ &ostm1;
+/delete-node/ &ostm2;
+
+/delete-node/ &reg_1p8v;
+/delete-node/ &reg_3p3v;
+
+/delete-node/ &sdhi0;
+
+#if !(SW_SW0_DEV_SEL)
+/delete-node/ &vccq_sdhi0;
+#endif
+
+/delete-node/ &wdt0;
diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
new file mode 100644
index 000000000000..3fde7192241e
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
@@ -0,0 +1,56 @@
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
+/delete-node/ &audio_clk1;
+/delete-node/ &audio_clk2;
+/delete-node/ &audio_mclock;
+
+/delete-node/ &canfd;
+
+/delete-node/ &cpu_dai;
+
+/delete-node/ &ehci0;
+/delete-node/ &ehci1;
+
+/delete-node/ &hsusb;
+
+/delete-node/ &i2c0;
+/delete-node/ &i2c1;
+
+/delete-node/ &ohci0;
+/delete-node/ &ohci1;
+
+&pinctrl {
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+};
+
+/delete-node/ &phyrst;
+
+/delete-node/ &sdhi1;
+
+/delete-node/ &snd_rzg2l;
+
+/delete-node/ &spi1;
+
+/delete-node/ &ssi1;
+
+/delete-node/ &usb0_vbus_otg;
+
+/delete-node/ &usb2_phy0;
+/delete-node/ &usb2_phy1;
+
+/delete-node/ &vccq_sdhi1;
-- 
2.25.1

