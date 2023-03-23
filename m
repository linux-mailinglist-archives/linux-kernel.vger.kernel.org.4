Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36C06C73D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCWXBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCWXBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:01:37 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226CCDBCB;
        Thu, 23 Mar 2023 16:01:37 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h5so92319ile.13;
        Thu, 23 Mar 2023 16:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679612496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKi3A+dV0/tXsD8Az45Lpy5Jn7qD/QNBqF2DDHsjptI=;
        b=bbrVRFpgVq8Z3pBppHqtnNOI941pkMlpAPmDFti9VxOgzynxQt3tR06ysjKU2+DzfF
         UtoOufG2ylJ67O3C9L44T2wOHLLSGe9sIUvTRYah+xjdDwPYySLoOIY3VeCFqHhDFvTR
         cR4lbDtUHfWKEaOvGE6kQzp0szas1ks5+lblONRTAohv97yAmBp8yuwC56A9p3r8aAj2
         B4EZOQmM/l+YMe3/coS9LKmKgaoCNSO2gWSYSTshdYHNYkGKJeu9K8wCaESQn6dGr3ew
         6QlvLIFTpOHx6cSpbupE8aeVEvZvjX+b9ugcwp1gbWemJ/Ycfbp6amoCzKEoEm7d8+2l
         WUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679612496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKi3A+dV0/tXsD8Az45Lpy5Jn7qD/QNBqF2DDHsjptI=;
        b=qzvj2SxK1HfuEaqqfdduQ7+aIS9iYCj1YuGMwuLRs7BUuavhmoRCX4uX+B7k1CcpvS
         01zVzaBEJD3rBjUYiOPkJOj22Nd0gS6xBL391iFFThtF9GAG3ZyCibUJYVZGwOBS0XLw
         tKngP0dFpnj/oBoY3n4azjSMgt1niXVwf9V4z43PgbJQW3mzp1CUnv2Lul+axP1z5jwL
         lPZWRs8/RerVWLQ5vpdZkj7o1LntibGZLP9T8pPdr+uzBjSRkMZ9LE+tuYUOxdVCgUtu
         Rtv99MywlL8RpDGJ5SmAjy/UezUXBKglSC7CNyPxJFoSd8MDb9Nkxo4xJ+dCOIRk90ov
         NQXg==
X-Gm-Message-State: AAQBX9ftzpQrKO6NlmaK6484we8O4fAhArakg40bc94MUa35rjU0dN+Z
        SP7kdAUkNenJ3JpmjtrLbhdG6gjrtNc=
X-Google-Smtp-Source: AKy350YVoWYfxzjzrJIZa0sUyA0VhekNp7+yIqqBVCM5Wett6PZZYMup1lS9ba5KWjGP4UqlIqq0DA==
X-Received: by 2002:a92:d48a:0:b0:325:b96e:66fb with SMTP id p10-20020a92d48a000000b00325b96e66fbmr916084ilg.1.1679612496050;
        Thu, 23 Mar 2023 16:01:36 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:f38d:f05d:4666:1249])
        by smtp.gmail.com with ESMTPSA id w20-20020a056e0213f400b00314201bcbdfsm5405492ilj.3.2023.03.23.16.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 16:01:35 -0700 (PDT)
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
Subject: [PATCH V4 4/4] clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
Date:   Thu, 23 Mar 2023 18:01:27 -0500
Message-Id: <20230323230127.120883-5-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323230127.120883-1-aford173@gmail.com>
References: <20230323230127.120883-1-aford173@gmail.com>
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

