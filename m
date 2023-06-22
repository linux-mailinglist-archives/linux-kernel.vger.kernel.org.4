Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6682973A52D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjFVPg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjFVPgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:36:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C178BE42;
        Thu, 22 Jun 2023 08:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apon558/odtCKX4PENSkkynPNzgEas9yD2oX8F2niU56bk13Gj1fXcuadhRHIEehwbEHX6EetzJSADLZ1pkoRzTa9V4JpMHsCeZFu7nGYlGsQ26l0oKJzA2yePzj1pyU0f0MIOKRy9eQqZL+NRd+cD3wYC1JDC+XH6IbdezYhlcOuXxx/ZHAl0QAiocs6cfduzq4i8c6LZ9yMbTySmwtUCEexXc5qkrd240vdBnRzPu/iCf8I3E5cvo5rVKdYYhj7RBs9u2McfnhWMNGwKku7r4Tiet8ecPEOKaDav7mah2FB7CtfFyfGNkO1Yc6qxgzT0SmyDgMKxYeAMQJ7tYflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc+RFBLhHBbj+BpmB2sMllwjT1d6e33rEgLutCGjt+c=;
 b=kL0gAUqejn2rxDFnJzjbmce1pYeJ8tZbvE2J05RLORVkPYXgQxV+sVPEN7s6q9Wu/wYsWz00P6niIZuaHwx7Na0xGP39/pfbUApNiDvv77T3jzblN1y8Bc/kXrfFETjVbfR/sEPmvf1KL2+BZe2ooSkNdsqSGfTrx/vJW63NssTGsi+rOOy5udpE8ew90OTGBecakW0q7uzge3t1dpYZ6XGADPvIJn7GmPeXU2Chjagz4UuE/pXAfkfFCxFNoMqJYpWCv+BmB32CKuVYLq9uFpcF9fPQskwnLK5mBPdcFj/tdhnnx+jUeHlPT6MZcOhFFnBbRYbiVkgpWls7LhrKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc+RFBLhHBbj+BpmB2sMllwjT1d6e33rEgLutCGjt+c=;
 b=uBfJbK+mu1GWLXYFlPhUQDcLqmvh/sSRzemfpbO+dYnBLxHq33QIRPpeY9fpBrPwg2mYLReqhXoOaVBHrYcdKoGIwF9QZEBVVG3OM6ZoW/EhRYlCkIPXERBFv/CCyk77XPk52D/VdvG+Mtiq7x4en3YzKl+zuyVwfw0uhtQJ2mabXPuRwa4SZCHIVwncI2v4y1+JiEtqVgWt7N7SCJ6gdxtFWvZUNFu+ncbe52gSThTqc8SBw1TwK0IWLYYaKwiLv4eobq9QkTsYolfcrEwZYGtecg998dCePB8m4+BQoWPwH80mkQ+ovf3KjxEL0+isroJHYrej0cl7mPBkI/L4IQ==
Received: from MW4PR04CA0326.namprd04.prod.outlook.com (2603:10b6:303:82::31)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:36:16 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::d8) by MW4PR04CA0326.outlook.office365.com
 (2603:10b6:303:82::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 15:36:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 08:36:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 08:36:05 -0700
Received: from build-jeshuas-20230620T084931826.internal (10.127.8.14) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Thu, 22 Jun 2023 08:36:05 -0700
From:   Jeshua Smith <jeshuas@nvidia.com>
To:     <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <lenb@kernel.org>, <james.morse@arm.com>,
        <bp@alien8.de>
CC:     <rafael@kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeshua Smith <jeshuas@nvidia.com>
Subject: [PATCH] ACPI: APEI: Use ERST timeout for slow devices
Date:   Thu, 22 Jun 2023 15:35:54 +0000
Message-ID: <20230622153554.16847-1-jeshuas@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: c42a7d06-dc54-46cf-0f0a-08db73366ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VewTLpB4Zyu+5vBwPBMCKxoRxkC1aPxJb/0M+506/TH0D9Qt+U2iVidSnq208Z86ecRZlHFoy1RaQJLdTITXSTtgH8Bj0YQEVgicmkykZTI52gDeSyvSRwYrC/e54m+ejeYGwkgqZIQDAVJ4IjlUwumzotrPypfQ7tgpyHkKPtdHJ5KNqQaL72Up3PRR9x/C7zT7Nbe65kyvZ+0yCeXOyJAyLjbj/kTaKtks9Ir01eJnl1h0cLuWOQ9KFQUGe75fKcKqRcsKwHUa4J7sVGhc0IOd+m1KRW3VAPj9tbWiCR9o7KKStCsg7v0IL3h2DzYgk2DyiGIVbcyL2Hc6OHKCyYV29qv4yqwuRZVvFyJcfYvBkeP38WJ8k0EEXxQdO02knDlP4odZIQ25ZDpk9Z8Z4CUtTMOzJMOwqzsgrMwOWg7BdjLWBb52wghIOKQBalTWXMMr+KxxmFEeXE25tCXEWeokklUWvCbDQoBt/gSTDMhVM3bYEkM98hPhYSWDVZu+Qj5Ito+Mn315mTaqPQAyi7TIhoFOmhKjnoPZV3WRRgYfQ1HJ4so+3wJjZXbOQ5ZIUFvMCmuKUF/SWl4FFkfPCWFRSv9TzlBgCON2VYbJXBAagwMb/InKhjOz++IVKJ4WPABSZ5r4CUzpbBZyvA6OgJ3PFdH1C8hA1OGhCPwzur7g9IIYP6xZAwxJfukSCQAJcux9hP3FZQFPWjJPAroGE/kovmlVzX0kWAAsftrQ3dj/4DZS2vDztazJfL1NAuXK
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(6666004)(54906003)(110136005)(4326008)(47076005)(40480700001)(336012)(83380400001)(426003)(86362001)(36756003)(36860700001)(40460700003)(2616005)(70586007)(2906002)(82310400005)(1076003)(107886003)(26005)(186003)(356005)(7636003)(82740400003)(41300700001)(8676002)(7416002)(8936002)(70206006)(316002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:36:15.9895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c42a7d06-dc54-46cf-0f0a-08db73366ad5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slow devices such as flash may not meet the default 1ms timeout value,
so use the ERST max execution time value that they provide as the
timeout if it is larger.

Signed-off-by: Jeshua Smith <jeshuas@nvidia.com>
---
 drivers/acpi/apei/erst.c | 41 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 247989060e29..eb0a05f032df 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -10,6 +10,7 @@
  *
  * Copyright 2010 Intel Corp.
  *   Author: Huang Ying <ying.huang@intel.com>
+ * Copyright (c) 2023 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -59,6 +60,12 @@ static struct acpi_table_erst *erst_tab;
 #define ERST_RANGE_NVRAM	0x0002
 #define ERST_RANGE_SLOW		0x0004
 
+/* ERST Exec timings */
+#define ERST_EXEC_TIMING_MAX_MASK      0xFFFFFFFF00000000
+#define ERST_EXEC_TIMING_MAX_SHIFT     32
+#define ERST_EXEC_TIMING_TYPICAL_MASK  0x00000000FFFFFFFF
+#define ERST_EXEC_TIMING_TYPICAL_SHIFT 0
+
 /*
  * ERST Error Log Address Range, used as buffer for reading/writing
  * error records.
@@ -68,6 +75,7 @@ static struct erst_erange {
 	u64 size;
 	void __iomem *vaddr;
 	u32 attr;
+	u64 timings;
 } erst_erange;
 
 /*
@@ -97,6 +105,19 @@ static inline int erst_errno(int command_status)
 	}
 }
 
+static inline u64 erst_get_timeout(void)
+{
+	u64 timeout = FIRMWARE_TIMEOUT;
+
+	if (erst_erange.attr & ERST_RANGE_SLOW) {
+		timeout = ((erst_erange.timings & ERST_EXEC_TIMING_MAX_MASK) >>
+			ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_MSEC;
+		if (timeout < FIRMWARE_TIMEOUT)
+			timeout = FIRMWARE_TIMEOUT;
+	}
+	return timeout;
+}
+
 static int erst_timedout(u64 *t, u64 spin_unit)
 {
 	if ((s64)*t < spin_unit) {
@@ -191,9 +212,11 @@ static int erst_exec_stall_while_true(struct apei_exec_context *ctx,
 {
 	int rc;
 	u64 val;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 stall_time;
 
+	timeout = erst_get_timeout();
+
 	if (ctx->var1 > FIRMWARE_MAX_STALL) {
 		if (!in_nmi())
 			pr_warn(FW_WARN
@@ -389,6 +412,10 @@ static int erst_get_erange(struct erst_erange *range)
 	if (rc)
 		return rc;
 	range->attr = apei_exec_ctx_get_output(&ctx);
+	rc = apei_exec_run(&ctx, ACPI_ERST_EXECUTE_TIMINGS);
+	if (rc)
+		return rc;
+	range->timings = apei_exec_ctx_get_output(&ctx);
 
 	return 0;
 }
@@ -621,10 +648,12 @@ EXPORT_SYMBOL_GPL(erst_get_record_id_end);
 static int __erst_write_to_storage(u64 offset)
 {
 	struct apei_exec_context ctx;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
 
+	timeout = erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc = apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_WRITE);
 	if (rc)
@@ -660,10 +689,12 @@ static int __erst_write_to_storage(u64 offset)
 static int __erst_read_from_storage(u64 record_id, u64 offset)
 {
 	struct apei_exec_context ctx;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
 
+	timeout = erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc = apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_READ);
 	if (rc)
@@ -703,10 +734,12 @@ static int __erst_read_from_storage(u64 record_id, u64 offset)
 static int __erst_clear_from_storage(u64 record_id)
 {
 	struct apei_exec_context ctx;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
 
+	timeout = erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc = apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_CLEAR);
 	if (rc)
-- 
2.25.1

