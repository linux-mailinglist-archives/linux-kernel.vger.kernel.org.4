Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2157333FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjFPOux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345755AbjFPOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A13330FB;
        Fri, 16 Jun 2023 07:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E3763E14;
        Fri, 16 Jun 2023 14:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761F6C433C8;
        Fri, 16 Jun 2023 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686927041;
        bh=iuzlJEXzgeFTJGc5anLsg53cYdFe9bM3LmN+rmOZxp0=;
        h=From:To:Cc:Subject:Date:From;
        b=cbYt5RWImunf6NH1W7o6L6MOYTWCXbHE/y+qRRmQKVcaPhRW2HX5icfdniiamszNn
         VMaXGYtz8Q/kfO0k3bxBEuLoQyFreRK03b4zybq7hib5/jhb3VtQ6nD1DGojhstaFN
         m67cJvqgqZnColKg3JhSiJRjaBo7ImapUF2D6RDJDkUSpZK3+IQfAK8DFCG1YgseoJ
         bjHap2/fnSC2IJOjoBFqyaPjQ0rNuE4YeSmgcQ89ePVYXTk8ct+1xuXDy6ehrFvoJT
         SDZ6iEOs6F8MGlBrpaOXWGLH68VGKzUsRIJVHygovxkm4qUECH/OchC4gzagqAEoaf
         T8tWnZWrz09/A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michal Simek <michal.simek@amd.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: synq: remove unused zynq_gpio_irq_reqres/zynq_gpio_irq_relres
Date:   Fri, 16 Jun 2023 16:50:33 +0200
Message-Id: <20230616145036.3910153-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The driver now uses the generic request/release callbacks, so the custom
ones are no longer called. When building with -Woverride-init, gcc produces
a warning about the duplicate entries:

In file included from drivers/gpio/gpio-zynq.c:10:
include/linux/gpio/driver.h:621:43: error: initialized field overwritten [-Werror=override-init]
  621 |                 .irq_request_resources  = gpiochip_irq_reqres,          \
      |                                           ^~~~~~~~~~~~~~~~~~~
drivers/gpio/gpio-zynq.c:611:9: note: in expansion of macro 'GPIOCHIP_IRQ_RESOURCE_HELPERS'
  611 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/gpio/driver.h:621:43: note: (near initialization for 'zynq_gpio_level_irqchip.irq_request_resources')
  621 |                 .irq_request_resources  = gpiochip_irq_reqres,          \
      |                                           ^~~~~~~~~~~~~~~~~~~
drivers/gpio/gpio-zynq.c:625:9: note: in expansion of macro 'GPIOCHIP_IRQ_RESOURCE_HELPERS'
  625 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/gpio/driver.h:622:43: error: initialized field overwritten [-Werror=override-init]
  622 |                 .irq_release_resources  = gpiochip_irq_relres
      |                                           ^~~~~~~~~~~~~~~~~~~

Removing the old ones has no effect on the driver but avoids the warnings.

Fixes: f569143935378 ("gpio: zynq: fix zynqmp_gpio not an immutable chip warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-zynq.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index c334e46033bae..0a7264aabe488 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -575,26 +575,6 @@ static int zynq_gpio_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
-static int zynq_gpio_irq_reqres(struct irq_data *d)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
-	int ret;
-
-	ret = pm_runtime_resume_and_get(chip->parent);
-	if (ret < 0)
-		return ret;
-
-	return gpiochip_reqres_irq(chip, d->hwirq);
-}
-
-static void zynq_gpio_irq_relres(struct irq_data *d)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
-
-	gpiochip_relres_irq(chip, d->hwirq);
-	pm_runtime_put(chip->parent);
-}
-
 /* irq chip descriptor */
 static const struct irq_chip zynq_gpio_level_irqchip = {
 	.name		= DRIVER_NAME,
@@ -604,8 +584,6 @@ static const struct irq_chip zynq_gpio_level_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
-	.irq_request_resources = zynq_gpio_irq_reqres,
-	.irq_release_resources = zynq_gpio_irq_relres,
 	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
 			  IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
@@ -619,8 +597,6 @@ static const struct irq_chip zynq_gpio_edge_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
-	.irq_request_resources = zynq_gpio_irq_reqres,
-	.irq_release_resources = zynq_gpio_irq_relres,
 	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
-- 
2.39.2

