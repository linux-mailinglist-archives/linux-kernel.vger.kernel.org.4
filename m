Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9890470E017
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbjEWPNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbjEWPN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:13:29 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466AEE7C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:13:09 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:b0ac:7afd:272:4cff])
        by albert.telenet-ops.be with bizsmtp
        id 0FD72A0010Jkz7G06FD7NG; Tue, 23 May 2023 17:13:07 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1Tgy-002swX-Dr;
        Tue, 23 May 2023 17:13:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1ThC-00CkPC-Rr;
        Tue, 23 May 2023 17:13:06 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] Input: gpio-keys - convert to dev_err_probe()
Date:   Tue, 23 May 2023 17:13:05 +0200
Message-Id: <9fc16eea6fd2c687b69e007e792e8c6338f80e48.1684854670.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the dev_err_probe() helper, instead of open-coding the same
operation.

While at it, invert the error checking logic to simplify code flow.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/input/keyboard/gpio_keys.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 93b75d78a9cb882f..5e18ef01b0340f1b 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -523,18 +523,15 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 						     NULL, GPIOD_IN, desc);
 		if (IS_ERR(bdata->gpiod)) {
 			error = PTR_ERR(bdata->gpiod);
-			if (error == -ENOENT) {
-				/*
-				 * GPIO is optional, we may be dealing with
-				 * purely interrupt-driven setup.
-				 */
-				bdata->gpiod = NULL;
-			} else {
-				if (error != -EPROBE_DEFER)
-					dev_err(dev, "failed to get gpio: %d\n",
-						error);
-				return error;
-			}
+			if (error != -ENOENT)
+				return dev_err_probe(dev, error,
+						     "failed to get gpio\n");
+
+			/*
+			 * GPIO is optional, we may be dealing with
+			 * purely interrupt-driven setup.
+			 */
+			bdata->gpiod = NULL;
 		}
 	} else if (gpio_is_valid(button->gpio)) {
 		/*
-- 
2.34.1

