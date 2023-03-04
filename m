Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA246AA6FD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 02:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCDBII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 20:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCDBHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 20:07:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F46B320;
        Fri,  3 Mar 2023 17:07:20 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323NuXtr009343;
        Sat, 4 Mar 2023 01:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=eWmxb3IZ5TQifCieDXFnzJeJsGPL7l3OYuz4phDHOj4=;
 b=bert6cQlkYJYzjchLumj2/6tAkBNhylJ+3auqkwZ1QhfB0WPJkhfBd9XidBZH+HI0FSQ
 0xM5bNYJaMno0xCe0Ff3G2HjbvEnNeBc4OJUhFlN3laO31j+1f0ZkDUgskVPulEzpVH1
 21b13/gW9RfQbu21wfOYug2AgAh4xFWU/iuTG5SiICWV9DiTFEg7n8TXNLtz8azGHYAJ
 zUsYel+F+NuaMhXfXJKJcSFrJEtRtkbzn+gi4DpqiwOpBjnISRg0wWZkcghjhAh/tlE9
 f5Hy3tRKalIwC0HicrGBKKwDchM/LYA5CINNBAH4hYnlSrqp1IqJPtamBdDOhfhzkGsx lg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3c8htrc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Mar 2023 01:07:09 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 324178xc019344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 4 Mar 2023 01:07:08 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 3 Mar 2023 17:07:07 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v11 16/26] firmware: qcom_scm: Register Gunyah platform ops
Date:   Fri, 3 Mar 2023 17:06:22 -0800
Message-ID: <20230304010632.2127470-17-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304010632.2127470-1-quic_eberman@quicinc.com>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VuMJC0YlIYTeKEJ9x10zbLd46YuWVSWY
X-Proofpoint-ORIG-GUID: VuMJC0YlIYTeKEJ9x10zbLd46YuWVSWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_07,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303040004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/firmware/Kconfig       |   2 +
 drivers/firmware/qcom_scm.c    | 100 +++++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h |   2 +-
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..b888068ff6f2 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -214,6 +214,8 @@ config MTK_ADSP_IPC
 
 config QCOM_SCM
 	tristate
+	select VIRT_DRIVERS
+	select GUNYAH_PLATFORM_HOOKS
 
 config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 	bool "Qualcomm download mode enabled by default"
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index b95616b35bff..89a261a9e021 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -20,6 +20,7 @@
 #include <linux/clk.h>
 #include <linux/reset-controller.h>
 #include <linux/arm-smccc.h>
+#include <linux/gunyah_rsc_mgr.h>
 
 #include "qcom_scm.h"
 
@@ -30,6 +31,9 @@ module_param(download_mode, bool, 0);
 #define SCM_HAS_IFACE_CLK	BIT(1)
 #define SCM_HAS_BUS_CLK		BIT(2)
 
+#define QCOM_SCM_RM_MANAGED_VMID	0x3A
+#define QCOM_SCM_MAX_MANAGED_VMID	0x3F
+
 struct qcom_scm {
 	struct device *dev;
 	struct clk *core_clk;
@@ -1299,6 +1303,99 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 }
 EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);
 
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
+		ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
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
+						le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
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
+		ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
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
 static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
 {
 	struct device_node *tcsr;
@@ -1502,6 +1599,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (download_mode)
 		qcom_scm_set_download_mode(true);
 
+	if (devm_gh_rm_register_platform_ops(&pdev->dev, &qcom_scm_gh_rm_platform_ops))
+		dev_warn(__scm->dev, "Gunyah RM platform ops were already registered\n");
+
 	return 0;
 }
 
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 515087931a2b..acf8c1545a6c 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -145,7 +145,7 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
 				struct gh_rm_hyp_resources **resources);
 int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
 
-struct gunyah_rm_platform_ops {
+struct gh_rm_platform_ops {
 	int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
 	int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
 };
-- 
2.39.2

