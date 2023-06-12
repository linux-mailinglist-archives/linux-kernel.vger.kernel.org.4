Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4572CFF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbjFLT5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjFLT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:57:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F6910CC;
        Mon, 12 Jun 2023 12:57:17 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJl6gI006086;
        Mon, 12 Jun 2023 19:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zkjo7yw+XyzaXEbEFhbeLIcrenF/SgLQDubhtwnz964=;
 b=SrptcaKHy414ZL73/2ZgKpgMcioAd2mVLbUr87dtCg32+TD6eBropJpZx2EGt8MWhSvp
 NJoRbc220y9O5OX3zqjMZerwCLUIuvhyJUY9/hNocf3lPRnst7nYf+Xuks7+x3PIjBoG
 Z515vSXImwu0PDOi30G9egl1wTpJ4erptTMEtzgsFI3JQSqIaWkZdrD/rC9X3zymFcPy
 p+YCx71RDRVD6kxSIO0SDuQ/MzhUeskzeE9/wUQZUQGbXmk+O/5HWwxO9VNrsTPK5fGu
 uct2NG0+F2hYfd3av3tpFsEch8B0v7t88fP2PVpBfS/VYa5Pi9BWXIQsVvBzUdkzbz6n oQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r69tqg661-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:03 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJ0qZQ027199;
        Mon, 12 Jun 2023 19:57:02 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3r4gt5krr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:02 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CJv1b451577340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 19:57:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2A445805F;
        Mon, 12 Jun 2023 19:57:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D4E25805E;
        Mon, 12 Jun 2023 19:57:01 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.226])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 19:57:01 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 11/14] fsi: Improve master indexing
Date:   Mon, 12 Jun 2023 14:56:54 -0500
Message-Id: <20230612195657.245125-12-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612195657.245125-1-eajames@linux.ibm.com>
References: <20230612195657.245125-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bYjn5AaMjBJ187RLnVB6mJMQ7ex554vw
X-Proofpoint-GUID: bYjn5AaMjBJ187RLnVB6mJMQ7ex554vw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Master indexing is problematic if a hub is rescanned while the
root master is being rescanned. Move the IDA free below the device
unregistration, lock the scan mutex in the probe function, and
request a specific idx in the hub driver.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c       | 41 ++++++++++++++++++++++--------------
 drivers/fsi/fsi-master-hub.c |  2 ++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index ec4d02264391..503061a6740b 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1327,46 +1327,55 @@ static struct class fsi_master_class = {
 int fsi_master_register(struct fsi_master *master)
 {
 	int rc;
-	struct device_node *np;
 
 	mutex_init(&master->scan_lock);
-	master->idx = ida_alloc(&master_ida, GFP_KERNEL);
+
+	if (master->idx) {
+		master->idx = ida_alloc_range(&master_ida, master->idx,
+					      master->idx, GFP_KERNEL);
+		if (master->idx < 0)
+			master->idx = ida_alloc(&master_ida, GFP_KERNEL);
+	} else {
+		master->idx = ida_alloc(&master_ida, GFP_KERNEL);
+	}
+
 	if (master->idx < 0)
 		return master->idx;
 
-	dev_set_name(&master->dev, "fsi%d", master->idx);
+	if (!dev_name(&master->dev))
+		dev_set_name(&master->dev, "fsi%d", master->idx);
+
 	master->dev.class = &fsi_master_class;
 
+	mutex_lock(&master->scan_lock);
 	rc = device_register(&master->dev);
 	if (rc) {
 		ida_free(&master_ida, master->idx);
-		return rc;
-	}
+	} else {
+		struct device_node *np = dev_of_node(&master->dev);
 
-	np = dev_of_node(&master->dev);
-	if (!of_property_read_bool(np, "no-scan-on-init")) {
-		mutex_lock(&master->scan_lock);
-		fsi_master_scan(master);
-		mutex_unlock(&master->scan_lock);
+		if (!of_property_read_bool(np, "no-scan-on-init"))
+			fsi_master_scan(master);
 	}
 
-	return 0;
+	mutex_unlock(&master->scan_lock);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(fsi_master_register);
 
 void fsi_master_unregister(struct fsi_master *master)
 {
-	trace_fsi_master_unregister(master);
+	int idx = master->idx;
 
-	if (master->idx >= 0) {
-		ida_free(&master_ida, master->idx);
-		master->idx = -1;
-	}
+	trace_fsi_master_unregister(master);
 
 	mutex_lock(&master->scan_lock);
 	fsi_master_unscan(master);
+	master->n_links = 0;
 	mutex_unlock(&master->scan_lock);
+
 	device_unregister(&master->dev);
+	ida_free(&master_ida, idx);
 }
 EXPORT_SYMBOL_GPL(fsi_master_unregister);
 
diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 6d8b6e8854e5..36da643b3201 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 
 #include "fsi-master.h"
+#include "fsi-slave.h"
 
 #define FSI_ENGID_HUB_MASTER		0x1c
 
@@ -229,6 +230,7 @@ static int hub_master_probe(struct device *dev)
 	hub->master.dev.release = hub_master_release;
 	hub->master.dev.of_node = of_node_get(dev_of_node(dev));
 
+	hub->master.idx = fsi_dev->slave->link + 1;
 	hub->master.n_links = links;
 	hub->master.read = hub_master_read;
 	hub->master.write = hub_master_write;
-- 
2.31.1

