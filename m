Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9561671070B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbjEYINI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjEYINF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:13:05 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F4C1A1;
        Thu, 25 May 2023 01:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaNN1Mioo+eO8GCQzMML8ovSYITWwlYVrH5I2isO8Al/mcjAgrtHbKdPZ4FOXSsZg5GchGDS1pZrzfSAhUY17OV9kD4x8mXog320sETYlGOQT984tAHmELxthjBKjvuR1NKFAbbabT81Rd27VwFyLSAxNsZ+kXSEkokNIWjTwRImjfl9Wcb3/xaMdIVBypXl5KSraKiQTIkw0mDlp+rIdebFt+RxdWs/ZZfwJxabuEOO8YShazW8W1Wd72oOsp3jkJwkOkw0FgixvJQgGzA59lVtrHbc+CUTXsxk38qUyHCxas5Cm3itzb2ZF5mim8faXBSdOYrdB8/rKOLrv0AM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL0ClAkbEycSKLrUeIk4Db43FKoj6o6waN/A4Cdgoy0=;
 b=XD3YvEWTDhANIK3/T0mrq4+QEWVlGSDphBasI51iKwRSpfFAmNML6MGhkxe1aPc+1qgYw2pAbXOCgvpElbu5iPgjTnEtgkSFqxC/s2stJegNK0/Y+6lf8LLUBpN/5E36WNQuGRJoIixMIpmNSDkqx5vNBdy1Y1KTvNbyrmr3yW+ff7ZBqFKfIzh0KuTFS+srAZTT9Fn5hkfEdFCzlOVmnbrW59AOtb3ddqqz4uIoyPPsk8bq2iLZLLT9E3rUrRuF125h9B9xtBl+XBufv29Jfn0B7ViPLK3MvERv+rmxwhw4Bulw0TRHmE8MqWPKHFWzmOJ8h4kASqG7R7TPJnfmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL0ClAkbEycSKLrUeIk4Db43FKoj6o6waN/A4Cdgoy0=;
 b=JT/fluMRRWqZUTaAKMs4HnMrFw5BnwFxNHZqTI5fI6i5CODSr2SH/Pi1rVZGdI3YwRJ6Lje8kOSnRpB5eGG7IQt3NRx8OQraTXqzWiOyRGZhShhSHaFHN9I4id39Eyzy7oknqpZBTiw+EX1uC26tYv+ch2X3TNCdNbK8iejQims=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 08:12:54 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::682b:185:581f:7ea2]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::682b:185:581f:7ea2%4]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 08:12:54 +0000
From:   wei.fang@nxp.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx93: add fsl,stop-mode property to support WOL
Date:   Thu, 25 May 2023 16:08:25 +0800
Message-Id: <20230525080825.513707-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21)
 To AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|AS8PR04MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: e0af81e2-aa35-467f-056a-08db5cf7d726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8bxCy84HCw6OHaTaU5AVJZam6T40pzBdnm+O9wy3vo3g6SS82dqlIN5dFXhZta7/lQ1QbWzLSvZNCitIvPLuPdPMF3k5riP6TPSm+tuT+ZAlYLVcBtBkQAVL6ReeK+c5wbpMw065V2XYqK9khGMFPDZpeHvckjNbybogZgszjedknT2G0UItx/9zUXT21d1sjpsIZ1AQVNnjL/rQcHhx8LamOuWVZvtLNhElBkvhwLkw/KGjdLBYJCOr3K0cxiRla8jtJrb6gM7mTj7Gt9DU2R5BrB9ux2/WFPEpaB9A3hCl5CJalbas3PFe3AawF0YCHnUl2S8Qu14M/IY+C675/q4LoGFnWOOHqya4CaG+kgVFQIE+Pllnqope8C4FxJL2GB61tiVlSiTm8P9xJLIgsLN3mN52ECDhMXNwpgXCy4+H6B5RpX7jKrFVnXbQSWfPnJRXsnAOY+wJslDCs3F50rSzYu3rk8zBkGxaw6oUmPzISdBS8S5UmRlNC3yFQ8r+wvPiJd8La5ZCExQSpBr9p39cHDnuhsScBB4Qe6nGFq12jJ9mlgardV+Uj6/lMXFgPCOFU75Lf73phQQ7wvW3VzYAUgaFtE1rqHzb94n/u2PBb/UFkoKZbIFk+OSNOfO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(83380400001)(2616005)(8676002)(8936002)(41300700001)(7416002)(5660300002)(2906002)(4744005)(36756003)(86362001)(478600001)(38100700002)(38350700002)(1076003)(6512007)(6666004)(186003)(26005)(6506007)(9686003)(316002)(6486002)(52116002)(66476007)(66946007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z0d8z5LmEi3l741MW8s8FYGHScv9EMrCNHwRcbq3aUfz2PMQhU3ASnhCcUnp?=
 =?us-ascii?Q?gPIqsS+SNWiBRT+qvN/Bzu8LJM+mRsaX1Eb/FgzfkVSfHMPJvW9Hv2HO9SkS?=
 =?us-ascii?Q?W9sHFHhbVyQ43i2MwPz6fZ5c5p3jr6MwuB2TXIGc6R/B6rDkvLW5Jd81iEMW?=
 =?us-ascii?Q?pufjEZhUT3fjiw35nrJGBWMh2sVUNOFpGWybAsQd51GeLuiiZLhznmp98xXM?=
 =?us-ascii?Q?ZvJIhYfymoCbnJInQtCBoea4BoxK863O4WPRv2nfqbvk64X4HT0QNcEVBUyp?=
 =?us-ascii?Q?XJzqw5V1SADpSsXNLabPhKJg9biMOGw/n5yQvP9nZog+XT92P8vsXisEuZ3l?=
 =?us-ascii?Q?6MvhbV/58PIr5Pa+mmY2wuhfXfSX+iGUf2Z8jCHhWGKJ4fNHwXf1dfP5O6qd?=
 =?us-ascii?Q?m1uQDQLW8C9cDaw6STdUw/1grvtWwou6yAyb250TgcKaxganxbS0LzTKTbim?=
 =?us-ascii?Q?liVAwviAWiZaYS9FNu1Mo6dHFsmZl7MZDthp/QQGBe1KnpIpdwkCMpW1gJAp?=
 =?us-ascii?Q?SE5//tw+eXFhLGGjUcZB1IpLzwDscdaf62jZ/Goi+K5FGx1PvnWzby88c6WV?=
 =?us-ascii?Q?mWBxiMalm9+Z8Ixsta7s3l3+EK/g/V6+qZN2zsAOhflcxgSpjYmDcUN8Whwe?=
 =?us-ascii?Q?1WYXK7a4WjLpze7/QzeIlQOZOi2o1DNJ1XRjUab55MRce7XvtJjVjfYPVGGv?=
 =?us-ascii?Q?3Dblv5zqVU0B5CrZlstBh3XjFbOun5sqb0LZHYWC5BJ/RocKoNIQ64oOKnyQ?=
 =?us-ascii?Q?CMp3yIKpeBwFEMvDGDL97sY+aCmBM0v1t2PJV/o9MVNy/uYT1bvOI/bZCRIg?=
 =?us-ascii?Q?s/tHoQbkZ7cm6QFNXgL2vQnpww/XYhSaAz49aaI/bn2VgQxK21yUmfjn4nHG?=
 =?us-ascii?Q?lD+CY9LCDECeS+LFuHD0S6zxOdyr99XLQnzuptZDnZ7ANlKNmp6JoRk1kwuk?=
 =?us-ascii?Q?pz7zjQRefDWojzmBcFoToQm8LAebql8jU8a1oEZAoAFEM4EYucI21E2d5KD8?=
 =?us-ascii?Q?s0aI2KKGdRcadzRUSPViXt+akDhEC92jm65CybSgTfacSUjgQbf44pWeU+tS?=
 =?us-ascii?Q?Jj6Vb4hGVDY8+pWp/J9pKAY/ARigz9GMwqeFqhMP2BhM1+bkW3huwmhPN8Ls?=
 =?us-ascii?Q?Z4dkktmKWCArfUsbGzrEXQ67Xp+F+6zoIwS8DJqqgG05HxLGCmW2diD+Eh22?=
 =?us-ascii?Q?hggB6BQa9BjC0fgbS4OY8u+txRFCxcYagfw+Lic86xPuZSRadE2JkZQkpwD0?=
 =?us-ascii?Q?4Rd7SYVXOIgt6sPtPTf49xIb7syxxmP2laxOBxKC4yraJheTnN+c72uGYdE0?=
 =?us-ascii?Q?yajNYe9gVFF5GbonMhr9WrkNzT8UYsTgG212JmD41pyiBIw/zLCkyCyoSOSU?=
 =?us-ascii?Q?tHNtrY4eSAjMqSEgM7kvSPKzr5nQV1dOW5ce9FRnzGZQkPrf+qZ873SSHXpd?=
 =?us-ascii?Q?RSwnikVGT7Vlfg9HaD7uCMZP5W0cqNdULMlIjR65GPC6bzgZPWMJUAXCst/z?=
 =?us-ascii?Q?hpqR1GStoAUyhHWXhw9w55x0gxUdvVqUwqSpV4QdmqbNMLX+T3BVpjAyQraa?=
 =?us-ascii?Q?zSjbLIr87bUOJly3Wv4eX1vNfVk4t6E1g0wbf34I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0af81e2-aa35-467f-056a-08db5cf7d726
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 08:12:54.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjavyB0SUKwQKbTgqwnSLJUeHLMyF52IBiN4Bi8HX6MTt/EroU+MJIK3w3WyaAA13pNJTEO7HZ6HlZC/m855JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Fang <wei.fang@nxp.com>

Add fsl,stop-mode property for FEC to support Wake-on-LAN (WOL)
feature. Otherwise, the WOL feature of FEC does not work.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index e8d49660ac85..d65a72329d53 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -685,6 +685,7 @@ fec: ethernet@42890000 {
 				assigned-clock-rates = <100000000>, <250000000>, <50000000>;
 				fsl,num-tx-queues = <3>;
 				fsl,num-rx-queues = <3>;
+				fsl,stop-mode = <&wakeupmix_gpr 0x0c 1>;
 				status = "disabled";
 			};
 
-- 
2.25.1

