Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11947372D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjFTR1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFTR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:27:38 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B340A3;
        Tue, 20 Jun 2023 10:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKT9ncMJXC3+mHFIIQCYkeJVsejWhcv03JDXKUhnJJ8XX9AV6/XWEGxa3P60t7QHk7VPy0ZmOkzBhymqqL8AML4dnnVJPbDxb0YCTbjGAJDV3oj+q7wVAPXV8N1VnHU9mfgkUgZJ+y09nwiDqNBgSbqvoqomshgzn5ux6yzSa2urO2nvZ3zJoWkdLbpuGSp5JfFJiFq85dVQHJydXu0r13Nw0XzzDFZyqMnza8vNAdjieBo4qkpxIzn5XmD0IoRx9Vo5ZkZ5Tnc8Z9EPHMIX3GUhUefoEUPutHWXnR5SZMLu1E7DEmA0l36NazPTL6rr3ilVRUnWu2zsTjS+LC5x9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvdeHgK8I91u4YE4HZJMiMMXoCaHX4aRM7nVHauW1y4=;
 b=G2ctEKPPv+hJ0fcuHBuldoCOxjeX+AWY7sxA3m/yIRtrPKTJ8db6vKf8IZhYcX6j4WdJH9KiP16L1X/CVv/a7Zqg7nBJ2fh3zm5H+z0RWS4gtOAsbfF2Nf2yJBLkYyFeelTNb9US/Nvb9dKALzphksG6Y4Etx8Ol82ZyjfSVfip74gmuAMFu9PROI5144I3ux6GtOC8abVn9GWwSabYVdKJZEbeAQ/0a5mUF4yZKPG4xW1bNrDMkWCxovblpD1f4B+PaDKz7Um1k24CDik/xiukgOj9ntaOoOGT5qyteyLpQ8Dl3tnfjmwWj4a94488S2rjHjsPgW5pzXqfEDfnxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvdeHgK8I91u4YE4HZJMiMMXoCaHX4aRM7nVHauW1y4=;
 b=InX0FrQQ7G+93rqABIMAcsETttd2TySgKrr0z5PIfWUPaF3jJhTT+BswKb4TC6RrAvhPg320/WDDd2UsQy/I47ALa1qJrIqlpXyayRduGNvsBYFil2vXFYQh7O/OyBFb4lKisVgbv605QPFCeUmNQF8vmqfpIzPUwdGyi2eLMX8=
Received: from PH8PR02CA0011.namprd02.prod.outlook.com (2603:10b6:510:2d0::10)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:27:35 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::b6) by PH8PR02CA0011.outlook.office365.com
 (2603:10b6:510:2d0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 17:27:34 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:27:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
        Wyes Karny <Wyes.Karny@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 1/3] ACPI: CPPC: Add definition for undefined FADT preferred PM profile value
Date:   Tue, 20 Jun 2023 12:24:31 -0500
Message-ID: <20230620172433.21325-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620172433.21325-1-mario.limonciello@amd.com>
References: <20230620172433.21325-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: c84faec9-dfaa-4622-d534-08db71b3a2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5xT3+fpsM/ba12YoAc4wEBMcPD6Qs6T1XWspAiWI1dyiBbTf/r2PkEQMjc8+3JmjptfFCUa5rkaal/Zm0m4bAYM1dk2UDeocOfGeM4UED9SyH5MDSxad5xFB1gGx/kaQBzXMB+Qwv7j3l0AsUKclOoPPhXfAItIGBHKfRsy7n6hZUhEYtkfW47lNQPJ52uQToTzkQjRb2/nbuvT7Aj+/yWtf74fijJjgeN88hd98c8mFThQ2HXr+ecW+dHQPtjVu2Yk8uA2PvBC82qenLqayW+AvqfX4SF1bDVvwHq2HwDas6S3G07ZQ+z8c8+YpFsd427bFhwwLIShESMaGT/pmsBAZA/HWEWjrpWlmEuATgIrZHMG2jCW1uqdB9nNfJtByLqa2khlKbzAsGErqpDnhJ/jwExhJ4eCG0BuQ+v2kb7YIQ3SsQLF+C3Rtj5OGAForrIeNTMl8QXisF/dkgkVlxYat7cF7HSOURkIyzUepF3PC45nolIlbiqKINnmeXm7epTMmq1EaYSDsm074jSi28WRhghhlSbSTpto0CBBWi51pamOgD1hdnmUQCQ0gSW0dxq5zj7RU7KDxiOAyhfPOCoQtNfGw6mf/gCkgsPLnLVkYZSBK0+p4XXD9Z3RtU6xGc8UFC487kLJ9t/Ytycfm1KJ2jxT1ZbsFtAcD/2ujVjYJnrQOdkCXDqiR8somPEWSvS8aApi5ucEpLECbRYvrLQ6zz1ag4zA3Vd4EiN2hJDnhOTCdLMJEFD1JZsMBgWtyTnAHxzxHp4PxpXnYN6s7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(1076003)(26005)(2906002)(966005)(7696005)(47076005)(82310400005)(36756003)(40460700003)(86362001)(36860700001)(40480700001)(8676002)(8936002)(70586007)(70206006)(41300700001)(316002)(4326008)(6916009)(426003)(2616005)(186003)(16526019)(82740400003)(81166007)(356005)(478600001)(83380400001)(336012)(54906003)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:27:34.5997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84faec9-dfaa-4622-d534-08db71b3a2bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event a new preferred PM profile value is introduced it's best for
code to be able to defensively guard against it so that the wrong settings
don't get applied on a new system that uses this profile but ancient
kernels.

Acked-by: Huang Rui <ray.huang@amd.com>
Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Drop new symbols (they fold into patch 2)
 * Update commit message
 * Add Ray's tag
---
 include/acpi/actbl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index e5dfb6f4de52..451f6276da49 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -307,7 +307,8 @@ enum acpi_preferred_pm_profiles {
 	PM_SOHO_SERVER = 5,
 	PM_APPLIANCE_PC = 6,
 	PM_PERFORMANCE_SERVER = 7,
-	PM_TABLET = 8
+	PM_TABLET = 8,
+	NR_PM_PROFILES = 9
 };
 
 /* Values for sleep_status and sleep_control registers (V5+ FADT) */
-- 
2.34.1

