Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27D16324BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiKUOCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKUOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:01:58 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B149CF47;
        Mon, 21 Nov 2022 06:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669039317; x=1700575317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6FRhFwKvkVENg+VPhJgJ86aIuZqgwHwm5Um5GmXyQ8w=;
  b=G686h3oopT7XF6VuRArh4EinyfLCbDtQLxONL7kETZlQxtAt11VroUW/
   FeJNSaa7HnoEGtZxmRbyYHN8Vq4105MaSXTvtsQxMzyVQzTFosQVrKOq9
   6a4N26f8Mvy+AJlHndnFHdIZa0b9lJDQsbO40h0sfkk+Yf4UCqDKZu3oI
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Nov 2022 06:01:56 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 06:01:56 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 06:01:55 -0800
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
Subject: [PATCH v7 11/20] gunyah: rsc_mgr: Add VM lifecycle RPC
Date:   Mon, 21 Nov 2022 06:00:00 -0800
Message-ID: <20221121140009.2353512-12-quic_eberman@quicinc.com>
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

Add Gunyah Resource Manager RPC to launch an unauthenticated VM.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/gunyah_rm_rpc.c | 217 +++++++++++++++++++++++++++-
 drivers/virt/gunyah/rsc_mgr.h       |  46 ++++++
 include/linux/gunyah_rsc_mgr.h      |  58 ++++++++
 3 files changed, 319 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/gunyah/gunyah_rm_rpc.c b/drivers/virt/gunyah/gunyah_rm_rpc.c
index 45b1a8691982..fe6ba476c4dc 100644
--- a/drivers/virt/gunyah/gunyah_rm_rpc.c
+++ b/drivers/virt/gunyah/gunyah_rm_rpc.c
@@ -436,8 +436,8 @@ static int gh_rm_send_request(struct gh_rm_rpc *rsc_mgr, u32 message_id,
  * Context: Process context. Will sleep waiting for reply.
  * Return: >0 is standard reply error from RM. <0 on internal error.
  */
-int gh_rm_call(struct gh_rm_rpc *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
-	       void **resp_buf, size_t *resp_buff_size)
+static int gh_rm_call(struct gh_rm_rpc *rsc_mgr, u32 message_id, void *req_buff,
+			size_t req_buff_size, void **resp_buf, size_t *resp_buff_size)
 {
 	struct gh_rm_connection *connection;
 	int ret;
@@ -566,5 +566,218 @@ void gh_rm_rpc_remove(struct gh_rm_rpc *rm)
 }
 EXPORT_SYMBOL_GPL(gh_rm_rpc_remove);
 
+/*
+ * Several RM calls take only a VMID as a parameter and give only standard
+ * response back. Deduplicate boilerplate code by using this common call.
+ */
+static int gh_rm_common_vmid_call(struct gh_rm_rpc *rm, u32 message_id, u16 vmid)
+{
+	void *resp = NULL;
+	struct gh_vm_common_vmid_req req_payload = {
+		.vmid = vmid,
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
+		.vmid = vmid,
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
+	struct gh_vm_stop_req req_payload = { 0 };
+	void *resp;
+	size_t resp_size;
+	int ret;
+
+	req_payload.vmid = vmid;
+
+	ret = gh_rm_call(rm, GH_RM_RPC_VM_STOP, &req_payload, sizeof(req_payload), &resp, &resp_size);
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
+	struct gh_vm_common_vmid_req req_payload = {0};
+
+	req_payload.vmid = vmid;
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
+	void *resp;
+	size_t resp_size;
+	int ret;
+	int payload = 0;
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
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Gunyah Resource Manager RPC Driver");
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 01f0af888fad..11a5afa2c79c 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -34,4 +34,50 @@ struct platform_device;
 struct gh_rm_rpc *gh_rm_rpc_init(struct platform_device *pdev);
 void gh_rm_rpc_remove(struct gh_rm_rpc *rm);
 
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
 #endif
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index b4f55c19954b..a0bd6f39c649 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -15,4 +15,62 @@
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
+ssize_t gh_rm_get_hyp_resources(struct gh_rm_rpc *rm, u16 vmid,
+				struct gh_rm_hyp_resource **resources);
+int gh_rm_get_vmid(struct gh_rm_rpc *rm, u16 *vmid);
+
+#define GH_RM_BOOT_CONTEXT_REG_SET_REGISTERS	0
+#define GH_RM_BOOT_CONTEXT_REG_SET_PC		1
+#define GH_RM_BOOT_CONTEXT_REG_SET_SP_ELx	2
+int gh_rm_set_boot_context(struct gh_rm_rpc *rm, u16 vmid, u8 reg_set, u8 reg_idx, u64 value);
+
 #endif
-- 
2.25.1

