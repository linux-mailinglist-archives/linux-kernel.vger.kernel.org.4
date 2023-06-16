Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37414733178
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbjFPMnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbjFPMnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:43:11 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F6359C;
        Fri, 16 Jun 2023 05:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaUXE9kwjml1NYunxvdEWR7+Kt3Yt+0RzbRRS4Fy2S90pQMjNYFbeHiu4IW9UzlIzAkUxseP1FjnGrjsCOjsFnJ+1a85OZbi2LXHuHfofW2FBOUvpEKgC0v05JdHVvizol0sO7QDScAFgwPAYIhaIvhj0cmVRHAwfKCOaV56G46fDk2qg146l9NQQ8NChYbJu0GQql8rGL2kjsbKRtHERqK1iqFD+FufafzJn9yPlgYjy9o54KtAn2J3EqpA7Orr0yCcsUKjXWis3fidkztvtxZGoslZaXdE3AHKS7XIleiNiWFhhJ9Dcd8dgjD5FtIV7qkY11s9FzpKrRpCyMG0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YapWrsBhDH/ndHGmJ06GdubLWFL1ZFWZAoEnNferzhU=;
 b=A3MtpquSS+Z4yTCC2Ur/nNyi5oTYiK3M59W6Wf5/GbinuUVpG49+lrek4HsZ390OyTG8HeSP+pP2fgLVGrq5Ye6FF1T3x8YVeXpn0Oyr3nyq8Y4yg2FuvUgedP8oOxMCYMwH7qKRYk6055Obd9jJKHSxR9Atijx/Xcci4yXx3uaSzCquU1aYUFhEfL84XO8q4N10FfhpzVarxW0azG4F/NSu7+BuEss5wVWJbwiYgBSr4jxJzpwaw4ZEMWsYrBHGxxLlLfL1flgGeu1vysmo6OUWS9Kc7gpdiHroEd20yDKY51HpBqD1c/3aIDMK6dOJykw4Qbztpc/49Rc3UU92mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YapWrsBhDH/ndHGmJ06GdubLWFL1ZFWZAoEnNferzhU=;
 b=i5/IY0m+6sED+wTsNxOuhTNXLQbu4JHP4nroQ74PxLFzEoG86M2lFlZ6MccVKw+wiMtxCWzMSDKTP7gNjuINLjKWTjO+RkYmpzInWkZWMcXfwtbJzJHa5RrLd0nFYEEWlxvcA1FM7JiRWbs4st7qpGWvTxaKeSixz1mUk8KaEiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8320.eurprd04.prod.outlook.com (2603:10a6:102:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 12:43:08 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 12:43:08 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, linux-kernel@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v3 4/7] arm64: dts: imx8ulp-evk: added ele-mu
Date:   Fri, 16 Jun 2023 23:41:41 +0530
Message-Id: <20230616181144.646500-5-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616181144.646500-1-pankaj.gupta@nxp.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc84457-9837-4250-a34c-08db6e673c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VF1DQo3eSOwY1zOa8bpJiZywRoAOsEJm58Rw7vlnME3Cgm//6Y4aljVIT7iHJn6x1ag2/LiwBdhZCSFgsYencHqlYJKT44DA9waNfjH3NA83tsvD3ZHtMZ6Fx6T4N70Dun9+J8UGu6U0wlnG3X2TD16QGIW6f/OEkv6N08GilOSpCntE9KP4b7WjojjkHirA6olkpAF8WM5PfA3lUT80G+zXEuziI4YT2+jnh4GAxPy0QNeiEhd2W0Khob/L7/BP2f04juOxkSR7EWNBmd5c1RQwVeEAYEbyIpPI4aHa5S4SPtPt4WeBD/70bME8VE4VVF+w8PqtsXG5vWuUGuFl9kNvo/Ufpa1V1OhTMdCO6rRikFimycYB+nmHXoaZ+yuxdF8dqgDEdHh3FudcP3PlhaK2XZNH/Dug+aBVHMfjlDO4NrD04r00m+FdnTjMORWQBmEOpeAB1hIg3AzwG8TpVRGMXFUzvkqj4Un3PutmlHzGgP+eu+x+4TTl6zNlTjxxx+9iYfPxCscK/vYTSxZu02Z4/2Wc0jVdRhkPdxoob0StJ/Y7OncZ+oVbMffsujHWyhqfglsHytXYmTUx0xZGECJBfDNGZBzPqqAkSB9PI+8sYgL5oVhHl52LUj88HtjC9W9gRxztq7HEn7m0IGi8qPgT/+HkHLzOmr/LLpMJfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(5660300002)(478600001)(8936002)(41300700001)(8676002)(316002)(6486002)(52116002)(1076003)(6506007)(7416002)(44832011)(186003)(6666004)(4326008)(66476007)(66556008)(66946007)(26005)(6512007)(2616005)(2906002)(83380400001)(921005)(38100700002)(38350700002)(86362001)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4nkwC+uLctojiTh1MwBPIDtlXM3AB45qSrDVz5Ug4T4X2ymWKveuetbZyZ4k?=
 =?us-ascii?Q?njJlBWfGE+Rnns3Hm+6BycEAI1bGNI1RqTQ02NCHIHIvn9ZshHInardzY0hW?=
 =?us-ascii?Q?av+wQkHMCtzaOGz0HI/AP6bF4/8fXF3PNPt8WR62wTICGDJxTDdYz3p8hSf/?=
 =?us-ascii?Q?SzRtm0axDxz0pEWvp+7lPjjF81hfxojtdIj+feCcAUqa/DyomTfL6CP2hzuu?=
 =?us-ascii?Q?5M+wE2WLcknCM0YVss4GIQuX0sw71yKsxaZ88s65QUUnHYbCkma3WrckQQGR?=
 =?us-ascii?Q?mGXRkZo0UmbcsrtlqlU0WnRCyeg4uHSwMI5C0d6CIep6GZN1gcpONajVu22b?=
 =?us-ascii?Q?2sr1ptXu33Z8FSyzcfTMCwrtnHyWl1ZPKfzvFBSUR2wMpXaGNqZ5srXOUfZP?=
 =?us-ascii?Q?A1Y1twv2U+i7eNxJ9DbSFBhDWmRQeqxXYzdSAmPrBQnIBvty/fIC467El0+0?=
 =?us-ascii?Q?nOYcIgmr6JIuPh4Vp8X7wAdJh7qsvYMmjr2FzsyB/H6cHpjtdCPchkF+baQG?=
 =?us-ascii?Q?a3+Pib4ew9AWNO7KeipyWJu4kwOBUyX7wCaLf8xeYOIQYsZiKguu1a2HRomq?=
 =?us-ascii?Q?WW7y6mkcW9PKTjOfEJg8o3AD5rsu7aZFyOLBxnC07+sGyncyvILOkUKxT2dR?=
 =?us-ascii?Q?uBcPbROZPswiyA7xKNpNVdftWegiA46lyCToeJ3Byc8CYMamT8n52/HrFohc?=
 =?us-ascii?Q?FMCcyLLyDX7tuYlbUWcFXTFJH8JzQowKCQ6ISL4K2aGGfswmDtzb8bSerKD8?=
 =?us-ascii?Q?XreSALeGZ/7ynBFxKBtD80PB3W8170QYP9JXb0nQT1cr4asqU7fRCleMwcM8?=
 =?us-ascii?Q?ALVbYaEY0tuK9VRK4N9TNEhzVTwDp3q/P78xnfbBivYk+LWVV/YamIX0nBbI?=
 =?us-ascii?Q?dzUl8N3RHrYW96dHLsL2ABF3yD8d4GgKYMKkhudXwxxOCSdLmPhI+tWyKwhw?=
 =?us-ascii?Q?QJ9CEtEMIRocoYE+d8JT7TiMvQ+NUaKUBzhR4RcvOI7G2kYFsk91/FcnGdDv?=
 =?us-ascii?Q?PbwFnr74pDnL7nzwmsrLV1YQpZhR20TXU5/gjlecHnuBhEWx/BGv+7CUSnBy?=
 =?us-ascii?Q?Hhu9dsFgbfnszyT2lLMzlLZsUuHy8lcAZpm+Q6e6k/aYl+kbQzs6rK8/1HYP?=
 =?us-ascii?Q?jI8INASdTt+uPddRcdr8Ik1TGOfi6oXzBu9ZphYMyw+pKwMsZDN/CrSdCSvO?=
 =?us-ascii?Q?3DTAgM0Eu7Ujbdc8ihEyX6zV2sEwBJ6fsFj3jyD09xucOKoZPdfPOz1nj+Vn?=
 =?us-ascii?Q?tnqSJMjznuNA3D4us/QJ6nTNNeJoz9BIZb1pMdQvda7l0rDF+bvMKWJ+PmVY?=
 =?us-ascii?Q?5CxualPZy2Mb705I6Vu/c6Th2rIkbPDbzdF4lkSZQM2Hzr1ISqq+BppBB74N?=
 =?us-ascii?Q?furyOgU00By3VseLJ1L5AvKUMQJyvm9uWO2rPXPY6Bz3UI4TeiEWJq/Z97i2?=
 =?us-ascii?Q?js7bwAcXhHLQRpPn8RI1q5iRlGozMeYWXFlWLeuLvNDdqb2EihxFKbKwFxs/?=
 =?us-ascii?Q?n7D25p3hvd5vmLiHeh+LZlXm97qlwCdkcN9S4naOVSZVmExpMtk9rMUHv1G5?=
 =?us-ascii?Q?N34HEol/2LqESl5H7gsl+3s/DQKmnRUe8+/qANfs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc84457-9837-4250-a34c-08db6e673c4e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:43:07.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCX5WdzLrVaARaElzCWAtQivvyU/yVYf5xpZG771/m/exEqLnjaWVu/kpgMmlC9dQ3lsQPdJRMj7TwDTezwCgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8320
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added support for ele-mu for imx8ulp-evk.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index ce8de81cac9a..cbc2769e4c8c 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -113,7 +113,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -160,6 +160,17 @@ s4muap: mailbox@27020000 {
 			#mbox-cells = <2>;
 		};
 
+		ele_mu: ele-mu {
+			compatible = "fsl,imx-ele";
+			mboxes = <&s4muap 0 0 &s4muap 1 0>;
+			mbox-names = "tx", "rx";
+			fsl,ele_mu_did = <7>;
+			fsl,ele_mu_id = <2>;
+			fsl,ele_mu_max_users = <4>;
+			sram-pool = <&sram0>;
+			status = "okay";
+		};
+
 		per_bridge3: bus@29000000 {
 			compatible = "simple-bus";
 			reg = <0x29000000 0x800000>;
-- 
2.34.1

