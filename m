Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C88B6FBA0F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjEHVkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjEHVkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:40:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701B59ECB;
        Mon,  8 May 2023 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683581998; x=1715117998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MJoOsIHNWt2r7nEPaCTq71uEbK+/snc/W10VxBnzw0g=;
  b=NoeVMPv9DNm1gBrkngFUGa8mIFoD2RNl+2M9OOQ0FAsTtQWKwOD7u27G
   jUSmQawRj12Yovx78Wnc3oqvkFE+tca3vDaemcyMOq1dTmNUljQ3et10A
   gNrfJdv7dzTBXKQzhGQRbyBqgfbtrf7OaliENMGgLFMqQWvDEfcXXQv5A
   KDFNvg0GfchnTx/5434nD4yS3s5dpN9O56iYkobnEWrwrv5S21p/wLvKN
   x/6Bz9BUA14p1MMqNab0PzvBKR4LFogCEfDULWfIf7me4O2GldV8vL2XI
   vpfRcwcpyVWFKmlX5Jx8McJgcx4FEGnjBkXluQyw2RXIGla8SJQtLFnTa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="349796687"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="349796687"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:38:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="945018715"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="945018715"
Received: from linux-builds1.an.intel.com ([10.122.105.32])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:38:57 -0700
From:   dinh.nguyen@linux.intel.com
To:     linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Dinh Nguyen <dinh.nguyen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCHv2 3/6] hwmon: (socfpga) Add hardware monitoring support on SoCFPGA platforms
Date:   Mon,  8 May 2023 16:28:49 -0500
Message-Id: <20230508212852.8413-3-dinh.nguyen@linux.intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
References: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@linux.intel.com>

The driver supports 64-bit SoCFPGA platforms for temperature and voltage
reading using the platform's SDM(Secure Device Manager). The driver
also uses the Stratix10 Service layer driver.

This driver only supports OF SoCFPGA 64-bit platforms.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
---
v2: clean up race conditions in probe/remove functions
    move changes in service driver to a separate patch
    fix undefined 'ret' value in socfpga_read()
    fix up socfpga_hwmon_err_to_errno() to handle signed integer
    add platform specific dts binding
---
 Documentation/hwmon/index.rst         |   1 +
 Documentation/hwmon/socfpga-hwmon.rst |  30 ++
 drivers/hwmon/Kconfig                 |  11 +
 drivers/hwmon/Makefile                |   1 +
 drivers/hwmon/socfpga-hwmon.c         | 408 ++++++++++++++++++++++++++
 5 files changed, 451 insertions(+)
 create mode 100644 Documentation/hwmon/socfpga-hwmon.rst
 create mode 100644 drivers/hwmon/socfpga-hwmon.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index f1fe75f596a5..9db4e1537481 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -196,6 +196,7 @@ Hardware Monitoring Kernel Drivers
    smsc47b397
    smsc47m192
    smsc47m1
+   socfpga-hwmon
    sparx5-temp
    stpddc60
    sy7636a-hwmon
diff --git a/Documentation/hwmon/socfpga-hwmon.rst b/Documentation/hwmon/socfpga-hwmon.rst
new file mode 100644
index 000000000000..f6565c83cf40
--- /dev/null
+++ b/Documentation/hwmon/socfpga-hwmon.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver socfpga-hwmon
+===========================
+
+Supported chips:
+
+ * Intel Stratix10
+ * Intel Agilex
+ * Intel N5X
+
+Author: Dinh Nguyen <dinh.nguyen@linux.intel.com>
+
+Description
+-----------
+
+This driver supports hardware monitoring for 64-Bit SoCFPGA and eASIC devices
+based around the Secure Device Manager and Stratix 10 Service layer.
+
+The following sensor types are supported:
+
+  * temperature
+  * voltage
+
+Usage Notes
+-----------
+
+The driver relies on a device tree node to enumerate support present on the
+specific device. See Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
+for details of the device-tree node.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5b3b76477b0e..c7c978acfece 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1875,6 +1875,17 @@ config SENSORS_SMSC47M192
 	  This driver can also be built as a module. If so, the module
 	  will be called smsc47m192.
 
+config SENSORS_SOCFPGA
+	tristate "SoCFPGA Hardware monitoring features"
+	depends on INTEL_STRATIX10_SERVICE
+	depends on OF || COMPILE_TEST
+	help
+	  If you say yes here you get support for the temperature and
+	  voltage sensors of 64-bit SoCFPGA devices.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called socfpga-hwmon.
+
 config SENSORS_SMSC47B397
 	tristate "SMSC LPC47B397-NC"
 	depends on !PPC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 88712b5031c8..c04c0b2578a4 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -193,6 +193,7 @@ obj-$(CONFIG_SENSORS_SMPRO)	+= smpro-hwmon.o
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
+obj-$(CONFIG_SENSORS_SOCFPGA)	+= socfpga-hwmon.o
 obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
 obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
diff --git a/drivers/hwmon/socfpga-hwmon.c b/drivers/hwmon/socfpga-hwmon.c
new file mode 100644
index 000000000000..01bdefa62b7f
--- /dev/null
+++ b/drivers/hwmon/socfpga-hwmon.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SoCFPGA hardware monitoring features
+ *
+ * Copyright (c) 2023 Intel Corporation. All rights reserved
+ */
+#include <linux/arm-smccc.h>
+#include <linux/hwmon.h>
+#include <linux/firmware/intel/stratix10-svc-client.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/units.h>
+
+#define HWMON_TIMEOUT	msecs_to_jiffies(SVC_HWMON_REQUEST_TIMEOUT_MS)
+
+/*
+ * Selected temperature sensor channel is currently inactive.
+ * Ensure that the tile where the TSD is located is actively in use.
+ */
+#define ETEMP_INACTIVE		0
+/*
+ * Selected temperature sensor channel returned a value that is not the
+ * latest reading. Try retrieve the temperature reading again.
+ */
+#define ETEMP_TOO_OLD		1
+/*
+ * Selected temperature sensor channel is invalid for the device. Ignore
+ * the returned data because the temperature sensor channel location is
+ * invalid.
+ */
+#define ETEMP_NOT_PRESENT	2
+/*
+ * System is corrupted or failed to respond.
+ */
+#define ETEMP_TIMEOUT		3
+#define ETEMP_CORRUPT		4
+/*
+ * Communication mechanism is busy.
+ */
+#define ETEMP_BUSY		5
+/*
+ * System is corrupted or failed to respond.
+ */
+#define ETEMP_NOT_INITIALIZED	255
+
+#define SOCFPGA_HWMON_ERR_MAX	-2147483648
+
+#define SOCFPGA_HWMON_MAXSENSORS	16
+
+/**
+ * struct socfpga_hwmon_chan - channel input parameters.
+ * @n : Number of channels.
+ * @value: value read from the chip.
+ * @names: names array from DTS labels.
+ * @chan: channel array.
+ *
+ * The structure represents either the voltage or temperature information
+ * for the hwmon channels.
+ */
+struct socfpga_hwmon_chan {
+	unsigned int n;
+	int value;
+	const char *names[SOCFPGA_HWMON_MAXSENSORS];
+	u32 chan[SOCFPGA_HWMON_MAXSENSORS];
+};
+
+struct socfpga_hwmon_priv {
+	struct device *hwmon_dev;
+	struct stratix10_svc_client client;
+	struct stratix10_svc_client_msg msg;
+	struct stratix10_svc_chan *chan;
+	struct completion completion;
+	struct mutex lock; /* lock for reading the hardware volts/temps */
+	struct socfpga_hwmon_chan temperature;
+	struct socfpga_hwmon_chan voltage;
+};
+
+enum hwmon_type_op {
+	SOCFPGA_HWMON_TYPE_TEMP,
+	SOCFPGA_HWMON_TYPE_VOLT
+};
+
+static const char *const hwmon_types_str[] = { "temperature", "voltage" };
+
+static umode_t socfpga_is_visible(const void *dev,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int chan)
+{
+	switch (type) {
+	case hwmon_temp:
+	case hwmon_in:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static void socfpga_smc_callback(struct stratix10_svc_client *client,
+				 struct stratix10_svc_cb_data *data)
+{
+	struct socfpga_hwmon_priv *priv = client->priv;
+	struct arm_smccc_res *res = data->kaddr1;
+
+	if (data->status == BIT(SVC_STATUS_OK))	{
+		if (priv->msg.command == COMMAND_HWMON_READTEMP)
+			priv->temperature.value = res->a0;
+		else
+			priv->voltage.value = res->a0;
+	} else {
+		dev_err(client->dev, "%s returned 0x%lX\n", __func__, res->a0);
+	}
+
+	complete(&priv->completion);
+}
+
+static int socfpga_hwmon_send(struct socfpga_hwmon_priv *priv)
+{
+	int ret;
+
+	priv->client.receive_cb = socfpga_smc_callback;
+
+	ret = stratix10_svc_send(priv->chan, &priv->msg);
+	if (ret < 0)
+		return ret;
+
+	if (!wait_for_completion_timeout(&priv->completion, HWMON_TIMEOUT)) {
+		dev_err(priv->client.dev, "SMC call timeout!\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int socfpga_hwmon_err_to_errno(struct socfpga_hwmon_priv *priv)
+{
+	int value = priv->temperature.value;
+	int err;
+
+	if (value >= SOCFPGA_HWMON_ERR_MAX)
+		return 0;
+
+	err = abs(SOCFPGA_HWMON_ERR_MAX - value);
+	switch (err) {
+	case ETEMP_NOT_PRESENT:
+		return -ENOENT;
+	case ETEMP_CORRUPT:
+	case ETEMP_NOT_INITIALIZED:
+		return -ENODATA;
+	case ETEMP_BUSY:
+		return -EBUSY;
+	case ETEMP_INACTIVE:
+	case ETEMP_TIMEOUT:
+	case ETEMP_TOO_OLD:
+		return -EAGAIN;
+	default:
+		/* Unknown error */
+		return -EIO;
+	}
+}
+
+static int socfpga_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int chan, long *val)
+{
+	struct socfpga_hwmon_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&priv->lock);
+	reinit_completion(&priv->completion);
+
+	switch (type) {
+	case hwmon_temp:
+		priv->msg.arg[0] = BIT_ULL(priv->temperature.chan[chan]);
+		priv->msg.command = COMMAND_HWMON_READTEMP;
+		ret = socfpga_hwmon_send(priv);
+		if (ret)
+			goto status_done;
+
+		ret = socfpga_hwmon_err_to_errno(priv);
+		if (ret)
+			break;
+		/*
+		 * The Temperature Sensor IP core returns the Celsius
+		 * temperature value in signed 32-bit fixed point binary
+		 * format, with eight bits below binary point.
+		 */
+		*val = (priv->temperature.value * MILLIDEGREE_PER_DEGREE) / 256;
+		break;
+	case hwmon_in:
+		priv->msg.arg[0] = BIT_ULL(priv->voltage.chan[chan]);
+		priv->msg.command = COMMAND_HWMON_READVOLT;
+		ret = socfpga_hwmon_send(priv);
+		if (ret)
+			goto status_done;
+
+		/*
+		 * The Voltage Sensor IP core returns the sampled voltage
+		 * in unsigned 32-bit fixed point binary format, with 16 bits
+		 * below binary point.
+		 */
+		*val = (priv->voltage.value * MILLIVOLT_PER_VOLT) / 65536;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+status_done:
+	stratix10_svc_done(priv->chan);
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static int socfpga_read_string(struct device *dev,
+			       enum hwmon_sensor_types type, u32 attr,
+			       int chan, const char **str)
+{
+	struct socfpga_hwmon_priv *priv = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_in:
+		*str = priv->voltage.names[chan];
+		return 0;
+	case hwmon_temp:
+		*str = priv->temperature.names[chan];
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_ops socfpga_ops = {
+	.is_visible = socfpga_is_visible,
+	.read = socfpga_read,
+	.read_string = socfpga_read_string,
+};
+
+static const struct hwmon_channel_info *socfpga_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL),
+	NULL
+};
+
+static const struct hwmon_chip_info socfpga_chip_info = {
+	.ops = &socfpga_ops,
+	.info = socfpga_info,
+};
+
+static int socfpga_add_channel(struct device *dev,  const char *type,
+			       u32 val, const char *label,
+			       struct socfpga_hwmon_priv *priv)
+{
+	int type_index;
+	struct socfpga_hwmon_chan *p;
+
+	type_index = match_string(hwmon_types_str, ARRAY_SIZE(hwmon_types_str), type);
+	switch (type_index) {
+	case SOCFPGA_HWMON_TYPE_TEMP:
+		p = &priv->temperature;
+		break;
+	case SOCFPGA_HWMON_TYPE_VOLT:
+		p = &priv->voltage;
+		break;
+	default:
+		return -ENODATA;
+	}
+	if (p->n >= SOCFPGA_HWMON_MAXSENSORS)
+		return -ENOSPC;
+
+	p->names[p->n] = label;
+	p->chan[p->n] = val;
+	p->n++;
+
+	return 0;
+}
+
+static int socfpga_probe_child_from_dt(struct device *dev,
+				       struct device_node *child,
+				       struct socfpga_hwmon_priv *priv)
+{
+	struct device_node *grandchild;
+	const char *label;
+	const char *type;
+	u32 val;
+	int ret;
+
+	if (of_property_read_string(child, "name", &type))
+		return dev_err_probe(dev, -EINVAL, "No type for %pOF\n", child);
+
+	for_each_child_of_node(child, grandchild) {
+		ret = of_property_read_u32(grandchild, "reg", &val);
+		if (ret)
+			return dev_err_probe(dev, ret, "missing reg property of %pOF\n",
+					     grandchild);
+
+		ret = of_property_read_string(grandchild, "label", &label);
+		if (ret)
+			return dev_err_probe(dev, ret, "missing label propoerty of %pOF\n",
+					     grandchild);
+		ret = socfpga_add_channel(dev, type, val, label, priv);
+		if (ret == -ENOSPC)
+			return dev_err_probe(dev, ret, "too many channels, only %d supported\n",
+					     SOCFPGA_HWMON_MAXSENSORS);
+	}
+	return 0;
+}
+
+static int socfpga_probe_from_dt(struct device *dev,
+				 struct socfpga_hwmon_priv *priv)
+{
+	const struct device_node *np = dev->of_node;
+	struct device_node *child;
+	int ret = 0;
+
+	for_each_child_of_node(np, child) {
+		ret = socfpga_probe_child_from_dt(dev, child, priv);
+		if (ret)
+			break;
+	}
+	of_node_put(child);
+
+	return ret;
+}
+
+static int socfpga_hwmon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct socfpga_hwmon_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->client.dev = dev;
+	priv->client.priv = priv;
+
+	ret = socfpga_probe_from_dt(dev, priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to probe from device tree\n");
+
+	mutex_init(&priv->lock);
+	init_completion(&priv->completion);
+	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
+							  SVC_CLIENT_HWMON);
+	if (IS_ERR(priv->chan))
+		return dev_err_probe(dev, PTR_ERR(priv->chan),
+				     "couldn't get service channel %s\n",
+				     SVC_CLIENT_RSU);
+
+	priv->hwmon_dev = devm_hwmon_device_register_with_info(dev, "socfpgahwmon",
+							       priv,
+							       &socfpga_chip_info,
+							       NULL);
+	if (IS_ERR(priv->hwmon_dev))
+		return PTR_ERR(priv->hwmon_dev);
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int socfpga_hwmon_remove(struct platform_device *pdev)
+{
+	struct socfpga_hwmon_priv *priv = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(priv->hwmon_dev);
+	stratix10_svc_free_channel(priv->chan);
+	return 0;
+}
+
+static const struct of_device_id socfpga_of_match[] = {
+	{ .compatible = "intel,socfpga-hwmon" },
+	{ .compatible = "intel,socfpga-agilex-hwmon" },
+	{ .compatible = "intel,socfpga-n5x-hwmon" },
+	{ .compatible = "intel,socfpga-stratix10-hwmon" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, socfpga_of_match);
+
+static struct platform_driver socfpga_hwmon_driver = {
+	.driver = {
+		.name = "socfpga-hwmon",
+		.of_match_table = socfpga_of_match,
+	},
+	.probe = socfpga_hwmon_probe,
+	.remove = socfpga_hwmon_remove,
+};
+module_platform_driver(socfpga_hwmon_driver);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("SoCFPGA hardware monitoring features");
+MODULE_LICENSE("GPL");
-- 
2.40.0

