Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2385C7209E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjFBTdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFBTc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:32:59 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52D1CE;
        Fri,  2 Jun 2023 12:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eE0EzxJu2hlFbKBtenbzr7x5v4Pjesy88Ial9Ij/9fYOZ2EUE789hi+vUKdytoOjmifNyi6P9hDLYiyKNeLw4wpVuKdmBgJrFJRc5aWRN6tNGJvSL1lAld9tkgOjh/pOtoQ90WNNtu4pfKhDiacZCVXeAwo2WWpeEDDaVO3z/+JhrD2OUVi+0kKDnKjRhwIY1GWHJthJwjgXcHgtgU+qFGx+gKli+ivSKu66B+NWvS5JihichiK8LhU6mG53GyeL5EoZlKXHv+ah4OMdfqFaU9YeJ1xPcHd1M+DXwv5Fp4A2jvsTCs5qYnvopiwd3p7aC+3nefpSIXwZNVdT+f3Ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrHATCoFhmN6yg/azbKKFkcA0h9V7q/tjG0BF8LbZ5Q=;
 b=U0zxVCWnj7yzgCtMTysxpHGglwZ88rddDmdrXGEkMiv8HBsd4i69pa/PoogiD2yHm+BEkHce+3KBc1ELMtR9vnWOuUylWkIGw1CLEsJEDlKL6wpP03jNwy0ccNHzjAiMjfNwNEUj2fZ1BkL8z5vWfKeDJF+JOPpt0tDQPEe4BUZO1sv3gVojG34mNeSq4u96Tpvu7NJeVBb0qgRsEtFVrFoFxP77UWjvND+bkdH7aRyLsmIJR7fQ8Bf/BI9RCHEcQ/t87cYkKaH+8mQRf0KvczCT8yfI2H7T6pamGu3gHn7ugT8ctnxJuk+G5abUeyUWc1kKmBZdV4qvqRIGZ6b8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrHATCoFhmN6yg/azbKKFkcA0h9V7q/tjG0BF8LbZ5Q=;
 b=CTbhX+wnnwRat98xzO+JYGe+emPFKmu9L8Cr30mE/LU922cC+sGRxspDYBJ4r0VVotRgF2n6EyU7lJp68voQGuuYJG79cWMqGfMRBC4nz0r/KCy+ZU5+Nkbp9b5GR8+dxw7As8SLxhiLjDmBVx25Jt7+n6WG1FIE/ippwlFGoKE=
Received: from MW4PR02CA0025.namprd02.prod.outlook.com (2603:10b6:303:16d::11)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.24; Fri, 2 Jun 2023 19:32:56 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::e7) by MW4PR02CA0025.outlook.office365.com
 (2603:10b6:303:16d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.25 via Frontend
 Transport; Fri, 2 Jun 2023 19:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 19:32:55 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 14:32:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rafael Wysocki <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for suspend related messages
Date:   Fri, 2 Jun 2023 02:30:25 -0500
Message-ID: <20230602073025.22884-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602073025.22884-1-mario.limonciello@amd.com>
References: <20230602073025.22884-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: c83ef4ba-0437-42c6-0383-08db63a02a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Wjnx4LGAUzrWwUcH5Iwxayk0HtWp7sUL5ANjvlUW64CyV5H0mdBjdR0qhwoXFbg8XPrUPjWUgvFqMmlffKhmMZFU9Q18O88E9SkYlEtEnVoeRLVd416Wfcp3xIViki6jywQbpBEomJr7hFumNGxcVcExER0Jqd4hfcIm62ucONF6wG12nSm69X7P9Ieurm+bkD9HWXhvBEz+xTlImAnp5GkMClayoSRTsWT2eL+sfXkby07SAWb3b925Rt3xsiHuOWN9nURmW1D8k+3rcKE/JwVgIUmCEORPWx9LZmIkqNkMgSLX/MuZWqWrtj/utOwRRFFhbn00GsfpVdDtBZ+v2JNbk5LTKR+ZZMHJwNAs1IHE5eHWWhFMG+7s6fbzjp0Q3C1jqghocRQpypp7ujNa33AaxU5SHPEq5Dgs4P43KZ+XIrg84XxoQ6qvdmREd3DJeZ6eqcZAmy4JOQMWpB6Uc0dbN9SkXnDNp2TMoEdNhjplpMx0ra100faNzM12Y+jiqa0BpcOoPU0ZRtDRkwTTxHGky8xLdwmsViPuA7MxBhvplTPHx7Rjte1fKsFJxcuhxSdFS3PI5BE/DKbVJSE9o74a138hOVThLEWOS1ljSZaeRAMou5ziixxsKCBMO+ap2KByKvH2LciozImEcZ9eeI/dcYds3u/JEHErauRDqAHwXmrrymFKk3gfAT8ekaL8yEz5lAQ52fkWYLXqBhN0sGKvhcIZtJQ8bu9nO3WkpMGfgMdMxYEt7+5WjxqjXRXJBA5zShnD0V0hnOBfVyPhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(7696005)(478600001)(6666004)(36860700001)(186003)(36756003)(336012)(426003)(47076005)(16526019)(86362001)(82310400005)(2616005)(81166007)(40480700001)(356005)(82740400003)(26005)(1076003)(83380400001)(41300700001)(316002)(4326008)(70586007)(44832011)(70206006)(8676002)(15650500001)(5660300002)(2906002)(110136005)(54906003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 19:32:55.3528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c83ef4ba-0437-42c6-0383-08db63a02a20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
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

