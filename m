Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2402860E819
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiJZTBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiJZTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:00:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76BB1401F;
        Wed, 26 Oct 2022 11:59:53 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIosWw024108;
        Wed, 26 Oct 2022 18:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=lFVY44XgE+xW1WgmT1Pn1ov2NHabwW5oVvaRTvSHW8w=;
 b=IPJJ+wdhnip96aeqyQV3qQlmC2rfdVT6Cff+0Ne/FxXxV4TFNK4xzOlWuFS+9TypqyUs
 TgkgHHkz17Jz/SaDTYwn2rzI7N6TE4lVm/NEg7Lj56EgbRF8OziJdf1xJn+X0Z+jYs1r
 tZ9m7UNviXujefzSKl2E39tlfvjvyw+rpuUnPn6isyda2Nid86bj1dWF0QhTnK15MRdA
 qlD0ycKCVxdStbCeSVBYfWRzAxtxN+/w/p3JApuPy+NthomAobXzaRk4QzpJ/iueStTI
 ZLk6KLO6KcqWbmv7iaTJXhHs6S9JdHg7KXL+uMv2WdJ/ca/Z74ItGnDHXWhDZyR+gOSA 8A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahb80pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:40 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QIxeYt004243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:40 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 11:59:39 -0700
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 20/21] firmware: qcom_scm: Register Gunyah platform ops
Date:   Wed, 26 Oct 2022 11:58:45 -0700
Message-ID: <20221026185846.3983888-21-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026185846.3983888-1-quic_eberman@quicinc.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lVbxEeHJEAL5_5FpU6hcCv2u6nWvuwiS
X-Proofpoint-ORIG-GUID: lVbxEeHJEAL5_5FpU6hcCv2u6nWvuwiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210260107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/firmware/qcom_scm.c    | 114 +++++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h |   5 ++
 2 files changed, 119 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 92763dce6477..6be7c71f8609 100644
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
@@ -1292,6 +1296,113 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 }
 EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);
 
+static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm_mem_parcel *mem_parcel)
+{
+	struct qcom_scm_vmperm *new_perms;
+	u16 this_vmid;
+	u64 src, src_cpy;
+	int ret, i, n;
+
+	ret = gh_rm_get_vmid(&this_vmid);
+	if (ret)
+		return ret;
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
+	if (this_vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+		src = (1ul << this_vmid);
+	else
+		src = (1ul << QCOM_SCM_RM_MANAGED_VMID);
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
+					src |= (1ul << mem_parcel->acl_entries[n].vmid);
+				else
+					src |= (1ul << QCOM_SCM_RM_MANAGED_VMID);
+			}
+
+			if (this_vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+				new_perms[0].vmid = this_vmid;
+			else
+				new_perms[0].vmid = QCOM_SCM_RM_MANAGED_VMID;
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
+static int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm_mem_parcel *mem_parcel)
+{
+	struct qcom_scm_vmperm new_perms;
+	u16 this_vmid;
+	u64 src = 0;
+	int ret, i, n;
+
+
+	ret = gh_rm_get_vmid(&this_vmid);
+	if (ret)
+		return ret;
+
+	if (this_vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+		new_perms.vmid = this_vmid;
+	else
+		new_perms.vmid = QCOM_SCM_RM_MANAGED_VMID;
+	new_perms.perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ;
+
+	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+		if (mem_parcel->acl_entries[n].vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+			src |= (1ul << mem_parcel->acl_entries[n].vmid);
+		else
+			src |= (1ul << QCOM_SCM_RM_MANAGED_VMID);
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
@@ -1414,6 +1525,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (download_mode)
 		qcom_scm_set_download_mode(true);
 
+	if (gh_rm_register_platform_ops(&qcom_scm_gh_rm_platform_ops))
+		dev_warn(__scm->dev, "Gunyah RM platform ops were already registered\n");
+
 	return 0;
 }
 
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 6e5e67e96688..710e9a045f02 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -142,6 +142,11 @@ void gh_rm_driver_unregister(struct gh_rm_driver *ghrm_drv);
 #define module_gh_rm_driver(ghrm_drv) \
 	module_driver(ghrm_drv, gh_rm_driver_register, gh_rm_driver_unregister)
 
+struct gunyah_rm_platform_ops {
+	int (*pre_mem_share)(struct gh_rm_mem_parcel *mem_parcel);
+	int (*post_mem_reclaim)(struct gh_rm_mem_parcel *mem_parcel);
+};
+
 #if IS_ENABLED(CONFIG_GUNYAH)
 int gh_rm_register_platform_ops(struct gunyah_rm_platform_ops *platform_ops);
 void gh_rm_unregister_platform_ops(struct gunyah_rm_platform_ops *platform_ops);
-- 
2.25.1

