Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C61734EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFSI6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjFSI5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:57:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8CB1997;
        Mon, 19 Jun 2023 01:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A50386009F;
        Mon, 19 Jun 2023 08:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4B7C433BA;
        Mon, 19 Jun 2023 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687164987;
        bh=SXbRj7a8K92shQSYS+f3sTL1ucqnqo6+0RjDa+QJfv0=;
        h=From:Date:Subject:To:Cc:From;
        b=aN/OC1mU3PD4B3Jk2EKdPZBCeT4FdZXy6Yrs/p7jMGYap6hhGssOzrt+EPVELd4nm
         S9WJgOHt/QjWiSOXr7yXlcinJU3t0g+IUIhgCEcfofuxRW+/vI8R2lxTcj5d2/QBt9
         Qi2Bv54drtMYcNwhuE/uPb0z6CeUnVAlvmVHJkVcEYxNYCGHVrUS4UaTH2VR7jMWU9
         YUkQLbF9Uuzz4eZ3p0jR5elQtZJR1hLJ1EWt1/fLLvBdAEMYElvaP+zNor3f01/0wA
         mEP+YMwJxUcJ8aUAUMxHUNdsMGdJRFME88RKg6K4DiWTyM2kIHaRzghBIOLb3dZ+5p
         O2Zyf4FQKEIDw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 19 Jun 2023 10:56:07 +0200
Subject: [PATCH v2] gpiolib: Fix irq_domain resource tracking for
 gpiochip_irqchip_add_domain()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230616-fixes-gpiolib-irq-domain-v2-1-e28b47fc3e45@kernel.org>
X-B4-Tracking: v=1; b=H4sIACYYkGQC/42OTQ6CMBCFr0K6dkxbkyKuvIdh0dIBJkILU0I0h
 LtbOIHL7728n00kZMIkHsUmGFdKFEMGfSlE09vQIZDPLLTUN2mUgZY+mKCbKA7kgHgGH0dLAbQ
 zFTYWZeu9yHFnE4JjG5r+KBhtWpAPY2I8S7L6qjP3lJbI3/PCqg71j7VVgQJdtngvpXeVUc83c
 sDhGrkT9b7vP+F6AhTaAAAA
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiawen Wu <jiawenwu@trustnetic.com>,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
Changes in v2:
- change flag name to domain_is_externally_allocated
- Link to v1: https://lore.kernel.org/r/20230616-fixes-gpiolib-irq-domain-v1-1-27fe870db961@kernel.org
---
 drivers/gpio/gpiolib.c      | 3 ++-
 include/linux/gpio/driver.h | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7c6fefcbebd1..2664275c25f3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1740,7 +1740,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 	}
 
 	/* Remove all IRQ mappings and delete the domain */
-	if (gc->irq.domain) {
+	if (!gc->irq.domain_is_allocated_externally && gc->irq.domain) {
 		unsigned int irq;
 
 		for (offset = 0; offset < gc->ngpio; offset++) {
@@ -1786,6 +1786,7 @@ int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 
 	gc->to_irq = gpiochip_to_irq;
 	gc->irq.domain = domain;
+	gc->irq.domain_is_allocated_externally = true;
 
 	/*
 	 * Using barrier() here to prevent compiler from reordering
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 5c6db5533be6..67b8774eed8f 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -251,6 +251,14 @@ struct gpio_irq_chip {
 	 */
 	bool initialized;
 
+	/**
+	 * @domain_is_allocated_externally:
+	 *
+	 * True it the irq_domain was allocated outside of gpiolib, in which
+	 * case gpiolib won't free the irq_domain itself.
+	 */
+	bool domain_is_allocated_externally;
+
 	/**
 	 * @init_hw: optional routine to initialize hardware before
 	 * an IRQ chip will be added. This is quite useful when

---
base-commit: 659140df086c67f5eb77bbffcab34a7e8accd2a8
change-id: 20230616-fixes-gpiolib-irq-domain-2b69ecae0fdd

