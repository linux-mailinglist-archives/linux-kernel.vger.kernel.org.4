Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A267129AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244147AbjEZPgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244106AbjEZPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:35:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E69F7;
        Fri, 26 May 2023 08:35:50 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QDee8m024376;
        Fri, 26 May 2023 15:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fUOQc1XwAyOouUkr2+5nZp3Y0sivRW4gUiV/Bxxwt/U=;
 b=IIolh4Bofw8Vwrb0Bmmm3a9xt4VikSmmbP4fXr8Ca2XyUpu2qlbDKuf7l/lzOh3Bos7j
 EFMOoSpn8lQ5mmffE4MGJRzUv6W3QBYDt+fsOOlKXgR6Ai+W9qFnxx7g3j6hTxhDRT+C
 HviZPmODddPLAljVGFLOdtvVycy5JEaMTvZGNX2hJSNiutTZmO3bc8scNn2pg04T4DUE
 dxUYURJDRL0xgEWwiK2kWHOd6Qz+dHZZpzOhlSbw1wFIuXkqAESqfmnt4Jf+6BjFiZCi
 wxqTtR3huubP40IzlrQcNbiR55y3dYW8Aq4+9PZ8XI61FTag68fw2MKTe/87NVQRDnWX 7A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtrd8h02b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:35:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QFZcMR023726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:35:38 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 08:35:34 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v1 2/3] coresight-tmc: byte-cntr: Add support for streaming interface for ETR
Date:   Fri, 26 May 2023 23:35:07 +0800
Message-ID: <20230526153508.6208-3-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
References: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zq7_JmhlnqsRyGE2S1TYUMTcW0XdcW6Q
X-Proofpoint-GUID: Zq7_JmhlnqsRyGE2S1TYUMTcW0XdcW6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a streaming interface for TMC ETR to allow for continuous
log collection to secondary storage. An interrupt based mechanism is used
to stream out the data from the device. The streaming interface cannot be
used in conjunction with the traditional ETR read operation.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tmc   |   7 +
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../hwtracing/coresight/coresight-byte-cntr.c | 304 ++++++++++++++++++
 .../hwtracing/coresight/coresight-byte-cntr.h |  49 +++
 drivers/hwtracing/coresight/coresight-csr.c   |  26 ++
 drivers/hwtracing/coresight/coresight-csr.h   |  19 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |  66 ++++
 .../hwtracing/coresight/coresight-tmc-etr.c   |   8 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |  12 +-
 9 files changed, 481 insertions(+), 12 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-byte-cntr.c
 create mode 100644 drivers/hwtracing/coresight/coresight-byte-cntr.h

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index 6aa527296c71..efb6b70ce322 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -91,3 +91,10 @@ Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(RW) Size of the trace buffer for TMC-ETR when used in SYSFS
 		mode. Writable only for TMC-ETR configurations. The value
 		should be aligned to the kernel pagesize.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/block_size
+Date:		May 2023
+KernelVersion:	6.3
+Contact:	Mao Jinlong <quic_jinlmao@quicinc.com>
+Description:	(RW) Size of the ETR irq byte counter value. The value
+		need to be greater than 4096.
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 956c642d05f6..4440c1e36e66 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -9,7 +9,7 @@ coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
 		coresight-syscfg-configfs.o coresight-trace-id.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
-		      coresight-tmc-etr.o
+		      coresight-tmc-etr.o coresight-byte-cntr.o
 obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
 obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
 obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
diff --git a/drivers/hwtracing/coresight/coresight-byte-cntr.c b/drivers/hwtracing/coresight/coresight-byte-cntr.c
new file mode 100644
index 000000000000..125c97fb1e35
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-byte-cntr.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/fs.h>
+#include <linux/of_irq.h>
+#include <linux/moduleparam.h>
+#include <linux/delay.h>
+#include <linux/uaccess.h>
+#include <linux/property.h>
+
+#include "coresight-csr.h"
+#include "coresight-byte-cntr.h"
+
+/* Read the data from ETR's DDR buffer */
+static void tmc_etr_read_bytes(struct byte_cntr *byte_cntr_data, long offset,
+			       size_t bytes, size_t *len, char **bufp)
+{
+	struct tmc_drvdata *tmcdrvdata = byte_cntr_data->tmcdrvdata;
+	struct etr_buf *etr_buf = tmcdrvdata->sysfs_buf;
+	size_t actual;
+
+	if (*len >= bytes)
+		*len = bytes;
+	else if (((uint32_t)offset % bytes) + *len > bytes)
+		*len = bytes - ((uint32_t)offset % bytes);
+
+	actual = tmc_etr_buf_get_data(etr_buf, offset, *len, bufp);
+	*len = actual;
+	if (actual == bytes || (actual + (uint32_t)offset) % bytes == 0)
+		atomic_dec(&byte_cntr_data->irq_cnt);
+}
+
+
+static irqreturn_t etr_handler(int irq, void *data)
+{
+	struct byte_cntr *byte_cntr_data = data;
+
+	atomic_inc(&byte_cntr_data->irq_cnt);
+	wake_up(&byte_cntr_data->wq);
+
+	return IRQ_HANDLED;
+}
+
+/* Read function for /dev/byte-cntr */
+static ssize_t tmc_etr_byte_cntr_read(struct file *fp, char __user *data,
+			       size_t len, loff_t *ppos)
+{
+	struct byte_cntr *byte_cntr_data = fp->private_data;
+	struct tmc_drvdata *tmcdrvdata = byte_cntr_data->tmcdrvdata;
+	char *bufp = NULL;
+	int ret = 0;
+
+	if (!data)
+		return -EINVAL;
+
+	mutex_lock(&byte_cntr_data->byte_cntr_lock);
+
+	if (byte_cntr_data->enable) {
+		if (!atomic_read(&byte_cntr_data->irq_cnt)) {
+			mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+			if (wait_event_interruptible(byte_cntr_data->wq,
+				atomic_read(&byte_cntr_data->irq_cnt) > 0
+				|| !byte_cntr_data->enable))
+				return -ERESTARTSYS;
+			mutex_lock(&byte_cntr_data->byte_cntr_lock);
+		}
+
+		tmc_etr_read_bytes(byte_cntr_data, byte_cntr_data->offset,
+				   byte_cntr_data->block_size, &len, &bufp);
+	} else {
+		ret = -EINVAL;
+		goto err0;
+	}
+
+	if (copy_to_user(data, bufp, len)) {
+		mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+		dev_dbg(&tmcdrvdata->csdev->dev,
+			"%s: copy_to_user failed\n", __func__);
+		return -EFAULT;
+	}
+
+	if (byte_cntr_data->offset + len >= tmcdrvdata->size)
+		byte_cntr_data->offset = 0;
+	else
+		byte_cntr_data->offset += len;
+
+	goto out;
+
+err0:
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+	return ret;
+out:
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+	return len;
+}
+
+/* Start byte-cntr function. */
+void tmc_etr_byte_cntr_start(struct byte_cntr *byte_cntr_data)
+{
+	if (!byte_cntr_data)
+		return;
+
+	mutex_lock(&byte_cntr_data->byte_cntr_lock);
+
+	/*
+	 * When block_size is not set or /dev/byte-cntr
+	 * is being read, don't start byte-cntr function.
+	 */
+	if (byte_cntr_data->block_size == 0
+		|| byte_cntr_data->read_active) {
+		mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+		return;
+	}
+
+	atomic_set(&byte_cntr_data->irq_cnt, 0);
+	byte_cntr_data->enable = true;
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+}
+
+/* Stop byte-cntr function */
+void tmc_etr_byte_cntr_stop(struct byte_cntr *byte_cntr_data)
+{
+	struct tmc_drvdata *tmcdrvdata;
+
+	if (!byte_cntr_data)
+		return;
+
+	tmcdrvdata = byte_cntr_data->tmcdrvdata;
+
+	mutex_lock(&byte_cntr_data->byte_cntr_lock);
+	byte_cntr_data->enable = false;
+	byte_cntr_data->read_active = false;
+	atomic_set(&byte_cntr_data->irq_cnt, 0);
+	wake_up(&byte_cntr_data->wq);
+	coresight_csr_set_byte_cntr(tmcdrvdata->csr, 0);
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+}
+
+static int tmc_etr_byte_cntr_release(struct inode *in, struct file *fp)
+{
+	struct byte_cntr *byte_cntr_data = fp->private_data;
+	struct tmc_drvdata *tmcdrvdata = byte_cntr_data->tmcdrvdata;
+
+	mutex_lock(&byte_cntr_data->byte_cntr_lock);
+	byte_cntr_data->read_active = false;
+
+	atomic_set(&byte_cntr_data->irq_cnt, 0);
+
+	if (byte_cntr_data->enable)
+		coresight_csr_set_byte_cntr(tmcdrvdata->csr, 0);
+
+	disable_irq_wake(byte_cntr_data->byte_cntr_irq);
+
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+
+	return 0;
+}
+
+static int tmc_etr_byte_cntr_open(struct inode *in, struct file *fp)
+{
+	struct byte_cntr *byte_cntr_data =
+			container_of(in->i_cdev, struct byte_cntr, dev);
+	struct tmc_drvdata *tmcdrvdata = byte_cntr_data->tmcdrvdata;
+
+	mutex_lock(&byte_cntr_data->byte_cntr_lock);
+
+	if (byte_cntr_data->read_active) {
+		mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+		return -EBUSY;
+	}
+
+	if (tmcdrvdata->mode != CS_MODE_SYSFS ||
+			!byte_cntr_data->block_size) {
+		mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+		return -EINVAL;
+	}
+
+	enable_irq_wake(byte_cntr_data->byte_cntr_irq);
+	/*
+	 * IRQ is a '8- byte' counter and to observe interrupt at
+	 * block_size' bytes of data
+	 */
+	coresight_csr_set_byte_cntr(tmcdrvdata->csr, (byte_cntr_data->block_size) / 8);
+
+	fp->private_data = byte_cntr_data;
+	nonseekable_open(in, fp);
+	byte_cntr_data->enable = true;
+	byte_cntr_data->read_active = true;
+	mutex_unlock(&byte_cntr_data->byte_cntr_lock);
+	return 0;
+}
+
+static const struct file_operations byte_cntr_fops = {
+	.owner		= THIS_MODULE,
+	.open		= tmc_etr_byte_cntr_open,
+	.read		= tmc_etr_byte_cntr_read,
+	.release	= tmc_etr_byte_cntr_release,
+	.llseek		= no_llseek,
+};
+
+static int byte_cntr_register_chardev(struct byte_cntr *byte_cntr_data)
+{
+	int ret;
+	unsigned int baseminor = 0;
+	unsigned int count = 1;
+	struct device *device;
+	dev_t dev;
+
+	ret = alloc_chrdev_region(&dev, baseminor, count, "byte-cntr");
+	if (ret < 0) {
+		pr_err("alloc_chrdev_region failed %d\n", ret);
+		return ret;
+	}
+	cdev_init(&byte_cntr_data->dev, &byte_cntr_fops);
+
+	byte_cntr_data->dev.owner = THIS_MODULE;
+	byte_cntr_data->dev.ops = &byte_cntr_fops;
+
+	ret = cdev_add(&byte_cntr_data->dev, dev, 1);
+	if (ret)
+		goto exit_unreg_chrdev_region;
+
+	byte_cntr_data->driver_class = class_create(THIS_MODULE,
+						   "coresight-tmc-etr-stream");
+	if (IS_ERR(byte_cntr_data->driver_class)) {
+		ret = -ENOMEM;
+		pr_err("class_create failed %d\n", ret);
+		goto exit_unreg_chrdev_region;
+	}
+
+	device = device_create(byte_cntr_data->driver_class, NULL,
+			       byte_cntr_data->dev.dev, byte_cntr_data,
+			       "byte-cntr");
+
+	if (IS_ERR(device)) {
+		pr_err("class_device_create failed %d\n", ret);
+		ret = -ENOMEM;
+		goto exit_destroy_class;
+	}
+
+	return 0;
+
+exit_destroy_class:
+	class_destroy(byte_cntr_data->driver_class);
+exit_unreg_chrdev_region:
+	unregister_chrdev_region(byte_cntr_data->dev.dev, 1);
+	return ret;
+}
+
+struct byte_cntr *byte_cntr_init(struct amba_device *adev,
+				 struct tmc_drvdata *drvdata)
+{
+	struct device *dev = &adev->dev;
+	struct device_node *np = adev->dev.of_node;
+	int byte_cntr_irq;
+	int ret;
+	struct byte_cntr *byte_cntr_data;
+
+	byte_cntr_irq = of_irq_get_byname(np, "byte-cntr-irq");
+	if (byte_cntr_irq < 0)
+		return NULL;
+
+	byte_cntr_data = devm_kzalloc(dev, sizeof(*byte_cntr_data), GFP_KERNEL);
+	if (!byte_cntr_data)
+		return NULL;
+
+	ret = devm_request_irq(dev, byte_cntr_irq, etr_handler,
+			       IRQF_TRIGGER_RISING | IRQF_SHARED,
+			       "tmc-etr", byte_cntr_data);
+	if (ret) {
+		devm_kfree(dev, byte_cntr_data);
+		dev_err(dev, "Byte_cntr interrupt registration failed\n");
+		return NULL;
+	}
+
+	ret = byte_cntr_register_chardev(byte_cntr_data);
+	if (ret) {
+		devm_free_irq(dev, byte_cntr_irq, byte_cntr_data);
+		devm_kfree(dev, byte_cntr_data);
+		dev_err(dev, "Byte_cntr char dev registration failed\n");
+		return NULL;
+	}
+
+	byte_cntr_data->tmcdrvdata = drvdata;
+	byte_cntr_data->byte_cntr_irq = byte_cntr_irq;
+	atomic_set(&byte_cntr_data->irq_cnt, 0);
+	init_waitqueue_head(&byte_cntr_data->wq);
+	mutex_init(&byte_cntr_data->byte_cntr_lock);
+
+	return byte_cntr_data;
+}
+
+void byte_cntr_remove(struct byte_cntr *byte_cntr_data)
+{
+	device_destroy(byte_cntr_data->driver_class,
+				byte_cntr_data->dev.dev);
+	class_destroy(byte_cntr_data->driver_class);
+	unregister_chrdev_region(byte_cntr_data->dev.dev, 1);
+}
+
diff --git a/drivers/hwtracing/coresight/coresight-byte-cntr.h b/drivers/hwtracing/coresight/coresight-byte-cntr.h
new file mode 100644
index 000000000000..c41343ba2c9b
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-byte-cntr.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _CORESIGHT_BYTE_CNTR_H
+#define _CORESIGHT_BYTE_CNTR_H
+
+#include <linux/cdev.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include "coresight-priv.h"
+#include "coresight-tmc.h"
+
+/**
+ * struct byte_cntr - Data of ETR's byte_cntr config
+ * @dev: cdev of byte_cntr node.
+ * @driver_class: class data for the dev node.
+ * @enable: byte_cntr enable or not.
+ * @read_active: Indicate that data is read from /dev/byte-cntr.
+ * @block_size: The counter value of byte_cntr irq.
+ * @byte_cntr_irq: irq number.
+ * @byte_cntr_lock: lock of the byte_cntr data.
+ * @offset: The offset of current read point.
+ * @wq: byte_cntr read work queue.
+ * @irq_cnt: counter number of the byte_cntr irq.
+ * @tmcdrvdata: ETR drvdata.
+ */
+struct byte_cntr {
+	struct cdev		dev;
+	struct class	*driver_class;
+	bool			enable;
+	bool			read_active;
+	u32			block_size;
+	int			byte_cntr_irq;
+	struct mutex		byte_cntr_lock;
+	unsigned long		offset;
+	wait_queue_head_t	wq;
+	atomic_t		irq_cnt;
+	struct tmc_drvdata		*tmcdrvdata;
+};
+
+struct byte_cntr *byte_cntr_init(struct amba_device *adev,
+				 struct tmc_drvdata *drvdata);
+void tmc_etr_byte_cntr_start(struct byte_cntr *byte_cntr_data);
+void tmc_etr_byte_cntr_stop(struct byte_cntr *byte_cntr_data);
+
+
+#endif
diff --git a/drivers/hwtracing/coresight/coresight-csr.c b/drivers/hwtracing/coresight/coresight-csr.c
index a1403e8531ee..45a72426a549 100644
--- a/drivers/hwtracing/coresight/coresight-csr.c
+++ b/drivers/hwtracing/coresight/coresight-csr.c
@@ -18,6 +18,29 @@ DEFINE_CORESIGHT_DEVLIST(csr_devs, "csr");
 
 static LIST_HEAD(csr_list);
 
+#define to_csr_drvdata(c) container_of(c, struct csr_drvdata, csr)
+
+void coresight_csr_set_byte_cntr(struct coresight_csr *csr,
+					uint32_t count)
+{
+	struct csr_drvdata *drvdata;
+	unsigned long flags;
+
+	if (csr == NULL)
+		return;
+
+	drvdata = to_csr_drvdata(csr);
+	if (IS_ERR_OR_NULL(drvdata) || !drvdata->set_byte_cntr_support)
+		return;
+
+	spin_lock_irqsave(&drvdata->spin_lock, flags);
+	CS_UNLOCK(drvdata->base);
+	writel_relaxed(count, drvdata->base + CSR_BYTECNTVAL);
+	CS_UNLOCK(drvdata->base);
+	spin_unlock_irqrestore(&drvdata->spin_lock, flags);
+}
+EXPORT_SYMBOL(coresight_csr_set_byte_cntr);
+
 /*
  * Get the CSR by name.
  */
@@ -85,6 +108,9 @@ static int csr_probe(struct platform_device *pdev)
 	if (!drvdata->base)
 		return -ENOMEM;
 
+	drvdata->set_byte_cntr_support = of_property_read_bool(
+			pdev->dev.of_node, "qcom,set-byte-cntr-support");
+
 	desc.type = CORESIGHT_DEV_TYPE_HELPER;
 	desc.pdata = pdev->dev.platform_data;
 	desc.dev = &pdev->dev;
diff --git a/drivers/hwtracing/coresight/coresight-csr.h b/drivers/hwtracing/coresight/coresight-csr.h
index 3fd24b8e28e8..c618c5ae4eaa 100644
--- a/drivers/hwtracing/coresight/coresight-csr.h
+++ b/drivers/hwtracing/coresight/coresight-csr.h
@@ -10,6 +10,8 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 
+#define CSR_BYTECNTVAL		(0x06C)
+
 struct coresight_csr {
 	const char *name;
 	struct list_head link;
@@ -17,13 +19,14 @@ struct coresight_csr {
 
 /**
  * struct csr_drvdata - specifics for the CSR device.
- * @base:	Memory mapped base address for this component.
- * @pbase:	Physical address base.
- * @dev:	The device entity associated to this component.
- * @csdev:	Data struct for coresight device.
- * @csr:	CSR struct
- * @clk:	Clock of this component.
- * @spin_lock:	Spin lock for the data.
+ * @base: Memory mapped base address for this component.
+ * @pbase: Physical address base.
+ * @dev: The device entity associated to this component.
+ * @csdev: Data struct for coresight device.
+ * @csr: CSR struct
+ * @clk: Clock of this component.
+ * @spin_lock: Spin lock for the data.
+ * @set_byte_cntr_support: Support set byte contr value or not.
  */
 struct csr_drvdata {
 	void __iomem		*base;
@@ -33,7 +36,9 @@ struct csr_drvdata {
 	struct coresight_csr	csr;
 	struct clk		*clk;
 	spinlock_t		spin_lock;
+	bool			set_byte_cntr_support;
 };
+
 #if IS_ENABLED(CONFIG_CORESIGHT_CSR)
 extern void coresight_csr_set_byte_cntr(struct coresight_csr *csr, uint32_t count);
 extern struct coresight_csr *coresight_csr_get(const char *name);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index c106d142e632..fd2bda0445be 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -329,9 +329,59 @@ static ssize_t buffer_size_store(struct device *dev,
 
 static DEVICE_ATTR_RW(buffer_size);
 
+static ssize_t block_size_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	uint32_t val = 0;
+
+	/* Only permitted for TMC-ETRs */
+	if (drvdata->config_type != TMC_CONFIG_TYPE_ETR)
+		return -EPERM;
+
+	if (drvdata->byte_cntr)
+		val = drvdata->byte_cntr->block_size;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			val);
+}
+
+static ssize_t block_size_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf,
+			      size_t size)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	/* Only permitted for TMC-ETRs */
+	if (drvdata->config_type != TMC_CONFIG_TYPE_ETR)
+		return -EPERM;
+
+	if (!drvdata->byte_cntr)
+		return -EINVAL;
+
+	if (val && val < 4096) {
+		pr_err("Assign minimum block size of 4096 bytes\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&drvdata->byte_cntr->byte_cntr_lock);
+	drvdata->byte_cntr->block_size = val;
+	mutex_unlock(&drvdata->byte_cntr->byte_cntr_lock);
+
+	return size;
+}
+static DEVICE_ATTR_RW(block_size);
+
 static struct attribute *coresight_tmc_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
 	&dev_attr_buffer_size.attr,
+	&dev_attr_block_size.attr,
 	NULL,
 };
 
@@ -473,6 +523,21 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
 	}
 
+	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
+		ret = of_get_coresight_csr_name(adev->dev.of_node, &drvdata->csr_name);
+		if (ret)
+			dev_dbg(dev, "No csr data\n");
+		else {
+			drvdata->csr = coresight_csr_get(drvdata->csr_name);
+			if (IS_ERR(drvdata->csr)) {
+				dev_dbg(dev, "failed to get csr, defer probe\n");
+				return -EPROBE_DEFER;
+			}
+
+		}
+
+	}
+
 	desc.dev = dev;
 	desc.groups = coresight_tmc_groups;
 
@@ -492,6 +557,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		if (ret)
 			goto out;
 		idr_init(&drvdata->idr);
+		drvdata->byte_cntr = byte_cntr_init(adev, drvdata);
 		mutex_init(&drvdata->idr_mutex);
 		dev_list = &etr_devs;
 		break;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 918d461fcf4a..bded8d4abe77 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -925,7 +925,7 @@ static void tmc_free_etr_buf(struct etr_buf *etr_buf)
  * Returns: The size of the linear data available @pos, with *bufpp
  * updated to point to the buffer.
  */
-static ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
+ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
 				    u64 offset, size_t len, char **bufpp)
 {
 	/* Adjust the length to limit this transaction to end of buffer */
@@ -1235,8 +1235,10 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	if (free_buf)
 		tmc_etr_free_sysfs_buf(free_buf);
 
-	if (!ret)
+	if (!ret) {
+		tmc_etr_byte_cntr_start(drvdata->byte_cntr);
 		dev_dbg(&csdev->dev, "TMC-ETR enabled\n");
+	}
 
 	return ret;
 }
@@ -1706,7 +1708,7 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	drvdata->perf_buf = NULL;
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
+	tmc_etr_byte_cntr_stop(drvdata->byte_cntr);
 	dev_dbg(&csdev->dev, "TMC-ETR disabled\n");
 	return 0;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 01c0382a29c0..082657fbb14c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -13,6 +13,9 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 
+#include "coresight-csr.h"
+#include "coresight-byte-cntr.h"
+
 #define TMC_RSZ			0x004
 #define TMC_STS			0x00c
 #define TMC_RRD			0x010
@@ -187,6 +190,9 @@ struct etr_buf {
  * @idr_mutex:	Access serialisation for idr.
  * @sysfs_buf:	SYSFS buffer for ETR.
  * @perf_buf:	PERF buffer for ETR.
+ * @csr:	CSR data struct of ETR.
+ * @csr_name:	CSR node name.
+ * @byte_cntr:	Byte_cntr data of ETR.
  */
 struct tmc_drvdata {
 	void __iomem		*base;
@@ -211,6 +217,9 @@ struct tmc_drvdata {
 	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
 	struct etr_buf		*perf_buf;
+	struct coresight_csr	*csr;
+	const char		*csr_name;
+	struct byte_cntr	*byte_cntr;
 };
 
 struct etr_buf_operations {
@@ -276,7 +285,8 @@ void tmc_etr_disable_hw(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etr_cs_ops;
 ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
 				loff_t pos, size_t len, char **bufpp);
-
+ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
+				u64 offset, size_t len, char **bufpp);
 
 #define TMC_REG_PAIR(name, lo_off, hi_off)				\
 static inline u64							\
-- 
2.17.1

