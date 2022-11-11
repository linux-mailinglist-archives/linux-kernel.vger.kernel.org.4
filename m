Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1036251A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKKD2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiKKD1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:27:44 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A43654DD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:26:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ5iTgcNJ8ADp9d5pmtm/lui5UhCzS5ynIdWW+TSgnAq/0cYEYdge11fja+qkSYLunP24fzx7HUtxOPUq4M/WqvPbbMENco456Ow1BBqreDLtKT7K5/wX/xuC/WYkg9OEhPe+IuYRENdOXSXAwFQdGlcTkm3vl2LGRqWgdLhOsP/oeNccHbXmEbakGnb0t0gRHbk1PGULl8XiS+miEpu+vI7aYci9j7jSAQiNjkNrcVuRkR8kKugINhpQ24+pCcOotZ1z6p0b7YDhQeQaw4/vrrtFexP5xUYYozbYFLyUJjz3mLMcqiNR5yjDLK+IvR0HVkbeSZr1LeGlIVz/M8lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQby33EV02onxRlFM7akkEkA0XvFpAwKcx9wYCEmXOc=;
 b=fMZeJjzmCeZvJyl8/EebwybnTjCWzsKR2WJHwqZ5SGYqa5/X6f37nHb1iBMfkpDUep6WsE4HNgMGI9dayEWhyEY29vvP1xVBC8H2T5MexrTc5BHRXEXWuchH3XfBRH1hM8F+Zd8rfRDflAm55BlFjn7fC722c4bDoxC667wFg739VS7ErL0YZ7xkS9sBaK+9tfAi7MryErwKdMwsnDzdYRwWN8HD0Xu6SkaiOB1dMvmHKve7yiyZkvAB/vGpe189XaGFT5nMECX/1b1TlrwbbjekbuNflt7G7v6uru0V+FCAG4KYnK+RDUrK5DcEKcU3aZePketNNSr2TARakZDiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQby33EV02onxRlFM7akkEkA0XvFpAwKcx9wYCEmXOc=;
 b=BAraR3lk8TraQ0PVTA/2kyiJo3hNxFgWgkmkbqN7mWkyvLveiKUw0k4dIyLPP1ICCjx+s44rn6EvAzDVyjAopfcA5xp1v+45nmJMRN/bQuB2pIFPHj1b5pbbUT9ZKA5a1ZBK9k4YaD76ho+CcEeXVQefrZdFMoRONVRibyQ7Nfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9321.eurprd04.prod.outlook.com (2603:10a6:10:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 03:26:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:26:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V4 01/14] arm64: dts: imx8mp: add mlmix power domain
Date:   Fri, 11 Nov 2022 11:27:58 +0800
Message-Id: <20221111032811.2456916-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ba9a4d-3fb2-47d9-192c-08dac39490d6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tpsdTf8Rkqs6NG7CLPUMDjvMei5QzAtCZWeCjgMsdl5W7pEaMsE3pmCwu+YOzrWLt363XqBh2MwVeqL6HGTzGeEdhGAP9ROfY3S355h9Xp7ydngd0ly5YRdm99qkZY3aLhqQCT6RF4chhBw6qNiDX/r4TLG4ld/kOxtXo+tDTHGlFS/Y/H3yCbNohdeE693Whwj0yhduPrq1Hr1jhCHnZNW0WdAGatwTWUD2pD7WQHQukqczzTJ6UCMlsP8Y8BINeYJIk6E0twG0Na/MGqT5Z6TYuef9oPAH6fSJu7G8Ysaaqs8SX9CI1yqCVc5JjrbIrA7uYIn87OB1lPt4vaNXhTZZ34+ZRnnyGZg8B15vIXjm5Ak0XT7HbiI5gIAIM4W6H8sgalAWl0S+X+LCAmgcSMS6emHsMZn34uE/o+EelIWgEUQ6pGalBZ1j7xwLO+H+9Sma1pO/Y/+5J0/ol0yF2QITulIgSMOl8xPbOhTepmWlWyvqXgcJIrC4Tia9w7tCuhdshY+PKl9aRKexAJlLzAxAGK9QS+ez0/xC5p5t1sIQ0WCSCqOHs7o8UmCt3EK1OL5SnQJ61DEun9Pjvz3b0FinWlX99PnW2E1Quf5vBiVCvU3WiI3S/EsPHBZ3+IKT85J8z/ttwl33VZd2ykoPAbG4HoVYDkF5QerveaiN/rFRBAe5x81j71Ch/vjT3cu1buG2NyUU24IkBBljKwmYKRPHvRpDU+NizJzvMvWZi4XJlOfgS85ZJYX3Vfn9WRY7sBeOFg0F077r686hpbZPk5IB9lHl4F9naXvrD7QcWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(83380400001)(86362001)(2906002)(38100700002)(478600001)(6486002)(26005)(66946007)(5660300002)(2616005)(66556008)(6666004)(41300700001)(54906003)(316002)(66476007)(4326008)(52116002)(8676002)(186003)(4744005)(6506007)(6512007)(1076003)(8936002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3/06mLGFt40djVlK4RA38NfpYjInokw/75jI9ZR86Z6iURImV9TcIzLCRiEa?=
 =?us-ascii?Q?aTiIxrBTsAA7s/J8tAOw0XlhLjt5hVIPormqnZntshooWwlYersf112Djh95?=
 =?us-ascii?Q?622o/OTLQm65f3VMNcwEJAEYs4bg1njYWIiGfIxXKQl/S+KeSgvkBdzLN7rM?=
 =?us-ascii?Q?EEsTuxJhTdcJlZv/YWU8P7ETe3dBHQ+ob0zk9FBTp7xfR7k40ooAZzZ3nE37?=
 =?us-ascii?Q?YnQ7Y+vIcGoJB5VX+ysXbUfdi2laZNRc8r4K+l/0pimoFby0AgNcHi3jhi2m?=
 =?us-ascii?Q?nZDoUEAWLvusxyZ74oNNBrzyQ0ec00qhXH9s/at5xtokzbBAiy1l8ZioT1TE?=
 =?us-ascii?Q?XJrlyTHmXkuPfWfrZpifFazQXZRAfiqTypjNt1etnZsQYAq4R6IYD3Oz7gDC?=
 =?us-ascii?Q?oaf8j6QI9PBOpK4AV5b4/1R5ZCTJQunnKkfVaWp7ViXbqaMaLKN/AOJodEMa?=
 =?us-ascii?Q?+XFacT8g2THiV7H4SgJSgnUAEWyjD36MBBJs6wNlDRPm0G22yLujrhs+78oz?=
 =?us-ascii?Q?FMYN4gyeL2XSyn6Mvx8vJ4mkDttcBx27x0/OIgS3ut3Gqdm2qObUdX7UFYqe?=
 =?us-ascii?Q?EZtTtkZJdKcZBPBhL+TEhvQpj8HMvn5xKixi+76N8qZsqfbG95LdghCEULYn?=
 =?us-ascii?Q?oMbniTZnViCYA6TMRqip2Tge9TnCwAcuQPt5fuzni17jGkCit1HDaEyrwH0p?=
 =?us-ascii?Q?2bgXBghuMPKMTE2DxJvMYPy40iGMkoErwK16b+fUDPk9V9X7yt0egPzuV+/T?=
 =?us-ascii?Q?AKoIJPkl48zW+XadUeBQ7lcWXpFeRfiSiuphLGg485+tClijWTNDIlNpgrtD?=
 =?us-ascii?Q?URmhog1vGkdwF1QHGZuojIK4i+5eRDKnVtO6tBCpr0y2izSEepHlOhjZBoEj?=
 =?us-ascii?Q?psQZpjW1rpwKGNnT5ZTx8wAklY4/tjYhlaKzRJtHkdk2dfY+TvmmudWT6hKj?=
 =?us-ascii?Q?CVF6O8fEtPoxqhs0csMtRmO4+nGys51bngy39J45d7IU7W5xs+yXtFUvRFE4?=
 =?us-ascii?Q?tcHk0Ix1NvkTsL9q8mVQWoCAMyxQCQcCS61pcXcaPfmnNd/9HDgQNg416o9h?=
 =?us-ascii?Q?9h5wlNg/+8CrvqRZWysrlK5uD3gBzBRK53ww4/1DYK2RWsMdHb1Pd9VzlDXQ?=
 =?us-ascii?Q?h1Q/eyDFr1b2yr32uibhtjozYrWHF/dTd7ho+VMfO9cLmd/PlP0yd8jl9X82?=
 =?us-ascii?Q?F8lxeGpcB0/divGCziPSOW7D5YlSoiKkcjEvZwrzLJuvCmCz5LtDoja4b7NO?=
 =?us-ascii?Q?UzVTnUxL2UHz+YlQ/xiYoUlcSU6SSnSFThURcOBOuwtg4EMgK/RMKzUuimA7?=
 =?us-ascii?Q?bOf/GA3une10MSzK8INcUOPXDtTPghETzTUEN9OZW5culX1ysNsJ5Lc+VwAd?=
 =?us-ascii?Q?UghiswdeAaF/n5LJLAVKS55aZltwuXddShxC7Tvc18gT6OjLwKsaHUTsm8Xl?=
 =?us-ascii?Q?DsYR6vrz5Zzi8p1hO3i/kfmKWO/DCImwvAWjJQH3q1O8gZG3ELKQEB5uWvMn?=
 =?us-ascii?Q?kA8TMIBbpoT6aedgAO4I2fch4nvtJyUZOvXIpwONDsEIs3WIYernBCfB22Jg?=
 =?us-ascii?Q?4hgwR+jFXBqq6xddwQELXCwAoViLUnn9mv14Fexc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ba9a4d-3fb2-47d9-192c-08dac39490d6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:26:48.2153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVLUkgzgmBDcwjOFMfTAqCK1hhJ99eoQcjKLjC6Kc9j3nVxhJSg/lVHdK8IkSc67R/BDrnVLMRyp5pmsBBJL7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9321
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mlmix power domain

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 7be02cd100cf..08704d2d9fdf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -631,6 +631,14 @@ pgc_vpu_vc8000e: power-domain@22 {
 						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
 						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
 					};
+
+					pgc_mlmix: power-domain@24 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_MLMIX>;
+						clocks = <&clk IMX8MP_CLK_ML_AXI>,
+							 <&clk IMX8MP_CLK_ML_AHB>,
+							 <&clk IMX8MP_CLK_NPU_ROOT>;
+					};
 				};
 			};
 		};
-- 
2.37.1

