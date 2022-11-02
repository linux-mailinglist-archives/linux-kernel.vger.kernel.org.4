Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE54616F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiKBUwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiKBUwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:52:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C7EB1CA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:52:21 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2Jbr2O006637;
        Wed, 2 Nov 2022 20:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LLFw9gcEwis11kPCwqwhMAzkAZBt/m0nidiPhYl58c8=;
 b=Yt4SSR+8O0JzrtJXGoUmzpShq6kY6OzKKF7k4LTGRwIH6rlyjXkveFJHRy0+t9Tx6SLJ
 CeemflzNCjSyBVXVRgfWhNbkBUZagvjsrz91tZ4i3QjpSVV7W+FtvcGWY7WkNR8CISCf
 vsHpCDQn+vu1tJYPFACihNvpW33TIg5KHwd+t3o9lrJWY3K6zDkKEUWtYmQnfbtTzfhX
 Gse7IpgGX3L08Dtn6YDgNdLE4iwgB8IsIaqsh41ApGVrI/QszclsRENin31xsT9dn8xm
 igY7zfQH5Tx1tdI7l0mPlPbpClvRxO5nznzIts8LeXZa/1U4K+3owl50uP8BnSyt9d8y 9g== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkxvkt05p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:52:04 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2Koh0n014779;
        Wed, 2 Nov 2022 20:51:58 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 3kgutam859-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:51:58 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2KpsiM42926378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 20:51:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED95058056;
        Wed,  2 Nov 2022 20:51:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA5C958069;
        Wed,  2 Nov 2022 20:51:55 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.200.160])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 20:51:55 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, eajames@linux.ibm.com
Subject: [PATCH v2 5/5] drivers: fsi: occ and sbefifo refactor
Date:   Wed,  2 Nov 2022 15:51:48 -0500
Message-Id: <20221102205148.1334459-6-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102205148.1334459-1-eajames@linux.ibm.com>
References: <20221102205148.1334459-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: StCS-5kMOa_vh_chlmxfuadpQaN76mI8
X-Proofpoint-GUID: StCS-5kMOa_vh_chlmxfuadpQaN76mI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
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

Rework the drivers to allow for SBEFIFO connected over FSI or I2C.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/Kconfig        |  26 +-
 drivers/fsi/Makefile       |   6 +-
 drivers/fsi/occ-cdev.c     | 178 ++++++-----
 drivers/fsi/occ.c          | 495 +++++++++++++------------------
 drivers/fsi/occ.h          |  57 ++++
 drivers/fsi/sbefifo-cdev.c | 239 +++++++--------
 drivers/fsi/sbefifo-fsi.c  |  68 +++++
 drivers/fsi/sbefifo-i2c.c  |  73 +++++
 drivers/fsi/sbefifo.c      | 588 ++++++++++++++-----------------------
 drivers/fsi/sbefifo.h      |  50 ++++
 10 files changed, 920 insertions(+), 860 deletions(-)
 create mode 100644 drivers/fsi/occ.h
 create mode 100644 drivers/fsi/sbefifo-fsi.c
 create mode 100644 drivers/fsi/sbefifo-i2c.c
 create mode 100644 drivers/fsi/sbefifo.h

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index c6049a7bc0dd..ab98c4b718fb 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -75,15 +75,29 @@ config FSI_I2CR
 
 config FSI_SBEFIFO
 	tristate "SBEFIFO FSI client device driver"
-	depends on OF_ADDRESS
+	select REGMAP_FSI
+	select SBEFIFO_CORE
 	help
-	This option enables an FSI based SBEFIFO device driver. The SBEFIFO is
-	a pipe-like FSI device for communicating with the self boot engine
-	(SBE) on POWER processors.
+	  This option enables an FSI based SBEFIFO device driver. The SBEFIFO is
+	  a pipe-like device for communicating with the self boot engine
+	  (SBE) on POWER processors.
+
+config I2C_SBEFIFO
+	tristate "SBEFIFO I2C client device driver"
+	select FSI_I2CR
+	select SBEFIFO_CORE
+	help
+	  This option enables an I2C based SBEFIFO device driver. The SBEFIFO is
+	  a pipe-like device for communicating with the self boot engine
+	  (SBE) on POWER processors.
+
+config SBEFIFO_CORE
+	tristate
+	select FSI_OCC
 
 config FSI_OCC
-	tristate "OCC SBEFIFO client device driver"
-	depends on FSI_SBEFIFO
+	tristate "OCC communications driver"
+	depends on SBEFIFO_CORE
 	help
 	This option enables an SBEFIFO based On-Chip Controller (OCC) device
 	driver. The OCC is a device embedded on a POWER processor that collects
diff --git a/drivers/fsi/Makefile b/drivers/fsi/Makefile
index 1a52fc6c5258..c1d0e020c845 100644
--- a/drivers/fsi/Makefile
+++ b/drivers/fsi/Makefile
@@ -7,5 +7,9 @@ obj-$(CONFIG_FSI_MASTER_GPIO) += fsi-master-gpio.o
 obj-$(CONFIG_FSI_MASTER_AST_CF) += fsi-master-ast-cf.o
 obj-$(CONFIG_FSI_SCOM) += fsi-scom.o
 obj-$(CONFIG_FSI_I2CR) += i2cr.o
-obj-$(CONFIG_FSI_SBEFIFO) += sbefifo.o sbefifo-cdev.o
 obj-$(CONFIG_FSI_OCC) += occ.o occ-cdev.o
+
+sbefifo-core-objs := sbefifo.o sbefifo-cdev.o
+
+obj-$(CONFIG_FSI_SBEFIFO) += sbefifo-core.o sbefifo-fsi.o
+obj-$(CONFIG_I2C_SBEFIFO) += sbefifo-core.o sbefifo-i2c.o
diff --git a/drivers/fsi/occ-cdev.c b/drivers/fsi/occ-cdev.c
index b3be880b5fe8..ff9cfd7d8350 100644
--- a/drivers/fsi/occ-cdev.c
+++ b/drivers/fsi/occ-cdev.c
@@ -1,132 +1,138 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) IBM Corporation 2022 */
 
-static int occ_open(struct inode *inode, struct file *file)
+#include <linux/container_of.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/minmax.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include "occ.h"
+
+static void occ_release_command(struct occ_user *user)
 {
-	struct occ_client *client = kzalloc(sizeof(*client), GFP_KERNEL);
-	struct miscdevice *mdev = file->private_data;
-	struct occ *occ = to_occ(mdev);
+	if (user->pending.allocated)
+		kfree(user->pending.buffer);
 
-	if (!client)
-		return -ENOMEM;
+	user->pending.buffer = user->buffer;
+	user->pending.buffer_size = sizeof(user->buffer);
+	user->pending.data_size = 0;
+	user->pending.allocated = 0;
+}
 
-	client->buffer = (u8 *)__get_free_page(GFP_KERNEL);
-	if (!client->buffer) {
-		kfree(client);
-		return -ENOMEM;
-	}
+static int occ_open(struct inode *inode, struct file *file)
+{
+	struct occ_user *user;
 
-	client->occ = occ;
-	mutex_init(&client->lock);
-	file->private_data = client;
-	get_device(occ->dev);
+	user = kmalloc(sizeof(*user), GFP_KERNEL);
+	if (!user)
+		return -ENOMEM;
 
-	/* We allocate a 1-page buffer, make sure it all fits */
-	BUILD_BUG_ON((OCC_CMD_DATA_BYTES + 3) > PAGE_SIZE);
-	BUILD_BUG_ON((OCC_RESP_DATA_BYTES + 7) > PAGE_SIZE);
+	file->private_data = user;
+	mutex_init(&user->lock);
+	user->occ = container_of(inode->i_cdev, struct occ, occ);
+	user->pending.buffer = user->buffer;
+	user->pending.buffer_size = sizeof(user->buffer);
+	user->pending.data_size = 0;
+	user->pending.allocated = 0;
+	user->pending.pending = 0;
+	user->pending.resizable = 1;
 
 	return 0;
 }
 
-static ssize_t occ_read(struct file *file, char __user *buf, size_t len,
-			loff_t *offset)
+static ssize_t occ_read(struct file *file, char __user *buf, size_t len, loff_t *offset)
 {
-	struct occ_client *client = file->private_data;
-	ssize_t rc = 0;
-
-	if (!client)
-		return -ENODEV;
+	struct occ_user *user;
+	size_t offs = *offset;
+	int rc;
 
-	if (len > OCC_SRAM_BYTES)
+	if (len + offs > OCC_SRAM_BYTES)
 		return -EINVAL;
 
-	mutex_lock(&client->lock);
+	user = file->private_data;
+	mutex_lock(&user->lock);
 
-	/* This should not be possible ... */
-	if (WARN_ON_ONCE(client->read_offset > client->data_size)) {
-		rc = -EIO;
-		goto done;
+	if (!offs) {
+		if (!user->pending.pending) {
+			rc = -EAGAIN;
+			goto done;
+		}
+
+		user->pending.pending = 0;
+
+		/* 1 byte sequence, 1 byte command type, 2 bytes data size, 2 bytes checksum */
+		rc = occ_submit(user->occ, user->pending.buffer, user->pending.data_size + 6,
+				&user->pending);
+		if (rc)
+			goto done;
 	}
 
-	/* Grab how much data we have to read */
-	rc = min(len, client->data_size - client->read_offset);
-	if (copy_to_user(buf, client->buffer + client->read_offset, rc))
+	rc = min(len, user->pending.data_size - offs);
+	if (copy_to_user(buf, user->pending.buffer + offs, rc))
 		rc = -EFAULT;
 	else
-		client->read_offset += rc;
-
- done:
-	mutex_unlock(&client->lock);
+		*offset += rc;
 
+done:
+	mutex_unlock(&user->lock);
 	return rc;
 }
 
-static ssize_t occ_write(struct file *file, const char __user *buf,
-			 size_t len, loff_t *offset)
+static ssize_t occ_write(struct file *file, const char __user *buf, size_t len, loff_t *offset)
 {
-	struct occ_client *client = file->private_data;
-	size_t rlen, data_length;
-	ssize_t rc;
-	u8 *cmd;
-
-	if (!client)
-		return -ENODEV;
+	struct occ_user *user;
+	int rc;
 
 	if (len > (OCC_CMD_DATA_BYTES + 3) || len < 3)
 		return -EINVAL;
 
-	mutex_lock(&client->lock);
+	user = file->private_data;
+	mutex_lock(&user->lock);
 
-	/* Construct the command */
-	cmd = client->buffer;
+	if (len > user->pending.buffer_size) {
+		occ_pending_alloc(&user->pending, len + 3);
+		if (!user->pending.buffer) {
+			rc = -ENOMEM;
+			goto done;
+		}
+	}
 
 	/*
-	 * Copy the user command (assume user data follows the occ command
-	 * format)
-	 * byte 0: command type
-	 * bytes 1-2: data length (msb first)
-	 * bytes 3-n: data
+	 * Copy the user command (assume user data follows the occ command format)
+	 *  byte 0: command type
+	 *  bytes 1-2: data length (msb first)
+	 *  bytes 3-n: data
 	 */
-	if (copy_from_user(&cmd[1], buf, len)) {
+	if (copy_from_user(&user->pending.buffer[1], buf, len)) {
 		rc = -EFAULT;
+		occ_release_command(user);
 		goto done;
 	}
 
-	/* Extract data length */
-	data_length = (cmd[2] << 8) + cmd[3];
-	if (data_length > OCC_CMD_DATA_BYTES) {
+	user->pending.data_size = (user->pending.buffer[2] << 8) + user->pending.buffer[3];
+	if (user->pending.data_size > OCC_CMD_DATA_BYTES) {
 		rc = -EINVAL;
+		occ_release_command(user);
 		goto done;
 	}
 
-	/* Submit command; 4 bytes before the data and 2 bytes after */
-	rlen = PAGE_SIZE;
-	rc = fsi_occ_submit(client->occ->dev, cmd, data_length + 6, cmd,
-			    &rlen);
-	if (rc)
-		goto done;
-
-	/* Set read tracking data */
-	client->data_size = rlen;
-	client->read_offset = 0;
-
-	/* Done */
+	user->pending.pending = 1;
 	rc = len;
 
- done:
-	mutex_unlock(&client->lock);
-
+done:
+	mutex_unlock(&user->lock);
 	return rc;
 }
 
 static int occ_release(struct inode *inode, struct file *file)
 {
-	struct occ_client *client = file->private_data;
-
-	put_device(client->occ->dev);
-	free_page((unsigned long)client->buffer);
-	kfree(client);
+	struct occ_user *user = file->private_data;
 
+	occ_release_command(user);
+	kfree(user);
 	return 0;
 }
 
@@ -136,4 +142,16 @@ static const struct file_operations occ_fops = {
 	.read = occ_read,
 	.write = occ_write,
 	.release = occ_release,
-};
\ No newline at end of file
+};
+
+void occ_cdev_init(struct occ *occ)
+{
+	int rc;
+
+	cdev_init(&occ->occ, &occ_fops);
+	rc = cdev_device_add(&occ->occ, &occ->dev);
+	if (rc) {
+		occ->no_cdev = 1;
+		dev_err(&occ->dev, "Failed to create char device: %d.\n", rc);
+	}
+}
diff --git a/drivers/fsi/occ.c b/drivers/fsi/occ.c
index 83429b0289e9..37834219f64d 100644
--- a/drivers/fsi/occ.c
+++ b/drivers/fsi/occ.c
@@ -1,30 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) IBM Corporation 2022 */
 
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
+#include <linux/fsi.h>
+#include <linux/fsi-occ.h>
 #include <linux/fsi-sbefifo.h>
-#include <linux/gfp.h>
-#include <linux/idr.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/miscdevice.h>
+#include <linux/jiffies.h>
 #include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/fsi-occ.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/sched.h>
+#include <linux/property.h>
 #include <linux/slab.h>
-#include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
-#define OCC_SRAM_BYTES		4096
-#define OCC_CMD_DATA_BYTES	4090
-#define OCC_RESP_DATA_BYTES	4089
+#include "occ.h"
+#include "sbefifo.h"
 
 #define OCC_P9_SRAM_CMD_ADDR	0xFFFBE000
 #define OCC_P9_SRAM_RSP_ADDR	0xFFFBF000
@@ -37,64 +25,61 @@
 #define OCC_TIMEOUT_MS		1000
 #define OCC_CMD_IN_PRG_WAIT_MS	50
 
-enum versions { occ_p9, occ_p10 };
-
-struct occ {
-	struct device *dev;
-	struct device *sbefifo;
-	char name[32];
-	int idx;
-	bool platform_hwmon;
-	u8 sequence_number;
-	void *buffer;
-	void *client_buffer;
-	size_t client_buffer_size;
-	size_t client_response_size;
-	enum versions version;
-	struct miscdevice mdev;
-	struct mutex occ_lock;
-};
-
-#define to_occ(x)	container_of((x), struct occ, mdev)
-
 struct occ_response {
 	u8 seq_no;
 	u8 cmd_type;
 	u8 return_status;
 	__be16 data_length;
-	u8 data[OCC_RESP_DATA_BYTES + 2];	/* two bytes checksum */
+	u8 data[OCC_RESP_DATA_BYTES];
+	u16 checksum;
 } __packed;
 
-struct occ_client {
-	struct occ *occ;
-	struct mutex lock;
-	size_t data_size;
-	size_t read_offset;
-	u8 *buffer;
-};
+void occ_pending_alloc(struct occ_pending *pending, size_t size)
+{
+	if (pending->allocated) {
+		void *b = krealloc(pending->buffer, size, GFP_KERNEL);
 
-#define to_client(x)	container_of((x), struct occ_client, xfr)
+		if (!b)
+			kfree(pending->buffer);
 
-static DEFINE_IDA(occ_ida);
+		pending->buffer = b;
+	} else {
+		pending->buffer = kmalloc(size, GFP_KERNEL);
+		pending->allocated = 1;
+	}
 
-static void occ_save_ffdc(struct occ *occ, __be32 *resp, size_t parsed_len,
-			  size_t resp_len)
+	pending->buffer_size = size;
+}
+
+static int occ_store(const void *data, size_t size, struct occ_pending *pending)
+{
+	if (size > pending->buffer_size) {
+		if (!pending->resizable)
+			return -ENOBUFS;
+
+		occ_pending_alloc(pending, size);
+		if (!pending->buffer)
+			return -ENOMEM;
+	}
+
+	memcpy(pending->buffer, data, size);
+	pending->data_size = size;
+	return 0;
+}
+
+static void occ_save_ffdc(struct occ *occ, __be32 *resp, size_t parsed_len, size_t resp_len,
+			  struct occ_pending *pending)
 {
 	if (resp_len > parsed_len) {
 		size_t dh = resp_len - parsed_len;
 		size_t ffdc_len = (dh - 1) * 4; /* SBE words are four bytes */
 		__be32 *ffdc = &resp[parsed_len];
 
-		if (ffdc_len > occ->client_buffer_size)
-			ffdc_len = occ->client_buffer_size;
-
-		memcpy(occ->client_buffer, ffdc, ffdc_len);
-		occ->client_response_size = ffdc_len;
+		occ_store(ffdc, ffdc_len, pending);
 	}
 }
 
-static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
-			       u16 data_length)
+static int occ_verify_checksum(struct occ *occ, struct occ_response *resp, u16 data_length)
 {
 	/* Fetch the two bytes after the data for the checksum. */
 	u16 checksum_resp = get_unaligned_be16(&resp->data[data_length]);
@@ -110,22 +95,24 @@ static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
 		checksum += resp->data[i];
 
 	if (checksum != checksum_resp) {
-		dev_err(occ->dev, "Bad checksum: %04x!=%04x\n", checksum,
-			checksum_resp);
+		dev_err(&occ->dev, "Bad checksum: %04x!=%04x\n", checksum, checksum_resp);
 		return -EBADE;
 	}
 
 	return 0;
 }
 
-static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
+static int occ_getsram(struct occ *occ, u32 offset, ssize_t len, struct occ_pending *pending)
 {
-	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
-	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
-	__be32 *resp = occ->buffer;
+	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
+	__be32 *resp = (__be32 *)occ->buffer;
+	size_t resp_data_len;
+	size_t parsed_len;
+	size_t cmd_len;
 	__be32 cmd[6];
-	int idx = 0, rc;
+	int idx = 0;
+	int rc;
 
 	/*
 	 * Magic sequence to do SBE getsram command. SBE will fetch data from
@@ -151,16 +138,15 @@ static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
 	cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_OCC_SRAM);
 	cmd[4 + idx] = cpu_to_be32(data_len);
 
-	rc = sbefifo_submit(occ->sbefifo, cmd, cmd_len, resp, &resp_len);
+	rc = sbefifo_submit(&occ->sbefifo->dev, cmd, cmd_len, resp, &resp_len);
 	if (rc)
 		return rc;
 
-	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_GET_OCC_SRAM,
-				  resp, resp_len, &parsed_len);
+	rc = sbefifo_parse_status(&occ->sbefifo->dev, SBEFIFO_CMD_GET_OCC_SRAM, resp, resp_len,
+				  &parsed_len);
 	if (rc > 0) {
-		dev_err(occ->dev, "SRAM read returned failure status: %08x\n",
-			rc);
-		occ_save_ffdc(occ, resp, parsed_len, resp_len);
+		dev_err(&occ->dev, "SRAM read returned failure status: %08x\n", rc);
+		occ_save_ffdc(occ, resp, parsed_len, resp_len, pending);
 		return -ECOMM;
 	} else if (rc) {
 		return rc;
@@ -168,25 +154,26 @@ static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
 
 	resp_data_len = be32_to_cpu(resp[parsed_len - 1]);
 	if (resp_data_len != data_len) {
-		dev_err(occ->dev, "SRAM read expected %d bytes got %zd\n",
-			data_len, resp_data_len);
+		dev_err(&occ->dev, "SRAM read expected %d bytes got %zd\n", data_len,
+			resp_data_len);
 		rc = -EBADMSG;
-	} else {
-		memcpy(data, resp, len);
 	}
 
 	return rc;
 }
 
-static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
-		       u8 seq_no, u16 checksum)
+static int occ_putsram(struct occ *occ, const void *data, ssize_t len, u8 seq_no, u16 checksum,
+		       struct occ_pending *pending)
 {
-	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
-	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
-	__be32 *buf = occ->buffer;
+	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
+	__be32 *buf = (__be32 *)occ->buffer;
+	size_t resp_data_len;
+	size_t parsed_len;
+	size_t cmd_len;
 	u8 *byte_buf;
-	int idx = 0, rc;
+	int idx = 0;
+	int rc;
 
 	cmd_len = (occ->version == occ_p10) ? 6 : 5;
 	cmd_len += data_len >> 2;
@@ -224,31 +211,28 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 	byte_buf[len - 2] = checksum >> 8;
 	byte_buf[len - 1] = checksum & 0xff;
 
-	rc = sbefifo_submit(occ->sbefifo, buf, cmd_len, buf, &resp_len);
+	rc = sbefifo_submit(&occ->sbefifo->dev, buf, cmd_len, buf, &resp_len);
 	if (rc)
 		return rc;
 
-	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_PUT_OCC_SRAM,
-				  buf, resp_len, &parsed_len);
+	rc = sbefifo_parse_status(&occ->sbefifo->dev, SBEFIFO_CMD_PUT_OCC_SRAM, buf, resp_len,
+				  &parsed_len);
 	if (rc > 0) {
-		dev_err(occ->dev, "SRAM write returned failure status: %08x\n",
-			rc);
-		occ_save_ffdc(occ, buf, parsed_len, resp_len);
+		dev_err(&occ->dev, "SRAM write returned failure status: %08x\n", rc);
+		occ_save_ffdc(occ, buf, parsed_len, resp_len, pending);
 		return -ECOMM;
 	} else if (rc) {
 		return rc;
 	}
 
 	if (parsed_len != 1) {
-		dev_err(occ->dev, "SRAM write response length invalid: %zd\n",
-			parsed_len);
+		dev_err(&occ->dev, "SRAM write response length invalid: %zd\n", parsed_len);
 		rc = -EBADMSG;
 	} else {
 		resp_data_len = be32_to_cpu(buf[0]);
 		if (resp_data_len != data_len) {
-			dev_err(occ->dev,
-				"SRAM write expected %d bytes got %zd\n",
-				data_len, resp_data_len);
+			dev_err(&occ->dev, "SRAM write expected %d bytes got %zd\n", data_len,
+				resp_data_len);
 			rc = -EBADMSG;
 		}
 	}
@@ -256,12 +240,15 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 	return rc;
 }
 
-static int occ_trigger_attn(struct occ *occ)
+static int occ_trigger_attn(struct occ *occ, struct occ_pending *pending)
 {
-	__be32 *buf = occ->buffer;
-	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
-	int idx = 0, rc;
+	__be32 *buf = (__be32 *)occ->buffer;
+	size_t resp_data_len;
+	size_t parsed_len;
+	size_t cmd_len;
+	int idx = 0;
+	int rc;
 
 	switch (occ->version) {
 	default:
@@ -285,31 +272,27 @@ static int occ_trigger_attn(struct occ *occ)
 	buf[5 + idx] = cpu_to_be32(0x20010000);	/* Trigger OCC attention */
 	buf[6 + idx] = 0;
 
-	rc = sbefifo_submit(occ->sbefifo, buf, cmd_len, buf, &resp_len);
+	rc = sbefifo_submit(&occ->sbefifo->dev, buf, cmd_len, buf, &resp_len);
 	if (rc)
 		return rc;
 
-	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_PUT_OCC_SRAM,
-				  buf, resp_len, &parsed_len);
+	rc = sbefifo_parse_status(&occ->sbefifo->dev, SBEFIFO_CMD_PUT_OCC_SRAM, buf, resp_len,
+				  &parsed_len);
 	if (rc > 0) {
-		dev_err(occ->dev, "SRAM attn returned failure status: %08x\n",
-			rc);
-		occ_save_ffdc(occ, buf, parsed_len, resp_len);
+		dev_err(&occ->dev, "SRAM attn returned failure status: %08x\n", rc);
+		occ_save_ffdc(occ, buf, parsed_len, resp_len, pending);
 		return -ECOMM;
 	} else if (rc) {
 		return rc;
 	}
 
 	if (parsed_len != 1) {
-		dev_err(occ->dev, "SRAM attn response length invalid: %zd\n",
-			parsed_len);
+		dev_err(&occ->dev, "SRAM attn response length invalid: %zd\n", parsed_len);
 		rc = -EBADMSG;
 	} else {
 		resp_data_len = be32_to_cpu(buf[0]);
 		if (resp_data_len != 8) {
-			dev_err(occ->dev,
-				"SRAM attn expected 8 bytes got %zd\n",
-				resp_data_len);
+			dev_err(&occ->dev, "SRAM attn expected 8 bytes got %zd\n", resp_data_len);
 			rc = -EBADMSG;
 		}
 	}
@@ -317,61 +300,37 @@ static int occ_trigger_attn(struct occ *occ)
 	return rc;
 }
 
-static bool fsi_occ_response_not_ready(struct occ_response *resp, u8 seq_no,
-				       u8 cmd_type)
+static bool occ_response_not_ready(struct occ_response *resp, u8 seq_no, u8 cmd_type)
 {
 	return resp->return_status == OCC_RESP_CMD_IN_PRG ||
 		resp->return_status == OCC_RESP_CRIT_INIT ||
 		resp->seq_no != seq_no || resp->cmd_type != cmd_type;
 }
 
-int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
-		   void *response, size_t *resp_len)
+int occ_submit(struct occ *occ, const u8 *request, size_t request_size,
+	       struct occ_pending *pending)
 {
+	const unsigned long wait_time = msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
 	const unsigned long timeout = msecs_to_jiffies(OCC_TIMEOUT_MS);
-	const unsigned long wait_time =
-		msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
-	struct occ *occ = dev_get_drvdata(dev);
-	struct occ_response *resp = response;
-	size_t user_resp_len = *resp_len;
-	u8 seq_no;
-	u8 cmd_type;
-	u16 checksum = 0;
-	u16 resp_data_length;
-	const u8 *byte_request = (const u8 *)request;
+	struct occ_response *resp = (struct occ_response *)occ->buffer;
+	u8 cmd_type = request[1];
+	size_t resp_data_length;
 	unsigned long end;
+	u16 checksum = 0;
+	u8 seq_no;
 	int rc;
-	size_t i;
-
-	*resp_len = 0;
+	int i;
 
-	if (!occ)
+	if (occ->dead)
 		return -ENODEV;
 
-	if (user_resp_len < 7) {
-		dev_dbg(dev, "Bad resplen %zd\n", user_resp_len);
-		return -EINVAL;
-	}
-
-	cmd_type = byte_request[1];
-
-	/* Checksum the request, ignoring first byte (sequence number). */
-	for (i = 1; i < req_len - 2; ++i)
-		checksum += byte_request[i];
+	for (i = 1; i < request_size - 2; ++i)
+		checksum += request[i];
 
-	rc = mutex_lock_interruptible(&occ->occ_lock);
+	rc = mutex_lock_interruptible(&occ->lock);
 	if (rc)
 		return rc;
 
-	occ->client_buffer = response;
-	occ->client_buffer_size = user_resp_len;
-	occ->client_response_size = 0;
-
-	if (!occ->buffer) {
-		rc = -ENOENT;
-		goto done;
-	}
-
 	/*
 	 * Get a sequence number and update the counter. Avoid a sequence
 	 * number of 0 which would pass the response check below even if the
@@ -385,27 +344,27 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		occ->sequence_number = 1;
 	checksum += seq_no;
 
-	rc = occ_putsram(occ, request, req_len, seq_no, checksum);
+	rc = occ_putsram(occ, request, request_size, seq_no, checksum, pending);
 	if (rc)
 		goto done;
 
-	rc = occ_trigger_attn(occ);
+	rc = occ_trigger_attn(occ, pending);
 	if (rc)
 		goto done;
 
 	end = jiffies + timeout;
 	while (true) {
 		/* Read occ response header */
-		rc = occ_getsram(occ, 0, resp, 8);
+		rc = occ_getsram(occ, 0, 8, pending);
 		if (rc)
 			goto done;
 
-		if (fsi_occ_response_not_ready(resp, seq_no, cmd_type)) {
+		if (occ_response_not_ready(resp, seq_no, cmd_type)) {
 			if (time_after(jiffies, end)) {
-				dev_err(occ->dev,
-					"resp timeout status=%02x seq=%d cmd=%d, our seq=%d cmd=%d\n",
-					resp->return_status, resp->seq_no,
-					resp->cmd_type, seq_no, cmd_type);
+				dev_err(&occ->dev,
+					"resp timeout sts=%02x seq=%d cmd=%d, our seq=%d cmd=%d\n",
+					resp->return_status, resp->seq_no, resp->cmd_type, seq_no,
+					cmd_type);
 				rc = -ETIMEDOUT;
 				goto done;
 			}
@@ -414,14 +373,13 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 			schedule_timeout(wait_time);
 		} else {
 			/* Extract size of response data */
-			resp_data_length =
-				get_unaligned_be16(&resp->data_length);
+			resp_data_length = get_unaligned_be16(&resp->data_length);
 
 			/*
 			 * Message size is data length + 5 bytes header + 2
 			 * bytes checksum
 			 */
-			if ((resp_data_length + 7) > user_resp_len) {
+			if ((resp_data_length + 7) > sizeof(occ->buffer)) {
 				rc = -EMSGSIZE;
 				goto done;
 			}
@@ -431,13 +389,11 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 			 * in case it changed
 			 */
 			if (resp_data_length > 1) {
-				rc = occ_getsram(occ, 0, resp,
-						 resp_data_length + 7);
+				rc = occ_getsram(occ, 0, resp_data_length + 7, pending);
 				if (rc)
 					goto done;
 
-				if (!fsi_occ_response_not_ready(resp, seq_no,
-								cmd_type))
+				if (!occ_response_not_ready(resp, seq_no, cmd_type))
 					break;
 			} else {
 				break;
@@ -445,185 +401,136 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		}
 	}
 
-	dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
-		resp->return_status, resp_data_length);
-
 	rc = occ_verify_checksum(occ, resp, resp_data_length);
 	if (rc)
 		goto done;
 
-	occ->client_response_size = resp_data_length + 7;
-
- done:
-	*resp_len = occ->client_response_size;
-	mutex_unlock(&occ->occ_lock);
+	rc = occ_store(resp, resp_data_length + 7, pending);
 
+done:
+	mutex_unlock(&occ->lock);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(fsi_occ_submit);
 
-static int occ_unregister_platform_child(struct device *dev, void *data)
+static void occ_free(struct device *dev)
 {
-	struct platform_device *hwmon_dev = to_platform_device(dev);
+	struct occ *occ = container_of(dev, struct occ, dev);
 
-	platform_device_unregister(hwmon_dev);
+	put_device(dev->parent);
+	kvfree(occ);
+}
 
-	return 0;
+static const struct property_entry hwmon_properties[] = {
+	PROPERTY_ENTRY_BOOL("ibm,no-poll-on-init"),
+	{ }
+};
+
+static void occ_register_hwmon(struct occ *occ, int idx)
+{
+	struct platform_device_info hwmon_dev_info = {
+		.parent = &occ->dev,
+		.name = "occ-hwmon",
+		.id = idx,
+		.properties = hwmon_properties,
+	};
+	struct platform_device *hwmon_dev;
+
+	hwmon_dev = platform_device_register_full(&hwmon_dev_info);
+	if (IS_ERR(hwmon_dev))
+		dev_warn(&occ->dev, "Failed to create hwmon device: %ld.\n", PTR_ERR(hwmon_dev));
 }
 
-static int occ_unregister_of_child(struct device *dev, void *data)
+static int occ_unregister_child(struct device *dev, void *data)
 {
 	struct platform_device *hwmon_dev = to_platform_device(dev);
 
-	of_device_unregister(hwmon_dev);
-	if (dev->of_node)
-		of_node_clear_flag(dev->of_node, OF_POPULATED);
+	platform_device_unregister(hwmon_dev);
 
 	return 0;
 }
 
-static int occ_probe(struct platform_device *pdev)
+struct occ *occ_create(struct sbefifo *sbefifo,
+		       int (*get_devt)(struct device *, int, dev_t *, int *), enum versions v)
 {
-	int rc;
-	u32 reg;
-	char child_name[32];
 	struct occ *occ;
-	struct platform_device *hwmon_dev = NULL;
-	struct device_node *hwmon_node;
-	struct device *dev = &pdev->dev;
-	struct platform_device_info hwmon_dev_info = {
-		.parent = dev,
-		.name = "occ-hwmon",
-	};
+	int idx;
+	int rc;
+
+	if (!get_device(&sbefifo->dev))
+		return NULL;
 
-	occ = devm_kzalloc(dev, sizeof(*occ), GFP_KERNEL);
-	if (!occ)
-		return -ENOMEM;
+	occ = kvzalloc(sizeof(*occ), GFP_KERNEL);
+	if (!occ) {
+		put_device(&sbefifo->dev);
+		return NULL;
+	}
+
+	rc = get_devt(sbefifo->dev.parent, (int)fsi_dev_occ, &occ->dev.devt, &idx);
+	if (rc) {
+		kvfree(occ);
+		put_device(&sbefifo->dev);
+		return NULL;
+	}
+
+	occ->dev.type = &fsi_cdev_type;
+	occ->dev.parent = &sbefifo->dev;
+	occ->dev.release = occ_free;
+	device_initialize(&occ->dev);
+	dev_set_name(&occ->dev, "occ%d", idx);
 
-	/* SBE words are always four bytes */
-	occ->buffer = kvmalloc(OCC_MAX_RESP_WORDS * 4, GFP_KERNEL);
-	if (!occ->buffer)
-		return -ENOMEM;
+	occ_cdev_init(occ);
 
-	occ->version = (uintptr_t)of_device_get_match_data(dev);
-	occ->dev = dev;
-	occ->sbefifo = dev->parent;
+	mutex_init(&occ->lock);
+	occ->sbefifo = sbefifo;
+	occ->version = v;
 	/*
 	 * Quickly derive a pseudo-random number from jiffies so that
 	 * re-probing the driver doesn't accidentally overlap sequence numbers.
 	 */
 	occ->sequence_number = (u8)((jiffies % 0xff) + 1);
-	mutex_init(&occ->occ_lock);
-
-	if (dev->of_node) {
-		rc = of_property_read_u32(dev->of_node, "reg", &reg);
-		if (!rc) {
-			/* make sure we don't have a duplicate from dts */
-			occ->idx = ida_simple_get(&occ_ida, reg, reg + 1,
-						  GFP_KERNEL);
-			if (occ->idx < 0)
-				occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-							  GFP_KERNEL);
-		} else {
-			occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-						  GFP_KERNEL);
-		}
-	} else {
-		occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX, GFP_KERNEL);
-	}
-
-	platform_set_drvdata(pdev, occ);
-
-	snprintf(occ->name, sizeof(occ->name), "occ%d", occ->idx);
-	occ->mdev.fops = &occ_fops;
-	occ->mdev.minor = MISC_DYNAMIC_MINOR;
-	occ->mdev.name = occ->name;
-	occ->mdev.parent = dev;
-
-	rc = misc_register(&occ->mdev);
-	if (rc) {
-		dev_err(dev, "failed to register miscdevice: %d\n", rc);
-		ida_simple_remove(&occ_ida, occ->idx);
-		kvfree(occ->buffer);
-		return rc;
-	}
 
-	hwmon_node = of_get_child_by_name(dev->of_node, hwmon_dev_info.name);
-	if (hwmon_node) {
-		snprintf(child_name, sizeof(child_name), "%s.%d", hwmon_dev_info.name, occ->idx);
-		hwmon_dev = of_platform_device_create(hwmon_node, child_name, dev);
-		of_node_put(hwmon_node);
-	}
-
-	if (!hwmon_dev) {
-		occ->platform_hwmon = true;
-		hwmon_dev_info.id = occ->idx;
-		hwmon_dev = platform_device_register_full(&hwmon_dev_info);
-		if (IS_ERR(hwmon_dev))
-			dev_warn(dev, "failed to create hwmon device\n");
-	}
+	occ_register_hwmon(occ, idx);
 
-	return 0;
+	return occ;
 }
+EXPORT_SYMBOL_GPL(occ_create);
 
-static int occ_remove(struct platform_device *pdev)
+void occ_destroy(struct occ *occ, void(*free_devt)(dev_t))
 {
-	struct occ *occ = platform_get_drvdata(pdev);
-
-	misc_deregister(&occ->mdev);
+	occ->dead = 1;
 
-	mutex_lock(&occ->occ_lock);
-	kvfree(occ->buffer);
-	occ->buffer = NULL;
-	mutex_unlock(&occ->occ_lock);
+	device_for_each_child(&occ->dev, NULL, occ_unregister_child);
 
-	if (occ->platform_hwmon)
-		device_for_each_child(&pdev->dev, NULL, occ_unregister_platform_child);
-	else
-		device_for_each_child(&pdev->dev, NULL, occ_unregister_of_child);
+	if (free_devt)
+		free_devt(occ->dev.devt);
 
-	ida_simple_remove(&occ_ida, occ->idx);
+	if (!occ->no_cdev)
+		cdev_device_del(&occ->occ, &occ->dev);
 
-	return 0;
+	put_device(&occ->dev);
 }
+EXPORT_SYMBOL_GPL(occ_destroy);
 
-static const struct of_device_id occ_match[] = {
-	{
-		.compatible = "ibm,p9-occ",
-		.data = (void *)occ_p9
-	},
-	{
-		.compatible = "ibm,p10-occ",
-		.data = (void *)occ_p10
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, occ_match);
-
-static struct platform_driver occ_driver = {
-	.driver = {
-		.name = "occ",
-		.of_match_table	= occ_match,
-	},
-	.probe	= occ_probe,
-	.remove = occ_remove,
-};
-
-static int occ_init(void)
+int fsi_occ_submit(struct device *dev, const void *request, size_t req_len, void *response,
+		   size_t *resp_len)
 {
-	return platform_driver_register(&occ_driver);
-}
+	struct occ *occ = container_of(dev, struct occ, dev);
+	struct occ_pending pending;
+	int rc;
 
-static void occ_exit(void)
-{
-	platform_driver_unregister(&occ_driver);
+	pending.buffer = response;
+	pending.buffer_size = *resp_len;
+	pending.data_size = 0;
+	pending.allocated = 0;
+	pending.resizable = 0;
+	pending.pending = 0;
 
-	ida_destroy(&occ_ida);
+	rc = occ_submit(occ, request, req_len, &pending);
+	*resp_len = pending.data_size;
+	return rc;
 }
-
-module_init(occ_init);
-module_exit(occ_exit);
+EXPORT_SYMBOL_GPL(fsi_occ_submit);
 
 MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
-MODULE_DESCRIPTION("BMC P9 OCC driver");
+MODULE_DESCRIPTION("OCC communications driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/fsi/occ.h b/drivers/fsi/occ.h
new file mode 100644
index 000000000000..bbb1b3aecdeb
--- /dev/null
+++ b/drivers/fsi/occ.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) IBM Corporation 2022 */
+
+#ifndef DRIVERS_OCC_H
+#define DRIVERS_OCC_H
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fsi-occ.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#define OCC_SRAM_BYTES		4096
+#define OCC_CMD_DATA_BYTES	4090
+#define OCC_RESP_DATA_BYTES	4089
+
+struct sbefifo;
+
+enum versions { occ_p9, occ_p10, };
+
+struct occ {
+	struct device dev;
+	struct cdev occ;
+	struct mutex lock;	// device lock
+	struct sbefifo *sbefifo;
+	enum versions version;
+	u8 sequence_number;
+	u8 dead : 1;
+	u8 no_cdev : 1;
+	u8 buffer[OCC_MAX_RESP_WORDS * 4];
+};
+
+struct occ_pending {
+	u8 *buffer;
+	size_t buffer_size;
+	size_t data_size;
+	u8 allocated : 1;
+	u8 pending : 1;
+	u8 resizable : 1;
+};
+
+struct occ_user {
+	struct mutex lock;	// file lock
+	struct occ *occ;
+	struct occ_pending pending;
+	u8 buffer[128];
+};
+
+void occ_cdev_init(struct occ *occ);
+struct occ *occ_create(struct sbefifo *sbefifo,
+		       int (*get_devt)(struct device *, int, dev_t *, int *), enum versions v);
+void occ_destroy(struct occ *occ, void(*free_devt)(dev_t));
+void occ_pending_alloc(struct occ_pending *pending, size_t size);
+int occ_submit(struct occ *occ, const u8 *request, size_t request_size,
+	       struct occ_pending *pending);
+
+#endif /* DRIVERS_OCC_H */
diff --git a/drivers/fsi/sbefifo-cdev.c b/drivers/fsi/sbefifo-cdev.c
index 75765e8c307a..ba34b1436557 100644
--- a/drivers/fsi/sbefifo-cdev.c
+++ b/drivers/fsi/sbefifo-cdev.c
@@ -1,217 +1,218 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) IBM Corporation 2022 */
 
-/*
- * Char device interface
- */
+#include <linux/container_of.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/uio.h>
+
+#include <uapi/linux/fsi.h>
+
+#include "sbefifo.h"
+
+struct sbefifo_user {
+	struct mutex lock;	// file lock
+	struct sbefifo *sbefifo;
+	struct {
+		void *buffer;
+		size_t size;
+	} pending;
+	unsigned int timeout;
+	u8 buffer[128];
+};
 
 static void sbefifo_release_command(struct sbefifo_user *user)
 {
-	if (is_vmalloc_addr(user->pending_cmd))
-		vfree(user->pending_cmd);
-	user->pending_cmd = NULL;
-	user->pending_len = 0;
+	if (user->pending.buffer != user->buffer)
+		kvfree(user->pending.buffer);
+
+	user->pending.buffer = NULL;
+	user->pending.size = 0;
 }
 
-static int sbefifo_user_open(struct inode *inode, struct file *file)
+static int sbefifo_open(struct inode *inode, struct file *file)
 {
-	struct sbefifo *sbefifo = container_of(inode->i_cdev, struct sbefifo, cdev);
 	struct sbefifo_user *user;
 
-	user = kzalloc(sizeof(struct sbefifo_user), GFP_KERNEL);
+	user = kmalloc(sizeof(*user), GFP_KERNEL);
 	if (!user)
 		return -ENOMEM;
 
 	file->private_data = user;
-	user->sbefifo = sbefifo;
-	user->cmd_page = (void *)__get_free_page(GFP_KERNEL);
-	if (!user->cmd_page) {
-		kfree(user);
-		return -ENOMEM;
-	}
-	mutex_init(&user->file_lock);
-	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
+	mutex_init(&user->lock);
+	user->sbefifo = container_of(inode->i_cdev, struct sbefifo, sbe);
+	user->pending.buffer = NULL;
+	user->pending.size = 0;
+	user->timeout = SBEFIFO_TIMEOUT_START_RSP;
 
 	return 0;
 }
 
-static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
-				 size_t len, loff_t *offset)
+static ssize_t sbefifo_read(struct file *file, char __user *buf, size_t len, loff_t *offset)
 {
-	struct sbefifo_user *user = file->private_data;
-	struct sbefifo *sbefifo;
+	struct sbefifo_user *user;
 	struct iov_iter resp_iter;
-        struct iovec resp_iov;
-	size_t cmd_len;
+	struct iovec resp_iov;
 	int rc;
 
-	if (!user)
-		return -EINVAL;
-	sbefifo = user->sbefifo;
 	if (len & 3)
 		return -EINVAL;
 
-	mutex_lock(&user->file_lock);
+	user = file->private_data;
+	mutex_lock(&user->lock);
 
-	/* Cronus relies on -EAGAIN after a short read */
-	if (user->pending_len == 0) {
+	if (!user->pending.size) {
 		rc = -EAGAIN;
-		goto bail;
+		goto done;
 	}
-	if (user->pending_len < 8) {
+
+	if (user->pending.size < 8) {
 		rc = -EINVAL;
-		goto bail;
+		goto done;
 	}
-	cmd_len = user->pending_len >> 2;
 
-	/* Prepare iov iterator */
 	resp_iov.iov_base = buf;
 	resp_iov.iov_len = len;
 	iov_iter_init(&resp_iter, WRITE, &resp_iov, 1, len);
 
-	/* Perform the command */
-	rc = mutex_lock_interruptible(&sbefifo->lock);
+	rc = mutex_lock_interruptible(&user->sbefifo->lock);
+	if (rc)
+		goto done;
+	user->sbefifo->timeout = user->timeout;
+	rc = sbefifo_submit_internal(user->sbefifo, user->pending.buffer, user->pending.size >> 2,
+				     &resp_iter);
+	user->sbefifo->timeout = SBEFIFO_TIMEOUT_START_RSP;
+	mutex_unlock(&user->sbefifo->lock);
 	if (rc)
-		goto bail;
-	sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
-	rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
-	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
-	mutex_unlock(&sbefifo->lock);
-	if (rc < 0)
-		goto bail;
-
-	/* Extract the response length */
+		goto done;
+
 	rc = len - iov_iter_count(&resp_iter);
- bail:
+
+done:
 	sbefifo_release_command(user);
-	mutex_unlock(&user->file_lock);
+	mutex_unlock(&user->lock);
 	return rc;
 }
 
-static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
-				  size_t len, loff_t *offset)
+static ssize_t sbefifo_write(struct file *file, const char __user *buf, size_t len, loff_t *offset)
 {
-	struct sbefifo_user *user = file->private_data;
-	struct sbefifo *sbefifo;
-	int rc = len;
+	struct sbefifo_user *user;
+	int rc;
 
-	if (!user)
-		return -EINVAL;
-	sbefifo = user->sbefifo;
-	if (len > SBEFIFO_MAX_USER_CMD_LEN)
-		return -EINVAL;
-	if (len & 3)
+	if (len > SBEFIFO_MAX_USER_CMD_LEN || len & 3)
 		return -EINVAL;
 
-	mutex_lock(&user->file_lock);
-
-	/* Can we use the pre-allocate buffer ? If not, allocate */
-	if (len <= PAGE_SIZE)
-		user->pending_cmd = user->cmd_page;
-	else
-		user->pending_cmd = vmalloc(len);
-	if (!user->pending_cmd) {
-		rc = -ENOMEM;
-		goto bail;
+	user = file->private_data;
+	mutex_lock(&user->lock);
+
+	if (len <= sizeof(user->buffer)) {
+		user->pending.buffer = user->buffer;
+	} else {
+		user->pending.buffer = kvmalloc(len, GFP_KERNEL);
+		if (!user->pending.buffer) {
+			user->pending.size = 0;
+			rc = -ENOMEM;
+			goto done;
+		}
 	}
 
-	/* Copy the command into the staging buffer */
-	if (copy_from_user(user->pending_cmd, buf, len)) {
+	if (copy_from_user(user->pending.buffer, buf, len)) {
 		rc = -EFAULT;
-		goto bail;
+		sbefifo_release_command(user);
+		goto done;
 	}
 
 	/* Check for the magic reset command */
-	if (len == 4 && be32_to_cpu(*(__be32 *)user->pending_cmd) ==
-	    SBEFIFO_RESET_MAGIC)  {
+	if (len == 4 && be32_to_cpu(*(__be32 *)user->pending.buffer) == SBEFIFO_RESET_MAGIC) {
+		user->pending.buffer = NULL;
+		user->pending.size = 0;
 
-		/* Clear out any pending command */
-		user->pending_len = 0;
-
-		/* Trigger reset request */
-		rc = mutex_lock_interruptible(&sbefifo->lock);
+		rc = mutex_lock_interruptible(&user->sbefifo->lock);
 		if (rc)
-			goto bail;
+			goto done;
 		rc = sbefifo_request_reset(user->sbefifo);
-		mutex_unlock(&sbefifo->lock);
-		if (rc == 0)
+		mutex_unlock(&user->sbefifo->lock);
+		if (!rc)
 			rc = 4;
-		goto bail;
+	} else {
+		user->pending.size = len;
+		rc = len;
 	}
 
-	/* Update the staging buffer size */
-	user->pending_len = len;
- bail:
-	if (!user->pending_len)
-		sbefifo_release_command(user);
-
-	mutex_unlock(&user->file_lock);
-
-	/* And that's it, we'll issue the command on a read */
+done:
+	mutex_unlock(&user->lock);
 	return rc;
 }
 
-static int sbefifo_user_release(struct inode *inode, struct file *file)
+static int sbefifo_release(struct inode *inode, struct file *file)
 {
 	struct sbefifo_user *user = file->private_data;
 
-	if (!user)
-		return -EINVAL;
-
 	sbefifo_release_command(user);
-	free_page((unsigned long)user->cmd_page);
 	kfree(user);
-
 	return 0;
 }
 
 static int sbefifo_read_timeout(struct sbefifo_user *user, void __user *argp)
 {
-	struct device *dev = &user->sbefifo->dev;
 	u32 timeout;
 
 	if (get_user(timeout, (__u32 __user *)argp))
 		return -EFAULT;
 
-	if (timeout == 0) {
-		user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
-		dev_dbg(dev, "Timeout reset to %d\n", user->read_timeout_ms);
+	if (!timeout) {
+		user->timeout = SBEFIFO_TIMEOUT_START_RSP;
 		return 0;
 	}
 
 	if (timeout < 10 || timeout > 120)
 		return -EINVAL;
 
-	user->read_timeout_ms = timeout * 1000; /* user timeout is in sec */
-
-	dev_dbg(dev, "Timeout set to %d\n", user->read_timeout_ms);
-
+	user->timeout = timeout * 1000;
 	return 0;
 }
 
-static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long sbefifo_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct sbefifo_user *user = file->private_data;
-	int rc = -ENOTTY;
+	struct sbefifo_user *user;
+	int rc;
 
-	if (!user)
-		return -EINVAL;
+	user = file->private_data;
+	mutex_lock(&user->lock);
 
-	mutex_lock(&user->file_lock);
 	switch (cmd) {
 	case FSI_SBEFIFO_READ_TIMEOUT_SECONDS:
 		rc = sbefifo_read_timeout(user, (void __user *)arg);
 		break;
+	default:
+		rc = -ENOTTY;
+		break;
 	}
-	mutex_unlock(&user->file_lock);
+
+	mutex_unlock(&user->lock);
 	return rc;
 }
 
 static const struct file_operations sbefifo_fops = {
-	.owner		= THIS_MODULE,
-	.open		= sbefifo_user_open,
-	.read		= sbefifo_user_read,
-	.write		= sbefifo_user_write,
-	.release	= sbefifo_user_release,
-	.unlocked_ioctl = sbefifo_user_ioctl,
+	.owner = THIS_MODULE,
+	.open = sbefifo_open,
+	.read = sbefifo_read,
+	.write = sbefifo_write,
+	.release = sbefifo_release,
+	.unlocked_ioctl = sbefifo_ioctl,
 };
+
+void sbefifo_cdev_init(struct sbefifo *sbefifo)
+{
+	int rc;
+
+	cdev_init(&sbefifo->sbe, &sbefifo_fops);
+	rc = cdev_device_add(&sbefifo->sbe, &sbefifo->dev);
+	if (rc) {
+		sbefifo->no_cdev = 1;
+		dev_err(&sbefifo->dev, "Failed to create char device: %d.\n", rc);
+	}
+}
diff --git a/drivers/fsi/sbefifo-fsi.c b/drivers/fsi/sbefifo-fsi.c
new file mode 100644
index 000000000000..9b425cf71ca8
--- /dev/null
+++ b/drivers/fsi/sbefifo-fsi.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) IBM Corporation 2022 */
+
+#include <linux/fsi.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+
+#include "sbefifo.h"
+
+static int sbefifo_fsi_get_devt(struct device *dev, int type, dev_t *devt, int *idx)
+{
+	return fsi_get_new_minor(to_fsi_dev(dev), (enum fsi_dev_type)type, devt, idx);
+}
+
+static int sbefifo_fsi_probe(struct device *dev)
+{
+	struct regmap_config cfg = {
+		.reg_bits = 32,
+		.reg_stride = 4,
+		.val_bits = 32,
+		.disable_locking = true,
+		.cache_type = REGCACHE_NONE,
+		.val_format_endian = REGMAP_ENDIAN_BIG,
+	};
+	struct fsi_device *fsi_dev;
+	struct regmap *regmap;
+	struct sbefifo *sbefifo;
+
+	fsi_dev = to_fsi_dev(dev);
+	regmap = regmap_init_fsi(fsi_dev, &cfg);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	sbefifo = sbefifo_create(dev, regmap, sbefifo_fsi_get_devt);
+	if (IS_ERR(sbefifo)) {
+		regmap_exit(regmap);
+		return PTR_ERR(sbefifo);
+	}
+
+	sbefifo->fsi_dev = fsi_dev;
+	dev_set_drvdata(dev, sbefifo);
+
+	return 0;
+}
+
+static int sbefifo_fsi_remove(struct device *dev)
+{
+	sbefifo_destroy(dev_get_drvdata(dev), fsi_free_minor);
+	return 0;
+}
+
+static const struct fsi_device_id sbefifo_fsi_ids[] = {
+	{ .engine_type = 0x22, .version = FSI_VERSION_ANY, },
+	{ }
+};
+
+static struct fsi_driver sbefifo_fsi_driver = {
+	.drv = {
+		.name = SBEFIFO_DEVICE_NAME,
+		.bus = &fsi_bus_type,
+		.probe = sbefifo_fsi_probe,
+		.remove = sbefifo_fsi_remove,
+	},
+	.id_table = sbefifo_fsi_ids,
+};
+
+module_fsi_driver(sbefifo_fsi_driver);
diff --git a/drivers/fsi/sbefifo-i2c.c b/drivers/fsi/sbefifo-i2c.c
new file mode 100644
index 000000000000..efc526a5947c
--- /dev/null
+++ b/drivers/fsi/sbefifo-i2c.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) IBM Corporation 2022 */
+
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include <linux/kdev_t.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+
+#include "i2cr.h"
+#include "sbefifo.h"
+
+static int sbefifo_i2c_get_devt(struct device *dev, int type, dev_t *devt, int *idx)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	*idx = client->adapter->nr;
+	*devt = MKDEV(I2C_MAJOR, (*idx << 7) | client->addr | type);
+
+	return 0;
+}
+
+static int sbefifo_i2c_probe(struct i2c_client *client)
+{
+	struct regmap_config cfg = {
+		.reg_bits = 32,
+		.reg_stride = 4,
+		.val_bits = 32,
+		.disable_locking = true,
+		.cache_type = REGCACHE_NONE,
+		.val_format_endian = REGMAP_ENDIAN_BIG,
+	};
+	struct regmap *regmap;
+	struct sbefifo *sbefifo;
+
+	regmap = init_i2cr(client, &cfg);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	sbefifo = sbefifo_create(&client->dev, regmap, sbefifo_i2c_get_devt);
+	if (IS_ERR(sbefifo)) {
+		regmap_exit(regmap);
+		return PTR_ERR(sbefifo);
+	}
+
+	sbefifo->i2c_client = client;
+	i2c_set_clientdata(client, sbefifo);
+
+	return 0;
+}
+
+static void sbefifo_i2c_remove(struct i2c_client *client)
+{
+	sbefifo_destroy(i2c_get_clientdata(client), NULL);
+}
+
+static const struct of_device_id sbefifo_i2c_ids[] = {
+	{ .compatible = "ibm,sbefifo", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sbefifo_i2c_ids);
+
+static struct i2c_driver sbefifo_i2c_driver = {
+	.probe_new = sbefifo_i2c_probe,
+	.remove = sbefifo_i2c_remove,
+	.driver = {
+		.name = SBEFIFO_DEVICE_NAME,
+		.of_match_table = sbefifo_i2c_ids,
+	},
+};
+
+module_i2c_driver(sbefifo_i2c_driver);
diff --git a/drivers/fsi/sbefifo.c b/drivers/fsi/sbefifo.c
index 634405b7aaf4..5743912a1b00 100644
--- a/drivers/fsi/sbefifo.c
+++ b/drivers/fsi/sbefifo.c
@@ -1,50 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) IBM Corporation 2017
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERGCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+/* Copyright (C) IBM Corporation 2022 */
 
-#include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/fs.h>
 #include <linux/fsi.h>
 #include <linux/fsi-sbefifo.h>
-#include <linux/kernel.h>
-#include <linux/cdev.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
-#include <linux/sched.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/uaccess.h>
-#include <linux/delay.h>
+#include <linux/sysfs.h>
 #include <linux/uio.h>
 #include <linux/vmalloc.h>
-#include <linux/mm.h>
 
-#include <uapi/linux/fsi.h>
+#include "occ.h"
+#include "sbefifo.h"
 
-/*
- * The SBEFIFO is a pipe-like FSI device for communicating with
- * the self boot engine on POWER processors.
- */
-
-#define DEVICE_NAME		"sbefifo"
-#define FSI_ENGID_SBE		0x22
-
-/*
- * Register layout
- */
+#define SBEFIFO_BASE		0x2400
 
 /* Register banks */
 #define SBEFIFO_UP		0x00		/* FSI -> Host */
@@ -71,6 +40,16 @@
 #define SBEFIFO_EOT_ACK		0x14		/* (Down only) Acknowledge EOT */
 #define SBEFIFO_DOWN_MAX	0x18		/* (Down only) Max transfer */
 
+/* CFAM SCOM ChipID register */
+#define CFAM_SCOM_CHIP_ID	0x1028 /* Converted 0x100a */
+#define CFAM_SCOM_CHIP_ID_CHIP_ID_MASK	0x000FF000
+#define CFAM_SCOM_CHIP_ID_CHIP_ID_SHIFT	12
+
+#define CHIP_ID_P9A		0xd1
+#define CHIP_ID_P9B		0xd4
+#define CHIP_ID_P9plus		0xd9
+#define CHIP_ID_P10		0xda
+
 /* CFAM GP Mailbox SelfBoot Message register */
 #define CFAM_GP_MBOX_SBM_ADDR	0x2824	/* Converted 0x2809 */
 
@@ -79,9 +58,8 @@
 #define CFAM_SBM_SBE_STATE_MASK		0x00f00000
 #define CFAM_SBM_SBE_STATE_SHIFT	20
 
-enum sbe_state
-{
-	SBE_STATE_UNKNOWN = 0x0, // Unkown, initial state
+enum sbe_state {
+	SBE_STATE_UNKNOWN = 0x0, // Unknown, initial state
 	SBE_STATE_IPLING  = 0x1, // IPL'ing - autonomous mode (transient)
 	SBE_STATE_ISTEP   = 0x2, // ISTEP - Running IPL by steps (transient)
 	SBE_STATE_MPIPL   = 0x3, // MPIPL
@@ -93,7 +71,7 @@ enum sbe_state
 };
 
 /* FIFO depth */
-#define SBEFIFO_FIFO_DEPTH		8
+#define SBEFIFO_FIFO_DEPTH	8
 
 /* Helpers */
 #define sbefifo_empty(sts)	((sts) & SBEFIFO_STS_EMPTY)
@@ -109,44 +87,15 @@ enum sbe_state
 /* Timeouts for commands in ms */
 #define SBEFIFO_TIMEOUT_START_CMD	10000
 #define SBEFIFO_TIMEOUT_IN_CMD		1000
-#define SBEFIFO_TIMEOUT_START_RSP	10000
 #define SBEFIFO_TIMEOUT_IN_RSP		1000
 
-/* Other constants */
-#define SBEFIFO_MAX_USER_CMD_LEN	(0x100000 + PAGE_SIZE)
-#define SBEFIFO_RESET_MAGIC		0x52534554 /* "RSET" */
-
-struct sbefifo {
-	uint32_t		magic;
-#define SBEFIFO_MAGIC		0x53424546 /* "SBEF" */
-	struct fsi_device	*fsi_dev;
-	struct device		dev;
-	struct cdev		cdev;
-	struct mutex		lock;
-	bool			broken;
-	bool			dead;
-	bool			async_ffdc;
-	bool			timed_out;
-	u32			timeout_start_rsp_ms;
-};
-
-struct sbefifo_user {
-	struct sbefifo		*sbefifo;
-	struct mutex		file_lock;
-	void			*cmd_page;
-	void			*pending_cmd;
-	size_t			pending_len;
-	u32			read_timeout_ms;
-};
-
 static DEFINE_MUTEX(sbefifo_ffdc_mutex);
 
-static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t timeout_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct sbefifo *sbefifo = container_of(dev, struct sbefifo, dev);
 
-	return sysfs_emit(buf, "%d\n", sbefifo->timed_out ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", sbefifo->timed_out);
 }
 static DEVICE_ATTR_RO(timeout);
 
@@ -160,10 +109,12 @@ static void __sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc,
 
 	while (ffdc_sz) {
 		u32 w0, w1, w2, i;
+
 		if (ffdc_sz < 3) {
 			dev_err(dev, "SBE invalid FFDC package size %zd\n", ffdc_sz);
 			return;
 		}
+
 		w0 = be32_to_cpu(*(ffdc++));
 		w1 = be32_to_cpu(*(ffdc++));
 		w2 = be32_to_cpu(*(ffdc++));
@@ -173,6 +124,7 @@ static void __sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc,
 				w0, w1, w2);
 			break;
 		}
+
 		w0 &= 0xffff;
 		if (w0 > ffdc_sz) {
 			dev_err(dev, "SBE FFDC package len %d words but only %zd remaining\n",
@@ -180,6 +132,7 @@ static void __sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc,
 			w0 = ffdc_sz;
 			break;
 		}
+
 		if (internal) {
 			dev_warn(dev, "+---- SBE FFDC package %d for async err -----+\n",
 				 pack++);
@@ -187,6 +140,7 @@ static void __sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc,
 			dev_warn(dev, "+---- SBE FFDC package %d for cmd %02x:%02x -----+\n",
 				 pack++, (w1 >> 8) & 0xff, w1 & 0xff);
 		}
+
 		dev_warn(dev, "| Response code: %08x                   |\n", w2);
 		dev_warn(dev, "|-------------------------------------------|\n");
 		for (i = 0; i < w0; i++) {
@@ -204,73 +158,29 @@ static void __sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc,
 				dev_warn(dev, "%s |\n", ffdc_line);
 			}
 		}
+
 		dev_warn(dev, "+-------------------------------------------+\n");
 	}
 }
 
-static void sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc,
-			      size_t ffdc_sz, bool internal)
+static void sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc, size_t ffdc_sz,
+			      bool internal)
 {
 	mutex_lock(&sbefifo_ffdc_mutex);
 	__sbefifo_dump_ffdc(dev, ffdc, ffdc_sz, internal);
 	mutex_unlock(&sbefifo_ffdc_mutex);
 }
 
-int sbefifo_parse_status(struct device *dev, u16 cmd, __be32 *response,
-			 size_t resp_len, size_t *data_len)
-{
-	u32 dh, s0, s1;
-	size_t ffdc_sz;
-
-	if (resp_len < 3) {
-		pr_debug("sbefifo: cmd %04x, response too small: %zd\n",
-			 cmd, resp_len);
-		return -ENXIO;
-	}
-	dh = be32_to_cpu(response[resp_len - 1]);
-	if (dh > resp_len || dh < 3) {
-		dev_err(dev, "SBE cmd %02x:%02x status offset out of range: %d/%zd\n",
-			cmd >> 8, cmd & 0xff, dh, resp_len);
-		return -ENXIO;
-	}
-	s0 = be32_to_cpu(response[resp_len - dh]);
-	s1 = be32_to_cpu(response[resp_len - dh + 1]);
-	if (((s0 >> 16) != 0xC0DE) || ((s0 & 0xffff) != cmd)) {
-		dev_err(dev, "SBE cmd %02x:%02x, status signature invalid: 0x%08x 0x%08x\n",
-			cmd >> 8, cmd & 0xff, s0, s1);
-		return -ENXIO;
-	}
-	if (s1 != 0) {
-		ffdc_sz = dh - 3;
-		dev_warn(dev, "SBE error cmd %02x:%02x status=%04x:%04x\n",
-			 cmd >> 8, cmd & 0xff, s1 >> 16, s1 & 0xffff);
-		if (ffdc_sz)
-			sbefifo_dump_ffdc(dev, &response[resp_len - dh + 2],
-					  ffdc_sz, false);
-	}
-	if (data_len)
-		*data_len = resp_len - dh;
-
-	/*
-	 * Primary status don't have the top bit set, so can't be confused with
-	 * Linux negative error codes, so return the status word whole.
-	 */
-	return s1;
-}
-EXPORT_SYMBOL_GPL(sbefifo_parse_status);
-
 static int sbefifo_regr(struct sbefifo *sbefifo, int reg, u32 *word)
 {
 	__be32 raw_word;
 	int rc;
 
-	rc = fsi_device_read(sbefifo->fsi_dev, reg, &raw_word,
-			     sizeof(raw_word));
+	rc = regmap_read(sbefifo->regmap, SBEFIFO_BASE + reg, (unsigned int *)&raw_word);
 	if (rc)
 		return rc;
 
 	*word = be32_to_cpu(raw_word);
-
 	return 0;
 }
 
@@ -278,8 +188,7 @@ static int sbefifo_regw(struct sbefifo *sbefifo, int reg, u32 word)
 {
 	__be32 raw_word = cpu_to_be32(word);
 
-	return fsi_device_write(sbefifo->fsi_dev, reg, &raw_word,
-				sizeof(raw_word));
+	return regmap_write(sbefifo->regmap, SBEFIFO_BASE + reg, (unsigned int)raw_word);
 }
 
 static int sbefifo_check_sbe_state(struct sbefifo *sbefifo)
@@ -288,13 +197,13 @@ static int sbefifo_check_sbe_state(struct sbefifo *sbefifo)
 	u32 sbm;
 	int rc;
 
-	rc = fsi_slave_read(sbefifo->fsi_dev->slave, CFAM_GP_MBOX_SBM_ADDR,
-			    &raw_word, sizeof(raw_word));
+	rc = regmap_read(sbefifo->regmap, CFAM_GP_MBOX_SBM_ADDR, (unsigned int *)&raw_word);
 	if (rc)
 		return rc;
+
 	sbm = be32_to_cpu(raw_word);
 
-	/* SBE booted at all ? */
+	/* SBE booted at all */
 	if (!(sbm & CFAM_SBM_SBE_BOOTED))
 		return -ESHUTDOWN;
 
@@ -317,40 +226,78 @@ static int sbefifo_check_sbe_state(struct sbefifo *sbefifo)
 
 	/* Is there async FFDC available ? Remember it */
 	if (sbm & CFAM_SBM_SBE_ASYNC_FFDC)
-		sbefifo->async_ffdc = true;
+		sbefifo->async_ffdc = 1;
 
 	return 0;
 }
 
-/* Don't flip endianness of data to/from FIFO, just pass through. */
+int sbefifo_parse_status(struct device *dev, u16 cmd, __be32 *response, size_t resp_len,
+			 size_t *data_len)
+{
+	size_t ffdc_sz;
+	u32 dh;
+	u32 s0;
+	u32 s1;
+
+	if (resp_len < 3)
+		return -ENXIO;
+
+	dh = be32_to_cpu(response[resp_len - 1]);
+	if (dh > resp_len || dh < 3) {
+		dev_err(dev, "SBE cmd %02x:%02x status offset out of range: %d/%zd\n", cmd >> 8,
+			cmd & 0xff, dh, resp_len);
+		return -ENXIO;
+	}
+
+	s0 = be32_to_cpu(response[resp_len - dh]);
+	s1 = be32_to_cpu(response[resp_len - dh + 1]);
+	if (((s0 >> 16) != 0xC0DE) || ((s0 & 0xffff) != cmd)) {
+		dev_err(dev, "SBE cmd %02x:%02x, status signature invalid: 0x%08x 0x%08x\n",
+			cmd >> 8, cmd & 0xff, s0, s1);
+		return -ENXIO;
+	}
+
+	if (s1 != 0) {
+		ffdc_sz = dh - 3;
+		dev_warn(dev, "SBE error cmd %02x:%02x status=%04x:%04x\n",  cmd >> 8, cmd & 0xff,
+			 s1 >> 16, s1 & 0xffff);
+		if (ffdc_sz)
+			sbefifo_dump_ffdc(dev, &response[resp_len - dh + 2], ffdc_sz, false);
+	}
+
+	if (data_len)
+		*data_len = resp_len - dh;
+
+	/*
+	 * Primary status don't have the top bit set, so can't be confused with
+	 * Linux negative error codes, so return the status word whole.
+	 */
+	return s1;
+}
+EXPORT_SYMBOL_GPL(sbefifo_parse_status);
+
 static int sbefifo_down_read(struct sbefifo *sbefifo, __be32 *word)
 {
-	return fsi_device_read(sbefifo->fsi_dev, SBEFIFO_DOWN, word,
-			       sizeof(*word));
+	return regmap_read(sbefifo->regmap, SBEFIFO_BASE + SBEFIFO_DOWN, (unsigned int *)word);
 }
 
 static int sbefifo_up_write(struct sbefifo *sbefifo, __be32 word)
 {
-	return fsi_device_write(sbefifo->fsi_dev, SBEFIFO_UP, &word,
-				sizeof(word));
+	return regmap_write(sbefifo->regmap, SBEFIFO_BASE + SBEFIFO_UP, (unsigned int)word);
 }
 
-static int sbefifo_request_reset(struct sbefifo *sbefifo)
+int sbefifo_request_reset(struct sbefifo *sbefifo)
 {
-	struct device *dev = &sbefifo->fsi_dev->dev;
 	unsigned long end_time;
 	u32 status;
 	int rc;
 
-	dev_dbg(dev, "Requesting FIFO reset\n");
-
-	/* Mark broken first, will be cleared if reset succeeds */
 	sbefifo->broken = true;
 
 	/* Send reset request */
 	rc = sbefifo_regw(sbefifo, SBEFIFO_UP | SBEFIFO_REQ_RESET, 1);
 	if (rc) {
-		dev_err(dev, "Sending reset request failed, rc=%d\n", rc);
+		dev_err(&sbefifo->dev, "Sending reset request failed, rc=%d\n", rc);
 		return rc;
 	}
 
@@ -359,44 +306,40 @@ static int sbefifo_request_reset(struct sbefifo *sbefifo)
 	while (!time_after(jiffies, end_time)) {
 		rc = sbefifo_regr(sbefifo, SBEFIFO_UP | SBEFIFO_STS, &status);
 		if (rc) {
-			dev_err(dev, "Failed to read UP fifo status during reset"
-				" , rc=%d\n", rc);
+			dev_err(&sbefifo->dev, "Failed to read status during reset, rc=%d\n", rc);
 			return rc;
 		}
 
 		if (!(status & SBEFIFO_STS_RESET_REQ)) {
-			dev_dbg(dev, "FIFO reset done\n");
 			sbefifo->broken = false;
 			return 0;
 		}
 
 		cond_resched();
 	}
-	dev_err(dev, "FIFO reset timed out\n");
 
+	dev_err(&sbefifo->dev, "FIFO reset timed out\n");
 	return -ETIMEDOUT;
 }
 
 static int sbefifo_cleanup_hw(struct sbefifo *sbefifo)
 {
-	struct device *dev = &sbefifo->fsi_dev->dev;
-	u32 up_status, down_status;
 	bool need_reset = false;
+	u32 down_status;
+	u32 up_status;
 	int rc;
 
 	rc = sbefifo_check_sbe_state(sbefifo);
-	if (rc) {
-		dev_dbg(dev, "SBE state=%d\n", rc);
+	if (rc)
 		return rc;
-	}
 
-	/* If broken, we don't need to look at status, go straight to reset */
+	/* If broken, we don't need to look at status, just reset */
 	if (sbefifo->broken)
-		goto do_reset;
+		return sbefifo_request_reset(sbefifo);
 
 	rc = sbefifo_regr(sbefifo, SBEFIFO_UP | SBEFIFO_STS, &up_status);
 	if (rc) {
-		dev_err(dev, "Cleanup: Reading UP status failed, rc=%d\n", rc);
+		dev_err(&sbefifo->dev, "Cleanup: Reading UP status failed, rc=%d\n", rc);
 
 		/* Will try reset again on next attempt at using it */
 		sbefifo->broken = true;
@@ -405,7 +348,7 @@ static int sbefifo_cleanup_hw(struct sbefifo *sbefifo)
 
 	rc = sbefifo_regr(sbefifo, SBEFIFO_DOWN | SBEFIFO_STS, &down_status);
 	if (rc) {
-		dev_err(dev, "Cleanup: Reading DOWN status failed, rc=%d\n", rc);
+		dev_err(&sbefifo->dev, "Cleanup: Reading DOWN status failed, rc=%d\n", rc);
 
 		/* Will try reset again on next attempt at using it */
 		sbefifo->broken = true;
@@ -414,13 +357,14 @@ static int sbefifo_cleanup_hw(struct sbefifo *sbefifo)
 
 	/* The FIFO already contains a reset request from the SBE ? */
 	if (down_status & SBEFIFO_STS_RESET_REQ) {
-		dev_info(dev, "Cleanup: FIFO reset request set, resetting\n");
+		dev_info(&sbefifo->dev, "Cleanup: FIFO reset request set, resetting\n");
 		rc = sbefifo_regw(sbefifo, SBEFIFO_DOWN, SBEFIFO_PERFORM_RESET);
 		if (rc) {
 			sbefifo->broken = true;
-			dev_err(dev, "Cleanup: Reset reg write failed, rc=%d\n", rc);
+			dev_err(&sbefifo->dev, "Cleanup: Reset reg write failed, rc=%d\n", rc);
 			return rc;
 		}
+
 		sbefifo->broken = false;
 		return 0;
 	}
@@ -436,52 +380,47 @@ static int sbefifo_cleanup_hw(struct sbefifo *sbefifo)
 	if (!need_reset)
 		return 0;
 
-	dev_info(dev, "Cleanup: FIFO not clean (up=0x%08x down=0x%08x)\n",
-		 up_status, down_status);
-
- do_reset:
-
 	/* Mark broken, will be cleared if/when reset succeeds */
+	dev_info(&sbefifo->dev, "Cleanup: FIFO not clean (up=0x%08x down=0x%08x)\n", up_status,
+		 down_status);
 	return sbefifo_request_reset(sbefifo);
 }
 
-static int sbefifo_wait(struct sbefifo *sbefifo, bool up,
-			u32 *status, unsigned long timeout)
+static int sbefifo_wait(struct sbefifo *sbefifo, u32 *status, unsigned long timeout, bool up)
 {
-	struct device *dev = &sbefifo->fsi_dev->dev;
 	unsigned long end_time;
 	bool ready = false;
-	u32 addr, sts = 0;
+	u32 sts = 0;
+	u32 addr;
 	int rc;
 
-	dev_vdbg(dev, "Wait on %s fifo...\n", up ? "up" : "down");
-
 	addr = (up ? SBEFIFO_UP : SBEFIFO_DOWN) | SBEFIFO_STS;
-
 	end_time = jiffies + timeout;
 	while (!time_after(jiffies, end_time)) {
 		cond_resched();
 		rc = sbefifo_regr(sbefifo, addr, &sts);
 		if (rc < 0) {
-			dev_err(dev, "FSI error %d reading status register\n", rc);
+			dev_err(&sbefifo->dev, "Bus error %d reading status register\n", rc);
 			return rc;
 		}
+
 		if (!up && sbefifo_parity_err(sts)) {
-			dev_err(dev, "Parity error in DOWN FIFO\n");
+			dev_err(&sbefifo->dev, "Parity error in DOWN FIFO\n");
 			return -ENXIO;
 		}
+
 		ready = !(up ? sbefifo_full(sts) : sbefifo_empty(sts));
 		if (ready)
 			break;
 	}
+
 	if (!ready) {
 		sysfs_notify(&sbefifo->dev.kobj, NULL, dev_attr_timeout.attr.name);
 		sbefifo->timed_out = true;
-		dev_err(dev, "%s FIFO Timeout (%u ms)! status=%08x\n",
+		dev_err(&sbefifo->dev, "%s FIFO Timeout (%u ms)! status=%08x\n",
 			up ? "UP" : "DOWN", jiffies_to_msecs(timeout), sts);
 		return -ETIMEDOUT;
 	}
-	dev_vdbg(dev, "End of wait status: %08x\n", sts);
 
 	sbefifo->timed_out = false;
 	*status = sts;
@@ -489,48 +428,45 @@ static int sbefifo_wait(struct sbefifo *sbefifo, bool up,
 	return 0;
 }
 
-static int sbefifo_send_command(struct sbefifo *sbefifo,
-				const __be32 *command, size_t cmd_len)
+static int sbefifo_send_command(struct sbefifo *sbefifo, const __be32 *command, size_t cmd_len)
 {
-	struct device *dev = &sbefifo->fsi_dev->dev;
-	size_t len, chunk, vacant = 0, remaining = cmd_len;
+	size_t remaining = cmd_len;
 	unsigned long timeout;
+	size_t vacant = 0;
+	size_t chunk;
+	size_t len;
 	u32 status;
 	int rc;
 
-	dev_dbg(dev, "sending command (%zd words, cmd=%04x)\n",
-		cmd_len, be32_to_cpu(command[1]));
-
 	/* As long as there's something to send */
 	timeout = msecs_to_jiffies(SBEFIFO_TIMEOUT_START_CMD);
 	while (remaining) {
 		/* Wait for room in the FIFO */
-		rc = sbefifo_wait(sbefifo, true, &status, timeout);
+		rc = sbefifo_wait(sbefifo, &status, timeout, true);
 		if (rc < 0)
 			return rc;
-		timeout = msecs_to_jiffies(SBEFIFO_TIMEOUT_IN_CMD);
 
+		timeout = msecs_to_jiffies(SBEFIFO_TIMEOUT_IN_CMD);
 		vacant = sbefifo_vacant(status);
-		len = chunk = min(vacant, remaining);
-
-		dev_vdbg(dev, "  status=%08x vacant=%zd chunk=%zd\n",
-			 status, vacant, chunk);
+		len = min(vacant, remaining);
+		chunk = len;
 
 		/* Write as much as we can */
 		while (len--) {
 			rc = sbefifo_up_write(sbefifo, *(command++));
 			if (rc) {
-				dev_err(dev, "FSI error %d writing UP FIFO\n", rc);
+				dev_err(&sbefifo->dev, "Bus error %d writing UP FIFO\n", rc);
 				return rc;
 			}
 		}
+
 		remaining -= chunk;
 		vacant -= chunk;
 	}
 
 	/* If there's no room left, wait for some to write EOT */
 	if (!vacant) {
-		rc = sbefifo_wait(sbefifo, true, &status, timeout);
+		rc = sbefifo_wait(sbefifo, &status, timeout, true);
 		if (rc)
 			return rc;
 	}
@@ -538,40 +474,36 @@ static int sbefifo_send_command(struct sbefifo *sbefifo,
 	/* Send an EOT */
 	rc = sbefifo_regw(sbefifo, SBEFIFO_UP | SBEFIFO_EOT_RAISE, 0);
 	if (rc)
-		dev_err(dev, "FSI error %d writing EOT\n", rc);
+		dev_err(&sbefifo->dev, "Bus error %d writing EOT\n", rc);
+
 	return rc;
 }
 
 static int sbefifo_read_response(struct sbefifo *sbefifo, struct iov_iter *response)
 {
-	struct device *dev = &sbefifo->fsi_dev->dev;
-	u32 status, eot_set;
-	unsigned long timeout;
 	bool overflow = false;
+	unsigned long timeout;
 	__be32 data;
+	u32 eot_set;
+	u32 status;
 	size_t len;
 	int rc;
 
-	dev_dbg(dev, "reading response, buflen = %zd\n", iov_iter_count(response));
-
-	timeout = msecs_to_jiffies(sbefifo->timeout_start_rsp_ms);
+	timeout = msecs_to_jiffies(sbefifo->timeout);
 	for (;;) {
 		/* Grab FIFO status (this will handle parity errors) */
-		rc = sbefifo_wait(sbefifo, false, &status, timeout);
-		if (rc < 0) {
-			dev_dbg(dev, "timeout waiting (%u ms)\n", jiffies_to_msecs(timeout));
+		rc = sbefifo_wait(sbefifo, &status, timeout, false);
+		if (rc < 0)
 			return rc;
-		}
+
 		timeout = msecs_to_jiffies(SBEFIFO_TIMEOUT_IN_RSP);
 
 		/* Decode status */
 		len = sbefifo_populated(status);
 		eot_set = sbefifo_eot_set(status);
 
-		dev_dbg(dev, "  chunk size %zd eot_set=0x%x\n", len, eot_set);
-
 		/* Go through the chunk */
-		while(len--) {
+		while (len--) {
 			/* Read the data */
 			rc = sbefifo_down_read(sbefifo, &data);
 			if (rc < 0)
@@ -586,15 +518,13 @@ static int sbefifo_read_response(struct sbefifo *sbefifo, struct iov_iter *respo
 				 * command.
 				 */
 				if (len) {
-					dev_warn(dev, "FIFO read hit"
-						 " EOT with still %zd data\n",
-						 len);
+					dev_warn(&sbefifo->dev,
+						 "FIFO read hit EOT with still %zd data\n", len);
 					sbefifo->broken = true;
 				}
 
 				/* We are done */
-				rc = sbefifo_regw(sbefifo,
-						  SBEFIFO_DOWN | SBEFIFO_EOT_ACK, 0);
+				rc = sbefifo_regw(sbefifo, SBEFIFO_DOWN | SBEFIFO_EOT_ACK, 0);
 
 				/*
 				 * If that write fail, still complete the request but mark
@@ -602,7 +532,7 @@ static int sbefifo_read_response(struct sbefifo *sbefifo, struct iov_iter *respo
 				 * we can do here).
 				 */
 				if (rc) {
-					dev_err(dev, "FSI error %d ack'ing EOT\n", rc);
+					dev_err(&sbefifo->dev, "Bus error %d ack'ing EOT\n", rc);
 					sbefifo->broken = true;
 				}
 
@@ -615,7 +545,7 @@ static int sbefifo_read_response(struct sbefifo *sbefifo, struct iov_iter *respo
 				if (copy_to_iter(&data, sizeof(__be32), response) < sizeof(__be32))
 					return -EFAULT;
 			} else {
-				dev_vdbg(dev, "Response overflowed !\n");
+				dev_warn(&sbefifo->dev, "Response overflowed !\n");
 
 				overflow = true;
 			}
@@ -624,16 +554,18 @@ static int sbefifo_read_response(struct sbefifo *sbefifo, struct iov_iter *respo
 			eot_set <<= 1;
 		}
 	}
+
 	/* Shouldn't happen */
 	return -EIO;
 }
 
-static int sbefifo_do_command(struct sbefifo *sbefifo,
-			      const __be32 *command, size_t cmd_len,
+static int sbefifo_do_command(struct sbefifo *sbefifo, const __be32 *command, size_t cmd_len,
 			      struct iov_iter *response)
 {
+	int rc;
+
 	/* Try sending the command */
-	int rc = sbefifo_send_command(sbefifo, command, cmd_len);
+	rc = sbefifo_send_command(sbefifo, command, cmd_len);
 	if (rc)
 		return rc;
 
@@ -643,58 +575,56 @@ static int sbefifo_do_command(struct sbefifo *sbefifo,
 
 static void sbefifo_collect_async_ffdc(struct sbefifo *sbefifo)
 {
-	struct device *dev = &sbefifo->fsi_dev->dev;
-        struct iov_iter ffdc_iter;
-        struct kvec ffdc_iov;
-	__be32 *ffdc;
+	struct iov_iter ffdc_iter;
+	struct kvec ffdc_iov;
 	size_t ffdc_sz;
 	__be32 cmd[2];
+	__be32 *ffdc;
 	int rc;
 
 	sbefifo->async_ffdc = false;
 	ffdc = vmalloc(SBEFIFO_MAX_FFDC_SIZE);
 	if (!ffdc) {
-		dev_err(dev, "Failed to allocate SBE FFDC buffer\n");
+		dev_err(&sbefifo->dev, "Failed to allocate SBE FFDC buffer\n");
 		return;
 	}
-        ffdc_iov.iov_base = ffdc;
+
+	ffdc_iov.iov_base = ffdc;
 	ffdc_iov.iov_len = SBEFIFO_MAX_FFDC_SIZE;
-        iov_iter_kvec(&ffdc_iter, WRITE, &ffdc_iov, 1, SBEFIFO_MAX_FFDC_SIZE);
+	iov_iter_kvec(&ffdc_iter, WRITE, &ffdc_iov, 1, SBEFIFO_MAX_FFDC_SIZE);
 	cmd[0] = cpu_to_be32(2);
 	cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_SBE_FFDC);
 	rc = sbefifo_do_command(sbefifo, cmd, 2, &ffdc_iter);
 	if (rc != 0) {
-		dev_err(dev, "Error %d retrieving SBE FFDC\n", rc);
-		goto bail;
+		dev_err(&sbefifo->dev, "Error %d retrieving SBE FFDC\n", rc);
+		goto done;
 	}
 	ffdc_sz = SBEFIFO_MAX_FFDC_SIZE - iov_iter_count(&ffdc_iter);
 	ffdc_sz /= sizeof(__be32);
-	rc = sbefifo_parse_status(dev, SBEFIFO_CMD_GET_SBE_FFDC, ffdc,
-				  ffdc_sz, &ffdc_sz);
+	rc = sbefifo_parse_status(&sbefifo->dev, SBEFIFO_CMD_GET_SBE_FFDC, ffdc, ffdc_sz,
+				  &ffdc_sz);
 	if (rc != 0) {
-		dev_err(dev, "Error %d decoding SBE FFDC\n", rc);
-		goto bail;
+		dev_err(&sbefifo->dev, "Error %d decoding SBE FFDC\n", rc);
+		goto done;
 	}
+
 	if (ffdc_sz > 0)
-		sbefifo_dump_ffdc(dev, ffdc, ffdc_sz, true);
- bail:
+		sbefifo_dump_ffdc(&sbefifo->dev, ffdc, ffdc_sz, true);
+done:
 	vfree(ffdc);
-
 }
 
-static int __sbefifo_submit(struct sbefifo *sbefifo,
-			    const __be32 *command, size_t cmd_len,
+int sbefifo_submit_internal(struct sbefifo *sbefifo, const __be32 *command, size_t words,
 			    struct iov_iter *response)
 {
-	struct device *dev = &sbefifo->fsi_dev->dev;
 	int rc;
 
 	if (sbefifo->dead)
 		return -ENODEV;
 
-	if (cmd_len < 2 || be32_to_cpu(command[0]) != cmd_len) {
-		dev_vdbg(dev, "Invalid command len %zd (header: %d)\n",
-			 cmd_len, be32_to_cpu(command[0]));
+	if (words < 2 || be32_to_cpu(command[0]) != words) {
+		dev_warn(&sbefifo->dev, "Invalid command len %zd (header: %u)\n", words,
+			 be32_to_cpu(command[0]));
 		return -EINVAL;
 	}
 
@@ -707,18 +637,15 @@ static int __sbefifo_submit(struct sbefifo *sbefifo,
 	if (sbefifo->async_ffdc)
 		sbefifo_collect_async_ffdc(sbefifo);
 
-	rc = sbefifo_do_command(sbefifo, command, cmd_len, response);
-	if (rc != 0 && rc != -EOVERFLOW)
-		goto fail;
-	return rc;
- fail:
+	rc = sbefifo_do_command(sbefifo, command, words, response);
+
 	/*
 	 * On failure, attempt a reset. Ignore the result, it will mark
 	 * the fifo broken if the reset fails
 	 */
-        sbefifo_request_reset(sbefifo);
+	if (rc != 0 && rc != -EOVERFLOW)
+		sbefifo_request_reset(sbefifo);
 
-	/* Return original error */
 	return rc;
 }
 
@@ -730,39 +657,34 @@ static int __sbefifo_submit(struct sbefifo *sbefifo,
  * @response: The output response buffer
  * @resp_len: In: Response buffer size, Out: Response size
  *
- * This will perform the entire operation. If the reponse buffer
+ * This will perform the entire operation. If the response buffer
  * overflows, returns -EOVERFLOW
  */
 int sbefifo_submit(struct device *dev, const __be32 *command, size_t cmd_len,
 		   __be32 *response, size_t *resp_len)
 {
 	struct sbefifo *sbefifo;
-        struct iov_iter resp_iter;
-        struct kvec resp_iov;
+	struct iov_iter resp_iter;
+	struct kvec resp_iov;
 	size_t rbytes;
 	int rc;
 
-	if (!dev)
-		return -ENODEV;
-	sbefifo = dev_get_drvdata(dev);
-	if (!sbefifo)
-		return -ENODEV;
-	if (WARN_ON_ONCE(sbefifo->magic != SBEFIFO_MAGIC))
-		return -ENODEV;
 	if (!resp_len || !command || !response)
 		return -EINVAL;
 
+	sbefifo = container_of(dev, struct sbefifo, dev);
+
 	/* Prepare iov iterator */
 	rbytes = (*resp_len) * sizeof(__be32);
 	resp_iov.iov_base = response;
 	resp_iov.iov_len = rbytes;
-        iov_iter_kvec(&resp_iter, WRITE, &resp_iov, 1, rbytes);
+	iov_iter_kvec(&resp_iter, WRITE, &resp_iov, 1, rbytes);
 
 	/* Perform the command */
 	rc = mutex_lock_interruptible(&sbefifo->lock);
 	if (rc)
 		return rc;
-	rc = __sbefifo_submit(sbefifo, command, cmd_len, &resp_iter);
+	rc = sbefifo_submit_internal(sbefifo, command, cmd_len, &resp_iter);
 	mutex_unlock(&sbefifo->lock);
 
 	/* Extract the response length */
@@ -777,153 +699,99 @@ static void sbefifo_free(struct device *dev)
 {
 	struct sbefifo *sbefifo = container_of(dev, struct sbefifo, dev);
 
-	put_device(&sbefifo->fsi_dev->dev);
+	put_device(dev->parent);
 	kfree(sbefifo);
 }
 
-/*
- * Probe/remove
- */
-
-static int sbefifo_probe(struct device *dev)
+struct sbefifo *sbefifo_create(struct device *parent, struct regmap *regmap,
+			       int (*get_devt)(struct device *, int, dev_t *, int *))
 {
-	struct fsi_device *fsi_dev = to_fsi_dev(dev);
 	struct sbefifo *sbefifo;
-	struct device_node *np;
-	struct platform_device *child;
-	char child_name[32];
-	int rc, didx, child_idx = 0;
+	__be32 raw_word;
+	u32 chip_id;
+	int idx;
+	int rc;
 
-	dev_dbg(dev, "Found sbefifo device\n");
+	if (!get_device(parent))
+		return ERR_PTR(-ENODEV);
 
 	sbefifo = kzalloc(sizeof(*sbefifo), GFP_KERNEL);
-	if (!sbefifo)
-		return -ENOMEM;
+	if (!sbefifo) {
+		put_device(parent);
+		return ERR_PTR(-ENOMEM);
+	}
 
-	/* Grab a reference to the device (parent of our cdev), we'll drop it later */
-	if (!get_device(dev)) {
+	rc = get_devt(parent, (int)fsi_dev_sbefifo, &sbefifo->dev.devt, &idx);
+	if (rc) {
 		kfree(sbefifo);
-		return -ENODEV;
+		put_device(parent);
+		return ERR_PTR(rc);
 	}
 
-	sbefifo->magic = SBEFIFO_MAGIC;
-	sbefifo->fsi_dev = fsi_dev;
-	dev_set_drvdata(dev, sbefifo);
-	mutex_init(&sbefifo->lock);
-	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
-
-	/*
-	 * Try cleaning up the FIFO. If this fails, we still register the
-	 * driver and will try cleaning things up again on the next access.
-	 */
-	rc = sbefifo_cleanup_hw(sbefifo);
-	if (rc && rc != -ESHUTDOWN)
-		dev_err(dev, "Initial HW cleanup failed, will retry later\n");
-
-	/* Create chardev for userspace access */
 	sbefifo->dev.type = &fsi_cdev_type;
-	sbefifo->dev.parent = dev;
+	sbefifo->dev.parent = parent;
 	sbefifo->dev.release = sbefifo_free;
 	device_initialize(&sbefifo->dev);
+	dev_set_name(&sbefifo->dev, "sbefifo%d", idx);
+
+	sbefifo_cdev_init(sbefifo);
+
+	mutex_init(&sbefifo->lock);
 
-	/* Allocate a minor in the FSI space */
-	rc = fsi_get_new_minor(fsi_dev, fsi_dev_sbefifo, &sbefifo->dev.devt, &didx);
+	rc = regmap_read(regmap, CFAM_SCOM_CHIP_ID, (unsigned int *)&raw_word);
 	if (rc)
-		goto err;
+		return ERR_PTR(rc);
 
-	dev_set_name(&sbefifo->dev, "sbefifo%d", didx);
-	cdev_init(&sbefifo->cdev, &sbefifo_fops);
-	rc = cdev_device_add(&sbefifo->cdev, &sbefifo->dev);
-	if (rc) {
-		dev_err(dev, "Error %d creating char device %s\n",
-			rc, dev_name(&sbefifo->dev));
-		goto err_free_minor;
-	}
+	chip_id = be32_to_cpu(raw_word);
+	chip_id = (chip_id & CFAM_SCOM_CHIP_ID_CHIP_ID_MASK) >> CFAM_SCOM_CHIP_ID_CHIP_ID_SHIFT;
 
-	/* Create platform devs for dts child nodes (occ, etc) */
-	for_each_available_child_of_node(dev->of_node, np) {
-		snprintf(child_name, sizeof(child_name), "%s-dev%d",
-			 dev_name(&sbefifo->dev), child_idx++);
-		child = of_platform_device_create(np, child_name, dev);
-		if (!child)
-			dev_warn(dev, "failed to create child %s dev\n",
-				 child_name);
+	switch (chip_id) {
+	case CHIP_ID_P9A:
+	case CHIP_ID_P9B:
+	case CHIP_ID_P9plus:
+		sbefifo->occ = occ_create(sbefifo, get_devt, occ_p9);
+		break;
+	case CHIP_ID_P10:
+		sbefifo->occ = occ_create(sbefifo, get_devt, occ_p10);
+		break;
 	}
 
-	device_create_file(&sbefifo->dev, &dev_attr_timeout);
+	sbefifo->regmap = regmap;
+	sbefifo->timeout = SBEFIFO_TIMEOUT_START_RSP;
 
-	return 0;
- err_free_minor:
-	fsi_free_minor(sbefifo->dev.devt);
- err:
-	put_device(&sbefifo->dev);
-	return rc;
-}
+	if (device_create_file(&sbefifo->dev, &dev_attr_timeout))
+		sbefifo->no_timeout_sysfs = 1;
 
-static int sbefifo_unregister_child(struct device *dev, void *data)
-{
-	struct platform_device *child = to_platform_device(dev);
-
-	of_device_unregister(child);
-	if (dev->of_node)
-		of_node_clear_flag(dev->of_node, OF_POPULATED);
+	rc = sbefifo_cleanup_hw(sbefifo);
+	if (rc && rc != -ESHUTDOWN)
+		dev_err(&sbefifo->dev, "Initial HW cleanup failed, will retry later\n");
 
-	return 0;
+	return sbefifo;
 }
 
-static int sbefifo_remove(struct device *dev)
+void sbefifo_destroy(struct sbefifo *sbefifo, void(*free_devt)(dev_t))
 {
-	struct sbefifo *sbefifo = dev_get_drvdata(dev);
-
-	dev_dbg(dev, "Removing sbefifo device...\n");
-
-	device_remove_file(&sbefifo->dev, &dev_attr_timeout);
-
 	mutex_lock(&sbefifo->lock);
-	sbefifo->dead = true;
+	sbefifo->dead = 1;
 	mutex_unlock(&sbefifo->lock);
 
-	cdev_device_del(&sbefifo->cdev, &sbefifo->dev);
-	fsi_free_minor(sbefifo->dev.devt);
-	device_for_each_child(dev, NULL, sbefifo_unregister_child);
-	put_device(&sbefifo->dev);
+	if (free_devt)
+		free_devt(sbefifo->dev.devt);
 
-	return 0;
-}
+	if (!sbefifo->no_timeout_sysfs)
+		device_remove_file(&sbefifo->dev, &dev_attr_timeout);
 
-static const struct fsi_device_id sbefifo_ids[] = {
-	{
-		.engine_type = FSI_ENGID_SBE,
-		.version = FSI_VERSION_ANY,
-	},
-	{ 0 }
-};
+	regmap_exit(sbefifo->regmap);
 
-static struct fsi_driver sbefifo_drv = {
-	.id_table = sbefifo_ids,
-	.drv = {
-		.name = DEVICE_NAME,
-		.bus = &fsi_bus_type,
-		.probe = sbefifo_probe,
-		.remove = sbefifo_remove,
-	}
-};
+	if (sbefifo->occ)
+		occ_destroy(sbefifo->occ, free_devt);
 
-static int sbefifo_init(void)
-{
-	return fsi_driver_register(&sbefifo_drv);
-}
+	if (!sbefifo->no_cdev)
+		cdev_device_del(&sbefifo->sbe, &sbefifo->dev);
 
-static void sbefifo_exit(void)
-{
-	fsi_driver_unregister(&sbefifo_drv);
+	put_device(&sbefifo->dev);
 }
 
-module_init(sbefifo_init);
-module_exit(sbefifo_exit);
+MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
+MODULE_DESCRIPTION("POWER Self Boot Engine FIFO driver");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Brad Bishop <bradleyb@fuzziesquirrel.com>");
-MODULE_AUTHOR("Eddie James <eajames@linux.vnet.ibm.com>");
-MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
-MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
-MODULE_DESCRIPTION("Linux device interface to the POWER Self Boot Engine");
diff --git a/drivers/fsi/sbefifo.h b/drivers/fsi/sbefifo.h
new file mode 100644
index 000000000000..23f342d712bd
--- /dev/null
+++ b/drivers/fsi/sbefifo.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) IBM Corporation 2022 */
+
+#ifndef DRIVERS_SBEFIFO_H
+#define DRIVERS_SBEFIFO_H
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#define SBEFIFO_DEVICE_NAME		"sbefifo"
+#define SBEFIFO_MAX_USER_CMD_LEN	(0x100000 + PAGE_SIZE)
+#define SBEFIFO_RESET_MAGIC		0x52534554 /* "RSET" */
+#define SBEFIFO_TIMEOUT_START_RSP	10000
+
+struct fsi_device;
+struct i2c_client;
+struct iov_iter;
+struct occ;
+struct regmap;
+
+struct sbefifo {
+	struct device dev;
+	struct cdev sbe;
+	struct mutex lock;	// device lock
+	union {
+		struct fsi_device *fsi_dev;
+		struct i2c_client *i2c_client;
+	};
+	struct occ *occ;
+	struct regmap *regmap;
+	unsigned int timeout;
+	unsigned int async_ffdc : 1;
+	unsigned int broken : 1;
+	unsigned int dead : 1;
+	unsigned int no_cdev : 1;
+	unsigned int no_timeout_sysfs : 1;
+	unsigned int timed_out : 1;
+};
+
+void sbefifo_cdev_init(struct sbefifo *sbefifo);
+struct sbefifo *sbefifo_create(struct device *parent, struct regmap *regmap,
+			       int (*get_devt)(struct device *, int, dev_t *, int *));
+void sbefifo_destroy(struct sbefifo *sbefifo, void(*free_devt)(dev_t));
+int sbefifo_request_reset(struct sbefifo *sbefifo);
+int sbefifo_submit_internal(struct sbefifo *sbefifo, const __be32 *command, size_t words,
+			    struct iov_iter *response);
+
+#endif /* DRIVERS_SBEFIFO_H */
-- 
2.31.1

