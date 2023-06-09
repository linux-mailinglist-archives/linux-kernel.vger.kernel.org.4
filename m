Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA819728FE1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbjFIGVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbjFIGVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:21:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD391FE6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:21:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-516a008e495so3094247a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686291666; x=1688883666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlm5X0f1SJIUHEa+Ch7CRBAmlhS5LXsyaOP8GZ1/KKI=;
        b=Zn2wbcwo21fhOpg5eFi3fFexbvEY7Ul6UQIoI1MeNQzf5cOD48Pb9CySIeYGY3/Jju
         r7AdVz3fWHqUZfj/p0Ek4p2HnCOJ+jHcldG9ZArs4G454NpdYB8sl6yLnYyTTWgzM56J
         YRveOMviMIp2hQ/ahVfiS2GmRK+Xlv1GoA9b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686291666; x=1688883666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlm5X0f1SJIUHEa+Ch7CRBAmlhS5LXsyaOP8GZ1/KKI=;
        b=Nhztwq1OVYlkf6nB9mZHrAlaOR5hOHmrfeyZWf3oSbmcLDTpfTUKSsHF1MCfgpBrxt
         MZQdADINv+jjQWf5zB/CrIfKAuOahMOYUHNbBKW4LpXXwXo+9nm6Fx+kjeU4sJxO+u2U
         TVkRL2xeJxwihkFR9AoGre4PRSioS30y86Gh+slp5VPNvxtipR3dU10V6spZ2tlFvk/R
         huBuJjVqgZJHy33xvLkp+fLIYE74RfvGp7kwyl44/OTV5ITl7+nOr7iRXxNp+KXZcxiv
         Swy7Kt8QO2dfaeFktO4JvOzNOTOtVKZIng0S/GyXEr+qnyvEGgUoZFaA5Q5I+nKQlyax
         1G9A==
X-Gm-Message-State: AC+VfDyKdgS+r7WguR3NtulvZvgsw22ZJJxJgYlX1e6kUW5BqQskrUKJ
        tsTQ4lnZGvOoJlJMbzmtJuImT4dtRm+/UGo7MkAs7w==
X-Google-Smtp-Source: ACHHUZ4xW5JNQUR9WpWc3Icd9H1a0H3sV6NT4RZVtX5z+P6Z7QibdOPH+DuK978r1/65E63K0G3P3g==
X-Received: by 2002:a05:6402:270e:b0:514:9e81:6185 with SMTP id y14-20020a056402270e00b005149e816185mr4277430edd.16.1686291666238;
        Thu, 08 Jun 2023 23:21:06 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-20.retail.telecomitalia.it. [95.248.31.20])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7d347000000b005149461b1e0sm1380058edr.25.2023.06.08.23.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 23:21:05 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 3/4] ARM: dts: stm32: support display on stm32f746-disco board
Date:   Fri,  9 Jun 2023 08:20:49 +0200
Message-Id: <20230609062050.2107143-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230609062050.2107143-1-dario.binacchi@amarulasolutions.com>
References: <20230609062050.2107143-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Rocktech RK043FN48H display on stm32f746-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/stm32f746-disco.dts | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
index c11616ed5fc6..cda423b6a874 100644
--- a/arch/arm/boot/dts/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/stm32f746-disco.dts
@@ -60,10 +60,41 @@ memory@c0000000 {
 		reg = <0xC0000000 0x800000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			no-map;
+			size = <0x80000>;
+			linux,dma-default;
+		};
+	};
+
 	aliases {
 		serial0 = &usart1;
 	};
 
+	backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpiok 3 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	panel_rgb: panel-rgb {
+		compatible = "rocktech,rk043fn48h";
+		backlight = <&backlight>;
+		enable-gpios = <&gpioi 12 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+		port {
+			panel_in_rgb: endpoint {
+				remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
@@ -99,6 +130,26 @@ &i2c1 {
 	status = "okay";
 };
 
+&dma1 {
+	status = "okay";
+};
+
+&dma2 {
+	status = "okay";
+};
+
+&ltdc {
+	pinctrl-0 = <&ltdc_pins_a>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	port {
+		ltdc_out_rgb: endpoint {
+			remote-endpoint = <&panel_in_rgb>;
+		};
+	};
+};
+
 &sdio1 {
 	status = "okay";
 	vmmc-supply = <&mmc_vcard>;
-- 
2.32.0

