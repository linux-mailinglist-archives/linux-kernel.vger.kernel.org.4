Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9436B04D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCHKks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCHKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:40:23 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4029CBF6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:40:22 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso962777wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678272020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIczb2Q7kXmWhiNYlRu3La2aSJAULsh/LcO5fB6EKp0=;
        b=dYqP5PzDHB7kHW/GYzCdC4fcjnq9olULmSIXWjxpTjXXGsPWNjLklh6TJWPqm0OhAk
         ufCbiHtaaiTSH+ZX6Znz09eDpjvwteGD8Umb04hbWhiNgnM37/9pwDo55eJb6omNsnGo
         pnOYQhl4jYSDvU37bZZcwyTMQft0b0NS8Qx0biCWZ7LXh46K/hosDT6ZxibtnuGH8rGo
         P1tcTfCXcySKIiGHtT5ZLABES7rHJpxN80KB5H5klPe8LB51jiof1yHnL2tI17WnSYI6
         tPZ2+xvb9u840OoQBzaa3jGb4Vd1v+eIc3H/4mso0Pbf27LyM7yCBqhSYLrn4ZtVfSmM
         RM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIczb2Q7kXmWhiNYlRu3La2aSJAULsh/LcO5fB6EKp0=;
        b=RUt4jX2hKcekaMwB4Uy0fT3Q0MwvBq62hVPAuIC3Ca0gL7xgQv6uiNkS2VvGQH/bs1
         hK+b+nN5BdL/GPRF5208EV2Bs8HW2qL0sHJxN0ueMobxiAsQmWqSdPrnNzq6i1YnP4iK
         aJkVS1G816HPs6qGvUM3lsNm3Lto3dfOMc/i3Q4cqEwwGvE0AtnSaFI9Qaoowxzj/Wsy
         wpciiipsqpK3y2a75fAODxCz+cGpkN3PI4P1GeCFMuh0Qno73Id7d0Jq1sUonj3pDltm
         Y+1qjPi5WnpmlRzx8NYRhGi+46kH9RDb2S0Tdb4cs4r19dsi60dyyWzYO7cNiksqUjTo
         8n4w==
X-Gm-Message-State: AO0yUKUnIHf/6Doddd8ZDspJcuVMlvVvS40qAa8zgAQcBGqONaSWWv6G
        00xXxFSkBP17SZ8P1GtIqBv/bw==
X-Google-Smtp-Source: AK7set+OHRoq/n4LW1uIuoWBtHE28YO7R2sU3L8lHKw+CMYWQMEmEuSh5N05qZEDHqJHJXrlSGPtlA==
X-Received: by 2002:a1c:f304:0:b0:3eb:29fe:734a with SMTP id q4-20020a1cf304000000b003eb29fe734amr15720206wmq.39.1678272020489;
        Wed, 08 Mar 2023 02:40:20 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2326:fd4c:82e3:7e07])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003eb0d6f48f3sm20664135wmn.27.2023.03.08.02.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:40:20 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 7/9] arm64: dts: qcom: sa8775p: add high-speed UART nodes
Date:   Wed,  8 Mar 2023 11:40:07 +0100
Message-Id: <20230308104009.260451-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308104009.260451-1-brgl@bgdev.pl>
References: <20230308104009.260451-1-brgl@bgdev.pl>
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

Add two UART nodes that are known to be used by existing development
boards with this SoC.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 992864e3e0c8..5ebfe8c10eac 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -490,6 +490,21 @@ &clk_virt SLAVE_QUP_CORE_1 0>,
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				status = "disabled";
 			};
+
+			uart12: serial@a94000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x00a94000 0x0 0x4000>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				status = "disabled";
+			};
 		};
 
 		qupv3_id_2: geniqup@8c0000 {
@@ -525,6 +540,22 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 				status = "disabled";
 			};
 
+			uart17: serial@88c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x0088c000 0x0 0x4000>;
+				interrupts-extended = <&intc GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+						      <&tlmm 94 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				status = "disabled";
+			};
+
 			i2c18: i2c@890000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0x00890000 0x0 0x4000>;
-- 
2.37.2

