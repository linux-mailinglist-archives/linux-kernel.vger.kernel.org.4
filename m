Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F241A5B4693
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIJOQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIJOQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:16:09 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FD451414
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 07:16:03 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id X1H3opcNk9RnzX1H3odu7c; Sat, 10 Sep 2022 16:16:01 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Sep 2022 16:16:01 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] PM / devfreq: rockchip-dfi: Fix an error message
Date:   Sat, 10 Sep 2022 16:15:56 +0200
Message-Id: <47627a29a443aedf3b36a4f72b3e1ad89933a0ea.1662819332.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in the message. The clock name should be 'pclk_ddr_mon'.
Fix it.

While at it, switch to dev_err_probe() which is less verbose, filters
-EPROBE_DEFER, and log the error code in a human readable way.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This looks like a cut'n'paste typo from drivers/devfreq/rk3399_dmc.c
---
 drivers/devfreq/event/rockchip-dfi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 9a88faaf8b27..39ac069cabc7 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -189,10 +189,9 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 		return PTR_ERR(data->regs);
 
 	data->clk = devm_clk_get(dev, "pclk_ddr_mon");
-	if (IS_ERR(data->clk)) {
-		dev_err(dev, "Cannot get the clk dmc_clk\n");
-		return PTR_ERR(data->clk);
-	}
+	if (IS_ERR(data->clk))
+		return dev_err_probe(dev, PTR_ERR(data->clk),
+				     "Cannot get the clk pclk_ddr_mon\n");
 
 	/* try to find the optional reference to the pmu syscon */
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
-- 
2.34.1

