Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBD7696F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjBNV1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjBNV1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:27:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180122FCE2;
        Tue, 14 Feb 2023 13:27:05 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EKidC4012731;
        Tue, 14 Feb 2023 21:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=zqGbikFIIa2m+Gc6+asp0mxiTKZjbfNd8w4T+3IJz6o=;
 b=f1otfkkXBDniANCdcPdoIBE9ij8/5ag/W2riUvsMSYeezVQZne2nTGvNaoBMHeCED6LA
 wWeYziLLaKiOI6dGvk//XD/nnIa9b681jVHzPqEHJO0LSlOAuOS0zK9iyUHrIDybsKEW
 OF5S0sywDLq0XI5iQffAvIYOuAyAb/Z/TP29RENJZM/u/ChgaW3f8GBJVJ+wVxYOO2XY
 zDzLfbRF6mb5ZrIBIE4gKmRi4x50t6kuVjxR/GO+WnsBfMGpKUiIdB1YisvG/MsgSnZR
 +pSnGXtawb63qqt6pyWnPwZgvThnNrgZkZT+UZDF70V4zFT0QYoE0MPyknoBCAIOiAM6 2A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqpmmm1yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:25:53 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ELPqIt028542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:25:52 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 13:25:51 -0800
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v10 20/26] virt: gunyah: Add resource tickets
Date:   Tue, 14 Feb 2023 13:25:40 -0800
Message-ID: <20230214212540.3324345-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214211229.3239350-1-quic_eberman@quicinc.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wVUxHGU_83jb-A6eB3GNYXE34WgMsOsh
X-Proofpoint-GUID: wVUxHGU_83jb-A6eB3GNYXE34WgMsOsh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some VM functions need to acquire Gunyah resources. For instance, Gunyah
vCPUs are exposed to the host as a resource. The Gunyah vCPU function
will register a resource ticket and be able to interact with the
hypervisor once the resource ticket is filled.

Resource tickets are the mechanism for functions to acquire ownership of
Gunyah resources. Gunyah functions can be created before the VM's
resources are created and made available to Linux. A resource ticket
identifies a type of resource and a label of a resource which the ticket
holder is interested in.

Resources are created by Gunyah as configured in the VM's devicetree
configuration. Gunyah doesn't process the label and that makes it
possible for userspace to create multiple resources with the same label.
Resource ticket owners need to be prepared for populate to be called
multiple times if userspace created multiple resources with the same
label.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c  | 110 +++++++++++++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h  |   4 ++
 include/linux/gunyah_vm_mgr.h |  14 +++++
 3 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index e9c55e7dd1b3..7190107a6a0d 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -189,6 +189,74 @@ static long gh_vm_rm_function(struct gh_vm *ghvm, struct gh_fn_desc *f)
 	return r;
 }
 
+int gh_vm_add_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket)
+{
+	struct gh_vm_resource_ticket *iter;
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
+EXPORT_SYMBOL_GPL(gh_vm_add_resource_ticket);
+
+void gh_vm_remove_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket)
+{
+	struct gunyah_resource *ghrsc, *iter;
+
+	mutex_lock(&ghvm->resources_lock);
+	list_for_each_entry_safe(ghrsc, iter, &ticket->resources, list) {
+		ticket->unpopulate(ticket, ghrsc);
+		list_move(&ghrsc->list, &ghvm->resources);
+	}
+
+	module_put(ticket->owner);
+	list_del(&ticket->list);
+	mutex_unlock(&ghvm->resources_lock);
+}
+EXPORT_SYMBOL_GPL(gh_vm_remove_resource_ticket);
+
+static void gh_vm_add_resource(struct gh_vm *ghvm, struct gunyah_resource *ghrsc)
+{
+	struct gh_vm_resource_ticket *ticket;
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
 static int gh_vm_rm_notification_status(struct gh_vm *ghvm, void *data)
 {
 	struct gh_rm_vm_status_payload *payload = data;
@@ -254,6 +322,8 @@ static void gh_vm_free(struct work_struct *work)
 {
 	struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
 	struct gh_vm_function_instance *inst, *iiter;
+	struct gh_vm_resource_ticket *ticket, *titer;
+	struct gunyah_resource *ghrsc, *riter;
 	struct gh_vm_mem *mapping, *tmp;
 	int ret;
 
@@ -271,6 +341,23 @@ static void gh_vm_free(struct work_struct *work)
 		}
 		mutex_unlock(&functions_lock);
 
+		if (!list_empty(&ghvm->resource_tickets)) {
+			pr_warn("Dangling resource tickets:\n");
+			list_for_each_entry_safe(ticket, titer, &ghvm->resource_tickets, list) {
+				pr_warn("  %pS\n", ticket->populate);
+				gh_vm_remove_resource_ticket(ghvm, ticket);
+			}
+		}
+
+		list_for_each_entry_safe(ghrsc, riter, &ghvm->resources, list) {
+			gh_rm_free_resource(ghrsc);
+		}
+
+		ret = gh_rm_vm_reset(ghvm->rm, ghvm->vmid);
+		if (ret)
+			pr_err("Failed to reset the vm: %d\n", ret);
+		wait_event(ghvm->vm_status_wait, ghvm->vm_status == GH_RM_VM_STATUS_RESET);
+
 		mutex_lock(&ghvm->mm_lock);
 		list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
 			gh_vm_mem_reclaim(ghvm, mapping);
@@ -350,6 +437,9 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 	init_rwsem(&ghvm->status_lock);
 	INIT_WORK(&ghvm->free_work, gh_vm_free);
 	kref_init(&ghvm->kref);
+	mutex_init(&ghvm->resources_lock);
+	INIT_LIST_HEAD(&ghvm->resources);
+	INIT_LIST_HEAD(&ghvm->resource_tickets);
 	INIT_LIST_HEAD(&ghvm->functions);
 	ghvm->vm_status = GH_RM_VM_STATUS_LOAD;
 
@@ -359,9 +449,11 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 static int gh_vm_start(struct gh_vm *ghvm)
 {
 	struct gh_vm_mem *mapping;
+	struct gh_rm_hyp_resources *resources;
+	struct gunyah_resource *ghrsc;
 	u64 dtb_offset;
 	u32 mem_handle;
-	int ret;
+	int ret, i, n;
 
 	down_write(&ghvm->status_lock);
 	if (ghvm->vm_status != GH_RM_VM_STATUS_LOAD) {
@@ -412,6 +504,22 @@ static int gh_vm_start(struct gh_vm *ghvm)
 		goto err;
 	}
 
+	ret = gh_rm_get_hyp_resources(ghvm->rm, ghvm->vmid, &resources);
+	if (ret) {
+		pr_warn("Failed to get hypervisor resources for VM: %d\n", ret);
+		goto err;
+	}
+
+	for (i = 0, n = le32_to_cpu(resources->n_entries); i < n; i++) {
+		ghrsc = gh_rm_alloc_resource(ghvm->rm, &resources->entries[i]);
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
index 4750d56c1297..56ae97d752d6 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -7,6 +7,7 @@
 #define _GH_PRIV_VM_MGR_H
 
 #include <linux/gunyah_rsc_mgr.h>
+#include <linux/gunyah_vm_mgr.h>
 #include <linux/list.h>
 #include <linux/kref.h>
 #include <linux/miscdevice.h>
@@ -49,6 +50,9 @@ struct gh_vm {
 	struct mutex mm_lock;
 	struct list_head memory_mappings;
 	struct list_head functions;
+	struct mutex resources_lock;
+	struct list_head resources;
+	struct list_head resource_tickets;
 };
 
 int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region);
diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
index f0a95af50b2e..84579150d6bc 100644
--- a/include/linux/gunyah_vm_mgr.h
+++ b/include/linux/gunyah_vm_mgr.h
@@ -77,4 +77,18 @@ void gh_vm_function_unregister(struct gh_vm_function *f);
 	DECLARE_GUNYAH_VM_FUNCTION(_name, _type, _bind, _unbind);	\
 	module_gunyah_vm_function(_name)
 
+struct gh_vm_resource_ticket {
+	struct list_head list; /* for gh_vm's resources list */
+	struct list_head resources; /* for gunyah_resources's list */
+	enum gunyah_resource_type resource_type;
+	u32 label;
+
+	struct module *owner;
+	int (*populate)(struct gh_vm_resource_ticket *ticket, struct gunyah_resource *ghrsc);
+	void (*unpopulate)(struct gh_vm_resource_ticket *ticket, struct gunyah_resource *ghrsc);
+};
+
+int gh_vm_add_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket);
+void gh_vm_remove_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket);
+
 #endif
-- 
2.39.1

