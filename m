Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BCA6C735F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjCWWwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjCWWvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:51:54 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ACE19F29;
        Thu, 23 Mar 2023 15:51:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id o14so94984ioa.3;
        Thu, 23 Mar 2023 15:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679611907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKi3A+dV0/tXsD8Az45Lpy5Jn7qD/QNBqF2DDHsjptI=;
        b=QfPT/4WC2X7jAlRT8+IvfxWvlZP2CfXyeSDJhl2CLaGv7cLC63TYcDVvkLq3fSd/4M
         S0bK5xy52t+Caul4cIxBgxke5dHP5MlaSRQFzw+3a9DcxBW+Xd3fafrKWRYTzLbrmZ1K
         87tQmanCExpFaNxGFfAaBcwdlQgXSAhKFY4Pmnq7ZXKGk0XpJCJEy9O4VVrWlyT9E+ND
         wj3iu2OGd+IvAfIGscKux4PLc9s9jUrK6q6FjSPcjalick5Mo/3dSBybpMbjZuChWlmZ
         vRsb6R0t0sunpVtesgjO6Ec9sKSOfrAnW2olOmdIRhju0z5+PyN9qNMmvlkhgqb8Kte2
         cw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKi3A+dV0/tXsD8Az45Lpy5Jn7qD/QNBqF2DDHsjptI=;
        b=lgwHNOwaRzkByujmIibOwf5tUVaM+yw/9zKXHZbWsFIL6Z7zeePhVZ/0JjCOQRDYMa
         K9R5QHG+PNA/nQN/zZ6qiyG59HerXWvzTJBSBCGRq8oim0CPx6YHdXY8qtN3EOgEr2wv
         1zpmRAZ7feaqHSk+5WpD0VPLUS5NcmYfH84sAgg0HAjXeF5i5XGHyn+u/KztIj3ZeeVC
         cxQXqMTt05kHIEZCRj2szpnEAdtDHF/XRx3ThbXfVlAXXVDqUbRTpNfpL03QnzONYfBF
         FTgeHSDXERrvrLJXZrOH29ZVUQFrzewiQi0vDzB1RKgLDI+p4gf6qt1favYacSR2yI7H
         j37Q==
X-Gm-Message-State: AO0yUKUo8XavNFfKtzHs+F0/YM4eC7CYAYEigadqXi/NzIXeu0lAgtbY
        mQYu6yeo/ELSRdfvJdMzbW71tov88Nc=
X-Google-Smtp-Source: AK7set+kvmHZiqjHbd6VY2U86cCCNsTDoJZB/YVJKwFj9hl7/FgixwpJZcWdS9bq7nIo6SHYOQJnIQ==
X-Received: by 2002:a05:6602:1415:b0:74d:ad9:d4f9 with SMTP id t21-20020a056602141500b0074d0ad9d4f9mr4342557iov.10.1679611907638;
        Thu, 23 Mar 2023 15:51:47 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:f38d:f05d:4666:1249])
        by smtp.gmail.com with ESMTPSA id f102-20020a0284ef000000b0040631e8bf89sm6266988jai.38.2023.03.23.15.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:51:47 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
Date:   Thu, 23 Mar 2023 17:51:28 -0500
Message-Id: <20230323225128.117061-5-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323225128.117061-1-aford173@gmail.com>
References: <20230323225128.117061-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default the display pixel clock needs to be evenly divide
down from the video_pll_out clock which rules out a significant
number of resolution and refresh rates.

The current clock tree looks something like:

 video_pll                594000000
  video_pll_bypass        594000000
   video_pll_out          594000000
    disp_pixel            148500000
     disp_pixel_clk       148500000

Now that composite-8m supports determine_rate, we can allow
disp_pixel to set the parent rate which then switches
every clock in the chain to a new frequency when disp_pixel
cannot evenly divide from video_pll_out.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index a042ed3a9d6c..4b23a4648600 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -470,7 +470,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mn_dram_alt_sels, base + 0xa000);
 	hws[IMX8MN_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mn_dram_apb_sels, base + 0xa080);
 
-	hws[IMX8MN_CLK_DISP_PIXEL] = imx8m_clk_hw_composite("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500);
+	hws[IMX8MN_CLK_DISP_PIXEL] = imx8m_clk_hw_composite_flags("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500, CLK_SET_RATE_PARENT);
 	hws[IMX8MN_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mn_sai2_sels, base + 0xa600);
 	hws[IMX8MN_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mn_sai3_sels, base + 0xa680);
 	hws[IMX8MN_CLK_SAI5] = imx8m_clk_hw_composite("sai5", imx8mn_sai5_sels, base + 0xa780);
-- 
2.34.1

