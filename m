Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8725ECB05
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiI0Rh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiI0Rhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:37:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08271D6D22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:37:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h3so11767313lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=S8p9f8npWVzLL+xxIGq+LPGJqP+UsFdvXgAaWjNbjvo=;
        b=THDBHN6pIuGeaBEKD0wMoXARQ8F4m0R90VgUzZubmiheHf7gXmwYG/G96i2q6R1kQK
         POqBssWpaUjaoMuLaJ33XOiThEnmBXWb8xbfATOR09R/Nb8TcbrbEst0Q//fw2SfJnZF
         APYQ6Ar30IHmF7QB8rZKG0DB5U/Q+fD/bKs6HdBlm+XTVC9+7LGRgjsTBclNldGmf87s
         bOgKXZZySYGGZyMAKKVVw5l6iSn2+uM5W1mM8MY9jA5TcVXyiSWkLH0kcBmB2tojX9Gg
         zYhiMebsZ6bAAqB3om6AOZyo5mM5WYNYK1dL0NYeW1VfxkmW2SD2JIWKj6jWiHTPVfg6
         aoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=S8p9f8npWVzLL+xxIGq+LPGJqP+UsFdvXgAaWjNbjvo=;
        b=h4RTgruds2i1u2DtetMWJ3jpOzAsMkAYK9tDwvtGvjBeOJrrjsnvHw8lXGCqwKQsLf
         nfiNJ8C7KUDkWr3y0GKMUH/ejwRZkj/R8DG5NJ7x7KbZ9/+FIYoUoj8JN1BIi5tYZJ6C
         I8bq/kJQL98NinaiXejlIM+SaRmFUxM1nVN6EoTTmxRDLdIkNPQnqUim9jtMREC3ki8c
         wdvVtei4x03Y+rXVLEn3FjP/nqrHsBZ3Am5kJCDqTnZL/fCz/wvjkdVRVT+zKA8Q9VT9
         bpZek0A96i1ycOamFbJHPrscvighIrgodrN44/+9HtBoXJy+26dWPQmVkTKduJ1lJjh+
         ajfA==
X-Gm-Message-State: ACrzQf1vBufAfGQCxcb3Jwea2VGITwy274geG2qcN6HOtBJ3vfXErZmW
        2CntPpe6DZSz/RTArbtuvpqP8b38DWrp+Q==
X-Google-Smtp-Source: AMsMyM48zPBDDyrGDHGqAZOF/HrESoIiPpO2ZN6iklFqu+FO0CZxRXGENxTkf9gXDtfmBHsrlkRj5A==
X-Received: by 2002:a2e:bd12:0:b0:264:7373:3668 with SMTP id n18-20020a2ebd12000000b0026473733668mr9410022ljq.18.1664300260021;
        Tue, 27 Sep 2022 10:37:40 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:37:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 06/34] ARM: dts: qcom: msm8974: align TLMM pin configuration with DT schema
Date:   Tue, 27 Sep 2022 19:36:34 +0200
Message-Id: <20220927173702.5200-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 6daceaa87802..8138f37233aa 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -573,43 +573,43 @@ bcrmf@1 {
 };
 
 &tlmm {
-	sdc1_on: sdc1-on {
-		clk {
+	sdc1_on: sdc1-on-state {
+		clk-pins {
 			pins = "sdc1_clk";
 			drive-strength = <16>;
 			bias-disable;
 		};
 
-		cmd-data {
+		cmd-data-pins {
 			pins = "sdc1_cmd", "sdc1_data";
 			drive-strength = <10>;
 			bias-pull-up;
 		};
 	};
 
-	sdc2_on: sdc2-on {
-		clk {
+	sdc2_on: sdc2-on-state {
+		clk-pins {
 			pins = "sdc2_clk";
 			drive-strength = <6>;
 			bias-disable;
 		};
 
-		cmd-data {
+		cmd-data-pins {
 			pins = "sdc2_cmd", "sdc2_data";
 			drive-strength = <6>;
 			bias-pull-up;
 		};
 	};
 
-	mpu6515_pin: mpu6515 {
+	mpu6515_pin: mpu6515-state {
 		pins = "gpio73";
 		function = "gpio";
 		bias-disable;
 		input-enable;
 	};
 
-	touch_pin: touch {
-		int {
+	touch_pin: touch-state {
+		int-pins {
 			pins = "gpio5";
 			function = "gpio";
 
@@ -618,7 +618,7 @@ int {
 			input-enable;
 		};
 
-		reset {
+		reset-pins {
 			pins = "gpio8";
 			function = "gpio";
 
@@ -627,25 +627,25 @@ reset {
 		};
 	};
 
-	panel_pin: panel {
+	panel_pin: panel-state {
 		pins = "gpio12";
 		function = "mdp_vsync";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	bt_pin: bt {
-		hostwake {
+	bt_pin: bt-state {
+		hostwake-pins {
 			pins = "gpio42";
 			function = "gpio";
 		};
 
-		devwake {
+		devwake-pins {
 			pins = "gpio62";
 			function = "gpio";
 		};
 
-		shutdown {
+		shutdown-pins {
 			pins = "gpio41";
 			function = "gpio";
 		};
-- 
2.34.1

