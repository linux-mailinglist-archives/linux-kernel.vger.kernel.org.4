Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D375262A05A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiKOR3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiKOR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:28:42 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B06927CE8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:28:40 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s8so8383590lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnzzFvDnrUNiU88yEZt6sQdtp0kEECaqorraO0GqvxU=;
        b=gTqXfTfz1AawXgaddIVtPqg4+pkukv3DqH6QpxMlqCBS05LIvP+2dQ4b6OMEevO4kA
         FHj86IBdobrG3d5IdXt/+3TCHAqqGWj7BmXM4FluMRmhulHmbEe5m0nXfF6h4N6N0+3n
         znqac4WQsqsJdf44MkWe6m4u5H+yNPTs63KaTASt2BnjxAZq/98zjcYD8Al4EFI54bEU
         QqtUy4uUBwj4NKrABJcJqUAW+u4RH3y95bTU2KY9/wJr8NkScoBaNXb7FrgeRbGujFTf
         mtDvGyealO5gkDiuH5wrlXwrTfAJbO+wzBFX9fYvNonCrOQYraxjuRY14Zkz3nz+ld+n
         lMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnzzFvDnrUNiU88yEZt6sQdtp0kEECaqorraO0GqvxU=;
        b=vT0xhz6nvEnfXxHOXjtZNozQQdk18tCiSwXAfVBpu8CHOrng3itLAC0j9W7yDrnQk/
         R3gps06uHwNrkLILCrCz+B2dXL3UJveg2nvjN5uI2NhL7fmbDeBRdqi6x0bOUybU5+As
         2BIK30fOJ3sXqQ94bhI2UR9n+DuXWwizbPGFjh8AaBYaDdnPSDf3krLrZ8ZABymmwpwp
         8sb04WUT5QVnhyftca7JbIJcEAANAwt/IH31U55sfb4TZAZbieQYw0ky/DlcYvpXoTZm
         1HYV5UDqooy6dfz2Ql4qPUngsmPvSJgM7jxwQ4D7zN0GWvShTvZHScZIeVi0YhZ4tKPV
         1fAw==
X-Gm-Message-State: ANoB5pk4qWak9PjD5AZOzhx3LISpwfMMrP2H6sMXSEctiWMk/4qKcEPi
        AwP55wTvwFERzJMKc7+lRog6sQ==
X-Google-Smtp-Source: AA0mqf5iYiSCCg41VSN3+mgDERmio+BS0NImVtdSFTzVWSNilw7sO0zafZj5BDmVrN1pC8TF7RC4kA==
X-Received: by 2002:a05:6512:3c8e:b0:4a0:5393:3749 with SMTP id h14-20020a0565123c8e00b004a053933749mr6050082lfv.494.1668533319861;
        Tue, 15 Nov 2022 09:28:39 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id b42-20020a0565120baa00b00496d3e6b131sm2261511lfv.234.2022.11.15.09.28.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 09:28:39 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sm8350-sagami: Wire up SDHCI2
Date:   Tue, 15 Nov 2022 18:28:28 +0100
Message-Id: <20221115172828.14372-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221115172828.14372-1-konrad.dybcio@linaro.org>
References: <20221115172828.14372-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust regulators, add required pin setup and finally enable SDHCI2
to get the SD Card slot going on Sagami Xperias.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index a428ce31ab4e..fdf95b763cf4 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -312,7 +312,8 @@ pm8350c_l8: ldo8 {
 		pm8350c_l9: ldo9 {
 			regulator-name = "pm8350c_l9";
 			regulator-min-microvolt = <2960000>;
-			regulator-max-microvolt = <3008000>;
+			/* Originally max = 3008000 but SDHCI expects 2960000 */
+			regulator-max-microvolt = <2960000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
@@ -558,6 +559,19 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_active>;
+	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_sleep>;
+	vmmc-supply = <&pm8350c_l9>;
+	vqmmc-supply = <&pm8350c_l6>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
+
 &slpi {
 	status = "okay";
 	firmware-name = "qcom/sm8350/Sony/sagami/slpi.mbn";
@@ -782,6 +796,20 @@ ts_int_default: ts-int-default-state {
 		bias-disable;
 		input-enable;
 	};
+
+	sdc2_card_det_active: sd-card-det-active-state {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	sdc2_card_det_sleep: sd-card-det-sleep-state {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
 };
 
 /* BIG WARNING! DO NOT TOUCH UFS, YOUR DEVICE WILL DIE! */
-- 
2.38.1

