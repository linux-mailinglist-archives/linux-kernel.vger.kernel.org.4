Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13375F9C98
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiJJKSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiJJKRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:17:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02536BCD0;
        Mon, 10 Oct 2022 03:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkDuT7tiW0yGUAyYA6gzXwkKPz3hWnVYCn4gZXxSKLUw/2Cu0W/9k7vfRjCjbXf0oW8pIIaBTx9CofsJgnMTH2N2xaeZEAP+IKWAQo51qwXC4HvxWCkQcYoWevIiSnC7+jFzj32GAreh2AQoYrU15kLuxcCO9KIRLc0iIXd1B8izxY9+y0zNOxK/+BY8YL//8KyVzi5wuHM9wxt/a+51Qn8Tr1ipMMgxG+CWW+KJkpnumgRl/RRx84IFrqfKyOjKYkRccjv6+cGj0Uvz/leGuBrzSjqNEE0lOes4D2tCGLFzTrHVX7Py9fYSJo8KarrzmD/HotSe1VExeLgYaxWvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM03IwIIyXrkQLaQFqB8tD18hWDcfZblnreNfgVND1s=;
 b=DyuoxmoYvokgAv3zCDvr8ADDVwAQ917lINUfrApiB8rvfeKlrvXtFg2DrcyN/vwdyBB1VM/MFItjb1RVDeYia1/orJQqPmtqChkBSU475QdLkyp15f4Jn3gGNXtqY5/JfFmqlRdJ1qSBomYwVXwOGLX6sbDXv79Bmdk/qvPUwGbLp7SbEoxF78sfQCMgLHhym9oz+MDzoI+sOBqTLx8B72MABQc747SXC+5kv1onfYSNXkckbqg6j41mcztWdw6CEXV7LFR4hXHrw/wvIWOjyTTbwZ74wceKEoKXSoBy8YfURpTybG93NnyzruX5EHVpAOaioDHx+o49UTey5spfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM03IwIIyXrkQLaQFqB8tD18hWDcfZblnreNfgVND1s=;
 b=NrwubEiLOMgQ6/2hpUVN8w5rnJuCziOU+vf3TJM+pHKtHgOCDDfAz6sSztIrEXMYQdCYRxvHAWY9pCyYAAruwNDeN88WiybnvSE7nBAczarD3E+4F+FXbbFWstx/FDgCyy1/fb8AtuTfBYyjkZQbWuUYH8dZz2siL2g215P8YkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7783.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:17:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Mon, 10 Oct 2022
 10:17:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/6] dt-bindings: usb: usbmisc-imx: add more i.MX compatible
Date:   Mon, 10 Oct 2022 18:18:16 +0800
Message-Id: <20221010101816.298334-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221010101816.298334-1-peng.fan@oss.nxp.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 354d7107-ac3c-4079-5cc6-08daaaa899d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmG+ILzSaEszH3fU6oCEaPKsc8Bas5GOZ1YL77f87FjEwEgpagDBcuLEpTSsH2bsT4niLgXI7mtuDAIF88ypkA004S183kHgPwdDlT7vsob0LM0cpprbUPfjiyWxCtfH5aXjFD+hv7M25BPrG1F7ZNyYnJAWI82LVkgnkZ6Nh5DoIgdjsclqcL8ByWhlem9YoDQ5HmxHbu4bHLiK8yeMdtDH0+M3S8ogpLxVqmKexeP6OVGfwONQ31hqKH4oubO/p1tTrt+g+5+jxA1uG9HOusubfzkHXcnNfw4fzdsL9KWK1f+7FHMtyN+zoFtJEm8yIlitQotG7PRofqCuV/+zxdI8rqhNm/BX3VM2Y/c54NRYBrv3nLgHpcH9y0JlbDBgWQyG02TD8eJpn5pv9GIlDjLFLUscEQr4tzFgYPYmP7Wd7AfuMHqtE98qqUzF2IiV6mjEY3tEJE44QnqcBet+qQyMbz8F3c1hQD4B35heUPFVHrM867AJsvN+RWf+vwdzzP7w62raXiaNMgwHg2LIWcNdpLn2U+kqh0uKPQAvmllv5vS3B0/vLVN4pKVN73FG/eQPr0L6gqsrVQbbrs78gXgNrcIN0YCt/ZbKxXw/3NxvHt4e3L8UHTQG8o9aA6yT2mXqjVn9EVhv5Ybd4LamP9/nctBOmn3GWZxNkyukFIKHrXoCGJq/8Wb3R+MzlyRc48rg1fLRe0U/pNd5o2O+Yr4wUxiKq3zW0aBq0cjxouZwJ5xTeBGUBc5D7AzoJ9dUf0WDylJokCPjo4DTWwUuwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(316002)(7416002)(2906002)(6486002)(186003)(1076003)(2616005)(66476007)(41300700001)(66946007)(83380400001)(66556008)(478600001)(8936002)(8676002)(4326008)(5660300002)(26005)(6506007)(52116002)(86362001)(38100700002)(6512007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MpC1MBL0ikzQIqwpW3ZW41ALDNYRAGSgrI4bJm+FIjIyAQ675VLyfFTIUkr4?=
 =?us-ascii?Q?3ycpn9/eGE0FOSL2odx/GzSglgYJWOJBrdveMHHzUzm/sfNSYiaE++rhNAnt?=
 =?us-ascii?Q?wogDqBPs5KoS7wKlT+U4VzXWiBZ6duZ+y85LSfOOc2dhOmfIEjHRtdkeJJ2u?=
 =?us-ascii?Q?zVYSP0CI1qHLnJA96L0KSvao/ItKukpfR2/NVjsg9KNSSRSCeh2rdjtUSrAy?=
 =?us-ascii?Q?e1zkmgTpI6PezttVWGgy/BsxgdXG9NoFzJjse+yBXzyAuqDutULk2Y4Vf+YN?=
 =?us-ascii?Q?PpygnZfvv22I4y2aTOKp8SJAaSuCmDKZFUyqa9F/uHCTd1K2yY7mbO0GfUJC?=
 =?us-ascii?Q?vNCQyfpDTFdPvc5BmXDGp4DJxPizwC/q+aBIEWFPweF1bAcOXAinOdLlzMdg?=
 =?us-ascii?Q?MR3y7l5dCfcgMzWkC43yxkzcYXUh5BVe/fCE+Xq1M47fhO/mLXUbeC8i35Qj?=
 =?us-ascii?Q?S5B/bnMRH7pcF9lkLYHLkvvk4CZmkfgJbY1d9XMzdT9zPyHxDoe64sVrqt12?=
 =?us-ascii?Q?Kfx2sXlRF8fPjDmkBz+b9ZsZjaFfhpuflmSStMbESb+imhJ4aSRd3GOUdGPE?=
 =?us-ascii?Q?xzyccm6G54EtAX03yM2R9oqozV7Vycb27U2UR+ldVhXckXHTMs/dCwmpgiMF?=
 =?us-ascii?Q?L6TTulXtNX5T7GMuhx3czI9p8gP0uaHzasxcGbjtqRmOl1XNFHsGHEZe5PvU?=
 =?us-ascii?Q?IleMX+EQhBkK/uCZdf3ZZ6+MX8qSfnLi5z7vdmxVbLCE5lsxK62ShiHp2kJd?=
 =?us-ascii?Q?+midZpVp6kXXVdtPIW1hziHHAlFwGmJyFoMNESuEc6BQROg+ZOs5d2sE8b6g?=
 =?us-ascii?Q?hPhp6bj4Wm1sNXcvbch9qN8QA1yG5/hspKo1ARI0W6WFLpzYhRxIlKF1dKEk?=
 =?us-ascii?Q?VUNcx81To31v73oz0RMi6nvIgYehj939gQFl8CUi/rKT2BhAe67y+gug6pY8?=
 =?us-ascii?Q?6V77+ATxod2MM2ouIIVF43oCm2+cbCtVR8mAimf3ModXN9NkwSHoEA3lSvCL?=
 =?us-ascii?Q?mdQ2JlszHzBAexCGf1oSy6zCebdvyCoMWhLZB/8gDIZxR/fnBYlcXzNzImwh?=
 =?us-ascii?Q?WPOuednwU4hDV0ccs+hec/Jyw4enzpgoOcZY8shyfaDoLF2yVKobRl6WJsHe?=
 =?us-ascii?Q?qecXJIQ+9qRRuDSgF5pNvdTXZfbDe4k7x8J85/679TR68+gr4NxgSntjv/k1?=
 =?us-ascii?Q?UKevd0aAt97oXJuKj4RZS2eDVw4BEBCSVN1OaZrQqSvhkRjFIE4G9svE9IrT?=
 =?us-ascii?Q?duWhVGHA54EIJZ1uYykuGIKvN5f8K42wfh1yjU4Aft7a7RlL0BbGOdQIAvfk?=
 =?us-ascii?Q?3rGyirDQ9G1Rls5f7jINZVVuGKZ72kzYEPlXwADJHrfXiPQMggojwOwYruyU?=
 =?us-ascii?Q?3uEAmwiTjq9BbjO/P7DV7hbTwcoxyEjmfvfswxGpnonzUVSIze5MnD283CpT?=
 =?us-ascii?Q?Vpe71AegpzwspXpKqp2ja9OhYUdoV/JHI+jVphdDju+A+bwFwsC+7d4+Xfdv?=
 =?us-ascii?Q?KLOQtUFweZJe1d1UEzT/Mx+ISh9hrGWbQ5HnlDUixwLWA+ZFg7QgEMJCoNtj?=
 =?us-ascii?Q?1KshJD8PnzhFxv0aOIq/J8mcbkb0QHpGTZOaLO+c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354d7107-ac3c-4079-5cc6-08daaaa899d2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:17:14.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgt0njnHWLFavzdcCx47xQDBbshrTF78z6NKhdzUTZQlXnsXZ2dO2FvcuhvcJcSNYg+xO8XZqYcp/0QF6IJ2dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add more i.MX chips support

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/usbmisc-imx.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
index bd2d3d95f5a6..943ccf6154da 100644
--- a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
+++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
@@ -13,19 +13,31 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - fsl,imx25-usbmisc
+          - fsl,imx27-usbmisc
+          - fsl,imx35-usbmisc
+          - fsl,imx51-usbmisc
+          - fsl,imx53-usbmisc
           - fsl,imx6q-usbmisc
           - fsl,imx7ulp-usbmisc
           - fsl,vf610-usbmisc
       - items:
           - enum:
               - fsl,imx6ul-usbmisc
+              - fsl,imx6sl-usbmisc
               - fsl,imx6sx-usbmisc
               - fsl,imx7d-usbmisc
           - const: fsl,imx6q-usbmisc
       - items:
           - enum:
               - fsl,imx7ulp-usbmisc
+              - fsl,imx8mm-usbmisc
+              - fsl,imx8mn-usbmisc
           - const: fsl,imx7d-usbmisc
+      - items:
+          - const: fsl,imx6sll-usbmisc
+          - const: fsl,imx6ul-usbmisc
+          - const: fsl,imx6q-usbmisc
 
   clocks:
     maxItems: 1
-- 
2.37.1

