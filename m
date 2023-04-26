Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A96EEE97
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbjDZGxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 02:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbjDZGxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:53:20 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B23230C1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 23:53:07 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rZ1RpwxQZMX1TrZ1Rpoi5U; Wed, 26 Apr 2023 08:53:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682491985;
        bh=KAtKMyZd7naxOW+Rdd07F5idduJev/3DNob3RYZOyX4=;
        h=From:To:Cc:Subject:Date;
        b=jtcYJmJzwcQembazxEh1mO1fWZlBgEiuhDv3/vLwH2iUAI4V/z95jF5L9LY4f9NZv
         si+K/7yFFq3Q40CA0IXnCQRaFpeWL0E9oZayGh/WBL8PnmOIk/HkBeeXiDRZNCUfK+
         7/tw9+Zg/0wISwhCG+qE2ANsbfBthzZBFAnOfbfUqPCW4k9TAGqS0lLye2TOg1c5YF
         KnaFAweV5CYgYxr9brt301VM67gBl5aJIzr7fwHvKizLctjMwJRrj4ivokDlbm6Vxc
         4HIYWw564uGM0GJnlMve910B3V9GiDm/8CbePGw7nLbAuxA1GtndlpvqT80urrAdD1
         L99XAbt5Z8CYw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 Apr 2023 08:53:05 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 1/2] watchdog: dw_wdt: Fix the error handling path of dw_wdt_drv_probe()
Date:   Wed, 26 Apr 2023 08:52:48 +0200
Message-Id: <fbb650650bbb33a8fa2fd028c23157bedeed50e1.1682491863.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes has only updated the remove function and missed the
error handling path of the probe.

Add the missing reset_control_assert() call.

Fixes: 65a3b6935d92 ("watchdog: dw_wdt: get reset lines from dt")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/watchdog/dw_wdt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 6f88bd81f8a1..a1354a59eb37 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -635,7 +635,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = dw_wdt_init_timeouts(dw_wdt, dev);
 	if (ret)
-		goto out_disable_clk;
+		goto out_assert_rst;
 
 	wdd = &dw_wdt->wdd;
 	wdd->ops = &dw_wdt_ops;
@@ -667,12 +667,15 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = watchdog_register_device(wdd);
 	if (ret)
-		goto out_disable_pclk;
+		goto out_assert_rst;
 
 	dw_wdt_dbgfs_init(dw_wdt);
 
 	return 0;
 
+out_assert_rst:
+	reset_control_assert(dw_wdt->rst);
+
 out_disable_pclk:
 	clk_disable_unprepare(dw_wdt->pclk);
 
-- 
2.34.1

