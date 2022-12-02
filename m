Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3BA6408EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiLBPFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiLBPEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:04:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF00D49DB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:04:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bs21so8207141wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 07:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT+rELkcvo2pAdmeaC5DliF/SIqlhen5chDTS+wFRn0=;
        b=eXBnnXOCXLfgK72gyFrTJ7GhFGDlAYQQr+aMyTCQw38QtxCnmP1Mjph+M2oyjKpFw2
         BZrLD1St5Ah3BuBHEdL6MKHGSsdULnFZDrcUZ//eQ0Zgp99sVLU/RZWJI2VnygBLYnJI
         CyfRyzUVmONT46NhL9w7IgbJWOtZAKPeWsV+motrRJL3cOJiAAOEwiStrSWtycakq8Ko
         romXI6B2O++EIJD6Ox2sKo+p/2NLsF4gHZomnsxooRQdGBMKbM/C5zCP7HfdRIX37Fae
         kSrKSHqLOz7nkCXKu7Chufmgx8tK487oPQA1X1e5eMfrdrP4OJoltpGdMLR0SWv9fIQk
         s/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PT+rELkcvo2pAdmeaC5DliF/SIqlhen5chDTS+wFRn0=;
        b=KyPFOb66HXzRjpWr5wHfUFu+nlfpiucdphLagYxpEHKfM5UNPVu3P4eW01aziiMeqh
         YVOenZBu9sKjpMgBBv+Plf8ybQbAurNP8SnKzqwXFgscfIjKSaPoQIs2m1ddFZx4m7Qx
         YmuNFCnGCclo1FGmk2F9EtOdHM9G1yGq0qyYFGeg2+Qnyqa1sxekn6q9dFka8iW4ApWK
         hjia07s6c6k0r5TwPH2xoyenoRdqk2+DPHTQe4dbhMc2sZdHqKtHYWF4v0mGj2GmlZfj
         oS+GczzT+cyRsqWNQwnCQMF25zhaOawglPMaRYqFZ5ZH+09xbM7qvsEchlh08wOdOMQB
         ADSw==
X-Gm-Message-State: ANoB5pli+oYqqd79HeXfLYeh5zwmkkfeP87JK81INMf5Cb5RQpy+S7zw
        4XjJ97Sp4xop7jA8rPuRjB1W46Opek2wNpD8
X-Google-Smtp-Source: AA0mqf4SqM3Hlvr3Fx0JliRrhwitXhmROjGp3DbGOyJ8FdSCYb30EjudE45KXoP7bZVlsdzRDNjg9A==
X-Received: by 2002:a05:6000:181:b0:241:c6f9:3e5a with SMTP id p1-20020a056000018100b00241c6f93e5amr35384170wrx.157.1669993492024;
        Fri, 02 Dec 2022 07:04:52 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:29a4:6f04:ddb1:1ed7])
        by smtp.gmail.com with ESMTPSA id v6-20020adfe286000000b00241f467f888sm7218237wri.74.2022.12.02.07.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:04:51 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nick Hainke <vincent@systemli.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v7 2/2] gpiolib: protect the GPIO device against being dropped while in use by user-space
Date:   Fri,  2 Dec 2022 16:04:44 +0100
Message-Id: <20221202150444.244313-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221202150444.244313-1-brgl@bgdev.pl>
References: <20221202150444.244313-1-brgl@bgdev.pl>
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
[Nick: fixed a build failure with CDEV_V1 disabled]
Co-authored-by: Nick Hainke <vincent@systemli.org>
Reviewed-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 180 +++++++++++++++++++++++++++++++-----
 drivers/gpio/gpiolib.c      |   4 +
 drivers/gpio/gpiolib.h      |   5 +
 3 files changed, 164 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 6fa5c2169985..c8138ae382e8 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -55,6 +55,53 @@ static_assert(IS_ALIGNED(sizeof(struct gpio_v2_line_values), 8));
  * interface to gpiolib GPIOs via ioctl()s.
  */
 
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
+	if (!down_read_trylock(&gdev->sem))
+		return EPOLLHUP | EPOLLERR;
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
+	if (!down_read_trylock(&gdev->sem))
+		return -ENODEV;
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
+	if (!down_read_trylock(&gdev->sem))
+		return -ENODEV;
+	ret = func(file, buf, count, f_ps);
+	up_read(&gdev->sem);
+
+	return ret;
+}
+
 /*
  * GPIO line handle management
  */
@@ -191,8 +238,8 @@ static long linehandle_set_config(struct linehandle_state *lh,
 	return 0;
 }
 
-static long linehandle_ioctl(struct file *file, unsigned int cmd,
-			     unsigned long arg)
+static long linehandle_ioctl_unlocked(struct file *file, unsigned int cmd,
+				      unsigned long arg)
 {
 	struct linehandle_state *lh = file->private_data;
 	void __user *ip = (void __user *)arg;
@@ -250,6 +297,15 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
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
@@ -1381,8 +1437,8 @@ static long linereq_set_config(struct linereq *lr, void __user *ip)
 	return ret;
 }
 
-static long linereq_ioctl(struct file *file, unsigned int cmd,
-			  unsigned long arg)
+static long linereq_ioctl_unlocked(struct file *file, unsigned int cmd,
+				   unsigned long arg)
 {
 	struct linereq *lr = file->private_data;
 	void __user *ip = (void __user *)arg;
@@ -1402,6 +1458,15 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
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
@@ -1410,8 +1475,8 @@ static long linereq_ioctl_compat(struct file *file, unsigned int cmd,
 }
 #endif
 
-static __poll_t linereq_poll(struct file *file,
-			    struct poll_table_struct *wait)
+static __poll_t linereq_poll_unlocked(struct file *file,
+				      struct poll_table_struct *wait)
 {
 	struct linereq *lr = file->private_data;
 	__poll_t events = 0;
@@ -1428,10 +1493,16 @@ static __poll_t linereq_poll(struct file *file,
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
@@ -1485,6 +1556,15 @@ static ssize_t linereq_read(struct file *file,
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
@@ -1722,8 +1802,8 @@ struct lineevent_state {
 	(GPIOEVENT_REQUEST_RISING_EDGE | \
 	GPIOEVENT_REQUEST_FALLING_EDGE)
 
-static __poll_t lineevent_poll(struct file *file,
-			       struct poll_table_struct *wait)
+static __poll_t lineevent_poll_unlocked(struct file *file,
+					struct poll_table_struct *wait)
 {
 	struct lineevent_state *le = file->private_data;
 	__poll_t events = 0;
@@ -1739,15 +1819,21 @@ static __poll_t lineevent_poll(struct file *file,
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
@@ -1815,6 +1901,15 @@ static ssize_t lineevent_read(struct file *file,
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
@@ -1832,8 +1927,8 @@ static int lineevent_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static long lineevent_ioctl(struct file *file, unsigned int cmd,
-			    unsigned long arg)
+static long lineevent_ioctl_unlocked(struct file *file, unsigned int cmd,
+				     unsigned long arg)
 {
 	struct lineevent_state *le = file->private_data;
 	void __user *ip = (void __user *)arg;
@@ -1864,6 +1959,15 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
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
@@ -2422,8 +2526,8 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static __poll_t lineinfo_watch_poll(struct file *file,
-				    struct poll_table_struct *pollt)
+static __poll_t lineinfo_watch_poll_unlocked(struct file *file,
+					     struct poll_table_struct *pollt)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
 	__poll_t events = 0;
@@ -2440,8 +2544,17 @@ static __poll_t lineinfo_watch_poll(struct file *file,
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
@@ -2519,6 +2632,15 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
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
@@ -2532,13 +2654,17 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	struct gpio_chardev_data *cdev;
 	int ret = -ENOMEM;
 
+	down_read(&gdev->sem);
+
 	/* Fail on open if the backing gpiochip is gone */
-	if (!gdev->chip)
-		return -ENODEV;
+	if (!gdev->chip) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
 
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
-		return -ENOMEM;
+		goto out_unlock;
 
 	cdev->watched_lines = bitmap_zalloc(gdev->chip->ngpio, GFP_KERNEL);
 	if (!cdev->watched_lines)
@@ -2561,6 +2687,8 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	if (ret)
 		goto out_unregister_notifier;
 
+	up_read(&gdev->sem);
+
 	return ret;
 
 out_unregister_notifier:
@@ -2570,6 +2698,8 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	bitmap_free(cdev->watched_lines);
 out_free_cdev:
 	kfree(cdev);
+out_unlock:
+	up_read(&gdev->sem);
 	return ret;
 }
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a70522aef355..5974cfc61b41 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -735,6 +735,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->notifier);
+	init_rwsem(&gdev->sem);
 
 #ifdef CONFIG_PINCTRL
 	INIT_LIST_HEAD(&gdev->pin_ranges);
@@ -875,6 +876,8 @@ void gpiochip_remove(struct gpio_chip *gc)
 	unsigned long	flags;
 	unsigned int	i;
 
+	down_write(&gdev->sem);
+
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gdev);
 	gpiochip_free_hogs(gc);
@@ -909,6 +912,7 @@ void gpiochip_remove(struct gpio_chip *gc)
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

