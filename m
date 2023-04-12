Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806F46DFF20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjDLTuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjDLTts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:49:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6D47DB4;
        Wed, 12 Apr 2023 12:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxWzJviypQ7Y48r+W+VsSFtcyfM7j/v6+zktV8MXxyLLeV27IvdZbMDqvZPvsXiojME2USxyRnCuiMXSRlnpPcVsjtgNA2zJ6CPtNHvtTWQv4w/U7OX1KZnJ7oJxiCZ+JYLEIBPYS34mcChI5mtjqSdGygwniscD3ihpsNM1/PHWT9DdHtIgWGzhBuuAIXQPWcaSblgMvG3VpfXuBR88DXw2CUwK1vpXUc55VEVa41dOdPVNnNGJ1fPtEnpcOyLw0mdSWnCHmthDeWPjDnVtHdmiWiNeaAyRRI/6qMiQsxFuQkgqhVqAFiJm4ckAyjlrZlhtAo80V59xbq+N28sKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uyuYrzpFUD9AAiawcudYbjDPhPlJBKpXwXniY+Li4s=;
 b=oK3l62FR9GboylsE7YWSIfKl1IUTSk5EOKxQxhQrcpV6n1hf7DG/vmQ8Le//47Wwu+v05SUUnQ0wPhW62ukRPzRk4zMkxT6XRedIECi7T4fnTJuBCM0wp+OMYFRQjWsEGa+i/O+n/yhUTBpn2Vc3qvlAfRdYvQxkPR7Pqz2KVpEAlcsuFsXYRVDJy6FByUoAwpMTJ82R5O/2GzyCelqGKiHx9WttKa9DlqRfcjdzEcLKS7jZJUxtj4IA3VJloiuSYbjjtZWP5TH336Aij495nSJ0QPYOVxYlH57TcUoHRxj8RIiwITLEiakGScyEBq/gmQIVczRkXCfwPdfPhaoeMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uyuYrzpFUD9AAiawcudYbjDPhPlJBKpXwXniY+Li4s=;
 b=ONJMgcKwsMeg9OjMDEA1S/ikMVnZJumz7bQY9I+NihINTwLe/jnoqjSUOIP1CoTQXyzQXHlIYQE7iZCv3dPHXWGIL0kM2wZ7nTPMhUW0Dw4NxTL3tGhogB+ZSODuGCstcPBjTh6wO7EXrw6EGWWNWTvHxDblvdQyGm/tosxvHhE=
Received: from DM6PR06CA0064.namprd06.prod.outlook.com (2603:10b6:5:54::41) by
 PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 19:49:38 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::fe) by DM6PR06CA0064.outlook.office365.com
 (2603:10b6:5:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 19:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Wed, 12 Apr 2023 19:49:38 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 14:49:36 -0500
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
Subject: [PATCH v8 3/4] platform/x86/intel/pmc: core: Always capture counters on suspend
Date:   Wed, 12 Apr 2023 14:49:15 -0500
Message-ID: <20230412194917.7164-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412194917.7164-1-mario.limonciello@amd.com>
References: <20230412194917.7164-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 96436eb1-9ae9-41ff-da91-08db3b8f0ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1j8+D8a39sAenBe3VSIQdV96MyQxwm29BxkE85OESQb10JN9c/WZIjr/dhaed+EavCAKpiffFITHnOrKWo4PTH9aEnHXuDbRUYTEey9+WDtT0NyJmWPr9dW2mUux2KZKDv9mD+R8E8Ou10gNqZ/KCN3/RfXzUSlyCV5zcdWL3aQRcl9e8J4Y+al5vW0qmowgZLD0YLrLDhvs+Zby4zVUgzszpCacFro9AfrfyoSeaybtqLmlVuTPBx4fB+qcLpC7RcsQA9ObrEyyevmtwT3aqFjgeiwV84uSaj/4FymBXm5W0njZUlpv+xaWu+W1kyGCGEdKklO06G82Tun0x51dyKlv5Fwa6kHk9kqEVjgKCCecXuJxpRP55HknF3W2qw03AOSd6qEHiJOxioGooIBOc6dFtI/rOoL2IfPLjXZozMPcZDGEg30vY2ho1Wx0r+3yVtXypb+Rt4AKxx88loL/dxiJWu8DJAlNNDi/lyF1q8x8IOsVDNK6L+P2oKYRjC2uA9T30p2awX+Qj7AEb8Y9pPM6KAr8+lRUAyhC+jvXIo18eb/3+3NvYHTlWqQLUD9IRX4nc8IX/SvPBS1rNb5wLu9vvPPr5EYF8j5mIq1qwg1mzeGADle6YaDn9USgrvB9KqmYyAkoDHGSxYyZlpG3AlrVSZz4wUdq5YqtmKreL0Yv1d0ot6So34hU4r3CL9z++SNaN87QgTEVCF6mmbqg7ynoFbYm2XWzOSWr4h4PDU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(44832011)(40460700003)(7416002)(82310400005)(15650500001)(36756003)(2906002)(5660300002)(8936002)(8676002)(40480700001)(86362001)(110136005)(6666004)(7696005)(26005)(1076003)(83380400001)(36860700001)(54906003)(478600001)(47076005)(2616005)(426003)(336012)(16526019)(82740400003)(186003)(70206006)(70586007)(81166007)(41300700001)(356005)(4326008)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 19:49:38.4831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96436eb1-9ae9-41ff-da91-08db3b8f0ce2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

