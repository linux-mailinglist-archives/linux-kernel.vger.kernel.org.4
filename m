Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A2E6B8C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCNHkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCNHkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:40:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F00A8C954
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:40:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ja10so5997744plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678779609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLxEHBJM5aBlcBtcL4I4cmvZzwwEog5yFTPmXjO+FxE=;
        b=l1IaoeBiQDXzjh5BdZkj9W0IJVdg8Nq68Sk1HEOvpFLmskNoDeAPzSviOqzJWoitpP
         5Ff5x8ivl+ocb0IHomeemsHYJ93NTC0qqbkoTaXmsbQ33Zw20jaOcTM1GTl/eE/ZbrBs
         OFibCP0xxKcH6vu2xe/R8pSXEWTpl7OQ2ZSdz7U90wCvQYJgla4nAlK2DSFAS6TLkAnC
         xQ6ItBZ8IGXDPUEPR/T3vn5Ve300uw5mpn6Rp97uHBv3/ijFo3aQ2AxCoRgFmsjGmoaR
         VuY+9jDxslKOQHk8Mim2G+65HjpwyCi+uwDXX2ch/ne+uz4ayPJ94Dr8JmpPNckB8qr/
         P4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678779609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLxEHBJM5aBlcBtcL4I4cmvZzwwEog5yFTPmXjO+FxE=;
        b=WKlFLkuH+mRgXSljpImvs0GSYvfERG8YLdI7/vxBqXIIuDWxjZ8dW3XmzirmaB4ra+
         QASa5cTfCQZ0Q6WPlvcQK3bVe6iAp21+ObKPB/oXSulvCY3plNwtbO29rh7l4i53geVn
         kkFcr079M0cA+HAWTXKtr7f5eAmdhSDMRvDljynCQO1JwFs6JKg8UP53lc4Eas7s7Hle
         H6tEchXgOCrGxaHNoSdpLd0TJW6lO72ER+ZqVIq+Tu/UbGUQv9XuQlWVtvDqd60fU405
         4nW8cb8D4nMZLmkJw3TVzF6sb9KjsHLN2o9st31N9wdXBhT0GeiUdE4Ui4wVLPCId6Af
         NN6Q==
X-Gm-Message-State: AO0yUKUc5tvtFJKqyReclBJ76eXthg9ewRnrBtf9ZJE973EDP5KktRkw
        eL+fnEHaGG2u56B7M3nbJQpIxA==
X-Google-Smtp-Source: AK7set/dwaMw/cLpwuGIFmPavyH96hm2WNMmzFUOdeQrEgcYJxcaoYl77Aekazd00aJnPHJRwwJ+SA==
X-Received: by 2002:a17:90b:3ecb:b0:23d:3761:6085 with SMTP id rm11-20020a17090b3ecb00b0023d37616085mr1463352pjb.34.1678779608994;
        Tue, 14 Mar 2023 00:40:08 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:4a3e:15d0:d540:3861:ef0e])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090aea8e00b002372106a5c2sm1034602pjz.37.2023.03.14.00.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 00:40:08 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v2] arm64: dts: qcom: sm6115: Move SDHC node(s)'s 'pinctrl' properties to dts
Date:   Tue, 14 Mar 2023 13:10:01 +0530
Message-Id: <20230314074001.1873781-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally the 'pinctrl' properties of a SDHC controller and the
chip detect pin settings are dependent on the type of the slots
(for e.g uSD card slot), regulators and GPIO(s) available on the
board(s).

So, move the same from the sm6115 dtsi file to the respective
board file(s).

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
Changes since v1:
- v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20221220113616.1556097-1-bhupesh.sharma@linaro.org/
- Colleted the R-B from Marijn.
- Rebased on linux-next/master

 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 10 +++++++++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 22 -------------------
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index a3f1c7c41fd73..329eb496bbc5f 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -202,12 +202,22 @@ &sdhc_2 {
 	vqmmc-supply = <&vreg_l5a>;
 
 	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_state_on &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_state_off &sdc2_card_det_n>;
 
 	status = "okay";
 };
 
 &tlmm {
 	gpio-reserved-ranges = <14 4>;
+
+	sdc2_card_det_n: sd-card-det-n-state {
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
 
 &ufs_mem_hc {
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index fbd67d2c8d781..e8e5f2cafebb9 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -595,13 +595,6 @@ data-pins {
 					bias-pull-up;
 					drive-strength = <10>;
 				};
-
-				sd-cd-pins {
-					pins = "gpio88";
-					function = "gpio";
-					bias-pull-up;
-					drive-strength = <2>;
-				};
 			};
 
 			sdc2_state_off: sdc2-off-state {
@@ -622,13 +615,6 @@ data-pins {
 					bias-pull-up;
 					drive-strength = <2>;
 				};
-
-				sd-cd-pins {
-					pins = "gpio88";
-					function = "gpio";
-					bias-disable;
-					drive-strength = <2>;
-				};
 			};
 		};
 
@@ -731,10 +717,6 @@ sdhc_1: mmc@4744000 {
 				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
 			clock-names = "iface", "core", "xo", "ice";
 
-			pinctrl-0 = <&sdc1_state_on>;
-			pinctrl-1 = <&sdc1_state_off>;
-			pinctrl-names = "default", "sleep";
-
 			bus-width = <8>;
 			status = "disabled";
 		};
@@ -753,10 +735,6 @@ sdhc_2: mmc@4784000 {
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
 
-			pinctrl-0 = <&sdc2_state_on>;
-			pinctrl-1 = <&sdc2_state_off>;
-			pinctrl-names = "default", "sleep";
-
 			power-domains = <&rpmpd SM6115_VDDCX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			iommus = <&apps_smmu 0x00a0 0x0>;
-- 
2.38.1

