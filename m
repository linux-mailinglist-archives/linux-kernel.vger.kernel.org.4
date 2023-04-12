Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9676DEB03
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjDLFXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDLFXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:23:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DDE4EE8;
        Tue, 11 Apr 2023 22:23:42 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C4EEDo024325;
        Wed, 12 Apr 2023 05:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=i4yyxoqt64EVG4opA6MYgBIeTbldFE/+ZzvjVZTuZmc=;
 b=Z3hOkXHzTtyYHuwOF4gZuBU78IU9S3vg//NYIuVa+nOV6BIc5ZerbshaF2fnfBbYA8MZ
 MwInfpQeXqvPh8AfGRPcEHVCv4DYih9jNK1kEBlsifX4sNkDY5V0tpqW4Vh4HyEAU4w4
 fayl3ySvigE2wvm6nxJ5gPbjzK9CuG6lv6Dxd2G2eGDEnTlDyU8+PQqg9o9nLJ6I3k1N
 fuJ/q1wY69V/AdzkbHOtODwat38Kb1+3GcsMyO0wBK3NFFq35UvZl89EKeay8z76Qia8
 MTzO2f0y2antJTEm72u2aaxJk0uNtEe+xW7j3QFcoF3lax3x4OiUbh6QPNgncFlk1RTC ig== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwneesv8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:12 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C2YmuA027956;
        Wed, 12 Apr 2023 05:23:11 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pu0jj93b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C5N9Ov37421728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 05:23:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E39B85807F;
        Wed, 12 Apr 2023 05:23:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE80F5807C;
        Wed, 12 Apr 2023 05:23:08 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Apr 2023 05:23:08 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id A4B6074514E; Wed, 12 Apr 2023 00:23:08 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v6 3/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Date:   Wed, 12 Apr 2023 00:23:03 -0500
Message-Id: <20230412052305.1369521-4-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
References: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7p3nF2AIP4PcNMoRfarm7h-sRL8w0u-P
X-Proofpoint-ORIG-GUID: 7p3nF2AIP4PcNMoRfarm7h-sRL8w0u-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the driver to support ACBEL FSG032 power supply.

Change-Id: Ief984325fe3fa0ed042e1d00e34ff579b45e1c81
Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 drivers/hwmon/pmbus/Kconfig        |  9 +++
 drivers/hwmon/pmbus/Makefile       |  1 +
 drivers/hwmon/pmbus/acbel-fsg032.c | 95 ++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/acbel-fsg032.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 59d9a7430499..270b6336b76d 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -27,6 +27,15 @@ config SENSORS_PMBUS
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
 
+config SENSORS_ACBEL_FSG032
+	tristate "ACBEL FSG032 Power Supply"
+	help
+	  If you say yes here you get hardware monitoring support for the ACBEL
+	  FSG032 Power Supply.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called acbel-fsg032.
+
 config SENSORS_ADM1266
 	tristate "Analog Devices ADM1266 Sequencer"
 	select CRC8
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 3ae019916267..84ee960a6c2d 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_PMBUS)		+= pmbus_core.o
 obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
+obj-$(CONFIG_SENSORS_ACBEL_FSG032) += acbel-fsg032.o
 obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
diff --git a/drivers/hwmon/pmbus/acbel-fsg032.c b/drivers/hwmon/pmbus/acbel-fsg032.c
new file mode 100644
index 000000000000..f160f45c7ac5
--- /dev/null
+++ b/drivers/hwmon/pmbus/acbel-fsg032.c
@@ -0,0 +1,95 @@
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
+static const struct i2c_device_id acbel_fsg032_id[] = {
+	{ "acbel_fsg032" },
+	{}
+};
+
+static struct pmbus_driver_info acbel_fsg032_info = {
+	.pages = 1,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
+		   PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT |
+		   PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
+		   PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_VOUT |
+		   PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_TEMP |
+		   PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_FAN12,
+};
+
+static int acbel_fsg032_probe(struct i2c_client *client)
+{
+	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
+	struct device *dev = &client->dev;
+	struct dentry *debugfs;
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
+	rc = pmbus_do_probe(client, &acbel_fsg032_info);
+	if (rc)
+		return rc;
+
+	debugfs = pmbus_get_debugfs_dir(client);
+	if (!debugfs)
+		return rc;
+
+	/* ccin is not available, create a symlink from the
+	 * mfr_serial to ccin as required by hwmon */
+	debugfs_create_symlink("ccin", debugfs, "mfr_serial");
+
+	return 0;
+}
+
+static const struct of_device_id acbel_fsg032_of_match[] = {
+	{ .compatible = "acbel,fsg032" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, acbel_fsg032_of_match);
+
+static struct i2c_driver acbel_fsg032_driver = {
+	.driver = {
+		.name = "acbel-fsg032",
+		.of_match_table = acbel_fsg032_of_match,
+	},
+	.probe_new = acbel_fsg032_probe,
+	.id_table = acbel_fsg032_id,
+};
+
+module_i2c_driver(acbel_fsg032_driver);
+
+MODULE_AUTHOR("Lakshmi Yadlapati");
+MODULE_DESCRIPTION("PMBus driver for AcBel Power System power supplies");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.37.2

