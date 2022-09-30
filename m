Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4295F1235
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiI3TLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiI3TLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:11:17 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75915178A10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:11:07 -0700 (PDT)
Received: from localhost.localdomain (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 210FC200F8;
        Fri, 30 Sep 2022 21:11:05 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: qcom: sdm845-akatsuki: Configure maXTouch touchscreen
Date:   Fri, 30 Sep 2022 21:10:49 +0200
Message-Id: <20220930191049.123256-9-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930191049.123256-1-konrad.dybcio@somainline.org>
References: <20220930191049.123256-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marijn Suijten <marijn.suijten@somainline.org>

Configure the maXTouch touchscreen found on Xperia XZ3 devices.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
[Konrad: clean up unused props, use generic node name]
---
 .../qcom/sdm845-sony-xperia-tama-akatsuki.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
index 5c5949a51184..1668ae99dd47 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
@@ -25,6 +25,29 @@ ts_vddio_supply: ts-vddio-regulator {
 		gpio = <&tlmm 133 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-boot-on;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_vddio_en>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	touchscreen: touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <125 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
+		vdda-supply = <&vreg_l28a_2p8>;
+		vdd-supply = <&ts_vddio_supply>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&ts_default>;
+		pinctrl-1 = <&ts_sleep>;
 	};
 };
 
-- 
2.37.3

