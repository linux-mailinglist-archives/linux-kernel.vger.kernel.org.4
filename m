Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19766324CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiKUODH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKUOCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:02:04 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EBD5FAE;
        Mon, 21 Nov 2022 06:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669039322; x=1700575322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l7tmQcGy3NTootmU6QFfSxvXb9cGNIyVov6HfTyhpFQ=;
  b=fCkFghSvsaPGetDSprnFChe3b8knlvcmeUT1lpoajfw9SG4EMfOAKh61
   YUi6OV70GmkSgNobDCy+XidmkXnZGJXIUUK+8V6zOREwV3sopHHM9Bz3P
   z5tPrloIrF+EUkhAf71CstI5VVG+8CwUcpH7zdFqmPZJ8AMMaiaEoj76E
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Nov 2022 06:02:02 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 06:02:02 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 06:02:01 -0800
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 13/20] gunyah: rsc_mgr: Add RPC for sharing memory
Date:   Mon, 21 Nov 2022 06:00:02 -0800
Message-ID: <20221121140009.2353512-14-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121140009.2353512-1-quic_eberman@quicinc.com>
References: <20221121140009.2353512-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/gunyah_rm_rpc.c | 199 ++++++++++++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h       |  44 ++++++
 include/linux/gunyah_rsc_mgr.h      |  47 +++++++
 3 files changed, 290 insertions(+)

diff --git a/drivers/virt/gunyah/gunyah_rm_rpc.c b/drivers/virt/gunyah/gunyah_rm_rpc.c
index fe6ba476c4dc..544ec8022104 100644
--- a/drivers/virt/gunyah/gunyah_rm_rpc.c
+++ b/drivers/virt/gunyah/gunyah_rm_rpc.c
@@ -49,6 +49,8 @@ struct gh_rm_rpc_reply_hdr {
 
 #define GH_RM_MAX_MSG_SIZE	(GH_MSGQ_MAX_MSG_SIZE - sizeof(struct gh_rm_rpc_hdr))
 
+#define GH_RM_MAX_MEM_ENTRIES	512
+
 /**
  * struct gh_rm_connection - Represents a complete message from resource manager
  * @payload: Combined payload of all the fragments (msg headers stripped off).
@@ -588,6 +590,203 @@ static int gh_rm_common_vmid_call(struct gh_rm_rpc *rm, u32 message_id, u16 vmid
 	return ret;
 }
 
+static int _gh_rm_mem_append(struct gh_rm_rpc *rm, u32 mem_handle, bool end_append,
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
+	req_header->mem_handle = mem_handle;
+	if (end_append)
+		req_header->flags |= GH_MEM_APPEND_REQ_FLAGS_END;
+
+	mem_section->n_entries = n_mem_entries;
+	memcpy(mem_section->entries, mem_entries, sizeof(*mem_entries) * n_mem_entries);
+
+	ret = gh_rm_call(rm, GH_RM_RPC_MEM_APPEND, msg, msg_size, &resp, &resp_size);
+	if (ret)
+		return ret;
+	kfree(resp);
+
+	return ret;
+}
+
+static int gh_rm_mem_append(struct gh_rm_rpc *rm, u32 mem_handle, bool allow_append,
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
+			end_append = !allow_append;
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
+static int gh_rm_mem_lend_common(struct gh_rm_rpc *rm, u32 message_id, struct gh_rm_mem_parcel *p)
+{
+	size_t msg_size = 0, initial_n_mem_entries = p->n_mem_entries;
+	void *msg, *resp;
+	struct gh_mem_share_req_header *req_header;
+	struct gh_mem_share_req_acl_section *acl_section;
+	struct gh_mem_share_req_mem_section *mem_section;
+	u32 *mem_attr_section;
+	size_t resp_size;
+	int ret;
+
+	if (!p->acl_entries || !p->n_acl_entries || !p->mem_entries || !p->n_mem_entries ||
+	    p->n_acl_entries > U8_MAX)
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
+	req_header->label = p->label;
+
+	acl_section->n_entries = p->n_acl_entries;
+	memcpy(acl_section->entries, p->acl_entries, sizeof(*(p->acl_entries)) * p->n_acl_entries);
+
+	mem_section->n_entries = initial_n_mem_entries;
+	memcpy(mem_section->entries, p->mem_entries,
+		sizeof(*(p->mem_entries)) * initial_n_mem_entries);
+
+	/* Set n_entries for memory attribute section to 0 */
+	*mem_attr_section = 0;
+
+	ret = gh_rm_call(rm, message_id, msg, msg_size, &resp, &resp_size);
+	if (ret)
+		return ret;
+
+	if (resp_size != sizeof(u32)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	p->mem_handle = *(u32 *)resp;
+
+	if (initial_n_mem_entries != p->n_mem_entries) {
+		ret = gh_rm_mem_append(rm, p->mem_handle, false,
+					&p->mem_entries[initial_n_mem_entries],
+					p->n_mem_entries - initial_n_mem_entries);
+		if (ret)
+			gh_rm_mem_reclaim(rm, p);
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
+int gh_rm_mem_lend(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *parcel)
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
+int gh_rm_mem_share(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *parcel)
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
+int gh_rm_mem_reclaim(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *parcel)
+{
+	struct gh_mem_release_req req = {
+		.mem_handle = parcel->mem_handle,
+	};
+	size_t resp_size;
+	void *resp;
+	int ret;
+
+	ret = gh_rm_call(rm, GH_RM_RPC_MEM_RECLAIM, &req, sizeof(req), &resp, &resp_size);
+	if (ret)
+		return ret;
+	kfree(resp);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_mem_reclaim);
+
 /**
  * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
  * @vmid: Use GH_VMID_INVAL to dynamically allocate a VM. A reserved VMID can also be requested
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 11a5afa2c79c..4712405a3486 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -34,6 +34,12 @@ struct platform_device;
 struct gh_rm_rpc *gh_rm_rpc_init(struct platform_device *pdev);
 void gh_rm_rpc_remove(struct gh_rm_rpc *rm);
 
+/* Message IDs: Memory Management */
+#define GH_RM_RPC_MEM_LEND			0x51000012
+#define GH_RM_RPC_MEM_SHARE			0x51000013
+#define GH_RM_RPC_MEM_RECLAIM			0x51000015
+#define GH_RM_RPC_MEM_APPEND			0x51000018
+
 /* Message IDs: VM Management */
 #define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
 #define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
@@ -51,6 +57,44 @@ struct gh_vm_common_vmid_req {
 	u16 reserved0;
 } __packed;
 
+/* Call: MEM_LEND, MEM_SHARE */
+struct gh_mem_share_req_header {
+	u8 mem_type;
+	u8 reserved0;
+#define GH_MEM_SHARE_REQ_FLAGS_APPEND		BIT(1)
+	u8 flags;
+	u8 reserved1;
+	u32 label;
+} __packed;
+
+struct gh_mem_share_req_acl_section {
+	u32 n_entries;
+	struct gh_rm_mem_acl_entry entries[];
+};
+
+struct gh_mem_share_req_mem_section {
+	u16 n_entries;
+	u16 reserved0;
+	struct gh_rm_mem_entry entries[];
+};
+
+/* Call: MEM_RELEASE */
+struct gh_mem_release_req {
+	u32 mem_handle;
+	u8 flags;
+	u16 reserved0;
+	u8 reserved1;
+} __packed;
+
+/* Call: MEM_APPEND */
+struct gh_mem_append_req_header {
+	u32 mem_handle;
+#define GH_MEM_APPEND_REQ_FLAGS_END	BIT(0)
+	u8 flags;
+	u16 reserved0;
+	u8 reserved1;
+} __packed;
+
 /* Call: VM_STOP */
 struct gh_vm_stop_req {
 	u16 vmid;
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index a0bd6f39c649..c0f5c04c64dc 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -11,6 +11,7 @@
 #include <linux/gunyah.h>
 
 #define GH_VMID_INVAL	U16_MAX
+#define GH_MEM_HANDLE_INVAL	U32_MAX
 
 /* Gunyah recognizes VMID0 as an alias to the current VM's ID */
 #define GH_VMID_SELF			0
@@ -31,7 +32,53 @@ enum gh_rm_vm_status {
 	GH_RM_VM_STATUS_RESET		= 11,
 };
 
+struct gh_rm_mem_acl_entry {
+	u16 vmid;
+#define GH_RM_ACL_X		BIT(0)
+#define GH_RM_ACL_W		BIT(1)
+#define GH_RM_ACL_R		BIT(2)
+	u8 perms;
+	u8 reserved;
+} __packed;
+
+struct gh_rm_mem_entry {
+	u64 ipa_base;
+	u64 size;
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
+int gh_rm_mem_lend(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *parcel);
+int gh_rm_mem_share(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *parcel);
+int gh_rm_mem_reclaim(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *parcel);
+
 int gh_rm_alloc_vmid(struct gh_rm_rpc *rm, u16 vmid);
 int gh_rm_dealloc_vmid(struct gh_rm_rpc *rm, u16 vmid);
 int gh_rm_vm_start(struct gh_rm_rpc *rm, u16 vmid);
-- 
2.25.1

