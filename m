Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0F86AA704
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 02:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCDBIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 20:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCDBHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 20:07:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E46069078;
        Fri,  3 Mar 2023 17:07:17 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323NdeqR017178;
        Sat, 4 Mar 2023 01:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=MaVCwpT5GoBYhUfIWvF2v8THe49xZ8C+mZ8RNreqWGo=;
 b=K+BJ448nZkgGEv3RV5JB+oTGgLaKJgl0i+CVQZm/cUafjLlYjjKUbVwbLcFe7Rg9CvSm
 vuC/EWqrhjDeMnruajyDfU5CwaFEZ5QggmW4Veq2HhUdqzPnsGCOPuq9vrMMHNGliJnl
 eqKDEzAQm9UxUgGZQxmMwlAfoFmvqyjGCYOR+pANF29o/duwNWJgIO8lA1FWAWFqaNPd
 mK7E8pqVnBYKp9t/6oI0iWfa7HjezPp2SCbVMwr5DrhmiSV+kzXXXPsUHI5oGm/M/oo1
 xceMrsssSyC1KANhODpnWmQIZbsz2N5OCMtlGAnBMO2QMS2cKBIE43Swg1nrEbw347er XA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3dfrjf3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Mar 2023 01:07:04 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 324173gY018726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 4 Mar 2023 01:07:03 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 3 Mar 2023 17:07:02 -0800
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
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v11 13/26] gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
Date:   Fri, 3 Mar 2023 17:06:19 -0800
Message-ID: <20230304010632.2127470-14-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304010632.2127470-1-quic_eberman@quicinc.com>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZTwRCB7bU_EhQRaXBPnsYGMVGFJAzsIV
X-Proofpoint-ORIG-GUID: ZTwRCB7bU_EhQRaXBPnsYGMVGFJAzsIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_07,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303040005
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
 drivers/virt/gunyah/vm_mgr.c    | 243 ++++++++++++++++++++++++++++++--
 drivers/virt/gunyah/vm_mgr.h    |  10 ++
 drivers/virt/gunyah/vm_mgr_mm.c |  23 +++
 include/linux/gunyah_rsc_mgr.h  |   6 +
 include/uapi/linux/gunyah.h     |  13 ++
 5 files changed, 282 insertions(+), 13 deletions(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index e950274c6a53..299b9bb81edc 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -9,37 +9,118 @@
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
+			dev_warn(ghvm->parent, "Failed to stop VM: %d\n", ret);
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
-	}
-	mutex_unlock(&ghvm->mm_lock);
-
-	ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
-	if (ret)
-		pr_warn("Failed to deallocate vmid: %d\n", ret);
+	switch (ghvm->vm_status) {
+	case GH_RM_VM_STATUS_RUNNING:
+		gh_vm_stop(ghvm);
+		fallthrough;
+	case GH_RM_VM_STATUS_INIT_FAILED:
+	case GH_RM_VM_STATUS_LOAD:
+	case GH_RM_VM_STATUS_EXITED:
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
+			dev_warn(ghvm->parent, "Failed to deallocate vmid: %d\n", ret);
+
+		gh_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
+		gh_rm_put(ghvm->rm);
+		kfree(ghvm);
+		break;
+	default:
+		dev_err(ghvm->parent, "VM is unknown state: %d. VM will not be cleaned up.\n",
+			ghvm->vm_status);
 
-	put_gh_rm(ghvm->rm);
-	kfree(ghvm);
+		gh_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
+		gh_rm_put(ghvm->rm);
+		kfree(ghvm);
+		break;
+	}
 }
 
 static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 {
 	struct gh_vm *ghvm;
-	int vmid;
+	int vmid, ret;
 
 	vmid = gh_rm_alloc_vmid(rm, 0);
 	if (vmid < 0)
@@ -55,13 +136,130 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 	ghvm->vmid = vmid;
 	ghvm->rm = rm;
 
+	init_waitqueue_head(&ghvm->vm_status_wait);
+	ghvm->nb.notifier_call = gh_vm_rm_notification;
+	ret = gh_rm_notifier_register(rm, &ghvm->nb);
+	if (ret) {
+		gh_rm_put(rm);
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
+	mutex_lock(&ghvm->mm_lock);
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
+			dev_warn(ghvm->parent, "Failed to %s parcel %d: %d\n",
+				mapping->share_type == VM_MEM_LEND ? "lend" : "share",
+				mapping->parcel.label,
+				ret);
+			goto err;
+		}
+	}
+	mutex_unlock(&ghvm->mm_lock);
+
+	mapping = gh_vm_mem_find_by_addr(ghvm, ghvm->dtb_config.guest_phys_addr,
+					ghvm->dtb_config.size);
+	if (!mapping) {
+		dev_warn(ghvm->parent, "Failed to find the memory_handle for DTB\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	mem_handle = mapping->parcel.mem_handle;
+	dtb_offset = ghvm->dtb_config.guest_phys_addr - mapping->guest_phys_addr;
+
+	ret = gh_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, mem_handle,
+				0, 0, dtb_offset, ghvm->dtb_config.size);
+	if (ret) {
+		dev_warn(ghvm->parent, "Failed to configure VM: %d\n", ret);
+		goto err;
+	}
+
+	ret = gh_rm_vm_init(ghvm->rm, ghvm->vmid);
+	if (ret) {
+		dev_warn(ghvm->parent, "Failed to initialize VM: %d\n", ret);
+		goto err;
+	}
+
+	ret = gh_rm_vm_start(ghvm->rm, ghvm->vmid);
+	if (ret) {
+		dev_warn(ghvm->parent, "Failed to start VM: %d\n", ret);
+		goto err;
+	}
+
+	ghvm->vm_status = GH_RM_VM_STATUS_RUNNING;
+	up_write(&ghvm->status_lock);
+	return ret;
+err:
+	ghvm->vm_status = GH_RM_VM_STATUS_INIT_FAILED;
+	/* gh_vm_free will handle releasing resources and reclaiming memory */
+	up_write(&ghvm->status_lock);
+	return ret;
+}
+
+static int gh_vm_ensure_started(struct gh_vm *ghvm)
+{
+	int ret;
+
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
+		/** gh_vm_start() is guaranteed to bring status out of
+		 * GH_RM_VM_STATUS_LOAD, thus inifitely recursive call is not
+		 * possible
+		 */
+		return gh_vm_ensure_started(ghvm);
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
@@ -85,6 +283,25 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		r = gh_vm_mem_alloc(ghvm, &region);
 		break;
 	}
+	case GH_VM_SET_DTB_CONFIG: {
+		struct gh_vm_dtb_config dtb_config;
+
+		if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
+			return -EFAULT;
+
+		dtb_config.size = PAGE_ALIGN(dtb_config.size);
+		if (dtb_config.guest_phys_addr + dtb_config.size < dtb_config.guest_phys_addr)
+			return -EOVERFLOW;
+
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
index c9f6fa5478ed..26bcc2ae4478 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -10,6 +10,8 @@
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
+#include <linux/wait.h>
 
 #include <uapi/linux/gunyah.h>
 
@@ -34,6 +36,13 @@ struct gh_vm {
 	u16 vmid;
 	struct gh_rm *rm;
 	struct device *parent;
+	enum gh_rm_vm_auth_mechanism auth;
+	struct gh_vm_dtb_config dtb_config;
+
+	struct notifier_block nb;
+	enum gh_rm_vm_status vm_status;
+	wait_queue_head_t vm_status_wait;
+	struct rw_semaphore status_lock;
 
 	struct work_struct free_work;
 	struct mutex mm_lock;
@@ -44,5 +53,6 @@ int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *regio
 void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping);
 int gh_vm_mem_free(struct gh_vm *ghvm, u32 label);
 struct gh_vm_mem *gh_vm_mem_find_by_label(struct gh_vm *ghvm, u32 label);
+struct gh_vm_mem *gh_vm_mem_find_by_addr(struct gh_vm *ghvm, u64 guest_phys_addr, u32 size);
 
 #endif
diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
index db6f55cef37f..6e1d2e8bddb7 100644
--- a/drivers/virt/gunyah/vm_mgr_mm.c
+++ b/drivers/virt/gunyah/vm_mgr_mm.c
@@ -47,6 +47,29 @@ void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping)
 	list_del(&mapping->list);
 }
 
+struct gh_vm_mem *gh_vm_mem_find_by_addr(struct gh_vm *ghvm, u64 guest_phys_addr, u32 size)
+{
+	struct gh_vm_mem *mapping = NULL;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ghvm->mm_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
+	list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
+		if (guest_phys_addr >= mapping->guest_phys_addr &&
+			(guest_phys_addr + size <= mapping->guest_phys_addr +
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
 struct gh_vm_mem *gh_vm_mem_find_by_label(struct gh_vm *ghvm, u32 label)
 {
 	struct gh_vm_mem *mapping;
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 88a429dad09e..8b0b46f28e39 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -29,6 +29,12 @@ struct gh_rm_vm_exited_payload {
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
index a19207e3e065..d6abd8605a2e 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -49,4 +49,17 @@ struct gh_userspace_memory_region {
 #define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
 						struct gh_userspace_memory_region)
 
+/**
+ * struct gh_vm_dtb_config - Set the location of the VM's devicetree blob
+ * @guest_phys_addr: Address of the VM's devicetree in guest memory.
+ * @size: Maximum size of the devicetree.
+ */
+struct gh_vm_dtb_config {
+	__u64 guest_phys_addr;
+	__u64 size;
+};
+#define GH_VM_SET_DTB_CONFIG	_IOW(GH_IOCTL_TYPE, 0x2, struct gh_vm_dtb_config)
+
+#define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
+
 #endif
-- 
2.39.2

