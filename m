Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948BE65168F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiLSXFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiLSXD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:03:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6DB167EB;
        Mon, 19 Dec 2022 15:01:09 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJLeWIM004662;
        Mon, 19 Dec 2022 23:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=iM6Z2a66baf9HuM6ahtcBTVvtSZtXdH56kj6YoRcGMc=;
 b=BXnFXDniKglyulQ9wM6bzpf2x/PPzBr4dWzCXJwPZka4RRqlw8I8Ubpa+0NN0S+8zKLA
 YU77H9I6o7CEMnJ2o75zlu2HvAZORUlCTwC3jB01rzAqgTKk9mvG49VtSje8VHAmRL6g
 /906MaSp+MgQ3dTuh3mX3Q6RUNlaGr9DD2+7GXzqPRhC76T0f4rFRCwi8nXnjYf8LcbO
 +RCmUnZ5AM4ww/Qn9WzJEiULR11mJ8jollyU7xPkjlRgCjWlV9+FHK5fIOU1rui5SRpR
 Y5LuTbNPKu2IdnDjo/8Tp85Ih87rDEe7YFK1g1nENr7p45FwpcZxAuWSBQdfKnHK9QNC /Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh5c7wh36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0U12030731
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:30 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:29 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
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
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 11/28] gunyah: rsc_mgr: Add VM lifecycle RPC
Date:   Mon, 19 Dec 2022 14:58:32 -0800
Message-ID: <20221219225850.2397345-12-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: 1Pk9qp5ju-KRNr2axxztKt_T8xRwHN_w
X-Proofpoint-ORIG-GUID: 1Pk9qp5ju-KRNr2axxztKt_T8xRwHN_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Gunyah Resource Manager RPC to launch an unauthenticated VM.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile      |   2 +-
 drivers/virt/gunyah/rsc_mgr.h     |  41 ++++++
 drivers/virt/gunyah/rsc_mgr_rpc.c | 224 ++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h    |  50 +++++++
 4 files changed, 316 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index e7cf59b9e64e..5caa05267a58 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_GUNYAH) += gunyah.o
 
-gunyah_rsc_mgr-y += rsc_mgr.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
 obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER) += gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index b5bb36a7a4cc..1f9e3c38038e 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -33,4 +33,45 @@ struct gh_rm_rpc;
 int gh_rm_call(struct gh_rm_rpc *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
 		void **resp_buf, size_t *resp_buff_size);
 
+/* Message IDs: VM Management */
+#define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
+#define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
+#define GH_RM_RPC_VM_START			0x56000004
+#define GH_RM_RPC_VM_STOP			0x56000005
+#define GH_RM_RPC_VM_CONFIG_IMAGE		0x56000009
+#define GH_RM_RPC_VM_INIT			0x5600000B
+#define GH_RM_RPC_VM_GET_HYP_RESOURCES		0x56000020
+#define GH_RM_RPC_VM_GET_VMID			0x56000024
+
+/* Call: CONSOLE_OPEN, CONSOLE_CLOSE, CONSOLE_FLUSH */
+struct gh_vm_common_vmid_req {
+	__le16 vmid;
+	__le16 reserved0;
+} __packed;
+
+/* Call: VM_STOP */
+struct gh_vm_stop_req {
+	__le16 vmid;
+	u8 flags;
+	u8 reserved;
+	__le32 stop_reason;
+} __packed;
+
+/* Call: VM_CONFIG_IMAGE */
+struct gh_vm_config_image_req {
+	__le16 vmid;
+	__le16 auth_mech;
+	__le32 mem_handle;
+	__le64 image_offset;
+	__le64 image_size;
+	__le64 dtb_offset;
+	__le64 dtb_size;
+} __packed;
+
+/* Call: GET_HYP_RESOURCES */
+struct gh_vm_get_hyp_resources_resp {
+	__le32 n_entries;
+	struct gh_rm_hyp_resource entries[];
+} __packed;
+
 #endif
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
new file mode 100644
index 000000000000..8d9c1c635a27
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/gunyah_rsc_mgr.h>
+
+#include "rsc_mgr.h"
+
+/*
+ * Several RM calls take only a VMID as a parameter and give only standard
+ * response back. Deduplicate boilerplate code by using this common call.
+ */
+static int gh_rm_common_vmid_call(struct gh_rm_rpc *rm, u32 message_id, u16 vmid)
+{
+	void *resp = NULL;
+	struct gh_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+	size_t resp_size;
+	int ret;
+
+	ret = gh_rm_call(rm, message_id, &req_payload, sizeof(req_payload), &resp, &resp_size);
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
+int gh_rm_alloc_vmid(struct gh_rm_rpc *rm, u16 vmid)
+{
+	void *resp;
+	struct gh_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+	struct gh_vm_common_vmid_req *resp_payload;
+	size_t resp_size;
+	int ret;
+
+	if (vmid == GH_VMID_INVAL)
+		vmid = 0;
+
+	ret = gh_rm_call(rm, GH_RM_RPC_VM_ALLOC_VMID, &req_payload, sizeof(req_payload), &resp,
+			&resp_size);
+	if (ret)
+		return ret;
+
+	if (!vmid) {
+		if (resp_size != sizeof(*resp_payload)) {
+			ret = -EINVAL;
+		} else {
+			resp_payload = resp;
+			ret = resp_payload->vmid;
+		}
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
+int gh_rm_dealloc_vmid(struct gh_rm_rpc *rm, u16 vmid)
+{
+	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_DEALLOC_VMID, vmid);
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
+int gh_rm_vm_start(struct gh_rm_rpc *rm, u16 vmid)
+{
+	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_START, vmid);
+}
+EXPORT_SYMBOL_GPL(gh_rm_vm_start);
+
+/**
+ * gh_rm_vm_stop() - Send a request to Resource Manager VM to stop a VM.
+ * @vmid: VM identifier
+ */
+int gh_rm_vm_stop(struct gh_rm_rpc *rm, u16 vmid)
+{
+	struct gh_vm_stop_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+	void *resp;
+	size_t resp_size;
+	int ret;
+
+	ret = gh_rm_call(rm, GH_RM_RPC_VM_STOP, &req_payload, sizeof(req_payload),
+			&resp, &resp_size);
+	if (ret)
+		return ret;
+	kfree(resp);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_vm_stop);
+
+int gh_rm_vm_configure(struct gh_rm_rpc *rm, u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism,
+		u32 mem_handle, u64 image_offset, u64 image_size, u64 dtb_offset, u64 dtb_size)
+{
+	struct gh_vm_config_image_req req_payload = { 0 };
+	void *resp;
+	size_t resp_size;
+	int ret;
+
+	req_payload.vmid = cpu_to_le16(vmid);
+	req_payload.auth_mech = cpu_to_le32(auth_mechanism);
+	req_payload.mem_handle = cpu_to_le32(mem_handle);
+	req_payload.image_offset = cpu_to_le64(image_offset);
+	req_payload.image_size = cpu_to_le64(image_size);
+	req_payload.dtb_offset = cpu_to_le64(dtb_offset);
+	req_payload.dtb_size = cpu_to_le64(dtb_size);
+
+	ret = gh_rm_call(rm, GH_RM_RPC_VM_CONFIG_IMAGE, &req_payload, sizeof(req_payload),
+			&resp, &resp_size);
+	if (ret)
+		return ret;
+	kfree(resp);
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
+int gh_rm_vm_init(struct gh_rm_rpc *rm, u16 vmid)
+{
+	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_INIT, vmid);
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
+ssize_t gh_rm_get_hyp_resources(struct gh_rm_rpc *rm, u16 vmid,
+				struct gh_rm_hyp_resource **resources)
+{
+	struct gh_vm_get_hyp_resources_resp *resp;
+	size_t resp_size;
+	int ret;
+	struct gh_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+
+	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_HYP_RESOURCES,
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
+int gh_rm_get_vmid(struct gh_rm_rpc *rm, u16 *vmid)
+{
+	static u16 cached_vmid = GH_VMID_INVAL;
+	void *resp;
+	size_t resp_size;
+	int ret;
+	int payload = 0;
+
+	if (cached_vmid != GH_VMID_INVAL) {
+		*vmid = cached_vmid;
+		return 0;
+	}
+
+	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_VMID, &payload, sizeof(payload), &resp, &resp_size);
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
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index b4f55c19954b..eb94b48c41de 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -15,4 +15,54 @@
 /* Gunyah recognizes VMID0 as an alias to the current VM's ID */
 #define GH_VMID_SELF			0
 
+struct gh_rm_rpc;
+
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
+int gh_rm_alloc_vmid(struct gh_rm_rpc *rm, u16 vmid);
+int gh_rm_dealloc_vmid(struct gh_rm_rpc *rm, u16 vmid);
+int gh_rm_vm_start(struct gh_rm_rpc *rm, u16 vmid);
+int gh_rm_vm_stop(struct gh_rm_rpc *rm, u16 vmid);
+
+enum gh_rm_vm_auth_mechanism {
+	GH_RM_VM_AUTH_NONE		= 0,
+	GH_RM_VM_AUTH_QCOM_PIL_ELF	= 1,
+	GH_RM_VM_AUTH_QCOM_ANDROID_PVM	= 2,
+};
+
+int gh_rm_vm_configure(struct gh_rm_rpc *rm, u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism,
+			u32 mem_handle, u64 image_offset, u64 image_size,
+			u64 dtb_offset, u64 dtb_size);
+int gh_rm_vm_init(struct gh_rm_rpc *rm, u16 vmid);
+
+struct gh_rm_hyp_resource {
+	u8 type;
+	u8 reserved;
+	__le16 partner_vmid;
+	__le32 resource_handle;
+	__le32 resource_label;
+	__le64 cap_id;
+	__le32 virq_handle;
+	__le32 virq;
+	__le64 base;
+	__le64 size;
+} __packed;
+
+ssize_t gh_rm_get_hyp_resources(struct gh_rm_rpc *rm, u16 vmid,
+				struct gh_rm_hyp_resource **resources);
+int gh_rm_get_vmid(struct gh_rm_rpc *rm, u16 *vmid);
+
 #endif
-- 
2.25.1

