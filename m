Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A187628DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbiKNXlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiKNXkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:40:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3513D07;
        Mon, 14 Nov 2022 15:40:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ1mHsy4sby1tDV1jm8nnHRg/baTkzoF+4gQHxrroMYbRfFqeCJyvjOXViz54c6i9K/9Y/tCxHz6vFpY7aOiUcnJWJrPMQn2sP2bGexqrG6f0SVmcXxUNLQPBSGZDQY6m7seipex0zAqffv/neAdpsTtIwYu+l4C80XF7Q71VTH/JhpeaXVNguesX6wfKScpOCoI0j09LUv9M/y/hGn2S79/FI+TZmFukRjoYWxwT/xxwpGKJXJNqafoH8z8r3lqzI7WedxkoACj/aqolnle3sRd5BXLC8LRvl+yPDwbN6Af7VpmkKVc39lCGsDz2pIiyA10HAnDUeKhWXS4JBFCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfHSkigZJdtURcwSRHFbuC2GKLepr1BHHg6iFztP8Pg=;
 b=bQ7uJPFGNfwLi1oub5h0BhJRxMUAqoEh7Z1+4Oyps1Z3P88c6DyyWJAagWo7EQ+3yNij5iM+HrLf6WyVH/uZ56m5ipG826oQhv88x4OceH0T1MEQOyqd/KpOXNDN8NBlEmlGvO3wGE06Bm7C8qYD9zwtYbo+v2pudBx4DUkcRwunVtMxaETQrKObIo4iSpT1HmRH52IwzC9dtj2kJg0pQukIyxu9t4utFX0777oBsCGf1OgE3SpDe5gfAtssw/WaFrBVSUsNU8vZlkr/+mBrqnjd4tDDxSyqKLoa/hvWOEPG1UtySadapnGWZAuFIgRK5lKTx2p30UWJ8SKoh9KUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfHSkigZJdtURcwSRHFbuC2GKLepr1BHHg6iFztP8Pg=;
 b=MEX0ZzPQQI+b+7Py7vOHOnWgweS6wU9xPOHmwSHpWSH47lG7dID9i4egR04rES/y5maCCxEhVdXTwGOYyZqgSqbrauLsJMIRKC5/MlSbCj2kxoau4Ff8FyZyVt2/IW8jZxJyK62RyedzdEMxn3jk2iWcDBEQFvZV/ErKxzuhWKY=
Received: from MW4PR04CA0339.namprd04.prod.outlook.com (2603:10b6:303:8a::14)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 23:40:50 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::e0) by MW4PR04CA0339.outlook.office365.com
 (2603:10b6:303:8a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 23:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 23:40:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 17:40:48 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 17:40:48 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 14 Nov 2022 17:40:47 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@amd.com>
CC:     <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ben Levinsky <ben.levinsky@amd.com>,
        "Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH v11 5/6] firmware: xilinx: Add RPU configuration APIs
Date:   Mon, 14 Nov 2022 15:39:39 -0800
Message-ID: <20221114233940.2096237-6-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114233940.2096237-1-tanmay.shah@amd.com>
References: <20221114233940.2096237-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0dcebe-227f-47dc-3fee-08dac699a910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZmQdsXRysFEMDL4aytFfpGTEvfQX7jh7CTIZbhlPVb9+w/au657AgZUeW9HcV+7lR9tJ2dommZX762O/vfvbrtXG3NGJHeW8DTmA9UncjfGofF0QVGnnIPEJjCT2XQocwgrI3NHYEnCMsWaGgU8UiQUxlsRVI9T0lJZK7MzL/EVMmfaYR7vNKxYVoXT7W/RhiurSKTiekHpgMRNU5UGXY/MXZ0ar9BFP2dXQi8lhGZ36KVOnMksyZX/KVw6kUvqgc91vAUluko3Zs/x4OsEt8eW04e7PBRiReTP76s02dvvQ7r7cmrx+EpWzTsF4d+QAS2RYIzIiiDyaXIy95wekTMD0YWQdCWxDlZ7OPbAr/Nn+ot2CyFFnomGrzJXYe2ELayspBwUvk7mzPrbnGHDwvsi8kVmG61INlNBPMtnB0WxXaOEUziBFO2jOV5i4vNAqz307Zvmw87QMNrDWsXSRl7xuKBHTZ8NwRgcoAzaHTK0pG92rH2D+PymDGT7o1fNkoKjQH+OMhmL6Gz7R8paBUxr/VYNiKKbS9pjcDgMvIkZo17D6l1bSu1y+qdLy3/+f3MpaN1+1qfDfu0B7r8IHy9eh9Y3nAji5Hd7YHXCkm+q8ejSA3KR+wDp+YduiUCkEqiqK8w79hDe4/99HZlFL063w+/3i2foEig/U4ToL3lNhcbSS79AgmP9DSrz/2AczgFdfiRi0Ta7jZ6/sMnrWs6h48ZQwktpmKescchxwrtHkIhhjAS0LNtMG+qAdZ4icBauD8u6jN+SF89XAQVlv23SuWT0r/uTiJOQZRow4dc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(426003)(36860700001)(54906003)(6636002)(316002)(40460700003)(2906002)(41300700001)(83380400001)(5660300002)(8936002)(2616005)(36756003)(336012)(44832011)(186003)(47076005)(40480700001)(8676002)(4326008)(26005)(1076003)(70206006)(70586007)(478600001)(82310400005)(6666004)(82740400003)(86362001)(110136005)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 23:40:49.3338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0dcebe-227f-47dc-3fee-08dac699a910
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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

This patch adds APIs to access to configure RPU and its
processor-specific memory.

That is query the run-time mode of RPU as either split or lockstep as well
as API to set this mode. In addition add APIs to access configuration of
the RPUs' tightly coupled memory (TCM).

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v11:
  - Rebase on latest rproc-next branch and resolve merge conflicts

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
  - Add missing function argument documentation

 drivers/firmware/xilinx/zynqmp.c     | 62 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 18 ++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 1865e43ed7e7..e4981e7f3500 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1159,6 +1159,68 @@ int zynqmp_pm_release_node(const u32 node)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
+/**
+ * zynqmp_pm_get_rpu_mode() - Get RPU mode
+ * @node_id:	Node ID of the device
+ * @rpu_mode:	return by reference value
+ *		either split or lockstep
+ *
+ * Return:	return 0 on success or error+reason.
+ *		if success, then  rpu_mode will be set
+ *		to current rpu mode.
+ */
+int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				  IOCTL_GET_RPU_OPER_MODE, 0, 0, ret_payload);
+
+	/* only set rpu_mode if no error */
+	if (ret == XST_PM_SUCCESS)
+		*rpu_mode = ret_payload[0];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
+
+/**
+ * zynqmp_pm_set_rpu_mode() - Set RPU mode
+ * @node_id:	Node ID of the device
+ * @rpu_mode:	Argument 1 to requested IOCTL call. either split or lockstep
+ *
+ *		This function is used to set RPU mode to split or
+ *		lockstep
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_SET_RPU_OPER_MODE, (u32)rpu_mode,
+				   0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
+
+/**
+ * zynqmp_pm_set_tcm_config - configure TCM
+ * @node_id:	Firmware specific TCM subsystem ID
+ * @tcm_mode:	Argument 1 to requested IOCTL call
+ *              either PM_RPU_TCM_COMB or PM_RPU_TCM_SPLIT
+ *
+ * This function is used to set RPU mode to split or combined
+ *
+ * Return: status: 0 for success, else failure
+ */
+int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_TCM_COMB_CONFIG, (u32)tcm_mode, 0,
+				   NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
+
 /**
  * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
  *             be powered down forcefully
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index ad3f2bd0c470..cf92e739fa3b 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -530,6 +530,9 @@ int zynqmp_pm_request_wake(const u32 node,
 			   const bool set_addr,
 			   const u64 address,
 			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode);
+int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1);
+int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1);
 int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 			     u32 value);
@@ -818,6 +821,21 @@ static inline int zynqmp_pm_request_wake(const u32 node,
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_set_sd_config(u32 node,
 					  enum pm_sd_config_type config,
 					  u32 value)
-- 
2.25.1

