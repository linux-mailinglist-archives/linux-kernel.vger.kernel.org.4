Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354956C0D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCTJd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjCTJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:33:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BAD199D5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:33:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso7051704wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679304802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+OQ0nI1S0CclNxQUNivJQtGEqsW3qm+k8fT1UZxHIQ=;
        b=oU83Oq2pAdAx/4w0Q2VdsWf6xV29kcsHvv9v0PoOJUhIgleB5j1mKvRRmxBhqAhvrV
         b70u/agLj1pqh+Tm9FTRaLeE4dv9PzTcFPnFf6OAYvMYBYhfRztHxqoRhaJXAKcrbJ0D
         6t41Njy/zLlnvi+pDlh/kpw5gzA1g+S1Ymm68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679304802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+OQ0nI1S0CclNxQUNivJQtGEqsW3qm+k8fT1UZxHIQ=;
        b=5o0m2FZACAIbVWfTbCEwNFkFkALGVURb+lwV5IlQP8W4SUuZdj0uKKUyGg7992lB5r
         QduooaYY8U6pqu8cgkHVF1aHGjKdxs74EprqiDayHZSsDqz5dfLweO9zu1/1tp8iXiLt
         b2f8ous2i/IVJ8TcoYLdmfju+S+angOjiS/Qq1/E8tOjDxu8u28TJeg8MpIda4EJgF8O
         SfMlZ8WiPJOcEZLB+zrmZGE/VLC6hbzeDO+1NcCX+3WbGZGjjBTdB2uw14g7APzg/LDl
         hHPngeTcLhDfoo4Z2I3LD3YZoxLe+c2dZCMHeG2Wiaqf5ASyGmd/qYD0vhP6FpcRJWzx
         fHsw==
X-Gm-Message-State: AO0yUKXjgJ6Djb4FZW6TKB+yajQ1mxXoyQPfy/or5hNjtvYahc1BZOYe
        AlLJWpmDUpUm3qYeJLNvGa188Q==
X-Google-Smtp-Source: AK7set/RHlRwsU4hzrHj8NbQ0dDxsDiKBByIeLUo9ZdDB3P52/7QU86/DbDV7MtnhYsX5qZsIy+lMg==
X-Received: by 2002:a05:600c:4712:b0:3da:28a9:a900 with SMTP id v18-20020a05600c471200b003da28a9a900mr31063590wmo.41.1679304801902;
        Mon, 20 Mar 2023 02:33:21 -0700 (PDT)
Received: from orzel1.c.googlers.com.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003dc434b39c7sm25751110wms.0.2023.03.20.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 02:33:21 -0700 (PDT)
From:   =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        upstream@semihalf.com, rad@semihalf.com, mattedavis@google.com,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
Subject: [PATCH] pinctrl: amd: Disable and mask interrupts on resume
Date:   Mon, 20 Mar 2023 09:32:59 +0000
Message-Id: <20230320093259.845178-1-korneld@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a similar problem to the one observed in:
commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe").

On some systems, during suspend/resume cycle firmware leaves
an interrupt enabled on a pin that is not used by the kernel.
This confuses the AMD pinctrl driver and causes spurious interrupts.

The driver already has logic to detect if a pin is used by the kernel.
Leverage it to re-initialize interrupt fields of a pin only if it's not
used by us.

Signed-off-by: Kornel Dulęba <korneld@chromium.org>
---
 drivers/pinctrl/pinctrl-amd.c | 36 +++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 9236a132c7ba..609821b756c2 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -872,32 +872,34 @@ static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_group_set = amd_pinconf_group_set,
 };
 
-static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
+static void amd_gpio_irq_init_pin(struct amd_gpio *gpio_dev, int pin)
 {
-	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
+	const struct pin_desc *pd;
 	unsigned long flags;
 	u32 pin_reg, mask;
-	int i;
 
 	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3) |
 		BIT(INTERRUPT_MASK_OFF) | BIT(INTERRUPT_ENABLE_OFF) |
 		BIT(WAKE_CNTRL_OFF_S4);
 
-	for (i = 0; i < desc->npins; i++) {
-		int pin = desc->pins[i].number;
-		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
-
-		if (!pd)
-			continue;
+	pd = pin_desc_get(gpio_dev->pctrl, pin);
+	if (!pd)
+		return;
 
-		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+	pin_reg = readl(gpio_dev->base + pin * 4);
+	pin_reg &= ~mask;
+	writel(pin_reg, gpio_dev->base + pin * 4);
+	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
+}
 
-		pin_reg = readl(gpio_dev->base + i * 4);
-		pin_reg &= ~mask;
-		writel(pin_reg, gpio_dev->base + i * 4);
+static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
+{
+	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
+	int i;
 
-		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
-	}
+	for (i = 0; i < desc->npins; i++)
+		amd_gpio_irq_init_pin(gpio_dev, i);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -950,8 +952,10 @@ static int amd_gpio_resume(struct device *dev)
 	for (i = 0; i < desc->npins; i++) {
 		int pin = desc->pins[i].number;
 
-		if (!amd_gpio_should_save(gpio_dev, pin))
+		if (!amd_gpio_should_save(gpio_dev, pin)) {
+			amd_gpio_irq_init_pin(gpio_dev, pin);
 			continue;
+		}
 
 		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 		gpio_dev->saved_regs[i] |= readl(gpio_dev->base + pin * 4) & PIN_IRQ_PENDING;
-- 
2.40.0.rc1.284.g88254d51c5-goog

