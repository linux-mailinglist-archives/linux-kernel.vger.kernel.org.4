Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6546E5EE640
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiI1T6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiI1T5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:57:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2228558C6;
        Wed, 28 Sep 2022 12:57:42 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SD604K022266;
        Wed, 28 Sep 2022 19:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Mc1zaz/62brz07fbZELnYixjwK3DmS2fp3SNZl9ly/Y=;
 b=l/tPT660gQswPBCR4UL8oqsr7DWXDpaFYDYkeYwoKvQVZrWq7fWPPWXZT4Lo4hbVmYQz
 Bl24bZCFrKf0/wzR8Om5NuFQ6LKK/o9gGhdb7nHZl/4VCveBJ1UbGHBQyXiYZcCLVe0e
 NrGxjJ/8ToGlFcbMz3c4agI+Ni8Qusqw6All9v2dk1qsq4AWT9OHywaSIQMthVwUjf51
 5Xx6teXWQWnw/TzmcVln6KFN6i0Ohp5h2r7hSxfgpK5YdHVgYxkpw6mQ3GcWI7v7dbPF
 edZH/1whEu0Z/6UaTvqxktVB1evsK3aGyvuhYwfc6DB08kSldhivwgsiGq/+3UekBHwE 4w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvpuv98vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 19:57:29 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SJvSL4022185
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 19:57:28 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 12:57:27 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
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
Subject: [PATCH v4 06/14] virt: gunyah: Add sysfs nodes
Date:   Wed, 28 Sep 2022 12:56:25 -0700
Message-ID: <20220928195633.2348848-7-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928195633.2348848-1-quic_eberman@quicinc.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sBgHLd-ejEHFdoHMqrU1Drf8mlhxZz0P
X-Proofpoint-ORIG-GUID: sBgHLd-ejEHFdoHMqrU1Drf8mlhxZz0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_09,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /sys/hypervisor support when detecting that Linux is running in a
Gunyah environment. Export the version of Gunyah which is reported via
the hyp_identify hypercall.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../ABI/testing/sysfs-hypervisor-gunyah       | 15 ++++
 MAINTAINERS                                   |  1 +
 drivers/virt/Makefile                         |  1 +
 drivers/virt/gunyah/Makefile                  |  2 +
 drivers/virt/gunyah/sysfs.c                   | 71 +++++++++++++++++++
 5 files changed, 90 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-hypervisor-gunyah
 create mode 100644 drivers/virt/gunyah/Makefile
 create mode 100644 drivers/virt/gunyah/sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-hypervisor-gunyah b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
new file mode 100644
index 000000000000..7d74e74e9edd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
@@ -0,0 +1,15 @@
+What:		/sys/hypervisor/gunyah/api
+Date:		October 2022
+KernelVersion:	6.1
+Contact:	linux-arm-msm@vger.kernel.org
+Description:	If running under Gunyah:
+		The Gunyah API version.
+
+What:		/sys/hypervisor/gunyah/variant
+Date:		October 2022
+KernelVersion:	6.1
+Contact:	linux-arm-msm@vger.kernel.org
+Description:	If running under Gunyah:
+		Reports the build variant of Gunyah:
+		The open source build of Gunyah will report "81".
+		The Qualcomm build of Gunyah will report "72".
diff --git a/MAINTAINERS b/MAINTAINERS
index feafac12db35..a26e67ef36b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8885,6 +8885,7 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
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
index 000000000000..e15f16c17142
--- /dev/null
+++ b/drivers/virt/gunyah/Makefile
@@ -0,0 +1,2 @@
+gunyah-y += sysfs.o
+obj-$(CONFIG_GUNYAH) += gunyah.o
diff --git a/drivers/virt/gunyah/sysfs.c b/drivers/virt/gunyah/sysfs.c
new file mode 100644
index 000000000000..ec11510cbece
--- /dev/null
+++ b/drivers/virt/gunyah/sysfs.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gunyah: " fmt
+
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <asm-generic/gunyah.h>
+
+static struct gh_hypercall_hyp_identify_resp gunyah_api;
+
+static ssize_t api_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
+{
+	return sysfs_emit(buffer, "%d\n", (int)GH_API_INFO_API_VERSION(gunyah_api.api_info));
+}
+static struct kobj_attribute api_attr = __ATTR_RO(api);
+
+static ssize_t variant_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
+{
+	return sysfs_emit(buffer, "%d\n", (int)GH_API_INFO_VARIANT(gunyah_api.api_info));
+}
+static struct kobj_attribute variant_attr = __ATTR_RO(variant);
+
+static struct attribute *gunyah_attrs[] = {
+	&api_attr.attr,
+	&variant_attr.attr,
+	NULL
+};
+
+static const struct attribute_group gunyah_group = {
+	.name = "gunyah",
+	.attrs = gunyah_attrs,
+};
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
+	if (GH_API_INFO_API_VERSION(gunyah_api.api_info) != 1) {
+		pr_warn("Unrecognized gunyah version: %llu. Currently supported: 1\n",
+			GH_API_INFO_API_VERSION(gunyah_api.api_info));
+		return 0;
+	}
+
+	pr_notice("Running under Gunyah hypervisor %llx/v%lld\n",
+		  GH_API_INFO_VARIANT(gunyah_api.api_info),
+		  GH_API_INFO_API_VERSION(gunyah_api.api_info));
+
+	return sysfs_create_group(hypervisor_kobj, &gunyah_group);
+}
+module_init(gunyah_init);
+
+static void __exit gunyah_exit(void)
+{
+	sysfs_remove_group(hypervisor_kobj, &gunyah_group);
+}
+module_exit(gunyah_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Hypervisor Driver");
-- 
2.25.1

