Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A026994EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBPMxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjBPMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:53:13 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB91A48E22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o15so1728421wrc.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zth4LRDzQbzOroJaQCO7UI7/ks7eZuvwOmU1RK0/21g=;
        b=zAvknU9k6u2pR7ZjnkDBa/R1INvpIk0qOu1+HQwUk+7py9mm1U261lNQm6m6vvjFxJ
         63yxVpuk60+ogoQ3Pdel4iWc+Vx6NxFpQo6lBs9U4vrgRDB+dBbQLCtcDwDkhcngf8qw
         otb6cGMp0SrU2dXE1K8a7JoR3yYwr6sxc/cGYqHRE9SqEDpGa1sxNlVAhS3x3f1UDJCw
         fdmfgnu9Vx4SlWftXPcPqzBwmi8nYhjLnbssRjeLUAOOEgqrfLEzaQfPEOiEyJAjVXiM
         vrPqXg7mh4dhrtTsdZIBRUUWOr9QMHixBRh8wdMZgt2df/6kMmttN7bnm9jOiV2VXDF6
         Jj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zth4LRDzQbzOroJaQCO7UI7/ks7eZuvwOmU1RK0/21g=;
        b=vkr397HBTAJxQ/52QrZ01BhHIf66UJxisNkH38j97gqFNYkBSRbfTyD9KCZQDFuILj
         CRgitKFJ7pBtGX226gQ6ouxSADnZWZmXDRqdJWTF3XIe+9HMIdBTJ2/D57YiZER1Nv/n
         FVnpr7nS3nnrSNwAloTcbN/65Ez3kz8mtNVAFtgIXJb4sv8xf39tWaEBMXRu/bwf+YCC
         oDYNeCs47Jl1ckjOisQPmUxC1H4U3mp8W8c2FXdy2cwX6kTTsdrHSlGSvl0Teijom/Hj
         RiOluiANUBA5IxqBAjXY18HVzQstt4Wjn6Hv5AWzK3UUUBjH+5TUehbqet60rvfQ9fT9
         DY8g==
X-Gm-Message-State: AO0yUKWdpHUL5IsYFc82V88ciWQ18+fWzt58138WmHshGyq/rX2/8jaR
        zaYkGvrIDDMF4BpXuVSNHKCZzA==
X-Google-Smtp-Source: AK7set+3ocTCALrHUmoHGw7XzcAcSr/5r/EjM8fRD8BZvx3A+PFAYc7MLMfJfJSGOKaQQqDKBW4XPQ==
X-Received: by 2002:adf:dec1:0:b0:2c5:5454:22f5 with SMTP id i1-20020adfdec1000000b002c5545422f5mr4333579wrn.54.1676551988447;
        Thu, 16 Feb 2023 04:53:08 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b002be5bdbe40csm1453292wrs.27.2023.02.16.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:53:08 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 8/9] arm64: dts: qcom: sa8775p-ride: enable the GNSS UART port
Date:   Thu, 16 Feb 2023 13:52:56 +0100
Message-Id: <20230216125257.112300-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230216125257.112300-1-brgl@bgdev.pl>
References: <20230216125257.112300-1-brgl@bgdev.pl>
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

Enable the high-speed UART port connected to the GNSS controller on the
sa8775p-adp development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 34 +++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index d01ca3a9ee37..6f96907b335c 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -13,6 +13,7 @@ / {
 
 	aliases {
 		serial0 = &uart10;
+		serial1 = &uart12;
 		i2c18 = &i2c18;
 		spi16 = &spi16;
 	};
@@ -66,6 +67,30 @@ qup_i2c18_default: qup-i2c18-state {
 		drive-strength = <2>;
 		bias-pull-up;
 	};
+
+	qup_uart12_cts: qup-uart12-cts-state {
+		pins = "gpio52";
+		function = "qup1_se5";
+		bias-disable;
+	};
+
+	qup_uart12_rts: qup-uart12-rts-state {
+		pins = "gpio53";
+		function = "qup1_se5";
+		bias-pull-down;
+	};
+
+	qup_uart12_tx: qup-uart12-tx-state {
+		pins = "gpio54";
+		function = "qup1_se5";
+		bias-pull-up;
+	};
+
+	qup_uart12_rx: qup-uart12-rx-state {
+		pins = "gpio55";
+		function = "qup1_se5";
+		bias-pull-down;
+	};
 };
 
 &uart10 {
@@ -75,6 +100,15 @@ &uart10 {
 	status = "okay";
 };
 
+&uart12 {
+	pinctrl-0 = <&qup_uart12_cts>,
+		    <&qup_uart12_rts>,
+		    <&qup_uart12_tx>,
+		    <&qup_uart12_rx>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
-- 
2.37.2

