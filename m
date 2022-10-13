Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66455FDB61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJMNsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJMNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:47:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FBCE6F5F;
        Thu, 13 Oct 2022 06:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2E1ODONkWum9XOFgPnhCObnUYHU95leJG9w/J8K1j2MT/7DXt4kpbpq2ltBVXiAr11muTi9BmlFMyj9sC7JLZH4Zs/vfvfgZtIOhjfG9Rkee2BDpbeEKI35oO0IlCr7ssVDoTRhWBdWcZgZtY6nZyHULQjYIWD0pQfvVpYygBAiZj6JmO7W7J2NS7OveCVGW5Qo9yIfDhhPjMq1+AkfxyTkAdeHGcs6uDP0ks603toYU1nTvbrObuLRelSJXuFvr6BaMDbvAVla9D3be6i54jGTXAXmlQXo8UCHOtLEN0PBfbMd8jI0PbgntV/XRuyVbOqDDJzox9NNRNTlYqFtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcTSJOCErw05dBb8YoQJXcPpmQ0xqB47IZW1+fQDyrc=;
 b=GPIlyXL0LcVafB4N3TwudOg93iFIAlmx3HydFR2svU1hVJ3WBLQUrhdXNCdGZRhA5Z51uoRxfCXFPoRWldDZs1tG7DOXdwUXJaXGypIGqPcEsOsGVwiNo6iHU0VQYUJvLNcgYYHCXBSttlarUONpjl3qwAcDvCSXwGbF2VRYJOh6hg9uZesShGkZxu28ZXgpEBKWFjRQ/vxWG0cCuYwtQ79Q19p5H1iwXVKNSHkS9F+qwLKFI5v31hyUMeFU8DTlplHuNAdG5CUsczDXLdx4CK4KQ5Z9yOguXd8DzPChFyBxk+DfElSM6irTrvFeKAMGfJt71CDW7WVgTQTrH/Kwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcTSJOCErw05dBb8YoQJXcPpmQ0xqB47IZW1+fQDyrc=;
 b=x0TAAgrUxPdouPotk2gYxQkEnjAgrrYBhffJSTVf+KhY0zDq31KdRjvAnnEtEbH44X8ffNifRZ4gCCsMHSuUJeBtqY8MWe10z4+po70kLcokFndgxiurMvOONqyHkGUnsPkIAuNaAk/GZPDVTIy0MLHje0f7Oy1TJ5jYb+cXC9U=
Received: from BN9PR03CA0424.namprd03.prod.outlook.com (2603:10b6:408:113::9)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 13:47:48 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::78) by BN9PR03CA0424.outlook.office365.com
 (2603:10b6:408:113::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Thu, 13 Oct 2022 13:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 13:47:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 08:47:47 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Mark Pearson <mpearson@lenovo.com>,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] pinctrl: amd: Add dynamic debugging for active GPIOs
Date:   Thu, 13 Oct 2022 08:47:29 -0500
Message-ID: <20221013134729.5592-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221013134729.5592-1-mario.limonciello@amd.com>
References: <20221013134729.5592-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 6080ff0b-8b4d-46dd-69bd-08daad2183fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0BzV2ILwPQ3bIJzPAhVwKJAyIIHho12FGeQ2cI4SQBbBm3eAEVFz+ThBDGRfmpKrICh2BdEuNLr0yQSHb8bF4lwvFZdPd5QAIqBx3+dSc/GCQKxzfPiczaOioCwIrc6djdsd/hPU/3LFzL5+Mh0V+xbCXlkdtGMeTxzHKWpc1eyl4tmFCgO+cQSZcJ7rlZSTpMxg7v/pWy9kXouoaNvUvy87TVhQ7Ayr/uyb185KSNwKIK2RyULdELSo9WQe7ErwcZm9ACFobFGMpVux7vjiWw+jv6Rxi4uVr7J3qaGT9Mtoo70lC5fH6yJEpJSUKFsPBLqOprJ1DrZzawtd8T1LG5XXdh5vHG4IuZO3Wiz6EEYPUJ6NxIp0cu8QFht1UmiQrN+p42V9s+UB0itJPKyCzVBIfguNdh9jeJAArQjjaqk57gq76rhEbKfx6gwPGqRXIgQOtYnG/+QPEF6pZ2jUEF9m6Kspugk/QvfrRYFCzdm3f1maniDzcYD+r28msPQK4RQ/KIEihcSHhEaqCClGQ+R/vnhrEM+sPFeEC2JFAn0/3ugd+ivVQSvIWvN8J3WtYYXNJ5oUe3i0gCEAEXWDArp6inQlGtowKUSNde2m3WnuOXJIarqybkLfR2g+s59vjfakNhLxJaf3ItwTqLD0+Mk+t0BlmzsrpA1RaPTuqsA3aUdVDHBXDgcxIhSRIvKJWDHQ1cTZmx+CbaVNWbypw/50z6mOQDzufqFxDNIjO3jEAbifR8gytwUgtZTnRrFqlSojqDGQs/dRd8AGNW3iakHYJRDznbfDRrHVLyiYekZg+PdIhs8288TDMMErmFH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(47076005)(8936002)(356005)(426003)(5660300002)(186003)(4326008)(8676002)(41300700001)(2616005)(478600001)(44832011)(70206006)(1076003)(6666004)(70586007)(83380400001)(81166007)(336012)(36860700001)(86362001)(36756003)(7696005)(82740400003)(26005)(54906003)(6636002)(16526019)(316002)(110136005)(2906002)(40460700003)(82310400005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:47:48.5695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6080ff0b-8b4d-46dd-69bd-08daad2183fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some laptops have been reported to wake up from s2idle when plugging
in the AC adapter or by closing the lid.  This is a surprising
behavior that is further clarified by commit cb3e7d624c3ff ("PM:
wakeup: Add extra debugging statement for multiple active IRQs").

With that commit in place the following interaction can be seen
when the lid is closed:

[   28.946038] PM: suspend-to-idle
[   28.946083] ACPI: EC: ACPI EC GPE status set
[   28.946101] ACPI: PM: Rearming ACPI SCI for wakeup
[   28.950152] Timekeeping suspended for 3.320 seconds
[   28.950152] PM: Triggering wakeup from IRQ 9
[   28.950152] ACPI: EC: ACPI EC GPE status set
[   28.950152] ACPI: EC: ACPI EC GPE dispatched
[   28.995057] ACPI: EC: ACPI EC work flushed
[   28.995075] ACPI: PM: Rearming ACPI SCI for wakeup
[   28.995131] PM: Triggering wakeup from IRQ 9
[   28.995271] ACPI: EC: ACPI EC GPE status set
[   28.995291] ACPI: EC: ACPI EC GPE dispatched
[   29.098556] ACPI: EC: ACPI EC work flushed
[   29.207020] ACPI: EC: ACPI EC work flushed
[   29.207037] ACPI: PM: Rearming ACPI SCI for wakeup
[   29.211095] Timekeeping suspended for 0.739 seconds
[   29.211095] PM: Triggering wakeup from IRQ 9
[   29.211079] PM: Triggering wakeup from IRQ 7
[   29.211095] ACPI: PM: ACPI non-EC GPE wakeup
[   29.211095] PM: resume from suspend-to-idle

* IRQ9 on this laptop is used for the ACPI SCI.
* IRQ7 on this laptop is used for the GPIO controller.

What has occurred is when the lid was closed the EC woke up the
SoC from it's deepest sleep state and the kernel's s2idle loop
processed all EC events.  When it was finished processing EC events,
it checked for any other reasons to wake (break the s2idle loop).

The IRQ for the GPIO controller was active so the loop broke, and
then this IRQ was processed.  This is not a kernel bug but it is
certainly a surprising behavior, and to better debug it we should
have a dynamic debugging message that we can enact to catch it.

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Use PIN_IRQ_PENDING instead
 * Add Acks
---
 drivers/pinctrl/pinctrl-amd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 4691a33bc374f..82480d9e4819c 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -628,13 +628,15 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
 		/* Each status bit covers four pins */
 		for (i = 0; i < 4; i++) {
 			regval = readl(regs + i);
-			/* caused wake on resume context for shared IRQ */
-			if (irq < 0 && (regval & BIT(WAKE_STS_OFF))) {
+
+			if (regval & PIN_IRQ_PENDING)
 				dev_dbg(&gpio_dev->pdev->dev,
-					"Waking due to GPIO %d: 0x%x",
+					"GPIO %d is active: 0x%x",
 					irqnr + i, regval);
+
+			/* caused wake on resume context for shared IRQ */
+			if (irq < 0 && (regval & BIT(WAKE_STS_OFF)))
 				return true;
-			}
 
 			if (!(regval & PIN_IRQ_PENDING) ||
 			    !(regval & BIT(INTERRUPT_MASK_OFF)))
-- 
2.34.1

