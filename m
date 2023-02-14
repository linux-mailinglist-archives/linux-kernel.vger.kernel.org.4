Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D1D696F65
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjBNVZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjBNVZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:25:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A0B1C7F2;
        Tue, 14 Feb 2023 13:24:53 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EKidC2012731;
        Tue, 14 Feb 2023 21:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=OBWvVnlAggHyoJwmX/rigEp8Eftw9CfyVZmRCv3vz0E=;
 b=F4RV2gD9/1teZwdOeLmqZKHomvH/IYpIhiL9s9+emTsDA2eAllXXiBuvwOiJJKRjmigw
 5Qvs7YshpG3YAocCWe0mlaY6VKZi8wM/owycSbXuWmbsLhT7cd5lM9dboOsEp3ZAVea7
 7nKn30Gby7C05vKVeOnWoG1xoFSJZvvbFWh+4aztPJJj45HF3x8Ksoik17H7y3Z6YVv4
 yVvOmuopO/MNF6p6MWR5j93/5g+7hRIbpj8pqT0R/lxTqDzuh4iWltOx+3UvcPX1x2Nn
 2lu3xB6wV81S6XImqZDz0P1PtJ6Lh13D2Zv9W0XymVgEWShI0+wArADTzl6Ypnh2WUux 4Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqpmmm1vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:24:38 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ELObkP008968
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:24:37 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 13:24:36 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
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
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v10 13/26] gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
Date:   Tue, 14 Feb 2023 13:24:26 -0800
Message-ID: <20230214212427.3316544-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214211229.3239350-1-quic_eberman@quicinc.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UqFGYD1MbmZAWzOWgezEFXk-7piT0duB
X-Proofpoint-GUID: UqFGYD1MbmZAWzOWgezEFXk-7piT0duB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add remaining ioctls to support non-proxy VM boot:

 - Gunyah Resource Manager uses the VM's devicetree to configure the
   virtual machine. The location of the devicetree in the guest's
   virtual memory can be declared via the SET_DTB_CONFIG ioctl.
 - Trigger start of the virtual machine with VM_START ioctl.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c    | 229 ++++++++++++++++++++++++++++++--
 drivers/virt/gunyah/vm_mgr.h    |  10 ++
 drivers/virt/gunyah/vm_mgr_mm.c |  23 ++++
 include/linux/gunyah_rsc_mgr.h  |   6 +
 include/uapi/linux/gunyah.h     |  13 ++
 5 files changed, 268 insertions(+), 13 deletions(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 84102bac03cc..fa324385ade5 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -9,37 +9,114 @@
 #include <linux/file.h>
 #include <linux/gunyah_rsc_mgr.h>
 #include <linux/miscdevice.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 
 #include <uapi/linux/gunyah.h>
 
 #include "vm_mgr.h"
 
+static int gh_vm_rm_notification_status(struct gh_vm *ghvm, void *data)
+{
+	struct gh_rm_vm_status_payload *payload = data;
+
+	if (payload->vmid != ghvm->vmid)
+		return NOTIFY_OK;
+
+	/* All other state transitions are synchronous to a corresponding RM call */
+	if (payload->vm_status == GH_RM_VM_STATUS_RESET) {
+		down_write(&ghvm->status_lock);
+		ghvm->vm_status = payload->vm_status;
+		up_write(&ghvm->status_lock);
+		wake_up(&ghvm->vm_status_wait);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int gh_vm_rm_notification_exited(struct gh_vm *ghvm, void *data)
+{
+	struct gh_rm_vm_exited_payload *payload = data;
+
+	if (payload->vmid != ghvm->vmid)
+		return NOTIFY_OK;
+
+	down_write(&ghvm->status_lock);
+	ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
+	up_write(&ghvm->status_lock);
+
+	return NOTIFY_DONE;
+}
+
+static int gh_vm_rm_notification(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct gh_vm *ghvm = container_of(nb, struct gh_vm, nb);
+
+	switch (action) {
+	case GH_RM_NOTIFICATION_VM_STATUS:
+		return gh_vm_rm_notification_status(ghvm, data);
+	case GH_RM_NOTIFICATION_VM_EXITED:
+		return gh_vm_rm_notification_exited(ghvm, data);
+	default:
+		return NOTIFY_OK;
+	}
+}
+
+static void gh_vm_stop(struct gh_vm *ghvm)
+{
+	int ret;
+
+	down_write(&ghvm->status_lock);
+	if (ghvm->vm_status == GH_RM_VM_STATUS_RUNNING) {
+		ret = gh_rm_vm_stop(ghvm->rm, ghvm->vmid);
+		if (ret)
+			pr_warn("Failed to stop VM: %d\n", ret);
+	}
+
+	ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
+	up_write(&ghvm->status_lock);
+}
+
 static void gh_vm_free(struct work_struct *work)
 {
 	struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
 	struct gh_vm_mem *mapping, *tmp;
 	int ret;
 
-	mutex_lock(&ghvm->mm_lock);
-	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
-		gh_vm_mem_reclaim(ghvm, mapping);
-		kfree(mapping);
+	switch (ghvm->vm_status) {
+unknown_state:
+	case GH_RM_VM_STATUS_RUNNING:
+		gh_vm_stop(ghvm);
+		fallthrough;
+	case GH_RM_VM_STATUS_INIT_FAILED:
+	case GH_RM_VM_STATUS_LOAD:
+	case GH_RM_VM_STATUS_LOAD_FAILED:
+		mutex_lock(&ghvm->mm_lock);
+		list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
+			gh_vm_mem_reclaim(ghvm, mapping);
+			kfree(mapping);
+		}
+		mutex_unlock(&ghvm->mm_lock);
+		fallthrough;
+	case GH_RM_VM_STATUS_NO_STATE:
+		ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
+		if (ret)
+			pr_warn("Failed to deallocate vmid: %d\n", ret);
+
+		gh_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
+		put_gh_rm(ghvm->rm);
+		kfree(ghvm);
+		break;
+	default:
+		pr_err("VM is unknown state: %d, assuming it's running.\n", ghvm->vm_status);
+		goto unknown_state;
 	}
-	mutex_unlock(&ghvm->mm_lock);
-
-	ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
-	if (ret)
-		pr_warn("Failed to deallocate vmid: %d\n", ret);
-
-	put_gh_rm(ghvm->rm);
-	kfree(ghvm);
 }
 
 static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 {
 	struct gh_vm *ghvm;
-	int vmid;
+	int vmid, ret;
 
 	vmid = gh_rm_alloc_vmid(rm, 0);
 	if (vmid < 0)
@@ -56,13 +133,123 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 	ghvm->vmid = vmid;
 	ghvm->rm = rm;
 
+	init_waitqueue_head(&ghvm->vm_status_wait);
+	ghvm->nb.notifier_call = gh_vm_rm_notification;
+	ret = gh_rm_notifier_register(rm, &ghvm->nb);
+	if (ret) {
+		put_gh_rm(rm);
+		gh_rm_dealloc_vmid(rm, vmid);
+		kfree(ghvm);
+		return ERR_PTR(ret);
+	}
+
 	mutex_init(&ghvm->mm_lock);
 	INIT_LIST_HEAD(&ghvm->memory_mappings);
+	init_rwsem(&ghvm->status_lock);
 	INIT_WORK(&ghvm->free_work, gh_vm_free);
+	ghvm->vm_status = GH_RM_VM_STATUS_LOAD;
 
 	return ghvm;
 }
 
+static int gh_vm_start(struct gh_vm *ghvm)
+{
+	struct gh_vm_mem *mapping;
+	u64 dtb_offset;
+	u32 mem_handle;
+	int ret;
+
+	down_write(&ghvm->status_lock);
+	if (ghvm->vm_status != GH_RM_VM_STATUS_LOAD) {
+		up_write(&ghvm->status_lock);
+		return 0;
+	}
+
+	ghvm->vm_status = GH_RM_VM_STATUS_RESET;
+
+	list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
+		switch (mapping->share_type) {
+		case VM_MEM_LEND:
+			ret = gh_rm_mem_lend(ghvm->rm, &mapping->parcel);
+			break;
+		case VM_MEM_SHARE:
+			ret = gh_rm_mem_share(ghvm->rm, &mapping->parcel);
+			break;
+		}
+		if (ret) {
+			pr_warn("Failed to %s parcel %d: %d\n",
+				mapping->share_type == VM_MEM_LEND ? "lend" : "share",
+				mapping->parcel.label,
+				ret);
+			goto err;
+		}
+	}
+
+	mapping = gh_vm_mem_find_mapping(ghvm, ghvm->dtb_config.gpa, ghvm->dtb_config.size);
+	if (!mapping) {
+		pr_warn("Failed to find the memory_handle for DTB\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	mem_handle = mapping->parcel.mem_handle;
+	dtb_offset = ghvm->dtb_config.gpa - mapping->guest_phys_addr;
+
+	ret = gh_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, mem_handle,
+				0, 0, dtb_offset, ghvm->dtb_config.size);
+	if (ret) {
+		pr_warn("Failed to configure VM: %d\n", ret);
+		goto err;
+	}
+
+	ret = gh_rm_vm_init(ghvm->rm, ghvm->vmid);
+	if (ret) {
+		pr_warn("Failed to initialize VM: %d\n", ret);
+		goto err;
+	}
+
+	ret = gh_rm_vm_start(ghvm->rm, ghvm->vmid);
+	if (ret) {
+		pr_warn("Failed to start VM: %d\n", ret);
+		goto err;
+	}
+
+	ghvm->vm_status = GH_RM_VM_STATUS_RUNNING;
+	up_write(&ghvm->status_lock);
+	return ret;
+err:
+	ghvm->vm_status = GH_RM_VM_STATUS_INIT_FAILED;
+	up_write(&ghvm->status_lock);
+	return ret;
+}
+
+static int gh_vm_ensure_started(struct gh_vm *ghvm)
+{
+	int ret;
+
+retry:
+	ret = down_read_interruptible(&ghvm->status_lock);
+	if (ret)
+		return ret;
+
+	/* Unlikely because VM is typically started */
+	if (unlikely(ghvm->vm_status == GH_RM_VM_STATUS_LOAD)) {
+		up_read(&ghvm->status_lock);
+		ret = gh_vm_start(ghvm);
+		if (ret)
+			goto out;
+		goto retry;
+	}
+
+	/* Unlikely because VM is typically running */
+	if (unlikely(ghvm->vm_status != GH_RM_VM_STATUS_RUNNING))
+		ret = -ENODEV;
+
+out:
+	up_read(&ghvm->status_lock);
+	return ret;
+}
+
 static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct gh_vm *ghvm = filp->private_data;
@@ -88,6 +275,22 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			r = gh_vm_mem_free(ghvm, region.label);
 		break;
 	}
+	case GH_VM_SET_DTB_CONFIG: {
+		struct gh_vm_dtb_config dtb_config;
+
+		if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
+			return -EFAULT;
+
+		dtb_config.size = PAGE_ALIGN(dtb_config.size);
+		ghvm->dtb_config = dtb_config;
+
+		r = 0;
+		break;
+	}
+	case GH_VM_START: {
+		r = gh_vm_ensure_started(ghvm);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 		break;
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 97bc00c34878..e9cf56647cc2 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -10,6 +10,8 @@
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
+#include <linux/wait.h>
 
 #include <uapi/linux/gunyah.h>
 
@@ -33,6 +35,13 @@ struct gh_vm_mem {
 struct gh_vm {
 	u16 vmid;
 	struct gh_rm *rm;
+	enum gh_rm_vm_auth_mechanism auth;
+	struct gh_vm_dtb_config dtb_config;
+
+	struct notifier_block nb;
+	enum gh_rm_vm_status vm_status;
+	wait_queue_head_t vm_status_wait;
+	struct rw_semaphore status_lock;
 
 	struct work_struct free_work;
 	struct mutex mm_lock;
@@ -43,5 +52,6 @@ int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *regio
 void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping);
 int gh_vm_mem_free(struct gh_vm *ghvm, u32 label);
 struct gh_vm_mem *gh_vm_mem_find(struct gh_vm *ghvm, u32 label);
+struct gh_vm_mem *gh_vm_mem_find_mapping(struct gh_vm *ghvm, u64 gpa, u32 size);
 
 #endif
diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
index 03e71a36ea3b..128b90da555a 100644
--- a/drivers/virt/gunyah/vm_mgr_mm.c
+++ b/drivers/virt/gunyah/vm_mgr_mm.c
@@ -52,6 +52,29 @@ void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping)
 	list_del(&mapping->list);
 }
 
+struct gh_vm_mem *gh_vm_mem_find_mapping(struct gh_vm *ghvm, u64 gpa, u32 size)
+{
+	struct gh_vm_mem *mapping = NULL;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ghvm->mm_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
+	list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
+		if (gpa >= mapping->guest_phys_addr &&
+			(gpa + size <= mapping->guest_phys_addr +
+			(mapping->npages << PAGE_SHIFT))) {
+			goto unlock;
+		}
+	}
+
+	mapping = NULL;
+unlock:
+	mutex_unlock(&ghvm->mm_lock);
+	return mapping;
+}
+
 struct gh_vm_mem *gh_vm_mem_find(struct gh_vm *ghvm, u32 label)
 {
 	struct gh_vm_mem *mapping;
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 2d8b8b6cc394..9cffee6f9b4e 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -32,6 +32,12 @@ struct gh_rm_vm_exited_payload {
 #define GH_RM_NOTIFICATION_VM_EXITED		 0x56100001
 
 enum gh_rm_vm_status {
+	/**
+	 * RM doesn't have a state where load partially failed because
+	 * only Linux
+	 */
+	GH_RM_VM_STATUS_LOAD_FAILED	= -1,
+
 	GH_RM_VM_STATUS_NO_STATE	= 0,
 	GH_RM_VM_STATUS_INIT		= 1,
 	GH_RM_VM_STATUS_READY		= 2,
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index d85d12119a48..d899bba6a4c6 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -53,4 +53,17 @@ struct gh_userspace_memory_region {
 #define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
 						struct gh_userspace_memory_region)
 
+/**
+ * struct gh_vm_dtb_config - Set the location of the VM's devicetree blob
+ * @gpa: Address of the VM's devicetree in guest memory.
+ * @size: Maximum size of the devicetree.
+ */
+struct gh_vm_dtb_config {
+	__u64 gpa;
+	__u64 size;
+};
+#define GH_VM_SET_DTB_CONFIG	_IOW(GH_IOCTL_TYPE, 0x2, struct gh_vm_dtb_config)
+
+#define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
+
 #endif
-- 
2.39.1

