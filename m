Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869E47484FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjGENbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjGENax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:30:53 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD81985;
        Wed,  5 Jul 2023 06:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alRYeJNEUybKLs5vcQBAmLSGp6uY7BFBVHBRghko0KiS/gsi7r90syup2OiH6APfQK9Bg0ADkl3wxUYocgzaDDJfK3S8kJytE4k5+2rgY7XcvVtkzIWzi1Swt03tVTmNBqf7ru9kgppcw2WPqhIdLKwSw00MYhayJDr1QX7UGBhvoAZVaoLHGAvwyalYhL1oEHkjNJtyr1MQsWL8I9nG9j7gIk+tR7MRcHW61DazWmXV3ziP396KATE4s3T+WFmhIPZhkBlJ1U8RuN9krVTIgOnGqdQGP/PYq6bEQt8aVrLZH425W5EwY7kCKxbk/AbOb+AWBKMEHtvlLm32rGsExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxmXIQl+Hyti15fSgdz0TOX+gm2McdUis9ZJa7BjXkE=;
 b=QmMUrL4tfsX6iuwXpJzTs6vjkFNBDhHN9iM4GeMPMelEQ/0jL6A09GI5kyrcideONyaGQ+W0cXHfZ9Bs//H2A0iZdpUaAbrMIOLYtkokWeumvFJyGbUxcfvAqahWks6DKDTdvA/WijpTMJ5rkw/SrMSt9F6UGuCvVHsw3xJ9KkXZs5co5AGNOk8u3e0QT96tNxsNnkTK32ClUKnMqEmlzECDpDyIan8qVToxHl+ZC4/FcO1nLxC8adftB5YYA/U1sE9ab4TfFQmJeaAKFzt1db7tXkAj4hhqWL10ctP3/LRWeFjx2nehMDZlqP6j75oj/YVuB5l59FrLFEq2J8/9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxmXIQl+Hyti15fSgdz0TOX+gm2McdUis9ZJa7BjXkE=;
 b=SUse1jaDUP7hBGiNXKqFC5ewVYSTrrbmFH7yefyizlLgpjsS1biP0Q8/TA23e4ZGDmiEYXT5hWTjJyvKg+Ha+Xy2lke6ImTq++1uKKdtgiCt9Gk1RrK9T7uOSeIqK4zuS2TrpUOU5qfty5fcegXWDPzMt32DYQo2Vzn218isYU0=
Received: from BYAPR07CA0066.namprd07.prod.outlook.com (2603:10b6:a03:60::43)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:30:31 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::94) by BYAPR07CA0066.outlook.office365.com
 (2603:10b6:a03:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 13:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Wed, 5 Jul 2023 13:30:30 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 08:30:29 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <linus.walleij@linaro.org>
CC:     <andriy.shevchenko@linux.intel.com>, <npliashechnikov@gmail.com>,
        <nmschulte@gmail.com>, <friedrich.vock@gmx.de>,
        <dridri85@gmail.com>, "Hans de Goede" <hdegoede@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list" <linux-gpio@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/4] pinctrl: amd: Use amd_pinconf_set() for all config options
Date:   Wed, 5 Jul 2023 08:30:03 -0500
Message-ID: <20230705133005.577-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705133005.577-1-mario.limonciello@amd.com>
References: <20230705133005.577-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: ddaa4341-0c21-41cf-a729-08db7d5c00a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0b6lv2TUylVfI0xTcGaSfTv3GQclNf6cYCYmZrOa8I2Dib0lgaQh/h9+ldc1m4C3idaz+nzswBzbAEoMyckeH9gFFZAQWuR7JymRu91R/PxxYMs9GwBMC4dYkRPMaUWtEdcHPVSgru7DoYJAeBR3dxUM+rl3HIgFSw5N2hWSSvPwKnMPJLJJ3JuS37s9E4KEj5xzDouNa+s07Js0GbWpplr0H2PFQ1TZF4rt4pbHoFE/JAluknDcl7hoDAtY1sd3pj+GlCYp7kjGhij0e3LVCCu6SNkXrzt5Ts8xQM7sU72xBfKXUefrJ2oA+b+CnqZJLecdqZBYquBqLLJjnuF2JpiJtcnPGdHebYRcjVL0jpFUUKNV+NTvojLspw5la2Hr9Fh8v6FkSdRx/QUfHeBgfziqEzMfbEadZhja7ZtQGp2X39iA1qSH86Fu3in9SGTDlNDsd4pvvb+6GgZ1qz63mlrxHwIIz+/Ng5DwWS0UeuOjgfzrVILt3uKLV3dFuLzaHAVEo3mX74OOUWgqkwGCHxsW2zNofpCxVRVa+M6IxEy00FlQSY7eZYNBk8qS7HjJE8xOUnTDdRNyAmB0QQOS8iEhbyAF6fSGHWDhuKeZ4ExDmIGG7F9IDfu3kduAY2pkpRB+bQp6nXqoFONPJ7OoqarSRwmNUyRbE1VbO1CHLRyJk3RWnnGBRmu4iY6K6yIyZEz8tZrKnvv43CV1fvrJXJSQ9wZztH9Mo6gVK192iz6KMinjdl6pg1D2OHmgtMTl7elh2nchjqWm8gBYKusEJeBGaDhwYwFpmSMET3YSYQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(6666004)(7696005)(70206006)(110136005)(54906003)(70586007)(186003)(1076003)(26005)(16526019)(336012)(966005)(2906002)(82310400005)(41300700001)(4326008)(316002)(44832011)(5660300002)(8936002)(8676002)(81166007)(356005)(40460700003)(82740400003)(86362001)(36756003)(47076005)(36860700001)(83380400001)(2616005)(426003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:30:30.3824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaa4341-0c21-41cf-a729-08db7d5c00a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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
	 "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
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
Fixes: 2956b5d94a76 ("pinctrl / gpio: Introduce .set_config() callback for GPIO chips")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Adjust commit message alignment
 * Move earlier in the series
---
 drivers/pinctrl/pinctrl-amd.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 02d9f9f245707..eeaf80fdc13a2 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -188,18 +188,6 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 	return ret;
 }
 
-static int amd_gpio_set_config(struct gpio_chip *gc, unsigned offset,
-			       unsigned long config)
-{
-	u32 debounce;
-
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
-
-	debounce = pinconf_to_config_argument(config);
-	return amd_gpio_set_debounce(gc, offset, debounce);
-}
-
 #ifdef CONFIG_DEBUG_FS
 static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 {
@@ -782,7 +770,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 }
 
 static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-				unsigned long *configs, unsigned num_configs)
+			   unsigned long *configs, unsigned int num_configs)
 {
 	int i;
 	u32 arg;
@@ -872,6 +860,20 @@ static int amd_pinconf_group_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int amd_gpio_set_config(struct gpio_chip *gc, unsigned int pin,
+			       unsigned long config)
+{
+	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
+
+	if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
+		u32 debounce = pinconf_to_config_argument(config);
+
+		return amd_gpio_set_debounce(gc, pin, debounce);
+	}
+
+	return amd_pinconf_set(gpio_dev->pctrl, pin, &config, 1);
+}
+
 static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_get		= amd_pinconf_get,
 	.pin_config_set		= amd_pinconf_set,
-- 
2.34.1

