Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F60768FE32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjBIEDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjBIECz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:02:55 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27DF303C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 20:02:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy3licoxj3MiQkiCqtzYjNTGOG0JSsUNoIWcI/Rl87m6/z1Pl9SuM3j2pS4L27T97uBRuHwOa4gx9ravI49zYSok5iP/9sYRFqE6aw0kX1ED8G5pUA6oTN0CDttaw2Q1Uv7KQk9bfcTtLcsCNrMVxmoQE/OxWW+O9OPeE6Ybncn933djR3ctfzTq9AVJrXqFosiZuYrl3Vci4RI8OSB46na3FgdtoHzH1b/5QQSI//xm0CAnZS87SupQcJwh9wfRR7QsE9A4Nu6wk++PometqBQ1Mx5doveKeRcfO0iGqPfAsr7/4+tG1xlPPH2uibK1/uKfbLs6tiX4nWT+zk7QtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spQA0Zq7uD4qbyX35eaOb14VrOuk5tWvLqau+eATdG0=;
 b=Dgn/pMLFhf9t92zrGM7uu5PkJOSV868bEU+8eSoGyyP08LXdnO7wxluc9AJTTZuvF3O2LF4KSKD5IBc1OFN/GVQmQbGtR7jToS1xfGid/MS2x+6+ZBH5QgGf/wF1iiJfzrMIGJKGcBUyHVUDjkk8UJMZnCo8Fsbjs88omND204i5HBMJmd6zloFbFkd6fFCT/L7FQKup9L8DxGepy4K/CV/dSGcnMU0jgvYLCCBPfE7e2KaLX5NzU3Cc7pO0TI8Jwi6E1bMm7JqIqUf29hxeTJXWpbgETqGVLhJf+Uo8KousfZhvxuWRhL1fJ6jlTaqx/Krz/saqdXxftFNY4rmr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spQA0Zq7uD4qbyX35eaOb14VrOuk5tWvLqau+eATdG0=;
 b=GAPOtMDc9x8K0t6hE8wsG1B/AvNxPgxkzi5fmAVxkBpBVnKDncuD45pPTiNjDTVm28xHtBM/vFDSrfxNDmlJhjYeFvSBw8ZCMeCx9LZusRHPQBow5eZu0Viw71RX0mw5N3rwxE9Zg2PBYRt42uXyJMyBXz6tib0O2gUsVGI1m6hEyQiTAotI9pjCgiDckXZz1hG4L+M9cblK4Gck6FPIgB9H3SjbGiyAJCQE2xR/xFfbLysPyBSMqf4aeCkYyM4f5Lz9g4fHUzGe2cWZVuibJdHuzDday3zOtbT2ogP/M49atC5BlVEYwqVlCwDPKYQFbF/4a6iY31FqHVXP2VuBiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5806.apcprd06.prod.outlook.com (2603:1096:400:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 04:02:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6086.011; Thu, 9 Feb 2023
 04:02:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] clocksource/drivers/timer-sun4i: Add CLOCK_EVT_FEAT_DYNIRQ
Date:   Thu,  9 Feb 2023 12:02:39 +0800
Message-Id: <20230209040239.24710-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 9882bae0-f820-46b0-c43c-08db0a52825d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nI2vcEJSvil+oGOo85UNq5dUg4JuXahKWwaLSXf5z/67nJHtE+x5tEgbuwl4iGaPd3t7Wf/jQ0ZDaiyZrN8jPjxwDwzPOwHLJX0RiwvG1dp7HNxp9My+35rr3kG2cir9HelKzxzIgLUb8p1085XFxGBs/OsxpXpALz73bLEZByfXfMqVlPMjJ9jPRR2Lp5qHtxN1dqWvipiT4RiTw3Gy8LpsjDb1tx5SFZsydkO1W6bN4/HpypIwumiC+r4K31drJBBsyN9kZyRfJy7oSZO9hHZ+llfEpJDv0l9EnMs9OUko5BgKS4qyYuk3hjY/u6isUbMD11VNVTXfjCgT84IKOIF5ffCGCq7qICWCb4Ah3Wmzk+OOF95gkfq30L/NTx6AS28M75zq5lgC04izPCtklwKBNDogTDE1OZVvO89LHoXnXrA9cB+T4LpaAAVgZPXoh0M4BBHZ3OOv7PiB8f/XnEw6LKQBvZxTLwQYmO4OD7HZG19SAnsPQ9vX9Aki9qmJX/5lCNSCUIZdyAufzXnDSTh8E6h/Id2btSJIpNcZzuPtALnAG1hBpTJhwK/m20uW2R8E9fyFci6B1sbDodKXatcFNFKnJ4dwoHA4fyMYz451ZNMHpziGLb2Ooa02DQIcFiCmOs1yIxhGsZGsPk6KEr4Uk0e/ZijqI+f5r0PgW6fVzuubpa3TPahPmfPuX/4QXIGHvUmlNI5W64PSA5MBoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(83380400001)(36756003)(5660300002)(2906002)(186003)(6506007)(6512007)(8936002)(26005)(41300700001)(66556008)(107886003)(6666004)(316002)(478600001)(6486002)(86362001)(52116002)(1076003)(38350700002)(38100700002)(2616005)(66476007)(4326008)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ueA1QVuPRifvU/uUnz31wqJQ1Lo2Zbd7jnpUMzGIH7GlTCkwmTfDixghkHVP?=
 =?us-ascii?Q?IkIjrWatWE4VTQ+aYOgxcg4oZsuKxVgPac3HWfH5H1Qjqs1yYof38G7PDsuc?=
 =?us-ascii?Q?lFkK3Pgm2haQGLn7GqH6IJnQ4l9TCA7eZfqitUqk3h6/sTVz7ZmP4XSyFAB+?=
 =?us-ascii?Q?po1OdPk27o+2uMSH2DIdP9fehXvpkP0IB4KUNgEmwZTCpZQdB47fYsJ2lTXs?=
 =?us-ascii?Q?Uz/+tj13J4hCij4FxWes7skeugf6vs7wNfqbdPDmahpt+a/KBZ+8Qs0dfMiy?=
 =?us-ascii?Q?357Pss5NflWkm/V7lRCOONUO0b7NiOpWVZIrMxumPaCxkMHN/+RyROp/kCRP?=
 =?us-ascii?Q?quK+SpmSXPHJANfq4mmsXFrw2pU2wvJmQtBcMXztTDkE835tiLilKkVIgY+t?=
 =?us-ascii?Q?yGzyqvJ3KPbXNZ7hpFBKFMZWi2Y5LtfO6EOua82hvNg53z3Ur6rwnPVpjJHO?=
 =?us-ascii?Q?lKSbeDEuqzS0wMoHWY3I7b0exsGE/SNI4j8N8bVICcWkZNopwiXh3cHeV9Zg?=
 =?us-ascii?Q?hcp1Nr+7Wbf/sCJ9o4tW9kFNcolF4Z8D5o0v39rmylKcmUFk6XZiCAD/35rH?=
 =?us-ascii?Q?vZuNep2xJ3Zu0jl8wYh2yP9uBmK2UTyOLbHVTV61ynYxDsYdD65ufKxAA5zB?=
 =?us-ascii?Q?zLoDuw5GSrqNFJyytSSHhGhdJNFTsPanUR/M9YKevAmdmlVMlv53dmftWNug?=
 =?us-ascii?Q?9B73b79GAhzI/653ryqCOskqn3zMHjogGeAqjY54cW/OypBgkKhCaCogfpl9?=
 =?us-ascii?Q?k+TpsWDp833Ak+WvPDrGzbfzqNvss2kyJi/NPUscxBxlhpDpdreQm93Twf9g?=
 =?us-ascii?Q?Mo8C0I8ccD52oUmNi5BUCiVcuKFaYB1+BMWEnYLmBDLfgbHhM08i80gcmEVg?=
 =?us-ascii?Q?vDuQsaWk72pmHmJBnl/d3U/TuoiwkNN0gos1ndm8lD3D5XgHHrKb9uYiFimS?=
 =?us-ascii?Q?tRfcJ5OI2zGKyPYDhiFj25zsKVgIh7nkal8fx/26jmNgpUnTsNVKeC5v+25C?=
 =?us-ascii?Q?z+Hw9O1bC52NCWTlemcnPiDvctca/pTRoD51xk0d6lqgslubWX4ot6fvdmAP?=
 =?us-ascii?Q?9JkZRcpJnHzIKziHGufppCUIHIpnsrba0YC6rvc8vmQp7+MwAWUjrW/xtAF4?=
 =?us-ascii?Q?UH1hztGCsnmuf+ul68szKPNRnJMD0eLtOiy05DJ+3XCA3ki3rLgt8eyqYa9J?=
 =?us-ascii?Q?T4ozRFkBa5YIm8P+baSqUAdZ9RTtH+5uFvgFc78D6QN2cmIovSqnjW0Gx8Nt?=
 =?us-ascii?Q?Dc0oiGdOgi3oxGoUJgDi/XWPX6t/9qMOhtDAug2MN4QlDxTpg3NbGbuwQY9a?=
 =?us-ascii?Q?Qtmq2887g8jLMdDA4Fw6fRAg6QjdJ9LkAMGhTxohmV1thlb2Yo9aRsXF+Z3I?=
 =?us-ascii?Q?ml9qI0IaByLboCgqGVdyT8L89TnFgRIgVaNu1Xf4b6qtro38vk/ssQQ8ti+g?=
 =?us-ascii?Q?s2UshCfuKkZFPKqpYAYndGSuHugEOHZM+r5kVbo6beWrjvEkdx40yPhQPgiI?=
 =?us-ascii?Q?JOOcRtyt1oWnmGoROyTqK+4Xm2LumQL4l+OoQ1Tumfv+RhGhWF9mS5beEq+E?=
 =?us-ascii?Q?7zZEFAaw/ud836tDfD8oSh+tL7fZQFgaDoQkiSaz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9882bae0-f820-46b0-c43c-08db0a52825d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 04:02:49.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbcuHpPnRg12XvHiZTYX0+oEumpHL6q/8m59stYlQ9mblpBndpQqP6XI76Tr7TlwSPR9ozkho7ynw9IyXn86kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5806
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CLOCK_EVT_FEAT_DYNIRQ to allow the IRQ could be runtime set affinity
to the cores that needs wake up, otherwise saying core0 has to send
IPI to wakeup core1. With CLOCK_EVT_FEAT_DYNIRQ set, when broadcast
timer could wake up the cores, IPI is not needed.

After enabling this feature, especially the scene where cpuidle is
enabled can benefit.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/clocksource/timer-sun4i.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index e5a70aa1deb4..7bdcc60ad43c 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -144,7 +144,8 @@ static struct timer_of to = {
 	.clkevt = {
 		.name = "sun4i_tick",
 		.rating = 350,
-		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+				CLOCK_EVT_FEAT_DYNIRQ,
 		.set_state_shutdown = sun4i_clkevt_shutdown,
 		.set_state_periodic = sun4i_clkevt_set_periodic,
 		.set_state_oneshot = sun4i_clkevt_set_oneshot,
-- 
2.25.1

