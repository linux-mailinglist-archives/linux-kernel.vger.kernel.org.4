Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266EC6760C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjATWuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjATWuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:50:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C263D4F35D;
        Fri, 20 Jan 2023 14:49:18 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMb1WQ007055;
        Fri, 20 Jan 2023 22:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ytZx091v+Zeou4MbVlh64449R9MyK4MSZfSGoF9kPNA=;
 b=Hko1lbODhT5XCfdtM4oC/kAUpW2zrdCeVui+M/IO5xUhCpKWhvTCvB1EWypKuDC8+a9z
 Nodhhsenr+G0/fhv/H+otxPJGv/Mobcat5X2xLpDcjX2UWWxHPnf/31ctlrGzRXUV2iE
 X6kf7hfIQLTG8hzEbJRgY6fjjPL+ZY1AFcxku0emNv9rITH/3VaYHD5Cwz2CXfkINfal
 NXwKxEMReWcm+sGN2xGMR1cZVxIrIiR9EOFWlOlzfazGFdL5ZNhBAzfjLQ+bIbhGxGDO
 Hf/dHPzyqB1CMIKHf9lahIoKtz23xCYw3hJpbZj0KsjGgvZZVk1TfS+QNCJdMB4yOXfe QQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7593uqyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:03 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMm2Zq024408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:02 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:48:02 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v9 21/27] gunyah: vm_mgr: Add framework to add VM Functions
Date:   Fri, 20 Jan 2023 14:46:20 -0800
Message-ID: <20230120224627.4053418-22-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120224627.4053418-1-quic_eberman@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XI3-3LRiBfYBc8VR1CiCD0_diTlYn1hB
X-Proofpoint-ORIG-GUID: XI3-3LRiBfYBc8VR1CiCD0_diTlYn1hB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301200218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/vm_mgr.c             | 187 ++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h             |   5 +
 include/linux/gunyah_vm_mgr.h            |  68 +++++++++
 include/uapi/linux/gunyah.h              |  13 ++
 5 files changed, 289 insertions(+), 2 deletions(-)
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
index 48bd3f06fb6c..1e795f3d19d5 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -16,7 +16,147 @@
 
 #include "vm_mgr.h"
 
-static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
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
+	kfree(f);
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
+static long gh_vm_rm_function(struct gunyah_vm *ghvm, struct gh_vm_function *fn)
+{
+	long r = 0;
+	struct gunyah_vm_function *f, *iter;
+
+	r = mutex_lock_interruptible(&functions_lock);
+	if (r)
+		return r;
+
+	list_for_each_entry_safe(f, iter, &ghvm->functions, vm_list) {
+		if (!memcmp(&f->fn, fn, sizeof(*fn)))
+			gh_vm_remove_function(f);
+	}
+
+	mutex_unlock(&functions_lock);
+	return 0;
+}
+
+static void ghvm_put(struct kref *kref)
+{
+	struct gunyah_vm *ghvm = container_of(kref, struct gunyah_vm, kref);
+
+	gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
+	put_gh_rm(ghvm->rm);
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
+static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm *rm)
 {
 	struct gunyah_vm *ghvm;
 	int vmid;
@@ -39,6 +179,8 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
 	mutex_init(&ghvm->mm_lock);
 	INIT_LIST_HEAD(&ghvm->memory_mappings);
 	init_rwsem(&ghvm->status_lock);
+	kref_init(&ghvm->kref);
+	INIT_LIST_HEAD(&ghvm->functions);
 
 	return ghvm;
 }
@@ -192,6 +334,39 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
+	case GH_VM_REMOVE_FUNCTION: {
+		struct gh_vm_function *fn;
+
+		r = -ENOMEM;
+		fn = kzalloc(sizeof(*fn), GFP_KERNEL);
+		if (!fn)
+			break;
+
+		r = -EFAULT;
+		if (copy_from_user(fn, argp, sizeof(*fn)))
+			break;
+
+		r = gh_vm_rm_function(ghvm, fn);
+		kfree(fn);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 		break;
@@ -204,15 +379,23 @@ static int gh_vm_release(struct inode *inode, struct file *filp)
 {
 	struct gunyah_vm *ghvm = filp->private_data;
 	struct gunyah_vm_memory_mapping *mapping, *tmp;
+	struct gunyah_vm_function *f, *fiter;
 
 	gh_vm_stop(ghvm);
 
+	mutex_lock(&functions_lock);
+	list_for_each_entry_safe(f, fiter, &ghvm->functions, vm_list) {
+		gh_vm_remove_function(f);
+	}
+	mutex_unlock(&functions_lock);
+
 	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
 		gh_vm_mem_mapping_reclaim(ghvm, mapping);
 		kfree(mapping);
 	}
+
 	put_gh_rm(ghvm->rm);
-	kfree(ghvm);
+	put_gunyah_vm(ghvm);
 	return 0;
 }
 
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 5c02fb305893..8d3b0678fb96 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -8,6 +8,7 @@
 
 #include <linux/gunyah_rsc_mgr.h>
 #include <linux/list.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
@@ -41,8 +42,12 @@ struct gunyah_vm {
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
index 000000000000..69f98eb503e9
--- /dev/null
+++ b/include/linux/gunyah_vm_mgr.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
+	struct gh_rm *rm;
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
index 36359ad2175e..ec8da6fde045 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -50,4 +50,17 @@ struct gh_vm_dtb_config {
 
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
+#define GH_VM_REMOVE_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x7, struct gh_vm_function)
+
 #endif
-- 
2.39.0

