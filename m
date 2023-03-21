Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ACE6C3A00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCUTKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCUTJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:09:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A2A1EBE7;
        Tue, 21 Mar 2023 12:09:57 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LIo9xS030248;
        Tue, 21 Mar 2023 19:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dCkWgDXPHL7UMRjkixDeGBJDy3gX9OY9N/nQn9w0XWw=;
 b=Dyq3Tsg8kvjNa2UQ3dn3paw7clReRPEeoMb/bDSHbl4MvUPBMA9v7v4yTupjLoWIjieb
 bvFIek5Je/Q1q2aW0lDk2uoEe9bFVpfmBN9TkFncOtVVITZO1Le5dnrZ6jRZpiqF6tCV
 IkFCpgJiWItYaLu7YiJc9vwjETkS03l+9tkPxPEc6rc3AsbRL8Xhd9LfFESzuJK5Ceka
 NNqsA4IDAd/5GFpD0tiVIDUH5l+daFQmD+2hCA+RJRpxq03oOdgUIsGhqE07zEj24L/5
 XfK6LAWF8IbdBFcmqThP3r9CH/ZL7yQL08oRpQlkWRwTDthxWSKZTZqjsHtlDrqMT249 JQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pfc52v189-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 19:09:34 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LIr5u0001310;
        Tue, 21 Mar 2023 19:09:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x74bq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 19:09:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LJ9U1J33882674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 19:09:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAC3958059;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A453658043;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 2816F74A47E; Tue, 21 Mar 2023 14:09:30 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v3 3/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Date:   Tue, 21 Mar 2023 14:09:12 -0500
Message-Id: <20230321190914.2266216-4-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230321190914.2266216-1-lakshmiy@us.ibm.com>
References: <20230321190914.2266216-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _NSsm_66GOy7OVtyGuf-TT3WQ7RaXDzu
X-Proofpoint-ORIG-GUID: _NSsm_66GOy7OVtyGuf-TT3WQ7RaXDzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210152
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the driver to support ACBEL FSG032 power supply.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 drivers/hwmon/pmbus/Kconfig        |  9 +++
 drivers/hwmon/pmbus/Makefile       |  1 +
 drivers/hwmon/pmbus/acbel-fsg032.c | 96 ++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
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
index 000000000000..7bfa0bf048db
--- /dev/null
+++ b/drivers/hwmon/pmbus/acbel-fsg032.c
@@ -0,0 +1,96 @@
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
+struct acbel_fsg032 {
+	struct i2c_client *client;
+};
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
+	struct acbel_fsg032 *psu;
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
+	rc = pmbus_do_probe(client, &acbel_fsg032_info);
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

