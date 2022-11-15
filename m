Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A127629D76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKOP3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbiKOP2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:28:11 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971822E690
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:27:52 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id kt23so36909550ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXNeiZSiKUzdZoTHuirJDg5xuDfVFRqeocp2CsC1HKs=;
        b=f0/LC4qEmBltwHtca1iArNV86IyOU5fGnON5xaV+i8xRAy8zt9ZzEc0iPDhysWUzhR
         XQvzMveBCys8i2b5TNixUxT5s4FKGbFzAZ7qckT86MS8qjTJ+dlbmssKkhzWrTrmslDs
         xdm+UmsqBe7V7tJZt4N9tj9opSCQoLMkDYPZ3x8oqJyiREmK9PUpT5XZ9nsnXla/5vEc
         co0Bw9veFcR9UQo9PXWDVbJzdlpijsNDbdPrVmtSE+68b0ddIVYsZgEd8E0QaEnZZ0Zs
         Wxe1I/NGVe+JwE0fqf6GQFRGNou1ppnoB2zi6Jhj8kBhw5I+dxtLqc1gZlMrhkPXyPEI
         rA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXNeiZSiKUzdZoTHuirJDg5xuDfVFRqeocp2CsC1HKs=;
        b=Bc2ssBMzsxHWkKJSuC1mKKrnXsK3Ao3UD5IXKlpAlw/OasmANRW0cjHpiJYrufNAY3
         PG0EUIM4u+3acpCkx5K1WN+dSuwP+TG31Kprq5YjNKk65AOWZexFKEy8Luh0nUoDipYH
         R2nbGdch58YdZioIC/TuAWwUCOpqmuepYNnrSlokVns6m5fFyaOf+TKJ0DbyCKuGQXMl
         flATDAyzQ1avfengze/M8q+RUCwXS8/DPKRUTg1IlGC6eyBmPWk+wmumtkFxAtkRsuUW
         PisOzZq7KB/4JK+WVagYVojsk/vrQBCmKK38U4hKIOmSPGlHn6gjWMrl0h8Q3GRQGgTN
         rj6g==
X-Gm-Message-State: ANoB5plrmUDSF9+c5lyVrZqLP0Ya/HAsm/iE7DLfi9g4u1Vuo9BnS5Dw
        +UagreQ7xvYhg8a/XNCpcbYWRg==
X-Google-Smtp-Source: AA0mqf6G00aK5hcQ0x7+uFf7ziD5zons24TbIeFxMratzW5r9iONupr0GsEq5Busc/qWa+nuvpxBdQ==
X-Received: by 2002:a17:906:16d0:b0:7ae:31a0:5727 with SMTP id t16-20020a17090616d000b007ae31a05727mr14523521ejd.540.1668526072162;
        Tue, 15 Nov 2022 07:27:52 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b007ae1ab8f887sm5750679ejc.14.2022.11.15.07.27.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 07:27:51 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] arm64: dts: qcom: sm6375-pdx225: Configure Samsung touchscreen
Date:   Tue, 15 Nov 2022 16:27:27 +0100
Message-Id: <20221115152727.9736-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221115152727.9736-1-konrad.dybcio@linaro.org>
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
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

Add a pretty bog-standard-for-Xperias-for-the-past-3-years
touchscreen setup.

The OEM that built the Xperia 10 IV for SONY decided to use some
kind of a GPIO regulator that needs to be enabled at all times
for both the touch panel and the display panel to function.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../qcom/sm6375-sony-xperia-murray-pdx225.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index 0f1ddfa28c89..d18167bcb41f 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -81,6 +81,23 @@ &gpi_dma1 {
 	status = "okay";
 };
 
+&i2c8 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen@48 {
+		compatible = "samsung,s6sy761";
+		reg = <0x48>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <22 0x2008>;
+
+		vdd-supply = <&pm6125_l13>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_default &ts_avdd_default>;
+	};
+};
+
 &pmk8350_adc_tm {
 	status = "okay";
 };
@@ -290,6 +307,20 @@ pmr735a_l7: l7 {
 
 &tlmm {
 	gpio-reserved-ranges = <13 4>;
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio22";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	ts_avdd_default: ts-avdd-default-state {
+		pins = "gpio59";
+		function = "gpio";
+		drive-strength = <8>;
+		output-high;
+	};
 };
 
 &usb_1 {
-- 
2.38.1

