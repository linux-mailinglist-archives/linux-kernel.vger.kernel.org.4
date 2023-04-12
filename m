Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76236DFB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDLQQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjDLQQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:16:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCCF728A;
        Wed, 12 Apr 2023 09:15:52 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CFHrIK029926;
        Wed, 12 Apr 2023 16:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oH0359u5WYHqyvFcKtEXKnjNbfudjFhzYbYaa8nsYDk=;
 b=cmAYOiRAAUeBOowPzPDzyjYVVU+cZHAnWOjxInyE3otSgE+qOowQBgc4z8o+h0iXbaOr
 VwDANSgH4OmbKzh2aV0gqH/AcZaNEWIGYW/NcNMiJN9d1i8SJl5lQ7s4YlQ4kdmWHrCN
 Y95YwxvZ7E676I2S5Q8Qnbi5KTjvOR4yUnXh/cs08PqiF8UlTp35br+KDwyL0zHdjGOZ
 dvJwLve4FPWCi6WvHaN+XEwq2Sbtry9SKRXZXZJIBWR3+8pGeIx0JY4pifhunpoJKGTI
 2QKeuZCyc1SObj/9PRO7xWLg89xRM0ocjKuWcrjoV6Rz6Ecw3SUib+3G7fjRCvrlfj1k UQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwy5ptpem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:15:36 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33CD2wBW022707;
        Wed, 12 Apr 2023 16:15:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3pu0f9y3f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:15:35 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33CGFYej14287388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 16:15:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AE535805D;
        Wed, 12 Apr 2023 16:15:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B8C158058;
        Wed, 12 Apr 2023 16:15:33 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.16.129])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Apr 2023 16:15:33 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 2/2] hwmon: (pmbus/ibm-cffps) Use default debugfs attributes and lock function
Date:   Wed, 12 Apr 2023 11:15:26 -0500
Message-Id: <20230412161526.252294-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230412161526.252294-1-eajames@linux.ibm.com>
References: <20230412161526.252294-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: okrznWKMb_1Z2Z-HtWjSmtPF04qojaRa
X-Proofpoint-ORIG-GUID: okrznWKMb_1Z2Z-HtWjSmtPF04qojaRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_07,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the driver to use the default debugfs attributes instead of
ones that provide the same data under different names. Use the lock
functions for the debugfs and led attributes, and simplify the input
history operation by dropping the timer and lock.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - No whitespace change

 drivers/hwmon/pmbus/ibm-cffps.c | 272 ++++++++++++++------------------
 1 file changed, 118 insertions(+), 154 deletions(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index e3294a1a54bb..76e72e9acda7 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -18,12 +18,6 @@
 
 #include "pmbus.h"
 
-#define CFFPS_MFG_ID_CMD                        0x99
-#define CFFPS_FRU_CMD				0x9A
-#define CFFPS_PN_CMD				0x9B
-#define CFFPS_HEADER_CMD			0x9C
-#define CFFPS_SN_CMD				0x9E
-#define CFFPS_MAX_POWER_OUT_CMD			0xA7
 #define CFFPS_CCIN_CMD				0xBD
 #define CFFPS_FW_CMD				0xFA
 #define CFFPS1_FW_NUM_BYTES			4
@@ -32,7 +26,7 @@
 #define CFFPS_12VCS_VOUT_CMD			0xDE
 
 #define CFFPS_INPUT_HISTORY_CMD			0xD6
-#define CFFPS_INPUT_HISTORY_SIZE		100
+#define CFFPS_INPUT_HISTORY_SIZE		101
 
 #define CFFPS_CCIN_REVISION			GENMASK(7, 0)
 #define CFFPS_CCIN_REVISION_LEGACY		 0xde
@@ -57,13 +51,7 @@
 #define CFFPS_BLINK_RATE_MS			250
 
 enum {
-	CFFPS_DEBUGFS_INPUT_HISTORY = 0,
-	CFFPS_DEBUGFS_MFG_ID,
-	CFFPS_DEBUGFS_FRU,
-	CFFPS_DEBUGFS_PN,
-	CFFPS_DEBUGFS_HEADER,
-	CFFPS_DEBUGFS_SN,
-	CFFPS_DEBUGFS_MAX_POWER_OUT,
+	CFFPS_DEBUGFS_MAX_POWER_OUT = 0,
 	CFFPS_DEBUGFS_CCIN,
 	CFFPS_DEBUGFS_FW,
 	CFFPS_DEBUGFS_ON_OFF_CONFIG,
@@ -72,19 +60,11 @@ enum {
 
 enum versions { cffps1, cffps2, cffps_unknown };
 
-struct ibm_cffps_input_history {
-	struct mutex update_lock;
-	unsigned long last_update;
-
-	u8 byte_count;
-	u8 data[CFFPS_INPUT_HISTORY_SIZE];
-};
-
 struct ibm_cffps {
 	enum versions version;
 	struct i2c_client *client;
 
-	struct ibm_cffps_input_history input_history;
+	u8 input_history[CFFPS_INPUT_HISTORY_SIZE];
 
 	int debugfs_entries[CFFPS_DEBUGFS_NUM_ENTRIES];
 
@@ -93,118 +73,98 @@ struct ibm_cffps {
 	struct led_classdev led;
 };
 
-static const struct i2c_device_id ibm_cffps_id[];
-
 #define to_psu(x, y) container_of((x), struct ibm_cffps, debugfs_entries[(y)])
 
-static ssize_t ibm_cffps_read_input_history(struct ibm_cffps *psu,
-					    char __user *buf, size_t count,
-					    loff_t *ppos)
+static ssize_t ibm_cffps_debugfs_read_input_history(struct file *file, char __user *buf,
+						    size_t count, loff_t *ppos)
 {
 	int rc;
-	u8 msgbuf0[1] = { CFFPS_INPUT_HISTORY_CMD };
-	u8 msgbuf1[CFFPS_INPUT_HISTORY_SIZE + 1] = { 0 };
+	u8 cmd = CFFPS_INPUT_HISTORY_CMD;
+	struct ibm_cffps *psu = file->private_data;
 	struct i2c_msg msg[2] = {
 		{
 			.addr = psu->client->addr,
 			.flags = psu->client->flags,
 			.len = 1,
-			.buf = msgbuf0,
+			.buf = &cmd,
 		}, {
 			.addr = psu->client->addr,
 			.flags = psu->client->flags | I2C_M_RD,
-			.len = CFFPS_INPUT_HISTORY_SIZE + 1,
-			.buf = msgbuf1,
+			.len = CFFPS_INPUT_HISTORY_SIZE,
+			.buf = psu->input_history,
 		},
 	};
 
 	if (!*ppos) {
-		mutex_lock(&psu->input_history.update_lock);
-		if (time_after(jiffies, psu->input_history.last_update + HZ)) {
-			/*
-			 * Use a raw i2c transfer, since we need more bytes
-			 * than Linux I2C supports through smbus xfr (only 32).
-			 */
-			rc = i2c_transfer(psu->client->adapter, msg, 2);
-			if (rc < 0) {
-				mutex_unlock(&psu->input_history.update_lock);
-				return rc;
-			}
+		rc = pmbus_lock_interruptible(psu->client);
+		if (rc)
+			return rc;
 
-			psu->input_history.byte_count = msgbuf1[0];
-			memcpy(psu->input_history.data, &msgbuf1[1],
-			       CFFPS_INPUT_HISTORY_SIZE);
-			psu->input_history.last_update = jiffies;
+		rc = pmbus_set_page(psu->client, 0, 0xff);
+		if (rc) {
+			pmbus_unlock(psu->client);
+			return rc;
 		}
 
-		mutex_unlock(&psu->input_history.update_lock);
+		/*
+		 * Use a raw i2c transfer, since we need more bytes
+		 * than Linux I2C supports through smbus xfr (only 32).
+		 */
+		rc = i2c_transfer(psu->client->adapter, msg, 2);
+		pmbus_unlock(psu->client);
+		if (rc < 0)
+			return rc;
 	}
 
 	return simple_read_from_buffer(buf, count, ppos,
-				       psu->input_history.data,
-				       psu->input_history.byte_count);
+				       psu->input_history + 1,
+				       psu->input_history[0]);
 }
 
+static const struct file_operations ibm_cffps_input_history_fops = {
+	.llseek = noop_llseek,
+	.read = ibm_cffps_debugfs_read_input_history,
+	.open = simple_open,
+};
+
 static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
 				      size_t count, loff_t *ppos)
 {
-	u8 cmd;
 	int i, rc;
 	int *idxp = file->private_data;
 	int idx = *idxp;
 	struct ibm_cffps *psu = to_psu(idxp, idx);
 	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
 
-	pmbus_set_page(psu->client, 0, 0xff);
+	rc = pmbus_lock_interruptible(psu->client);
+	if (rc)
+		return rc;
+
+	rc = pmbus_set_page(psu->client, 0, 0xff);
+	if (rc)
+		goto unlock;
 
 	switch (idx) {
-	case CFFPS_DEBUGFS_INPUT_HISTORY:
-		return ibm_cffps_read_input_history(psu, buf, count, ppos);
-	case CFFPS_DEBUGFS_MFG_ID:
-		cmd = CFFPS_MFG_ID_CMD;
-		break;
-	case CFFPS_DEBUGFS_FRU:
-		cmd = CFFPS_FRU_CMD;
-		break;
-	case CFFPS_DEBUGFS_PN:
-		cmd = CFFPS_PN_CMD;
-		break;
-	case CFFPS_DEBUGFS_HEADER:
-		cmd = CFFPS_HEADER_CMD;
-		break;
-	case CFFPS_DEBUGFS_SN:
-		cmd = CFFPS_SN_CMD;
-		break;
 	case CFFPS_DEBUGFS_MAX_POWER_OUT:
-		if (psu->version == cffps1) {
-			rc = i2c_smbus_read_word_swapped(psu->client,
-					CFFPS_MAX_POWER_OUT_CMD);
-		} else {
-			rc = i2c_smbus_read_word_data(psu->client,
-					CFFPS_MAX_POWER_OUT_CMD);
-		}
-
-		if (rc < 0)
-			return rc;
-
-		rc = snprintf(data, I2C_SMBUS_BLOCK_MAX, "%d", rc);
-		goto done;
+		if (psu->version == cffps1)
+			rc = i2c_smbus_read_word_swapped(psu->client, PMBUS_MFR_POUT_MAX);
+		else
+			rc = i2c_smbus_read_word_data(psu->client, PMBUS_MFR_POUT_MAX);
+		if (rc >= 0)
+			rc = snprintf(data, I2C_SMBUS_BLOCK_MAX, "%d", rc);
+		break;
 	case CFFPS_DEBUGFS_CCIN:
 		rc = i2c_smbus_read_word_swapped(psu->client, CFFPS_CCIN_CMD);
-		if (rc < 0)
-			return rc;
-
-		rc = snprintf(data, 5, "%04X", rc);
-		goto done;
+		if (rc >= 0)
+			rc = snprintf(data, 5, "%04X", rc);
+		break;
 	case CFFPS_DEBUGFS_FW:
 		switch (psu->version) {
 		case cffps1:
 			for (i = 0; i < CFFPS1_FW_NUM_BYTES; ++i) {
-				rc = i2c_smbus_read_byte_data(psu->client,
-							      CFFPS_FW_CMD +
-								i);
+				rc = i2c_smbus_read_byte_data(psu->client, CFFPS_FW_CMD + i);
 				if (rc < 0)
-					return rc;
+					goto unlock;
 
 				snprintf(&data[i * 2], 3, "%02X", rc);
 			}
@@ -213,11 +173,9 @@ static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
 			break;
 		case cffps2:
 			for (i = 0; i < CFFPS2_FW_NUM_WORDS; ++i) {
-				rc = i2c_smbus_read_word_data(psu->client,
-							      CFFPS_FW_CMD +
-								i);
+				rc = i2c_smbus_read_word_data(psu->client, CFFPS_FW_CMD + i);
 				if (rc < 0)
-					return rc;
+					goto unlock;
 
 				snprintf(&data[i * 4], 5, "%04X", rc);
 			}
@@ -225,26 +183,25 @@ static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
 			rc = i * 4;
 			break;
 		default:
-			return -EOPNOTSUPP;
+			rc = -EOPNOTSUPP;
+			break;
 		}
-		goto done;
+		break;
 	case CFFPS_DEBUGFS_ON_OFF_CONFIG:
-		rc = i2c_smbus_read_byte_data(psu->client,
-					      PMBUS_ON_OFF_CONFIG);
-		if (rc < 0)
-			return rc;
-
-		rc = snprintf(data, 3, "%02x", rc);
-		goto done;
+		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_ON_OFF_CONFIG);
+		if (rc >= 0)
+			rc = snprintf(data, 3, "%02x", rc);
+		break;
 	default:
-		return -EINVAL;
+		rc = -EINVAL;
+		break;
 	}
 
-	rc = i2c_smbus_read_block_data(psu->client, cmd, data);
+unlock:
+	pmbus_unlock(psu->client);
 	if (rc < 0)
 		return rc;
 
-done:
 	data[rc] = '\n';
 	rc += 2;
 
@@ -263,14 +220,22 @@ static ssize_t ibm_cffps_debugfs_write(struct file *file,
 
 	switch (idx) {
 	case CFFPS_DEBUGFS_ON_OFF_CONFIG:
-		pmbus_set_page(psu->client, 0, 0xff);
-
 		rc = simple_write_to_buffer(&data, 1, ppos, buf, count);
 		if (rc <= 0)
 			return rc;
 
-		rc = i2c_smbus_write_byte_data(psu->client,
-					       PMBUS_ON_OFF_CONFIG, data);
+		rc = pmbus_lock_interruptible(psu->client);
+		if (rc)
+			return rc;
+
+		rc = pmbus_set_page(psu->client, 0, 0xff);
+		if (rc) {
+			pmbus_unlock(psu->client);
+			return rc;
+		}
+
+		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_ON_OFF_CONFIG, data);
+		pmbus_unlock(psu->client);
 		if (rc)
 			return rc;
 
@@ -396,10 +361,19 @@ static int ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
 	dev_dbg(&psu->client->dev, "LED brightness set: %d. Command: %d.\n",
 		brightness, next_led_state);
 
-	pmbus_set_page(psu->client, 0, 0xff);
+	rc = pmbus_lock_interruptible(psu->client);
+	if (rc)
+		return rc;
+
+	rc = pmbus_set_page(psu->client, 0, 0xff);
+	if (rc) {
+		pmbus_unlock(psu->client);
+		return rc;
+	}
 
 	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
 				       next_led_state);
+	pmbus_unlock(psu->client);
 	if (rc < 0)
 		return rc;
 
@@ -418,10 +392,19 @@ static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
 
 	dev_dbg(&psu->client->dev, "LED blink set.\n");
 
-	pmbus_set_page(psu->client, 0, 0xff);
+	rc = pmbus_lock_interruptible(psu->client);
+	if (rc)
+		return rc;
+
+	rc = pmbus_set_page(psu->client, 0, 0xff);
+	if (rc) {
+		pmbus_unlock(psu->client);
+		return rc;
+	}
 
 	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
 				       CFFPS_LED_BLINK);
+	pmbus_unlock(psu->client);
 	if (rc < 0)
 		return rc;
 
@@ -474,9 +457,11 @@ static struct pmbus_driver_info ibm_cffps_info[] = {
 			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
 			PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
 			PMBUS_HAVE_STATUS_FAN12 | PMBUS_HAVE_VMON,
-		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
-			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
-			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_PIN | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
+			PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT |
+			PMBUS_HAVE_STATUS_TEMP,
 		.read_byte_data = ibm_cffps_read_byte_data,
 		.read_word_data = ibm_cffps_read_word_data,
 	},
@@ -486,12 +471,19 @@ static struct pmbus_platform_data ibm_cffps_pdata = {
 	.flags = PMBUS_SKIP_STATUS_CHECK | PMBUS_NO_CAPABILITY,
 };
 
+static const struct i2c_device_id ibm_cffps_id[] = {
+	{ "ibm_cffps1", cffps1 },
+	{ "ibm_cffps2", cffps2 },
+	{ "ibm_cffps", cffps_unknown },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ibm_cffps_id);
+
 static int ibm_cffps_probe(struct i2c_client *client)
 {
 	int i, rc;
 	enum versions vs = cffps_unknown;
 	struct dentry *debugfs;
-	struct dentry *ibm_cffps_dir;
 	struct ibm_cffps *psu;
 	const void *md = of_device_get_match_data(&client->dev);
 	const struct i2c_device_id *id;
@@ -560,8 +552,6 @@ static int ibm_cffps_probe(struct i2c_client *client)
 
 	psu->version = vs;
 	psu->client = client;
-	mutex_init(&psu->input_history.update_lock);
-	psu->input_history.last_update = jiffies - HZ;
 
 	ibm_cffps_create_led_class(psu);
 
@@ -570,55 +560,29 @@ static int ibm_cffps_probe(struct i2c_client *client)
 	if (!debugfs)
 		return 0;
 
-	ibm_cffps_dir = debugfs_create_dir(client->name, debugfs);
-	if (!ibm_cffps_dir)
-		return 0;
-
 	for (i = 0; i < CFFPS_DEBUGFS_NUM_ENTRIES; ++i)
 		psu->debugfs_entries[i] = i;
 
-	debugfs_create_file("input_history", 0444, ibm_cffps_dir,
-			    &psu->debugfs_entries[CFFPS_DEBUGFS_INPUT_HISTORY],
-			    &ibm_cffps_fops);
-	debugfs_create_file("mfg_id", 0444, ibm_cffps_dir,
-			    &psu->debugfs_entries[CFFPS_DEBUGFS_MFG_ID],
-			    &ibm_cffps_fops);
-	debugfs_create_file("fru", 0444, ibm_cffps_dir,
-			    &psu->debugfs_entries[CFFPS_DEBUGFS_FRU],
-			    &ibm_cffps_fops);
-	debugfs_create_file("part_number", 0444, ibm_cffps_dir,
-			    &psu->debugfs_entries[CFFPS_DEBUGFS_PN],
-			    &ibm_cffps_fops);
-	debugfs_create_file("header", 0444, ibm_cffps_dir,
-			    &psu->debugfs_entries[CFFPS_DEBUGFS_HEADER],
-			    &ibm_cffps_fops);
-	debugfs_create_file("serial_number", 0444, ibm_cffps_dir,
-			    &psu->debugfs_entries[CFFPS_DEBUGFS_SN],
-			    &ibm_cffps_fops);
-	debugfs_create_file("max_power_out", 0444, ibm_cffps_dir,
+	debugfs_create_file("input_history", 0444, debugfs, psu, &ibm_cffps_input_history_fops);
+	debugfs_create_file("max_power_out", 0444, debugfs,
 			    &psu->debugfs_entries[CFFPS_DEBUGFS_MAX_POWER_OUT],
 			    &ibm_cffps_fops);
-	debugfs_create_file("ccin", 0444, ibm_cffps_dir,
+	debugfs_create_file("ccin", 0444, debugfs,
 			    &psu->debugfs_entries[CFFPS_DEBUGFS_CCIN],
 			    &ibm_cffps_fops);
-	debugfs_create_file("fw_version", 0444, ibm_cffps_dir,
+	debugfs_create_file("fw_version", 0444, debugfs,
 			    &psu->debugfs_entries[CFFPS_DEBUGFS_FW],
 			    &ibm_cffps_fops);
-	debugfs_create_file("on_off_config", 0644, ibm_cffps_dir,
+	debugfs_create_file("on_off_config", 0644, debugfs,
 			    &psu->debugfs_entries[CFFPS_DEBUGFS_ON_OFF_CONFIG],
 			    &ibm_cffps_fops);
 
+	/* For compatibility with users of the old naming scheme. */
+	debugfs_create_symlink(client->name, debugfs, ".");
+
 	return 0;
 }
 
-static const struct i2c_device_id ibm_cffps_id[] = {
-	{ "ibm_cffps1", cffps1 },
-	{ "ibm_cffps2", cffps2 },
-	{ "ibm_cffps", cffps_unknown },
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, ibm_cffps_id);
-
 static const struct of_device_id ibm_cffps_of_match[] = {
 	{
 		.compatible = "ibm,cffps1",
-- 
2.31.1

