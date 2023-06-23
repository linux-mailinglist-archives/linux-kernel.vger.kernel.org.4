Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75BA73B989
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjFWOL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjFWOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:11:50 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12271BDF;
        Fri, 23 Jun 2023 07:11:47 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDMQMT032044;
        Fri, 23 Jun 2023 16:11:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=XdY3aQR2My4+fE+TtISFedSlydf7UiR2AlI5q0T6zgU=;
 b=ivDRCh+AWg08RxLSHHB7zh2N/XtFs2zSgngzhcntKNUhQZYdQhubL1/cSRL0iMPvWazk
 avDRLNdTaWaG5tcG/Q8EYibJ/PsmsSPU4H+7MOfw+0KwfjE2lr3r55XrW/18e7iBquCa
 PjjerbGtQDtI1H6Zlr5bV34DYB+ImRf53sfBiCX7mUmIokoRjtzj479LCBmNfB5z9Vgf
 aOyuQXTwrbUCxoJlqZEjj62+ZavBwsUKGuek5wPJehb4sxmPLmpF3by+6n5VZofF8DS9
 Hd2P9HjQAwloNTzk0aEqeNAtDfJeRvzrCp4nAx2aDJnUns9THiUBB8eDPd2oLJxbTokE 9A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rd6mab07t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:11:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CF7D4100075;
        Fri, 23 Jun 2023 16:11:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C861022AFF1;
        Fri, 23 Jun 2023 16:11:26 +0200 (CEST)
Received: from localhost (10.252.5.198) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 23 Jun
 2023 16:11:26 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [RFC PATCH 1/7] iio: introduce iio backend device
Date:   Fri, 23 Jun 2023 16:09:37 +0200
Message-ID: <20230623140944.2613002-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623140944.2613002-1-olivier.moysan@foss.st.com>
References: <20230623140944.2613002-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.5.198]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new device type in IIO framework.
This backend device does not compute channel attributes and does not expose
them through sysfs, as done typically in iio-rescale frontend device.
Instead, it allows to report information applying to channel
attributes through callbacks. These backend devices can be cascaded
to represent chained components.
An IIO device configured as a consumer of a backend device can compute
the channel attributes of the whole chain.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/Makefile               |  2 +
 drivers/iio/industrialio-backend.c | 59 ++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        | 29 +++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/iio/industrialio-backend.c
 create mode 100644 include/linux/iio/backend.h

diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 9622347a1c1b..b747fcef611d 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -8,6 +8,8 @@ industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 
+industrialio-$(CONFIG_IIO_BACKEND) += industrialio-backend.o
+
 obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
 obj-$(CONFIG_IIO_GTS_HELPER) += industrialio-gts-helper.o
 obj-$(CONFIG_IIO_SW_DEVICE) += industrialio-sw-device.o
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
new file mode 100644
index 000000000000..6a0f071f8682
--- /dev/null
+++ b/drivers/iio/industrialio-backend.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* The industrial I/O core, backend handling functions
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/iio/backend.h>
+
+struct iio_backend *iio_backend_alloc(struct device *parent)
+{
+	struct iio_backend *backend;
+
+	/*
+	 * Allocate backend struct
+	 * Init backend device & struct
+	 */
+
+	return backend;
+};
+EXPORT_SYMBOL(iio_backend_alloc);
+
+int iio_backend_register(struct iio_backend *backend)
+{
+	/*
+	 * Add device to device hierarchy
+	 * (Call device_add())
+	 */
+
+	return 0;
+};
+EXPORT_SYMBOL(iio_backend_register);
+
+void iio_backend_unregister(struct iio_backend *backend)
+{
+	/*
+	 * Free backend struct and delete device
+	 * (Call device_del())
+	 */
+};
+EXPORT_SYMBOL(iio_backend_unregister);
+
+struct iio_backend *iio_backend_get(struct device *dev)
+{
+	struct iio_backend *backend;
+
+	/*
+	 * Get backend in from device node
+	 * (call fwnode_property_get_reference_args() with io-backends prop)
+	 * Allocate backend
+	 * Find backend device from phandle
+	 * (call bus_find_device_by_fwnode())
+	 * Return backend
+	 */
+
+	return backend;
+};
+EXPORT_SYMBOL(iio_backend_get);
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
new file mode 100644
index 000000000000..e089e5e6cef0
--- /dev/null
+++ b/include/linux/iio/backend.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * The industrial I/O core, backend handling functions
+ *
+ * Author: Olivier Moysan <olivier.moysan@foss.st.com>.
+ */
+
+struct iio_backend_ops;
+
+struct iio_backend {
+	const struct iio_backend_ops	*ops;
+	struct module			*owner;
+	int				id;
+	const char			*name;
+	struct device			dev;
+	struct list_head		list;
+	void				*priv;
+};
+
+struct iio_backend_ops {
+	int (*enable)(struct iio_backend *backend);
+	int (*disable)(struct iio_backend *backend);
+	int (*read_raw)(struct iio_backend *backend, int *val, int *val2, long mask);
+};
+
+struct iio_backend *iio_backend_alloc(struct device *parent);
+int iio_backend_register(struct iio_backend *backend);
+void iio_backend_unregister(struct iio_backend *backend);
+struct iio_backend *iio_backend_get(struct device *dev);
-- 
2.25.1

