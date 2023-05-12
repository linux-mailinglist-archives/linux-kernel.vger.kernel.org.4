Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE1D6FFE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjELBEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjELBEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:04:36 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABF846A2;
        Thu, 11 May 2023 18:04:34 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-76c5ab0eaa1so290933939f.1;
        Thu, 11 May 2023 18:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683853474; x=1686445474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ1mT+Nk2N9M+HVwepWiYGdckgXCMaArOhKkQSuUL4Q=;
        b=GGo4WyEx+7TaC4Q+0kC9/3y2RcNjUtWw6kUUa9XDMMiwubH6qIKck4KZGzkoH1w8wS
         1tChj6gCsHEnPIzDRaIg4YXjrzpX+A0WM0HkqnaC7bW8fXzE43dmkc5ArjyFHJJF62Gm
         KCd7pGyfW65hUR3EjdiCSTPfnFtPVzvvHT3MZLSi3+5yxnB/nbmB8lDVxlRZhJCA0Mqa
         uwmg39a9yniKbRQeYK+6oU8JnTdh9PwCMKQQ9jwpQOSdd5WXZB9owzvtrOFV7aEcBXgy
         N1mUrsm63tLcP8lz/7hcdxNYNR8wYcisy14XPO0GvUvW7J2oBQZ2OASrJR8FoFaPoQDn
         Skpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683853474; x=1686445474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ1mT+Nk2N9M+HVwepWiYGdckgXCMaArOhKkQSuUL4Q=;
        b=A9BqSp2aKJeMJwDYGkeuuVIYNKDZkfLpE8fjiqcheua/6T1PoGrbS7SSqoykpiPvON
         amt1bd3pm7sLzcfjtgBLg5flfkwHFB4SQO8JgeYxn3fjtQnaqDcjR5qn8XaGTTVjquam
         fhI/qOs2gOicgAV2nD9mdLsSeiNQ9prVgcUiHE7jiCtGQWR1nPlUHN/i18SxBDfb6XFp
         ApK3lUfEI5ojeYHH7aqXf+NguA1ZqwTT+pgAGdaxVVjeNZJSIiyOcs0+8x0IK7Eu4h/+
         4mFOkQz3c1vFTAamlN/BuEIQ0cqcjRmlE0CA7xoG0DmuRtSHuQFlQaZcaBaCy4pShHY3
         Qj5w==
X-Gm-Message-State: AC+VfDwgQgG4XkfUvLaUEpoiRI27dHaDpCCVDICZaiPExSUnnpkrgrOl
        I7lqG8uM4qHwdI/oTmKEOoE=
X-Google-Smtp-Source: ACHHUZ7I9SIQmU+jZBGOnFf9WIVeeeCtk+T/wn3mFmM9mON78RngE6en8bFgE4oKjBGxQPLXhuK4Aw==
X-Received: by 2002:a5d:9bd4:0:b0:769:c95b:29d2 with SMTP id d20-20020a5d9bd4000000b00769c95b29d2mr15334332ion.15.1683853473939;
        Thu, 11 May 2023 18:04:33 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:57d3:515b:eddc:b201])
        by smtp.gmail.com with ESMTPSA id r15-20020a6bd90f000000b0076ca45ebfc4sm44000ioc.14.2023.05.11.18.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 18:04:33 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp: Fix video clock parents
Date:   Thu, 11 May 2023 20:04:23 -0500
Message-Id: <20230512010423.1227793-1-aford173@gmail.com>
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
and lcdif nodes, but these clocks are used by the media_blk_ctrl
power domain.  This may cause an issue when re-parenting, because
the media_blk_ctrl may start the clocks before the reparent is
done resulting in a disp_pixel clock having the wrong parent and
rate.

Fix this by moving the assigned-clock-parents and rates to the
media_blk_ctrl node to configure these clocks before they are enabled.

After this patch, both disp1_pix_root and dixp2_pix_root clock
become children of the video_pll1.

video_pll1_ref_sel           24000000
  video_pll1               1039500000
    video_pll1_bypass        1039500000
      video_pll1_out           1039500000
        media_disp2_pix          1039500000
          media_disp2_pix_root_clk   1039500000
        media_disp1_pix          1039500000
          media_disp1_pix_root_clk   1039500000

Fixes: eda09fe149df ("arm64: dts: imx8mp: Add display pipeline components")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index f81391993354..428c60462e3d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1211,13 +1211,6 @@ lcdif1: display-controller@32e80000 {
 					 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>;
 				clock-names = "pix", "axi", "disp_axi";
-				assigned-clocks = <&clk IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT>,
-						  <&clk IMX8MP_CLK_MEDIA_AXI>,
-						  <&clk IMX8MP_CLK_MEDIA_APB>;
-				assigned-clock-parents = <&clk IMX8MP_CLK_MEDIA_DISP1_PIX>,
-							 <&clk IMX8MP_SYS_PLL2_1000M>,
-							 <&clk IMX8MP_SYS_PLL1_800M>;
-				assigned-clock-rates = <594000000>, <500000000>, <200000000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_LCDIF_1>;
 				status = "disabled";
@@ -1237,11 +1230,6 @@ lcdif2: display-controller@32e90000 {
 					 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>;
 				clock-names = "pix", "axi", "disp_axi";
-				assigned-clocks = <&clk IMX8MP_CLK_MEDIA_DISP2_PIX>,
-						  <&clk IMX8MP_VIDEO_PLL1>;
-				assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>,
-							 <&clk IMX8MP_VIDEO_PLL1_REF_SEL>;
-				assigned-clock-rates = <0>, <1039500000>;
 				power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_LCDIF_2>;
 				status = "disabled";
 
@@ -1296,11 +1284,16 @@ media_blk_ctrl: blk-ctrl@32ec0000 {
 					      "disp1", "disp2", "isp", "phy";
 
 				assigned-clocks = <&clk IMX8MP_CLK_MEDIA_AXI>,
-						  <&clk IMX8MP_CLK_MEDIA_APB>;
+						  <&clk IMX8MP_CLK_MEDIA_APB>,
+						  <&clk IMX8MP_CLK_MEDIA_DISP1_PIX>,
+						  <&clk IMX8MP_CLK_MEDIA_DISP2_PIX>,
+						  <&clk IMX8MP_VIDEO_PLL1>;
 				assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>,
-							 <&clk IMX8MP_SYS_PLL1_800M>;
-				assigned-clock-rates = <500000000>, <200000000>;
-
+							 <&clk IMX8MP_SYS_PLL1_800M>,
+							 <&clk IMX8MP_VIDEO_PLL1_OUT>,
+							 <&clk IMX8MP_VIDEO_PLL1_OUT>;
+				assigned-clock-rates = <500000000>, <200000000>,
+						       <0>, <0>, <1039500000>;
 				#power-domain-cells = <1>;
 
 				lvds_bridge: bridge@5c {
-- 
2.39.2

