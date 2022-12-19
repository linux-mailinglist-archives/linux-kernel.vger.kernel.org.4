Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83DC651684
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiLSXFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiLSXD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:03:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B683167E8;
        Mon, 19 Dec 2022 15:01:09 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJMN9Wk027753;
        Mon, 19 Dec 2022 23:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=CEq8c94IBG6Nvn6CnZAOeBhIxN7kOp8McXlsMOcGt/E=;
 b=ZDrqc8PJ9eBpd3DhCkpHL8mw95krPSUw8tEyJeWctopdnojP7lQQkWAl7foR4X39MYkT
 4j0fO6QyLz1NkBM9v4lMGuCT+Q4R5QKVrZqxvhQYbwcGVDjtekt8WsgOF3rV2W2JuaJp
 N6j/9Yh0/114HXK03wG7WurEgfh7rzJiAmADpkjJpG5JlF2q4Gh/dvgcTwsiF2tatKan
 fyA5TnWVvVjMl/xT1jeWnl+ze9meK330aF6X65tVsbh29C7vkhkTWuRXhJDR6WJ2DAuP
 9hbumyWnrPghdhBjlHX3eUC0W/v7o0zdnnuqDSryCAhr9xlso6ujWFGZi8RuhVYv17Ng Jg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh34udrf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:50 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0n2W007943
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:49 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:48 -0800
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
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 23/28] virt: gunyah: Add resource tickets
Date:   Mon, 19 Dec 2022 14:58:44 -0800
Message-ID: <20221219225850.2397345-24-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4_OVl2SDQwk6HGf4b6SFB5ryrjLKLYYt
X-Proofpoint-GUID: 4_OVl2SDQwk6HGf4b6SFB5ryrjLKLYYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some VM functions need to acquire Gunyah resources. For instance, Gunyah
vCPUs are exposed to the host as a resource. The Gunyah vCPU function
will register a resource ticket and be able to interact with the
hypervisor once the resource ticket is filled.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c  | 93 ++++++++++++++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h  |  5 ++
 include/linux/gunyah.h        |  1 +
 include/linux/gunyah_vm_mgr.h | 14 ++++++
 4 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index a5bda4d6613b..3328b84fa681 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -115,6 +115,56 @@ static long gh_vm_add_function(struct gunyah_vm *ghvm, struct gunyah_vm_function
 	return r;
 }
 
+int ghvm_add_resource_ticket(struct gunyah_vm *ghvm, struct gunyah_vm_resource_ticket *ticket)
+{
+	struct gunyah_vm_resource_ticket *iter;
+	struct gunyah_resource *ghrsc;
+	int ret = 0;
+
+	mutex_lock(&ghvm->resources_lock);
+	list_for_each_entry(iter, &ghvm->resource_tickets, list) {
+		if (iter->resource_type == ticket->resource_type && iter->label == ticket->label) {
+			ret = -EEXIST;
+			goto out;
+		}
+	}
+
+	if (!try_module_get(ticket->owner)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	list_add(&ticket->list, &ghvm->resource_tickets);
+	INIT_LIST_HEAD(&ticket->resources);
+
+	list_for_each_entry(ghrsc, &ghvm->resources, list) {
+		if (ghrsc->type == ticket->resource_type && ghrsc->rm_label == ticket->label) {
+			if (!ticket->populate(ticket, ghrsc))
+				list_move(&ghrsc->list, &ticket->resources);
+		}
+	}
+out:
+	mutex_unlock(&ghvm->resources_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ghvm_add_resource_ticket);
+
+void ghvm_remove_resource_ticket(struct gunyah_vm *ghvm, struct gunyah_vm_resource_ticket *ticket)
+{
+	struct gunyah_resource *ghrsc;
+
+	mutex_lock(&ghvm->resources_lock);
+	list_for_each_entry(ghrsc, &ticket->resources, list) {
+		ticket->unpopulate(ticket, ghrsc);
+		list_move(&ghrsc->list, &ghvm->resources);
+	}
+
+	module_put(ticket->owner);
+	list_del(&ticket->list);
+	mutex_unlock(&ghvm->resources_lock);
+}
+EXPORT_SYMBOL_GPL(ghvm_remove_resource_ticket);
+
 static void ghvm_put(struct kref *kref)
 {
 	struct gunyah_vm *ghvm = container_of(kref, struct gunyah_vm, kref);
@@ -156,17 +206,41 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
 	INIT_LIST_HEAD(&ghvm->memory_mappings);
 	init_rwsem(&ghvm->status_lock);
 	kref_init(&ghvm->kref);
+	mutex_init(&ghvm->resources_lock);
+	INIT_LIST_HEAD(&ghvm->resources);
+	INIT_LIST_HEAD(&ghvm->resource_tickets);
 	INIT_LIST_HEAD(&ghvm->functions);
 
 	return ghvm;
 }
 
+static void gh_vm_add_resource(struct gunyah_vm *ghvm, struct gunyah_resource *ghrsc)
+{
+	struct gunyah_vm_resource_ticket *ticket;
+
+	mutex_lock(&ghvm->resources_lock);
+	list_for_each_entry(ticket, &ghvm->resource_tickets, list) {
+		if (ghrsc->type == ticket->resource_type && ghrsc->rm_label == ticket->label) {
+			if (!ticket->populate(ticket, ghrsc)) {
+				list_add(&ghrsc->list, &ticket->resources);
+				goto found;
+			}
+		}
+	}
+	list_add(&ghrsc->list, &ghvm->resources);
+found:
+	mutex_unlock(&ghvm->resources_lock);
+}
+
 static int gh_vm_start(struct gunyah_vm *ghvm)
 {
 	struct gunyah_vm_memory_mapping *mapping;
 	u64 dtb_offset;
 	u32 mem_handle;
-	int ret;
+	ssize_t num_hyp_resources;
+	struct gunyah_resource *ghrsc;
+	struct gh_rm_hyp_resource *resources;
+	int ret, i;
 
 	down_write(&ghvm->status_lock);
 	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE) {
@@ -198,6 +272,23 @@ static int gh_vm_start(struct gunyah_vm *ghvm)
 		goto err;
 	}
 
+	num_hyp_resources = gh_rm_get_hyp_resources(ghvm->rm, ghvm->vmid, &resources);
+	if (num_hyp_resources < 0) {
+		pr_warn("Failed to get hypervisor resources for VM: %ld\n", num_hyp_resources);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	for (i = 0; i < num_hyp_resources; i++) {
+		ghrsc = gh_rm_alloc_resource(ghvm->rm, &resources[i]);
+		if (!ghrsc) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		gh_vm_add_resource(ghvm, ghrsc);
+	}
+
 	ret = gh_rm_vm_start(ghvm->rm, ghvm->vmid);
 	if (ret) {
 		pr_warn("Failed to start VM: %d\n", ret);
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 2c4fd240792a..8a71f97960bc 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -7,6 +7,7 @@
 #define _GH_PRIV_VM_MGR_H
 
 #include <linux/gunyah_rsc_mgr.h>
+#include <linux/gunyah_vm_mgr.h>
 #include <linux/list.h>
 #include <linux/kref.h>
 #include <linux/miscdevice.h>
@@ -53,6 +54,10 @@ struct gunyah_vm {
 	struct mutex mm_lock;
 	struct list_head memory_mappings;
 
+	struct mutex resources_lock;
+	struct list_head resources;
+	struct list_head resource_tickets;
+
 	struct list_head functions;
 };
 
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 8cb6af88c75d..af69a3479025 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -28,6 +28,7 @@ struct gunyah_resource {
 	int irq;
 
 	/* To help allocator in resource manager */
+	struct list_head list;
 	u32 rm_label;
 };
 
diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
index 4bb06f100ae5..3e6e6e0ab7f0 100644
--- a/include/linux/gunyah_vm_mgr.h
+++ b/include/linux/gunyah_vm_mgr.h
@@ -65,4 +65,18 @@ void gunyah_vm_function_unregister(struct gunyah_vm_function_driver *f);
 	}								\
 	module_exit(_name##_mod_exit)
 
+struct gunyah_vm_resource_ticket {
+	struct list_head list;
+	struct list_head resources;
+	enum gunyah_resource_type resource_type;
+	u32 label;
+
+	struct module *owner;
+	int (*populate)(struct gunyah_vm_resource_ticket *ticket, struct gunyah_resource *ghrsc);
+	void (*unpopulate)(struct gunyah_vm_resource_ticket *ticket, struct gunyah_resource *ghrsc);
+};
+
+int ghvm_add_resource_ticket(struct gunyah_vm *ghvm, struct gunyah_vm_resource_ticket *ticket);
+void ghvm_remove_resource_ticket(struct gunyah_vm *ghvm, struct gunyah_vm_resource_ticket *ticket);
+
 #endif
-- 
2.25.1

