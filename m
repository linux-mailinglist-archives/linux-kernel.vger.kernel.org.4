Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3E66994EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjBPMxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjBPMxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:53:09 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F33748E1C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bk16so1718447wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dibhyEZtmC71mf7EJSLWFvkJAQUY//1IZfvc8uLBhaw=;
        b=E160OixKVn90Zpizo/M3/xEFYcyRRa/ZXahSb91waDLEM8CkY0pOfJ94KT+2CNrbpA
         OIcBQJtTj0JiQkqn1kf9QeiLKuzWxrWBwj7BooNZiopqlGCjcOAiM4z1T7xw1lH5EHJm
         xs5M/1mJGlg/2V5R79Jo9i3nbWQgEjOl7dZIRkdwOjI0C7CRdzHsEjLnIBvGLSYBqVnP
         /jmX7rxl/uCnZCY12BM/DppcSV3eborERAUSxomSX8wSQV+pdtZDOmdqUe2GMop5YKZN
         rBzG2nY1i0t7WEncfe5lXrtRT+QYAwq+bHoRPdf8x2qvaZSUGfnxMx6QsxUyJY0hYnds
         ys+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dibhyEZtmC71mf7EJSLWFvkJAQUY//1IZfvc8uLBhaw=;
        b=Be5tq+FeagCtPNIeF3zeiqsu3KcJZQ7dSIYr27pJIac1aa/FybwohkqphuX1CzsDHV
         iFGvWmypUr9hRZhVurcJiPFR5rzGXUrgyyuPmMcZlHttQ8YuwwL019jj9Spek4HCTtwz
         ALFg0k9WgevYK9qphBw4CKuP3Ldrer0BJpx1b9+VTeM5YQQbFXfHQOuKebqHals0FpoQ
         xzXPBFXrLs/SepvbauPJ3xroziw/NlCOyH0rPyo6+fVs/lMVm+mI/fkeu1l69qbwd6rI
         pvpv/ERjXDRCBvPZLtvTHG/XDNh3is3Yys2R2A76S+C3TmotQ6/Ckjp7I7bCQH+upyak
         xf5A==
X-Gm-Message-State: AO0yUKXwrTSCWXtdG0v21U7KxDJqdbAmtzpwzM8v5PSjE9kt+9Wjs0gT
        ISEJIkQhKkVo9PWBTuGV0Gl/OA==
X-Google-Smtp-Source: AK7set/4zjAVRkIhO53ldU71bp1KqctiEVHhvuH8slmb/qQuJ2do0Q9irXuM9u4q8pEeHCQsPd8O8g==
X-Received: by 2002:adf:f450:0:b0:2c5:5759:12d2 with SMTP id f16-20020adff450000000b002c5575912d2mr4825255wrp.35.1676551986668;
        Thu, 16 Feb 2023 04:53:06 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b002be5bdbe40csm1453292wrs.27.2023.02.16.04.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:53:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 6/9] arm64: dts: qcom: sa8775p-ride: enable the SPI node
Date:   Thu, 16 Feb 2023 13:52:54 +0100
Message-Id: <20230216125257.112300-7-brgl@bgdev.pl>
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

Enable the SPI interface exposed on the sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 5fdce8279537..d01ca3a9ee37 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -14,6 +14,7 @@ / {
 	aliases {
 		serial0 = &uart10;
 		i2c18 = &i2c18;
+		spi16 = &spi16;
 	};
 
 	chosen {
@@ -40,12 +41,25 @@ &sleep_clk {
 	clock-frequency = <32764>;
 };
 
+&spi16 {
+	pinctrl-0 = <&qup_spi16_default>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &tlmm {
 	qup_uart10_default: qup-uart10-state {
 		pins = "gpio46", "gpio47";
 		function = "qup1_se3";
 	};
 
+	qup_spi16_default: qup-spi16-state {
+		pins = "gpio86", "gpio87", "gpio88", "gpio89";
+		function = "qup2_se2";
+		drive-strength = <6>;
+		bias-disable;
+	};
+
 	qup_i2c18_default: qup-i2c18-state {
 		pins = "gpio95", "gpio96";
 		function = "qup2_se4";
-- 
2.37.2

