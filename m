Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08396153DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiKAVPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiKAVO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:14:57 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823A1DF24
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:14:55 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyanoKD2rsfCIpyazoWfH6; Tue, 01 Nov 2022 22:14:54 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:14:54 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 03/30] irqchip: Use kstrtobool() instead of strtobool()
Date:   Tue,  1 Nov 2022 22:13:51 +0100
Message-Id: <755c4083122071bb27aa8ed5d98156a07bb63a39.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is part of a serie that axes all usages of strtobool().
Each patch can be applied independently from the other ones.

The last patch of the serie removes the definition of strtobool().

You may not be in copy of the cover letter. So, if needed, it is available
at [1].


This patch has NOT been compile tested.


[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 drivers/irqchip/irq-gic-v3.c | 3 ++-
 drivers/irqchip/irq-gic.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 34d58567b78d..997104d4338e 100644
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
index 4c7bae0ec8f9..799f86d84b43 100644
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
 
-- 
2.34.1

