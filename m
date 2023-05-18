Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC77086E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjERR3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjERR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:28:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF86E6D;
        Thu, 18 May 2023 10:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxNvhS+BKZteu/P85RAIpfbR0OFYf+eoGkig9Gftvp70qQqPUKrE7VSHxS5sczsupIONBoeeSekyFU1FZxEHyyaVN8PM2zLhkrbXQaG3PjtxD7HYzEkavqreOIIdA8YtnsqzquF1ePpR3Pp5oyXSMx2VYYP0HJDjuhq9yB7CpCedIjiHiH5VBnW9FZH1qukDpILZoLrbdsGjSJSXYQ77f7Qnzn91nzMT9Pr8jqcELjXMHLV/8+PI9+98X8mtSTEEPZ+nHjvv9K/IN4o07FDosBWqVbRk5ZZui3Gn9yKJCvT2LGMHbN4PN/YmX7pNxED32l/KwGdRCieQs+Wnii2h9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrHATCoFhmN6yg/azbKKFkcA0h9V7q/tjG0BF8LbZ5Q=;
 b=OGG9eP1BehymH+IIQFvwrav/gsq+GncABQk65umBqbYNLKaco0IEk+0Z8bnIsMthusUfe+YGcAHh4i52KsRQuH25HxDQOOhDzkagbY0JKUaXXJ1y991ndmHzvsFTCWp/SsVFT9qbJawz3iKmbFVAx+NbFcC3BpFwKxUNpF86/wmGrBXr3d6CzH51kET1WyJBqeb8F3DhVWtXM7bWNS+WAl8bsp2fYIccxKZV2yaOR8me1+mWnDF5TGO8yFpt9SEHjMxXRC0F40oU2H3o8oVBFzjkQN+k1hiF0RxnqGnWF8qT2k7VVDEXswpksPFB0whQQS7f0bTpTltCdYstAfqcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrHATCoFhmN6yg/azbKKFkcA0h9V7q/tjG0BF8LbZ5Q=;
 b=UglK3fpkgNpHwVHB+kOzMK8+aHM7UpryOXMpmKdFJ8vNNpGDh4jf03NUiHXNRXiXBGmGanb29OrBeW+Qfiuu+6S6Swz/xkoQBeJoMXVIOD2tPiDytZRCFgWPj3AwPUZgrYE5p3sscjGGggAK/iHaWCi8vaR0ZNIlmNcD8/2dUc4=
Received: from MW4PR03CA0030.namprd03.prod.outlook.com (2603:10b6:303:8f::35)
 by DM6PR12MB4928.namprd12.prod.outlook.com (2603:10b6:5:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 17:28:41 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::3f) by MW4PR03CA0030.outlook.office365.com
 (2603:10b6:303:8f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20 via Frontend
 Transport; Thu, 18 May 2023 17:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Thu, 18 May 2023 17:28:41 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 12:28:39 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for suspend related messages
Date:   Thu, 18 May 2023 12:27:52 -0500
Message-ID: <20230518172752.93322-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518172752.93322-1-mario.limonciello@amd.com>
References: <20230518172752.93322-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|DM6PR12MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d6dcdc-8e5d-4332-23cd-08db57c552c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SupjCA7Bo1HCJv4g6tiPt2QW5q5Px4zIovLcBKEYKG2k6EHr9pRzmqqgjWzk7VPMFYyaD4DMmzuoqiAwnUlp6+jI0RzwV6mb/PeOQUzy8rdz8zm6XyQmNenwOtDzrB8NAPMD/fW+SGUJ8CgHiutYO/Wy2hYjZb513ECinkRNBkzCPzjGnAIQAmWCzp6hWQZHMpytMVPhB21epuG6ae9GfPuUdpS7EevYDHj7wFcTsMTtXjVoBKzXe3McPuFWPQ8TUfPfE3neczvCP/43Mng7wx9TA0K6Z8tBTF2B1kYchis6Uw0JZs+yeff9k4XhWvtfO01DEuHpmgzHvKp8VotdDrg4k8ubiuGmZB5v2Lwe9FpmzIWEl1BzFAZkZtk2QIcu1oYhB+kDFfbHleWFX2UlsuZcL8wi1M1YPOg6g1l/ns5QNVpTezyk7WvIrP4NN2teSQOD0pewMyP8IruTwLf22y16yNXNr0JZjbxgqrrVcSxyt/KwyJn2WqXx7QTZtufFjoV3JL+lFc77LRS33ymHcVkw8qBVs673bF6MXmkj4qBat3j5kSXEf3hI712NC2y1Mc+Rj9nxhZx5uXimWUI5QMmTUDPRnbXn5uuEeY6z+5RpOxOXuSf9HAfA+A0BKQeCRuf998e7xTy08/yWWaTvZ7m7lVcEcR9Lfa6SD8jgLa0La4t5DBpuLxLPt4/u0hYH+Iasw0LC9w1XwCmXDDJ9gtSBeUppKbNvm1JbnoiN892t9L5v7r/g+xaTZgWOaGqbaJ2rz7pzygF/XH+AcoLQ7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(1076003)(26005)(40460700003)(7696005)(36860700001)(36756003)(40480700001)(47076005)(83380400001)(426003)(336012)(86362001)(82310400005)(2616005)(82740400003)(356005)(16526019)(186003)(81166007)(110136005)(54906003)(44832011)(478600001)(15650500001)(2906002)(4326008)(8936002)(8676002)(41300700001)(316002)(5660300002)(70586007)(70206006)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 17:28:41.0607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d6dcdc-8e5d-4332-23cd-08db57c552c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4928
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

