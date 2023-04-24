Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71E96ECA44
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjDXKWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjDXKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:21:54 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91B540DC;
        Mon, 24 Apr 2023 03:20:54 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id C6FE65EC79;
        Mon, 24 Apr 2023 12:36:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-0eocMuTW;
        Mon, 24 Apr 2023 12:36:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328961;
        bh=lZRbxaS0xiq44T/zESI4eXsgKm1tQjdSQS2qMC8kcOI=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=VdZETi2KvvQVolaU2tPAozmUDXDxbWuIqXQuqwLYYAVRFgPXhBOcgRFd8tqDq9W6E
         38AA8AadndV18s2PlZ9Q1ZT0aMqB0D1a7uu9SoAg4ra7qe0fC05mzGKp0hTXP3aKUr
         186NKY8klPejc8zFQ71UM9OHh33ulANePgB6ArZM=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lv Ruyi <lv.ruyi@zte.com.cn>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/43] input: keypad: ep93xx: add DT support for Cirrus EP93xx
Date:   Mon, 24 Apr 2023 15:34:43 +0300
Message-Id: <20230424123522.18302-28-nikita.shubin@maquefel.me>
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

- get keymap from the device tree
- find register range from the device tree
- get interrupts from device tree

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    Arnd Bergmann:
    - wildcards ep93xx to something meaningful, i.e. ep9301
    - drop wrappers

 drivers/input/keyboard/ep93xx_keypad.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 55075addcac2..bf77754fa4c7 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -20,6 +20,8 @@
 #include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -315,10 +317,17 @@ static int ep93xx_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_keypad_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-keypad" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ep93xx_keypad_of_ids);
+
 static struct platform_driver ep93xx_keypad_driver = {
 	.driver		= {
 		.name	= "ep93xx-keypad",
 		.pm	= pm_sleep_ptr(&ep93xx_keypad_pm_ops),
+		.of_match_table = ep93xx_keypad_of_ids,
 	},
 	.probe		= ep93xx_keypad_probe,
 	.remove		= ep93xx_keypad_remove,
-- 
2.39.2

