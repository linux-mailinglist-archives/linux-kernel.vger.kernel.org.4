Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC872E9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbjFMRX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjFMRWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:22:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EA71FFB;
        Tue, 13 Jun 2023 10:22:07 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DAc8Sj024932;
        Tue, 13 Jun 2023 17:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=2dGoHiZGXQO/3XzpGqgnZG8qZ1fUB2ur8D+86DuXzpM=;
 b=niZNNZoAEOgiFXSNVD4U3USTP1q6JULHpUUKqiuoP0Msiw867caTXM4MiDx6upWTiMgZ
 Qm7X6sePCXUBVVML/edjbC11NRBG74cfnZV8j0IwJFV3kKI4Hpo6ftUOr2uFyQ4ZMjhh
 DI4pe7+nPqSj11LmQAuZm3qxXoVuKwp4KktdXceEI4pAJ17zrSTC7nZBWtj+wn3P7w8l
 Hgw5bFGqjnfbYZx+Cj4RU8sxDCeJ0gYVsrhnJytiCK8iJFVUAFvEr7tD/7jdUiTW+5LR
 36thDc2VCt9ncSd2YMbsCaYi/npliCs0KHOkVQPiMLlgnk0oHz2GXxORle2RNUA/5dp3 Xw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r68x9ae10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:42 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DHLfx9005703
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:41 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 10:21:40 -0700
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
Subject: [PATCH v14 14/25] gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
Date:   Tue, 13 Jun 2023 10:20:42 -0700
Message-ID: <20230613172054.3959700-15-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: 34k8r9ljwTrzWrXZCEPnMpXQcv-c8iYW
X-Proofpoint-ORIG-GUID: 34k8r9ljwTrzWrXZCEPnMpXQcv-c8iYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_19,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130153
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qualcomm platforms, there is a firmware entity which controls access
to physical pages. In order to share memory with another VM, this entity
needs to be informed that the guest VM should have access to the memory.

Reviewed-by: Alex Elder <elder@linaro.org>
Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Kconfig                 |  4 ++
 drivers/virt/gunyah/Makefile                |  2 +
 drivers/virt/gunyah/gunyah_platform_hooks.c | 80 +++++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h               |  3 +
 drivers/virt/gunyah/rsc_mgr_rpc.c           | 18 ++++-
 include/linux/gunyah_rsc_mgr.h              | 17 +++++
 6 files changed, 122 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/gunyah/gunyah_platform_hooks.c

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 1a737694c333d..de815189dab6c 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -4,6 +4,7 @@ config GUNYAH
 	tristate "Gunyah Virtualization drivers"
 	depends on ARM64
 	depends on MAILBOX
+	select GUNYAH_PLATFORM_HOOKS
 	help
 	  The Gunyah drivers are the helper interfaces that run in a guest VM
 	  such as basic inter-VM IPC and signaling mechanisms, and higher level
@@ -11,3 +12,6 @@ config GUNYAH
 
 	  Say Y/M here to enable the drivers needed to interact in a Gunyah
 	  virtual environment.
+
+config GUNYAH_PLATFORM_HOOKS
+	tristate
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index bacf78b8fa337..4fbeee521d60a 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
+
 gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
 obj-$(CONFIG_GUNYAH) += gunyah.o
diff --git a/drivers/virt/gunyah/gunyah_platform_hooks.c b/drivers/virt/gunyah/gunyah_platform_hooks.c
new file mode 100644
index 0000000000000..905515b4589e3
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_platform_hooks.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/rwsem.h>
+#include <linux/gunyah_rsc_mgr.h>
+
+#include "rsc_mgr.h"
+
+static const struct gh_rm_platform_ops *rm_platform_ops;
+static DECLARE_RWSEM(rm_platform_ops_lock);
+
+int gh_rm_platform_pre_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->pre_mem_share)
+		ret = rm_platform_ops->pre_mem_share(rm, mem_parcel);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_platform_pre_mem_share);
+
+int gh_rm_platform_post_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->post_mem_reclaim)
+		ret = rm_platform_ops->post_mem_reclaim(rm, mem_parcel);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_platform_post_mem_reclaim);
+
+int gh_rm_register_platform_ops(const struct gh_rm_platform_ops *platform_ops)
+{
+	int ret = 0;
+
+	down_write(&rm_platform_ops_lock);
+	if (!rm_platform_ops)
+		rm_platform_ops = platform_ops;
+	else
+		ret = -EEXIST;
+	up_write(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_register_platform_ops);
+
+void gh_rm_unregister_platform_ops(const struct gh_rm_platform_ops *platform_ops)
+{
+	down_write(&rm_platform_ops_lock);
+	if (rm_platform_ops == platform_ops)
+		rm_platform_ops = NULL;
+	up_write(&rm_platform_ops_lock);
+}
+EXPORT_SYMBOL_GPL(gh_rm_unregister_platform_ops);
+
+static void _devm_gh_rm_unregister_platform_ops(void *data)
+{
+	gh_rm_unregister_platform_ops((const struct gh_rm_platform_ops *)data);
+}
+
+int devm_gh_rm_register_platform_ops(struct device *dev, const struct gh_rm_platform_ops *ops)
+{
+	int ret;
+
+	ret = gh_rm_register_platform_ops(ops);
+	if (ret)
+		return ret;
+
+	return devm_add_action(dev, _devm_gh_rm_unregister_platform_ops, (void *)ops);
+}
+EXPORT_SYMBOL_GPL(devm_gh_rm_register_platform_ops);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Platform Hooks");
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 8309b7bf46683..3d43bb79ff447 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -13,4 +13,7 @@ struct gh_rm;
 int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, const void *req_buf, size_t req_buf_size,
 		void **resp_buf, size_t *resp_buf_size);
 
+int gh_rm_platform_pre_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
+int gh_rm_platform_post_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
+
 #endif
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
index 25064123a31c3..d0548db1500c2 100644
--- a/drivers/virt/gunyah/rsc_mgr_rpc.c
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -207,6 +207,12 @@ static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, struct gh_rm_
 	if (!msg)
 		return -ENOMEM;
 
+	ret = gh_rm_platform_pre_mem_share(rm, p);
+	if (ret) {
+		kfree(msg);
+		return ret;
+	}
+
 	req_header = msg;
 	acl_section = (void *)req_header + sizeof(*req_header);
 	mem_section = (void *)acl_section + acl_section_size;
@@ -231,8 +237,10 @@ static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, struct gh_rm_
 	ret = gh_rm_call(rm, message_id, msg, msg_size, (void **)&resp, &resp_size);
 	kfree(msg);
 
-	if (ret)
+	if (ret) {
+		gh_rm_platform_post_mem_reclaim(rm, p);
 		return ret;
+	}
 
 	p->mem_handle = le32_to_cpu(*resp);
 	kfree(resp);
@@ -287,8 +295,14 @@ int gh_rm_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
 	struct gh_rm_mem_release_req req = {
 		.mem_handle = cpu_to_le32(parcel->mem_handle),
 	};
+	int ret;
+
+	ret = gh_rm_call(rm, GH_RM_RPC_MEM_RECLAIM, &req, sizeof(req), NULL, NULL);
+	/* Only call the platform mem reclaim hooks if we reclaimed the memory */
+	if (ret)
+		return ret;
 
-	return gh_rm_call(rm, GH_RM_RPC_MEM_RECLAIM, &req, sizeof(req), NULL, NULL);
+	return gh_rm_platform_post_mem_reclaim(rm, parcel);
 }
 
 /**
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index dfac088420bda..cac4476b46ade 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -139,4 +139,21 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
 				struct gh_rm_hyp_resources **resources);
 int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
 
+struct gh_rm_platform_ops {
+	int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
+	int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
+};
+
+#if IS_ENABLED(CONFIG_GUNYAH_PLATFORM_HOOKS)
+int gh_rm_register_platform_ops(const struct gh_rm_platform_ops *platform_ops);
+void gh_rm_unregister_platform_ops(const struct gh_rm_platform_ops *platform_ops);
+int devm_gh_rm_register_platform_ops(struct device *dev, const struct gh_rm_platform_ops *ops);
+#else
+static inline int gh_rm_register_platform_ops(const struct gh_rm_platform_ops *platform_ops)
+	{ return 0; }
+static inline void gh_rm_unregister_platform_ops(const struct gh_rm_platform_ops *platform_ops) { }
+static inline int devm_gh_rm_register_platform_ops(struct device *dev,
+	const struct gh_rm_platform_ops *ops) { return 0; }
+#endif
+
 #endif
-- 
2.40.0

