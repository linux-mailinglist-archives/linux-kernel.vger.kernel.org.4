Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4705E651645
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiLSXDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiLSXBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:01:50 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72E01178;
        Mon, 19 Dec 2022 15:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671490844; x=1703026844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8UhbIO+bjFBQdkCiu8pP4FCYrwf/TNyQmQumJGPtH4E=;
  b=mqL+MaM0oAt3wNjvSQZPsr6lUcAJ7uwgwCDKimAPcvtu5OgzAZQ5jwl/
   o+Qa91l9e1BnAH3t6V7gzcQ6yA+4xB7pdMZw3HEN5by5w7IGPS6vH3NDX
   NsBqsRVOg87nxXD3NRkPL9Tiv1fBP4kjzKqwn0yVYULq+IE08CZnn44MH
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Dec 2022 15:00:43 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 15:00:43 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:42 -0800
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 19/28] firmware: qcom_scm: Register Gunyah platform ops
Date:   Mon, 19 Dec 2022 14:58:40 -0800
Message-ID: <20221219225850.2397345-20-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 92763dce6477..bebc848cd3c5 100644
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
+	int ret = 0, i, n;
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
+	int ret = 0, i, n;
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

