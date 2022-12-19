Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8330C651650
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiLSXDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiLSXB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:01:56 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5263B2;
        Mon, 19 Dec 2022 15:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671490848; x=1703026848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sf8syiRSzClrN1+SVtumeEs5knGjEyeRSly4hps5WZE=;
  b=YtsjAxROak9/TbuMqvHoZVjC449AdIquRYl50X4JqC/iOHNKqjSXVuvk
   zcLmp52ASvl2hck5PT3hLvWN9E+bmnxLZLI5cA585gKZXgWfx/JINSMXn
   dKdDy1I25Xy35gvQnSG53pRZ/uJ3UNVfUateXKvOItvIKOJO2uTw9rJle
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Dec 2022 15:00:48 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 15:00:48 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:47 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
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
Subject: [PATCH v8 22/28] gunyah: vm_mgr: Add framework to add VM Functions
Date:   Mon, 19 Dec 2022 14:58:43 -0800
Message-ID: <20221219225850.2397345-23-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
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

Introduce a framework for Gunyah userspace to install VM functions. VM
functions are optional interfaces to the virtual machine. vCPUs,
ioeventfs, and irqfds are examples of such VM functions and are
implemented in subsequent patches.

A generic framework is implemented instead of individual ioctls to
create vCPUs, irqfds, etc., in order to simplify the VM manager core
implementation and allow dynamic loading of VM function modules.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/vm-manager.rst |  18 +++
 drivers/virt/gunyah/vm_mgr.c             | 145 ++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h             |   5 +
 include/linux/gunyah_vm_mgr.h            |  68 +++++++++++
 include/uapi/linux/gunyah.h              |  12 ++
 5 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/gunyah_vm_mgr.h

diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
index 62513af09cbf..d929f8f20b3b 100644
--- a/Documentation/virt/gunyah/vm-manager.rst
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -17,6 +17,24 @@ sharing userspace memory with a VM is done via the GH_VM_SET_USER_MEM_REGION
 ioctl. The VM itself is configured to use the memory region via the
 devicetree.
 
+Gunyah Functions
+================
+
+Components of a Gunyah VM's configuration that need kernel configuration are
+called "functions" and are built on top of a framework. Functions are identified
+by a string and have some argument(s) to configure them. They are typically
+created by the `GH_VM_ADD_FUNCTION` ioctl.
+
+Functions typically will always do at least one of these operations:
+
+1. Create resource ticket(s). Resource tickets allow a function to register
+   itself as the client for a Gunyah resource (e.g. doorbell or vCPU) and
+   the function is given the pointer to the `struct gunyah_resource` when the
+   VM is starting.
+
+2. Register IO handler(s). IO handlers allow a function to handle stage-2 faults
+   from the virtual machine.
+
 Sample Userspace VMM
 ====================
 
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index a96cb7f73754..a5bda4d6613b 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -15,6 +15,125 @@
 
 #include "vm_mgr.h"
 
+static DEFINE_MUTEX(functions_lock);
+static LIST_HEAD(functions);
+
+static struct gunyah_vm_function_driver *__find_function(const char name[GUNYAH_FUNCTION_NAME_SIZE])
+	__must_hold(functions_lock)
+{
+	struct gunyah_vm_function_driver *iter, *drv = NULL;
+
+	list_for_each_entry(iter, &functions, list) {
+		if (!strncmp(iter->name, name, GUNYAH_FUNCTION_NAME_SIZE)) {
+			drv = iter;
+			break;
+		}
+	}
+
+	return drv;
+}
+
+int gunyah_vm_function_register(struct gunyah_vm_function_driver *drv)
+{
+	int ret = 0;
+
+	mutex_lock(&functions_lock);
+	if (__find_function(drv->name)) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&drv->instances);
+	list_add(&drv->list, &functions);
+out:
+	mutex_unlock(&functions_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_vm_function_register);
+
+static void gh_vm_remove_function(struct gunyah_vm_function *f)
+	__must_hold(functions_lock)
+{
+	f->drv->release(f);
+	list_del(&f->vm_list);
+	list_del(&f->drv_list);
+	module_put(f->drv->mod);
+}
+
+void gunyah_vm_function_unregister(struct gunyah_vm_function_driver *drv)
+{
+	struct gunyah_vm_function *f, *iter;
+
+	mutex_lock(&functions_lock);
+	list_for_each_entry_safe(f, iter, &drv->instances, drv_list)
+		gh_vm_remove_function(f);
+	list_del(&drv->list);
+	mutex_unlock(&functions_lock);
+}
+EXPORT_SYMBOL_GPL(gunyah_vm_function_unregister);
+
+static long gh_vm_add_function(struct gunyah_vm *ghvm, struct gunyah_vm_function *f)
+{
+	long r = 0;
+
+	mutex_lock(&functions_lock);
+	f->drv = __find_function(f->fn.name);
+	if (!f->drv) {
+		mutex_unlock(&functions_lock);
+		r = request_module("ghfunc:%s", f->fn.name);
+		if (r)
+			return r;
+
+		mutex_lock(&functions_lock);
+		f->drv = __find_function(f->fn.name);
+	}
+
+	if (!f->drv) {
+		r = -ENOENT;
+		goto out;
+	}
+
+	if (!try_module_get(f->drv->mod)) {
+		r = -ENOENT;
+		f->drv = NULL;
+		goto out;
+	}
+
+	f->ghvm = ghvm;
+	f->rm = ghvm->rm;
+
+	r = f->drv->bind(f);
+	if (r < 0) {
+		module_put(f->drv->mod);
+		goto out;
+	}
+
+	list_add(&f->vm_list, &ghvm->functions);
+	list_add(&f->drv_list, &f->drv->instances);
+out:
+	mutex_unlock(&functions_lock);
+	return r;
+}
+
+static void ghvm_put(struct kref *kref)
+{
+	struct gunyah_vm *ghvm = container_of(kref, struct gunyah_vm, kref);
+
+	kfree(ghvm);
+}
+
+int __must_check get_gunyah_vm(struct gunyah_vm *ghvm)
+{
+	return kref_get_unless_zero(&ghvm->kref);
+}
+EXPORT_SYMBOL_GPL(get_gunyah_vm);
+
+void put_gunyah_vm(struct gunyah_vm *ghvm)
+{
+	kref_put(&ghvm->kref, ghvm_put);
+}
+EXPORT_SYMBOL_GPL(put_gunyah_vm);
+
 static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
 {
 	struct gunyah_vm *ghvm;
@@ -36,6 +155,8 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
 	mutex_init(&ghvm->mm_lock);
 	INIT_LIST_HEAD(&ghvm->memory_mappings);
 	init_rwsem(&ghvm->status_lock);
+	kref_init(&ghvm->kref);
+	INIT_LIST_HEAD(&ghvm->functions);
 
 	return ghvm;
 }
@@ -170,6 +291,23 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			r = -EINVAL;
 		break;
 	}
+	case GH_VM_ADD_FUNCTION: {
+		struct gunyah_vm_function *f;
+
+		r = -ENOMEM;
+		f = kzalloc(sizeof(*f), GFP_KERNEL);
+		if (!f)
+			break;
+
+		r = -EFAULT;
+		if (copy_from_user(&f->fn, argp, sizeof(f->fn)))
+			break;
+
+		r = gh_vm_add_function(ghvm, f);
+		if (r < 0)
+			kfree(f);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 		break;
@@ -182,14 +320,19 @@ static int gh_vm_release(struct inode *inode, struct file *filp)
 {
 	struct gunyah_vm *ghvm = filp->private_data;
 	struct gunyah_vm_memory_mapping *mapping, *tmp;
+	struct gunyah_vm_function *f, *iter;
 
 	gh_vm_stop(ghvm);
 
+	list_for_each_entry_safe(f, iter, &ghvm->functions, vm_list) {
+		gh_vm_remove_function(f);
+	}
 	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
 		gh_vm_mem_mapping_reclaim(ghvm, mapping);
 	}
+
 	put_gh_rm(ghvm->rm);
-	kfree(ghvm);
+	put_gunyah_vm(ghvm);
 	return 0;
 }
 
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 8dcba9f14b5c..2c4fd240792a 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -8,6 +8,7 @@
 
 #include <linux/gunyah_rsc_mgr.h>
 #include <linux/list.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
@@ -47,8 +48,12 @@ struct gunyah_vm {
 	enum gh_rm_vm_status vm_status;
 	struct rw_semaphore status_lock;
 
+	struct kref kref;
+
 	struct mutex mm_lock;
 	struct list_head memory_mappings;
+
+	struct list_head functions;
 };
 
 struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct gunyah_vm *ghvm,
diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
new file mode 100644
index 000000000000..4bb06f100ae5
--- /dev/null
+++ b/include/linux/gunyah_vm_mgr.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _GUNYAH_VM_MGR_H
+#define _GUNYAH_VM_MGR_H
+
+#include <linux/compiler_types.h>
+#include <linux/gunyah.h>
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+#include <linux/notifier.h>
+
+#include <uapi/linux/gunyah.h>
+
+struct gunyah_vm;
+
+int __must_check get_gunyah_vm(struct gunyah_vm *ghvm);
+void put_gunyah_vm(struct gunyah_vm *ghvm);
+
+struct gunyah_vm_function;
+struct gunyah_vm_function_driver {
+	const char name[GUNYAH_FUNCTION_NAME_SIZE];
+	struct module *mod;
+	long (*bind)(struct gunyah_vm_function *f);
+	void (*release)(struct gunyah_vm_function *f);
+	struct list_head list;
+	struct list_head instances;
+};
+
+struct gunyah_vm_function {
+	struct gh_vm_function fn;
+	struct gunyah_vm *ghvm;
+	struct gh_rm_rpc *rm;
+	struct gunyah_vm_function_driver *drv;
+	void *data;
+	struct list_head vm_list;
+	struct list_head drv_list;
+};
+
+int gunyah_vm_function_register(struct gunyah_vm_function_driver *f);
+void gunyah_vm_function_unregister(struct gunyah_vm_function_driver *f);
+
+#define DECLARE_GUNYAH_VM_FUNCTION(_name, _bind, _release)		\
+	static struct gunyah_vm_function_driver _name = {		\
+		.name = __stringify(_name),				\
+		.mod = THIS_MODULE,					\
+		.bind = _bind,						\
+		.release = _release,					\
+	};								\
+	MODULE_ALIAS("ghfunc:"__stringify(_name))
+
+#define DECLARE_GUNYAH_VM_FUNCTION_INIT(_name, _bind, _release)		\
+	DECLARE_GUNYAH_VM_FUNCTION(_name, _bind, _release);		\
+	static int __init _name##_mod_init(void)			\
+	{								\
+		return gunyah_vm_function_register(&(_name));		\
+	}								\
+	module_init(_name##_mod_init);					\
+	static void __exit _name##_mod_exit(void)			\
+	{								\
+		gunyah_vm_function_unregister(&(_name));		\
+	}								\
+	module_exit(_name##_mod_exit)
+
+#endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 36359ad2175e..40db32aeb012 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -50,4 +50,16 @@ struct gh_vm_dtb_config {
 
 #define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
 
+#define GUNYAH_FUNCTION_NAME_SIZE		32
+#define GUNYAH_FUNCTION_MAX_ARG_SIZE		1024
+
+struct gh_vm_function {
+	char name[GUNYAH_FUNCTION_NAME_SIZE];
+	union {
+		char data[GUNYAH_FUNCTION_MAX_ARG_SIZE];
+	};
+};
+
+#define GH_VM_ADD_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x4, struct gh_vm_function)
+
 #endif
-- 
2.25.1

