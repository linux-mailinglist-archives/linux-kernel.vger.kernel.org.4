Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2515EE1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiI1QUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiI1QTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:19:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F4813CE9;
        Wed, 28 Sep 2022 09:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCHIH/bi4R8GdYIuTg0f7Gp4AuW5GjdYMSagGS+DZR/CmBzkLCA/14CfBgbf+gbcdyil6XdAHM8gr6N0BbbkfhcPFfSl9szqJayhGCiKImH+speY+BlusHBjOHiM0q4OQ+jaP7d5L0ej2y9HBHZzCmbqTr4U9UUCSGno7YJUUGWIVW1yEW7Q5RCg/huQo4o+/Gd27KUXuLtOqUTkORFS4kdDRqKHPzbmnHAWzLyHti1+ommpfAKnBMK7aBa6kf4xTgq+lwuNaHKq0/DrBW0BNeg4ioPYg7wPG3qgpCz5PFm+Ydpr7SGAGlDFYJPZigHhSHfKJbdx4/y8iKVjkR6PLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWKv0psN6tCPonjYPFvcnE00NP4TXAr7JWg6dGs+2lM=;
 b=Zpr/8kcxA3DAQbPbOrLJSvE6XhfIMNd2/yXJIUww/JOY/qypzxrnDJnTRtTiukoghwCmWQXPGzkxjwhH63fLuQILyFtYYuUNORQqlRH3bqqPpsEkCGjXfnmezrwuEYNqPr2yHAuRtTJaEiVPI7EE1bcBDggQxZSWTCxlpkpQYjcOL3Qyd32ZwdcAvor8K0CvXdqjMYdLaRIsRCaGm2BSGu9UxNxyiAqVyBmz6YOgcC5Rl8bxS/8hBaJlqbcqIHr+SMgaW5QtAfLXAKPneefS9l8RvyZLVvRCJJuTq0BM+3D/I1qbFU4dc+60yo9K45wqWP40lVXDE3s/GT2oQ0GWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWKv0psN6tCPonjYPFvcnE00NP4TXAr7JWg6dGs+2lM=;
 b=3QldTtbvIhxIEnnmJDQjpF6LTO6i4NyLHr9mM6B7cKAlMDTq7OZeR/sVE0PQqsk6g9hRWgNAa6u8F5MuDbXUkF3WNjMKLqlBcKmB89BbapkyrcOGh/DfZ8HfJsYfxc08YvC96YvzH090CUcPNsVos/OKIz4JD9GQP/y8cxYn/8A=
Received: from DS7PR03CA0206.namprd03.prod.outlook.com (2603:10b6:5:3b6::31)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 16:19:46 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::b8) by DS7PR03CA0206.outlook.office365.com
 (2603:10b6:5:3b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 16:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 16:19:46 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 11:19:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>
CC:     <luke@ljones.dev>, <Shyam-sundar.S-k@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 2/2] ACPI: x86: s2idle: Add another ID to s2idle_dmi_table
Date:   Wed, 28 Sep 2022 11:19:35 -0500
Message-ID: <20220928161935.31913-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928161935.31913-1-mario.limonciello@amd.com>
References: <20220928161935.31913-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: ba19ae0d-4d72-404e-bed2-08daa16d42ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhAg5sFzSroqqtSK1/R7mTmJbB+D7e/b/x068VEcbRT15GJ7h37WTQQyeVBYcvSgRJ8ZiyeJsIDE97uip8B5V1VFtV9OYIcklAXMcmKSCFePH8e3vq2Qy1A3vCnkJJp4TdAwX/qf32+M3iSoq6R72jp+3civnzxs9wKb1JA4omNMlkJTMdKFs59varMq8Ciu306XbvkLt3it4MLYhIZgg0RBhGcfQhTNVimbNB+BvqNkUUYZVf6ZPlVglzg05uS9/p/n2ICVBrzCp63wZF3a27XCONkeguBNe2TVBf++gem4OAQaybV1Llg5GMjS9ujeRJgW8rnoi5JSoLT8nqLkg7VJVVTvsrIiaTLQGJrL63fbKiGLjEbHDijr5/7VieqNIwFQljSHNhtUrMh0e8Br2bV1UoCehJL6TR4KS61sNHeUgHkOZNl58RMvBjrjHHRx9/ER5SIJFtUGUvUGVU/Td+anrs/YLq9nipPI656yNjqEOH29ZHLzY15PQqz4utcQIS9SCuczTLBJdesohlMpI6dV0EtNwEkbzkNBvSNw17bQ99VBw3U0QRDzh5IM99MT9t5Clvjtp20pJmiLJ00pAjFW+TV7gb6XHNxMmTzrPaYPIS1r6nwlHMSd5LGaTxwEMG9Q5ATXwtUBGqHiuJvO25SZiC+Vp/f5Qf1khoWpbePi9Mo8LOwhq9LfQZQlsCrrsk1MnU3syUiRNxxF4MfarhxEUa2Jj8Vp8/xQ50HD2yuPDB1GPy5skj9fZwwtuJHZWRTLVeXemr4nAcGbjbX/gEI2dVWDHlaSe81pGDNCcXvBcjvnxUxEtt9KVy9XdAmIGAl8+jF8dck617OnxYyOlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(8936002)(186003)(47076005)(336012)(426003)(2616005)(1076003)(2906002)(478600001)(16526019)(45080400002)(41300700001)(316002)(966005)(54906003)(110136005)(86362001)(26005)(5660300002)(6666004)(7696005)(44832011)(8676002)(4326008)(70206006)(70586007)(82740400003)(356005)(40480700001)(82310400005)(36756003)(40460700003)(81166007)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 16:19:46.7442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba19ae0d-4d72-404e-bed2-08daa16d42ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's reported that "ASUSTeK COMPUTER INC. ROG Flow X16 GV601RW" has
non-functional fans after resume when using the AMD codepath.  This
issue is fixed using the Microsoft codepath.

Add the 3 variants of this system to the Microsoft codepath DMI table.
* GV601RW
* GV601RM
* GV601RE

Link: https://www.reddit.com/r/linuxhardware/comments/wh50nd/compatibility_report_asus_rog_flow_x16_gv601rm/
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2148#note_1571241
Reported-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 3ae2ba74de92..0155c1d2d608 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -451,6 +451,17 @@ static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Flow X13 GV301"),
 		},
 	},
+	{
+		/*
+		 * ASUSTeK COMPUTER INC. ROG Flow X16 GV601RW_GV601RW
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/2148
+		 */
+		.callback = lps0_prefer_microsoft,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Flow X16 GV601"),
+		},
+	},
 	{}
 };
 
-- 
2.34.1

