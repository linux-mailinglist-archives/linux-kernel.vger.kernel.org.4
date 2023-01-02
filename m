Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149BA65AFF8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjABKve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjABKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:51:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F3D62EF;
        Mon,  2 Jan 2023 02:50:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9199060F2E;
        Mon,  2 Jan 2023 10:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C45C433B4;
        Mon,  2 Jan 2023 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672656651;
        bh=Nyqaf4bMK9dpEeEzGEV6JiYvRsVHPutFOLZwu11jQ2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ymvz2PV60CNcTI+Gcs/E6FuKXe0Yshdl7PycIGVyxCm3+pEqrIZRHCo3bDYcXHexm
         F7iv/3w/PRyBeSPumFOpIvLpjbuKNXIjum7BieLAfmTn+xJtxr/0K582Ht+IOrqXwd
         u32LHlAUxHuKVQciYqj2XwSFe8q3ovHipiFH9DEIxLURAzpvPFRzwYmujLxqbWcnsd
         KzReIfY0jP8j/GrDGoPx69YyHAKHOwMaqnpIMrkVebvnTxAWiKtJ+xXIIx4C6TVo74
         7LLMSeLtCgfZoPdRG1QC5jZfUKEIvzKuWD7mKLU4S8prQIoxpjMy/3p5IPieN1sU3u
         ndv+Chf/X1VIw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pCIPM-00026w-EE; Mon, 02 Jan 2023 11:51:08 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/6] arm64: dts: qcom: sc8280xp-x13s: fix wcd938x codec node
Date:   Mon,  2 Jan 2023 11:50:36 +0100
Message-Id: <20230102105038.8074-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230102105038.8074-1-johan+linaro@kernel.org>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wcd938x codec is not a memory-mapped device and does not belong
under the soc node.

Move the node to the root node to avoid DT validation failures.

While at it, clean up the node somewhat by adding newline separators,
reordering properties and renaming it 'audio-codec'.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 54 ++++++++++---------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 97ff74d5095e..ae67c11bfc22 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -21,6 +21,34 @@ / {
 	model = "Lenovo ThinkPad X13s";
 	compatible = "lenovo,thinkpad-x13s", "qcom,sc8280xp";
 
+	wcd938x: audio-codec {
+		compatible = "qcom,wcd9380-codec";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcd_default>;
+
+		reset-gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+
+		vdd-buck-supply = <&vreg_s10b>;
+		vdd-rxtx-supply = <&vreg_s10b>;
+		vdd-io-supply = <&vreg_s10b>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		#sound-dai-cells = <1>;
+
+		status = "disabled";
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pmc8280c_lpg 3 1000000>;
@@ -628,32 +656,6 @@ &remoteproc_nsp0 {
 	status = "okay";
 };
 
-&soc {
-	wcd938x: codec {
-		compatible = "qcom,wcd9380-codec";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wcd_default>;
-		reset-gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
-		#sound-dai-cells = <1>;
-
-		vdd-buck-supply = <&vreg_s10b>;
-		vdd-rxtx-supply = <&vreg_s10b>;
-		vdd-io-supply = <&vreg_s10b>;
-		vdd-mic-bias-supply = <&vreg_bob>;
-		qcom,micbias1-microvolt = <1800000>;
-		qcom,micbias2-microvolt = <1800000>;
-		qcom,micbias3-microvolt = <1800000>;
-		qcom,micbias4-microvolt = <1800000>;
-		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
-		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
-		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
-		qcom,rx-device = <&wcd_rx>;
-		qcom,tx-device = <&wcd_tx>;
-
-		status = "disabled";
-	};
-};
-
 &sound {
 	compatible = "qcom,sc8280xp-sndcard";
 	model = "SC8280XP-LENOVO-X13S";
-- 
2.37.4

