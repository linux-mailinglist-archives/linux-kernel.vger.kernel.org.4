Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C29F617753
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiKCHLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKCHKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:10:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA124F020
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:10:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j12so1096305plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 00:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH8K/6eg5Lh08TfiTAW9SH/au0kXMjW1a4OsBDcVWqM=;
        b=ZrpmvktuoNhallTRgxhKQWglgv0B8LbAU1PTDwPFaf4kgpbfOwqNdrjuUyEYePAhmn
         v4ka3TNaMdkeY8ZVY2T2rQ0f8guNpPWfWma2a9Yvp85ab9hutZ6UK3cy7HUmFdgqOCfd
         GnKXbWoyhIecHnsbgAYaKyOxfc5gZfd8rk9quMhI4WpVKYLgV53MWkF+opti+4DIs2LD
         xlUsF7jtqt98uNmlEs9MrQUhTBg7WgBXzFR+yP0j8yfbq/TYfaCvo5wJl/I7SqYuE/0p
         92zAmBBlwYZYtT5WTc+4WwHUSjSJTho/+IY30WbkLUmdhQwzfPTtzMVjvrNqMJ7rPt/M
         GOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mH8K/6eg5Lh08TfiTAW9SH/au0kXMjW1a4OsBDcVWqM=;
        b=NodbHNDKbDx52/lpkiKvUg5eox5kI4+5WGyCK8M6UheOLjQQ4CQat1FSZVk09uXshO
         PRQ9mPapX/IgH2ca6C6pR9FLZvU7aSkv+13uKXxgeMpMfFXnN6nEcqGz8K06UbYVLzuL
         /dXXpanRpaVXwqea0btNaPQ8XLldERdSFClGBEeCx9jnhpJgazK5G6MD2Xrly4C4aDdv
         MNqeMArZ0ccUdiRI5FFjLB8ywhFvOxV83DjBSNn3nVnKt3YPEV0zQHNJVCjBsnDha5Bd
         1GmRBFfV9CTLV87RqkPIQ63KDMWpV9rikWPV+HsaAyLD+SZdfEH0/rCN4nOcC3P6/UJ4
         gqWQ==
X-Gm-Message-State: ACrzQf3EZe8lDnbuUHnFP78SjbUwdGcFAh1ietbnupWG32+tgPikhBPE
        Sz+fSOmE0S72MI5FtDdeTOAV
X-Google-Smtp-Source: AMsMyM54CWyBk4TvLqKM0kCdmNpeBWyLDMlWh55Ntk+biSUah5rCsEOht738OFK0w9dK2KGfEeYZzA==
X-Received: by 2002:a17:903:2c2:b0:182:df88:e6d3 with SMTP id s2-20020a17090302c200b00182df88e6d3mr28273709plk.81.1667459435320;
        Thu, 03 Nov 2022 00:10:35 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.64])
        by smtp.gmail.com with ESMTPSA id s9-20020a170903214900b00186748fe6ccsm9451244ple.214.2022.11.03.00.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 00:10:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 12/12] arm64: dts: qcom: sc8280xp-x13s: Add thermal zone support
Date:   Thu,  3 Nov 2022 12:39:11 +0530
Message-Id: <20221103070911.20019-13-manivannan.sadhasivam@linaro.org>
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
index fdeb7718a596..7d2b53ceaa54 100644
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

