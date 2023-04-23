Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F34C6EBF76
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDWMfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDWMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:35:20 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9310EC;
        Sun, 23 Apr 2023 05:35:19 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-329326b4f10so9046165ab.2;
        Sun, 23 Apr 2023 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682253319; x=1684845319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QtnicWRsXeGVPUpqiniDebyuNAb5rFcvTu3vu+v4UpE=;
        b=sXoZE2SYKkMhm8OxNqfG32fhaRS3lCsepRnBMAwEqQYUp8i2UN2qKVKLPLr4gu32MI
         bznhpTzp5Aqh1+tqVgKvjVcOogGlYXAO3aauc+RfyvWRIgFfgqSgtccm8Zc49qUCkV3p
         +HS8wtOPcMdg8gU6U03h2uPpKjgxq7YbFF7yFn6MuiOSLtDa4xvWNBQ/fXF8xbGtacuV
         HUYcqsVcmcA6g7trlEawaJfGsxWvlC8uTUEZXTWlM2bXJgKlh4p334di0OIY006xARLn
         KRFlco0J72opbNkV+zQ30tusqpR+bA58SP5POExVAjnxX7dSNS+ZvDqI7KZq0ubWVQ6f
         GCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682253319; x=1684845319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtnicWRsXeGVPUpqiniDebyuNAb5rFcvTu3vu+v4UpE=;
        b=QtOVRK+Io+M9BwhH9wOWjJEZ5I6/ldcho0oK/qlYXRBl54wkkX3OAOzqgx1hjsIp/B
         ZGCwZatMPWsFvBbWrDQFQLQ9H2avwPykpa049jVP+TigxuAiXmBsegAgt34cD0ANvHsC
         YVo6oqF8lhZkH3Ui/zQiAOjnh3fMIyvvT4XB9Er3E7Z6INoRb/Y/wJ9lTty0gFNmWHXo
         8umNISN/eICf9aer9HPJYqtHBDADVZslHIojpEfRBaytkw2VId4NxMAgphPNbAPTxwMj
         fFHQhxlZxs1h2lQkg+J6R3Uu2Mly3qs1Gkt2gX0zJIEfxj9W+LFCiugD4neSPKv2/X4b
         I+4w==
X-Gm-Message-State: AAQBX9cAO4NWgLQD2S8PchISr6d9AHkLONFfaG07tZ8pATojixvPR4pk
        1ithaMqdGU/vDMY29To/lqs=
X-Google-Smtp-Source: AKy350aLEw59rtT9KSESirmcgbKF47ZYPYkZnHWFXuWglUB6fQp4VVdJ56ID1zS1LBKpjxtlDg3IDQ==
X-Received: by 2002:a5d:9b18:0:b0:762:f8d4:6f9 with SMTP id y24-20020a5d9b18000000b00762f8d406f9mr3449146ion.2.1682253319105;
        Sun, 23 Apr 2023 05:35:19 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:b473:5d7c:4c2:75d7])
        by smtp.gmail.com with ESMTPSA id d8-20020a5e8a08000000b0071d93cda853sm2554549iok.42.2023.04.23.05.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 05:35:18 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64: dts: imx8mn: Fix video clock parents
Date:   Sun, 23 Apr 2023 07:35:13 -0500
Message-Id: <20230423123513.1346323-1-aford173@gmail.com>
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

There are a few clocks whose parents are set in mipi_dsi
and mxsfb nodes, but these clocks are used by the disp_blk_ctrl
power domain which may cause an issue when re-parenting, resuling
in a disp_pixel clock having the wrong parent and wrong rate.

Fix this by moving the assigned-clock-parents as associate clock
assignments to the power-domain node to setup these clocks before
they are enabled.

Fixes: d825fb6455d5 ("arm64: dts: imx8mn: Add display pipeline components")
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Split this into a separate patch away from a series of DSIM changes.
     No actual changes made to the patch.

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

