Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6511A61205A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 07:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiJ2FPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 01:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJ2FPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 01:15:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85E06069D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 17so2190126pfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1RKtSeGBWRwRID09716W7BxvRPtXtLZIH1JuwC4u5k=;
        b=ndpS8QyRAYJP0b3/4viVqp4LveScTVv4ndPUVuXsb2l/nSs/V8En6yX1BNbUzYkH89
         7+sWqsnsnQ708+LfNZvJLAUHlQV+DrPpb1lMYhmJDoxJ7J9Kyf65NRHEFK217C5geFKH
         K14o5aeT+6eqX/X6WfgyoJtc8WHz/Vj3QrKFjxHHTTj9dEPS2lqtWhSZWl2aZQfAs6m3
         OvK/S9KZ5HNW+FuQWhUgDe92BzNky52aMtxHnc1p6YuGxDnYiBNM0RBu0W2WARcIZ2BI
         4jigX1K5ViF3aERS0jBN34aJlauWPxVq+2MyRX3FO7zt6L7dYxhXjohmV+UMnXGgK8PC
         3aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1RKtSeGBWRwRID09716W7BxvRPtXtLZIH1JuwC4u5k=;
        b=B9G1JOxnlpNkHS8xH3N5bZDjB0RiIsRtjpqSOpTDNgdX86S3euZTC/y1j+N5LibPzW
         XKGnga9i4V8sdYb5ptUffwER+NpiCrzlJD/2MQtBkV63hwUAVAFMD+lE3kMadKHS4TLT
         xBzjygNytyXLb+YVGOUUiIYzZ6QrJ5yUfrX10UWdleby/KaDRoO3tKrPzSCZmzsdPsXx
         xrUXRADNy2oeNIegr+cShkHBgPQA2XZwj8EbUZSRidJSwU/hrOyI8J8urZgyp+S+VRgQ
         kD6jPScC0UQxEIVt6TyK3T8gBUBhFoY+2arLO/dqNKVAdMhEcPBpQ++iaTWNDFaK2w1f
         TVYQ==
X-Gm-Message-State: ACrzQf1YH5hkTL1VYjU227t5xfDrR4guotz0B4ucSuY3HPO08wKG18FW
        PcUMMkmIu4/t22TectsIhlU5
X-Google-Smtp-Source: AMsMyM4YQD+8OjeSOuE0TprlgSLpqBYoWVvkyQ4rqZ+cDJ42uRqnwstxsBwRQRWK1RoB/9Jqk7mMWQ==
X-Received: by 2002:a63:91:0:b0:461:f509:2a31 with SMTP id 139-20020a630091000000b00461f5092a31mr2677317pga.108.1667020509410;
        Fri, 28 Oct 2022 22:15:09 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.167])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b0017e9b820a1asm363150plg.100.2022.10.28.22.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 22:15:08 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 01/12] dt-bindings: iio: qcom: adc7-pm8350: Allow specifying SID for channels
Date:   Sat, 29 Oct 2022 10:44:38 +0530
Message-Id: <20221029051449.30678-2-manivannan.sadhasivam@linaro.org>
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

As per the new ADC7 architecture used by the Qualcomm PMICs, each PMIC
has the static Slave ID (SID) assigned by default. The primary PMIC
PMK8350 is responsible for collecting the temperature/voltage data from
the slave PMICs and exposing them via it's registers.

For getting the measurements from the slave PMICs, PMK8350 uses the
channel ID encoded with the SID of the relevant PMIC. So far, the
dt-binding for the slave PMIC PM8350 assumed that there will be only
one PM8350 in a system. So it harcoded SID 1 with channel IDs.

But this got changed in platforms such as Lenovo X13s where there are a
couple of PM8350 PMICs available. So to address multiple PM8350s, change
the binding to accept the SID specified by the user and use it for
encoding the channel ID.

It should be noted that, even though the SID is static it is not
globally unique. Only the primary PMIC has the unique SID id 0.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |  6 +-
 .../dt-bindings/iio/qcom,spmi-adc7-pm8350.h   | 90 +++++++++----------
 2 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index feb390d50696..d20569b9b763 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -222,8 +222,8 @@ examples:
                 qcom,hw-settle-time = <200>;
             };
 
-            conn-therm@47 {
-                reg = <PM8350_ADC7_AMUX_THM4_100K_PU>;
+            conn-therm@147 {
+                reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
                 qcom,ratiometric;
                 qcom,hw-settle-time = <200>;
             };
@@ -247,7 +247,7 @@ examples:
 
             conn-therm@1 {
                 reg = <1>;
-                io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU>;
+                io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
                 qcom,avg-samples = <2>;
                 qcom,ratiometric;
                 qcom,hw-settle-time-us = <200>;
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
index 9426f27a1946..09fd169ad18e 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
@@ -6,62 +6,58 @@
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
 #define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
 
-#ifndef PM8350_SID
-#define PM8350_SID					1
-#endif
-
 /* ADC channels for PM8350_ADC for PMIC7 */
-#define PM8350_ADC7_REF_GND			(PM8350_SID << 8 | 0x0)
-#define PM8350_ADC7_1P25VREF			(PM8350_SID << 8 | 0x01)
-#define PM8350_ADC7_VREF_VADC			(PM8350_SID << 8 | 0x02)
-#define PM8350_ADC7_DIE_TEMP			(PM8350_SID << 8 | 0x03)
-
-#define PM8350_ADC7_AMUX_THM1			(PM8350_SID << 8 | 0x04)
-#define PM8350_ADC7_AMUX_THM2			(PM8350_SID << 8 | 0x05)
-#define PM8350_ADC7_AMUX_THM3			(PM8350_SID << 8 | 0x06)
-#define PM8350_ADC7_AMUX_THM4			(PM8350_SID << 8 | 0x07)
-#define PM8350_ADC7_AMUX_THM5			(PM8350_SID << 8 | 0x08)
-#define PM8350_ADC7_GPIO1			(PM8350_SID << 8 | 0x0a)
-#define PM8350_ADC7_GPIO2			(PM8350_SID << 8 | 0x0b)
-#define PM8350_ADC7_GPIO3			(PM8350_SID << 8 | 0x0c)
-#define PM8350_ADC7_GPIO4			(PM8350_SID << 8 | 0x0d)
+#define PM8350_ADC7_REF_GND(sid)			((sid) << 8 | 0x0)
+#define PM8350_ADC7_1P25VREF(sid)			((sid) << 8 | 0x01)
+#define PM8350_ADC7_VREF_VADC(sid)			((sid) << 8 | 0x02)
+#define PM8350_ADC7_DIE_TEMP(sid)			((sid) << 8 | 0x03)
+
+#define PM8350_ADC7_AMUX_THM1(sid)			((sid) << 8 | 0x04)
+#define PM8350_ADC7_AMUX_THM2(sid)			((sid) << 8 | 0x05)
+#define PM8350_ADC7_AMUX_THM3(sid)			((sid) << 8 | 0x06)
+#define PM8350_ADC7_AMUX_THM4(sid)			((sid) << 8 | 0x07)
+#define PM8350_ADC7_AMUX_THM5(sid)			((sid) << 8 | 0x08)
+#define PM8350_ADC7_GPIO1(sid)				((sid) << 8 | 0x0a)
+#define PM8350_ADC7_GPIO2(sid)				((sid) << 8 | 0x0b)
+#define PM8350_ADC7_GPIO3(sid)				((sid) << 8 | 0x0c)
+#define PM8350_ADC7_GPIO4(sid)				((sid) << 8 | 0x0d)
 
 /* 30k pull-up1 */
-#define PM8350_ADC7_AMUX_THM1_30K_PU		(PM8350_SID << 8 | 0x24)
-#define PM8350_ADC7_AMUX_THM2_30K_PU		(PM8350_SID << 8 | 0x25)
-#define PM8350_ADC7_AMUX_THM3_30K_PU		(PM8350_SID << 8 | 0x26)
-#define PM8350_ADC7_AMUX_THM4_30K_PU		(PM8350_SID << 8 | 0x27)
-#define PM8350_ADC7_AMUX_THM5_30K_PU		(PM8350_SID << 8 | 0x28)
-#define PM8350_ADC7_GPIO1_30K_PU		(PM8350_SID << 8 | 0x2a)
-#define PM8350_ADC7_GPIO2_30K_PU		(PM8350_SID << 8 | 0x2b)
-#define PM8350_ADC7_GPIO3_30K_PU		(PM8350_SID << 8 | 0x2c)
-#define PM8350_ADC7_GPIO4_30K_PU		(PM8350_SID << 8 | 0x2d)
+#define PM8350_ADC7_AMUX_THM1_30K_PU(sid)		((sid) << 8 | 0x24)
+#define PM8350_ADC7_AMUX_THM2_30K_PU(sid)		((sid) << 8 | 0x25)
+#define PM8350_ADC7_AMUX_THM3_30K_PU(sid)		((sid) << 8 | 0x26)
+#define PM8350_ADC7_AMUX_THM4_30K_PU(sid)		((sid) << 8 | 0x27)
+#define PM8350_ADC7_AMUX_THM5_30K_PU(sid)		((sid) << 8 | 0x28)
+#define PM8350_ADC7_GPIO1_30K_PU(sid)			((sid) << 8 | 0x2a)
+#define PM8350_ADC7_GPIO2_30K_PU(sid)			((sid) << 8 | 0x2b)
+#define PM8350_ADC7_GPIO3_30K_PU(sid)			((sid) << 8 | 0x2c)
+#define PM8350_ADC7_GPIO4_30K_PU(sid)			((sid) << 8 | 0x2d)
 
 /* 100k pull-up2 */
-#define PM8350_ADC7_AMUX_THM1_100K_PU		(PM8350_SID << 8 | 0x44)
-#define PM8350_ADC7_AMUX_THM2_100K_PU		(PM8350_SID << 8 | 0x45)
-#define PM8350_ADC7_AMUX_THM3_100K_PU		(PM8350_SID << 8 | 0x46)
-#define PM8350_ADC7_AMUX_THM4_100K_PU		(PM8350_SID << 8 | 0x47)
-#define PM8350_ADC7_AMUX_THM5_100K_PU		(PM8350_SID << 8 | 0x48)
-#define PM8350_ADC7_GPIO1_100K_PU		(PM8350_SID << 8 | 0x4a)
-#define PM8350_ADC7_GPIO2_100K_PU		(PM8350_SID << 8 | 0x4b)
-#define PM8350_ADC7_GPIO3_100K_PU		(PM8350_SID << 8 | 0x4c)
-#define PM8350_ADC7_GPIO4_100K_PU		(PM8350_SID << 8 | 0x4d)
+#define PM8350_ADC7_AMUX_THM1_100K_PU(sid)		((sid) << 8 | 0x44)
+#define PM8350_ADC7_AMUX_THM2_100K_PU(sid)		((sid) << 8 | 0x45)
+#define PM8350_ADC7_AMUX_THM3_100K_PU(sid)		((sid) << 8 | 0x46)
+#define PM8350_ADC7_AMUX_THM4_100K_PU(sid)		((sid) << 8 | 0x47)
+#define PM8350_ADC7_AMUX_THM5_100K_PU(sid)		((sid) << 8 | 0x48)
+#define PM8350_ADC7_GPIO1_100K_PU(sid)			((sid) << 8 | 0x4a)
+#define PM8350_ADC7_GPIO2_100K_PU(sid)			((sid) << 8 | 0x4b)
+#define PM8350_ADC7_GPIO3_100K_PU(sid)			((sid) << 8 | 0x4c)
+#define PM8350_ADC7_GPIO4_100K_PU(sid)			((sid) << 8 | 0x4d)
 
 /* 400k pull-up3 */
-#define PM8350_ADC7_AMUX_THM1_400K_PU		(PM8350_SID << 8 | 0x64)
-#define PM8350_ADC7_AMUX_THM2_400K_PU		(PM8350_SID << 8 | 0x65)
-#define PM8350_ADC7_AMUX_THM3_400K_PU		(PM8350_SID << 8 | 0x66)
-#define PM8350_ADC7_AMUX_THM4_400K_PU		(PM8350_SID << 8 | 0x67)
-#define PM8350_ADC7_AMUX_THM5_400K_PU		(PM8350_SID << 8 | 0x68)
-#define PM8350_ADC7_GPIO1_400K_PU		(PM8350_SID << 8 | 0x6a)
-#define PM8350_ADC7_GPIO2_400K_PU		(PM8350_SID << 8 | 0x6b)
-#define PM8350_ADC7_GPIO3_400K_PU		(PM8350_SID << 8 | 0x6c)
-#define PM8350_ADC7_GPIO4_400K_PU		(PM8350_SID << 8 | 0x6d)
+#define PM8350_ADC7_AMUX_THM1_400K_PU(sid)		((sid) << 8 | 0x64)
+#define PM8350_ADC7_AMUX_THM2_400K_PU(sid)		((sid) << 8 | 0x65)
+#define PM8350_ADC7_AMUX_THM3_400K_PU(sid)		((sid) << 8 | 0x66)
+#define PM8350_ADC7_AMUX_THM4_400K_PU(sid)		((sid) << 8 | 0x67)
+#define PM8350_ADC7_AMUX_THM5_400K_PU(sid)		((sid) << 8 | 0x68)
+#define PM8350_ADC7_GPIO1_400K_PU(sid)			((sid) << 8 | 0x6a)
+#define PM8350_ADC7_GPIO2_400K_PU(sid)			((sid) << 8 | 0x6b)
+#define PM8350_ADC7_GPIO3_400K_PU(sid)			((sid) << 8 | 0x6c)
+#define PM8350_ADC7_GPIO4_400K_PU(sid)			((sid) << 8 | 0x6d)
 
 /* 1/3 Divider */
-#define PM8350_ADC7_GPIO4_DIV3			(PM8350_SID << 8 | 0x8d)
+#define PM8350_ADC7_GPIO4_DIV3(sid)			((sid) << 8 | 0x8d)
 
-#define PM8350_ADC7_VPH_PWR			(PM8350_SID << 8 | 0x8e)
+#define PM8350_ADC7_VPH_PWR(sid)			((sid) << 8 | 0x8e)
 
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H */
-- 
2.25.1

