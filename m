Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3EA6C4B31
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCVM5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCVM5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:57:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C75DC94;
        Wed, 22 Mar 2023 05:57:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h17so16955581wrt.8;
        Wed, 22 Mar 2023 05:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679489820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UETI/o1VyrzdJ5JktzswARWiINVYl7e4LvF4s43JmGU=;
        b=FF1sP46E++GE8R+JZt5Xd7n8/SIz15OCSqly/mfs2V9LvpQIB00GdQkZoWqHOX79Xb
         8WFU49Zi1TE22S4P/Ko2v+ZCa8IOjkWFOMwDnhjJ87eowD1ufeQi3TOE2Hy3rKaQYCMP
         moRPyI5m+qXrMkKBGJTq/efREsiTWK2ka3ybopAa3QtjoA7IRm5m9VoGsyN0oLg4+vum
         moQqK9GozuYUGE2k1AalngBJdB4MLb6CYc5mAeqet7Wg+mWLW/9zdcUN1v13JZ/FZOAp
         cHyLnXdfcAPOwIfF2Ljtmrp1k8V433GYjbCiyCEbNJJM2PobIR22DjU0YfjBncesZ/jX
         JNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UETI/o1VyrzdJ5JktzswARWiINVYl7e4LvF4s43JmGU=;
        b=ahY5+N8GCzLcdmjuWtQIve8Ije4/7l3Tp6R9txY1KHENQvrS2LPBS6SmUV9R9sW9ji
         i3d+JVQUwsL78jl18K4hbPRslI/xKz1kOaB9oSWbtx+IkPsGq2egQSz+o1VAT+/Egnut
         AXK08stazzhVdLeSHOM84PDeW3zbK2xD8H4Bc4K5/uDLxjufMvcfKTrlYNs/lA77B3c6
         MueebxGwn+GBAfv9wV9r6f6fKmLRhHUTWgm+iocnUI4wH2iRJCPXfOB+Casatw1oQWFr
         VJJqReDGoKXKDNTU8Gtdx7PgCrSFDol/2pERI+cPDvUGB2OHZ7SowMSSnU4RKcRrIhLS
         AhYg==
X-Gm-Message-State: AO0yUKVImZL9W7xT/8OhXIzo+Sc0UiI3U4MJiwKoA+Vk7zQi0QEeS5O0
        jNnOAUJmc6qPM1QU0zZtmk0=
X-Google-Smtp-Source: AK7set9fSDfwN5Ckv5IXNHoV2kIockWCUGHD0+QFOgBhjd9v0wpQJZBvaTKHkYRnZhw9OizDLcdXnA==
X-Received: by 2002:a5d:55cb:0:b0:2ce:c982:5e4b with SMTP id i11-20020a5d55cb000000b002cec9825e4bmr4926194wrw.57.1679489819752;
        Wed, 22 Mar 2023 05:56:59 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:9c35:3f3f:458c:5fef])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000181700b002c5694aef92sm13707167wrh.21.2023.03.22.05.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:56:58 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 2/2] arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support
Date:   Wed, 22 Mar 2023 12:56:48 +0000
Message-Id: <20230322125648.24948-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322125648.24948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230322125648.24948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable CRU, CSI on RZ/G2L SMARC EVK and tie the CSI to OV5645 sensor
using Device Tree overlay. rz-smarc-cru-csi-ov5645.dtsi is created so
that RZ/G2L alike EVKs can make use of it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
setenv bootfile kernel_fdt.itb
tftpboot ${bootfile}
bootm ${fileaddr}#rzg2l-smarc#ov5645

v2->v3
* Moved the gpio.h and rzg2l-pinctrl.h headers to
  r9a07g044l2-smarc-cru-csi-ov5645.dtso

v1->v2
* New patch
---
 arch/arm64/boot/dts/renesas/Makefile          |  1 +
 .../r9a07g044l2-smarc-cru-csi-ov5645.dtso     | 21 +++++
 .../dts/renesas/rz-smarc-cru-csi-ov5645.dtsi  | 80 +++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 23b10c03091c..a553d99175cb 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_R9A07G043) += r9a07g043u11-smarc.dtb
 
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
+dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc-cru-csi-ov5645.dtbo
 
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso
new file mode 100644
index 000000000000..d834bff9bda2
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree overlay for the RZ/G2L SMARC EVK with OV5645 camera
+ * connected to CSI and CRU enabled.
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+#define OV5645_PARENT_I2C i2c0
+#include "rz-smarc-cru-csi-ov5645.dtsi"
+
+&ov5645 {
+	enable-gpios = <&pinctrl RZG2L_GPIO(2, 0) GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pinctrl RZG2L_GPIO(40, 2) GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi b/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
new file mode 100644
index 000000000000..6efa8958bc36
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common Device Tree for the RZ/G2L SMARC EVK (and alike EVKs) with
+ * OV5645 camera connected to CSI and CRU enabled.
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+&{/} {
+	ov5645_vdddo_1v8: 1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdddo";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	ov5645_vdda_2v8: 2p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdda";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+
+	ov5645_vddd_1v5: 1p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vddd";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+	};
+
+	ov5645_fixed_clk: osc25250_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+};
+
+&cru {
+	status = "okay";
+};
+
+&csi2 {
+	status = "okay";
+
+	ports {
+		port@0 {
+			csi2_in: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+				remote-endpoint = <&ov5645_ep>;
+			};
+		};
+	};
+};
+
+&OV5645_PARENT_I2C {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ov5645: camera@3c {
+		compatible = "ovti,ov5645";
+		reg = <0x3c>;
+		clocks = <&ov5645_fixed_clk>;
+		clock-frequency = <24000000>;
+		vdddo-supply = <&ov5645_vdddo_1v8>;
+		vdda-supply = <&ov5645_vdda_2v8>;
+		vddd-supply = <&ov5645_vddd_1v5>;
+
+		port {
+			ov5645_ep: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+				remote-endpoint = <&csi2_in>;
+			};
+		};
+	};
+};
-- 
2.25.1

