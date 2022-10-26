Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0492D60E810
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiJZTB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiJZTAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:00:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72AB10047;
        Wed, 26 Oct 2022 11:59:50 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIosWv024108;
        Wed, 26 Oct 2022 18:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VsTxB5E5PuNgBp4rHSP9IfukuyPYI/T2vB+XXCnIxyE=;
 b=A6xL+vWv+45nl/QZhml9mwPaIIvpzirCtFJmukDvmtLkarwmyng16ZkKOn5OPzzGjKb9
 xrRYaNRMbNXahNEnZeQCaj3noCNJTMvcfmdD5Yc+Sj9raLquHeBW6dJUpCTi79q6w+yJ
 LeCCeKIh5vYevYgzzbFyyN/WPsQZR7zBvg72VVQsisd4Znf+BIazvEu//XNAbjTF3IDc
 xAsy0KC4AtAFI+WkA0xNAha0T2N+56nzqHsjHwGtQJbkW5hWj/5ON8eX8Q5sn99XDMXu
 Go8qH6ieldR4brm75/RZyRN3pUYt/I6GW5mOyKTT2Gp98CN3+4tUoC+gq9Syv8joscb8 rQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahb80pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:33 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QIxXoT024202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:33 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 11:59:32 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 11/21] gunyah: rsc_mgr: Add subdevices bus
Date:   Wed, 26 Oct 2022 11:58:36 -0700
Message-ID: <20221026185846.3983888-12-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026185846.3983888-1-quic_eberman@quicinc.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aEUQmP0jzQhzh7rYB_mA6mHh6lD7ZJxx
X-Proofpoint-ORIG-GUID: aEUQmP0jzQhzh7rYB_mA6mHh6lD7ZJxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210260107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah Resource Manager exposes an interface which should occupy a few
devices on Linux:
 - a remote procedure call framework to talk to RM
 - a virtual machine manager to launch VMs, share memory with them,
   schedule runtime for those VMs, and handle certain faults.

Create a virtual device bus for the console and VM Manager functions.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile      |  2 +-
 drivers/virt/gunyah/rsc_mgr.c     | 42 ++++++++++++++--
 drivers/virt/gunyah/rsc_mgr.h     | 10 ++++
 drivers/virt/gunyah/rsc_mgr_bus.c | 83 +++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h    | 19 +++++++
 include/linux/mod_devicetable.h   |  8 +++
 scripts/mod/devicetable-offsets.c |  3 ++
 scripts/mod/file2alias.c          | 10 ++++
 8 files changed, 173 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virt/gunyah/rsc_mgr_bus.c

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 2c18b0a56413..a9169af6c61f 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_GUNYAH) += gunyah.o
 
-gunyah_rsc_mgr-y += rsc_mgr.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_bus.o
 obj-$(CONFIG_GUNYAH_RESORUCE_MANAGER) += gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index a9fde703cbbe..f2f776edecb8 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -98,6 +98,8 @@ struct gh_rsc_mgr {
 	struct mutex send_lock;
 
 	struct work_struct recv_work;
+
+	struct gh_rm_device vm_mgr_dev;
 };
 
 static struct gh_rsc_mgr *__rsc_mgr;
@@ -567,17 +569,27 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 
 	__rsc_mgr = rsc_mgr;
 
+	ret = gh_rm_device_add(&rsc_mgr->vm_mgr_dev, &pdev->dev, GH_RM_DEVICE_VM_MGR);
+	if (ret)
+		goto err_msgq;
+
 	return 0;
+
+err_msgq:
+	gh_msgq_remove(&rsc_mgr->msgq);
+	return ret;
 }
 
 static int gh_rm_drv_remove(struct platform_device *pdev)
 {
 	struct gh_rsc_mgr *rsc_mgr = platform_get_drvdata(pdev);
 
+	gh_rm_device_delete(&rsc_mgr->vm_mgr_dev);
+
 	__rsc_mgr = NULL;
 
-	mbox_free_channel(gunyah_msgq_chan(&rsc_mgr->msgq));
-	gunyah_msgq_remove(&rsc_mgr->msgq);
+	mbox_free_channel(gh_msgq_chan(&rsc_mgr->msgq));
+	gh_msgq_remove(&rsc_mgr->msgq);
 
 	return 0;
 }
@@ -596,7 +608,31 @@ static struct platform_driver gh_rm_driver = {
 		.of_match_table = gh_rm_of_match,
 	},
 };
-module_platform_driver(gh_rsc_mgr_driver);
+
+static int __init gh_rm_init(void)
+{
+	int ret;
+
+	ret = gh_rm_bus_register();
+	if (ret) {
+		pr_err("Failed to register gh_rm_bus: %d\n", ret);
+		return ret;
+	}
+
+	ret = platform_driver_register(&gh_rm_driver);
+	if (ret)
+		gh_rm_bus_unregister();
+
+	return ret;
+}
+subsys_initcall(gh_rm_init);
+
+static void __exit gh_rm_exit(void)
+{
+	platform_driver_unregister(&gh_rm_driver);
+	gh_rm_bus_unregister();
+}
+module_exit(gh_rm_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Gunyah Resource Manager Driver");
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index e4f2499267bf..129e9d514f2a 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -31,4 +31,14 @@
 int gh_rm_call(u32 message_id, void *req_buff, size_t req_buff_size,
 		void **resp_buf, size_t *resp_buff_size);
 
+struct gh_rm_device {
+	struct device dev;
+	const char *name;
+};
+
+int gh_rm_bus_register(void);
+void gh_rm_bus_unregister(void);
+int gh_rm_device_add(struct gh_rm_device *ghrm_dev, struct device *parent, const char *name);
+void gh_rm_device_delete(struct gh_rm_device *ghrm_dev);
+
 #endif
diff --git a/drivers/virt/gunyah/rsc_mgr_bus.c b/drivers/virt/gunyah/rsc_mgr_bus.c
new file mode 100644
index 000000000000..bbb3bdc747cc
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr_bus.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gh_rsc_mgr: " fmt
+
+#include <linux/device.h>
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/mod_devicetable.h>
+
+#include "rsc_mgr.h"
+
+#define to_gh_rm_device(dev)	container_of(dev, struct gh_rm_device, dev)
+#define to_gh_rm_driver(drv)	container_of(drv, struct gh_rm_driver, drv)
+
+static int gh_rm_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct gh_rm_device *ghrm_dev = to_gh_rm_device(dev);
+	struct gh_rm_driver *ghrm_drv = to_gh_rm_driver(drv);
+
+	return !strncmp(ghrm_dev->name, ghrm_drv->id_table->name, GUNYAH_RSC_MGR_NAME_SIZE);
+}
+
+static int gh_rm_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct gh_rm_device *ghrm_dev = to_gh_rm_device(dev);
+
+	return add_uevent_var(env, "MODALIAS=%s%s", GUNYAH_RSC_MGR_PREFIX, ghrm_dev->name);
+}
+
+static struct bus_type gh_rm_bus = {
+	.name = "gh_rsc_mgr",
+	.match = gh_rm_bus_match,
+	.uevent = gh_rm_bus_uevent,
+};
+
+int gh_rm_bus_register(void)
+{
+	return bus_register(&gh_rm_bus);
+}
+
+void gh_rm_bus_unregister(void)
+{
+	bus_unregister(&gh_rm_bus);
+}
+
+int gh_rm_device_add(struct gh_rm_device *ghrm_dev, struct device *parent, const char *name)
+{
+	ghrm_dev->dev.bus = &gh_rm_bus;
+	ghrm_dev->dev.parent = parent;
+	ghrm_dev->name = name;
+
+	device_initialize(&ghrm_dev->dev);
+
+	dev_set_name(&ghrm_dev->dev, "%s.%s", dev_name(parent), name);
+	return device_add(&ghrm_dev->dev);
+}
+
+void gh_rm_device_delete(struct gh_rm_device *ghrm_dev)
+{
+	device_del(&ghrm_dev->dev);
+}
+
+int __gh_rm_driver_register(struct gh_rm_driver *ghrm_drv, struct module *owner,
+				const char *modname)
+{
+	if (WARN_ON(!ghrm_drv->drv.probe) || WARN_ON(!ghrm_drv->id_table))
+		return -EINVAL;
+
+	ghrm_drv->drv.bus = &gh_rm_bus;
+	ghrm_drv->drv.owner = owner;
+	ghrm_drv->drv.mod_name = modname;
+
+	return driver_register(&ghrm_drv->drv);
+}
+EXPORT_SYMBOL_GPL(__gh_rm_driver_register);
+
+void gh_rm_driver_unregister(struct gh_rm_driver *ghrm_drv)
+{
+	driver_unregister(&ghrm_drv->drv);
+}
+EXPORT_SYMBOL_GPL(gh_rm_driver_unregister);
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index b3b37225b7fb..0eeb7202fa33 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -9,6 +9,8 @@
 #include <linux/list.h>
 #include <linux/notifier.h>
 #include <linux/gunyah.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
 
 #define GH_VMID_INVAL	U16_MAX
 
@@ -23,4 +25,21 @@ struct gh_rm_notification {
 int gh_rm_register_notifier(struct notifier_block *nb);
 int gh_rm_unregister_notifier(struct notifier_block *nb);
 
+#define GH_RM_DEVICE_VM_MGR		"vm_mgr"
+
+struct gh_rm_driver {
+	const struct gunyah_rsc_mgr_device_id *id_table;
+	struct device_driver drv;
+};
+
+int __gh_rm_driver_register(struct gh_rm_driver *ghrm_drv, struct module *owner,
+				const char *modname);
+#define gh_rm_driver_register(ghrm_drv) \
+	__gh_rm_driver_register(ghrm_drv, THIS_MODULE, KBUILD_MODNAME)
+
+void gh_rm_driver_unregister(struct gh_rm_driver *ghrm_drv);
+
+#define module_gh_rm_driver(ghrm_drv) \
+	module_driver(ghrm_drv, gh_rm_driver_register, gh_rm_driver_unregister)
+
 #endif
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 549590e9c644..c4dc0ee6ae00 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -911,4 +911,12 @@ struct ishtp_device_id {
 	kernel_ulong_t driver_data;
 };
 
+#define GUNYAH_RSC_MGR_NAME_SIZE 32
+#define GUNYAH_RSC_MGR_PREFIX "gh_rsc_mgr:"
+
+struct gunyah_rsc_mgr_device_id {
+	const char name[GUNYAH_RSC_MGR_NAME_SIZE];
+	kernel_ulong_t driver_data;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index c0d3bcb99138..7b6944ed9336 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -262,5 +262,8 @@ int main(void)
 	DEVID(ishtp_device_id);
 	DEVID_FIELD(ishtp_device_id, guid);
 
+	DEVID(gunyah_rsc_mgr_device_id);
+	DEVID_FIELD(gunyah_rsc_mgr_device_id, name);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 80d973144fde..a02b9e8e02a8 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1452,6 +1452,15 @@ static int do_dfl_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: gh_rsc_mgr:S */
+static int do_gunyah_rsc_mgr_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD_ADDR(symval, gunyah_rsc_mgr_device_id, name);
+	sprintf(alias, GUNYAH_RSC_MGR_PREFIX "%s", *name);
+
+	return 1;
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1531,6 +1540,7 @@ static const struct devtable devtable[] = {
 	{"ssam", SIZE_ssam_device_id, do_ssam_entry},
 	{"dfl", SIZE_dfl_device_id, do_dfl_entry},
 	{"ishtp", SIZE_ishtp_device_id, do_ishtp_entry},
+	{"gh_rsc_mgr", SIZE_gunyah_rsc_mgr_device_id, do_gunyah_rsc_mgr_entry},
 };
 
 /* Create MODULE_ALIAS() statements.
-- 
2.25.1

