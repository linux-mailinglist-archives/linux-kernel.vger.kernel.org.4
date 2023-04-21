Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DB16EA9FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjDUMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjDUMGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:06:47 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73A183EC;
        Fri, 21 Apr 2023 05:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8KNBqqJOHkDo/ugKooH/UZotkRhH1ntbluaT5rrNkfd7YPw4b1quelq6iWm6TZQtkWJ5anX/Rk2P7oYFupdjpHcg9UWRsrny9+IDZo1XtTAtbCWdQMNG79sBU5meyEaDwq4XyVgrci4sOQLKsPpTXdVTwVjE8V8xCvbZCDF+7wUXzHI4VfbHJcUVZ2TuOgb/GhSe/u9u2n+vWMRbk5XuOiwin/9SxBDo03o6UeTmk/bv+A9qlvkg7LNs0H3VyvoE54sv982GuK1eqV04hXswnzqb6cuvR4fonWeZH8d+39qcHEEdhMIOVp2jYVh4nF+FowqJZn/ec6nVcoY7gH4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twaIqLuxaA+WZsbIdEdp6pcVaaqm+Te+/f2DZHkQQB0=;
 b=a//gmDjEKchfpB1rJ74Id72XVUUZq0a2K7+WyUtevapREgqDYTqusyo1wTSSTTriB+mVJiefIckK5/bzcRqOAyZOQexRx3FurfoMV22rA7cPoO1Cgii7k6eubBU54mUXWtzb7gLWSmHwDpXa7ZJL6ae5NDPka49OAC6DmDiNLae18S3Uqimk5C2pANCpjqkw0hjmpiiKmo3Z0r3dKgV9zf6xHQz4tGEgJKD79mpqx5VRhaBAid1/tIXDEX6FVvXZv1vkjvJehdjoTL9jQolW3b4zPBJHA8yO8oIfw4TK8Up4opCmBXAtlBe5gN+0dv8KEaFcE0sp8U6MmLDrF5d2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twaIqLuxaA+WZsbIdEdp6pcVaaqm+Te+/f2DZHkQQB0=;
 b=qspE/HgbTKE44/+t5D0orDCd+YQ3BI4zV3sWQffatNARH0pThjPQys5ggu67SdXJxliynUPKOoA1D7pm30lv/2UIKUK1AxZnbnE06M6fx/fy13n68AGO439SSFY4ygYQWF0fT78QhaZVASHS50XqrkiaS/Uc8ikfuLH+k96hVUQ=
Received: from MW4PR03CA0072.namprd03.prod.outlook.com (2603:10b6:303:b6::17)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 12:06:43 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::89) by MW4PR03CA0072.outlook.office365.com
 (2603:10b6:303:b6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Fri, 21 Apr 2023 12:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Fri, 21 Apr 2023 12:06:43 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 07:06:42 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <nakato@nakato.io>, <korneld@chromium.org>, <richard.gong@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] pinctrl: amd: Revert "pinctrl: amd: disable and mask interrupts on probe"
Date:   Fri, 21 Apr 2023 07:06:24 -0500
Message-ID: <20230421120625.3366-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421120625.3366-1-mario.limonciello@amd.com>
References: <20230421120625.3366-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 7859163e-46d0-4a31-9ac7-08db4260df3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNfwxN/sS6FcV3Y2/VZ+s9o+IUe6GMxV8hxmotHmBLN1vdXzhEDmkYf7/THM5NDMrUKtjdVFbw2F+7Lw5VlW7Kyxy8jsLkO4aLR9FDXcHQCGGlPhYEZGubbdOhDOuXNh4ZyLsEHUiHtSCeOjih571fIb/uYQN5Gf22ExeT649AM0+7bB1XzHi460TwZA215jEyS5h8u7gil472jw7Ss56wLTode32TftsWbJRSaZy7fThL6vzNRg3b23eqQuycOqP8Y7yCtzS9scy+uZMo7Sj+OI5xK2kUaZHInES15BIAumIAKLb/nZQ6Lc0rtjuohNCd4izexztgjqgiVPqrB5llwIvefr5LwYD3IALkYmrdIKZ8y/ul+Fryh+hQXthTetwbytZHNGOAEWH8m5CRc5soSYleZwqiAQHqF9/l2bss6AZT74ikJOu88Ne0bv8ZIKTyBIGt7QNT1ofphK5LWHIZqQy0HPHoYCb+A4yG5x560QDAJ/vK8DbNBxKUcH83a4pN603GGQb/G14nL4LebUsdTaEIzzqbLIC1x8+ZB8YKrU2rin2Cr5BXRTHHL7wupueuq7rUcSYXpBx8hIbW2P+13vIGkaP0JQnTAjHdf/iOflKFAhY5LAzB8rizVG7TSsYumZ69d3+CYVZY0gyPOgvWZefRrq6cbatqG3xHRgQc82E+P4cWwmPcE2iKfNfix3fddGqGTNJXGM4N4omVp9NxLUxMgYICQPmQLMBvFDGho=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(36756003)(6636002)(54906003)(83380400001)(478600001)(2616005)(36860700001)(47076005)(7696005)(40480700001)(1076003)(26005)(6666004)(316002)(110136005)(4326008)(186003)(336012)(426003)(70206006)(82740400003)(70586007)(16526019)(44832011)(5660300002)(8936002)(2906002)(8676002)(356005)(40460700003)(81166007)(41300700001)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 12:06:43.1079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7859163e-46d0-4a31-9ac7-08db4260df3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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

commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe")
was well intentioned to mask a firmware issue on a surface laptop, but it
has a few problems:
1. It had a bug in the loop handling for iteration 63 that lead to other
   problems with GPIO0 handling.
2. It disables interrupts that are used internally by the SOC but masked
   by default.
3. It masked a real firmware problem in some chromebooks that should have
   been caught during development but wasn't.

There has been a lot of other development around s2idle; particularly
around handling of the spurious wakeups.  If there is still a problem on
the original reported surface laptop it should be avoided by adding a quirk
to gpiolib-acpi for that system instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 675c9826b78a..e9fef2391b38 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -877,34 +877,6 @@ static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_group_set = amd_pinconf_group_set,
 };
 
-static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
-{
-	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
-	unsigned long flags;
-	u32 pin_reg, mask;
-	int i;
-
-	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3) |
-		BIT(INTERRUPT_MASK_OFF) | BIT(INTERRUPT_ENABLE_OFF) |
-		BIT(WAKE_CNTRL_OFF_S4);
-
-	for (i = 0; i < desc->npins; i++) {
-		int pin = desc->pins[i].number;
-		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
-
-		if (!pd)
-			continue;
-
-		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
-
-		pin_reg = readl(gpio_dev->base + pin * 4);
-		pin_reg &= ~mask;
-		writel(pin_reg, gpio_dev->base + pin * 4);
-
-		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
-	}
-}
-
 #ifdef CONFIG_PM_SLEEP
 static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
 {
@@ -1142,9 +1114,6 @@ static int amd_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio_dev->pctrl);
 	}
 
-	/* Disable and mask interrupts */
-	amd_gpio_irq_init(gpio_dev);
-
 	girq = &gpio_dev->gc.irq;
 	gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
-- 
2.34.1

