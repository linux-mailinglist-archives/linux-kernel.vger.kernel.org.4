Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3BF6A0A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjBWNdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBWNc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:32:59 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E2ECA29
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:32:57 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id t11so2822024lfr.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXSfRBLuMqFua2MZpV9G4Cg4Ju4L9Za2DVr8M7QmRxU=;
        b=EauZMVoGlbIfZ9gek64NWvJXSZlJNS4Ni7B1SzeT4bSexNDB79YluikQY1jDnya1Hb
         L5ix6ZTLOjxK55m0roFsvXBBdqZRwryi86JX7p+YJQkvuOywE0UiefJCN13fQyK35JwK
         SP0Ewpk4wh107UdESFvUvf+aSDa6ai5bIVAGU575pjPDsQ3jnMJ/4WcMc1VypNO8nEsS
         SjqdLDvSOdhm60kJU97+fS0zl9YAa3YW+neShTDUBMX9bUdHjAzBvOyqp4i4lmTP3fYq
         2sY/E41yX4G56/ZoTeGUARPv6QdkByNVqcM3utAdyvZA3XjGdKplmEU5NBfh9l0yVxc4
         rJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXSfRBLuMqFua2MZpV9G4Cg4Ju4L9Za2DVr8M7QmRxU=;
        b=SpYOM0Fmuj18NMu5q0htRpq0c6M2daLhNgH1JMciw7SZooY+8hwS33w9nb26lCvT/C
         Pe4ndW5nhbtx+UDogg5ZmFBJMC8SdUnc9NsCbfpm89rNtWU+HyfRaoZshLNyEFYGCeUr
         sht5C+q218EPpVGixA7REBn5oBj/wre8SbVnsWDc5yvACQwpZ1Fxgjm8p4UnAvcTpB/I
         9n3wiZd2lpDcJFljD7xPrMLwPIS4imywgJArSXpjba8D6qYSdEGhvFoGkA2IPKbHLhoE
         K+zQZ05Hi9uR3RffI7d1JHo/v13lWlI2K0+VXmu8JjChrIKU8cVrXyLuwQpLhNqG2stm
         VZkQ==
X-Gm-Message-State: AO0yUKU2KldBGyTFMK18d7krSjXxnHXJ15P274YMXMyGRTIBCF7/ixq1
        Lgt1eF65mIyId5RKnIqNPpagY5gR/46hYpimwmY=
X-Google-Smtp-Source: AK7set8hx54qO9AF9kFGbn8rERbVyJmLHHWmAj3gIrsaR1aZTHYta7tKlaZm5HP7onXeHLZk9JfXqA==
X-Received: by 2002:a19:f60f:0:b0:4b5:2ef3:fd2a with SMTP id x15-20020a19f60f000000b004b52ef3fd2amr4944777lfe.47.1677159175881;
        Thu, 23 Feb 2023 05:32:55 -0800 (PST)
Received: from fedora.. ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id y14-20020ac24e6e000000b004dc48d91061sm772238lfs.304.2023.02.23.05.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:32:55 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: [PATCH] misc: microchip: pci1xxxx: Convert to immutable irqchip
Date:   Thu, 23 Feb 2023 14:32:52 +0100
Message-Id: <20230223133252.2257276-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

Cc: linux-gpio@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Maybe this would have been caught in review if the GPIO maintainers
were involved, but the process isn't perfect. Better to just fix
it.
---
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
index 3389803cb281..e616e3ec2b42 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
@@ -175,9 +175,13 @@ static void pci1xxxx_gpio_irq_set_mask(struct irq_data *data, bool set)
 	unsigned int gpio = irqd_to_hwirq(data);
 	unsigned long flags;
 
+	if (!set)
+		gpiochip_enable_irq(chip, gpio);
 	spin_lock_irqsave(&priv->lock, flags);
 	pci1xxx_assign_bit(priv->reg_base, INTR_MASK_OFFSET(gpio), (gpio % 32), set);
 	spin_unlock_irqrestore(&priv->lock, flags);
+	if (set)
+		gpiochip_disable_irq(chip, gpio);
 }
 
 static void pci1xxxx_gpio_irq_mask(struct irq_data *data)
@@ -283,12 +287,14 @@ static irqreturn_t pci1xxxx_gpio_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irq_chip pci1xxxx_gpio_irqchip = {
+static const struct irq_chip pci1xxxx_gpio_irqchip = {
 	.name = "pci1xxxx_gpio",
 	.irq_ack = pci1xxxx_gpio_irq_ack,
 	.irq_mask = pci1xxxx_gpio_irq_mask,
 	.irq_unmask = pci1xxxx_gpio_irq_unmask,
 	.irq_set_type = pci1xxxx_gpio_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static int pci1xxxx_gpio_suspend(struct device *dev)
@@ -351,7 +357,7 @@ static int pci1xxxx_gpio_setup(struct pci1xxxx_gpio *priv, int irq)
 		return retval;
 
 	girq = &priv->gpio.irq;
-	girq->chip = &pci1xxxx_gpio_irqchip;
+	gpio_irq_chip_set_chip(girq, &pci1xxxx_gpio_irqchip);
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
 	girq->parents = NULL;
-- 
2.34.1

