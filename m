Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3110629B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKON62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiKON6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:58:25 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088601039;
        Tue, 15 Nov 2022 05:58:22 -0800 (PST)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D57C11C0013;
        Tue, 15 Nov 2022 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668520701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lLraTOre/NKFIPvF9c2t40s43oz6eKUAFvet+eTCKV0=;
        b=lr2SL03AiQTqqxTediJvKHEmQwt+GeyJHNy8aCsGyzy8WxrU6buS/k0oCJTk2rP13t6w9I
        NzcRDCRhGA3D1geqLfPUtNs5vNvdHMGPrIPLofZwEKktUVaiYOcuixJgpCNW00hX568IMI
        FOUPPslC/JXj7+tAMFkouP7yZIATazPLnZKp3bOTP6V4on+JuTe3c8NgC/otB+CqqQfCi7
        ok9X4ZGlZTxa+3Lj8xhWZZvv+LJyP4T6dda+alXpv04C0nJ+IiHVFzXU8HSej8xpwHgDWE
        5EI2ybsEDuf9SR6M/Tiw9NskGp4+LiP4KPBXGe9etb15nngkHS0QqCwlL/b1XA==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        thomas.petazzoni@bootlin.com, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org
Subject: [PATCH v3 1/2] clk: spear: Fix CLCD clock definition on SPEAr600
Date:   Tue, 15 Nov 2022 14:58:12 +0100
Message-Id: <20221115135814.214388-2-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115135814.214388-1-kory.maincent@bootlin.com>
References: <20221115135814.214388-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

There is no SPEAr600 device named "clcd". Instead, the description of the
CLCD (color liquid crystal display controller) name is "fc200000.clcd", so
we should associate the CLCD gateable clock to this device name.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear6xx_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index c192a9141b86..ee0ed89f2954 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -207,7 +207,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_gate(NULL, "clcd_clk", "clcd_mclk", 0,
 			PERIP1_CLK_ENB, CLCD_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "clcd");
+	clk_register_clkdev(clk, NULL, "fc200000.clcd");
 
 	/* gpt clocks */
 	clk = clk_register_gpt("gpt0_1_syn_clk", "pll1_clk", 0, PRSC0_CLK_CFG,
-- 
2.25.1

