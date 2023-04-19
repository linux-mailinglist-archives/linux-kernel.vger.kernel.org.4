Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC86E835B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjDSVTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDSVTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:19:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4D65FE9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fy21so1597840ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681939150; x=1684531150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbjB7nNg2fivtclYxRNMULQiQZCAt+Dj4vs0IV9gBiw=;
        b=X7+k4JKLQ24aACDfO7O4HUc/jExbhVt9xzDU8JAuV+gxy+355v3VuJimmv0Zh1VkD3
         BU/dHPucFcJ2AlzizHRy5VeLgCM0yivWSXPVV0/tkxy0UtnJZKYCv5PjXfNEEaKC9vjE
         /Pi3vzdWb1ybFElEIhPo3STckQqJ3ZDQb0iu8yJIyj2VVSPScvFo8zhQ+g5kzMNupxFQ
         4tGsby4xbCaPqwLlw2YAGBJ2z664b6QDSbL248mTHTSUmRlOC5h0H7lciBKg984uwKJV
         fjnCcvHYUhEIAggAxcY1TaR0J42agUvyRNdfIsiW2+fDMW579m8jHL8XeuM5y1XgAiH2
         NwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939150; x=1684531150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbjB7nNg2fivtclYxRNMULQiQZCAt+Dj4vs0IV9gBiw=;
        b=SoYXfhd6/Ex9lFoDkQ7xYlko8Hcy2ws6EcJONFEzXR3XrgZuXMS/lhYfDNL9uPYiuu
         UuOde7dx92Gsy4H+/jdlYl+IYLpZMlSk5Vjpht4TDifMOrAn189ifwAbsIHxQA6uUOTs
         svcYx5DJ0HyaYp+PtJ3JwlHlLSgPSb8DZ12/AylhvEZ4WJ1E2o+2Mj4AcbQdW8KNyeR9
         NwQSdcwTcz6FZ0hGPUwFkntWSF5gXcevZscTS8J9bup8E252q71Bccb2TWq+rKphD0Dj
         qzf3Tc/mbbpHjb0bVZn99+SglHuwNdL0KIaNZRK4AYklp3l8lDnFK+uvDns8sFQk2gqc
         JW4g==
X-Gm-Message-State: AAQBX9f4nDOsgTARzVPRWr1d+nHHIIBf4KOG0ACPSP+c9B/ege3uU0CQ
        3oDew0XW/afnhR1wGcBMfHWdLg==
X-Google-Smtp-Source: AKy350Y4tcCAW3OxlWfP5OotfW+Kuokv348bNlCXZE3G6VutesGeO79/PMLWMSreeki0Yvivme6LDQ==
X-Received: by 2002:a17:906:2dda:b0:92b:f118:ef32 with SMTP id h26-20020a1709062dda00b0092bf118ef32mr18184354eji.48.1681939150295;
        Wed, 19 Apr 2023 14:19:10 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090682cc00b0094f109a5b3asm7092739ejy.135.2023.04.19.14.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:19:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/18] arm64: dts: qcom: msm8976: correct MMC unit address
Date:   Wed, 19 Apr 2023 23:18:45 +0200
Message-Id: <20230419211856.79332-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc@0/mmc@7824000: simple-bus unit address format error, expected "7824900"
  Warning (simple_bus_reg): /soc@0/mmc@7864000: simple-bus unit address format error, expected "7864900"
  Warning (simple_bus_reg): /soc@0/mmc@7a24000: simple-bus unit address format error, expected "7a24900"

Fixes: 0484d3ce0902 ("arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index f47fb8ea71e2..753b9a2105ed 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -822,7 +822,7 @@ spmi_bus: spmi@200f000 {
 			#interrupt-cells = <4>;
 		};
 
-		sdhc_1: mmc@7824000 {
+		sdhc_1: mmc@7824900 {
 			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x500>, <0x07824000 0x800>;
 			reg-names = "hc", "core";
@@ -838,7 +838,7 @@ sdhc_1: mmc@7824000 {
 			status = "disabled";
 		};
 
-		sdhc_2: mmc@7864000 {
+		sdhc_2: mmc@7864900 {
 			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
 			reg-names = "hc", "core";
@@ -957,7 +957,7 @@ otg: usb@78db000 {
 			#reset-cells = <1>;
 		};
 
-		sdhc_3: mmc@7a24000 {
+		sdhc_3: mmc@7a24900 {
 			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07a24900 0x11c>, <0x07a24000 0x800>;
 			reg-names = "hc", "core";
-- 
2.34.1

