Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A97765AFF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjABKvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjABKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:51:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5404962E2;
        Mon,  2 Jan 2023 02:50:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7047B80D07;
        Mon,  2 Jan 2023 10:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C12C433B3;
        Mon,  2 Jan 2023 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672656651;
        bh=NnSjzogFraldpT+XgAkjYumPBRSVym0mp3juRqkdBpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9XUZ6DlHPc+bBa0ForStYZhT5tJwdXf/wFRBVQ5wdWU+fYlbl5yISWRi5rxUKSBD
         M6jiVrGmjr3TIORGvzU+BHTsZLJdbWelF2azHeNme6dc0lY+SiV/6ner5FlG/VbY2L
         tR40DLeW4viM5CNAn22sOvh85Kp1DHUxk60kQsLD0Wq7GAB+SArbcXJhV8WJnE9PfD
         8RX1ee7JEDXEhC5GswkxemVwGaDvZAbLTZLe4HcBligs7MzVWyPX9dGI3oeTqBCzeo
         nJCY7d+blk0TCw84twVzigMjo53JkEVAqDSP/lcxum4kUANFpeImylqiWmwnUfCC6Y
         NXdcD8B2XUWzg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pCIPM-000273-Jl; Mon, 02 Jan 2023 11:51:08 +0100
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
Subject: [PATCH 6/6] arm64: dts: qcom: sm8450-hdk: fix wcd938x codec node
Date:   Mon,  2 Jan 2023 11:50:38 +0100
Message-Id: <20230102105038.8074-7-johan+linaro@kernel.org>
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

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 52 ++++++++++++-------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 4de3e1f1c39c..217b2c654745 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -17,6 +17,31 @@ aliases {
 		serial0 = &uart7;
 	};
 
+	wcd938x: codec {
+		compatible = "qcom,wcd9380-codec";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcd_default>;
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
+		reset-gpios = <&tlmm 43 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <1>;
+
+		vdd-buck-supply = <&vreg_s10b_1p8>;
+		vdd-rxtx-supply = <&vreg_s10b_1p8>;
+		vdd-io-supply = <&vreg_s10b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -407,33 +432,6 @@ &sdhc_2 {
 	status = "okay";
 };
 
-&soc {
-	wcd938x: codec {
-		compatible = "qcom,wcd9380-codec";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&wcd_default>;
-
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
-		reset-gpios = <&tlmm 43 GPIO_ACTIVE_LOW>;
-		#sound-dai-cells = <1>;
-
-		vdd-buck-supply = <&vreg_s10b_1p8>;
-		vdd-rxtx-supply = <&vreg_s10b_1p8>;
-		vdd-io-supply = <&vreg_s10b_1p8>;
-		vdd-mic-bias-supply = <&vreg_bob>;
-	};
-};
-
 &sound {
 	compatible = "qcom,sm8450-sndcard";
 	model = "SM8450-HDK";
-- 
2.37.4

