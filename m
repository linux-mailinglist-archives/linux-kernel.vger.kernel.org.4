Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55313622860
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiKIKZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKIKZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:25:09 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140070.outbound.protection.outlook.com [40.107.14.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB73F13D64;
        Wed,  9 Nov 2022 02:25:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbFZNBkLaZra30EqWFPQ1ylOJTJkXhEjPZMo9PMpt16pxS8byIKzmakqNem1xEWHzi3061UZlpdqS/seP8m6Pn4pXPzyQi6qJLlP8uSi8DeGf6Z3iyPAcJh99qME9LcYTvWwmn6V1kjd0J/ocboZw8id9WYr+DnX4ixGBNvwkxste5W/Z98vARbFaFjnzlywPmoT4MjumCbnZ4EBt5fRFk9cb9upa34gPSJJXckd55Kfrcbm/8r2YLRdutYpje5asSp4SJ2X+iGbytbhDhv7K4DltUeuw7EKcrNpAQyCDCeMxmKfH+llCR3S8/Hy3E71TCSHyEgDcTcxkBuH1phRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MU4dobfDhemaIPAuxuMsHIffrWx8+wKr5Sb4k2tTeRo=;
 b=Rgz0knJMmBZy6XeswcsyFHXq9UO29PrLMht90PsV4DRohG65gwjA8GsPLe6lri7f+Z5EbT7GUYXsvjik5jnl0SoZli6qGB7N6pKPNMIyRWE+zZDj3ZnpLb7gCQZheWoK0ssCVMqpGbiLmhtkKkmV9EH/vrEKCQdpe06o/qC4gCax61B43tCrWh1LdNzhxjZdCfTjDFxRng0J3j/8i6Vp0AKejQzNd9W2Iclaxq9B11WtdqEHO8MWw83K66dWPLa45dwr6LlUS5oQXctkJZZrgevIP3T8tnKEifXLxGx9tYZ1h1hfN94ZW5VXSX+rIrKA6IKrGYdQkCvf6i4EOSx/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU4dobfDhemaIPAuxuMsHIffrWx8+wKr5Sb4k2tTeRo=;
 b=d76RPq053dxgpv6t1uPoojCmEEysLk6oRho8g6iC+/ESELtOIMR+2L3MQj4XglaSwo3DElbVteUXVA0JE1GI0McTPbp1V4Obv1I6s0j1WCWfe/naryU5ADt2z1DFRIYNH73m84UtGysCXZpf8u7MdRlD7fKIyklwu+NOGLaN3EZtSgX048G7ud6IGljVCU1hI3HVnkd3BGz+vcwPCxU0bN+79Y4tB+9VFgXxlP/bPyPftTLwU2galLMrNvNw4UGIkaqgosVJx7YX5eT7PwvGCK6sU7dU2jRufB5LzJ9Q5LXAyuX5eS4F/shYMB3duXuCg0Y4F+W9VT/jEXDtEOPqqQ==
Received: from DB6PR0201CA0038.eurprd02.prod.outlook.com (2603:10a6:4:3f::48)
 by AS2PR10MB7838.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 9 Nov
 2022 10:25:06 +0000
Received: from DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:3f:cafe::12) by DB6PR0201CA0038.outlook.office365.com
 (2603:10a6:4:3f::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.21 via Frontend
 Transport; Wed, 9 Nov 2022 10:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT031.mail.protection.outlook.com (10.152.4.253) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Wed, 9 Nov 2022 10:25:05 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 9 Nov 2022 11:25:05 +0100
Received: from bennie-lenovo.ad001.siemens.net (139.23.126.196) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 9 Nov 2022 11:25:04 +0100
From:   "B. Niedermayr" <benedikt.niedermayr@siemens.com>
To:     <linux-next@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <keescook@chromium.org>,
        <krzysztof.kozlowski@linaro.org>, <rogerq@kernel.org>,
        <tony@atomide.com>, <gustavo@embeddedor.com>
Subject: [PATCH] memory: omap-gpmc: fix coverity issue "Control flow issues"
Date:   Wed, 9 Nov 2022 11:24:54 +0100
Message-ID: <20221109102454.174320-1-benedikt.niedermayr@siemens.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.23.126.196]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT031:EE_|AS2PR10MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9222ddac-e06e-4c62-86d0-08dac23cabaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAC9zoTVRw/LEoFRPjtDzO+4Xd/eVAii4D4VC2mmIRuhrKIh8DUjtmanQFE+IOx4o4mOt4B+aJB/Jwj5peBgRr62yTEWTPcBkhmfqsRLty0+xSvxtf/g6OhNJeibyzEWfW8h9+8pP3vMjw7lHPJQcXnKIUptU6z/f+PiGHgQ6k/PnJ7s4DqnG/myE3r3fpuQhQU39lx1LygR8+vFaN/CoKJWNxp1giCGt4MzfFh5fLmd4oCR3mwvxz0us1XHcJoOrrXYGL7bC3nMcYr3vDZWl5YjlIECot+O19oVUUo3BJ6xxJ904V8y00+dFDs5ypocpusZL65IvmiuI+kiPgkZYRck+n+T5WJQuQdO2NT1L2QYhUAX0Z5U6yvlvQsrohkyUvjxx5GM1/DqVFs8Gm2loyiDCweNYi37cnFWRRiblb6R29HkQ5YSkxNF2WkilxNojQs7zass6VkIPtaeYKdRIBjiNnQv1WuI6o4lVLjQlEAEry5vY/YYOJ0B5rbuNmomkpRqjYq8YVPu+MhiUjcPJfVcdCc/pSiOE4qMctQo3ooiji5vRjar5mfa8d5FXoBLucIOo+q9tk0oVRs/h1zd9u1AkUtQfIqrRGTW3SZ0Ppl9aV/s1nJt6F/iumjGCQOe1UZuO4RBi2vGW+frsJzEGLtXVQhE0FV4WheB0ZZWujcOVrl0uMogcH4Y2ipUEl7yHQpkg1kIlMtOPjdomYrPnY43c2pc23q7gqEETV+b8LTV4Um1YuIyOS1ViD6IuDW88P2OYW8Z9p+wKBdJpL4v8EtltQ/6KAU/sm5gRM7nzmvbtbwNC2+hB55uYDL7Ck62
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(26005)(4326008)(54906003)(70206006)(40460700003)(82960400001)(36756003)(82740400003)(83380400001)(8676002)(36860700001)(6916009)(40480700001)(8936002)(356005)(5660300002)(81166007)(86362001)(6666004)(41300700001)(956004)(478600001)(186003)(1076003)(316002)(70586007)(47076005)(2906002)(16526019)(82310400005)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:25:05.9798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9222ddac-e06e-4c62-86d0-08dac23cabaf
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7838
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>

Assign a big positive integer instead of an negative integer to an
u32 variable. Also remove the check for ">= 0" which doesn't make sense
for unsigned integers.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527139 ("Control flow issues")
Fixes: 89aed3cd5cb9 ("memory: omap-gpmc: wait pin additions")
Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
---
 drivers/memory/omap-gpmc.c              | 2 +-
 include/linux/platform_data/gpmc-omap.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index e427572712e2..57d9f91fe89b 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1045,7 +1045,7 @@ EXPORT_SYMBOL(gpmc_cs_free);
 
 static bool gpmc_is_valid_waitpin(u32 waitpin)
 {
-	return waitpin >= 0 && waitpin < gpmc_nr_waitpins;
+	return waitpin < gpmc_nr_waitpins;
 }
 
 static int gpmc_alloc_waitpin(struct gpmc_device *gpmc,
diff --git a/include/linux/platform_data/gpmc-omap.h b/include/linux/platform_data/gpmc-omap.h
index 296b080c5c67..dcca6c5e23bb 100644
--- a/include/linux/platform_data/gpmc-omap.h
+++ b/include/linux/platform_data/gpmc-omap.h
@@ -137,11 +137,11 @@ struct gpmc_device_timings {
 #define GPMC_MUX_AD			2	/* Addr-Data multiplex */
 
 /* Wait pin polarity values */
-#define GPMC_WAITPINPOLARITY_INVALID -1
+#define GPMC_WAITPINPOLARITY_INVALID UINT_MAX
 #define GPMC_WAITPINPOLARITY_ACTIVE_LOW 0
 #define GPMC_WAITPINPOLARITY_ACTIVE_HIGH 1
 
-#define GPMC_WAITPIN_INVALID -1
+#define GPMC_WAITPIN_INVALID UINT_MAX
 
 struct gpmc_settings {
 	bool burst_wrap;	/* enables wrap bursting */
-- 
2.25.1

