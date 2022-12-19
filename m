Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA365167A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiLSXFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiLSXDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:03:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC2E167E4;
        Mon, 19 Dec 2022 15:01:09 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJMcef5001250;
        Mon, 19 Dec 2022 23:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Ce9NS6VF/ZlGRqo1zpRzMWmAMt+GG1MMbt0MLD3M85c=;
 b=SZa/AXj0gQOkBgaHG6ZWyNZRK2EJmR7UV+ekE4BGpsIfp51EfTvkBLVQsV6W7caMKD9H
 yxtud3PjRnlPzhvEm+mSLtaMwMheQh17J4FsPHsEdHph+lMkXnyapx5NvlMsblhBsJ83
 te40oWEmQx6kBPdZaN9++Okoa1huNktVsG58HE56FLCrQUCh0uJ4IEwsJ2VFb5byXzWe
 3GWMbpaGR35CpjB/0+xsNRKbU1OmTbRDtG/DYGO+n5oq3j47SETbZDK6y+JApbmQfsn8
 LNVKnu9j4vp+U6u1gVhQSKF4ospb22yGa1wVG3yejoULwPCiKTjzyUEzbrY5D5sSq1h/ Aw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh5v25h0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:41 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0e0m030845
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:40 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:39 -0800
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
Subject: [PATCH v8 17/28] gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
Date:   Mon, 19 Dec 2022 14:58:38 -0800
Message-ID: <20221219225850.2397345-18-quic_eberman@quicinc.com>
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
X-Proofpoint-ORIG-GUID: QVRaxSI7JB3k2Xyea0G01Y-X0y1mGWqM
X-Proofpoint-GUID: QVRaxSI7JB3k2Xyea0G01Y-X0y1mGWqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/Makefile                |  1 +
 drivers/virt/gunyah/gunyah_platform_hooks.c | 63 +++++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h               |  3 +
 drivers/virt/gunyah/rsc_mgr_rpc.c           |  7 ++-
 include/linux/gunyah_rsc_mgr.h              | 14 +++++
 6 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/gunyah_platform_hooks.c

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 5e5a329c9866..e92318ec8026 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -11,11 +11,15 @@ config GUNYAH
 	  Say Y/M here to enable the drivers needed to interact in a Gunyah
 	  virtual environment.
 
+config GUNYAH_PLATFORM_HOOKS
+	tristate
+
 if GUNYAH
 config GUNYAH_RESOURCE_MANAGER
 	tristate "Gunyah Resource Manager"
 	depends on MAILBOX
 	select GUNYAH_MESSAGE_QUEUES
+	select GUNYAH_PLATFORM_HOOKS
 	help
 	  The resource manager (RM) is a privileged application VM supporting
 	  the Gunyah Hypervisor. Enable this driver to support communicating
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 9d6f900ab7b0..e321c009898f 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_GUNYAH) += gunyah.o
+obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
 
 gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
 gunyah_rsc_mgr-$(CONFIG_GUNYAH_VM_MANAGER) += vm_mgr.o vm_mgr_mm.o
diff --git a/drivers/virt/gunyah/gunyah_platform_hooks.c b/drivers/virt/gunyah/gunyah_platform_hooks.c
new file mode 100644
index 000000000000..36cc02c75963
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_platform_hooks.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/rwsem.h>
+#include <linux/gunyah_rsc_mgr.h>
+
+#include "rsc_mgr.h"
+
+static struct gunyah_rm_platform_ops *rm_platform_ops;
+static DECLARE_RWSEM(rm_platform_ops_lock);
+
+int gh_rm_platform_pre_mem_share(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel)
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
+int gh_rm_platform_post_mem_reclaim(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel)
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
+int gh_rm_register_platform_ops(struct gunyah_rm_platform_ops *platform_ops)
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
+void gh_rm_unregister_platform_ops(struct gunyah_rm_platform_ops *platform_ops)
+{
+	down_write(&rm_platform_ops_lock);
+	if (rm_platform_ops == platform_ops)
+		rm_platform_ops = NULL;
+	up_write(&rm_platform_ops_lock);
+}
+EXPORT_SYMBOL_GPL(gh_rm_unregister_platform_ops);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Platform Hooks");
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index e068b5b65d2b..69554602c889 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -33,6 +33,9 @@ struct gh_rm_rpc;
 int gh_rm_call(struct gh_rm_rpc *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
 		void **resp_buf, size_t *resp_buff_size);
 
+int gh_rm_platform_pre_mem_share(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel);
+int gh_rm_platform_post_mem_reclaim(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel);
+
 /* Message IDs: Memory Management */
 #define GH_RM_RPC_MEM_LEND			0x51000012
 #define GH_RM_RPC_MEM_SHARE			0x51000013
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
index 2c9aded7cc09..e81a0dc798e1 100644
--- a/drivers/virt/gunyah/rsc_mgr_rpc.c
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -112,6 +112,10 @@ static int gh_rm_mem_lend_common(struct gh_rm_rpc *rm, u32 message_id, struct gh
 	if (initial_n_mem_entries > GH_RM_MAX_MEM_ENTRIES)
 		initial_n_mem_entries = GH_RM_MAX_MEM_ENTRIES;
 
+	ret = gh_rm_platform_pre_mem_share(rm, p);
+	if (ret)
+		return ret;
+
 	/* The format of the message goes:
 	 * request header
 	 * ACL entries (which VMs get what kind of access to this memory parcel)
@@ -155,6 +159,7 @@ static int gh_rm_mem_lend_common(struct gh_rm_rpc *rm, u32 message_id, struct gh
 
 	if (resp_size != sizeof(__le32)) {
 		ret = -EIO;
+		gh_rm_platform_post_mem_reclaim(rm, p);
 		goto out;
 	}
 
@@ -224,7 +229,7 @@ int gh_rm_mem_reclaim(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *parcel)
 		return ret;
 	kfree(resp);
 
-	return ret;
+	return gh_rm_platform_post_mem_reclaim(rm, parcel);
 }
 EXPORT_SYMBOL_GPL(gh_rm_mem_reclaim);
 
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 0b5b236fd76f..be434bcf9b4e 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -115,4 +115,18 @@ ssize_t gh_rm_get_hyp_resources(struct gh_rm_rpc *rm, u16 vmid,
 				struct gh_rm_hyp_resource **resources);
 int gh_rm_get_vmid(struct gh_rm_rpc *rm, u16 *vmid);
 
+struct gunyah_rm_platform_ops {
+	int (*pre_mem_share)(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel);
+	int (*post_mem_reclaim)(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel);
+};
+
+#if IS_ENABLED(CONFIG_GUNYAH_PLATFORM_HOOKS)
+int gh_rm_register_platform_ops(struct gunyah_rm_platform_ops *platform_ops);
+void gh_rm_unregister_platform_ops(struct gunyah_rm_platform_ops *platform_ops);
+#else
+static inline int gh_rm_register_platform_ops(struct gunyah_rm_platform_ops *platform_ops)
+	{ return 0; }
+static inline void gh_rm_unregister_platform_ops(struct gunyah_rm_platform_ops *platform_ops) { }
+#endif
+
 #endif
-- 
2.25.1

