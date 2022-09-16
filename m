Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9145BB21B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiIPS1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIPS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:26:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C879CB6D76;
        Fri, 16 Sep 2022 11:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSZMHXix9rHzBdAkLeiTaVCdhclG8gsYDvszDOa6UKKYwUViUR6WrMjIaIxsJmGXZ5ZLDxBhqrA46vRhKCARPkNRRCcaxAKd2TK1+Is3deX5MsFxareZfgWnaOIjpneFiojlw83KUq7rAGTdoMXGc1aBM1PK7V59VZUsL1f5EE1x3b5NXLV+v98jTMINJ15DVDIHGkaHmlMscwdL07fC2NDXZUd+ZbuWETBAClB54OSok44m4XzS2jlHl49gO8DXBoku2gnyPOWjlrvKhFnqC5R2hYxQLspp5a5lAvWiTMrCqF2aT78ymWuqLi8BtBLcP94YnOF7ZLYMWKUS95bNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Llqeg4TjQ++pX9TuvSuuly+jehqWmV537lSvc4A1pNA=;
 b=jHR90jdSkLCo1GaMV7J4bK7stOF9/R+eLXNUpXZ56BLUvWTVSbFJCWoV9weFZkqQLXXHbAcL2K7Bgy8pAUHcrIWCvqjVKGpVSJQvqhdR4LHYLzRnsNQDKAXffvbBfR9gdgxG6nGnRsMD/lUA7f4IEYbHHWTG+BZMzwc6fzCk9muDkL8865Hmo+m/+DaXoV++RHkWS37heTUzUE2fNRSqEESNXo2zlCjsXI1eXjrNEUnR+1cwzDRA4t0QsCqo+ZRA9jhS+/0Xy07mMxcRjnemkCh36FwMFppswVXcvmWGAUZRx4uZ86SBo5vKhaBixSzK98i1PbV9EpJwEhkl6+P1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Llqeg4TjQ++pX9TuvSuuly+jehqWmV537lSvc4A1pNA=;
 b=5PvIksePcqm5HYY7Zq0gFoaam6H1FvXATlLoARs7XL74Ld2yrIjZODIhnKWnFsxMtfkGdZOBR46DnLpggUkLqurn6A70tXXoD8vB2LUhRnADiJboCL8ZudsuvBnWvldT/aF9NX2G59cU2M+ireK7gfsDk9k+Ros+U6WPOwwV80o=
Received: from BY5PR17CA0001.namprd17.prod.outlook.com (2603:10b6:a03:1b8::14)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 18:26:27 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::20) by BY5PR17CA0001.outlook.office365.com
 (2603:10b6:a03:1b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 18:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Fri, 16 Sep 2022 18:26:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 13:26:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, "Sebastian S ." <iam@decentr.al>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 6/7] acpi/x86: s2idle: Add a quirk for Lenovo Slim 7 Pro 14ARH7
Date:   Fri, 16 Sep 2022 13:26:08 -0500
Message-ID: <20220916182609.3039-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916182609.3039-1-mario.limonciello@amd.com>
References: <20220916182609.3039-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7b88d6-e1c7-4642-c1bf-08da9810f7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4/m37FvKS/bozju20cIoxXl5x9f5K4y3DPQhsrV4scfSEkPdaL93y/dIXuqZlqCzjavgIMNSUsv7uyl8/er1Y0ZxczZttZcLuJinFUw0MyAE5z1FHwKmPB3W4athTUux3z4ty2zdLr/p1F+xAPGq9MFoWIWEFqB7DBkdcUeK5AZZkASMPFtSBta5W2G24rt7ijUk/eGo7sqvLfU+OcvIXUAidX3nDybRETS02gt5cr7SJJ7rexom06nyxGHKB4JpFEXukjfQPifcHnVxMuuLYkzcdObIaJ0HsTppzW2T9ROdqJzwwa679ZcAgM4k8jyvC6ejagsIGvpI2b8P/Qo7JkiFUI0THyY/XkzlxEz+IdNJKAjdrJuJpUxrQCQkOOYXsKcIhvzYHVJSzVeUsFOLKYN4JlUGN2t5K2tPw8RWxT80KTk6ZLWqpM9cgAkoiDlteJ1r/R/4zE/D1kQ//yQ0FDGT9UBTmMGbxW0HB9opF+RqVr4i5lyFX/MgN/KUOAmrog+5YF8mpBdjx+sNGe9oeT9Fvf28gdO8C6jh/dN5xVmwdU/WgTZaoNUbQSyiohlowe9DPeNr/DxLY1jkPlollM0qmHjwyyRvUA9rV3Kv6B4Fgo2FUAdCuzpsuUr/EzSiGwXs12E5EMd8bo3CYLy8jBRLnzCGpD0YfQdiBUDuZI2ySDnIJsKlihilF4ARcILZeCZ6olEh/CwxKP7qGy8R34+HWmk1UDqFpIFtW1ILZfceHktWsPW2iipkKHZWuoScnspga4D3+7RASxGzboYchvutpKjiLHuK5eCUBRPyJ7jkeqNgIfB/PDcwDFw/tgeItuw5wfdwaqhd2+b4TYPq99X0IqtnQ8QOWej0G7MylEl+QlK8SCrDRePH5VutfvT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(81166007)(356005)(36756003)(36860700001)(86362001)(1076003)(44832011)(26005)(40460700003)(40480700001)(82310400005)(2906002)(478600001)(45080400002)(186003)(41300700001)(966005)(7696005)(6666004)(16526019)(336012)(2616005)(426003)(47076005)(110136005)(316002)(54906003)(70586007)(70206006)(8676002)(7416002)(4326008)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:26:27.1579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7b88d6-e1c7-4642-c1bf-08da9810f7f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo Slim 7 Pro 14ARH7 has a sporadically non-functional keyboard
when resuming from s2idle.  This is caused by some missing calls to the
EC that don't occur in the AMD codepath but only in the Microsoft codepath.

Add the system to the quirk list to force Microsoft codepath.

Reported-by: Travis Glenn Hansen <travisghansen@yahoo.com>
Reported-by: Sebastian S. <iam@decentr.al>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216473
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216438
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Adjust prefix to cover multiple systems
 * Add another Link tag
v1->v2:
 * New patch
---
 drivers/acpi/x86/s2idle.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 52f41119f296..9c84eb068e19 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -428,6 +428,18 @@ static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14 GA402"),
 		},
 	},
+	{
+		/*
+		 * Lenovo Yoga Slim 7 Pro X 14ARH7
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216438 : 82V2
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216438 : 82TL
+		 */
+		.callback = lps0_prefer_microsoft,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82"),
+		},
+	},
 	{}
 };
 
-- 
2.34.1

