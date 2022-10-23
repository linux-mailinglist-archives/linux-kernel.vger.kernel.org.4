Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6BE60921D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJWJuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJWJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:50:01 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB6F2E6BC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666518546; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FBECTcdeQLfSp5bHcYAa/1zAvqLKLLp0tQ+VpGze+A=;
        b=WMXviK4znNH+cxAIFAOQi3B1ykMnVrOcVU4hf2Rqqlk058V80E+qnyk8E0LlkDXjEPWIXm
        5qVkv3kePJ7wNXzCipfnq9MYT16MVBahctpgvp0h4oxMOe2Waq01lOVUy6yVlaUaKThAzq
        zocXklgI+/PciXSlgUahWpIe9bqshyo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 05/28] mfd: mt6397-irq: Remove #ifdef guards for PM related functions
Date:   Sun, 23 Oct 2022 10:48:29 +0100
Message-Id: <20221023094852.8035-6-paul@crapouillou.net>
In-Reply-To: <20221023094852.8035-1-paul@crapouillou.net>
References: <20221023094852.8035-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pm_sleep_ptr() macro to handle the .irq_set_wake() callback.

This macro allows the mt6397_irq_set_wake() function to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org

 drivers/mfd/mt6397-irq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
index eff53fed8fe7..72f923e47752 100644
--- a/drivers/mfd/mt6397-irq.c
+++ b/drivers/mfd/mt6397-irq.c
@@ -54,7 +54,6 @@ static void mt6397_irq_enable(struct irq_data *data)
 	mt6397->irq_masks_cur[reg] |= BIT(shift);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mt6397_irq_set_wake(struct irq_data *irq_data, unsigned int on)
 {
 	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(irq_data);
@@ -68,9 +67,6 @@ static int mt6397_irq_set_wake(struct irq_data *irq_data, unsigned int on)
 
 	return 0;
 }
-#else
-#define mt6397_irq_set_wake NULL
-#endif
 
 static struct irq_chip mt6397_irq_chip = {
 	.name = "mt6397-irq",
@@ -78,7 +74,7 @@ static struct irq_chip mt6397_irq_chip = {
 	.irq_bus_sync_unlock = mt6397_irq_sync_unlock,
 	.irq_enable = mt6397_irq_enable,
 	.irq_disable = mt6397_irq_disable,
-	.irq_set_wake = mt6397_irq_set_wake,
+	.irq_set_wake = pm_sleep_ptr(mt6397_irq_set_wake),
 };
 
 static void mt6397_irq_handle_reg(struct mt6397_chip *mt6397, int reg,
-- 
2.35.1

