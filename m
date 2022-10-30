Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AE86128CE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 08:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJ3HdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 03:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJ3Hcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 03:32:52 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD7E2D9;
        Sun, 30 Oct 2022 00:32:48 -0700 (PDT)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 61D1C200BC;
        Sun, 30 Oct 2022 08:32:46 +0100 (CET)
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] arm64: dts: qcom: sm6350-lena: Provide power to SDHCI 2 (SDCard slot)
Date:   Sun, 30 Oct 2022 08:32:29 +0100
Message-Id: <20221030073232.22726-8-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030073232.22726-1-marijn.suijten@somainline.org>
References: <20221030073232.22726-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without power the SDCard slot / hardware remains dormant.

Like many other platforms these regulators are used exclusively by
SDHCI, and have their maximum voltage decreased to what downstream sets
on the consumer side.  Additionally the SDHCI driver supports setting a
load, for which the regulator definition is extended much the same.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 1aaa9612b061..5cb76026ef67 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -219,8 +219,13 @@ pm6150l_l5: ldo5 {
 
 		pm6150l_l6: ldo6 {
 			regulator-min-microvolt = <1700000>;
-			regulator-max-microvolt = <3544000>;
+			regulator-max-microvolt = <2950000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
+
 		};
 
 		pm6150l_l7: ldo7 {
@@ -237,8 +242,13 @@ pm6150l_l8: ldo8 {
 
 		pm6150l_l9: ldo9 {
 			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <3544000>;
+			regulator-max-microvolt = <2960000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
+
 		};
 
 		pm6150l_l10: ldo10 {
@@ -300,6 +310,9 @@ sd-cd-pins {
 &sdhc_2 {
 	status = "okay";
 
+	vmmc-supply = <&pm6150l_l9>;
+	vqmmc-supply = <&pm6150l_l6>;
+
 	cd-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
 };
 
-- 
2.38.1

