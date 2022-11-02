Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBC4616F29
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKBUwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiKBUwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:52:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ED72ADC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:52:12 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2IpDKI008781;
        Wed, 2 Nov 2022 20:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dyqm/ghfzJ1G7WBgnL2YcCoksG62RZXEkyTRTKhz8Ec=;
 b=P3PyhGZK6IXYjDJ3/QI3fj7rCUCHss4zCMy4zdW45HzYemeuvXRCvidNXAe7HNvSRTeJ
 Zl3DsbbWtPubyoc2SOB0g74Eo0WY54CMBRedwc+Of79LI1sksEiP16owD+rnQ5nWHdPt
 ezEanaf19ntoXrxxhmUcegGilx6qPNrEePbjF6zF+Bb1SP0wQjU/qeT71xNW9Mgden8l
 BGUCLpeh1aIgPxCFE7kRrYiUQnezvi+nDR78iXEI7RPpxWskJKxCFn3gxuw+1Y6X9eMg
 BOsYFjv4c320tZjfsXhBcRqVGnZFyATWM1xidHo0Nn3XdxALLGjqNS+LPL4B9F1Mc0bM Ow== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkx6qufvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:51:58 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2KpisA025206;
        Wed, 2 Nov 2022 20:51:57 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 3kgutav8r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:51:57 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2KpxiL12649192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 20:51:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C2C558068;
        Wed,  2 Nov 2022 20:51:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 685BC58052;
        Wed,  2 Nov 2022 20:51:54 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.200.160])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 20:51:54 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, eajames@linux.ibm.com
Subject: [PATCH v2 4/5] drivers: fsi: separate char device code for occ and sbefifo
Date:   Wed,  2 Nov 2022 15:51:47 -0500
Message-Id: <20221102205148.1334459-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102205148.1334459-1-eajames@linux.ibm.com>
References: <20221102205148.1334459-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GDQiUym2S-04rtWkklnvn68C39ZD9BTE
X-Proofpoint-ORIG-GUID: GDQiUym2S-04rtWkklnvn68C39ZD9BTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/Makefile       |   4 +-
 drivers/fsi/occ-cdev.c     | 139 ++++++++++++++++++++++++
 drivers/fsi/occ.c          | 137 -----------------------
 drivers/fsi/sbefifo-cdev.c | 217 +++++++++++++++++++++++++++++++++++++
 drivers/fsi/sbefifo.c      | 215 ------------------------------------
 5 files changed, 358 insertions(+), 354 deletions(-)
 create mode 100644 drivers/fsi/occ-cdev.c
 create mode 100644 drivers/fsi/sbefifo-cdev.c

diff --git a/drivers/fsi/Makefile b/drivers/fsi/Makefile
index 850825556e9c..1a52fc6c5258 100644
--- a/drivers/fsi/Makefile
+++ b/drivers/fsi/Makefile
@@ -7,5 +7,5 @@ obj-$(CONFIG_FSI_MASTER_GPIO) += fsi-master-gpio.o
 obj-$(CONFIG_FSI_MASTER_AST_CF) += fsi-master-ast-cf.o
 obj-$(CONFIG_FSI_SCOM) += fsi-scom.o
 obj-$(CONFIG_FSI_I2CR) += i2cr.o
-obj-$(CONFIG_FSI_SBEFIFO) += sbefifo.o
-obj-$(CONFIG_FSI_OCC) += occ.o
+obj-$(CONFIG_FSI_SBEFIFO) += sbefifo.o sbefifo-cdev.o
+obj-$(CONFIG_FSI_OCC) += occ.o occ-cdev.o
diff --git a/drivers/fsi/occ-cdev.c b/drivers/fsi/occ-cdev.c
new file mode 100644
index 000000000000..b3be880b5fe8
--- /dev/null
+++ b/drivers/fsi/occ-cdev.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) IBM Corporation 2022 */
+
+static int occ_open(struct inode *inode, struct file *file)
+{
+	struct occ_client *client = kzalloc(sizeof(*client), GFP_KERNEL);
+	struct miscdevice *mdev = file->private_data;
+	struct occ *occ = to_occ(mdev);
+
+	if (!client)
+		return -ENOMEM;
+
+	client->buffer = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!client->buffer) {
+		kfree(client);
+		return -ENOMEM;
+	}
+
+	client->occ = occ;
+	mutex_init(&client->lock);
+	file->private_data = client;
+	get_device(occ->dev);
+
+	/* We allocate a 1-page buffer, make sure it all fits */
+	BUILD_BUG_ON((OCC_CMD_DATA_BYTES + 3) > PAGE_SIZE);
+	BUILD_BUG_ON((OCC_RESP_DATA_BYTES + 7) > PAGE_SIZE);
+
+	return 0;
+}
+
+static ssize_t occ_read(struct file *file, char __user *buf, size_t len,
+			loff_t *offset)
+{
+	struct occ_client *client = file->private_data;
+	ssize_t rc = 0;
+
+	if (!client)
+		return -ENODEV;
+
+	if (len > OCC_SRAM_BYTES)
+		return -EINVAL;
+
+	mutex_lock(&client->lock);
+
+	/* This should not be possible ... */
+	if (WARN_ON_ONCE(client->read_offset > client->data_size)) {
+		rc = -EIO;
+		goto done;
+	}
+
+	/* Grab how much data we have to read */
+	rc = min(len, client->data_size - client->read_offset);
+	if (copy_to_user(buf, client->buffer + client->read_offset, rc))
+		rc = -EFAULT;
+	else
+		client->read_offset += rc;
+
+ done:
+	mutex_unlock(&client->lock);
+
+	return rc;
+}
+
+static ssize_t occ_write(struct file *file, const char __user *buf,
+			 size_t len, loff_t *offset)
+{
+	struct occ_client *client = file->private_data;
+	size_t rlen, data_length;
+	ssize_t rc;
+	u8 *cmd;
+
+	if (!client)
+		return -ENODEV;
+
+	if (len > (OCC_CMD_DATA_BYTES + 3) || len < 3)
+		return -EINVAL;
+
+	mutex_lock(&client->lock);
+
+	/* Construct the command */
+	cmd = client->buffer;
+
+	/*
+	 * Copy the user command (assume user data follows the occ command
+	 * format)
+	 * byte 0: command type
+	 * bytes 1-2: data length (msb first)
+	 * bytes 3-n: data
+	 */
+	if (copy_from_user(&cmd[1], buf, len)) {
+		rc = -EFAULT;
+		goto done;
+	}
+
+	/* Extract data length */
+	data_length = (cmd[2] << 8) + cmd[3];
+	if (data_length > OCC_CMD_DATA_BYTES) {
+		rc = -EINVAL;
+		goto done;
+	}
+
+	/* Submit command; 4 bytes before the data and 2 bytes after */
+	rlen = PAGE_SIZE;
+	rc = fsi_occ_submit(client->occ->dev, cmd, data_length + 6, cmd,
+			    &rlen);
+	if (rc)
+		goto done;
+
+	/* Set read tracking data */
+	client->data_size = rlen;
+	client->read_offset = 0;
+
+	/* Done */
+	rc = len;
+
+ done:
+	mutex_unlock(&client->lock);
+
+	return rc;
+}
+
+static int occ_release(struct inode *inode, struct file *file)
+{
+	struct occ_client *client = file->private_data;
+
+	put_device(client->occ->dev);
+	free_page((unsigned long)client->buffer);
+	kfree(client);
+
+	return 0;
+}
+
+static const struct file_operations occ_fops = {
+	.owner = THIS_MODULE,
+	.open = occ_open,
+	.read = occ_read,
+	.write = occ_write,
+	.release = occ_release,
+};
\ No newline at end of file
diff --git a/drivers/fsi/occ.c b/drivers/fsi/occ.c
index abdd37d5507f..83429b0289e9 100644
--- a/drivers/fsi/occ.c
+++ b/drivers/fsi/occ.c
@@ -77,143 +77,6 @@ struct occ_client {
 
 static DEFINE_IDA(occ_ida);
 
-static int occ_open(struct inode *inode, struct file *file)
-{
-	struct occ_client *client = kzalloc(sizeof(*client), GFP_KERNEL);
-	struct miscdevice *mdev = file->private_data;
-	struct occ *occ = to_occ(mdev);
-
-	if (!client)
-		return -ENOMEM;
-
-	client->buffer = (u8 *)__get_free_page(GFP_KERNEL);
-	if (!client->buffer) {
-		kfree(client);
-		return -ENOMEM;
-	}
-
-	client->occ = occ;
-	mutex_init(&client->lock);
-	file->private_data = client;
-	get_device(occ->dev);
-
-	/* We allocate a 1-page buffer, make sure it all fits */
-	BUILD_BUG_ON((OCC_CMD_DATA_BYTES + 3) > PAGE_SIZE);
-	BUILD_BUG_ON((OCC_RESP_DATA_BYTES + 7) > PAGE_SIZE);
-
-	return 0;
-}
-
-static ssize_t occ_read(struct file *file, char __user *buf, size_t len,
-			loff_t *offset)
-{
-	struct occ_client *client = file->private_data;
-	ssize_t rc = 0;
-
-	if (!client)
-		return -ENODEV;
-
-	if (len > OCC_SRAM_BYTES)
-		return -EINVAL;
-
-	mutex_lock(&client->lock);
-
-	/* This should not be possible ... */
-	if (WARN_ON_ONCE(client->read_offset > client->data_size)) {
-		rc = -EIO;
-		goto done;
-	}
-
-	/* Grab how much data we have to read */
-	rc = min(len, client->data_size - client->read_offset);
-	if (copy_to_user(buf, client->buffer + client->read_offset, rc))
-		rc = -EFAULT;
-	else
-		client->read_offset += rc;
-
- done:
-	mutex_unlock(&client->lock);
-
-	return rc;
-}
-
-static ssize_t occ_write(struct file *file, const char __user *buf,
-			 size_t len, loff_t *offset)
-{
-	struct occ_client *client = file->private_data;
-	size_t rlen, data_length;
-	ssize_t rc;
-	u8 *cmd;
-
-	if (!client)
-		return -ENODEV;
-
-	if (len > (OCC_CMD_DATA_BYTES + 3) || len < 3)
-		return -EINVAL;
-
-	mutex_lock(&client->lock);
-
-	/* Construct the command */
-	cmd = client->buffer;
-
-	/*
-	 * Copy the user command (assume user data follows the occ command
-	 * format)
-	 * byte 0: command type
-	 * bytes 1-2: data length (msb first)
-	 * bytes 3-n: data
-	 */
-	if (copy_from_user(&cmd[1], buf, len)) {
-		rc = -EFAULT;
-		goto done;
-	}
-
-	/* Extract data length */
-	data_length = (cmd[2] << 8) + cmd[3];
-	if (data_length > OCC_CMD_DATA_BYTES) {
-		rc = -EINVAL;
-		goto done;
-	}
-
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
-	rc = len;
-
- done:
-	mutex_unlock(&client->lock);
-
-	return rc;
-}
-
-static int occ_release(struct inode *inode, struct file *file)
-{
-	struct occ_client *client = file->private_data;
-
-	put_device(client->occ->dev);
-	free_page((unsigned long)client->buffer);
-	kfree(client);
-
-	return 0;
-}
-
-static const struct file_operations occ_fops = {
-	.owner = THIS_MODULE,
-	.open = occ_open,
-	.read = occ_read,
-	.write = occ_write,
-	.release = occ_release,
-};
-
 static void occ_save_ffdc(struct occ *occ, __be32 *resp, size_t parsed_len,
 			  size_t resp_len)
 {
diff --git a/drivers/fsi/sbefifo-cdev.c b/drivers/fsi/sbefifo-cdev.c
new file mode 100644
index 000000000000..75765e8c307a
--- /dev/null
+++ b/drivers/fsi/sbefifo-cdev.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) IBM Corporation 2022 */
+
+/*
+ * Char device interface
+ */
+
+static void sbefifo_release_command(struct sbefifo_user *user)
+{
+	if (is_vmalloc_addr(user->pending_cmd))
+		vfree(user->pending_cmd);
+	user->pending_cmd = NULL;
+	user->pending_len = 0;
+}
+
+static int sbefifo_user_open(struct inode *inode, struct file *file)
+{
+	struct sbefifo *sbefifo = container_of(inode->i_cdev, struct sbefifo, cdev);
+	struct sbefifo_user *user;
+
+	user = kzalloc(sizeof(struct sbefifo_user), GFP_KERNEL);
+	if (!user)
+		return -ENOMEM;
+
+	file->private_data = user;
+	user->sbefifo = sbefifo;
+	user->cmd_page = (void *)__get_free_page(GFP_KERNEL);
+	if (!user->cmd_page) {
+		kfree(user);
+		return -ENOMEM;
+	}
+	mutex_init(&user->file_lock);
+	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
+
+	return 0;
+}
+
+static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
+				 size_t len, loff_t *offset)
+{
+	struct sbefifo_user *user = file->private_data;
+	struct sbefifo *sbefifo;
+	struct iov_iter resp_iter;
+        struct iovec resp_iov;
+	size_t cmd_len;
+	int rc;
+
+	if (!user)
+		return -EINVAL;
+	sbefifo = user->sbefifo;
+	if (len & 3)
+		return -EINVAL;
+
+	mutex_lock(&user->file_lock);
+
+	/* Cronus relies on -EAGAIN after a short read */
+	if (user->pending_len == 0) {
+		rc = -EAGAIN;
+		goto bail;
+	}
+	if (user->pending_len < 8) {
+		rc = -EINVAL;
+		goto bail;
+	}
+	cmd_len = user->pending_len >> 2;
+
+	/* Prepare iov iterator */
+	resp_iov.iov_base = buf;
+	resp_iov.iov_len = len;
+	iov_iter_init(&resp_iter, WRITE, &resp_iov, 1, len);
+
+	/* Perform the command */
+	rc = mutex_lock_interruptible(&sbefifo->lock);
+	if (rc)
+		goto bail;
+	sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
+	rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
+	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
+	mutex_unlock(&sbefifo->lock);
+	if (rc < 0)
+		goto bail;
+
+	/* Extract the response length */
+	rc = len - iov_iter_count(&resp_iter);
+ bail:
+	sbefifo_release_command(user);
+	mutex_unlock(&user->file_lock);
+	return rc;
+}
+
+static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
+				  size_t len, loff_t *offset)
+{
+	struct sbefifo_user *user = file->private_data;
+	struct sbefifo *sbefifo;
+	int rc = len;
+
+	if (!user)
+		return -EINVAL;
+	sbefifo = user->sbefifo;
+	if (len > SBEFIFO_MAX_USER_CMD_LEN)
+		return -EINVAL;
+	if (len & 3)
+		return -EINVAL;
+
+	mutex_lock(&user->file_lock);
+
+	/* Can we use the pre-allocate buffer ? If not, allocate */
+	if (len <= PAGE_SIZE)
+		user->pending_cmd = user->cmd_page;
+	else
+		user->pending_cmd = vmalloc(len);
+	if (!user->pending_cmd) {
+		rc = -ENOMEM;
+		goto bail;
+	}
+
+	/* Copy the command into the staging buffer */
+	if (copy_from_user(user->pending_cmd, buf, len)) {
+		rc = -EFAULT;
+		goto bail;
+	}
+
+	/* Check for the magic reset command */
+	if (len == 4 && be32_to_cpu(*(__be32 *)user->pending_cmd) ==
+	    SBEFIFO_RESET_MAGIC)  {
+
+		/* Clear out any pending command */
+		user->pending_len = 0;
+
+		/* Trigger reset request */
+		rc = mutex_lock_interruptible(&sbefifo->lock);
+		if (rc)
+			goto bail;
+		rc = sbefifo_request_reset(user->sbefifo);
+		mutex_unlock(&sbefifo->lock);
+		if (rc == 0)
+			rc = 4;
+		goto bail;
+	}
+
+	/* Update the staging buffer size */
+	user->pending_len = len;
+ bail:
+	if (!user->pending_len)
+		sbefifo_release_command(user);
+
+	mutex_unlock(&user->file_lock);
+
+	/* And that's it, we'll issue the command on a read */
+	return rc;
+}
+
+static int sbefifo_user_release(struct inode *inode, struct file *file)
+{
+	struct sbefifo_user *user = file->private_data;
+
+	if (!user)
+		return -EINVAL;
+
+	sbefifo_release_command(user);
+	free_page((unsigned long)user->cmd_page);
+	kfree(user);
+
+	return 0;
+}
+
+static int sbefifo_read_timeout(struct sbefifo_user *user, void __user *argp)
+{
+	struct device *dev = &user->sbefifo->dev;
+	u32 timeout;
+
+	if (get_user(timeout, (__u32 __user *)argp))
+		return -EFAULT;
+
+	if (timeout == 0) {
+		user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
+		dev_dbg(dev, "Timeout reset to %d\n", user->read_timeout_ms);
+		return 0;
+	}
+
+	if (timeout < 10 || timeout > 120)
+		return -EINVAL;
+
+	user->read_timeout_ms = timeout * 1000; /* user timeout is in sec */
+
+	dev_dbg(dev, "Timeout set to %d\n", user->read_timeout_ms);
+
+	return 0;
+}
+
+static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct sbefifo_user *user = file->private_data;
+	int rc = -ENOTTY;
+
+	if (!user)
+		return -EINVAL;
+
+	mutex_lock(&user->file_lock);
+	switch (cmd) {
+	case FSI_SBEFIFO_READ_TIMEOUT_SECONDS:
+		rc = sbefifo_read_timeout(user, (void __user *)arg);
+		break;
+	}
+	mutex_unlock(&user->file_lock);
+	return rc;
+}
+
+static const struct file_operations sbefifo_fops = {
+	.owner		= THIS_MODULE,
+	.open		= sbefifo_user_open,
+	.read		= sbefifo_user_read,
+	.write		= sbefifo_user_write,
+	.release	= sbefifo_user_release,
+	.unlocked_ioctl = sbefifo_user_ioctl,
+};
diff --git a/drivers/fsi/sbefifo.c b/drivers/fsi/sbefifo.c
index 5f93a53846aa..634405b7aaf4 100644
--- a/drivers/fsi/sbefifo.c
+++ b/drivers/fsi/sbefifo.c
@@ -773,221 +773,6 @@ int sbefifo_submit(struct device *dev, const __be32 *command, size_t cmd_len,
 }
 EXPORT_SYMBOL_GPL(sbefifo_submit);
 
-/*
- * Char device interface
- */
-
-static void sbefifo_release_command(struct sbefifo_user *user)
-{
-	if (is_vmalloc_addr(user->pending_cmd))
-		vfree(user->pending_cmd);
-	user->pending_cmd = NULL;
-	user->pending_len = 0;
-}
-
-static int sbefifo_user_open(struct inode *inode, struct file *file)
-{
-	struct sbefifo *sbefifo = container_of(inode->i_cdev, struct sbefifo, cdev);
-	struct sbefifo_user *user;
-
-	user = kzalloc(sizeof(struct sbefifo_user), GFP_KERNEL);
-	if (!user)
-		return -ENOMEM;
-
-	file->private_data = user;
-	user->sbefifo = sbefifo;
-	user->cmd_page = (void *)__get_free_page(GFP_KERNEL);
-	if (!user->cmd_page) {
-		kfree(user);
-		return -ENOMEM;
-	}
-	mutex_init(&user->file_lock);
-	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
-
-	return 0;
-}
-
-static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
-				 size_t len, loff_t *offset)
-{
-	struct sbefifo_user *user = file->private_data;
-	struct sbefifo *sbefifo;
-	struct iov_iter resp_iter;
-        struct iovec resp_iov;
-	size_t cmd_len;
-	int rc;
-
-	if (!user)
-		return -EINVAL;
-	sbefifo = user->sbefifo;
-	if (len & 3)
-		return -EINVAL;
-
-	mutex_lock(&user->file_lock);
-
-	/* Cronus relies on -EAGAIN after a short read */
-	if (user->pending_len == 0) {
-		rc = -EAGAIN;
-		goto bail;
-	}
-	if (user->pending_len < 8) {
-		rc = -EINVAL;
-		goto bail;
-	}
-	cmd_len = user->pending_len >> 2;
-
-	/* Prepare iov iterator */
-	resp_iov.iov_base = buf;
-	resp_iov.iov_len = len;
-	iov_iter_init(&resp_iter, WRITE, &resp_iov, 1, len);
-
-	/* Perform the command */
-	rc = mutex_lock_interruptible(&sbefifo->lock);
-	if (rc)
-		goto bail;
-	sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
-	rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
-	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
-	mutex_unlock(&sbefifo->lock);
-	if (rc < 0)
-		goto bail;
-
-	/* Extract the response length */
-	rc = len - iov_iter_count(&resp_iter);
- bail:
-	sbefifo_release_command(user);
-	mutex_unlock(&user->file_lock);
-	return rc;
-}
-
-static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
-				  size_t len, loff_t *offset)
-{
-	struct sbefifo_user *user = file->private_data;
-	struct sbefifo *sbefifo;
-	int rc = len;
-
-	if (!user)
-		return -EINVAL;
-	sbefifo = user->sbefifo;
-	if (len > SBEFIFO_MAX_USER_CMD_LEN)
-		return -EINVAL;
-	if (len & 3)
-		return -EINVAL;
-
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
-	}
-
-	/* Copy the command into the staging buffer */
-	if (copy_from_user(user->pending_cmd, buf, len)) {
-		rc = -EFAULT;
-		goto bail;
-	}
-
-	/* Check for the magic reset command */
-	if (len == 4 && be32_to_cpu(*(__be32 *)user->pending_cmd) ==
-	    SBEFIFO_RESET_MAGIC)  {
-
-		/* Clear out any pending command */
-		user->pending_len = 0;
-
-		/* Trigger reset request */
-		rc = mutex_lock_interruptible(&sbefifo->lock);
-		if (rc)
-			goto bail;
-		rc = sbefifo_request_reset(user->sbefifo);
-		mutex_unlock(&sbefifo->lock);
-		if (rc == 0)
-			rc = 4;
-		goto bail;
-	}
-
-	/* Update the staging buffer size */
-	user->pending_len = len;
- bail:
-	if (!user->pending_len)
-		sbefifo_release_command(user);
-
-	mutex_unlock(&user->file_lock);
-
-	/* And that's it, we'll issue the command on a read */
-	return rc;
-}
-
-static int sbefifo_user_release(struct inode *inode, struct file *file)
-{
-	struct sbefifo_user *user = file->private_data;
-
-	if (!user)
-		return -EINVAL;
-
-	sbefifo_release_command(user);
-	free_page((unsigned long)user->cmd_page);
-	kfree(user);
-
-	return 0;
-}
-
-static int sbefifo_read_timeout(struct sbefifo_user *user, void __user *argp)
-{
-	struct device *dev = &user->sbefifo->dev;
-	u32 timeout;
-
-	if (get_user(timeout, (__u32 __user *)argp))
-		return -EFAULT;
-
-	if (timeout == 0) {
-		user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
-		dev_dbg(dev, "Timeout reset to %d\n", user->read_timeout_ms);
-		return 0;
-	}
-
-	if (timeout < 10 || timeout > 120)
-		return -EINVAL;
-
-	user->read_timeout_ms = timeout * 1000; /* user timeout is in sec */
-
-	dev_dbg(dev, "Timeout set to %d\n", user->read_timeout_ms);
-
-	return 0;
-}
-
-static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct sbefifo_user *user = file->private_data;
-	int rc = -ENOTTY;
-
-	if (!user)
-		return -EINVAL;
-
-	mutex_lock(&user->file_lock);
-	switch (cmd) {
-	case FSI_SBEFIFO_READ_TIMEOUT_SECONDS:
-		rc = sbefifo_read_timeout(user, (void __user *)arg);
-		break;
-	}
-	mutex_unlock(&user->file_lock);
-	return rc;
-}
-
-static const struct file_operations sbefifo_fops = {
-	.owner		= THIS_MODULE,
-	.open		= sbefifo_user_open,
-	.read		= sbefifo_user_read,
-	.write		= sbefifo_user_write,
-	.release	= sbefifo_user_release,
-	.unlocked_ioctl = sbefifo_user_ioctl,
-};
-
 static void sbefifo_free(struct device *dev)
 {
 	struct sbefifo *sbefifo = container_of(dev, struct sbefifo, dev);
-- 
2.31.1

