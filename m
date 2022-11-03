Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39E7617A68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiKCJ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiKCJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:59:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A03DC778
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:58:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l2so1396462pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeYJbVuqGDHsqyzLjF7twJNYqifLyyH6qytnIHxb/r8=;
        b=TlHdsmUsbQTX+8RUr7LDQ9Nmjh1YY6/jN4twIOVT7W6kZk7/N6NgTFR6gM+846Jlqv
         V7woKLUFkxTuWEDE3E/SZoPJdNYAxlLpaaGSIHDItwFFxjiQiLRjd35Q0sZE02QslK7v
         Nvr7dkLO1IMwLaNxd6syj4UqR9LYHk0OuxUzHJTNTltk+vrFov6gZnptYa2SRylY+A7o
         U7O+scY/UO8JtVawcfbixLrCBJJKZEfJHF4zKidTZVg38juwpj8Q9vxN4FyiJE5k6TPC
         dZ/nKsW5R7bg/7wnfDbVOiPc7mDGRMyol6VgCynI3Lqy+s29w4mKL9k+L21ly0yII3Bd
         ANhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeYJbVuqGDHsqyzLjF7twJNYqifLyyH6qytnIHxb/r8=;
        b=zla8qdeayBtAj73O4PcTCQGdo2K6LdztpM77iFFzhxpwdp4Zbt8vs0Raam9fPn5i6N
         eIQ++FvcseM14WQBvzlPWLsA5oPiOYtSQAf1D1XlYTgZ7hlG6GHjl72XTqrPAbxnt6/W
         RY+8vqZ0Cmn5MsRzqzyN0+sXbbA21wv+465sIAt0v89PApKXREdLAVQgzYVuTsyBv8uB
         F86wC1wQ8Xjk4nQ+JTGL3BymxwlKqkkNqvgy7Yc40FJ6lrAIw9j5RsWS/sW9FliKY3Rm
         ShXBwPnD89WP8yCDOVLphP74r6wH7Qjm7L/2tZG9wqNCRGCr1+zZYn5Gm973EAbKpON7
         RxMA==
X-Gm-Message-State: ACrzQf1zD8mPSlUy+vK3X9XoY6jwXa3woa1rbH6tPGcLR7lRJ+VCoY92
        bfqDJ8Aw+2VVVhOq0S0Wk5c/
X-Google-Smtp-Source: AMsMyM7ANYMLT4destN4DCR37dCq6zAu6QGsrlnUHAivO2i1lwZPF0m5qixqkf6et0S1Hqq+YMFjAw==
X-Received: by 2002:a17:902:dac3:b0:186:a437:f4b9 with SMTP id q3-20020a170902dac300b00186a437f4b9mr29006746plx.29.1667469536694;
        Thu, 03 Nov 2022 02:58:56 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.64])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b00186c54188b4sm161670plf.240.2022.11.03.02.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:58:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 06/12] arm64: dts: qcom: sc8280xp-pmics: Add support for TM5 block in PMK8280
Date:   Thu,  3 Nov 2022 15:28:04 +0530
Message-Id: <20221103095810.64606-7-manivannan.sadhasivam@linaro.org>
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

Thermal Monitoring block ADC5 (TM5) in PMK8280 can be used to monitor the
temperature from secondary PMICs like PM8280.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index b1cdde2f7861..f2c0b71b5d8e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -85,6 +85,16 @@ pmk8280_vadc: adc@3100 {
 			#io-channel-cells = <1>;
 			status = "disabled";
 		};
+
+		pmk8280_adc_tm: adc-tm@3400 {
+			compatible = "qcom,spmi-adc-tm5-gen2";
+			reg = <0x3400>;
+			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#thermal-sensor-cells = <1>;
+			status = "disabled";
+		};
 	};
 
 	pmc8280_1: pmic@1 {
-- 
2.25.1

