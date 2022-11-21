Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6482463250F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiKUOGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiKUOFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:05:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF05915A28;
        Mon, 21 Nov 2022 06:02:52 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALDpuuw002757;
        Mon, 21 Nov 2022 14:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=mXb2fL6LiNsISTP1XVQxJOuaLu5jYesWFp3pLxmAg70=;
 b=PaYdMu9/9MHoniJlEBDclScdHeHtgg4k1Q28H3iAa4ibHCPu4SuNbOvjHtdpL5UXWugF
 7HdfOk18EFV7sJsY7e5a6v7sgfHMjS2YtxRTScCongvaBG1Xu4Fkbww8JtCm6piv7nFI
 0DTWYqguGCBOB7q6NbGwi1LR6CttGmujrETdaP/k1zsT3F3bzDSS5hkFJVXkfpiiZoUI
 O6jYQnBeKhgWucqTUy0oBpRUTCc5D+BpDSBu+G66+0lJkCx+MRbsxi3FKW0M40T7l6wQ
 LQ1dnQGr1Ka9YNV4K1SJ4wXPlMiP7d7rhYlAtho+Dn9mGQyj7cgLBdpDScv07aYKiLv0 vw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrkv4j7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 14:02:22 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALE2LHm031134
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 14:02:21 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 06:02:19 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 19/20] firmware: qcom_scm: Register Gunyah platform ops
Date:   Mon, 21 Nov 2022 06:00:08 -0800
Message-ID: <20221121140009.2353512-20-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121140009.2353512-1-quic_eberman@quicinc.com>
References: <20221121140009.2353512-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F-OM38BBb85ligj1Izx4ohLwH3UxOV7Q
X-Proofpoint-ORIG-GUID: F-OM38BBb85ligj1Izx4ohLwH3UxOV7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/firmware/Kconfig    |  2 +
 drivers/firmware/qcom_scm.c | 95 +++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

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
index 92763dce6477..2dde5cd9701b 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/reset-controller.h>
 #include <linux/arm-smccc.h>
+#include <linux/gunyah_rsc_mgr.h>
 
 #include "qcom_scm.h"
 
@@ -27,6 +28,9 @@ module_param(download_mode, bool, 0);
 #define SCM_HAS_IFACE_CLK	BIT(1)
 #define SCM_HAS_BUS_CLK		BIT(2)
 
+#define QCOM_SCM_RM_MANAGED_VMID	0x3A
+#define QCOM_SCM_MAX_MANAGED_VMID	0x3F
+
 struct qcom_scm {
 	struct device *dev;
 	struct clk *core_clk;
@@ -1292,6 +1296,94 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 }
 EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);
 
+static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel)
+{
+	struct qcom_scm_vmperm *new_perms;
+	u64 src, src_cpy;
+	int ret, i, n;
+
+	new_perms = kcalloc(mem_parcel->n_acl_entries, sizeof(*new_perms), GFP_KERNEL);
+	if (!new_perms)
+		return -ENOMEM;
+
+	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+		if (mem_parcel->acl_entries[n].vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+			new_perms[n].vmid = mem_parcel->acl_entries[n].vmid;
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
+		ret = qcom_scm_assign_mem(mem_parcel->mem_entries[i].ipa_base,
+						mem_parcel->mem_entries[i].size,
+						&src_cpy, new_perms, mem_parcel->n_acl_entries);
+		if (ret) {
+			src = 0;
+			for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+				if (mem_parcel->acl_entries[n].vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+					src |= (1ull << mem_parcel->acl_entries[n].vmid);
+				else
+					src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
+			}
+
+			new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
+
+			for (i--; i >= 0; i--) {
+				src_cpy = src;
+				ret = qcom_scm_assign_mem(mem_parcel->mem_entries[i].ipa_base,
+								mem_parcel->mem_entries[i].size,
+								&src_cpy, new_perms, 1);
+				WARN_ON_ONCE(ret);
+			}
+			break;
+		}
+	}
+
+	kfree(new_perms);
+	return ret;
+}
+
+static int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm_rpc *rm,
+						struct gh_rm_mem_parcel *mem_parcel)
+{
+	struct qcom_scm_vmperm new_perms;
+	u64 src = 0;
+	int ret, i, n;
+
+	new_perms.vmid = QCOM_SCM_VMID_HLOS;
+	new_perms.perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ;
+
+	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+		if (mem_parcel->acl_entries[n].vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+			src |= (1ull << mem_parcel->acl_entries[n].vmid);
+		else
+			src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
+	}
+
+	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
+		ret = qcom_scm_assign_mem(mem_parcel->mem_entries[i].ipa_base,
+						mem_parcel->mem_entries[i].size,
+						&src, &new_perms, 1);
+		WARN_ON_ONCE(ret);
+	}
+
+	return ret;
+}
+
+static struct gunyah_rm_platform_ops qcom_scm_gh_rm_platform_ops = {
+	.pre_mem_share = qcom_scm_gh_rm_pre_mem_share,
+	.post_mem_reclaim = qcom_scm_gh_rm_post_mem_reclaim,
+};
+
 static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
 {
 	struct device_node *tcsr;
@@ -1414,6 +1506,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (download_mode)
 		qcom_scm_set_download_mode(true);
 
+	if (gh_rm_register_platform_ops(&qcom_scm_gh_rm_platform_ops))
+		dev_warn(__scm->dev, "Gunyah RM platform ops were already registered\n");
+
 	return 0;
 }
 
-- 
2.25.1

