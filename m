Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8037484FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjGENbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjGENax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:30:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9B2198A;
        Wed,  5 Jul 2023 06:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfKn0JlXhRYpJfkWP//6TZZXSFKAEGE/+C5LpfllRvfWmlhkf1rLvvcHGk/M7t5zVLvMVxIkZAmfB795i5FiXJUDlLCbzpf06ypVy32qKBgDI7yiUuO8KEFvig/1P7rUndS0czrmEGDDOi6JR9+0e0tV0GnBYScAAn1UCCh6mgIwYRGIbOkM1++b/jjbSTJJf2prw/OH+CXMfsI7Yt5mgKZXnqUw6EOWUYxWn9TfCP6nX08RdrlMtJnhsk7Xlcjk/Co1m9BTYBpFf7kF5h4p/BXr0EiPyannacVazvOzrZpcixH2wg/AWcXLqeEwfqdsB1mYBYuf1oj4agWJB9sGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAj/wHolyK1cuAkHYoHzg9mdmUNdlC8onwLZ6fe1W6Q=;
 b=Jqfxi2faJaFEZmE1gNoaZe1Y7NhXrWSnKwQUZL2G8ZbDh+kyia1OK+EcFRwsrWW+teItaxNKIElqNcePGd1O7hfFNyU60kt6Hl7oEvinII219sIs/bE7dl1oPj6Z2okp4lCFwJZEnfWiKOiRXAK/N9mSzVsM9PHcsy0kkyNEOlpCc6E4qgL5Nbb6qp3Wy603dteCONPejbu7T6B+yS+F90vrmYF5WhowMB69q3KQWH4QGNGsTzxRJinGR02H0pVLJuC49pU+wfrhJduIOhoybxj4hRwNWE0WF/5Oxq4x1h+uxJ8K1sFlaqOwSLaPWK3yNnTKyJ54q21txHsbVyeRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAj/wHolyK1cuAkHYoHzg9mdmUNdlC8onwLZ6fe1W6Q=;
 b=wLVc+7XraeQgWmWqKcDZgVu8G0IBm+9j4YL9eUY2RHxbeLBYbOVUW0JjgUopm+lnSuVjng4wPx+tIjPFoKaTR5XCEqICwAsfXSR8jiXQimv+MyQ2lPH88vuqlTB7r48OlxsIx949+lXmVlpQnUG53N4ndJ2aHa9raYvZbSRjvYU=
Received: from BYAPR07CA0049.namprd07.prod.outlook.com (2603:10b6:a03:60::26)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 13:30:32 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::16) by BYAPR07CA0049.outlook.office365.com
 (2603:10b6:a03:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 13:30:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Wed, 5 Jul 2023 13:30:31 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 08:30:30 -0500
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
Subject: [PATCH v2 3/4] pinctrl: amd: Drop pull up select configuration
Date:   Wed, 5 Jul 2023 08:30:04 -0500
Message-ID: <20230705133005.577-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705133005.577-1-mario.limonciello@amd.com>
References: <20230705133005.577-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab1010b-7ed9-411a-9f4b-08db7d5c015a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFyd+fAFpRMbaOM7ffeE1EvqRn/bVGi0JJ8Z++/EQJySwWZf7Z5ewtIY+/dLaxZHzOdU2z/PF8GhHLnkG5xd/4MYO8O05Ea2dO1ficWXUDIjIG2v0ROVI3zRSF17C50n+X/2mlfBxWO2kNaTi5rH42btQmLw2wmOLRw4+yJ4eaR19wl6qowlZdPN4uQuYa6e0QmOB5lqeapoyi/OYUvntkPyQ6s2lH0kTlCNg5AhKXg/S4AJP5gotH+Rv/1WYXXcUJ8htxZioZA4ipDvOW3Bezb59yaD0xAj37kmS+PXk/TG2zJSWQQWtXjwXISee1/6FtfJ+9pBB9EONYq82LMJ2NKgXUyr94KSj/Px+/363F5PnTFVIeFT7E0/9WYw/s8z9iNFhwuid/LfDY8R/+uYdpJjuXyZK+rtoLloF4vkLB6jqHts2ItrTSZLPttEiuO89uANjm5R5iGNT4Vo8yzNyc35zhBrOmGa98mJcAS+7l4h6gkO32tw61a8kYFiDLLN5D9P08WikDETpwvdwRhIWa8wvmQKBzktQWTs8oIBWBCygRDojtttRulQB+8c0ErRHf6D3mHFPuOFcD06jRAwNaJxKYQ8vj3s+0h0l9ERVwZch6GbqKTpnCAl07L8BGXrzb8lvbZ9gB0YQa+iCMbbA3a1SkVVEorKCZidXn8YGACPg5NUkydmWPitUu3FjIsrkKy7ZsFil39szYsjgzhPyDcYsskX1TysCZipz7toIaCq9ARy7sjbg6tlWHhrXoDG/pm0tyi/QuGQIcAbTggkHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(47076005)(186003)(426003)(336012)(478600001)(16526019)(1076003)(26005)(86362001)(82740400003)(2616005)(6666004)(110136005)(36860700001)(70586007)(70206006)(316002)(356005)(83380400001)(4326008)(81166007)(54906003)(7696005)(5660300002)(41300700001)(44832011)(2906002)(40460700003)(36756003)(8676002)(40480700001)(82310400005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:30:31.5458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab1010b-7ed9-411a-9f4b-08db7d5c015a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

pinctrl-amd currently tries to program bit 19 of all GPIOs to select
either a 4kΩ or 8hΩ pull up, but this isn't what bit 19 does.  Bit
19 is marked as reserved, even in the latest platforms documentation.

Drop this programming functionality.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 16 ++++------------
 drivers/pinctrl/pinctrl-amd.h |  1 -
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index eeaf80fdc13a2..44d3193a81f2a 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -209,7 +209,6 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	char *pin_sts;
 	char *interrupt_sts;
 	char *wake_sts;
-	char *pull_up_sel;
 	char *orientation;
 	char debounce_value[40];
 	char *debounce_enable;
@@ -317,14 +316,9 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 			seq_printf(s, "   %s|", wake_sts);
 
 			if (pin_reg & BIT(PULL_UP_ENABLE_OFF)) {
-				if (pin_reg & BIT(PULL_UP_SEL_OFF))
-					pull_up_sel = "8k";
-				else
-					pull_up_sel = "4k";
-				seq_printf(s, "%s ↑|",
-					   pull_up_sel);
+				seq_puts(s, "  ↑ |");
 			} else if (pin_reg & BIT(PULL_DOWN_ENABLE_OFF)) {
-				seq_puts(s, "   ↓|");
+				seq_puts(s, "  ↓ |");
 			} else  {
 				seq_puts(s, "    |");
 			}
@@ -751,7 +745,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
-		arg = (pin_reg >> PULL_UP_SEL_OFF) & (BIT(0) | BIT(1));
+		arg = (pin_reg >> PULL_UP_ENABLE_OFF) & BIT(0);
 		break;
 
 	case PIN_CONFIG_DRIVE_STRENGTH:
@@ -798,10 +792,8 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_BIAS_PULL_UP:
-			pin_reg &= ~BIT(PULL_UP_SEL_OFF);
-			pin_reg |= (arg & BIT(0)) << PULL_UP_SEL_OFF;
 			pin_reg &= ~BIT(PULL_UP_ENABLE_OFF);
-			pin_reg |= ((arg>>1) & BIT(0)) << PULL_UP_ENABLE_OFF;
+			pin_reg |= (arg & BIT(0)) << PULL_UP_ENABLE_OFF;
 			break;
 
 		case PIN_CONFIG_DRIVE_STRENGTH:
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 1cf2d06bbd8c4..34c5c3e71fb26 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -36,7 +36,6 @@
 #define WAKE_CNTRL_OFF_S4               15
 #define PIN_STS_OFF			16
 #define DRV_STRENGTH_SEL_OFF		17
-#define PULL_UP_SEL_OFF			19
 #define PULL_UP_ENABLE_OFF		20
 #define PULL_DOWN_ENABLE_OFF		21
 #define OUTPUT_VALUE_OFF		22
-- 
2.34.1

