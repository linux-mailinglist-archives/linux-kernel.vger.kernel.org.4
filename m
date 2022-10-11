Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448275FBCDE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJKVZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJKVZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:25:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1569A8A7FF;
        Tue, 11 Oct 2022 14:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U91YUxVLMggX7XPDd98Wj/bYFur1xvQVqZRoXXn5IR1+VN713cq/bBynhZxuo2869GNHFZex+RI3pLv6RyT/sgSfkHECBXh1690WT8MQxcayoceeDtLWCzclEx4KaZWvSbtFis64QO6HqcjTgAo2TCJrdKHp5qacVdE3+bm5fVBCAtqZNkcLEsVMqZH9qSWcagAfu95g7epKKzXrP6pXc8OYK/mwHS4WtzE/71Iyx6vDcIPH9zM2BmmEYtj/sD6KacUV9TLtQVt53qAz1XzFX1djV+7lCRvhwNAT5W1EXG5wYJhfrCkxXCI50NJQYxAqg1ELWaYqv4Axmi+/Icx3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epHRU+5owBwWLILIhQzBGxcH5lCALyC8zpUbPw0INqk=;
 b=GQVOuL91bZcH/duYbdX0JB+25Yg06wMKkuVIgiteK/w6aPTWdImAEa52fuE9FrvEHQc0DziOQlO2yBSflFLy3Xg4URN/nu6/DaZj2nqrZoAzf4ENdbcQZFq1ndFoxdG26HkgxVZAuIuElLEIYNr+i1C9qg2ub7s7TNJn0xKFNzmxQ9yMQAxevHVCt+Jpk5W+yT7n65mTCTGwh06Eih9ST3qxjnQvuNGZMikyCAeaowViq7KHIY1D2pRnbQSvycNMahl3Stgsq4X3hdEM8U9LXlxd9pMcsk1eTfO+wuIeZiAnfzFgOiKF1i/opMGXZa83fsBl6UoUrQPugWiAdojZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epHRU+5owBwWLILIhQzBGxcH5lCALyC8zpUbPw0INqk=;
 b=uhJchU5h3+sOuZVyiKCffa5NG8JizQynTSkSHk3fzorhi06nPk24wdmJWDo06uZ/bxj7r5ibIvIKg4y8ROBxBtr7+eJ2gT6K9cu2WKzos/HyGb8Pqillq+PtTDrDyYZWdF7uc4PfCauq6iqEIaiQ/6bGXPgesGSejzE2U4V4lyQ=
Received: from BN9PR03CA0381.namprd03.prod.outlook.com (2603:10b6:408:f7::26)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Tue, 11 Oct
 2022 21:25:16 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::7) by BN9PR03CA0381.outlook.office365.com
 (2603:10b6:408:f7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.20 via Frontend
 Transport; Tue, 11 Oct 2022 21:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 21:25:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 16:25:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 14:25:15 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 16:25:14 -0500
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
Subject: [PATCH v10 5/6] firmware: xilinx: Add RPU configuration APIs
Date:   Tue, 11 Oct 2022 14:25:00 -0700
Message-ID: <20221011212501.2661003-6-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011212501.2661003-1-tanmay.shah@amd.com>
References: <20221011212501.2661003-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 836a7480-c220-4d67-11d9-08daabcf1758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K172I7gvCkmjX/FFOdcEePbFsUL9Ycuoo5+BCdsY/0TemM+7VigaotXuZpWjolctRN4tCFKHtULZ6V1t6/LLmVZHHHkItxorP1JnPevhezZEKrzUlRfBEnxWhYjKPMaV2X2BQ9lh9bK8rW/bgSaiEN3tkj8ZvRx6+fjbFTi0KatzFH8jNVt+r02GMrWiZINNJLRNiJhZUeiw3OqouF85PCgFSzW4kedNeasvy+w/lEtZDAcNu5aSHB6Oalh/BwnM9QsLZknvVWz/5i4MJmXX3BqwYXxWAucsUAy1BxiY4wJsxv7rTdUUkDdBpypWmHxOefKdHMMEISsCilsv1/WEVtYhmocJUqlNC4xPDWMKLIL4Z/uX8RAC/QUnGG9s7vYsWI5LMFxfDsgz7hrNrCFmKBSMQiYi1dzlJ28NtbUJzK7xhpTlS3vCg2MDS7JsFkQdw72ZZ7qncXaH6+QasGq1oREuT79TjQqLsquxLmMlXSsWKKh1IKTFanSzDShj4jEwwUVrIfi9fquBJVRFSXNRGjoe1UYUsniPRifLyX051N0/oOTCcPyw+zqwXn1WNWTTYLGPgVECUHvxfUQTA/HYYnBTJX3IeJwckATAq6WBIF/Kkjk10pjjNlh2oBTd6S2b2SUGZmXGpmLO79OPQ31Xzek2/KSQOfcPsNJRU9EXtnHKjetU9kAAzmvblL1SjC6Cj++JPv12nig6p3mtMhHW3k1wHJHIdjoZKeYkPEA3BTilfzIdm/tloF//ykxEhN6hvIcWvto/aBlky+s133eJCEJKPZSx6zlPqkFtndSAd5s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(2616005)(83380400001)(336012)(356005)(81166007)(426003)(186003)(1076003)(44832011)(82740400003)(26005)(5660300002)(2906002)(70206006)(41300700001)(40480700001)(40460700003)(54906003)(8936002)(36860700001)(316002)(478600001)(70586007)(110136005)(4326008)(8676002)(6666004)(6636002)(82310400005)(47076005)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 21:25:16.4105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836a7480-c220-4d67-11d9-08daabcf1758
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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
index edb13167170f..eba359e66414 100644
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
index d52f8413b892..83c69c968e32 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -503,6 +503,9 @@ int zynqmp_pm_request_wake(const u32 node,
 			   const bool set_addr,
 			   const u64 address,
 			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode);
+int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1);
+int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -787,6 +790,21 @@ static inline int zynqmp_pm_request_wake(const u32 node,
 {
 	return -ENODEV;
 }
+
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
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.25.1

