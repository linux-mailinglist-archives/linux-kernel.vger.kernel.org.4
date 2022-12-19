Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A49C65162D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiLSXCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiLSXBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:01:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F30E51;
        Mon, 19 Dec 2022 15:00:40 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJKfAMd022223;
        Mon, 19 Dec 2022 23:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=HF4iBQ+cZRuNQfUCG3QLF2FXAPRplCw3XpMEge6HY8k=;
 b=O/p1DlSW7Ob467RQVAx6SbgS7/tlRvNwumhPFfgLecQhEwlG1S068RgB9FldOlsb9FyU
 NtEzl5LYjLm4dZJ6eNzu8gzcdjbCebv+XX289LZNrH+MBrieVI6ir4/BK0p8FWke/LgC
 cQJZ4SMYNr5k+shNZNvtG2ZyzBjXrcvNFesmZ/cSqA3mxRyWm6BVdGBnO6CKz0gRurOd
 C4drtdBZjLURlzSdx36JEhb3kQGrj4qj/9EuomE6BxfE6oQqbg6bgAPREGD7EEAKMkq0
 OBX68z7UdsQz8LM3Dnj+yT9SlafiB4d9QErRJcljkbQ8Yw7m8+pB5jU1CPVDcCAvIZca iA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjkwqsk6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:23 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0MZL018881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:22 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:21 -0800
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
Subject: [PATCH v8 06/28] virt: gunyah: Identify hypervisor version
Date:   Mon, 19 Dec 2022 14:58:27 -0800
Message-ID: <20221219225850.2397345-7-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: j84v7y38ynZzjec5L9VK6_j-hh90Hx4t
X-Proofpoint-ORIG-GUID: j84v7y38ynZzjec5L9VK6_j-hh90Hx4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
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

Export the version of Gunyah which is reported via the hyp_identify
hypercall. Increments of the major API version indicate possibly
backwards incompatible changes.

Export the hypervisor identity so that Gunyah drivers can act according
to the major API version.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/Makefile        |  1 +
 drivers/virt/gunyah/Makefile |  1 +
 drivers/virt/gunyah/gunyah.c | 46 ++++++++++++++++++++++++++++++++++++
 include/linux/gunyah.h       |  6 +++++
 4 files changed, 54 insertions(+)
 create mode 100644 drivers/virt/gunyah/Makefile
 create mode 100644 drivers/virt/gunyah/gunyah.c

diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 093674e05c40..92b7e5311548 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
 obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
 obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
+obj-y				+= gunyah/
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
new file mode 100644
index 000000000000..2ac4ee64b89d
--- /dev/null
+++ b/drivers/virt/gunyah/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_GUNYAH) += gunyah.o
diff --git a/drivers/virt/gunyah/gunyah.c b/drivers/virt/gunyah/gunyah.c
new file mode 100644
index 000000000000..c34c9046fc08
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gunyah: " fmt
+
+#include <linux/gunyah.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+struct gh_hypercall_hyp_identify_resp gunyah_api;
+EXPORT_SYMBOL_GPL(gunyah_api);
+
+static const uint32_t gunyah_known_uuids[][4] = {
+	{0x19bd54bd, 0x0b37571b, 0x946f609b, 0x54539de6}, /* QC_HYP (Qualcomm's build) */
+	{0x673d5f14, 0x9265ce36, 0xa4535fdb, 0xc1d58fcd}, /* GUNYAH (open source build) */
+};
+
+static int __init gunyah_init(void)
+{
+	u32 uid[4];
+	int i;
+
+	gh_hypercall_get_uid(uid);
+
+	for (i = 0; i < ARRAY_SIZE(gunyah_known_uuids); i++)
+		if (!memcmp(uid, gunyah_known_uuids[i], sizeof(uid)))
+			break;
+
+	if (i == ARRAY_SIZE(gunyah_known_uuids))
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
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 2765d2b40198..166156f69df9 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -92,6 +92,12 @@ struct gh_hypercall_hyp_identify_resp {
 	u64 api_info;
 	u64 flags[3];
 };
+extern struct gh_hypercall_hyp_identify_resp gunyah_api;
+
+static inline u16 gh_api_version(void)
+{
+	return FIELD_GET(GH_API_INFO_API_VERSION_MASK, gunyah_api.api_info);
+}
 
 void gh_hypercall_get_uid(u32 uid[4]);
 void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
-- 
2.25.1

