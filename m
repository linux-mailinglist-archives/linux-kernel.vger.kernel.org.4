Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278995E5FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiIVKWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiIVKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:22:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E434D8252;
        Thu, 22 Sep 2022 03:22:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so1758497pjq.3;
        Thu, 22 Sep 2022 03:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=BxGtjVSVOQEaUvbPCB6HQ9jLP3jtcPyILTDdc43OmbM=;
        b=fnR0N5ur7q/5engT3fG/AWa90woUZXIMuZx9/U+InCbx8ve65ape5wgfBXGnVgVt6V
         r841nm1RD2fTZ5t3fDYodimP5jMHbArPJeTxAWGfMIXiTDPUHkmPMFruPlRPVbqO1P76
         /yQeNLpkeD8M9M+z8fPLqd8R3A+6mALUhfalngCkS3MqzZuWcSdcXzyLOnJyf59HUizS
         Gxo/st5FYcfUBt+LJ45n7ctfB1Yrr61ADMwTGB1pQkJPyJf8N1RDGIO22dF73fKGeHtC
         maPznFop2Sd6iSpqIbQDxgCTQ2I4Nph/7qsjPRIsexP8NPQYQ7dL090ij86naGvxLD7t
         9xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BxGtjVSVOQEaUvbPCB6HQ9jLP3jtcPyILTDdc43OmbM=;
        b=eS8TXx4FxB3uWDWaPK0QGTxDFlBFgw052EcuWLlYifec1YLuH07wlPtaOaIDBea3+x
         jYL0bRq8sL6TlJuAamiV3LE8u4uIytNL7bKS/+TVmbUEGVPN+Q1xAelToM+5ui7qpoxi
         86eyKdaTRZ3sFHBsqO4LTxA35wj23q61T5zIlCZuQB3IFPhdsrhRzz3Y130u3Y7+LdAP
         mr4k4y/VlZPQ0zK+77DVclKa0TjWE2sYkUv/duMxfpGGZFJG+fQl4UDinJl4rhJKkRny
         mumWg53TRybjrpyKTD2Vp93HPo/ihn9Ifg67uskhTBRmDYO5vDW98HOlvaQ1a7tBPHGq
         +6aA==
X-Gm-Message-State: ACrzQf1cDy+19a50MGD3w/chHIq7lG7TvAdazWE+GJDfHxObZEdto684
        mT0Y9Pc/dVZReY8zfUqClAOIwdWr2Z8=
X-Google-Smtp-Source: AMsMyM5QVXH0UquS5+QJWHQh2EDmYetuyZE9xxpqDmcwsPlJ9+osF6os57tpMBZvC1i8lwrnsazE0w==
X-Received: by 2002:a17:902:b415:b0:178:2835:29e7 with SMTP id x21-20020a170902b41500b00178283529e7mr2682986plr.86.1663842149527;
        Thu, 22 Sep 2022 03:22:29 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id v16-20020a63f210000000b0042a713dd68csm3422050pgh.53.2022.09.22.03.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:22:28 -0700 (PDT)
From:   Yunlong Jia <ecs.beijing2022@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 2/4] arm64: dts: qcom: Add sc7180-pazquel360
Date:   Thu, 22 Sep 2022 10:21:18 +0000
Message-Id: <20220922101813.v4.2.Iea2d2918adfff2825b87d428b5732717425c196f@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
References: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create first version device tree for pazquel360
pazquel360 is convertible and the pazquel it is based on is clamshell.
sku 20 for lte & wifi
sku 21 for wifi only
sku 22 for lte w/o esim & wifi

Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v4:
 1. Adjust the 'Signed-off-by'.
 2. Add touchscreen setting in dtsi.

Changes in v2:
 1. Remove the touchscreen setting, as a follow-up patch

 arch/arm64/boot/dts/qcom/Makefile             |  2 +
 .../qcom/sc7180-trogdor-pazquel360-lte.dts    | 22 ++++++
 .../qcom/sc7180-trogdor-pazquel360-wifi.dts   | 17 +++++
 .../dts/qcom/sc7180-trogdor-pazquel360.dtsi   | 71 +++++++++++++++++++
 4 files changed, 112 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d8192a2eaa754..65cb0f714ed6b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -76,6 +76,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-parade.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-ti.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-parade.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-ti.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel360-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel360-wifi.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dts
new file mode 100644
index 0000000000000..021bcafcf8154
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-pazquel360.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Pazquel (Parade,LTE)";
+	compatible = "google,pazquel-sku22", "google,pazquel-sku20", "qcom,sc7180";
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dts
new file mode 100644
index 0000000000000..defd84c5354a0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-pazquel360.dtsi"
+
+/ {
+	model = "Google Pazquel (Parade,WIFI-only)";
+	compatible = "google,pazquel-sku21", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
new file mode 100644
index 0000000000000..54b89def84020
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/* This file must be included after sc7180-trogdor.dtsi */
+#include "sc7180-trogdor-pazquel.dtsi"
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+ap_ts_pen_1v8: &i2c4 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@10 {
+		compatible = "elan,ekth3915", "elan,ekth3500";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+		hid-descr-addr = <0x0001>;
+
+		vcc33-supply = <&pp3300_ts>;
+		vccio-supply = <&pp1800_l10a>;
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
+		MATRIX_KEY(0x03, 0x09, 0)       /* T11 */
+	>;
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+		MATRIX_KEY(0x03, 0x09, KEY_SLEEP)
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
-- 
2.17.1

