Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C800676090
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjATWs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjATWsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:48:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703616C110;
        Fri, 20 Jan 2023 14:48:10 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMj7Pg012734;
        Fri, 20 Jan 2023 22:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=buRBYdqqq4lVajfjuXfcbraNXLbcL/HEObILLeW8jNE=;
 b=BNXJaDSRbyLUbMnVf3ijSCx4jf9qlw2e4H0u/SrecA83gvrGmFAC09ag/N5Gyj0ZGtyW
 QZAMPzxNGMJrjZHXxqSYFXMWXeHatqyNPPm3dcII0L7dLvuIbDozKhW2fY9g1yrCPxHR
 1Wf0jERLamAne+00Gkj3HrwVoYsL5qW/hpp74SLZ19/4Dys9jfa1iEdm8AKj4JxYZh6B
 DztMt8sg5l5TsSlH5UXWikueFLpRvmzLscDF8pDqN/o9VITuX+8nUz/wWXd7Od0vSBP6
 3eFYERgo435JapcxXMOkDYU+HXv3ySYzNpJXO4Lszh7fCWDHR6ikZkjTHcHEU9lk83Oi lg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7xm40k8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:45 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMliFq027210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:44 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:47:43 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v9 10/27] gunyah: rsc_mgr: Add VM lifecycle RPC
Date:   Fri, 20 Jan 2023 14:46:09 -0800
Message-ID: <20230120224627.4053418-11-quic_eberman@quicinc.com>
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
X-Proofpoint-ORIG-GUID: JS1-phWs0Rucq5eQG4DjwRxi-Ob3IDt4
X-Proofpoint-GUID: JS1-phWs0Rucq5eQG4DjwRxi-Ob3IDt4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200218
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
 drivers/virt/gunyah/rsc_mgr.h     |  36 +++++
 drivers/virt/gunyah/rsc_mgr_rpc.c | 238 ++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h    |  55 +++++++
 4 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index cc864ff5abbb..de29769f2f3f 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -2,5 +2,5 @@
 
 obj-$(CONFIG_GUNYAH) += gunyah.o
 
-gunyah_rsc_mgr-y += rsc_mgr.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
 obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 824749e63a54..2f12f31a2ea6 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -68,4 +68,40 @@ struct gh_rm;
 int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
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
+struct gh_vm_common_vmid_req {
+	__le16 vmid;
+	__le16 reserved0;
+} __packed;
+
+/* Call: VM_STOP */
+struct gh_vm_stop_req {
+	__le16 vmid;
+	u8 flags; /* currently not used */
+	u8 reserved;
+	__le32 stop_reason; /* currently not used */
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
+
 #endif
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
new file mode 100644
index 000000000000..b6935dfac1fe
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
+static int gh_rm_common_vmid_call(struct gh_rm *rm, u32 message_id, u16 vmid)
+{
+	void *resp;
+	struct gh_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+	size_t resp_size;
+	int ret;
+
+	ret = gh_rm_call(rm, message_id, &req_payload, sizeof(req_payload), &resp, &resp_size);
+	if (!ret && resp_size) {
+		pr_warn("Unexpected payload size: %ld Expected: 0", resp_size);
+		dump_stack();
+		kfree(resp);
+		return -EBADMSG;
+	}
+
+	return ret;
+}
+
+/**
+ * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
+ * @vmid: Use GH_VMID_INVAL or GH_VMID_SELF (0) to dynamically allocate a VM. A reserved VMID can
+ *        be supplied to request allocation of a platform-defined VM.
+ *
+ * Returns - the allocated VMID or negative value on error
+ */
+int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid)
+{
+	void *resp;
+	struct gh_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+	struct gh_vm_alloc_vmid_resp *resp_payload;
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
+			pr_warn("%s: unexpected payload size: %ld Expected: %ld", __func__,
+				resp_size, sizeof(*resp_payload));
+			ret = -EBADMSG;
+		} else {
+			resp_payload = resp;
+			ret = le16_to_cpu(resp_payload->vmid);
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
+int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid)
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
+int gh_rm_vm_start(struct gh_rm *rm, u16 vmid)
+{
+	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_START, vmid);
+}
+EXPORT_SYMBOL_GPL(gh_rm_vm_start);
+
+/**
+ * gh_rm_vm_stop() - Send a request to Resource Manager VM to stop a VM.
+ * @vmid: VM identifier
+ *
+ * Returns - 0 on success; negative value on failure
+ */
+int gh_rm_vm_stop(struct gh_rm *rm, u16 vmid)
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
+	if (!ret && resp_size) {
+		pr_warn("%s: unexpected payload size: %ld Expected: 0", __func__, resp_size);
+		kfree(resp);
+		return -EBADMSG;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_vm_stop);
+
+int gh_rm_vm_configure(struct gh_rm *rm, u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism,
+		u32 mem_handle, u64 image_offset, u64 image_size, u64 dtb_offset, u64 dtb_size)
+{
+	struct gh_vm_config_image_req req_payload = { 0 };
+	void *resp;
+	size_t resp_size;
+	int ret;
+
+	req_payload.vmid = cpu_to_le16(vmid);
+	req_payload.auth_mech = cpu_to_le16(auth_mechanism);
+	req_payload.mem_handle = cpu_to_le32(mem_handle);
+	req_payload.image_offset = cpu_to_le64(image_offset);
+	req_payload.image_size = cpu_to_le64(image_size);
+	req_payload.dtb_offset = cpu_to_le64(dtb_offset);
+	req_payload.dtb_size = cpu_to_le64(dtb_size);
+
+	ret = gh_rm_call(rm, GH_RM_RPC_VM_CONFIG_IMAGE, &req_payload, sizeof(req_payload),
+			&resp, &resp_size);
+	if (!ret && resp_size) {
+		pr_warn("%s: unexpected payload size: %ld Expected: 0", __func__, resp_size);
+		kfree(resp);
+		return -EBADMSG;
+	}
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
+ *
+ * Returns - 0 on success; negative value on failure
+ */
+int gh_rm_vm_init(struct gh_rm *rm, u16 vmid)
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
+ * Returns - 0 on success; negative value on failure
+ */
+int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
+				struct gh_rm_hyp_resources **resources)
+{
+	struct gh_rm_hyp_resources *resp;
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
+	if (!resp_size)
+		return -EBADMSG;
+
+	if (resp_size < struct_size(resp, entries, 0) ||
+		resp_size != struct_size(resp, entries, le32_to_cpu(resp->n_entries))) {
+		kfree(resp);
+		return -EBADMSG;
+	}
+
+	*resources = resp;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gh_rm_get_hyp_resources);
+
+/**
+ * gh_rm_get_vmid() - Retrieve VMID of this virtual machine
+ * @vmid: Filled with the VMID of this VM
+ */
+int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid)
+{
+	static u16 cached_vmid = GH_VMID_INVAL;
+	__le16 *resp;
+	size_t resp_size;
+	int ret;
+
+	if (cached_vmid != GH_VMID_INVAL) {
+		*vmid = cached_vmid;
+		return 0;
+	}
+
+	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_VMID, NULL, 0, (void **)&resp, &resp_size);
+	if (ret)
+		return ret;
+
+	if (resp_size != sizeof(*resp)) {
+		pr_warn("%s: unexpected payload size: %ld Expected: %ld", __func__,
+			resp_size, sizeof(*resp));
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	*vmid = cached_vmid = le16_to_cpu(*resp);
+out:
+	kfree(resp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_get_vmid);
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 959787ad0a3d..be0bce5507b1 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -15,4 +15,59 @@
 /* Gunyah recognizes VMID0 as an alias to the current VM's ID */
 #define GH_VMID_SELF			0
 
+struct gh_rm;
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
+int gh_rm_vm_configure(struct gh_rm *rm, u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism,
+			u32 mem_handle, u64 image_offset, u64 image_size,
+			u64 dtb_offset, u64 dtb_size);
+int gh_rm_vm_init(struct gh_rm *rm, u16 vmid);
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
+struct gh_rm_hyp_resources {
+	__le32 n_entries;
+	struct gh_rm_hyp_resource entries[];
+} __packed;
+
+int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
+				struct gh_rm_hyp_resources **resources);
+int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
+
 #endif
-- 
2.39.0

