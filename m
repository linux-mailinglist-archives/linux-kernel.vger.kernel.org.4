Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC96C283F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCUCcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCUCcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:32:12 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FB3399D3;
        Mon, 20 Mar 2023 19:31:53 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id r4so7490550ilt.8;
        Mon, 20 Mar 2023 19:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679365912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/mm5G0PkOndQQapwu4nkn1W5qAmcqtIfUJayOecLk0=;
        b=njQQ2EZ6+w4LBgLXRCDOA1u/7yBrAiap9M56rD9qLhp8bs3ohxOy5MjiVFuMarc+PJ
         5ifchgcAVvsBA0HIYA90NPsQau9ZJgJ/qGCV6HN5EINCiiIlTxhXUR3XOyvEPQVdHsPA
         wVAhNWso3D8bz+51lpszZqRXycM+P/1iiJN2DrYsP8qcv5XW0HVew+5IfCT3Kc65xenM
         Sa7cu0z4L5h9CLJPUM/ndxB7u421CfqPkUBXh8oGkkCx425O22GJEiuA1BuxDMmEsjsy
         0rSGTSgWh6uqZEow46y6hGw+FxlxAJ9MeeL6dtSnLlkkrivn0u6RSGmO1YipG8O5f2BE
         5z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679365912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/mm5G0PkOndQQapwu4nkn1W5qAmcqtIfUJayOecLk0=;
        b=frNiWb9f0pHIbIAbnTJafmXBvEKtoob6DZ/vAxBUYPpI9PYlXEf+MtPKOnC3qpYw0D
         5ObWXEjxMtNE+YEWkvQt6Kkc5IJanBrRszhnMTpWbC3aHBRiyZcNLwxfZofxXSzv3eNz
         fC3Ib5E74bUIRnGQU/azWZAHbpDMR7Md6KuC+YICW6qOvC/I4x3YOsrMd9Dt9L/2S0KX
         y1sBsXUnj+wBopc7Ky0AcEMMlZ/bZED8nQ8aai9NB1jPKqavOgAIrPn3IPVTYtU6dyRN
         08+RE64Bs0WSsl+tjR0A4DYLIhySXZqzkk9ZWnr1w2GadUQF7vHG1w15MMpHsgz1BZsg
         M81g==
X-Gm-Message-State: AO0yUKXDjEXXhirBybsSpgYAKpz7NkJ2SujF2J5GOSEIDtQuZrCiYNxJ
        C5HSlKxXrilGsrIMmC0J54/uWzFl/84=
X-Google-Smtp-Source: AK7set/xGd4TZlxrqYJ02heVW2VbJ5R2Z1EZ24Lg2WVPoEgarTmsm6XiI/xSD+9eq4JwVthB9RTdvA==
X-Received: by 2002:a92:4b0a:0:b0:317:93dc:10f5 with SMTP id m10-20020a924b0a000000b0031793dc10f5mr524195ilg.19.1679365912239;
        Mon, 20 Mar 2023 19:31:52 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:1387:3268:b209:f4ec])
        by smtp.gmail.com with ESMTPSA id a28-20020a027a1c000000b004065ad317fdsm2241200jac.151.2023.03.20.19.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 19:31:51 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/4] clk: imx8mm: Let IMX8MM_CLK_LCDIF_PIXEL set parent rate
Date:   Mon, 20 Mar 2023 21:31:35 -0500
Message-Id: <20230321023136.57986-4-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321023136.57986-1-aford173@gmail.com>
References: <20230321023136.57986-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default the display pixel clock needs to be evenly divide
down from 594MHz which rules out a significant number of
resolution and refresh rates.
The current clock tree looks something like:

video_pll1                  594000000
  video_pll1_bypass         594000000
     video_pll1_out         594000000
        lcdif_pixel         148500000

Now that composite-8m supports determine_rate, we can allow
lcdif_pixel to set the parent rate which then switches
every clock in the chain to a new frequency when lcdif_pixel
cannot evenly divide from video_pll1_out.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No Change

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index b618892170f2..075f643e3f35 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -468,7 +468,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MM_CLK_PCIE1_PHY] = imx8m_clk_hw_composite("pcie1_phy", imx8mm_pcie1_phy_sels, base + 0xa380);
 	hws[IMX8MM_CLK_PCIE1_AUX] = imx8m_clk_hw_composite("pcie1_aux", imx8mm_pcie1_aux_sels, base + 0xa400);
 	hws[IMX8MM_CLK_DC_PIXEL] = imx8m_clk_hw_composite("dc_pixel", imx8mm_dc_pixel_sels, base + 0xa480);
-	hws[IMX8MM_CLK_LCDIF_PIXEL] = imx8m_clk_hw_composite("lcdif_pixel", imx8mm_lcdif_pixel_sels, base + 0xa500);
+	hws[IMX8MM_CLK_LCDIF_PIXEL] = imx8m_clk_hw_composite_flags("lcdif_pixel", imx8mm_lcdif_pixel_sels, base + 0xa500, CLK_SET_RATE_PARENT);
 	hws[IMX8MM_CLK_SAI1] = imx8m_clk_hw_composite("sai1", imx8mm_sai1_sels, base + 0xa580);
 	hws[IMX8MM_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mm_sai2_sels, base + 0xa600);
 	hws[IMX8MM_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mm_sai3_sels, base + 0xa680);
-- 
2.34.1

