Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE845FA926
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJKALV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiJKAKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:10:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE619C14;
        Mon, 10 Oct 2022 17:09:46 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B09VPY002497;
        Tue, 11 Oct 2022 00:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=P0lLr7aK19S1+yv1vs1G44smdfqvt8pl/Cr2VkW0RfU=;
 b=DClDY29Ioy5txiSp2hGc7O2ox4pA6CMjYNmOWNl3VdB/yNX+Pv1UBzz63PmfTd2yYonn
 c8vKlRhyl0Xo+fUMdKcWTL7y0ogBcSzYyrdKkww9m/AosfODgV30OCFpE/mPzHylNe+B
 umb/mGDmcvuYLCXeLUXHTEHZ5liR8rHGr/aGzofTKzumFpbsFLX+zQSY+oNShcWZnvTa
 GO//EZdJTGYygaa0bVxs6B4RTSvXZY/YkoBjiE/fSSjPHrvlY43sBHSITDoSPZY1k7nx
 vjSweNK+01lAZoFYTsJhFpOZTLY0HrCWJapsrXF7V0o4yXoEyZB2dxgHCRXjc1xgZFsV UA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rxe0hjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 00:09:31 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29B09TtE005738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 00:09:30 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 10 Oct 2022 17:09:29 -0700
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
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 11/13] gunyah: rsc_mgr: Add RPC for console services
Date:   Mon, 10 Oct 2022 17:08:38 -0700
Message-ID: <20221011000840.289033-12-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011000840.289033-1-quic_eberman@quicinc.com>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IAq9Zjr57Rk16Rc58SZ8yf8zm0ROe5u-
X-Proofpoint-ORIG-GUID: IAq9Zjr57Rk16Rc58SZ8yf8zm0ROe5u-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_12,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=766 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100143
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah resource manager defines a simple API for virtual machine log
sharing with the console service. A VM's own log can be opened by using
GH_VMID_SELF. Another VM's log can be accessed via its VMID. Once
opened, characters can be written to the log with a write command.
Characters are received with resource manager notifications (using ID
GH_RM_NOTIF_VM_CONSOLE_CHARS).

These high level rpc calls are kept in
drivers/virt/gunyah/rsc_mgr_rpc.c. Future RPC calls, e.g. to launch a VM
will also be maintained in this file.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile      |   2 +-
 drivers/virt/gunyah/rsc_mgr.h     |  22 ++++++
 drivers/virt/gunyah/rsc_mgr_rpc.c | 126 ++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h    |  18 +++++
 4 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 2cae8ea5bc7d..5eb6ad3c45ba 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,5 +1,5 @@
 gunyah-y += gunyah.o
 obj-$(CONFIG_GUNYAH) += gunyah.o
 
-gunyah_rsc_mgr-y += rsc_mgr.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
 obj-$(CONFIG_GUNYAH_RESORUCE_MANAGER) += gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index e4f2499267bf..4620ac648bcf 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -28,6 +28,28 @@
 #define GH_RM_ERROR_IRQ_INUSE		0x10
 #define GH_RM_ERROR_IRQ_RELEASED	0x11
 
+/* Message IDs: VM Management */
+#define GH_RM_RPC_VM_GET_VMID			0x56000024
+
+/* Message IDs: VM Services */
+#define GH_RM_RPC_VM_CONSOLE_OPEN_ID		0x56000081
+#define GH_RM_RPC_VM_CONSOLE_CLOSE_ID		0x56000082
+#define GH_RM_RPC_VM_CONSOLE_WRITE_ID		0x56000083
+#define GH_RM_RPC_VM_CONSOLE_FLUSH_ID		0x56000084
+
+/* Call: CONSOLE_OPEN, CONSOLE_CLOSE, CONSOLE_FLUSH */
+struct gh_vm_common_vmid_req {
+	u16 vmid;
+	u16 reserved0;
+} __packed;
+
+/* Call: CONSOLE_WRITE */
+struct gh_vm_console_write_req {
+	u16 vmid;
+	u16 num_bytes;
+	u8 data[0];
+} __packed;
+
 int gh_rm_call(u32 message_id, void *req_buff, size_t req_buff_size,
 		void **resp_buf, size_t *resp_buff_size);
 
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
new file mode 100644
index 000000000000..89d3a295f072
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -0,0 +1,126 @@
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
+/* Several RM calls take only a VMID as a parameter and give only standard response back.
+ * Deduplicate boilerplate code by using this common call.
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
+
+/**
+ * gh_rm_console_open() - Open a console with a VM
+ * @vmid: VMID of the other VM whose console to open. If VMID is GH_VMID_SELF, the
+ *        console associated with this VM is opened.
+ */
+int gh_rm_console_open(u16 vmid)
+{
+	return gh_rm_common_vmid_call(GH_RM_RPC_VM_CONSOLE_OPEN_ID, vmid);
+}
+EXPORT_SYMBOL_GPL(gh_rm_console_open);
+
+/**
+ * gh_rm_console_close() - Close a console with a VM
+ * @vmid: The vmid of the vm whose console to close.
+ */
+int gh_rm_console_close(u16 vmid)
+{
+	return gh_rm_common_vmid_call(GH_RM_RPC_VM_CONSOLE_CLOSE_ID, vmid);
+}
+EXPORT_SYMBOL_GPL(gh_rm_console_close);
+
+/**
+ * gh_rm_console_write() - Write to a VM's console
+ * @vmid: The vmid of the vm whose console to write to.
+ * @buf: Buffer to write to the VM's console
+ * @size: Size of the buffer
+ */
+int gh_rm_console_write(u16 vmid, const char *buf, size_t size)
+{
+	void *resp;
+	struct gh_vm_console_write_req *req_payload;
+	size_t resp_size;
+	int ret = 0;
+	size_t req_payload_size = sizeof(*req_payload) + size;
+
+	if (size < 1 || size > (U32_MAX - sizeof(*req_payload)))
+		return -EINVAL;
+
+	req_payload = kzalloc(req_payload_size, GFP_KERNEL);
+
+	if (!req_payload)
+		return -ENOMEM;
+
+	req_payload->vmid = vmid;
+	req_payload->num_bytes = size;
+	memcpy(req_payload->data, buf, size);
+
+	ret = gh_rm_call(GH_RM_RPC_VM_CONSOLE_WRITE_ID,
+		   req_payload, req_payload_size,
+		   &resp, &resp_size);
+
+	kfree(req_payload);
+	if (!ret)
+		kfree(resp);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_console_write);
+
+/**
+ * gh_rm_console_flush() - Flush a console with a VM
+ * @vmid: The vmid of the vm whose console to flush
+ */
+int gh_rm_console_flush(u16 vmid)
+{
+	return gh_rm_common_vmid_call(GH_RM_RPC_VM_CONSOLE_FLUSH_ID, vmid);
+}
+EXPORT_SYMBOL_GPL(gh_rm_console_flush);
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index b3b37225b7fb..2a1a51299247 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -23,4 +23,22 @@ struct gh_rm_notification {
 int gh_rm_register_notifier(struct notifier_block *nb);
 int gh_rm_unregister_notifier(struct notifier_block *nb);
 
+/* Notification type Message IDs */
+#define GH_RM_NOTIF_VM_CONSOLE_CHARS	0x56100080
+
+struct gh_rm_notif_vm_console_chars {
+	u16 vmid;
+	u16 num_bytes;
+	u8 bytes[];
+} __packed;
+
+/* RPC Calls */
+int gh_rm_get_vmid(u16 *vmid);
+int gh_rm_console_open(u16 vmid);
+int gh_rm_console_close(u16 vmid);
+// Number of characters that can fit in a single RM message.
+#define GH_RM_CONSOLE_WRITE_CHARS	228
+int gh_rm_console_write(u16 vmid, const char *buf, size_t size);
+int gh_rm_console_flush(u16 vmid);
+
 #endif
-- 
2.25.1

