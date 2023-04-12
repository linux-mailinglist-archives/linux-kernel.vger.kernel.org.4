Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCAB6DFF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjDLTuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjDLTtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:49:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079F17A80;
        Wed, 12 Apr 2023 12:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4oLoyt2UJuFINE6kDcpyJTpWDJy0rwhIx1JRZunDerfSoYKk/l80JVMMj6aVW/bx+i9goX2BjpnjN15Ya1DdwuGWfuRG/pVEfGI5HqXAbHkdObeIvYXJb/Ez/qnXpKcZpLeepeW30fpNeoqRbh7AMCMWs/QXgZorLVEfTg61+KvQO+A3hq5KqrKR204N7752LICrAAUS1LZK1LmaNfjdRDpEQmtSip33QBTjAdFxKy89Sv/diJYPDS8pI4MkiFqJODcw6NKsqk/9R/ZjBTp8F50re6OelD2HzYKW0smxA7Hx6iXdqQri6e/3O+2SXd+7SOe4bqTjBi42UIsI0Snlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCQus717f+zD9JKyXeRkEq1zVYd+Ada2Q2y6ruMT/bM=;
 b=PL6lgA/epwI+F+Bpr/JRRsgeaOoBAu6YeVuFfVK5d3QQjr0Dt2BKhExOCuSOVab2PSqDRWQ9O2FfRutda3pIc8Tj/6xY92GXfe0g9BAmeS2aOkbQw2D/I+9GGIO+2q2Ye2zIU1pRdoSXBjFemqYM9dfBczwxYNY6/CZ72H2jLS9Z5yn+3seu2VOlmOo7Ri/BX5i9I59NHJiuL1e6D3pVMpuJRjAxy+hzRtLCCsGH9VZMWHBsAi/zt5yHRd2ZA6YZWPpDmysAVPXQ6U10+dOpxmSYzmwv6zRwzLyjWHsN6LfvsaMbpzdiAlDwAKEiigRyGlLfGnkFuulJavJek4RbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCQus717f+zD9JKyXeRkEq1zVYd+Ada2Q2y6ruMT/bM=;
 b=frrmy33/ySyssOSk7hUZkk7Ge3eHXY6Bg1VuGVBIu9coc1nx7A0viGl368CBvsI5HP27i3UeZcJuS705Hh/a+2CgwUTrqXmLvOolUqBSav2yiYY2EBv7vJsF6Ga6BUrjdxdEKM4HxFwZW451c1wSlE1pTw1pOYIcgt9TR9Y5zoQ=
Received: from DM6PR06CA0064.namprd06.prod.outlook.com (2603:10b6:5:54::41) by
 SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37; Wed, 12 Apr
 2023 19:49:39 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::fe) by DM6PR06CA0064.outlook.office365.com
 (2603:10b6:5:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 19:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Wed, 12 Apr 2023 19:49:39 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 14:49:37 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
CC:     <Shyam-sundar.S-k@amd.com>, <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 4/4] platform/x86/intel/pmc: core: Report duration of time in HW sleep state
Date:   Wed, 12 Apr 2023 14:49:16 -0500
Message-ID: <20230412194917.7164-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: fdaa4028-c203-4f7f-3513-08db3b8f0d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6e6vmHmhVjIOtQWlj2HwOOzIe+7faWuATD+cK30c2digTrLKROlstuX3SNxX/2CY+6iR7IhMSzF7VZSBqgzW00Pac6ckzBayGy8WSytFyAg1fU0kb6ck1XwSUKH4j2Im6BU+Lx79SLsFn/fhPHx+JrXZV09cTHpoiEXcHqepXHwKTLbdIWNwXlzHgSdbL3Buhq2imHzfObFBoGZPZxuZclgU5rI4vR2XJD1+3K7Jq6VoLBgJ/oN09aKLTvaJDDiFIMCwogUg+DZ9idlByTrq4tuE2P79EF7rTvXytenrXY+IA6ohAWds4DS6jtirpqe87D+e0tqGgx8gxudNeBXUxi4Fh7xbgiDNwEauYSB9YPenJV+NRhQ/BYA7li49Aei+zdZjIFlbGFYNX4Auo8gsJORBJe/0c5PVNJFF97Y+hkYjMaTmiOD3UnQhwhK2F9jEOB56qEZhtnyWqtpH2nNmX+qy0SjayA6j4UMKBhd8qXswK1ziqZ+YH4t+OTzz4AdPnUOVABEyGW9cprM4NWYFNhIlaLfYLpLwIl0XKITr1U8WX/D5LXQZBTQEUtjIXLRufr7AzzHFpFLfpS8DnEphCB8F+kYzL1XSeZ5BEeyoqTKooOPoKE8r+mdUWcGycsSR5j9rzS37eYZT517kpjdksnxjJRUZDUhIc/gEi7s9zrSZYIXiiVJVuACkwWi5tazKWR2rFbMmPM95Gm5jiqYJWYWMZElEeUonPSM90gVpS0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(8676002)(70206006)(41300700001)(54906003)(70586007)(7696005)(478600001)(4326008)(110136005)(316002)(36756003)(86362001)(83380400001)(426003)(47076005)(336012)(1076003)(26005)(6666004)(2616005)(5660300002)(2906002)(8936002)(44832011)(7416002)(82310400005)(40480700001)(356005)(82740400003)(81166007)(16526019)(186003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 19:49:39.3112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdaa4028-c203-4f7f-3513-08db3b8f0d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_pmc_core displays a warning when the module parameter
`warn_on_s0ix_failures` is set and a suspend didn't get to a HW sleep
state.

Report this to the standard kernel reporting infrastructure so that
userspace software can query after the suspend cycle is done.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7->v8:
 * Report max sleep as well
---
 drivers/platform/x86/intel/pmc/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 925c5d676a43..f9677104353d 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1153,6 +1153,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	pmc_core_do_dmi_quirks(pmcdev);
 
 	pmc_core_dbgfs_register(pmcdev);
+	pm_report_max_hw_sleep(((1UL << 32) - 1) * pmc_core_adjust_slp_s0_step(pmcdev, 1));
 
 	device_initialized = true;
 	dev_info(&pdev->dev, " initialized\n");
@@ -1214,6 +1215,8 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
 	if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
 		return false;
 
+	pm_report_hw_sleep_time((u32)(s0ix_counter - pmcdev->s0ix_counter));
+
 	if (s0ix_counter == pmcdev->s0ix_counter)
 		return true;
 
-- 
2.34.1

