Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F230065165C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiLSXED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiLSXCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:02:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C51274F;
        Mon, 19 Dec 2022 15:00:54 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJMpfGm001530;
        Mon, 19 Dec 2022 23:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=aKAupqStqr6PCuMQ/ko/uzEbZ6rKcoMmTUfe7DRB6HA=;
 b=ASPcmUHD7sHj/1M0rVoMjJ2SaQ6hdCO+xoVg46n97nbZJjZjULL+SB1CMul++q8KhBdT
 P6NQl3FyGGt5WtHauaW+b+WIAjyd1lvb/2Wf1WjdRPS+Ua0pxhFWrX43FsctBScLuIWW
 WRwepOQIk1s5vwyPbntJ1KoVxyqf4HrEcu3RDZIjOk2tziJeEeU0KMhHecmcwJsBidrN
 In6PYomuCJScuuKJRx6HjzmwVDDNlfL6Rc1aRlumlDb0xG4Ggyf0X9Ny4pAjbyNGmOgj
 D3ZnM/c8EzhsXqXGPEldC5PONYEgYAjn+Tovxt/Ws6+HZUnhsxEfwntNgxdZeRFBYK7+ ow== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh6xtd4bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:33 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0Wl9007757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:32 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:31 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 12/28] gunyah: vm_mgr: Introduce basic VM Manager
Date:   Mon, 19 Dec 2022 14:58:33 -0800
Message-ID: <20221219225850.2397345-13-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aLW2YXmq8yY539Rz7zU0SfLwhZ3b28DE
X-Proofpoint-ORIG-GUID: aLW2YXmq8yY539Rz7zU0SfLwhZ3b28DE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212190202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/Kconfig                   |  11 ++
 drivers/virt/gunyah/Makefile                  |   1 +
 drivers/virt/gunyah/rsc_mgr.c                 |  47 ++++++-
 drivers/virt/gunyah/vm_mgr.c                  | 115 ++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h                  |  25 ++++
 include/linux/gunyah_rsc_mgr.h                |   3 +
 include/uapi/linux/gunyah.h                   |  23 ++++
 8 files changed, 225 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/vm_mgr.c
 create mode 100644 drivers/virt/gunyah/vm_mgr.h
 create mode 100644 include/uapi/linux/gunyah.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 5f81e2a24a5c..81456c34c85d 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -136,6 +136,7 @@ Code  Seq#    Include File                                           Comments
 'F'   DD     video/sstfb.h                                           conflict!
 'G'   00-3F  drivers/misc/sgi-gru/grulib.h                           conflict!
 'G'   00-0F  xen/gntalloc.h, xen/gntdev.h                            conflict!
+'G'   00-0f  linux/gunyah.h                                          conflict!
 'H'   00-7F  linux/hiddev.h                                          conflict!
 'H'   00-0F  linux/hidraw.h                                          conflict!
 'H'   01     linux/mei.h                                             conflict!
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 4a6189dedab2..5e5a329c9866 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -23,4 +23,15 @@ config GUNYAH_RESOURCE_MANAGER
 	  Gunyah wanting to have Gunyah-awareness.
 
 	  Say Y/M here if unsure.
+
+config GUNYAH_VM_MANAGER
+	bool "Manage Gunyah Virtual Machines"
+	depends on MAILBOX
+	depends on GUNYAH_RESOURCE_MANAGER
+	help
+	  Gunyah VM manager exposes an interface to Gunyah userspace to load,
+	  run, and interact with other Gunyah virtual machines. This option is
+	  required to launch other virtual machines.
+
+	  Say Y here if unsure and you want to support Gunyah VMMs.
 endif
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 5caa05267a58..e817ae6deddc 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_GUNYAH) += gunyah.o
 
 gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
+gunyah_rsc_mgr-$(CONFIG_GUNYAH_VM_MANAGER) += vm_mgr.o
 obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER) += gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index 6b281576f5af..49d7939bbe36 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -16,8 +16,10 @@
 #include <linux/completion.h>
 #include <linux/gunyah_rsc_mgr.h>
 #include <linux/platform_device.h>
+#include <linux/miscdevice.h>
 
 #include "rsc_mgr.h"
+#include "vm_mgr.h"
 
 /* Resource Manager Header */
 struct gh_rm_rpc_hdr {
@@ -96,6 +98,7 @@ struct gh_rm_rpc {
 
 	struct mutex send_lock;
 
+	struct miscdevice miscdev;
 	struct work_struct recv_work;
 };
 
@@ -496,6 +499,33 @@ int gh_rm_call(struct gh_rm_rpc *rsc_mgr, u32 message_id, void *req_buff, size_t
 	return ret;
 }
 
+void get_gh_rm(struct gh_rm_rpc *rm)
+{
+	get_device(rm->dev);
+}
+EXPORT_SYMBOL_GPL(get_gh_rm);
+
+void put_gh_rm(struct gh_rm_rpc *rm)
+{
+	put_device(rm->dev);
+}
+EXPORT_SYMBOL_GPL(put_gh_rm);
+
+static long gh_dev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct miscdevice *miscdev = filp->private_data;
+	struct gh_rm_rpc *rm = container_of(miscdev, struct gh_rm_rpc, miscdev);
+
+	return gh_dev_vm_mgr_ioctl(rm, cmd, arg);
+}
+
+static const struct file_operations gh_dev_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= gh_dev_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.llseek		= noop_llseek,
+};
+
 static int gh_msgq_platform_probe_direction(struct platform_device *pdev,
 					u8 gh_type, int idx, struct gunyah_resource *ghrsc)
 {
@@ -550,14 +580,29 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 	rsc_mgr->msgq_client.rx_callback = gh_rm_msgq_rx_data;
 	rsc_mgr->msgq_client.tx_done = gh_rm_msgq_tx_done;
 
-	return gh_msgq_init(&pdev->dev, &rsc_mgr->msgq, &rsc_mgr->msgq_client,
+	ret = gh_msgq_init(&pdev->dev, &rsc_mgr->msgq, &rsc_mgr->msgq_client,
 				&rsc_mgr->tx_ghrsc, &rsc_mgr->rx_ghrsc);
+
+	rsc_mgr->miscdev.name = "gunyah";
+	rsc_mgr->miscdev.minor = MISC_DYNAMIC_MINOR;
+	rsc_mgr->miscdev.fops = &gh_dev_fops;
+
+	ret = misc_register(&rsc_mgr->miscdev);
+	if (ret)
+		goto err_msgq;
+
+	return 0;
+err_msgq:
+	mbox_free_channel(gh_msgq_chan(&rsc_mgr->msgq));
+	gh_msgq_remove(&rsc_mgr->msgq);
+	return ret;
 }
 
 static int gh_rm_drv_remove(struct platform_device *pdev)
 {
 	struct gh_rm_rpc *rm = platform_get_drvdata(pdev);
 
+	misc_deregister(&rm->miscdev);
 	mbox_free_channel(gh_msgq_chan(&rm->msgq));
 	gh_msgq_remove(&rm->msgq);
 
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
new file mode 100644
index 000000000000..9c796e5edcf1
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -0,0 +1,115 @@
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
+static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
+{
+	struct gunyah_vm *ghvm;
+	int vmid;
+
+	vmid = gh_rm_alloc_vmid(rm, 0);
+	if (vmid < 0)
+		return ERR_PTR(vmid);
+
+	ghvm = kzalloc(sizeof(*ghvm), GFP_KERNEL);
+	if (!ghvm)
+		return ghvm;
+
+	get_gh_rm(rm);
+
+	ghvm->vmid = vmid;
+	ghvm->rm = rm;
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
+	put_gh_rm(ghvm->rm);
+	kfree(ghvm);
+	return 0;
+}
+
+static const struct file_operations gh_vm_fops = {
+	.unlocked_ioctl = gh_vm_ioctl,
+	.release = gh_vm_release,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.llseek = noop_llseek,
+};
+
+static long gh_dev_ioctl_create_vm(struct gh_rm_rpc *rm, unsigned long arg)
+{
+	struct gunyah_vm *ghvm;
+	struct file *file;
+	int fd, err;
+
+	/* arg reserved for future use. */
+	if (arg)
+		return -EINVAL;
+
+	ghvm = gunyah_vm_alloc(rm);
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
+long gh_dev_vm_mgr_ioctl(struct gh_rm_rpc *rm, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case GH_CREATE_VM:
+		return gh_dev_ioctl_create_vm(rm, arg);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+EXPORT_SYMBOL_GPL(gh_dev_vm_mgr_ioctl);
+
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
new file mode 100644
index 000000000000..84e3d1a8571d
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -0,0 +1,25 @@
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
+#if IS_ENABLED(CONFIG_GUNYAH_VM_MANAGER)
+long gh_dev_vm_mgr_ioctl(struct gh_rm_rpc *rm, unsigned int cmd, unsigned long arg);
+#else
+static inline long gh_dev_vm_mgr_ioctl(struct gh_rm_rpc *rm, unsigned int cmd, unsigned long arg)
+	{ return -ENOIOCTLCMD; }
+#endif
+
+struct gunyah_vm {
+	u16 vmid;
+	struct gh_rm_rpc *rm;
+};
+
+#endif
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index eb94b48c41de..9c566436687d 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -17,6 +17,9 @@
 
 struct gh_rm_rpc;
 
+void get_gh_rm(struct gh_rm_rpc *rm);
+void put_gh_rm(struct gh_rm_rpc *rm);
+
 enum gh_rm_vm_status {
 	GH_RM_VM_STATUS_NO_STATE	= 0,
 	GH_RM_VM_STATUS_INIT		= 1,
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
new file mode 100644
index 000000000000..88a40d6e0b96
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
+#define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
+
+#endif
-- 
2.25.1

