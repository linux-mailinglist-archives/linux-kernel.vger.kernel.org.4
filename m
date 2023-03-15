Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8CD6BB045
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCOMQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjCOMQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:16:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2108E3E4;
        Wed, 15 Mar 2023 05:16:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32FCFtrB6024487, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32FCFtrB6024487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 15 Mar 2023 20:15:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Mar 2023 20:16:07 +0800
Received: from localhost (172.21.177.105) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 15 Mar
 2023 20:16:07 +0800
Date:   Wed, 15 Mar 2023 20:16:06 +0800
From:   phinex <phinex@realtek.com>
To:     <jdelvare@suse.com>
CC:     <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <phinex@realtek.com>
Subject: [PATCH v1] hwmon: drivetemp: support to be a platform driver for thermal_of
Message-ID: <20230315121606.GA71707@threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.21.177.105]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support thermal zone so that we can just rely on dts to describe a
thermal zone and do the cooling operations.

You can define a comptible string "drivetemp,hdd-sensors" to enable
this, such as

	sata_port0: sata-port@0 {
		compatible = "drivetemp,hdd-sensors";
		#thermal-sensor-cells = <0>;
	}

Then define a thermal with this sensor to get it work.

               hdd_thermal: hdd-thermal {
                       thermal-sensors = <&sata_port0>;
		}

In most of the SoC systems, using dts to handle cooling is common.
This can eliminate the usage of user space application to check
the value exported in hwmon and then through sysfs to cooling.

Signed-off-by: phinex <phinex@realtek.com>

---
 .../bindings/hwmon/drivetemp,hdd-sensors.yaml |  35 ++++++
 drivers/hwmon/drivetemp.c                     | 102 +++++++++++++++++-
 2 files changed, 133 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml b/Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml
new file mode 100644
index 000000000000..939d7a923e94
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/drivetemp,hdd-sensors.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Drivetemp Temperature Monitor
+
+maintainers:
+  - Phinex <phinex@realtek.com>
+
+description: |
+  Drivetemp Temperature Monitor that support a single thermal zone
+  This single thermal zone can support multiple hard drives,
+  it uses maximal temperature of these hard drivers as its temp value.
+
+properties:
+  compatible:
+    enum:
+      - drivetemp,hdd-sensors
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    sata_port0: sata-port@0 {
+        ompatible = "drivetemp,hdd-sensors";
+        #thermal-sensor-cells = <0>;
+    };
diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
index 1eb37106a220..9a60315d732c 100644
--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -107,6 +107,14 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_driver.h>
 #include <scsi/scsi_proto.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+#include <linux/libata.h>
+
+/*A single thermal_zone for all HDD sensors */
+static struct thermal_zone_device *tz;
+#define MAX_NAME_LEN 255
 
 struct drivetemp_data {
 	struct list_head list;		/* list of instantiated devices */
@@ -126,6 +134,7 @@ struct drivetemp_data {
 	int temp_max;			/* max temp */
 	int temp_lcrit;			/* lower critical limit */
 	int temp_crit;			/* critical limit */
+	u8 drivename[MAX_NAME_LEN];     /* Keep the drive name for each hdd*/
 };
 
 static LIST_HEAD(drivetemp_devlist);
@@ -537,6 +546,46 @@ static const struct hwmon_channel_info *drivetemp_info[] = {
 	NULL
 };
 
+#if IS_ENABLED(CONFIG_THERMAL_OF)
+static int hdd_read_temp(void *data, int *temp)
+{
+	int err;
+	struct drivetemp_data *st = data;
+	long value, max = 0;
+
+	list_for_each_entry(st, &drivetemp_devlist, list) {
+		mutex_lock(&st->lock);
+		err = st->get_temp(st, hwmon_temp_input, &value);
+		mutex_unlock(&st->lock);
+
+		if (value > max)
+			max = value;
+	}
+
+	/*non-existent sensor or not ready*/
+	if (max == 0)
+		return -EAGAIN;
+
+	*temp = (int)max;
+
+	dev_dbg(st->dev, "%s, sensor read %d\n", __func__, *temp);
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops hdd_sensor_ops = {
+	.get_temp = hdd_read_temp,
+};
+
+static const struct of_device_id hdd_of_match[] = {
+	{
+		.compatible = "drivetemp,hdd-sensors",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, hdd_of_match);
+#endif
+
 static const struct hwmon_ops drivetemp_ops = {
 	.is_visible = drivetemp_is_visible,
 	.read = drivetemp_read,
@@ -556,11 +605,16 @@ static int drivetemp_add(struct device *dev, struct class_interface *intf)
 	struct scsi_device *sdev = to_scsi_device(dev->parent);
 	struct drivetemp_data *st;
 	int err;
+	struct ata_port *ap;
 
 	st = kzalloc(sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
 
+	ap = ata_shost_to_port(sdev->host);
+
+	snprintf(st->drivename, MAX_NAME_LEN, "drivetemp_port%d", ap->port_no);
+
 	st->sdev = sdev;
 	st->dev = dev;
 	mutex_init(&st->lock);
@@ -570,9 +624,9 @@ static int drivetemp_add(struct device *dev, struct class_interface *intf)
 		goto abort;
 	}
 
-	st->hwdev = hwmon_device_register_with_info(dev->parent, "drivetemp",
-						    st, &drivetemp_chip_info,
-						    NULL);
+	st->hwdev = hwmon_device_register_with_info(
+		dev->parent, st->drivename, st, &drivetemp_chip_info, NULL);
+
 	if (IS_ERR(st->hwdev)) {
 		err = PTR_ERR(st->hwdev);
 		goto abort;
@@ -605,14 +659,54 @@ static struct class_interface drivetemp_interface = {
 	.remove_dev = drivetemp_remove,
 };
 
+#if IS_ENABLED(CONFIG_THERMAL_OF)
+static int hdd_hwmon_probe(struct platform_device *pdev)
+{
+	if (list_empty(&drivetemp_devlist))
+		return -EPROBE_DEFER;
+
+	if (!tz)
+		devm_thermal_zone_of_sensor_register(
+			&pdev->dev, 0, &drivetemp_devlist, &hdd_sensor_ops);
+
+	return 0;
+}
+
+static int hdd_hwmon_remove(struct platform_device *dev)
+{
+	thermal_zone_device_unregister(tz);
+	tz = NULL;
+	return 0;
+}
+
+static struct platform_driver hdd_hwmon_platdrv = {
+	.driver = {
+		.name   = "hdd-hwmon",
+		.of_match_table = hdd_of_match,
+	},
+	.probe          = hdd_hwmon_probe,
+	.remove		= hdd_hwmon_remove,
+};
+#endif
+
 static int __init drivetemp_init(void)
 {
-	return scsi_register_interface(&drivetemp_interface);
+	int ret;
+
+	ret = scsi_register_interface(&drivetemp_interface);
+#if IS_ENABLED(CONFIG_THERMAL_OF)
+	if (ret == 0)
+		ret = platform_driver_register(&hdd_hwmon_platdrv);
+#endif
+	return ret;
 }
 
 static void __exit drivetemp_exit(void)
 {
 	scsi_unregister_interface(&drivetemp_interface);
+#if IS_ENABLED(CONFIG_THERMAL_OF)
+	platform_driver_unregister(&hdd_hwmon_platdrv);
+#endif
 }
 
 module_init(drivetemp_init);
-- 
2.17.1

