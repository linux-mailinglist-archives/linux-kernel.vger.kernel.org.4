Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F063A9BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiK1Ni4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiK1Niy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:38:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C5F1E3F9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:38:52 -0800 (PST)
Date:   Mon, 28 Nov 2022 13:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669642730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNnynXnRegdXzVlwj3a1KTCbuWWp+T8YaZaXXxxRguM=;
        b=4WkfDg8IjNtw2SfSkCnfQAe+7R3+fXG5hCySNwuSTbkEN3OrbR1YnWBGLvfjQtZBrVJ2bK
        gnvLzcbKw3vJ4qz8x1JdQjnZUXxaE5KN+/KE5qtAnWkThsoC7nVNV5RsdrIvg+vXaWv68O
        90YGd5FibLLtxIEwlePrHgCjVk7duKVPToeNzdPqbEJ5xtLIPjN29fokCRf4ED8nKbnxM7
        lQdhnBnQ+SKalgk4s9FaYG8d28DyzPsjbNkIODuiqdpfggF4C9kM7yUxrHjYRcBCAAhnOX
        eYB7WNRgndWnCGcanK2fYbJph/CsjEYh+2j32DnO1iS1OA5zjZ5/9OtFRU+RXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669642730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNnynXnRegdXzVlwj3a1KTCbuWWp+T8YaZaXXxxRguM=;
        b=2nfi+GY5ihNSu7fX08OcUhI+2cm3RVIcZyAzcin895UP6sTOGjG/YtYPvYYPSBn4fpvir3
        iAMEwttIBsb4vRBA==
From:   "irqchip-bot for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic: Use kstrtobool() instead of
 strtobool()
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C755c4083122071bb27aa8ed5d98156a07bb63a39=2E16673?=
 =?utf-8?q?36095=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3C755c4083122071bb27aa8ed5d98156a07bb63a39=2E166733?=
 =?utf-8?q?6095=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <166964272891.4906.17772181110833861902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5e279739d7312b8958ec816fa38dba2725638503
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5e279739d7312b8958ec816fa38dba2725638503
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Tue, 01 Nov 2022 22:13:51 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 28 Nov 2022 13:32:55 

irqchip/gic: Use kstrtobool() instead of strtobool()

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/755c4083122071bb27aa8ed5d98156a07bb63a39.1667336095.git.christophe.jaillet@wanadoo.fr
---
 drivers/irqchip/irq-gic-v3.c | 3 ++-
 drivers/irqchip/irq-gic.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 34d5856..997104d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
+#include <linux/kstrtox.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -1171,7 +1172,7 @@ static bool gicv3_nolpi;
 
 static int __init gicv3_nolpi_cfg(char *buf)
 {
-	return strtobool(buf, &gicv3_nolpi);
+	return kstrtobool(buf, &gicv3_nolpi);
 }
 early_param("irqchip.gicv3_nolpi", gicv3_nolpi_cfg);
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4c7bae0..799f86d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -19,6 +19,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/list.h>
@@ -1332,7 +1333,7 @@ static bool gicv2_force_probe;
 
 static int __init gicv2_force_probe_cfg(char *buf)
 {
-	return strtobool(buf, &gicv2_force_probe);
+	return kstrtobool(buf, &gicv2_force_probe);
 }
 early_param("irqchip.gicv2_force_probe", gicv2_force_probe_cfg);
 
