Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4171F6DC267
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 03:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDJBpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 21:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDJBph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 21:45:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406632D6B;
        Sun,  9 Apr 2023 18:45:36 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 339Nr3WI000924;
        Mon, 10 Apr 2023 01:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YEeEucWqMdvl/w0fHu13v3UetqaV1bCa2Ep4Ai1Qeg4=;
 b=JIAYN+ZY4nJDVjYIwgLqswh9oZgKab5RtOxcNA6DoX31juoCw3t1I0m6QA2CmsJsgu4a
 2ZuGWt+tyo6UOO1KB0rzc/UMiiVvFIFe/WodL1EQpYPgN9M1bWKdkaoQW4F9eJhcxGOq
 1jbO9u6zQKqRzLnskGVq8dBfaamO8bEhXd/OpXT+nR3+nRtQYxAwQOLZqDBQ0PSjA0n9
 7bfCJU/ufqw7oKlpfJjyluvbOoqmd5qbuQlRbLgCC3Rl63XZeQP95MbXJQnFGjbypYAj
 fpUCCfIhhSlh6mxmZZ1XdkzlOLbFBQEUd+KlGnricSFISMU2vgVsBtMwHBQFmIeTTXFl 4w== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3puj3rthmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 01:45:09 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 339NZUhw018863;
        Mon, 10 Apr 2023 01:45:08 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pu0jgrad5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 01:45:08 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33A1j7N97275166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 01:45:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8D7058069;
        Mon, 10 Apr 2023 01:45:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E449B58056;
        Mon, 10 Apr 2023 01:45:06 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Apr 2023 01:45:06 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id A3F8A74514D; Sun,  9 Apr 2023 20:45:06 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v5 3/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Date:   Sun,  9 Apr 2023 20:44:43 -0500
Message-Id: <20230410014445.458385-4-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230410014445.458385-1-lakshmiy@us.ibm.com>
References: <20230410014445.458385-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jcRVWVHG6gpS8_nslse2-7V77Zm7Ega8
X-Proofpoint-GUID: jcRVWVHG6gpS8_nslse2-7V77Zm7Ega8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-09_18,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100011
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the driver to support ACBEL FSG032 power supply.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 drivers/hwmon/pmbus/Kconfig        |  9 ++++
 drivers/hwmon/pmbus/Makefile       |  1 +
 drivers/hwmon/pmbus/acbel-fsg032.c | 85 ++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
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
index 000000000000..28a25f30e2cf
--- /dev/null
+++ b/drivers/hwmon/pmbus/acbel-fsg032.c
@@ -0,0 +1,85 @@
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

