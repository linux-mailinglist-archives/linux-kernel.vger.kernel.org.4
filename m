Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3035B6FD940
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbjEJI1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbjEJI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:27:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E8E76;
        Wed, 10 May 2023 01:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITziIOZ0q8qibZnqAb/ndRKUhbUokqIj+b5RHBs/f3c949UwnzsmQWie7InmzcvV/a9tbdsIfv54r+cSl5v0nMT0pVR0dh6vepdNXAxGIZOduMFWgFTZKcsz1DwUQsXRpa7KZzVHlKsg9YCSuBAT/5EZuZhgBTfRQMix8Wa6i2inYujQ6Ota0en5TP2qHxNCjeyOcZtS5QufRRK4saf8EN3VZv3qwkV9IGEqg7xw0pjqFLybiwrDDErnJVJxNonw0Hnh4jD7TCG8cmZjR6F85zA9HLCmIqlLHoAfCWznO5wIpCYqUZox5L9VfsNkaMIidkGQZA+4hWUrSLkP5fLZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYwcBgQXSp+oGhTpd3Tw8wm/J1szrb/0m7lypLR8YUA=;
 b=PvCSvCdlw2IRTIOqe2p9xjSbGy/bDGl+HrEfpeJxZ40r3xLQXj5IK4YkO4dtnxHwz3FcGcpX37syYvOvRPmGRjC0b/SqZb+8tv1rgbEFoThp1fXqIqX2Cs4Al84qZd1jqa5e295OfXYZAhVQ5RM3bmxnm9ZI96sPigs/J9cwMonV0jkHgIv03KXIKdkO6LKgTqXc1WEOih/PbN0lGxRiwAX/NhTsCBSKQ4wR9kYPKqVr3/LPk/TxaRZk7VvMN+IjuazzeW9lRy+x9PcWTilo5Gu4d6OtI95hgzt/i2KsFTxe6web56aH4j38u9bR9AXaNxhrpvAvMsLWPGpGGIVk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYwcBgQXSp+oGhTpd3Tw8wm/J1szrb/0m7lypLR8YUA=;
 b=kSHIBg816iYKsksceQW/aQpFpOhwKbYxGh//7DKKVJ6pV/Ata86uVKTDHHJogD/nVVCKtNk37G2gRnLzQOf587CnfGiPuyBq0Hvg25u/5Qyb00dqyibavu2EuNX9jS1kg3j++5PE8ztNRuKaHfYlqg38YuFZ73b6nmXdCTrfc9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9368.eurprd04.prod.outlook.com (2603:10a6:102:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 08:26:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 08:26:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/5] arm64: dts: imx93: add watchdog node
Date:   Wed, 10 May 2023 16:31:49 +0800
Message-Id: <20230510083153.3769140-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
References: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a2f906-ab42-49b2-c2c9-08db5130525a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVb3/nsFjh2+JmWIkdOQVf7dZGlxgnliVCc9/dReKA8hWi/d9PmraeTyrexwiIHIG82SeTk5ND2QbwddddheMAlyHBuRR01ZeC4fZ+eqiac/t8Z7Ji8BuTH28Dize66myj9CgWoONBRgi1jR1KbRvYwvY81sDH4ZOup1rZkrqUGa444xen5fWSdnOI7IHWf7WHfSYM6fOlQwND7+hmqWhTUf9+pVSbqg1ZqfhMlO102D/kJV/ZJWP/mS8oqk86eVphGFfC/ugXd4HCXI9Si/iMGOJV4gQfilvjDqtX8pAeYiZSfEXbXV81oUstf6NoPIl8LasAiQnnwiMOxDR3/4zFjV6bH+ZFDHotV38+tVtJ265F3H+0wEU4pzNHt0c3+WokylnutJTtC2RmFb/1aLdzfaAlfqULH3eAUaXzNEhxlVWcYmWNRDVOL7PyZwtW15ck0+MA3i31SYAjy5PGJaFrFGTD5cEkSPqJuq42ZCh4a/6daxCETO+CuVtLcO4CJPnViqe0J3m4+DxDHlbXNUBLUpzUG2+9dY2H8GbUVLfHsoYguGgIe8oxaaxkBZAQ0J9SAqJFDBP0SmF7K8IW/L7oCAJGRwjEXNSl5DXmNK0bhEas1KmJmnrttaRab+54Hg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(38100700002)(38350700002)(4326008)(8936002)(8676002)(83380400001)(2616005)(66476007)(66556008)(66946007)(316002)(41300700001)(6506007)(1076003)(26005)(6512007)(186003)(478600001)(86362001)(2906002)(6486002)(52116002)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1p1miDxAtahK314b6zlEWhIUbgdA+2N/fZcIjeMvDVF0YS1J0a87xXoddlmx?=
 =?us-ascii?Q?nQldUy2O2c1ojkw8bq8Fhop7FEVlgmUjyWJDVnh1T/yS/dFeo5Xgj9gzjzSz?=
 =?us-ascii?Q?k3wpOMDkdf0bJDWIlPssN0LjETLD/bEuSrDMPOcigWlTS2acmOCMP2hnuko5?=
 =?us-ascii?Q?/q0Vo9RZMijZtzjEDLLeGp3fYPyVBshmOp2YvwkkXlM+J+ROkhW1Sds/Iq+T?=
 =?us-ascii?Q?+A7srhLFupt71XAMBPnliur5GW9YsTf3eSRgMu+Z/tMAGebZ4T58pkpn33O8?=
 =?us-ascii?Q?HOT5FrrfFVjB/x6n+ah0wTITo5cFi5lj+mTyRuDGrWDTyJN4e5ZYewGdSwbH?=
 =?us-ascii?Q?ghKVdmt7WjzTsOwDXN7o4n1e+A4sSbBbhLVSRNk+zUEEPvqpzQOR2zCBG3/2?=
 =?us-ascii?Q?v4WQ0Lg7gDpozlKd74wOmNxmmSkoT2mXpn184GDjq8iHcUBGOb2K9BKlRCfS?=
 =?us-ascii?Q?kl2YaRsvFL6WLgybHQqPmHd1sGAzbWOv6XaQAe6UWYc2tiymr3C0E3sVOabz?=
 =?us-ascii?Q?LNhzIfuUqX3KyQ8AT5DA7JK5w7OGsR11TL78RkmSjWyRPr7rwSNxp8fCGz6E?=
 =?us-ascii?Q?OUlY22Qt4AV1854xhAWz47BC81wVQSeqPpuHcU0SHkouqfcKhW1y3/HEM4dq?=
 =?us-ascii?Q?xAHZ05ZMyQgmpXkda7ZR8kj1HeXvk0HHEMXqf5mZs3y49SLa4cKs7WxGSG5F?=
 =?us-ascii?Q?Tu9uvvHzcoxwcq/LxfUIWR8S4OCBasF8b35DVG6C3exJAuetzO+VuyYhSZk2?=
 =?us-ascii?Q?JN0A/+ZBt3A9aL5oksdvuI701F6Vzh+hLYH6AyLmyr1GGrbzjyE18EWqOjWJ?=
 =?us-ascii?Q?JZ08rVcPb/TpulU1IM4Vvc4bpCkW04jkImuIAXq9hV5tkeMx5BAEtvsulcic?=
 =?us-ascii?Q?q836gv8axVQmp4n4spFhUT9o++TVsJh9PvVhq9bxuzaxREhuH9z8Y+jQGBjf?=
 =?us-ascii?Q?WWB/Mfihxvoy7ay9QnPLDJXEG56NEvebR274YdjUhVgiVl1eJkGu4E5PxPg0?=
 =?us-ascii?Q?FwnGPwsj9QP1SqlMEyNWYzjfwZjKI6s0X6vLCzLZExzdGxXR4WoslUCecTZb?=
 =?us-ascii?Q?MFNrcqkv39vFBlt9ATCps2bV8MYLyWfIdOz6HcAkme2xqJD8FnZkt1kN8P1Z?=
 =?us-ascii?Q?iKAaiJY3YRawtYdC8od0Tpa3gHeNFX58kzNcJN+H/nnd+BrEay9WqBqodUJE?=
 =?us-ascii?Q?BvCTEvzGgl3Hy8RtWcNUFzNsy4LJTZnEk/l//0ZfgEQapS8Eq9+M+Eqi+VZn?=
 =?us-ascii?Q?c0uT0e+mAFQFgzAfGlKIpihTaKCX2VSNyR5RSgYv4d5KjTtfZXlF7lGvkz10?=
 =?us-ascii?Q?6CspxOXg/hY81w7leETLNPFDeoZMBSFk39oA0BMxPBY5zt4aRQ0OBL6c1wpX?=
 =?us-ascii?Q?6ZMfSxe8anGIs8NYvpbTlMeM0mr++2wrVxK1iY6I6YV0YhYbt+jASY36maXb?=
 =?us-ascii?Q?udjN3jjxv19AhvRBdqFbTGJzKSe+FY+lbLUqOSZ4zt8O66ROjCSBcODsNi1p?=
 =?us-ascii?Q?AP0gHyObfbX+dVv5almYlrpHbbDqocvr9KtgQ2uVGgWwGNAjgUOPuFuqr25e?=
 =?us-ascii?Q?BQ9k13LHfwLdYuG86+paio16Fu42WSej4KneqyZs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a2f906-ab42-49b2-c2c9-08db5130525a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:26:58.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08HBJSr0ACctd17pnZd2LJKZjl7f21232IY+NEZ0wgg9JK+j/0u9aAvQ3p9NQyQ92W9xxtwZ9Uh90FruuF9N2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9368
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add watchdog[1-5] nodes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index e8d49660ac85..a04c63d4dc06 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -153,6 +153,24 @@ system_counter: timer@44290000 {
 				nxp,no-divider;
 			};
 
+			wdog1: watchdog@442d0000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x442d0000 0x10000>;
+				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_WDOG1_GATE>;
+				timeout-sec = <40>;
+				status = "disabled";
+			};
+
+			wdog2: watchdog@442e0000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x442e0000 0x10000>;
+				interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_WDOG2_GATE>;
+				timeout-sec = <40>;
+				status = "disabled";
+			};
+
 			tpm1: pwm@44310000 {
 				compatible = "fsl,imx7ulp-pwm";
 				reg = <0x44310000 0x1000>;
@@ -344,6 +362,33 @@ mu2: mailbox@42440000 {
 				status = "disabled";
 			};
 
+			wdog3: watchdog@42490000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x42490000 0x10000>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_WDOG3_GATE>;
+				timeout-sec = <40>;
+				status = "disabled";
+			};
+
+			wdog4: watchdog@424a0000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x424a0000 0x10000>;
+				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_WDOG4_GATE>;
+				timeout-sec = <40>;
+				status = "disabled";
+			};
+
+			wdog5: watchdog@424b0000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x424b0000 0x10000>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_WDOG5_GATE>;
+				timeout-sec = <40>;
+				status = "disabled";
+			};
+
 			tpm3: pwm@424e0000 {
 				compatible = "fsl,imx7ulp-pwm";
 				reg = <0x424e0000 0x1000>;
-- 
2.37.1

