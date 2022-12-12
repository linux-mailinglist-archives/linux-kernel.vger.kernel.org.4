Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D835649D45
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiLLLQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiLLLQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:16:16 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC537DF93
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:47 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so17983324lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaqnzgEez5o+aheB4jouM3JSYEeh5J5pWhvvk2MpmEg=;
        b=b/l7p+kWOAQddo37xNV68tq1G5PdOYsZVSayXQc/n2hR7gWXdf+Jm8RNm40skIcET5
         6uAuyUJmtLTTMo+TmyCWEbqYF37GaaGx7qD+DS7UdTSQ9cx4sBSche86jUfqWmpTRAV7
         AbwfBwPy+6FQAwXCrOttv2DdzDMaS+uKF97o8/hEEu7Ab5kaSBq3FhRLRMAkgKRplCi0
         bNUJrvLCXC5m1/wVPOFYljmeHuXyjRr9gxzt55yAbVaeibnVgFa+Fj/rY72Jckm9EMfW
         Bc++Mh8VF3LESe6pKMnocoDpsZ90DnJVOHYo++vSVHQWJIBHWn3O2AYl8NyOebmXl1TH
         o60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaqnzgEez5o+aheB4jouM3JSYEeh5J5pWhvvk2MpmEg=;
        b=vo91+fHOYyELNWHBK4I60jqLLB5AaZABDz9a6TFiXQVOGE63ol4fWVuS5j7Cs7gda7
         G1pz5V8FPUSi28pTrpLnGtytkoP5OFPtJbC9uPIFIKoILHZ0Hamcr0UkPbxSY2j+W86I
         NZSOL45rkM+R2uTNvVTfnz1D5FcsjoHwT8GB8B9l+Y3Olj9obuQRTwfxc6mQ01ZzOUAv
         4NyVM9q75nZpFbwQIiWCPas1Dd92pEwLKn6UWMJM3WoLHLPcH/o6Vs5/UQSmsy6zx1Dj
         ApisreiqCLyN9nb/dXK6Z+ab3ZtfsSw/E+T2xSVqekdlUFKjwx7eERaXAIE2Bw0aFj91
         s2hQ==
X-Gm-Message-State: ANoB5pmotqp3718RW5aK0eqL8IY7RVGHq1a4OoqVhCzMFB+usDl0o7wu
        ncRPk6syFG6TV3jzOy0QEOPkGw==
X-Google-Smtp-Source: AA0mqf7WNG69Av72RF+/EYRAlR8ZdhfMneuro3qaDzrmQ35ioUFKffzDpTaroJNhGXIOVSmHoFh2VQ==
X-Received: by 2002:a05:6512:1082:b0:4a4:68b7:f884 with SMTP id j2-20020a056512108200b004a468b7f884mr7307008lfg.40.1670843446355;
        Mon, 12 Dec 2022 03:10:46 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512060400b004b57a810e09sm1599110lfe.288.2022.12.12.03.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:10:46 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] arm64: dts: qcom: ipq6018: Use lowercase hex
Date:   Mon, 12 Dec 2022 12:10:29 +0100
Message-Id: <20221212111037.98160-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212111037.98160-1-konrad.dybcio@linaro.org>
References: <20221212111037.98160-1-konrad.dybcio@linaro.org>
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

Use lowercase hex, as that's the preferred and overwhermingly present
style.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 5d453f11acd9..2ceae73a6069 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -679,7 +679,7 @@ dwc_1: usb@7000000 {
 
 		ssphy_0: ssphy@78000 {
 			compatible = "qcom,ipq6018-qmp-usb3-phy";
-			reg = <0x0 0x78000 0x0 0x1C4>;
+			reg = <0x0 0x78000 0x0 0x1c4>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -696,7 +696,7 @@ ssphy_0: ssphy@78000 {
 			usb0_ssphy: phy@78200 {
 				reg = <0x0 0x00078200 0x0 0x130>, /* Tx */
 				      <0x0 0x00078400 0x0 0x200>, /* Rx */
-				      <0x0 0x00078800 0x0 0x1F8>, /* PCS */
+				      <0x0 0x00078800 0x0 0x1f8>, /* PCS */
 				      <0x0 0x00078600 0x0 0x044>; /* PCS misc */
 				#phy-cells = <0>;
 				#clock-cells = <0>;
@@ -721,7 +721,7 @@ qusb_phy_0: qusb@79000 {
 
 		usb3: usb@8af8800 {
 			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
-			reg = <0x0 0x8AF8800 0x0 0x400>;
+			reg = <0x0 0x8af8800 0x0 0x400>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -747,7 +747,7 @@ usb3: usb@8af8800 {
 
 			dwc_0: usb@8a00000 {
 				compatible = "snps,dwc3";
-				reg = <0x0 0x8A00000 0x0 0xcd00>;
+				reg = <0x0 0x8a00000 0x0 0xcd00>;
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_0>, <&usb0_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
-- 
2.38.1

