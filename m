Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D177C69A5C5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBQGxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBQGxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:53:13 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89B14EB7;
        Thu, 16 Feb 2023 22:53:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keh+NmuxdR1TQ+IguE/jzawOVqsCSFgFT1XFagQ1fN3BNdc59OHUY8DFOKqLh40qr0FV0B/1iYKOQgopgEm8lPumI145Dsn/uDZ9wFHe8vgCzYjF53R1q8SocxrMcC7HyZuWt14/ZHfaU+yvvGmsysd6P6L3LFW55seUtyDAyQcTSrsqvOy5OMOpL5q2+4TLE+RzacayeCg1gmwCFhd3K0PZJ12x3MNplfieK2zlNJ8lGxUKyxyzTgnzsniTUCbJY/D9X7PXHxQu/cAf2rBkK8IqNOITucn3+jlCas1J0+jcR0GdKW+cnpA4xNyiM8mVcNo4YUK4fLUmCKZScubq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2HHqZCmi8hseR+UVb+THPvMsd4VUC+JCmwjkcYGiTc=;
 b=atS9nlWZ2qdo6tUVsgsjlENMm+kXGbIE/tSMsKsQW3n+/Spf/TEDmlHoNhQMUDiSQO8yTVw71oFy5MZFmVaAKI3FUbBMkh4I3YaSQaVrkSCskWUy8tE/dYMYSrVBqGVTQYcl+XukHsOClQFjoVWsI0KnYFB10LaNr6ajEUWq8nmoW9mkzr9yo6kefU7UgP4kr5WcvteP7W+t53GlXi+ecULQKNnOAshXSMSz7yZete5FrPBxqnYDanNRm+O4GfBXn0xPO380vIiyBf+5dUHyVPmhoQ/5U3JaxHsFRUf4BMeW3f1g6afW5ADEMqnPWZxswNLWKSZNTN0viJwVWD0yTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2HHqZCmi8hseR+UVb+THPvMsd4VUC+JCmwjkcYGiTc=;
 b=bjz8jnm5z+Ga+jdt3sbOabp1cvRsSJnIIJRpQd43c5xcAso6hdBZRkwy/yI2xtwwzQmIfTeM1x/nPC2w9LFhuCcr4UH7030HK7QqHYJU2CyTnGJtxtY4Xsgwc6eShaXVeX4QzrBH8lryBkiTrjJjWrIVY3cSoc252MkBV/oufus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM7PR04MB6840.eurprd04.prod.outlook.com (2603:10a6:20b:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 06:53:09 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%9]) with mapi id 15.20.6111.014; Fri, 17 Feb 2023
 06:53:09 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@karo-electronics.de,
        alexander.stein@ew.tq-group.com
Subject: [PATCH v4 1/6] dt-bindings: lcdif: Add i.MX93 LCDIF support
Date:   Fri, 17 Feb 2023 14:54:02 +0800
Message-Id: <20230217065407.2259731-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230217065407.2259731-1-victor.liu@nxp.com>
References: <20230217065407.2259731-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AM7PR04MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dcb056-ff48-4fd4-b530-08db10b3a101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GBk+fdzdaF0ZcA+2W4eu8oz6zjPyIr7IFvwCWgFlN//wnhljrKe72+OAPUV7JM0RvmoLOWyQqE536GN72tReBhdo8kZfBqIQFg+EB/AGhlEWmxGdZIhpLZrXt8p57odlcePYGecazHY0T3iuTtLH2wB8GSvf3WHovTlCrLxhnQpRftp5rA0heM1qStj2szAmNKqG+NbnqA1HwUiLuV8riTaTDpCwTjutvbkIYWiFuoVeQzwr2eeka5NdY983IPd7jVbg+ztJkGpsN9M0LZH1NW38Qd10LeUPk3Zcp3XvoXTCboDmXOACh6LJmsG7phYwHG7ku6z6+HkYzWCKxc1mM5BJJLb8ukrXrdnxFyNTUO9uL4O+UU0eSIQo/a4qE3KxOp+G789uPyKgynUfctxXnbkl+5/FVDneDOU0TZXH/VGBlzwUFMqFU/M70O8+ftnTga62WE3abK4gXUbMnnJFnv6/d+xmcjJs4mnmS2pxPyS/tkY36ZBmAbOvxa/M2S8ezkHVyRJ6aS+T9KQLOBFGa51d6LlELGjrlIqZkRUNMdPIBm/8OKELeWn78IHqbyORgbmEieJbqKk3+J5Pj+RupG7V00e7gIN0QC0DGDIovbzPwwqfrrVXANoB2mP7+4gSVBhrb7REaMbMiOfkp5nnAtkcpJZOiZG1JQql67IM47PrQRNNCU7Qd1asJ2mobhTKfIgQHp1G+Geqps03/g3sWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199018)(36756003)(66946007)(4326008)(8676002)(2906002)(66476007)(66556008)(7416002)(38350700002)(38100700002)(478600001)(1076003)(6486002)(41300700001)(52116002)(316002)(6506007)(6666004)(5660300002)(86362001)(8936002)(83380400001)(26005)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+0kPZtk09FUEMD9ftk/Fi+ERJL9zdhUvDpvdEIwaSNCHh8XZwnwHpmfn2MzC?=
 =?us-ascii?Q?JK1S6BJBPRcBctceY+QQmx8AUmGB4pBXT02L3xVvmbp82SSdKcXDOsTysfcn?=
 =?us-ascii?Q?DnvotOJqHvuRd7OerkTUA99GDAkK3v/p46cTwtD3V6bbV5BBAw/smuXnl7i3?=
 =?us-ascii?Q?kJFUeHYErXvDDN1Uh/FTG9cdWqhV+o+lP2eSuwRsJ0U9VyS99NqF0MnI0dgy?=
 =?us-ascii?Q?wz6CWeTr8wLgKLH2DZWXLgTNEPaA1wQBG8FQNjisa8RYO2j71uKlAepn6nBD?=
 =?us-ascii?Q?I4jlnX3VHsWkvMgvVYMKIyVgtIGw8lO061amz6QV/h7HEKnJ7WiJoLhd62WM?=
 =?us-ascii?Q?Qmvk4y2S+SgIKmK2v2TRrH6rhVoqXxbJ6ObwfgI7a2mrERAtaLlEodnP5/yZ?=
 =?us-ascii?Q?ehd+zctJ1adHpt/JtfbLtYcsebqGtg/KgTuDQeMg9Cwc7vrPUtVKyB6iwJ2k?=
 =?us-ascii?Q?UU4LhSC7OECLseIiBAnHna10Cx01pFkix/H+/z6lieIBFS8SnjARdmNRnfug?=
 =?us-ascii?Q?cxzOfi+4WuSHwhy7jQEpwEKMLwxb7O/DQjduY19zxNm9GAYlPrAj3Y3j+3+3?=
 =?us-ascii?Q?tPFr+Om91cVedGt2VZp44Hgu/0iV5AYjpZ9O5HumX7A7ZxmTzFouSIhWafzz?=
 =?us-ascii?Q?qTn7fn8dpeFdwHKK8VP+v26iLNeEMcUXMrgNvGsYUj+U5dIGjP2DBlLAUjrC?=
 =?us-ascii?Q?RJm8EA8YDN2/jpmZyhGFXdJ38gj876dFVhharxNdD0iiRcHc8zvzHd7NWyt2?=
 =?us-ascii?Q?zpsoZTtJ5e+JNN/cWiNNoTYenQRrSjfGutbKZvVIldjxu7PjUMex/cVZiHm8?=
 =?us-ascii?Q?RN8PQITg0PdWgIIMAzOn/72j5TwHCRNUEy2xBzbAWe010AP8hXdqfKxtMVlA?=
 =?us-ascii?Q?tq1eqcCq/4M1pfksn86o3Q1r7hnqgMTSBZyB/pBgGEQdp0qSajJwjwkemXmI?=
 =?us-ascii?Q?/nQhGeoyuhIsiBrF6Xg82fUFhCOXaJ0CcyBrtuaXGSb5ElACFJXM8F9Dz8lo?=
 =?us-ascii?Q?sRhrKX/DI4G4bNzYDwZ3BZIQlYIwE99r2PqNTDbjpr5ZrkQTanfWgUd7onvc?=
 =?us-ascii?Q?0fOKapzk4wSMx9yggjqh0M/P/uVuiemRV/uO2ih/NI0YqnTtSWXaGKq6ch8K?=
 =?us-ascii?Q?V2/NyrWpswEeBc+lUDJlN9ALzT17cH87tBhiRoivKVxkxlhlRCx1oSWU4HQx?=
 =?us-ascii?Q?EGzj17j2YSaRefyeTDIIoI9P4IvCjEYC4PIe9JdJ5dl7yK3uHpAbgUG9OCF+?=
 =?us-ascii?Q?Y5A1H2pOb30ANElCL8HYQyIyolsCObMUrktNGAUra+pjK5UTdtwBGqCWXPql?=
 =?us-ascii?Q?wSDyx3DaFqBMeXhZl+/0Fhl1BpmJGr2B/8UcZyh91EFzkRUpjrjjQY0UEssv?=
 =?us-ascii?Q?EPL96gB6N4LejpX0yAVxir3SWC9VWTUCfA5/S4s7ApWUgc/uJhTAOTQMHdpD?=
 =?us-ascii?Q?G1b+eoljs2fZXK4im/zKb6PS0LtD8gIw8tN79z4++oKguNkLEe+u2Jr6Ymv3?=
 =?us-ascii?Q?NH19RBjDIbP2Q+im4DehoHXcPU8iaT20NcOWcfJCVq8M0oEKQyuctznccyhL?=
 =?us-ascii?Q?akFzgFnH8VFy7iiuaWCC+l4Hgvr1WcBtJho4lE07?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dcb056-ff48-4fd4-b530-08db10b3a101
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 06:53:09.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3WHG/6e1nommGXRYdreFoEwhmxNWGxfW1T4HOIAfXVlQF/NvgH58tUgdTbBtDAEmdjzc+5ywDd6AF7hYBZ0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one LCDIF embedded in i.MX93 SoC to connect with
MIPI DSI controller through LCDIF cross line pattern(controlled
by mediamix blk-ctrl) or connect with LVDS display bridge(LDB)
directly or connect with a parallel display through parallel
display format(also controlled by mediamix blk-ctrl).  i.MX93
LCDIF IP is essentially the same to i.MX8MP LCDIF IP.  Add device
tree binding for i.MX93 LCDIF.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v3->v4:
* Add Alexander's R-b tag.

v2->v3:
* No change.

v1->v2:
* Add Krzysztof's A-b and Marek's R-b tags.

 Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index 75b4efd70ba8..fc11ab5fc465 100644
--- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
@@ -21,6 +21,7 @@ properties:
           - fsl,imx28-lcdif
           - fsl,imx6sx-lcdif
           - fsl,imx8mp-lcdif
+          - fsl,imx93-lcdif
       - items:
           - enum:
               - fsl,imx6sl-lcdif
@@ -88,7 +89,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: fsl,imx8mp-lcdif
+            enum:
+              - fsl,imx8mp-lcdif
+              - fsl,imx93-lcdif
     then:
       properties:
         clocks:
@@ -107,6 +110,7 @@ allOf:
               enum:
                 - fsl,imx6sx-lcdif
                 - fsl,imx8mp-lcdif
+                - fsl,imx93-lcdif
     then:
       properties:
         clocks:
@@ -123,6 +127,7 @@ allOf:
               - fsl,imx8mm-lcdif
               - fsl,imx8mn-lcdif
               - fsl,imx8mp-lcdif
+              - fsl,imx93-lcdif
     then:
       required:
         - power-domains
-- 
2.37.1

