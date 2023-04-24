Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22A6EC998
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjDXJ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjDXJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:57:27 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDB3196;
        Mon, 24 Apr 2023 02:57:26 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 920515EBE4;
        Mon, 24 Apr 2023 12:36:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-Lb5xZorK;
        Mon, 24 Apr 2023 12:36:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328964;
        bh=X2ZnF8z0MJVwVfnTxaJeQDmtpEYIwg62QlS6BVN0m0c=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=S6TlKmzSb8mNgS6HtrmGROmKsWLrDtphmKY5TD7km/ETt/mRUm4XbxPgbMLqweMoQ
         YkJ4UglWWycr7ZEJZ0Hm/dm+WozxYlX4tlUpjgnaIram/ik3LWCZ+p5JqCzu0u2FPd
         7G/UZPfpZVKs+61TIneJoVh7MWDYEvcH5Vjd1aJU=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 31/43] wdt: ts72xx: add DT support for ts72xx
Date:   Mon, 24 Apr 2023 15:34:47 +0300
Message-Id: <20230424123522.18302-32-nikita.shubin@maquefel.me>
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

- get regs from device tree

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    Arnd Bergmann:
    - wildcards ep93xx to something meaningful, i.e. ep9301
    - drop wrappers

 drivers/watchdog/ts72xx_wdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index bf918f5fa131..72bbb4db983e 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -13,6 +13,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/watchdog.h>
@@ -162,10 +163,17 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ts72xx_wdt_of_ids[] = {
+	{ .compatible = "technologic,ts7200-wdt" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ts72xx_wdt_of_ids);
+
 static struct platform_driver ts72xx_wdt_driver = {
 	.probe		= ts72xx_wdt_probe,
 	.driver		= {
 		.name	= "ts72xx-wdt",
+		.of_match_table = ts72xx_wdt_of_ids,
 	},
 };
 
-- 
2.39.2

