Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4121A5B4E13
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiIKLOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiIKLN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:13:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF5F32D81
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z25so10392609lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=e91Jrvw0byDqU3CWt6E5mPoWrF7xdNn1DqHo4tKVYDs=;
        b=enIi1l91688Uylbui5XHd2/yt57W1FH/w89unA4B82kU/cO1uZBT5JQCdy9Ai2ikKx
         wUeXJfJSRT4IlBuOpR2FI7TJGRfzGQYFrzkUVC/4u88KVVX+2oExO+4WjRhpmF8hT0Pa
         sMXOYBwsIG2d8nvO+wDa9g13V9Gma591dDAHxlm3BBbNnWPnCw2XVfJojofq3UQ+TDjg
         0okC/ZlaAq+1+fup+fKuczLxdiQEtYad42JVjqvwIJ0LXBPKMFPxbhMmGYfJNc4uLdpf
         qHZ0BtX8jgo5CVRJ7H0B8lArDO+PZt3C9xwJAXSPRbzepGFDg83NKCIiQJ1Vg8QfAsQo
         w40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=e91Jrvw0byDqU3CWt6E5mPoWrF7xdNn1DqHo4tKVYDs=;
        b=KkS9C86FPpRRZMBNxcYlBw3orsyp8ISQIu89NRIVB83xJlPL8TrsJlNwJndLkN1eXD
         JB6D3SVAs2SFNhxgRx9tt+KuCizvvknE3/aDf7wu/o8//iQASAk/7XxT4UqQRRxt24DA
         Af6U4n8GC+i4cgZ2d3ovsoZP5TnTNM2+X+maYKKwu2L7DtqcuI2SAVOeBjI2b8JcUDTQ
         wLpSEmdpNFhhqGDt4WSQlyXbUV5/x/5XJ58ZXmUofCasI5TAcv/6nP04iJk4MVpbu8tG
         si1sBF3nKmTcclJ0CNWUeQ3aBHQFW2lKdSime/HwuEY0sOfGNCepS7TzkVw26mvpnE0r
         +Tvg==
X-Gm-Message-State: ACgBeo0vow+D3LT7cg+g84yzc6I2zBYBNkkpHUz4LpxXHnlaCkNc112r
        /vHqr+wZTxQKV+oWThX8TpqeyQ==
X-Google-Smtp-Source: AA6agR7RDHlm1PY+nYi3QuP1c/tOFiE46t0Sq5QC8f9PuEUrvs9WUaMQzaWGD4+uh+eZ/EONPDn61A==
X-Received: by 2002:a05:6512:3b94:b0:492:bbe1:df3e with SMTP id g20-20020a0565123b9400b00492bbe1df3emr8119832lfv.371.1662894767815;
        Sun, 11 Sep 2022 04:12:47 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 34/40] arm64: dts: qcom: sm6125: align TLMM pin configuration with DT schema
Date:   Sun, 11 Sep 2022 13:11:54 +0200
Message-Id: <20220911111200.199182-35-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects TLMM pin configuration nodes to be named with '-state'
suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts  |  4 ++--
 arch/arm64/boot/dts/qcom/sm6125.dtsi                   | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 0aad2e94e757..6a8b88cc4385 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -87,7 +87,7 @@ &hsusb_phy1 {
 };
 
 &sdc2_off_state {
-	sd-cd {
+	sd-cd-pins {
 		pins = "gpio98";
 		drive-strength = <2>;
 		bias-disable;
@@ -95,7 +95,7 @@ sd-cd {
 };
 
 &sdc2_on_state {
-	sd-cd {
+	sd-cd-pins {
 		pins = "gpio98";
 		drive-strength = <2>;
 		bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 8c582a9e4ada..1fe3fa3ad877 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -387,19 +387,19 @@ tlmm: pinctrl@500000 {
 			#interrupt-cells = <2>;
 
 			sdc2_off_state: sdc2-off-state {
-				clk {
+				clk-pins {
 					pins = "sdc2_clk";
 					drive-strength = <2>;
 					bias-disable;
 				};
 
-				cmd {
+				cmd-pins {
 					pins = "sdc2_cmd";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 
-				data {
+				data-pins {
 					pins = "sdc2_data";
 					drive-strength = <2>;
 					bias-pull-up;
@@ -413,13 +413,13 @@ clk {
 					bias-disable;
 				};
 
-				cmd {
+				cmd-pins-pins {
 					pins = "sdc2_cmd";
 					drive-strength = <10>;
 					bias-pull-up;
 				};
 
-				data {
+				data-pins {
 					pins = "sdc2_data";
 					drive-strength = <10>;
 					bias-pull-up;
-- 
2.34.1

