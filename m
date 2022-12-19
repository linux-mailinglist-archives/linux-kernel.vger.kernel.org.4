Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8865164A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiLSXDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiLSXBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:01:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2876B26E7;
        Mon, 19 Dec 2022 15:00:44 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJMoPmT008515;
        Mon, 19 Dec 2022 23:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=chfYYeBv7lleRWiVsrlZotQk/mJeB3QcEkzrz6VKP5E=;
 b=NRCiBbX25ycaH+XTo6iWwiEFUVxMSQERb8aZrskRwnMdyuJ5mvLuZPTHV8j2DurTJwbM
 Sv7Wz6Ri1m2n08iKqYVD3MdHKRuMKf8ejp3St0Emg/m+33gL0wqkM7M5XlVzCDXcdR4m
 olXZ4nkLnJdGof7wtJYBZKnGKwWLGT9HkyM0biEkd8ICRbXBJFaXW29yCzXRU0XlskDD
 2I0OdOx/Z/yUIf23LKU/6YvP5mNvNOxZiUKUlnQmYymavTxvvZNB5f1um+ftLD56/wvf
 A7q1GOgVeU26+Wub/PIKWgjpxMBqgYHHR+hLh4Kls1FG+VFlOjTW6VhpwXR68x9lUSKM qQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjyk505x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:21 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0Lol007581
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:21 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:20 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 05/28] virt: gunyah: Add hypercalls to identify Gunyah
Date:   Mon, 19 Dec 2022 14:58:26 -0800
Message-ID: <20221219225850.2397345-6-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: Q7boJ0Pv-qwYEsRE1bT1QkJQy6HPV3cI
X-Proofpoint-ORIG-GUID: Q7boJ0Pv-qwYEsRE1bT1QkJQy6HPV3cI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/gunyah/Makefile           |  1 +
 arch/arm64/gunyah/gunyah_hypercall.c | 69 ++++++++++++++++++++++++++++
 drivers/virt/Kconfig                 |  1 +
 drivers/virt/gunyah/Kconfig          | 12 +++++
 include/linux/gunyah.h               | 25 ++++++++++
 7 files changed, 111 insertions(+)
 create mode 100644 arch/arm64/gunyah/Makefile
 create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
 create mode 100644 drivers/virt/gunyah/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 74e76e0ab14d..36698df6b0e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8941,6 +8941,8 @@ L:	linux-arm-msm@vger.kernel.org
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
index 000000000000..9fbc720b6fb6
--- /dev/null
+++ b/arch/arm64/gunyah/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_GUNYAH) += gunyah_hypercall.o
diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
new file mode 100644
index 000000000000..0beb3123d650
--- /dev/null
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/module.h>
+#include <linux/gunyah.h>
+
+#define GH_CALL_TYPE_PLATFORM_CALL		0
+#define GH_CALL_TYPE_HYPERCALL			2
+#define GH_CALL_TYPE_SERVICE			3
+#define GH_CALL_TYPE_SHIFT			14
+#define GH_CALL_FUNCTION_NUM_MASK		0x3fff
+
+#define GH_FN_ID(type, num)	((type) << GH_CALL_TYPE_SHIFT | ((num) & GH_CALL_FUNCTION_NUM_MASK))
+
+#define GH_SERVICE(fn)		ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
+						   ARM_SMCCC_OWNER_VENDOR_HYP, \
+						   GH_FN_ID(GH_CALL_TYPE_SERVICE, fn))
+
+#define GH_HYPERCALL_CALL_UID			GH_SERVICE(0x3f01)
+
+#define GH_HYPERCALL(fn)	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
+						   ARM_SMCCC_OWNER_VENDOR_HYP, \
+						   GH_FN_ID(GH_CALL_TYPE_HYPERCALL, fn))
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
+
+	arm_smccc_1_1_hvc(GH_HYPERCALL_CALL_UID, &res);
+
+	uid[0] = res.a0;
+	uid[1] = res.a1;
+	uid[2] = res.a2;
+	uid[3] = res.a3;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_get_uid);
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
index 87ef258cec64..259dc2be6cad 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -52,4 +52,5 @@ source "drivers/virt/coco/efi_secret/Kconfig"
 
 source "drivers/virt/coco/sev-guest/Kconfig"
 
+source "drivers/virt/gunyah/Kconfig"
 endif
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
new file mode 100644
index 000000000000..127156a678a6
--- /dev/null
+++ b/drivers/virt/gunyah/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config GUNYAH
+	tristate "Gunyah Virtualization drivers"
+	depends on ARM64
+	help
+	  The Gunyah drivers are the helper interfaces that runs in a guest VM
+	  such as basic inter-VM IPC and signaling mechanisms, and higher level
+	  services such as memory/device sharing, IRQ sharing, and so on.
+
+	  Say Y/M here to enable the drivers needed to interact in a Gunyah
+	  virtual environment.
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 824e20a11d27..2765d2b40198 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -6,6 +6,7 @@
 #ifndef _GUNYAH_H
 #define _GUNYAH_H
 
+#include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 
@@ -71,4 +72,28 @@ static inline int gh_remap_error(int gh_error)
 	}
 }
 
+#define GUNYAH_API_V1			1
+
+#define GH_API_INFO_API_VERSION_MASK	GENMASK_ULL(13, 0)
+#define GH_API_INFO_BIG_ENDIAN		BIT_ULL(14)
+#define GH_API_INFO_IS_64BIT		BIT_ULL(15)
+#define GH_API_INFO_VARIANT_MASK	GENMASK_ULL(63, 56)
+
+#define GH_IDENTIFY_PARTITION_CSPACE		BIT_ULL(0)
+#define GH_IDENTIFY_DOORBELL			BIT_ULL(1)
+#define GH_IDENTIFY_MSGQUEUE			BIT_ULL(2)
+#define GH_IDENTIFY_VIC				BIT_ULL(3)
+#define GH_IDENTIFY_VPM				BIT_ULL(4)
+#define GH_IDENTIFY_VCPU			BIT_ULL(5)
+#define GH_IDENTIFY_MEMEXTENT			BIT_ULL(6)
+#define GH_IDENTIFY_TRACE_CTRL			BIT_ULL(7)
+
+struct gh_hypercall_hyp_identify_resp {
+	u64 api_info;
+	u64 flags[3];
+};
+
+void gh_hypercall_get_uid(u32 uid[4]);
+void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
+
 #endif
-- 
2.25.1

