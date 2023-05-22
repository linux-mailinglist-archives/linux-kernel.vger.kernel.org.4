Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DB470CA44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjEVUBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjEVUBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:01:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185DFA9;
        Mon, 22 May 2023 13:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmFa2cMKYcoiv6s7Lds6ROZwMYyLYHlRGHJEN1i5ERiPvHSv1Wq6GNsJIVcmKy26UDvtem9ZBTKCKKmBCekK/ugeljKDa+V9amnKH0VIIdBKZOfy8izWfW37Ct4G83fQ+h0kaS6hA8mHfASu3y/c12xyQbvVhTdXvL/wz82oAhWjDemxVQ4C7hH7rQGrLDws6yzjRlAEyFPm4myQC6gkyS0ijazn2H1zL/mzcFcTJs5Fuuz3KYqdUTs0vHPaVjwnWj0q15DQsvSoALAt/jbzsn0id+DA/yvTHMAxC5S5qv1kV95MKtL03C8z41JM09wbn0QbowopOvMLpZ/mvJq3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrHATCoFhmN6yg/azbKKFkcA0h9V7q/tjG0BF8LbZ5Q=;
 b=lfMoniGPnsV3su/XFF0tFiejbQBBh9HLkO8bs3yy/5Zhm41vOyHsOLlmmQImQwOAaC+WOxyZtzvkITo8ygjHcRPvruONLy7FgJMINOo2q042J7lbzIeAhlWp17yaVltnpe/mfIvgydKoO7pVRA70TK9b4L4UmaWFAI6Hn1TCSdkDgSRofE1r7eFownJ/5tSPbKmheQxydN/Bxeci6Q3r+UnQTTb60IP6xgFgskxQBihUV8IqkPs2YYdAWXGNT6CQvj2RmRZ1Uj3nXHBgvC/QITbLLgSdSxEJUPPBFJrEMWY0VijMx47TCHrM1DdFJOT58lDBULZHtQwUraiFIB4Wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrHATCoFhmN6yg/azbKKFkcA0h9V7q/tjG0BF8LbZ5Q=;
 b=DsoCIqWe+4b8td+PzIFDOFUHPawlY32G8stxypAUPJUYIHao4LY8AHVBaUQGF5YVspoenABpcbyb2doEg7EEPW1KHLfqEFOdbVay0AzeQoEKI32BNHcoalXu2Tw7ooZjzpAWz4bZtov6YvPKwmEVjH9qufCJe4mrQqhowCW6FyM=
Received: from MW4PR03CA0167.namprd03.prod.outlook.com (2603:10b6:303:8d::22)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 20:01:11 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d::4) by MW4PR03CA0167.outlook.office365.com
 (2603:10b6:303:8d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 20:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 20:01:10 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 15:01:08 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for suspend related messages
Date:   Mon, 22 May 2023 15:00:33 -0500
Message-ID: <20230522200033.2605-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522200033.2605-1-mario.limonciello@amd.com>
References: <20230522200033.2605-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: c07bf1c8-8200-40dd-c244-08db5aff4a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cy1k35ph/Zwscf+cqriUXNrF+kJ2BIDnlsXNOymzGlkNKHn/WtT95ltNI7HHHPKLevEfU8G2/eQc0a+SmSsG9dlao4L4mZW0ChCFEwsRh0zEPYqc5v7il5hFC0Dd6v7oCJr/FlQyHLpU12k0aDpBDZVmvc2oTixE04xmjAYx7tPnvkufo0loXuUM+5hyyxZbU12NH0U2HJpKYV6smMEX9OZVVaUMS40Aq+foYPIEZTGC45flQQl5RqGPcGRlgpgjqg8kXdJF04NCDRtfZ2g4vbxQ8QBZE0+QmZlAmJUDHkqQbYIP8sKfAsSWsBmgRcTrNkmitLKmz8Ok2Vc2fX16pTrgDUFe95ah5tAC85g0ixffThDxkGT/JsUsOwVh13l2BjbJkAKFdpHh/BMLM3d/5KXYGtDx0BExiyWLqtFIA38TSSJBt1F6gHXMkKTy0IM/F/jjA+/NvS9wklXS1tptGCWvILyDlF+c+fcckUvKnMIkx0YDLbtVae309RVs6o/7hxjwIdXRLxBhScDUrubjMSF4S39L/fdMnWNM8FS2IFA2rYujwCw/ApwE3Fi45hxKWXHelkpYnMxu5wqwyUrgyd9UL2sua1hNuwYkHNvbqaV11jQMwjBEIJE5tt2ackbOC5pn2yvDu3KLIWvdYZvKzKuoWg/a7x5L20nJdKkzuDHgQy6TDENkjsvPjY28vswj4hF6TlL9rKmWL74v/0rJHs52PFncp+GIyrgMYPEJdD2BwAJtkj/5gFjNNUErJU3K15OCsmLOxTF3FkIYB4f0SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(8936002)(8676002)(47076005)(5660300002)(44832011)(36860700001)(82310400005)(83380400001)(186003)(16526019)(1076003)(86362001)(2616005)(26005)(81166007)(356005)(82740400003)(426003)(336012)(40460700003)(41300700001)(6666004)(7696005)(40480700001)(70206006)(70586007)(316002)(4326008)(36756003)(478600001)(110136005)(54906003)(2906002)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 20:01:10.9102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c07bf1c8-8200-40dd-c244-08db5aff4a2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using pm_pr_dbg() allows users to toggle `/sys/power/pm_debug_messages`
as a single knob to turn on messages that amd-pmc can emit to aid in
any s2idle debugging.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 427905714f79..1304cd6f13f6 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -543,7 +543,7 @@ static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
 	}
 
 	if (dev)
-		dev_dbg(pdev->dev, "SMU idlemask s0i3: 0x%x\n", val);
+		pm_pr_dbg("SMU idlemask s0i3: 0x%x\n", val);
 
 	if (s)
 		seq_printf(s, "SMU idlemask : 0x%x\n", val);
@@ -769,7 +769,7 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 
 	*arg |= (duration << 16);
 	rc = rtc_alarm_irq_enable(rtc_device, 0);
-	dev_dbg(pdev->dev, "wakeup timer programmed for %lld seconds\n", duration);
+	pm_pr_dbg("wakeup timer programmed for %lld seconds\n", duration);
 
 	return rc;
 }
-- 
2.34.1

