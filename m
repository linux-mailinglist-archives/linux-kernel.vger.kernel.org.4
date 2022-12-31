Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7223265A470
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiLaNAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiLaM7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:32 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E5EE36
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:29 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j17so25675920lfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KWb6JfwG6Ts20LHUhQAxhPE9XSRDnMV5XfHaceL3Pg=;
        b=McpTyAx3xvsVRFBGvBoC2t35E4wHtaZEinIEaeNOhxp+1Lbh4sWfqdluB5z/5tUWs6
         3xMAHWtM7e4ISbpQfsYfut5VuME3oXCjCLK8ao9DCXR/phaU39rZhTR7cqgQRvVn7LiC
         Wd5XGzji1x8Kw/PmuaUynj/+7WJjJX7VdEet3B5ieFJzlMeCk0WExz6Ma99dgEoAyoQ3
         pzv8WsSGYC9xQmnV4dYXota5JpBZt0bqhg+ooRG2XH8th6iNr88Bv398fEoTls6dEXWI
         a1+UWJdDdRYx1DpsL6LEwBSWVHMGOyIp24ilCgRn2zDfQdzBWBkDP0mMT20XX+7qHxPZ
         CiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KWb6JfwG6Ts20LHUhQAxhPE9XSRDnMV5XfHaceL3Pg=;
        b=RFj6jjwNouNadKB2AIiW8oiNj0p4JV121J8WLkRzNYyM4MeL/QOb+lURo6kD3OnAZR
         kddTcuJuJ3bAGMMDiktCrO7gVQYhDWqqG7+OcgIRxcXDhNqFliYGT3FbT3BMnmeYhCwI
         z5CWFO858md1crHD9CUEEvOb9roUNxLfCQvcuIMiHxxg40i1hlDP7b8N40tGNOl38Cs6
         YWB1fp7TKOhwrBzR1MGKfuPMGWj3tjFjKW/LRfXiQxa5AFGIH191uV9p1Q5nsXB8I2i+
         LOaMEJIwK+Av+fiWvulfJ4jUVuw99POMUMlx7b5YSSsHsOSoyFUN0xirwgRWyruHElyZ
         WpRQ==
X-Gm-Message-State: AFqh2krZF+HpRxQ0rebZidEQqT6HwQLiinDkU5dL3zr4CKuKp/gZCWyp
        7o6Hx0oThHUzXYD8GQaJCOBDJ5xs+XSLHon0
X-Google-Smtp-Source: AMrXdXuVh/3jxJmadNotiwLvCfoWzTrI1+mycskWB9udTjZ20rP10JJaPkNTbOqSGn1Iu/2XApoSog==
X-Received: by 2002:a05:6512:281b:b0:4cb:2c79:eeb3 with SMTP id cf27-20020a056512281b00b004cb2c79eeb3mr1174984lfb.40.1672491568960;
        Sat, 31 Dec 2022 04:59:28 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:28 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/18] arm64: dts: qcom: sm6350: Pad addresses to 8 hex digits
Date:   Sat, 31 Dec 2022 13:59:02 +0100
Message-Id: <20221231125911.437599-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231125911.437599-1-konrad.dybcio@linaro.org>
References: <20221231125911.437599-1-konrad.dybcio@linaro.org>
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

Some addresses were 7-hex-digits long, or less. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8944dcbbe3a2..e71ffc31d41e 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -557,7 +557,7 @@ gpi_dma0: dma-controller@800000 {
 
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
-			reg = <0x0 0x8c0000 0x0 0x2000>;
+			reg = <0x0 0x008c0000 0x0 0x2000>;
 			clock-names = "m-ahb", "s-ahb";
 			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
@@ -630,7 +630,7 @@ gpi_dma1: dma-controller@900000 {
 
 		qupv3_id_1: geniqup@9c0000 {
 			compatible = "qcom,geni-se-qup";
-			reg = <0x0 0x9c0000 0x0 0x2000>;
+			reg = <0x0 0x009c0000 0x0 0x2000>;
 			clock-names = "m-ahb", "s-ahb";
 			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
@@ -702,7 +702,7 @@ i2c8: i2c@988000 {
 
 			uart9: serial@98c000 {
 				compatible = "qcom,geni-debug-uart";
-				reg = <0 0x98c000 0 0x4000>;
+				reg = <0 0x0098c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				pinctrl-names = "default";
@@ -1654,11 +1654,11 @@ aoss_qmp: power-controller@c300000 {
 
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg = <0 0xc440000 0 0x1100>,
-			      <0 0xc600000 0 0x2000000>,
-			      <0 0xe600000 0 0x100000>,
-			      <0 0xe700000 0 0xa0000>,
-			      <0 0xc40a000 0 0x26000>;
+			reg = <0 0x0c440000 0 0x1100>,
+			      <0 0x0c600000 0 0x2000000>,
+			      <0 0x0e600000 0 0x100000>,
+			      <0 0x0e700000 0 0xa0000>,
+			      <0 0x0c40a000 0 0x26000>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
 			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.39.0

