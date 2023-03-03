Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B410D6A9CAC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCCREp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCCREn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:04:43 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF121ABFE;
        Fri,  3 Mar 2023 09:04:42 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323GZrGV026815;
        Fri, 3 Mar 2023 17:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qyn+EWnxFstxyTndS+aBZAkYcNiZRJK1wB+Dw0C3Hw8=;
 b=ZaIoSIU3He/pgwvk8Jb7JJvHnSLJrUEagWRRdrbs/Uuc1Ezo2DTbixIU7L9D4rlMhhRW
 7klLJznt9zsRhfxMy7y+3YOWFZwHQLkWUlT/32XD5r6LwBOVjM5RkTU7nfC8voBaxh4B
 2i4g9Mk2TLBDCVa2bkmb5eyQNaUloTI1w8TxdrxvfQPF3OzTkrDVdM/2Y3alM17U/y/r
 BAms/wo1QwTmx1lPaClenHEvq1S0pQr4xGyYIWy5BIra+0FfszwaKcy8/cXdY8s7CU9e
 Zffurqa1Qm3WbBX2tciu/4izL2RHDUuUyCY8d+QYwDxjtPj/3kDS65rQbYe93SCAJf3q JQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p3mj9gq6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 17:04:23 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 323EFpCq019436;
        Fri, 3 Mar 2023 17:04:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3nybduuyb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 17:04:22 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 323H4Lhb7799496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Mar 2023 17:04:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 529DA58061;
        Fri,  3 Mar 2023 17:04:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 755E65805D;
        Fri,  3 Mar 2023 17:04:19 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.137.234])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Mar 2023 17:04:19 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v7 1/7] fsi: Move fsi_slave structure definition to header
Date:   Fri,  3 Mar 2023 11:04:10 -0600
Message-Id: <20230303170416.1347530-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230303170416.1347530-1-eajames@linux.ibm.com>
References: <20230303170416.1347530-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5iLq4dK5v2sVtrF7GtEm5hFO-RMO-kE8
X-Proofpoint-GUID: 5iLq4dK5v2sVtrF7GtEm5hFO-RMO-kE8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some FSI drivers may have need of the slave definition, so
move it to a header file. Also use one macro for obtaining a
pointer to the fsi_master structure.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c          | 24 ++++--------------------
 drivers/fsi/fsi-master-aspeed.c |  2 +-
 drivers/fsi/fsi-master-ast-cf.c |  2 +-
 drivers/fsi/fsi-master-gpio.c   |  2 +-
 drivers/fsi/fsi-master-hub.c    |  2 +-
 drivers/fsi/fsi-master.h        |  2 +-
 drivers/fsi/fsi-slave.h         | 28 ++++++++++++++++++++++++++++
 7 files changed, 37 insertions(+), 25 deletions(-)
 create mode 100644 drivers/fsi/fsi-slave.h

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 0b927c9f4267..d591e68afd11 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -23,6 +23,10 @@
 #include <linux/uaccess.h>
 
 #include "fsi-master.h"
+#include "fsi-slave.h"
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/fsi.h>
 
 #define FSI_SLAVE_CONF_NEXT_MASK	GENMASK(31, 31)
 #define FSI_SLAVE_CONF_SLOTS_MASK	GENMASK(23, 16)
@@ -78,26 +82,6 @@ static const int engine_page_size = 0x400;
 
 static DEFINE_IDA(master_ida);
 
-struct fsi_slave {
-	struct device		dev;
-	struct fsi_master	*master;
-	struct cdev		cdev;
-	int			cdev_idx;
-	int			id;	/* FSI address */
-	int			link;	/* FSI link# */
-	u32			cfam_id;
-	int			chip_id;
-	uint32_t		size;	/* size of slave address space */
-	u8			t_send_delay;
-	u8			t_echo_delay;
-};
-
-#define CREATE_TRACE_POINTS
-#include <trace/events/fsi.h>
-
-#define to_fsi_master(d) container_of(d, struct fsi_master, dev)
-#define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
-
 static const int slave_retries = 2;
 static int discard_errors;
 
diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 7cec1772820d..437f87b4a6a3 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -376,7 +376,7 @@ static int aspeed_master_break(struct fsi_master *master, int link)
 static void aspeed_master_release(struct device *dev)
 {
 	struct fsi_master_aspeed *aspeed =
-		to_fsi_master_aspeed(dev_to_fsi_master(dev));
+		to_fsi_master_aspeed(to_fsi_master(dev));
 
 	kfree(aspeed);
 }
diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 5f608ef8b53c..6124978305eb 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1190,7 +1190,7 @@ static int fsi_master_acf_gpio_release(void *data)
 
 static void fsi_master_acf_release(struct device *dev)
 {
-	struct fsi_master_acf *master = to_fsi_master_acf(dev_to_fsi_master(dev));
+	struct fsi_master_acf *master = to_fsi_master_acf(to_fsi_master(dev));
 
 	/* Cleanup, stop coprocessor */
 	mutex_lock(&master->lock);
diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 7d5f29b4b595..ed03da4f2447 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -761,7 +761,7 @@ static DEVICE_ATTR(external_mode, 0664,
 
 static void fsi_master_gpio_release(struct device *dev)
 {
-	struct fsi_master_gpio *master = to_fsi_master_gpio(dev_to_fsi_master(dev));
+	struct fsi_master_gpio *master = to_fsi_master_gpio(to_fsi_master(dev));
 
 	of_node_put(dev_of_node(master->dev));
 
diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 01f0a796111e..6d8b6e8854e5 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -105,7 +105,7 @@ static int hub_master_link_enable(struct fsi_master *master, int link,
 
 static void hub_master_release(struct device *dev)
 {
-	struct fsi_master_hub *hub = to_fsi_master_hub(dev_to_fsi_master(dev));
+	struct fsi_master_hub *hub = to_fsi_master_hub(to_fsi_master(dev));
 
 	kfree(hub);
 }
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index 4762315a46ba..967622c1cabf 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -136,7 +136,7 @@ struct fsi_master {
 				       u8 t_send_delay, u8 t_echo_delay);
 };
 
-#define dev_to_fsi_master(d) container_of(d, struct fsi_master, dev)
+#define to_fsi_master(d) container_of(d, struct fsi_master, dev)
 
 /**
  * fsi_master registration & lifetime: the fsi_master_register() and
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
new file mode 100644
index 000000000000..1d63a585829d
--- /dev/null
+++ b/drivers/fsi/fsi-slave.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) IBM Corporation 2023 */
+
+#ifndef DRIVERS_FSI_SLAVE_H
+#define DRIVERS_FSI_SLAVE_H
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+
+struct fsi_master;
+
+struct fsi_slave {
+	struct device		dev;
+	struct fsi_master	*master;
+	struct cdev		cdev;
+	int			cdev_idx;
+	int			id;	/* FSI address */
+	int			link;	/* FSI link# */
+	u32			cfam_id;
+	int			chip_id;
+	uint32_t		size;	/* size of slave address space */
+	u8			t_send_delay;
+	u8			t_echo_delay;
+};
+
+#define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
+
+#endif /* DRIVERS_FSI_SLAVE_H */
-- 
2.31.1

