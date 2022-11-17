Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C678A62E8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbiKQW7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbiKQW6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:58:50 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CC1A83F;
        Thu, 17 Nov 2022 14:58:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt3cCPLH9sm35xzoVtftk0WcZtlDVWrNXlSLvp/xVkgDHSU+w18jznWbEZJYjFrquulTMZ1dxpxIfRzRQvXPAiiee9Au0+GxoGX5a++Xm3mrR7oP38ddrbhn863v5fG8NtmrVzssD/ZcCN0m0HzHgtjKwbcbJGIRWVw36bWx4p00gq+KqGM3aqJ/8I1U7LS9oIsvUuXplJCaz85iLAJ+Ma5qUwx7n7qZ1Tc5PHCEHRJah8qUEmJ3opi3O34RZo/8GQwon8nbOnq5cc4E6DPvx/Outl6HN0gYRT0OdNdlXGGyAOwbvaKwYfGtOSmG5nHkeoQx7A3yR9SpMBKOaf35DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFpWtiOZ35dp3m8Jcz7NLsEPoVL9M2+PpIKQgIoVC2s=;
 b=H/EmCoO4NN2RcZAib43TirA5WzDsWaTHnUTBgkyhFwMa6WbjtwEbS8puCsblAeRb+KsCUe/Ffahx5kJO3Gxuv4daD/1PPMZ4a2KSEVWcBYuPutMRp2RM8cfO12A099mhUthcsW+xWXp2kOKWMDOerD70Ijo9KH4BrKbRFYXmlJ8PpKYCPcgq6eUQV6i7DS07a4KyGosnR6kO0sJaB3rvQbEvb3gE8Ujxjbhx6O9i4CDHab4OE0gCkfM9Qj9MgYozA3q+3FykVlMYfdj82AmzIK9TSla52wiRMpKDDGxGKCHRNtkFktxEZab/5GzeTS7CpNo1S5IYMJXXQ9FfPtw6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFpWtiOZ35dp3m8Jcz7NLsEPoVL9M2+PpIKQgIoVC2s=;
 b=Ga+RwUt1G6aCd0im2TEaFS/gvBVs8yYqp5q2B3PseQVwRCtGd0KUN8jJFUz3TNroXnvhH+1eJLYIgwjR5yRuUav+mPT/LPaZTga5I+l0wW40cxNuIb6ONxUUXhGA3mISL9teVcnA5uLAcruERBvuH8LsJNoTtWUaeJTEzLgZ12E=
Received: from MW4PR04CA0197.namprd04.prod.outlook.com (2603:10b6:303:86::22)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 22:58:31 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::de) by MW4PR04CA0197.outlook.office365.com
 (2603:10b6:303:86::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 22:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 22:58:31 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 16:58:29 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
CC:     Sven van Ashbrook <svenva@chromium.org>,
        Raul Rangel <rrangel@chromium.org>, <linux-pm@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Subject: [RFC v4 5/5] platform/x86/intel/pmc: core: Report duration of time in HW sleep state
Date:   Thu, 17 Nov 2022 16:58:21 -0600
Message-ID: <20221117225822.16154-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117225822.16154-1-mario.limonciello@amd.com>
References: <20221117225822.16154-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: af4678a2-97f0-4c9b-e859-08dac8ef3f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBuanw/yfmB6gxkEtMCLBeCmmpEybS8nJZRGgn4QQsWW6+vygolE5q2V315TIvP/+bF6IiiY9kVLiRwR1vfz1b1NF6cyaioop9kSwXnkWwBfG5cpVmJlt4Ootm7I49NdVoXpqTg59OJj6quEYKf4vlmoQ/dcYpxJMYlYM34wWcTLhiT0E7UNGmrkCG5awpz4U9K9K9XsX1Y01xJoSGBU0XdQGQiWRG3k3QTk13MDNyY8AswnqkD1wjkPLEK9+eZqsPiRqtK6CpwFUhPpOGimEog19fkccZzAlj8qqgOJ3r0ZX7aNBxDoJzwtdJvXriO80yDLeiA6JjBzSgFzv0qII/EiouwTau8U90HpHQJOX6T25G2N9H79W8nWWinbQc2dAB3bV1mS6l8bF7/DTZpbdMo4QoVVpg0TVv+skGE45dZOzxEOxHKhrzOEv2TQrEQYTaR4cqp9bu70yApnmTTBBCRmfff2ZvBeGP4hWn27c7NfJREZ9wIzYlkfR1FSZdY0aiG+Ene8bjq+0EAhRULA2nW+MYflQeqs3pPQKY+7G19jBuE97Zqq1yt7ESHytGweBwqWsQQRX5aQKypkBVLASIV2QW2uDVaAPa+MQNM93gOhjqjlz0yADvSAEWOEOlugvX1K7Fy6KZPh7aZF3y4nMY3tCarh+uhxV5zYMnshak1U2samhXog5SgNU/S9E9Q4XM6tmWExAKdbFYHyN1+agb6cGWiJgfLyXifmCQmDeY0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(6666004)(70586007)(41300700001)(5660300002)(316002)(54906003)(44832011)(186003)(110136005)(26005)(1076003)(4744005)(7416002)(8676002)(8936002)(70206006)(2616005)(336012)(7696005)(16526019)(40460700003)(36756003)(40480700001)(86362001)(2906002)(47076005)(83380400001)(426003)(82740400003)(82310400005)(4326008)(36860700001)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 22:58:31.2804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af4678a2-97f0-4c9b-e859-08dac8ef3f7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_pmc_core displays a warning when the module parameter
`warn_on_s0ix_failures` is set and a suspend didn't get to a HW sleep
state.

Report this to the standard kernel reporting infrastructure that will
be used to display a percentage of time spent in a hw sleep state.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v3->v4:
 * New patch
---
 drivers/platform/x86/intel/pmc/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 9baf2bb443c8..0e25348f1c2a 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -2094,6 +2094,8 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
 	if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
 		return false;
 
+	pm_set_hw_sleep_time(s0ix_counter - pmcdev->s0ix_counter);
+
 	if (s0ix_counter == pmcdev->s0ix_counter)
 		return true;
 
-- 
2.34.1

