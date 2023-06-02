Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3827209E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjFBTdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjFBTc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:32:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E11A2;
        Fri,  2 Jun 2023 12:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klh2MnTCFtv575mGWFsO+A1xamp16JnRaAuNi4/NzjxtlZ6zXA+BkTMP9xp8WChbc4jpTw5rHgLpIw6Q271jq9D4sGHSOZ1thjQ7oUgIyZQPHn8geDllfOzM0GWRZcM94g+hSrzq3/U2Uyv4lOhoGovWSn5mJ6MzSbOPFytSsyxBwEod2X62O5NgOTHKtJ4Xg6dC58Jx/WJByJq3GZbionzyViwCMGtvpGNn7GHLNsx2yM59AIIzPWh6QVL07IuOG2qqcceHIRi5upyyVvTiAkydXw2abn+EA5uu5b5hjhh9jlZ7ho+eyGZigYM+RnqTYnKIzLabOWUk3rUhZs9kGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCtaCSh2xp3TLU3Jn9duTu+a0ilJ5rZJIXMRb1Vd+cU=;
 b=G3ovVtXOtv51LL6Erux8hqlIbAtWWHq3YbzAsZiY7d3KuvoBP7EnRF1so76mI33PjcWbkG30Qnp7HQawTdHnzTySfIgoer4ISjupxt9rTahNuNFTlzwEzX122Jh4o0k6gjWDirlwyGpNXxKT80MhfREAFsnGQKE7KEhqgcjFdBaTVj1StSXgssQTh2ljke++0VSIavsKeisK6ssa1jEBp9wR/D/0dLaxjKSMTMnMGkT7j244cjAunPCSo/v7dZpSTVNySX6nlMdkNprPuLRewysMOxbclpIa/WiM5pOPV0OUZTlTRkuX+SsdMKsrcUAQ2Vtx1lUMgebAU7KTwCoRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCtaCSh2xp3TLU3Jn9duTu+a0ilJ5rZJIXMRb1Vd+cU=;
 b=5i6MhecCySXX+HQSj8vKnQiIF567FBROJf30+cx5Sd3bZpq+RWp1ELGV2yFI6KpiLG2BKs0jEk17LeCrIY2Ymr85jBCv08WEM0BbrmtvLMfAkBJM5oPOTyKA0zxf3xIrcq+M1wk/Rf2nXgZbu/AOO4kbiDp3NEalHWrxEN2jZkg=
Received: from MW4PR02CA0017.namprd02.prod.outlook.com (2603:10b6:303:16d::24)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 19:32:55 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::de) by MW4PR02CA0017.outlook.office365.com
 (2603:10b6:303:16d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 19:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 19:32:54 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 14:32:51 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rafael Wysocki <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 3/4] pinctrl: amd: Use pm_pr_dbg to show debugging messages
Date:   Fri, 2 Jun 2023 02:30:24 -0500
Message-ID: <20230602073025.22884-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602073025.22884-1-mario.limonciello@amd.com>
References: <20230602073025.22884-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 7277e61a-f0a3-4069-bdb1-08db63a02995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0FoX+0mkawxQiDJnKdLE9qFGbdBZljPAEvii1cZ3C6Y5wsgy3+S6bOySgJn8oQSdMlkcBzTmSyF+tXxXORXtG0SFYPpjP8sf6FXuIxTds0C3SrrBDeHb2NBZJNpVuF+NR4YD7u53Kkcl6NRzlZpCptsp5HZuTfVBfg3GCkOmr8LGt7o94MiC6pxuYPtgHrTEy7uV1mMZoroew3UYSYhZzAxEQjjk3/Ku+86tRm9OfzanjvIwVEYq9fru8iWgMAbuOTHJMyVaZa5dkf84L+MKrnlzIq7wobqfvN4xqxGMT1UnHRSgOr2lNrqUjwOPO4QjmDOdDDuWUxiBUwnvpI8zKrc+wcojp6XkxstxPXFheQnjyokHYTl4l1Czc+QrjuTqxuJQ+Wigc/sx3pH+JAytOYTt/fKSBcAu7brwkZB1933J0IYMbnCmFn3rP9/5t54MPcarhzCU1UH6+k92ikUqzM+jNI9b841iYyAdMaOIG8erC1/J0SG7ka1j/7CiIE3kjydWGs9uziBvmDyqvm8oUuYSx84vcoA4v5w3HslV/+Kiq/2fPGlTg/GO4kbTW16nc46F++0OjTFm1uVLzpUwkiI+UqqMZyJYrkHdQW8AYZBjphAjszPHpWO67xlMQz26GZe1VWqbpUY0JpKGEOJZ/Ie8NaA0GwPRm/Emm/jLGrrFCH2vfec8UHN8IYhuBFW7TS/k7LyOSSwjo3OUHf4aoVEHXTcME8Z+0Fv2aQIpgo6KBYck0w17fN8kDqMW2+OI66+qArCCu5aJt9vQWUuQvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(426003)(16526019)(47076005)(83380400001)(186003)(15650500001)(2616005)(36860700001)(6666004)(4326008)(7696005)(478600001)(316002)(70206006)(70586007)(110136005)(54906003)(2906002)(26005)(44832011)(5660300002)(1076003)(8676002)(41300700001)(8936002)(336012)(40480700001)(356005)(81166007)(36756003)(82310400005)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 19:32:54.5091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7277e61a-f0a3-4069-bdb1-08db63a02995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

