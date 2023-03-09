Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806636B21A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCIKie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCIKiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:38:06 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A5714E80
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:38:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g3so1367204wri.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678358282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ7qwaWhTP1sdEt6dec5mYyXeH36jDZTEXpRK58r+Rs=;
        b=eehEsIMy1Fd2fn+39Zh7PVoMcS9kNOEUOLgBLSv3+ud7BlOYwBP3V3cposi9bUHYAT
         dOQpqM63HhHzl4Dbin0iISQFaRAAJIy0ky7ckNVaKpKZwQLh4A6Z/iT+woWbY/9fPAuc
         3opcTDLjd8px4SDKErZJXOmw1JeMHo4yzlVNph7iGZGpL1GbEiU6p/wGjhvbw2Qe3Liy
         VJdzT/4G8mVCysHHHrqT7/ROZVvPWImvnF5u/6y4V0Q15tiIZkikRbjEwsHeyXjBvK5N
         dfI4EegGI8MGzPIXL5nW39e/K1FOLt1WpUJdtkxCnQVZqC6jtohge/pXjjGdK5an1Nkc
         8v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ7qwaWhTP1sdEt6dec5mYyXeH36jDZTEXpRK58r+Rs=;
        b=nsTR2yU4cY/1wpWQe0aL+e18g5DBiXDSa5BIZgMfdqdpkLs26aqdyEDUk3S3sIFxSs
         ifCpKEzQENkVCQP4lHBAdNJYtDVR/e4K5gYSjkqrbfPbPO323X9f6dskOcJFvcVNRWfX
         hppuUd6EGKm1jLHJE66zYDtJb2eCHs2JywIl1T5peUDK/CNrjwBCIi+M2uDy5ubXrpNc
         VbwT8LodpmPW6nloYCuCxP5oPFjcDrwMROSMnB7Qh5+VlXUoWius2kXx51FEbImjNshk
         fHahdr1v+GHH09PnJ9qKPwENJL9mjEWVMcu66BF14SgH7QxedLrQTHOpLqRSZrgmiYeJ
         QYBA==
X-Gm-Message-State: AO0yUKWeh+XyilCEQe98cO+za3FBHPGtD/k6YtXKByPcPT3hTKsGj3oM
        hKGGX8MwPwd0ue8zuoPeHRuv0w==
X-Google-Smtp-Source: AK7set9LwkOrGvDIlXn3flZzfCZgxh0SnIOwxDGxEceTPTD5/DPrQg2K7krZwcmuaWBgoZSA9ENOMA==
X-Received: by 2002:adf:ce91:0:b0:2c7:1e16:57cf with SMTP id r17-20020adfce91000000b002c71e1657cfmr12732352wrn.67.1678358282638;
        Thu, 09 Mar 2023 02:38:02 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f14c:2275:50fc:c056])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d58e2000000b002c56af32e8csm17638119wrd.35.2023.03.09.02.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:38:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 7/9] arm64: dts: qcom: sa8775p: add high-speed UART nodes
Date:   Thu,  9 Mar 2023 11:37:50 +0100
Message-Id: <20230309103752.173541-8-brgl@bgdev.pl>
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

Add two UART nodes that are known to be used by existing development
boards with this SoC.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index d1b2a6d30eae..468390edf049 100644
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
@@ -525,6 +540,21 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 				status = "disabled";
 			};
 
+			uart17: serial@88c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x0088c000 0x0 0x4000>;
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
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

