Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B151B5BE33F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiITKbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiITKbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:19 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B386FA36
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id B93FE280BA6;
        Tue, 20 Sep 2022 18:31:15 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 08/20] gpiolib: make gpiochip_find_by_name to be common function
Date:   Tue, 20 Sep 2022 18:30:56 +0800
Message-Id: <20220920103108.23074-9-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920103108.23074-1-jay.xu@rock-chips.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGEMeVkIZTR4eSR5NT0lMTVUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAg6Ixw*Kz0pNhwrFxQ8LxgO
        FwswCipVSlVKTU1ITU1CQ0xNT0pIVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUhMSEw3Bg++
X-HM-Tid: 0a835a73b52a2eb1kusnb93fe280ba6
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move find_chip_by_name from gpiolib to the gpio/driver.h, also rename to
gpiochip_find_by_name, make it to be a common function.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/gpio/gpiolib.c      | 16 ++--------------
 include/linux/gpio/driver.h | 12 ++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cc9c0a12259e..c06334772c47 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -935,18 +935,6 @@ struct gpio_chip *gpiochip_find(void *data,
 }
 EXPORT_SYMBOL_GPL(gpiochip_find);
 
-static int gpiochip_match_name(struct gpio_chip *gc, void *data)
-{
-	const char *name = data;
-
-	return !strcmp(gc->label, name);
-}
-
-static struct gpio_chip *find_chip_by_name(const char *name)
-{
-	return gpiochip_find((void *)name, gpiochip_match_name);
-}
-
 #ifdef CONFIG_GPIOLIB_IRQCHIP
 
 /*
@@ -3660,7 +3648,7 @@ void gpiod_add_hogs(struct gpiod_hog *hogs)
 		 * The chip may have been registered earlier, so check if it
 		 * exists and, if so, try to hog the line now.
 		 */
-		gc = find_chip_by_name(hog->chip_label);
+		gc = gpiochip_find_by_name(hog->chip_label);
 		if (gc)
 			gpiochip_machine_hog(gc, hog);
 	}
@@ -3745,7 +3733,7 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 			return ERR_PTR(-EPROBE_DEFER);
 		}
 
-		gc = find_chip_by_name(p->key);
+		gc = gpiochip_find_by_name(p->key);
 
 		if (!gc) {
 			/*
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 6aeea1071b1b..4ed26a7d98ff 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -618,6 +618,18 @@ extern int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip
 extern struct gpio_chip *gpiochip_find(void *data,
 			      int (*match)(struct gpio_chip *gc, void *data));
 
+static int gpiochip_match_name(struct gpio_chip *gc, void *data)
+{
+	const char *name = data;
+
+	return !strcmp(gc->label, name);
+}
+
+static inline struct gpio_chip *gpiochip_find_by_name(const char *name)
+{
+	return gpiochip_find((void *)name, gpiochip_match_name);
+}
+
 bool gpiochip_line_is_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_reqres_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
-- 
2.25.1

