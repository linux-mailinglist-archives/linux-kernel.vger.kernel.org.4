Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6004769E97B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjBUV1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBUV07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:26:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD872F7B4;
        Tue, 21 Feb 2023 13:26:54 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LLHN7G023259;
        Tue, 21 Feb 2023 21:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s4kIBTdwHgvnp0JR5GqHrVoFL9IUarVdZp5dipeTXo0=;
 b=DluUQDQWj2sgykOJqjN8JGeE5QqY6md6BHJyyXvwm/IMFOb79NtUVqm8M0O+HAsOSS+K
 ba5GvHZE1BcPtdcojbx17V5A7ufMq4k9yTUaBpyj3CqYA2IP0zztzqDS1FoIKgB/dfH6
 fTMJJPCYmFxURZawQPa4EdoSZqYYZ/JwDACdOzLAmcvHMME97u0N0rlY2TmpcvyJ2ug1
 3sFpfvwPdbZI2IFgS5p/qpNu1mEnEAFpxi/uPXnymbXtXxy3ti2SGblkkFYZTZ11slRd
 peHXUl8UdLSF/JVjSItm9jtA5dPRNWhoGJcUs3EuL8/i+hpJKQJRjBF5oEFUQrUII9Np 3g== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nw5he0f4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:26:39 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LIV1Qr000567;
        Tue, 21 Feb 2023 21:26:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ntpa79y63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:26:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LLQb5f58065286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 21:26:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3081D58059;
        Tue, 21 Feb 2023 21:26:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6374658058;
        Tue, 21 Feb 2023 21:26:35 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.223.120])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 21:26:35 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v5 6/6] fsi: Use of_match_table for bus matching if specified
Date:   Tue, 21 Feb 2023 15:26:22 -0600
Message-Id: <20230221212622.3897097-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230221212622.3897097-1-eajames@linux.ibm.com>
References: <20230221212622.3897097-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KdM53zcmLUr04hQaxmdWtxUPecESYjsk
X-Proofpoint-GUID: KdM53zcmLUr04hQaxmdWtxUPecESYjsk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210182
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

