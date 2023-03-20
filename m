Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7376C1A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCTPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjCTPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104584EFC;
        Mon, 20 Mar 2023 08:40:57 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KF3a9F024622;
        Mon, 20 Mar 2023 15:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NyI8geK9k20aFo5hgJaF0Q1RaIoTbttjiZ9pgyo953U=;
 b=OwYHKMmjVmffOEW0a0SXtNtb9IrdYAk2URVA5qW/XpUtBTuhshrzo/0QqDItPljVsxbV
 EOADchJ//cC2N7k7ij5EFxoCgOC/IdVNGMHFeVHwv+G88WGuRmWCpCyIkCAA0K5TLAEA
 fnglwstmGSO1mwG0s7uyGhqbTY+3Cn21GlsQUt3eGysnaJi/ChsZ1jWrx+ExaKqi/bmV
 hgQttiz8mX7Wkwj/kQgWqdAzq4qsWUEHfNZLR+v9bmUeVA3vns/VGJpwexOGxbrUW5rH
 dj+vducT+TdeP9eebHLKNiytOaSSn3HYoIQSnB49g4SgteaLQvA9ndOwh5MqJFby4hEe yg== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pessyry7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:40:33 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KEOEHX020716;
        Mon, 20 Mar 2023 15:40:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x6wjs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:40:33 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KFeVE410617374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 15:40:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB66C58068;
        Mon, 20 Mar 2023 15:40:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2B7058055;
        Mon, 20 Mar 2023 15:40:31 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Mar 2023 15:40:31 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 1E8C774A47E; Mon, 20 Mar 2023 10:40:31 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v2 3/5] hwmon: (pmbus/acbel-crps) Add Acbel CRPS power supply driver
Date:   Mon, 20 Mar 2023 10:40:17 -0500
Message-Id: <20230320154019.1943770-4-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
References: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bxfUuDazjKhegkQ6jhyvDlXNTLA08fFO
X-Proofpoint-ORIG-GUID: bxfUuDazjKhegkQ6jhyvDlXNTLA08fFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_10,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the driver to support Acbel CRPS power supply.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
Changes since V1
- Removed debugfs stuff.
- Removed acbel_crps_read_word_data and acbel_crps_read_byte_data.
- Removed PMBUS_MFR_IIN_MAX.
- Added validation for the supported power supply.
- Fix the formatting.

 drivers/hwmon/pmbus/Kconfig      |  10 +++
 drivers/hwmon/pmbus/Makefile     |   1 +
 drivers/hwmon/pmbus/acbel-crps.c | 102 +++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/acbel-crps.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 59d9a7430499..0215709c3dd2 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -27,6 +27,16 @@ config SENSORS_PMBUS
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
 
+config SENSORS_ACBEL_CRPS
+	tristate "ACBEL CRPS Power Supply"
+	help
+	  If you say yes here you get hardware monitoring support for the ACBEL
+	  Common Redundant Power Supply.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called acbel-crps.
+	  Supported models: FSG032-00xG
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
index 000000000000..ac281699709f
--- /dev/null
+++ b/drivers/hwmon/pmbus/acbel-crps.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2023 IBM Corp.
+ */
+
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pmbus.h>
+#include <linux/hwmon-sysfs.h>
+#include "pmbus.h"
+
+struct acbel_crps {
+	struct i2c_client *client;
+};
+
+static const struct i2c_device_id acbel_crps_id[] = {
+	{ "acbel_crps" },
+	{}
+};
+#define to_psu(x, y) container_of((x), struct acbel_crps, debugfs_entries[(y)])
+
+static const struct file_operations acbel_crps_fops = {
+	.llseek = noop_llseek,
+	.open = simple_open,
+};
+
+static struct pmbus_driver_info acbel_crps_info = {
+	.pages = 1,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
+		   PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT |
+		   PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
+		   PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_VOUT |
+		   PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_TEMP |
+		   PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_FAN12,
+};
+
+static int acbel_crps_probe(struct i2c_client *client)
+{
+	struct acbel_crps *psu;
+	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
+	struct device *dev = &client->dev;
+	int rc;
+
+	rc = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
+	if (rc < 0) {
+		dev_err(dev, "Failed to read PMBUS_MFR_ID\n");
+		return rc;
+	}
+	if (strncmp(buf, "ACBEL", 5)) {
+		buf[rc] = '\0';
+		dev_err(dev, "Manufacturer '%s' not supported\n", buf);
+		return -ENODEV;
+	}
+
+	rc = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
+	if (rc < 0) {
+		dev_err(dev, "Failed to read PMBUS_MFR_MODEL\n");
+		return rc;
+	}
+
+	if (strncmp(buf, "FSG032", 6)) {
+		buf[rc] = '\0';
+		dev_err(dev, "Model '%s' not supported\n", buf);
+		return -ENODEV;
+	}
+
+	rc = pmbus_do_probe(client, &acbel_crps_info);
+	if (rc)
+		return rc;
+	/*
+         * Don't fail the probe if there isn't enough memory for debugfs.
+         */
+	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
+	if (!psu)
+		return 0;
+
+	return 0;
+}
+
+static const struct of_device_id acbel_crps_of_match[] = {
+	{ .compatible = "acbel,crps" },
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

