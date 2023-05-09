Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9696FD037
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjEIUwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjEIUv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:51:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D925BAA;
        Tue,  9 May 2023 13:50:13 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349JShdM024708;
        Tue, 9 May 2023 20:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=2qDSzniWwTVC3bN+E8VB5M/5pNJLJi7nSoxqf0LZuaI=;
 b=BFSbZUvU9cnhFdgp2ZRfNAU6LW/6mN8bGZc0xV23i80B50cvtH+7ZmGRx8S68jLJllGt
 h1OIGa4OiEGkFo15u4/84HrI8S8KMbhTtRPIhKnAjJR9R8vg5xSMRZP6V6MgG5oO/NIb
 F6qJyGEBs7fQ7qQcWP7X7S3hapKkLyBtV9iNCcDTB7RIugUm2zgfe8T51wa6L3jrAqzV
 Wty6pceUU6HhBbTOxP6WU4EEbLeKgvT40PgBA3Jg35rN0aT2iTFVUH9Ny4JO+clLH9tc
 4/u+n+kpMqzR7zQVq/Yhi9kMWKJQLUsSlT1PWw5flHlXD4vS2GKUC1fDr3psoitPufus 2w== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfr508tc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 20:49:20 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349KnJYi003145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 20:49:19 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 13:49:18 -0700
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
Subject: [PATCH v13 18/24] virt: gunyah: Add resource tickets
Date:   Tue, 9 May 2023 13:47:55 -0700
Message-ID: <20230509204801.2824351-19-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: 5bGx_nl9kc_bGqFFiriZAF1fIlgLTg69
X-Proofpoint-ORIG-GUID: 5bGx_nl9kc_bGqFFiriZAF1fIlgLTg69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
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
 drivers/virt/gunyah/vm_mgr.c  | 117 +++++++++++++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h  |   4 ++
 include/linux/gunyah_vm_mgr.h |  14 ++++
 3 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 56464451b262..6228090aceb6 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -186,6 +186,99 @@ void gh_vm_function_unregister(struct gh_vm_function *fn)
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
@@ -268,6 +361,9 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 	init_waitqueue_head(&ghvm->vm_status_wait);
 	INIT_WORK(&ghvm->free_work, gh_vm_free);
 	kref_init(&ghvm->kref);
+	mutex_init(&ghvm->resources_lock);
+	INIT_LIST_HEAD(&ghvm->resources);
+	INIT_LIST_HEAD(&ghvm->resource_tickets);
 	INIT_LIST_HEAD(&ghvm->functions);
 	ghvm->vm_status = GH_RM_VM_STATUS_NO_STATE;
 
@@ -277,9 +373,11 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
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
@@ -339,6 +437,22 @@ static int gh_vm_start(struct gh_vm *ghvm)
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
@@ -460,6 +574,7 @@ static void gh_vm_free(struct work_struct *work)
 		gh_vm_stop(ghvm);
 
 	gh_vm_remove_functions(ghvm);
+	gh_vm_clean_resources(ghvm);
 
 	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE &&
 	    ghvm->vm_status != GH_RM_VM_STATUS_LOAD &&
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index c4bec1469ae8..e5e0c92d4cb1 100644
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
index 1f0dc43ade50..e3a6666d7529 100644
--- a/include/linux/gunyah_vm_mgr.h
+++ b/include/linux/gunyah_vm_mgr.h
@@ -84,4 +84,18 @@ void gh_vm_function_unregister(struct gh_vm_function *f);
 	module_gh_vm_function(_name);							\
 	MODULE_ALIAS_GH_VM_FUNCTION(_type, _idx)
 
+struct gh_vm_resource_ticket {
+	struct list_head vm_list; /* for gh_vm's resource tickets list */
+	struct list_head resources; /* resources associated with this ticket */
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

