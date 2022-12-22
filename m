Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76342654746
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiLVUhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLVUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:36:49 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D9121830;
        Thu, 22 Dec 2022 12:36:47 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 031C31F8D6;
        Thu, 22 Dec 2022 21:36:45 +0100 (CET)
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
Subject: [PATCH 1/5] arm64: dts: qcom: sm6125-seine: Configure PM6125 regulators
Date:   Thu, 22 Dec 2022 21:36:32 +0100
Message-Id: <20221222203636.250190-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221222203636.250190-1-marijn.suijten@somainline.org>
References: <20221222203636.250190-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure PM6125 regulators based on availability and voltages defined
downstream, to allow powering up (and/or keeping powered) other hardware
blocks going forward.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 4e7c12863d28..4f825c55692b 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -276,6 +276,145 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		vdd_l2_l3_l4-supply = <&pm6125_l7>;
+		vdd_l5_l15_l19_l20_l21_l22-supply = <&pm6125_l10>;
+
+		/*
+		 * S3/S4 is VDD_CX
+		 * S5 is VDD_MX/WCSS_MX
+		 */
+
+		pm6125_s6: s6 {
+			regulator-min-microvolt = <936000>;
+			regulator-max-microvolt = <1422000>;
+		};
+
+		pm6125_l1: l1 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1256000>;
+		};
+
+		pm6125_l2: l2 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1056000>;
+		};
+
+		pm6125_l3: l3 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1064000>;
+		};
+
+		pm6125_l4: l4 {
+			regulator-min-microvolt = <872000>;
+			regulator-max-microvolt = <976000>;
+		};
+
+		pm6125_l5: l5 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <3104000>;
+		};
+
+		pm6125_l6: l6 {
+			regulator-min-microvolt = <576000>;
+			regulator-max-microvolt = <656000>;
+		};
+
+		pm6125_l7: l7 {
+			regulator-min-microvolt = <872000>;
+			regulator-max-microvolt = <976000>;
+		};
+
+		pm6125_l8: l8 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+
+		pm6125_l9: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1896000>;
+		};
+
+		pm6125_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1896000>;
+		};
+
+		pm6125_l11: l11 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		pm6125_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1996000>;
+		};
+
+		pm6125_l13: l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1832000>;
+		};
+
+		pm6125_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		pm6125_l15: l15 {
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3232000>;
+		};
+
+		pm6125_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		pm6125_l17: l17 {
+			regulator-min-microvolt = <1248000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l18: l18 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1264000>;
+		};
+
+		pm6125_l19: l19 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <2952000>;
+		};
+
+		pm6125_l20: l20 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <2952000>;
+		};
+
+		pm6125_l21: l21 {
+			regulator-min-microvolt = <2600000>;
+			regulator-max-microvolt = <2856000>;
+		};
+
+		pm6125_l22: l22 {
+			regulator-min-microvolt = <2944000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l23: l23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		pm6125_l24: l24 {
+			regulator-min-microvolt = <2944000>;
+			regulator-max-microvolt = <3304000>;
+		};
+	};
+};
+
 &sdc2_off_state {
 	sd-cd-pins {
 		pins = "gpio98";
-- 
2.39.0

