Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23497735DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjFSTFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjFSTFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:05:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FDE101;
        Mon, 19 Jun 2023 12:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djLcdE/w8l8lMjCSJdWbDnD4iOqWWqV2P3e7oL9QTpvtVYEo/6iV4KcAu6CpP8v5sAY6Ow97xnNsjpQw3G/YCKos3KITXaHEpw1ykDf+mIkmb7BJqTGUIQF/TjeoVqFFD5Lqz9Ukbw8nay/vSBZok9Nt+ugHUvCXErVnnuARld8uc4zK/luXgKLa+FWQY9j4LY9vd0ITjHxx6PRz7eq+kEk8/qm6nn44noDaVaWqql7PUHW+4UfprRZJ9x6ENnLQN/fkf1x1Nt84vWk/yMpI+ccOy2+3l71X4juZqV+023Z9vonpf+V9QQNpsJJGBaB6Fw3nGy5AKmXAe6PbLqgC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHcEL9FAExU/6yuRYsG+FsS2p0pbRi6Ph0vnHhf1Ffc=;
 b=nUOA5iQobtjfx1JIEq0CU9ZLbbADJ9mdblfmeaIkBL8oh4xj+uvRsEqEzc06CuA5LXSmLBY4haRmYKJZx5yqCL4UW5UnQRg20ggoWZkrcYzFmiUxZh43GyB0fE4NkW/b/8RTyB/kg/j6RDSZkfEyBevX+r7QABr0XZPXlSaubPN4aU0qkmDboRsCtxOAXTPnHdfOB8KElUYCmGz5/JtCzXiWy10iFJhaaN7Y5hlrdCusQZbg/hsjp8B248KKyZcEJsVbStky7pttZamI3tK30q/C6vDKYuaGKCLq4a0hLHdC97Fu0BB8iRNMEKWV8DJXTHnhM6k8w2bbs25zv9Jthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHcEL9FAExU/6yuRYsG+FsS2p0pbRi6Ph0vnHhf1Ffc=;
 b=3u0RnCcNBItjfNLSBR0e2qzPFCwJxnIHc5EfcRCMJC8JEjCIi9nVHuPId/ir7ZZQP/N9iECcj8diQYp/rQZoSmD6q4nYqkBmLwL3sTmmtqJaOH4Zqas+9vxqV17gOj2Y4Wrypoe3Maemo6gDL0vUPUkjsbc815St2hD9Q/QSGrs=
Received: from SA1P222CA0116.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::20)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 19:05:44 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::7f) by SA1P222CA0116.outlook.office365.com
 (2603:10b6:806:3c5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.44 via Frontend
 Transport; Mon, 19 Jun 2023 19:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Mon, 19 Jun 2023 19:05:44 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 14:05:40 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v3 1/5] cpupower: Recognise amd-pstate active mode driver
Date:   Mon, 19 Jun 2023 19:04:59 +0000
Message-ID: <20230619190503.4061-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619190503.4061-1-wyes.karny@amd.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0fdbca-030d-4b65-9fbb-08db70f82ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/bsir/Trezz490mtsIW+fMN1RdRsCs6A1KY/pgP++Z2rxHRtTncX/zTnAWJc8VLcvN6so4Fod1deS5vF5Dt1G67cV+8e/gMV+i6Zlo4ju/oFJ2Vxdosy3xc328utzxKVTcG410O6+T+88DxbhK11iR/bg9L91r0M0UVcDPrjaXN6gvzgy0DpFm/JIfS4UXrvlqSJJyiPCIuPDRoUDLoaVeN5quT1l0EYc0vMfTIzsBUn/EsSBRBDimCfyc0ieo2nrqzFFBrXQM9t5FX/Ww/U7Sx0hx9GxByFy2cS+GU7N8pvn7bi9yOaRCDbdEyMbxjcvvnoskwXm9ygUV9uUkq+dS5/q4DdBoiXU7WmUIk/45Ns7TkNq2uahqI/+YaUicWMT73jzW5N0oCsVMCea/aOgO4YfiEB3Cr0Ruyszpon0xBwA7UGAXKeCNMA5crTrELFYwTYooRoKA+1iDR1I6GorYhw7U3G9fJrZmZP1HCaxWmlQaSIUCHc8aPIWddiuvNJ0sc2kDKbTOhwgIxn6L0bFt4K+9KfcQ+NV77q1slolInwHdAmcXgbcIae00c8dJZqKx9vb4TzF41Sf14iYu6C0VlUQxtStMtve8ZmilQenxZ2EDodwFcDpBQTcVZlh7R/Tf/pe11M+Iwkvr3qbl5SGWsCi9tigJ74gqvj7whz2dvUfLel+63yHXvkwvMnkb5r5pL5QnT75B0wG1Nc74oKWt7IBx+r1aQOnHOPdjySdtrGMLCDJPmSSiaP3haclYCJTCQ/Ex/wmRJv1Hf4IensQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(4326008)(54906003)(478600001)(110136005)(7696005)(40460700003)(1076003)(26005)(16526019)(186003)(40480700001)(6666004)(4744005)(36756003)(2906002)(8676002)(41300700001)(8936002)(70206006)(70586007)(316002)(5660300002)(44832011)(82310400005)(83380400001)(47076005)(86362001)(426003)(336012)(81166007)(356005)(36860700001)(2616005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 19:05:44.3564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0fdbca-030d-4b65-9fbb-08db70f82ee7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd-pstate active mode driver name is "amd-pstate-epp". Use common
prefix for string matching condition to recognise amd-pstate active mode
driver.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 tools/power/cpupower/utils/helpers/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 9547b29254a7..0c56fc77f93b 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -95,7 +95,7 @@ bool cpupower_amd_pstate_enabled(void)
 	if (!driver)
 		return ret;
 
-	if (!strcmp(driver, "amd-pstate"))
+	if (!strncmp(driver, "amd", 3))
 		ret = true;
 
 	cpufreq_put_driver(driver);
-- 
2.34.1

