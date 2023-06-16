Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2A27328F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245111AbjFPHbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbjFPHar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33DC30F5;
        Fri, 16 Jun 2023 00:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D97A062D2F;
        Fri, 16 Jun 2023 07:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9264C433C0;
        Fri, 16 Jun 2023 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686900632;
        bh=f+LgoALENSeGbpRznsBkL8AxsTrl0/0l4wQlFDbC4tk=;
        h=From:Date:Subject:To:Cc:From;
        b=bg20uc3VVcGfkNHiSyAKcdlbAiPmikUy10j3PxceC9t7yRWsfmydaak5wD2PjpD9f
         kSP/LnDonrV0txvbiUKjwi/yPQy6ovogAqxh1ulpZk+qpGd74pgff1GYmP9tLYPbGh
         mxdQz5oSqVOj04b1JN5ujFlEwZSVKSB0a3vJ/kkQSQfUKQPVXwY65LUOfU0K7Af9uY
         Y4r+XR07rlRyCD2oMdsXGO14YcZMhDvYXreRoukRfHHvQn/v/IYxqwlScRnA+e4uCU
         wjsc1d3hcKzJpEigOnr6XdWZcRCAahMHYN92qXjfAqO7KWTbGeLfld3MMAQ+xYzdu7
         +MOIwTRVHFA3A==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 16 Jun 2023 09:30:06 +0200
Subject: [PATCH] gpiolib: Fix irq_domain resource tracking for
 gpiochip_irqchip_add_domain()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230616-fixes-gpiolib-irq-domain-v1-1-27fe870db961@kernel.org>
X-B4-Tracking: v=1; b=H4sIAH0PjGQC/x2M0QqDMAxFf0XyvEDtoOB+ZewhbaMGtHXJkIH47
 6t7PPdyzgHGKmzw6A5Q3sWklgb9rYM0U5kYJTcG7/zdhT7gKF82nDapi0QUfWOuK0lBH8PAidi
 NOUPTIxljVCppvgIr2Yf1Ojblf6Stz9d5/gCKCoi4gwAAAA==
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiawen Wu <jiawenwu@trustnetic.com>,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until commit 6a45b0e2589f ("gpiolib: Introduce
gpiochip_irqchip_add_domain()") all irq_domains were allocated
by gpiolib itself and thus gpiolib also takes care of freeing it.

With gpiochip_irqchip_add_domain() a user of gpiolib can associate an
irq_domain with the gpio_chip. This irq_domain is not managed by
gpiolib and therefore must not be freed by gpiolib.

Fixes: 6a45b0e2589f ("gpiolib: Introduce gpiochip_irqchip_add_domain()")
Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpio/gpiolib.c      | 3 ++-
 include/linux/gpio/driver.h | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7c6fefcbebd1..b0e3a3de2bf2 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1740,7 +1740,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 	}
 
 	/* Remove all IRQ mappings and delete the domain */
-	if (gc->irq.domain) {
+	if (!gc->irq.domain_is_ext && gc->irq.domain) {
 		unsigned int irq;
 
 		for (offset = 0; offset < gc->ngpio; offset++) {
@@ -1786,6 +1786,7 @@ int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 
 	gc->to_irq = gpiochip_to_irq;
 	gc->irq.domain = domain;
+	gc->irq.domain_is_ext = true;
 
 	/*
 	 * Using barrier() here to prevent compiler from reordering
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 5c6db5533be6..3dbfed83823b 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -251,6 +251,14 @@ struct gpio_irq_chip {
 	 */
 	bool initialized;
 
+	/**
+	 * @domain_is_ext:
+	 *
+	 * True it the irq_domain was allocated outside of gpiolib, in which
+	 * case gpiolib won't free the irq_domain itself.
+	 */
+	bool domain_is_ext;
+
 	/**
 	 * @init_hw: optional routine to initialize hardware before
 	 * an IRQ chip will be added. This is quite useful when

---
base-commit: 659140df086c67f5eb77bbffcab34a7e8accd2a8
change-id: 20230616-fixes-gpiolib-irq-domain-2b69ecae0fdd

