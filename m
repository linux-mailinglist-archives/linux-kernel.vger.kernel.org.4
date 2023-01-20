Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5A46760C7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjATWuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjATWuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:50:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0296F3C284;
        Fri, 20 Jan 2023 14:49:25 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMQZ9F011386;
        Fri, 20 Jan 2023 22:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=iCSyjBfqrRmZK0zvAXu/cBR+A/KtRTfe11K5Ky0RinU=;
 b=eje28ZCyQhZNxdTrjsDv7isomZc2YgoaEDvwacerY6goFuevI0og85GYaSpKgHXqXOc0
 PEl/U2NuNNqu9VnKsP5T6A08AeaQDbDTT+IKOyD2dRVC4m9t4IMRSLsCxMdgGsQc2sYO
 MkKAvpCZV8V3m58HXG6szoqNOmhRlURVK1ruTA1V6Ko/akO7la68vq2K/si1IBBpSoeh
 Q4IuuEJmSL6Y7JKwnPadMuEkLW8/Ff8npiFen1NWgvLD4wDR2R80LxjbUkTa9NxxM1pY
 UlW0GvmBkq5dOmbtOSZylsST3aXPkSoU49NV+ojelVYYQQEKuoBqmoFNfCwuWP2gchpG 3g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7593uqyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:06 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMm5at029387
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:05 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:48:04 -0800
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
Subject: [PATCH v9 23/27] virt: gunyah: Add IO handlers
Date:   Fri, 20 Jan 2023 14:46:22 -0800
Message-ID: <20230120224627.4053418-24-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: A87Y_caG1S4FalvA4a7H7nv6B8QXsviN
X-Proofpoint-ORIG-GUID: A87Y_caG1S4FalvA4a7H7nv6B8QXsviN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301200218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add framework for VM functions to handle stage-2 write faults from Gunyah
guest virtual machines. IO handlers have a range of addresses which they
apply to. Optionally, they may apply to only when the value written
matches the IO handler's value.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c  | 85 +++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h  |  4 ++
 include/linux/gunyah_vm_mgr.h | 25 +++++++++++
 3 files changed, 114 insertions(+)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index ee593cf1b074..1dfe354bcc29 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -185,6 +185,91 @@ void ghvm_remove_resource_ticket(struct gunyah_vm *ghvm, struct gunyah_vm_resour
 }
 EXPORT_SYMBOL_GPL(ghvm_remove_resource_ticket);
 
+static inline bool gh_vm_io_handler_matches(struct gunyah_vm_io_handler *io_hdlr, u64 addr,
+						u64 len, u64 data)
+{
+	u64 mask = BIT_ULL(io_hdlr->len * BITS_PER_BYTE) - 1;
+
+	if (io_hdlr->addr != addr)
+		return false;
+
+	if (!io_hdlr->datamatch)
+		return true;
+
+	if (io_hdlr->len != len)
+		return false;
+
+	return (data & mask) == (io_hdlr->data & mask);
+}
+
+static struct gunyah_vm_io_handler *gh_vm_mgr_find_io_hdlr(struct gunyah_vm *ghvm, u64 addr,
+								u64 len, u64 data)
+{
+	struct gunyah_vm_io_handler *io_hdlr = NULL;
+	struct rb_node *root = NULL;
+
+	root = ghvm->mmio_handler_root.rb_node;
+	while (root) {
+		io_hdlr = rb_entry(root, struct gunyah_vm_io_handler, node);
+		if (addr < io_hdlr->addr)
+			root = root->rb_left;
+		else if (addr > io_hdlr->addr)
+			root = root->rb_right;
+		else if (gh_vm_io_handler_matches(io_hdlr, addr, len, data))
+			return io_hdlr;
+	}
+	return NULL;
+}
+
+int gh_vm_mgr_mmio_write(struct gunyah_vm *ghvm, u64 addr, u32 len, u64 data)
+{
+	struct gunyah_vm_io_handler *io_hdlr = NULL;
+
+	io_hdlr = gh_vm_mgr_find_io_hdlr(ghvm, addr, len, data);
+	if (!io_hdlr)
+		return -ENODEV;
+
+	if (io_hdlr->ops && io_hdlr->ops->write)
+		return io_hdlr->ops->write(io_hdlr, addr, len, data);
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(gh_vm_mgr_mmio_write);
+
+int gh_vm_mgr_add_io_handler(struct gunyah_vm *ghvm, struct gunyah_vm_io_handler *io_hdlr)
+{
+	struct rb_node **root, *parent = NULL;
+
+	if (io_hdlr->datamatch &&
+		(!io_hdlr->len || io_hdlr->len > (sizeof(io_hdlr->data) * BITS_PER_BYTE)))
+		return -EINVAL;
+
+	root = &ghvm->mmio_handler_root.rb_node;
+	while (*root) {
+		struct gunyah_vm_io_handler *curr = rb_entry(*root, struct gunyah_vm_io_handler,
+								node);
+
+		parent = *root;
+		if (io_hdlr->addr < curr->addr)
+			root = &((*root)->rb_left);
+		else if (io_hdlr->addr > curr->addr)
+			root = &((*root)->rb_right);
+		else
+			return -EEXIST;
+	}
+
+	rb_link_node(&io_hdlr->node, parent, root);
+	rb_insert_color(&io_hdlr->node, &ghvm->mmio_handler_root);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gh_vm_mgr_add_io_handler);
+
+void gh_vm_mgr_remove_io_handler(struct gunyah_vm *ghvm, struct gunyah_vm_io_handler *io_hdlr)
+{
+	rb_erase(&io_hdlr->node, &ghvm->mmio_handler_root);
+}
+EXPORT_SYMBOL_GPL(gh_vm_mgr_remove_io_handler);
+
 static void ghvm_put(struct kref *kref)
 {
 	struct gunyah_vm *ghvm = container_of(kref, struct gunyah_vm, kref);
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index f52350145010..eb17a2dda2a5 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -52,6 +52,8 @@ struct gunyah_vm {
 	struct list_head resources;
 	struct list_head resource_tickets;
 
+	struct rb_root mmio_handler_root;
+
 	struct list_head functions;
 };
 
@@ -62,4 +64,6 @@ struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct gunyah_vm *ghvm,
 struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find_mapping(struct gunyah_vm *ghvm,
 								u64 gpa, u32 size);
 
+int gh_vm_mgr_mmio_write(struct gunyah_vm *ghvm, u64 addr, u32 len, u64 data);
+
 #endif
diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
index 995a9b0eb6b7..dd719061f3bf 100644
--- a/include/linux/gunyah_vm_mgr.h
+++ b/include/linux/gunyah_vm_mgr.h
@@ -79,4 +79,29 @@ struct gunyah_vm_resource_ticket {
 int ghvm_add_resource_ticket(struct gunyah_vm *ghvm, struct gunyah_vm_resource_ticket *ticket);
 void ghvm_remove_resource_ticket(struct gunyah_vm *ghvm, struct gunyah_vm_resource_ticket *ticket);
 
+/*
+ * gunyah_vm_io_handler contains the info about an io device and its associated
+ * addr and the ops associated with the io device.
+ */
+struct gunyah_vm_io_handler {
+	struct rb_node node;
+	u64 addr;
+
+	bool datamatch;
+	u8 len;
+	u64 data;
+	struct gunyah_vm_io_handler_ops *ops;
+};
+
+/*
+ * gunyah_vm_io_handler_ops contains function pointers associated with an iodevice.
+ */
+struct gunyah_vm_io_handler_ops {
+	int (*read)(struct gunyah_vm_io_handler *io_dev, u64 addr, u32 len, u64 data);
+	int (*write)(struct gunyah_vm_io_handler *io_dev, u64 addr, u32 len, u64 data);
+};
+
+int gh_vm_mgr_add_io_handler(struct gunyah_vm *ghvm, struct gunyah_vm_io_handler *io_dev);
+void gh_vm_mgr_remove_io_handler(struct gunyah_vm *ghvm, struct gunyah_vm_io_handler *io_dev);
+
 #endif
-- 
2.39.0

