Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADE5E549D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiIUUlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiIUUlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:41:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8D59DF91;
        Wed, 21 Sep 2022 13:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgX90EABTAaSuyjCpXDhxD5kYqIc/EGyRuOJgIIclC0TevWbMW4WgHe873Ghs2I8c95li3C1P2CgkfkhA0aNESMXNDvfGViIcRvrsOMc4+0lS3yUTbcZlOoPou3RGdT7o7ZTRwFdKWWuJcMuF3b7G8Lxsdt7brcxcGD53QyxTQRnirIde1PudC88j+RWvGqYoPle075EBCd0yqQpoPENtXtDG+LJUXSZ3fisWXo9n9nF2XEQIiFiZP5D7ytr/hsCOGoNrnfGHaxqeo1TfMVqga0acIr98WkTq3E5b0r8OFrDLhOxefOGVG8h545WEaAHE2k4r0OTOr4A+XXZJsJ4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKqcJNcHmIvYByUS375q8UZD1SDsKqYT2s5xqmccxRs=;
 b=fQE7EAVvaCdv3+WaJ5hOHNlURTdHoerDVQYvn60EGLXJPqESJwOsAowwZ5Ab/2f2ObtsVw4EzThFJ5ue2ueB2X5z5CGVJ+HhqzIjcSjBhWpAuw9iPnMikymksNWD+No5TCnNAIyZGb5e67UGuSDI1SS0m1tA+DRYgPn6sGUPZ68C276X+5ISlgVe6Wuuy5ZsTAk3XkUvlY3XJbWN1j+dC0oDzPiJIucUXhK01Rt2yTgPeUUozGIVTHdHr5negaysrD9C9rX4h9B02MpfnPvLEFEGrsE6BQNSzdVTTw44Ol34/8RuNqbuZ8jOxBZlOa0DkJg1WBmOJ8UoJUAJjE3V1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKqcJNcHmIvYByUS375q8UZD1SDsKqYT2s5xqmccxRs=;
 b=wuMZmww7Zaq+V85riYR8qFfVrk82MlXlQT7NN2yNZ6oVcVlShdhQRPXb7lgG4Km4XugT4iig9KiWCY2xuRRj8PdrDsc584kTkKuyYwn2uZkm7Kt4o/SZmcwRx4d4crxzhqgS6LTLqzfeu2y1RAhYTL3DuXRPP859SfEyCuZpHGA=
Received: from DM6PR07CA0097.namprd07.prod.outlook.com (2603:10b6:5:337::30)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Wed, 21 Sep
 2022 20:40:56 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::80) by DM6PR07CA0097.outlook.office365.com
 (2603:10b6:5:337::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 20:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Wed, 21 Sep 2022 20:40:56 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 15:40:54 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>, <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, <iam@decentr.al>, <hdegoede@redhat.com>,
        <davidedp91@gmail.com>, <marko.cekrlic.26@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v4 4/7] acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming A17 FA707RE
Date:   Wed, 21 Sep 2022 15:40:51 -0500
Message-ID: <20220921204055.22889-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 32472976-00eb-4549-5bbf-08da9c1195b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kuJJhLdyIv9B4MuqzFBEKRZHy82LJwytv4zFke8yXPwb4trRCFl8u9yhR9qGrBkg/nGgsej4228ZnJb0BQzwM0t9plYQGm5kz/0m3PavgtHwsmccwLfgiBnsEwjvs/E8iFmHNXi3TbJYgmWRuaZIz0Hb+5cswl1serCBieUWwghrgRhtnu8BZkTOo75xQckCxksDc9oOdQTm7ZAZmTdxsBTuAZqc7/rg1jUUjHMR9YNkfbm5Fu80WZbteBEbnzrT/OKLp9YN1hEfmAnAGKemfCf+458pKSrQ7x7+2DUgpLectuaEBndRkAQzbygqA7mCffivbg/4wEJ0G78UFTHv8WdfuspaIzdZKwsOup+fafw+dZVjAwmAzBddDT6mr93qjDGNZqLt3v5iAR8sIA9cEDfs/8hTP5+qYkUjxQJ47pnl2bHXL+fqFNHFkdAT/efVoqQgBs6KkvPCeeqYiYmQ5GJFW+qfmU6fgXzGWGKE48yI+8IHy4qDgsnGfrA14aJ1ML3QFnEBwCnyZYIc3GvHmsviuF6N3eFWeI92J424zHaDm1EPmSbS5SLOziW9MO6WIvdJYfNnFyJ7QKft71TaYRGFcmg8EqJ0BKQ+u1jYQDSi+NVXSOU65zEGZE0ou0yeQU3lPx2ycBGxJIkVQ/5B9FJJQBKTDfWhSNda+CTGtAKc+3v9Xx9h6iLcnxAPeBnpRO9TpaXbJ3gElx2ZE+V3h5SHZVZuaWW6auQbdCtbJAoGhyyrH5iDQ9LZOZdfVUrls5eOND/jmo9i9CdhSxOJE9omdOaNJ69AB39nhkyKFEpRrS7n99EtszjHwEBNQv5XwtMvTHdL4sOP4Ooe8J+pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(6666004)(110136005)(478600001)(26005)(81166007)(356005)(316002)(54906003)(45080400002)(966005)(5660300002)(36860700001)(16526019)(86362001)(40480700001)(186003)(8676002)(426003)(336012)(1076003)(2616005)(47076005)(36756003)(2906002)(40460700003)(44832011)(8936002)(41300700001)(7696005)(70206006)(70586007)(83380400001)(7416002)(4326008)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 20:40:56.5214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32472976-00eb-4549-5bbf-08da9c1195b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS TUF Gaming A17 FA707RE has problems with ACPI events after
s2idle resume.  It's from a missing call to an ASL method in AMD
the s2idle calling path. Force the system to use the Microsoft
Modern Standby calling path instead.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216101
Reported-and-tested-by: catalin@antebit.com
Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Rename parameter per change in 3/7
v2->v3:
 * Add tags
v1->v2:
 * Fixup for __init
---
 drivers/acpi/x86/s2idle.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 725d2a6c87ed..99eae362de6d 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -17,6 +17,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/suspend.h>
 
 #include "../sleep.h"
@@ -400,6 +401,28 @@ static const struct acpi_device_id amd_hid_ids[] = {
 	{}
 };
 
+static int lps0_prefer_microsoft(const struct dmi_system_id *id)
+{
+	pr_debug("Preferring Microsoft GUID.\n");
+	prefer_microsoft_dsm_guid = true;
+	return 0;
+}
+
+static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
+	{
+		/*
+		 * ASUS TUF Gaming A17 FA707RE
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216101
+		 */
+		.callback = lps0_prefer_microsoft,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A17"),
+		},
+	},
+	{}
+};
+
 static int lps0_device_attach(struct acpi_device *adev,
 			      const struct acpi_device_id *not_used)
 {
@@ -566,8 +589,9 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.end = acpi_s2idle_end,
 };
 
-void acpi_s2idle_setup(void)
+void __init acpi_s2idle_setup(void)
 {
+	dmi_check_system(s2idle_dmi_table);
 	acpi_scan_add_handler(&lps0_handler);
 	s2idle_set_ops(&acpi_s2idle_ops_lps0);
 }
-- 
2.34.1

