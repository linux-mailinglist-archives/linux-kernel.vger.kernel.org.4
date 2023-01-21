Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA11676697
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 14:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjAUNsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 08:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAUNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 08:48:07 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF210193C6;
        Sat, 21 Jan 2023 05:48:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev5WuH17j1IFyHD8MFrWHZWhuf/fhdrT49AWAeWLgxI+xnRD5tjuPLnAZ/JgTOjThuGx81OsSWPtuAgVmqvN/HLzVCrNvP2J9wHndkLf1gQj6mrsZyaeusKEt5Qg1mVKcXKOSFm74EsWZ5RTh6C1IN9mim0GL+FtTaWzfFzlJskPa9FQKi6xGASN8quiafWc/l9qUosiv4MjEXHoMcx8TlShBUEioiF/GWdlO+n4lhFcJFbW1FmgDPNQrXSjKpBjzAMGEXMgZLwa3F4ujjy/8o+nILsA8fiCtE95vbElbmLc3lZtMELGlBRUTEPpBXLxbHiThLTOm6M6ZhTs6kXo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRnCveg1irG4fhoslR3hYLzkp/CAtElgDK9PLHL2yqE=;
 b=TLCm6rd9ALJ0TYwEuhph5EwzHL1YBTwbqhKfVmcMhn/iqzpblyoiTsYfUHug7Z3s/lbC3yxS8JEM0R5B/gxUi+6p5dLwIC7b5/42+GfHdZpjRtGYg183sHO21Qno7Wzkj5P2o17p06CnFxIuZN7kVGt9Pu1PefCx6Y1rIt+QSCJHh2DUsUsO/uGJY3tkppyqUcVNlcwzqERzN/k45voGyElZcWU8MlwIyyKjkHz4Cug95fQUKo67S6cdKVWdBE6ikVPtR67m1ENMHPvyHA3Rbdmjs7Iymijeqxbzp0QkA8oXaaMHjxyoyEgU2tkmzq+7rtc7pTk6m9Ri5AGxI0nNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRnCveg1irG4fhoslR3hYLzkp/CAtElgDK9PLHL2yqE=;
 b=Krh5MIdd6p3NHI7NALaD1QzSQnQkjpBUSc11heaY9mKFwlSiFIv2EAEFZIQvVDZJKWtQ/vakO6pbcM04X01PdgIASqgcQpEnLYry9SnEZgrR1ZmBkk9J9KAvFMOx7CZXUJxWuY79Kh45cHme+mgn6NKY3DbmdhdEAxGHg2cxI30=
Received: from MW4PR03CA0318.namprd03.prod.outlook.com (2603:10b6:303:dd::23)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sat, 21 Jan
 2023 13:48:02 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::63) by MW4PR03CA0318.outlook.office365.com
 (2603:10b6:303:dd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28 via Frontend
 Transport; Sat, 21 Jan 2023 13:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Sat, 21 Jan 2023 13:48:01 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 21 Jan
 2023 07:48:00 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Raul E Rangel" <rrangel@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Smythe <ncsmythe@scruboak.org>,
        <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
Date:   Sat, 21 Jan 2023 07:48:11 -0600
Message-ID: <20230121134812.16637-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230121134812.16637-1-mario.limonciello@amd.com>
References: <20230121134812.16637-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db76c4b-c217-4453-7955-08dafbb61d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isafuOfY4TwG/7d6ra8IaHtgs2wWg4TKr6qPQzchWJFSK8c0nsLuN+sS8y4aJmklXGFh2GhV5pTt7wYVQOPYyf5C1bInW0sgdeeyZ9SK2/WUK/V+sJI0+eWlvodMMzXGQAZH8YOFksImyhZBUKhAWxg3gUIK3Upqhxha064exm+Pml9YooXCVFGU3kothFamwmHEaRIT4YVgqNL+td4M3um/TmM9ZIZIVyDoUJVwbUfnIRPi4+a1S3+prkGPa1B/r1O1imCm4PUmJ6qheiTTqfi5PZnMHCKiMZSM/vs/cvltKqK/jegLGfXwPvxy95ewKjO0mqL2ACPPYbJgqGq74iF7o6Fb95qjvGVOSg765oOVd6pXoR4QMvQRh+SdWKob4AGo6ii1P+pShX6xpwmmZeqml+MKNT17LbkgoHCi01cma8qnhQ/saskx0B1e7rAnKVOL7v040CgIB7GsjdU2IfHrwg/SbtBKxTruvtAReRLCuCWgITGEi2BdaXnv6HINFkohva+4IvwoF1MUrObWQJVQq5kvljt8TOqnj4MFK2C2RjLbJZU1HBXUtjnlzKOx6qEydIY4JXMbg6NUELwWMbDjGUE7Q3kQOubOuD/ZNJb1YuhKvvOEVgaYd9vlAVgCfybBF9Zp+2F+7l8j4IT9bqrILFr2rcPEEBqMdGHnq4Z9sML1iP6IIdnGAC3OHIyw7NelKwDtkJuO/C2eKMrBajgt3QCFj1z0QEEABCOQ3ct5dLB6lVDv5xnBZOlQNP2VDhdSQHIFnTIChLkn7+mvBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(44832011)(86362001)(2906002)(40480700001)(70206006)(70586007)(336012)(16526019)(186003)(26005)(41300700001)(426003)(4326008)(8676002)(1076003)(47076005)(2616005)(478600001)(7696005)(40460700003)(966005)(54906003)(110136005)(6666004)(82740400003)(316002)(81166007)(5660300002)(356005)(8936002)(7416002)(83380400001)(36860700001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 13:48:01.4916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db76c4b-c217-4453-7955-08dafbb61d0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
adjusted the policy to enable wakeup by default if the ACPI tables
indicated that a device was wake capable.

It was reported however that this broke suspend on at least two System76
systems in S3 mode and two Lenovo Gen2a systems, but only with S3.
When the machines are set to s2idle, wakeup behaves properly.

Configuring the GPIOs for wakeup with S3 doesn't work properly, so only
set it when the system supports low power idle.

Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
Fixes: b38f2d5d9615c ("i2c: acpi: Use ACPI wake capability bit to set wake_irq")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2357
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2162013
Reported-by: Nathan Smythe <ncsmythe@scruboak.org>
Tested-by: Nathan Smythe <ncsmythe@scruboak.org>
Suggested-by: Raul Rangel <rrangel@chromium.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpio/gpiolib-acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 9ef0f5641b521..17c53f484280f 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1104,7 +1104,8 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, in
 				dev_dbg(&adev->dev, "IRQ %d already in use\n", irq);
 			}
 
-			if (wake_capable)
+			/* avoid suspend issues with GPIOs when systems are using S3 */
+			if (wake_capable && acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
 				*wake_capable = info.wake_capable;
 
 			return irq;
-- 
2.34.1

