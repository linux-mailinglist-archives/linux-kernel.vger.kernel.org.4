Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4667442E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjF3Trz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjF3Trj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:47:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0B819A9;
        Fri, 30 Jun 2023 12:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHgACpnlx46gWrVHOg8PIXQA72o6QmxxpeMUU4CwdPZTUz7GKAg4WCCJEcYQw+aL9uKv7BXE01FwqYwJuWqQPhqXMa92galsQ9hVtGEAd40Z05hsOkx9BpiYAbuVjwyjP6KR7dAXp4KomH8RH23XLRVz6yrC5BFKQGapfW28lVTk8oZ9/4zeA3cNI/k5zdN5CaVDqdEcI/3WVYHsbdslsdIEgBAPwTp3TtvD8vO0qMtle/b4oY/HZvIknWv/qaRneggL6Ru1SIANAqbfHAfE0l5BLoQzWyNDIwzFnn9mHkvKwo+wnY2DgzwmxvzoZSRL1/SLEcDNZjngb8jVneJ5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAxjDBO7x2yNiy0AtnQhx95ahaFwwysXpgsjAHueea4=;
 b=Ou2kgBOJtbSwsB/IywjOrtj0gCVbfEme/Mg0tEaCXKXLOqWJw2RYUoog5g+vhq/26ns5OB3+eD0Nm13HsFzeghDaUUPN36MXLgHgJFqi2ylqXAt84HMVTai1DdnFcCXJCts9YLwAXw6rk7+eWBknoIqw42ATkcWTsg7KGu8FV79Go1Miqi5FNvhV/sPzuRrnprej8JkBUyTv5bTzci8Hof2h9VcUeXNAg/9xDvKMiGSM9hvZ+QIcjQs6wPMJqiecUUy9nxEQzGBVthKOGbZ1EGSTAIFApkedKTUHg+xbTBaJLsKyOfhSDdFTxSOWY9+DbjpMgFbNsKg+IaAWTRC9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAxjDBO7x2yNiy0AtnQhx95ahaFwwysXpgsjAHueea4=;
 b=CV2lqhd1OXZAkdhmW7JrlXLrv7tBerJ/sS5PzrExJNYoN/ded8gdYYCAZ9NElB1fO4hUQUeVND3Awni/2ol1WvXjHAhY0o7ZRLcX9xi40Eebj0JnpJNeMtBhHQfGVy8OIDX6JcSYwoH6wAPYJQzg9GzJC2XMqhvOU1qRKAS56+I=
Received: from SJ0PR13CA0116.namprd13.prod.outlook.com (2603:10b6:a03:2c5::31)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 19:47:35 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c5:cafe::44) by SJ0PR13CA0116.outlook.office365.com
 (2603:10b6:a03:2c5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.10 via Frontend
 Transport; Fri, 30 Jun 2023 19:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Fri, 30 Jun 2023 19:47:35 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 14:47:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <linus.walleij@linaro.org>
CC:     <npliashechnikov@gmail.com>, <nmschulte@gmail.com>,
        <friedrich.vock@gmx.de>, <dridri85@gmail.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/4] pinctrl: amd: Use amd_pinconf_set() for all config options
Date:   Fri, 30 Jun 2023 14:47:16 -0500
Message-ID: <20230630194716.6497-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630194716.6497-1-mario.limonciello@amd.com>
References: <20230630194716.6497-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: f9abc006-b04e-42dc-1683-08db79a2da09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cly2rRW3voOA66ITsk8QXfYfQ18fzJnMWJYEKO1bUYYP2hBmDy/Kzwa9zK2+2sr8aPGgcUC0qplhGTtLShbP4tcUuSX9R6Z/eB9Oxstd+OAheg/bq5MvXCNKGRzXvQpqm39jpqzSn19PmQOPPP2ByBvR9u0sRQK+Nd7K/UgTMMSlZZ1Mg1cptvQAlauU4Ws13cOzNg/Uy/VD+ju+ur87D/TW62jAfNPwb+hrhy5m0adhUvy5vmXCTOaZT2zYBpwcoifN0GhHBqgxqNcUfJfW/egi29MvH/3z0LDdluHCFEtHoV/7vixknt1NwxmRk3be34PkBnn7T0yg44hN3ZyiQ8Vi1dVbZwREl4jaJOydjbHxgokeDZr6SoPHW+LNIamalFubOBG8hNGslBYwAzrfZ4rO83Pj59T8f4djHjAiReQ1mY1Au2FIz/5hPGyfiDlHDlnOzP6iu5zLzhRg+95jmi36l/XHwG1gf9L5hQp69T7pxWD3qFa+D37OKLGs0NXwp4zAPWLD9sOvcjDHPA+GmfuWeQ8XpFAkTybvPYlAAsHkjEBgAd13B3P0MeAMI0hNNiKFuqfBFqPTtERUBA/kf7BuW+8mxtqHWwOtQkGJembpEGPYyY3mQrg7sOvrLf2H50bHq7Lc63g9W0MvMIXw0LP7NZDG4ntSPPQ/1gVmQ9BPw8EWPV8L1iyo/avh/0hvMJz5x30z82ATONErh7v3c9cy4S9ipRt6YcF0TaIxEsboVVexhZXzc3VkMjVqsnL8yeJnyylIvsQao0eSF9SQ9DoBKdKx9iEM79/ZsjACYNU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(36860700001)(47076005)(110136005)(966005)(478600001)(1076003)(7696005)(54906003)(83380400001)(336012)(2616005)(6666004)(26005)(2906002)(16526019)(426003)(86362001)(44832011)(70206006)(41300700001)(36756003)(4326008)(8676002)(356005)(5660300002)(82740400003)(40480700001)(70586007)(40460700003)(81166007)(316002)(8936002)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:47:35.1030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9abc006-b04e-42dc-1683-08db79a2da09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ASUS TUF A16 it is reported that the ITE5570 ACPI device connected to
GPIO 7 is causing an interrupt storm.  This issue doesn't happen on
Windows.

Comparing the GPIO register configuration between Windows and Linux
bit 20 has been configured as a pull up on Windows, but not on Linux.
Checking GPIO declaration from the firmware it is clear it *should* have
been a pull up on Linux as well.

```
                    GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                        "\\_SB.GPIO", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0007
                        }
```

On Linux amd_gpio_set_config() is currently only used for programming
the debounce. Actually the GPIO core calls it with all the arguments
that are supported by a GPIO, pinctrl-amd just responds `-ENOTSUPP`.

To solve this issue expand amd_gpio_set_config() to support the other
arguments amd_pinconf_set() supports, namely `PIN_CONFIG_BIAS_PULL_DOWN`,
`PIN_CONFIG_BIAS_PULL_UP`, and `PIN_CONFIG_DRIVE_STRENGTH`.

Reported-by: Nik P <npliashechnikov@gmail.com>
Reported-by: Nathan Schulte <nmschulte@gmail.com>
Reported-by: Friedrich Vock <friedrich.vock@gmx.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217336
Reported-by: dridri85@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217493
Link: https://lore.kernel.org/linux-input/20230530154058.17594-1-friedrich.vock@gmx.de/
Fixes: 2956b5d94a76b ("pinctrl / gpio: Introduce .set_config() callback for GPIO chips")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index a22e02e2f5d35..76fabf4404a6c 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -852,9 +852,6 @@ static int amd_gpio_set_config(struct gpio_chip *gc, unsigned pin,
 {
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
 
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
-
 	return amd_pinconf_set(gpio_dev->pctrl, pin, &config, 1);
 }
 
-- 
2.34.1

