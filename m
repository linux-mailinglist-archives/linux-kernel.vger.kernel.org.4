Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B217A6310E9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiKSUpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiKSUoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:44:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5708E13D35
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 12:44:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E539460BA2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 20:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CCBC43144;
        Sat, 19 Nov 2022 20:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668890691;
        bh=+qLD/Tk2ZKcMqNy7BvCXDXY0lmH6jmR0kHJc5m1PAJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnsvhKmcmC5+c/9aj+z8Soh42zQS4XZqRVGb/WOK2xGHLquGW4vbr+1wVGXKbMIjj
         5Cu9AnLbtMXNkag1J08IxkdnfZva9KTZ8qhCDk4Q8QOLJCUSlF5wxN3Bu7KoWKqd9H
         4mFA2JxqEXY9HbPVmfK131bDfMAVAENC9ra8YDIsiCRrJOYhPU9K1V2BT98vVIlAzG
         Ysbq19GgWDtp1u6QU4vXNT4elOS4GGreHXAwiwPdEd/xEFzg851cuNRXxiR6ZkxG/S
         3H81QGtVGVJhQoOiggFvRK2lk9sGuxGvjpkjYBii+9smT1X1dmtFfocchidT9MCVgS
         mwhdq0j8XrHMA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Christopher Friedt <chrisfriedt@gmail.com>
Subject: [PATCH v4 1/4] drivers/accel: define kconfig and register a new major
Date:   Sat, 19 Nov 2022 22:44:32 +0200
Message-Id: <20221119204435.97113-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119204435.97113-1-ogabbay@kernel.org>
References: <20221119204435.97113-1-ogabbay@kernel.org>
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

Add a new Kconfig for the accel subsystem. The Kconfig currently
contains only the basic CONFIG_DRM_ACCEL option that will be used to
decide whether to compile the accel registration code. Therefore, the
kconfig option is defined as bool.

The accel code will be compiled as part of drm.ko and will be called
directly from the DRM core code. The reason we compile it as part of
drm.ko and not as a separate module is because of cyclic dependency
between drm.ko and the separate module (if it would have existed).
This is due to the fact that DRM core code calls accel functions and
vice-versa.

The accelerator devices will be exposed to the user space with a new,
dedicated major number - 261.

The accel init function registers the new major number as a char device
and create corresponding sysfs and debugfs root entries, similar to
what is done in DRM init function.

I added a new header called drm_accel.h to include/drm/, that will hold
the prototypes of the drm_accel.c functions. In case CONFIG_DRM_ACCEL
is set to 'N', that header will contain empty inline implementations of
those functions, to allow DRM core code to compile successfully
without dependency on CONFIG_DRM_ACCEL.

I Updated the MAINTAINERS file accordingly with the newly added folder
and I have taken the liberty to appropriate the dri-devel mailing list
and the dri-devel IRC channel for the accel subsystem.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Changes in v4:
 - Fix comment style
 - Remove useless goto
 - Fix indentation of major define
 - Move comment from next patch to this patch

 Documentation/admin-guide/devices.txt |  5 ++
 MAINTAINERS                           |  8 +++
 drivers/Kconfig                       |  2 +
 drivers/accel/Kconfig                 | 24 ++++++++
 drivers/accel/drm_accel.c             | 83 +++++++++++++++++++++++++++
 drivers/gpu/drm/Makefile              |  1 +
 include/drm/drm_accel.h               | 32 +++++++++++
 7 files changed, 155 insertions(+)
 create mode 100644 drivers/accel/Kconfig
 create mode 100644 drivers/accel/drm_accel.c
 create mode 100644 include/drm/drm_accel.h

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 9764d6edb189..06c525e01ea5 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -3080,6 +3080,11 @@
 		  ...
 		  255 = /dev/osd255	256th OSD Device

+ 261 char	Compute Acceleration Devices
+		  0 = /dev/accel/accel0	First acceleration device
+		  1 = /dev/accel/accel1	Second acceleration device
+		    ...
+
  384-511 char	RESERVED FOR DYNAMIC ASSIGNMENT
 		Character devices that request a dynamic allocation of major
 		number will take numbers starting from 511 and downward,
diff --git a/MAINTAINERS b/MAINTAINERS
index 178a7a383b5f..4d752aac3ec0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6831,6 +6831,14 @@ F:	include/drm/drm*
 F:	include/linux/vga*
 F:	include/uapi/drm/drm*

+DRM COMPUTE ACCELERATORS DRIVERS AND FRAMEWORK
+M:	Oded Gabbay <ogabbay@kernel.org>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+C:	irc://irc.oftc.net/dri-devel
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git
+F:	drivers/accel/
+
 DRM DRIVERS FOR ALLWINNER A10
 M:	Maxime Ripard <mripard@kernel.org>
 M:	Chen-Yu Tsai <wens@csie.org>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 19ee995bd0ae..968bd0a6fd78 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -99,6 +99,8 @@ source "drivers/media/Kconfig"

 source "drivers/video/Kconfig"

+source "drivers/accel/Kconfig"
+
 source "sound/Kconfig"

 source "drivers/hid/Kconfig"
diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
new file mode 100644
index 000000000000..c9ce849b2984
--- /dev/null
+++ b/drivers/accel/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Compute Acceleration device configuration
+#
+# This framework provides support for compute acceleration devices, such
+# as, but not limited to, Machine-Learning and Deep-Learning acceleration
+# devices
+#
+menuconfig DRM_ACCEL
+	bool "Compute Acceleration Framework"
+	depends on DRM
+	help
+	  Framework for device drivers of compute acceleration devices, such
+	  as, but not limited to, Machine-Learning and Deep-Learning
+	  acceleration devices.
+	  If you say Y here, you need to select the module that's right for
+	  your acceleration device from the list below.
+	  This framework is integrated with the DRM subsystem as compute
+	  accelerators and GPUs share a lot in common and can use almost the
+	  same infrastructure code.
+	  Having said that, acceleration devices will have a different
+	  major number than GPUs, and will be exposed to user-space using
+	  different device files, called accel/accel* (in /dev, sysfs
+	  and debugfs).
diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
new file mode 100644
index 000000000000..fac6ad6ac28e
--- /dev/null
+++ b/drivers/accel/drm_accel.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2022 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+
+#include <drm/drm_accel.h>
+#include <drm/drm_ioctl.h>
+#include <drm/drm_print.h>
+
+static struct dentry *accel_debugfs_root;
+static struct class *accel_class;
+
+static char *accel_devnode(struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "accel/%s", dev_name(dev));
+}
+
+static int accel_sysfs_init(void)
+{
+	accel_class = class_create(THIS_MODULE, "accel");
+	if (IS_ERR(accel_class))
+		return PTR_ERR(accel_class);
+
+	accel_class->devnode = accel_devnode;
+
+	return 0;
+}
+
+static void accel_sysfs_destroy(void)
+{
+	if (IS_ERR_OR_NULL(accel_class))
+		return;
+	class_destroy(accel_class);
+	accel_class = NULL;
+}
+
+static int accel_stub_open(struct inode *inode, struct file *filp)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct file_operations accel_stub_fops = {
+	.owner = THIS_MODULE,
+	.open = accel_stub_open,
+	.llseek = noop_llseek,
+};
+
+void accel_core_exit(void)
+{
+	unregister_chrdev(ACCEL_MAJOR, "accel");
+	debugfs_remove(accel_debugfs_root);
+	accel_sysfs_destroy();
+}
+
+int __init accel_core_init(void)
+{
+	int ret;
+
+	ret = accel_sysfs_init();
+	if (ret < 0) {
+		DRM_ERROR("Cannot create ACCEL class: %d\n", ret);
+		goto error;
+	}
+
+	accel_debugfs_root = debugfs_create_dir("accel", NULL);
+
+	ret = register_chrdev(ACCEL_MAJOR, "accel", &accel_stub_fops);
+	if (ret < 0)
+		DRM_ERROR("Cannot register ACCEL major: %d\n", ret);
+
+error:
+	/*
+	 * Any cleanup due to errors will be done in drm_core_exit() that
+	 * will call accel_core_exit()
+	 */
+	return ret;
+}
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index c44a54cadb61..2773e1ad1b6b 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -70,6 +70,7 @@ drm-$(CONFIG_DRM_LOAD_EDID_FIRMWARE) += drm_edid_load.o
 drm-$(CONFIG_DRM_PRIVACY_SCREEN) += \
 	drm_privacy_screen.o \
 	drm_privacy_screen_x86.o
+drm-$(CONFIG_DRM_ACCEL) += ../../accel/drm_accel.o
 obj-$(CONFIG_DRM)	+= drm.o

 obj-$(CONFIG_DRM_NOMODESET) += drm_nomodeset.o
diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
new file mode 100644
index 000000000000..e1758f484278
--- /dev/null
+++ b/include/drm/drm_accel.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2022 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef DRM_ACCEL_H_
+#define DRM_ACCEL_H_
+
+#define ACCEL_MAJOR		261
+
+#if IS_ENABLED(CONFIG_DRM_ACCEL)
+
+void accel_core_exit(void);
+int accel_core_init(void);
+
+#else
+
+static inline void accel_core_exit(void)
+{
+}
+
+static inline int __init accel_core_init(void)
+{
+	/* Return 0 to allow drm_core_init to complete successfully */
+	return 0;
+}
+
+#endif /* IS_ENABLED(CONFIG_DRM_ACCEL) */
+
+#endif /* DRM_ACCEL_H_ */
--
2.25.1

