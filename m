Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D912870B203
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 01:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjEUXLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 19:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjEUXLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 19:11:05 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09522CD;
        Sun, 21 May 2023 16:11:04 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3382b8b3c33so41139955ab.2;
        Sun, 21 May 2023 16:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684710663; x=1687302663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fR1fnzVsiO6TQrco2vdiwn9ZSO3wfii/ZP217z+d6sY=;
        b=Gc7wLockmD4v+aSXwZMKBZ7I/u5xtpXXlmagZbUmnWmO/y6jjGKa7RUxtMC/T8SG5N
         yIP1uHr2ExY80WdW1jvKu5LqF62+iZCzjT962Xh4qQVsyR3XIgnaJUtWN0GbWR6/aUB+
         uRmPNKPW3AgIvu3wVqC0euT0CLrcuiUYpfZcqc4+dJ7k9m5d40lsCet5Ngt4uvplnnhG
         sy4AQxFRr3WFySKImr4CK6Ruk9wHONZXpp6877P9hZGtU8fmYzY4SE8X2JbKHqHRLUY/
         8UuO0OU+OFzIfO/QaZvNgBJEUswa7vPltRF3zoyPTaMW7uf9Usu3jWEOb3S+N4x65Zz4
         JK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684710663; x=1687302663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR1fnzVsiO6TQrco2vdiwn9ZSO3wfii/ZP217z+d6sY=;
        b=SHLI7CVNvqZRoWOd66k/02C1GfDpIEB10Ugh9o6rIUjmJNoNnBl13czkn2D7zFt4E/
         5ytClub2KEMHEu4bYwtIpBcZYY7mUI4m6qzF3FKJSex/OLJfvO0i7Hcmb7kQ08MdIZdX
         ba5/52vXj5jiLFrP0J1uaUxZ+TPtVSziCZ49J2UkQAGaNHMRDcpi/A/dV3qQ6vR2ynou
         Q907vWZ5XOQsCowb/3hpt26btgN40Z8l83n5vkxxsGIUUs9e11cgWNUDl1g0Fpc4ynDP
         nhjTyT7g4ZDMCI3gZuYhlxol64MZMhYsqTOuClmLXiERHhprV7WaDXs6C9MF5K7jaM7l
         o2TA==
X-Gm-Message-State: AC+VfDwRl2sKOX1o1qaQlXA8zUd3/WqsQlxDp8Ojamch7dJTLpIlyVD+
        JRcjZLAUuB+X50OUneOS7kA=
X-Google-Smtp-Source: ACHHUZ5qTtzjMeqjz4J5xQqWpVvxTmUX/LLonCNiWhPS9JJleopzkoK5l+pwhL1tYrWCis2JDEbaqA==
X-Received: by 2002:a92:d708:0:b0:338:6ace:dd74 with SMTP id m8-20020a92d708000000b003386acedd74mr5918827iln.18.1684710663219;
        Sun, 21 May 2023 16:11:03 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:84e4:c2f6:44bb:b929])
        by smtp.gmail.com with ESMTPSA id a93-20020a029466000000b00416789bfd70sm1367468jai.1.2023.05.21.16.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 16:11:02 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mn-beacon: Migrate sound card to simple-audio-card
Date:   Sun, 21 May 2023 18:10:54 -0500
Message-Id: <20230521231055.167351-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a custom glue layer connecting the wm8962 CODEC
to the SAI3 sound-dai, migrate the sound card to simple-audio-card.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index bd84db550053..8be8f090e8b8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1069,13 +1069,6 @@ lcdif: lcdif@32e00000 {
 					 <&clk IMX8MN_CLK_DISP_APB_ROOT>,
 					 <&clk IMX8MN_CLK_DISP_AXI_ROOT>;
 				clock-names = "pix", "axi", "disp_axi";
-				assigned-clocks = <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
-						  <&clk IMX8MN_CLK_DISP_AXI>,
-						  <&clk IMX8MN_CLK_DISP_APB>;
-				assigned-clock-parents = <&clk IMX8MN_CLK_DISP_PIXEL>,
-							 <&clk IMX8MN_SYS_PLL2_1000M>,
-							 <&clk IMX8MN_SYS_PLL1_800M>;
-				assigned-clock-rates = <594000000>, <500000000>, <200000000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_LCDIF>;
 				status = "disabled";
@@ -1093,12 +1086,6 @@ mipi_dsi: dsi@32e10000 {
 				clocks = <&clk IMX8MN_CLK_DSI_CORE>,
 					 <&clk IMX8MN_CLK_DSI_PHY_REF>;
 				clock-names = "bus_clk", "sclk_mipi";
-				assigned-clocks = <&clk IMX8MN_CLK_DSI_CORE>,
-						  <&clk IMX8MN_CLK_DSI_PHY_REF>;
-				assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_266M>,
-							 <&clk IMX8MN_CLK_24M>;
-				assigned-clock-rates = <266000000>, <24000000>;
-				samsung,pll-clock-frequency = <24000000>;
 				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_MIPI_DSI>;
 				status = "disabled";
@@ -1142,6 +1129,21 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
 					      "lcdif-axi", "lcdif-apb", "lcdif-pix",
 					      "dsi-pclk", "dsi-ref",
 					      "csi-aclk", "csi-pclk";
+				assigned-clocks = <&clk IMX8MN_CLK_DSI_CORE>,
+						  <&clk IMX8MN_CLK_DSI_PHY_REF>,
+						  <&clk IMX8MN_CLK_DISP_PIXEL>,
+						  <&clk IMX8MN_CLK_DISP_AXI>,
+						  <&clk IMX8MN_CLK_DISP_APB>;
+				assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_266M>,
+							 <&clk IMX8MN_CLK_24M>,
+							 <&clk IMX8MN_VIDEO_PLL1_OUT>,
+							 <&clk IMX8MN_SYS_PLL2_1000M>,
+							 <&clk IMX8MN_SYS_PLL1_800M>;
+				assigned-clock-rates = <266000000>,
+						       <24000000>,
+						       <594000000>,
+						       <500000000>,
+						       <200000000>;
 				#power-domain-cells = <1>;
 			};
 
-- 
2.39.2

