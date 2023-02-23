Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A169C6A0C44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjBWOyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjBWOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:54:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA80C4ECDE;
        Thu, 23 Feb 2023 06:54:37 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B5306602219;
        Thu, 23 Feb 2023 14:54:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677164076;
        bh=EMwmDgqiKXB9Dx2NxJ/NhHjgvpsexC8a5B3Qc0K2qvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KruIvXwfhBJ1KgQJ8MomBQ7ddTMRxdJFkotOKOZNKWW2puLevwEou1ipTyayhMYWD
         +RG5lQP49nVFlAmbJqLdHw6tddeqQx3O966PhIeYsTHtLsjONtLEKZCeuxstRVtlXl
         GgBxgCU107vCmvk288rcgohAJoP5oc5e0YcUYLCUiKlYVlY7gSMx7ip+WZraEazNIP
         fDumET3XZBY1J6PrGU0yI1d8nV2V1Bu3T/HsFrZIkGXrPpz05xc1uNMq/MNXHhGcOG
         e8hu3/KYlj9qvPWO+VqfTI97mkRag8BJuQty6SgdBhKI4f7QEXDE5lH7pjqlsJ9JPG
         9vItNLGbkzOkQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 4/4] arm64: dts: mediatek: cherry: Add configuration for display backlight
Date:   Thu, 23 Feb 2023 15:54:26 +0100
Message-Id: <20230223145426.193590-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com>
References: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the hardware PWM for the integrated display's backlight:
all Cherry devices enable the backlight with GPIO82 and manage the
PWM via MediaTek disp-pwm on GPIO97.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index d679a04207d8..c50f1e2914b2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -22,6 +22,16 @@ aliases {
 		serial0 = &uart0;
 	};
 
+	backlight_lcd0: backlight-lcd0 {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 1023>;
+		default-brightness-level = <576>;
+		enable-gpios = <&pio 82 GPIO_ACTIVE_HIGH>;
+		num-interpolated-steps = <1023>;
+		pwms = <&disp_pwm0 0 500000>;
+		power-supply = <&ppvar_sys>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -349,6 +359,13 @@ &auxadc {
 	status = "okay";
 };
 
+&disp_pwm0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&disp_pwm0_pin_default>;
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -773,6 +790,13 @@ pins-cmd-dat {
 		};
 	};
 
+	disp_pwm0_pin_default: disp-pwm0-default-pins {
+		pins-disp-pwm {
+			pinmux = <PINMUX_GPIO82__FUNC_GPIO82>,
+				 <PINMUX_GPIO97__FUNC_DISP_PWM0>;
+		};
+	};
+
 	i2c0_pins: i2c0-default-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
-- 
2.39.2

