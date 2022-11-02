Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB02616F26
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiKBUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKBUwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:52:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B26438AF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:52:10 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2JrXXd026057;
        Wed, 2 Nov 2022 20:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MpVvkqG2seocK1a7uXpNtzIUVzXr4bfRkn6EzUwZCuE=;
 b=tG4rnkwzRuqGnsACDdCxuMKWvQUWSw6La4ErWyUoxXZ6bfOhpP/VrCaBG1/QefebNUsL
 dbVyWcCnzBXTgG4U3yDFp5nRvk3xyyFHp7023cfslDx76M5/O2ICVNcXucENnzSlqTPQ
 R/HuNJYblX7MNdMpj4qps0/PJjMQQhKTFVGXa4y6zAQ0YGRTrf2axIg9KGWtpObKcKbT
 ZZ12y3+QtRsL85IJGwTjgiL9hnypAV9JAmlF4Me8p+sHLnhNuLdfZSn2OjrPhpBxbeKU
 s7ykC5OdZyefBzEGxR9vvyd2ai6mZ9QQY+JesyyawSaM8WpSpYO2oerWO3hGH8VcJZ6i KQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kky3v1csp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:51:54 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2KoSPT031560;
        Wed, 2 Nov 2022 20:51:54 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03wdc.us.ibm.com with ESMTP id 3kgut9w3wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:51:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2KprQr19333670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 20:51:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E64365806C;
        Wed,  2 Nov 2022 20:51:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E12DB58069;
        Wed,  2 Nov 2022 20:51:51 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.200.160])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 20:51:51 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, eajames@linux.ibm.com
Subject: [PATCH v2 2/5] drivers: fsi: Add I2C Responder driver
Date:   Wed,  2 Nov 2022 15:51:45 -0500
Message-Id: <20221102205148.1334459-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102205148.1334459-1-eajames@linux.ibm.com>
References: <20221102205148.1334459-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hyYmcbdSsV7CTxUX0-gApOGcmR8tGR0Q
X-Proofpoint-ORIG-GUID: hyYmcbdSsV7CTxUX0-gApOGcmR8tGR0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a regmap driver for the I2C Responder (I2CR) which provides
access to an FSI CFAM through an I2C endpoint device. Since no
userspace access is needed, simply provide a regmap bus for the
CFAM address space through the I2CR.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/Kconfig  |   6 +++
 drivers/fsi/Makefile |   1 +
 drivers/fsi/i2cr.c   | 116 +++++++++++++++++++++++++++++++++++++++++++
 drivers/fsi/i2cr.h   |  19 +++++++
 4 files changed, 142 insertions(+)
 create mode 100644 drivers/fsi/i2cr.c
 create mode 100644 drivers/fsi/i2cr.h

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index e6668a869913..c6049a7bc0dd 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -67,6 +67,12 @@ config FSI_SCOM
 	help
 	This option enables an FSI based SCOM device driver.
 
+config FSI_I2CR
+	tristate "I2C Responder device driver"
+	help
+	  This option enables the I2C client driver for the IBM POWER I2C
+	  responder which gives access to CFAM address space.
+
 config FSI_SBEFIFO
 	tristate "SBEFIFO FSI client device driver"
 	depends on OF_ADDRESS
diff --git a/drivers/fsi/Makefile b/drivers/fsi/Makefile
index da218a1ad8e1..c49d7e65ee5b 100644
--- a/drivers/fsi/Makefile
+++ b/drivers/fsi/Makefile
@@ -6,5 +6,6 @@ obj-$(CONFIG_FSI_MASTER_ASPEED) += fsi-master-aspeed.o
 obj-$(CONFIG_FSI_MASTER_GPIO) += fsi-master-gpio.o
 obj-$(CONFIG_FSI_MASTER_AST_CF) += fsi-master-ast-cf.o
 obj-$(CONFIG_FSI_SCOM) += fsi-scom.o
+obj-$(CONFIG_FSI_I2CR) += i2cr.o
 obj-$(CONFIG_FSI_SBEFIFO) += fsi-sbefifo.o
 obj-$(CONFIG_FSI_OCC) += fsi-occ.o
diff --git a/drivers/fsi/i2cr.c b/drivers/fsi/i2cr.c
new file mode 100644
index 000000000000..4d3c90fc198f
--- /dev/null
+++ b/drivers/fsi/i2cr.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#define I2CR_STATUS		0x30001
+#define  I2CR_STATUS_ERR	 BIT(29)
+
+static bool i2cr_check_parity(u32 v, bool parity)
+{
+	u32 i;
+
+	for (i = 0; i < 32; ++i) {
+		if (v & (1 << i))
+			parity = !parity;
+	}
+
+	return parity;
+}
+
+static __be32 i2cr_get_command(u32 address, bool parity)
+{
+	address <<= 1;
+
+	if (i2cr_check_parity(address, parity))
+		address |= 1;
+
+	return cpu_to_be32(address);
+}
+
+static int i2cr_transfer(struct i2c_client *client, u32 address, u32 *data)
+{
+	struct i2c_msg msgs[2];
+	__be32 response[2];
+	__be32 command;
+	int ret;
+
+	command = i2cr_get_command(address, false);
+	msgs[0].addr = client->addr;
+	msgs[0].flags = 0;
+	msgs[0].len = sizeof(command);
+	msgs[0].buf = (__u8 *)&command;
+	msgs[1].addr = client->addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = sizeof(response);
+	msgs[1].buf = (__u8 *)response;
+
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret == 2) {
+		*data = be32_to_cpu(response[0]);
+		return 0;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return -EIO;
+}
+
+static int i2cr_check_status(struct i2c_client *client)
+{
+	u32 status;
+	int ret;
+
+	ret = i2cr_transfer(client, I2CR_STATUS, &status);
+	if (ret)
+		return ret;
+
+	if (status & I2CR_STATUS_ERR)
+		return -EREMOTEIO;
+
+	return 0;
+}
+
+static int i2cr_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct i2c_client *client = context;
+	int ret;
+	u32 v;
+
+	ret = i2cr_transfer(client, (u32)reg, &v);
+	if (ret)
+		return ret;
+
+	*val = v;
+	return i2cr_check_status(client);
+}
+
+static int i2cr_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct i2c_client *client = context;
+	__be32 data[3];
+	int ret;
+
+	data[0] = i2cr_get_command((u32)reg, i2cr_check_parity((u32)val, false));
+	data[1] = cpu_to_be32((u32)val);
+
+	ret = i2c_master_send(client, (const char *)data, sizeof(data));
+	if (ret == sizeof(data))
+		return i2cr_check_status(client);
+
+	if (ret < 0)
+		return ret;
+
+	return -EIO;
+}
+
+const struct regmap_bus regmap_bus_i2cr = {
+	.reg_write = i2cr_reg_write,
+	.reg_read = i2cr_reg_read,
+};
+EXPORT_SYMBOL_GPL(regmap_bus_i2cr);
+
+MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
+MODULE_DESCRIPTION("IBM I2C Responder driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/fsi/i2cr.h b/drivers/fsi/i2cr.h
new file mode 100644
index 000000000000..681945713843
--- /dev/null
+++ b/drivers/fsi/i2cr.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) IBM Corporation 2022 */
+
+#ifndef DRIVERS_I2CR_H
+#define DRIVERS_I2CR_H
+
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+extern const struct regmap_bus regmap_bus_i2cr;
+
+#define init_i2cr(client, config)	\
+	__regmap_lockdep_wrapper(__regmap_init, #config, &(client)->dev, &regmap_bus_i2cr, \
+				 client, config)
+#define devm_init_i2cr(client, config)	\
+	__regmap_lockdep_wrapper(__devm_regmap_init, #config, &(client)->dev, &regmap_bus_i2cr, \
+				 client, config)
+
+#endif /* DRIVERS_I2CR_H */
-- 
2.31.1

