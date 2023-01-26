Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4067D89F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjAZWjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAZWjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:39:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2672131
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:39:08 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QLZhRl009760;
        Thu, 26 Jan 2023 22:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=G/uaFy5jo3vL+SyVWvMvRTVRDzMfDTlP0hQUCbXqJHY=;
 b=k31POMZ8UVthRdLjJXnIeiQjPMVuns9EsFN2hTKTVzVH76iUgJrTiZu2rYvxg8P/Mtl9
 k1kqi9Th+N42aV7fB08TDojwwRFtIqDnkC9mibN2YhK5LmDZFg4LbCkpQ817O7/WrO2v
 ++6HiDQXEbnVlUC6dWSWqo15vxIZjhc8UTZSqY+8dfnzQY4J5hlXT72Ff1REaQa5/B25
 59Mfcuqjrsde2SeX2lSrM8u99jpxDPDkeFtMJIJHU1Vd45BHKF6S1nT8OAV+SKobwFOm
 rsrBvG0mlaOzI/7i+xDhyQrvpw29P2at2wsfNHySNzlwm7Tojg2T8cZ059kUHQ6l9B0E 5Q== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbyynb361-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 22:38:59 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QL83Kf006949;
        Thu, 26 Jan 2023 22:38:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3n87p7qerc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 22:38:58 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QMcubN29360630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 22:38:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91BEA58064;
        Thu, 26 Jan 2023 22:38:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9051B58060;
        Thu, 26 Jan 2023 22:38:55 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.3.213])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 22:38:55 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: Add aliased device numbering
Date:   Thu, 26 Jan 2023 16:38:50 -0600
Message-Id: <20230126223850.901302-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: URS7CnJw_KE2itk4gpb4m8TISkT8q2M6
X-Proofpoint-GUID: URS7CnJw_KE2itk4gpb4m8TISkT8q2M6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=998 clxscore=1015
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301260211
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C and SPI subsystems can use an aliased name to number the device.
Add similar support to the FSI subsystem for any device type.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c    | 31 +++++++++++++++++++++++++++++++
 drivers/fsi/fsi-sbefifo.c |  5 ++---
 drivers/fsi/fsi-scom.c    |  3 ++-
 include/linux/fsi.h       |  1 +
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 694e80c06665..c3c139c31341 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -971,9 +971,40 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
 	return 0;
 }
 
+static const char *const fsi_dev_type_names[] = {
+	"cfam",
+	"sbefifo",
+	"scom",
+	"occ",
+};
+
+const char *fsi_get_dev_type_name(enum fsi_dev_type type)
+{
+	return fsi_dev_type_names[type];
+}
+EXPORT_SYMBOL_GPL(fsi_get_dev_type_name);
+
 int fsi_get_new_minor(struct fsi_device *fdev, enum fsi_dev_type type,
 		      dev_t *out_dev, int *out_index)
 {
+	if (fdev->dev.of_node) {
+		int aid = of_alias_get_id(fdev->dev.of_node, fsi_dev_type_names[type]);
+
+		if (aid >= 0) {
+			int id = (aid << 4) | type;
+
+			id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
+			if (id >= 0) {
+				*out_index = aid;
+				*out_dev = fsi_base_dev + id;
+				return 0;
+			}
+
+			if (id != -ENOSPC)
+				return id;
+		}
+	}
+
 	return __fsi_get_new_minor(fdev->slave, type, out_dev, out_index);
 }
 EXPORT_SYMBOL_GPL(fsi_get_new_minor);
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 9912b7a6a4b9..c79396ba982e 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -39,7 +39,6 @@
  * the self boot engine on POWER processors.
  */
 
-#define DEVICE_NAME		"sbefifo"
 #define FSI_ENGID_SBE		0x22
 
 /*
@@ -1046,7 +1045,7 @@ static int sbefifo_probe(struct device *dev)
 	if (rc)
 		goto err;
 
-	dev_set_name(&sbefifo->dev, "sbefifo%d", didx);
+	dev_set_name(&sbefifo->dev, "%s%d", fsi_get_dev_type_name(fsi_dev_sbefifo), didx);
 	cdev_init(&sbefifo->cdev, &sbefifo_fops);
 	rc = cdev_device_add(&sbefifo->cdev, &sbefifo->dev);
 	if (rc) {
@@ -1117,7 +1116,7 @@ static const struct fsi_device_id sbefifo_ids[] = {
 static struct fsi_driver sbefifo_drv = {
 	.id_table = sbefifo_ids,
 	.drv = {
-		.name = DEVICE_NAME,
+		.name = "sbefifo",
 		.bus = &fsi_bus_type,
 		.probe = sbefifo_probe,
 		.remove = sbefifo_remove,
diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index bcb756dc9866..ee2c70906d06 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -556,7 +556,8 @@ static int scom_probe(struct device *dev)
 	if (rc)
 		goto err;
 
-	dev_set_name(&scom->dev, "scom%d", didx);
+	dev_set_name(&scom->dev, "%s%d", fsi_get_dev_type_name(fsi_dev_scom),
+		     didx);
 	cdev_init(&scom->cdev, &scom_fops);
 	rc = cdev_device_add(&scom->cdev, &scom->dev);
 	if (rc) {
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index 3df8c54868df..a6c6c57e146f 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -78,6 +78,7 @@ enum fsi_dev_type {
 	fsi_dev_occ
 };
 
+const char *fsi_get_dev_type_name(enum fsi_dev_type type);
 extern int fsi_get_new_minor(struct fsi_device *fdev, enum fsi_dev_type type,
 			     dev_t *out_dev, int *out_index);
 extern void fsi_free_minor(dev_t dev);
-- 
2.31.1

