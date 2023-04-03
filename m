Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D398F6D3DD6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjDCHJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjDCHJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:09:04 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AD4EF82;
        Mon,  3 Apr 2023 00:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXUOhZEX7IF3SQVRZcghdkqgVo29oyxmPBnW1MKpsF1E5MFwtldYk9094zTATeta6GewNRjM231fAUFUXX6Oy4USmClJIC1Pj6Vzr2S4Agb4fd1NrO+zy0QikDiM7XA05Ea+7zNN1E7NmmDVGZJpLA7dzFECsBxO7vecKfSpkuBWDtOrYANhUe+bxJ5WHcwqmWVnsz3EUYV+uhYVrKN043IF9Yj7q67BaFwZ+nkSNfNxNXSElNSHldsXEA5jitu8mbZ60eY3gHgDNN5QJiWOhyXMxGjOlnJHs7l/gLjotsJYWYzmWDL790iYd358tJrzd8lhKikcpKE7c6R/eeq42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETuJofe8ZfN7VX4BGmq/281L79ouoSuTQv57kBHlu/s=;
 b=ebEZJGXTVvn9Df5XGr1t3E5Cf3c77QfRrSKOiPEZj18PeM1oiETSLzHKcLHCQEzr0yDjXiV2+DkwKc7+StZ4CVJlJfcxJbCBbXZjHKUrHRDqin+SIeiKsDVymhlSJB23RbWHHjlcRXbeeZRfJp903c9exetErEUsY4UcKvr+VZr72N9Oe6klv972CjoJO9IrB8ie/Kg56iCDkT0n309o/quNIdYN3tJHobyqv1j1ZRKLsxG5n0ujjG7O2o42UOWppEkuAg0dvBKM/fYgKNT9zHI00Dl5pzW80gJpctbIdJRqX9rda/6o09mwt3Sr0muIAgeWL3A0ZbnRmX8QrFvm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETuJofe8ZfN7VX4BGmq/281L79ouoSuTQv57kBHlu/s=;
 b=mM/N8wf9OUeoY2uB8ZCBOLtN5vQbiPYH129sZCZyXTyBkoGD7A8xbO8T1x6/qknd5FLcFrupq2/bylPlErtR9yUayKqhkyNJd/P4y9tNjnDtm085oryONMzIDGVqo0CR2RM9kG9+7WaoQa6YSCb4NALXEl//kVHRMybve4M79Ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9457.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Mon, 3 Apr
 2023 07:08:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 07:08:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Ye Li <ye.li@nxp.com>
Subject: [PATCH V2 5/7] clk: imx: imx93: add mcore_booted module paratemter
Date:   Mon,  3 Apr 2023 15:13:07 +0800
Message-Id: <20230403071309.3113513-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
References: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: 89da437e-b1a8-4934-a981-08db34123ae5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LDttBXiIyfegUrBoT73GKj4rcTtcW8lhjDu3vgWhVVKk4VVVb4i56WpYlLClu1kXVuFM5HLskmvwaYt+T3D9jrMV1femnaBhFQoHUtXtomTftFSsQIRC9l+G4n3ivsv+TWj8Dn3VbiuhU0v+GWXsXKBj9V0ecz+zXOT/SLRBe18fpyqFNnaMNUq4L43z1+a5zqmzX7ehO9vdxrz9tEK2AzfJ176T8tC5bmpDChZ6Pf5n0YpL0+XUh9MyGSmcDm9O/yh/BUVxnChbSUVp3nM0EmEsnxaYQSb2Wuiowy5XFP7dkIZ71Lc4m42iARL6fBeLMCv9lydfwebRGhqc2+2LZitx/U4lcdLJEUxoz7IJIpGvaOMfmxiXkeFU2TV7Ydm3MKf0rDv5wvLxvoa3pYTz516AyG4xCSMX+pDpcKuxWLgv+43SRFl3Eu7RoqPYnByay/qdFXLvkgcgA9v/zdddP+L05aY0zKUwGKGsirhxmCIDir3txHUAnzUs6NRpl7Ls7zRnogbHkhT1czor2QAjat4/zumKM9H8+dJSnPYbc1BlPJiZytp420WSKZCcX3+/QKHw7B2LobHQ3dG0js0L2qAw7b/Nw+r/pruXUh5g1FM2GXjvxW/hBTHumgDzLzA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(8676002)(66476007)(6486002)(4326008)(316002)(66556008)(66946007)(54906003)(52116002)(5660300002)(478600001)(8936002)(41300700001)(7416002)(2906002)(86362001)(38350700002)(2616005)(186003)(6666004)(26005)(6506007)(6512007)(1076003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ozYtixaN3mlL/TwDHulULJUaJBqegSHSwFohlcDR16JozZvNrvVUSVGKX0Ie?=
 =?us-ascii?Q?JsCWyHwObEawgnu8asSlYJIsreUXf/D9r9zMgk5/dL18hQfveMLlIchUjgun?=
 =?us-ascii?Q?pOqoN4vDw0XrEv+meYHF/qjA0c+kw7Gi7cVFfcgGdHT7F9RcqB2G8I3bBZLf?=
 =?us-ascii?Q?GkvCbnvQ/HkBl5FMx2fHYsQV+2iXi7+fXT6n/250KqkXTuSZZ/PLjDaqE8m7?=
 =?us-ascii?Q?dOUFz2Ll/G+ZPPAcXgqrwxtei8xG5DRtWGbXNVCiACW3Nr3XIIsjnCycJGEx?=
 =?us-ascii?Q?XjP81rfr6bEK0plrtAPoYh0aUIngher9T3tKB/0OInD9L7XFgLqt7b9jH/xk?=
 =?us-ascii?Q?krau5AA9krd0OcDcLQaRFzkekPPyFe43Cmo+jO1gGKxV34cpuuk0lRgX5rR0?=
 =?us-ascii?Q?XONuPLbS3ca35vmXqOsVb8h9F5XpeshjCx8as8MgI2J6N95aGGNwXOOuUTrH?=
 =?us-ascii?Q?v+x0s1/Klrqrr+dGrCttskNAiD0yZQ7KgSKdjP6jU40s1meurb2EsvB6x5oK?=
 =?us-ascii?Q?vsHrRdMG04rh77KTxMiE+/318xT/e8npjV3/ZVHoR7u8BouOD5EwDNchTKFg?=
 =?us-ascii?Q?C1n6RYnbF39DnINcMnBa9L1oVSjBnd9hcGpR4bxJuV5GzT9gZ/9mSIG5xdTO?=
 =?us-ascii?Q?ggHHAw9N6AYsS9Y6aiK0z3uvwNkx/IJ6By09w+E2kEEDpp6Mv/OPgYa3WtjL?=
 =?us-ascii?Q?Vvmi0L0Z2XXn4aZk1ioKSc4D+ea7ctLFUEv+J85V1ExUmTyCXUXVBllIajy4?=
 =?us-ascii?Q?6AuA9YFIfNBF9C6JQIuaDu7Okdx7oXrNRvYDQ2yzZdwgPUJtnp+JEKme2pEo?=
 =?us-ascii?Q?8eD4UtjFRgVlXpz6VSmSUs9wbYic3t20sbZiKfJDs4EKf2/wh0DVjwo+I0Mi?=
 =?us-ascii?Q?YgXJD4seE+wHOG1YqNgxf84TKmPOvnl56NGPtKvYA9AMf68uCzBSchIVQlUI?=
 =?us-ascii?Q?FYhZ2e9T4gKDMiFlAnDM/zB1khe1UL97BTjwD3vzssRi0uZRM2qmC6lsM7FA?=
 =?us-ascii?Q?YuEQO64Og9WRUod4WCbfU3Nzkvw3D48YwOqmgdgUcduSbUwHTKQ+GNVjXtMf?=
 =?us-ascii?Q?g0I5sbOOig9Rv0N+RMc2DJZxZJv0sibis+thhevnidaT53buoRLrtHHK3fzF?=
 =?us-ascii?Q?xI+qed8qtC45FGqdpozPNqUGkAso1106BlnIZIHXxZ4mLMbtNtnlVg8LaSLs?=
 =?us-ascii?Q?lphgM04XLSS5NhACq7EyVjOoSVhppRXOPl2H+aXlZ3fdqKwYlVPRTk3gj/L7?=
 =?us-ascii?Q?ktTe3duF/J+7/jr2033f2e0x5ynFAiK0qXP9N0eB98JpDwHHoKxUjbuFgSFZ?=
 =?us-ascii?Q?mJN6Qr88juCbxuj16bw09Wu7ZGwUupas4yDVEYg1xFxCY+/WOU2IXoumaFBE?=
 =?us-ascii?Q?cOlYtgz0y+PjYUn19yS5a+YPON0ScgRTOGm7xXKLnwXc971CwNVSw/EBveGc?=
 =?us-ascii?Q?9evrdlBWcjJ1vNo3WLiFWOzxTMt7JISiEvt0Oxw6v2JFZxNczNak9oprQtJn?=
 =?us-ascii?Q?7tHG2hiP5qzszjMw0TOY7T/QjLFFvryiI/JKbEWnKAIxZtZ7rslFg8bRXTbw?=
 =?us-ascii?Q?gwNBHOl/ll9i7xkil16b5VGsSYWl0TqDfKCVuW5n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89da437e-b1a8-4934-a981-08db34123ae5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:08:30.8275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZd9YymJS8FRqKLJSa0WA2+Hx7JJPY78PYzwHi5CIeWiIEmmO+PM7NPyA6hIVZ76LGL4Cd9qWp+hxLCXS9Jgmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9457
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mcore_booted boot parameter which could simplify AMP clock
management. To i.MX93, there is CCM(clock control Module) to generate
clock root clock, anatop(analog PLL module) to generate PLL, and LPCG
(clock gating) to gate clocks to peripherals. As below:
anatop->ccm->lpcg->peripheral

Linux handles the clock management and the auxiliary core is under
control of Linux. Although there is per hardware domain control for LPCG
and CCM, auxiliary core normally only use LPCG hardware domain control
to avoid linux gate off the clk to peripherals and leave CCM ana anatop
to Linux.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-93.c | 8 +++++++-
 drivers/clk/imx/clk-imx93.c        | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
index 74a66b0203e4..81164bdcd6cc 100644
--- a/drivers/clk/imx/clk-composite-93.c
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -222,7 +222,7 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 					       mux_hw, &clk_mux_ro_ops, div_hw,
 					       &clk_divider_ro_ops, NULL, NULL, flags);
-	} else {
+	} else if (!mcore_booted) {
 		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 		if (!gate)
 			goto fail;
@@ -238,6 +238,12 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 					       &imx93_clk_composite_divider_ops, gate_hw,
 					       &imx93_clk_composite_gate_ops,
 					       flags | CLK_SET_RATE_NO_REPARENT);
+	} else {
+		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+					       mux_hw, &imx93_clk_composite_mux_ops, div_hw,
+					       &imx93_clk_composite_divider_ops, NULL,
+					       &imx93_clk_composite_gate_ops,
+					       flags | CLK_SET_RATE_NO_REPARENT);
 	}
 
 	if (IS_ERR(hw))
diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 8d0974db6bfd..de1ed1d8ba54 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -352,6 +352,8 @@ static struct platform_driver imx93_clk_driver = {
 	},
 };
 module_platform_driver(imx93_clk_driver);
+module_param(mcore_booted, bool, 0444);
+MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
 
 MODULE_DESCRIPTION("NXP i.MX93 clock driver");
 MODULE_LICENSE("GPL v2");
-- 
2.37.1

