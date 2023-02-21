Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F77D69E973
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjBUV0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBUV0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:26:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD28F2E82D;
        Tue, 21 Feb 2023 13:26:47 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LLHOIS023384;
        Tue, 21 Feb 2023 21:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qyn+EWnxFstxyTndS+aBZAkYcNiZRJK1wB+Dw0C3Hw8=;
 b=U5nDySRsuRNC1pN32z9Rnv7yFXz+gxsWc5PqGFEaHGlnGQW1911IhihVaXblAxsoPQ+4
 GoCAPwTMo4sYDJUbuWIW8kpI1gNlVVHq9PD97BdQhJ//8MKIVYKQv3RmmHGhgWwfcS22
 Is76opS1dCChaEjTYBIOy0mgVdd+6qfFgzrZ1CkLBTaqA2DCWS2KESz1kozDTHWYFc8N
 OxeHZYVDcs1J65hmVxlLtRHfGg5de5eSUvn8q05kWue40SV0SgQ7VFyEF5RTHJ8Nh0dN
 hwm3kTZG8Aw+Z6ybqVleHBHVpuICw+l+BNnn2TGxTM1yxNm11h00r9bobhf9VF7kFrvQ pw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nw5he0f21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:26:28 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LLDV6f015920;
        Tue, 21 Feb 2023 21:26:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa6vuy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:26:28 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LLQRGU41288080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 21:26:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA3CC58058;
        Tue, 21 Feb 2023 21:26:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24CAC58059;
        Tue, 21 Feb 2023 21:26:25 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.223.120])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 21:26:24 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v5 1/6] fsi: Move fsi_slave structure definition to header
Date:   Tue, 21 Feb 2023 15:26:17 -0600
Message-Id: <20230221212622.3897097-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230221212622.3897097-1-eajames@linux.ibm.com>
References: <20230221212622.3897097-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: soZPrvsKpj-x7P2i25deSYAtonnUn0eJ
X-Proofpoint-GUID: soZPrvsKpj-x7P2i25deSYAtonnUn0eJ
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

