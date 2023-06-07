Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E79725444
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbjFGGcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbjFGGb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:31:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9851730
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:31:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f73617a292so38379675e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686119509; x=1688711509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlm5X0f1SJIUHEa+Ch7CRBAmlhS5LXsyaOP8GZ1/KKI=;
        b=bzMNTxZK/4hAhbCJfyfkajbjSZHcrJlJ/ANGEgI8Xc2LZi/1j3XIaARW8OaUk1oUNt
         xVXHCzLxMc+NJPP7tmKJXtlG0YFtoAOv6eKRl6cIeAXRzBEeZFxDxGMzfM6EQiFdDCoG
         UlbJzxvd+HoA7k7tgjRYe/4BsTTBBkPNUkICY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686119509; x=1688711509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlm5X0f1SJIUHEa+Ch7CRBAmlhS5LXsyaOP8GZ1/KKI=;
        b=H/sTvA4tsp18oD6YD7HflObQqMqZH5UPrpglRwKctSl6F8/+GrpBKrq2xV39K51YJ5
         M3CxZetb5UcJfenpEUk0vYS/5Lymou6I+AcSbBKUX8Zd2MFEu3AQzbo8A8OJly+TSlps
         vPS1p8/sZla2/TULk0Mi/yiPrFzmtnCqBeu61BUkd0ylAifUbwoeRX5FTVO6Hxx6NbbQ
         9v3XtJnuCG/IeIElrEZVYKmwUHF0yQB+KvlebdXeCKmaR+yUY1wjwvnBC8qcrlwnhBf7
         9Tx0EEm0lEtg8gE47UYex8SBdmiw7Y5w5JCa4y1C3KM68JY5qa+5slE+N76ugeXOMSEO
         W7PA==
X-Gm-Message-State: AC+VfDwdi6z39YuRGUeJFNBvCC9Jc1Ev/stdn1HUy1q4MnGwflK67M31
        ewTjQSI3Vp+5TDrNhuQW/1M4HBVs5PZ8RdhbJZ0M5g==
X-Google-Smtp-Source: ACHHUZ6ixe3R4kTg2jdLqsiTsvsMwIkzn0sw/3lIsOWGtuw4V3ztP1iDpCLGs/weEh3bWDKm3W6iSg==
X-Received: by 2002:adf:eac1:0:b0:30e:5729:b5a5 with SMTP id o1-20020adfeac1000000b0030e5729b5a5mr1086540wrn.38.1686119508799;
        Tue, 06 Jun 2023 23:31:48 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.114.163])
        by smtp.gmail.com with ESMTPSA id m6-20020adff386000000b0030630120e56sm14385127wro.57.2023.06.06.23.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 23:31:48 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        michael@amarulasolutions.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RESEND PATCH v2 3/6] ARM: dts: stm32: support display on stm32f746-disco board
Date:   Wed,  7 Jun 2023 08:31:36 +0200
Message-Id: <20230607063139.621351-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
References: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
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

