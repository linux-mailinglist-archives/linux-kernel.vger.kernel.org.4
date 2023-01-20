Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E004676148
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjATXM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjATXM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:12:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A0139BB2;
        Fri, 20 Jan 2023 15:12:55 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMDFiY020834;
        Fri, 20 Jan 2023 22:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=7HbBt3e0a1vAlc9eCKkIzVLn1j5GxGmq0P3U4Vw3h48=;
 b=ZN9RAm/VAbnLc4zWttEDFDOsbtzD6gDxw7/fXXnQFtwtuktwIxFlQ3T3+MCeeo3l8vsA
 4qPXBwfCV5/58CSSGHF3dg9N0kSEgOIBP2bQVk3YMOGLHSH2R+YsT1pyzvR4YYsagHoM
 tW6cuKX2GXhwldS4bZpQMu9WGEuIf9YNGNJBxAikOrmTfkKWWM9eHzjRpm8C+METidgI
 eqCKysPkJtNygXf+tYMNrNfbIdQ6TOHkPbKSzESwf112nzwUFlJtTAEDw6ZgIqj9XwJO
 rEsZq0i8KsJpRIcAfFsSHbmWzfda7MuIiuZ5yy9Rl2oyPGO8oanmSIpzUNYqatad5dYq WQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n81yq062k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMm4MA024424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:04 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:48:03 -0800
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
Subject: [PATCH v9 22/27] virt: gunyah: Add resource tickets
Date:   Fri, 20 Jan 2023 14:46:21 -0800
Message-ID: <20230120224627.4053418-23-quic_eberman@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1B8-ZnTqIwdwSlHPVIzxct3lZ3qbYisu
X-Proofpoint-GUID: 1B8-ZnTqIwdwSlHPVIzxct3lZ3qbYisu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200218
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

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c  | 105 +++++++++++++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h  |   5 ++
 include/linux/gunyah.h        |   4 ++
 include/linux/gunyah_vm_mgr.h |  14 +++++
 4 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 1e795f3d19d5..ee593cf1b074 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -135,6 +135,56 @@ static long gh_vm_rm_function(struct gunyah_vm *ghvm, struct gh_vm_function *fn)
 	return 0;
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
+EXPORT_SYMBOL_GPL(ghvm_remove_resource_ticket);
+
 static void ghvm_put(struct kref *kref)
 {
 	struct gunyah_vm *ghvm = container_of(kref, struct gunyah_vm, kref);
@@ -180,17 +230,40 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm *rm)
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
+	struct gunyah_resource *ghrsc;
+	struct gh_rm_hyp_resources *resources;
+	int ret, i;
 
 	down_write(&ghvm->status_lock);
 	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE) {
@@ -241,6 +314,22 @@ static int gh_vm_start(struct gunyah_vm *ghvm)
 		goto err;
 	}
 
+	ret = gh_rm_get_hyp_resources(ghvm->rm, ghvm->vmid, &resources);
+	if (ret) {
+		pr_warn("Failed to get hypervisor resources for VM: %d\n", ret);
+		goto err;
+	}
+
+	for (i = 0; i < le32_to_cpu(resources->n_entries); i++) {
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
@@ -380,6 +469,8 @@ static int gh_vm_release(struct inode *inode, struct file *filp)
 	struct gunyah_vm *ghvm = filp->private_data;
 	struct gunyah_vm_memory_mapping *mapping, *tmp;
 	struct gunyah_vm_function *f, *fiter;
+	struct gunyah_vm_resource_ticket *ticket, *titer;
+	struct gunyah_resource *ghrsc, *riter;
 
 	gh_vm_stop(ghvm);
 
@@ -394,6 +485,18 @@ static int gh_vm_release(struct inode *inode, struct file *filp)
 		kfree(mapping);
 	}
 
+	if (!list_empty(&ghvm->resource_tickets)) {
+		pr_warn("Dangling resource tickets:\n");
+		list_for_each_entry_safe(ticket, titer, &ghvm->resource_tickets, list) {
+			pr_warn("  %pS\n", ticket->populate);
+			ghvm_remove_resource_ticket(ghvm, ticket);
+		}
+	}
+
+	list_for_each_entry_safe(ghrsc, riter, &ghvm->resources, list) {
+		gh_rm_free_resource(ghrsc);
+	}
+
 	put_gh_rm(ghvm->rm);
 	put_gunyah_vm(ghvm);
 	return 0;
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 8d3b0678fb96..f52350145010 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -7,6 +7,7 @@
 #define _GH_PRIV_VM_MGR_H
 
 #include <linux/gunyah_rsc_mgr.h>
+#include <linux/gunyah_vm_mgr.h>
 #include <linux/list.h>
 #include <linux/kref.h>
 #include <linux/miscdevice.h>
@@ -47,6 +48,10 @@ struct gunyah_vm {
 	struct mutex mm_lock;
 	struct list_head memory_mappings;
 
+	struct mutex resources_lock;
+	struct list_head resources;
+	struct list_head resource_tickets;
+
 	struct list_head functions;
 };
 
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 91d2c9f5b2f0..d745916cabcc 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -27,6 +27,10 @@ struct gunyah_resource {
 	enum gunyah_resource_type type;
 	u64 capid;
 	int irq;
+
+	/* To help allocator of resource manager */
+	struct list_head list;
+	u32 rm_label;
 };
 
 /**
diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
index 69f98eb503e9..995a9b0eb6b7 100644
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
2.39.0

