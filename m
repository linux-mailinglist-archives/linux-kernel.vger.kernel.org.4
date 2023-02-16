Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BF86994EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBPMxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjBPMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:53:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C667D45F70
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r2so1737261wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7uOoIM/ZRg0/gRsck8jf0SfprCY2FGC+Fvuy6yN0cU=;
        b=fPkAi4CQml76sUQkY6HVbTV58puI9K5+Y647bTINfv4YSDC3Lwk1ywAEfNb97YZLMS
         PKryfMPzh4sWPNuJXpcoIJBIYYgO1MJrdA0WxDg1ok3HACqnXaO24w9R7e+KbMVeQt+s
         L0pspxbKqVzg+zFB6hzb0iCxi3dAuq+lnZ3owM8KMQzKfvCBS82qtbYXUlThm21SAIf4
         JsC8SFef6Md824r1IufIKTreB56D37SdnnRPmY1kbOfzuJ2blFPLV94tkK0dAk32UDKe
         xa7xkNLuza7lT0tLahiWWwC5hTqB6rw+KVyoOfZi2E64eR3se2hBtch0AtWAWDzUJtmS
         8lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7uOoIM/ZRg0/gRsck8jf0SfprCY2FGC+Fvuy6yN0cU=;
        b=U1138wXOPcBFBN0Ox8QmKZT5DacvyH/hn2Lnr0OF864e01aM9BtXXWh9PPlQkmcuUQ
         eJGgwvyaZ4uTJ2+HcwK4hcWWNa9DGdmjCGYpnZiffsQmhi4fVzs6ke6d8LZJQhCxqwKG
         YEXwlHqQRfB5+yI8/C/eRW5cuidVh2A6bSjcestNKRaGAJKPq+x4Q/gXB2pQDlLyCYOq
         A6+e+7fOmK/XfnQ2esjMeNuABHbIyFFl9dhGR11Fn5kn9YdN6P0aGKmxAbSlFxnFYh8Y
         yEZhCCXh8t72gAjqOA2SGY0XC9+p1uwcSaKZ8UUf3lOjqAbBWRnx91tSLxmh7RESN16L
         rqBQ==
X-Gm-Message-State: AO0yUKWFnKE5zRC40s0fh93caJJHaZ6JG1/BK6nfypLWqi48OJ22jTJo
        MsemCffuTxPfrgr+rx9CIIICmw==
X-Google-Smtp-Source: AK7set+/NiMGAZRAJZ7qxw6w9doBfQNzPfKzK290K1n3NTgUPyfQ3H+vcHbgP3WrFvbklGAWJsoPQg==
X-Received: by 2002:a05:6000:180e:b0:2c5:4aad:db85 with SMTP id m14-20020a056000180e00b002c54aaddb85mr4476913wrh.37.1676551989337;
        Thu, 16 Feb 2023 04:53:09 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b002be5bdbe40csm1453292wrs.27.2023.02.16.04.53.08
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
Subject: [PATCH v3 9/9] arm64: dts: qcom: sa8775p-ride: enable the BT UART port
Date:   Thu, 16 Feb 2023 13:52:57 +0100
Message-Id: <20230216125257.112300-10-brgl@bgdev.pl>
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

Enable the high-speed UART port connected to the Bluetooth controller on
the sa8775p-adp development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 6f96907b335c..1de3b9d4a05a 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -14,6 +14,7 @@ / {
 	aliases {
 		serial0 = &uart10;
 		serial1 = &uart12;
+		serial2 = &uart17;
 		i2c18 = &i2c18;
 		spi16 = &spi16;
 	};
@@ -89,6 +90,29 @@ qup_uart12_tx: qup-uart12-tx-state {
 	qup_uart12_rx: qup-uart12-rx-state {
 		pins = "gpio55";
 		function = "qup1_se5";
+	};
+
+	qup_uart17_cts: qup-uart17-cts-state {
+		pins = "gpio91";
+		function = "qup2_se3";
+		bias-disable;
+	};
+
+	qup_uart17_rts: qup0-uart17-rts-state {
+		pins = "gpio92";
+		function = "qup2_se3";
+		bias-pull-down;
+	};
+
+	qup_uart17_tx: qup0-uart17-tx-state {
+		pins = "gpio93";
+		function = "qup2_se3";
+		bias-pull-up;
+	};
+
+	qup_uart17_rx: qup0-uart17-rx-state {
+		pins = "gpio94";
+		function = "qup2_se3";
 		bias-pull-down;
 	};
 };
@@ -109,6 +133,15 @@ &uart12 {
 	status = "okay";
 };
 
+&uart17 {
+	pinctrl-0 = <&qup_uart17_cts>,
+		    <&qup_uart17_rts>,
+		    <&qup_uart17_tx>,
+		    <&qup_uart17_rx>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
-- 
2.37.2

