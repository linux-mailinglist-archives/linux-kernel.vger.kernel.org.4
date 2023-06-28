Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A9741552
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjF1Pgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:36:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232536AbjF1PfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:35:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SFYlxS011856;
        Wed, 28 Jun 2023 15:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yjSSLk7IIZbwKBc+RFq027CdKB7HA5IOuDChCv+hIhs=;
 b=ljPs2feU/vhJXsPNgbGmNkrTbcMofD14IP5jzUjlI+AtUgj9zMbRiC9o861S13hAPdX/
 BONL6mKUSXbCe584x1JKlGAxdaw0nyIZ4De6IPePQqAwvs9Zb31dGOYIv4tsfcsM5q0H
 jaKaI/y1n9x1s6r87Jp1qU9mJKJ4LfDcaz8pkyJVFXtWiiwdf0FrZJv7JcB9k/Uxf61O
 tyC1niAs8E+cKBZ23Z7T9D1BCFTuO0HpLLnb9rO0MpZ1VWOpXiuRo3W0wUEbI6he8eK5
 skVMK5KFfEfbe6Np98dx34RaVvGLnenkLhCc3PraTt61AZ8CWvJbEP5LxC6focRE8K5f NA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgqhhg5e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 15:35:03 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35SEHLcH023981;
        Wed, 28 Jun 2023 15:34:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3rdr466ke4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 15:34:56 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SFYtG31442434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 15:34:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DE275805C;
        Wed, 28 Jun 2023 15:34:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C137A5805D;
        Wed, 28 Jun 2023 15:34:54 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.85.197])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 15:34:54 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, lakshmiy@us.ibm.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2] hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs attribute
Date:   Wed, 28 Jun 2023 10:34:53 -0500
Message-Id: <20230628153453.122213-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xs-fYOUbxI1zmkiDR1VJpmPzRWpxJViA
X-Proofpoint-ORIG-GUID: Xs-fYOUbxI1zmkiDR1VJpmPzRWpxJViA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the IBM CFFPS driver, export the PSU's firmware version to a
debugfs attribute as reported in the manufacturer register.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Remove locking since there's only one page
 - Switch to %*ph in snprintf instead of loop of %02x

 drivers/hwmon/pmbus/acbel-fsg032.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/hwmon/pmbus/acbel-fsg032.c b/drivers/hwmon/pmbus/acbel-fsg032.c
index 0a0ef4ce3493..6413f5ae605f 100644
--- a/drivers/hwmon/pmbus/acbel-fsg032.c
+++ b/drivers/hwmon/pmbus/acbel-fsg032.c
@@ -3,14 +3,52 @@
  * Copyright 2023 IBM Corp.
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/pmbus.h>
 #include <linux/hwmon-sysfs.h>
 #include "pmbus.h"
 
+#define ACBEL_MFR_FW_REVISION	0xd9
+
+static ssize_t acbel_fsg032_debugfs_read(struct file *file, char __user *buf, size_t count,
+					 loff_t *ppos)
+{
+	struct i2c_client *client = file->private_data;
+	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
+	char out[8];
+	int rc;
+	int i;
+
+	rc = i2c_smbus_read_block_data(client, ACBEL_MFR_FW_REVISION, data);
+	if (rc < 0)
+		return rc;
+
+	rc = snprintf(out, sizeof(out), "%*phN\n", min(rc, 3), data);
+	return simple_read_from_buffer(buf, count, ppos, out, rc);
+}
+
+static const struct file_operations acbel_debugfs_ops = {
+	.llseek = noop_llseek,
+	.read = acbel_fsg032_debugfs_read,
+	.write = NULL,
+	.open = simple_open,
+};
+
+static void acbel_fsg032_init_debugfs(struct i2c_client *client)
+{
+	struct dentry *debugfs = pmbus_get_debugfs_dir(client);
+
+	if (!debugfs)
+		return;
+
+	debugfs_create_file("fw_version", 0444, debugfs, client, &acbel_debugfs_ops);
+}
+
 static const struct i2c_device_id acbel_fsg032_id[] = {
 	{ "acbel_fsg032" },
 	{}
@@ -59,6 +97,7 @@ static int acbel_fsg032_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	acbel_fsg032_init_debugfs(client);
 	return 0;
 }
 
-- 
2.39.3

