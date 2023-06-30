Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0E57442E7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjF3Trr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjF3Trh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:47:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F9D19A9;
        Fri, 30 Jun 2023 12:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuHsKuQ0qhDV1Jdd/k1h5XvTVxYoCQlZq6l8G0S47agKy+eQger5+pi9LbsENE6jRaSJpYm1jG0wgZAxdWcEeyfJfsKZFO/xRDk6DzjwBWIkn4GrlGAdKKKSMSni+NyURHzzM9XM5H8Mu9yC+q++uw7eWoF8+Bbv+mJ8eZ+ore1T9LUwAMf2tkysZQD+gxOdfjNWlA+5vk5RXiUxWGTLH9+cGEzaSSrdNXpzfUgjPbdwDpElCWxXkzaiz4/hAORDkJWSPwxB/biGiLp32p4ext9CpAuZZPJOMles+KeMcbqiWt4ZLV1pEAy+P75mQzpp2/jj0Tj7Nvb0lSp2XSL43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1RlsxEo5Tfy5SSjNbFvpb4yqnUfA+lLTf69KEyNJ+A=;
 b=G4d8F7DY7RAoiOdOMTEv1ur5LkJTUmayojHS7Q91sQ3hoGK500ye9/o0crIY7Ycezmd/0LNW6JeWytUlH+4MWq7xGhIIpz+JGMlbgzMR2oCkd5cg/ij3/F3tf+EX6AhvLRkymn5I3PbcOX2/bGXIsa0OkcdWvHEzNpro40wUcpcchfp4hEs3RkDUHgrB4HjZ5oM7dTu9jSvrQtKNBNiYxyRXS4ew9h8v1i92SgNygKB+FihMo1VkO5NKUSBCJYDBk3L15LLrABfZB3wJ1w1xN22zNiM+Tjk8EpsXS7M2ktpuBqFG8Dv+Ik1Ls6REWUyqzyWv1C4/D/x+3ZYJFVmFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1RlsxEo5Tfy5SSjNbFvpb4yqnUfA+lLTf69KEyNJ+A=;
 b=zfdp4/SVF6xOM7M1ONy55fgt/fkm4SJ1H3wC6LbBmZ10FBAmYF1xd2E2xpF7WsvhOkiZO98gAOSPU5KgXhnqS8hFYS0aD0PLDUp8uDnR87kArZpef4/+nYIF+Z9632Q43MXU917Nc5ZiM1KN0PeZVHMNkfYN/OJT0FMZCX3slcI=
Received: from SJ0PR13CA0107.namprd13.prod.outlook.com (2603:10b6:a03:2c5::22)
 by BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 19:47:34 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c5:cafe::64) by SJ0PR13CA0107.outlook.office365.com
 (2603:10b6:a03:2c5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.10 via Frontend
 Transport; Fri, 30 Jun 2023 19:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Fri, 30 Jun 2023 19:47:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 14:47:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <linus.walleij@linaro.org>
CC:     <npliashechnikov@gmail.com>, <nmschulte@gmail.com>,
        <friedrich.vock@gmx.de>, <dridri85@gmail.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/4] pinctrl: amd: Drop pull up select configuration
Date:   Fri, 30 Jun 2023 14:47:14 -0500
Message-ID: <20230630194716.6497-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630194716.6497-1-mario.limonciello@amd.com>
References: <20230630194716.6497-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|BL1PR12MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: d05a56e7-f258-4d1c-502c-08db79a2d8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOlloJyoUFGEYj4YWtxqF0lIZiH08Xp5Rm2lA+L8WQCVOAGS21et4+3seBTl5UNBrJ/axChbHQcmxUHxRRNn2da0q3Tjs84wieofTWLO9wqOcjpN2yH0Zto9VQ2jsWFqX0dm8JVqtGEOmhLhEemR8wIEYV/kUT3WfkqjbT6S301MlL/dqunXHWzGLeN4Qi/J2mb3ZqNRCdOYzY3iFRVU/Ca4Jh3nfJKVaBn4Z1JC5tpWnAROD0FYuMLDDk0leAMD9TrIOMLt7yzZxnQO+soyFG/sF0L8Q3ELBoKCnY4XXr3WbH6sumkRCqjOWT9mi8JXhFZkyNvDzSShW4kGPpOfWWeSXcUM85NOb8HlFYRcJtcYv8pheh4xd2hWLJjyOYn8W901V0uj3hBH4y2mlzCO2M8S9Qj5H3r+YbDKXyCjXfJ+2v1tVbPUE2uuLec0NFF+AAcJqn4i55zq64/ruANpIe1870bQG7qT3pBvCF225NrzlGY5BgSP0Tn9d7zynEgxIIeIE/MsN7T1ncoYNjTcGpwAiKUTDpdwe7LfspFiPJ2jJyPGxXmaDKJtNZzrV1FrujBv25Nb1VkxR3dzyj7NG/aL7hw6nuht0m7LFIAXBjdXdbizOL3DsAKADE+hiJCD9AZXQd0TqzieLr5165HXdFIJKXu8iSJI4AnV7iTl8ottr9oALdsOvj0lIHphuLM97WY+UoSRSXrYFGQMmyJ1wH3sHKSlKLqV1sSZTpkUUQ/fEKqa2c6j8JKs23wcJmlLU/kKbHKZ81w6EfQaOt7PWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(336012)(426003)(47076005)(40460700003)(83380400001)(2616005)(2906002)(81166007)(356005)(82740400003)(36860700001)(40480700001)(36756003)(8936002)(8676002)(82310400005)(110136005)(5660300002)(86362001)(54906003)(41300700001)(4326008)(70206006)(70586007)(6666004)(316002)(7696005)(478600001)(16526019)(186003)(44832011)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:47:33.1343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05a56e7-f258-4d1c-502c-08db79a2d8da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803
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
index 02d9f9f245707..cd46a5200f9b4 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -221,7 +221,6 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	char *pin_sts;
 	char *interrupt_sts;
 	char *wake_sts;
-	char *pull_up_sel;
 	char *orientation;
 	char debounce_value[40];
 	char *debounce_enable;
@@ -329,14 +328,9 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
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
@@ -763,7 +757,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
-		arg = (pin_reg >> PULL_UP_SEL_OFF) & (BIT(0) | BIT(1));
+		arg = (pin_reg >> PULL_UP_ENABLE_OFF) & BIT(0);
 		break;
 
 	case PIN_CONFIG_DRIVE_STRENGTH:
@@ -810,10 +804,8 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
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

