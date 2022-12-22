Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709B3654826
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiLVWC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLVWCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:02:52 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982D7DED0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671746571; x=1703282571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XzRcH9xIgofCN1Fx2C1/9Imdy13Q/iYG8/kotrsmBok=;
  b=kAvYFwULYAC9OXS8hhKKvvLgBHpKv0OLWtKzSblIjG0/mn/bLgS7leMI
   cwDHdFN+BQ1V3I8oqvlboHU7dOqv4gtJbG01v7G4+A4RODBZJkYBXuKdj
   D2vuxvXAdqbywBV7BJNjf8PIRMt2El2tJrNoVePB/k3SvwQ/nq8LItuKC
   pziDdOgkHEU37bl+euiVyuXTBdbtanHuMbw1pUJKpuRpgcSGsdX2wN4/p
   E8oTfk9GRHi3EDYNrm7GLGgwN6FJwU0RpRrupEVvU7P3KCIXQtkDQbGRM
   eOaCKOJk0ZbnBjZHKezU3h2uv9et+8HhvwI6pjRm4XqCtVcW6ilxeXSJo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="320282402"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="320282402"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 14:02:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="602009621"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="602009621"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.42])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 14:02:26 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: gsc_proxy: add gsc proxy driver
Date:   Fri, 23 Dec 2022 00:02:14 +0200
Message-Id: <20221222220214.3688774-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Add GSC proxy driver. It to allows messaging between GSC component
on Intel on board graphics card and CSME device.
GSC and MEI

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 MAINTAINERS                                |   2 +-
 drivers/misc/mei/Kconfig                   |   1 +
 drivers/misc/mei/Makefile                  |   1 +
 drivers/misc/mei/gsc_proxy/Kconfig         |  13 ++
 drivers/misc/mei/gsc_proxy/Makefile        |   7 +
 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c | 205 +++++++++++++++++++++
 6 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/mei/gsc_proxy/Kconfig
 create mode 100644 drivers/misc/mei/gsc_proxy/Makefile
 create mode 100644 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5490b1f94803..01473c039412 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10561,7 +10561,7 @@ M:	Tomas Winkler <tomas.winkler@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/mei/*
-F:	drivers/misc/mei/
+F:	drivers/misc/mei/*
 F:	drivers/watchdog/mei_wdt.c
 F:	include/linux/mei_aux.h
 F:	include/linux/mei_cl_bus.h
diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index d21486d69df2..92baed17a50b 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -62,4 +62,5 @@ config INTEL_MEI_GSC
 
 source "drivers/misc/mei/hdcp/Kconfig"
 source "drivers/misc/mei/pxp/Kconfig"
+source "drivers/misc/mei/gsc_proxy/Kconfig"
 
diff --git a/drivers/misc/mei/Makefile b/drivers/misc/mei/Makefile
index fb740d754900..14aee253ae48 100644
--- a/drivers/misc/mei/Makefile
+++ b/drivers/misc/mei/Makefile
@@ -30,3 +30,4 @@ CFLAGS_mei-trace.o = -I$(src)
 
 obj-$(CONFIG_INTEL_MEI_HDCP) += hdcp/
 obj-$(CONFIG_INTEL_MEI_PXP) += pxp/
+obj-$(CONFIG_INTEL_MEI_GSC_PROXY) += gsc_proxy/
diff --git a/drivers/misc/mei/gsc_proxy/Kconfig b/drivers/misc/mei/gsc_proxy/Kconfig
new file mode 100644
index 000000000000..9bc4486a6dad
--- /dev/null
+++ b/drivers/misc/mei/gsc_proxy/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022, Intel Corporation. All rights reserved.
+#
+config INTEL_MEI_GSC_PROXY
+	tristate "Intel GSC Proxy services of ME Interface"
+	select INTEL_MEI_ME
+	depends on DRM_I915
+	help
+	  MEI Support for GSC Proxy Services on Intel platforms.
+
+	  MEI GSC proxy enables messaging between GSC service on
+	  Intel graphics on-board card and services on CSE (MEI)
+	  firmware residing SoC or PCH.
diff --git a/drivers/misc/mei/gsc_proxy/Makefile b/drivers/misc/mei/gsc_proxy/Makefile
new file mode 100644
index 000000000000..fd7da77ad90a
--- /dev/null
+++ b/drivers/misc/mei/gsc_proxy/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2022, Intel Corporation. All rights reserved.
+#
+# Makefile - GSC Proxy client driver for Intel MEI Bus Driver.
+
+obj-$(CONFIG_INTEL_MEI_GSC_PROXY) += mei_gsc_proxy.o
diff --git a/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c b/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
new file mode 100644
index 000000000000..4be6dc3ffdff
--- /dev/null
+++ b/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Intel Corporation
+ */
+
+/**
+ * DOC: MEI_GSC_PROXY Client Driver
+ *
+ * The mei_gsc_proxy driver acts as a translation layer between
+ * user (I915) and CSE FW services.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/uuid.h>
+#include <linux/mei_cl_bus.h>
+#include <linux/component.h>
+#include <drm/drm_connector.h>
+#include <drm/i915_component.h>
+#include <drm/i915_gsc_proxy_mei_interface.h>
+
+/**
+ * mei_gsc_proxy_send - Sends a proxy message to ME FW.
+ * @dev: device corresponding to the mei_cl_device
+ * @buf: a message buffer to send
+ * @size: size of the message
+ * Return: bytes sent on Success, <0 on Failure
+ */
+static int mei_gsc_proxy_send(struct device *dev, const void *buf, size_t size)
+{
+	ssize_t ret;
+
+	if (!dev || !buf)
+		return -EINVAL;
+
+	ret = mei_cldev_send(to_mei_cl_device(dev), buf, size);
+	if (ret < 0)
+		dev_dbg(dev, "mei_cldev_send failed. %zd\n", ret);
+
+	return ret;
+}
+
+/**
+ * mei_gsc_proxy_recv - Receives a proxy message from ME FW.
+ * @dev: device corresponding to the mei_cl_device
+ * @buf: a message buffer to contain the received message
+ * @size: size of the buffer
+ * Return: bytes received on Success, <0 on Failure
+ */
+static int mei_gsc_proxy_recv(struct device *dev, void *buf, size_t size)
+{
+	ssize_t ret;
+
+	if (!dev || !buf)
+		return -EINVAL;
+
+	ret = mei_cldev_recv(to_mei_cl_device(dev), buf, size);
+	if (ret < 0)
+		dev_dbg(dev, "mei_cldev_recv failed. %zd\n", ret);
+
+	return ret;
+}
+
+static const struct i915_gsc_proxy_component_ops mei_gsc_proxy_ops = {
+	.owner = THIS_MODULE,
+	.send = mei_gsc_proxy_send,
+	.recv = mei_gsc_proxy_recv,
+};
+
+static int mei_component_master_bind(struct device *dev)
+{
+	struct mei_cl_device *cldev = to_mei_cl_device(dev);
+	struct i915_gsc_proxy_component *comp_master = mei_cldev_get_drvdata(cldev);
+
+	comp_master->ops = &mei_gsc_proxy_ops;
+	comp_master->mei_dev = dev;
+	return component_bind_all(dev, comp_master);
+}
+
+static void mei_component_master_unbind(struct device *dev)
+{
+	struct mei_cl_device *cldev = to_mei_cl_device(dev);
+	struct i915_gsc_proxy_component *comp_master = mei_cldev_get_drvdata(cldev);
+
+	component_unbind_all(dev, comp_master);
+}
+
+static const struct component_master_ops mei_component_master_ops = {
+	.bind = mei_component_master_bind,
+	.unbind = mei_component_master_unbind,
+};
+
+/**
+ * mei_gsc_proxy_component_match - compare function for matching mei.
+ *
+ *    The function checks if the driver is i915, the subcomponent is SW Proxy
+ *    and the grand parent of proxy and the parent of i915 are the same
+ *    PCH device.
+ *
+ * @dev: master device
+ * @subcomponent: subcomponent to match (I915_COMPONENT_SWPROXY)
+ * @data: compare data (mei gsc proxy device)
+ *
+ * Return:
+ * * 1 - if components match
+ * * 0 - otherwise
+ */
+static int mei_gsc_proxy_component_match(struct device *dev, int subcomponent, void *data)
+{
+	struct device *base = data;
+
+	if (!dev || !dev->driver ||
+	    strcmp(dev->driver->name, "i915") ||
+	    subcomponent != I915_COMPONENT_GSC_PROXY)
+		return 0;
+
+	base = base->parent;
+	if (!base) /* mei device */
+		return 0;
+
+	base = base->parent; /* pci device */
+
+	dev = dev->parent;
+	return (base && dev && dev == base);
+}
+
+static int mei_gsc_proxy_probe(struct mei_cl_device *cldev, const struct mei_cl_device_id *id)
+{
+	struct i915_gsc_proxy_component *comp_master;
+	struct component_match *master_match = NULL;
+	int ret;
+
+	ret = mei_cldev_enable(cldev);
+	if (ret < 0) {
+		dev_err(&cldev->dev, "mei_cldev_enable Failed. %d\n", ret);
+		goto enable_err_exit;
+	}
+
+	comp_master = kzalloc(sizeof(*comp_master), GFP_KERNEL);
+	if (!comp_master) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	component_match_add_typed(&cldev->dev, &master_match,
+				  mei_gsc_proxy_component_match, &cldev->dev);
+	if (IS_ERR_OR_NULL(master_match)) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	mei_cldev_set_drvdata(cldev, comp_master);
+	ret = component_master_add_with_match(&cldev->dev,
+					      &mei_component_master_ops,
+					      master_match);
+	if (ret < 0) {
+		dev_err(&cldev->dev, "Master comp add failed %d\n", ret);
+		goto err_exit;
+	}
+
+	return 0;
+
+err_exit:
+	mei_cldev_set_drvdata(cldev, NULL);
+	kfree(comp_master);
+	mei_cldev_disable(cldev);
+enable_err_exit:
+	return ret;
+}
+
+static void mei_gsc_proxy_remove(struct mei_cl_device *cldev)
+{
+	struct i915_gsc_proxy_component *comp_master = mei_cldev_get_drvdata(cldev);
+	int ret;
+
+	component_master_del(&cldev->dev, &mei_component_master_ops);
+	kfree(comp_master);
+	mei_cldev_set_drvdata(cldev, NULL);
+
+	ret = mei_cldev_disable(cldev);
+	if (ret)
+		dev_warn(&cldev->dev, "mei_cldev_disable() failed %d\n", ret);
+}
+
+#define MEI_GUID_GSC_PROXY GUID_INIT(0xf73db04, 0x97ab, 0x4125, \
+				     0xb8, 0x93, 0xe9, 0x4, 0xad, 0xd, 0x54, 0x64)
+
+static struct mei_cl_device_id mei_gsc_proxy_tbl[] = {
+	{ .uuid = MEI_GUID_GSC_PROXY, .version = MEI_CL_VERSION_ANY },
+	{ }
+};
+MODULE_DEVICE_TABLE(mei, mei_gsc_proxy_tbl);
+
+static struct mei_cl_driver mei_gsc_proxy_driver = {
+	.id_table = mei_gsc_proxy_tbl,
+	.name = KBUILD_MODNAME,
+	.probe = mei_gsc_proxy_probe,
+	.remove	= mei_gsc_proxy_remove,
+};
+
+module_mei_cl_driver(mei_gsc_proxy_driver);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MEI GSC PROXY");
-- 
2.38.1

