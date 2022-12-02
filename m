Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A857B64082C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiLBOGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiLBOGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:06:21 -0500
Received: from mail1.systemli.org (mail1.systemli.org [93.190.126.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B25CCFDE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:06:20 -0800 (PST)
From:   Nick Hainke <vincent@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1669989978;
        bh=OCDmhgTyLSlPbP6Fb/y2O3SRRjzGG9cASZpxCloAR/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=T7TUKpDz70v2AFSYhpEV346WKTBGdXd39XXHYLh5gm9OYs4BjOy8vtTVmKRFwI5K6
         UWezPLCLaV4tDcW6ZyYXa39GSkswcx8iO0/N1gXOixipC5S6UeuU0ud877rfuvfd+k
         jzFAO1narFdHRUQvQZ5Zyg1zXyz1muC4Rc1w27hup88PiWBpldQRSNdKh9xVdsNSre
         zfufjLl0npPno0IwYMo3YXAyz4L430anX8YWKzF+g1b0sZWXGw1S2eNQp6J8sEmBqo
         uIkSUVAIS05xTs6PdcN5WjaSUokOKKfTTErB+d6B46i9kz0qn9IyL0WgoGTQPnq+Yc
         lMcbP+9eOoMeA==
To:     vincent@systemli.org
Cc:     linux-next@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpiolib: fix compiling when CONFIG_GPIO_CDEV_V1 is not defined
Date:   Fri,  2 Dec 2022 15:04:54 +0100
Message-Id: <20221202140454.273333-1-vincent@systemli.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_GPIO_CDEV_V1 is not defined compiling will fail with:

drivers/gpio/gpiolib-cdev.c: In function 'linereq_ioctl':
drivers/gpio/gpiolib-cdev.c:1468:16: error: implicit declaration of
 function 'call_ioctl_locked' [-Werror=implicit-function-declaration]
 1468 |         return call_ioctl_locked(file, cmd, arg, lr->gdev,
      |                ^~~~~~~~~~~~~~~~~
drivers/gpio/gpiolib-cdev.c: In function 'linereq_poll':
drivers/gpio/gpiolib-cdev.c:1503:16: error: implicit declaration of
 function 'call_poll_locked'; did you mean 'wake_up_all_locked'?
 [-Werror=implicit-function-declaration]
 1503 |         return call_poll_locked(file, wait, lr->gdev,
                                      linereq_poll_unlocked);
      |                ^~~~~~~~~~~~~~~~
      |                wake_up_all_locked
drivers/gpio/gpiolib-cdev.c: In function 'linereq_read':
drivers/gpio/gpiolib-cdev.c:1566:16: error: implicit declaration of
 function 'call_read_locked'; did you mean 'xa_head_locked'?
 [-Werror=implicit-function-declaration]
 1566 |         return call_read_locked(file, buf, count, f_ps, lr->gdev,
      |                ^~~~~~~~~~~~~~~~
      |                xa_head_locked

Move "call_poll_locked", "call_ioctl_locked", "call_read_locked" and
the necessary typedefs "poll_fn", "ioctl_fn", "read_fn" in front of the
ifdef-statement checking CONFIG_GPIO_CDEV_V1.

Fixes: 98d8b93c6171 ("gpiolib: protect the GPIO device against being dropped while in use by user-space")

Signed-off-by: Nick Hainke <vincent@systemli.org>
---
 drivers/gpio/gpiolib-cdev.c | 50 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index e8079c1d2e1b..067e26a00775 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -61,31 +61,6 @@ static_assert(IS_ALIGNED(sizeof(struct gpio_v2_line_values), 8));
  * GPIO line handle management
  */
 
-#ifdef CONFIG_GPIO_CDEV_V1
-/**
- * struct linehandle_state - contains the state of a userspace handle
- * @gdev: the GPIO device the handle pertains to
- * @label: consumer label used to tag descriptors
- * @descs: the GPIO descriptors held by this handle
- * @num_descs: the number of descriptors held in the descs array
- */
-struct linehandle_state {
-	struct gpio_device *gdev;
-	const char *label;
-	struct gpio_desc *descs[GPIOHANDLES_MAX];
-	u32 num_descs;
-};
-
-#define GPIOHANDLE_REQUEST_VALID_FLAGS \
-	(GPIOHANDLE_REQUEST_INPUT | \
-	GPIOHANDLE_REQUEST_OUTPUT | \
-	GPIOHANDLE_REQUEST_ACTIVE_LOW | \
-	GPIOHANDLE_REQUEST_BIAS_PULL_UP | \
-	GPIOHANDLE_REQUEST_BIAS_PULL_DOWN | \
-	GPIOHANDLE_REQUEST_BIAS_DISABLE | \
-	GPIOHANDLE_REQUEST_OPEN_DRAIN | \
-	GPIOHANDLE_REQUEST_OPEN_SOURCE)
-
 typedef __poll_t (*poll_fn)(struct file *, struct poll_table_struct *);
 typedef long (*ioctl_fn)(struct file *, unsigned int, unsigned long);
 typedef ssize_t (*read_fn)(struct file *, char __user *,
@@ -133,6 +108,31 @@ static ssize_t call_read_locked(struct file *file, char __user *buf,
 	return ret;
 }
 
+#ifdef CONFIG_GPIO_CDEV_V1
+/**
+ * struct linehandle_state - contains the state of a userspace handle
+ * @gdev: the GPIO device the handle pertains to
+ * @label: consumer label used to tag descriptors
+ * @descs: the GPIO descriptors held by this handle
+ * @num_descs: the number of descriptors held in the descs array
+ */
+struct linehandle_state {
+	struct gpio_device *gdev;
+	const char *label;
+	struct gpio_desc *descs[GPIOHANDLES_MAX];
+	u32 num_descs;
+};
+
+#define GPIOHANDLE_REQUEST_VALID_FLAGS \
+	(GPIOHANDLE_REQUEST_INPUT | \
+	GPIOHANDLE_REQUEST_OUTPUT | \
+	GPIOHANDLE_REQUEST_ACTIVE_LOW | \
+	GPIOHANDLE_REQUEST_BIAS_PULL_UP | \
+	GPIOHANDLE_REQUEST_BIAS_PULL_DOWN | \
+	GPIOHANDLE_REQUEST_BIAS_DISABLE | \
+	GPIOHANDLE_REQUEST_OPEN_DRAIN | \
+	GPIOHANDLE_REQUEST_OPEN_SOURCE)
+
 static int linehandle_validate_flags(u32 flags)
 {
 	/* Return an error if an unknown flag is set */
-- 
2.38.1

