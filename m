Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4981B7403C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjF0TFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjF0TFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:05:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD3D185;
        Tue, 27 Jun 2023 12:05:15 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RIxaTa031473;
        Tue, 27 Jun 2023 19:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=C3D/P4FPq9C11xGqw+J0fMya1etpgORpNTBZHmpQ5a0=;
 b=PGitqmLY/HXn5BLhQYJs51QT78xDtZP6o3Dnyte/7G9Ugd5eciKJ+3/VoHZgNF1QqVGr
 Yn2kNib6u56WbS+hJCJGWn6szXh/GOp8uiQ1OXDTATHHmzybJDJ6ArOhNeeGllikOrPS
 E3LjynpYYCdNBBI8x1qEHBZt27l6AdezA5ouoQmdbsovq3QQrAN1WqjHdRChtIHTA6Y+
 QpIkrd5lCLnul+TdcOpPyilQODVw1Ykh+4rr0cocdPY0Su7hYKDGZ9JBPNZjWWNFeytD
 1mSxwzTTGTDoPHWZzDWCUqL/HPWLEvfAUJA9xg9Me8vPadg8qt/4eVvdydavl1CFMdTk wQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rg5hag6et-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 19:05:01 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35RHkVFN013240;
        Tue, 27 Jun 2023 18:40:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3rdr45j2e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 18:40:32 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35RIeUNe66257280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 18:40:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9593658043;
        Tue, 27 Jun 2023 18:40:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 639B258055;
        Tue, 27 Jun 2023 18:40:30 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.104.152])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jun 2023 18:40:30 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, lakshmiy@us.ibm.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs attribute
Date:   Tue, 27 Jun 2023 13:40:27 -0500
Message-Id: <20230627184027.16343-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yCImGPd8-ZGvACJ7YC59vgajXeidnTVp
X-Proofpoint-GUID: yCImGPd8-ZGvACJ7YC59vgajXeidnTVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270173
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the IBM CFFPS driver, export the PSU's firmware version to a
debugfs attribute as reported in the manufacturer register.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/acbel-fsg032.c | 48 ++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/hwmon/pmbus/acbel-fsg032.c b/drivers/hwmon/pmbus/acbel-fsg032.c
index 0a0ef4ce3493..4b97f108cfe3 100644
--- a/drivers/hwmon/pmbus/acbel-fsg032.c
+++ b/drivers/hwmon/pmbus/acbel-fsg032.c
@@ -3,6 +3,7 @@
  * Copyright 2023 IBM Corp.
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
@@ -11,6 +12,52 @@
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
+	rc = pmbus_lock_interruptible(client);
+	if (rc)
+		return rc;
+
+	rc = i2c_smbus_read_block_data(client, ACBEL_MFR_FW_REVISION, data);
+	pmbus_unlock(client);
+	if (rc < 0)
+		return rc;
+
+	for (i = 0; i < rc && i < 3; ++i)
+		snprintf(&out[i * 2], 3, "%02X", data[i]);
+
+	rc = i * 2;
+	out[rc++] = '\n';
+	out[rc++] = 0;
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
@@ -59,6 +106,7 @@ static int acbel_fsg032_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	acbel_fsg032_init_debugfs(client);
 	return 0;
 }
 
-- 
2.39.3

