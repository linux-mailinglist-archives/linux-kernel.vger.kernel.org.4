Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E0D6B21A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCIKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjCIKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:38:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC407DB2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:38:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so3221185wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678358279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEdI6IptwEvOPoe2m8zVGUNDSr2cKpU09XYXcL318IQ=;
        b=2zMfCQfhjF/vXXLxR4n7qE1iv1DxbZkKshTMJ0BOqQUyJ0f14N6J1vjPAvd8Qc4/pq
         KTfZA3VR1M3dZGA7sEQ1J8C++7+68DInTmMlsRMiDKP5iXZXINExitdd5mdyWd4gO8rC
         CJU3WJ99/c7uFucsqea+Gl4JRTuz1vuyOjc2wZxa3J4ztIJjLCc0x+Ks8SzjKLGSy2uh
         /GU1l/CAZoAhjTUHPP3v3jg6ZvFth34PkfZ7Grhb7PibJOeJv93m8SsN85tNslSFzJSU
         gOFpfyhNH53zgd4NGhlF2jjMdD7t7BAlQ+ZXeKekdp+EalQ01N1sm2ISwgTekrVYhf29
         q32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEdI6IptwEvOPoe2m8zVGUNDSr2cKpU09XYXcL318IQ=;
        b=ZDd0lr+NiAjvMD+3A5TF/h22vOYD3Wg+qug047TMS8CxUt24cixmIJGed6TICJF0II
         mn/vgQifCSvyBmB0Nh08DAdGsFzHSqjO0/mXWYmi/d1MDajZloyMjkcVYroja49nM2OF
         QpnOnfu0FsDdjQpTLJ9TwHkZDW3+vkPHpCD5G93dEEwu+aR4FiR3LZd1+euYhiV9vjBa
         UsKvekyK6hLx24IQ2Xi1QpWu0PUnFOgInhB88cbrgHSkmKug7ZcAAkhlBJYflY0vElln
         2PPeVi+vwv3m5V9GW3Zsyf3WYb+ocOjVLB80SOJIxObv1WJDrkjsI3TU4Yq1sXmManXt
         PW9Q==
X-Gm-Message-State: AO0yUKVvKXDGR2ofncTGHPhDKZaXxP6lyhOqj1CDF7lcHutjT6/LxQ5+
        5wdXka5ygfPeEKnaRuEFjubh/Q==
X-Google-Smtp-Source: AK7set8/jQncze0zV6RWIlaFsJDhZ3/Ua6UrdZxQU/q046cTXWXwlqm0VJdh/mlm6aBteY8V9daB3g==
X-Received: by 2002:a05:600c:1d93:b0:3df:9858:c039 with SMTP id p19-20020a05600c1d9300b003df9858c039mr18025163wms.14.1678358278962;
        Thu, 09 Mar 2023 02:37:58 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f14c:2275:50fc:c056])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d58e2000000b002c56af32e8csm17638119wrd.35.2023.03.09.02.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:37:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 3/9] arm64: dts: qcom: sa8775p: add the i2c18 node
Date:   Thu,  9 Mar 2023 11:37:46 +0100
Message-Id: <20230309103752.173541-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230309103752.173541-1-brgl@bgdev.pl>
References: <20230309103752.173541-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a disabled node for the I2C interface that's exposed on the
sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9e30c1e3e66a..e7ed309fc04f 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2023, Linaro Limited
  */
 
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
@@ -502,6 +503,27 @@ qupv3_id_2: geniqup@8c0000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			status = "disabled";
+
+			i2c18: i2c@890000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00890000 0x0 0x4000>;
+				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
+						<&aggre2_noc MASTER_QUP_2 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
-- 
2.37.2

