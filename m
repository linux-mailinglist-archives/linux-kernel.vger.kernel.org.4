Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188EB71F69E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjFAX3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjFAX3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:29:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E42A136;
        Thu,  1 Jun 2023 16:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dizkZMI5ZJVWcuf0tPAvS9K53vnBKc2o2yM9ellUiSkwpQuc00NfG2x3nC6z/EpccuCUmmhC90rlJ9SdhNzVtSPrGln0CL8XXfNWfiJ8hr9shzz1vSq6Xe4twOQi1V4G2j7xR6LiftGneaAf8XlDIZChgIDKqj780rnN5xomgpGQZ8I2OEcxKpGWsxoxIO3ZjJde5CGOy54Kw8TO+NGXrLDZS2/KyQ3u3nPDEJ22sh0jtf9P3/kWZLMtD3KUeu3knuIY4TbmAHQYck8Pov09OpWjFZSBJVCIAkV9Y//EKNBbv8mGcoIm59QqhRilaHLw7a3cTh6xZsNp4BkUaPlFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCtaCSh2xp3TLU3Jn9duTu+a0ilJ5rZJIXMRb1Vd+cU=;
 b=Cxj1EkoTB5xr2Wt7gkGm1SaqMKlyGBWGMIhA7GJr7Qs4iSuSt7MXr0C41MWIiKRpWZa1bDQ4KDrLJAKt/OpfZXF2SR1coWZQd5CRQYHi27Ix30180+fPhJSiftQOuT+2qeLfs5yhh3ZIu2AkZUUCQN4UDbYtubLntYSCd0Rzaoar1tpefp5zFmfyaJZaBPM+8dhHvV26Pi2mXaULsgYeCvs7BOBSZ3k4kppYNMqZUiv/yn8T0I+z7MrQ2nXINlG6L7uCUDXC3F6/cTfx0UCn7/lU0R/cnPn3GCSprITbVrherMeOnN1Zf8HRtgAPi/29XXo8nqP20j3DL8Bt8I0EPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCtaCSh2xp3TLU3Jn9duTu+a0ilJ5rZJIXMRb1Vd+cU=;
 b=ORWt2kzztJm9REpBfs1fLP1Z5FkZhbG/qauYKzMhvoDvOn0/CMM1JVG7g9v9SFdjFT42lk2/gGvttCsH3hLDeKTSQccaSZ115RCSQG4YBL8HQtagp+4kiULy6jv2YPxP/PBrsxrpzTpy4ySgRPmrpVhZUyvXzPaYiHMNFVRhJxM=
Received: from DM6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:5:174::20)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.25; Thu, 1 Jun
 2023 23:29:43 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::4f) by DM6PR21CA0010.outlook.office365.com
 (2603:10b6:5:174::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.9 via Frontend
 Transport; Thu, 1 Jun 2023 23:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 23:29:43 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 18:29:42 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rafael Wysocki <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 3/4] pinctrl: amd: Use pm_pr_dbg to show debugging messages
Date:   Thu, 1 Jun 2023 18:29:22 -0500
Message-ID: <20230601232923.1248-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601232923.1248-1-mario.limonciello@amd.com>
References: <20230601232923.1248-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 77336892-228a-420d-972a-08db62f8141f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTMcIr/8bHc99V113LydJUuy0CiOT6Ii1qiI2Q9Oqc9NTGKfnhAb+d520z8wU7gmsxibgDccusa+w0qO0e6hnXO6SPnW1ky2JLsCLv9A7vLN/vb9adOxS4dXTkiCAz1Ad3+NdBeEi5/KIDjlf05U4A/vUfqaqNve1LZkBl+VeJ+loPMqApHKggfuXcaqsO1i7hEGXITmFjKLsHSJjnVdBKl8kzNajmrFMfmPYnCqx9mI9Pi9pX36CjF5ex8mS/X7fMDjNIpNQPTQb0F8gvwE3koyNdvPXKEr2jX5MZb2WsNxWomjtaMFKHLgzzHuQbmy4Q0KQr2Qqlx/1tlQCTYmkfnMpq9BbG5QGk0C7P1xlWHhJD/oArV/dgts56LSkDBCIPV3C5ld6j5I04Emaoj3vHbueagO1REpzS7F8BWjckmwQ3PnM6R9VK4uniqz/xz5dZeFliVNxhkTdQDXaLSGq1YNEFT9H6XGyyXYAnWISou2L/2cqtNt2WHWQfVnnOFVk4voOtaJ7bzezW7x8yazT+FTE3wzmSvlCZAz+Qptb3cnXN4nwTt9DuxInN1o1ms0crIvaXAVtyzyvniO9ILWTXUMIfpusieTvBIwoQcQkqfQwj6Q0DFQ7FnPcj921WrfEUMZnCJtULPbLAZThJ1yhMYO+NhpnxO8BgJMUgamb+gQnVurs5K3px/vpVhXXrXLHvJ2RoRPv+Aq51A0G0PPKwQym1b310prslxBK+iGLWMNCxStlhrRFJvAMaMeH6U7j2DqlMkF7asNfQno7l/xiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(110136005)(186003)(4326008)(83380400001)(70586007)(47076005)(54906003)(36756003)(15650500001)(2906002)(70206006)(478600001)(16526019)(1076003)(2616005)(40460700003)(26005)(8936002)(336012)(356005)(82740400003)(8676002)(426003)(82310400005)(81166007)(316002)(44832011)(36860700001)(40480700001)(5660300002)(7696005)(6666004)(86362001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 23:29:43.1302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77336892-228a-420d-972a-08db62f8141f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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

