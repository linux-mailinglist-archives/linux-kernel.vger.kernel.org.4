Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A9A6DE659
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDKVSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjDKVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:18:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B1C55BA;
        Tue, 11 Apr 2023 14:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwjQDx/YlocGg5nC7vv12V5iASGA21WOAt9jAUIBNSn+7yXhooQiZb8csgM7kWOudWOWRFVcZQ3FfrfI51bddJUotslBFXKmQ/p4xVA/LSYdaNjRgHWx6btxUkY2co07rHjBLy6O2a6fjZTRXSlAPEVrSIxy0TFs65a2XyTkyfD3p82KizLahEDxNi4yEEyScJnlcscElrRkr59XmKP2CMOP9Yyvq0X4DgZnWBtBpGm3mmiAT06Pa2kiqGbr9Dp7BC6snEcA9heb/yLjwc82Go6epperR3C0idC3UMRiAx9bUAeu3BdwCXHKtw39JayMus7xmbFi09csv6tLYESk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uyuYrzpFUD9AAiawcudYbjDPhPlJBKpXwXniY+Li4s=;
 b=ElqDPSpJE/cFDtm7BfF6C6C3NRoMwzlBVKGy8XJfrjmgyV2VawRep7Ve9ynrj0L/3UL9JKnoMB8sxPUTEkdE0ZMtT4KSvpSMiZPhN+8ZQEUSjACCU957DgXx50FXW4YCaxX74cyhpYCy8yUgyuuQOQmrHBYYEfCtOaa7xiIx0wi//RjPZa+bu9iPo56Wv7/iO3/1TYmHStcR1lTINy7IYn6PPs9PqIyZ1H0nYLT1ZQnwbvmG5m7JYTcqIFhX5zJpafFn83GvbrTu6GLpP76DxDZE4AMDXGfxlSem/YS6T1iit/eBumd9BbaSPq1Fq7NT6RcEEOzSrD81CHejBJqYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uyuYrzpFUD9AAiawcudYbjDPhPlJBKpXwXniY+Li4s=;
 b=wFOxXo44AKYcyCa/Drs2u1FJIKWXDnJYH34ZLLGUpV79uZZT/KE1g2NGRb774AGPaUrSqTTCvS/CXP4NigiHYfouKLJabHXagHCog1gEXRNv2omfsWVWWdwO/FepbF72g2CsgR3tevKCJSLKTtg3FfxQd9NK5Z8Gx7h7jkSg8ew=
Received: from BN9PR03CA0544.namprd03.prod.outlook.com (2603:10b6:408:138::9)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 21:17:52 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::93) by BN9PR03CA0544.outlook.office365.com
 (2603:10b6:408:138::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 21:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.29 via Frontend Transport; Tue, 11 Apr 2023 21:17:52 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 16:17:51 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
CC:     <Shyam-sundar.S-k@amd.com>, <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 3/4] platform/x86/intel/pmc: core: Always capture counters on suspend
Date:   Tue, 11 Apr 2023 16:17:17 -0500
Message-ID: <20230411211719.4549-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411211719.4549-1-mario.limonciello@amd.com>
References: <20230411211719.4549-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df8c4c1-fb28-452c-da15-08db3ad235ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tdibms7sgHEWEsYCMinsMOi4U6m2/dNP7KXXpXY+wnhS8LG6Mpk0L8ZTAQwj6muhjDq4YN1yqJJxNbvFDqmHO4w8EYVxHaWjiKoz876uwIt36xylU5PC2SNFkII5jxHV8ftU6ZxuZM8IWFJd0hyL/tM6Lu6KX6CUfVTa00WEnUTfM1G8vHxsX2Xq56cmWBBF+SplwqI0uYBywuimuysxnxz8XY7tBio1u5sXQ3MbZBCZJ3SvoKibAyL1S1eocRrjsYFZAp9wauUSH1pVVq9pfUK168NqbGug64qfbDXxGM0VdNWQLu/Cg0jsWtu+G42yPgqlKy4//w9wmY3yWNkbVpnMVKngQdcP8RLku8AhUCwQyTzRH5fshZLRaYTeYLpYPYQb1Ov5oNFGviL3ArMIE5eZx+X1PZEejsoyvRi+KjgBsir08GpN+wqmxd7QrhwybMMPCr7gY/g0HdhYmKmPQ+WL1Bu7B6askVFFwRT/QXQWESK6fsKDa/q6nsHcUETJDnKU0qdtkTZs8iIOvm6CfWRY/EjpGsE/ms12M0xtFonv6TL2emJ/vU+w1UXJp0+gLSI4Y6UiixBC8tL0ZR2Lh0lmtf3JGVVOKYJoBojSNeGd3f90Gl38dZEwYu9TEQU6g4zCUtelzbmwVLYjcGlIwl93YGAPvD67u8FdSvUs7t8K6hsFlS4O8QoKbTzJvsd6eUmoJoDX64u5xfbXaMKPey8dfr/TNLQMWgZFbpCKJ80=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(7696005)(478600001)(40480700001)(47076005)(36756003)(83380400001)(86362001)(40460700003)(81166007)(356005)(82740400003)(426003)(2616005)(2906002)(316002)(110136005)(16526019)(1076003)(336012)(36860700001)(54906003)(7416002)(44832011)(26005)(186003)(15650500001)(8676002)(8936002)(6666004)(82310400005)(41300700001)(5660300002)(70586007)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 21:17:52.4871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df8c4c1-fb28-452c-da15-08db3ad235ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently counters are only captured during suspend when the
warn_on_s0ix_failures module parameter is set.

In order to relay this counter information to the kernel reporting
infrastructure adjust it so that the counters are always captured.

warn_on_s0ix_failures will be utilized solely for messaging by
the driver instead.

Reviewed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Pick up tag
v4->v5:
 * Squash patches together
 * Add extra pm_suspend_via_firmware() check for resume routine too
---
 drivers/platform/x86/intel/pmc/core.c | 13 +++++--------
 drivers/platform/x86/intel/pmc/core.h |  2 --
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index b9591969e0fa..925c5d676a43 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1179,12 +1179,6 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 
-	pmcdev->check_counters = false;
-
-	/* No warnings on S0ix failures */
-	if (!warn_on_s0ix_failures)
-		return 0;
-
 	/* Check if the syspend will actually use S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
@@ -1197,7 +1191,6 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	if (pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
 		return -EIO;
 
-	pmcdev->check_counters = true;
 	return 0;
 }
 
@@ -1233,12 +1226,16 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
 	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
 	int offset = pmcdev->map->lpm_status_offset;
 
-	if (!pmcdev->check_counters)
+	/* Check if the syspend used S0ix */
+	if (pm_suspend_via_firmware())
 		return 0;
 
 	if (!pmc_core_is_s0ix_failed(pmcdev))
 		return 0;
 
+	if (!warn_on_s0ix_failures)
+		return 0;
+
 	if (pmc_core_is_pc10_failed(pmcdev)) {
 		/* S0ix failed because of PC10 entry failure */
 		dev_info(dev, "CPU did not enter PC10!!! (PC10 cnt=0x%llx)\n",
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 810204d758ab..51d73efceaf3 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -319,7 +319,6 @@ struct pmc_reg_map {
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
  *			used to read MPHY PG and PLL status are available
  * @mutex_lock:		mutex to complete one transcation
- * @check_counters:	On resume, check if counters are getting incremented
  * @pc10_counter:	PC10 residency counter
  * @s0ix_counter:	S0ix residency (step adjusted)
  * @num_lpm_modes:	Count of enabled modes
@@ -338,7 +337,6 @@ struct pmc_dev {
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
 
-	bool check_counters; /* Check for counter increments on resume */
 	u64 pc10_counter;
 	u64 s0ix_counter;
 	int num_lpm_modes;
-- 
2.34.1

