Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C6A682861
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjAaJNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjAaJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:13:16 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0DB4E505;
        Tue, 31 Jan 2023 01:11:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2MKTiCU57cr2p0dRam2oPY5ItzcD9DxucfrwfnyOi1usTnTKldkBOgHrHzPDf/REZTt+d9X7KlrQaTMPiBIPApAD8MBNswVXRyJpphOCyDoqcBrScnVgZp2G2OZZ6/NXerg8ZfPRImTCMKWrfaHMk9OOTvb+4E7IM4rTqddwpbRXfM/qipXucQSncGnTYrJtbIjZhQ9suM0+7Z0zZTXV99UaT4+4jicM2P7XebDOoOBL4cv9ZAxcZPVZK647NS85Ijq82mulB1w6bDdMBjEBOBiT9/zR2177mPuGTEmxejIRh7jPWOm7/UA3RU0VX2Qk3sfw4my8/mRt7HbT7Gndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSE4biS5VxyWA0FfFzjaGHtJY118yFhIC2CkFDOTDQM=;
 b=UhbTZQc9WWo04arGA383G2Ou4C+WzwiEzPpDT2H8oLAZd/jmbqetRStTSHDL3L7CZIZ8kWstWfZRPvW9AkpG0aX/YffIBf0cTf4EwH8NHaytF3cyCQiauQxM8gBrr7NCj3zDISStmzpNhJy4VloHMxAbAiblt8+7Y7nfMzv5mNi9uCT9B6ZXogg/lka9MFj09SyOqAvOB3IWZijyOf29ECSiVAWFwE6js4VdVzPCMXQmyAHASAvaFLf3NVGGNFFkk8P1tTbhaf5LbLc7qWM9MgywFJl7frb5XinrYFnEBMx+F6LNPz7hr2DcTmDGRwDP7C5EukiFF8kbGzy9fPjzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSE4biS5VxyWA0FfFzjaGHtJY118yFhIC2CkFDOTDQM=;
 b=LIkMu8wUWrdhgCUGRGRFdPaSDrZGl4mX7T0erbRwMmjmyiDP0fOtML6gZN7wuPn2h57Nl1pF+jkErB+q+sSVia0fzY5ANAK9LKbjpIkWGVXuWA2f/Zuo+V12QrWNcK02I+tMsNHVFqDjS/PusrsxmwdqyyoHtIENINbg6dl7o7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Tue, 31 Jan
 2023 09:10:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Tue, 31 Jan 2023
 09:10:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mq: update usb compatible string
Date:   Tue, 31 Jan 2023 17:11:40 +0800
Message-Id: <20230131091140.3696808-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 182f5c90-5d0d-4a63-5919-08db036afbc0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8NHetC2/3t9pHw0U4/tLM1rvi9HZKEREh68FzdH5k1F6CPCxXJFherOsasXEm41yca1KzaHTIqf2wAMCQ9IXRZ74t7POBK9pbRbJ6OhkY9d8vTQQrwSWexDcP1362rHlzDZIwLZ0C3OYROHWuZOis6/BqWN2BhMLn4n/4igh5sH1dcUNpRo0Di43x2z5diGXA2UzHthJTJyQ+xQUgHBr46MBtJfJHvxPBNjhFv/cLKHRdl93xzHzMsd9aIORhVZfFSEqXE1e/3wEqOGHi+o0V/OTknGHP5U9Tfv0+BrcZw1fdJLrPLB5nSK8XfabagRr2L5DxoiLh6+DzDL6qfCvdxtfew14fSwR7R5+jzkCOiKlUxL+ozoS0pUbOGFGfizEd2Ri0GopLaDpNDD5gpSk1NTxudbEt3OfhPjVfXbPW8sZhpzDUPCiUjsdz18yVWCzQuMMnnXrdFQ9bxYLJ5ykzyiSUYki8yPXH50+8pNafpO5jePfPrNfJ4a0djlI5PGwDWIxlPoFpzSPZygkjwjdndIIcyGL2Vj3cKSDmuvqqR4zDrzt+y6PLipSw8+qDr1NrawiKF9RB3xZ8MjVDM6tUL5SUKD7Ds+sOoQlV81RM4sm+7lx2XtPLLfuejuTzNAznMAg3WhSKXrIeBasnyVGbLEwQnP2PdMt9fRcyK8bNfk/zp4MyGDQiS+EhOl5XqYZKvh+cCuagB1zJa7DjB8DSz1Tv4FPQxVwU8Gp54KksY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199018)(41300700001)(8676002)(66556008)(66476007)(4326008)(6666004)(8936002)(6506007)(66946007)(316002)(5660300002)(2906002)(52116002)(26005)(86362001)(6486002)(6512007)(1076003)(478600001)(83380400001)(186003)(2616005)(38100700002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gk7h/zPSSMJdzHi+FkCtquLcAWwPDfeWOf5JaN+RP92ew5HGk3prNQMZYr/f?=
 =?us-ascii?Q?PHca7YxS8hE4zdD0ZsgRgbUPActqXcfoMmJwggfu/J5TN05Ds66Z2dCY4sgr?=
 =?us-ascii?Q?LuZiws4y9Dy0t6Pi3J+XA4fTxXglNXP9vkeclqDkHEZ21KZhAqPYB4C7Uq+j?=
 =?us-ascii?Q?bpWBxQBgjV7cdg1JnHWzbqTjY4nL35HCwfcanUuWF9YhmLLayDLfvgdK+t1u?=
 =?us-ascii?Q?OQA44LGmGXZNF322yjRnXnJQu6vQfP5FSfT6eByOjzEg5L2PZnhCmo+ZC6j3?=
 =?us-ascii?Q?RUgMhu9lC1aKxbSwEOnYrxiDWesGiqmIFTkiI8XATc5TIXD7IgyaCJeOqzRk?=
 =?us-ascii?Q?LZBLq+P73oCZZEm5EKAA6H35FcHmo5s/+WrDV8/X+dTLEuHyx+eopcuEtSTF?=
 =?us-ascii?Q?zQ/6gKTKbuQVB0/JcbaDvcAwyDvQa3J3ySkJc22Tl+SLbHZ/bUdH61IJAwNp?=
 =?us-ascii?Q?/bm3mFNOeh7aGGtPoqo6oUBFi/5ePOkL0rB8Glg0z5hzERxJfgBgAiucQOxz?=
 =?us-ascii?Q?7oHbDOeTqFzRK4lw9HsCJ3nSsziZWpSHVNtjS37YnfYm0RvfLRgbl9ArtkLP?=
 =?us-ascii?Q?7GAu/Vysb92THmHkwNetB2uto2/uTVz3jfsLVYs51pN4FJ+ufEa8je/DhHMD?=
 =?us-ascii?Q?U4lxC7rf0BTjXHp6MZLlokZSwtHG0gmW350B3SE+EMWrTnAAy9TKqT9IYgtt?=
 =?us-ascii?Q?UqT6zQLG+awIHGtPbb9NsnlpO9JkVwlnC71C5lgX/z2wmADELCp3sFYGCuZI?=
 =?us-ascii?Q?A2GJ/shbe2glYI6DScfzDtt2pDSDdxQav7qBp8+dqWYPq1kRJ2k4EJMypoxT?=
 =?us-ascii?Q?OmaQtW4P7nJZ3UgvmxuW6EjoXG90H1aRxin+9my3w6xMuCmatvofuCJDpE06?=
 =?us-ascii?Q?nkjxsNco9FjPyLOd65bCh9rkU22ouFLmFVdnih9nx0goB0CWxenNyUDuiapS?=
 =?us-ascii?Q?ymwmSe2a0i0QXxF/TrTfnQHB39y9LzYAS+I9hl62+MRFz5dGzxkUfY2AWyvq?=
 =?us-ascii?Q?5Ilu/Y04ElrozquKZQlL0r+1DP+tLrKwPfQ69a6XbVzM29oSssRmaujs4vXy?=
 =?us-ascii?Q?QYUVaPeyId59lWjyEpdpR/mcb8lJo7iRfV8CdwjH6mBmrUUNUjDMi+4rhJhQ?=
 =?us-ascii?Q?Em4gskmDRZqiY6VD+AxVSniihDs7vHA+Ggj6b2mADRDcDpyh721PnqevpY+w?=
 =?us-ascii?Q?mj8iMlP/ltNWf3j1SRM2SFyCy1KUEw2bAu732JT31r+68tuo+48n4ARhrRp/?=
 =?us-ascii?Q?frt2FH7ObUKq/NAOjD8T4HM86echsl4t8YGwAiyprqmWlvwuHyNUW7d2GvlZ?=
 =?us-ascii?Q?+olGEdTxmWHc5jeBZ5j4+X/MDkYIHOG/zl7KErh9gWvF78vvNeKlLXoSbBU/?=
 =?us-ascii?Q?XdJ/PsqS0uXlw1arDwT2t7wYkvFRAFakni8CGhDMKFblsFvK3e/RFY5DYfWV?=
 =?us-ascii?Q?9Q80KHPG566jkIdJYQHfPeNBYhYCtqrtBIbMtY7K9WjsQBuanw99NwdedjP/?=
 =?us-ascii?Q?Jw3QiKvzg2lHMvdfNB3gqpF3es8iFcB6eavYQ2U3g7ckD9RJcprDkKWrlS1c?=
 =?us-ascii?Q?nljRvYqFmAmO0+sTfvdGw+anNhs68Lmq+A4BWys6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182f5c90-5d0d-4a63-5919-08db036afbc0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:10:23.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvCnQ4KYf7yt4uJJJxpwidJ2bvog/YTBmZBXWJPwo9Vd5DRsT6uHpI6XTgx1jmYrLYhgx60DeTAJOjN0E0klXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8539
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is no fsl,imx8mq-dwc3 binding doc, no driver use this compatible
string. Drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d59156fdee0b..d308f94a7c52 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1431,7 +1431,7 @@ gpu: gpu@38000000 {
 		};
 
 		usb_dwc3_0: usb@38100000 {
-			compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
+			compatible = "snps,dwc3";
 			reg = <0x38100000 0x10000>;
 			clocks = <&clk IMX8MQ_CLK_USB1_CTRL_ROOT>,
 			         <&clk IMX8MQ_CLK_USB_CORE_REF>,
@@ -1463,7 +1463,7 @@ usb3_phy0: usb-phy@381f0040 {
 		};
 
 		usb_dwc3_1: usb@38200000 {
-			compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
+			compatible = "snps,dwc3";
 			reg = <0x38200000 0x10000>;
 			clocks = <&clk IMX8MQ_CLK_USB2_CTRL_ROOT>,
 			         <&clk IMX8MQ_CLK_USB_CORE_REF>,
-- 
2.37.1

