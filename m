Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514536C4CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCVOEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjCVOEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:04:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CF22448C;
        Wed, 22 Mar 2023 07:04:12 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MDihSN014912;
        Wed, 22 Mar 2023 14:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=u10EnUSL6p0ItLDNOhx6Gr1HUTPaTt28SKZJBED3HJs=;
 b=CntaOVPHFcNmfQvy6jqnoB2rn1yjsPlQ0VIo8FAppMqXb9x0B9QhdazvxdyYXX5aeOS3
 uYaYPr6HhkylKJCnfgUw5T/YoqvsaR3tliGLjvV0YObVS5m3eW2fWcLJ8ndlZaL36sDS
 nJM7eJCzqqU3phQmZwVu6/TkT9IkSjTO9tFeXq0EDI26KTeUlEgtO7D9dFzdPHkV63lA
 wP3PI3HALwScSgqWoYGT3VGQonqOg4QpuplpDhjSxR5srLD23/R/yNQgL2T5wdRVx1RC
 H2LCD1JGJtUmDm6WZ1dNHmZgOeqn7wXxd0M9T3vvjBi0TIxk+1/vfcUAFZMPZNU2wODg fA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pg2ttghwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 14:03:56 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCBRfN029517;
        Wed, 22 Mar 2023 14:03:55 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3pd4x7ep2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 14:03:55 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ME3rqj12059208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 14:03:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9BD95805F;
        Wed, 22 Mar 2023 14:03:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 327CE5805C;
        Wed, 22 Mar 2023 14:03:52 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.129.242])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Mar 2023 14:03:52 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 1/4] eeprom: ee1004: Enable devices on multiple busses
Date:   Wed, 22 Mar 2023 09:03:45 -0500
Message-Id: <20230322140348.569397-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230322140348.569397-1-eajames@linux.ibm.com>
References: <20230322140348.569397-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lwzZVQoF0jZrNNdtQ5hcuv5TvtGC0mQm
X-Proofpoint-GUID: lwzZVQoF0jZrNNdtQ5hcuv5TvtGC0mQm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220103
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver previously prevented probing devices on more than one
bus due to locking constraints with the special page addresses. This
constraint can be removed by allocating a reference-counted bus
structure containing the lock, rather than using global variables.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v2:
 - Remove of_device.h include

 drivers/misc/eeprom/ee1004.c | 174 +++++++++++++++++++++--------------
 1 file changed, 105 insertions(+), 69 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index c8c6deb7ed89..0aed5760e370 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -9,9 +9,11 @@
  * Copyright (C) 2008 Wolfram Sang, Pengutronix
  */
 
+#include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -31,20 +33,24 @@
  * over performance.
  */
 
-#define EE1004_ADDR_SET_PAGE		0x36
+#define EE1004_ADDR_SET_PAGE0		0x36
+#define EE1004_ADDR_SET_PAGE1		0x37
 #define EE1004_NUM_PAGES		2
 #define EE1004_PAGE_SIZE		256
 #define EE1004_PAGE_SHIFT		8
 #define EE1004_EEPROM_SIZE		(EE1004_PAGE_SIZE * EE1004_NUM_PAGES)
 
-/*
- * Mutex protects ee1004_set_page and ee1004_dev_count, and must be held
- * from page selection to end of read.
- */
-static DEFINE_MUTEX(ee1004_bus_lock);
-static struct i2c_client *ee1004_set_page[EE1004_NUM_PAGES];
-static unsigned int ee1004_dev_count;
-static int ee1004_current_page;
+struct ee1004_bus {
+	struct kref kref;
+	struct list_head list;
+	struct mutex lock;
+	struct i2c_adapter *adapter;
+	struct i2c_client *set_page_clients[EE1004_NUM_PAGES];
+	int page;
+};
+
+static LIST_HEAD(ee1004_busses);
+static DEFINE_MUTEX(ee1004_busses_lock);
 
 static const struct i2c_device_id ee1004_ids[] = {
 	{ "ee1004", 0 },
@@ -54,11 +60,11 @@ MODULE_DEVICE_TABLE(i2c, ee1004_ids);
 
 /*-------------------------------------------------------------------------*/
 
-static int ee1004_get_current_page(void)
+static int ee1004_get_current_page(struct ee1004_bus *bus)
 {
 	int err;
 
-	err = i2c_smbus_read_byte(ee1004_set_page[0]);
+	err = i2c_smbus_read_byte(bus->set_page_clients[0]);
 	if (err == -ENXIO) {
 		/* Nack means page 1 is selected */
 		return 1;
@@ -72,33 +78,30 @@ static int ee1004_get_current_page(void)
 	return 0;
 }
 
-static int ee1004_set_current_page(struct device *dev, int page)
+static int ee1004_set_current_page(struct ee1004_bus *bus, int page)
 {
 	int ret;
 
-	if (page == ee1004_current_page)
+	if (page == bus->page)
 		return 0;
 
 	/* Data is ignored */
-	ret = i2c_smbus_write_byte(ee1004_set_page[page], 0x00);
+	ret = i2c_smbus_write_byte(bus->set_page_clients[page], 0x00);
+
 	/*
 	 * Don't give up just yet. Some memory modules will select the page
 	 * but not ack the command. Check which page is selected now.
 	 */
-	if (ret == -ENXIO && ee1004_get_current_page() == page)
+	if (ret == -ENXIO && ee1004_get_current_page(bus) == page)
 		ret = 0;
-	if (ret < 0) {
-		dev_err(dev, "Failed to select page %d (%d)\n", page, ret);
+	if (ret < 0)
 		return ret;
-	}
-
-	dev_dbg(dev, "Selected page %d\n", page);
-	ee1004_current_page = page;
 
+	bus->page = page;
 	return 0;
 }
 
-static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
+static ssize_t ee1004_eeprom_read(struct i2c_client *client, struct ee1004_bus *bus, char *buf,
 				  unsigned int offset, size_t count)
 {
 	int status, page;
@@ -106,9 +109,11 @@ static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
 	page = offset >> EE1004_PAGE_SHIFT;
 	offset &= (1 << EE1004_PAGE_SHIFT) - 1;
 
-	status = ee1004_set_current_page(&client->dev, page);
-	if (status)
+	status = ee1004_set_current_page(bus, page);
+	if (status) {
+		dev_err(&client->dev, "Failed to select page %d (%d)\n", page, status);
 		return status;
+	}
 
 	/* Can't cross page boundaries */
 	if (offset + count > EE1004_PAGE_SIZE)
@@ -125,6 +130,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 			   char *buf, loff_t off, size_t count)
 {
 	struct i2c_client *client = kobj_to_i2c_client(kobj);
+	struct ee1004_bus *bus = i2c_get_clientdata(client);
 	size_t requested = count;
 	int ret = 0;
 
@@ -132,10 +138,10 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 	 * Read data from chip, protecting against concurrent access to
 	 * other EE1004 SPD EEPROMs on the same adapter.
 	 */
-	mutex_lock(&ee1004_bus_lock);
+	mutex_lock(&bus->lock);
 
 	while (count) {
-		ret = ee1004_eeprom_read(client, buf, off, count);
+		ret = ee1004_eeprom_read(client, bus, buf, off, count);
 		if (ret < 0)
 			goto out;
 
@@ -144,7 +150,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 		count -= ret;
 	}
 out:
-	mutex_unlock(&ee1004_bus_lock);
+	mutex_unlock(&bus->lock);
 
 	return ret < 0 ? ret : requested;
 }
@@ -158,18 +164,56 @@ static struct bin_attribute *ee1004_attrs[] = {
 
 BIN_ATTRIBUTE_GROUPS(ee1004);
 
-static void ee1004_cleanup(int idx)
+static void ee1004_bus_unregister(struct ee1004_bus *bus)
 {
-	if (--ee1004_dev_count == 0)
-		while (--idx >= 0) {
-			i2c_unregister_device(ee1004_set_page[idx]);
-			ee1004_set_page[idx] = NULL;
-		}
+	i2c_unregister_device(bus->set_page_clients[1]);
+	i2c_unregister_device(bus->set_page_clients[0]);
+}
+
+static void ee1004_bus_release(struct kref *kref)
+{
+	struct ee1004_bus *bus = container_of(kref, struct ee1004_bus, kref);
+
+	ee1004_bus_unregister(bus);
+
+	mutex_lock(&ee1004_busses_lock);
+	list_del(&bus->list);
+	mutex_unlock(&ee1004_busses_lock);
+
+	kfree(bus);
+}
+
+static int ee1004_bus_initialize(struct ee1004_bus *bus, struct i2c_adapter *adapter)
+{
+	bus->set_page_clients[0] = i2c_new_dummy_device(adapter, EE1004_ADDR_SET_PAGE0);
+	if (IS_ERR(bus->set_page_clients[0]))
+		return PTR_ERR(bus->set_page_clients[0]);
+
+	bus->set_page_clients[1] = i2c_new_dummy_device(adapter, EE1004_ADDR_SET_PAGE1);
+	if (IS_ERR(bus->set_page_clients[1])) {
+		i2c_unregister_device(bus->set_page_clients[0]);
+		return PTR_ERR(bus->set_page_clients[1]);
+	}
+
+	bus->page = ee1004_get_current_page(bus);
+	if (bus->page < 0) {
+		ee1004_bus_unregister(bus);
+		return bus->page;
+	}
+
+	kref_init(&bus->kref);
+	list_add(&bus->list, &ee1004_busses);
+	mutex_init(&bus->lock);
+	bus->adapter = adapter;
+
+	return 0;
 }
 
 static int ee1004_probe(struct i2c_client *client)
 {
-	int err, cnr = 0;
+	struct ee1004_bus *bus;
+	bool found = false;
+	int rc = 0;
 
 	/* Make sure we can operate on this adapter */
 	if (!i2c_check_functionality(client->adapter,
@@ -178,53 +222,45 @@ static int ee1004_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_READ_BYTE_DATA))
 		return -EPFNOSUPPORT;
 
-	/* Use 2 dummy devices for page select command */
-	mutex_lock(&ee1004_bus_lock);
-	if (++ee1004_dev_count == 1) {
-		for (cnr = 0; cnr < EE1004_NUM_PAGES; cnr++) {
-			struct i2c_client *cl;
-
-			cl = i2c_new_dummy_device(client->adapter, EE1004_ADDR_SET_PAGE + cnr);
-			if (IS_ERR(cl)) {
-				err = PTR_ERR(cl);
-				goto err_clients;
-			}
-			ee1004_set_page[cnr] = cl;
+	mutex_lock(&ee1004_busses_lock);
+	list_for_each_entry(bus, &ee1004_busses, list) {
+		if (bus->adapter == client->adapter) {
+			kref_get(&bus->kref);
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		bus = kzalloc(sizeof(*bus), GFP_KERNEL);
+		if (!bus) {
+			rc = -ENOMEM;
+			goto unlock;
 		}
 
-		/* Remember current page to avoid unneeded page select */
-		err = ee1004_get_current_page();
-		if (err < 0)
-			goto err_clients;
-		dev_dbg(&client->dev, "Currently selected page: %d\n", err);
-		ee1004_current_page = err;
-	} else if (client->adapter != ee1004_set_page[0]->adapter) {
-		dev_err(&client->dev,
-			"Driver only supports devices on a single I2C bus\n");
-		err = -EOPNOTSUPP;
-		goto err_clients;
+		rc = ee1004_bus_initialize(bus, client->adapter);
+		if (rc) {
+			kfree(bus);
+			goto unlock;
+		}
 	}
-	mutex_unlock(&ee1004_bus_lock);
+
+	i2c_set_clientdata(client, bus);
 
 	dev_info(&client->dev,
 		 "%u byte EE1004-compliant SPD EEPROM, read-only\n",
 		 EE1004_EEPROM_SIZE);
 
-	return 0;
-
- err_clients:
-	ee1004_cleanup(cnr);
-	mutex_unlock(&ee1004_bus_lock);
-
-	return err;
+unlock:
+	mutex_unlock(&ee1004_busses_lock);
+	return rc;
 }
 
 static void ee1004_remove(struct i2c_client *client)
 {
-	/* Remove page select clients if this is the last device */
-	mutex_lock(&ee1004_bus_lock);
-	ee1004_cleanup(EE1004_NUM_PAGES);
-	mutex_unlock(&ee1004_bus_lock);
+	struct ee1004_bus *bus = i2c_get_clientdata(client);
+
+	kref_put(&bus->kref, ee1004_bus_release);
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.31.1

