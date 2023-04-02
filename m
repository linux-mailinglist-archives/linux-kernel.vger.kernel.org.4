Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFACE6D39A3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjDBR7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjDBR7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F111012845
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 10:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33C01612D6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 17:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B43C433D2;
        Sun,  2 Apr 2023 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680458357;
        bh=leWIQAXQz3QXHiAX/iTqJSpy4ZNlpuecBAdl9KGTU0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcGT+fPDhJJRkEUFgUkTykT3Go2qmi2Tpjn+UO/WIpsa7NhIcSNZ2WUx1b15ToNJG
         +cepNiUJwjgf5v7sNQyh5GHSIiqZM7GA1MfEwxeHCit4u2b0YrodSpEr99nrbtLPdD
         Vwi+wYAxeVk2GyhoZiaZjjbvxIUjSM26OM9/4ltM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/5] tty: make tty_class a static const structure
Date:   Sun,  2 Apr 2023 19:58:50 +0200
Message-Id: <2023040250-landowner-unfitted-11f4@gregkh>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <2023040244-duffel-pushpin-f738@gregkh>
References: <2023040244-duffel-pushpin-f738@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines:  138
X-Developer-Signature: v=1; a=openpgp-sha256; l=5137; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=leWIQAXQz3QXHiAX/iTqJSpy4ZNlpuecBAdl9KGTU0A=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmah6IqND1XreO+xpnhz5ejk/vBRl0uk70zS7Nrr5xJ7 P3MFa0dsSwMgkwMsmKKLF+28RzdX3FI0cvQ9jTMHFYmkCEMXJwCMJF7ZxgWzG9ce+y4pZpbwDSj /dN/Ptf78UE+iGE2605l854j4Vv9Fy8t3Pb5qbV4mtYKAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, move the tty_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Jiri and Ilpo, this is part of the larger driver-core changes to make it
possible to move struct class into read-only memory and is used as proof
that this all works properly.  I'll take it throught the driver-core
tree as it shoudn't conflict with any tty.git changes.

 drivers/tty/pty.c    |  2 +-
 drivers/tty/tty_io.c | 24 +++++++++++-------------
 drivers/tty/vt/vt.c  |  2 +-
 include/linux/tty.h  |  2 +-
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 07394fdaf522..2b1c8ab99dba 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -931,7 +931,7 @@ static void __init unix98_pty_init(void)
 	if (cdev_add(&ptmx_cdev, MKDEV(TTYAUX_MAJOR, 2), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
 		panic("Couldn't register /dev/ptmx driver");
-	device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
+	device_create(&tty_class, NULL, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
 }
 
 #else
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1382d9050ce8..44e0d53aa0b8 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3070,7 +3070,7 @@ static struct device *tty_get_device(struct tty_struct *tty)
 {
 	dev_t devt = tty_devnum(tty);
 
-	return class_find_device_by_devt(tty_class, devt);
+	return class_find_device_by_devt(&tty_class, devt);
 }
 
 
@@ -3143,8 +3143,6 @@ int tty_put_char(struct tty_struct *tty, unsigned char ch)
 }
 EXPORT_SYMBOL_GPL(tty_put_char);
 
-struct class *tty_class;
-
 static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
 		unsigned int index, unsigned int count)
 {
@@ -3239,7 +3237,7 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 		return ERR_PTR(-ENOMEM);
 
 	dev->devt = devt;
-	dev->class = tty_class;
+	dev->class = &tty_class;
 	dev->parent = device;
 	dev->release = tty_device_create_release;
 	dev_set_name(dev, "%s", name);
@@ -3294,8 +3292,7 @@ EXPORT_SYMBOL_GPL(tty_register_device_attr);
  */
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
-	device_destroy(tty_class,
-		MKDEV(driver->major, driver->minor_start) + index);
+	device_destroy(&tty_class, MKDEV(driver->major, driver->minor_start) + index);
 	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
 		cdev_del(driver->cdevs[index]);
 		driver->cdevs[index] = NULL;
@@ -3510,13 +3507,14 @@ static char *tty_devnode(const struct device *dev, umode_t *mode)
 	return NULL;
 }
 
+const struct class tty_class = {
+	.name		= "tty",
+	.devnode	= tty_devnode,
+};
+
 static int __init tty_class_init(void)
 {
-	tty_class = class_create("tty");
-	if (IS_ERR(tty_class))
-		return PTR_ERR(tty_class);
-	tty_class->devnode = tty_devnode;
-	return 0;
+	return class_register(&tty_class);
 }
 
 postcore_initcall(tty_class_init);
@@ -3643,13 +3641,13 @@ int __init tty_init(void)
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
 		panic("Couldn't register /dev/tty driver\n");
-	device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
+	device_create(&tty_class, NULL, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
 
 	cdev_init(&console_cdev, &console_fops);
 	if (cdev_add(&console_cdev, MKDEV(TTYAUX_MAJOR, 1), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
 		panic("Couldn't register /dev/console driver\n");
-	consdev = device_create_with_groups(tty_class, NULL,
+	consdev = device_create_with_groups(&tty_class, NULL,
 					    MKDEV(TTYAUX_MAJOR, 1), NULL,
 					    cons_dev_groups, "console");
 	if (IS_ERR(consdev))
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5496bf4b76ec..02f4b6be8584 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3539,7 +3539,7 @@ int __init vty_init(const struct file_operations *console_fops)
 	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
 		panic("Couldn't register /dev/tty0 driver\n");
-	tty0dev = device_create_with_groups(tty_class, NULL,
+	tty0dev = device_create_with_groups(&tty_class, NULL,
 					    MKDEV(TTY_MAJOR, 0), NULL,
 					    vt_dev_groups, "tty0");
 	if (IS_ERR(tty0dev))
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 093935e97f42..121eb4b0d325 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -387,7 +387,7 @@ extern struct ktermios tty_std_termios;
 
 int vcs_init(void);
 
-extern struct class *tty_class;
+extern const struct class tty_class;
 
 /**
  *	tty_kref_get		-	get a tty reference
-- 
2.40.0

