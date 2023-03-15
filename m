Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD56BBCBC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjCOSx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjCOSx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:53:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B34D508;
        Wed, 15 Mar 2023 11:53:24 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FHvMvJ037381;
        Wed, 15 Mar 2023 18:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QNwjdI5ee+SP7XXkH0heho35d6EH1YrUqB94LyE/BoM=;
 b=EGwqoJw3R9RV1GnLjQVGwBbRbxo2y46AL6gHG8Fpe4qjkCncHRhMCgPVjgOrdUm4RU0G
 RBRI3PDhb8ijl6c5uylS3O0QfLRzKtHKy/W/GN5qliv9Oo9lASY/0pPkde5XaFLdDTnG
 pbp3BFuCFU4ZlSi14lSF89l1UeirUoysONlM2LkaS7FgnhmTIGAXM+sDwxBHXUVCHYDm
 TQTYD0M2zCSEdWlN92mBiuhpbhif0YUqshdM86Ta7qrQIsC+1J5Ea71+Jontqj5dv5Xg
 bcI3cjvSly3U22fnbbEHDmvauzTP9porZZez1XE2YoNHtMrxHL9kMre1bkSTsuaGdTux AA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbf9g0bfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 18:53:09 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32FH6dHJ031172;
        Wed, 15 Mar 2023 18:53:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3pb29r4tsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 18:53:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32FIr7e79568900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 18:53:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2DF858055;
        Wed, 15 Mar 2023 18:53:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A8E858043;
        Wed, 15 Mar 2023 18:53:07 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Mar 2023 18:53:07 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 38DD774A47B; Wed, 15 Mar 2023 13:53:07 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     linux@roeck-us.net, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH 3/4] hwmon: (pmbus/acbel-crps) Add Acbel CRPS power supply driver
Date:   Wed, 15 Mar 2023 13:53:03 -0500
Message-Id: <20230315185303.960368-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zxUbvNJCOs94Np4cajdT11F40ggAoDdU
X-Proofpoint-ORIG-GUID: zxUbvNJCOs94Np4cajdT11F40ggAoDdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_10,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2302240000
 definitions=main-2303150155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the driver to support Acbel CRPS power supply.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 drivers/hwmon/pmbus/Kconfig      |   9 +
 drivers/hwmon/pmbus/Makefile     |   1 +
 drivers/hwmon/pmbus/acbel-crps.c | 311 +++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/acbel-crps.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 59d9a7430499..9fe7ac94cfa2 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -27,6 +27,15 @@ config SENSORS_PMBUS
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
 
+config SENSORS_ACBEL_CRPS
+	tristate "ACBEL CRPS Power Supply"
+	help
+	  If you say yes here you get hardware monitoring support for the ACBEL
+	  CRPS power supply.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called acbel-crps.
+
 config SENSORS_ADM1266
 	tristate "Analog Devices ADM1266 Sequencer"
 	select CRC8
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 3ae019916267..39aef0cb9934 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_PMBUS)		+= pmbus_core.o
 obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
+obj-$(CONFIG_SENSORS_ACBEL_CRPS) += acbel-crps.o
 obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
diff --git a/drivers/hwmon/pmbus/acbel-crps.c b/drivers/hwmon/pmbus/acbel-crps.c
new file mode 100644
index 000000000000..f7779f0fbb2d
--- /dev/null
+++ b/drivers/hwmon/pmbus/acbel-crps.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2023 IBM Corp.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pmbus.h>
+#include <linux/hwmon-sysfs.h>
+#include "pmbus.h"
+
+#define CRPS_MFG_ID_CMD                 0x99
+#define CRPS_MFG_MODEL_CMD              0x9A
+#define CRPS_MFG_REVISION_CMD           0x9B
+#define CRPS_MFG_LOCATION_CMD           0x9C
+#define CRPS_MFG_SERIAL_CMD             0x9E
+#define CRPS_CCIN_CMD                   CRPS_MFG_SERIAL_CMD
+
+/* STATUS_VOUT */
+#define CRPS_STATUS_UV_FAULT            BIT(4)
+#define CRPS_STATUS_OV_FAULT            BIT(7)
+
+/* STATUS_IOUT */
+#define CRPS_STATUS_OP_WARNING          BIT(0)
+#define CRPS_STATUS_OP_FAULT            BIT(1)
+#define CRPS_STATUS_OC_WARNING          BIT(5)
+#define CRPS_STATUS_OC_FAULT            BIT(7)
+
+/* STATUS_TEMP */
+#define CRPS_STATUS_OT_WARNING          BIT(6)
+#define CRPS_STATUS_OT_FAULT            BIT(7)
+
+/* STATUS_FAN12 */
+#define CRPS_FAN1_SPEED_OVERRIDE        BIT(2)
+#define CRPS_FAN1_WARNING               BIT(5)
+#define CRPS_FAN1_FAULT                 BIT(7)
+
+enum {
+	CRPS_DEBUGFS_MFG_ID,
+	CRPS_DEBUGFS_MFG_MODEL,
+	CRPS_DEBUGFS_MFG_REVISION,
+	CRPS_DEBUGFS_MFG_LOCATION,
+	CRPS_DEBUGFS_MFG_SERIAL,
+	CRPS_DEBUGFS_CCIN,
+	CRPS_DEBUGFS_NUM_ENTRIES
+};
+
+struct acbel_crps {
+	struct i2c_client *client;
+	int debugfs_entries[CRPS_DEBUGFS_NUM_ENTRIES];
+};
+
+static const struct i2c_device_id acbel_crps_id[] = {
+	{ "acbel_crps" },
+	{ }
+};
+#define to_psu(x, y) container_of((x), struct acbel_crps, debugfs_entries[(y)])
+
+static ssize_t acbel_crps_debugfs_read(struct file *file, char __user *buf,
+				       size_t count, loff_t *ppos)
+{
+	u8 cmd;
+	int rc;
+	int *idxp = file->private_data;
+	int idx = *idxp;
+	struct acbel_crps *psu = to_psu(idxp, idx);
+	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
+
+	pmbus_set_page(psu->client, 0, 0xff);
+
+	switch (idx) {
+	case CRPS_DEBUGFS_MFG_ID:
+		cmd = CRPS_MFG_ID_CMD;
+		break;
+	case CRPS_DEBUGFS_MFG_MODEL:
+		cmd = CRPS_MFG_MODEL_CMD;
+		break;
+	case CRPS_DEBUGFS_MFG_REVISION:
+		cmd = CRPS_MFG_REVISION_CMD;
+		break;
+	case CRPS_DEBUGFS_MFG_LOCATION:
+		cmd = CRPS_MFG_LOCATION_CMD;
+		break;
+	case CRPS_DEBUGFS_MFG_SERIAL:
+		cmd = CRPS_MFG_SERIAL_CMD;
+		break;
+	case CRPS_DEBUGFS_CCIN:
+		cmd = CRPS_CCIN_CMD;
+		rc = i2c_smbus_read_block_data(psu->client, cmd, data);
+		if (rc < 0)
+			return rc;
+		data[4] = '\n';
+		data[5] = '\0';
+		rc = 6;
+		goto done;
+	default:
+		return -EINVAL;
+	}
+
+	rc = i2c_smbus_read_block_data(psu->client, cmd, data);
+	if (rc < 0)
+		return rc;
+	data[rc] = '\n';
+	rc += 2;
+done:
+	return simple_read_from_buffer(buf, count, ppos, data, rc);
+}
+
+static const struct file_operations acbel_crps_fops = {
+	.llseek = noop_llseek,
+	.read = acbel_crps_debugfs_read,
+	.open = simple_open,
+};
+
+static int acbel_crps_read_word_data(struct i2c_client *client, int page,
+				     int phase, int reg)
+{
+	int ret = 0;
+
+	if (page > 0)
+		return -ENXIO;
+
+	switch (reg) {
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+	case PMBUS_OT_WARN_LIMIT:
+	case PMBUS_IIN_OC_FAULT_LIMIT:
+	case PMBUS_IIN_OC_WARN_LIMIT:
+	case PMBUS_POUT_OP_FAULT_LIMIT:
+	case PMBUS_POUT_OP_WARN_LIMIT:
+	case PMBUS_MFR_VIN_MIN:
+	case PMBUS_MFR_VIN_MAX:
+	case PMBUS_MFR_IIN_MAX:
+	case PMBUS_MFR_PIN_MAX:
+	case PMBUS_MFR_VOUT_MIN:
+	case PMBUS_MFR_VOUT_MAX:
+	case PMBUS_MFR_IOUT_MAX:
+	case PMBUS_MFR_POUT_MAX:
+	case PMBUS_PIN_OP_WARN_LIMIT:
+	case PMBUS_READ_VIN:
+	case PMBUS_READ_IIN:
+	case PMBUS_READ_VOUT:
+	case PMBUS_READ_IOUT:
+	case PMBUS_READ_TEMPERATURE_1:
+	case PMBUS_READ_TEMPERATURE_2:
+	case PMBUS_READ_TEMPERATURE_3:
+	case PMBUS_READ_FAN_SPEED_1:
+	case PMBUS_READ_POUT:
+	case PMBUS_READ_PIN:
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+	return ret;
+}
+
+static int acbel_crps_read_byte_data(struct i2c_client *client, int page,
+				     int reg)
+{
+	int ret = 0;
+	int mfg_status;
+
+	if (page >= 0) {
+		ret = pmbus_set_page(client, page, 0xff);
+		if (ret < 0)
+			return ret;
+	}
+
+	switch (reg) {
+	case PMBUS_STATUS_VOUT:
+	case PMBUS_STATUS_IOUT:
+	case PMBUS_STATUS_TEMPERATURE:
+	case PMBUS_STATUS_FAN_12:
+		mfg_status = pmbus_read_word_data(client, 0, 0xff,
+						  PMBUS_STATUS_MFR_SPECIFIC);
+		if (mfg_status < 0)
+			return mfg_status;
+
+		if (reg == PMBUS_STATUS_VOUT) {
+			if (mfg_status & CRPS_STATUS_OV_FAULT)
+				ret |= PB_VOLTAGE_OV_FAULT;
+			else if (mfg_status & CRPS_STATUS_UV_FAULT)
+				ret |= PB_VOLTAGE_UV_FAULT;
+		} else if (reg == PMBUS_STATUS_IOUT) {
+			if (mfg_status & CRPS_STATUS_OC_FAULT)
+				ret |= PB_IOUT_OC_FAULT;
+			else if (mfg_status & CRPS_STATUS_OC_WARNING)
+				ret |= PB_IOUT_OC_WARNING;
+			else if (mfg_status & CRPS_STATUS_OP_FAULT)
+				ret |= PB_POUT_OP_FAULT;
+			else if (mfg_status & CRPS_STATUS_OP_WARNING)
+				ret |= PB_POUT_OP_WARNING;
+		} else if (reg == PMBUS_STATUS_TEMPERATURE) {
+			if (mfg_status & CRPS_STATUS_OT_FAULT)
+				ret |= PB_TEMP_OT_FAULT;
+			else if (mfg_status & CRPS_STATUS_OT_WARNING)
+				ret |= PB_TEMP_OT_WARNING;
+		} else if (reg == PMBUS_STATUS_FAN_12) {
+			if (mfg_status & CRPS_FAN1_FAULT)
+				ret |= PB_FAN_FAN1_FAULT;
+			else if (mfg_status & CRPS_FAN1_WARNING)
+				ret |= PB_FAN_FAN1_WARNING;
+			else if (mfg_status & CRPS_FAN1_SPEED_OVERRIDE)
+				ret |= PB_FAN_FAN1_SPEED_OVERRIDE;
+		}
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static struct pmbus_driver_info acbel_crps_info = {
+        .pages = 1,
+        .func[0] =  PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
+                    PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT |
+                    PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
+                    PMBUS_HAVE_FAN12 |
+                    PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
+                    PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_STATUS_INPUT |
+                    PMBUS_HAVE_STATUS_FAN12 | PMBUS_MFR_IIN_MAX,
+        .read_word_data = acbel_crps_read_word_data,
+        .read_byte_data = acbel_crps_read_byte_data,
+};
+
+
+static int acbel_crps_probe(struct i2c_client *client)
+{
+	struct dentry *acbel_crps_dir;
+	struct dentry *debugfs;
+	struct acbel_crps *psu;
+	int rc, i;
+
+	rc = pmbus_do_probe(client, &acbel_crps_info);
+        if (rc)
+                return rc;
+	/*
+         * Don't fail the probe if there isn't enough memory for debugfs.
+         */
+	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
+	if (!psu)
+		return 0;
+
+	psu->client = client;
+
+	debugfs = pmbus_get_debugfs_dir(client);
+	if (!debugfs)
+		return 0;
+
+	acbel_crps_dir = debugfs_create_dir(client->name, debugfs);
+	if (!acbel_crps_dir)
+		return 0;
+
+	for (i = 0; i < CRPS_DEBUGFS_NUM_ENTRIES; ++i)
+		psu->debugfs_entries[i] = i;
+
+	debugfs_create_file("mfg_id", 0444, acbel_crps_dir,
+			    &psu->debugfs_entries[CRPS_DEBUGFS_MFG_ID],
+			    &acbel_crps_fops);
+
+	debugfs_create_file("part_number", 0444, acbel_crps_dir,
+			    &psu->debugfs_entries[CRPS_DEBUGFS_MFG_MODEL],
+			    &acbel_crps_fops);
+
+	debugfs_create_file("fw_version", 0444, acbel_crps_dir,
+			    &psu->debugfs_entries[CRPS_DEBUGFS_MFG_REVISION],
+			    &acbel_crps_fops);
+
+	debugfs_create_file("mfg_location", 0444, acbel_crps_dir,
+			    &psu->debugfs_entries[CRPS_DEBUGFS_MFG_LOCATION],
+			    &acbel_crps_fops);
+
+	debugfs_create_file("serial_number", 0444, acbel_crps_dir,
+			    &psu->debugfs_entries[CRPS_DEBUGFS_MFG_SERIAL],
+			    &acbel_crps_fops);
+
+	debugfs_create_file("ccin", 0444, acbel_crps_dir,
+			    &psu->debugfs_entries[CRPS_DEBUGFS_CCIN],
+			    &acbel_crps_fops);
+	return 0;
+}
+
+static const struct of_device_id acbel_crps_of_match[] = {
+	{ .compatible = "acbel,crps"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, acbel_crps_of_match);
+
+static struct i2c_driver acbel_crps_driver = {
+	.driver = {
+		.name = "acbel-crps",
+		.of_match_table = acbel_crps_of_match,
+	},
+	.probe_new = acbel_crps_probe,
+	.id_table = acbel_crps_id,
+};
+
+module_i2c_driver(acbel_crps_driver);
+
+MODULE_AUTHOR("Lakshmi Yadlapati");
+MODULE_DESCRIPTION("PMBus driver for AcBel Power System power supplies");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.37.2

