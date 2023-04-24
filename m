Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84926ED8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjDXXSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjDXXRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:17:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E4B455;
        Mon, 24 Apr 2023 16:17:04 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OMUE2O014920;
        Mon, 24 Apr 2023 23:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=CHwj9Uf0TgvQz6p6/+o+1Zn/RgTdthoiXVBmSJR6HTI=;
 b=Z7gbw5hbnfFsLsf5pzYG2Y97OdWVrXvrMX0EnGx+mkiUTjQMAvMvgZze+ChIhKDu2y8g
 XE2eZe3ykFwj53V4zv+KgdNg20vVhUX8LNTbzk+j4Ex6z4vK5UTuBb/D73xb8HK0QLWg
 M96mmAeZfWP3urWfSqr7N85y1K/sfVt5jW9ON+3dPvPi9t8cotiGnZwGWq3//x7EZ9wc
 b7RXH7vBbEZxPu34RG/wNjAeoO/cVAC2dplLXMqTOvlrYrwd9Uk6+uM2zMXp/mMgo61h
 EZlEraiY0bN3eahaytD0h6z86iCqjeFd8fAFSWRgDrFTiuazOaX0ZIMWq3OEkgFub7x2 lQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5mnnhypw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:51 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ONGonD001014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:50 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 16:16:49 -0700
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
Subject: [PATCH v12 15/25] firmware: qcom_scm: Register Gunyah platform ops
Date:   Mon, 24 Apr 2023 16:15:48 -0700
Message-ID: <20230424231558.70911-16-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424231558.70911-1-quic_eberman@quicinc.com>
References: <20230424231558.70911-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ynTHmfENm1TKIs9eEDeYNB3w42U86exO
X-Proofpoint-ORIG-GUID: ynTHmfENm1TKIs9eEDeYNB3w42U86exO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm platforms have a firmware entity which performs access control
to physical pages. Dynamically started Gunyah virtual machines use the
QCOM_SCM_RM_MANAGED_VMID for access. Linux thus needs to assign access
to the memory used by guest VMs. Gunyah doesn't do this operation for us
since it is the current VM (typically VMID_HLOS) delegating the access
and not Gunyah itself. Use the Gunyah platform ops to achieve this so
that only Qualcomm platforms attempt to make the needed SCM calls.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Kconfig       |  13 +++
 drivers/virt/gunyah/Makefile      |   1 +
 drivers/virt/gunyah/gunyah_qcom.c | 147 ++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)
 create mode 100644 drivers/virt/gunyah/gunyah_qcom.c

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index de815189dab6..0421b751aad4 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -5,6 +5,7 @@ config GUNYAH
 	depends on ARM64
 	depends on MAILBOX
 	select GUNYAH_PLATFORM_HOOKS
+	imply GUNYAH_QCOM_PLATFORM if ARCH_QCOM
 	help
 	  The Gunyah drivers are the helper interfaces that run in a guest VM
 	  such as basic inter-VM IPC and signaling mechanisms, and higher level
@@ -15,3 +16,15 @@ config GUNYAH
 
 config GUNYAH_PLATFORM_HOOKS
 	tristate
+
+config GUNYAH_QCOM_PLATFORM
+	tristate "Support for Gunyah on Qualcomm platforms"
+	depends on GUNYAH
+	select GUNYAH_PLATFORM_HOOKS
+	select QCOM_SCM
+	help
+	  Enable support for interacting with Gunyah on Qualcomm
+	  platforms. Interaction with Qualcomm firmware requires
+	  extra platform-specific support.
+
+	  Say Y/M here to use Gunyah on Qualcomm platforms.
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 4fbeee521d60..2aa9ff038ed0 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
+obj-$(CONFIG_GUNYAH_QCOM_PLATFORM) += gunyah_qcom.o
 
 gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
 obj-$(CONFIG_GUNYAH) += gunyah.o
diff --git a/drivers/virt/gunyah/gunyah_qcom.c b/drivers/virt/gunyah/gunyah_qcom.c
new file mode 100644
index 000000000000..18acbda8fcbd
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_qcom.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/module.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+#define QCOM_SCM_RM_MANAGED_VMID	0x3A
+#define QCOM_SCM_MAX_MANAGED_VMID	0x3F
+
+static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
+{
+	struct qcom_scm_vmperm *new_perms;
+	u64 src, src_cpy;
+	int ret = 0, i, n;
+	u16 vmid;
+
+	new_perms = kcalloc(mem_parcel->n_acl_entries, sizeof(*new_perms), GFP_KERNEL);
+	if (!new_perms)
+		return -ENOMEM;
+
+	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
+		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+			new_perms[n].vmid = vmid;
+		else
+			new_perms[n].vmid = QCOM_SCM_RM_MANAGED_VMID;
+		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_X)
+			new_perms[n].perm |= QCOM_SCM_PERM_EXEC;
+		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_W)
+			new_perms[n].perm |= QCOM_SCM_PERM_WRITE;
+		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_R)
+			new_perms[n].perm |= QCOM_SCM_PERM_READ;
+	}
+
+	src = (1ull << QCOM_SCM_VMID_HLOS);
+
+	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
+		src_cpy = src;
+		ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
+						le64_to_cpu(mem_parcel->mem_entries[i].size),
+						&src_cpy, new_perms, mem_parcel->n_acl_entries);
+		if (ret) {
+			src = 0;
+			for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+				vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
+				if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+					src |= (1ull << vmid);
+				else
+					src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
+			}
+
+			new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
+
+			for (i--; i >= 0; i--) {
+				src_cpy = src;
+				WARN_ON_ONCE(qcom_scm_assign_mem(
+						le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
+						le64_to_cpu(mem_parcel->mem_entries[i].size),
+						&src_cpy, new_perms, 1));
+			}
+			break;
+		}
+	}
+
+	kfree(new_perms);
+	return ret;
+}
+
+static int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
+{
+	struct qcom_scm_vmperm new_perms;
+	u64 src = 0, src_cpy;
+	int ret = 0, i, n;
+	u16 vmid;
+
+	new_perms.vmid = QCOM_SCM_VMID_HLOS;
+	new_perms.perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ;
+
+	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
+		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+			src |= (1ull << vmid);
+		else
+			src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
+	}
+
+	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
+		src_cpy = src;
+		ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
+						le64_to_cpu(mem_parcel->mem_entries[i].size),
+						&src_cpy, &new_perms, 1);
+		WARN_ON_ONCE(ret);
+	}
+
+	return ret;
+}
+
+static struct gh_rm_platform_ops qcom_scm_gh_rm_platform_ops = {
+	.pre_mem_share = qcom_scm_gh_rm_pre_mem_share,
+	.post_mem_reclaim = qcom_scm_gh_rm_post_mem_reclaim,
+};
+
+/* {19bd54bd-0b37-571b-946f-609b54539de6} */
+static const uuid_t QCOM_EXT_UUID =
+	UUID_INIT(0x19bd54bd, 0x0b37, 0x571b, 0x94, 0x6f, 0x60, 0x9b, 0x54, 0x53, 0x9d, 0xe6);
+
+#define GH_QCOM_EXT_CALL_UUID_ID	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
+							   ARM_SMCCC_OWNER_VENDOR_HYP, 0x3f01)
+
+static bool gh_has_qcom_extensions(void)
+{
+	struct arm_smccc_res res;
+	uuid_t uuid;
+
+	arm_smccc_1_1_smc(GH_QCOM_EXT_CALL_UUID_ID, &res);
+
+	((u32 *)&uuid.b[0])[0] = lower_32_bits(res.a0);
+	((u32 *)&uuid.b[0])[1] = lower_32_bits(res.a1);
+	((u32 *)&uuid.b[0])[2] = lower_32_bits(res.a2);
+	((u32 *)&uuid.b[0])[3] = lower_32_bits(res.a3);
+
+	return uuid_equal(&uuid, &QCOM_EXT_UUID);
+}
+
+static int __init qcom_gh_platform_hooks_register(void)
+{
+	if (!gh_has_qcom_extensions())
+		return -ENODEV;
+
+	return gh_rm_register_platform_ops(&qcom_scm_gh_rm_platform_ops);
+}
+
+static void __exit qcom_gh_platform_hooks_unregister(void)
+{
+	gh_rm_unregister_platform_ops(&qcom_scm_gh_rm_platform_ops);
+}
+
+module_init(qcom_gh_platform_hooks_register);
+module_exit(qcom_gh_platform_hooks_unregister);
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Platform Hooks for Gunyah");
+MODULE_LICENSE("GPL");
-- 
2.40.0

