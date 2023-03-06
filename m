Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222996AC820
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjCFQfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCFQey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:34:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614AB3B0DB;
        Mon,  6 Mar 2023 08:34:21 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326EeDRM017416;
        Mon, 6 Mar 2023 16:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=v2gEUB123stf3BBeQgDaxg0D1lDc/c2GglxXTZ+mQwI=;
 b=WcG9i5XeaicJ2oUBje495QrWZEzOQe4VsQZoK8bo94emQel9n3rpvpR+/VQXUWKbVpJd
 1tmxdDl6nWijbU6mMG6OUjMuLy7ojDfqbXhn5YKr4cfKosEkv9hShpvuldlPb51ev2qX
 czeQUsgzxM/W1gjh5CU2nK7ADsRRcKXPxNlTOJU+FlGq/vUA7qxE7Ej7FJeNJSo78nCz
 FiOfoR9jkDVCrL3167GGo93i2p2ZVtIDNj40tCI29/YM8ij33qRDGTFzAf98imRG5Ysh
 y4GuTFb9JbWSSt+xz5G3I9ZdONFgd1hAaraPMGpRmns9FaXJqn1sR5w62k8i9DLVWgFE Gg== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p50vmgexq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:16 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326G3qsA020396;
        Mon, 6 Mar 2023 16:11:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3p419k634c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:15 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326GBDvA59703552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 16:11:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0F5E5805B;
        Mon,  6 Mar 2023 16:11:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B99A5805C;
        Mon,  6 Mar 2023 16:11:12 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.108.29])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 16:11:11 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v8 7/8] fsi: Use of_match_table for bus matching if specified
Date:   Mon,  6 Mar 2023 10:10:55 -0600
Message-Id: <20230306161057.44017-8-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306161057.44017-1-eajames@linux.ibm.com>
References: <20230306161057.44017-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oDYfBsJ73dgTAAcu7QUJSxV-inL8RD__
X-Proofpoint-ORIG-GUID: oDYfBsJ73dgTAAcu7QUJSxV-inL8RD__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303060142
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
index 48f25dc0fad7..5191f6979346 100644
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
@@ -1380,8 +1381,14 @@ static int fsi_bus_match(struct device *dev, struct device_driver *drv)
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

