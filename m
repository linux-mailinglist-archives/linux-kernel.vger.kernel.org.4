Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9158866CFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjAPThk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjAPTh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:37:28 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DC62B615;
        Mon, 16 Jan 2023 11:37:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkbBHN/4d7YBdYm5+fAwC05CrKkQ7YSQYmiqvd7arZKQ+lCqasibJgzA6sdSnnqeIDTKQYniQUofa2Wx1SeMuwxN38PvRMw4NEfEt6wsf6sJ0FqmlUAvI1dT30T6eAM6sEEzMLXDi+fI/r0txRKWYChhfQZNOQhmwmhqjMfNFUhN8nvbTnJ/+9tp4fydJnO59ywMFhJ33kUIcfk2NC86jMnS1ko7wxAECKNE51sZN36fRdKpucKIQ88fDZHDr2wJBxOGWS29h7f9UE8XvPZTz5+eHuQ1j7FWtQL2NTtPFLXw1EAGSzE4Xn7UyyAXUvnFccEGbukTx8OdTXZf7ODJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJtoXOHKcF8fL2WLvw4kfGHsz5e7fJQ7PwqNuG0CfJ0=;
 b=jE4x10a//x7Gew91ydcuy/pmVy/G6Z7PTzz8LarPD5GOylyTed3SvTbwwLnN34E1jgyDbWUcn3Ael2yh02vxJwFpbgprKtpLulnValqvX6wbHDG11jezcWc/feNKwS6ehvM/tEt+AtJxjihMkD2uvrRBX1RJ6PruxJjqPic1RDZh3ZTCe1i8Vx4r3dPRF72IxieL83qDhzoeL3yNFb8Jof9FCn/3SZJlq3mazbNvYsOrhmsKlaVfxNv/YMdihZyy5AqfHu0vhraCOPszfMrMYTywyS2AOYWnKHNHb2viGopWIgFUsXAFBDJGqD9msV9OlgbnLxnj5lWQEwLp0TKYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJtoXOHKcF8fL2WLvw4kfGHsz5e7fJQ7PwqNuG0CfJ0=;
 b=aqBI4j72yuE3b4JQyZsacFKy70k6LCneVa33RTQy575gK7FdwDgG1VQ1LbXmz4zdE0b+7E1YJaWN/DE86YZBgrosOyoI0SIrtecFEbwLrFVz2NZtnhEATPM+OMyd/SuiNrxlXBFdeZRYNU5uWhOUUxKjyPrAc8YjPf1bgrsIK/k=
Received: from BN8PR04CA0004.namprd04.prod.outlook.com (2603:10b6:408:70::17)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Mon, 16 Jan
 2023 19:37:25 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::66) by BN8PR04CA0004.outlook.office365.com
 (2603:10b6:408:70::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 19:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 19:37:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 13:37:24 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     <regressions@lists.linux.dev>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xRU
Date:   Mon, 16 Jan 2023 13:37:02 -0600
Message-ID: <20230116193702.31356-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230116193702.31356-1-mario.limonciello@amd.com>
References: <20230116193702.31356-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: a48c67c1-f8dd-4c48-6c49-08daf7f9186a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjJb4kv3XUrlBBaM/axg00wo/YgwJgirK/EQc3T+8bZHGxp4V9+a+dArDOtMRhpvEUJbuek6t/Npb/vKSBTXLgDnDUVYEV9ZM+nc1K6TldplFbtmY4yUELu8DXmCpRetLl7+utf1hkzK40COrQN1SeOCK/+K8+GUxj2IQh/F6QDQmngcGvFPQhNLTrODAcHVfl1DoqpsEf7U5jQGb7qMcn08fJ84+azBQ59RnjlBvriUrLTlCNQgqbo63q1a8bD4ZuCGMExaB8Ax6opNQ5f3D0pxKSPeohZbx6ULO06yzL89bULe8J34PwiOupqfg4SK6VHvyEA2gaqbVjnQ31WFC5HrTqQhRYuLCOFr7Vaaoq1KR2GSUxJyrhitZfvyZ6/qY69r7c0Mmuk5xIugpd34LRpCM5GUUHj886668KBUuvWYpbv9czex6EaQSa5iET8A+V4H5f3wbvPyP43Zw6gr3Eygpx7Q4lOVwy/wbkDnCpMW1j9ggWZIzqbWPyBNCu1vMrOtzcFQYOAeRxyfjZ511z4WCMZDSLV47tn8v0jxm4zg5/4ixh7IJGxEjIwE35mu/V+zKminRh1+dbOZftlLxU1vHEUjsrNkltqB3ZCvNEWuKQVNA77IYp8Jju//zF429LJ2vvQJXUxYd7cQsAjlwjneM/Au6SL2AHEGqvxgAQoHuO+1YBy1AbX8rcpchMlkjlEx3G+VohjuQJWU+1K2MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(336012)(1076003)(8936002)(2616005)(5660300002)(7696005)(7416002)(82740400003)(426003)(47076005)(356005)(186003)(26005)(86362001)(110136005)(6666004)(54906003)(316002)(82310400005)(478600001)(40480700001)(81166007)(70586007)(8676002)(70206006)(16526019)(40460700003)(4326008)(41300700001)(966005)(36860700001)(83380400001)(2906002)(44832011)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 19:37:25.4110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48c67c1-f8dd-4c48-6c49-08daf7f9186a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
changed the policy such that I2C touchpads may be able to wake up the
system by default if the system is configured as such.

However on Clevo NL5xRU there is a mistake in the ACPI tables that the
TP_ATTN# signal connected to GPIO 9 is configured as ActiveLow and level
triggered but connected to a pull up. As soon as the system suspends the
touchpad loses power and then the system wakes up.

To avoid this problem, introduce a quirk for this model that will prevent
the wakeup capability for being set for GPIO 9.

Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
Reported-by: Werner Sembach <wse@tuxedocomputers.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627
Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpio/gpiolib-acpi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 4287555a12408..9ef0f5641b521 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1623,6 +1623,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@18",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 1.7.8
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "ELAN0415:00@9",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.34.1

