Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717FB64841B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLIOtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLIOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:49:12 -0500
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F179421A1;
        Fri,  9 Dec 2022 06:49:08 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 714CE7D47F;
        Fri,  9 Dec 2022 17:24:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1670595848;
        bh=IOAnolxy3IZUwIcxvxaNi6nzmb8eykgwoZz1C5UIgjE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZXu6CQlf++EznsbpjRgeaAhxti9TExLR4MPvnUXsn3A+1ptKVR+BsrNq0PB0GRioJ
         InP/EelUtLTVuT4EvEcrxoOtRhg9cJ3TxAYoYs8SEOS4ot39ZALfNimMT1vf5YH+lM
         f9/u7b44cTMiag4sN7ipxtmQHBmqrKxM2NNiPA/uudr5QZUMhpF+GG8d79RzZZSDpn
         v+65Yh8wU/IzgH+NR45DZaeAmiTh0o4WST3+KtCKl3OLYz4vrFLnftQleIzQkFOOay
         qxAteUKdRjc8MbWHoAOrs19cnkjTS1kmuH7Y3PQqophJVrDBb/mMYWL2sDYNCwdDmz
         WQ91+Dcs0PVqQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:24:04 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 08/21] block, blksnap: interaction with sysfs
Date:   Fri, 9 Dec 2022 15:23:18 +0100
Message-ID: <20221209142331.26395-9-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209142331.26395-1-sergei.shtepa@veeam.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031556627C62
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides creation of a class file /sys/class/blksnap and a device file
/dev/blksnap for module management.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/sysfs.c | 80 +++++++++++++++++++++++++++++++++++
 drivers/block/blksnap/sysfs.h |  7 +++
 2 files changed, 87 insertions(+)
 create mode 100644 drivers/block/blksnap/sysfs.c
 create mode 100644 drivers/block/blksnap/sysfs.h

diff --git a/drivers/block/blksnap/sysfs.c b/drivers/block/blksnap/sysfs.c
new file mode 100644
index 000000000000..6f53c4217d6c
--- /dev/null
+++ b/drivers/block/blksnap/sysfs.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-sysfs: " fmt
+
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/sysfs.h>
+#include <linux/device.h>
+#include <uapi/linux/blksnap.h>
+#include "sysfs.h"
+#include "ctrl.h"
+
+static ssize_t major_show(struct class *class, struct class_attribute *attr,
+			  char *buf)
+{
+	sprintf(buf, "%d", get_blk_snap_major());
+	return strlen(buf);
+}
+
+/* Declare class_attr_major */
+CLASS_ATTR_RO(major);
+
+static struct class *blk_snap_class;
+
+static struct device *blk_snap_device;
+
+int sysfs_initialize(void)
+{
+	struct device *dev;
+	int res;
+
+	blk_snap_class = class_create(THIS_MODULE, THIS_MODULE->name);
+	if (IS_ERR(blk_snap_class)) {
+		res = PTR_ERR(blk_snap_class);
+
+		pr_err("Bad class create. errno=%d\n", abs(res));
+		return res;
+	}
+
+	pr_info("Create 'major' sysfs attribute\n");
+	res = class_create_file(blk_snap_class, &class_attr_major);
+	if (res) {
+		pr_err("Failed to create 'major' sysfs file\n");
+
+		class_destroy(blk_snap_class);
+		blk_snap_class = NULL;
+		return res;
+	}
+
+	dev = device_create(blk_snap_class, NULL,
+			    MKDEV(get_blk_snap_major(), 0), NULL,
+			    THIS_MODULE->name);
+	if (IS_ERR(dev)) {
+		res = PTR_ERR(dev);
+		pr_err("Failed to create device, errno=%d\n", abs(res));
+
+		class_remove_file(blk_snap_class, &class_attr_major);
+		class_destroy(blk_snap_class);
+		blk_snap_class = NULL;
+		return res;
+	}
+
+	blk_snap_device = dev;
+	return res;
+}
+
+void sysfs_finalize(void)
+{
+	pr_info("Cleanup sysfs\n");
+
+	if (blk_snap_device) {
+		device_unregister(blk_snap_device);
+		blk_snap_device = NULL;
+	}
+
+	if (blk_snap_class != NULL) {
+		class_remove_file(blk_snap_class, &class_attr_major);
+		class_destroy(blk_snap_class);
+		blk_snap_class = NULL;
+	}
+}
diff --git a/drivers/block/blksnap/sysfs.h b/drivers/block/blksnap/sysfs.h
new file mode 100644
index 000000000000..5fc200d36789
--- /dev/null
+++ b/drivers/block/blksnap/sysfs.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_SYSFS_H
+#define __BLK_SNAP_SYSFS_H
+
+int sysfs_initialize(void);
+void sysfs_finalize(void);
+#endif /* __BLK_SNAP_SYSFS_H */
-- 
2.20.1

