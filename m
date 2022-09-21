Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355A65E54A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIUUlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiIUUlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:41:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE8FA3D22;
        Wed, 21 Sep 2022 13:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCXwzy4KSI3YXZNnTC65rla5xDxD2UEHGXRUfOKkIaj4YuYJ3kKXg8OQtOjCKBHu1FVh7fIzpBFTD0y7Lnv37Ns7Ek8+hxtS5kfLIY5v8q+0i5KSuUou6W3d/1unWcd0yXNw2nR7fA1hS/5BNuSTj9LT/FUtzObXS3lNqsUFx8+TaIhbS5zFfAKXzHaUQsnFlRmBi6T83GwmqYwBfRQObfI+fiZxn21ixsyRhd40BmVUMDJ3aNwF8C6kOf8aq7fPZuII2zD06FNepFfHkdmY9XvOhpzf9WVPCH5peh9mUvww3yX8kR3hTXhUr6v6GWVAXSNBg9tFT6z9Aw53rE90mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUI/OhsC6+aL5T0coZPgXzHZbnSUMWBi1W2PP67AaOE=;
 b=KsDs97ev+HIq0nXWqW7Lgcx8IE8/Hc5PE+FgUybD4+8h+KUANWBNojo+gqdnDsEeKEZcy2LBfyAQHZxH9U3K3vfAMqv1a2YcvLBYynTsWkeiCayI85QJHsLTe5jsoBcZx0Amwrxh5lk8OKpanL0B8QVbLtN+/NuiNzUSHe9v0XC9TrBOiA2jOISts0xkA3cEEDFUGMHbtVYLMQRQ2SFU4XRxoO/WrAM1K7HlLtGukyBub4SZP84UsHZUxv0XGmhu5N3hFk9E5Ae31MvkWQ6Av3Uc5NABRMWZGjQQLWvGYBdOu8RIwE308PCC7Lmcmt9FYyZzGk9fXjTVH0zsobuH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUI/OhsC6+aL5T0coZPgXzHZbnSUMWBi1W2PP67AaOE=;
 b=igcs4TNOwqkR5PfKhu1TTZE0JrvgnCo9wm5X4CUZvouCf1SUPJqZDgbBqHp/AvglbRT2PD9Kn3kXaTnb+fyCWBH8TbBUpz4qvXThB14D7noNU2UxNo45HZTlw/EyviDkGluAhgeygx+SvJr2t2FdsWzLzAh+/wDWpZSqW8GGguI=
Received: from DM6PR07CA0097.namprd07.prod.outlook.com (2603:10b6:5:337::30)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 21 Sep 2022 20:41:01 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::c7) by DM6PR07CA0097.outlook.office365.com
 (2603:10b6:5:337::30) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.5654.11 via Frontend Transport; Wed, 21 Sep 2022 20:41:00 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 15:40:58 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>, <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, <iam@decentr.al>, <hdegoede@redhat.com>,
        <davidedp91@gmail.com>, <marko.cekrlic.26@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v4 6/7] acpi/x86: s2idle: Add a quirk for Lenovo Slim 7 Pro 14ARH7
Date:   Wed, 21 Sep 2022 15:40:53 -0500
Message-ID: <20220921204055.22889-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0f3ab1-62c9-44b5-1492-08da9c119854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tu8hdNNb6LNgIxug75R1S1z0TAbdk/TQ3MWgFfQ0lB2u4RY1CE8cY/guvxk+qFqEgnpcX3r9R6LZZqzmhUxwWH8D1LYXhecr9WWAyvaLzJDZYoZPnGk/6SEtc7LvCtxzN7rI9+AhPYRCTfwKLzFEvyFVL9Ag4i7yg+sQbNFuv7vGrRrqHto+y+tpz9koDnVm3ZdtveP5V4cGT/EwK3HRLmj/2bBRzqtuNyyjh+/5dfYXCY9TXNutF4YUQXfQT3Hz89GFRnPf0JsVGGLuR/SArbUhditMlWNM0te1bacn16TzZwJ+aruYetgCjs3U/HUvWf+R/qmb+IWywF/+q34Zuf3hsd+bDyC6LFNAkXLhui/6PFTnV2NoTpcgGxTAyzu6ST9tOG6+W6ENsNjUXyBrgZgZHCuNtaiROKEWVMMVuyMZN8JJr7SodYqcUOQFizT5pxfS+vMuEi2pvdN4DAYJcizW2u1pB1BLl7LwWuiEnU6CKvEXZNd1zZvXVLEn1VT8ADqLmARM2yd1CMDEvaJQKIdxFdtp0o4HjRJ0Nm2d+hL71HpqxxDoN4IYewiFWTJkGVlzGWx2QKGyNV0YlrSqUqZfOLWxtfV6u0qtkgW6MvQkdTEc1SRUjFM/X+VF+wpuDwr8deDVwoDr5uHbbLyJyqyr3OvIL1oCdXX1hHAdethUe4VH2/b3Ord7ZklHIchLJZnew0bWvQ1Q8P5RrCIaA+w6JrB4azQ4+H9ZBl91i/YwQPW17w8xVTzlsf1YyHBR/UPh0687KdNwuWr3ZfnFg4ma6FrIjEHCeqLk6FNSQhdc157IT9lKqTI786+KjZMcHD0GTr302dxG1MbLr0/xEla42+YtEX622kIRj8yKew/psWot/6MYe3F/rspdBvIS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(186003)(44832011)(336012)(8676002)(1076003)(2616005)(478600001)(81166007)(86362001)(7416002)(356005)(70206006)(70586007)(966005)(36860700001)(40460700003)(7696005)(8936002)(2906002)(82740400003)(45080400002)(82310400005)(40480700001)(26005)(54906003)(316002)(47076005)(16526019)(5660300002)(6666004)(41300700001)(110136005)(4326008)(36756003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 20:41:00.8965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0f3ab1-62c9-44b5-1492-08da9c119854
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
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
v3->v4:
 * Fix URL for one of the bugzilla links
v2->v3:
 * Adjust prefix to cover multiple systems
 * Add another Link tag
v1->v2:
 * New patch
---
 drivers/acpi/x86/s2idle.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2cd381f6c002..c811eeed42cd 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -428,6 +428,18 @@ static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14 GA402"),
 		},
 	},
+	{
+		/*
+		 * Lenovo Yoga Slim 7 Pro X 14ARH7
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216473 : 82V2
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

