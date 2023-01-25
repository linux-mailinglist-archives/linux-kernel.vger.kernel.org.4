Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276A967B490
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjAYOew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbjAYOen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:34:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469759984;
        Wed, 25 Jan 2023 06:34:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id be8so5156393plb.7;
        Wed, 25 Jan 2023 06:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uUEIUXRT9q9lHy3kc8AWUGd4aWNpn7Eo0QlIhJUhEE=;
        b=bbLfdOAYTTbyGy3Pjn2l/V+nZL0/zc7m7ILa4+blFmAhwL0yBtgJevoY97wMdAyHWx
         KAXNp1M4yjLcZT0x+EFujMqyCCIPgTxyKKtQLnzNKaq6pntp6UBHqosiUJRrsHk2OhsV
         sdmRSmrhNNC3qeACPMKFtC8PRmrft/M/1DnB8MNqtIacKcaJojZEFwOqCzXbzj6D4B8D
         dlSSLltt3F998561RLYxPqPgPR02HWJv3M7Ui3XpSKTlNFpUqMSr1agbwAm8up2kI5B/
         4OLjsIgs9XP+RMYMkJAPK1Pay/bfVgEfXHxjbsxeYVjK/Vbl3wAD4H+lAHwjJwenKV0o
         E++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uUEIUXRT9q9lHy3kc8AWUGd4aWNpn7Eo0QlIhJUhEE=;
        b=eKPINmnxNm2bPmlfDiag+utQYTtncRw4cxiuouPA7j/TlL/X5oZiVDxeTm33zguHS0
         SCVKYMdWAlbtSmU9dO7MLduMO9tsbbskowZODZxKHq7p1lGZwJNmxEqVztBpZhF3q2yz
         gKaQnXtXLJ09YzB3GrD8u4QOQsZjJBlOZmgX0pNgoKnqNVXzz3ko4Gqv0cDi1vQiajoC
         mCYQ6WjpDwvDERZXGtowLsrZNcjdlsY+zI5GwSupuGitIMUqJbwFuCkGX8XiW2IzEs+5
         qDqmdkS61/VEI2d1365RmiDj4qJ60lNBWDaQvT0W3ixyJB7+gd+BuitF3yXypA2ry+Ag
         NMhg==
X-Gm-Message-State: AFqh2koSiKEVz3ttfALAeR/t+RWZWMn5qRdWMMIDm2k/fYl4DVT5NixI
        mCkZAkQb8HaQm4/s2NOi4WE=
X-Google-Smtp-Source: AMrXdXuPaax7cW0zR8SleapPgK1Xc3MqA2CnRHvd6tNBi5TlrQ1FsAi02NbRNP6wV+CScodvylHOjA==
X-Received: by 2002:a17:90a:160f:b0:228:5b99:3b45 with SMTP id n15-20020a17090a160f00b002285b993b45mr34241546pja.7.1674657278370;
        Wed, 25 Jan 2023 06:34:38 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a1d0200b0022c033f501asm1671465pjd.41.2023.01.25.06.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:34:37 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND linux-next v4.1 3/4] arm64: dts: meson: move usb-hub node under dwc3 node on Odroid C4
Date:   Wed, 25 Jan 2023 14:34:02 +0000
Message-Id: <20230125143404.1424-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230125143404.1424-1-linux.amoon@gmail.com>
References: <20230125143404.1424-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the usb-hub node under dwc3 node and drop superfluous
dr_mode as it is the default in meson-g12-common.dtsi.

Fixes: 71593b2020b3 ("arm64: dts: amlogic: Used onboard usb hub reset on odroid c4")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 41 +++++++++----------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
index d04768a66bfe..a988015dd2d5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
@@ -26,30 +26,29 @@ led-blue {
 	sound {
 		model = "ODROID-C4";
 	};
+};
 
+&dwc3 {
 	/* USB hub supports both USB 2.0 and USB 3.0 root hub */
-	usb-hub {
-		dr_mode = "host";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* 2.0 hub on port 1 */
-		hub_2_0: hub@1 {
-			compatible = "usb2109,2817";
-			reg = <1>;
-			peer-hub = <&hub_3_0>;
-			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
-			vdd-supply = <&vcc_5v>;
-		};
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub_2_0: hub@1 {
+		compatible = "usb2109,2817";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&vcc_5v>;
+	};
 
-		/* 3.1 hub on port 4 */
-		hub_3_0: hub@2 {
-			compatible = "usb2109,817";
-			reg = <2>;
-			peer-hub = <&hub_2_0>;
-			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
-			vdd-supply = <&vcc_5v>;
-		};
+	/* 3.1 hub on port 4 */
+	hub_3_0: hub@2 {
+		compatible = "usb2109,817";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&vcc_5v>;
 	};
 };
 
-- 
2.38.1

