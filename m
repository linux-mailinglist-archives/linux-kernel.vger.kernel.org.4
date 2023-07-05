Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4E9747B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 03:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGEB5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 21:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjGEB5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 21:57:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC24172B;
        Tue,  4 Jul 2023 18:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rtl8UinHVI19OEDuivazmVQoHasQHf4k9P64TMvFYwYkuYYaHJ3H4jzWxE20FLkSgML8iQaS7mNepDWUfZOIhlqpeS2E9iVSTBj8o8NJtJYh4H/zfhj91tU9cveyv5QNXIfE4RVhqbZ0VTHwIxY9T13Ene6fORlx+IHjV18diIuzWtcXop8q4lGe6NPycGmf/PUxjezpIc5Z9/IgCew2+WWH+KwknN3xi6qLcM4RW84N9iv9aZ2z59CyLVhxsDdGksV/I2oMJAchpzfgI+VoOe+sd+RHEC6Pdg4VvBA95EySQCTg3oIVeNb5voz8z/cAmEL6BdNyY1Gdnfed2QMmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co8wIMheDYI34UaOTDhs9a8ghjoD0utIictNd93Hw20=;
 b=OXJ/CU9DJop2/wp/HozwDRx+vk+4TvtvRQ5/i1dx0ZLYg70zsxYI0+wyppQZsGcyzoxRDYjOB9j/CvE6J8sTr2/Sf3OUOyAI53Fvdx/n3HPWfHilzQCaX3IExlexSLD1LHToRyrbsEAiBUOub8azXtTyDYgo6WROczdFZmumrBJwh4TDh1RZKh6sRE5PYs+uWn+BtnVaM7/7cxmyuuN0z+e9dxZEX1e+FMSPm5inKip7rWM2KdJeZ0HDm6oPtUvTkoX9s0PNMgsVZmEszzJWRx7RSAk/HbM3273WOmTVt/9gV6rSwuIo1MEe7buqPN2jvA3qEYO9DDox+Ulu29u2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co8wIMheDYI34UaOTDhs9a8ghjoD0utIictNd93Hw20=;
 b=Fud7bDuuD3FiMykH6+k0fyyEQbjvWxFhtw53NMkQBPSh7ANaGDVXlgzmVEHVyb0317tkKGlQIh/3rP7IFB/PWxMKqbliSdnisFaXe/IrPG3q9kCCcQBWqPCpMxgyZOtcZXZdBFR1AVsnx2Bve+yl78yTCz0oOjFhekNT67tplhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8845.eurprd04.prod.outlook.com (2603:10a6:102:20c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 01:57:40 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 01:57:40 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V4 3/3] dt-bindings: serial: fsl-lpuart: correct imx93-lpuart dt-binding item
Date:   Wed,  5 Jul 2023 09:56:02 +0800
Message-Id: <20230705015602.29569-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230705015602.29569-1-sherry.sun@nxp.com>
References: <20230705015602.29569-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: d33bf302-260b-47f5-8c3f-08db7cfb36aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbUdq77deI3H6s1Fi6vsHuEpPcp44q9imbgrJkEpT/JzbsRbrDrP27KKvCtaSITAWZ7imC+4Egf3mrnDvilWa+0RVLCgeMXc4cjyfV5wNv/fJWtGT8QehObH6YD4uu0nw843iosswBwa9CzUbpzlEus1PuHBTsuzexI1MwL3t/o/gHnMjeKw6Yfj6+2ukVtNuhFj8jzM31YX/bvBJckxG93U0bdT2NledR+Y9bvYfrsNB/5Jx9LTEgazkTsbJecnaJ5xawUNuvh3MruyJm08IZsF0UGpr2dK6fnAHtyJnO4QTu90hs/qNjGvSnG9Ry9E/SPNEzyhGi+AUaDMVqncl6l4RQ8Mp8HxT6Nhe37NtV5syK7FxFB+y1MOHbLamIHELLetIWeZ/1+MiyrTn0DPCeB/zyrlmZqW7GG1kdtsNgm4KMWlA27dCy3YEBMefPMZCuJ3tmDrRoKrjxTrCPVkhosFUUS3YCF0U9RtEnFP4OsjjeeuQOHiCYZZpSmoleu2M7ptHWdM0R9zL/YFFjnTGh8YatO3EEheX0Sdjlhh0wqytG4FQLhc106xRNpIVGGZLWbD9DmTUbLj0ITEc+ALQ589yhEiKcfUTll9M0utMOrtrBcCYNdxpSDZdThTRINverP+iOeejILfBwk3Hxwwj6ZxYbaUjoGXEEd05Ong2TQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(6512007)(1076003)(6506007)(66476007)(316002)(4326008)(38100700002)(66946007)(38350700002)(66556008)(2616005)(83380400001)(186003)(26005)(478600001)(2906002)(4744005)(8936002)(8676002)(52116002)(44832011)(36756003)(5660300002)(7416002)(86362001)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+wKP7afyrAC1BKIhC+0u48eVfElLe28jOVr3pchGeQIkz7D//KZEtJMV2kAH?=
 =?us-ascii?Q?bwKcdIzLZ3SwerPDW4SHurY9KqVI8IwfFyEbfAi3oSmEJ6HEgN0GLasvF/2r?=
 =?us-ascii?Q?VyDVGDflp5+oMtG1YzFctfT9c8WxTy9IcSmzlCzlnuHA4ihOzoMCUDTAKq8/?=
 =?us-ascii?Q?4PLKDj7bZMQ3xqIg6POwHlv+DGcs+aD0A6b8RetHwcWo+93M1u21YUBNBHT2?=
 =?us-ascii?Q?wa8l9FryVxL8EX7QwCUTNyzxrW8CmIq0PkMqXnG/ZZnTlZQwaBMzBu5Vx8eC?=
 =?us-ascii?Q?hOtatX88RPs0OZkm++CCwOZa6JkJ+FWJaIPV1/WbwyLAyPdOl2wUeUelexV3?=
 =?us-ascii?Q?w7cmS3jQPRD4H9Inw6dJE4acrjeMWrpF5BIN4e3tbJoEHPxiSBdrhWnZnLbl?=
 =?us-ascii?Q?Q3EKFf2Ya0WtnVzwJgWhDg0FXd03dWolWZiAvq1eUD+3dF2cKo6Nod/J1DP9?=
 =?us-ascii?Q?MmkHb2bQGRdBMOHV3CVEBv8ZZ0FNwZ1H1nj3fFWuw0Bw/Qe2he45XRm7tGqg?=
 =?us-ascii?Q?EARL6/RZeEGKjKz4nCVJ7y7Lx3PnrrRzH+KM+cD5csQhJeBNHBWK7WTxNrPC?=
 =?us-ascii?Q?QpOCXuYXaYw10H/xUVd8Ra+c8xwmEMhwGiA1lqUN4p0s7kaImihs7yjLVtOO?=
 =?us-ascii?Q?03/J+xeetTc9GLswRixdKHVuEJ0vpeVK015eMtxNvWz4HdVFAocBHMlUR9W9?=
 =?us-ascii?Q?fhvFHboiNBsB343ceTkR5WLSpf9dWgNXJXz8tw0OdTceajZJgDPKlYpaShb/?=
 =?us-ascii?Q?1xmx7/avTIJu79gojFGtVnXJ/ZkufjOyQTNcKy0MAvZrL7ANyEcQOx84HPmg?=
 =?us-ascii?Q?QKa2ZdWPewxSo9gA4e1IqKu1u8BTZghU4+iBnNEv95jLI9x5SBCPlQOuysWw?=
 =?us-ascii?Q?OfR7NObDYu4F6CkhZmT6K/0V+NdDe03Ro5qY6FXVoXr+Ua8AfWT2+NTcv4fa?=
 =?us-ascii?Q?wQATUZ4TR0YXuv1+BP2a/zTdm8lQ9zrMfxzgs4Vs/zmRMGlim17hVafEZc17?=
 =?us-ascii?Q?N96moT19/g+m1wlcvtjpT52S6bvfmoGey9Tv3Up68jBmdJfK2nShgC3B8qfq?=
 =?us-ascii?Q?d++d0XiELvsFzjKFGgFjWZzm18iNmFpLBKATF8h8goMUuvbsHhA5Mnit3t/e?=
 =?us-ascii?Q?t7EfUL4jUlE+3bSJf4GkpxLll6cWIQI7jX/VkIvkmWmC61bYiLMJdpDsCLCk?=
 =?us-ascii?Q?hYRJAnqshjXasyVqK34qIx7Gqk7ziEq5FH2KyrIYpFgCzyYij9/t5XfsDgw4?=
 =?us-ascii?Q?R0Fq4YhmyjqBM9EOfZu7v+FNV2jAfzP7Ls9i2eNQwwn1MzZp0B6eB6c8pwui?=
 =?us-ascii?Q?p+uQUIJmNvoXRGMB+4Dsevk97bNlICTkhfaEqpX9VVpKzubxYzPy+gaJHyUU?=
 =?us-ascii?Q?wJkrW2o1BhWR9KluzahV9j56rx3R2EDjjYGr5ysuGaOwGArovufZDmyfJe1G?=
 =?us-ascii?Q?QzTwUrF+hN61eqDIcyO4zzcvCQhLEMaHOgrKHk11c+1zFwliWFpH57tTn6Ld?=
 =?us-ascii?Q?CzMycjVXpRaa90fnA1pV26460ytjIE8QtvLXyZeOjqo7nRDSH8Nd4S7J+Knx?=
 =?us-ascii?Q?V5vsu4+2K1Diade9GPTKHBiz92WTKcqd7oLHmjd6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33bf302-260b-47f5-8c3f-08db7cfb36aa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 01:57:40.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqbTXqpE8TnhjJUptIoxcPdL5KTtkqj5GIhMIB4Plb4uIbRW9zZahfIYAQWYJ5Nmg8BJFrcTiv5v0EHVQGoT1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8845
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the fsl,imx93-lpuart dt-binding item, imx93/imx8ulp add some new
features based on imx7ulp lpuart, so need to add "fsl,imx8ulp-lpuart"
for imx93 to enable those new features.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 93062403276b..3a5b59f5d3e3 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -25,9 +25,13 @@ properties:
           - fsl,imxrt1050-lpuart
       - items:
           - enum:
-              - fsl,imx93-lpuart
               - fsl,imx8ulp-lpuart
           - const: fsl,imx7ulp-lpuart
+      - items:
+          - enum:
+              - fsl,imx93-lpuart
+          - const: fsl,imx8ulp-lpuart
+          - const: fsl,imx7ulp-lpuart
       - items:
           - enum:
               - fsl,imx8qm-lpuart
-- 
2.17.1

