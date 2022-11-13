Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05B9627177
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiKMSHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiKMSH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:07:26 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA612A98
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:07:25 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so23406828ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY/YbaT2oocFTRi9rozmezD/+VGVGVIO+2TePf2+ldU=;
        b=esSz1VqzMydOCCFAmDZxkV0kwBvkxmYqkNmOgqtT9gI1r4dR8rfXmP6enOyg4A/JY2
         vCpeDHv8mYQuBNGa8I65cL078SO/A85DJ/bAOgckxPuCrXKjRiCwYTvQoK5LmgA8RZDE
         ksqr8tP6iWhZZKy/u4tm0KIKLLbhSftEiVYHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY/YbaT2oocFTRi9rozmezD/+VGVGVIO+2TePf2+ldU=;
        b=pOqIeVUhT58PEJ6oqBsDKiQ5rZyTv+tLYV/CBd+TKL2XHOwpZqBSWjGwMmwoMGRqoq
         jC0QuuI6f8r86cQO3hWpp+4L/AC/ol/DSsyjDODhHoDIg0lqyvJczB8KyilYjZ2EuizI
         X3SHz9DKo43HdJ72bP4FORhkxZ426i1MdwlwVGzfeVIgPwy78R05QksxImrGNhOiCE6n
         hSqZ9eiLupBnUgQy0+hJoN1f01zGZuvD56oxQTMe3YhS46FVzdISqL2e8U6qw1o130t5
         0rEzJIwZQvd45J3KwHzetofJBFiexwy3DbsZc+k2Fx0k4TySypok/pryJD9PelORnmUa
         p95Q==
X-Gm-Message-State: ANoB5pkSQNI+PuqRJhITLqiuc7Hc/BlI3tEKAJ3SkTabpe4Kqc3uT8Ob
        yDfohipd/U0k9QF0LoiXgDndTSsqLIzwvw==
X-Google-Smtp-Source: AA0mqf7Bql1t8/TVOsxUzpgGr0R8sIbEv22SFH08QOqWO+33J71bOOMHJuA9UzrWPzMGXae6h7zqIA==
X-Received: by 2002:a17:906:9f09:b0:7ae:ea7:2139 with SMTP id fy9-20020a1709069f0900b007ae0ea72139mr8127573ejc.319.1668362844166;
        Sun, 13 Nov 2022 10:07:24 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-103-33.business.telecomitalia.it. [79.40.103.33])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906118b00b007a8de84ce36sm3171058eja.206.2022.11.13.10.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 10:07:23 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 5/5] clk: imx8mn: fix imx8mn_enet_phy_sels clocks list
Date:   Sun, 13 Nov 2022 19:07:10 +0100
Message-Id: <20221113180710.1625410-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221113180710.1625410-1-dario.binacchi@amarulasolutions.com>
References: <20221113180710.1625410-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the "Clock Root" table of the reference manual (document
IMX8MNRM Rev 2, 07/2022):

     Clock Root         offset     Source Select (CCM_TARGET_ROOTn[MUX])
        ...              ...                    ...
 ENET_PHY_REF_CLK_ROOT  0xAA80            000 - 24M_REF_CLK
                                          001 - SYSTEM_PLL2_DIV20
                                          010 - SYSTEM_PLL2_DIV8
                                          011 - SYSTEM_PLL2_DIV5
                                          100 - SYSTEM_PLL2_DIV2
                                          101 - AUDIO_PLL1_CLK
                                          110 - VIDEO_PLL_CLK
                                          111 - AUDIO_PLL2_CLK
        ...              ...                    ...

while the imx8mn_enet_phy_sels list didn't contained audio_pll1_out for
source select bits 101b.

Fixes: 96d6392b54dbb ("clk: imx: Add support for i.MX8MN clock driver")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/clk/imx/clk-imx8mn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 37128c35198d..2afea905f7f3 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -140,8 +140,8 @@ static const char * const imx8mn_enet_timer_sels[] = {"osc_24m", "sys_pll2_100m"
 						      "clk_ext4", "video_pll_out", };
 
 static const char * const imx8mn_enet_phy_sels[] = {"osc_24m", "sys_pll2_50m", "sys_pll2_125m",
-						    "sys_pll2_200m", "sys_pll2_500m", "video_pll_out",
-						    "audio_pll2_out", };
+						    "sys_pll2_200m", "sys_pll2_500m", "audio_pll1_out",
+						    "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mn_nand_sels[] = {"osc_24m", "sys_pll2_500m", "audio_pll1_out",
 						"sys_pll1_400m", "audio_pll2_out", "sys_pll3_out",
-- 
2.32.0

