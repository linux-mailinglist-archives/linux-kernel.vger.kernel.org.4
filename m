Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335A8616F27
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiKBUwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiKBUwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:52:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B582ADC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:52:07 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2K8DHB016318;
        Wed, 2 Nov 2022 20:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nHZhBJhfRfwwVvTHO/Gy3lS9yXjAu7WswgEe8IT56LU=;
 b=HqVScRdbf8CXmGO4Z5wv5wu6SnnrObj91w22YYW2Lb2nA8uvTn8umbCZhD0uiUNMglFu
 bmyL7bAqq61LpGASLeYFQzdHdjsuQ9pyV0RH+K+GGYND0DibAyrIzClqqMCplo7T6mpV
 1JI8dMUm+OTEw9vT8McH4gy9U1MXag5kgYanE5inaOnU5+bezXcffT/ymohPwdxhh0uU
 hMU2Rk1eKlcaOFlOZmvP4WEzwJFd4gjHiMmO5SEbMQgbouVbKk2LJyWMfZbW+b+/WgEV
 VS+srIzsd0hzVmQ6mF+3G4U1ff4/K5EbXLprEd/i7n9Pb61KuGc1/Qc++esYvwTJhchP ng== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkwetcfsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:51:54 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2Konk0016183;
        Wed, 2 Nov 2022 20:51:53 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 3kgutam9qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:51:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2Kpr0N61342190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 20:51:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B59FD58067;
        Wed,  2 Nov 2022 20:51:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B12585805D;
        Wed,  2 Nov 2022 20:51:50 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.200.160])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 20:51:50 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, eajames@linux.ibm.com
Subject: [PATCH v2 1/5] regmap: Add FSI bus support
Date:   Wed,  2 Nov 2022 15:51:44 -0500
Message-Id: <20221102205148.1334459-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102205148.1334459-1-eajames@linux.ibm.com>
References: <20221102205148.1334459-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D6zzHaidoqb-PO4EPqNDeE-k6VKkxYoi
X-Proofpoint-GUID: D6zzHaidoqb-PO4EPqNDeE-k6VKkxYoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regmap support for the FSI bus.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/base/regmap/Kconfig      |   6 +-
 drivers/base/regmap/Makefile     |   1 +
 drivers/base/regmap/regmap-fsi.c | 231 +++++++++++++++++++++++++++++++
 include/linux/regmap.h           |  37 +++++
 4 files changed, 274 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-fsi.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 159bac6c5046..cd4bb642b9de 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -4,7 +4,7 @@
 # subsystems should select the appropriate symbols.
 
 config REGMAP
-	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM || REGMAP_MDIO)
+	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM || REGMAP_MDIO || REGMAP_FSI)
 	select IRQ_DOMAIN if REGMAP_IRQ
 	select MDIO_BUS if REGMAP_MDIO
 	bool
@@ -65,3 +65,7 @@ config REGMAP_I3C
 config REGMAP_SPI_AVMM
 	tristate
 	depends on SPI
+
+config REGMAP_FSI
+	tristate
+	depends on FSI
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 11facb32a027..6990de7ca9a9 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
 obj-$(CONFIG_REGMAP_I3C) += regmap-i3c.o
 obj-$(CONFIG_REGMAP_SPI_AVMM) += regmap-spi-avmm.o
 obj-$(CONFIG_REGMAP_MDIO) += regmap-mdio.o
+obj-$(CONFIG_REGMAP_FSI) += regmap-fsi.o
diff --git a/drivers/base/regmap/regmap-fsi.c b/drivers/base/regmap/regmap-fsi.c
new file mode 100644
index 000000000000..3d2f3cb31d5e
--- /dev/null
+++ b/drivers/base/regmap/regmap-fsi.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API - FSI support
+//
+// Copyright 2022 IBM Corp
+//
+// Author: Eddie James <eajames@linux.ibm.com>
+
+#include <linux/fsi.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "internal.h"
+
+static int regmap_fsi32_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	u32 v;
+	int ret;
+
+	ret = fsi_slave_read(context, reg, &v, sizeof(v));
+	if (ret)
+		return ret;
+
+	*val = v;
+	return 0;
+}
+
+static int regmap_fsi32_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	u32 v = val;
+
+	return fsi_slave_write(context, reg, &v, sizeof(v));
+}
+
+static const struct regmap_bus regmap_fsi32 = {
+	.reg_write = regmap_fsi32_reg_write,
+	.reg_read = regmap_fsi32_reg_read,
+};
+
+static int regmap_fsi32le_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	__be32 v;
+	int ret;
+
+	ret = fsi_slave_read(context, reg, &v, sizeof(v));
+	if (ret)
+		return ret;
+
+	*val = be32_to_cpu(v);
+	return 0;
+}
+
+static int regmap_fsi32le_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	__be32 v = cpu_to_be32(val);
+
+	return fsi_slave_write(context, reg, &v, sizeof(v));
+}
+
+static const struct regmap_bus regmap_fsi32le = {
+	.reg_write = regmap_fsi32le_reg_write,
+	.reg_read = regmap_fsi32le_reg_read,
+};
+
+static int regmap_fsi16_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	u16 v;
+	int ret;
+
+	ret = fsi_slave_read(context, reg, &v, sizeof(v));
+	if (ret)
+		return ret;
+
+	*val = v;
+	return 0;
+}
+
+static int regmap_fsi16_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	u16 v;
+
+	if (val > 0xffff)
+		return -EINVAL;
+
+	v = val;
+	return fsi_slave_write(context, reg, &v, sizeof(v));
+}
+
+static const struct regmap_bus regmap_fsi16 = {
+	.reg_write = regmap_fsi16_reg_write,
+	.reg_read = regmap_fsi16_reg_read,
+};
+
+static int regmap_fsi16le_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	__be16 v;
+	int ret;
+
+	ret = fsi_slave_read(context, reg, &v, sizeof(v));
+	if (ret)
+		return ret;
+
+	*val = be16_to_cpu(v);
+	return 0;
+}
+
+static int regmap_fsi16le_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	__be16 v;
+
+	if (val > 0xffff)
+		return -EINVAL;
+
+	v = cpu_to_be16(val);
+	return fsi_slave_write(context, reg, &v, sizeof(v));
+}
+
+static const struct regmap_bus regmap_fsi16le = {
+	.reg_write = regmap_fsi16le_reg_write,
+	.reg_read = regmap_fsi16le_reg_read,
+};
+
+static int regmap_fsi8_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	u8 v;
+	int ret;
+
+	ret = fsi_slave_read(context, reg, &v, sizeof(v));
+	if (ret)
+		return ret;
+
+	*val = v;
+	return 0;
+}
+
+static int regmap_fsi8_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	u8 v;
+
+	if (val > 0xff)
+		return -EINVAL;
+
+	v = val;
+	return fsi_slave_write(context, reg, &v, sizeof(v));
+}
+
+static const struct regmap_bus regmap_fsi8 = {
+	.reg_write = regmap_fsi8_reg_write,
+	.reg_read = regmap_fsi8_reg_read,
+};
+
+static const struct regmap_bus *regmap_get_fsi_bus(struct fsi_device *fsi_dev,
+						   const struct regmap_config *config)
+{
+	const struct regmap_bus *bus = NULL;
+
+	if (config->reg_bits == 8 || config->reg_bits == 16 || config->reg_bits == 32) {
+		switch (config->val_bits) {
+		case 8:
+			bus = &regmap_fsi8;
+			break;
+		case 16:
+			switch (regmap_get_val_endian(&fsi_dev->dev, NULL, config)) {
+			case REGMAP_ENDIAN_LITTLE:
+#ifdef __LITTLE_ENDIAN
+			case REGMAP_ENDIAN_NATIVE:
+#endif
+				bus = &regmap_fsi16le;
+				break;
+			case REGMAP_ENDIAN_DEFAULT:
+			case REGMAP_ENDIAN_BIG:
+#ifdef __BIG_ENDIAN
+			case REGMAP_ENDIAN_NATIVE:
+#endif
+				bus = &regmap_fsi16;
+				break;
+			default:
+				break;
+			}
+			break;
+		case 32:
+			switch (regmap_get_val_endian(&fsi_dev->dev, NULL, config)) {
+			case REGMAP_ENDIAN_LITTLE:
+#ifdef __LITTLE_ENDIAN
+			case REGMAP_ENDIAN_NATIVE:
+#endif
+				bus = &regmap_fsi32le;
+				break;
+			case REGMAP_ENDIAN_DEFAULT:
+			case REGMAP_ENDIAN_BIG:
+#ifdef __BIG_ENDIAN
+			case REGMAP_ENDIAN_NATIVE:
+#endif
+				bus = &regmap_fsi32;
+				break;
+			default:
+				break;
+			}
+			break;
+		}
+	}
+
+	return bus ?: ERR_PTR(-EOPNOTSUPP);
+}
+
+struct regmap *__regmap_init_fsi(struct fsi_device *fsi_dev, const struct regmap_config *config,
+				 struct lock_class_key *lock_key, const char *lock_name)
+{
+	const struct regmap_bus *bus = regmap_get_fsi_bus(fsi_dev, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __regmap_init(&fsi_dev->dev, bus, fsi_dev->slave, config, lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__regmap_init_fsi);
+
+struct regmap *__devm_regmap_init_fsi(struct fsi_device *fsi_dev,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key, const char *lock_name)
+{
+	const struct regmap_bus *bus = regmap_get_fsi_bus(fsi_dev, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __devm_regmap_init(&fsi_dev->dev, bus, fsi_dev->slave, config, lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_fsi);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index ca3434dca3a0..e477112fb1c7 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -24,6 +24,7 @@ struct module;
 struct clk;
 struct device;
 struct device_node;
+struct fsi_device;
 struct i2c_client;
 struct i3c_device;
 struct irq_domain;
@@ -628,6 +629,10 @@ struct regmap *__regmap_init_spi_avmm(struct spi_device *spi,
 				      const struct regmap_config *config,
 				      struct lock_class_key *lock_key,
 				      const char *lock_name);
+struct regmap *__regmap_init_fsi(struct fsi_device *fsi_dev,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 
 struct regmap *__devm_regmap_init(struct device *dev,
 				  const struct regmap_bus *bus,
@@ -693,6 +698,11 @@ struct regmap *__devm_regmap_init_spi_avmm(struct spi_device *spi,
 					   const struct regmap_config *config,
 					   struct lock_class_key *lock_key,
 					   const char *lock_name);
+struct regmap *__devm_regmap_init_fsi(struct fsi_device *fsi_dev,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name);
+
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
  * for each call. No-op if CONFIG_LOCKDEP is not set.
@@ -919,6 +929,19 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__regmap_init_spi_avmm, #config,		\
 				 spi, config)
 
+/**
+ * regmap_init_fsi() - Initialise register map
+ *
+ * @fsi_dev: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+#define regmap_init_fsi(fsi_dev, config)				\
+	__regmap_lockdep_wrapper(__regmap_init_fsi, #config, fsi_dev,	\
+				 config)
+
 /**
  * devm_regmap_init() - Initialise managed register map
  *
@@ -1148,6 +1171,20 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__devm_regmap_init_spi_avmm, #config,	\
 				 spi, config)
 
+/**
+ * devm_regmap_init_fsi() - Initialise managed register map
+ *
+ * @fsi_dev: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_fsi(fsi_dev, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_fsi, #config,	\
+				 fsi_dev, config)
+
 int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
 void regmap_mmio_detach_clk(struct regmap *map);
 void regmap_exit(struct regmap *map);
-- 
2.31.1

