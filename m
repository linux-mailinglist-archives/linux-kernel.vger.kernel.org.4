Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E1772CFED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbjFLT5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjFLT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:57:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA810FA;
        Mon, 12 Jun 2023 12:57:17 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJkapc007067;
        Mon, 12 Jun 2023 19:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s4kIBTdwHgvnp0JR5GqHrVoFL9IUarVdZp5dipeTXo0=;
 b=QcxriQNEJFNJojJQXXTfITP272HFv9qme9SHdHw/uvTVdffDWctxRE4fARDoGd4ezsNP
 nPyInwI4109DkGJ7qOb4YJeXMI6qj7zQo3mUt9eTAbU3e/W5u5tUOex6vaGRGFRqG+xz
 bvMh85edSJ1IOaI4FQfI+MX+0l+ud4kSv7MyG97eB3sx4LT0Raji1ZBv95I2c+6j4mjq
 Of7+1iR2VliPecG2HbrwO6OMhQwdOla8llZnH4LM+aOVrp3zKgIyAHbrXGJkvsq4aYff
 nqqMj9oZC8jNlCcQrf81vc7TNtiuSA1P59YizJApvaWX5d//SKD22nzAll0BZ3L5mWGg 9Q== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r69tpg6hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:01 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJ6r5V027203;
        Mon, 12 Jun 2023 19:57:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3r4gt5krqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CJuxYp3080800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 19:56:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8B1658043;
        Mon, 12 Jun 2023 19:56:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A27A05805D;
        Mon, 12 Jun 2023 19:56:58 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.226])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 19:56:58 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 03/14] fsi: Use of_match_table for bus matching if specified
Date:   Mon, 12 Jun 2023 14:56:46 -0500
Message-Id: <20230612195657.245125-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612195657.245125-1-eajames@linux.ibm.com>
References: <20230612195657.245125-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ubf8GxZQJWqSeM0zJoUGdy9sBzTBDGPL
X-Proofpoint-ORIG-GUID: Ubf8GxZQJWqSeM0zJoUGdy9sBzTBDGPL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have two scom drivers, use the standard of matching if
the driver specifies a table so that the right devices go to the
right driver.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c | 11 +++++++++--
 drivers/fsi/fsi-scom.c |  8 ++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index b77013b9d8a7..ca4a9634fbc3 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -16,6 +16,7 @@
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/cdev.h>
@@ -1375,8 +1376,14 @@ static int fsi_bus_match(struct device *dev, struct device_driver *drv)
 		if (id->engine_type != fsi_dev->engine_type)
 			continue;
 		if (id->version == FSI_VERSION_ANY ||
-				id->version == fsi_dev->version)
-			return 1;
+		    id->version == fsi_dev->version) {
+			if (drv->of_match_table) {
+				if (of_driver_match_device(dev, drv))
+					return 1;
+			} else {
+				return 1;
+			}
+		}
 	}
 
 	return 0;
diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index bcb756dc9866..61dbda9dbe2b 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -10,6 +10,7 @@
 #include <linux/cdev.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/mod_devicetable.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/list.h>
@@ -587,6 +588,12 @@ static int scom_remove(struct device *dev)
 	return 0;
 }
 
+static const struct of_device_id scom_of_ids[] = {
+	{ .compatible = "ibm,fsi2pib" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, scom_of_ids);
+
 static const struct fsi_device_id scom_ids[] = {
 	{
 		.engine_type = FSI_ENGID_SCOM,
@@ -600,6 +607,7 @@ static struct fsi_driver scom_drv = {
 	.drv = {
 		.name = "scom",
 		.bus = &fsi_bus_type,
+		.of_match_table = scom_of_ids,
 		.probe = scom_probe,
 		.remove = scom_remove,
 	}
-- 
2.31.1

