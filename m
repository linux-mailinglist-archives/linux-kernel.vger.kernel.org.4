Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6767287BC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjFHTMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjFHTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:12:11 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27552D56
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:12:04 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 7L3Bqt4nXtjdE7L3Cqf3FS; Thu, 08 Jun 2023 21:12:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686251523;
        bh=hqcGyIGMqLhHLJ6KCJoyUKD++6o+2VySY5s7lD2Ospo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=adYpnyWIsE+lirv6ljQWvlWdzTp6I48lT1yTbJYGXniMO5ygVe0wz0PnqAlRXM/Cq
         2WqQ0HOxhI0ls4xsKOAasQ9k6NMHnQAiOI4oANs4ZuaX0prxGpcxU5IHZ+kCN+QLcX
         dBnmgq0UWPkHF14yyG/0UgsHV/a5KI+NKBchUZEc2nMf8eCM4UOTnyWiFBo12P/dKO
         FHXPIww/myOobUQoYv96RI3DWHadN+c0/PudBPpvbIWJ+lBeq7NNVpPhO4WIHIaF89
         mweY/oxObL4dc1prmtq4IwUSFc1jPIFecI+Sk0uNSr5qgT8zanhSQ5y1X+z9KR7qM3
         8+pwSBOSsYnTQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Jun 2023 21:12:03 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: [PATCH 2/2] rtc: st-lpc: Simplify clk handling in st_rtc_probe()
Date:   Thu,  8 Jun 2023 21:12:00 +0200
Message-Id: <992dd8c31be0bb5b8a9d8b5e8e94807ab0848a66.1686251455.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <866af6adbc7454a7b4505eb6c28fbdc86ccff39e.1686251455.git.christophe.jaillet@wanadoo.fr>
References: <866af6adbc7454a7b4505eb6c28fbdc86ccff39e.1686251455.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_enabled() instead of hand writing it. This simplifies
error handling and removes some lines of code.

Also use dev_err_probe() which filters -EPROBE_DEFER.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/rtc/rtc-st-lpc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index d04d46f9cc65..d492a2d26600 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -228,17 +228,13 @@ static int st_rtc_probe(struct platform_device *pdev)
 	enable_irq_wake(rtc->irq);
 	disable_irq(rtc->irq);
 
-	rtc->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(rtc->clk)) {
-		dev_err(&pdev->dev, "Unable to request clock\n");
-		return PTR_ERR(rtc->clk);
-	}
-
-	clk_prepare_enable(rtc->clk);
+	rtc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(rtc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
+				     "Unable to request clock\n");
 
 	rtc->clkrate = clk_get_rate(rtc->clk);
 	if (!rtc->clkrate) {
-		clk_disable_unprepare(rtc->clk);
 		dev_err(&pdev->dev, "Unable to fetch clock rate\n");
 		return -EINVAL;
 	}
@@ -252,10 +248,8 @@ static int st_rtc_probe(struct platform_device *pdev)
 	do_div(rtc->rtc_dev->range_max, rtc->clkrate);
 
 	ret = devm_rtc_register_device(rtc->rtc_dev);
-	if (ret) {
-		clk_disable_unprepare(rtc->clk);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
-- 
2.34.1

