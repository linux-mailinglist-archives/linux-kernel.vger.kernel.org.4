Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A273D6FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjFZEy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjFZEyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:54:22 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F370EB;
        Sun, 25 Jun 2023 21:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV7iSTpCRIfI+pXkt4IiD8/1f7vKXK/WW3Qoz7sKmd+DNSSMaSaaxAFzgdZryDRJqqyU6FRDyfacGwibrtl+KaMM2Ww9fMdPd0mX6S6Yk0Q6Yq05/P7VXGpn/vieEaQV8is7nmrETgTjkazMDUZFg+jZsuy9PKnufeHnrysKrHOEsVSCaCy1vM/ItYllodY6RoznAJ6Lo8msuN7lIyNTa6P8kBYwd9f5/pLlHIAwpP/6gmwEFGq33EpqTO6IngKSa1AbkoptbiplIkCxk+GS0CJhAwZj3zBeNPyeE65bXPdUljVYCsn39m6afzAXcRZ5BFouiDQQc6U94yNjR2JmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhvUNmnMvvHvCygalaGDXqwurZdsLRZqdkFH73aaxos=;
 b=WW6LOXzYqlRkpWZz+CMxB4o0wRE9uNA039EzQn1ioD1IuXHGw9UL/Rwqjw/ZDWhf03QDg+QfyBXCvmei5tZ6kEeEYGvagCzaUgUKZ1bIK1Dij2bW4e5oO/DQqQ3im07i1nbF5W2kHcfpfnjyO6N9fx4CEqx8ekcIDws2l49Bg5Ljo4Fn4gXl6sz9VXao5oBzR5fqSwgtUKQKmwkYQYJEdBmt4Y8f0FZ0p76potLyGB4BLfYwAy7m6Mf7/8fhJtxPvBiqquDIXF7xifryCj9aqHviAnw4xEgKUNPkAJRvMpV713l/JyI8ccR2iDf0FAihCHmwZ/2tSZELZPO85LtAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhvUNmnMvvHvCygalaGDXqwurZdsLRZqdkFH73aaxos=;
 b=jqBvzQ0w3YH9FsUkPivHTf7M4XiaKQq0/1ZGGvgbpcRV0/tmpYg1QekvYziMfpZsVEThN9g8WGhmAcE2rjfeimclUKPD+iekhM2AgoU27H6UroWGtpnGQeZMj1dYRLFyTHrUWENOz0KHcJEcV5RMZaJiiXmuZF2Zgmq7AgQvlt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8092.eurprd04.prod.outlook.com (2603:10a6:10:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 04:54:18 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 04:54:18 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 1/3] arm64: dts: imx8dxl: remove "fsl,imx7ulp-lpuart" compatible for imx8dxl
Date:   Mon, 26 Jun 2023 12:48:46 +0800
Message-Id: <20230626044848.4417-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626044848.4417-1-sherry.sun@nxp.com>
References: <20230626044848.4417-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 53189995-ba3d-4b88-285f-08db76016642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dD4i0lbZ7ueWdgxjX0vWkU5nUvtmNos/HVn8oqs1h6upsPrFeAtiyUHMLwMucgDRKdC1W1lpowJMvX0g4C2+3JN8ix2/sLr6JsX0kR+IOzJ4E5Cx1MEB5i2WuOL7FjgNgDkSIUAxmlrb/9TC9H8CO2PQsXNQdNnRrRZRC4O7Revx7rf7HlK5+oeZ0nTOovwjyGHngaayLclWAguxTsiKdw/KUb4u02rVHzrQMKCITRa6/hIlAYYGnaBuoRvga3iYn7+YPSP72i12HIzo386ClU83DVKRPybITj3M8mLXwnSp+XXhGJvyVEmrDwLgOSQVu8RN0EG30QElZRSvmoknzi9XWxDSsWXhR3cOY2CX+E5rDeLuFQpmw9KlVJcLCt4s1e0hz/njB4eGSt7u3jcsnw09Pd72/ouWSQk/T8KVhic5u4GqI7QuyTr/xOCHhcp79hiuI3X+jEaaWzPnBuMGN4sYbJMOQYiW/WhCd/QfFHQv8wt5A4fWK19R6YmJCSiQGl73fdYdH9P6tLIUZMIAD33FCzegqryTwAWbqkg7D8tu/Ylx/NMjmWuVUoOr/izrqa5QSDg7zyoiYpQtfeNZdLJV2MWbUFsOoLFx8fst0MN+v/V6Ijsz9UvwynB/vjMS7INAixhY57suRCj6SMfNxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(186003)(26005)(2906002)(52116002)(6666004)(7416002)(8676002)(36756003)(316002)(478600001)(6486002)(86362001)(4326008)(2616005)(38350700002)(1076003)(38100700002)(41300700001)(44832011)(5660300002)(8936002)(66556008)(83380400001)(66946007)(66476007)(6512007)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y5GCkFDFzV3qyKrX8PXqY+7oY46pTcoCk8jKinVGj/VOtjIrV0N2Xfca9AWY?=
 =?us-ascii?Q?241TSt9tWundqEAqQT0wTvOJD/6hYyEb+2dIUqtiuA/P6rcu6lF6x+LSqque?=
 =?us-ascii?Q?TCGotBNfGhr2PxebTHzHq12jOLS055geSmSDwy1OWGxtCBB13Lv6dpFFDFKj?=
 =?us-ascii?Q?M2cPV1ibm22F4XIDFNJ/3XUPiBXRmZaKAfDfN6o5I/CQPX0Zv41v8N9vGd98?=
 =?us-ascii?Q?EuTDJYlKK7mF5vJrvLmxrMB0bOfT2HGx+sgQ2NMzHBG8yBMUeQ/QksrYsYpe?=
 =?us-ascii?Q?J1s3Oic8Xa4FObK38nny+wvkCYKUfXcgPH7fL2BaGylvkYWQ+QdXpq+/n2ME?=
 =?us-ascii?Q?l2GAqfhJjdlam1nwn65G6wTo21fmaqXKhnU2jvQJRRY9NnJon8tb503AGEuD?=
 =?us-ascii?Q?d1VCWjgmqPkqd9r+Udl/OShdqs6OqEzzCEOp8hkslB3l0vajyHoWwzZp6KlG?=
 =?us-ascii?Q?R3ZZqvpeL3csc/l3jVpRTOtqAdzYv2abO830XUv1zzoSMfBZW39QHZSyeAhm?=
 =?us-ascii?Q?sUIETturwPmPnyQ8uEUpZGFpYxyGyaF7OPX+MSkd+21YvH/ylrwcnomVAzit?=
 =?us-ascii?Q?cHWUguQZlxeU4+y9XPbtYceqpNPVQNRIY32YiSeRO9JpS5jEzkk3X8wKZLva?=
 =?us-ascii?Q?Hp2xGmjBvhKx2Z55Kkg+J1wlbOVaS5ox0hAjmy2VkawHSehJUYocNwS4+xx8?=
 =?us-ascii?Q?4SY008Rk8IoOml2Y0wFtnQ+SChrX6lxCqhvykM399oAh6numa0eVzu1cvmKt?=
 =?us-ascii?Q?KX4CCLzhSPH8cWdTCMkXBOf6rTo8+kK03MnAISjSA4bUgRqz/qFGC36fillg?=
 =?us-ascii?Q?oC/OXTjMn3yDBJNYTXgFx5Bo9VQ7o1VKtZFjlJauxvIcFix3vllE06RjLjz+?=
 =?us-ascii?Q?y4Qfumma6ntRid8eamPQQUQOMEUXH8DTmfsoGLmKbbibCz5yfFfU9bXHxNJi?=
 =?us-ascii?Q?MrGZqYXxM1J8ks8PpY5pEDPoE7BkrzOfXvGpHNHN7INyL1V43hD+wgt7zdsO?=
 =?us-ascii?Q?EsVbRJTmqnzPj1OeR7PFm76EYcLlwauQPBjrGftNi6Z+TNwoiuedQOL3Zjfb?=
 =?us-ascii?Q?rRkeaCW5BZ/MHE7dC86uiv/ZgdWukwDyzDg4RJuqDelrMFKZGUzy+lc0BNdJ?=
 =?us-ascii?Q?VtIhnp/NMS9VLTzYMBAeUxy60If2KYMKothHQdIP16UNJ6ELvkdYWuTFGt+O?=
 =?us-ascii?Q?b85rYmkbjogGSqTVLCPWPkpqqROHzRZR9S/dSZukveLvWnTfO4XOGae4blIa?=
 =?us-ascii?Q?FiyBrdAY8Bs9xWaXidIWE3OK9JB1llI4UQTqW2J8IXFsLwK3d2HVlE2PJmym?=
 =?us-ascii?Q?+F9lYec7GEFZbkSZfv3drlRek9lHbaUlJP+R8tnNfV2jmNC8RbT0WQ+1OMT3?=
 =?us-ascii?Q?Rj/Bfri/Ulu+A9d6v/Nu4RUOw99b1s2pLNIq5lW1I+6Jf1vU/H4Dg7cxWl0N?=
 =?us-ascii?Q?4vVev/rHX6L/6n6RRMWSJW8VqB0uvI9iMLU1i+HE1kJ8qJnuqdBYtmsi1nq6?=
 =?us-ascii?Q?injQ7do2cU685zDJuo8MRAyI+ZjG9zzK1yHvdUKPso5Q1N2hOnZEMyGonC5T?=
 =?us-ascii?Q?Sn3DeqMkUnwyM5OIvZ+BLMTwP1UvlMU0ffCwFK43?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53189995-ba3d-4b88-285f-08db76016642
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 04:54:18.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JagC5nCxXjou1+39xOvMEUfT95NozisKNhyOOtlg/4CdOZD3aHA4QqMcNL+LElsO2t2mmdWZ7knMLkBSJr7iZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the i.MX8DXL backwards compatibility with i.MX7ULP since they
differ from clocks handling point of view.

dtbs_check has the following warnings:
linux-next/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: serial@5a060000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['fsl,imx8qxp-lpuart', 'fsl,imx7ulp-lpuart'] is too long
        'fsl,imx93-lpuart' was expected
        'fsl,imx8qxp-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
        'fsl,imxrt1050-lpuart' was expected
        'fsl,imx8ulp-lpuart' was expected
        'fsl,imx8qxp-lpuart' was expected
        'fsl,imxrt1170-lpuart' was expected
        From schema: linux-next/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 6881330ab4c6..e2eeddf38aa3 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -36,22 +36,22 @@
 };
 
 &lpuart0 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart1 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart2 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart3 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-- 
2.17.1

