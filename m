Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2465FBCDD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJKVZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJKVZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:25:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23EA1583A;
        Tue, 11 Oct 2022 14:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl7sTn+/gi3zP7rbWPjDgYWYOU1m3m9wUu0qNZjr6aCfBYGvKe9jMwmHg/yxRnarJEfJqCzqGTxNCZ/poErpWwcHBS2e24NbEfmKp7yeOtDt0IaCdQmS5fly8p/uHuM8O87peUyiBMU5fwrySGGujQHvIEIET1Kd0rV+Q1eQnpdp4Z1Hmc8CRuGPJwj+9NYrEIVh9mGhYWiu6r045RT5fZkvdUG6oFbOPlGYFXq+kFEg+hBSV+0Flve31lxHHX995T+FzUx2v7Zz0tzUx6cHAJZ/qf7hz0BDThjLAROhxsgIMu36UANgWTQ4xNFa5eshx38jCOe/e+eZCSpFjuesFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkLX/i3PQxqPLQJsN/ULD/C3mywqMmzCoPKU9RtlYs4=;
 b=hVjSOo6I1zNxR3J/HRX83mZA6p2PXk8WoxCFcOiJOIixC1AN9x9HTGKTSUYdnGQ3kntGl3B1wqsPXNITzO2GISy8z4Xpw5xycpUvE4MIEn8tBbqxQzDIrMx8vOantaNbUdsjW+CPkRdCoF3ZAj91TH5A43ZFk1XhkmBqH+LwUFFLGHOorpb+OsclFE+8BSKfRDXNAV9TRewK93SyFdy4W9DS5P8ovZcfCeVrN1FSUEhK7+Yz1jgWGWDrid5WR8IxZtosmcNHF1taFRCPrFSzhjZaaTW+VN232wwAdjZ870RMZ6lG3mdm4e1iy79KF802q1U4QF2JfOgSPNkys9EhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkLX/i3PQxqPLQJsN/ULD/C3mywqMmzCoPKU9RtlYs4=;
 b=QA55d468ETTkk2p57wdIG8bxxdHuKCYGyxKL0SMffAQr+4iroZlcsFAb6UOXBQCO35XJYEJ53IUXWa8IodlvmM5MPZWpkCY8ERTGgCDhzL0lqcpREADSN75imGpxNE5L0fYlBgkMpaTk8XwNDCvcWajcP3+5lumiA5IZe6aIqGI=
Received: from MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::11)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 21:25:16 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::5) by MW4P221CA0006.outlook.office365.com
 (2603:10b6:303:8b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.43 via Frontend
 Transport; Tue, 11 Oct 2022 21:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 11 Oct 2022 21:25:15 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 16:25:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 14:25:14 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 16:25:13 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ben Levinsky <ben.levinsky@amd.com>
Subject: [PATCH v10 4/6] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Tue, 11 Oct 2022 14:24:59 -0700
Message-ID: <20221011212501.2661003-5-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011212501.2661003-1-tanmay.shah@amd.com>
References: <20221011212501.2661003-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b4a60e-1d13-41f2-7cea-08daabcf1719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HE8T1S0N0qeWxFBftXCDhXYE96h0z43wN1TLdzGt4h+X230As4zBA57UCzWEpS7vTSBvcofk6KRTE9llvwbZNtEMEcqooZshubQ4WdGdjkfFBMB1tQYrnhPvK8d9QoIW8yc+pRY10lxXgkxJXo+k7/cLzAE5ANOA04D2r+1OpmKEmD+JAubiYecib0oW41LVKLbL+6L5VEQGL5PwNg6HcBpU+Mv2xpT27SU/y0Wnw0bzr/mhly/nvH9MBrSs99v1JMsE8TrQWhbti3lO2d9e/+EHJuYW9qf0pgQJTPhwFciVMveXlHb70f060H0XKuK5pdw+bu+gviA8faU/OlfdcdsNy+qSasWvel6tXrvVcduBa7Ul8/K6LfSrLsFcpRZG16vK3CDTko/DRmq/MqUMjcejiDLGev4sC8fyaoktVH6d+rykT7JQdGfZYFzJeF906SlR47U3lTxOAWKsUbYQ5j/LU3oPx6bSmeOZO1UXHg6hzJ/pQ5p8P032Jp6jVOy9N7g4hlzw/XMOedFgAaHHzHjj7vfDxO2sa+PyGgmzDv+m+qst3QP73Rrsm22tebzQuJG0ouO4/MlFRp9mXyYD4v1pxx0Z4z4y/sDj9QCXlhUrUENv4O6zRj9FF9o398/RkwMcRT2M6xhzGjPk61qhZVFTEeQvYgmtoXfLVkY7POYqWFBct8Xv501BqjdKwPzkOHYBAyBbHWBiJ+HwZg2/38Xgh7dJQeJqAuJmTAGSTaJu+KXBLRp1UNNx/XtqHypm4ueEPi0Gat0c+EOdBvXD/9p2kiyhyIbTBNGSmw2NVKwabQgfRp7LvWlU88gKcSet
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(26005)(36860700001)(40480700001)(47076005)(83380400001)(336012)(186003)(2616005)(2906002)(5660300002)(6666004)(44832011)(40460700003)(82310400005)(54906003)(8936002)(41300700001)(478600001)(1076003)(70206006)(70586007)(8676002)(110136005)(6636002)(426003)(316002)(4326008)(36756003)(81166007)(356005)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 21:25:15.8754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b4a60e-1d13-41f2-7cea-08daabcf1719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Levinsky <ben.levinsky@amd.com>

Add shutdown/wakeup a resource eemi operations to shutdown
or bringup a resource.

Note alignment of args matches convention of other fn's in this file.
The reason being that the long fn name results in aligned args that
otherwise go over 80 chars so shift right to avoid this

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v10:
  - None

Changes in v9:
  - None

Changes in v8:
  - None

Changes in v7:
  - None

Changes in v6:
  - None

Changes in v5:
  - None

Changes in v4:
  - None

Changes in v3:
  - None

 drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 23 ++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index d1f652802181..edb13167170f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1159,6 +1159,41 @@ int zynqmp_pm_release_node(const u32 node)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
+/**
+ * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
+ *             be powered down forcefully
+ * @node:  Node ID of the targeted PU or subsystem
+ * @ack:   Flag to specify whether acknowledge is requested
+ *
+ * Return: status, either success or error+reason
+ */
+int zynqmp_pm_force_pwrdwn(const u32 node,
+			   const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, node, ack, 0, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_force_pwrdwn);
+
+/**
+ * zynqmp_pm_request_wake - PM call to wake up selected master or subsystem
+ * @node:  Node ID of the master or subsystem
+ * @set_addr:  Specifies whether the address argument is relevant
+ * @address:   Address from which to resume when woken up
+ * @ack:   Flag to specify whether acknowledge requested
+ *
+ * Return: status, either success or error+reason
+ */
+int zynqmp_pm_request_wake(const u32 node,
+			   const bool set_addr,
+			   const u64 address,
+			   const enum zynqmp_pm_request_ack ack)
+{
+	/* set_addr flag is encoded into 1st bit of address */
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
+				   address >> 32, ack, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_request_wake);
+
 /**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index e00a25aa2c17..d52f8413b892 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -12,6 +12,7 @@
 
 #ifndef __FIRMWARE_ZYNQMP_H__
 #define __FIRMWARE_ZYNQMP_H__
+#include <linux/types.h>
 
 #include <linux/err.h>
 
@@ -87,6 +88,8 @@ enum pm_api_cb_id {
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_REGISTER_NOTIFIER = 5,
+	PM_FORCE_POWERDOWN = 8,
+	PM_REQUEST_WAKEUP = 10,
 	PM_SYSTEM_SHUTDOWN = 12,
 	PM_REQUEST_NODE = 13,
 	PM_RELEASE_NODE = 14,
@@ -494,6 +497,12 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
 int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
+int zynqmp_pm_force_pwrdwn(const u32 target,
+			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_request_wake(const u32 node,
+			   const bool set_addr,
+			   const u64 address,
+			   const enum zynqmp_pm_request_ack ack);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -764,6 +773,20 @@ static inline int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_force_pwrdwn(const u32 target,
+					 const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_request_wake(const u32 node,
+					 const bool set_addr,
+					 const u64 address,
+					 const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.25.1

