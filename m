Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA8612076
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 07:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJ2FQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 01:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJ2FQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 01:16:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF6D12908B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so11655329pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oG+CRaVcqYBbm4D8Yfx9jHp7jDERA+/Wzp95brL2NNE=;
        b=pcDQZczNVmyzX7iGp8KQ6mKNbirS/2sewuyCEzhqgxSUsicd/GOQF8ZEKKL3UdwT4l
         j9gJJJjsXtPFyLLdPJKUFgWTXrEQbVf0X9w7q4P4Oor5V+ckElY0Hof7xgo6MUx4qt6R
         +QDhO2s8/b3wp/rjpmB9rmLNoPxJDyuVZO5EqAewJxsKP3zzK5+z85EPkHX+3a58k0Tr
         W6AGPqj8zLU5U2AsbR+Ta5azL3PWIStkGjZycej1OyMjbjkEhTVp9N7nrkPcoP24zVVJ
         CshMUW3dZ7al3JqGaxxuz68tcFyyfdndCHUN37oibrA9ZSCAvC5q3Bl5rqks8RA4zBba
         3iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oG+CRaVcqYBbm4D8Yfx9jHp7jDERA+/Wzp95brL2NNE=;
        b=OZFwsfuzvMx1jrtb2GL5JJCAxrb20uCqo8oxyb18f4fqy/j6zB5Z7I8YQ4RBH+bUSY
         hFaXXNbKdWHbT0FpKIffrpbHc72Bkb5tc1GXzB7duD3dcuIBF4rsMDE5oSZLslewl8cL
         Z9ICmwl960S3drshl1ruyqYiy2owflwPEMgZ7A86P/vGvfIp0hnx/vLNkJb22yvUHaim
         MpZ819ufB6Qv/ft5bRpILL/7+jqSKheL4gCALd8no0U2b2sFv/UhNHWzUeidLQhuHY+C
         cwSiVeRHRFR32MWKopRZNkEsR9B646qch2CJapH6eStVCmTEJIEc4CoK7HE3cPjcNSMR
         f7hw==
X-Gm-Message-State: ACrzQf0PJx9WaB9utI/Ul3cGu1szNSbnbwVRi1kb1TK1DnP025BTB/m7
        jLwmOKZdeIZ/1FYeRvFZ3jOW
X-Google-Smtp-Source: AMsMyM5OWmnofo49Y+/SzTJA6D32lPWyPowypy7DwSlYUTAqiTHXn/8CO46xXpc2f1+KpDMyR/OqcA==
X-Received: by 2002:a17:902:c7c4:b0:186:5ebe:38e with SMTP id r4-20020a170902c7c400b001865ebe038emr2685918pla.33.1667020555301;
        Fri, 28 Oct 2022 22:15:55 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.167])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b0017e9b820a1asm363150plg.100.2022.10.28.22.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 22:15:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 10/12] arm64: dts: qcom: sc8280xp-x13s: Add PMR735A VADC channel
Date:   Sat, 29 Oct 2022 10:44:47 +0530
Message-Id: <20221029051449.30678-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
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

Add VADC channel of PMR735A for measuring the on-chip die temperature.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 250e1489f029..9545b471c2fa 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
 #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc8280xp.dtsi"
@@ -250,6 +251,12 @@ sys-therm@347 {
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 	};
+
+	pmic-die-temp@403 {
+		reg = <PMR735A_ADC7_DIE_TEMP>;
+		label = "pmr735a_die_temp";
+		qcom,pre-scaling = <1 1>;
+	};
 };
 
 &qup0 {
-- 
2.25.1

