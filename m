Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF46C499E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCVLr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjCVLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:47:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E2D61536;
        Wed, 22 Mar 2023 04:46:54 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MBR3Ob019059;
        Wed, 22 Mar 2023 11:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dCkWgDXPHL7UMRjkixDeGBJDy3gX9OY9N/nQn9w0XWw=;
 b=XTh5chKm/z0ooaBuHiOZ8WZD4QCaV8jcTOCAsoTsk0kjJqfxJw2iS4kINr0+wXrCkkax
 aa2rzBEkRdLGF8a9VdmI9c2NQvCYrrwJC+nCftspQE5srWCYaX30fMVcsK1Seu6qIoK1
 SbGqS3IoSa9A86VZ16V2mhVPKEeA6ydNDacpy2DGza29bM+sNKgig+pFBPnFKqn7ZJtW
 h177ibg4nJKBwOm0wP9XmvVyPe8yOWsRq+Q+1JPPK0Q6p99f+M5k+EVsO6R/JAkKRETl
 6aJAjrjjtJpayhYFnhaBKV5R7Z3Ya8F9mEvXZoaZdaeNQZlbwd04OUx+DUR9Fw9UQT7T aw== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pg0tg8dbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 11:46:31 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32MAJaEK020716;
        Wed, 22 Mar 2023 11:46:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x782kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 11:46:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32MBkUUj328404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 11:46:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2200E58056;
        Wed, 22 Mar 2023 11:46:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1319958052;
        Wed, 22 Mar 2023 11:46:30 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Mar 2023 11:46:30 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id CEF7574A47A; Wed, 22 Mar 2023 06:46:29 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v4 3/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Date:   Wed, 22 Mar 2023 06:46:21 -0500
Message-Id: <20230322114623.2278920-4-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230322114623.2278920-1-lakshmiy@us.ibm.com>
References: <20230322114623.2278920-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yQDGLLTNPNHtzigleq1NWpc7Sj9Xur28
X-Proofpoint-ORIG-GUID: yQDGLLTNPNHtzigleq1NWpc7Sj9Xur28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_08,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220082
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

