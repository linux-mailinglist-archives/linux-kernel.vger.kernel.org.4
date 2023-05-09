Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67AE6FD032
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjEIUvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjEIUvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:51:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DBB7D8B;
        Tue,  9 May 2023 13:50:02 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349JQGa8024422;
        Tue, 9 May 2023 20:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=TMDnpvWgz74ga2+3hPMl/XoAM0CkED5BB/wCo9kJmcM=;
 b=hgssLACqBB8Xd3Tqvg2BbwRSe0BjaD6W52Sj+XQs//7Sf+5bxzzy+u8+yC5rCZuXGTl/
 mU4KgpDps3Qp9CoWUp2xpxl6z3s5k6cUmrfpbB+X94qhbv7VfGdl/h1QZKXgwq8jzFf6
 2HV6RlmllUOmXih7TF+5drbtCZgqzeIXY9zuCWCUKLpq/ab3mN5GliUMMTt3mubKzIQR
 8jGII51fB6X94P0Pa4AV74I2oeXl8Anw1VT2oXxYJuu66Hsj/SFTdbuveBxYvA2oDptV
 h96Te5hfEII7gMIhNSScdX4rq+rIGXyQJNmENMuIz5UPxU3BwgObyvNbz22GrGnahAVt kw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77g2v6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 20:49:21 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349KnK0J003154
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 20:49:20 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 13:49:19 -0700
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
Subject: [PATCH v13 19/24] virt: gunyah: Add IO handlers
Date:   Tue, 9 May 2023 13:47:56 -0700
Message-ID: <20230509204801.2824351-20-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230509204801.2824351-1-quic_eberman@quicinc.com>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: POLcyTH-tsXSgDza2gmnfEun7qwoDJHp
X-Proofpoint-ORIG-GUID: POLcyTH-tsXSgDza2gmnfEun7qwoDJHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090171
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index 6228090aceb6..81b42ab675f6 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -279,6 +279,108 @@ static void gh_vm_clean_resources(struct gh_vm *ghvm)
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
@@ -364,6 +466,8 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
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
index e3a6666d7529..0fa3cf6bcaca 100644
--- a/include/linux/gunyah_vm_mgr.h
+++ b/include/linux/gunyah_vm_mgr.h
@@ -98,4 +98,29 @@ struct gh_vm_resource_ticket {
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

