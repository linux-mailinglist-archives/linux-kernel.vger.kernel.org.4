Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5E6C0203
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjCSNVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCSNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:21:39 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D822794;
        Sun, 19 Mar 2023 06:21:37 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h11so5253901ild.11;
        Sun, 19 Mar 2023 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679232097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jRLas+X66DwX3DvgENKtWbw6Tk9kAguCjzndTr3/Fs=;
        b=J9DyP+7/MlVewq+owGn+geALUpv3MYnFqyNPqqv5xtvFRYzsxIAUC1RKIvEqAubk93
         rTfJBEv0/IHksl3L9dZ8MSkyuHdPgkmBuK5rmTe80SnBIsEmGdc4T1iOwohN9J01GLIW
         56VlyFvZrmDiRNuOqgZlEL9midprlFaCt8JpZJlVYxs4S+90wcKY5XcJ9jf63stCyU+v
         fznUYlOJQCbtzfOObWyRK40qDfCYef8jWOJmKsCFr0phBiMiOSJQ9XN+lKqb8dP9RrZL
         lvwgAfdCOHivA1K9vcDxj6amxv6St5eZJzCAoW9pgK4jqs1MkyH8EGwtc1rZWCaiJ9uS
         O0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679232097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jRLas+X66DwX3DvgENKtWbw6Tk9kAguCjzndTr3/Fs=;
        b=PgBhLnMtfnun+A7kZWz+4VGvjllOrBZB6Qw+9emoFT4mflgnEXu8/JxVbk+uNe4HrB
         13dfweNzhuJFoi5pqWy/m+0X4wsbcrcbe/BYq1j8dTMoXPDQXiE7ZSOELgBZ5U6rw80Z
         GctdhV7rLMrKJ2pLbQzDvofD/0sNbGFmuhiwqLshFKz2Y/vnP47wsRx4tdyqMk+DKYR0
         U24Iofr3C5+0UVl+3m5fnWeTTJxkUsgx9bTWQB9kJZtGzIGdZvgTCjQDWIqtX3cZ2Dre
         KFH3UvSCB5C10lMsw3aQJi0idVVBLzNwIFTp/3rQGUL0MdXIE2lwwn/ay7fLWu25xCzm
         QVDw==
X-Gm-Message-State: AO0yUKVZ8R+i7HCJX2hgtREEOSfsWuiUERfZKSy4UxAv6bOMkJk2dxMr
        yRuznsohiUV9HM7/sGceYW4ckaR8fSU=
X-Google-Smtp-Source: AK7set9E8JPLYVAomIXIP7dJobm+AJ5GJXDPiDKsreSdMdMszzhI8MANxoCTEXwrxH+EYLP4mq/BIA==
X-Received: by 2002:a05:6e02:686:b0:318:aa8a:6453 with SMTP id o6-20020a056e02068600b00318aa8a6453mr3334106ils.7.1679232096852;
        Sun, 19 Mar 2023 06:21:36 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id a23-20020a027357000000b00406227162fesm2363460jae.32.2023.03.19.06.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 06:21:36 -0700 (PDT)
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
Subject: [PATCH 3/3] clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
Date:   Sun, 19 Mar 2023 08:21:20 -0500
Message-Id: <20230319132120.6347-4-aford173@gmail.com>
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
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3d94722bbf99..621b0e84ef27 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -417,6 +417,10 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	_imx8m_clk_hw_composite(name, parent_names, reg, \
 			0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT)
 
+#define imx8m_clk_hw_composite_flags(name, parent_names, reg, flags) \
+	_imx8m_clk_hw_composite(name, parent_names, reg, \
+			0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT |  flags)
+
 #define imx8m_clk_hw_composite_critical(name, parent_names, reg) \
 	_imx8m_clk_hw_composite(name, parent_names, reg, \
 			0, IMX_COMPOSITE_CLK_FLAGS_CRITICAL)
-- 
2.34.1

