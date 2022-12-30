Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC38659AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiL3RAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiL3RAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:00:01 -0500
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2765A1902A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:00:00 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BIjepxxYHqMfRBIjepeWsm; Fri, 30 Dec 2022 17:59:59 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Dec 2022 17:59:59 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: sccnxp: Use devm_clk_get_enabled() helper
Date:   Fri, 30 Dec 2022 17:59:56 +0100
Message-Id: <735a807c2df835aa436dcbc76b374f983f89a9af.1672419577.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code.
This also avoids some other warnings/issues. (see [1])

[1]: https://lore.kernel.org/all/20221118233101.never.215-kees@kernel.org/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/sccnxp.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 7df687822634..4f2fc5f7bb19 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -913,23 +913,13 @@ static int sccnxp_probe(struct platform_device *pdev)
 	} else if (PTR_ERR(s->regulator) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		if (ret == -EPROBE_DEFER)
 			goto err_out;
 		uartclk = 0;
 	} else {
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			goto err_out;
-
-		ret = devm_add_action_or_reset(&pdev->dev,
-				(void(*)(void *))clk_disable_unprepare,
-				clk);
-		if (ret)
-			goto err_out;
-
 		uartclk = clk_get_rate(clk);
 	}
 
-- 
2.34.1

