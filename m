Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FF26C2840
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCUCc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCUCcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:32:14 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B977A39283;
        Mon, 20 Mar 2023 19:31:54 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h11so7481127ild.11;
        Mon, 20 Mar 2023 19:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679365914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqpGcS63yc5cSPHmxqdpFofUmCewSZ11m39gJLQd6jk=;
        b=XJK8bYuAYWV4i+jlGHDK0/eQ6IRVok7DNw6IJTnUYWwb4ig0zAAX0SIU3PHXgfpnJt
         2HQF2Umxf9xDQihRG/fSD65jlmjzeBcSQUgPywH4RijcHEjUSbGWDZc3WgourQC8J4Ic
         dzn+iNwn5DrCUANEZUqD28UUJtZUpM8a5pOsNwo6uG2rE8ZKmrDjJD/biWzU+f5dPpli
         W0R7BtzGCR9ZCu8ITtypWIWuM74mjNg/ZBV8eh+yGx8Vcs8iq4Z283Ktyx22dxd4dSNM
         AvPqHZNsn7l+K+zxiQr0551r7gtRKAEZWwPy0Bth2GJaTKOlGRMbuQ6g0ozw28kRm4a8
         oe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679365914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqpGcS63yc5cSPHmxqdpFofUmCewSZ11m39gJLQd6jk=;
        b=NMzgIDHeFlHWexDRavOMmmkyW26QYvyIqQys0FNicj0yE4cZ1H3nLUHIYH5HcsUSgQ
         //jV9J+qtBSLB4OFLfRLZ/7qKkV/LajxU9tMO/UhNLDIAZxtlV7me1CaJQMMh7HpDLE/
         aQq+oKU4seGzvAMQLyPfdJeIMxc56x9nQtcPNVC/BHMNy3tk5gR6/3G+HsOnidKn3wfS
         Z99mIH0+mkuw4oj+sgNb1ItUvFHkAhCB88ea12lZuvsg0pwdrfECmupxcyrdbiHzqQSu
         /D/qLcw1SyvgG6fibr9dreFPu3j9X/oM934T4b8FPrz/jI3ng8wTWUVHMC6otsKv/m1E
         vR4Q==
X-Gm-Message-State: AO0yUKUp+j9uJhlickS0jufyHg+I4eNuajLm+Pu/Ujnjqw/tVtxAw1Fw
        3kCOmHYm35N5uwQ60g9EXxmoV/JyMY8=
X-Google-Smtp-Source: AK7set8HYWHZUuD+7SIheB2PsHjWfQQaWd1+NCf3uo8ARCLs+rPES5DAi/i/7R+KWeEiFzcgOgKtOA==
X-Received: by 2002:a05:6e02:2162:b0:315:6f9d:e75 with SMTP id s2-20020a056e02216200b003156f9d0e75mr395505ilv.7.1679365913785;
        Mon, 20 Mar 2023 19:31:53 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:1387:3268:b209:f4ec])
        by smtp.gmail.com with ESMTPSA id a28-20020a027a1c000000b004065ad317fdsm2241200jac.151.2023.03.20.19.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 19:31:53 -0700 (PDT)
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
Subject: [PATCH V2 4/4] clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
Date:   Mon, 20 Mar 2023 21:31:36 -0500
Message-Id: <20230321023136.57986-5-aford173@gmail.com>
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
---
V2:  Move imx8m_clk_hw_composite_flags macro into its own patch

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

