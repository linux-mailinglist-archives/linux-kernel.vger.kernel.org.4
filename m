Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2476AA701
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 02:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCDBIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 20:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCDBH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 20:07:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ED365054;
        Fri,  3 Mar 2023 17:07:10 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323MXBj2013044;
        Sat, 4 Mar 2023 01:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=JlyHqXP7Soq3BVBkMamSVK9ujf73myqb4KE+XUy1blU=;
 b=crhKsJznVTFjHCT2VrtO0DCDFRxWf09Ra70xdA5b48qlWbmkG14JJ1NXTeYzTliyGDc4
 6rLICaEIDhW+07in3jznrL75rGnxXS2MOAZBgeBvHp/GBO2pBFGu/ow/0iornqdQsblg
 3se9Hvzyyr7yTBVMSpygcR/4xi6I3SdgNaQPClvqbmfUPetKS5YQ+bZ0SKxpJWgmI4Jc
 HQduplzZQiDJE7po6FvBMfLGU27eP7miTuKDHNcyxntu6cWNUnrsjyWXYOm7LQg9Z67a
 11pOgie64KXW0vjZmz+rdFTX4h+GrviTSDk1lgTz7gdBVe5Chz43UdwDe51EFrj3erJ0 qg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3ph4rpdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Mar 2023 01:06:58 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32416vTp031701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 4 Mar 2023 01:06:57 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 3 Mar 2023 17:06:56 -0800
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
Subject: [PATCH v11 09/26] gunyah: rsc_mgr: Add VM lifecycle RPC
Date:   Fri, 3 Mar 2023 17:06:15 -0800
Message-ID: <20230304010632.2127470-10-quic_eberman@quicinc.com>
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
X-Proofpoint-ORIG-GUID: BhzwMmc3EXhrPh6P32A8rJDh1iAv9dCF
X-Proofpoint-GUID: BhzwMmc3EXhrPh6P32A8rJDh1iAv9dCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_07,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303040004
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
 drivers/virt/gunyah/rsc_mgr_rpc.c | 260 ++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h    |  73 +++++++++
 3 files changed, 334 insertions(+), 1 deletion(-)
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
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
new file mode 100644
index 000000000000..ffcb861a31b5
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/gunyah_rsc_mgr.h>
+#include "rsc_mgr.h"
+
+/* Message IDs: VM Management */
+#define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
+#define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
+#define GH_RM_RPC_VM_START			0x56000004
+#define GH_RM_RPC_VM_STOP			0x56000005
+#define GH_RM_RPC_VM_RESET			0x56000006
+#define GH_RM_RPC_VM_CONFIG_IMAGE		0x56000009
+#define GH_RM_RPC_VM_INIT			0x5600000B
+#define GH_RM_RPC_VM_GET_HYP_RESOURCES		0x56000020
+#define GH_RM_RPC_VM_GET_VMID			0x56000024
+
+struct gh_rm_vm_common_vmid_req {
+	__le16 vmid;
+	__le16 _padding;
+} __packed;
+
+/* Call: VM_ALLOC */
+struct gh_rm_vm_alloc_vmid_resp {
+	__le16 vmid;
+	__le16 _padding;
+} __packed;
+
+/* Call: VM_STOP */
+#define GH_RM_VM_STOP_FLAG_FORCE_STOP	BIT(0)
+
+#define GH_RM_VM_STOP_REASON_FORCE_STOP		3
+
+struct gh_rm_vm_stop_req {
+	__le16 vmid;
+	u8 flags;
+	u8 _padding;
+	__le32 stop_reason;
+} __packed;
+
+/* Call: VM_CONFIG_IMAGE */
+struct gh_rm_vm_config_image_req {
+	__le16 vmid;
+	__le16 auth_mech;
+	__le32 mem_handle;
+	__le64 image_offset;
+	__le64 image_size;
+	__le64 dtb_offset;
+	__le64 dtb_size;
+} __packed;
+
+/*
+ * Several RM calls take only a VMID as a parameter and give only standard
+ * response back. Deduplicate boilerplate code by using this common call.
+ */
+static int gh_rm_common_vmid_call(struct gh_rm *rm, u32 message_id, u16 vmid)
+{
+	struct gh_rm_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+
+	return gh_rm_call(rm, message_id, &req_payload, sizeof(req_payload), NULL, NULL);
+}
+
+/**
+ * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: Use 0 to dynamically allocate a VM. A reserved VMID can be supplied
+ *        to request allocation of a platform-defined VM.
+ *
+ * Returns - the allocated VMID or negative value on error
+ */
+int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid)
+{
+	struct gh_rm_vm_common_vmid_req req_payload = {
+		.vmid = vmid,
+	};
+	struct gh_rm_vm_alloc_vmid_resp *resp_payload;
+	size_t resp_size;
+	void *resp;
+	int ret;
+
+	ret = gh_rm_call(rm, GH_RM_RPC_VM_ALLOC_VMID, &req_payload, sizeof(req_payload), &resp,
+			&resp_size);
+	if (ret)
+		return ret;
+
+	if (!vmid) {
+		resp_payload = resp;
+		ret = le16_to_cpu(resp_payload->vmid);
+		kfree(resp);
+	}
+
+	return ret;
+}
+
+/**
+ * gh_rm_dealloc_vmid() - Dispose the VMID
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gh_rm_alloc_vmid
+ */
+int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid)
+{
+	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_DEALLOC_VMID, vmid);
+}
+
+/**
+ * gh_rm_vm_reset() - Reset the VM's resources
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gh_rm_alloc_vmid
+ *
+ * While tearing down the VM, request RM to clean up all the VM resources
+ * associated with the VM. Only after this, Linux can clean up all the
+ * references it maintains to resources.
+ */
+int gh_rm_vm_reset(struct gh_rm *rm, u16 vmid)
+{
+	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_RESET, vmid);
+}
+
+/**
+ * gh_rm_vm_start() - Move the VM into "ready to run" state
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gh_rm_alloc_vmid
+ *
+ * On VMs which use proxy scheduling, vcpu_run is needed to actually run the VM.
+ * On VMs which use Gunyah's scheduling, the vCPUs start executing in accordance with Gunyah
+ * scheduling policies.
+ */
+int gh_rm_vm_start(struct gh_rm *rm, u16 vmid)
+{
+	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_START, vmid);
+}
+
+/**
+ * gh_rm_vm_stop() - Send a request to Resource Manager VM to forcibly stop a VM.
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gh_rm_alloc_vmid
+ */
+int gh_rm_vm_stop(struct gh_rm *rm, u16 vmid)
+{
+	struct gh_rm_vm_stop_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+		.flags = GH_RM_VM_STOP_FLAG_FORCE_STOP,
+		.stop_reason = cpu_to_le32(GH_RM_VM_STOP_REASON_FORCE_STOP),
+	};
+
+	return gh_rm_call(rm, GH_RM_RPC_VM_STOP, &req_payload, sizeof(req_payload), NULL, NULL);
+}
+
+/**
+ * gh_rm_vm_configure() - Prepare a VM to start and provide the common
+ *			  configuration needed by RM to configure a VM
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gh_rm_alloc_vmid
+ * @auth_mechanism: Authentication mechanism used by resource manager to verify
+ *                  the virtual machine
+ * @mem_handle: Handle to a previously shared memparcel that contains all parts
+ *              of the VM image subject to authentication.
+ * @image_offset: Start address of VM image, relative to the start of memparcel
+ * @image_size: Size of the VM image
+ * @dtb_offset: Start address of the devicetree binary with VM configuration,
+ *              relative to start of memparcel.
+ * @dtb_size: Maximum size of devicetree binary. Resource manager applies
+ *            an overlay to the DTB and dtb_size should include room for
+ *            the overlay.
+ */
+int gh_rm_vm_configure(struct gh_rm *rm, u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism,
+		u32 mem_handle, u64 image_offset, u64 image_size, u64 dtb_offset, u64 dtb_size)
+{
+	struct gh_rm_vm_config_image_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+		.auth_mech = cpu_to_le16(auth_mechanism),
+		.mem_handle = cpu_to_le32(mem_handle),
+		.image_offset = cpu_to_le64(image_offset),
+		.image_size = cpu_to_le64(image_size),
+		.dtb_offset = cpu_to_le64(dtb_offset),
+		.dtb_size = cpu_to_le64(dtb_size),
+	};
+
+	return gh_rm_call(rm, GH_RM_RPC_VM_CONFIG_IMAGE, &req_payload, sizeof(req_payload),
+			  NULL, NULL);
+}
+
+/**
+ * gh_rm_vm_init() - Move the VM to initialized state.
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier
+ *
+ * RM will allocate needed resources for the VM.
+ */
+int gh_rm_vm_init(struct gh_rm *rm, u16 vmid)
+{
+	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_INIT, vmid);
+}
+
+/**
+ * gh_rm_get_hyp_resources() - Retrieve hypervisor resources (capabilities) associated with a VM
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VMID of the other VM to get the resources of
+ * @resources: Set by gh_rm_get_hyp_resources and contains the returned hypervisor resources.
+ */
+int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
+				struct gh_rm_hyp_resources **resources)
+{
+	struct gh_rm_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+	struct gh_rm_hyp_resources *resp;
+	size_t resp_size;
+	int ret;
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
+
+/**
+ * gh_rm_get_vmid() - Retrieve VMID of this virtual machine
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: Filled with the VMID of this VM
+ */
+int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid)
+{
+	static u16 cached_vmid = GH_VMID_INVAL;
+	size_t resp_size;
+	__le32 *resp;
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
+	*vmid = cached_vmid = lower_16_bits(le32_to_cpu(*resp));
+	kfree(resp);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_get_vmid);
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index deca9b3da541..6a2f434e67f7 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -18,4 +18,77 @@ int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block *nb);
 struct device *gh_rm_get(struct gh_rm *rm);
 void gh_rm_put(struct gh_rm *rm);
 
+struct gh_rm_vm_exited_payload {
+	__le16 vmid;
+	__le16 exit_type;
+	__le32 exit_reason_size;
+	u8 exit_reason[];
+} __packed;
+
+#define GH_RM_NOTIFICATION_VM_EXITED		 0x56100001
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
+struct gh_rm_vm_status_payload {
+	__le16 vmid;
+	u16 reserved;
+	u8 vm_status;
+	u8 os_status;
+	__le16 app_status;
+} __packed;
+
+#define GH_RM_NOTIFICATION_VM_STATUS		 0x56100008
+
+/* RPC Calls */
+int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid);
+int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid);
+int gh_rm_vm_reset(struct gh_rm *rm, u16 vmid);
+int gh_rm_vm_start(struct gh_rm *rm, u16 vmid);
+int gh_rm_vm_stop(struct gh_rm *rm, u16 vmid);
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
2.39.2

