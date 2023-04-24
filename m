Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E786ED871
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjDXXRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjDXXRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:17:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48593A27D;
        Mon, 24 Apr 2023 16:16:55 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OMrBDN010553;
        Mon, 24 Apr 2023 23:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=hoC7Ppz/4eLQw3t/BGkJDwF+GEaOrhGHbf1+GJV+gnU=;
 b=LgKJNtvcN6sFwuYyf/gBjtO4BvMSSZh3YZeBdKOSlFBrGezfK1goaayGPdvskLrr0ggG
 qDfFEcUg3LS/ZBSqPlhzZb0QYiMs4nzblNoPbAIAaNfgA5/tB3k6APc8Xy2y47CK/Fjh
 hcpfwj/FjbwBF86eKJUsPX8aRA7apdVcMRY/YITt2bLE6nK2RKU2RJMiWLZQlxb6Qn3K
 yx6qgt06xoFRZF/oTEr098aEI2R159VaO6BiOadYlrS9hA5ySGeKaTzs79pCvx7XXl7b
 JiR2WVvnW/FXnsuA4SfV1irDtPr1sM5lKjgLzn3PZ9EGcBURm3bqsYqt4WmW4xjEasXm qw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q628x83c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:42 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ONGg50006984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:42 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 16:16:41 -0700
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
Subject: [PATCH v12 10/25] gunyah: rsc_mgr: Add RPC for sharing memory
Date:   Mon, 24 Apr 2023 16:15:43 -0700
Message-ID: <20230424231558.70911-11-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424231558.70911-1-quic_eberman@quicinc.com>
References: <20230424231558.70911-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SCwRihyukZh2PxuDVABGF-qofEZhrkv0
X-Proofpoint-ORIG-GUID: SCwRihyukZh2PxuDVABGF-qofEZhrkv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240211
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah resource manager provides API to manipulate stage 2 page tables.
Manipulations are represented as a memory parcel. Memory parcels
describe a list of memory regions (intermediate physical address and
size), a list of new permissions for VMs, and the memory type (DDR or
MMIO). Memory parcels are uniquely identified by a handle allocated by
Gunyah. There are a few types of memory parcel sharing which Gunyah
supports:

 - Sharing: the guest and host VM both have access
 - Lending: only the guest has access; host VM loses access
 - Donating: Permanently lent (not reclaimed even if guest shuts down)

Memory parcels that have been shared or lent can be reclaimed by the
host via an additional call. The reclaim operation restores the original
access the host VM had to the memory parcel and removes the access to
other VM.

One point to note that memory parcels don't describe where in the guest
VM the memory parcel should reside. The guest VM must accept the memory
parcel either explicitly via a "gh_rm_mem_accept" call (not introduced
here) or be configured to accept it automatically at boot. As the guest
VM accepts the memory parcel, it also mentions the IPA it wants to place
memory parcel.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/rsc_mgr_rpc.c | 227 ++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h    |  48 +++++++
 2 files changed, 275 insertions(+)

diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
index 97a6abe3e144..22e2648ca3ed 100644
--- a/drivers/virt/gunyah/rsc_mgr_rpc.c
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -6,6 +6,12 @@
 #include <linux/gunyah_rsc_mgr.h>
 #include "rsc_mgr.h"
 
+/* Message IDs: Memory Management */
+#define GH_RM_RPC_MEM_LEND			0x51000012
+#define GH_RM_RPC_MEM_SHARE			0x51000013
+#define GH_RM_RPC_MEM_RECLAIM			0x51000015
+#define GH_RM_RPC_MEM_APPEND			0x51000018
+
 /* Message IDs: VM Management */
 #define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
 #define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
@@ -22,6 +28,46 @@ struct gh_rm_vm_common_vmid_req {
 	__le16 _padding;
 } __packed;
 
+/* Call: MEM_LEND, MEM_SHARE */
+#define GH_MEM_SHARE_REQ_FLAGS_APPEND		BIT(1)
+
+struct gh_rm_mem_share_req_header {
+	u8 mem_type;
+	u8 _padding0;
+	u8 flags;
+	u8 _padding1;
+	__le32 label;
+} __packed;
+
+struct gh_rm_mem_share_req_acl_section {
+	__le32 n_entries;
+	struct gh_rm_mem_acl_entry entries[];
+};
+
+struct gh_rm_mem_share_req_mem_section {
+	__le16 n_entries;
+	__le16 _padding;
+	struct gh_rm_mem_entry entries[];
+};
+
+/* Call: MEM_RELEASE */
+struct gh_rm_mem_release_req {
+	__le32 mem_handle;
+	u8 flags; /* currently not used */
+	u8 _padding0;
+	__le16 _padding1;
+} __packed;
+
+/* Call: MEM_APPEND */
+#define GH_MEM_APPEND_REQ_FLAGS_END		BIT(0)
+
+struct gh_rm_mem_append_req_header {
+	__le32 mem_handle;
+	u8 flags;
+	u8 _padding0;
+	__le16 _padding1;
+} __packed;
+
 /* Call: VM_ALLOC */
 struct gh_rm_vm_alloc_vmid_resp {
 	__le16 vmid;
@@ -51,6 +97,8 @@ struct gh_rm_vm_config_image_req {
 	__le64 dtb_size;
 } __packed;
 
+#define GH_RM_MAX_MEM_ENTRIES	512
+
 /*
  * Several RM calls take only a VMID as a parameter and give only standard
  * response back. Deduplicate boilerplate code by using this common call.
@@ -64,6 +112,185 @@ static int gh_rm_common_vmid_call(struct gh_rm *rm, u32 message_id, u16 vmid)
 	return gh_rm_call(rm, message_id, &req_payload, sizeof(req_payload), NULL, NULL);
 }
 
+static int _gh_rm_mem_append(struct gh_rm *rm, u32 mem_handle, bool end_append,
+			struct gh_rm_mem_entry *mem_entries, size_t n_mem_entries)
+{
+	struct gh_rm_mem_share_req_mem_section *mem_section;
+	struct gh_rm_mem_append_req_header *req_header;
+	size_t msg_size = 0;
+	void *msg;
+	int ret;
+
+	msg_size += sizeof(struct gh_rm_mem_append_req_header);
+	msg_size += struct_size(mem_section, entries, n_mem_entries);
+
+	msg = kzalloc(msg_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	req_header = msg;
+	mem_section = (void *)req_header + sizeof(struct gh_rm_mem_append_req_header);
+
+	req_header->mem_handle = cpu_to_le32(mem_handle);
+	if (end_append)
+		req_header->flags |= GH_MEM_APPEND_REQ_FLAGS_END;
+
+	mem_section->n_entries = cpu_to_le16(n_mem_entries);
+	memcpy(mem_section->entries, mem_entries, sizeof(*mem_entries) * n_mem_entries);
+
+	ret = gh_rm_call(rm, GH_RM_RPC_MEM_APPEND, msg, msg_size, NULL, NULL);
+	kfree(msg);
+
+	return ret;
+}
+
+static int gh_rm_mem_append(struct gh_rm *rm, u32 mem_handle,
+			struct gh_rm_mem_entry *mem_entries, size_t n_mem_entries)
+{
+	bool end_append;
+	int ret = 0;
+	size_t n;
+
+	while (n_mem_entries) {
+		if (n_mem_entries > GH_RM_MAX_MEM_ENTRIES) {
+			end_append = false;
+			n = GH_RM_MAX_MEM_ENTRIES;
+		} else {
+			end_append = true;
+			n = n_mem_entries;
+		}
+
+		ret = _gh_rm_mem_append(rm, mem_handle, end_append, mem_entries, n);
+		if (ret)
+			break;
+
+		mem_entries += n;
+		n_mem_entries -= n;
+	}
+
+	return ret;
+}
+
+static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, struct gh_rm_mem_parcel *p)
+{
+	size_t msg_size = 0, initial_mem_entries = p->n_mem_entries, resp_size;
+	size_t acl_section_size, mem_section_size;
+	struct gh_rm_mem_share_req_acl_section *acl_section;
+	struct gh_rm_mem_share_req_mem_section *mem_section;
+	struct gh_rm_mem_share_req_header *req_header;
+	u32 *attr_section;
+	__le32 *resp;
+	void *msg;
+	int ret;
+
+	if (!p->acl_entries || !p->n_acl_entries || !p->mem_entries || !p->n_mem_entries ||
+	    p->n_acl_entries > U8_MAX || p->mem_handle != GH_MEM_HANDLE_INVAL)
+		return -EINVAL;
+
+	if (initial_mem_entries > GH_RM_MAX_MEM_ENTRIES)
+		initial_mem_entries = GH_RM_MAX_MEM_ENTRIES;
+
+	acl_section_size = struct_size(acl_section, entries, p->n_acl_entries);
+	mem_section_size = struct_size(mem_section, entries, initial_mem_entries);
+	/* The format of the message goes:
+	 * request header
+	 * ACL entries (which VMs get what kind of access to this memory parcel)
+	 * Memory entries (list of memory regions to share)
+	 * Memory attributes (currently unused, we'll hard-code the size to 0)
+	 */
+	msg_size += sizeof(struct gh_rm_mem_share_req_header);
+	msg_size += acl_section_size;
+	msg_size += mem_section_size;
+	msg_size += sizeof(u32); /* for memory attributes, currently unused */
+
+	msg = kzalloc(msg_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	req_header = msg;
+	acl_section = (void *)req_header + sizeof(*req_header);
+	mem_section = (void *)acl_section + acl_section_size;
+	attr_section = (void *)mem_section + mem_section_size;
+
+	req_header->mem_type = p->mem_type;
+	if (initial_mem_entries != p->n_mem_entries)
+		req_header->flags |= GH_MEM_SHARE_REQ_FLAGS_APPEND;
+	req_header->label = cpu_to_le32(p->label);
+
+	acl_section->n_entries = cpu_to_le32(p->n_acl_entries);
+	memcpy(acl_section->entries, p->acl_entries,
+		flex_array_size(acl_section, entries, p->n_acl_entries));
+
+	mem_section->n_entries = cpu_to_le16(initial_mem_entries);
+	memcpy(mem_section->entries, p->mem_entries,
+		flex_array_size(mem_section, entries, initial_mem_entries));
+
+	/* Set n_entries for memory attribute section to 0 */
+	*attr_section = 0;
+
+	ret = gh_rm_call(rm, message_id, msg, msg_size, (void **)&resp, &resp_size);
+	kfree(msg);
+
+	if (ret)
+		return ret;
+
+	p->mem_handle = le32_to_cpu(*resp);
+	kfree(resp);
+
+	if (initial_mem_entries != p->n_mem_entries) {
+		ret = gh_rm_mem_append(rm, p->mem_handle,
+					&p->mem_entries[initial_mem_entries],
+					p->n_mem_entries - initial_mem_entries);
+		if (ret) {
+			gh_rm_mem_reclaim(rm, p);
+			p->mem_handle = GH_MEM_HANDLE_INVAL;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * gh_rm_mem_lend() - Lend memory to other virtual machines.
+ * @rm: Handle to a Gunyah resource manager
+ * @parcel: Information about the memory to be lent.
+ *
+ * Lending removes Linux's access to the memory while the memory parcel is lent.
+ */
+int gh_rm_mem_lend(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
+{
+	return gh_rm_mem_lend_common(rm, GH_RM_RPC_MEM_LEND, parcel);
+}
+
+
+/**
+ * gh_rm_mem_share() - Share memory with other virtual machines.
+ * @rm: Handle to a Gunyah resource manager
+ * @parcel: Information about the memory to be shared.
+ *
+ * Sharing keeps Linux's access to the memory while the memory parcel is shared.
+ */
+int gh_rm_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
+{
+	return gh_rm_mem_lend_common(rm, GH_RM_RPC_MEM_SHARE, parcel);
+}
+
+/**
+ * gh_rm_mem_reclaim() - Reclaim a memory parcel
+ * @rm: Handle to a Gunyah resource manager
+ * @parcel: Information about the memory to be reclaimed.
+ *
+ * RM maps the associated memory back into the stage-2 page tables of the owner VM.
+ */
+int gh_rm_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
+{
+	struct gh_rm_mem_release_req req = {
+		.mem_handle = cpu_to_le32(parcel->mem_handle),
+	};
+
+	return gh_rm_call(rm, GH_RM_RPC_MEM_RECLAIM, &req, sizeof(req), NULL, NULL);
+}
+
 /**
  * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
  * @rm: Handle to a Gunyah resource manager
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 1ac66d9004d2..dfac088420bd 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -11,6 +11,7 @@
 #include <linux/gunyah.h>
 
 #define GH_VMID_INVAL		U16_MAX
+#define GH_MEM_HANDLE_INVAL	U32_MAX
 
 struct gh_rm;
 int gh_rm_notifier_register(struct gh_rm *rm, struct notifier_block *nb);
@@ -51,7 +52,54 @@ struct gh_rm_vm_status_payload {
 
 #define GH_RM_NOTIFICATION_VM_STATUS		 0x56100008
 
+#define GH_RM_ACL_X		BIT(0)
+#define GH_RM_ACL_W		BIT(1)
+#define GH_RM_ACL_R		BIT(2)
+
+struct gh_rm_mem_acl_entry {
+	__le16 vmid;
+	u8 perms;
+	u8 reserved;
+} __packed;
+
+struct gh_rm_mem_entry {
+	__le64 phys_addr;
+	__le64 size;
+} __packed;
+
+enum gh_rm_mem_type {
+	GH_RM_MEM_TYPE_NORMAL	= 0,
+	GH_RM_MEM_TYPE_IO	= 1,
+};
+
+/*
+ * struct gh_rm_mem_parcel - Info about memory to be lent/shared/donated/reclaimed
+ * @mem_type: The type of memory: normal (DDR) or IO
+ * @label: An client-specified identifier which can be used by the other VMs to identify the purpose
+ *         of the memory parcel.
+ * @n_acl_entries: Count of the number of entries in the @acl_entries array.
+ * @acl_entries: An array of access control entries. Each entry specifies a VM and what access
+ *               is allowed for the memory parcel.
+ * @n_mem_entries: Count of the number of entries in the @mem_entries array.
+ * @mem_entries: An array of regions to be associated with the memory parcel. Addresses should be
+ *               (intermediate) physical addresses from Linux's perspective.
+ * @mem_handle: On success, filled with memory handle that RM allocates for this memory parcel
+ */
+struct gh_rm_mem_parcel {
+	enum gh_rm_mem_type mem_type;
+	u32 label;
+	size_t n_acl_entries;
+	struct gh_rm_mem_acl_entry *acl_entries;
+	size_t n_mem_entries;
+	struct gh_rm_mem_entry *mem_entries;
+	u32 mem_handle;
+};
+
 /* RPC Calls */
+int gh_rm_mem_lend(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel);
+int gh_rm_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel);
+int gh_rm_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel);
+
 int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid);
 int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid);
 int gh_rm_vm_reset(struct gh_rm *rm, u16 vmid);
-- 
2.40.0

