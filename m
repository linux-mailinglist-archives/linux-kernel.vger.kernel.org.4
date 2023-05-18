Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363837086E1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjERR26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjERR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:28:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E6BE46;
        Thu, 18 May 2023 10:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXgSeiNqvWQTXX6tYSjQMmMz4lAGR/nQurNj0W3gifyHz64806ifnG1/tuX+MPvKhlJKJl7TScsPMCgOEvBxuByfAAPr0fsiliudoScbWpspDbAlI/d16pvaIiXL8H1W2l8zPbcPvSMyNMSCoA1tjgtqs+3w2tMEAfKYcD04U6uwaBSytk8VbrOY4D0aXuj672xW24FS/YDkaWT5DhfP3O7eEQU0Yt0N2VpjBVk3o5MoeySEiqsv9mN1eudfskWeIAFOnhN5ZTX7ZN5Iw2+obsTwwfzH/lcgt3KZqn/JX7IjRsW1wQ+6AUl2+FtlaWMQbJBvgXyB3W7ClZ8utRnE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCtaCSh2xp3TLU3Jn9duTu+a0ilJ5rZJIXMRb1Vd+cU=;
 b=KRphIMYmazRT6DBp+bQkiXI2Wgw42cnF9g+Jc6x3t1Fzm1mQbZ/DlHDXdfQNF2gMQQVrmwgt1JxniCWdaTQ+GD+Cif48ay9d72C3BMQlSgvy5GfKr4oNvsL3BcMOnTr5P6ayYmn2v9Bad8nT4JgTDPHHDcTnGxEtDvYq2u1O9YlMFyLZBbV9IDLWZn6LFWlsuP9NvGHCqe6uS1uWUX0Dq8cm54eIVxWzSN8gwrfKhMCLfYdL2ZQpcf0MpbqnwVgFDZjdszYb3ds4V8TQC13XP43SExZ3o8mk/tszdz9zx9x8bV6O6I95wCz5zlslrctSwfjUnbWhV5i/8rYiInRClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCtaCSh2xp3TLU3Jn9duTu+a0ilJ5rZJIXMRb1Vd+cU=;
 b=5aYCBrz04GJnNhukI4MjjaupNU3fv8Xn1WedccIo9Z0LvTCk6HeRan8DGXMgaaUJQbLp7AN6/Uv1kTqfRNHQmijY9gBE3CkqRAAI33AvvT7VZDAth/93Hfyh5ayYNy1Qu8W2PH2f7T7Dcf4wD61a7Ft4qQiISF8vB+hj74Q0zls=
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 17:28:39 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::a0) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Thu, 18 May 2023 17:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Thu, 18 May 2023 17:28:39 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 12:28:38 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/4] pinctrl: amd: Use pm_pr_dbg to show debugging messages
Date:   Thu, 18 May 2023 12:27:51 -0500
Message-ID: <20230518172752.93322-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518172752.93322-1-mario.limonciello@amd.com>
References: <20230518172752.93322-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: ce871595-96a9-45eb-6d38-08db57c551e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rb4WnEMCU2esqI7VHCfxcxoX2Z49b+cukM6MWtsMVZOd49p0FL8cPk2yd1st+tjimD9WWgOMDEWjQgpU3a/Qb1KftLcbcJ4zKajEf0Fs0RmE6+yOWUzL6TQtzv4jLNiEOOT0dNd85bUW7YdCcbLkwzZDlOmq3EsBYSpat/G4OFEYZRRYgLr6YLfZ7DhBwaOiP7Cs19yiv4dulb0yO7J3SuN0zxLVGmUuoPUWBih+cW6+DofjfrYKsh6sr0uUnR9GKzvT3yK1cId2dsVLjVeeU6nDwwDqMVjlVe5I3YkQFT8eN8MO/xoR++pxyezZhP4nnB8+gwRd9nWh4rHuXFKuQpE/er30l0/9RLUZX+i3D/FttS89TDkoJ49C/7yHIqVmsxZzbBFptKBJY6DjUB+mhPz/R/yD22+qpJYnJVn1i6/K8okQMRv4Ulwcuzms+Hzfge6M41GcDdp92E9G9xyD5pcbe0scczp7OPjdvLM6yvdcYAQU3kQvAqxJhsmbrq3EQPougvefN3QQuZnbaxArEgxKL6pW3uSo82Mp8LQSg2DSDVOrDVrID+V4hnNsrY8RTCqdICQGf85NDyzQ/2NaKJY3WuZETJMdAiOQTb4WicrnSjDkkrp6qpMSLXDwuF1jenLd/aUXUtKS7HTcmrLYISMaIua8DU2Hsf/t3vVb60cFJGRLl9lmHO+YbhBhNXoVE2n4cWOBPzNulZL0/j5p6TWudx6p6D2K8EM2D7/lW881xUaX21yv83EatWoUWAD4t3xPyuhVmtMDA6Qzg7bRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(6666004)(40460700003)(26005)(1076003)(7696005)(8676002)(336012)(426003)(44832011)(186003)(16526019)(316002)(36756003)(478600001)(356005)(82310400005)(4326008)(5660300002)(86362001)(81166007)(2616005)(70586007)(70206006)(54906003)(110136005)(82740400003)(40480700001)(83380400001)(41300700001)(36860700001)(47076005)(2906002)(8936002)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 17:28:39.6077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce871595-96a9-45eb-6d38-08db57c551e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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

