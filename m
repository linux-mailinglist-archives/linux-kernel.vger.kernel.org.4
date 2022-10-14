Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B485FF5EA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJNWGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJNWGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:06:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23F19E03F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:05:59 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ELPs2A034421;
        Fri, 14 Oct 2022 22:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Yi2gQIfN0zGArd3FdBfvw2OkPXUU6h5x/AA0k3wHtb8=;
 b=KQ/xPW1c1KwmsB71NrFyzxhtSVQCSeZC7jdK/qzBvsSXZlSi3KhUhT6EU7cRoaqA5lAt
 ON7z6k9JEH0Q5WBOh5ixs72OmzQ9oiI3aVWTLMyZzq8r/SAib+A0qkMjdlpa0us3Tzou
 nKoqKkwsFb1D6T+a9f1IveVRDe7w6oL/H1qIJi/jYuomCZYLU1uGP7yaGJY1Z4hH0Lil
 /XthhRR3M2a/H9xZsZxPdaUBrX6oJXShANj3T31Cewud6aF5XSrH8Kwl4t2qzN6MlFH0
 C5OiQ5hq7Wr7HfGq50NvBwt9hWGYhadt/YoS19yd7VDwlrZbgRYXOAhtcqSACqYPJq2M 8w== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k7e6e3h9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:05:47 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29ELoItF018573;
        Fri, 14 Oct 2022 22:05:47 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 3k6kcmkyf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:05:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29EM5jj91180268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 22:05:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8F5D58055;
        Fri, 14 Oct 2022 22:05:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9E1B58056;
        Fri, 14 Oct 2022 22:05:43 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.52.204])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Oct 2022 22:05:43 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     broonie@kernel.org, jk@ozlabs.org, alistair@popple.id.au,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        eajames@linux.ibm.com
Subject: [PATCH 2/5] regmap: Add IBM I2CR support
Date:   Fri, 14 Oct 2022 17:05:37 -0500
Message-Id: <20221014220540.55570-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221014220540.55570-1-eajames@linux.ibm.com>
References: <20221014220540.55570-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q7788RlpKNTHixFYlBzAhHPlWiANN-KW
X-Proofpoint-ORIG-GUID: q7788RlpKNTHixFYlBzAhHPlWiANN-KW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_11,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regmap support for the IBM I2CR. The I2CR (I2C Responder) is an
I2C end-point device that provides access to an IBM POWER CFAM, which
has traditionally been accessed over FSI.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/base/regmap/Kconfig           |   4 +
 drivers/base/regmap/Makefile          |   1 +
 drivers/base/regmap/regmap-ibm-i2cr.c | 159 ++++++++++++++++++++++++++
 include/linux/regmap.h                |  35 ++++++
 4 files changed, 199 insertions(+)
 create mode 100644 drivers/base/regmap/regmap-ibm-i2cr.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index cd4bb642b9de..71af079a1b67 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -69,3 +69,7 @@ config REGMAP_SPI_AVMM
 config REGMAP_FSI
 	tristate
 	depends on FSI
+
+config REGMAP_IBM_I2CR
+	tristate
+	depends on I2C
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 6990de7ca9a9..871069903ad5 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_REGMAP_I3C) += regmap-i3c.o
 obj-$(CONFIG_REGMAP_SPI_AVMM) += regmap-spi-avmm.o
 obj-$(CONFIG_REGMAP_MDIO) += regmap-mdio.o
 obj-$(CONFIG_REGMAP_FSI) += regmap-fsi.o
+obj-$(CONFIG_REGMAP_IBM_I2CR) += regmap-ibm-i2cr.o
diff --git a/drivers/base/regmap/regmap-ibm-i2cr.c b/drivers/base/regmap/regmap-ibm-i2cr.c
new file mode 100644
index 000000000000..799ad9e43a45
--- /dev/null
+++ b/drivers/base/regmap/regmap-ibm-i2cr.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API - IBM I2CR for POWER CFAM access
+//
+// Copyright 2022 IBM Corp
+//
+// Author: Eddie James <eajames@linux.ibm.com>
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "internal.h"
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
+static int regmap_ibm_i2cr_reg_read(void *context, unsigned int reg, unsigned int *val)
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
+static int regmap_ibm_i2cr_reg_write(void *context, unsigned int reg, unsigned int val)
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
+static const struct regmap_bus regmap_ibm_i2cr = {
+	.reg_write = regmap_ibm_i2cr_reg_write,
+	.reg_read = regmap_ibm_i2cr_reg_read,
+};
+
+static const struct regmap_bus *regmap_get_ibm_i2cr_bus(struct i2c_client *client,
+							const struct regmap_config *config)
+{
+	const struct regmap_bus *bus = NULL;
+
+	if (config->reg_bits == 32 && config->val_bits == 32)
+		bus = &regmap_ibm_i2cr;
+
+	return bus ?: ERR_PTR(-EOPNOTSUPP);
+}
+
+struct regmap *__regmap_init_ibm_i2cr(struct i2c_client *client,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key, const char *lock_name)
+{
+	const struct regmap_bus *bus = regmap_get_ibm_i2cr_bus(client, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __regmap_init(&client->dev, bus, client, config, lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__regmap_init_ibm_i2cr);
+
+struct regmap *__devm_regmap_init_ibm_i2cr(struct i2c_client *client,
+					   const struct regmap_config *config,
+					   struct lock_class_key *lock_key, const char *lock_name)
+{
+	const struct regmap_bus *bus = regmap_get_ibm_i2cr_bus(client, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __devm_regmap_init(&client->dev, bus, client, config, lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_ibm_i2cr);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e477112fb1c7..1821ebfa640c 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -633,6 +633,10 @@ struct regmap *__regmap_init_fsi(struct fsi_device *fsi_dev,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name);
+struct regmap *__regmap_init_ibm_i2cr(struct i2c_client *client,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name);
 
 struct regmap *__devm_regmap_init(struct device *dev,
 				  const struct regmap_bus *bus,
@@ -702,6 +706,10 @@ struct regmap *__devm_regmap_init_fsi(struct fsi_device *fsi_dev,
 				      const struct regmap_config *config,
 				      struct lock_class_key *lock_key,
 				      const char *lock_name);
+struct regmap *__devm_regmap_init_ibm_i2cr(struct i2c_client *client,
+					   const struct regmap_config *config,
+					   struct lock_class_key *lock_key,
+					   const char *lock_name);
 
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
@@ -942,6 +950,19 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__regmap_init_fsi, #config, fsi_dev,	\
 				 config)
 
+/**
+ * regmap_init_ibm_i2cr() - Initialise register map
+ *
+ * @client: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+#define regmap_init_ibm_i2cr(client, config)				\
+	__regmap_lockdep_wrapper(__regmap_init_ibm_i2cr, #config,	\
+				 client, config)
+
 /**
  * devm_regmap_init() - Initialise managed register map
  *
@@ -1185,6 +1206,20 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__devm_regmap_init_fsi, #config,	\
 				 fsi_dev, config)
 
+/**
+ * devm_regmap_init_ibm_i2cr() - Initialise managed register map
+ *
+ * @client: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_ibm_i2cr(client, config)			\
+	__regmap_lockdep_wrapper(__devm_regmap_init_ibm_i2cr, #config,	\
+				 client, config)
+
 int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
 void regmap_mmio_detach_clk(struct regmap *map);
 void regmap_exit(struct regmap *map);
-- 
2.31.1

