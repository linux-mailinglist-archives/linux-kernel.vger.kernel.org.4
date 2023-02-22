Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9369FC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjBVTY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjBVTYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:24:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB193B21F;
        Wed, 22 Feb 2023 11:24:21 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MHDrj5006652;
        Wed, 22 Feb 2023 19:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=waX+8sT3aVB7C0VYfFZIwCssqJj6O6pwgHe/RSvxh4U=;
 b=FHiEJqZeeqmuLOY/gZku91ZE1KjPg7tiog9EReYqwFAxr5AbaRbnLEd7PDwB0iANf2xt
 cQyRL3E/gHrviQFsWac7/GYvmTpzfsuDT6HfyEk+cE/3iFI+NnCMejjPtQEWpHYj/C8d
 pxeYwkMU+n+yEb2a2zTKLHj2ZhKTTEoOK5gCl7LsGghxRYQchk/SxnXyJQAhkK5ShUSv
 C5sj0FEJ3zjyA1myGTDUpP7EPtblPfAUYmCjRJXU8Bu7gauSlZm/NdccEeOH58EyUQHf
 6GULklPtQf9osGmfJZ7hcoOC1QIZIHX0xXff3bh4pcI9iLDRhW92Ch39VL6Bf3WGEw0k 7w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwn677gp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 19:24:05 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MIlRdT019841;
        Wed, 22 Feb 2023 19:24:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ntpa7gbcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 19:24:04 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MJO22r47120666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 19:24:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D725958060;
        Wed, 22 Feb 2023 19:24:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71ED158062;
        Wed, 22 Feb 2023 19:24:01 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.56.187])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 19:24:01 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v6 4/6] fsi: Add I2C Responder SCOM driver
Date:   Wed, 22 Feb 2023 13:23:52 -0600
Message-Id: <20230222192354.4055034-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230222192354.4055034-1-eajames@linux.ibm.com>
References: <20230222192354.4055034-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OpKYMf-JiFpZ-PUECdv0ehyAlnDC7LHk
X-Proofpoint-ORIG-GUID: OpKYMf-JiFpZ-PUECdv0ehyAlnDC7LHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_07,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2CR has the capability to directly perform SCOM operations,
circumventing the need to drive the FSI2PIB engine. Add a new
driver to perform SCOM operations through the I2CR.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/Kconfig     |   8 ++
 drivers/fsi/Makefile    |   1 +
 drivers/fsi/i2cr-scom.c | 158 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 drivers/fsi/i2cr-scom.c

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index 999be82720c5..79a31593618a 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -94,4 +94,12 @@ config FSI_OCC
 	provide the raw sensor data as well as perform thermal and power
 	management on the system.
 
+config I2CR_SCOM
+	tristate "IBM I2C Responder SCOM driver"
+	depends on FSI_MASTER_I2CR
+	help
+	  This option enables an I2C Responder based SCOM device driver. The
+	  I2CR has the capability to directly perform SCOM operations instead
+	  of using the FSI2PIB engine.
+
 endif
diff --git a/drivers/fsi/Makefile b/drivers/fsi/Makefile
index 34dbaa1c452e..5550aa15e0b1 100644
--- a/drivers/fsi/Makefile
+++ b/drivers/fsi/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_FSI_MASTER_AST_CF) += fsi-master-ast-cf.o
 obj-$(CONFIG_FSI_SCOM) += fsi-scom.o
 obj-$(CONFIG_FSI_SBEFIFO) += fsi-sbefifo.o
 obj-$(CONFIG_FSI_OCC) += fsi-occ.o
+obj-$(CONFIG_I2CR_SCOM) += i2cr-scom.o
diff --git a/drivers/fsi/i2cr-scom.c b/drivers/fsi/i2cr-scom.c
new file mode 100644
index 000000000000..7e1c7b93c32f
--- /dev/null
+++ b/drivers/fsi/i2cr-scom.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) IBM Corporation 2023 */
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/fsi.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+
+#include "fsi-master-i2cr.h"
+#include "fsi-slave.h"
+
+struct i2cr_scom {
+	struct device dev;
+	struct cdev cdev;
+	struct fsi_master_i2cr *i2cr;
+};
+
+static loff_t i2cr_scom_llseek(struct file *file, loff_t offset, int whence)
+{
+	switch (whence) {
+	case SEEK_CUR:
+		break;
+	case SEEK_SET:
+		file->f_pos = offset;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return offset;
+}
+
+static ssize_t i2cr_scom_read(struct file *filep, char __user *buf, size_t len, loff_t *offset)
+{
+	struct i2cr_scom *scom = filep->private_data;
+	__be64 data_be;
+	u64 data;
+	int ret;
+
+	if (len != sizeof(data))
+		return -EINVAL;
+
+	ret = fsi_master_i2cr_read(scom->i2cr, (u32)*offset, &data_be, sizeof(data_be));
+	if (ret)
+		return ret;
+
+	data = be64_to_cpu(data_be);
+	ret = copy_to_user(buf, &data, len);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t i2cr_scom_write(struct file *filep, const char __user *buf, size_t len,
+			       loff_t *offset)
+{
+	struct i2cr_scom *scom = filep->private_data;
+	__be64 data_be;
+	u64 data;
+	int ret;
+
+	if (len != sizeof(data))
+		return -EINVAL;
+
+	ret = copy_from_user(&data, buf, len);
+	if (ret)
+		return ret;
+
+	data_be = cpu_to_be64(data);
+	ret = fsi_master_i2cr_write(scom->i2cr, (u32)*offset, &data_be, sizeof(data_be));
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static const struct file_operations i2cr_scom_fops = {
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.llseek		= i2cr_scom_llseek,
+	.read		= i2cr_scom_read,
+	.write		= i2cr_scom_write,
+};
+
+static int i2cr_scom_probe(struct device *dev)
+{
+	struct fsi_device *fsi_dev = to_fsi_dev(dev);
+	struct i2cr_scom *scom;
+	int didx;
+	int ret;
+
+	if (!(fsi_dev->slave->master->flags & FSI_MASTER_FLAG_I2CR))
+		return -ENODEV;
+
+	scom = devm_kzalloc(dev, sizeof(*scom), GFP_KERNEL);
+	if (!scom)
+		return -ENOMEM;
+
+	scom->i2cr = to_fsi_master_i2cr(fsi_dev->slave->master);
+	dev_set_drvdata(dev, scom);
+
+	scom->dev.type = &fsi_cdev_type;
+	scom->dev.parent = dev;
+	device_initialize(&scom->dev);
+
+	ret = fsi_get_new_minor(fsi_dev, fsi_dev_scom, &scom->dev.devt, &didx);
+	if (ret)
+		return ret;
+
+	dev_set_name(&scom->dev, "scom%d", didx);
+	cdev_init(&scom->cdev, &i2cr_scom_fops);
+	ret = cdev_device_add(&scom->cdev, &scom->dev);
+	if (ret)
+		fsi_free_minor(scom->dev.devt);
+
+	return ret;
+}
+
+static int i2cr_scom_remove(struct device *dev)
+{
+	struct i2cr_scom *scom = dev_get_drvdata(dev);
+
+	cdev_device_del(&scom->cdev, &scom->dev);
+	fsi_free_minor(scom->dev.devt);
+
+	return 0;
+}
+
+static const struct of_device_id i2cr_scom_of_ids[] = {
+	{ .compatible = "ibm,i2cr-scom" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, i2cr_scom_of_ids);
+
+static const struct fsi_device_id i2cr_scom_ids[] = {
+	{ 0x5, FSI_VERSION_ANY },
+	{ }
+};
+
+static struct fsi_driver i2cr_scom_driver = {
+	.id_table = i2cr_scom_ids,
+	.drv = {
+		.name = "i2cr_scom",
+		.bus = &fsi_bus_type,
+		.of_match_table = i2cr_scom_of_ids,
+		.probe = i2cr_scom_probe,
+		.remove = i2cr_scom_remove,
+	}
+};
+
+module_fsi_driver(i2cr_scom_driver);
+
+MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
+MODULE_DESCRIPTION("IBM I2C Responder SCOM driver");
+MODULE_LICENSE("GPL");
-- 
2.31.1

