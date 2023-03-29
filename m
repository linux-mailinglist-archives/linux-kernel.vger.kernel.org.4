Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ADF6CF154
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjC2RqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC2RqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:46:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBB655B1;
        Wed, 29 Mar 2023 10:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVb5mkmzOwFhTXqaz9/DiXmYkDxl1GnzV/mzOGaXRpSQSWYx6CLdMMlSe1TJrQMvWRsbTfjCvUMbtqDvoVhY+RGSQ6j0jU9aE+fagOiW1zvJoKNduY80OfzcuRKvGO/fb4O62svMEschccSibOqC8Z1UKRqFXD1qHkYDdL6jJdogQeIWdib3VkNDINkzxpOuP2s/otQT4Vrt9nXHldleRwIwwSrZk6tsJjl3PiQN0RelU+U2n6MSCvdh9hfHFLFMGhrsrOr+mGeO31uPnK8sM72lgb8Pe2I2iMoQM7TC5tTB8gK+/oYCW39U2xVUemTshwTGfWXQFiVy9bNQLDbNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFkcmUUWOjJPBKH4ad1wuM5v88Gc6KVkN6gxiwmSJsg=;
 b=Tj3FEkDbCnj17Hq9G9+luunyj1f1LPsb8VBI/SjPBYzgQZF+08APg2QW2KqFJZjoA6t67Dbqk5Az0TBagHmS5zs7YfobFRR1amvCQdGELH58u9JVKhWUetur/UlxJOrFz99EEDMaN8HwBXw3Gen0JBT8owkKv5z/Xvaqg2u1atA79iEuw4LvCgunCzs9ujc+QuyLi30GzKrXbRfEZ71+dZZQPL8sMMRIZKkyMyhwosoaCrHaU4o7DIUaPo8T9LmlyWtoo/1SevwtAPHKJBWFvPfdf/MmLGFjvGJbxfVllVz4LRqp2uI3LBwngW8MlGpc+Nh0PWrl0lA34toI5INERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFkcmUUWOjJPBKH4ad1wuM5v88Gc6KVkN6gxiwmSJsg=;
 b=w6HO8Ak/xKcWo/PRyhAj+j8Z8ZZCShZvW8kRckT0ce6LABQ25SA+DFvnHFFKXCuj4+x6X4Nj/l8pKXlGocFifueFnNGq55H/z59MEELHGVwd33Opw9yOxOecX5tyQAH/2lV8mB05v96d3tgqo36IVBsDcxUJilQka1ZuDA3syMA=
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 17:46:05 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::4f) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 17:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 17:46:04 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 12:46:03 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Mario Limonciello <mario.limonciello@amd.com>
CC:     Eric DeVolder <eric.devolder@oracle.com>,
        Borislav Petkob <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/ACPI/boot: Use FADT version to check support for online capable
Date:   Wed, 29 Mar 2023 12:45:35 -0500
Message-ID: <20230329174536.6931-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff8b979-87a5-493e-4308-08db307d7838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3IKNG4gMUzXHl3AxgUpoNNLr+xpUjoJvT6IOo4RT1jv7HGwBKB23E5wg9/EbwjUkPmMkL5BwwpxvOQPMxAIvfsbRmP8lxxAdgWMr98Hu5e4kdel7kya++4DYK6KGfhqDDn/oqcm7iQ5/58NVHoqjwL+PXOnN2JxZlMvYD62e8kx3kVLr21zmEY4Y3RrK0qP66xkvcaU0HgVMLNlGm/qSaIIoyE3mXsTAWt8PzD+3+BerAtmIvGkGSmOBHWSgVf/J8q+uzgq1aJmpqtkdFWR8GDWv08XsGJX+XLDUUc7qryTTXcuTl7FD38fVgDykvwXIm076SMzca+t1K4H3h2SrKh7sE/06evzS80LCbzYz6H19KcQM3NcUwOpCHMvG46+kkCa7Dp4BA3HRNc3Ce4Dcu0qATPe3u4eYnB5ZGTRCUYaIj40yGejum9ms+25dr/XfdZCMM43GgW5Q9RgmyJERBWJGzBvBJhM33dhJjtWNit7PYaQkUyOS2UBE0Kv02nseipHfls8pinJU2ahsuGm8fdisSZdjZgBhjeiSCL3zkzsOAaJfcBM3rMlb1dulenFcelOX506pnmpQ231YwGRdsAftJYfk0aSHAtRDLwKqqHK85arbuUCmKGYm+LdZ/WxdeVaNZO4tVfdx2Wtc4UT8dbUpBsck+bm6/evQt5u4WAtc0occdDClQEprdxnrASGielIFK+F47h1nl84z37tRfvZ/LWgJVxbIp3/8HGMTCs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(7049001)(2616005)(426003)(336012)(83380400001)(44832011)(5660300002)(7416002)(6666004)(8936002)(41300700001)(36756003)(54906003)(110136005)(8676002)(40460700003)(316002)(4326008)(478600001)(7696005)(70206006)(70586007)(36860700001)(82310400005)(86362001)(186003)(16526019)(81166007)(356005)(47076005)(40480700001)(1076003)(26005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 17:46:04.7649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff8b979-87a5-493e-4308-08db307d7838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI 6.3 introduced the online capable bit, and also introduced MADT
version 5.

This was used to distinguish whether the offset storing online capable
could be used. However ACPI 6.2b has MADT version "45" which is for
an errata version of the ACPI 6.2 spec.  This means that the Linux code
for detecting availability of MADT will mistakingly flag ACPI 6.2b as
supporting online capable which is inaccurate as it's an ACPI 6.3 feature.

Instead use the FADT major and minor revision fields to distingush this.

Reported-by: Eric DeVolder <eric.devolder@oracle.com>
Reported-by: Borislav Petkob <bp@alien8.de>
Fixes: aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/boot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1c38174b5f01..e92e3292fef7 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -146,7 +146,10 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 
 		pr_debug("Local APIC address 0x%08x\n", madt->address);
 	}
-	if (madt->header.revision >= 5)
+
+	if (acpi_gbl_FADT.header.revision > 6 ||
+	    (acpi_gbl_FADT.header.revision == 6 &&
+	     acpi_gbl_FADT.minor_revision >= 3))
 		acpi_support_online_capable = true;
 
 	default_acpi_madt_oem_check(madt->header.oem_id,
-- 
2.34.1

