Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D116C735E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjCWWwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjCWWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:51:53 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A139193F7;
        Thu, 23 Mar 2023 15:51:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id bl9so83924iob.8;
        Thu, 23 Mar 2023 15:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679611906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/Q6xa6hn+k+lfvS3cph2ZGvXNMdvP6vRrG80AxIr6U=;
        b=FCXfX5PvSoceV10qCbE1jx70Fi05EPoQtylGGlRD+AloQC6EVlHOTiGTdSEONPOpw7
         aiRf4HMl0D/f9MB124+hHwAcH/d/G5Xtx7VWD6z3vMVVMtmrjzrwSpZYs9b2nS2ZAHGe
         9I7UESwPl6BFsS3cFYmUeBPRI4JNBxYpqIHjFz5Nc3V0WXdIghKIwSRiV1OtK3hJExrT
         869q9MxHbVGbqnNVYUXRO/UM0hxuWxWlqqsdWQg0+kjk0hqPJCurrxNWznWKkco0uZs4
         cXtPAU3VO5xtWPYhNsib3+mOJIw3MmC4zGnjtfs+6BtGa4hxq1GQ5ZTRYeQ2sAVjABb3
         B1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/Q6xa6hn+k+lfvS3cph2ZGvXNMdvP6vRrG80AxIr6U=;
        b=oH/fSMKI55r9XIpEgtzr3lGzqE9KhFL0+yBSFnZOQlHv41c/0feX8RQsYQZg9BA9bR
         jNmQHIM671d4GndRym+/435X+xhSxo8wGrlB5W7GH4+yj1Z2qnnYJJbwR87UcipAZorB
         NST+NKzRUh2xdiNEsR9psnOYIc9L4L5GLKKQwqGlj8kutcn2iY1SerlNpjcGC4Gdc73/
         t2BOcBmPYLFqXOh7AaFsm8Hj/lakwVzq32/1kBvnogqmo77Ct9KD1Kqh19b0ggJYKgyh
         tNHJcr0pNcPmLI3EejnL83VDmehBMBdDfOwKMoXfGNYrVvRXRB6NUqdCQzWduW9tOeK6
         Zw+Q==
X-Gm-Message-State: AO0yUKVQ3uXN+Jj33h3gOrZTPOYDKl6C6q7llLSvWiVsSu3vZ8d4Yw+y
        4rKQMGP+poFtLnfmCkTUTYN+5SuaAu0=
X-Google-Smtp-Source: AK7set+HXZbnRpJ4vJgFWLXBvQvp+3+IFKwxKAE1HpNe0KTAVrXLlCOxrjlgJHjQGXFztvrFFhy/sg==
X-Received: by 2002:a5d:8b9a:0:b0:758:6d1e:2978 with SMTP id p26-20020a5d8b9a000000b007586d1e2978mr553873iol.10.1679611905938;
        Thu, 23 Mar 2023 15:51:45 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:f38d:f05d:4666:1249])
        by smtp.gmail.com with ESMTPSA id f102-20020a0284ef000000b0040631e8bf89sm6266988jai.38.2023.03.23.15.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:51:45 -0700 (PDT)
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
Subject: [PATCH V3 3/4] clk: imx8mm: Let IMX8MM_CLK_LCDIF_PIXEL set parent rate
Date:   Thu, 23 Mar 2023 17:51:27 -0500
Message-Id: <20230323225128.117061-4-aford173@gmail.com>
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
Reviewed-by: Fabio Estevam <festevam@gmail.com>

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

