Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9162D64930B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 08:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLKHIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 02:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiLKHIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 02:08:43 -0500
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8576D11816
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 23:08:42 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 4GRzpHRqabLgJ4GRzp7eVK; Sun, 11 Dec 2022 08:08:40 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Dec 2022 08:08:40 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] bus: ts-nbus: Fix the error handling path of ts_nbus_probe()
Date:   Sun, 11 Dec 2022 08:08:38 +0100
Message-Id: <6e14d11b9725494b55df9939bde3fc5b8eaef6e4.1670742502.git.christophe.jaillet@wanadoo.fr>
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

If an error occurs after a successful pwm_enable() call, it must be undone
by a corresponding pwm_disable(), as already done in the remove function.

Fixes: 5b143d2a6ede ("bus: add driver for the Technologic Systems NBUS")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure if we need the mutex_lock()/mutex_unlock() that is in the remove
function.
---
 drivers/bus/ts-nbus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 38c886dc2ed6..ed568061ba6b 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -324,11 +324,16 @@ static int ts_nbus_probe(struct platform_device *pdev)
 
 	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 	if (ret < 0)
-		return ret;
+		goto err_disable_pwm;
 
 	dev_info(dev, "initialized\n");
 
 	return 0;
+
+err_disable_pwm:
+	pwm_disable(pwm);
+	return ret;
+
 }
 
 static int ts_nbus_remove(struct platform_device *pdev)
-- 
2.34.1

