Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09543654748
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiLVUhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiLVUgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:36:50 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9E620BC6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:36:49 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1A1421F966;
        Thu, 22 Dec 2022 21:36:48 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: qcom: sm6125-seine: Configure SD Card slot on SDHCI 2
Date:   Thu, 22 Dec 2022 21:36:35 +0100
Message-Id: <20221222203636.250190-5-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221222203636.250190-1-marijn.suijten@somainline.org>
References: <20221222203636.250190-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony's seine board features an SD Card slot on SDHCI 2, that is to be
powered by l5 and l22.  The card detect pin is already biased via
updates on the generic sdc2_*_state pinctrl nodes.

As usual regulator voltages are decreased to the maximum voted by the
downstream driver for safety.  SDHCI 2 is the only hardware block
feeding off of these.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts  | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index eaddbe522695..4c9b8ad77dd9 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -318,7 +318,8 @@ pm6125_l4: l4 {
 
 		pm6125_l5: l5 {
 			regulator-min-microvolt = <1648000>;
-			regulator-max-microvolt = <3104000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
 		};
 
 		pm6125_l6: l6 {
@@ -404,7 +405,8 @@ pm6125_l21: l21 {
 
 		pm6125_l22: l22 {
 			regulator-min-microvolt = <2944000>;
-			regulator-max-microvolt = <3304000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
 		};
 
 		pm6125_l23: l23 {
@@ -444,6 +446,15 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 98 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&pm6125_l22>;
+	vqmmc-supply = <&pm6125_l5>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <22 2>, <28 6>;
 
-- 
2.39.0

