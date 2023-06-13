Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D234772E9B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbjFMRXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbjFMRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:23:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D872135;
        Tue, 13 Jun 2023 10:22:15 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DDBaEH005060;
        Tue, 13 Jun 2023 17:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=OPtSM8nWeqsxL3k23c94sOppSuUyjfS/9XUJXN8PHOw=;
 b=XVQtBJBrXNFuXrOhF9rvulu+4ivRpnrjelyUm4LfsbrVbEnwIO+DOPpVK7aDc4X2u6iN
 j821IjnXQqV634H/sWxH+E6Bke0W9+q+llAa0o7uZxQuFr0C8BmrU9M5tQ91w1FLcxcc
 x7hhtlhRsuAUf7Lgxicv2i/h/W6GKYyRXcpLQ9Nig93W/Nsyfv3WOrdBDXSKSB7WR45C
 llKZIUyBHunsYJp+Q11IbiMe94n4m1ZTMYTabDx4d6Zvwwz9ge4QazrzqpzEcjbRmBYN
 NNQ+19x/qaVeXQub3DSkBbsBbPu8l9ffOWTFgQNsC0by9OvAuC4xbqGTDk4e9vay69+z fA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6s3wrnbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:49 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DHLlvu029757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:47 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 10:21:46 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v14 18/25] gunyah: vm_mgr: Add framework for VM Functions
Date:   Tue, 13 Jun 2023 10:20:46 -0700
Message-ID: <20230613172054.3959700-19-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230613172054.3959700-1-quic_eberman@quicinc.com>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RajAQ38azNm1O3E-vm6UTrDGfVfSEg3U
X-Proofpoint-GUID: RajAQ38azNm1O3E-vm6UTrDGfVfSEg3U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_19,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 Documentation/virt/gunyah/vm-manager.rst |  18 ++
 drivers/virt/gunyah/vm_mgr.c             | 213 ++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h             |   4 +
 include/linux/gunyah_vm_mgr.h            |  97 +++++++++++
 include/uapi/linux/gunyah.h              |  18 ++
 5 files changed, 347 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/gunyah_vm_mgr.h

diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
index df0e1a8279bf5..cbc79bd8749b4 100644
--- a/Documentation/virt/gunyah/vm-manager.rst
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -15,6 +15,24 @@ such as vCPUs for the VM. Memory can be shared with the VM with
 `GH_VM_SET_USER_MEM_REGION`_. Userspace can interact with the resources in Linux
 by adding "functions" to the VM.
 
+Gunyah Functions
+================
+
+Components of a Gunyah VM's configuration that need kernel configuration are
+called "functions" and are built on top of a framework. Functions are identified
+by a string and have some argument(s) to configure them. They are typically
+created by the `GH_VM_ADD_FUNCTION`_ ioctl.
+
+Functions typically will always do at least one of these operations:
+
+1. Create resource ticket(s). Resource tickets allow a function to register
+   itself as the client for a Gunyah resource (e.g. doorbell or vCPU) and
+   the function is given the pointer to the &struct gh_resource when the
+   VM is starting.
+
+2. Register IO handler(s). IO handlers allow a function to handle stage-2 faults
+   from the virtual machine.
+
 Sample Userspace VMM
 ====================
 
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 562ae6ed4a5f1..cfd79bc9900fd 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -6,10 +6,13 @@
 #define pr_fmt(fmt) "gh_vm_mgr: " fmt
 
 #include <linux/anon_inodes.h>
+#include <linux/compat.h>
 #include <linux/file.h>
 #include <linux/gunyah_rsc_mgr.h>
+#include <linux/gunyah_vm_mgr.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/xarray.h>
 
 #include <uapi/linux/gunyah.h>
 
@@ -17,6 +20,169 @@
 
 static void gh_vm_free(struct work_struct *work);
 
+static DEFINE_XARRAY(gh_vm_functions);
+
+static void gh_vm_put_function(struct gh_vm_function *fn)
+{
+	module_put(fn->mod);
+}
+
+static struct gh_vm_function *gh_vm_get_function(u32 type)
+{
+	struct gh_vm_function *fn;
+
+	fn = xa_load(&gh_vm_functions, type);
+	if (!fn) {
+		request_module("ghfunc:%d", type);
+
+		fn = xa_load(&gh_vm_functions, type);
+	}
+
+	if (!fn || !try_module_get(fn->mod))
+		fn = ERR_PTR(-ENOENT);
+
+	return fn;
+}
+
+static void gh_vm_remove_function_instance(struct gh_vm_function_instance *inst)
+	__must_hold(&inst->ghvm->fn_lock)
+{
+	inst->fn->unbind(inst);
+	list_del(&inst->vm_list);
+	gh_vm_put_function(inst->fn);
+	kfree(inst->argp);
+	kfree(inst);
+}
+
+static void gh_vm_remove_functions(struct gh_vm *ghvm)
+{
+	struct gh_vm_function_instance *inst, *iiter;
+
+	mutex_lock(&ghvm->fn_lock);
+	list_for_each_entry_safe(inst, iiter, &ghvm->functions, vm_list) {
+		gh_vm_remove_function_instance(inst);
+	}
+	mutex_unlock(&ghvm->fn_lock);
+}
+
+static long gh_vm_add_function_instance(struct gh_vm *ghvm, struct gh_fn_desc *f)
+{
+	struct gh_vm_function_instance *inst;
+	void __user *argp;
+	long r = 0;
+
+	if (f->arg_size > GH_FN_MAX_ARG_SIZE) {
+		dev_err_ratelimited(ghvm->parent, "%s: arg_size > %d\n",
+					__func__, GH_FN_MAX_ARG_SIZE);
+		return -EINVAL;
+	}
+
+	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+
+	inst->arg_size = f->arg_size;
+	if (inst->arg_size) {
+		inst->argp = kzalloc(inst->arg_size, GFP_KERNEL);
+		if (!inst->argp) {
+			r = -ENOMEM;
+			goto free;
+		}
+
+		argp = u64_to_user_ptr(f->arg);
+		if (copy_from_user(inst->argp, argp, f->arg_size)) {
+			r = -EFAULT;
+			goto free_arg;
+		}
+	}
+
+	inst->fn = gh_vm_get_function(f->type);
+	if (IS_ERR(inst->fn)) {
+		r = PTR_ERR(inst->fn);
+		goto free_arg;
+	}
+
+	inst->ghvm = ghvm;
+	inst->rm = ghvm->rm;
+
+	mutex_lock(&ghvm->fn_lock);
+	r = inst->fn->bind(inst);
+	if (r < 0) {
+		mutex_unlock(&ghvm->fn_lock);
+		gh_vm_put_function(inst->fn);
+		goto free_arg;
+	}
+
+	list_add(&inst->vm_list, &ghvm->functions);
+	mutex_unlock(&ghvm->fn_lock);
+
+	return r;
+free_arg:
+	kfree(inst->argp);
+free:
+	kfree(inst);
+	return r;
+}
+
+static long gh_vm_rm_function_instance(struct gh_vm *ghvm, struct gh_fn_desc *f)
+{
+	struct gh_vm_function_instance *inst, *iter;
+	void __user *user_argp;
+	void *argp;
+	long r = 0;
+
+	r = mutex_lock_interruptible(&ghvm->fn_lock);
+	if (r)
+		return r;
+
+	if (f->arg_size) {
+		argp = kzalloc(f->arg_size, GFP_KERNEL);
+		if (!argp) {
+			r = -ENOMEM;
+			goto out;
+		}
+
+		user_argp = u64_to_user_ptr(f->arg);
+		if (copy_from_user(argp, user_argp, f->arg_size)) {
+			r = -EFAULT;
+			kfree(argp);
+			goto out;
+		}
+
+		r = -ENOENT;
+		list_for_each_entry_safe(inst, iter, &ghvm->functions, vm_list) {
+			if (inst->fn->type == f->type &&
+				inst->fn->compare(inst, argp, f->arg_size)) {
+				gh_vm_remove_function_instance(inst);
+				r = 0;
+			}
+		}
+
+		kfree(argp);
+	}
+
+out:
+	mutex_unlock(&ghvm->fn_lock);
+	return r;
+}
+
+int gh_vm_function_register(struct gh_vm_function *fn)
+{
+	if (!fn->bind || !fn->unbind)
+		return -EINVAL;
+
+	return xa_err(xa_store(&gh_vm_functions, fn->type, fn, GFP_KERNEL));
+}
+EXPORT_SYMBOL_GPL(gh_vm_function_register);
+
+void gh_vm_function_unregister(struct gh_vm_function *fn)
+{
+	/* Expecting unregister to only come when unloading a module */
+	WARN_ON(fn->mod && module_refcount(fn->mod));
+	xa_erase(&gh_vm_functions, fn->type);
+}
+EXPORT_SYMBOL_GPL(gh_vm_function_unregister);
+
 static int gh_vm_rm_notification_status(struct gh_vm *ghvm, void *data)
 {
 	struct gh_rm_vm_status_payload *payload = data;
@@ -98,6 +264,8 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 	init_rwsem(&ghvm->status_lock);
 	init_waitqueue_head(&ghvm->vm_status_wait);
 	INIT_WORK(&ghvm->free_work, gh_vm_free);
+	kref_init(&ghvm->kref);
+	INIT_LIST_HEAD(&ghvm->functions);
 	ghvm->vm_status = GH_RM_VM_STATUS_NO_STATE;
 
 	return ghvm;
@@ -254,6 +422,24 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		r = gh_vm_ensure_started(ghvm);
 		break;
 	}
+	case GH_VM_ADD_FUNCTION: {
+		struct gh_fn_desc f;
+
+		if (copy_from_user(&f, argp, sizeof(f)))
+			return -EFAULT;
+
+		r = gh_vm_add_function_instance(ghvm, &f);
+		break;
+	}
+	case GH_VM_REMOVE_FUNCTION: {
+		struct gh_fn_desc f;
+
+		if (copy_from_user(&f, argp, sizeof(f)))
+			return -EFAULT;
+
+		r = gh_vm_rm_function_instance(ghvm, &f);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 		break;
@@ -270,6 +456,8 @@ static void gh_vm_free(struct work_struct *work)
 	if (ghvm->vm_status == GH_RM_VM_STATUS_RUNNING)
 		gh_vm_stop(ghvm);
 
+	gh_vm_remove_functions(ghvm);
+
 	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE &&
 	    ghvm->vm_status != GH_RM_VM_STATUS_LOAD &&
 	    ghvm->vm_status != GH_RM_VM_STATUS_RESET) {
@@ -294,14 +482,33 @@ static void gh_vm_free(struct work_struct *work)
 	kfree(ghvm);
 }
 
-static int gh_vm_release(struct inode *inode, struct file *filp)
+int __must_check gh_vm_get(struct gh_vm *ghvm)
 {
-	struct gh_vm *ghvm = filp->private_data;
+	return kref_get_unless_zero(&ghvm->kref);
+}
+EXPORT_SYMBOL_GPL(gh_vm_get);
+
+static void _gh_vm_put(struct kref *kref)
+{
+	struct gh_vm *ghvm = container_of(kref, struct gh_vm, kref);
 
 	/* VM will be reset and make RM calls which can interruptible sleep.
 	 * Defer to a work so this thread can receive signal.
 	 */
 	schedule_work(&ghvm->free_work);
+}
+
+void gh_vm_put(struct gh_vm *ghvm)
+{
+	kref_put(&ghvm->kref, _gh_vm_put);
+}
+EXPORT_SYMBOL_GPL(gh_vm_put);
+
+static int gh_vm_release(struct inode *inode, struct file *filp)
+{
+	struct gh_vm *ghvm = filp->private_data;
+
+	gh_vm_put(ghvm);
 	return 0;
 }
 
@@ -346,7 +553,7 @@ static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long arg)
 err_put_fd:
 	put_unused_fd(fd);
 err_destroy_vm:
-	gh_vm_free(&ghvm->free_work);
+	gh_vm_put(ghvm);
 	return err;
 }
 
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 4173bd51f83fe..c4bec1469ae8c 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -8,6 +8,7 @@
 
 #include <linux/gunyah_rsc_mgr.h>
 #include <linux/list.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
@@ -45,9 +46,12 @@ struct gh_vm {
 	struct rw_semaphore status_lock;
 
 	struct work_struct free_work;
+	struct kref kref;
 	struct mm_struct *mm; /* userspace tied to this vm */
 	struct mutex mm_lock;
 	struct list_head memory_mappings;
+	struct mutex fn_lock;
+	struct list_head functions;
 };
 
 int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region);
diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
new file mode 100644
index 0000000000000..6e4dd6fa5f96d
--- /dev/null
+++ b/include/linux/gunyah_vm_mgr.h
@@ -0,0 +1,97 @@
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
+struct gh_vm;
+
+int __must_check gh_vm_get(struct gh_vm *ghvm);
+void gh_vm_put(struct gh_vm *ghvm);
+
+struct gh_vm_function_instance;
+/**
+ * struct gh_vm_function - Represents a function type
+ * @type: value from &enum gh_fn_type
+ * @name: friendly name for debug purposes
+ * @mod: owner of the function type
+ * @bind: Called when a new function of this type has been allocated.
+ * @unbind: Called when the function instance is being destroyed.
+ * @compare: Compare function instance @f's argument to the provided arg.
+ *           Return true if they are equivalent. Used on GH_VM_REMOVE_FUNCTION.
+ */
+struct gh_vm_function {
+	u32 type;
+	const char *name;
+	struct module *mod;
+	long (*bind)(struct gh_vm_function_instance *f);
+	void (*unbind)(struct gh_vm_function_instance *f);
+	bool (*compare)(const struct gh_vm_function_instance *f, const void *arg, size_t size);
+};
+
+/**
+ * struct gh_vm_function_instance - Represents one function instance
+ * @arg_size: size of user argument
+ * @argp: pointer to user argument
+ * @ghvm: Pointer to VM instance
+ * @rm: Pointer to resource manager for the VM instance
+ * @fn: The ops for the function
+ * @data: Private data for function
+ * @vm_list: for gh_vm's functions list
+ * @fn_list: for gh_vm_function's instances list
+ */
+struct gh_vm_function_instance {
+	size_t arg_size;
+	void *argp;
+	struct gh_vm *ghvm;
+	struct gh_rm *rm;
+	struct gh_vm_function *fn;
+	void *data;
+	struct list_head vm_list;
+};
+
+int gh_vm_function_register(struct gh_vm_function *f);
+void gh_vm_function_unregister(struct gh_vm_function *f);
+
+/* Since the function identifiers were setup in a uapi header as an
+ * enum and we do no want to change that, the user must supply the expanded
+ * constant as well and the compiler checks they are the same.
+ * See also MODULE_ALIAS_RDMA_NETLINK.
+ */
+#define MODULE_ALIAS_GH_VM_FUNCTION(_type, _idx)			\
+	static inline void __maybe_unused __chk##_idx(void)		\
+	{								\
+		BUILD_BUG_ON(_type != _idx);				\
+	}								\
+	MODULE_ALIAS("ghfunc:" __stringify(_idx))
+
+#define DECLARE_GH_VM_FUNCTION(_name, _type, _bind, _unbind, _compare)	\
+	static struct gh_vm_function _name = {				\
+		.type = _type,						\
+		.name = __stringify(_name),				\
+		.mod = THIS_MODULE,					\
+		.bind = _bind,						\
+		.unbind = _unbind,					\
+		.compare = _compare,					\
+	}
+
+#define module_gh_vm_function(__gf)					\
+	module_driver(__gf, gh_vm_function_register, gh_vm_function_unregister)
+
+#define DECLARE_GH_VM_FUNCTION_INIT(_name, _type, _idx, _bind, _unbind, _compare)	\
+	DECLARE_GH_VM_FUNCTION(_name, _type, _bind, _unbind, _compare);			\
+	module_gh_vm_function(_name);							\
+	MODULE_ALIAS_GH_VM_FUNCTION(_type, _idx)
+
+#endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 4b63d0b9b8ba7..bb07118a351fd 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -72,4 +72,22 @@ struct gh_vm_dtb_config {
 
 #define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
 
+#define GH_FN_MAX_ARG_SIZE		256
+
+/**
+ * struct gh_fn_desc - Arguments to create a VM function
+ * @type: Type of the function. See &enum gh_fn_type.
+ * @arg_size: Size of argument to pass to the function. arg_size <= GH_FN_MAX_ARG_SIZE
+ * @arg: Pointer to argument given to the function. See &enum gh_fn_type for expected
+ *       arguments for a function type.
+ */
+struct gh_fn_desc {
+	__u32 type;
+	__u32 arg_size;
+	__u64 arg;
+};
+
+#define GH_VM_ADD_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x4, struct gh_fn_desc)
+#define GH_VM_REMOVE_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x7, struct gh_fn_desc)
+
 #endif
-- 
2.40.0

