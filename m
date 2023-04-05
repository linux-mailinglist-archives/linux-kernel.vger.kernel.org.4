Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912006D8017
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbjDEOw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbjDEOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:52:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822B1658A;
        Wed,  5 Apr 2023 07:52:50 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335DObjU005230;
        Wed, 5 Apr 2023 14:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1Kpd8suCSJvpllpL/T0XrbZxPVM/IOIfz+qTGO3kGdc=;
 b=XnrXTr+wLChDJFRQ8m9oX5iv1ttEKP+EUYOpfIsjg5TYC//kAfcBnPxTE5ckmXOllIOj
 vQ6cns8bgiNOG1/XWNFaPzEUXXjJiwQVt9eINlzKfErf4FuAcRfQt66+36LQ0iSRU/92
 P3kGYJ7PS8Q7VisSdJC+c8FLjrXomdELeWoWMgkT6wNC+mUOTSUP3aRPM9yew5YQ9MCF
 8CH658PcJio+LOP0h2B8m0jbHDYVTt0saa67u7fCxdduiwZGgGsHp2qKOF3joVEu36Ke
 1Ki1dcMyzmgO+StE3WhudXAqIxSfl6k2iWueQYUBpETtv14kzlj6MKe7mcfR7m4QbgUz cQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps9umjhq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:52:36 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 335DN7ex031588;
        Wed, 5 Apr 2023 14:52:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ppc88cg47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:52:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335EqY1S66781678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 14:52:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC9E95805E;
        Wed,  5 Apr 2023 14:52:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18E0458056;
        Wed,  5 Apr 2023 14:52:34 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.127.161])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 14:52:33 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/2] hwmon: (pmbus/core) Add lock and unlock functions
Date:   Wed,  5 Apr 2023 09:52:29 -0500
Message-Id: <20230405145230.68631-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230405145230.68631-1-eajames@linux.ibm.com>
References: <20230405145230.68631-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EfwuhR8T7a6SP21RIQbmzdllcdalXsOW
X-Proofpoint-GUID: EfwuhR8T7a6SP21RIQbmzdllcdalXsOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050132
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugfs operations may set the page number, which must be done
atomically with the subsequent i2c operation. Lock the update_lock
in the debugfs functions and provide a function for pmbus drivers
to lock and unlock the update_lock.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/pmbus.h      |  2 ++
 drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 11e84e141126..b0832a4c690d 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -505,6 +505,8 @@ int pmbus_get_fan_rate_device(struct i2c_client *client, int page, int id,
 			      enum pmbus_fan_mode mode);
 int pmbus_get_fan_rate_cached(struct i2c_client *client, int page, int id,
 			      enum pmbus_fan_mode mode);
+int pmbus_lock_interruptible(struct i2c_client *client);
+void pmbus_unlock(struct i2c_client *client);
 int pmbus_update_fan(struct i2c_client *client, int page, int id,
 		     u8 config, u8 mask, u16 command);
 struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index ca4510e4f918..04b4c65666fd 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3212,8 +3212,13 @@ static int pmbus_debugfs_get(void *data, u64 *val)
 {
 	int rc;
 	struct pmbus_debugfs_entry *entry = data;
+	struct pmbus_data *pdata = i2c_get_clientdata(entry->client);
 
+	rc = mutex_lock_interruptible(&pdata->update_lock);
+	if (rc)
+		return rc;
 	rc = _pmbus_read_byte_data(entry->client, entry->page, entry->reg);
+	mutex_unlock(&pdata->update_lock);
 	if (rc < 0)
 		return rc;
 
@@ -3230,7 +3235,11 @@ static int pmbus_debugfs_get_status(void *data, u64 *val)
 	struct pmbus_debugfs_entry *entry = data;
 	struct pmbus_data *pdata = i2c_get_clientdata(entry->client);
 
+	rc = mutex_lock_interruptible(&pdata->update_lock);
+	if (rc)
+		return rc;
 	rc = pdata->read_status(entry->client, entry->page);
+	mutex_unlock(&pdata->update_lock);
 	if (rc < 0)
 		return rc;
 
@@ -3246,10 +3255,15 @@ static ssize_t pmbus_debugfs_mfr_read(struct file *file, char __user *buf,
 {
 	int rc;
 	struct pmbus_debugfs_entry *entry = file->private_data;
+	struct pmbus_data *pdata = i2c_get_clientdata(entry->client);
 	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
 
+	rc = mutex_lock_interruptible(&pdata->update_lock);
+	if (rc)
+		return rc;
 	rc = pmbus_read_block_data(entry->client, entry->page, entry->reg,
 				   data);
+	mutex_unlock(&pdata->update_lock);
 	if (rc < 0)
 		return rc;
 
@@ -3587,6 +3601,22 @@ struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client)
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_get_debugfs_dir, PMBUS);
 
+int pmbus_lock_interruptible(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	return mutex_lock_interruptible(&data->update_lock);
+}
+EXPORT_SYMBOL_NS_GPL(pmbus_lock_interruptible, PMBUS);
+
+void pmbus_unlock(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	mutex_unlock(&data->update_lock);
+}
+EXPORT_SYMBOL_NS_GPL(pmbus_unlock, PMBUS);
+
 static int __init pmbus_core_init(void)
 {
 	pmbus_debugfs_dir = debugfs_create_dir("pmbus", NULL);
-- 
2.31.1

