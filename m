Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C8F6A9CB7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjCCRFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjCCREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:04:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FBA222C5;
        Fri,  3 Mar 2023 09:04:47 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323Ful3Y010554;
        Fri, 3 Mar 2023 17:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s4kIBTdwHgvnp0JR5GqHrVoFL9IUarVdZp5dipeTXo0=;
 b=O5isZR0+VDt5iZ16rFmARm6LZbB76qIIDlQhZElwFGgRtdW0x6KRMEozg16dM7wklT1y
 AgUFaK7hZslmQacuOgzaOnE3yl2tHVFFcnCOT0hM4t7vQdLqeyAx2xxv/Vyj1/nrExi7
 6iA9DBNa1EASQHvyVzBkzYbO5/q+vMm/JxmN/37DEISfaHxhMChB4uduAaPzQXfnflZi
 jnGfsOKjiBjairj3DtI2adOrTuzdnwzCVAZsWYnmtY2XKkNyjQTk3qf7Kxrf+DQBquEH
 1tbXb8ouwm07RevWE4xi8lYSN28xEFfCy++UbMorOI/Uer7fw/z80zEKJpDoIW5Hx5Bf XQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p3kyvt0eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 17:04:34 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 323H1lXh030157;
        Fri, 3 Mar 2023 17:04:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3nybcn4y3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 17:04:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 323H4Vn79700086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Mar 2023 17:04:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A38AB58059;
        Fri,  3 Mar 2023 17:04:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA5A58043;
        Fri,  3 Mar 2023 17:04:29 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.137.234])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Mar 2023 17:04:29 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v7 6/7] fsi: Use of_match_table for bus matching if specified
Date:   Fri,  3 Mar 2023 11:04:15 -0600
Message-Id: <20230303170416.1347530-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230303170416.1347530-1-eajames@linux.ibm.com>
References: <20230303170416.1347530-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XRJyIDwennyJIW0CmijR6IQPekWkHjrf
X-Proofpoint-ORIG-GUID: XRJyIDwennyJIW0CmijR6IQPekWkHjrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030148
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

