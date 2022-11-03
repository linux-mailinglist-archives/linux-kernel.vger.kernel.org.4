Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41C617734
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiKCHJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiKCHJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:09:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10437BF49
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:09:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b11so837398pjp.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2bk7pRYobVWNftG5GXW6pX8qzOqi3/Pti4Jd+nYDpQ=;
        b=MPlN1lHeWyyr/qqGI08Q4sE44tpm3RZKK8Jnv+rPqOFeYKtcD1mKsxdFepnKzufC3l
         MElM3zA0aTBKptox/lWPdVUWNF6E9LMsdCVv6lavSOkWEYVSbgTC5CKZQ74+RuF1zmFL
         lW27ol8KKeHE6CREtLWMXTXFoUJgEAYhkZVRDBwmGJ18wuJEAlG0qQt1dsU+ZKCmNXXe
         0Jt4ljkhhlFoACMmepTKKtYsTzRldFJBKtNW/1bV/+vGjizuwhPN+1HjfxGjcTSj2sRX
         jjazKq6GivhHodHMfdeAOYaSTN5M03DwEw8hHqQdr3Jx3yyQWOsYNNVWvZ82NBViKHHH
         5+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2bk7pRYobVWNftG5GXW6pX8qzOqi3/Pti4Jd+nYDpQ=;
        b=D9dm9SuCBTPE31o8HEr0XgtlxcgnMdASriv+0eVW+UTCU8MSIWS8Dp7QkRasPzwwro
         G/JqMQQn2KO54ewrBHJK37vjv7Nu2qW89gjYjV9zyj5Qb3sSigNdxuBzC3WYhOww8A1v
         q0ZyUz7FcQLY02lVVw6I8ulGz/dTLl2871PhxROY/UcMoI1h3T+nDzycmFDwiDzuGBrf
         WcVxPss4AANlofjsfyvj31rK99HnTeA0zPc8tM6kPDm4/AmPaSI2O3Tko81/PARc+R2q
         qL14jn26EmowKNU8TX4SEeJ8bOoOnmbJ7citSTjmt60+MVv7aoxnh1yUBZlpryed7S98
         uetg==
X-Gm-Message-State: ACrzQf0ZzEOvlkiOr0fYo6cZSt8+DljJD1bC1Baw2ImnJcusMfC9ZxOZ
        5FoeLWdMepIcHEyo0d/LfXTA
X-Google-Smtp-Source: AMsMyM6Q+z52ghR9YK7/1LqrTk3FEYFbZoZsvK1H+bdlFO2aX/dpVg0y10iWbJ6PbvrZN+QDuLQoxw==
X-Received: by 2002:a17:902:d489:b0:187:2b1d:1101 with SMTP id c9-20020a170902d48900b001872b1d1101mr16660361plg.158.1667459381540;
        Thu, 03 Nov 2022 00:09:41 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.64])
        by smtp.gmail.com with ESMTPSA id s9-20020a170903214900b00186748fe6ccsm9451244ple.214.2022.11.03.00.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 00:09:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 02/12] arm64: dts: qcom: sc8280xp-pmics: Add temp alarm for PM8280_{1/2} PMICs
Date:   Thu,  3 Nov 2022 12:39:01 +0530
Message-Id: <20221103070911.20019-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103070911.20019-1-manivannan.sadhasivam@linaro.org>
References: <20221103070911.20019-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for temperature alarm feature in the PM8280_{1/2} PMICs.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 24836b6b9bbc..5de47b1434a4 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -33,6 +33,13 @@ pmc8280_1: pmic@1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8280_1_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		pmc8280_1_gpios: gpio@8800 {
 			compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
@@ -78,6 +85,13 @@ pmc8280_2: pmic@3 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8280_2_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		pmc8280_2_gpios: gpio@8800 {
 			compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
-- 
2.25.1

