Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F6167607D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjATWsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjATWsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:48:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B22423C66;
        Fri, 20 Jan 2023 14:47:49 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KLa0MV023841;
        Fri, 20 Jan 2023 22:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=OO98CIBdly0mmgA1GwNwOM2BQ1GVB1wy57q24H0LVUc=;
 b=GGH2cd6VDIs5iA0hR0YGeLT8QlWAukaBlSJcbkdX/peWPS2jt/qfKUUptYs8MGsBn8mH
 brkzzn58k0jvNepEytuOgXQy1mkq4i69FONKZN/nA34wr/DulIcExKyw0h5dFWxWn9Gu
 0LkMqvFKvYHe1omTslChoMsLr/AvF/WdpEaLsYlgW3d0noq205EdMFlybL/UzeCAnh5b
 EFO9tsqSQMlb72/N8AeBVzwB3ObvcbrBOm6Kot2czXdVRZ7zIrTXBeBvwQkFbwMGHw8z
 ab3TbwgqcjRpkL5FKODyWCi0rZD9diK7vXOWiKl5oQ+yduxh9HWuaKOSOYQfOUmPi9yC YQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7c28jren-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:35 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMlZkq022200
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:35 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:47:34 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v9 04/27] virt: gunyah: Add hypercalls to identify Gunyah
Date:   Fri, 20 Jan 2023 14:46:03 -0800
Message-ID: <20230120224627.4053418-5-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: pWBNmX3rT8gpCMtAwMmNEaimMZ-Y1FKY
X-Proofpoint-ORIG-GUID: pWBNmX3rT8gpCMtAwMmNEaimMZ-Y1FKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hypercalls to identify when Linux is running a virtual machine under
Gunyah.

There are two calls to help identify Gunyah:

1. gh_hypercall_get_uid() returns a UID when running under a Gunyah
   hypervisor.
2. gh_hypercall_hyp_identify() returns build information and a set of
   feature flags that are supported by Gunyah.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS                          |  2 +
 arch/arm64/Kbuild                    |  1 +
 arch/arm64/gunyah/Makefile           |  3 ++
 arch/arm64/gunyah/gunyah_hypercall.c | 75 ++++++++++++++++++++++++++++
 drivers/virt/Kconfig                 |  2 +
 drivers/virt/gunyah/Kconfig          | 14 ++++++
 include/linux/gunyah.h               | 33 ++++++++++++
 7 files changed, 130 insertions(+)
 create mode 100644 arch/arm64/gunyah/Makefile
 create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
 create mode 100644 drivers/virt/gunyah/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index f1e07e39b2f5..fe19e71efc6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9048,6 +9048,8 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 F:	Documentation/virt/gunyah/
+F:	arch/arm64/gunyah/
+F:	drivers/virt/gunyah/
 F:	include/linux/gunyah.h
 
 HABANALABS PCI DRIVER
diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
index 5bfbf7d79c99..e4847ba0e3c9 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -3,6 +3,7 @@ obj-y			+= kernel/ mm/ net/
 obj-$(CONFIG_KVM)	+= kvm/
 obj-$(CONFIG_XEN)	+= xen/
 obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
+obj-$(CONFIG_GUNYAH)	+= gunyah/
 obj-$(CONFIG_CRYPTO)	+= crypto/
 
 # for cleaning
diff --git a/arch/arm64/gunyah/Makefile b/arch/arm64/gunyah/Makefile
new file mode 100644
index 000000000000..84f1e38cafb1
--- /dev/null
+++ b/arch/arm64/gunyah/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_GUNYAH) += gunyah_hypercall.o
diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
new file mode 100644
index 000000000000..ffed4b71641f
--- /dev/null
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/module.h>
+#include <linux/gunyah.h>
+
+static const uint32_t gunyah_known_uuids[][4] = {
+	{0x19bd54bd, 0x0b37571b, 0x946f609b, 0x54539de6}, /* QC_HYP (Qualcomm's build) */
+	{0x673d5f14, 0x9265ce36, 0xa4535fdb, 0xc1d58fcd}, /* GUNYAH (open source build) */
+};
+
+#define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x0000)
+
+/**
+ * gh_hypercall_get_uid() - Returns a UID when running under a Gunyah hypervisor
+ * @uid: An array of 4 u32's (u32 uid[4];)
+ *
+ * Caller should compare the resulting UID to a list of known Gunyah UIDs to
+ * confirm that Linux is running as a guest of Gunyah.
+ */
+void gh_hypercall_get_uid(u32 uid[4])
+{
+	struct arm_smccc_res res;
+	u32 uid[4];
+	int i;
+
+	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
+
+	uid[0] = lower_32_bits(res.a0);
+	uid[1] = lower_32_bits(res.a1);
+	uid[2] = lower_32_bits(res.a2);
+	uid[3] = lower_32_bits(res.a3);
+
+	for (i = 0; i < ARRAY_SIZE(gunyah_known_uuids); i++)
+		if (!memcmp(uid, gunyah_known_uuids[i], sizeof(uid)))
+			break;
+
+	return i != ARRAY_SIZE(gunyah_known_uuids);
+}
+EXPORT_SYMBOL_GPL(arch_is_gunyah_guest);
+
+#define GH_HYPERCALL(fn)	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
+						   ARM_SMCCC_OWNER_VENDOR_HYP, \
+						   fn)
+
+#define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x8000)
+#define GH_HYPERCALL_DBL_SEND			GH_HYPERCALL(0x8012)
+#define GH_HYPERCALL_DBL_SET_MASK		GH_HYPERCALL(0x8015)
+#define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x801B)
+#define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x801C)
+#define GH_HYPERCALL_VCPU_RUN			GH_HYPERCALL(0x8065)
+
+/**
+ * gh_hypercall_hyp_identify() - Returns build information and feature flags
+ *                               supported by Gunyah.
+ * @hyp_identity: filled by the hypercall with the API info and feature flags.
+ */
+void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GH_HYPERCALL_HYP_IDENTIFY, &res);
+
+	hyp_identity->api_info = res.a0;
+	hyp_identity->flags[0] = res.a1;
+	hyp_identity->flags[1] = res.a2;
+	hyp_identity->flags[2] = res.a3;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index f79ab13a5c28..85bd6626ffc9 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -54,4 +54,6 @@ source "drivers/virt/coco/sev-guest/Kconfig"
 
 source "drivers/virt/coco/tdx-guest/Kconfig"
 
+source "drivers/virt/gunyah/Kconfig"
+
 endif
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
new file mode 100644
index 000000000000..71c38845bcea
--- /dev/null
+++ b/drivers/virt/gunyah/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config GUNYAH
+	tristate "Gunyah Virtualization drivers"
+	depends on ARM64
+	depends on MAILBOX
+	select GUNYAH_PLATFORM_HOOKS
+	help
+	  The Gunyah drivers are the helper interfaces that run in a guest VM
+	  such as basic inter-VM IPC and signaling mechanisms, and higher level
+	  services such as memory/device sharing, IRQ sharing, and so on.
+
+	  Say Y/M here to enable the drivers needed to interact in a Gunyah
+	  virtual environment.
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 985c6086348e..6724d1264d58 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -6,8 +6,10 @@
 #ifndef _LINUX_GUNYAH_H
 #define _LINUX_GUNYAH_H
 
+#include <linux/bitfield.h>
 #include <linux/errno.h>
 #include <linux/limits.h>
+#include <linux/types.h>
 
 /* Common Gunyah macros */
 #define GH_CAPID_INVAL	U64_MAX
@@ -71,4 +73,35 @@ static inline int gh_remap_error(int gh_error)
 	}
 }
 
+enum gh_api_feature {
+	GH_API_FEATURE_DOORBELL,
+	GH_API_FEATURE_MSGQUEUE,
+	GH_API_FEATURE_VCPU,
+	GH_API_FEATURE_MEMEXTENT,
+};
+
+bool arch_is_gunyah_guest(void);
+
+u16 gh_api_version(void);
+bool gh_api_has_feature(enum gh_api_feature feature);
+
+#define GUNYAH_API_V1			1
+
+#define GH_API_INFO_API_VERSION_MASK	GENMASK_ULL(13, 0)
+#define GH_API_INFO_BIG_ENDIAN		BIT_ULL(14)
+#define GH_API_INFO_IS_64BIT		BIT_ULL(15)
+#define GH_API_INFO_VARIANT_MASK	GENMASK_ULL(63, 56)
+
+#define GH_IDENTIFY_DOORBELL			BIT_ULL(1)
+#define GH_IDENTIFY_MSGQUEUE			BIT_ULL(2)
+#define GH_IDENTIFY_VCPU			BIT_ULL(5)
+#define GH_IDENTIFY_MEMEXTENT			BIT_ULL(6)
+
+struct gh_hypercall_hyp_identify_resp {
+	u64 api_info;
+	u64 flags[3];
+};
+
+void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
+
 #endif
-- 
2.39.0

