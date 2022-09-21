Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B272F5E54A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiIUUlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiIUUlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:41:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00F5A3D7E;
        Wed, 21 Sep 2022 13:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkUQAAZRr+i2yS9i1qj8bNVpdES5cFamZ+mD/BLE5ybqI018TkXdZFQMP0J1SHegSdbRZSoipYYr1hAyWIP8KuMXxBQsEiBd4YMGzsCR+v1qjVDlWc0e5sxLLq0qAU8cXvLDSTwT6i9KypFB8BojQD3WD3X+SoZlXc9ANtW46kP6df0PbVkV7phwBGtFU6pKZE8nr95OvKO+/mxEnF4v3ggGQSnHBWy7IYBfHK8A6Sj8s0M+8MjVtf0LHeMtrF5VR9uRLoH6qi406acf3hPGOMLaMRjqf1yIDSYWsy6pT0rPXjP/qTiFe5hEHNrDCb1BCrebgBmAtqPhbIQ4OSbqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBSOjxZsPkZ9YhD40xr9ihuKaZmFQMXW0IpCGm6pwgQ=;
 b=Qieahu5jKYQIm1oXRdZ2kg20BZUuLNKONcmJ1LhVZ/T2bwg6BSpbpQHFb4cONcg06DQnm69Q9heMp1ZQQSYDKWUM4voE80kENzIU/ALGjpKVs+LXqQvopZ0L5Gud7Stg2i9B2jSHokhet8gZ6chC9Rm95hGf2kKUME7zM+zJVOzpYVntiIr1ZdNWzsgyloZfquv5QBrgSo2l2q0krA0OjXMxMrRJJXO69UYYawHbKcEHuXc48K5Nl54GH0Lv4sY2Mvcpp/T9nUTQFXH4AHjImQKeBUUg00AREqB1zJCccMWDtVBa2BD8rhrVWCYy9g6qeW8/7DODVUNRki91LtH4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBSOjxZsPkZ9YhD40xr9ihuKaZmFQMXW0IpCGm6pwgQ=;
 b=K9XgO1xNnf2uPK/4WyIcYcbIXQfZKzEEkxHmdl7n6k7TqKEOPg+McrPAsqZOWRe/fgq58o1jQeX9ZZpHayjD8n4RZ4BQFRAy66m4+fSM9eBLmq8aAAhggRLYyBtVG6KmOofOHzXjDKDFFz8wspwqRFIhw5zX4Vz0TpO1fYSJJls=
Received: from DM6PR07CA0080.namprd07.prod.outlook.com (2603:10b6:5:337::13)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 20:41:01 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::8) by DM6PR07CA0080.outlook.office365.com
 (2603:10b6:5:337::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 20:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Wed, 21 Sep 2022 20:41:01 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 15:40:59 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>, <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, <iam@decentr.al>, <hdegoede@redhat.com>,
        <davidedp91@gmail.com>, <marko.cekrlic.26@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v4 7/7] acpi/x86: s2idle: Add a quirk for ASUSTeK COMPUTER INC. ROG Flow X13
Date:   Wed, 21 Sep 2022 15:40:54 -0500
Message-ID: <20220921204055.22889-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 57219f81-4439-4cc2-af7e-08da9c11988f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzfYwKBXBnpU3tBS4arUY5KZtWQT/Q18SwduEOjlvJRfm+AlDPJQVi4z5vv+yCZO4e/zGvJEbAcZ7s3ewoyg1T9g3joIA4kq3FCr9GanJRMRzfrokjKYjSRnVk6Cv0M0wFXX9zB4bVKoweQLRDGhpmooSb/mPxYBUA/6J+VKTZFHbxaDm5rHoK998UbVP/rS5wOG+5f4dYhblwL7C5Zg/ZvhPq53oEBYbgFzoAuDfrTBezYnAZ7nlUOI3roFiYdFWeAtOcNPZiZOyORmhZs+OrqMf6Rfr5UWqI2tb1dXHI9rvmDPGpZ7krF2jrDoe02URN7zMolcipMWJfqOLxBb3Vby/HN+6IPaBa9KRLlvwvdbKO4nRCTAj/4IjC4DG/mHTGKZ+f0jZQdWhBd3LurR4ELg0rlKhERKQ+n+Qp/7VK3kBp14T5x5x5iBqZW7hXcukepoUd5arzI9WGLOGisien2HtymgZ0f7mcmLISr+uzJ5yeIj56F6SZerr7paavp47bx71NmSApJQ+Nvu8KyFJO2ucvmmU8ULzDQfi1/3P6O8Mo8k4cHd/82J8MJuLoTb+JvKJ0WR/+bH29KbWSQnAzzxXYBYD2dxH6iHzGkbF06jf8643USb7gqwdjbIfTbfrR551zxp4xspNE1GVx/ctAgDwn8lwp2idJO3iidE/lB8TIwj7hxKkPGmlCvQEustPzaP+Y9OtG89NWGksuVxwkqSEOi3PHmWr10kx1m9sCFoOPNL/oPfgHRTIq/VXySk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(54906003)(2616005)(44832011)(1076003)(186003)(86362001)(336012)(36860700001)(82740400003)(45080400002)(316002)(426003)(5660300002)(47076005)(7416002)(8936002)(4326008)(16526019)(81166007)(356005)(8676002)(70206006)(70586007)(110136005)(40480700001)(6666004)(2906002)(41300700001)(26005)(36756003)(966005)(478600001)(7696005)(40460700003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 20:41:01.3339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57219f81-4439-4cc2-af7e-08da9c11988f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUSTeK COMPUTER INC. ROG Flow X13 has a problem with fans upon wakeup from
s2idle. In examining the ASL, functions 3 and 4 are not called in the AMD
codepath but only in the Microsoft codepath.

Add the system to the quirk list to force Microsoft codepath.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2148
Tested-by: short-circuit <davidedp91@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Absorb tag
v2->v3:
 * New patch
---
 drivers/acpi/x86/s2idle.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index c811eeed42cd..eedd21d8a284 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -440,6 +440,17 @@ static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82"),
 		},
 	},
+	{
+		/*
+		 * ASUSTeK COMPUTER INC. ROG Flow X13 GV301RE_GV301RE
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/2148
+		 */
+		.callback = lps0_prefer_microsoft,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Flow X13 GV301"),
+		},
+	},
 	{}
 };
 
-- 
2.34.1

