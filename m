Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C493617A7A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiKCKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiKCJ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:59:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3908E101C9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:59:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso4679580pjg.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 02:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zLxFJEASSU3tUrFfThzdsPS2NuaYzvPoadCkKwT1l8=;
        b=koW3fgyiskpJg315ThqxKVECKYwUmEhPRt72Yf0apXAI1QAGbKgenxyI5dHW/b5E/8
         vIQJR0tsx5hsTRYHEQ5LAavp9JzPf5uCdNfMmBmU3jhDa/LpKJgjwFNcAvRuOmWh6/xe
         qm1v5GUayZiJrhloYiID0z3RlTIMMwYGyZOJk3oMPn2nN1eyp3g4C7XSdMmWj/fFyCvE
         l4bWZpUQiDcmb9DFqChYVBTwweowx6GMNzqZxqoXL98HYJG9eSBfOqAEKe1L3I+0I3H8
         jDqn4Bg93y8EkxOEcZlaN7elVfNr433JO5E5YnQPR7cqaTUMjcydFcmvpZx/h2ZDeIm2
         lWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zLxFJEASSU3tUrFfThzdsPS2NuaYzvPoadCkKwT1l8=;
        b=fDwXFR2M73yVRQzmZUG0tyFERnvpqJH0KamgchziTeX9yKcZb413Xe56ECWSLORbS1
         qPgzr5tueILjBXz1Gubt2mXrKK/q3oHdwJJPjWaKF2amELDv21XWZJ/9E6FzW8AV1rG1
         wBfgvtLpUspNNoP1sBsoCp4Iv4rpjJvLzJdZO6Bn37QGx5FtxRGdKww38odeJadqPPZw
         fiyWOzA3oPzlxtd7Nrg8LRz+IwCFbdwPjS4r5cR51e4wnk8W70y1Gu0MBOpq9CNRNcV/
         JU7B+n4dMy95fhqcVQymetjJzIEdO6Umss4rohB0G71S8i+rmH0FMsJb9/F+J+x5Wwad
         6jwA==
X-Gm-Message-State: ACrzQf0ddSillqJofSDS4AzjpDZrAFfKc55l2+kU79w4YIwfDdceJrGB
        abj/QDc/DmQwJyjsr9c0aVDMJVsr0Ram
X-Google-Smtp-Source: AMsMyM4HiYKwRQ6GoEQbmXFqlpxyrE58hUnvlciw6ItSGxPFLPnEhOQM4IF03UISktY3zxI/uYvdgQ==
X-Received: by 2002:a17:90b:1bd2:b0:212:cf30:3d53 with SMTP id oa18-20020a17090b1bd200b00212cf303d53mr47015471pjb.18.1667469570616;
        Thu, 03 Nov 2022 02:59:30 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.64])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b00186c54188b4sm161670plf.240.2022.11.03.02.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:59:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 12/12] arm64: dts: qcom: sc8280xp-x13s: Add thermal zone support
Date:   Thu,  3 Nov 2022 15:28:10 +0530
Message-Id: <20221103095810.64606-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103095810.64606-1-manivannan.sadhasivam@linaro.org>
References: <20221103095810.64606-1-manivannan.sadhasivam@linaro.org>
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

Add thermal zone support by making use of the thermistor SYS_THERM6.
Based on experiments, this thermistor seems to reflect the actual
surface temperature of the laptop.

For the cooling device, all BIG CPU cores are throttled down to keep the
temperature at a sane level.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index bdaacf1abf9f..60dbc736f4d7 100644
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

