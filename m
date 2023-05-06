Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A773A6F94F3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 01:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjEFX2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 19:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjEFX2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 19:28:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62E21AEE1;
        Sat,  6 May 2023 16:27:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f19afc4f60so20635995e9.1;
        Sat, 06 May 2023 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683415666; x=1686007666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aWNeOXwnkGXx7BWbyXaj7Kul1oiC8tUChPKVcUGoAU=;
        b=hqBI5AfOQOQd86X8mkaZPkW/VEcSlmA4PGHENrf374QREkEIM45HC5HiV9T6St+Ol9
         L+Z73x/dc4oo7oWgjad8xZXH4eN5TH+0SyRBktv5r0Srl8Fvu7otgt10ZGBJYiLPxEM6
         EgqlXZvWGYllVgMEzgOKLIhC0VNANn0LrNFjDJgmzg0BTt8ow+gn6t1wuLeuAtFBrzc3
         92eek28suumx+hJ7ZjxgUJ/Sc2J8eRroFAEJ7I4h9nzEEcmEQEfTbimX685sW95CEOgr
         3OCX5KcftyL2ce9y2tltYrPuuH06OzzYlTXN7GAZhn2nAmwNWHxXztLeJVHlPXbyfH9f
         rDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683415666; x=1686007666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aWNeOXwnkGXx7BWbyXaj7Kul1oiC8tUChPKVcUGoAU=;
        b=Iw/hygGyw4h47HFY7Mb7shl4qQaV+0uhWnMOh8GrX8qejgFoDJOUeMFD212J/h3I9p
         k2FkbWhcPXHT9iCGQRxtLdmhn4gZYETAx7z9UqGhtxOOPknpmq53SrSM/5We7JKJKj0z
         xsUbZRo/TLQgaZR33fOO+IKZV9WDPboFEGK7v9fPoQXCVqNJnkOESRsslxT8CPqGOAuQ
         2Ruuz/PnF1zPv9tuvht4yRYTqx63OmMQZMTIjUomWGmlMgggVN6HD9+eow+K3E5rcvXM
         wZDbkJIQZjK0Yrf/e3UL/+YcY3esk3TwaD3W73DeaPOAElmp57+b/zvs0aVU45f4Z8BK
         dDUg==
X-Gm-Message-State: AC+VfDwsSJrdCtTYymfuzYEvmOxFU1otp/+jPhjUwbCAn3tmjsLES4jB
        NrzZ9TWpKqXBf3D/HjEtKAg=
X-Google-Smtp-Source: ACHHUZ7FTYmJxCyZm2ZCulaucrLFWOmqwq91uFwSGOBEAyYGzAOiOr1CSWhB+1vUVvzDTMOTN3LASA==
X-Received: by 2002:adf:db84:0:b0:306:28dd:5fb with SMTP id u4-20020adfdb84000000b0030628dd05fbmr3881083wri.62.1683415666151;
        Sat, 06 May 2023 16:27:46 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c7404000000b003f1739a0116sm12098655wmc.33.2023.05.06.16.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 16:27:45 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 5/5] riscv: dts: allwinner: d1: Add SPI controllers node
Date:   Sun,  7 May 2023 02:26:08 +0300
Message-Id: <20230506232616.1792109-6-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506232616.1792109-1-bigunclemax@gmail.com>
References: <20230506232616.1792109-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards form the MangoPi family (MQ\MQ-Dual\MQ-R) may have
an optional SPI flash that connects to the SPI0 controller.

This controller is the same for R329/D1/R528/T113s SoCs and
should be supported by the sun50i-r329-spi driver.

So let's add its DT nodes.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 922e8e0e2c09..1bb1e5cae602 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -108,6 +108,12 @@ rmii_pe_pins: rmii-pe-pins {
 				function = "emac";
 			};
 
+			/omit-if-no-ref/
+			spi0_pins: spi0-pins {
+				pins = "PC2", "PC3", "PC4", "PC5";
+				function = "spi0";
+			};
+
 			/omit-if-no-ref/
 			uart1_pg6_pins: uart1-pg6-pins {
 				pins = "PG6", "PG7";
@@ -447,6 +453,37 @@ mmc2: mmc@4022000 {
 			#size-cells = <0>;
 		};
 
+		spi0: spi@4025000 {
+			compatible = "allwinner,sun20i-d1-spi",
+				     "allwinner,sun50i-r329-spi";
+			reg = <0x04025000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(15) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 22>, <&dma 22>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi@4026000 {
+			compatible = "allwinner,sun20i-d1-spi-dbi",
+				     "allwinner,sun50i-r329-spi-dbi",
+				     "allwinner,sun50i-r329-spi";
+			reg = <0x04026000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(16) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_SPI1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		usb_otg: usb@4100000 {
 			compatible = "allwinner,sun20i-d1-musb",
 				     "allwinner,sun8i-a33-musb";
-- 
2.39.2

