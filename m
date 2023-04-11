Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894356DDCCA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjDKNuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjDKNuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:50:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B0E525E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:49:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso9626569wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681220980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRMC5iFofoKktGidEDO+nRAZWqOxvRlQKeJzDZZ9bBc=;
        b=gXQ3ca40eFlGA4Hoz/INT+Ar9rGM4EfT+6AD5PotZ487coDbSqFCPFYB7c+D8uz18l
         M0PLaBkzncs9DBCJr997F7Fw7gbyx4FhZ+P6sJfFiu3ISD73QswGhBIKZ8igcqrzwpPI
         krKuiQ1wrAkf9+Lg8RhLYmGI0T8Prssaa/NDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681220980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRMC5iFofoKktGidEDO+nRAZWqOxvRlQKeJzDZZ9bBc=;
        b=hlqsg16sY27a9OLWRo2WOoxeBAzfp1hh6hw7J4tZLFuW5hZ0qWs3P0AOt6BKNJZN5/
         99zS8h3yp17MFq3PYA1Zl+P66PLeWo0P4v8M9FyglDPU5EDrtz6accK1wo1jOEXF0vAw
         BltoTuZnhcOUhlZ+hQOACw1U9G/Uub/kuctHsl0DZCmcBaXLYICzGcpGvuewsgFCl0Do
         COJobw0Rrwrq+/DeH1wKDtS83BjDcvSGlK/INQuk4P2aiV9zwpjhSZjRc2LcpdGsCcal
         NCg4NAR/3N4AtWve2OAqJd+UKbIqNTFr5UGpcxC6SjzpvZ+8dvJ1upKFhAlBrCiQudrg
         Rkzg==
X-Gm-Message-State: AAQBX9dekwV1eTorMxzU/+8ngTtkJEVK8gTrOCYcIb08NUBSmDQrzOvi
        NITUMI5S+1KylK2vlOphu+e1pQ==
X-Google-Smtp-Source: AKy350Zr1fK8+7gCRz5xWYNdcIUOGijel6dNT+C0SWtjTZxVN1plQHjMDuzT220lCqxmsLndIV5pFA==
X-Received: by 2002:a7b:c842:0:b0:3ed:88f5:160a with SMTP id c2-20020a7bc842000000b003ed88f5160amr2125195wml.11.1681220980405;
        Tue, 11 Apr 2023 06:49:40 -0700 (PDT)
Received: from orzel1.c.googlers.com.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f071466229sm16665401wme.17.2023.04.11.06.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:49:39 -0700 (PDT)
From:   =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        upstream@semihalf.com, rad@semihalf.com, mattedavis@google.com,
        Gong Richard <richard.gong@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
Subject: [PATCH] Revert "pinctrl: amd: Disable and mask interrupts on resume"
Date:   Tue, 11 Apr 2023 13:49:32 +0000
Message-Id: <20230411134932.292287-1-korneld@chromium.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b26cd9325be4c1fcd331b77f10acb627c560d4d7.

This patch introduces a regression on Lenovo Z13, which can't wake
from the lid with it applied; and some unspecified AMD based Dell
platforms are unable to wake from hitting the power button

Signed-off-by: Kornel Dulęba <korneld@chromium.org>
---
 drivers/pinctrl/pinctrl-amd.c | 36 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 609821b756c2..9236a132c7ba 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -872,34 +872,32 @@ static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_group_set = amd_pinconf_group_set,
 };
 
-static void amd_gpio_irq_init_pin(struct amd_gpio *gpio_dev, int pin)
+static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 {
-	const struct pin_desc *pd;
+	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
 	unsigned long flags;
 	u32 pin_reg, mask;
+	int i;
 
 	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3) |
 		BIT(INTERRUPT_MASK_OFF) | BIT(INTERRUPT_ENABLE_OFF) |
 		BIT(WAKE_CNTRL_OFF_S4);
 
-	pd = pin_desc_get(gpio_dev->pctrl, pin);
-	if (!pd)
-		return;
+	for (i = 0; i < desc->npins; i++) {
+		int pin = desc->pins[i].number;
+		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
 
-	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
-	pin_reg = readl(gpio_dev->base + pin * 4);
-	pin_reg &= ~mask;
-	writel(pin_reg, gpio_dev->base + pin * 4);
-	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
-}
+		if (!pd)
+			continue;
 
-static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
-{
-	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
-	int i;
+		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 
-	for (i = 0; i < desc->npins; i++)
-		amd_gpio_irq_init_pin(gpio_dev, i);
+		pin_reg = readl(gpio_dev->base + i * 4);
+		pin_reg &= ~mask;
+		writel(pin_reg, gpio_dev->base + i * 4);
+
+		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
+	}
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -952,10 +950,8 @@ static int amd_gpio_resume(struct device *dev)
 	for (i = 0; i < desc->npins; i++) {
 		int pin = desc->pins[i].number;
 
-		if (!amd_gpio_should_save(gpio_dev, pin)) {
-			amd_gpio_irq_init_pin(gpio_dev, pin);
+		if (!amd_gpio_should_save(gpio_dev, pin))
 			continue;
-		}
 
 		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 		gpio_dev->saved_regs[i] |= readl(gpio_dev->base + pin * 4) & PIN_IRQ_PENDING;
-- 
2.40.0.577.gac1e443424-goog

