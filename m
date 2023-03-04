Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B656AA713
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 02:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCDBIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 20:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjCDBIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 20:08:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE5967803;
        Fri,  3 Mar 2023 17:07:42 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3238mIJu007928;
        Sat, 4 Mar 2023 01:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=/VCX+yqz/ho1pAOqIOYfJGpNKwtPtomBUY+Aoh/O+TI=;
 b=UnEHWhCGXHoSs7qcIhC36RmNXdsseY0gRIJDjDz0Tc0NXEZr0sNwGpwqFIXCLqgT/dBn
 YsHVr6QMe9ZQWwAmlvXCXD8jOCxG0UyrN2fobJyLIPeZNQD671I+ANODqIxMs9KW9nJx
 oZYXwJjPzHbfQ+9zpDn3lSJTw4Xm0wG2JRQ4OBqMwXakvt2tkKl53AX5B11m9m31pBGM
 HeAuYpi9sLV1RWx64lGpg8AMwmS0o7UlZnbULPbg+3TOC9ZSd14MEBRKx/OL85/N6bFg
 Dou3v5oEsZ7WZ2B0OaOFkaQY0kWu2W9MksOR/AGt961cS5O5HTmd/Be/1NZOlgosE3Sq EA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3dpxjjcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Mar 2023 01:07:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32417EnF028975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 4 Mar 2023 01:07:14 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 3 Mar 2023 17:07:13 -0800
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
Subject: [PATCH v11 20/26] virt: gunyah: Add resource tickets
Date:   Fri, 3 Mar 2023 17:06:26 -0800
Message-ID: <20230304010632.2127470-21-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304010632.2127470-1-quic_eberman@quicinc.com>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eyLziE9DYf1WbGWtvtPkVm5QrPjY-rYr
X-Proofpoint-GUID: eyLziE9DYf1WbGWtvtPkVm5QrPjY-rYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_07,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303040004
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
 drivers/virt/gunyah/vm_mgr.c  | 112 +++++++++++++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h  |   4 ++
 include/linux/gunyah_vm_mgr.h |  14 +++++
 3 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 88db011395ec..0269bcdaf692 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -165,6 +165,74 @@ static long gh_vm_rm_function(struct gh_vm *ghvm, struct gh_fn_desc *f)
 	return r;
 }
 
+int gh_vm_add_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket)
+{
+	struct gh_vm_resource_ticket *iter;
+	struct gh_resource *ghrsc;
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
+	struct gh_resource *ghrsc, *iter;
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
+static void gh_vm_add_resource(struct gh_vm *ghvm, struct gh_resource *ghrsc)
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
@@ -230,6 +298,8 @@ static void gh_vm_free(struct work_struct *work)
 {
 	struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
 	struct gh_vm_function_instance *inst, *iiter;
+	struct gh_vm_resource_ticket *ticket, *titer;
+	struct gh_resource *ghrsc, *riter;
 	struct gh_vm_mem *mapping, *tmp;
 	int ret;
 
@@ -246,6 +316,25 @@ static void gh_vm_free(struct work_struct *work)
 		}
 		mutex_unlock(&ghvm->fn_lock);
 
+		mutex_lock(&ghvm->resources_lock);
+		if (!list_empty(&ghvm->resource_tickets)) {
+			dev_warn(ghvm->parent, "Dangling resource tickets:\n");
+			list_for_each_entry_safe(ticket, titer, &ghvm->resource_tickets, list) {
+				dev_warn(ghvm->parent, "  %pS\n", ticket->populate);
+				gh_vm_remove_resource_ticket(ghvm, ticket);
+			}
+		}
+
+		list_for_each_entry_safe(ghrsc, riter, &ghvm->resources, list) {
+			gh_rm_free_resource(ghrsc);
+		}
+		mutex_unlock(&ghvm->resources_lock);
+
+		ret = gh_rm_vm_reset(ghvm->rm, ghvm->vmid);
+		if (ret)
+			dev_err(ghvm->parent, "Failed to reset the vm: %d\n", ret);
+		wait_event(ghvm->vm_status_wait, ghvm->vm_status == GH_RM_VM_STATUS_RESET);
+
 		mutex_lock(&ghvm->mm_lock);
 		list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
 			gh_vm_mem_reclaim(ghvm, mapping);
@@ -329,6 +418,9 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 	init_rwsem(&ghvm->status_lock);
 	INIT_WORK(&ghvm->free_work, gh_vm_free);
 	kref_init(&ghvm->kref);
+	mutex_init(&ghvm->resources_lock);
+	INIT_LIST_HEAD(&ghvm->resources);
+	INIT_LIST_HEAD(&ghvm->resource_tickets);
 	INIT_LIST_HEAD(&ghvm->functions);
 	ghvm->vm_status = GH_RM_VM_STATUS_LOAD;
 
@@ -338,9 +430,11 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
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
 	if (ghvm->vm_status != GH_RM_VM_STATUS_LOAD) {
@@ -394,6 +488,22 @@ static int gh_vm_start(struct gh_vm *ghvm)
 		goto err;
 	}
 
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
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 7bd271bad721..18d0e1effd25 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -7,6 +7,7 @@
 #define _GH_PRIV_VM_MGR_H
 
 #include <linux/gunyah_rsc_mgr.h>
+#include <linux/gunyah_vm_mgr.h>
 #include <linux/list.h>
 #include <linux/kref.h>
 #include <linux/miscdevice.h>
@@ -51,6 +52,9 @@ struct gh_vm {
 	struct list_head memory_mappings;
 	struct mutex fn_lock;
 	struct list_head functions;
+	struct mutex resources_lock;
+	struct list_head resources;
+	struct list_head resource_tickets;
 };
 
 int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region);
diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
index 3825c951790a..01b1761b5923 100644
--- a/include/linux/gunyah_vm_mgr.h
+++ b/include/linux/gunyah_vm_mgr.h
@@ -70,4 +70,18 @@ void gh_vm_function_unregister(struct gh_vm_function *f);
 	DECLARE_GH_VM_FUNCTION(_name, _type, _bind, _unbind);	\
 	module_gh_vm_function(_name)
 
+struct gh_vm_resource_ticket {
+	struct list_head list; /* for gh_vm's resources list */
+	struct list_head resources; /* for gh_resources's list */
+	enum gh_resource_type resource_type;
+	u32 label;
+
+	struct module *owner;
+	int (*populate)(struct gh_vm_resource_ticket *ticket, struct gh_resource *ghrsc);
+	void (*unpopulate)(struct gh_vm_resource_ticket *ticket, struct gh_resource *ghrsc);
+};
+
+int gh_vm_add_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket);
+void gh_vm_remove_resource_ticket(struct gh_vm *ghvm, struct gh_vm_resource_ticket *ticket);
+
 #endif
-- 
2.39.2

