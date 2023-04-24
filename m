Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64886ED8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjDXXTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjDXXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:18:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853BABB95;
        Mon, 24 Apr 2023 16:17:50 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ON9lcq002645;
        Mon, 24 Apr 2023 23:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=9Q7OR+DluVdj2mndd6P0QHa5Z98U3fWWlKmdmsxu4Yo=;
 b=HNNO3nc+ScNPNF7MgGYc5KcOzgFsOnq/6vd6TFZ8dHfTeQeJFvOPGxq0DH94t1Mexmb+
 FUVeAOiY+6te5GfF7PsWQliziMi+jWjtBkSEygHPDR05ZpYUitkK2y1epZimwtGraTvO
 daffNTaHlLAtUPP4MBBxu7NTmjCKaFdwKU8cJ6zmFrUrypORcv5dG5vGzyW2QhXsfsIy
 h+eoY27/rC2K/AKEB2O8Zvac35BIwbI5seCGmnhKfshujK6OBJ+8dH+beOQwARNxAO1l
 R9KApxidXb7xodW/OonLnGZW2acQ0+Vz82BBA3iySRkKEsEbSYgYfjNjp+E49sQnEMl1 pw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5wrb0q29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:58 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ONGvUe024959
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:57 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 16:16:57 -0700
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
Subject: [PATCH v12 20/25] virt: gunyah: Add IO handlers
Date:   Mon, 24 Apr 2023 16:15:53 -0700
Message-ID: <20230424231558.70911-21-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: qKebh6LfZSgRAY4KcCh4GIEcxHm0adEH
X-Proofpoint-ORIG-GUID: qKebh6LfZSgRAY4KcCh4GIEcxHm0adEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/vm_mgr.c  | 104 ++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h  |   4 ++
 include/linux/gunyah_vm_mgr.h |  25 ++++++++
 3 files changed, 133 insertions(+)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 8fd59203792e..fa0c84f58b78 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -277,6 +277,108 @@ static void gh_vm_clean_resources(struct gh_vm *ghvm)
 	mutex_unlock(&ghvm->resources_lock);
 }
 
+static int _gh_vm_io_handler_compare(const struct rb_node *node, const struct rb_node *parent)
+{
+	struct gh_vm_io_handler *n = container_of(node, struct gh_vm_io_handler, node);
+	struct gh_vm_io_handler *p = container_of(parent, struct gh_vm_io_handler, node);
+
+	if (n->addr < p->addr)
+		return -1;
+	if (n->addr > p->addr)
+		return 1;
+	if ((n->len && !p->len) || (!n->len && p->len))
+		return 0;
+	if (n->len < p->len)
+		return -1;
+	if (n->len > p->len)
+		return 1;
+	/* one of the io handlers doesn't have datamatch and the other does.
+	 * For purposes of comparison, that makes them identical since the
+	 * one that doesn't have datamatch will cover the same handler that
+	 * does.
+	 */
+	if (n->datamatch != p->datamatch)
+		return 0;
+	if (n->data < p->data)
+		return -1;
+	if (n->data > p->data)
+		return 1;
+	return 0;
+}
+
+static int gh_vm_io_handler_compare(struct rb_node *node, const struct rb_node *parent)
+{
+	return _gh_vm_io_handler_compare(node, parent);
+}
+
+static int gh_vm_io_handler_find(const void *key, const struct rb_node *node)
+{
+	const struct gh_vm_io_handler *k = key;
+
+	return _gh_vm_io_handler_compare(&k->node, node);
+}
+
+static struct gh_vm_io_handler *gh_vm_mgr_find_io_hdlr(struct gh_vm *ghvm, u64 addr,
+								u64 len, u64 data)
+{
+	struct gh_vm_io_handler key = {
+		.addr = addr,
+		.len = len,
+		.datamatch = true,
+		.data = data,
+	};
+	struct rb_node *node;
+
+	node = rb_find(&key, &ghvm->mmio_handler_root, gh_vm_io_handler_find);
+	if (!node)
+		return NULL;
+
+	return container_of(node, struct gh_vm_io_handler, node);
+}
+
+int gh_vm_mmio_write(struct gh_vm *ghvm, u64 addr, u32 len, u64 data)
+{
+	struct gh_vm_io_handler *io_hdlr = NULL;
+	int ret;
+
+	down_read(&ghvm->mmio_handler_lock);
+	io_hdlr = gh_vm_mgr_find_io_hdlr(ghvm, addr, len, data);
+	if (!io_hdlr || !io_hdlr->ops || !io_hdlr->ops->write) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = io_hdlr->ops->write(io_hdlr, addr, len, data);
+
+out:
+	up_read(&ghvm->mmio_handler_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_vm_mmio_write);
+
+int gh_vm_add_io_handler(struct gh_vm *ghvm, struct gh_vm_io_handler *io_hdlr)
+{
+	struct rb_node *found;
+
+	if (io_hdlr->datamatch && (!io_hdlr->len || io_hdlr->len > sizeof(io_hdlr->data)))
+		return -EINVAL;
+
+	down_write(&ghvm->mmio_handler_lock);
+	found = rb_find_add(&io_hdlr->node, &ghvm->mmio_handler_root, gh_vm_io_handler_compare);
+	up_write(&ghvm->mmio_handler_lock);
+
+	return found ? -EEXIST : 0;
+}
+EXPORT_SYMBOL_GPL(gh_vm_add_io_handler);
+
+void gh_vm_remove_io_handler(struct gh_vm *ghvm, struct gh_vm_io_handler *io_hdlr)
+{
+	down_write(&ghvm->mmio_handler_lock);
+	rb_erase(&io_hdlr->node, &ghvm->mmio_handler_root);
+	up_write(&ghvm->mmio_handler_lock);
+}
+EXPORT_SYMBOL_GPL(gh_vm_remove_io_handler);
+
 static int gh_vm_rm_notification_status(struct gh_vm *ghvm, void *data)
 {
 	struct gh_rm_vm_status_payload *payload = data;
@@ -362,6 +464,8 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 	mutex_init(&ghvm->resources_lock);
 	INIT_LIST_HEAD(&ghvm->resources);
 	INIT_LIST_HEAD(&ghvm->resource_tickets);
+	init_rwsem(&ghvm->mmio_handler_lock);
+	ghvm->mmio_handler_root = RB_ROOT;
 	INIT_LIST_HEAD(&ghvm->functions);
 	ghvm->vm_status = GH_RM_VM_STATUS_NO_STATE;
 
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index e5e0c92d4cb1..3fc0f91dfd1a 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -56,10 +56,14 @@ struct gh_vm {
 	struct mutex resources_lock;
 	struct list_head resources;
 	struct list_head resource_tickets;
+	struct rb_root mmio_handler_root;
+	struct rw_semaphore mmio_handler_lock;
 };
 
 int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region);
 void gh_vm_mem_reclaim(struct gh_vm *ghvm);
 struct gh_vm_mem *gh_vm_mem_find_by_addr(struct gh_vm *ghvm, u64 guest_phys_addr, u32 size);
 
+int gh_vm_mmio_write(struct gh_vm *ghvm, u64 addr, u32 len, u64 data);
+
 #endif
diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
index 266b24579636..0a7687b0eb7d 100644
--- a/include/linux/gunyah_vm_mgr.h
+++ b/include/linux/gunyah_vm_mgr.h
@@ -96,4 +96,29 @@ struct gh_vm_resource_ticket {
 int gh_vm_add_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket);
 void gh_vm_remove_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket);
 
+/*
+ * gh_vm_io_handler contains the info about an io device and its associated
+ * addr and the ops associated with the io device.
+ */
+struct gh_vm_io_handler {
+	struct rb_node node;
+	u64 addr;
+
+	bool datamatch;
+	u8 len;
+	u64 data;
+	struct gh_vm_io_handler_ops *ops;
+};
+
+/*
+ * gh_vm_io_handler_ops contains function pointers associated with an iodevice.
+ */
+struct gh_vm_io_handler_ops {
+	int (*read)(struct gh_vm_io_handler *io_dev, u64 addr, u32 len, u64 data);
+	int (*write)(struct gh_vm_io_handler *io_dev, u64 addr, u32 len, u64 data);
+};
+
+int gh_vm_add_io_handler(struct gh_vm *ghvm, struct gh_vm_io_handler *io_dev);
+void gh_vm_remove_io_handler(struct gh_vm *ghvm, struct gh_vm_io_handler *io_dev);
+
 #endif
-- 
2.40.0

