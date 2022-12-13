Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF5A64B69C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiLMNwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiLMNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:52:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCF1E87;
        Tue, 13 Dec 2022 05:52:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5675861482;
        Tue, 13 Dec 2022 13:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BD9C433D2;
        Tue, 13 Dec 2022 13:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670939531;
        bh=ozsOqii7yDA4mRglZq4iaweWnsQ4vb3m5tfjpKxpvJU=;
        h=From:To:Cc:Subject:Date:From;
        b=mlB9wnWVKHQQUsot8BirqD9Gl1ViMlEbbasljjhEbxqI+tEY7UDj6ekjhFuSDmwrb
         JoAJQtuS7J3HjFmDHCgkonCb+Rpb+KAW1vRqQGxmnV8QxOj0XJfCZl6BoXBnciRS4r
         i3+w78Dnr5wQ2MpB7fvW5BLhNCXf1rOkhOyQ4XvvfnBaRzIbGkE2+n28Bx3npA3gL1
         AdOBLwonx+hBf9G4X3oejOGzjmnVGbtCHbxrPmIkqyzjWANyIzdCM+DMXZyf9sWCaa
         3CIO7n+ef0TvH3UW5xBhYRjqD0xqSIIaPNBLWAsynoODPwORma/iHryTL1sEVTmSO6
         GE8pbLQy66a0w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p55i1-0003ks-Kz; Tue, 13 Dec 2022 14:52:37 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] gpiolib: use irq_domain_alloc_irqs()
Date:   Tue, 13 Dec 2022 14:52:27 +0100
Message-Id: <20221213135227.14398-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the irq_domain_alloc_irqs() wrapper instead of the full
__irq_domain_alloc_irqs() interface, which was only intended for some
legacy (x86) use cases.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/gpio/gpiolib.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5a66d9616d7c..ede9630b197c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1126,14 +1126,8 @@ static void gpiochip_set_hierarchical_irqchip(struct gpio_chip *gc,
 			/* Just pick something */
 			fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
 			fwspec.param_count = 2;
-			ret = __irq_domain_alloc_irqs(gc->irq.domain,
-						      /* just pick something */
-						      -1,
-						      1,
-						      NUMA_NO_NODE,
-						      &fwspec,
-						      false,
-						      NULL);
+			ret = irq_domain_alloc_irqs(gc->irq.domain, 1,
+						    NUMA_NO_NODE, &fwspec);
 			if (ret < 0) {
 				chip_err(gc,
 					 "can not allocate irq for GPIO line %d parent hwirq %d in hierarchy domain: %d\n",
-- 
2.37.4

