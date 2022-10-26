Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F1860E7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiJZTA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiJZTAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:00:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D3BCE32;
        Wed, 26 Oct 2022 11:59:48 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIprcn003960;
        Wed, 26 Oct 2022 18:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Zx78Z8Hz7/Au869llrMubfRCTLY/fhmtR3G4p5oJGN4=;
 b=XAhS7kEOrI3wYdKjEu2iRTkrmFEqSk+qkiYpL/2RM0Nc00MGk9HC1VhEpiE4WS94eBvj
 X1CfUXSZIDOrAYX2+BaPIkA2qNEwKVPGWuXH+D8Pfx0DH60KAy0fN3gb0gytvW0RSVIK
 6LN8wSV2seEvPCuAsOkkohAJwDikr9464VVuiy4c56A/fzWaZ7/HQJvqGfqj6jizfzME
 W6xMq35FlDtgV2384CvAQgLfvHud6jxe/NN+wF8owsC2GjfAnv3aeVbl5IwhkKR6U5F7
 JFTaThMOwRXX7YJbc3QNFp6UlQK+T7fsf+iYR6wxD6YLyN/xV8ESTVfRD8ulgLaXp+/y pQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahvr0ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:35 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QIxYjC010506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:34 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 11:59:33 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
Date:   Wed, 26 Oct 2022 11:58:38 -0700
Message-ID: <20221026185846.3983888-14-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: AyAdauPjERWMlwHBKA6iJdpo7yR-LOME
X-Proofpoint-ORIG-GUID: AyAdauPjERWMlwHBKA6iJdpo7yR-LOME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2210260105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah VM manager is a kernel moduel which exposes an interface to
Gunyah userspace to load, run, and interact with other Gunyah virtual
machines. The interface is a character device at /dev/gunyah.

Add a basic VM manager driver. Upcoming patches will add more ioctls
into this driver.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/virt/gunyah/Kconfig                   |   8 +
 drivers/virt/gunyah/Makefile                  |   3 +
 drivers/virt/gunyah/vm_mgr.c                  | 152 ++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h                  |  17 ++
 include/uapi/linux/gunyah.h                   |  23 +++
 6 files changed, 204 insertions(+)
 create mode 100644 drivers/virt/gunyah/vm_mgr.c
 create mode 100644 drivers/virt/gunyah/vm_mgr.h
 create mode 100644 include/uapi/linux/gunyah.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 5f81e2a24a5c..1fa1a5877bd7 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -136,6 +136,7 @@ Code  Seq#    Include File                                           Comments
 'F'   DD     video/sstfb.h                                           conflict!
 'G'   00-3F  drivers/misc/sgi-gru/grulib.h                           conflict!
 'G'   00-0F  xen/gntalloc.h, xen/gntdev.h                            conflict!
+'G'   40-4f  linux/gunyah.h
 'H'   00-7F  linux/hiddev.h                                          conflict!
 'H'   00-0F  linux/hidraw.h                                          conflict!
 'H'   01     linux/mei.h                                             conflict!
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 4de88d80aa7b..c5d239159118 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -25,3 +25,11 @@ config GUNYAH_RESORUCE_MANAGER
 
 	  Say Y/M here if unsure.
 
+config GUNYAH_VM_MANAGER
+	tristate "Gunyah VM Manager"
+	depends on GUNYAH_RESORUCE_MANAGER
+	help
+	  Gunyah VM manager is a kernel module which exposes an interface to
+	  Gunyah userspace to load, run, and interact with other Gunyah
+	  virtual machines. This module is required to launch other virtual
+	  machines.
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 09c1bbd28b48..a69b1e2273af 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -2,3 +2,6 @@ obj-$(CONFIG_GUNYAH) += gunyah.o
 
 gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o rsc_mgr_bus.o
 obj-$(CONFIG_GUNYAH_RESORUCE_MANAGER) += gunyah_rsc_mgr.o
+
+gunyah_vm_mgr-y += vm_mgr.o
+obj-$(CONFIG_GUNYAH_VM_MANAGER) += gunyah_vm_mgr.o
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
new file mode 100644
index 000000000000..c48853dba11d
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gh_vm_mgr: " fmt
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+
+#include <uapi/linux/gunyah.h>
+
+#include "vm_mgr.h"
+
+static __must_check struct gunyah_vm *gunyah_vm_alloc(void)
+{
+	struct gunyah_vm *ghvm;
+	int ret;
+
+	ret = gh_rm_alloc_vmid(0);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	ghvm = kzalloc(sizeof(*ghvm), GFP_KERNEL);
+	if (!ghvm)
+		return ghvm;
+
+	ghvm->vmid = ret;
+
+	return ghvm;
+}
+
+static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	long r;
+
+	switch (cmd) {
+	default:
+		r = -ENOTTY;
+		break;
+	}
+
+	return r;
+}
+
+static int gh_vm_release(struct inode *inode, struct file *filp)
+{
+	struct gunyah_vm *ghvm = filp->private_data;
+
+	kfree(ghvm);
+	return 0;
+}
+
+static const struct file_operations gh_vm_fops = {
+	.unlocked_ioctl = gh_vm_ioctl,
+	.release = gh_vm_release,
+	.llseek = noop_llseek,
+};
+
+static long gh_dev_ioctl_create_vm(unsigned long arg)
+{
+	struct gunyah_vm *ghvm;
+	struct file *file;
+	int fd, err;
+
+	/* arg reserved for future use. */
+	if (arg)
+		return -EINVAL;
+
+	ghvm = gunyah_vm_alloc();
+	if (IS_ERR_OR_NULL(ghvm))
+		return PTR_ERR(ghvm) ? : -ENOMEM;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		err = fd;
+		goto err_destroy_vm;
+	}
+
+	file = anon_inode_getfile("gunyah-vm", &gh_vm_fops, ghvm, O_RDWR);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_fd;
+	}
+
+	fd_install(fd, file);
+
+	return fd;
+
+err_put_fd:
+	put_unused_fd(fd);
+err_destroy_vm:
+	kfree(ghvm);
+	return err;
+}
+
+static long gh_dev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case GH_CREATE_VM:
+		return gh_dev_ioctl_create_vm(arg);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct file_operations gh_dev_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= gh_dev_ioctl,
+	.llseek		= noop_llseek,
+};
+
+static struct miscdevice gh_dev = {
+	.name		= "gunyah",
+	.minor		= MISC_DYNAMIC_MINOR,
+	.fops		= &gh_dev_fops,
+};
+
+static int vm_mgr_probe(struct device *dev)
+{
+	return misc_register(&gh_dev);
+}
+
+static int vm_mgr_remove(struct device *dev)
+{
+	misc_deregister(&gh_dev);
+
+	return 0;
+}
+
+static struct gunyah_rsc_mgr_device_id vm_mgr_ids[] = {
+	{ .name = GH_RM_DEVICE_VM_MGR },
+	{}
+};
+MODULE_DEVICE_TABLE(gunyah_rsc_mgr, vm_mgr_ids);
+
+static struct gh_rm_driver vm_mgr_drv = {
+	.drv = {
+		.name = KBUILD_MODNAME,
+		.probe = vm_mgr_probe,
+		.remove = vm_mgr_remove,
+	},
+	.id_table = vm_mgr_ids,
+};
+module_gh_rm_driver(vm_mgr_drv);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah VM Manager");
+
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
new file mode 100644
index 000000000000..d306ff5eac82
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _GH_PRIV_VM_MGR_H
+#define _GH_PRIV_VM_MGR_H
+
+#include <linux/gunyah_rsc_mgr.h>
+
+#include <uapi/linux/gunyah.h>
+
+struct gunyah_vm {
+	u16 vmid;
+};
+
+#endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
new file mode 100644
index 000000000000..37ea6bd4c2fd
--- /dev/null
+++ b/include/uapi/linux/gunyah.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _UAPI_LINUX_GUNYAH
+#define _UAPI_LINUX_GUNYAH
+
+/*
+ * Userspace interface for /dev/gunyah - gunyah based virtual machine
+ */
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define GH_IOCTL_TYPE			'G'
+
+/*
+ * ioctls for /dev/gunyah fds:
+ */
+#define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x40) /* Returns a Gunyah VM fd */
+
+#endif
-- 
2.25.1

