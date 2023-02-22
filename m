Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD569FC09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjBVTYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjBVTYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:24:34 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C339B3E09B;
        Wed, 22 Feb 2023 11:24:17 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MIokJk019285;
        Wed, 22 Feb 2023 19:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qyn+EWnxFstxyTndS+aBZAkYcNiZRJK1wB+Dw0C3Hw8=;
 b=mkwPwb+ok2IRNThYEJkmgdrzLwHzbQImNhNonp2Kx68Tl1KXpbZgEWXZPs7my/55v4WB
 mBrzPTuF0slcdgGzRSMfpbQvP1OwYVacaIwo1Fxedq6wXmKKVh1fHNLxdinFtA8oBd0/
 gwxpFcTLF3eFSyxTkSwUc+EiX47H+NbFN56LEKcQlVy3M1zRgjbYMhCH+HFkD0AGHBwi
 T3mMkjjRU5+JKD86lxN/YxhGOMdajttp5awqPsmEGQFYKl5hi49gj8Gil6CuD05SgYfG
 FBXGkXAOtVvg5loDmS/8kBBQ4ybFHzuvF5JrdKwnCD3ayZ8F6HM4Qs/QUJFlQt6D01Zc pQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwrph18cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 19:23:59 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MGkAif015944;
        Wed, 22 Feb 2023 19:23:58 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa71ycj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 19:23:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MJNwuf26411754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 19:23:58 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1277258051;
        Wed, 22 Feb 2023 19:23:58 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E3815805C;
        Wed, 22 Feb 2023 19:23:56 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.56.187])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 19:23:56 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v6 1/6] fsi: Move fsi_slave structure definition to header
Date:   Wed, 22 Feb 2023 13:23:49 -0600
Message-Id: <20230222192354.4055034-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230222192354.4055034-1-eajames@linux.ibm.com>
References: <20230222192354.4055034-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xQWKbCcLCTKWBzGghGaIszI0pgx_0YKV
X-Proofpoint-GUID: xQWKbCcLCTKWBzGghGaIszI0pgx_0YKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_08,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220164
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

