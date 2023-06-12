Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B322A72CFF4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbjFLT5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjFLT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:57:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8478810F5;
        Mon, 12 Jun 2023 12:57:17 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJg1x7011634;
        Mon, 12 Jun 2023 19:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cX6XRVZYcRIiEIAah+ZhS1yVvJ/XcMDdbd7xxssaCTg=;
 b=JRIo2bq5tp7VRwFZjdEq0G+hpHfXhvUuUxU1rirC8/bh6bMcF9dlDLBtfFSPrtyaCELj
 hMDzYk1tgyxFM6H0bmIj5ggUz42Vj/tc5dVMRTMBu82wF5+B9scwxQVFlYyq5XnZqdO9
 bRik7yk9KSB/aSALfMUKBT7h9rkpThhiiztDpBqPsLhXHWrZOr6q9l71mkKwol4NyiPH
 vcUp9OKZVbTN4EkgyEdFxc/QzHDzzux9HfxjZUZoFMUjqeABka7ar6+riYRc/ibqzD6U
 zQjZ7jYQdWUWdQXVN7/1rrc/QNdW1rlMp1xqfHa9er650XN4FaKH86Nugz/yc7O6rRhb eQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r69r8rc4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:02 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CBf2cO020557;
        Mon, 12 Jun 2023 19:57:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3r4gt4uu9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:01 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CJuxUq1311294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 19:57:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A34F258055;
        Mon, 12 Jun 2023 19:56:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56D985805D;
        Mon, 12 Jun 2023 19:56:59 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.226])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 19:56:59 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 05/14] fsi: sbefifo: Add configurable in-command timeout
Date:   Mon, 12 Jun 2023 14:56:48 -0500
Message-Id: <20230612195657.245125-6-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612195657.245125-1-eajames@linux.ibm.com>
References: <20230612195657.245125-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JI9EFeUV82SVUzsy_E6p2Ykp0uigrQiM
X-Proofpoint-ORIG-GUID: JI9EFeUV82SVUzsy_E6p2Ykp0uigrQiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@us.ibm.com>

A new use case for the SBEFIFO requires a long in-command timeout
as the SBE processes each part of the command before clearing the
upstream FIFO for the next part of the command.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-sbefifo.c | 30 +++++++++++++++++++++++++++++-
 include/uapi/linux/fsi.h  | 10 ++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 42d7c95528d1..5e6a9e08a92d 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -127,6 +127,7 @@ struct sbefifo {
 	bool			dead;
 	bool			async_ffdc;
 	bool			timed_out;
+	u32			timeout_in_cmd_ms;
 	u32			timeout_start_rsp_ms;
 };
 
@@ -136,6 +137,7 @@ struct sbefifo_user {
 	void			*cmd_page;
 	void			*pending_cmd;
 	size_t			pending_len;
+	u32			cmd_timeout_ms;
 	u32			read_timeout_ms;
 };
 
@@ -508,7 +510,7 @@ static int sbefifo_send_command(struct sbefifo *sbefifo,
 		rc = sbefifo_wait(sbefifo, true, &status, timeout);
 		if (rc < 0)
 			return rc;
-		timeout = msecs_to_jiffies(SBEFIFO_TIMEOUT_IN_CMD);
+		timeout = msecs_to_jiffies(sbefifo->timeout_in_cmd_ms);
 
 		vacant = sbefifo_vacant(status);
 		len = chunk = min(vacant, remaining);
@@ -802,6 +804,7 @@ static int sbefifo_user_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 	mutex_init(&user->file_lock);
+	user->cmd_timeout_ms = SBEFIFO_TIMEOUT_IN_CMD;
 	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
 
 	return 0;
@@ -845,9 +848,11 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
 	rc = mutex_lock_interruptible(&sbefifo->lock);
 	if (rc)
 		goto bail;
+	sbefifo->timeout_in_cmd_ms = user->cmd_timeout_ms;
 	sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
 	rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
 	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
+	sbefifo->timeout_in_cmd_ms = SBEFIFO_TIMEOUT_IN_CMD;
 	mutex_unlock(&sbefifo->lock);
 	if (rc < 0)
 		goto bail;
@@ -937,6 +942,25 @@ static int sbefifo_user_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int sbefifo_cmd_timeout(struct sbefifo_user *user, void __user *argp)
+{
+	struct device *dev = &user->sbefifo->dev;
+	u32 timeout;
+
+	if (get_user(timeout, (__u32 __user *)argp))
+		return -EFAULT;
+
+	if (timeout == 0) {
+		user->cmd_timeout_ms = SBEFIFO_TIMEOUT_IN_CMD;
+		dev_dbg(dev, "Command timeout reset to %us\n", user->cmd_timeout_ms / 1000);
+		return 0;
+	}
+
+	user->cmd_timeout_ms = timeout * 1000; /* user timeout is in sec */
+	dev_dbg(dev, "Command timeout set to %us\n", timeout);
+	return 0;
+}
+
 static int sbefifo_read_timeout(struct sbefifo_user *user, void __user *argp)
 {
 	struct device *dev = &user->sbefifo->dev;
@@ -971,6 +995,9 @@ static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, unsigned lon
 
 	mutex_lock(&user->file_lock);
 	switch (cmd) {
+	case FSI_SBEFIFO_CMD_TIMEOUT_SECONDS:
+		rc = sbefifo_cmd_timeout(user, (void __user *)arg);
+		break;
 	case FSI_SBEFIFO_READ_TIMEOUT_SECONDS:
 		rc = sbefifo_read_timeout(user, (void __user *)arg);
 		break;
@@ -1025,6 +1052,7 @@ static int sbefifo_probe(struct device *dev)
 	sbefifo->fsi_dev = fsi_dev;
 	dev_set_drvdata(dev, sbefifo);
 	mutex_init(&sbefifo->lock);
+	sbefifo->timeout_in_cmd_ms = SBEFIFO_TIMEOUT_IN_CMD;
 	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
 
 	/* Create chardev for userspace access */
diff --git a/include/uapi/linux/fsi.h b/include/uapi/linux/fsi.h
index b2f1977378c7..a2e730fc6309 100644
--- a/include/uapi/linux/fsi.h
+++ b/include/uapi/linux/fsi.h
@@ -59,6 +59,16 @@ struct scom_access {
  * /dev/sbefifo* ioctl interface
  */
 
+/**
+ * FSI_SBEFIFO_CMD_TIMEOUT sets the timeout for writing data to the SBEFIFO.
+ *
+ * The command timeout is specified in seconds.  The minimum value of command
+ * timeout is 1 seconds (default) and the maximum value of command timeout is
+ * 120 seconds.  A command timeout of 0 will reset the value to the default of
+ * 1 seconds.
+ */
+#define FSI_SBEFIFO_CMD_TIMEOUT_SECONDS		_IOW('s', 0x01, __u32)
+
 /**
  * FSI_SBEFIFO_READ_TIMEOUT sets the read timeout for response from SBE.
  *
-- 
2.31.1

