Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD360E812
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiJZTBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiJZTAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:00:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C88A11A2C;
        Wed, 26 Oct 2022 11:59:51 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIoirJ007816;
        Wed, 26 Oct 2022 18:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=+d81CWgci1lI7DJgnBOznnn+zOvuWdVdMf8BeHnmsTs=;
 b=AtnEb4XpY5lArWuOkiBwKA55lqSibeqJ3IhovVLZX8AWo4Su7ZtBP+kQ8S25KK7/nmx8
 D2c/PWvARo7fzuUZ5nbeCQTGmvRHHwZO6khG0MFJOGFqZu2+abGpllAR799Wb+Lb1DHc
 r3Kuxgi7k9QoPlRBw3+DXkLra3Dv6MHOv4rvtby6RtjIV4AwgTcogPOPQsKhvRJ2H46K
 Jz5Q4lEesqjNFi9cxP7HMq4pj3eyXchf4Rd9PmAitRc643kzXd5sQE9TZa+IMMfwE+mn
 frDpYqjGLWyKjze9CTKhSF4ZSEwEpmx8xecunq/h8LR0/RHcUE5TnBxlQ5VECpr9L/Ug wg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfaheg0pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:34 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QIxYD7024213
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
Subject: [PATCH v6 12/21] gunyah: rsc_mgr: Add VM lifecycle RPC
Date:   Wed, 26 Oct 2022 11:58:37 -0700
Message-ID: <20221026185846.3983888-13-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: wzEpxKtjGedgK66ML0T6OaTfQIx6Qph2
X-Proofpoint-ORIG-GUID: wzEpxKtjGedgK66ML0T6OaTfQIx6Qph2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210260107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Gunyah Resource Manager RPC to launch an unauthenticated VM.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile      |   2 +-
 drivers/virt/gunyah/rsc_mgr.h     |  55 +++++++
 drivers/virt/gunyah/rsc_mgr_rpc.c | 264 ++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h    |  54 ++++++
 4 files changed, 374 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index a9169af6c61f..09c1bbd28b48 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_GUNYAH) += gunyah.o
 
-gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_bus.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o rsc_mgr_bus.o
 obj-$(CONFIG_GUNYAH_RESORUCE_MANAGER) += gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 129e9d514f2a..247664b8b008 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -28,6 +28,61 @@
 #define GH_RM_ERROR_IRQ_INUSE		0x10
 #define GH_RM_ERROR_IRQ_RELEASED	0x11
 
+/* Message IDs: VM Management */
+#define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
+#define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
+#define GH_RM_RPC_VM_START			0x56000004
+#define GH_RM_RPC_VM_STOP			0x56000005
+#define GH_RM_RPC_VM_CONFIG_IMAGE		0x56000009
+#define GH_RM_RPC_VM_INIT			0x5600000B
+#define GH_RM_RPC_VM_GET_HYP_RESOURCES		0x56000020
+#define GH_RM_RPC_VM_GET_VMID			0x56000024
+#define GH_RM_RPC_VM_SET_BOOT_CONTEXT		0x56000031
+
+/* Call: CONSOLE_OPEN, CONSOLE_CLOSE, CONSOLE_FLUSH */
+struct gh_vm_common_vmid_req {
+	u16 vmid;
+	u16 reserved0;
+} __packed;
+
+/* Call: VM_STOP */
+struct gh_vm_stop_req {
+	u16 vmid;
+	u8 flags;
+	u8 reserved;
+	u32 stop_reason;
+} __packed;
+
+/* Call: VM_CONFIG_IMAGE */
+struct gh_vm_config_image_req {
+	u16 vmid;
+	u16 auth_mech;
+	u32 mem_handle;
+	u32 image_offset_low;
+	u32 image_offset_high;
+	u32 image_size_low;
+	u32 image_size_high;
+	u32 dtb_offset_low;
+	u32 dtb_offset_high;
+	u32 dtb_size_low;
+	u32 dtb_size_high;
+} __packed;
+
+/* Call: GET_HYP_RESOURCES */
+struct gh_vm_get_hyp_resources_resp {
+	u32 n_entries;
+	struct gh_rm_hyp_resource entries[];
+} __packed;
+
+/* Call: SET_BOOT_CONTEXT */
+struct gh_vm_set_boot_context_req {
+	u16 vmid;
+	u8 reg_set;
+	u8 reg_idx;
+	u32 val_low;
+	u32 val_high;
+} __packed;
+
 int gh_rm_call(u32 message_id, void *req_buff, size_t req_buff_size,
 		void **resp_buf, size_t *resp_buff_size);
 
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
new file mode 100644
index 000000000000..33d27690c16e
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gh_rsc_mgr: " fmt
+
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/printk.h>
+#include <linux/gunyah_rsc_mgr.h>
+
+#include "rsc_mgr.h"
+
+/*
+ * Several RM calls take only a VMID as a parameter and give only standard
+ * response back. Deduplicate boilerplate code by using this common call.
+ */
+static int gh_rm_common_vmid_call(u32 message_id, u16 vmid)
+{
+	void *resp = NULL;
+	struct gh_vm_common_vmid_req req_payload = {
+		.vmid = vmid,
+	};
+	size_t resp_size;
+	int ret;
+
+	ret = gh_rm_call(message_id, &req_payload, sizeof(req_payload), &resp, &resp_size);
+	if (!ret)
+		kfree(resp);
+
+	WARN_ON(!ret && resp_size);
+
+	return ret;
+}
+
+/**
+ * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
+ * @vmid: Use GH_VMID_INVAL to dynamically allocate a VM. A reserved VMID can also be requested
+ *        for a special-purpose platform-defined VM.
+ *
+ * Returns - the allocated VMID or negative value on error
+ */
+int gh_rm_alloc_vmid(u16 vmid)
+{
+	void *resp;
+	struct gh_vm_common_vmid_req req_payload = {
+		.vmid = vmid,
+	};
+	struct gh_vm_common_vmid_req *resp_payload;
+	size_t resp_size;
+	int ret;
+
+	if (vmid == GH_VMID_INVAL)
+		vmid = 0;
+
+	ret = gh_rm_call(GH_RM_RPC_VM_ALLOC_VMID, &req_payload, sizeof(req_payload), &resp,
+			&resp_size);
+	if (ret)
+		return ret;
+
+	if (!vmid) {
+		if (resp_size != sizeof(*resp_payload)) {
+			pr_warn("Incorrect response size for ALLOC_VMID: %lu\n", resp_size);
+			ret = -EINVAL;
+		} else {
+			resp_payload = resp;
+			ret = resp_payload->vmid;
+		}
+	} else if (resp_size) {
+		pr_warn("Received unexpected payload for ALLOC_VMID: %lu\n", resp_size);
+	}
+	kfree(resp);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_alloc_vmid);
+
+/**
+ * gh_rm_dealloc_vmid() - Dispose the VMID
+ * @vmid: VM identifier
+ */
+int gh_rm_dealloc_vmid(u16 vmid)
+{
+	return gh_rm_common_vmid_call(GH_RM_RPC_VM_DEALLOC_VMID, vmid);
+}
+EXPORT_SYMBOL_GPL(gh_rm_dealloc_vmid);
+
+/**
+ * gh_rm_vm_start() - Move the VM into "ready to run" state
+ * @vmid: VM identifier
+ *
+ * On VMs which use proxy scheduling, vcpu_run is needed to actually run the VM.
+ * On VMs which use Gunyah's scheduling, the vCPUs start executing in accordance with Gunyah
+ * scheduling policies.
+ */
+int gh_rm_vm_start(u16 vmid)
+{
+	return gh_rm_common_vmid_call(GH_RM_RPC_VM_START, vmid);
+}
+EXPORT_SYMBOL_GPL(gh_rm_vm_start);
+
+/**
+ * gh_rm_vm_stop() - Send a request to Resource Manager VM to stop a VM.
+ * @vmid: VM identifier
+ */
+int gh_rm_vm_stop(u16 vmid)
+{
+	struct gh_vm_stop_req req_payload = { 0 };
+	void *resp;
+	size_t resp_size;
+	int ret;
+
+	req_payload.vmid = vmid;
+
+	ret = gh_rm_call(GH_RM_RPC_VM_STOP, &req_payload, sizeof(req_payload), &resp, &resp_size);
+	if (ret)
+		return ret;
+	kfree(resp);
+
+	if (resp_size)
+		pr_warn("Received unexpected payload for VM_STOP: %lu\n", resp_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_vm_stop);
+
+int gh_rm_vm_configure(u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism, u32 mem_handle,
+			u64 image_offset, u64 image_size, u64 dtb_offset, u64 dtb_size)
+{
+	struct gh_vm_config_image_req req_payload = { 0 };
+	void *resp;
+	size_t resp_size;
+	int ret;
+
+	req_payload.vmid = vmid;
+	req_payload.auth_mech = auth_mechanism;
+	req_payload.mem_handle = mem_handle;
+	req_payload.image_offset_low = image_offset;
+	req_payload.image_offset_high = image_offset >> 32;
+	req_payload.image_size_low = image_size;
+	req_payload.image_size_high = image_size >> 32;
+	req_payload.dtb_offset_low = dtb_offset;
+	req_payload.dtb_offset_high = dtb_offset >> 32;
+	req_payload.dtb_size_low = dtb_size;
+	req_payload.dtb_size_high = dtb_size >> 32;
+
+	ret = gh_rm_call(GH_RM_RPC_VM_CONFIG_IMAGE, &req_payload, sizeof(req_payload),
+			&resp, &resp_size);
+	if (ret)
+		return ret;
+	kfree(resp);
+
+	if (resp_size)
+		pr_warn("Received unexpected payload for VM_CONFIG_IMAGE: %lu\n", resp_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_vm_configure);
+
+/**
+ * gh_rm_vm_init() - Move the VM to initialized state.
+ * @vmid: VM identifier
+ *
+ * RM will allocate needed resources for the VM. After gh_rm_vm_init, gh_rm_get_hyp_resources()
+ * can be called to learn of the capabilities we can use with the new VM.
+ */
+int gh_rm_vm_init(u16 vmid)
+{
+	return gh_rm_common_vmid_call(GH_RM_RPC_VM_INIT, vmid);
+}
+EXPORT_SYMBOL_GPL(gh_rm_vm_init);
+
+/**
+ * gh_rm_get_hyp_resources() - Retrieve hypervisor resources (capabilities) associated with a VM
+ * @vmid: VMID of the other VM to get the resources of
+ * @resources: Set by gh_rm_get_hyp_resources and contains the returned hypervisor resources.
+ *
+ * Return: >=0 value indicates the number of gh_rm_hyp_resource entries filled into *resources
+ */
+ssize_t gh_rm_get_hyp_resources(u16 vmid, struct gh_rm_hyp_resource **resources)
+{
+	struct gh_vm_get_hyp_resources_resp *resp;
+	size_t resp_size;
+	int ret;
+	struct gh_vm_common_vmid_req req_payload = {0};
+
+	req_payload.vmid = vmid;
+
+	ret = gh_rm_call(GH_RM_RPC_VM_GET_HYP_RESOURCES,
+			 &req_payload, sizeof(req_payload),
+			 (void **)&resp, &resp_size);
+	if (ret)
+		return ret;
+
+	if (resp_size < sizeof(*resp) ||
+		(sizeof(*resp->entries) && (resp->n_entries > U32_MAX / sizeof(*resp->entries))) ||
+		(resp_size != sizeof(*resp) + (resp->n_entries * sizeof(*resp->entries)))) {
+		ret = -EIO;
+		goto out;
+	}
+
+	*resources = kmemdup(resp->entries, (resp->n_entries * sizeof(*resp->entries)), GFP_KERNEL);
+	ret = resp->n_entries;
+
+out:
+	kfree(resp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_get_hyp_resources);
+
+/**
+ * gh_rm_get_vmid() - Retrieve VMID of this virtual machine
+ * @vmid: Filled with the VMID of this VM
+ */
+int gh_rm_get_vmid(u16 *vmid)
+{
+	void *resp;
+	size_t resp_size;
+	int ret;
+	int payload = 0;
+
+	ret = gh_rm_call(GH_RM_RPC_VM_GET_VMID, &payload, sizeof(payload), &resp, &resp_size);
+	if (ret)
+		return ret;
+
+	if (resp_size != sizeof(*vmid))
+		return -EIO;
+	*vmid = *(u16 *)resp;
+	kfree(resp);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_get_vmid);
+
+/**
+ * gh_rm_set_boot_context() - Set boot context of a VM
+ * @vmid: VM identifier
+ * @reg_set: Register Set
+ * @reg_idx: Index into the register set
+ * @value: Updated register value
+ */
+int gh_rm_set_boot_context(u16 vmid, u8 reg_set, u8 reg_idx, u64 value)
+{
+	struct gh_vm_set_boot_context_req req = { 0 };
+	int ret;
+	size_t resp_size;
+	void *resp;
+
+	req.vmid = vmid;
+	req.reg_set = reg_set;
+	req.reg_idx = reg_idx;
+	req.val_low = (value & 0xFFFFFFFF);
+	req.val_high = ((value >> 32) & 0xFFFFFFFF);
+
+	ret = gh_rm_call(GH_RM_RPC_VM_SET_BOOT_CONTEXT, &req, sizeof(req), &resp, &resp_size);
+	kfree(resp);
+
+	if (!ret && resp_size)
+		pr_warn("Received unexpected payload for SET_BOOT_CONTEXT: %lu\n", resp_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_set_boot_context);
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 0eeb7202fa33..169497f894c8 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -25,6 +25,60 @@ struct gh_rm_notification {
 int gh_rm_register_notifier(struct notifier_block *nb);
 int gh_rm_unregister_notifier(struct notifier_block *nb);
 
+enum gh_rm_vm_status {
+	GH_RM_VM_STATUS_NO_STATE	= 0,
+	GH_RM_VM_STATUS_INIT		= 1,
+	GH_RM_VM_STATUS_READY		= 2,
+	GH_RM_VM_STATUS_RUNNING		= 3,
+	GH_RM_VM_STATUS_PAUSED		= 4,
+	GH_RM_VM_STATUS_LOAD		= 5,
+	GH_RM_VM_STATUS_AUTH		= 6,
+	GH_RM_VM_STATUS_INIT_FAILED	= 8,
+	GH_RM_VM_STATUS_EXITED		= 9,
+	GH_RM_VM_STATUS_RESETTING	= 10,
+	GH_RM_VM_STATUS_RESET		= 11,
+};
+
+/* RPC Calls */
+int gh_rm_alloc_vmid(u16 vmid);
+int gh_rm_dealloc_vmid(u16 vmid);
+int gh_rm_vm_start(u16 vmid);
+int gh_rm_vm_stop(u16 vmid);
+
+enum gh_rm_vm_auth_mechanism {
+	GH_RM_VM_AUTH_NONE		= 0,
+	GH_RM_VM_AUTH_QCOM_PIL_ELF	= 1,
+	GH_RM_VM_AUTH_QCOM_ANDROID_PVM	= 2,
+};
+
+int gh_rm_vm_configure(u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism, u32 mem_handle,
+			u64 image_offset, u64 image_size, u64 dtb_offset, u64 dtb_size);
+int gh_rm_vm_init(u16 vmid);
+
+struct gh_rm_hyp_resource {
+	u8 type;
+	u8 reserved;
+	u16 partner_vmid;
+	u32 resource_handle;
+	u32 resource_label;
+	u32 cap_id_low;
+	u32 cap_id_high;
+	u32 virq_handle;
+	u32 virq;
+	u32 base_low;
+	u32 base_high;
+	u32 size_low;
+	u32 size_high;
+} __packed;
+
+ssize_t gh_rm_get_hyp_resources(u16 vmid, struct gh_rm_hyp_resource **resources);
+int gh_rm_get_vmid(u16 *vmid);
+
+#define GH_RM_BOOT_CONTEXT_REG_SET_REGISTERS	0
+#define GH_RM_BOOT_CONTEXT_REG_SET_PC		1
+#define GH_RM_BOOT_CONTEXT_REG_SET_SP_ELx	2
+int gh_rm_set_boot_context(u16 vmid, u8 reg_set, u8 reg_idx, u64 value);
+
 #define GH_RM_DEVICE_VM_MGR		"vm_mgr"
 
 struct gh_rm_driver {
-- 
2.25.1

