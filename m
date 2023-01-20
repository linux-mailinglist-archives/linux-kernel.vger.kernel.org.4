Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828EC6760AB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjATWth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjATWt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:49:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8696779E;
        Fri, 20 Jan 2023 14:48:49 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMe2fF029889;
        Fri, 20 Jan 2023 22:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=YP+69sXYD0uhnHJf+coVLGSsBBt1XgaAsipO/XYv0PU=;
 b=c0iQVqbcPNBuJJZboD2pXHbq53CxvZZdGgr/tOJZ9/yxrK/Z8tV3LF0Q0oIHVmN2ywWb
 a5RqrOEGVUvFTt/wQzBC3RhVma/51oZs8JtW9C9lC1VYrOtPX6znafQgvmlScijbubAX
 KlWULmD4Yzk4vhXZgl7vLwwJyvTjQ+DA0/0Hgw4YsomSemM93DwE7CuwO0KCv6B3XDS5
 vwnRLParG3u1/hGwiGACTjZjoNMP0BKAXQkHKRKsEKKXcBkoEelswIrUtjePslzJE8Xc
 4ccuoa/CH9eNpJVlD5JWE72IjtCS4+0G0Spri2EH1pHhF3GUrbOSW78UaY9z8svEeT2a XQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7xm40k8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:49 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMlmq8022649
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:48 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:47:47 -0800
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
Subject: [PATCH v9 12/27] gunyah: rsc_mgr: Add RPC for sharing memory
Date:   Fri, 20 Jan 2023 14:46:11 -0800
Message-ID: <20230120224627.4053418-13-quic_eberman@quicinc.com>
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
X-Proofpoint-ORIG-GUID: h8-LVh-TZkr7OIpKs_1DtbMtZ0mrjCt6
X-Proofpoint-GUID: h8-LVh-TZkr7OIpKs_1DtbMtZ0mrjCt6
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
 drivers/virt/gunyah/rsc_mgr.h     |  50 +++++++
 drivers/virt/gunyah/rsc_mgr_rpc.c | 216 ++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h    |  55 +++++++-
 3 files changed, 317 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 2f12f31a2ea6..17047afefb28 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -68,6 +68,12 @@ struct gh_rm;
 int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
 		void **resp_buf, size_t *resp_buff_size);
 
+/* Message IDs: Memory Management */
+#define GH_RM_RPC_MEM_LEND			0x51000012
+#define GH_RM_RPC_MEM_SHARE			0x51000013
+#define GH_RM_RPC_MEM_RECLAIM			0x51000015
+#define GH_RM_RPC_MEM_APPEND			0x51000018
+
 /* Message IDs: VM Management */
 #define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
 #define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
@@ -83,6 +89,50 @@ struct gh_vm_common_vmid_req {
 	__le16 reserved0;
 } __packed;
 
+/* Call: MEM_LEND, MEM_SHARE */
+struct gh_mem_share_req_header {
+	u8 mem_type;
+	u8 reserved0;
+#define GH_MEM_SHARE_REQ_FLAGS_APPEND		BIT(1)
+	u8 flags;
+	u8 reserved1;
+	__le32 label;
+} __packed;
+
+struct gh_mem_share_req_acl_section {
+	__le32 n_entries;
+	struct gh_rm_mem_acl_entry entries[];
+};
+
+struct gh_mem_share_req_mem_section {
+	__le16 n_entries;
+	__le16 reserved0;
+	struct gh_rm_mem_entry entries[];
+};
+
+/* Call: MEM_RELEASE */
+struct gh_mem_release_req {
+	__le32 mem_handle;
+	u8 flags; /* currently not used */
+	__le16 reserved0;
+	u8 reserved1;
+} __packed;
+
+/* Call: MEM_APPEND */
+struct gh_mem_append_req_header {
+	__le32 mem_handle;
+#define GH_MEM_APPEND_REQ_FLAGS_END	BIT(0)
+	u8 flags;
+	__le16 reserved0;
+	u8 reserved1;
+} __packed;
+
+/* Call: VM_ALLOC */
+struct gh_vm_alloc_vmid_resp {
+	__le16 vmid;
+	__le16 reserved0;
+} __packed;
+
 /* Call: VM_STOP */
 struct gh_vm_stop_req {
 	__le16 vmid;
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
index b6935dfac1fe..a3633df98a38 100644
--- a/drivers/virt/gunyah/rsc_mgr_rpc.c
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -7,6 +7,8 @@
 
 #include "rsc_mgr.h"
 
+#define GH_RM_MAX_MEM_ENTRIES	512
+
 /*
  * Several RM calls take only a VMID as a parameter and give only standard
  * response back. Deduplicate boilerplate code by using this common call.
@@ -31,6 +33,220 @@ static int gh_rm_common_vmid_call(struct gh_rm *rm, u32 message_id, u16 vmid)
 	return ret;
 }
 
+static int _gh_rm_mem_append(struct gh_rm *rm, u32 mem_handle, bool end_append,
+			struct gh_rm_mem_entry *mem_entries, size_t n_mem_entries)
+{
+	size_t msg_size = 0;
+	void *msg;
+	struct gh_mem_append_req_header *req_header;
+	struct gh_mem_share_req_mem_section *mem_section;
+	void *resp;
+	size_t resp_size;
+	int ret;
+
+	msg_size += sizeof(struct gh_mem_append_req_header);
+	msg_size += offsetof(struct gh_mem_share_req_mem_section, entries[n_mem_entries]);
+
+	msg = kzalloc(msg_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	req_header = msg;
+	mem_section = (void *)req_header + sizeof(struct gh_mem_append_req_header);
+
+	req_header->mem_handle = cpu_to_le32(mem_handle);
+	if (end_append)
+		req_header->flags |= GH_MEM_APPEND_REQ_FLAGS_END;
+
+	mem_section->n_entries = cpu_to_le16(n_mem_entries);
+	memcpy(mem_section->entries, mem_entries, sizeof(*mem_entries) * n_mem_entries);
+
+	ret = gh_rm_call(rm, GH_RM_RPC_MEM_APPEND, msg, msg_size, &resp, &resp_size);
+	kfree(msg);
+	if (!ret && resp_size) {
+		pr_warn("%s: unexpected payload size: %ld Expected: 0", __func__, resp_size);
+		kfree(resp);
+		ret = -EBADMSG;
+	}
+
+	return ret;
+}
+
+static int gh_rm_mem_append(struct gh_rm *rm, u32 mem_handle,
+			struct gh_rm_mem_entry *mem_entries, size_t n_mem_entries)
+{
+	bool end_append;
+	size_t n;
+	int ret = 0;
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
+	size_t msg_size = 0, initial_n_mem_entries = p->n_mem_entries;
+	void *msg;
+	__le32 *resp;
+	struct gh_mem_share_req_header *req_header;
+	struct gh_mem_share_req_acl_section *acl_section;
+	struct gh_mem_share_req_mem_section *mem_section;
+	u32 *mem_attr_section;
+	size_t resp_size;
+	int ret;
+
+	if (!p->acl_entries || !p->n_acl_entries || !p->mem_entries || !p->n_mem_entries ||
+	    p->n_acl_entries > U8_MAX || p->mem_handle != GH_MEM_HANDLE_INVAL)
+		return -EINVAL;
+
+	if (initial_n_mem_entries > GH_RM_MAX_MEM_ENTRIES)
+		initial_n_mem_entries = GH_RM_MAX_MEM_ENTRIES;
+
+	/* The format of the message goes:
+	 * request header
+	 * ACL entries (which VMs get what kind of access to this memory parcel)
+	 * Memory entries (list of memory regions to share)
+	 * Memory attributes (currently unused, we'll hard-code the size to 0)
+	 */
+	msg_size += sizeof(struct gh_mem_share_req_header);
+	msg_size += offsetof(struct gh_mem_share_req_acl_section, entries[p->n_acl_entries]);
+	msg_size += offsetof(struct gh_mem_share_req_mem_section, entries[initial_n_mem_entries]);
+	msg_size += sizeof(u32); /* for memory attributes, currently unused */
+
+	msg = kzalloc(msg_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = gh_rm_platform_pre_mem_share(rm, p);
+	if (ret) {
+		kfree(msg);
+		return ret;
+	}
+
+	req_header = msg;
+	acl_section = (void *)req_header + sizeof(*req_header);
+	mem_section = (void *)acl_section + offsetof(struct gh_mem_share_req_acl_section,
+						entries[p->n_acl_entries]);
+	mem_attr_section = (void *)mem_section + offsetof(struct gh_mem_share_req_mem_section,
+						entries[initial_n_mem_entries]);
+
+	req_header->mem_type = p->mem_type;
+	if (initial_n_mem_entries != p->n_mem_entries)
+		req_header->flags |= GH_MEM_SHARE_REQ_FLAGS_APPEND;
+	req_header->label = cpu_to_le32(p->label);
+
+	acl_section->n_entries = cpu_to_le32(p->n_acl_entries);
+	memcpy(acl_section->entries, p->acl_entries, sizeof(*(p->acl_entries)) * p->n_acl_entries);
+
+	mem_section->n_entries = cpu_to_le16(initial_n_mem_entries);
+	memcpy(mem_section->entries, p->mem_entries,
+		sizeof(*(p->mem_entries)) * initial_n_mem_entries);
+
+	/* Set n_entries for memory attribute section to 0 */
+	*mem_attr_section = 0;
+
+	ret = gh_rm_call(rm, message_id, msg, msg_size, (void **)&resp, &resp_size);
+	kfree(msg);
+	if (ret) {
+		gh_rm_platform_post_mem_reclaim(rm, p);
+		goto out;
+	}
+
+	if (resp_size != sizeof(__le32)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	p->mem_handle = le32_to_cpu(*resp);
+
+	if (initial_n_mem_entries != p->n_mem_entries) {
+		ret = gh_rm_mem_append(rm, p->mem_handle,
+					&p->mem_entries[initial_n_mem_entries],
+					p->n_mem_entries - initial_n_mem_entries);
+		if (ret) {
+			gh_rm_mem_reclaim(rm, p);
+			p->mem_handle = GH_MEM_HANDLE_INVAL;
+		}
+	}
+
+out:
+	kfree(resp);
+	return ret;
+}
+
+/**
+ * gh_rm_mem_lend() - Lend memory to other virtual machines.
+ * @parcel: Package the memory information of the memory to be lent.
+ *
+ * Returns - 0 on success; negative value on failure
+ *
+ * Lending removes Linux's access to the memory while the memory parcel is lent.
+ */
+int gh_rm_mem_lend(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
+{
+	return gh_rm_mem_lend_common(rm, GH_RM_RPC_MEM_LEND, parcel);
+}
+EXPORT_SYMBOL_GPL(gh_rm_mem_lend);
+
+
+/**
+ * gh_rm_mem_share() - Share memory with other virtual machines.
+ * @parcel: Package the memory information of the memory to be shared.
+ *
+ * Returns - 0 on success; negative value on failure
+ *
+ * Sharing keeps Linux's access to the memory while the memory parcel is shared.
+ */
+int gh_rm_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
+{
+	return gh_rm_mem_lend_common(rm, GH_RM_RPC_MEM_SHARE, parcel);
+}
+EXPORT_SYMBOL_GPL(gh_rm_mem_share);
+
+/**
+ * gh_rm_mem_reclaim() - Reclaim a memory parcel
+ * @parcel: Package the memory information of the memory to be reclaimed.
+ *
+ * Returns - 0 on success; negative value on failure
+ *
+ * RM maps the associated memory back into the stage-2 page tables of the owner VM.
+ */
+int gh_rm_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
+{
+	struct gh_mem_release_req req = {
+		.mem_handle = cpu_to_le32(parcel->mem_handle),
+	};
+	size_t resp_size;
+	void *resp;
+	int ret;
+
+	ret = gh_rm_call(rm, GH_RM_RPC_MEM_RECLAIM, &req, sizeof(req), &resp, &resp_size);
+	if (!ret && resp_size) {
+		pr_warn("%s: unexpected payload size: %ld Expected: 0", __func__, resp_size);
+		kfree(resp);
+		return -EBADMSG;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_mem_reclaim);
+
 /**
  * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
  * @vmid: Use GH_VMID_INVAL or GH_VMID_SELF (0) to dynamically allocate a VM. A reserved VMID can
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 9a9a037b349a..264f054540b8 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -11,6 +11,7 @@
 #include <linux/gunyah.h>
 
 #define GH_VMID_INVAL	U16_MAX
+#define GH_MEM_HANDLE_INVAL	U32_MAX
 
 /* Gunyah recognizes VMID0 as an alias to the current VM's ID */
 #define GH_VMID_SELF			0
@@ -34,11 +35,57 @@ enum gh_rm_vm_status {
 	GH_RM_VM_STATUS_RESET		= 11,
 };
 
+struct gh_rm_mem_acl_entry {
+	__le16 vmid;
+#define GH_RM_ACL_X		BIT(0)
+#define GH_RM_ACL_W		BIT(1)
+#define GH_RM_ACL_R		BIT(2)
+	u8 perms;
+	u8 reserved;
+} __packed;
+
+struct gh_rm_mem_entry {
+	__le64 ipa_base;
+	__le64 size;
+} __packed;
+
+enum gh_rm_mem_type {
+	GH_RM_MEM_TYPE_NORMAL	= 0,
+	GH_RM_MEM_TYPE_IO	= 1,
+};
+
+/*
+ * struct gh_rm_mem_parcel - Package info about memory to be lent/shared/donated/reclaimed
+ * @mem_type: The type of memory: normal (DDR) or IO
+ * @label: An client-specified identifier which can be used by the other VMs to identify the purpose
+ *         of the memory parcel.
+ * @acl_entries: An array of access control entries. Each entry specifies a VM and what access
+ *               is allowed for the memory parcel.
+ * @n_acl_entries: Count of the number of entries in the `acl_entries` array.
+ * @mem_entries: An list of regions to be associated with the memory parcel. Addresses should be
+ *               (intermediate) physical addresses from Linux's perspective.
+ * @n_mem_entries: Count of the number of entries in the `mem_entries` array.
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
-int gh_rm_alloc_vmid(struct gh_rm_rpc *rm, u16 vmid);
-int gh_rm_dealloc_vmid(struct gh_rm_rpc *rm, u16 vmid);
-int gh_rm_vm_start(struct gh_rm_rpc *rm, u16 vmid);
-int gh_rm_vm_stop(struct gh_rm_rpc *rm, u16 vmid);
+int gh_rm_mem_lend(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel);
+int gh_rm_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel);
+int gh_rm_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel);
+
+int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid);
+int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid);
+int gh_rm_vm_start(struct gh_rm *rm, u16 vmid);
+int gh_rm_vm_stop(struct gh_rm *rm, u16 vmid);
 
 enum gh_rm_vm_auth_mechanism {
 	GH_RM_VM_AUTH_NONE		= 0,
-- 
2.39.0

