Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560976C2435
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCTWGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCTWGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:06:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196AC7EE8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:06:16 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KLCj8e012156;
        Mon, 20 Mar 2023 22:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=AV88f+76ahwOXTELtVaHbKx8Syz2qs3ENASHWyGOxMc=;
 b=gEHqOMhqLFy4irGTy2FU1yD4MqKAsn3+uD512vEookc22Tvj3vg7pN12NK1mirLDbvzi
 IJFeuvbNQlHnQURd5V6VvrYAPj5kzB6T6zlvE2nakWuwOW7ROUf6ES1BJekxXnbHfkQw
 t7rlpjLL+qfMpNiWqact06uLD81AsjZArYuZvLTO+qxd8yOFyIPu6RfoNhAeX3IHbHS5
 AmJ3bTDmMON9tO132O6WdtbcxaeOg5yY7vpfxvp7wrefJL5rhCQdHO2zIccxXkSh3bBg
 dtobuY9j+ghvzkS3f5SpUjYEgiOMjzoDQv5u76u5xU7svWTgD2J8VmkRMn0rmdimFNxs pw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pest030tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 22:06:09 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KJrSKQ022214;
        Mon, 20 Mar 2023 22:06:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x6y5se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 22:06:08 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KM67Lu24117836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 22:06:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81AA258058;
        Mon, 20 Mar 2023 22:06:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE46358057;
        Mon, 20 Mar 2023 22:06:06 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.23.218])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Mar 2023 22:06:06 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, jdelvare@suse.de,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] eeprom: ee1004: Enable devices on multiple busses
Date:   Mon, 20 Mar 2023 17:06:03 -0500
Message-Id: <20230320220603.442782-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PhwiY0B_-nwRB61Exccr_vrCcXnxLiBb
X-Proofpoint-ORIG-GUID: PhwiY0B_-nwRB61Exccr_vrCcXnxLiBb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200187
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/misc/eeprom/ee1004.c | 175 +++++++++++++++++++++--------------
 1 file changed, 106 insertions(+), 69 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index c8c6deb7ed89..950813821087 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -9,12 +9,15 @@
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
+#include <linux/of_device.h>
 
 /*
  * DDR4 memory modules use special EEPROMs following the Jedec EE1004
@@ -31,20 +34,24 @@
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
@@ -54,11 +61,11 @@ MODULE_DEVICE_TABLE(i2c, ee1004_ids);
 
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
@@ -72,33 +79,30 @@ static int ee1004_get_current_page(void)
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
@@ -106,9 +110,11 @@ static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
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
@@ -125,6 +131,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 			   char *buf, loff_t off, size_t count)
 {
 	struct i2c_client *client = kobj_to_i2c_client(kobj);
+	struct ee1004_bus *bus = i2c_get_clientdata(client);
 	size_t requested = count;
 	int ret = 0;
 
@@ -132,10 +139,10 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
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
 
@@ -144,7 +151,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 		count -= ret;
 	}
 out:
-	mutex_unlock(&ee1004_bus_lock);
+	mutex_unlock(&bus->lock);
 
 	return ret < 0 ? ret : requested;
 }
@@ -158,18 +165,56 @@ static struct bin_attribute *ee1004_attrs[] = {
 
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
@@ -178,53 +223,45 @@ static int ee1004_probe(struct i2c_client *client)
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

