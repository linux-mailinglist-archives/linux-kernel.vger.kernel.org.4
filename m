Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C7374FDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGLDnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGLDnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:43:25 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7363019A7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3v/9MCjFlw8ocYz9i0SmMcbRaA74zJ2F1PNL+hHJSljQ3E0dtahkouVqjIJ2xY4U67+2W279YzNrIA45A5/pQ2VRY9AbWvFDnavE19/4wmkNhRhk/6RHqt5jCd8AMyIAxCJvLdW3NbhYdyQerryAOtE403+rsVCMdG+cBkc9O7xFJyzpAW/1+VN5l0b8xkYmG6bWvOwgILFmZJ/HE3mbL17tdBOitgkkQds6gl/Y6ZCm+zkMH/9HHIMd1bup8o/i8xq9/4ezhy5Wd7nac97MIV3uxKseHbWNid46LrZmZnZyhTUEqsp7Sbs249syuXfvGpTvtVeKvZd4CPMd8O1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXzJm/9ejfx3vg4dkBqqSjxSiYzdYx3bO11i5yYL+8E=;
 b=d4UhaceA/5a3iZsbjLR1gRsQcJ/sC2ZR1KCnB8ajjdcjk6OfL/G8HFelXpU0e/tQYtp6o20mU6v0IcbsRGuOrcdHOJLEeepxRdSHt/5B4YMraGh3BmA6zYx7EAZwcrJcsP078Z38/fKGBTgtribeWCVFK2JRiHj0EbFOYhCuE7K5q557y4ysehBF3L2wcc4DZCF+Tld1l1vEi5Ppka0VhxHH4AcgY4Gt3oi5wiX2DM+QGkB/omNX1X97w6h1J8N0PHQCiRo4PDsV4POKkWWO2lH7zqxXEUZKZSco3q/SENbjhOT3ZdU0mrXvnML+hNTiYsRHjuaPdXI+nHoS5kxXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXzJm/9ejfx3vg4dkBqqSjxSiYzdYx3bO11i5yYL+8E=;
 b=VFVh9TOEFLh8v5y/jFOuJd6eTi0pOXc7btcT+FpGoImyYUpSAiYM8bX2fFpx7wt5/58TnMnst0XGTUh9tiwwmP9Can5mbqZEC6fkkFXwkL40ehzf1EC/Xfnp+Lsxj3pkLBGITlJGqiIsoAshoImpslg86rG/C4V34CL6/LoX0xI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 03:43:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 03:43:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Subject: [PATCH] mailbox: imx: Add support for identifying SCU wakeup source from sysfs
Date:   Wed, 12 Jul 2023 11:47:55 +0800
Message-Id: <20230712034755.2676008-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd1a40a-37de-4223-4975-08db828a1c4f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7WlAAcGjTRNSxB5ShDxQ7PUwQAs51MDmDjwNkHpL0EVQYTzgAdpaXi8+GfEAEa/Km+ePW0UVtMnOmXE8+8SCauzIFtQ5B86/75s/Fm5zt1N+07qsOTF/nZQ2FT3wB6aFEw6lOK8M8Ds5G7dl2Kz3gzMOTiDc+0XDMBQnwcB2sy/y97QcveLaVXMUK6nq3uXJHy4cTIku4pMUVwrJo0w73LIjN6EKE173yUbjWrBowIqpv4Dqdd3LvRAnDxAloSmb64UNfLw0vyL2igFeuAx1W7dFD+PCLwBawJoXVJxwaREtDJ615q2LEVLX9F3AnfcxZ+lDdeAjhDL34EEzY1M4HYPtSUhZ/tbi/Z+B0yE+Fcbt35WLllueoFG6iIuq9glVJbj/fyuAWv3A745mxS3SD2zHpU5KoJgzuVvGDYY+XjVdm0x8nhtVnPW7oy2LlfSSuFcL0H/wdte8Pmi0t9OqbZV/R2hh3dVOIDId7fofGnbJEwi2HSQObhUqUP32hWb22m98jt2+AzXz4SCrhRoEL5RtKBH8cgjiKg6S+099f1SmB7Njlc9zSezIuTiOn6kDeh1juU8GZuE6NCwyZyGVsNEiB3gWT+SNp5u9Qb/RmsOIK1maKLTj6MQQCQJLU2I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(5660300002)(316002)(15650500001)(41300700001)(8936002)(66946007)(2906002)(66476007)(4326008)(66556008)(6666004)(8676002)(6486002)(6512007)(52116002)(54906003)(6506007)(1076003)(26005)(83380400001)(186003)(4744005)(2616005)(38350700002)(38100700002)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PncPeLXrRdwpGfWkevjHFuT8EwqGtduQXU5AfafP/2wGuB5zqzHqqQT0wyGg?=
 =?us-ascii?Q?G1bqenHshT4oLe3uPnJfW/6gfzOWn9fdJXjW/bTwb6nviX2gIz82vCt1A/Yx?=
 =?us-ascii?Q?9sSRPIEwk0GwALNQsucAq1Uoy1ITt2jZmSi4ccChJd6IEtySOjiogYolzVoj?=
 =?us-ascii?Q?kabbtisMrh/HpqbxnGDP5hTrhZu8Rok2RYLvZPCZqXS73NQvRtaB2dPqElUM?=
 =?us-ascii?Q?I8wLUMOipkk5pZNSkBYCB/54MXbyYR2Y6TpiJ7bHMqNRK5mnLJb61vNp7zFH?=
 =?us-ascii?Q?51AdrqZcr0zEFF5EvPH54clinuWSyCPA2fSDUtJ/1PcIqFM2oaWEQyp0qlkM?=
 =?us-ascii?Q?CqCSWYCmWAthQEBhWJVlWMeDbMu5NsSEx19MaTCt6h/pEy962WjGG01RxtSZ?=
 =?us-ascii?Q?wNnXbdCLZ6xh2pWIyQsnckV3uxGdtFmrCvUMLMYhvHbzYTgzXd3hivvpAlCK?=
 =?us-ascii?Q?Vp1cY/+lhNyckjeoET0DibPJXkU777dbcZTFGuxmcOozBJks5KYz4c1Emz+O?=
 =?us-ascii?Q?8Kiz6FhyHIy/nPPa8Wi+E8Hy4P1100AkRO44TDpTAdakbuHjt8PrU7wvbuUh?=
 =?us-ascii?Q?eCXBwNe5ETlhJXjFOcYwEA4QsmLd3sqAWvqzxUJeSeQsA8K/np5maz9JGCdE?=
 =?us-ascii?Q?+QYFizmTGbptwPtG88DoJNFP6Y+JjIPGlNUbz+eBXY/uHcXf/CFJO/rJQb3a?=
 =?us-ascii?Q?13j99FJGvIvMBm+SYUTnRyzBaW4xphfnqXBjGwM9lHQv6L+KDQQg2JvApBWt?=
 =?us-ascii?Q?55nm6Zd3D5vpZSXpOBJjMlcDWvpvQb2+7oLnPL/6bCxOeb2mUunARrfVrtDi?=
 =?us-ascii?Q?Fty2Tnx4QQ+3IFGjoQ7tba4+JPlLBqWjXHOOQRJhqdgehJiWX8Rcc008Bo+w?=
 =?us-ascii?Q?R1iaSyrNTkJ1cUwbvAZpw51Xt2GX2zU7YSdDZNtSiC629ygEMS8ubmji2IFF?=
 =?us-ascii?Q?J9/0S7REamYuKEQn0/cR7W613PPot9dpwmdCUphhrRN2WixfidD8pZHvk526?=
 =?us-ascii?Q?2/VwJ/zc+cgmWQwCQtTqDeCYpJHkunvqjeSnkB+fMvilbFsJ1VGtTCAx93iv?=
 =?us-ascii?Q?4FLkvZqo4yEOx03I90KtlrPaC6XA5eN1FApAqKVS1uGzoVwah/0XrsWxnA7c?=
 =?us-ascii?Q?oNY9qHwNgBrBjFy87/ZQ40pFyohOn1YfStOK5arUJbXKrAizDeNrwiosfOur?=
 =?us-ascii?Q?G2wk3ZDnMgIR1Imv74Lf2AK156K0Io23cndgF1WRIaN/4O/9y+j68QUu/75e?=
 =?us-ascii?Q?to+N9h53B8wWr523KYNqlmyXruqNQkH3g5rdYlc/MG34Qz4QW0iMq8gSPNRK?=
 =?us-ascii?Q?Y3Lt7rVZNG21OOQj3H8WQ+rrxCT+OnEp63WzQhHTspQXWS5es78Ue7Kl+kTj?=
 =?us-ascii?Q?KSjx2vCwpQpiE37Kk0YgHm4hdtGsbuoD0CKS6awczolK8xbvTEKP1FkVm/um?=
 =?us-ascii?Q?sKnxTFhNGz9mcUpcA/II8Od7/9uajVD6wOXeY8yPL/GlJ3Kbr1Uc8DYAieda?=
 =?us-ascii?Q?9NBRx9gvxlGOC74T0e4WkiscACInSgtJoYwRb0C4BQtTeQ5R8Jy3e5IirwqW?=
 =?us-ascii?Q?Ei/yMYQcKWt8Cw92tKNRJGhhcNexLtMHw2EvgeSc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd1a40a-37de-4223-4975-08db828a1c4f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 03:43:09.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6goESGeY9htAWA0ghDQlKyp4VSxu0Ru+/lFiI+5CuHTkb7AmXKztow/swwWaLn3b7efUAua/ya65YM7R/ixMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Record SCU wakeup interrupt in /sys/power/pm_wakeup_irq by using
pm_system_wakeup_irq

Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 20f2ec880ad6..0719b9cfba97 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -531,8 +531,12 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 		return IRQ_NONE;
 	}
 
-	if (priv->suspend)
-		pm_system_wakeup();
+	if (priv->suspend) {
+		if (priv->dcfg->type & IMX_MU_V2_IRQ)
+			pm_system_wakeup();
+		else
+			pm_system_irq_wakeup(priv->irq[0]);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.37.1

