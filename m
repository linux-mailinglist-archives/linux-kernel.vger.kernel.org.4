Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADAA69E976
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBUV07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBUV0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:26:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A64E2ED4C;
        Tue, 21 Feb 2023 13:26:50 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LLHNqq023254;
        Tue, 21 Feb 2023 21:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5xWbYPcgc3bQ0wvnr2TBCu4KGyKaVhhsaKawXrsKrGU=;
 b=GRbpKUMka62Zv1MOGZApY6Wd9QdEvmVygEWa3gNhFLbigXF4v9PLv6SvYGw+K1Q1Lotd
 Qg2CDLthN6bFMh5n0wZn0VuEfl+koClVsw0o4xNlWt46JL/Ph3mgbcEIyRzIYSnwU1nJ
 3zNlX7gFhA2UNDHrmJNSAuYdoUIja9Z4JP60e+zxhbZg7IHoh2flezOnQ6HdJuK9Wm/S
 sQP8GyUNYLSc/vDQAyTdpJ2REzqfIW5VyQEbjzWDEl2mnDSXFJ8sOgyqU7Lr/7fQ1Y9b
 hHOpVHDcm3beVOxMa6k2aLtIBZQQt63/ss/zsLTKvxKGyDZhkqvs+FVZaC1AfReE+R/w Zw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nw5he0f3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:26:35 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LITOfF019805;
        Tue, 21 Feb 2023 21:26:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ntpa7a035-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:26:34 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LLQXKk1770158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 21:26:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AF0C5805C;
        Tue, 21 Feb 2023 21:26:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CC7758058;
        Tue, 21 Feb 2023 21:26:31 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.223.120])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 21:26:31 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v5 4/6] fsi: Add I2C Responder SCOM driver
Date:   Tue, 21 Feb 2023 15:26:20 -0600
Message-Id: <20230221212622.3897097-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230221212622.3897097-1-eajames@linux.ibm.com>
References: <20230221212622.3897097-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rCHA6uGqnlQ9G7oA-E6CktJEwHqQ-v51
X-Proofpoint-GUID: rCHA6uGqnlQ9G7oA-E6CktJEwHqQ-v51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210182
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
 drivers/fsi/Kconfig     |  12 +++
 drivers/fsi/Makefile    |   1 +
 drivers/fsi/i2cr-scom.c | 158 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/fsi/i2cr-scom.c

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index 999be82720c5..09a8285d4bdc 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -71,6 +71,18 @@ config FSI_MASTER_I2CR
 	  that translates I2C commands to CFAM or SCOM operations, effectively
 	  implementing an FSI master and bus.
 
+if FSI_MASTER_I2CR
+
+config I2CR_SCOM
+	tristate "IBM I2C Responder SCOM driver"
+	default y
+	help
+	  This option enables an I2C Responder based SCOM device driver. The
+	  I2CR has the capability to directly perform SCOM operations instead
+	  of using the FSI2PIB engine.
+
+endif
+
 config FSI_SCOM
 	tristate "SCOM FSI client device driver"
 	help
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

