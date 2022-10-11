Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D095FA914
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJKAKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiJKAJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:09:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D67BC3D;
        Mon, 10 Oct 2022 17:09:41 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B025sh015760;
        Tue, 11 Oct 2022 00:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=rrQpMl+TyNIKRY9rHebJbBrgYsWLOpC0fYbbUnfUSjM=;
 b=SRdkBJvq/+1gZIYcwhBj1VjkqSPjVxfAUmxvvYTyZ7+7UFPFk0Hspv5aGAiqeGol2AgX
 IWWtnV2ob5IlLN17w4OEmwPsYoGFLq5b5aJO+ZuwinniGeKGKCZZZiQ7vsyXKnx8o0Kk
 3Pry/7TaSYodEj/TCeDFUhX/szTt4b2A2wISaHnlAWlqaESmZZY4seUUZHqxjR1ZyV1g
 33A7f0vHeMMc0ek5UycIlxnJHDO1EtbEVwqR39LPfr3NRJAks6D/3GJyupIbCN4izsj/
 6pz5EDnIZVXq3BSiXQ5i0ud0RO49ES57/zbxq3LcJKdrQIBcAucnCH5Rs4J3a9usv3dL pg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rx4rj19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 00:09:27 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29B09QWf020393
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 00:09:26 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 10 Oct 2022 17:09:25 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 06/13] virt: gunyah: Identify hypervisor version
Date:   Mon, 10 Oct 2022 17:08:33 -0700
Message-ID: <20221011000840.289033-7-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011000840.289033-1-quic_eberman@quicinc.com>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gDO8b4OFU1rMRXR7GpCZ0nF559N1AFSP
X-Proofpoint-ORIG-GUID: gDO8b4OFU1rMRXR7GpCZ0nF559N1AFSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_12,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100143
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the version of Gunyah which is reported via the hyp_identify
hypercall. Increments of the major API version indicate possibly
backwards incompatible changes. Export the hypervisor identity so that
Gunyah drivers can act according to the major API version.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS                  |  1 +
 drivers/virt/Makefile        |  1 +
 drivers/virt/gunyah/Makefile |  2 ++
 drivers/virt/gunyah/gunyah.c | 41 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/gunyah.h |  3 +++
 5 files changed, 48 insertions(+)
 create mode 100644 drivers/virt/gunyah/Makefile
 create mode 100644 drivers/virt/gunyah/gunyah.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ed2bc98c3818..c5458aeec023 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8884,6 +8884,7 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
 M:	Murali Nalajala <quic_mnalajal@quicinc.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Supported
+F:	Documentation/ABI/testing/sysfs-hypervisor-gunyah
 F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 F:	Documentation/virt/gunyah/
 F:	arch/arm64/gunyah/
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 093674e05c40..10b87f934730 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
 obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
 obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
+obj-$(CONFIG_GUNYAH)		+= gunyah/
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
new file mode 100644
index 000000000000..dc081e2dc02b
--- /dev/null
+++ b/drivers/virt/gunyah/Makefile
@@ -0,0 +1,2 @@
+gunyah-y += gunyah.o
+obj-$(CONFIG_GUNYAH) += gunyah.o
diff --git a/drivers/virt/gunyah/gunyah.c b/drivers/virt/gunyah/gunyah.c
new file mode 100644
index 000000000000..2893a56f3dfc
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gunyah: " fmt
+
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <asm-generic/gunyah.h>
+
+struct gh_hypercall_hyp_identify_resp gunyah_api;
+EXPORT_SYMBOL(gunyah_api);
+
+static int __init gunyah_init(void)
+{
+	u32 uid[4];
+
+	gh_hypercall_get_uid(uid);
+
+	if (!(gh_uid_matches(GUNYAH, uid) || gh_uid_matches(QC_HYP, uid)))
+		return 0;
+
+	gh_hypercall_hyp_identify(&gunyah_api);
+
+	pr_info("Running under Gunyah hypervisor %llx/v%lld\n",
+		  GH_API_INFO_VARIANT(gunyah_api.api_info),
+		  GH_API_INFO_API_VERSION(gunyah_api.api_info));
+
+	return 0;
+}
+arch_initcall(gunyah_init);
+
+static void __exit gunyah_exit(void)
+{
+}
+module_exit(gunyah_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Hypervisor Driver");
diff --git a/include/asm-generic/gunyah.h b/include/asm-generic/gunyah.h
index 86eb59e203ef..8f9d4c649ba8 100644
--- a/include/asm-generic/gunyah.h
+++ b/include/asm-generic/gunyah.h
@@ -85,6 +85,8 @@ static inline int gh_remap_error(int gh_error)
 	((uid)[0] == prefix ## _UID0 && (uid)[1] == prefix ## _UID1 && \
 	 (uid)[2] == prefix ## _UID2 && (uid)[3] == prefix ## _UID3)
 
+#define GUNYAH_API_V1			1
+
 #define GH_API_INFO_API_VERSION(x)	(((x) >> 0) & 0x3fff)
 #define GH_API_INFO_BIG_ENDIAN(x)	(((x) >> 14) & 1)
 #define GH_API_INFO_IS_64BIT(x)		(((x) >> 15) & 1)
@@ -103,6 +105,7 @@ struct gh_hypercall_hyp_identify_resp {
 	u64 api_info;
 	u64 flags[3];
 };
+extern struct gh_hypercall_hyp_identify_resp gunyah_api;
 
 void gh_hypercall_get_uid(u32 *uid);
 void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
-- 
2.25.1

