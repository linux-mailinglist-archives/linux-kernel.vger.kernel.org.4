Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453C765465A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiLVTHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLVTHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:07:17 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC01810FDE;
        Thu, 22 Dec 2022 11:07:15 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 9BC8220228;
        Thu, 22 Dec 2022 20:07:13 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845-tama: Add volume up and camera GPIO keys
Date:   Thu, 22 Dec 2022 20:06:56 +0100
Message-Id: <20221222190656.31664-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tama has four GPIO-wired keys: two for camera focus and shutter /
snapshot, and two more for volume up and down.  As per the comment these
used to not work because the necessary pin bias was missing, which is
now set via pinctrl on pm8998_gpio(s).

The missing bias has also been added to the existing volume down button,
which receives a node name and label cleanup at the same time to be more
consistent with other DTS and the newly added buttons.  Its deprecated
gpio-key,wakeup property has also been replaced with wakeup-source.

Note that volume up is also available through the usual PON RESIN node,
but unlike other platforms only triggers when the power button is held
down at the same time making it unsuitable to serve as KEY_VOLUMEUP.

Fixes: 30a7f99befc6 ("arm64: dts: qcom: Add support for SONY Xperia XZ2 / XZ2C / XZ3 (Tama platform)")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../dts/qcom/sdm845-sony-xperia-tama.dtsi     | 72 +++++++++++++++++--
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 87dd0fc36747..6390dadd5f82 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
 #include "pm8005.dtsi"
@@ -17,14 +18,43 @@ / {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		/* Neither Camera Focus, nor Camera Shutter seem to work... */
+		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &vol_up_n>;
+		pinctrl-names = "default";
 
-		key-vol-down {
-			label = "volume_down";
+		key-camera-focus {
+			label = "Camera Focus";
+			gpios = <&pm8998_gpio 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_CAMERA_FOCUS>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+
+		key-camera-snapshot {
+			label = "Camera Snapshot";
+			gpios = <&pm8998_gpio 7 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_CAMERA>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
 			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 			debounce-interval = <15>;
-			gpio-key,wakeup;
+			linux,can-disable;
+			wakeup-source;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
 		};
 	};
 
@@ -358,6 +388,40 @@ &i2c14 {
 	/* AMS TCS3490 RGB+IR color sensor @ 72 */
 };
 
+&pm8998_gpio {
+	focus_n: focus-n-state {
+		pins = "gpio2";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	vol_down_n: vol-down-n-state {
+		pins = "gpio5";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	vol_up_n: vol-up-n-state {
+		pins = "gpio6";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	snapshot_n: snapshot-n-state {
+		pins = "gpio7";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.39.0

