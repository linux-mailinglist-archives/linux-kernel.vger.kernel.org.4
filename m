Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78838622E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiKIOmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiKIOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:42:10 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8765914D1D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:42:06 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id k19so26102871lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=899l+c/XtH99xaccvHTLVoe+jcl0BTwhY2TnnCFqLNM=;
        b=Az7odDo6dAll2WS21pj6xbA5tgTltd8bZGosqRjhAU/DzXrEF6WzD4007Z+BNkJpW7
         Uia94bgTw+YOQ9e8vNy/AUOnW5kfs4WoIKCRuYLkVBzp+nPk+10oF/T1RQ6Lngh8Vvo+
         D9AqPqP6BeppOnf3sFdXIvmZ4+p6GBzt9/rlfFYq/15/SWsa2JKse3nJkZTD/7FPsP8c
         iI1rWd03aypjHFocxZ2GKqhbfbP4LoS4/1+EY45nERQIE8dbMNYeqBpYwD33l35VVzak
         TgJG/u82ggphCxbn6RkrepuNVVUL/6LF0wVii+bv/BsmrAJMKtWWOXBvqyZ9BEcf7tUc
         BHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=899l+c/XtH99xaccvHTLVoe+jcl0BTwhY2TnnCFqLNM=;
        b=vnjUqrwriiAELv8NHtCElpFgxDcCR4l69Jkp5Y7LoRJwM3pxBxbhtoFzpaZca1vGHh
         XSFr+rZuvyrPXicmG1nK6U9KTk+x1JNwxL5KyYxSJhivRdHWUnXv62VNV0Qh/Zpb1HAH
         VKV3qzFEORkaGItys1XQtlUD5uMbW1PzLqBCdJTqrGkUpQmWjEOIW2T6R1kGWsFLF7xJ
         7P9dl+qFemo8/XWGXmCGj/flTtfecPFXZC8cyqX/qZ/pKvvfZRhYbiRU/sqVXbHknS2Y
         6nJ77miBcBK9IoWXv66kNhYui3t0p4tVt+15vADegHB2OT0gU3BooDjNCsSBgviakTCl
         oTDQ==
X-Gm-Message-State: ACrzQf1M9BNe/+6eiBxhx3c443SiXtswcmtAAFcW9i5KbjFKbAZm9FId
        mXia6oQjlePlFOAXp3oLqd78qA==
X-Google-Smtp-Source: AMsMyM65KJ5cVonuq2Hh0wXFJThu1u/Vcg4bXrIM8SKT0BplJd2QE0M1dRsmzE/Z+QthmAukpXIj8Q==
X-Received: by 2002:a2e:a801:0:b0:261:91a3:bc44 with SMTP id l1-20020a2ea801000000b0026191a3bc44mr20087296ljq.497.1668004924957;
        Wed, 09 Nov 2022 06:42:04 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id q10-20020a056512210a00b004a478c2f4desm2235229lfr.163.2022.11.09.06.42.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 06:42:04 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm6375-pdx225: Enable SD card slot
Date:   Wed,  9 Nov 2022 15:41:53 +0100
Message-Id: <20221109144153.53630-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109144153.53630-1-konrad.dybcio@linaro.org>
References: <20221109144153.53630-1-konrad.dybcio@linaro.org>
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

Set SDHCI VMMC/VQMMC to <=2v96 and allow load setting by the SDHCI
driver, as required by this use case.

Configure the SD Card Detect pin, enable the SDHCI2 controller and
assign it the aforementioned regulators.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v1:
- remove stray newline
- pick up r-b

 .../qcom/sm6375-sony-xperia-murray-pdx225.dts | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index 33083f18755b..7cf71b8bcac5 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -153,7 +153,8 @@ pm6125_l4: l4 {
 
 		pm6125_l5: l5 {
 			regulator-min-microvolt = <1650000>;
-			regulator-max-microvolt = <3050000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 
 		pm6125_l6: l6 {
@@ -235,7 +236,8 @@ pm6125_l21: l21 {
 
 		pm6125_l22: l22 {
 			regulator-min-microvolt = <2704000>;
-			regulator-max-microvolt = <3544000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 
 		pm6125_l23: l23 {
@@ -302,6 +304,33 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&sdc2_off_state {
+	sd-cd-pins {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&sdc2_on_state {
+	sd-cd-pins {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	vmmc-supply = <&pm6125_l22>;
+	vqmmc-supply = <&pm6125_l5>;
+
+	cd-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
+};
+
 &tlmm {
 	gpio-reserved-ranges = <13 4>;
 
-- 
2.38.1

