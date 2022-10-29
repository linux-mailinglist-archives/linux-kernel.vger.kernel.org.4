Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13125612073
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 07:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJ2FQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 01:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJ2FP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 01:15:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9F61D374E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so11656332pjk.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lacf58udOIotYpm9O1+kpxWuSMQ/so9proy5x8qUsKM=;
        b=BKW2GRUYUcvNwgRC9PoWD+SZ9gBFBHy+flAlJ4Il9EVWFDpcSWj+6BUJz6gmTbGA5x
         nPJkY6xM+rZxoBxGAx90lS0yhbUXSylCXHy62p3QfWtZUlH4PEprv3e/hKGTFq3CTo2/
         QzO0B2TQnH2EkdeMvdsiRNGd5X8VNsyoBXbmeA0OspUNjvT7UkfeIgNBAvTJfUWdB84A
         JbpdyhcSu+KYYfa8s1S6GuJL0vc4YhHycg7+g9FzfHUruTn68imOC9noU9AY9EwtnBKx
         U68+u2tjlWThbrUXg5zMLQ0H7P+miUOy9633qv3PXzegq9KTxy5zJuUsA9TQgZAALQOU
         tfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lacf58udOIotYpm9O1+kpxWuSMQ/so9proy5x8qUsKM=;
        b=Lnrnz9gfxrBhanM38qCr45kiuG5FA42gXk1AtMXCPFbfpi46YKNb41s6NyY0uS0IRR
         mDC4RQdwF0eLBptNk4huH6rQ9ELgDZ/y3mL0vOilH6co+Mik1qMRL10wq/52FDQ7NQPJ
         KtZwQJ5y9pWu0muN2M6n3mpJBxb+kXXPB2tWHG0ZXp2MleMWKkHGR8B3gDM2BWth+WMs
         /6+qVpRvW/PQRI1OYQdPCowdOIcGTyjzMl5bgTLlhW+DE2XZWvX5iU5L7E/5tAECt/pA
         ec0VPseietYG0BFSUmNPapqOVIRditOyOOqsThYaLbYqyTku0IYbBHGNRC/thvRFX4kM
         QPMQ==
X-Gm-Message-State: ACrzQf2ngi9pPa6EUaGZK8xfrthkqAeYX2oPEp34EE8AylcH1/QLAeYt
        8uefjRzNswlj2+8y5uXb9OL3
X-Google-Smtp-Source: AMsMyM7OJNpCK0PJHyp8EhfJ/Cik8xFsVLDBJBAL+G2uR+Z7kjOTnIVFJXvehnk5qUWjWaCi7xZMAw==
X-Received: by 2002:a17:90b:1d0f:b0:20d:1ec3:f732 with SMTP id on15-20020a17090b1d0f00b0020d1ec3f732mr2980176pjb.84.1667020550291;
        Fri, 28 Oct 2022 22:15:50 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.167])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b0017e9b820a1asm363150plg.100.2022.10.28.22.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 22:15:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 09/12] arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2} VADC channels
Date:   Sat, 29 Oct 2022 10:44:46 +0530
Message-Id: <20221029051449.30678-10-manivannan.sadhasivam@linaro.org>
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

Add VADC channels of PM8280_{1/2} PMICs for measuring the on-chip die
temperature and external thermistors connected to the AMUX pins.

The measurements are collected by the primary PMIC PMK8280 from the
secondary PMICs PM8280_{1/2} and exposed over the PMK8280's VADC channels.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 18315743313b..250e1489f029 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
 #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
@@ -189,6 +190,66 @@ xo-therm@44 {
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 	};
+
+	pmic-die-temp@103 {
+		reg = <PM8350_ADC7_DIE_TEMP(1)>;
+		label = "pm8280_1_die_temp";
+		qcom,pre-scaling = <1 1>;
+	};
+
+	sys-therm@144 {
+		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	sys-therm@145 {
+		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	sys-therm@146 {
+		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	sys-therm@147 {
+		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pmic-die-temp@303 {
+		reg = <PM8350_ADC7_DIE_TEMP(3)>;
+		label = "pm8250_2_die_temp";
+		qcom,pre-scaling = <1 1>;
+	};
+
+	sys-therm@344 {
+		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(3)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	sys-therm@345 {
+		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(3)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	sys-therm@346 {
+		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(3)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	sys-therm@347 {
+		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(3)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
 };
 
 &qup0 {
-- 
2.25.1

