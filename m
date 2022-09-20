Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F2F5BE341
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiITKb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiITKbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:20 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F205B62ABD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:18 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 71C22280B29;
        Tue, 20 Sep 2022 18:31:16 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 09/20] gpio/rockchip: drop 'bank->name' from the driver
Date:   Tue, 20 Sep 2022 18:30:57 +0800
Message-Id: <20220920103108.23074-10-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920103108.23074-1-jay.xu@rock-chips.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUpJVh4eSU4fS01IHx5MSVUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6Ogw5GD0eFBxLPQk6Lx8s
        FBZPCzFVSlVKTU1ITU1CQ0xMSkNIVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUhKTEs3Bg++
X-HM-Tid: 0a835a73b7f12eb1kusn71c22280b29
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not to use the 'bank->name' and create 'gc->lable' by the bank number.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/gpio/gpio-rockchip.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index bb50335239ac..dafcc8be1687 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -327,7 +327,7 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 	struct rockchip_pin_bank *bank = irq_desc_get_handler_data(desc);
 	u32 pend;
 
-	dev_dbg(bank->dev, "got irq for bank %s\n", bank->name);
+	dev_dbg(bank->dev, "got irq\n");
 
 	chained_irq_enter(chip, desc);
 
@@ -521,8 +521,7 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
 	bank->domain = irq_domain_add_linear(bank->of_node, 32,
 					&irq_generic_chip_ops, NULL);
 	if (!bank->domain) {
-		dev_warn(bank->dev, "could not init irq domain for bank %s\n",
-			 bank->name);
+		dev_warn(bank->dev, "could not init irq domain\n");
 		return -EINVAL;
 	}
 
@@ -531,8 +530,7 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
 					     handle_level_irq,
 					     clr, 0, 0);
 	if (ret) {
-		dev_err(bank->dev, "could not alloc generic chips for bank %s\n",
-			bank->name);
+		dev_err(bank->dev, "could not alloc generic chips\n");
 		irq_domain_remove(bank->domain);
 		return -EINVAL;
 	}
@@ -586,8 +584,10 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 	gc = &bank->gpio_chip;
 	gc->base = bank->pin_base;
 	gc->ngpio = bank->nr_pins;
-	gc->label = bank->name;
 	gc->parent = bank->dev;
+	gc->label = devm_kasprintf(bank->dev, GFP_KERNEL, "gpio%d", bank->bank_num);
+	if (!gc->label)
+		return -ENOMEM;
 
 	ret = gpiochip_add_data(gc, bank);
 	if (ret) {
-- 
2.25.1

