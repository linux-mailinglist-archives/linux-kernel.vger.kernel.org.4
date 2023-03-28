Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54EE6CB689
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC1GGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjC1GGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:06:35 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344F22D73;
        Mon, 27 Mar 2023 23:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHGsFIYWCBt7bulu81JHUsSZGZB40Xp1XbhuC3nPiCpO5JEUzdPWI8MytSxB1vFk4eLZII3UueldnnivZ8avKj8aD4AsZWKX+F2R4ruhZyfVFrC0FQJDGdYUCqcYC3kPeZzCgX2xrIUYZqn18O0zsDjKFKOYPkP164R4CxYfIpanwyisBuUz4GooNHWOq5+8N5N3fI3bpgDNFmGFQVBGxTvZn6657r/bYk29JKJLVN2gsYiDz9hStXCCsvTSFd1sLSFLbWcdjMir7IadUUqYbrmC61FAdbQjqHLPhhDwYsn8rKQDQBhVX3FuydBwPvhG9iTFJzQ3RSQXw0A4lcGl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oikn2s35fucKZvH65NC/WPoMHrcbh6tZGnPZIOOAfes=;
 b=Ee+psMa6yMwvnyahqDWRPonuiR+jb3zQq8g920rIoOmYksWbvRQ77J6inU/gOM0PstmRAKdPKnExK9kALxMqqWTiGNX8+w42HCCQXnQ0ll5AWcGH13wu0bOwdsMXh8aMm5fm+5MyQG5ECA5fbpU7XstV9ylIG0AUksHwl0P8D3+bwPDTRvZ34FzH6yjyHq6ENFkSDQcfS66+A3D53smLH4n+OyxyON3Zi5pm/i/UCx3aW4ZVatP487XhWgZjnkB73ETLIJj89XZ7sL6NPdOw9Blvlwj/qbycOfBrjidxRuEVJZZAL0GRZC55g7Wksop+eNrLRlJPiGBVpsB5j6TDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oikn2s35fucKZvH65NC/WPoMHrcbh6tZGnPZIOOAfes=;
 b=cmwf/beNO+UvjeLoQiiuDIeMEx5BXtJEISqfMoa8Y3gFg4Xyn1CIx6NhmOaJ9dZgIMmA+axhBr4g/xh0NUi9z/7qTD8Ye0zr+XovlY/+qQh7ciZ9vBe3N/Fq94Lpj+J7lzOpAvlBFocu1g7RPNBlZ+TPAOALffOqEqbY4LkOGgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 06:06:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 06:06:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mq-librem5: add missing #clock-cells
Date:   Tue, 28 Mar 2023 14:11:23 +0800
Message-Id: <20230328061123.1984643-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 128d02d6-3a27-4899-00a4-08db2f528b7a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBCJw2vrCsCHAd+/cIToKGLMnwiLIy1tz3ZWUEekdEufdtHOBP4GcAjSZXCp45UbJ/iIVddxtkv6mBC4y5w5MeJp1ahKT4L+g1TQ6AW5IQJc05M/oao3rsVSR3Hk2fSWCbQuQuHZvwjts/YXcvszAQY7eIwskviHkHck9P+DvonDwY1BvMCoDcZZ0gRPT/NIL1d8RUm3OueAYOyBEY8DN26dV3ZLCVr7n4COIZNzYKYm8y4X9ufkKPG5c2kDalsB9FDyXkOEBLS3NooYsHG/laWLYlp5B6H3rJRqY87x1vGUu4cdfSlDVWVhmv8xYjapzxzeeTk3SnLBVQBHAJQEzq6yH4b1VEQEKmaE3Z9dVxRfwbjlPWzfV3zlxllUXZvLOAmtTPzIwW9cQSRefK1CyVi9VGQerDK+lpiaIBvAwDbulr+dn2CqZUvQdKJA74SC5iMYuoEsvwc3uihunLvRl4f76s0c/scNfT+JdxPpgZAAIXwCXF6mb2n+Sd70k6E0YaNqnofu7PZikx44Oe3WRMsBhlcaE1S2m3FnJ+vDjCGxr2PS0rhXtloIldYcEUberj/ZnzrQ2e97y4fy/E4x6tYxXIb2HTDWNRJlvjb3EmRrBQw9Mn4k5YvzH7/trL+zFxHpuS6leadQpeV/0YmHNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(6486002)(52116002)(8676002)(4326008)(66476007)(66946007)(41300700001)(66556008)(2906002)(86362001)(8936002)(5660300002)(38100700002)(38350700002)(4744005)(478600001)(316002)(6512007)(6506007)(1076003)(83380400001)(26005)(186003)(2616005)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cca1Bhi1BvMSPQ44g5DxDGEFbFeJLlPxJUBIdzhgJjmnqwH8SEIazgadyd0C?=
 =?us-ascii?Q?5iOua/M0WRW1lrNRBaW4asp8a5tkBirwN7tCVYx9F7niiVddFtg6RW59xiA/?=
 =?us-ascii?Q?H67qhqLrUQrW2WxC9ryQLQiGkFUPtLBH1hfZcxjZ7kHREJyXE5igR9nWHO5S?=
 =?us-ascii?Q?GTJxmLvz13zqRXNCg7LleNCU4WsBWUu7cLMowQiNPIcqGZWVv2BQl41qvMHU?=
 =?us-ascii?Q?38gHpBQHvFfJqKIjpzjg4bQuZwwKDXfeWKLPfRkfNmWqngesq4X3vwfFwqqG?=
 =?us-ascii?Q?oH5wDo+L/g9sw1o3RnRN+v9WovL940/171YrjiwXnHi7azXueu33Hjls2n1S?=
 =?us-ascii?Q?BNQJyG3tJ16FvM5UIuYZKxuz5asnXgKauAga5K1l4JkTmqaGAsqlV1uhg7j8?=
 =?us-ascii?Q?i8DCMxdMDKlJSs9InEZwJIPlgnuq9nJLvVJLUufwJAUuJGw4LVpar5fUWVla?=
 =?us-ascii?Q?7uDsMjQpODE7942mkcfpYSgyoOD4gduR+nQlB5WTevt2p6zNd6lvDJmUbH8R?=
 =?us-ascii?Q?RPaWAnEpKx92yJ1F2TbietHxU4W1F5A/QGsgZVFpTe907dd4tuimkIYdfaDF?=
 =?us-ascii?Q?1uicI1bJE7Iq6N0xmO1QuqcWYJ4Jq0hgCuMojCe+im38GU7o2stw6/ub/ofi?=
 =?us-ascii?Q?+0PNCd8WY5tnble5gmE9jzIWZNdyEdNMGWKbR7A776qCUDlggEZ+nNHNaeKr?=
 =?us-ascii?Q?DB+GhXNIrKhAHyZCKG9PLjWS9bpgeFzhMe7agDjCUMaMfkABzi4xjlueciVe?=
 =?us-ascii?Q?Dzi1UVjcCczf1w/gL1KjASMwWlq7mxCPGsmwPZ1XMKwjvGfijFjzjnt5Uceq?=
 =?us-ascii?Q?37zeguLr71jeKpp5RxuVa1c5AFFbgCHWKxJ8Yy+PnnXNLaJFQ1rtd7Z26LCp?=
 =?us-ascii?Q?i/sIoGzCFWzY6uuBGF6sKMk+Z5K3iNafxFNrg6jYhxwpQhuGh3fvOs9CaBm3?=
 =?us-ascii?Q?gocxsbni09Pvw4E52+3xu9QLgL+3nHlOSnqQDGqhJ5qX74HYPlzdwFzaeDYb?=
 =?us-ascii?Q?F6z5gUD+SUHaV46cgi0uyzTAJLOhPf8MIb6TBxcuIKUFYFdaBAmDzhOVibbE?=
 =?us-ascii?Q?BzDojTMmZM92G2lISG1Y66QiuQaxSP3pXqTnQ4AC25nALuE3CYLfoyInn8Ii?=
 =?us-ascii?Q?j6fchddA8WLV3DUTyl1KyGNUA0R/V7u/wcRUeGru3hHU6FhxYGIA9UAQPPaG?=
 =?us-ascii?Q?31qEdULzn9DR1uNl6Q/N4f02i+eRrOtyz+i0aMC0jHq/S5UOth5f1kRHf0b7?=
 =?us-ascii?Q?aS3GvkF36zq3xvakBYwX04WbdHpPormMAu/n5uq4Xbp373PnoY39CMjA35uR?=
 =?us-ascii?Q?NHKz37N7f6HkBSABMhQBYgSlycxqhQOa+bhmN9pBo+78SvYXMYEVOqTN1Wmj?=
 =?us-ascii?Q?zmOaSHeCBNVObT1fWoJdMwEFQGIJA3VNUmWZb86AKkcIIoMEWx45jwW6a0vH?=
 =?us-ascii?Q?ycxGZHS0KwmWqP+em9W75UMwR0gf5UKUkdy0qXvJCB1fIzcaDIn1XyJyp5Jo?=
 =?us-ascii?Q?tsUVvan3pw5DzAHZDVgOs16i8YtzU/gxdnNdGtTA2TcYuTaaAQq2di9nm15I?=
 =?us-ascii?Q?jSh4P6qnRcWxT4O+VTJ1hOldQjBOJrQ6SbkLzc+e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128d02d6-3a27-4899-00a4-08db2f528b7a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 06:06:18.0297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G41OYAE/kiqPBpfrkFiMsI3u7sKENvd6wewelihnt3d8JZPqXh21W1rT0fZOwyO7hvDCwBU+6o/g903eMSKFKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

'#clock-cells' is a dependency of 'clock-output-names', following
binding doc, add it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 6895bcc12165..b3de4947762f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -806,6 +806,7 @@ pmic: pmic@4b {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pmic>, <&pinctrl_camera_pwr>;
 		clocks = <&pmic_osc>;
+		#clock-cells = <0>;
 		clock-names = "osc";
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
-- 
2.37.1

