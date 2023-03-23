Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FA16C73D0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjCWXBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCWXBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:01:35 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD8EEC4B;
        Thu, 23 Mar 2023 16:01:35 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i19so99092ila.10;
        Thu, 23 Mar 2023 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679612494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/Q6xa6hn+k+lfvS3cph2ZGvXNMdvP6vRrG80AxIr6U=;
        b=PvnomUgwJhFFGVd77ArauD7bqMvzE1OYSjS9WYvf8/bzz9nXv12fSe+z9+pR4ncTJA
         hiq2WqRoiJ3etczBYlNNUzckpD74VJbCWJZJXNEkBGaUjZcw4mbrYUr+SQ4c7uKseN4U
         H5T+m7AHTZmN00OUqUNnUgRziFRiNCJRzjfaEu7jRdWBttETEPtUsu3kJ6o5fOnPzxU1
         Tb8xPYcwP+3xhL9b4tfCDZGpbSh7GAWBKWI9oGwP8fU4WMaRgRgzbVaf243v/Y0EzCpc
         SOCCxzK23qu1blumomrhdEr9Wmfm8Qz3ez0lwfacVogdBZzB07fd4PjkJIDvbydRprmZ
         EG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679612494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/Q6xa6hn+k+lfvS3cph2ZGvXNMdvP6vRrG80AxIr6U=;
        b=I/lEOyU1MmM6aS1Ur2M5H11jZotakP9NeIgv3vl5gymjV6WF+hkQZ+HVyCNZfKBGIn
         YGEeUR61V1o3Q6//JUWPenK45hB74/EoR/lHUbTlnedARBLaDjHovsJyDD43h89nesBz
         AqZICk5FLHp9+4jp3ddM0cJumUyVFiv+U3uSLC5qq50cUEppf1R8IfJ7TMaYoox6SYWH
         yGfFILGf9apEi4bPQ6qyeqajviCs/me2ntx+U7R0APt4ZneZxxvpUhSA3QdsLELWd+85
         FIiwRaEB08M7nY1iEgdi/fqyTsqO3K+73zsJuzqbZWj1bIBgo2qwDQLRNTnhfMRqeTNQ
         Pzkw==
X-Gm-Message-State: AAQBX9eEhfTW0/eu39KHwIBXpwopIhBBwgYcF81wNiALRugT3SJu/iiX
        w9/Aam73nCuKNZhw0DxHy/D1fchAdtQ=
X-Google-Smtp-Source: AKy350Zu7vFYu8YnzXAXL+VgxNGS+TQ/V7MzyBfsmY5bmH5svzZC3FbmUUPldLCXwQJFji1aQJQLGw==
X-Received: by 2002:a92:4b0d:0:b0:323:ec3:49b7 with SMTP id m13-20020a924b0d000000b003230ec349b7mr908478ilg.11.1679612494427;
        Thu, 23 Mar 2023 16:01:34 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:f38d:f05d:4666:1249])
        by smtp.gmail.com with ESMTPSA id w20-20020a056e0213f400b00314201bcbdfsm5405492ilj.3.2023.03.23.16.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 16:01:34 -0700 (PDT)
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
Subject: [PATCH V4 3/4] clk: imx8mm: Let IMX8MM_CLK_LCDIF_PIXEL set parent rate
Date:   Thu, 23 Mar 2023 18:01:26 -0500
Message-Id: <20230323230127.120883-4-aford173@gmail.com>
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

