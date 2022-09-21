Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF05E549B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiIUUlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiIUUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:40:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154299AFDB;
        Wed, 21 Sep 2022 13:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cShTlf8oPjCWnSDt9Gqo4/QCjLm4w9jIAusaK7hIMBCW6hVrZ2PNFhp14mzeu25RYz0YALz6rEHFbRJ3icxbTIBBJsmEKgVvpCtB9GNfdGvgRMpWhVwIud+quq/doM0Fq1Fdd6iVwQbsFhqyIWlinXB/O3yK69eImpFKDHbDQ9ou3Qnn2SJ7H+rp9k45ny8APSF2EAcqlPTgLyKpxC9MHvVRo9yQmeNtJt5kZLrlWH3wQiVrR70EmiTjhjsxNn5LVv0R9vRwIYlVxtPza2Gdn8Nv3G2K7lJUtsATtj9xDhijqPklVEfV4xcjVdgJbaGVNhCEsyCVmcpVnOPvZN1kYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu+mo1iXMAanBkfxUMrBrYqB1ngbY/23z24VwDxRvUs=;
 b=AzDmazSC9GHq3VL78+tbs7GuEBkQrqEc5pi5NfsyNiVmoAUkDV3ImsLxyGmouh4t6dUUAbD9NGUn9q60EUwAM928IOpeCgAgqBtbirA2h/BCiYLpOkTPQnKb0Yqdn56A/buqSgpQH/JhoJvhvn/eGgKsq/GmOdATkn/nNHV+rLIiZNUHPUHrmfD1+9JE+kidSoJAUaSV7HAqyt/neH8/L8t8aOTsicUBqU+/Rl8AqxWdwRUDrCK4DxUqQMMeZFSvryqv9apJEqa1dC+J74DOwpJnazR/sOnEJQpWaDU21/+wPpu1zfkjBt6NDHM9hTgbUVYzRC7Inn6qqJ+Rq8ocOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu+mo1iXMAanBkfxUMrBrYqB1ngbY/23z24VwDxRvUs=;
 b=Lf/ECWzT5IUM8t9j+scjzfAku3M20r3R5BoJKUC8643yN5L5kWCTSqPLEovf+ISt9WLz15WOYvJXiMpHmVJK8oDMwVAnlV+pVt0MozAjj0twyfeqm/vSwxjfog26D/VIC1Gk9mdgvlOzIhPi7rwXPdEGjJFUfP9BjjqHCwwMK9M=
Received: from DM6PR07CA0080.namprd07.prod.outlook.com (2603:10b6:5:337::13)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 20:40:55 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::cd) by DM6PR07CA0080.outlook.office365.com
 (2603:10b6:5:337::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 20:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Wed, 21 Sep 2022 20:40:55 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 15:40:52 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>, <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, <iam@decentr.al>, <hdegoede@redhat.com>,
        <davidedp91@gmail.com>, <marko.cekrlic.26@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v4 3/7] acpi/x86: s2idle: Add module parameter to prefer Microsoft GUID
Date:   Wed, 21 Sep 2022 15:40:50 -0500
Message-ID: <20220921204055.22889-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921204055.22889-1-mario.limonciello@amd.com>
References: <20220921204055.22889-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|CO6PR12MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a936f5-e0dc-425e-65e2-08da9c1194d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vsgOQzOHFBzl5EySF2ddchPdhv9GgYbMCi0rIXQIm13ysvr2faAblWeuL2ATjApYrOWvW2sgNaLoHRIY52vK8Ftj8ccGVEIdYhTsu5IidLDP6LeXdDg8GEz9WCr3Gvu1+s6avpgPv+BzIaR1RpIfS2IUi9GnW4aSzDT9A+K+JkMTVNdFjUm7q0NYdkURaYxf0ZlhxaeyEMN96Hw7+J2lIVQUcOc2GyozS+jk7Z0DN/ngkvMUu2FqupU726ioeZQoRgVFMV6/U2m/CNohYqOuEuAxZK7MYoeLhIC1xHQnOvyRJNI93uq3aAlh0tof2hKk4YCnSE7sTvOnxgqdboZLlTi2C+9cLowPZ4xAVN5CSeqBgZjtYu/tDiTi34zQLuXGLcni//RTUejCzaohd+M8maEV4p9bNZ8qVeMWVe7GQp00kYAa0GeG05oDKYlZGwaRIWYwYG/E/l65VHZdhrWdQujW+3250RwAPH1un8PTgqkOGlKS8O5XRTbFjvLvl2EcGk66sLqHqWD/FvegHYIG+c/Fe6mo4SV9ckLXOok1wjakYwBFSblGYzs8IOGDUxzWdXefN1F7OcTREhJpqjubSs5ho+BMSpcfTGiJUvzd8gdNoBCU6vGrSHB7Lrps9sPyymDZ7wVyuhWWWXr9nDNChVW56YM8Ajj8cvKFq25+OEiEpxd5qNL1vz/ddkFRsmM0CLrfBDzHg5oHd9MhWkrKfRI5jNg+C84aHdybi25GMYFWXT/YsuSoZwHZXawcf6Z6gNbbBAypNO8IIfBcjAT1F3DYX9C7+GxBJ5ZHUDLEC9NgYsNUebulUnETcFSMIQe
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(47530400004)(451199015)(40470700004)(46966006)(36840700001)(45080400002)(478600001)(4326008)(36756003)(41300700001)(5660300002)(7416002)(8936002)(54906003)(8676002)(316002)(110136005)(70586007)(70206006)(82310400005)(356005)(81166007)(36860700001)(40480700001)(82740400003)(26005)(2616005)(426003)(7696005)(52230400001)(40460700003)(186003)(1076003)(16526019)(336012)(83380400001)(47076005)(86362001)(2906002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 20:40:55.0371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a936f5-e0dc-425e-65e2-08da9c1194d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OEMs have made some mistakes in the past for the AMD GUID support
and not populated the method properly.  To add an escape hatch for
this problem introduce a module parameter that can force using
the Microsoft GUID.

This is intentionally introduced to both Intel and AMD codepaths
to allow using the parameter as a debugging tactic on either.

Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Rename parameter and string per Rafael's request
v2->v3:
 * Add tags
---
 drivers/acpi/x86/s2idle.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2c5931d247a2..725d2a6c87ed 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -27,6 +27,10 @@ static bool sleep_no_lps0 __read_mostly;
 module_param(sleep_no_lps0, bool, 0644);
 MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
 
+static bool prefer_microsoft_dsm_guid __read_mostly;
+module_param(prefer_microsoft_dsm_guid, bool, 0644);
+MODULE_PARM_DESC(prefer_microsoft_dsm_guid, "Prefer using Microsoft GUID in LPS0 device _DSM evaluation");
+
 static const struct acpi_device_id lps0_device_ids[] = {
 	{"PNP0D80", },
 	{"", },
@@ -402,6 +406,9 @@ static int lps0_device_attach(struct acpi_device *adev,
 	if (lps0_device_handle)
 		return 0;
 
+	lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
+						    ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
+						    &lps0_dsm_guid_microsoft);
 	if (acpi_s2idle_vendor_amd()) {
 		static const struct acpi_device_id *dev_id;
 		const struct amd_lps0_hid_device_data *data;
@@ -416,16 +423,12 @@ static int lps0_device_attach(struct acpi_device *adev,
 		rev_id = data->rev_id;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
-		lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
-					ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
-					&lps0_dsm_guid_microsoft);
 		if (lps0_dsm_func_mask > 0x3 && data->check_off_by_one) {
 			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
 			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
 					  ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
 		} else if (lps0_dsm_func_mask_microsoft > 0 && data->prefer_amd_guid &&
-				(!strcmp(hid, "AMDI0007") ||
-				 !strcmp(hid, "AMDI0008"))) {
+				!prefer_microsoft_dsm_guid) {
 			lps0_dsm_func_mask_microsoft = -EINVAL;
 			acpi_handle_debug(adev->handle, "_DSM Using AMD method\n");
 		}
@@ -433,7 +436,8 @@ static int lps0_device_attach(struct acpi_device *adev,
 		rev_id = 1;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID, rev_id, &lps0_dsm_guid);
-		lps0_dsm_func_mask_microsoft = -EINVAL;
+		if (!prefer_microsoft_dsm_guid)
+			lps0_dsm_func_mask_microsoft = -EINVAL;
 	}
 
 	if (lps0_dsm_func_mask < 0 && lps0_dsm_func_mask_microsoft < 0)
-- 
2.34.1

