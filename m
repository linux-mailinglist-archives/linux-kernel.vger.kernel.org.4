Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8826E417D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjDQHma convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 03:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDQHmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:42:21 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E639240EF;
        Mon, 17 Apr 2023 00:41:44 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 38B5424E083;
        Mon, 17 Apr 2023 15:41:18 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Apr
 2023 15:41:18 +0800
Received: from ubuntu.localdomain (183.27.97.249) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Apr
 2023 15:41:17 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-clk@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <linux-mm@kvack.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Paul Gazzillo" <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] clk: starfive: Delete the redundant dev_set_drvdata() in JH7110 clock drivers
Date:   Mon, 17 Apr 2023 15:41:15 +0800
Message-ID: <20230417074115.30786-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417074115.30786-1-hal.feng@starfivetech.com>
References: <20230417074115.30786-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_set_drvdata() is no longer needed after we used a wrapper
struct to get the data in auxiliary driver.

Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Fixes: d1aae0663023 ("clk: starfive: Avoid casting iomem pointers")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-jh7110-aon.c | 2 --
 drivers/clk/starfive/clk-starfive-jh7110-sys.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-aon.c b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
index a2799fe8a234..62954eb7b50a 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-aon.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
@@ -83,8 +83,6 @@ static int jh7110_aoncrg_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	dev_set_drvdata(priv->dev, (void *)(&priv->base));
-
 	for (idx = 0; idx < JH7110_AONCLK_END; idx++) {
 		u32 max = jh7110_aonclk_data[idx].max;
 		struct clk_parent_data parents[4] = {};
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 851b93d0f371..e6031345ef05 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -402,8 +402,6 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	dev_set_drvdata(priv->dev, (void *)(&priv->base));
-
 	/*
 	 * These PLL clocks are not actually fixed factor clocks and can be
 	 * controlled by the syscon registers of JH7110. They will be dropped
-- 
2.38.1

