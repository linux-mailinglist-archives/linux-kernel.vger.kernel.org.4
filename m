Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E776D1C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjCaJeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjCaJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:33:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54D44EC9;
        Fri, 31 Mar 2023 02:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9303CB82DB3;
        Fri, 31 Mar 2023 09:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23B9C433D2;
        Fri, 31 Mar 2023 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680255204;
        bh=72mzuO04L3PUk9aLCOXDvsit2zTzKDWhSwQULIrm2dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Racua//Q7UDpfBF96lbadzS4b0GO6n85LayT00ZPbmGfYsxeO/GNyrTILknk4WWk
         53tLe2c6OPQiNsQ37NnQAcRDAYXEHrZopBKV8o1MujN+nOybKjqCGaCQ5yq2f+zjVN
         YDqnPhLO5pkpeEVpm6LyU5gOEpKvosiUVDKwodwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/7] driver core: create class_is_registered()
Date:   Fri, 31 Mar 2023 11:33:13 +0200
Message-Id: <20230331093318.82288-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331093318.82288-1-gregkh@linuxfoundation.org>
References: <20230331093318.82288-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3679; i=gregkh@linuxfoundation.org; h=from:subject; bh=72mzuO04L3PUk9aLCOXDvsit2zTzKDWhSwQULIrm2dg=; b=owGbwMvMwCRo6H6F97bub03G02pJDClqK+6c83t86uvFnEWSap/cVvBrx5nnSOgvVeJJ/r860 prZ4cr1jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIy2MM8+N+PvoguP1DQNrn 2SdOX/IRs5vEycQw33f6p/6ZprF2J75UyvNUz91+0GWuJwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some classes (i.e. gpio), want to know if they have been registered or
not, and poke around in the class's internal structures to try to figure
this out.  Because this is not really a good idea, provide a function
for classes to call to try to figure this out.

Note, this is racy as the state of the class could change at any moment
in time after the call is made, but as usually a class only wants to
know if it has been registered yet or not, it should be fairly safe to
use, and is just as safe as the previous "poke at the class internals"
check was.

Move the gpiolib code to use this function as proof that it works
properly.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-gpio@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         | 25 +++++++++++++++++++++++++
 drivers/gpio/gpiolib-sysfs.c |  4 ++--
 include/linux/device/class.h |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 68a6f9b56d19..a8a1bf976290 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -634,6 +634,31 @@ void class_compat_remove_link(struct class_compat *cls, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(class_compat_remove_link);
 
+/**
+ * class_is_registered - determine if at this moment in time, a class is
+ *			 registered in the driver core or not.
+ * @class: the class to check
+ *
+ * Returns a boolean to state if the class is registered in the driver core
+ * or not.  Note that the value could switch right after this call is made,
+ * so only use this in places where you "know" it is safe to do so (usually
+ * to determine if the specific class has been registered yet or not).
+ *
+ * Be careful in using this.
+ */
+bool class_is_registered(const struct class *class)
+{
+	struct subsys_private *sp = class_to_subsys(class);
+	bool is_initialized = false;
+
+	if (sp) {
+		is_initialized = true;
+		subsys_put(sp);
+	}
+	return is_initialized;
+}
+EXPORT_SYMBOL_GPL(class_is_registered);
+
 int __init classes_init(void)
 {
 	class_kset = kset_create_and_add("class", NULL, NULL);
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index a895915affa5..1a9b21731cc9 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -554,7 +554,7 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	int			offset;
 
 	/* can't export until sysfs is available ... */
-	if (!gpio_class.p) {
+	if (!class_is_registered(&gpio_class)) {
 		pr_debug("%s: called too early!\n", __func__);
 		return -ENOENT;
 	}
@@ -728,7 +728,7 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 	 * register later, in gpiolib_sysfs_init() ... here we just
 	 * verify that _some_ field of gpio_class got initialized.
 	 */
-	if (!gpio_class.p)
+	if (!class_is_registered(&gpio_class))
 		return 0;
 
 	/*
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index b53728ca56fb..9cb5db0588c8 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -84,6 +84,7 @@ extern struct kobject *sysfs_dev_block_kobj;
 
 int __must_check class_register(struct class *class);
 void class_unregister(const struct class *class);
+bool class_is_registered(const struct class *class);
 
 struct class_compat;
 struct class_compat *class_compat_register(const char *name);
-- 
2.40.0

