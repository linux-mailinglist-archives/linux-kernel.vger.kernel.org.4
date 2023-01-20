Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C3C67607F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjATWsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjATWsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:48:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B885329161;
        Fri, 20 Jan 2023 14:47:49 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMeJoO014550;
        Fri, 20 Jan 2023 22:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=k1t08PAttr9GVLaiQO+z0sFDGMbPRc3GjKBx/B+SyEA=;
 b=PFO1TmgUcx+Feq8KmwpEYvjgjSoe8TJA8lH+EzFDLw/iGOL6BVWH9NurOU39q1yEJtZS
 sUZ1zNZa5QWTdblL4NpEF0veusRQa21ulqQx14Ib1RkO/NwnDR+R+A4MG9FHsNkF9CkU
 s1obgGp/bTmL86RbtfC7/qamMqjJ3+iNKSH0fs7r7sl4n1XyovGLas/2SSvxa5c2s79Y
 Bgqdz6bsBdzzrQtwRgteX2MnnpzsXMfgeXJOHbvufuyJVBDFf2ybkwO7xMKfdLL+fi9Q
 g/07vUuZGWt6G5ICIovRsL0U8qm5V/Rx2Hud8MVfdhwkS+MH3cmGak+iXGskFWE8dBBb qw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7593uqxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:37 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMla2X030153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:36 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:47:35 -0800
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
Subject: [PATCH v9 05/27] virt: gunyah: Identify hypervisor version
Date:   Fri, 20 Jan 2023 14:46:04 -0800
Message-ID: <20230120224627.4053418-6-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: 6Upn7tBCYYsP4iIn8eZYgneASuW-c2Kd
X-Proofpoint-ORIG-GUID: 6Upn7tBCYYsP4iIn8eZYgneASuW-c2Kd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301200218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the version of Gunyah which is reported via the hyp_identify
hypercall. Increments of the major API version indicate possibly
backwards incompatible changes.

Export the hypervisor identity so that Gunyah drivers can act according
to the major API version.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/Makefile        |  1 +
 drivers/virt/gunyah/Makefile |  3 ++
 drivers/virt/gunyah/gunyah.c | 54 ++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 drivers/virt/gunyah/Makefile
 create mode 100644 drivers/virt/gunyah/gunyah.c

diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index e9aa6fc96fab..a5817e2d7d71 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_ACRN_HSM)		+= acrn/
 obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
 obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= coco/tdx-guest/
+obj-y				+= gunyah/
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
new file mode 100644
index 000000000000..34f32110faf9
--- /dev/null
+++ b/drivers/virt/gunyah/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_GUNYAH) += gunyah.o
diff --git a/drivers/virt/gunyah/gunyah.c b/drivers/virt/gunyah/gunyah.c
new file mode 100644
index 000000000000..776e83c6920d
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gunyah: " fmt
+
+#include <linux/gunyah.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+static struct gh_hypercall_hyp_identify_resp gunyah_api;
+
+u16 gh_api_version(void)
+{
+	return FIELD_GET(GH_API_INFO_API_VERSION_MASK, gunyah_api.api_info);
+}
+EXPORT_SYMBOL_GPL(gh_api_version);
+
+bool gh_api_has_feature(enum gh_api_feature feature)
+{
+	switch (feature) {
+	case GH_API_FEATURE_DOORBELL:
+		return !!(gunyah_api.flags[0] & GH_IDENTIFY_DOORBELL);
+	case GH_API_FEATURE_MSGQUEUE:
+		return !!(gunyah_api.flags[0] & GH_IDENTIFY_MSGQUEUE);
+	case GH_API_FEATURE_VCPU:
+		return !!(gunyah_api.flags[0] & GH_IDENTIFY_VCPU);
+	case GH_API_FEATURE_MEMEXTENT:
+		return !!(gunyah_api.flags[0] & GH_IDENTIFY_MEMEXTENT);
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(gh_api_has_feature);
+
+static int __init gunyah_init(void)
+{
+	if (!arch_is_gunyah_guest())
+		return -ENODEV;
+
+	gh_hypercall_hyp_identify(&gunyah_api);
+
+	pr_info("Running under Gunyah hypervisor %llx/v%u\n",
+		FIELD_GET(GH_API_INFO_VARIANT_MASK, gunyah_api.api_info),
+		gh_api_version());
+
+	return 0;
+}
+arch_initcall(gunyah_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Hypervisor Driver");
-- 
2.39.0

