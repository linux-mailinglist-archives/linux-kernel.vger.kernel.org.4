Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94A9616900
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiKBQb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiKBQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:30 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F9A2DAA1;
        Wed,  2 Nov 2022 09:27:08 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 4FE044110A;
        Wed,  2 Nov 2022 11:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1667404319;
        bh=sMx+tCVloqWsGtoNfLLhf1sI9qkGg1iVULg5OTBOaq0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dKq1trBqhdpSVVwhwlGqx3mWdVRskpehqCIH5W/BxBI75zCCOsk8kwj4R3Ku8SS+Q
         w2pUZT4un3jANT/3ZkQBq228XA1W0JDJLqMElBTYtkJmOnhYWZjyYofXVpUiaDTE6L
         scOuDSgOCipWst72qNyGsZnw6Sou2Esg5wKATEs13hrn0lFsGm2x2fvD6nEnLLNroc
         Xyy83eztwmBEb2UqaseWh6f7xp+uxVdY9iQ4hsVxxrFTKaOZrQ1qNEcqbW49QXwJwL
         OlVQhZIHNQDN4A8cmIkbFcvXL/aMA6Nv8B6eATEjJljUiFtQDDTEpSiRehwEH6VYRD
         3J40Adw6nM52w==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 2 Nov 2022 16:51:21 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v1 05/17] block, blksnap: interaction with sysfs
Date:   Wed, 2 Nov 2022 16:50:49 +0100
Message-ID: <20221102155101.4550-6-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221102155101.4550-1-sergei.shtepa@veeam.com>
References: <20221102155101.4550-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155666726A
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides creation of a class file /sys/class/blksnap and a device file
/dev/blksnap for module management.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/sysfs.c | 79 +++++++++++++++++++++++++++++++++++
 drivers/block/blksnap/sysfs.h |  7 ++++
 2 files changed, 86 insertions(+)
 create mode 100644 drivers/block/blksnap/sysfs.c
 create mode 100644 drivers/block/blksnap/sysfs.h

diff --git a/drivers/block/blksnap/sysfs.c b/drivers/block/blksnap/sysfs.c
new file mode 100644
index 000000000000..fd20336a14c7
--- /dev/null
+++ b/drivers/block/blksnap/sysfs.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-sysfs: " fmt
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
+int sysfs_init(void)
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
+void sysfs_done(void)
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
index 000000000000..66ce9d1509af
--- /dev/null
+++ b/drivers/block/blksnap/sysfs.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_SNAP_SYSFS_H
+#define __BLK_SNAP_SYSFS_H
+
+int sysfs_init(void);
+void sysfs_done(void);
+#endif /* __BLK_SNAP_SYSFS_H */
-- 
2.20.1

