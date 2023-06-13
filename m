Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A447672E995
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbjFMRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbjFMRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:23:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E77A213B;
        Tue, 13 Jun 2023 10:22:15 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DAcSO0013828;
        Tue, 13 Jun 2023 17:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=2OkUID34BeYflc/zrfAetQILUsMucg1FpZUzkaqznGs=;
 b=FGBF7C9kzILd/1/Vwzp6VbHxRiUuQVNLJ37mfy2jbl9t6V6P+il9Hz10vj0zYpDI9aMh
 B5J7kxF9GPJWQ0rQLG3RFwekEZfPZI1SHAFFNSsVlyfiDLyGSholWqnEwKhAIfXdgcWs
 xlAUqbagMI6nVMBK/gt4Uj8akpWw5nNiOWgpbSwk7IyLrOgw4pe7cnEdlXjLlekSsl9B
 UZs4Ld8z3F2X+ZvEPkNNJwURn36vHjfoJPBkM6Xt/Yftg3RgdDY9dqrX3uvcXFAYw7G+
 SI/ILoJD6h6FFPKAuFDyFksSPDLL08Tk2cmu1sKaxd8iHJT0XdQmMum9gPCI86AmlzpQ 2w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6km41d54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:49 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DHLncn004530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:49 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 10:21:48 -0700
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
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v14 19/25] virt: gunyah: Add resource tickets
Date:   Tue, 13 Jun 2023 10:20:47 -0700
Message-ID: <20230613172054.3959700-20-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230613172054.3959700-1-quic_eberman@quicinc.com>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JL4NrveqiZ26zxkNvTOAO2zHPx0gTD42
X-Proofpoint-GUID: JL4NrveqiZ26zxkNvTOAO2zHPx0gTD42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306130153
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c  | 117 +++++++++++++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h  |   4 ++
 include/linux/gunyah_vm_mgr.h |  31 +++++++++
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index cfd79bc9900fd..d6aa1731148ae 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -183,6 +183,99 @@ void gh_vm_function_unregister(struct gh_vm_function *fn)
 }
 EXPORT_SYMBOL_GPL(gh_vm_function_unregister);
 
+int gh_vm_add_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket)
+{
+	struct gh_vm_resource_ticket *iter;
+	struct gh_resource *ghrsc, *rsc_iter;
+	int ret = 0;
+
+	mutex_lock(&ghvm->resources_lock);
+	list_for_each_entry(iter, &ghvm->resource_tickets, vm_list) {
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
+	list_add(&ticket->vm_list, &ghvm->resource_tickets);
+	INIT_LIST_HEAD(&ticket->resources);
+
+	list_for_each_entry_safe(ghrsc, rsc_iter, &ghvm->resources, list) {
+		if (ghrsc->type == ticket->resource_type && ghrsc->rm_label == ticket->label) {
+			if (ticket->populate(ticket, ghrsc))
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
+	struct gh_resource *ghrsc, *iter;
+
+	mutex_lock(&ghvm->resources_lock);
+	list_for_each_entry_safe(ghrsc, iter, &ticket->resources, list) {
+		ticket->unpopulate(ticket, ghrsc);
+		list_move(&ghrsc->list, &ghvm->resources);
+	}
+
+	module_put(ticket->owner);
+	list_del(&ticket->vm_list);
+	mutex_unlock(&ghvm->resources_lock);
+}
+EXPORT_SYMBOL_GPL(gh_vm_remove_resource_ticket);
+
+static void gh_vm_add_resource(struct gh_vm *ghvm, struct gh_resource *ghrsc)
+{
+	struct gh_vm_resource_ticket *ticket;
+
+	mutex_lock(&ghvm->resources_lock);
+	list_for_each_entry(ticket, &ghvm->resource_tickets, vm_list) {
+		if (ghrsc->type == ticket->resource_type && ghrsc->rm_label == ticket->label) {
+			if (ticket->populate(ticket, ghrsc))
+				list_add(&ghrsc->list, &ticket->resources);
+			else
+				list_add(&ghrsc->list, &ghvm->resources);
+			/* unconditonal -- we prevent multiple identical
+			 * resource tickets so there will not be some other
+			 * ticket elsewhere in the list if populate() failed.
+			 */
+			goto found;
+		}
+	}
+	list_add(&ghrsc->list, &ghvm->resources);
+found:
+	mutex_unlock(&ghvm->resources_lock);
+}
+
+static void gh_vm_clean_resources(struct gh_vm *ghvm)
+{
+	struct gh_vm_resource_ticket *ticket, *titer;
+	struct gh_resource *ghrsc, *riter;
+
+	mutex_lock(&ghvm->resources_lock);
+	if (!list_empty(&ghvm->resource_tickets)) {
+		dev_warn(ghvm->parent, "Dangling resource tickets:\n");
+		list_for_each_entry_safe(ticket, titer, &ghvm->resource_tickets, vm_list) {
+			dev_warn(ghvm->parent, "  %pS\n", ticket->populate);
+			gh_vm_remove_resource_ticket(ghvm, ticket);
+		}
+	}
+
+	list_for_each_entry_safe(ghrsc, riter, &ghvm->resources, list) {
+		gh_rm_free_resource(ghrsc);
+	}
+	mutex_unlock(&ghvm->resources_lock);
+}
+
 static int gh_vm_rm_notification_status(struct gh_vm *ghvm, void *data)
 {
 	struct gh_rm_vm_status_payload *payload = data;
@@ -265,6 +358,9 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 	init_waitqueue_head(&ghvm->vm_status_wait);
 	INIT_WORK(&ghvm->free_work, gh_vm_free);
 	kref_init(&ghvm->kref);
+	mutex_init(&ghvm->resources_lock);
+	INIT_LIST_HEAD(&ghvm->resources);
+	INIT_LIST_HEAD(&ghvm->resource_tickets);
 	INIT_LIST_HEAD(&ghvm->functions);
 	ghvm->vm_status = GH_RM_VM_STATUS_NO_STATE;
 
@@ -274,9 +370,11 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 static int gh_vm_start(struct gh_vm *ghvm)
 {
 	struct gh_vm_mem *mapping;
+	struct gh_rm_hyp_resources *resources;
+	struct gh_resource *ghrsc;
 	u64 dtb_offset;
 	u32 mem_handle;
-	int ret;
+	int ret, i, n;
 
 	down_write(&ghvm->status_lock);
 	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE) {
@@ -336,6 +434,22 @@ static int gh_vm_start(struct gh_vm *ghvm)
 	}
 	ghvm->vm_status = GH_RM_VM_STATUS_READY;
 
+	ret = gh_rm_get_hyp_resources(ghvm->rm, ghvm->vmid, &resources);
+	if (ret) {
+		dev_warn(ghvm->parent, "Failed to get hypervisor resources for VM: %d\n", ret);
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
 		dev_warn(ghvm->parent, "Failed to start VM: %d\n", ret);
@@ -457,6 +571,7 @@ static void gh_vm_free(struct work_struct *work)
 		gh_vm_stop(ghvm);
 
 	gh_vm_remove_functions(ghvm);
+	gh_vm_clean_resources(ghvm);
 
 	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE &&
 	    ghvm->vm_status != GH_RM_VM_STATUS_LOAD &&
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index c4bec1469ae8c..e5e0c92d4cb12 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -7,6 +7,7 @@
 #define _GH_VM_MGR_H
 
 #include <linux/gunyah_rsc_mgr.h>
+#include <linux/gunyah_vm_mgr.h>
 #include <linux/list.h>
 #include <linux/kref.h>
 #include <linux/miscdevice.h>
@@ -52,6 +53,9 @@ struct gh_vm {
 	struct list_head memory_mappings;
 	struct mutex fn_lock;
 	struct list_head functions;
+	struct mutex resources_lock;
+	struct list_head resources;
+	struct list_head resource_tickets;
 };
 
 int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region);
diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
index 6e4dd6fa5f96d..af97fec9e2ef5 100644
--- a/include/linux/gunyah_vm_mgr.h
+++ b/include/linux/gunyah_vm_mgr.h
@@ -94,4 +94,35 @@ void gh_vm_function_unregister(struct gh_vm_function *f);
 	module_gh_vm_function(_name);							\
 	MODULE_ALIAS_GH_VM_FUNCTION(_type, _idx)
 
+/**
+ * struct gh_vm_resource_ticket - Represents a ticket to reserve exclusive access to VM resource(s)
+ * @vm_list: for @gh_vm->resource_tickets
+ * @resources: List of resource(s) associated with this ticket(members are from @gh_resource->list)
+ * @resource_type: Type of resource this ticket reserves
+ * @label: Label of the resource from resource manager this ticket reserves.
+ * @owner: owner of the ticket
+ * @populate: callback provided by the ticket owner and called when a resource is found that
+ *            matches @resource_type and @label. Note that this callback could be called
+ *            multiple times if userspace created mutliple resources with the same type/label.
+ *            This callback may also have significant delay after gh_vm_add_resource_ticket()
+ *            since gh_vm_add_resource_ticket() could be called before the VM starts.
+ * @unpopulate: callback provided by the ticket owner and called when the ticket owner should no
+ *              no longer use the resource provided in the argument. When unpopulate() returns,
+ *              the ticket owner should not be able to use the resource any more as the resource
+ *              might being freed.
+ */
+struct gh_vm_resource_ticket {
+	struct list_head vm_list;
+	struct list_head resources;
+	enum gh_resource_type resource_type;
+	u32 label;
+
+	struct module *owner;
+	bool (*populate)(struct gh_vm_resource_ticket *ticket, struct gh_resource *ghrsc);
+	void (*unpopulate)(struct gh_vm_resource_ticket *ticket, struct gh_resource *ghrsc);
+};
+
+int gh_vm_add_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket);
+void gh_vm_remove_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket);
+
 #endif
-- 
2.40.0

