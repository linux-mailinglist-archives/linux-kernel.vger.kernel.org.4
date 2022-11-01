Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDCD6153E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKAVPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiKAVP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:15:28 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A841EEC1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:15:13 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyanoKD2rsfCIpybIoWfIz; Tue, 01 Nov 2022 22:15:12 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:15:12 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-usb@vger.kernel.org
Subject: [PATCH 08/30] usb: gadget: Use kstrtobool() instead of strtobool()
Date:   Tue,  1 Nov 2022 22:13:56 +0100
Message-Id: <09bc980d8432a4b5f7d88388ec0df5b085583139.1667336095.git.christophe.jaillet@wanadoo.fr>
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

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 drivers/usb/gadget/configfs.c                | 3 ++-
 drivers/usb/gadget/function/f_mass_storage.c | 3 ++-
 drivers/usb/gadget/function/storage_common.c | 9 +++++----
 drivers/usb/gadget/function/u_serial.c       | 3 ++-
 drivers/usb/gadget/legacy/serial.c           | 3 ++-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 3a6b4926193e..96121d1c8df4 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/kstrtox.h>
 #include <linux/nls.h>
 #include <linux/usb/composite.h>
 #include <linux/usb/gadget_configfs.h>
@@ -800,7 +801,7 @@ static ssize_t os_desc_use_store(struct config_item *item, const char *page,
 	bool use;
 
 	mutex_lock(&gi->lock);
-	ret = strtobool(page, &use);
+	ret = kstrtobool(page, &use);
 	if (!ret) {
 		gi->use_os_desc = use;
 		ret = len;
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 3abf7f586e2a..3a30feb47073 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -176,6 +176,7 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/kstrtox.h>
 #include <linux/kthread.h>
 #include <linux/sched/signal.h>
 #include <linux/limits.h>
@@ -3387,7 +3388,7 @@ static ssize_t fsg_opts_stall_store(struct config_item *item, const char *page,
 		return -EBUSY;
 	}
 
-	ret = strtobool(page, &stall);
+	ret = kstrtobool(page, &stall);
 	if (!ret) {
 		opts->common->can_stall = stall;
 		ret = len;
diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
index 208c6a92780a..2a4163b0f6fe 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -23,6 +23,7 @@
 #include <linux/blkdev.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/kstrtox.h>
 #include <linux/usb/composite.h>
 
 #include "storage_common.h"
@@ -396,7 +397,7 @@ ssize_t fsg_store_ro(struct fsg_lun *curlun, struct rw_semaphore *filesem,
 	ssize_t		rc;
 	bool		ro;
 
-	rc = strtobool(buf, &ro);
+	rc = kstrtobool(buf, &ro);
 	if (rc)
 		return rc;
 
@@ -419,7 +420,7 @@ ssize_t fsg_store_nofua(struct fsg_lun *curlun, const char *buf, size_t count)
 	bool		nofua;
 	int		ret;
 
-	ret = strtobool(buf, &nofua);
+	ret = kstrtobool(buf, &nofua);
 	if (ret)
 		return ret;
 
@@ -470,7 +471,7 @@ ssize_t fsg_store_cdrom(struct fsg_lun *curlun, struct rw_semaphore *filesem,
 	bool		cdrom;
 	int		ret;
 
-	ret = strtobool(buf, &cdrom);
+	ret = kstrtobool(buf, &cdrom);
 	if (ret)
 		return ret;
 
@@ -493,7 +494,7 @@ ssize_t fsg_store_removable(struct fsg_lun *curlun, const char *buf,
 	bool		removable;
 	int		ret;
 
-	ret = strtobool(buf, &removable);
+	ret = kstrtobool(buf, &removable);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 7538279f9817..840626e064e1 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -24,6 +24,7 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/console.h>
+#include <linux/kstrtox.h>
 #include <linux/kthread.h>
 #include <linux/workqueue.h>
 #include <linux/kfifo.h>
@@ -1070,7 +1071,7 @@ ssize_t gserial_set_console(unsigned char port_num, const char *page, size_t cou
 	bool enable;
 	int ret;
 
-	ret = strtobool(page, &enable);
+	ret = kstrtobool(page, &enable);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/gadget/legacy/serial.c b/drivers/usb/gadget/legacy/serial.c
index dcd3a6603d90..4974bee6049a 100644
--- a/drivers/usb/gadget/legacy/serial.c
+++ b/drivers/usb/gadget/legacy/serial.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -109,7 +110,7 @@ static int enable_set(const char *s, const struct kernel_param *kp)
 	if (!s)	/* called for no-arg enable == default */
 		return 0;
 
-	ret = strtobool(s, &do_enable);
+	ret = kstrtobool(s, &do_enable);
 	if (ret || enable == do_enable)
 		return ret;
 
-- 
2.34.1

