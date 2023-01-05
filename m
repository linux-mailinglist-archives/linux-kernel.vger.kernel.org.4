Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A660765EAD5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjAEMlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjAEMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:41:11 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF5130A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:41:08 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o15so27901968wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mE6v31ZZ0E7oy+OxwP/3qLKCpkH38/LEX5bi/JWcPpw=;
        b=ISRv+h7juXHTqYp3y1UgeXJZQePwb4ygyPPIZJjxYN/vKNjuRkuStN+CksM+Mew8Zr
         SX8Y89KF1G5f4H5gtA/a3Z4Prd3ODlKqNKCUsOcLnCd66P5M4d5v4ulwxfrihH8Xjrw5
         iSPfS2FmvtO7C9csfEpEfBTZBatTq18clmfZeieQFgCD51/4CzK20MCMiek5kBY5b7sq
         aKvIhEDnvKMeiPQQZREJ2eKWb/rgb48nMCjDUQ7ZdR4w7G5pXpq6IN2b6BpumpHWtZgK
         4X50varBbauB6A0InRc/Y/AN3Uwiq6nV97q5hT2UjPa3/Exk4nuJcvarMFgOWyGNW2ta
         htCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mE6v31ZZ0E7oy+OxwP/3qLKCpkH38/LEX5bi/JWcPpw=;
        b=yv6VM31ggz2O3A4nPDUHGnJTn9fT/UNiJ/HVwQnpae1DxRBS1Ts3FM/9xf4k4f6Sa6
         ebbNDBsGZrPgUIwSvoe8lxZo7nDXuen503o5vydkHRZH/IfsvWHZgMrtKZtfUiVDjLw1
         YH8hDZGor+0FJ2vRkXH2bKPvz7razW20D+7jmqFYUuoaT6LT2c0HhFRCQVTTRUh+nute
         lVahGfG8y4moDd2MRt3VVgGMR7r7sKd9k4E9YtEwXxypfGjxbodc6eJdpdQWBWFmbaf8
         H7tLYh0zaSDGm83e8GpBXm5dmz/YuMp+IFEI1WYCsVfwjaV/jwAIShipO8xhcqMTJ7Ub
         ClTg==
X-Gm-Message-State: AFqh2krq+nYv0Gd4Sw3pVBq6JKlrDpfy80W4lDSAhTHnNMQ9ayw1qCxI
        hMK4PRd+xxOhcJuYGOlDd1DVNPlfm6ccArT9
X-Google-Smtp-Source: AMrXdXuAxloSp3gFtgCQktpymTTqK+iVZhI0eQWrCdYEZ5d15gm+znCn2Gd59w7mIdU7uothWv9ohg==
X-Received: by 2002:a05:600c:4da0:b0:3d2:3a53:2cd6 with SMTP id v32-20020a05600c4da000b003d23a532cd6mr36715161wmp.9.1672922466802;
        Thu, 05 Jan 2023 04:41:06 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:101:3196:3a40:6416])
        by smtp.gmail.com with ESMTPSA id m6-20020a1c2606000000b003b47e75b401sm2338153wmm.37.2023.01.05.04.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:41:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] spi: spidev: fix a race condition when accessing spidev->spi
Date:   Thu,  5 Jan 2023 13:40:59 +0100
Message-Id: <20230105124100.185542-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
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

There's a spinlock in place that is taken in file_operations callbacks
whenever we check if spidev->spi is still alive (not null). It's also
taken when spidev->spi is set to NULL in remove().

This however doesn't protect the code against driver unbind event while
one of the syscalls is still in progress. To that end we need a lock taken
continuously as long as we may still access spidev->spi. As both the file
ops and the remove callback are never called from interrupt context, we
can replace the spinlock with a sleeping lock. Using an RW semaphore
allows the syscalls to run concurrently unless protected otherwise. We
take it for writing only when setting spidev->spi to null, while
everywhere else it's only taken for reading. This assures that it will
be dropped only once all currently executed syscalls have returned.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/spidev.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 6313e7d0cdf8..b71620f64ec9 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
+#include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
 
@@ -68,7 +69,7 @@ static_assert(N_SPI_MINORS > 0 && N_SPI_MINORS <= 256);
 
 struct spidev_data {
 	dev_t			devt;
-	spinlock_t		spi_lock;
+	struct rw_semaphore	sem;
 	struct spi_device	*spi;
 	struct list_head	device_entry;
 
@@ -95,9 +96,8 @@ spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 	int status;
 	struct spi_device *spi;
 
-	spin_lock_irq(&spidev->spi_lock);
+	down_read(&spidev->sem);
 	spi = spidev->spi;
-	spin_unlock_irq(&spidev->spi_lock);
 
 	if (spi == NULL)
 		status = -ESHUTDOWN;
@@ -107,6 +107,7 @@ spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 	if (status == 0)
 		status = message->actual_length;
 
+	up_read(&spidev->sem);
 	return status;
 }
 
@@ -359,12 +360,12 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	 * we issue this ioctl.
 	 */
 	spidev = filp->private_data;
-	spin_lock_irq(&spidev->spi_lock);
+	down_read(&spidev->sem);
 	spi = spi_dev_get(spidev->spi);
-	spin_unlock_irq(&spidev->spi_lock);
-
-	if (spi == NULL)
+	if (spi == NULL) {
+		up_read(&spidev->sem);
 		return -ESHUTDOWN;
+	}
 
 	/* use the buffer lock here for triple duty:
 	 *  - prevent I/O (from us) so calling spi_setup() is safe;
@@ -508,6 +509,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	mutex_unlock(&spidev->buf_lock);
 	spi_dev_put(spi);
+	up_read(&spidev->sem);
 	return retval;
 }
 
@@ -529,12 +531,12 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 	 * we issue this ioctl.
 	 */
 	spidev = filp->private_data;
-	spin_lock_irq(&spidev->spi_lock);
+	down_read(&spidev->sem);
 	spi = spi_dev_get(spidev->spi);
-	spin_unlock_irq(&spidev->spi_lock);
-
-	if (spi == NULL)
+	if (spi == NULL) {
+		up_read(&spidev->sem);
 		return -ESHUTDOWN;
+	}
 
 	/* SPI_IOC_MESSAGE needs the buffer locked "normally" */
 	mutex_lock(&spidev->buf_lock);
@@ -561,6 +563,7 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 done:
 	mutex_unlock(&spidev->buf_lock);
 	spi_dev_put(spi);
+	up_read(&spidev->sem);
 	return retval;
 }
 
@@ -640,10 +643,10 @@ static int spidev_release(struct inode *inode, struct file *filp)
 	spidev = filp->private_data;
 	filp->private_data = NULL;
 
-	spin_lock_irq(&spidev->spi_lock);
+	down_read(&spidev->sem);
 	/* ... after we unbound from the underlying device? */
 	dofree = (spidev->spi == NULL);
-	spin_unlock_irq(&spidev->spi_lock);
+	up_read(&spidev->sem);
 
 	/* last close? */
 	spidev->users--;
@@ -776,7 +779,7 @@ static int spidev_probe(struct spi_device *spi)
 
 	/* Initialize the driver data */
 	spidev->spi = spi;
-	spin_lock_init(&spidev->spi_lock);
+	init_rwsem(&spidev->sem);
 	mutex_init(&spidev->buf_lock);
 
 	INIT_LIST_HEAD(&spidev->device_entry);
@@ -821,9 +824,9 @@ static void spidev_remove(struct spi_device *spi)
 	/* prevent new opens */
 	mutex_lock(&device_list_lock);
 	/* make sure ops on existing fds can abort cleanly */
-	spin_lock_irq(&spidev->spi_lock);
+	down_write(&spidev->sem);
 	spidev->spi = NULL;
-	spin_unlock_irq(&spidev->spi_lock);
+	up_write(&spidev->sem);
 
 	list_del(&spidev->device_entry);
 	device_destroy(spidev_class, spidev->devt);
-- 
2.37.2

