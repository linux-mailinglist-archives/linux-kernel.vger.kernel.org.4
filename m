Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6921A6324E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiKUOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiKUOCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:02:17 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360242EF53;
        Mon, 21 Nov 2022 06:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669039335; x=1700575335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qy6zLlRt58JzjnAnjZx0E210Sky1kDaCzk1olERIjGA=;
  b=GtK3PqbbD3BmCUPb550lB/G6QPxm4Da7BWe0G6mllY3emKjUbyrMfD9t
   yx2jxRk89w0+ebdoFQG3dO7ZSQyFuo/XcbZzGOv3Inl35B7aZSDWpbJP4
   l510ooPXiKVJGQ1ChGvIQ5m1s+33g0hx7Rv1y+WyMZlaE9ou2veFPS3SW
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Nov 2022 06:02:14 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 06:02:14 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 06:02:12 -0800
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 17/20] gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
Date:   Mon, 21 Nov 2022 06:00:06 -0800
Message-ID: <20221121140009.2353512-18-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121140009.2353512-1-quic_eberman@quicinc.com>
References: <20221121140009.2353512-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/gunyah_rm_rpc.c         |  7 ++-
 drivers/virt/gunyah/rsc_mgr.h               |  3 +
 include/linux/gunyah_rsc_mgr.h              | 14 +++++
 6 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/gunyah_platform_hooks.c

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 5856b7c5157b..41e619128b3d 100644
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
 	tristate
 	depends on MAILBOX
 	select GUNYAH_MESSAGE_QUEUES
+	select GUNYAH_PLATFORM_HOOKS
 
 config GUNYAH_VM_MANAGER
 	tristate "Gunyah VM Manager"
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 82fd18d518d1..90d589ce1f44 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_GUNYAH) += gunyah.o
+obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
 
 obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER) += gunyah_rsc_mgr.o gunyah_rm_rpc.o
 
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
diff --git a/drivers/virt/gunyah/gunyah_rm_rpc.c b/drivers/virt/gunyah/gunyah_rm_rpc.c
index 544ec8022104..f81c7b55e7d7 100644
--- a/drivers/virt/gunyah/gunyah_rm_rpc.c
+++ b/drivers/virt/gunyah/gunyah_rm_rpc.c
@@ -671,6 +671,10 @@ static int gh_rm_mem_lend_common(struct gh_rm_rpc *rm, u32 message_id, struct gh
 	if (initial_n_mem_entries > GH_RM_MAX_MEM_ENTRIES)
 		initial_n_mem_entries = GH_RM_MAX_MEM_ENTRIES;
 
+	ret = gh_rm_platform_pre_mem_share(rm, p);
+	if (ret)
+		return ret;
+
 	/* The format of the message goes:
 	 * request header
 	 * ACL entries (which VMs get what kind of access to this memory parcel)
@@ -714,6 +718,7 @@ static int gh_rm_mem_lend_common(struct gh_rm_rpc *rm, u32 message_id, struct gh
 
 	if (resp_size != sizeof(u32)) {
 		ret = -EIO;
+		gh_rm_platform_post_mem_reclaim(rm, p);
 		goto out;
 	}
 
@@ -783,7 +788,7 @@ int gh_rm_mem_reclaim(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *parcel)
 		return ret;
 	kfree(resp);
 
-	return ret;
+	return gh_rm_platform_post_mem_reclaim(rm, parcel);
 }
 EXPORT_SYMBOL_GPL(gh_rm_mem_reclaim);
 
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 4712405a3486..3a7f171a7416 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -34,6 +34,9 @@ struct platform_device;
 struct gh_rm_rpc *gh_rm_rpc_init(struct platform_device *pdev);
 void gh_rm_rpc_remove(struct gh_rm_rpc *rm);
 
+int gh_rm_platform_pre_mem_share(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel);
+int gh_rm_platform_post_mem_reclaim(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel);
+
 /* Message IDs: Memory Management */
 #define GH_RM_RPC_MEM_LEND			0x51000012
 #define GH_RM_RPC_MEM_SHARE			0x51000013
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index c0f5c04c64dc..7cdb736f7054 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -120,4 +120,18 @@ int gh_rm_get_vmid(struct gh_rm_rpc *rm, u16 *vmid);
 #define GH_RM_BOOT_CONTEXT_REG_SET_SP_ELx	2
 int gh_rm_set_boot_context(struct gh_rm_rpc *rm, u16 vmid, u8 reg_set, u8 reg_idx, u64 value);
 
+struct gunyah_rm_platform_ops {
+	int (*pre_mem_share)(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel);
+	int (*post_mem_reclaim)(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel);
+};
+
+#if IS_ENABLED(CONFIG_GUNYAH)
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

