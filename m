Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE366598FF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiL3NvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiL3Nuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:50:51 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24EE0D0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:50:49 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g13so31790887lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ub/VznuYkK88f9PSV7dmnTyJuP0obsTGr+Fx4fP9G1c=;
        b=kuL8IW9OudDKPBDB5lZMhTLIIx57sKuoJA1Q/zbah+th2HmKXylN6unVeJg7/zMKFj
         ETyBYsEYFax16hSdZ/7zSQlWIzQ+A23w9woNkBYHvxjIzLofNH4NpvYVAAyTypWC0iUz
         p+vvDc/CAPlY0bv94tgMNMMIt/JJvMde4dyrStojOVgTVAtKtBt6p19aPU4Of9JFU9vI
         6BiqRXkrciqQkIbOCEh3luXVArNQF/h80CIo+Zp8Z2BNNaH8WMe1+BPGqG8In+Ipk1aW
         LxwzmfSSdfDIwIsPHwHIs0+ddwGNgLFy93XeYa+9jYQ31SSgilUr6rau2ijIXlm/5Pcq
         GNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ub/VznuYkK88f9PSV7dmnTyJuP0obsTGr+Fx4fP9G1c=;
        b=llBDoDdON7dedbI4JpmrPmNcuiuauY2njvk70Lnz+feREndLiBp4IKwh1n79Cs/Z91
         uXhxpt/VFTdgJLk2kdJLDy6Q82/NKt/cDoKLouab48oUMN5acE+yxPNP7XBm05Jn1dxX
         AFRP6JT+i/63bRwVEMPZZB+LCak1ChhLUxFpFIPFYXpOryknVupBXmDTVL9Fzb0LBQ4o
         aK8qMeZXhBam+ySAlG+ODiMBMwfx7JLt9d+IintObxcyIkYp5i/40GhBi5RAVDi4k2Qa
         DehoqH+n9I9C7H65tNlLOWEOcXuzeNeAe9ZKqSrgQ/aUTSBDH/QBVXJL9h1Dq9zEZ+gP
         U7BA==
X-Gm-Message-State: AFqh2kp5t80tAjH+4zSOOcPhcDC3x3eQUmcNdE5hGJglHr+bspKHIZJG
        4F3TLH3rUDbQ1rP3AkmDw4ndiA==
X-Google-Smtp-Source: AMrXdXsuilJ2rkf4fBr2NwXOV0bN74v9ThRoP27qdpcAkuIucfHZZt5ExQZvpzwKc+2s0UoF2PNilQ==
X-Received: by 2002:a05:6512:3d9e:b0:4c0:2b07:e6e7 with SMTP id k30-20020a0565123d9e00b004c02b07e6e7mr11762738lfv.58.1672408247566;
        Fri, 30 Dec 2022 05:50:47 -0800 (PST)
Received: from localhost.localdomain (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id e16-20020ac24e10000000b004b4ea0f4e25sm3447970lfr.301.2022.12.30.05.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:50:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: qcom: sm8250: Pad addresses to 8 hex digits
Date:   Fri, 30 Dec 2022 14:50:42 +0100
Message-Id: <20221230135044.287874-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
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

Some addresses were 7-hex-digits long. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a3aa85a32bf8..3b3ea380c6e6 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2284,7 +2284,7 @@ rxmacro: rxmacro@3200000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&rx_swr_active>;
 			compatible = "qcom,sm8250-lpass-rx-macro";
-			reg = <0 0x3200000 0 0x1000>;
+			reg = <0 0x03200000 0 0x1000>;
 			status = "disabled";
 
 			clocks = <&q6afecc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
@@ -2302,7 +2302,7 @@ rxmacro: rxmacro@3200000 {
 		};
 
 		swr1: soundwire-controller@3210000 {
-			reg = <0 0x3210000 0 0x2000>;
+			reg = <0 0x03210000 0 0x2000>;
 			compatible = "qcom,soundwire-v1.5.1";
 			status = "disabled";
 			interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
@@ -2331,7 +2331,7 @@ txmacro: txmacro@3220000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&tx_swr_active>;
 			compatible = "qcom,sm8250-lpass-tx-macro";
-			reg = <0 0x3220000 0 0x1000>;
+			reg = <0 0x03220000 0 0x1000>;
 			status = "disabled";
 
 			clocks = <&q6afecc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
@@ -2352,7 +2352,7 @@ txmacro: txmacro@3220000 {
 
 		/* tx macro */
 		swr2: soundwire-controller@3230000 {
-			reg = <0 0x3230000 0 0x2000>;
+			reg = <0 0x03230000 0 0x2000>;
 			compatible = "qcom,soundwire-v1.5.1";
 			interrupts-extended = <&intc GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "core";
-- 
2.39.0

