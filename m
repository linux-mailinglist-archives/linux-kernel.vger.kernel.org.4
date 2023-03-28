Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5229D6CC98A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjC1Rne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjC1Rn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:43:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA0EF82;
        Tue, 28 Mar 2023 10:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIKB5tdcsFIwU8+VBbSXuvBnZ3KpuaYA4ukPVw1OQpXQ6N6d+oMmvr8dqcM4uRmx99mrl2NB/kF0CkvmGNMVU6c9rwQZhHU+kioF2Co7DdsGRyCYgIA5om9Zjs3Mv6Yut0E2PViLNNg3eyAbMKUpasEn0k0FzQU9DJGMll3X8f8TyxXX5bizTDYRqt8dnr1f3XOFu+6W3uqaBSN4khA3ZXnMUlSId32z8isGGLFF3fUs+r4TpDOO2M8rBbmN9CZe5ziFJcoqoYW8B1yvvhkl9NMexN10nDjm7HnkwrvnYxp5Xet3yqa9QR6ofuktfrXSK8+QVp2PT2MVshl8qOzxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSuoLr/9O/R09usuVCbLBPYgQ9ZvhGbin8jKbizBPpQ=;
 b=AdabLB7vXL6FENes0eHmkWepDDM5Yc8+y18sJf7IXMFmfx9j2lUiU7Eq6lvkI3Y5pMZjcI03xKbkWF+h0Fjb4KN4KB97vhcp2WJy2+l+WGWGApjcV0tv8fCnhYsl517VoGt+OXPUFjqXsd72gJxnulEyf03OWwSbg+Olmi6EvzdZkb+FfBy3bwcKW5otIlCtooW0Ul9+Se3eneJn68hqL4IvSqBRt81OvASc2TGacLfBpJW1lwAMInRpU7dx4xnKyyyxDPTdh5kaiERJCtig5Fp8NGSrz5uTe/PFOtEBvcpCOKFpmuvgDoPZ0FnJKXvC+Lbm4lI0kxrLqsX3O7oLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSuoLr/9O/R09usuVCbLBPYgQ9ZvhGbin8jKbizBPpQ=;
 b=gH7X1/6rrzD6/zN28P8IuzhGq4kK4t/PuyMz+4PlQWtNdylHQ1Q4q+Gw2x0D/cfZIrfLHfhgyGI+uLoa9/HDcI45wRwY81oM6YnZN95C7kX9PkH55k/U7iIk7lDg+hpw5o6vpDaeK1UzipP6Ozaqsw2IgZIgA9lE9v8gxZNTAfg=
Received: from MW4PR03CA0300.namprd03.prod.outlook.com (2603:10b6:303:b5::35)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 17:43:11 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d1) by MW4PR03CA0300.outlook.office365.com
 (2603:10b6:303:b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 17:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Tue, 28 Mar 2023 17:43:10 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 12:43:03 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] pinctrl: amd: Adjust debugfs output
Date:   Tue, 28 Mar 2023 12:42:30 -0500
Message-ID: <20230328174231.8924-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328174231.8924-1-mario.limonciello@amd.com>
References: <20230328174231.8924-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT010:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bd8834-44a2-4d38-240a-08db2fb3e5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuLVap3kywE5bY9nApqI+4lyFTXPtIiBtdz0dT54WxAGGhfLFx0wRNyVSDX5nIfKBwUe9JIy4GBB9OzQHhFDii7FThp3CqTRhpMWQz59s7w6fJ43zl7GMs26ml1OEVCLDusq1/NJ8PrlHkmxftCDuzu6OSFnYlBxwWR+BdvWkxiwOa6W0VYgQOSgXXXY1vErsqo4M/k0TrTsOz3go0l0rz5/oJ0x9uq3Xz4q9Z66rjfuMMJYzwKh72P8QquaZLmvVJMmabUDzVaL+UDCQmVD9IHUdTXCeL3/c5Va08Vx6dbGH47Nr8h9cDPVlYEsuBjaRFfyVXClh66Pfa8IgQYLs4WN3ZRENpVU9Yed9SOFXj0jK07hjuiia7PWf49tNcmjo+lEtmEBzhEjmmMHEdt5vYKKGktMfiwjjR/CYh0V969cb0TZeQ8cJqMSCjIp8/OuELTvpw6DP7ktB2RQZFgdpqdIfUH2km/rKh3val+efQWjUUU1ESHEvPTXPC5xIcIxbbPCtRo09SyZ/Uke2sFhxsSIM8b1RzlGedlpt9fGc6fg0X9cr1VrdqYjkYj39N3aO032u1l6a/BuL3FiWl6pyiagOZ/4n+fF0d/xQrn29pjBgo7slk3RRTbLSPXiJ1iRoA+HXFw9BFuxT7/ALk2mQrM6i/FHZHjvLMEA20F8VJOELLcOax0ClNBdlE4KDA2elzBDunLmVjJ1yzxgMgSj7P5dWS/S2fbdpFH4/t8If2A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(44832011)(82310400005)(83380400001)(47076005)(16526019)(4326008)(186003)(426003)(336012)(2616005)(26005)(36860700001)(81166007)(70206006)(82740400003)(356005)(86362001)(41300700001)(70586007)(8676002)(40480700001)(1076003)(6666004)(316002)(110136005)(7696005)(36756003)(40460700003)(478600001)(54906003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 17:43:10.4604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bd8834-44a2-4d38-240a-08db2fb3e5ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More fields are to be added, so to keep the display from being
too busy, adjust it.

1) Add a header to all columns
2) Except for interrupt, when fields have no data show empty
3) Remove otherwise blank whitespace

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 76 ++++++++++++++---------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 9236a132c7ba..822f29440f15 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -206,15 +206,12 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 
 	char *level_trig;
 	char *active_level;
-	char *interrupt_enable;
 	char *interrupt_mask;
 	char *wake_cntrl0;
 	char *wake_cntrl1;
 	char *wake_cntrl2;
 	char *pin_sts;
 	char *pull_up_sel;
-	char *pull_up_enable;
-	char *pull_down_enable;
 	char *orientation;
 	char debounce_value[40];
 	char *debounce_enable;
@@ -246,6 +243,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 			continue;
 		}
 		seq_printf(s, "GPIO bank%d\n", bank);
+		seq_puts(s, "gpio\tint|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient|       debounce|reg\n");
 		for (; i < pin_num; i++) {
 			seq_printf(s, "#%d\t", i);
 			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
@@ -255,7 +253,6 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 			if (pin_reg & BIT(INTERRUPT_ENABLE_OFF)) {
 				u8 level = (pin_reg >> ACTIVE_LEVEL_OFF) &
 						ACTIVE_LEVEL_MASK;
-				interrupt_enable = "+";
 
 				if (level == ACTIVE_LEVEL_HIGH)
 					active_level = "↑";
@@ -272,65 +269,54 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 				else
 					level_trig = " edge";
 
-			} else {
-				interrupt_enable = "∅";
-				active_level = "∅";
-				level_trig = "    ∅";
-			}
+				if (pin_reg & BIT(INTERRUPT_MASK_OFF))
+					interrupt_mask = "😛";
+				else
+					interrupt_mask = "😷";
 
-			if (pin_reg & BIT(INTERRUPT_MASK_OFF))
-				interrupt_mask = "😛";
-			else
-				interrupt_mask = "😷";
-			seq_printf(s, "int %s (%s)| active-%s| %s-⚡| ",
-				   interrupt_enable,
+				seq_printf(s, "%s|     %s|  %s|",
 				   interrupt_mask,
 				   active_level,
 				   level_trig);
+			} else
+				seq_puts(s, "  ∅|      |       |");
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S0I3))
 				wake_cntrl0 = "⏰";
 			else
-				wake_cntrl0 = " ∅";
-			seq_printf(s, "S0i3 %s| ", wake_cntrl0);
+				wake_cntrl0 = "  ";
+			seq_printf(s, "  %s| ", wake_cntrl0);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S3))
 				wake_cntrl1 = "⏰";
 			else
-				wake_cntrl1 = " ∅";
-			seq_printf(s, "S3 %s| ", wake_cntrl1);
+				wake_cntrl1 = "  ";
+			seq_printf(s, "%s|", wake_cntrl1);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S4))
 				wake_cntrl2 = "⏰";
 			else
-				wake_cntrl2 = " ∅";
-			seq_printf(s, "S4/S5 %s| ", wake_cntrl2);
+				wake_cntrl2 = "  ";
+			seq_printf(s, "   %s|", wake_cntrl2);
 
 			if (pin_reg & BIT(WAKECNTRL_Z_OFF))
 				wake_cntrlz = "⏰";
 			else
-				wake_cntrlz = " ∅";
-			seq_printf(s, "Z %s| ", wake_cntrlz);
+				wake_cntrlz = "  ";
+			seq_printf(s, "%s|", wake_cntrlz);
 
 			if (pin_reg & BIT(PULL_UP_ENABLE_OFF)) {
-				pull_up_enable = "+";
 				if (pin_reg & BIT(PULL_UP_SEL_OFF))
 					pull_up_sel = "8k";
 				else
 					pull_up_sel = "4k";
-			} else {
-				pull_up_enable = "∅";
-				pull_up_sel = "  ";
+				seq_printf(s, "%s ↑|",
+					   pull_up_sel);
+			} else if (pin_reg & BIT(PULL_DOWN_ENABLE_OFF)) {
+				seq_puts(s, "   ↓|");
+			} else  {
+				seq_puts(s, "    |");
 			}
-			seq_printf(s, "pull-↑ %s (%s)| ",
-				   pull_up_enable,
-				   pull_up_sel);
-
-			if (pin_reg & BIT(PULL_DOWN_ENABLE_OFF))
-				pull_down_enable = "+";
-			else
-				pull_down_enable = "∅";
-			seq_printf(s, "pull-↓ %s| ", pull_down_enable);
 
 			if (pin_reg & BIT(OUTPUT_ENABLE_OFF)) {
 				pin_sts = "output";
@@ -345,7 +331,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 				else
 					orientation = "↓";
 			}
-			seq_printf(s, "%s %s| ", pin_sts, orientation);
+			seq_printf(s, "%s %s|", pin_sts, orientation);
 
 			db_cntrl = (DB_CNTRl_MASK << DB_CNTRL_OFF) & pin_reg;
 			if (db_cntrl) {
@@ -364,19 +350,17 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 						unit = 61;
 				}
 				if ((DB_TYPE_REMOVE_GLITCH << DB_CNTRL_OFF) == db_cntrl)
-					debounce_enable = "b +";
+					debounce_enable = "b";
 				else if ((DB_TYPE_PRESERVE_LOW_GLITCH << DB_CNTRL_OFF) == db_cntrl)
-					debounce_enable = "↓ +";
+					debounce_enable = "↓";
 				else
-					debounce_enable = "↑ +";
-
+					debounce_enable = "↑";
+				snprintf(debounce_value, sizeof(debounce_value), "%06u", time * unit);
+				seq_printf(s, "%s (🕑 %sus)|", debounce_enable, debounce_value);
 			} else {
-				debounce_enable = "  ∅";
-				time = 0;
+				seq_puts(s, "               |");
 			}
-			snprintf(debounce_value, sizeof(debounce_value), "%u", time * unit);
-			seq_printf(s, "debounce %s (🕑 %sus)| ", debounce_enable, debounce_value);
-			seq_printf(s, " 0x%x\n", pin_reg);
+			seq_printf(s, "0x%x\n", pin_reg);
 		}
 	}
 }
-- 
2.34.1

