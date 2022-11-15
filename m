Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622A3629B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiKON6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiKON61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:58:27 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E839399;
        Tue, 15 Nov 2022 05:58:24 -0800 (PST)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A2AD1C0014;
        Tue, 15 Nov 2022 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668520703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2xVfnlmooK7Qg1BmLHoWVwjVfzC1dVIJEO1AD5E1VU=;
        b=FNKVsKjgQzR8g1b6dlfOcwb0WiId/4yqMgDzJut3rJM4x6yG2FgJMm6ID4pfDnE3a7j+f8
        Rrfb5yvkFPSuUm6yGwS6JrYvI/y9Om4Wq16mEqJYuH+UoOR9t3Kh9k4ptNRzgM7g1NUJr3
        FSaFdyPUt5WinN2eOoRaym8fOUUtsPpGheeXTtQqIkDDHqQF5EOxwSFDy4dsvLD+vxpXEc
        sY+E3yi+J5GZO5eBCufzgnjSmpNoYxZfddQZBvIIUkI8lhty5r6yKHXj73DfIZ/mNwB8oG
        3yUBaR63Unc7skLNPFI5ky+CONAXqo16GOSJf1k7fdFZTKBOY0MOGgW6qu2jsQ==
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
Subject: [PATCH v3 2/2] clk: spear: Fix SSP clock definition on SPEAr600
Date:   Tue, 15 Nov 2022 14:58:13 +0100
Message-Id: <20221115135814.214388-3-kory.maincent@bootlin.com>
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

There is no SPEAr600 device named "ssp-pl022.x". Instead, the description
of the SSP (Synchronous Serial Port) was recently added to the Device Tree,
and the device name is "xxx.spi", so we should associate the SSP gateable
clock to these device names.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear6xx_clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index ee0ed89f2954..adfa118520c3 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -326,13 +326,13 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_gate(NULL, "ssp0_clk", "apb_clk", 0, PERIP1_CLK_ENB,
 			SSP0_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "ssp-pl022.0");
+	clk_register_clkdev(clk, NULL, "d0100000.spi");
 
 	clk = clk_register_gate(NULL, "ssp1_clk", "apb_clk", 0, PERIP1_CLK_ENB,
 			SSP1_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "ssp-pl022.1");
+	clk_register_clkdev(clk, NULL, "d0180000.spi");
 
 	clk = clk_register_gate(NULL, "ssp2_clk", "apb_clk", 0, PERIP1_CLK_ENB,
 			SSP2_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "ssp-pl022.2");
+	clk_register_clkdev(clk, NULL, "d8180000.spi");
 }
-- 
2.25.1

