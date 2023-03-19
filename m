Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB016C0202
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCSNVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjCSNVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:21:37 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F87222D4;
        Sun, 19 Mar 2023 06:21:36 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p17so2605281ioj.10;
        Sun, 19 Mar 2023 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679232095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICE/28jdiWQEExDCz4xlI7/MltQ5deN6UZpAbZEvh1g=;
        b=dwsNCcZCAaA8Y95qfxLCA6gLC/K5wYt/9k7ZquFa43Fw5t8CDxySvGP93vagrin9h+
         9Ruyraig8kgFcB0eLmEIqwN+zpo7ETEMJirizprUeyBchxaZuPMKtZyaTxLisJ3bguUB
         QGxU1SvqDYURdkUbw0Rz6XckvfoHZLXHET+/XgqvDof5lfZPQSLcrUy/0Ks6U5PCV4m+
         vXGBp88/pm8M3QZJHiTjOncseRwaPYIXMdvk2mG7chqijMJ93WZzDSC4DQrr+hjWrvnr
         gl7/TZkD2DoHfrXGtL3WWdygPKaXpO0A+CmbmVAytN8uHj9Z+ykVkKl0pysyIlWSZL5r
         kkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679232095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICE/28jdiWQEExDCz4xlI7/MltQ5deN6UZpAbZEvh1g=;
        b=NR+ZQGHqwOcbpkFe8zCe9so6UK+LhkdGIjt0q5J+msOyWf55VTgWYD2pqWZjy2cnNs
         JhcWs41Abc3altgemP4ojRnTw77Q7+Q/WO+AOQDHVWWnFxd7I1hoIXf5Ldk094X1Q0rd
         5YUQdgrzW9LV64jt6n9vu2a1ZweYbgau8aEjfFgJvCRlVwyCoZQAOBS+SDnSUE02LJgB
         a0WKVeO9R+drm2A+3SkEr/jafeDWL+DoNDyx+zKDLzFv4NJyKUuM3+QFaV+k9GGuHnqI
         5gGcRUPcjBQu9pY0VMUyQg1sI9t9gFJS5Xa5QD7fDuD70laDvQ1WVF9v4o1C0m0O99AI
         TsqQ==
X-Gm-Message-State: AO0yUKUd1uSEzuO8SMYPaC38vlqIBFUylexc9SaPdvrgJz5+vy9hJtoT
        RVMv7ByBYQM7FOJ1JPnNdpr4RvSP7iA=
X-Google-Smtp-Source: AK7set9jE3Qxtj29KL2vNJruxgw0I0I8Rgfvxf+OhLddCuPylzgqtHa2ahdOmGXz8gVXWjtyP7qaMw==
X-Received: by 2002:a5d:8254:0:b0:750:6c44:3454 with SMTP id n20-20020a5d8254000000b007506c443454mr3247920ioo.12.1679232095050;
        Sun, 19 Mar 2023 06:21:35 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id a23-20020a027357000000b00406227162fesm2363460jae.32.2023.03.19.06.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 06:21:34 -0700 (PDT)
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
Subject: [PATCH 2/3] clk: imx8mm: Let IMX8MM_CLK_LCDIF_PIXEL set parent rate
Date:   Sun, 19 Mar 2023 08:21:19 -0500
Message-Id: <20230319132120.6347-3-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230319132120.6347-1-aford173@gmail.com>
References: <20230319132120.6347-1-aford173@gmail.com>
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

