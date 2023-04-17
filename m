Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DE16E4D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjDQP22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjDQP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:28:20 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2DF7683;
        Mon, 17 Apr 2023 08:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMjHnbGpYUCdG+xR6r3efWKrcJozlUiwVriRx63dTYygz3DN3hYLp0KaOhfYzMMBP+L+iYjmig9sjp+bzmj5ApE1MzfxXHZRb/SgjexTOTcXgEZ8vJ0yNqoVKCcPQ8Y3y4qt2r++0SbJwnYtyKkhaWqudUX+OG/btomLcek18/iYj6fkt1T+da5KmVNu0iB+aGQL/OCfJ9iSuEXnGhNqEZs1D67fZpBjONlz76SQbXA5fYhc7p0Tr7qCWMwEQ2vcXA2aHdYRFopTkEtFmapY1ZDWKhz20/poysHXa7qUBTSUwnTcJzyBvLo8FnFocTOTpBGtsgxxeyQEXckSGWMDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLqQQatTCDsDQf68uUAaQQVpsjvmPexAs/ETpYIVPFI=;
 b=CSWPxCtHm9dZ/uY8YAm4p5rb6QQn1QUXKnW4y4HLDgbXB14KYB0JdPukwhGF8hZUvl309r+Cq7LpIQqQiFQ/uyQc4m/+vQMYRVeblqJ6xQowBB59sIBba1/B2q0CA5SulrsdE6/gzkKWzG/9vk5oTzxcMMZ26aqBdJUyP/yYHKeVLXO6WV4sFymrgmJ+5eiK50sy+uDfpw3RE9JVY6RtaKnb1EPWjwwTFYqo+WSDlFtg+4lQutrcL03lExlCNPzdx4d7esddpp5uh7pQhYCmnYt4LTx7c1x8Q12NYfrX8tANHZl/H5xmni11m8ri4cjbH+59GsuJnuCfSSrXrWxEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLqQQatTCDsDQf68uUAaQQVpsjvmPexAs/ETpYIVPFI=;
 b=MtnkApYJ8pnESswIMl338kcW4SqxPuHcsCnb3tQsrHBzuTx6N7JTWOhxpPGh0Iz8K/6dAVD4ewg/Pl5Gfy/VP6dOZt1DzkIORSv4sUkKmEGkGlTOdXnChLKlRphdnIONvLIVPb+EqU/UaSTShsS/B7SehvITaw/deeCE4vWQDhY=
Received: from SJ0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:a03:333::22)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 15:27:33 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::6d) by SJ0PR03CA0107.outlook.office365.com
 (2603:10b6:a03:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 15:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.14 via Frontend Transport; Mon, 17 Apr 2023 15:27:32 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 10:27:25 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <rrangel@chromium.org>, Jain Rajat <rajatja@google.com>,
        <hdegoede@redhat.com>, <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH v10 3/4] platform/x86/intel/pmc: core: Always capture counters on suspend
Date:   Mon, 17 Apr 2023 10:27:07 -0500
Message-ID: <20230417152708.3599-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417152708.3599-1-mario.limonciello@amd.com>
References: <20230417152708.3599-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: ae23293f-fe06-46ee-ebf2-08db3f58436c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b//nMak9QZVGXeHyWCjoW+Js63DyU86Hs0A9dQTkp8xEV1SSFLIL+ab/xtsBCghyLZMM5aUNuz8mRin8x+UPmO/dAp9WvVelaJNYE3OZUr8uDLbHl84O9FaOvaIeDUCvVmaNhnnb91DsKw/hCMvPy9PB8ruoRsHRxfBa/oNWfgFtMpQQKbNnhgwPhx+bbLH8svmQ1CCR7BO+NCH4KWo9cLnTXhxLvwRn92Gzq6EYw+L1XZiIse0OgAVtbhTEorlExN+lB+w9g0s3cxONXZpc8DZT1vg5Wgn+7rBa0EhWmEJMXD0NqqPN049yPNAhAla14MvCmd1lq0gEV66x2lnLLrJHXs1xmrXdQMlh1/hAWVjJ/KyniJ8NJmLt6i3FJuCZnbaGj8noiCuOdA7wfig2tiuCzcE+DO4KpaQm69Y0kZgRQXcMKsMQ62YfLsIlw+JPC/iA4IXIxFRgkIwnBYGpVFSL2cpqCi8/qcsTh1sR498i45tJMWVaKmED1pxrwLyoF3nL/mVXjlvgBKwnF2yxnl4FGH5v80BnOQFNh9BcKb14S5dkNVF99Fd/RMayfYW7oBcQZ+zaDBPGJjTrJb6YD4wZE0LqP2YhE2zGtt2tSfhw6PIhaZHASK632KpNAuZ8oP4Xue+vb6IcG8dR1leW9xAB5h2DbUlh5tly8EIQQq7j/FXuUURo6XidCDQiBhKmTI0cohRljjZ2i8sqi16KKjOxZy1as1wBbbOuWySuQmk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(7416002)(54906003)(44832011)(15650500001)(40460700003)(478600001)(316002)(356005)(81166007)(41300700001)(8676002)(8936002)(5660300002)(70206006)(70586007)(40480700001)(36756003)(426003)(336012)(26005)(1076003)(16526019)(186003)(36860700001)(6916009)(4326008)(82740400003)(6666004)(83380400001)(2906002)(7696005)(2616005)(82310400005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 15:27:32.2378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae23293f-fe06-46ee-ebf2-08db3f58436c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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

