Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7779D60F02E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiJ0Gad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiJ0GaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:30:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67709AB82E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:30:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e129so367278pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBi2Xfj3W+jjbTJxzPJ9SgBb72Uc/kJB+XX+Hh7W9T0=;
        b=a0iUSJ9jva9jZz4oFXdlMyzmq8rNbGfZ4as1KC/CPsT9TGmOFfEwQnK3ylrCS4SckQ
         rvySXNQQqGSWfEUWQBESjGA3p4FI1U+BbZloLlzo2Q+gX7DELfkjPRAYIzEm31TdxN+7
         VBcPYP9qLC/qCkUqeWHKnyR+YIavpTBk225UrFosPW6qACAhYRFnjNtVBYL6Hk1umoUq
         rHoth5BMjHKGkZtMOETpIDE07UhSmn0RNvkrhk8Dc/ahVODOMgAY17PAiMRiCYgnwQ7N
         cyOmaiGb6CrBNEsyQdROOlwPtb74oPIixgizP0QO1FxJ15GNflXf3mASaKAi8ZtAsqxv
         TgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBi2Xfj3W+jjbTJxzPJ9SgBb72Uc/kJB+XX+Hh7W9T0=;
        b=4rmCpdrSbszTFdP8ulYO4mGU6xKFogyh0BQ7qYMpK7YkH/NqShZIC/Yn8t9ca8XHWO
         wHHwswuwn2qzRwXLF8q/s2w5P4j73P8hl192VNC1H1D90srAdqT8lC6HFP0E45yjzQDc
         mptFVgfq84yCLmxbeABhikpxAOKkQX6r9ch6BAbWFTG4cRx2+t8AA3y/RDA/ygRWO7f4
         hYBNevnreDGcrw6uKi9THrkxefQlmwxhTV175VEtllsv8q51Be9ddfoyjZtBajh7zG+K
         NAU0SSJxlWIa0WyBlcZ8ECRGHLNlT+RepwvqE2PWj+V9wQ19T7tL2VTCH1/QbWikMfGP
         55Vw==
X-Gm-Message-State: ACrzQf02UJB5w5ASRPZlOIOCj3q9Rpb9zY7IKMG7IPfNK3iGfb6SEIJr
        9jMcVXObNFBmfOKS0qqxEC+4
X-Google-Smtp-Source: AMsMyM4agvX2oS3U8DzR25c60c1h5ILvxBKgap1ahjb5V7cXjlUCYD0I4QXsmyvFH6gRu/k0FUIkxg==
X-Received: by 2002:a63:4753:0:b0:462:b3f0:a984 with SMTP id w19-20020a634753000000b00462b3f0a984mr39624442pgk.501.1666852221767;
        Wed, 26 Oct 2022 23:30:21 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.123])
        by smtp.gmail.com with ESMTPSA id i126-20020a626d84000000b00561d79f1064sm446041pfc.57.2022.10.26.23.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 23:30:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 01/11] dt-bindings: iio: qcom: adc7-pm8350: Allow specifying SID for channels
Date:   Thu, 27 Oct 2022 11:59:56 +0530
Message-Id: <20221027063006.9056-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
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
index 9426f27a1946..50de5adfe6ac 100644
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
+#define PM8350_ADC7_REF_GND(sid)			(sid << 8 | 0x0)
+#define PM8350_ADC7_1P25VREF(sid)			(sid << 8 | 0x01)
+#define PM8350_ADC7_VREF_VADC(sid)			(sid << 8 | 0x02)
+#define PM8350_ADC7_DIE_TEMP(sid)			(sid << 8 | 0x03)
+
+#define PM8350_ADC7_AMUX_THM1(sid)			(sid << 8 | 0x04)
+#define PM8350_ADC7_AMUX_THM2(sid)			(sid << 8 | 0x05)
+#define PM8350_ADC7_AMUX_THM3(sid)			(sid << 8 | 0x06)
+#define PM8350_ADC7_AMUX_THM4(sid)			(sid << 8 | 0x07)
+#define PM8350_ADC7_AMUX_THM5(sid)			(sid << 8 | 0x08)
+#define PM8350_ADC7_GPIO1(sid)				(sid << 8 | 0x0a)
+#define PM8350_ADC7_GPIO2(sid)				(sid << 8 | 0x0b)
+#define PM8350_ADC7_GPIO3(sid)				(sid << 8 | 0x0c)
+#define PM8350_ADC7_GPIO4(sid)				(sid << 8 | 0x0d)
 
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
+#define PM8350_ADC7_AMUX_THM1_30K_PU(sid)		(sid << 8 | 0x24)
+#define PM8350_ADC7_AMUX_THM2_30K_PU(sid)		(sid << 8 | 0x25)
+#define PM8350_ADC7_AMUX_THM3_30K_PU(sid)		(sid << 8 | 0x26)
+#define PM8350_ADC7_AMUX_THM4_30K_PU(sid)		(sid << 8 | 0x27)
+#define PM8350_ADC7_AMUX_THM5_30K_PU(sid)		(sid << 8 | 0x28)
+#define PM8350_ADC7_GPIO1_30K_PU(sid)			(sid << 8 | 0x2a)
+#define PM8350_ADC7_GPIO2_30K_PU(sid)			(sid << 8 | 0x2b)
+#define PM8350_ADC7_GPIO3_30K_PU(sid)			(sid << 8 | 0x2c)
+#define PM8350_ADC7_GPIO4_30K_PU(sid)			(sid << 8 | 0x2d)
 
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
+#define PM8350_ADC7_AMUX_THM1_100K_PU(sid)		(sid << 8 | 0x44)
+#define PM8350_ADC7_AMUX_THM2_100K_PU(sid)		(sid << 8 | 0x45)
+#define PM8350_ADC7_AMUX_THM3_100K_PU(sid)		(sid << 8 | 0x46)
+#define PM8350_ADC7_AMUX_THM4_100K_PU(sid)		(sid << 8 | 0x47)
+#define PM8350_ADC7_AMUX_THM5_100K_PU(sid)		(sid << 8 | 0x48)
+#define PM8350_ADC7_GPIO1_100K_PU(sid)			(sid << 8 | 0x4a)
+#define PM8350_ADC7_GPIO2_100K_PU(sid)			(sid << 8 | 0x4b)
+#define PM8350_ADC7_GPIO3_100K_PU(sid)			(sid << 8 | 0x4c)
+#define PM8350_ADC7_GPIO4_100K_PU(sid)			(sid << 8 | 0x4d)
 
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
+#define PM8350_ADC7_AMUX_THM1_400K_PU(sid)		(sid << 8 | 0x64)
+#define PM8350_ADC7_AMUX_THM2_400K_PU(sid)		(sid << 8 | 0x65)
+#define PM8350_ADC7_AMUX_THM3_400K_PU(sid)		(sid << 8 | 0x66)
+#define PM8350_ADC7_AMUX_THM4_400K_PU(sid)		(sid << 8 | 0x67)
+#define PM8350_ADC7_AMUX_THM5_400K_PU(sid)		(sid << 8 | 0x68)
+#define PM8350_ADC7_GPIO1_400K_PU(sid)			(sid << 8 | 0x6a)
+#define PM8350_ADC7_GPIO2_400K_PU(sid)			(sid << 8 | 0x6b)
+#define PM8350_ADC7_GPIO3_400K_PU(sid)			(sid << 8 | 0x6c)
+#define PM8350_ADC7_GPIO4_400K_PU(sid)			(sid << 8 | 0x6d)
 
 /* 1/3 Divider */
-#define PM8350_ADC7_GPIO4_DIV3			(PM8350_SID << 8 | 0x8d)
+#define PM8350_ADC7_GPIO4_DIV3(sid)			(sid << 8 | 0x8d)
 
-#define PM8350_ADC7_VPH_PWR			(PM8350_SID << 8 | 0x8e)
+#define PM8350_ADC7_VPH_PWR(sid)			(sid << 8 | 0x8e)
 
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H */
-- 
2.25.1

