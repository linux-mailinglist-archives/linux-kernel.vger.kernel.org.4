Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF49617A73
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKCJ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiKCJ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:59:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD33D1054D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:59:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q71so1214212pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 02:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=armaKSmpSTh8RxIedmjX+VLdFnheOMOEqRVNaKfmRgQ=;
        b=hT/ik8gKBFkvZAAdFsi1VGucXUWf4gjYU0GBEnUDjuJfIHXHnjZ6AnSKSHn0NGwKOe
         xCSLTitQ9fP0hhW1XTOxqtZpymST7RBvVb7o8YtdRE3LVUb/cFncxN1N4o8CbjLGWys0
         ppNNV0ICbhN8Vmpy4gfQJ01Zp855ZIgyXPUBY2iTzsDP2dq4EISeMoqg+ACWubjHFJoW
         vuBBnX7LC+nB0tlelTi2SnDsw1a38L8ygwO19dR/YY18aEffuKKHa2bSWd/0kxHK6dYC
         64CCqFsEc+xPcCxupuGROq/JJvEaPsl4uFTQU9qFymfVzfCgu2DjDqZwkT0UvB1+qSGi
         +jbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=armaKSmpSTh8RxIedmjX+VLdFnheOMOEqRVNaKfmRgQ=;
        b=PDsVP8v9zyX4QvdIwrpg67fmzS25kv/LmP7X5Mwg248x1NhsRFiTlGiSW/Hr6EoOOF
         ehM4At5s7CAhiB+H8sTm2/y5+4I2IuJFBegNH2Yk8jjF3DDbaiWMD2GIhZd0VyZvpctV
         7swecFGNFzUZSC1mFr49uhLpbjzGlp4Ov55q3w8GvPEvkb2EscI0VdLa8GH5VsKwMjrd
         MCZFK/OLORq41v5PYidzKMXUZ1MQBu7CPXRYDU2PwJLUb/xmAaCu6X6y3zcJktmA1Hqf
         QyekTzHugvM+Uwm/uuKr2TjvERbMHKMLkE8EysNqm4fU3BCCq3v9SSa9uOTgjmndYS7C
         +47A==
X-Gm-Message-State: ACrzQf1LZ43mvl7CD2URQtrl3/lmUYaS8+KGdtq09IVHPpaGgEqivwi2
        nitxNJIDSTkdw/DrsBh+hGB+
X-Google-Smtp-Source: AMsMyM7AaGbDh5mf+GqJWyENh/4pyPecDLXdZcI4wewi3P4UQFH/jIK1OOQfV6IX8+h6r6a/YxgjOw==
X-Received: by 2002:a63:544e:0:b0:46f:7b0e:e4f with SMTP id e14-20020a63544e000000b0046f7b0e0e4fmr25825627pgm.92.1667469548276;
        Thu, 03 Nov 2022 02:59:08 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.64])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b00186c54188b4sm161670plf.240.2022.11.03.02.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:59:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 08/12] arm64: dts: qcom: sc8280xp-x13s: Add PMK8280 VADC channels
Date:   Thu,  3 Nov 2022 15:28:06 +0530
Message-Id: <20221103095810.64606-9-manivannan.sadhasivam@linaro.org>
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

Add VADC channels for measuring the on-chip die temperature and external
crystal osciallator temperature of PMK8280.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 6aa8cf6d9776..9e1180b468d4 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc8280xp.dtsi"
@@ -173,6 +174,21 @@ &pmk8280_pon_resin {
 	status = "okay";
 };
 
+&pmk8280_vadc {
+	status = "okay";
+
+	pmic-die-temp@3 {
+		reg = <PMK8350_ADC7_DIE_TEMP>;
+		qcom,pre-scaling = <1 1>;
+	};
+
+	xo-therm@44 {
+		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+	};
+};
+
 &qup0 {
 	status = "okay";
 };
-- 
2.25.1

