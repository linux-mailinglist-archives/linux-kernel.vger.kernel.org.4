Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C6570CA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjEVUBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbjEVUBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:01:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFF395;
        Mon, 22 May 2023 13:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk6WZv9LIYPGgS+0OwVaFWJMchFmPCfNwZB7XpjwTDcrL4M5CLKQO4VoOEdnNu72GSOomd50KydtgvgIXwIu571xH20BySW164Vs9ewIOCBpomDl+/GzMCtJp2mcyYBctwX26DXR9ZZZnTKT/YVjNMIfZEH02JVZoYfc29uKW00ViHjHoQpIYxSXS7z+O/jRjEj/wt+hAZ89kyryjQROsLTTHjOPdbPpLxnt03UT+3Ry0ay+JWIWaJSSI2DEh7Cq+4gZkWUkGZwRZn7FMeWE4Vsh6kQ0jw/kt/cIdVk7l4eH2U68t1b48CDiGB99qfHmOkIfGNleVEGMV/W+OB2irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCtaCSh2xp3TLU3Jn9duTu+a0ilJ5rZJIXMRb1Vd+cU=;
 b=NmIPPzA7qtQx72aW/P3xWHneVpwbUpAE7G2eesbJ0YRETwCOOSlGnaer8M+WutQTgpjDicJX53c4LnfGjxDfs5jfgvQucclbLfoIw1ga5MMrdK20Q0Zs2ezJFWtq4lt+79tNbnOa74YdUlR6ArgCLHE0qxS/11a/Go+rSHwo5SO/SHXU4s9crtj2az/P6YEKp7gzNYiPvNK10ZC40NaJwp6IvMxpgIPBkLqUtNqAJ+9gsqm8yABXlIoBffsplWZzRgOZH3rfTqEFcTEfunK5bAOet3CPRzw2bLLfNvPh9mKawyqyoLtfE9j84RfsnwB4VKgA9wp8Z7c5okXrseVIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCtaCSh2xp3TLU3Jn9duTu+a0ilJ5rZJIXMRb1Vd+cU=;
 b=x1Z/0bpd613FKOAKUlDC6vMKpwNeQ4/BsbO86g7TVP6nmx5PFbD83NtAPllV/rsKtUzYMUBoAlD7Wz0dTddlLNE49hE0BDfyAG8LnoOySCkDa1Qg9B6/1/5cqkkQgtxZ37f2OJ3bdOtUN6ZA146cwtUCmced2kdstrg79sEgSAs=
Received: from MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 20:01:09 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::24) by MW4PR03CA0161.outlook.office365.com
 (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Mon, 22 May 2023 20:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 20:01:09 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 15:01:07 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 3/4] pinctrl: amd: Use pm_pr_dbg to show debugging messages
Date:   Mon, 22 May 2023 15:00:32 -0500
Message-ID: <20230522200033.2605-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522200033.2605-1-mario.limonciello@amd.com>
References: <20230522200033.2605-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: ad48489a-6384-48c9-4743-08db5aff492b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/xyU/nz6B7ExV/3YpVEPhY9nbkSRlzndF6/4+SmPe35DfZWlaLU1xzMo2Wl811KuZJAc7Ju5kMlTZXEk7zERuADtQxq4bIir9f1dBKRbb+t1IjYnOfZd5fHL+3pu5EtNG7FU1mgpdhUmsi+VMGoBUcueJeD7TkCmtsh/sX/gRhVLHp6K9u6fjI6BiOnaeuLbH8HVAsZuBxQuyie2vdaImqyZox3jKWDcCjGJ9f4AZFIxcislqK9AM5Q4mhLOhcz3sKphJN+3a8npBYmfnTmfm9kwSQ1ld+ehgO0DUqJc1a6AUSV8gOmx5TSdNmxVwT+RXa1ZJNQ8EmD/5pTEF5/Mm3wuctzg5I8TwjZo7AoICkVtMf8xrCRhkYM96eqB78ju9pudnepzXpMplkojTpXBWPoEpNE4VNE66WIQkzhCsj81HUfSU9I0R6A5FcquO8xRqL3doH0Q6u1YVQZH039ekSWErFC3gv8oYyzT4c2pLoJuUyB2hsN51OWyPbZrAC6I07rU0KT9YpsN1zlkkgFx950G4TfrC4N/sAhMlqUs0NRX8PhzaQI9C3lw1YHFUO75QSCD1Wy2h4xLntHvnFKGR7cJfTGBCNUvQWsczEsoR8iBKARxBx2C6v/Y+QRPrP5xworoA5RM/kMWUnlsOyg6UIzc1PDEtZMNIvNwr6Y47WOEQwHAT6PTZtXX2jlOTdigCpeI47+DxyKS0thQf0qT9yI30Sfmkl7S2fVKXrCo+EyT+ZhPsSWn+OZEAd67y9rBIfUcx1j4ZbifEj8heuYXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(186003)(82740400003)(26005)(1076003)(44832011)(81166007)(16526019)(8676002)(8936002)(47076005)(2616005)(2906002)(356005)(426003)(336012)(15650500001)(40480700001)(40460700003)(6666004)(7696005)(83380400001)(4326008)(316002)(70586007)(70206006)(86362001)(478600001)(82310400005)(36756003)(110136005)(54906003)(41300700001)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 20:01:09.2228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad48489a-6384-48c9-4743-08db5aff492b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the GPIO tracking around suspend easier for end users to
use, link it with pm_debug_messages.  This will make discovering
sources of spurious GPIOs around suspend easier.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index f279b360c20d..43d3530bab48 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -30,6 +30,7 @@
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
+#include <linux/suspend.h>
 
 #include "core.h"
 #include "pinctrl-utils.h"
@@ -636,9 +637,8 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
 			regval = readl(regs + i);
 
 			if (regval & PIN_IRQ_PENDING)
-				dev_dbg(&gpio_dev->pdev->dev,
-					"GPIO %d is active: 0x%x",
-					irqnr + i, regval);
+				pm_pr_dbg("GPIO %d is active: 0x%x",
+					  irqnr + i, regval);
 
 			/* caused wake on resume context for shared IRQ */
 			if (irq < 0 && (regval & BIT(WAKE_STS_OFF)))
-- 
2.34.1

