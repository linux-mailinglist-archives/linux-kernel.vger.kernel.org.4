Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EE972E990
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbjFMRXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbjFMRW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:22:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA4D1FC8;
        Tue, 13 Jun 2023 10:22:02 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DAxhWj025649;
        Tue, 13 Jun 2023 17:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=j1WJ1ACZtU3TBr3O7B4TkWADaRm3J6sg79CmXLkh6K4=;
 b=P8uHBCG5tLiNfP8vLVV+LCGeJzlNGtU2N+haARnGX+jgorl++btbxZrES1B5nlRYb06B
 4kl9qmQfcbUxp5QxjQ3H40Flj7FCKeK3AIemqdcRyimHVTRjOFBjUZPpEvvXQfvl7dJI
 QTkaw8tjDGILbAv0DT0pMXVp1tawLRp15YdKaEWXbLTqpPuUxEIjfxLjCIR7iA13Yt+x
 xH6eON1HyjLA60z6z1LxcLOyW2/5odRxaPz48uRd81Gjebo+QnWSYQUC2vpFFiEIeQxq
 ZBgksjFxyJ6L4GQpUVsrQ6hFand04Sv6on9WFVQ/bmSfNYyD/jGYhxerxxa3rQoVtxsA YQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r68x9ae0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DHLbB1004303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:37 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 10:21:36 -0700
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
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v14 12/25] gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
Date:   Tue, 13 Jun 2023 10:20:40 -0700
Message-ID: <20230613172054.3959700-13-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: 8niVjKHBNKRZO9zuhHzATAYyAqSIGf2X
X-Proofpoint-ORIG-GUID: 8niVjKHBNKRZO9zuhHzATAYyAqSIGf2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_19,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130153
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Alex Elder <elder@linaro.org>
Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c    | 215 ++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h    |  11 ++
 drivers/virt/gunyah/vm_mgr_mm.c |  20 +++
 include/uapi/linux/gunyah.h     |  15 +++
 4 files changed, 261 insertions(+)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 297427952b8c7..562ae6ed4a5f1 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -17,6 +17,68 @@
 
 static void gh_vm_free(struct work_struct *work);
 
+static int gh_vm_rm_notification_status(struct gh_vm *ghvm, void *data)
+{
+	struct gh_rm_vm_status_payload *payload = data;
+
+	if (le16_to_cpu(payload->vmid) != ghvm->vmid)
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
+	if (le16_to_cpu(payload->vmid) != ghvm->vmid)
+		return NOTIFY_OK;
+
+	down_write(&ghvm->status_lock);
+	ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
+	up_write(&ghvm->status_lock);
+	wake_up(&ghvm->vm_status_wait);
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
+	up_write(&ghvm->status_lock);
+
+	wait_event(ghvm->vm_status_wait, ghvm->vm_status == GH_RM_VM_STATUS_EXITED);
+}
+
 static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 {
 	struct gh_vm *ghvm;
@@ -26,17 +88,130 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 		return ERR_PTR(-ENOMEM);
 
 	ghvm->parent = gh_rm_get(rm);
+	ghvm->vmid = GH_VMID_INVAL;
 	ghvm->rm = rm;
 
 	mmgrab(current->mm);
 	ghvm->mm = current->mm;
 	mutex_init(&ghvm->mm_lock);
 	INIT_LIST_HEAD(&ghvm->memory_mappings);
+	init_rwsem(&ghvm->status_lock);
+	init_waitqueue_head(&ghvm->vm_status_wait);
 	INIT_WORK(&ghvm->free_work, gh_vm_free);
+	ghvm->vm_status = GH_RM_VM_STATUS_NO_STATE;
 
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
+	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE) {
+		up_write(&ghvm->status_lock);
+		return 0;
+	}
+
+	ghvm->nb.notifier_call = gh_vm_rm_notification;
+	ret = gh_rm_notifier_register(ghvm->rm, &ghvm->nb);
+	if (ret)
+		goto err;
+
+	ret = gh_rm_alloc_vmid(ghvm->rm, 0);
+	if (ret < 0) {
+		gh_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
+		goto err;
+	}
+	ghvm->vmid = ret;
+	ghvm->vm_status = GH_RM_VM_STATUS_LOAD;
+
+	mutex_lock(&ghvm->mm_lock);
+	list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
+		mapping->parcel.acl_entries[0].vmid = cpu_to_le16(ghvm->vmid);
+		ret = gh_rm_mem_share(ghvm->rm, &mapping->parcel);
+		if (ret) {
+			dev_warn(ghvm->parent, "Failed to share parcel %d: %d\n",
+				mapping->parcel.label, ret);
+			mutex_unlock(&ghvm->mm_lock);
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
+		ghvm->vm_status = GH_RM_VM_STATUS_INIT_FAILED;
+		dev_warn(ghvm->parent, "Failed to initialize VM: %d\n", ret);
+		goto err;
+	}
+	ghvm->vm_status = GH_RM_VM_STATUS_READY;
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
+	if (unlikely(ghvm->vm_status == GH_RM_VM_STATUS_NO_STATE)) {
+		up_read(&ghvm->status_lock);
+		ret = gh_vm_start(ghvm);
+		if (ret)
+			return ret;
+		/** gh_vm_start() is guaranteed to bring status out of
+		 * GH_RM_VM_STATUS_LOAD, thus infinitely recursive call is not
+		 * possible
+		 */
+		return gh_vm_ensure_started(ghvm);
+	}
+
+	/* Unlikely because VM is typically running */
+	if (unlikely(ghvm->vm_status != GH_RM_VM_STATUS_RUNNING))
+		ret = -ENODEV;
+
+	up_read(&ghvm->status_lock);
+	return ret;
+}
+
 static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct gh_vm *ghvm = filp->private_data;
@@ -61,6 +236,24 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		r = gh_vm_mem_alloc(ghvm, &region);
 		break;
 	}
+	case GH_VM_SET_DTB_CONFIG: {
+		struct gh_vm_dtb_config dtb_config;
+
+		if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
+			return -EFAULT;
+
+		if (overflows_type(dtb_config.guest_phys_addr + dtb_config.size, u64))
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
@@ -72,8 +265,30 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 static void gh_vm_free(struct work_struct *work)
 {
 	struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
+	int ret;
+
+	if (ghvm->vm_status == GH_RM_VM_STATUS_RUNNING)
+		gh_vm_stop(ghvm);
+
+	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE &&
+	    ghvm->vm_status != GH_RM_VM_STATUS_LOAD &&
+	    ghvm->vm_status != GH_RM_VM_STATUS_RESET) {
+		ret = gh_rm_vm_reset(ghvm->rm, ghvm->vmid);
+		if (ret)
+			dev_err(ghvm->parent, "Failed to reset the vm: %d\n", ret);
+		wait_event(ghvm->vm_status_wait, ghvm->vm_status == GH_RM_VM_STATUS_RESET);
+	}
 
 	gh_vm_mem_reclaim(ghvm);
+
+	if (ghvm->vm_status > GH_RM_VM_STATUS_NO_STATE) {
+		gh_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
+
+		ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
+		if (ret)
+			dev_warn(ghvm->parent, "Failed to deallocate vmid: %d\n", ret);
+	}
+
 	gh_rm_put(ghvm->rm);
 	mmdrop(ghvm->mm);
 	kfree(ghvm);
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 434ef9f662a7a..4173bd51f83fe 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -10,6 +10,8 @@
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
+#include <linux/wait.h>
 
 #include <uapi/linux/gunyah.h>
 
@@ -31,8 +33,16 @@ struct gh_vm_mem {
 };
 
 struct gh_vm {
+	u16 vmid;
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
 	struct mm_struct *mm; /* userspace tied to this vm */
@@ -42,5 +52,6 @@ struct gh_vm {
 
 int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region);
 void gh_vm_mem_reclaim(struct gh_vm *ghvm);
+struct gh_vm_mem *gh_vm_mem_find_by_addr(struct gh_vm *ghvm, u64 guest_phys_addr, u32 size);
 
 #endif
diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
index 6974607f02edd..f8a09e86d6bc1 100644
--- a/drivers/virt/gunyah/vm_mgr_mm.c
+++ b/drivers/virt/gunyah/vm_mgr_mm.c
@@ -75,6 +75,26 @@ void gh_vm_mem_reclaim(struct gh_vm *ghvm)
 	mutex_unlock(&ghvm->mm_lock);
 }
 
+struct gh_vm_mem *gh_vm_mem_find_by_addr(struct gh_vm *ghvm, u64 guest_phys_addr, u32 size)
+{
+	struct gh_vm_mem *mapping;
+
+	if (overflows_type(guest_phys_addr + size, u64))
+		return NULL;
+
+	mutex_lock(&ghvm->mm_lock);
+
+	list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
+		if (gh_vm_mem_overlap(mapping, guest_phys_addr, size))
+			goto unlock;
+	}
+
+	mapping = NULL;
+unlock:
+	mutex_unlock(&ghvm->mm_lock);
+	return mapping;
+}
+
 int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region)
 {
 	struct gh_vm_mem *mapping, *tmp_mapping;
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 91d6dd26fcc89..4b63d0b9b8ba7 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -57,4 +57,19 @@ struct gh_userspace_memory_region {
 #define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
 						struct gh_userspace_memory_region)
 
+/**
+ * struct gh_vm_dtb_config - Set the location of the VM's devicetree blob
+ * @guest_phys_addr: Address of the VM's devicetree in guest memory.
+ * @size: Maximum size of the devicetree including space for overlays.
+ *        Resource manager applies an overlay to the DTB and dtb_size should
+ *        include room for the overlay. A page of memory is typicaly plenty.
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
2.40.0

