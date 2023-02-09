Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69DB690640
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBILON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjBILN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:13:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC855E4A;
        Thu,  9 Feb 2023 03:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675941222; x=1707477222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HcB71VgwsOGzm/alG3JFlYZDfTCLlCg+NRBDC1yKb+0=;
  b=BdO6OL0m5rZbaSY5lyn9IUqOGuoi+TO1qvxVz5N0P3l1mGXvtqqoOhnU
   gsvMkzjEmKScOlDXT2nhVf61At7IE28jpt/zpP8h3uZBMIvKlLhX7Lkik
   V/NkuMO63PkInoMIYk9eumn8uQCBVKcyc2ganyF1QoGbFvrQeiwMfUrlX
   XPuKAuoUdH9rgHswZQK9d11UDIqivla9uWDsUHPyQasKnLsluh3q4nNyq
   6vlC0GzpBlEwakEp8+HWAXbnWJCBMEEsdAP0tkHcn1B7Ocogkg0ra4RUv
   bXCRgn33c4MlVtRzDTIP1ZurkrQ2YnmRpr+NmyZaTx3fG1URlAzXZ74Jp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="327769084"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="327769084"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 03:13:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="697986790"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="697986790"
Received: from enguerra-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.36.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 03:13:37 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Lee Jones <lee@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH 1/1] fpga: intel-m10-bmc-log: Create MAX 10 BMC log driver
Date:   Thu,  9 Feb 2023 13:13:28 +0200
Message-Id: <20230209111329.15791-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAX 10 BMC log driver for accessing BMC event log, FPGA image
directory, and bill-of-materials (BOM) info partitions on FPGA card's
flash. Use the nvmem API to expose the event MAX 10 BMC event logs to
userspace.

The PMCI MAX 10 BMC contains high and low timestamp registers that are
periodically written by the host driver to facilitate BMC event logs.
Add a kernel worker thread to update the BMC timestamp registers. The
frequency of timestamp updates is controlled through sysfs file (the
default frequency is once per minute).

Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Co-developed-by: Tianfei Zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

This requires commit 4f43a6e80ba9 ("fpga: m10bmc-sec: Add support for
N6000") from ib-mfd-fpga-hwmon-6.3-1 (the 11th patch of the M10 BMC split
series that wasn't picked up at first and still isn't in for-fpga-v6.3-rc1).

 .../testing/sysfs-driver-intel-m10-bmc-log    |  37 +++
 MAINTAINERS                                   |   4 +-
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   3 +-
 drivers/fpga/intel-m10-bmc-log.c              | 264 ++++++++++++++++++
 drivers/mfd/intel-m10-bmc-pmci.c              |   1 +
 include/linux/mfd/intel-m10-bmc.h             |  13 +
 7 files changed, 329 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-log
 create mode 100644 drivers/fpga/intel-m10-bmc-log.c

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-log b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-log
new file mode 100644
index 000000000000..a170e675d11e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-log
@@ -0,0 +1,37 @@
+What: /sys/bus/platform/devices/intel-m10-bmc-log.*.auto/time_sync_frequency
+Date:		Apr 2023
+KernelVersion:	6.3
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read/write. This sysfs node controls the frequency (in
+		seconds) that the host writes to the MAX10 BMC registers
+		to synchronize the timestamp registers used for the BMC
+		event log. Write zero to stop the timestamp synchronization.
+		Write a non-zero integer value to restart or modify the
+		update frequency. Reading from this file will return the
+		same integer value.
+		Format: %u
+
+What:		/sys/bus/platform/devices/intel-m10-bmc-log.*.auto/bmc_event_log*/nvmem
+Date:		Apr 2023
+KernelVersion:	6.3
+Contact:	Tianfei zhang <tianfei.zhang@intel.com>
+Description:	Read-only. This file returns the contents of the "evemt log"
+		partition in flash. This partition includes the event and
+		error info for the BMC.
+
+What:		/sys/bus/platform/devices/intel-m10-bmc-log.*.auto/fpga_image_directory*/nvmem
+Date:		Apr 2023
+KernelVersion:	6.3
+Contact:	Tianfei zhang <tianfei.zhang@intel.com>
+Description:	Read-only. This file returns the contents of the "FPGA image
+		directory" partition in flash. This partition includes
+		information like the FPGA Image versions and state.
+
+What:		/sys/bus/platform/devices/intel-m10-bmc-log.*.auto/bom_info*/nvmem
+Date:		Apr 2023
+KernelVersion:	6.3
+Contact:	Tianfei zhang <tianfei.zhang@intel.com>
+Description:	Read-only. This file returns the contents of the "BOM info"
+		partition in flash. This partition includes information such
+		as the bill of materials (BOM) critical components like
+		PBA#, MMID.
diff --git a/MAINTAINERS b/MAINTAINERS
index ddfa4f8b3c80..1b2427ba6729 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8075,11 +8075,13 @@ F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
 
-INTEL MAX10 BMC SECURE UPDATES
+INTEL MAX10 BMC SUBDRIVERS
 M:	Russ Weight <russell.h.weight@intel.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-log
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
+F:	drivers/fpga/intel-m10-bmc-log.c
 F:	drivers/fpga/intel-m10-bmc-sec-update.c
 
 MICROCHIP POLARFIRE FPGA DRIVERS
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0a00763b9f28..773667e3b027 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -244,6 +244,15 @@ config FPGA_MGR_VERSAL_FPGA
 
 	  To compile this as a module, choose M here.
 
+config FPGA_M10_BMC_LOG
+	tristate "Intel MAX 10 Board Management Controller Log Driver"
+	depends on MFD_INTEL_M10_BMC_CORE
+	help
+	  Support for the Intel MAX 10 Board Management Controller (BMC)
+	  event log, event log timestamp synchronization, and other
+	  information on flash partitions (available images and
+	  bill-of-materials critical information).
+
 config FPGA_M10_BMC_SEC_UPDATE
 	tristate "Intel MAX10 BMC Secure Update driver"
 	depends on MFD_INTEL_M10_BMC_CORE
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 72e554b4d2f7..1db25ad3d76a 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -25,7 +25,8 @@ obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI)	+= lattice-sysconfig-spi.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
 
-# FPGA Secure Update Drivers
+# MAX10 subdrivers
+obj-$(CONFIG_FPGA_M10_BMC_LOG)		+= intel-m10-bmc-log.o
 obj-$(CONFIG_FPGA_M10_BMC_SEC_UPDATE)	+= intel-m10-bmc-sec-update.o
 
 # FPGA Bridge Drivers
diff --git a/drivers/fpga/intel-m10-bmc-log.c b/drivers/fpga/intel-m10-bmc-log.c
new file mode 100644
index 000000000000..4e7a54afe786
--- /dev/null
+++ b/drivers/fpga/intel-m10-bmc-log.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Max10 Board Management Controller Log Driver
+ *
+ * Copyright (C) 2021-2023 Intel Corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/dev_printk.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/nvmem-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/types.h>
+
+#include <linux/mfd/intel-m10-bmc.h>
+
+#define M10BMC_TIMESTAMP_FREQ			60	/* 60 secs between updates */
+
+struct m10bmc_log_cfg {
+	int el_size;
+	unsigned long el_off;
+
+	int id_size;
+	unsigned long id_off;
+
+	int bi_size;
+	unsigned long bi_off;
+};
+
+struct m10bmc_log {
+	struct device *dev;
+	struct intel_m10bmc *m10bmc;
+	unsigned int freq_s;		/* update frequency in seconds */
+	struct delayed_work dwork;
+	const struct m10bmc_log_cfg *log_cfg;
+	struct nvmem_device *bmc_event_log_nvmem;
+	struct nvmem_device *fpga_image_dir_nvmem;
+	struct nvmem_device *bom_info_nvmem;
+};
+
+static void m10bmc_log_time_sync(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	const struct m10bmc_csr_map *csr_map;
+	struct m10bmc_log *log;
+	s64 time_ms;
+	int ret;
+
+	log = container_of(dwork, struct m10bmc_log, dwork);
+	csr_map = log->m10bmc->info->csr_map;
+
+	time_ms = ktime_to_ms(ktime_get_real());
+	ret = regmap_write(log->m10bmc->regmap, csr_map->base + M10BMC_N6000_TIME_HIGH,
+			   upper_32_bits(time_ms));
+	if (!ret) {
+		ret = regmap_write(log->m10bmc->regmap, csr_map->base + M10BMC_N6000_TIME_LOW,
+				   lower_32_bits(time_ms));
+	}
+	if (ret)
+		dev_err_once(log->dev, "Failed to update BMC timestamp: %d\n", ret);
+
+	schedule_delayed_work(&log->dwork, log->freq_s * HZ);
+}
+
+static ssize_t time_sync_frequency_store(struct device *dev, struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct m10bmc_log *ddata = dev_get_drvdata(dev);
+	unsigned int old_freq = ddata->freq_s;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &ddata->freq_s);
+	if (ret)
+		return ret;
+
+	if (old_freq)
+		cancel_delayed_work_sync(&ddata->dwork);
+
+	if (ddata->freq_s)
+		m10bmc_log_time_sync(&ddata->dwork.work);
+
+	return count;
+}
+
+static ssize_t time_sync_frequency_show(struct device *dev, struct device_attribute *attr,
+					char *buf)
+{
+	struct m10bmc_log *ddata = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", ddata->freq_s);
+}
+static DEVICE_ATTR_RW(time_sync_frequency);
+
+static struct attribute *m10bmc_log_attrs[] = {
+	&dev_attr_time_sync_frequency.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(m10bmc_log);
+
+static int bmc_nvmem_read(struct m10bmc_log *ddata, unsigned int addr,
+			  unsigned int off, void *val, size_t count)
+{
+	struct intel_m10bmc *m10bmc = ddata->m10bmc;
+	int ret;
+
+	ret = m10bmc->flash_bulk_ops->read(m10bmc, val, addr + off, count);
+	if (ret) {
+		if (ret != -EBUSY)
+			dev_err(ddata->dev, "failed to read flash %x (%d)\n", addr, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bmc_event_log_nvmem_read(void *priv, unsigned int off, void *val, size_t count)
+{
+	struct m10bmc_log *ddata = priv;
+
+	return bmc_nvmem_read(ddata, ddata->log_cfg->el_off, off, val, count);
+}
+
+static int fpga_image_dir_nvmem_read(void *priv, unsigned int off, void *val, size_t count)
+{
+	struct m10bmc_log *ddata = priv;
+
+	return bmc_nvmem_read(ddata, ddata->log_cfg->id_off, off, val, count);
+}
+
+static int bom_info_nvmem_read(void *priv, unsigned int off, void *val, size_t count)
+{
+	struct m10bmc_log *ddata = priv;
+
+	return bmc_nvmem_read(ddata, ddata->log_cfg->bi_off, off, val, count);
+}
+
+static struct nvmem_config bmc_event_log_nvmem_config = {
+	.name = "bmc_event_log",
+	.stride = 4,
+	.word_size = 1,
+	.reg_read = bmc_event_log_nvmem_read,
+	.id = NVMEM_DEVID_AUTO,
+};
+
+static struct nvmem_config fpga_image_dir_nvmem_config = {
+	.name = "fpga_image_directory",
+	.stride = 4,
+	.word_size = 1,
+	.reg_read = fpga_image_dir_nvmem_read,
+	.id = NVMEM_DEVID_AUTO,
+};
+
+static struct nvmem_config bom_info_nvmem_config = {
+	.name = "bom_info",
+	.stride = 4,
+	.word_size = 1,
+	.reg_read = bom_info_nvmem_read,
+	.id = NVMEM_DEVID_AUTO,
+};
+
+static int m10bmc_log_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct intel_m10bmc *m10bmc = dev_get_drvdata(pdev->dev.parent);
+	struct nvmem_config nvconfig;
+	struct m10bmc_log *ddata;
+
+	if (WARN_ON_ONCE(!m10bmc->flash_bulk_ops))
+		return -ENODEV;
+
+	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->dev = &pdev->dev;
+	ddata->m10bmc = m10bmc;
+	ddata->freq_s = M10BMC_TIMESTAMP_FREQ;
+	INIT_DELAYED_WORK(&ddata->dwork, m10bmc_log_time_sync);
+	ddata->log_cfg = (struct m10bmc_log_cfg *)id->driver_data;
+	dev_set_drvdata(&pdev->dev, ddata);
+
+	if (ddata->log_cfg->el_size > 0) {
+		m10bmc_log_time_sync(&ddata->dwork.work);
+
+		memcpy(&nvconfig, &bmc_event_log_nvmem_config, sizeof(bmc_event_log_nvmem_config));
+		nvconfig.dev = ddata->dev;
+		nvconfig.priv = ddata;
+		nvconfig.size = ddata->log_cfg->el_size;
+
+		ddata->bmc_event_log_nvmem = devm_nvmem_register(ddata->dev, &nvconfig);
+		if (IS_ERR(ddata->bmc_event_log_nvmem))
+			return PTR_ERR(ddata->bmc_event_log_nvmem);
+	}
+
+	if (ddata->log_cfg->id_size > 0) {
+		memcpy(&nvconfig, &fpga_image_dir_nvmem_config, sizeof(fpga_image_dir_nvmem_config));
+		nvconfig.dev = ddata->dev;
+		nvconfig.priv = ddata;
+		nvconfig.size = ddata->log_cfg->id_size;
+
+		ddata->fpga_image_dir_nvmem = devm_nvmem_register(ddata->dev, &nvconfig);
+		if (IS_ERR(ddata->fpga_image_dir_nvmem))
+			return PTR_ERR(ddata->fpga_image_dir_nvmem);
+	}
+
+	if (ddata->log_cfg->bi_size > 0) {
+		memcpy(&nvconfig, &bom_info_nvmem_config, sizeof(bom_info_nvmem_config));
+		nvconfig.dev = ddata->dev;
+		nvconfig.priv = ddata;
+		nvconfig.size = ddata->log_cfg->bi_size;
+
+		ddata->bom_info_nvmem = devm_nvmem_register(ddata->dev, &nvconfig);
+		if (IS_ERR(ddata->bom_info_nvmem))
+			return PTR_ERR(ddata->bom_info_nvmem);
+	}
+
+	return 0;
+}
+
+static int m10bmc_log_remove(struct platform_device *pdev)
+{
+	struct m10bmc_log *ddata = dev_get_drvdata(&pdev->dev);
+
+	cancel_delayed_work_sync(&ddata->dwork);
+
+	return 0;
+}
+
+static const struct m10bmc_log_cfg m10bmc_log_n6000_cfg = {
+	.el_size = M10BMC_N6000_ERROR_LOG_SIZE,
+	.el_off = M10BMC_N6000_ERROR_LOG_ADDR,
+
+	.id_size = M10BMC_N6000_FPGA_IMAGE_DIR_SIZE,
+	.id_off = M10BMC_N6000_FPGA_IMAGE_DIR_ADDR,
+
+	.bi_size = M10BMC_N6000_BOM_INFO_SIZE,
+	.bi_off = M10BMC_N6000_BOM_INFO_ADDR,
+};
+
+static const struct platform_device_id intel_m10bmc_log_ids[] = {
+	{
+		.name = "n6000bmc-log",
+		.driver_data = (unsigned long)&m10bmc_log_n6000_cfg,
+	},
+	{ }
+};
+
+static struct platform_driver intel_m10bmc_log_driver = {
+	.probe = m10bmc_log_probe,
+	.remove = m10bmc_log_remove,
+	.driver = {
+		.name = "intel-m10-bmc-log",
+		.dev_groups = m10bmc_log_groups,
+	},
+	.id_table = intel_m10bmc_log_ids,
+};
+module_platform_driver(intel_m10bmc_log_driver);
+
+MODULE_DEVICE_TABLE(platform, intel_m10bmc_log_ids);
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel MAX 10 BMC log driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
index 8821f1876dd6..f8803b7bb98e 100644
--- a/drivers/mfd/intel-m10-bmc-pmci.c
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -350,6 +350,7 @@ static struct regmap_config m10bmc_pmci_regmap_config = {
 static struct mfd_cell m10bmc_pmci_n6000_bmc_subdevs[] = {
 	{ .name = "n6000bmc-hwmon" },
 	{ .name = "n6000bmc-sec-update" },
+	{ .name = "n6000bmc-log" },
 };
 
 static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 1812ebfa11a8..1079e580e9e6 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -125,6 +125,9 @@
 #define M10BMC_N6000_SYS_BASE			0x0
 #define M10BMC_N6000_SYS_END			0xfff
 
+#define M10BMC_N6000_TIME_LOW			0x178
+#define M10BMC_N6000_TIME_HIGH			0x17c
+
 #define M10BMC_N6000_DOORBELL			0x1c0
 #define M10BMC_N6000_AUTH_RESULT		0x1c4
 #define AUTH_RESULT_RSU_STATUS			GENMASK(23, 16)
@@ -134,6 +137,16 @@
 #define M10BMC_N6000_MAC_LOW			0x20
 #define M10BMC_N6000_MAC_HIGH			(M10BMC_N6000_MAC_LOW + 4)
 
+/* Addresses for BMC log data in FLASH */
+#define M10BMC_N6000_ERROR_LOG_ADDR		0x7fb0000
+#define M10BMC_N6000_ERROR_LOG_SIZE		0x40000
+
+#define M10BMC_N6000_FPGA_IMAGE_DIR_ADDR	0x7ff6000
+#define M10BMC_N6000_FPGA_IMAGE_DIR_SIZE	0x3000
+
+#define M10BMC_N6000_BOM_INFO_ADDR		0x7ff0000
+#define M10BMC_N6000_BOM_INFO_SIZE		0x2000
+
 /* Addresses for security related data in FLASH */
 #define M10BMC_N6000_BMC_REH_ADDR		0x7ffc004
 #define M10BMC_N6000_BMC_PROG_ADDR		0x7ffc000
-- 
2.30.2

