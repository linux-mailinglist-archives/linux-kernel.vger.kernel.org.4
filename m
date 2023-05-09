Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608586FD011
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjEIUu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjEIUtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:49:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F2A59E7;
        Tue,  9 May 2023 13:49:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349Kc70q029068;
        Tue, 9 May 2023 20:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=eFsobt63lueiKqYe3ovJGbPznIbnDb7lh2HnbmeCpZ0=;
 b=H32hlNhZT8P3iIGesrLvOOejUV6G3YdL2J10dT2CyHeHgPfB5pCFqtReuPmqMHiHZAsi
 lkEF/bDHIUhoHn0P6eeLy0F4lVeSJtPSBd7GptgVyOPCbgl3/O5pEmHjD5d5h80Vj61r
 DhJKMJIKCR1dr5Z6GVNpGIut3kdwnyo4hUvj4yG9M9bK51Zx8neYwdxxQswhGESo+2BF
 UlJ95jxwPaBApNe0Di2ZDSEJQrfm+GuwRg4VasnQZaLNj9f345nBTRnJZfFT7xGneNr0
 nrxPV3goPxjMyFOqKw2F9GjODTwxw1DCv9vHm096FoacePOGxt+1xiugG9aiF65aLXqr IQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77ktu3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 20:49:12 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349KnBbE014136
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 20:49:11 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 13:49:10 -0700
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
Subject: [PATCH v13 13/24] gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
Date:   Tue, 9 May 2023 13:47:50 -0700
Message-ID: <20230509204801.2824351-14-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: MYN-qIJQDWbYm6u4kHPEdo1kbHPDv3yH
X-Proofpoint-ORIG-GUID: MYN-qIJQDWbYm6u4kHPEdo1kbHPDv3yH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090171
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qualcomm platforms, there is a firmware entity which controls access
to physical pages. In order to share memory with another VM, this entity
needs to be informed that the guest VM should have access to the memory.

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
index 1a737694c333..de815189dab6 100644
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
index bacf78b8fa33..4fbeee521d60 100644
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
index 000000000000..60da0e154e98
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
+static struct gh_rm_platform_ops *rm_platform_ops;
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
+int gh_rm_register_platform_ops(struct gh_rm_platform_ops *platform_ops)
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
+void gh_rm_unregister_platform_ops(struct gh_rm_platform_ops *platform_ops)
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
+	gh_rm_unregister_platform_ops(data);
+}
+
+int devm_gh_rm_register_platform_ops(struct device *dev, struct gh_rm_platform_ops *ops)
+{
+	int ret;
+
+	ret = gh_rm_register_platform_ops(ops);
+	if (ret)
+		return ret;
+
+	return devm_add_action(dev, _devm_gh_rm_unregister_platform_ops, ops);
+}
+EXPORT_SYMBOL_GPL(devm_gh_rm_register_platform_ops);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Platform Hooks");
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 8309b7bf4668..3d43bb79ff44 100644
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
index 4f25f07400b3..835a851ae71b 100644
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
index dfac088420bd..7c599654ea30 100644
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
+int gh_rm_register_platform_ops(struct gh_rm_platform_ops *platform_ops);
+void gh_rm_unregister_platform_ops(struct gh_rm_platform_ops *platform_ops);
+int devm_gh_rm_register_platform_ops(struct device *dev, struct gh_rm_platform_ops *ops);
+#else
+static inline int gh_rm_register_platform_ops(struct gh_rm_platform_ops *platform_ops)
+	{ return 0; }
+static inline void gh_rm_unregister_platform_ops(struct gh_rm_platform_ops *platform_ops) { }
+static inline int devm_gh_rm_register_platform_ops(struct device *dev,
+	struct gh_rm_platform_ops *ops) { return 0; }
+#endif
+
 #endif
-- 
2.40.0

