Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CBD6994ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjBPMx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBPMxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:53:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE58B47433
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:07 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d4so1665016wrj.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSdbB0k5k1AEobOWepSdzQF+T7jER4lOY+1Fh8MN3Kw=;
        b=XFpf2epYKOY95abu5FSgg1iKNOIeJcdptJ6YYAtNYb/psT7MzGRyVrnAFWTDkRHpd+
         Vjhk5O1Ijl2xR5J7u7TthKCELgJQrk0lsYeVkwz31uJTji0kakxVnZPhKdvopqOwp/9r
         G2wucm+zifPjBAOIlCr6Ms7/9dS/ZOXjnLdB6oxLyuj4os29CrM4W5ePCjUFeiAeUtoq
         pjccuO0TpGWwvQN1fTXbn7o8i9oJ1PJtQ1RpfS0Yd89JBHVfIkl9WMUjOlqiFXJcco+E
         +0rtOoG5e9V81LvCrM9dWRBoVCVv9Wtm4YwbT6nF34iKO5Uwdtw86EYMq1fqFGpr6I2o
         HlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSdbB0k5k1AEobOWepSdzQF+T7jER4lOY+1Fh8MN3Kw=;
        b=O2StyV8YCgM8yG+Ito3efejOY1xrXsV0e2k3mb6TEtm4bS9m+nMLaCCqe+IY/cOYgG
         LQvBXAKbmfR/E4ccSbAHBxcgmFjXTDH9KzKcpFR5xGe4alwnm5tL9jz3cEJevibHmPDC
         4PKmkjR/W2wSsX+uvTdXGAsyAJDtNJwyJrjkxl9SWJlSW/uXzeAP1+ah139CKedNrGBI
         53swNPmBSoOXE5o1DfTlMIImRme5r8jyy2roe/jOiN0OemE5bLOZMPE4f2qrshCEr64p
         VZr/FgShfV6FyQbeeMpYhgjOwYhOB9CAfHIpwWryBwM0AZhl9w+oxpsFlYtv3cMX4MLY
         16EA==
X-Gm-Message-State: AO0yUKV33/HUlPY5XQBnxoiWB6Edk9OlgYTXXym7K6V1QXHxFW1s6pUc
        rOyzxtKXpuN6x43r5jD3UzqHMA==
X-Google-Smtp-Source: AK7set/b2v39ofFqrzr0BRAG6/CK2bfQFhxJ2DUQT9/A445MuadwMBj/PCyPE4wkxjFUgQtjFG7S8A==
X-Received: by 2002:adf:e801:0:b0:2c5:5836:4e1b with SMTP id o1-20020adfe801000000b002c558364e1bmr5412597wrm.60.1676551987542;
        Thu, 16 Feb 2023 04:53:07 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b002be5bdbe40csm1453292wrs.27.2023.02.16.04.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:53:07 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 7/9] arm64: dts: qcom: sa8775p: add high-speed UART nodes
Date:   Thu, 16 Feb 2023 13:52:55 +0100
Message-Id: <20230216125257.112300-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230216125257.112300-1-brgl@bgdev.pl>
References: <20230216125257.112300-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index eda5d107961b..ce5976e36aee 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -489,6 +489,21 @@ &clk_virt SLAVE_QUP_CORE_1 0>,
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				status = "disabled";
 			};
+
+			uart12: serial@a94000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0xa94000 0x0 0x4000>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0
+						 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0
+						 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				status = "disabled";
+			};
 		};
 
 		qupv3_id_2: geniqup@8c0000 {
@@ -524,6 +539,22 @@ &config_noc SLAVE_QUP_2 0>,
 				status = "disabled";
 			};
 
+			uart17: serial@88c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x88c000 0x0 0x4000>;
+				interrupts-extended = <&intc GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+						      <&tlmm 94 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0
+						 &clk_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_APPSS_PROC 0
+						 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				status = "disabled";
+			};
+
 			i2c18: i2c@890000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0x890000 0x0 0x4000>;
-- 
2.37.2

