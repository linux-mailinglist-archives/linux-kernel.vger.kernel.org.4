Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8A767CC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjAZN3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbjAZN2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:28:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4552714;
        Thu, 26 Jan 2023 05:28:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 488EC617DC;
        Thu, 26 Jan 2023 13:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05E9C4339E;
        Thu, 26 Jan 2023 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674739706;
        bh=e4AsdmwdSJCP/xsPyWv+tSbBA9IAnfawTLOAVhDVorM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5E9X+aal0HBiiHd/it1x+8vs2MPfjTzCvZUKFksXBNqlsbNQ3DdeUwL3f6m22A1+
         TzXj1zrVxwjiwEeZ0PGlvkoCgKps9yaSN28g7KURiMfNjIF2dNL/fPuhRlgLB/Be98
         g/Q8p7/d7dwBa/S7/YJtF5AVQI7hrWhRvxOqGo4bkoRLoEDswwxClcBRA6Evydnhsl
         eDCeZUUQLHFA23GsiteIsUXyOyIt9zXvA9qiQqNv48BWu2iF3P2fW6kHqqk046xYsw
         CY3V/5pfHLg44+E5vgmVsVpk5V3STym/VccU0zispNJ1V43tlzCjlQBxE4f84/QaII
         KsjJCluVhtUTA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-gpio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] gpiolib: move of_gpio_flags into gpiolib-of.c
Date:   Thu, 26 Jan 2023 14:28:01 +0100
Message-Id: <20230126132801.2042371-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126132801.2042371-1-arnd@kernel.org>
References: <20230126132801.2042371-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is no need for this in the header any more, it's just
an implementation detail now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpiolib-of.c | 15 +++++++++++++++
 include/linux/of_gpio.h   | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 6a08569a20c1..1563ddcf32d4 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -23,6 +23,21 @@
 #include "gpiolib.h"
 #include "gpiolib-of.h"
 
+/*
+ * This is Linux-specific flags. By default controllers' and Linux' mapping
+ * match, but GPIO controllers are free to translate their own flags to
+ * Linux-specific in their .xlate callback. Though, 1:1 mapping is recommended.
+ */
+enum of_gpio_flags {
+	OF_GPIO_ACTIVE_LOW = 0x1,
+	OF_GPIO_SINGLE_ENDED = 0x2,
+	OF_GPIO_OPEN_DRAIN = 0x4,
+	OF_GPIO_TRANSITORY = 0x8,
+	OF_GPIO_PULL_UP = 0x10,
+	OF_GPIO_PULL_DOWN = 0x20,
+	OF_GPIO_PULL_DISABLE = 0x40,
+};
+
 /**
  * of_gpio_named_count() - Count GPIOs for a device
  * @np:		device node to count GPIOs for
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 04e1f76acdd7..d0f66a5e1b2a 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -17,21 +17,6 @@
 
 struct device_node;
 
-/*
- * This is Linux-specific flags. By default controllers' and Linux' mapping
- * match, but GPIO controllers are free to translate their own flags to
- * Linux-specific in their .xlate callback. Though, 1:1 mapping is recommended.
- */
-enum of_gpio_flags {
-	OF_GPIO_ACTIVE_LOW = 0x1,
-	OF_GPIO_SINGLE_ENDED = 0x2,
-	OF_GPIO_OPEN_DRAIN = 0x4,
-	OF_GPIO_TRANSITORY = 0x8,
-	OF_GPIO_PULL_UP = 0x10,
-	OF_GPIO_PULL_DOWN = 0x20,
-	OF_GPIO_PULL_DISABLE = 0x40,
-};
-
 #ifdef CONFIG_OF_GPIO
 
 extern int of_get_named_gpio(const struct device_node *np,
-- 
2.39.0

