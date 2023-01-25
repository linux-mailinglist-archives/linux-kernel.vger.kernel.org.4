Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D1267ABC8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjAYIcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjAYIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:32:42 -0500
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Jan 2023 00:32:38 PST
Received: from forward100o.mail.yandex.net (forward100o.mail.yandex.net [37.140.190.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE491632B;
        Wed, 25 Jan 2023 00:32:38 -0800 (PST)
Received: from sas2-ffeb92823cb1.qloud-c.yandex.net (sas2-ffeb92823cb1.qloud-c.yandex.net [IPv6:2a02:6b8:c08:6803:0:640:ffeb:9282])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 6DF8D52ABE00;
        Wed, 25 Jan 2023 11:30:33 +0300 (MSK)
Received: by sas2-ffeb92823cb1.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id UUKCeP8ZA4Y1-yKFqrCCN;
        Wed, 25 Jan 2023 11:30:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1674635432;
        bh=Nz8cIXhLQKYa93vDg4gntVAYXm7H7DwzGbURAEZehlU=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=UWHBaFOZTq3hXwc0tLeo/xSevHCIOs9mduVrPSLe14feKTPGG8uWUY3Y97D6pT3yV
         V0wId8eFERmNTBhFLFsdE17jxCK9L5X3hCCELp98GVayBX6aNPwI8etpr+Pr9f9JkO
         IXIVymJ39fnt8hdydAoSvyqsx4O3QihvKKeULbcQ=
Authentication-Results: sas2-ffeb92823cb1.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     linux-gpio@vger.kernel.org
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] gpio: ep93xx: Fix port F hwirq numbers in handler
Date:   Wed, 25 Jan 2023 11:30:24 +0300
Message-Id: <20230125083026.5399-2-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230125083026.5399-1-nikita.shubin@maquefel.me>
References: <20230117100845.16708-1-nikita.shubin@maquefel.me>
 <20230125083026.5399-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix wrong translation of irq numbers in port F handler, as ep93xx hwirqs
increased by 1, we should simply decrease them by 1 in translation.

Fixes: 482c27273f52 ("ARM: ep93xx: renumber interrupts")
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/gpio/gpio-ep93xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 2e1779709113..7edcdc575080 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -148,7 +148,7 @@ static void ep93xx_gpio_f_irq_handler(struct irq_desc *desc)
 	 */
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 	unsigned int irq = irq_desc_get_irq(desc);
-	int port_f_idx = ((irq + 1) & 7) ^ 4; /* {19..22,47..50} -> {0..7} */
+	int port_f_idx = (irq & 7) ^ 4; /* {20..23,48..51} -> {0..7} */
 	int gpio_irq = EP93XX_GPIO_F_IRQ_BASE + port_f_idx;
 
 	chained_irq_enter(irqchip, desc);
-- 
2.37.4

