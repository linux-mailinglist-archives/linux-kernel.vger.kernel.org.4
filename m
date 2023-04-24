Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735DA6ECA15
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjDXKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjDXKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:40 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277981BE6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:20:38 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 3F6505EEE7;
        Mon, 24 Apr 2023 12:36:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-uIzrV9z0;
        Mon, 24 Apr 2023 12:36:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328970;
        bh=ILW7HQf2U6XIRRdddf7sXhZXt2NIlcnnFnvadaw+a9k=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=j5UN+nR4GxEPvjO303ZhccRQk/FFjdl6xNS8wrHhKOIAVHUoBwMU6Gx7cYyymH9yq
         hJqGkbWtQthzZTOLoCE75g/B4AUQtHYHOGc2luGeBAkiA/wps5ntf+0E7BNwgrmBRG
         uNmRACHMKjVHOO0DJo3RxdCYjDOByFIfLZp0PMG0=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lv Ruyi <lv.ruyi@zte.com.cn>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 37/43] input: keypad: ep93xx: drop legacy pinctrl
Date:   Mon, 24 Apr 2023 15:34:53 +0300
Message-Id: <20230424123522.18302-38-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop legacy acquire/release since we are using
pinctrl for this now.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/input/keyboard/ep93xx_keypad.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index bf77754fa4c7..a5f5d7d453e7 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -222,13 +222,6 @@ static int ep93xx_keypad_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ep93xx_keypad_pm_ops,
 				ep93xx_keypad_suspend, ep93xx_keypad_resume);
 
-static void ep93xx_keypad_release_gpio_action(void *_pdev)
-{
-	struct platform_device *pdev = _pdev;
-
-	ep93xx_keypad_release_gpio(pdev);
-}
-
 static int ep93xx_keypad_probe(struct platform_device *pdev)
 {
 	struct ep93xx_keypad *keypad;
@@ -256,15 +249,6 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	if (IS_ERR(keypad->mmio_base))
 		return PTR_ERR(keypad->mmio_base);
 
-	err = ep93xx_keypad_acquire_gpio(pdev);
-	if (err)
-		return err;
-
-	err = devm_add_action_or_reset(&pdev->dev,
-				       ep93xx_keypad_release_gpio_action, pdev);
-	if (err)
-		return err;
-
 	keypad->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk))
 		return PTR_ERR(keypad->clk);
-- 
2.39.2

