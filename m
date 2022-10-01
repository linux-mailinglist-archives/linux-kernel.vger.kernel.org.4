Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51295F1ED1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJATC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 15:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJATCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 15:02:22 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99A2356E3
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 12:02:20 -0700 (PDT)
Received: from TimeMachine.lan (adsl-dyn13.78-99-1.t-com.sk [78.99.1.13])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id B3C4E3F326;
        Sat,  1 Oct 2022 20:53:26 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: qcom: sm6125: Add dispcc node
Date:   Sat,  1 Oct 2022 20:53:21 +0200
Message-Id: <20221001185321.492532-1-martin.botka@somainline.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dispcc node for the newly added DISPCC
driver for Qualcomm Technology Inc's SM6125 SoC.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 62f216bfca4f..ffbcee009279 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2021, Martin Botka <martin.botka@somainline.org>
  */
 
+#include <dt-bindings/clock/qcom,dispcc-sm6125.h>
 #include <dt-bindings/clock/qcom,gcc-sm6125.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -367,6 +368,17 @@ soc {
 		ranges = <0x00 0x00 0x00 0xffffffff>;
 		compatible = "simple-bus";
 
+		dispcc: clock-controller@5f00000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "qcom,dispcc-sm6125";
+			reg = <0x5f00000 0x20000>;
+			clocks = <&gcc GCC_DISP_AHB_CLK>;
+			clock-names = "cfg_ahb_clk";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		tcsr_mutex: hwlock@340000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x00340000 0x20000>;
-- 
2.37.3

