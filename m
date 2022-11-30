Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8D363D163
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiK3JGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiK3JGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:06:03 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E249B7A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:06:02 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so883067wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaWBRwWXBehjrIvGP4MX42mw8iXGH6zrJDG1Zu/gB00=;
        b=qxjvlJdDcX0EfPoIFyfLI3DER//zESGiJCLneb7tfs4yy5ZtVLmXUzTG66aw37WO1p
         gLHClHLAnT56UpSvPYpKj3eF552ZaXyrXMq0qIFQ+kpY+A/DehjYZMeMWqDaXS6bz7L2
         qv3YNpYkELL87INh5ybaUM+PEDdkieqTAbmTHQPPt9VDDdRKzfQjSNMtltlqRoXa3ImR
         YGonit1nmC1y+rauofRyB75A1lISZuAVa33OVjknkfeVTfP7C+wktONQmT3zFMWhpbbu
         M6WFsHsqnenTAeKl473+nbczhhjzAlEfbuz10cMpw7UvG5xhRTnc4ce/ZHmELBQ8YVmu
         Q3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaWBRwWXBehjrIvGP4MX42mw8iXGH6zrJDG1Zu/gB00=;
        b=OYUlE6YAO/BXshAH8LWKrCN+SFndhKjqlX83qziTV+H7iN3ZSjp8GLDC9AoDNuIBRN
         AjOaEz9cUor6y8ino2/AD8oRnXiyNC3/1uyQQktUauBRcSkL0eobgQRQtDTVdLpstuDk
         nFWCmpXyhDW+Sg7GqWcYIKlmYFTXZ2x9F684VshgZJ9qXtYztZgQCCBN8A1qGL/qPUgg
         WQv4eC8oj4qaqmxKUwoOAg3d+QXBD8w+hwjGMjvP+fvUP8TrgX8wu8XShwnhn/jZFqjl
         vlesRZn+W7vPOsTHcwJu8F2H5e631EpsFkJCM2AytaKyXoRY0K7y3tbgdMINUdMjHvir
         C1iQ==
X-Gm-Message-State: ANoB5pk0IELR0FAZ1fiCG8PjkDsFFJphO4jz6/nlsITkGGDsNjRkKa1U
        S6ia0GL2PhJGPYW8uAIXLHeXaw==
X-Google-Smtp-Source: AA0mqf4jVWL5qDOUtlWFbVmQityTkU6mDQ2eA2QxcbqXaHcWta//M/zA1TUlIc8SNj7uYBVquU1E6w==
X-Received: by 2002:a1c:4b12:0:b0:3cf:5237:c0be with SMTP id y18-20020a1c4b12000000b003cf5237c0bemr42878687wma.163.1669799160694;
        Wed, 30 Nov 2022 01:06:00 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:458c:6db9:e033:a468])
        by smtp.gmail.com with ESMTPSA id v24-20020a05600c4d9800b003cfbe1da539sm1168841wmp.36.2022.11.30.01.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:06:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 2/2] gpiolib: protect the GPIO device against being dropped while in use by user-space
Date:   Wed, 30 Nov 2022 10:05:56 +0100
Message-Id: <20221130090556.40280-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221130090556.40280-1-brgl@bgdev.pl>
References: <20221130090556.40280-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

While any of the GPIO cdev syscalls is in progress, the kernel can call
gpiochip_remove() (for instance, when a USB GPIO expander is disconnected)
which will set gdev->chip to NULL after which any subsequent access will
cause a crash.

To avoid that: use an RW-semaphore in which the syscalls take it for
reading (so that we don't needlessly prohibit the user-space from calling
syscalls simultaneously) while gpiochip_remove() takes it for writing so
that it can only happen once all syscalls return.

Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
Fixes: 7b8e00d98168 ("gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-cdev.c | 163 +++++++++++++++++++++++++++++++-----
 drivers/gpio/gpiolib.c      |   4 +
 drivers/gpio/gpiolib.h      |   5 ++
 3 files changed, 150 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 911d91668903..98904832f4b4 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -84,6 +84,50 @@ struct linehandle_state {
 	GPIOHANDLE_REQUEST_OPEN_DRAIN | \
 	GPIOHANDLE_REQUEST_OPEN_SOURCE)
 
+typedef __poll_t (*poll_fn)(struct file *, struct poll_table_struct *);
+typedef long (*ioctl_fn)(struct file *, unsigned int, unsigned long);
+typedef ssize_t (*read_fn)(struct file *, char __user *,
+			   size_t count, loff_t *);
+
+static __poll_t call_poll_locked(struct file *file,
+				 struct poll_table_struct *wait,
+				 struct gpio_device *gdev, poll_fn func)
+{
+	__poll_t ret;
+
+	down_read(&gdev->sem);
+	ret = func(file, wait);
+	up_read(&gdev->sem);
+
+	return ret;
+}
+
+static long call_ioctl_locked(struct file *file, unsigned int cmd,
+			      unsigned long arg, struct gpio_device *gdev,
+			      ioctl_fn func)
+{
+	long ret;
+
+	down_read(&gdev->sem);
+	ret = func(file, cmd, arg);
+	up_read(&gdev->sem);
+
+	return ret;
+}
+
+static ssize_t call_read_locked(struct file *file, char __user *buf,
+				size_t count, loff_t *f_ps,
+				struct gpio_device *gdev, read_fn func)
+{
+	ssize_t ret;
+
+	down_read(&gdev->sem);
+	ret = func(file, buf, count, f_ps);
+	up_read(&gdev->sem);
+
+	return ret;
+}
+
 static int linehandle_validate_flags(u32 flags)
 {
 	/* Return an error if an unknown flag is set */
@@ -191,8 +235,8 @@ static long linehandle_set_config(struct linehandle_state *lh,
 	return 0;
 }
 
-static long linehandle_ioctl(struct file *file, unsigned int cmd,
-			     unsigned long arg)
+static long linehandle_ioctl_unlocked(struct file *file, unsigned int cmd,
+				      unsigned long arg)
 {
 	struct linehandle_state *lh = file->private_data;
 	void __user *ip = (void __user *)arg;
@@ -250,6 +294,15 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
+static long linehandle_ioctl(struct file *file, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct linehandle_state *lh = file->private_data;
+
+	return call_ioctl_locked(file, cmd, arg, lh->gdev,
+				 linehandle_ioctl_unlocked);
+}
+
 #ifdef CONFIG_COMPAT
 static long linehandle_ioctl_compat(struct file *file, unsigned int cmd,
 				    unsigned long arg)
@@ -1381,8 +1434,8 @@ static long linereq_set_config(struct linereq *lr, void __user *ip)
 	return ret;
 }
 
-static long linereq_ioctl(struct file *file, unsigned int cmd,
-			  unsigned long arg)
+static long linereq_ioctl_unlocked(struct file *file, unsigned int cmd,
+				   unsigned long arg)
 {
 	struct linereq *lr = file->private_data;
 	void __user *ip = (void __user *)arg;
@@ -1402,6 +1455,15 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
+static long linereq_ioctl(struct file *file, unsigned int cmd,
+			  unsigned long arg)
+{
+	struct linereq *lr = file->private_data;
+
+	return call_ioctl_locked(file, cmd, arg, lr->gdev,
+				 linereq_ioctl_unlocked);
+}
+
 #ifdef CONFIG_COMPAT
 static long linereq_ioctl_compat(struct file *file, unsigned int cmd,
 				 unsigned long arg)
@@ -1410,8 +1472,8 @@ static long linereq_ioctl_compat(struct file *file, unsigned int cmd,
 }
 #endif
 
-static __poll_t linereq_poll(struct file *file,
-			    struct poll_table_struct *wait)
+static __poll_t linereq_poll_unlocked(struct file *file,
+				      struct poll_table_struct *wait)
 {
 	struct linereq *lr = file->private_data;
 	__poll_t events = 0;
@@ -1428,10 +1490,16 @@ static __poll_t linereq_poll(struct file *file,
 	return events;
 }
 
-static ssize_t linereq_read(struct file *file,
-			    char __user *buf,
-			    size_t count,
-			    loff_t *f_ps)
+static __poll_t linereq_poll(struct file *file,
+			     struct poll_table_struct *wait)
+{
+	struct linereq *lr = file->private_data;
+
+	return call_poll_locked(file, wait, lr->gdev, linereq_poll_unlocked);
+}
+
+static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
+				     size_t count, loff_t *f_ps)
 {
 	struct linereq *lr = file->private_data;
 	struct gpio_v2_line_event le;
@@ -1485,6 +1553,15 @@ static ssize_t linereq_read(struct file *file,
 	return bytes_read;
 }
 
+static ssize_t linereq_read(struct file *file, char __user *buf,
+			    size_t count, loff_t *f_ps)
+{
+	struct linereq *lr = file->private_data;
+
+	return call_read_locked(file, buf, count, f_ps, lr->gdev,
+				linereq_read_unlocked);
+}
+
 static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
@@ -1722,8 +1799,8 @@ struct lineevent_state {
 	(GPIOEVENT_REQUEST_RISING_EDGE | \
 	GPIOEVENT_REQUEST_FALLING_EDGE)
 
-static __poll_t lineevent_poll(struct file *file,
-			       struct poll_table_struct *wait)
+static __poll_t lineevent_poll_unlocked(struct file *file,
+					struct poll_table_struct *wait)
 {
 	struct lineevent_state *le = file->private_data;
 	__poll_t events = 0;
@@ -1739,15 +1816,21 @@ static __poll_t lineevent_poll(struct file *file,
 	return events;
 }
 
+static __poll_t lineevent_poll(struct file *file,
+			       struct poll_table_struct *wait)
+{
+	struct lineevent_state *le = file->private_data;
+
+	return call_poll_locked(file, wait, le->gdev, lineevent_poll_unlocked);
+}
+
 struct compat_gpioeevent_data {
 	compat_u64	timestamp;
 	u32		id;
 };
 
-static ssize_t lineevent_read(struct file *file,
-			      char __user *buf,
-			      size_t count,
-			      loff_t *f_ps)
+static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
+				       size_t count, loff_t *f_ps)
 {
 	struct lineevent_state *le = file->private_data;
 	struct gpioevent_data ge;
@@ -1815,6 +1898,15 @@ static ssize_t lineevent_read(struct file *file,
 	return bytes_read;
 }
 
+static ssize_t lineevent_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *f_ps)
+{
+	struct lineevent_state *le = file->private_data;
+
+	return call_read_locked(file, buf, count, f_ps, le->gdev,
+				lineevent_read_unlocked);
+}
+
 static void lineevent_free(struct lineevent_state *le)
 {
 	if (le->irq)
@@ -1832,8 +1924,8 @@ static int lineevent_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static long lineevent_ioctl(struct file *file, unsigned int cmd,
-			    unsigned long arg)
+static long lineevent_ioctl_unlocked(struct file *file, unsigned int cmd,
+				     unsigned long arg)
 {
 	struct lineevent_state *le = file->private_data;
 	void __user *ip = (void __user *)arg;
@@ -1864,6 +1956,15 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
 	return -EINVAL;
 }
 
+static long lineevent_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct lineevent_state *le = file->private_data;
+
+	return call_ioctl_locked(file, cmd, arg, le->gdev,
+				 lineevent_ioctl_unlocked);
+}
+
 #ifdef CONFIG_COMPAT
 static long lineevent_ioctl_compat(struct file *file, unsigned int cmd,
 				   unsigned long arg)
@@ -2422,8 +2523,8 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static __poll_t lineinfo_watch_poll(struct file *file,
-				    struct poll_table_struct *pollt)
+static __poll_t lineinfo_watch_poll_unlocked(struct file *file,
+					     struct poll_table_struct *pollt)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
 	__poll_t events = 0;
@@ -2440,8 +2541,17 @@ static __poll_t lineinfo_watch_poll(struct file *file,
 	return events;
 }
 
-static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
-				   size_t count, loff_t *off)
+static __poll_t lineinfo_watch_poll(struct file *file,
+				    struct poll_table_struct *pollt)
+{
+	struct gpio_chardev_data *cdev = file->private_data;
+
+	return call_poll_locked(file, pollt, cdev->gdev,
+				lineinfo_watch_poll_unlocked);
+}
+
+static ssize_t lineinfo_watch_read_unlocked(struct file *file, char __user *buf,
+					    size_t count, loff_t *off)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
 	struct gpio_v2_line_info_changed event;
@@ -2519,6 +2629,15 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 	return bytes_read;
 }
 
+static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
+				   size_t count, loff_t *off)
+{
+	struct gpio_chardev_data *cdev = file->private_data;
+
+	return call_read_locked(file, buf, count, off, cdev->gdev,
+				lineinfo_watch_read_unlocked);
+}
+
 /**
  * gpio_chrdev_open() - open the chardev for ioctl operations
  * @inode: inode for this chardev
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4756ea08894f..e0e73bd756ca 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -731,6 +731,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->notifier);
+	init_rwsem(&gdev->sem);
 
 #ifdef CONFIG_PINCTRL
 	INIT_LIST_HEAD(&gdev->pin_ranges);
@@ -865,6 +866,8 @@ void gpiochip_remove(struct gpio_chip *gc)
 	unsigned long	flags;
 	unsigned int	i;
 
+	down_write(&gdev->sem);
+
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gdev);
 	gpiochip_free_hogs(gc);
@@ -899,6 +902,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	 * gone.
 	 */
 	gcdev_unregister(gdev);
+	up_write(&gdev->sem);
 	put_device(&gdev->dev);
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index d900ecdbac46..9ad68a0adf4a 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cdev.h>
+#include <linux/rwsem.h>
 
 #define GPIOCHIP_NAME	"gpiochip"
 
@@ -39,6 +40,9 @@
  * @list: links gpio_device:s together for traversal
  * @notifier: used to notify subscribers about lines being requested, released
  *            or reconfigured
+ * @sem: protects the structure from a NULL-pointer dereference of @chip by
+ *       user-space operations when the device gets unregistered during
+ *       a hot-unplug event
  * @pin_ranges: range of pins served by the GPIO driver
  *
  * This state container holds most of the runtime variable data
@@ -60,6 +64,7 @@ struct gpio_device {
 	void			*data;
 	struct list_head        list;
 	struct blocking_notifier_head notifier;
+	struct rw_semaphore	sem;
 
 #ifdef CONFIG_PINCTRL
 	/*
-- 
2.37.2

