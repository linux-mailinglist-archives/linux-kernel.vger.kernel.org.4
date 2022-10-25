Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6866460C3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJYGRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJYGRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:17:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582BBDF8;
        Mon, 24 Oct 2022 23:17:08 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MxM6R0ZWRz15M3l;
        Tue, 25 Oct 2022 14:12:15 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 14:17:06 +0800
From:   Zhang Zekun <zhangzekun11@huawei.com>
To:     <lenb@kernel.org>, <rafael@kernel.org>
CC:     <patchwork@huawei.com>, <wangkefeng.wang@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] ACPI: container: Add power domain control methods
Date:   Tue, 25 Oct 2022 06:14:37 +0000
Message-ID: <20221025061437.17571-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform devices which supports power control are often required to be
power off/on together with the devices in the same power domain. However,
there isn't a generic driver that support the power control logic of
these devices.

ACPI container seems to be a good place to hold these control logic. Add
platform devices in the same power domain in a ACPI container, we can
easily get the locality information about these devices and can moniter
the power of these devices in the same power domain together.

This patch provide three userspace control interface to control the power
of devices together in the container:
- on: power up the devices in the container and then online these devices
  which will be triggered by BIOS.
- off: offline and eject the child devices in the container which are
  ejectable.
- pxms: show the pxms of devices which are present in the container.

In our scenario, we need to control the power of HBM memory devices which
can be power consuming and will only be used in some specialized scenarios,
such as HPC. HBM memory devices in a socket are in the same power domain,
and should be power off/on together. We have come up with an idea that put
these power control logic in a specialized driver, but ACPI container seems
to be a more generic place to hold these control logic.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/acpi/Kconfig     |  12 +++++
 drivers/acpi/container.c | 112 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 473241b5193f..ebb26d56dba0 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -584,6 +584,18 @@ config ACPI_PRMT
 	  substantially increase computational overhead related to the
 	  initialization of some server systems.
 
+config ACPI_POWER_DOMAIN_CTL
+	bool "acpi container power domain control support"
+	depends on ACPI_CONTAINER
+	default n
+	help
+	  Add userspace power control interfaces in container which can be used
+	  for manipulating the power of child devices in the same power domain.
+
+	  To use this feature you need to put devices in the same power domain
+	  in a container. Enable this feature if you want to control the power
+	  of these devices together.
+
 endif	# ACPI
 
 config X86_PM_TIMER
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 5b7e3b9ae370..9ed2eb5a3dcc 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -42,6 +42,115 @@ static void acpi_container_release(struct device *dev)
 	kfree(to_container_dev(dev));
 }
 
+#ifdef CONFIG_ACPI_POWER_DOMAIN_CTL
+
+static int get_pxm(struct acpi_device *acpi_device, void *arg)
+{
+	int nid;
+	unsigned long long sta;
+	acpi_handle handle;
+	nodemask_t *mask;
+	acpi_status status;
+
+	mask = arg;
+	handle = acpi_device->handle;
+
+	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+	if (ACPI_SUCCESS(status) && (sta & ACPI_STA_DEVICE_ENABLED)) {
+		nid = acpi_get_node(handle);
+		if (nid >= 0)
+			node_set(nid, *mask);
+	}
+
+	return 0;
+}
+
+static ssize_t pxms_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	nodemask_t mask;
+	acpi_status status;
+	struct acpi_device *adev;
+
+	adev = to_acpi_device(dev);
+	nodes_clear(mask);
+
+	status = acpi_dev_for_each_child(adev, get_pxm, &mask);
+
+	return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&mask));
+}
+DEVICE_ATTR_RO(pxms);
+
+static ssize_t on_store(struct device *d, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	acpi_status status;
+	acpi_handle handle;
+	struct acpi_device *adev;
+
+	if (!count || buf[0] != '1')
+		return -EINVAL;
+
+	adev = to_acpi_device(d);
+	handle = adev->handle;
+	status = acpi_evaluate_object(handle, "_ON", NULL, NULL);
+	if (status == AE_NOT_FOUND)
+		acpi_handle_warn(handle, "No power on support for the container\n");
+	else if (ACPI_FAILURE(status))
+		acpi_handle_warn(handle, "Power on the device failed (0x%x)\n", status);
+
+	return count;
+}
+DEVICE_ATTR_WO(on);
+
+static int eject_device(struct acpi_device *acpi_device, void *not_used)
+{
+	acpi_object_type unused;
+	acpi_status status;
+
+	status = acpi_get_type(acpi_device->handle, &unused);
+	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable)
+		return -ENODEV;
+
+	acpi_dev_get(acpi_device);
+	status = acpi_hotplug_schedule(acpi_device, ACPI_OST_EC_OSPM_EJECT);
+	if (ACPI_SUCCESS(status))
+		return status;
+
+	acpi_dev_put(acpi_device);
+	acpi_evaluate_ost(acpi_device->handle, ACPI_OST_EC_OSPM_EJECT,
+			  ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
+
+	return status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
+}
+
+static ssize_t off_store(struct device *d, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct acpi_device *adev;
+	acpi_status status;
+
+	if (!count || buf[0] != '1')
+		return -EINVAL;
+
+	adev = to_acpi_device(d);
+	status = acpi_dev_for_each_child(adev, eject_device, NULL);
+	if (ACPI_SUCCESS(status))
+		return count;
+
+	return status;
+}
+DEVICE_ATTR_WO(off);
+
+static void create_sysfs(struct device *dev)
+{
+	device_create_file(dev, &dev_attr_on);
+	device_create_file(dev, &dev_attr_off);
+	device_create_file(dev, &dev_attr_pxms);
+}
+#endif
+
 static int container_device_attach(struct acpi_device *adev,
 				   const struct acpi_device_id *not_used)
 {
@@ -68,6 +177,9 @@ static int container_device_attach(struct acpi_device *adev,
 		return ret;
 	}
 	adev->driver_data = dev;
+#ifdef CONFIG_ACPI_POWER_DOMAIN_CTL
+	create_sysfs(&adev->dev);
+#endif
 	return 1;
 }
 
-- 
2.30.0

