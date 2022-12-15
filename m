Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D084D64DE12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLOPvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLOPvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:51:35 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EB2286C2;
        Thu, 15 Dec 2022 07:51:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8hAB1OAP+j/mdzErl6pC7xnMg4ZI3vutl2J3XVog2mCLYZDKkLowih5egd4qA6PXZ46DhqPQd1i/bJuHM/no2S7hyeRyNTYtAfbkc/Sc8RFuXxZgmrfTNHdI/5MhoeubIKwxkzT+oNQu7ypNfzo+TNqOyGyhK4yzjiceSoPNkQdxoQe6X36IPvH7UoJiqQ6QGWVu6AfCDN6/6N4ppQU1Eg7DD4tePp5r5kKZ2bg8A1X0VNzSNh3XobCKBtNIOzFfsPQdxQY1+XHHIKGzfq0IEta9T7I6ElmHt99L16wh+BNuaRIU1RGEbav4F/OJpYfmal4u0Kezw77ld+BAJnSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nux/Es/CyH6oRdiqvlvwzvzhCqjwC77aoe2q9jZ0WOk=;
 b=Oaoe7jQtATg5H6XPMnoRi7hMQRYtR8a0pHiWpqygHgrS94LUT1OxXRz3Izp0KL2MXS6wnsuSDBxYdunVJE1n2Qksh79B6M2YH3yGRubKmusayrf9P7ysFJ8eUegQTzsFA26mAqHGM1BurzVelR0RkcI3Udf3j6eXcSX1FAcPFbk4bW9ni7cMfvTf+ZfVimN1AvWr2b6u4wx2ojuZqTGH3Bj5aB0xG0M7s3iHTMn9xgs+YwxdVeOsUZ3Dr1hLhN+D5j9WFXT/8tzyoOsGK1vfOORcPVLXqUUSs2qEe8CVVC51bmejSSmurdgYAmfQsE3WfdwW5sYch/FytuTrjodsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nux/Es/CyH6oRdiqvlvwzvzhCqjwC77aoe2q9jZ0WOk=;
 b=IPh9AjXknA9kGebEZwb9EZeb8Yy9DyTPlqjQIZAam7hF8hfGGpR57cNrC+aDUgoJposuTjicl5uWc7PvkyMW4AYaSfDWtIRE4W5d8YB+TWjX/TNsX1P046Qunedzi8+bGwbrit4B/T6Iag+9LcieL6eZFF3zbexSVUfGUHJomiI=
Received: from BN9PR03CA0753.namprd03.prod.outlook.com (2603:10b6:408:13a::8)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 15:51:32 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::79) by BN9PR03CA0753.outlook.office365.com
 (2603:10b6:408:13a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 15:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 15 Dec 2022 15:51:31 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 09:51:30 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lin Ming <ming.m.lin@intel.com>,
        Len Brown <len.brown@intel.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPICA: Drop port I/O validation for some regions
Date:   Thu, 15 Dec 2022 09:51:20 -0600
Message-ID: <20221215155120.2276-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e985c0a-2ec2-4243-a346-08dadeb43c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXK1Ob7QOHI2NdqhD755GL/xPEwO5hYpylI8s3DAqx6BolucpAP2Z2GfOBx9dOsDtuHI+sKEq+t2yFR+8XGrdJPa73uE09UAk0GehkDgWxWz+kioRadjbCcUsLYNKQ1Nk9DtpMqyNSc8X9WwajBB3sIfA0xgjIaVzbdrQ2jj9ai6MhuousgL560+ZBYHXQOF62FHyNJl2cqyjeKkXEGdyiwJueXBTQn3SPMYL0srr8fTLw5fX5WUIafg4cDUVGabwe5cBqy1wKdjBI4Q9QV4IPg8MmbdfsMCJKWoW3MyfMubKvGG29N+ZjBX77wjo4f88GG6y0o6JqWbJm8MJc51mAl9j6PBCTanJhjQ/wgnoevWAKo2qW7YdzmQIkWusDkUGQ8YE9CyJTuMzXPKNE2CkZ5viOfbgFPzYnaUqj0qwh1mZBWXESuDdcWvGe9s/XrqGgIt6MczfPDVf2yPFX7XOKP+wmfBpmL3w6aVFiIgb7FWFl2bG1sh40MQ0gk/n7AcvRjtyNV/JUPajn8dDKjXbS3wE2OMdgUQUHqPQks6Y1GOvlBoldCe+vmI7+xY7BBczv6XDrOe0HAj86xdU3JB4ecSbhp71ezD2QVdUA0xw2NXxumLyttpEZZzQOKhfJIAlLxm0oVBspIYQ71KrVwBfBVWbbcvj6SCeFlajIRuJSsrolMtTGkPStO9AOmteAOGRcdrRScfRe+2VCY91zp4ErSgzKhy+QkqZ3eTk/Yu+SPSx9DfgZqqB02T05vctH6Q97PRnV/Xu9MS1w68AsGlEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(86362001)(36756003)(4326008)(8676002)(45080400002)(70206006)(70586007)(316002)(54906003)(1076003)(2616005)(82740400003)(81166007)(426003)(47076005)(36860700001)(83380400001)(2906002)(40460700003)(966005)(336012)(82310400005)(16526019)(186003)(26005)(110136005)(478600001)(6666004)(356005)(7696005)(41300700001)(40480700001)(5660300002)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 15:51:31.8608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e985c0a-2ec2-4243-a346-08dadeb43c9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microsoft introduced support in Windows XP for blocking port I/O
to various regions.  For Windows compatibility ACPICA has adopted
the same protections and will disallow writes to those
(presumably) the same regions.

On some systems the AML included with the firmware will issue 4 byte
long writes to 0x80.  These writes aren't making it over because of this
blockage. The first 4 byte write attempt is rejected, and then
subsequently 1 byte at a time each offset is tried. The first at 0x80
works, but then the next 3 bytes are rejected.

This manifests in bizarre failures for devices that expected the AML to
write all 4 bytes.  Trying the same AML on Windows 10 or 11 doesn't hit
this failure and all 4 bytes are written.

Either some of these regions were wrong or some point after Windows XP
some of these regions blocks have been lifted.

In the last 15 years there doesn't seem to be any reports popping up of
this error in the Windows event viewer anymore.  There is no documentation
at Microsoft's developer site indicating that Windows ACPI interpreter
blocks these regions. Between the lack of documentation and the fact that
the writes actually do work in Windows 10 and 11, it's quite likely
Windows doesn't actually enforce this anymore.

So to help the issue, only enforce Windows XP specific entries if the
latest _OSI supported is Windows XP. Continue to enforce the
ALWAYS_ILLEGAL entries.

Link: https://github.com/acpica/acpica/pull/817
Fixes: 7f0719039085 ("ACPICA: New: I/O port protection")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/acpica/hwvalid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 915b26448d2c..0d392e7b0747 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -23,8 +23,8 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width);
  *
  * The table is used to implement the Microsoft port access rules that
  * first appeared in Windows XP. Some ports are always illegal, and some
- * ports are only illegal if the BIOS calls _OSI with a win_XP string or
- * later (meaning that the BIOS itelf is post-XP.)
+ * ports are only illegal if the BIOS calls _OSI with nothing newer than
+ * the specific _OSI strings.
  *
  * This provides ACPICA with the desired port protections and
  * Microsoft compatibility.
@@ -145,7 +145,8 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 
 			/* Port illegality may depend on the _OSI calls made by the BIOS */
 
-			if (acpi_gbl_osi_data >= port_info->osi_dependency) {
+			if (port_info->osi_dependency == ACPI_ALWAYS_ILLEGAL ||
+			    acpi_gbl_osi_data == port_info->osi_dependency) {
 				ACPI_DEBUG_PRINT((ACPI_DB_VALUES,
 						  "Denied AML access to port 0x%8.8X%8.8X/%X (%s 0x%.4X-0x%.4X)\n",
 						  ACPI_FORMAT_UINT64(address),
-- 
2.34.1

