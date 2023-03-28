Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EA86CC989
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjC1Rn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjC1Rn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:43:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38EED50D;
        Tue, 28 Mar 2023 10:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiK6mdYlMf19x2YJ4ORIl4iPCRQA6m6Fc3i5QmFm3f1pYH21uvVhdYPHiFpA5JTtuMDyy1DNGEPTCL3KX4l5SFNFlwLmqkijpw0vzMKqpoCa+6mPzSXbr+nR2o913aOvHn2/wAxa2WzQ6Q4M27bcK4/2SYpfZ/y2k5noOu5ugW943eUlXk4s+6QpXtGI/PKXJ0bAYqm0vnTcQycHb3pFqzZo2C4cl+3QwFhhjpn6ln8UuS51G+VegqSmvbLAWHug+SgC14TjF5hqjuFClpI7ZQSshQSAO5Z636mO3gDSE3kdCJmBLDwABltquuxZoHwcmSfLfq2fJfghlTqElf7nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hbgjoW3lXuWAlH5JJ5NsfG0s7gg+q8tDyId+wx566Y=;
 b=hO5143jkFBNxggF/5m39uzcncHEH3TSosaKqnqmDM/OpJJBGHV60aAIaf+rCmp+JprTwnBo9zRaorZ9zrVw4fNJroOViRLC7acHoHOL0bCRRNkDhg4BJeS1pIGJR1yDZFvl+7DH3qt5injmh3Bgyfh/K8MoagQjkA0Ahq7tvjQQXEd7xVn1IiSKXojtW+6q7LXsQtvSyoj5xmRYOAp8xBhn1cNeRW6RMAg77bhzANGHZnFUp1O4UEXpytTxjOv5p+EtyRuT3oSNMiMwyf+P4RvbLHY7l1cTC2HcaXhZuB8OD3rmQOEJpD9AcfKUjMrmPUfdV1hBpsBfCmdBuuLGVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hbgjoW3lXuWAlH5JJ5NsfG0s7gg+q8tDyId+wx566Y=;
 b=WzFmw2n02zDVRL4Si5p5Wm8TWIsYzppyoqgoHJcpLHfrTkxfohVkXHGov6HpJRiMrmw4Jj4RhXYLX1IgdlhkCyNs34eIV41kNT5bCyMSrui38f4M93w/T50xf46xINmpPKouHOKiiBGoxgWMurD0S0BIOMcERldU0r3jzjdKUMM=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 17:43:10 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::cc) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 17:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Tue, 28 Mar 2023 17:43:10 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 12:43:04 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] pinctrl: amd: Add fields for interrupt status and wake status
Date:   Tue, 28 Mar 2023 12:42:31 -0500
Message-ID: <20230328174231.8924-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT035:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d064557-2b8a-40ba-6110-08db2fb3e5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCWDr+EW+8et08Aigb+kpDtNaqkX4CpWHvzgBWhqLqAwUmHxr6+fWPDqtlTW53U3uN1RdDZYr9F3bGVzM3BBDfI7YjZi7PRP1gLmoJsOX1pV4CPyslL5TnOTsEW6ffgEvkKBzvzDxRQcxBDI/7z1K/meT/JBNNfiioUxCnS7pqaFyDPmdf6bj7I4+08hv5eErueqFEuGx4wnesP9RbDMMUv/58VfQPaMuFsor9FlisVxIuLS1xG0Hx6rvgPEw2zd0nf36ofYmzy4+RqeVDPL1DmsDsoSn3hYOCLLQiuK5TcirYEfAWYIrdvFBGbpyscvHzjDAkxJTzYs0h8V5ULhAaY3rkG5UetkoeRRhwC3qSHNFP2acknoXjWXKdTl+6pLaW9dtx86bT0e9+jGZR4HOK7xAmvZwE/ZMul4Drd/VDqCDZar7CyoNryglbektIwLHdFt2XIvqZIX8XrL3CNJ4TmVtb2VHlQmvL9JN84HDrewKk83YvkncdzXfc8ew0QNhHExEJK3LkNi8MYvrNlOPcseh6TZxnbDm1Ic/gBf6YAq9vnstZZSeDUAhv55b5fXjIZ9DJVTlGGTdVVVsxO088lJFee7e5Bw7wqDAl6eXCuMYZAu7UVltBKlxRe5iGXpJ4IhP7Vy58LlsLRv3TmDJT+RLBYT8KefKDXfjOz7M80x9ByrenHATrzsJEGRWZLTD3+h6eH+kD2eSE+ObpP61V5DqgQZ6Db9OaK6goz/eqY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(86362001)(47076005)(426003)(336012)(82740400003)(36756003)(16526019)(2906002)(83380400001)(82310400005)(2616005)(186003)(5660300002)(1076003)(26005)(8936002)(81166007)(356005)(6666004)(40460700003)(36860700001)(70206006)(70586007)(41300700001)(40480700001)(4326008)(7696005)(54906003)(44832011)(316002)(8676002)(478600001)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 17:43:10.5955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d064557-2b8a-40ba-6110-08db2fb3e5fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the firmware has misconfigured a GPIO it may cause interrupt
status or wake status bits to be set and not asserted. Add these
to debug output to catch this case.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 822f29440f15..c250110f6775 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -211,6 +211,8 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	char *wake_cntrl1;
 	char *wake_cntrl2;
 	char *pin_sts;
+	char *interrupt_sts;
+	char *wake_sts;
 	char *pull_up_sel;
 	char *orientation;
 	char debounce_value[40];
@@ -243,7 +245,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 			continue;
 		}
 		seq_printf(s, "GPIO bank%d\n", bank);
-		seq_puts(s, "gpio\tint|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient|       debounce|reg\n");
+		seq_puts(s, "gpio\t  int|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient|       debounce|reg\n");
 		for (; i < pin_num; i++) {
 			seq_printf(s, "#%d\t", i);
 			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
@@ -274,12 +276,18 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 				else
 					interrupt_mask = "😷";
 
-				seq_printf(s, "%s|     %s|  %s|",
+				if (pin_reg & BIT(INTERRUPT_STS_OFF))
+					interrupt_sts = "🔥";
+				else
+					interrupt_sts = "  ";
+
+				seq_printf(s, "%s %s|     %s|  %s|",
+				   interrupt_sts,
 				   interrupt_mask,
 				   active_level,
 				   level_trig);
 			} else
-				seq_puts(s, "  ∅|      |       |");
+				seq_puts(s, "    ∅|      |       |");
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S0I3))
 				wake_cntrl0 = "⏰";
@@ -305,6 +313,12 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 				wake_cntrlz = "  ";
 			seq_printf(s, "%s|", wake_cntrlz);
 
+			if (pin_reg & BIT(WAKE_STS_OFF))
+				wake_sts = "🔥";
+			else
+				wake_sts = " ";
+			seq_printf(s, "   %s|", wake_sts);
+
 			if (pin_reg & BIT(PULL_UP_ENABLE_OFF)) {
 				if (pin_reg & BIT(PULL_UP_SEL_OFF))
 					pull_up_sel = "8k";
-- 
2.34.1

