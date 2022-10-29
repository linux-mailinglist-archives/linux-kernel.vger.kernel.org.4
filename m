Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F2E61207C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 07:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJ2FQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 01:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJ2FQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 01:16:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5C9AF196
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:16:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d24so6545446pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpyWOsS0FBSOmnylpOdwOjAVxC2jYFz7gdsUBGPUnb0=;
        b=qzoXpid0DCIWb2RKt8w0bFIHln3U61B6bnegL/kf56vwhNn+IPJnNLiX2Mubujj/P4
         /Ve39fktovVrJt9csGeFLKBuminWK8xrLY+Bfy6A0xh3jMzNAiOcNuEXF4EfQcJAQTra
         n+A1GyiXoeh4zqTLKeMQmHr1qpmGhEsAI37wq13R6RCWhYWem9t3KnVViOayMYrHjOOE
         zpnZlCxtQQtsXkJh1OfbcMp6ZWdM8xTRRNZjOeVguSEu1RUQgOFTQ69KaB1gg5BtGbpZ
         VIqbJfHz46kKTO4OkxjkVkAwdlFMP3GGzZ/UCxXOhL7go4v7LDRQP55GBa7g+spy5tu5
         kYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpyWOsS0FBSOmnylpOdwOjAVxC2jYFz7gdsUBGPUnb0=;
        b=rvXfoAVyQkU8RzUKxgbrAj527coPq+QP9Lqkezn4tmqzsZ2/hpTFBIA0YhFMYydCxt
         XoMyqCN4DXbgb3AWN+2tSX5az3P0J5Y0/O7lVmNzI72odeq26S/OnnW/mpvirUGkYI4S
         RSLWzS37NVxZfIHBPJDk/JtkPTHH/5g3LS8XR1yT2MpKLVCmt1oXw4sTzYSUKmUw36XO
         0c+fQlDKLDlMivTPKIdMxab0boaAbd4fEeEPUC8uE+T0ZfS6Im1iC8DV62bThi5DLIEc
         EPsuxQ1h8CnF0wACPVzTSJ7DD9pEvUQXtWh+fpBL4wAqurjB4WttIWWcRdWY61kqd2v4
         GSnw==
X-Gm-Message-State: ACrzQf3PioG8fIwqJzL8jlURpNM9sTXFGHh08H+9EFgs7jW7SY7fpQeq
        0hj9Bf0oWhosgLvi6AFjPjTU
X-Google-Smtp-Source: AMsMyM4lz557/k3cVsDcvnHIuqI4qgGU+9VIzarRNzaOlvgWn7mLqPcYcpRqteRblBPbukofVqJCPQ==
X-Received: by 2002:a17:90b:38d1:b0:210:99f9:9712 with SMTP id nn17-20020a17090b38d100b0021099f99712mr20447697pjb.57.1667020565035;
        Fri, 28 Oct 2022 22:16:05 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.167])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b0017e9b820a1asm363150plg.100.2022.10.28.22.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 22:16:04 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 12/12] arm64: dts: qcom: sc8280xp-x13s: Add thermal zone support
Date:   Sat, 29 Oct 2022 10:44:49 +0530
Message-Id: <20221029051449.30678-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
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

Add thermal zone support by making use of the thermistor SYS_THERM6.
Based on experiments, this thermistor seems to reflect the actual
surface temperature of the laptop.

For the cooling device, all BIG CPU cores are throttle down to keep the
temperature at a sane level.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index ca77c19c6d0d..96e2fa72f782 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -29,6 +29,52 @@ backlight {
 		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
 	};
 
+	thermal-zones {
+		skin-temp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8280_adc_tm 5>;
+
+			trips {
+				skin_temp_alert0: trip-point0 {
+					temperature = <55000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				skin_temp_alert1: trip-point1 {
+					temperature = <58000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				skin-temp-crit {
+					temperature = <73000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&skin_temp_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&skin_temp_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	vreg_edp_bl: regulator-edp-bl {
 		compatible = "regulator-fixed";
 
-- 
2.25.1

