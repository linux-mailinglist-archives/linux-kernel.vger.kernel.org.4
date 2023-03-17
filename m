Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6C6BE95A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCQMeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCQMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:34:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E67CC37;
        Fri, 17 Mar 2023 05:33:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso3223050wmo.0;
        Fri, 17 Mar 2023 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679056410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjv5+PrqXIvURLUwrYK99nDGIhWRuR6pNFnPWF4wxiI=;
        b=pbq6ZSdR5nIJ5secaZFI6sBee3J/JDWHO/lvytKXVsCeITaXjYWtt+t0MkrWZ3iedo
         T9tKUfefMrXI3w1xGDD9U1ynjXMApbUXrK+Fsdrs6sUls4W0g/VCWVfkzSwXyv9u9nsY
         GVPhUOQ5tNAtGJodPWFWdUrGZSQt3b83uqJi8let1fcM4ny9sbp98WjviMfTXc2/lGhP
         tU7wlzYtN2VLezg2e2eSIuR5676SnuAmeEV+0jRj5NFivwgBjZpMLRZDKZ8agRTaZVLR
         jMSv+V4V2DuZCEBgFALXw/WTR9Ox45xPjQ1U4bQG13iCpVUCMGPuL33cb36ypy2tgFix
         w+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679056410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjv5+PrqXIvURLUwrYK99nDGIhWRuR6pNFnPWF4wxiI=;
        b=s+NIdB+HM35p8sL7hmCgyxb3Xk1m/o2HgnNvQmdL+vUOxAp0+k4wS3QRNdx9MuZPN/
         snrkVG3XKx0j23LQQjkGGsdyTU0bmI5xLvBZwfvbkf77RddWFXMsOOQ7pvkJKMkPrf4J
         8lrGGb9lwSZ+BwnKxFXzH5rhNd/AoSgqcb17FLgboqOVeYr9ah4kL1Fy4cMU6CIXFPXU
         3YoRERvtAUDJIBC6JOtByCGSTwhUHj1lRUIKCKx/hvI1CV15ynk6IgKcSnu96VMKEDZ5
         U9TWzI+Es49gPXTno0mj0cj3Jlyf7CQBFNqQ1oIAn+ACK5FsiB8RR2XfduJtIyHbAzJJ
         876Q==
X-Gm-Message-State: AO0yUKVZMsYQq44FSqp/rGO1h/K9NXtwC10WQa52RWpXaTeFm8iN/WeV
        a8286Aqqc+HoUEMHIEbDBZ0=
X-Google-Smtp-Source: AK7set9hdWTVaCX8MlH6PFGqjP0Nh+FiR/SUaH1b6OLEkubj7+mS425PcGjwWynqyiDgRVdNx5vttA==
X-Received: by 2002:a05:600c:310d:b0:3eb:3945:d405 with SMTP id g13-20020a05600c310d00b003eb3945d405mr23817708wmo.38.1679056410405;
        Fri, 17 Mar 2023 05:33:30 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:cc60:8c15:c868:fa91])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d464a000000b002cea8f07813sm1876515wrs.81.2023.03.17.05.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 05:33:29 -0700 (PDT)
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
Subject: [PATCH v2 2/2] arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support
Date:   Fri, 17 Mar 2023 12:33:14 +0000
Message-Id: <20230317123314.145121-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317123314.145121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230317123314.145121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable CRU, CSI on RZ/G2L SMARC EVK and tie the CSI to OV5645 sensor
using Device Tree overlay. rz-smarc-cru-csi-ov5645.dtsi is created so
that RZ/G2L alike EVKs can make use of it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
setenv bootfile kernel_fdt.itb
tftpboot ${bootfile}
bootm ${fileaddr}#rzg2l-smarc#ov5645

v1->v2
* New patch
---
 arch/arm64/boot/dts/renesas/Makefile          |  1 +
 .../r9a07g044l2-smarc-cru-csi-ov5645.dtso     | 18 ++++
 .../dts/renesas/rz-smarc-cru-csi-ov5645.dtsi  | 87 +++++++++++++++++++
 3 files changed, 106 insertions(+)
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
index 000000000000..40cece1491bb
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso
@@ -0,0 +1,18 @@
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
+#define OV5645_PARENT_I2C i2c0
+#include "rz-smarc-cru-csi-ov5645.dtsi"
+
+&ov5645 {
+	enable-gpios = <&pinctrl RZG2L_GPIO(2, 0) GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pinctrl RZG2L_GPIO(40, 2) GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi b/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
new file mode 100644
index 000000000000..95286bf2066e
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common Device Tree for the RZ/G2L SMARC EVK (and alike EVKs) with
+ * OV5645 camera connected to CSI and CRU enabled.
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
+	status = "okay";
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

