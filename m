Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7422D6324C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiKUOCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiKUOCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:02:02 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6D4FC6;
        Mon, 21 Nov 2022 06:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669039320; x=1700575320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/AbaL2gOtJsOtw6O608D+VMLPxbCH1NmWF8RQaiB/U=;
  b=Xz8QJ80nHS9ZC62tbrDvCWTdvghrsI6fYbpzqcIKl+vkh/VFju4TYVcN
   00toZuG6ntljhafMLxQIr8y0CXIAdwU4q3q+JsK2USPG1SmdGvvMKga+X
   mV0qPeD5lwwosw2y2Hy8XTTG0qeKM5zCrejTHfQvjwhonHiR1o7cIm5qQ
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Nov 2022 06:02:00 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 06:02:00 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 06:01:58 -0800
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 12/20] gunyah: vm_mgr: Introduce basic VM Manager
Date:   Mon, 21 Nov 2022 06:00:01 -0800
Message-ID: <20221121140009.2353512-13-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121140009.2353512-1-quic_eberman@quicinc.com>
References: <20221121140009.2353512-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
 drivers/virt/gunyah/Kconfig                   |  10 ++
 drivers/virt/gunyah/Makefile                  |   3 +
 drivers/virt/gunyah/gunyah_rsc_mgr.c          |  32 +++-
 drivers/virt/gunyah/vm_mgr.c                  | 155 ++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h                  |  31 ++++
 include/uapi/linux/gunyah.h                   |  23 +++
 7 files changed, 249 insertions(+), 6 deletions(-)
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
index 0bb497372d4e..5856b7c5157b 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -16,4 +16,14 @@ config GUNYAH_RESOURCE_MANAGER
 	tristate
 	depends on MAILBOX
 	select GUNYAH_MESSAGE_QUEUES
+
+config GUNYAH_VM_MANAGER
+	tristate "Gunyah VM Manager"
+	depends on MAILBOX
+	select GUNYAH_RESOURCE_MANAGER
+	help
+	  Gunyah VM manager is a kernel module which exposes an interface to
+	  Gunyah userspace to load, run, and interact with other Gunyah
+	  virtual machines. This module is required to launch other virtual
+	  machines.
 endif
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index b62ac4045621..ae628424719b 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,3 +1,6 @@
 obj-$(CONFIG_GUNYAH) += gunyah.o
 
 obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER) += gunyah_rsc_mgr.o gunyah_rm_rpc.o
+
+gunyah_vm_mgr-y += vm_mgr.o
+obj-$(CONFIG_GUNYAH_VM_MANAGER) += gunyah_vm_mgr.o
diff --git a/drivers/virt/gunyah/gunyah_rsc_mgr.c b/drivers/virt/gunyah/gunyah_rsc_mgr.c
index 2fae62bbfe49..47cf107ce894 100644
--- a/drivers/virt/gunyah/gunyah_rsc_mgr.c
+++ b/drivers/virt/gunyah/gunyah_rsc_mgr.c
@@ -7,25 +7,45 @@
 #include <linux/platform_device.h>
 
 #include "rsc_mgr.h"
+#include "vm_mgr.h"
+
+struct gh_rsc_mgr {
+	struct gh_rm_rpc *rpc;
+	struct gh_vm_mgr *vm_mgr;
+};
 
 static int gh_rm_drv_probe(struct platform_device *pdev)
 {
-	struct gh_rm_rpc *rsc_mgr;
+	struct gh_rsc_mgr *rsc_mgr;
 
-	rsc_mgr = gh_rm_rpc_init(pdev);
-	if (IS_ERR(rsc_mgr))
-		return PTR_ERR(rsc_mgr);
+	rsc_mgr = devm_kzalloc(&pdev->dev, sizeof(*rsc_mgr), GFP_KERNEL);
+	if (!rsc_mgr)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, rsc_mgr);
 
+	rsc_mgr->rpc = gh_rm_rpc_init(pdev);
+	if (IS_ERR(rsc_mgr->rpc))
+		return PTR_ERR(rsc_mgr->rpc);
+
+	rsc_mgr->vm_mgr = gh_vm_mgr_init(&pdev->dev, rsc_mgr->rpc);
+	if (IS_ERR(rsc_mgr->vm_mgr)) {
+		dev_warn(&pdev->dev, "Failed to initialize vm manager: %ld\n",
+			PTR_ERR(rsc_mgr->vm_mgr));
+		rsc_mgr->vm_mgr = NULL;
+	}
+
 	return 0;
 }
 
 static int gh_rm_drv_remove(struct platform_device *pdev)
 {
-	struct gh_rm_rpc *rsc_mgr = platform_get_drvdata(pdev);
+	struct gh_rsc_mgr *rsc_mgr = platform_get_drvdata(pdev);
+
+	if (rsc_mgr->vm_mgr)
+		gh_vm_mgr_remove(rsc_mgr->vm_mgr);
 
-	gh_rm_rpc_remove(rsc_mgr);
+	gh_rm_rpc_remove(rsc_mgr->rpc);
 
 	return 0;
 }
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
new file mode 100644
index 000000000000..deb8e0bf4a4d
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -0,0 +1,155 @@
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
+static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_vm_mgr *vm_mgr)
+{
+	struct gunyah_vm *ghvm;
+	int ret;
+
+	ret = gh_rm_alloc_vmid(vm_mgr->rm, 0);
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
+	.compat_ioctl	= compat_ptr_ioctl,
+	.llseek = noop_llseek,
+};
+
+static long gh_dev_ioctl_create_vm(struct gh_vm_mgr *vm_mgr, unsigned long arg)
+{
+	struct gunyah_vm *ghvm;
+	struct file *file;
+	int fd, err;
+
+	/* arg reserved for future use. */
+	if (arg)
+		return -EINVAL;
+
+	ghvm = gunyah_vm_alloc(vm_mgr);
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
+	struct miscdevice *miscdev = filp->private_data;
+	struct gh_vm_mgr *vm_mgr = container_of(miscdev, struct gh_vm_mgr, miscdev);
+
+	switch (cmd) {
+	case GH_CREATE_VM:
+		return gh_dev_ioctl_create_vm(vm_mgr, arg);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct file_operations gh_dev_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= gh_dev_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.llseek		= noop_llseek,
+};
+
+struct gh_vm_mgr *gh_vm_mgr_init(struct device *dev, struct gh_rm_rpc *rm)
+{
+	struct gh_vm_mgr *vm_mgr;
+	int ret;
+
+	vm_mgr = kzalloc(sizeof(*vm_mgr), GFP_KERNEL);
+	if (!vm_mgr)
+		return ERR_PTR(-ENOMEM);
+
+	vm_mgr->dev = dev;
+	vm_mgr->rm = rm;
+	vm_mgr->miscdev.name = "gunyah";
+	vm_mgr->miscdev.minor = MISC_DYNAMIC_MINOR;
+	vm_mgr->miscdev.fops = &gh_dev_fops;
+
+	ret = misc_register(&vm_mgr->miscdev);
+	if (ret) {
+		kfree(vm_mgr);
+		return ERR_PTR(ret);
+	}
+
+	return vm_mgr;
+}
+EXPORT_SYMBOL_GPL(gh_vm_mgr_init);
+
+void gh_vm_mgr_remove(struct gh_vm_mgr *vm_mgr)
+{
+	misc_deregister(&vm_mgr->miscdev);
+	kfree(vm_mgr);
+}
+EXPORT_SYMBOL_GPL(gh_vm_mgr_remove);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah VM Manager");
+
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
new file mode 100644
index 000000000000..9e9dfb1c0268
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -0,0 +1,31 @@
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
+struct gh_vm_mgr {
+	struct device *dev;
+	struct gh_rm_rpc *rm;
+	struct miscdevice miscdev;
+};
+
+#if IS_ENABLED(CONFIG_GUNYAH_VM_MANAGER)
+struct gh_vm_mgr *gh_vm_mgr_init(struct device *dev, struct gh_rm_rpc *rm);
+void gh_vm_mgr_remove(struct gh_vm_mgr *vm_mgr);
+#else
+static inline struct gh_vm_mgr *gh_vm_mgr_init(struct gh_rm_rpc *rm) { return NULL; }
+static inline void gh_vm_mgr_remove(struct gh_vm_mgr *vm_mgr) { }
+#endif
+
+struct gunyah_vm {
+	u16 vmid;
+};
+
+#endif
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

