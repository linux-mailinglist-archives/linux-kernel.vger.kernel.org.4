Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0146BE94E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCQMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCQMdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:33:13 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD1D73AD4;
        Fri, 17 Mar 2023 05:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZspbcUqZoDx5LkxBoHUm1XHWq4W3cUmc/g6cgnUiuxWGP1U6sC8I9MV1cyTKlF0mgIzsHmKjeoZqk9+3XQzuOnrrAtxdOyKLG7xamc8yE8l3It3FM/mP7joVhrTgCeUqjnNq2BYeJB3tZ78xNXEMY80yraNGzmh23UlZhEGX4aMiyXaK4jhk10AGS+zSAug1OAxDgIgYf5xziQqgfHtUOG9oFTUNnJJGoU/Hq+KUCBX6MHHwUNOQ5GpKYjb72f6qm6h0J3qfAfxu2YktYa9ky73NVcVm+8gDmACBXNC+ZbZkKT4Z4RJvgKhWWMxmfBXYBYFJyVRn0bMooXzNbPLFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff4ng602SoshLDvQgPEcxyiSzsCtkn3MaccwzpQapdA=;
 b=GbNpivjE7DlY4nSt0ynkBTOU1K04wAfofBo4krkw7+mAsZcDOY0GxxzvNnQUlLPIyLn6V/zIkkP8Es2gaLw8341NnTsT3m869Fcke7XHZzdV9wqzqai0dHE7r2s11uvc6XptK5fnrP3+kI6SY+E4nEEACgNWtTfzdCUq9IMpkLzPXIncMeM3ejmEEY4WOB3S72nqxoRGK/Kbaqbc7bNVyfBzVsayAuJQPuq2sWvi/auQqE5cYoT7BHz5BK/5KAKy2zTabUNv/A7OZpTo2oEwu5QUNx+4f7f5J61IYbpTt8DlT6A5liUgC3GQgD7q/eX2USQJjhkta15JToDfj3KkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff4ng602SoshLDvQgPEcxyiSzsCtkn3MaccwzpQapdA=;
 b=akH3fMxTQz8IGOwZP7A7w0cjSzNFQngNpMUDvkPo5l6Z7CInEfnMlBdClcAyyRNMbpiCJ3d1mMeoX3q8i/cpej9VY/3xkZjYgMrbOw6r+/E+E/WIfPP7axbb7ROoGBgkZtapwCJz+WMuBmcZYv3Mmnt/EnbmqQkGxALKosaHPM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Fri, 17 Mar
 2023 12:32:34 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf%6]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 12:32:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 6/6] arm64: dts: imx8dxl: update usb compatible
Date:   Fri, 17 Mar 2023 20:37:08 +0800
Message-Id: <20230317123708.337286-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230317123708.337286-1-peng.fan@oss.nxp.com>
References: <20230317123708.337286-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|DB8PR04MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 4651bb16-7bc1-4c01-5c6b-08db26e3aec5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5RCEzOqGGlrexes4NaT0CZGXZoIP70qgRcgcdnf++xRSVs6VJ+wwjUo0LiilXEIRIoTEwMpagC+856oL0bgwqhJ0Uw/LZGfzJw7r+HDT1QYWaMAGSnX/GOgrYlBUrxjFaxqWDF3VrCwyl1HOclTIssp1YntDcXUBSx099LifqNgdZ10HcpLBWb1f2G7B+1+d/2thyi6tbjVKfrE0Tt/jeheqhS6UvX+RJh7pPNpzO0ovTLxRDUMXK6EoDtOTSdHsYCsw5kI0jGui4mAwPP+xfZrzgZLurLcZvfVlE/CJ3FhxOy+N69v63JXSvigtIM68CtiPkUjopBaLZdSblGq8huypVWzDLD1zSkQXhJhiERDffoKz/wKogQe+yiGdOfsQtXEqiUT2k+u54JOEPUrecrnKldeanpJM/+koboqaaX7576bspG8/u3yW70/4IbgadUb0cFzUCVMwLTgLPUyQanVnfhXJ6ec4BR4F99VIOr5jumd6SJ3012RB3MjZi4R7Jt6VW0hr1lCqK7tr2iih164gFuhPSO5YOIPwzPh1D8b0Xhzhk7sW+XRDFsp9DQX5ccm/rp4jF5Ck22tLMh/K0G1La/q7DiNBGz0CbBKLwvvW3n81BoqPMoTUEhZVoSpzUZjttzwGn6lr8n43WemSHX1LxFNFhFgJFeeYNkGELqy1MvzLaWXgOUuJlcpxOE3noadiXSdowdgeg+MSPZDiObIIrGmQSDa3poqFjn60C0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199018)(2906002)(5660300002)(15650500001)(7416002)(186003)(26005)(2616005)(6666004)(83380400001)(6506007)(52116002)(6486002)(478600001)(6512007)(1076003)(316002)(66946007)(41300700001)(8936002)(86362001)(66476007)(38100700002)(66556008)(8676002)(4326008)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LvBZwgAN0+rZGqcMOKcvHwIj4nMm1tRwRRO3PsuPQBP3nlzDOglGCwU0nKmI?=
 =?us-ascii?Q?3aPxGkIU4T36bJR3tlIwLpVTaznRg3XDZyWlQUw4z3Bz2MIoeF0xbpIcWDLZ?=
 =?us-ascii?Q?uQM77pDhSq5wLc1aubJhoufDUei7YUxxwnHO92crUXcEFAwGL42Lvx0Ll/iD?=
 =?us-ascii?Q?L/RQ6QuRQ5aI+ewGdGcyfoAoWDnIAxvn5mICAR/iVcFHT3doIceh+bOW2fjq?=
 =?us-ascii?Q?n+qR+K9EnBUlJnrtR3/BNtcjvw36aV0CSZAluwm286C4thy4z2362+MEhgYP?=
 =?us-ascii?Q?sbFXc9SDkV2bz6gMCIGQUiBv34w5Y/7Mz0VtK/TB/EnxBBa7GYZg3jrM8rsA?=
 =?us-ascii?Q?IaGfgPvyP0trUfcqanbVMNlw4ebFrv/G5O9BJh5qky8kwkMkJIJ2IusZXRhP?=
 =?us-ascii?Q?tuONju+24AoFuwhOOHrCB5622vaoXQQqTCt3liQUobxDPze2YUHnxeyOjH1z?=
 =?us-ascii?Q?7fvdL9eLzPxrQ16A9vdijdTy0g33281VraPD4WlVVFlH8U13iayMq1Ur53jC?=
 =?us-ascii?Q?FcweaOXqtqZcP81cdHdhETQ/ToIKRJUaRIxCmmm0emGmS6p7/ZGD11cRvawS?=
 =?us-ascii?Q?8shM09zXXKmb/WsdzvKaJS6L1DtkvYyyjzPqO+3U+sUYT3Ts1Gpt+sofKVgM?=
 =?us-ascii?Q?ynOa/Bd9m+y/A0dn/PXbuimDAZt4m4qyZaIDrWW7cKppAfXJ8MEkbyvSH9V2?=
 =?us-ascii?Q?O6Vp5rab3FNLLk7uQtori7Tu/0vp0hlypm62P9+Y1IShl29HF6mfnjzkbLTZ?=
 =?us-ascii?Q?sB0g0LeEow/OyV3j6UnjZ6nLZe59MCbX+21HQ3yc+GMQDOEqhpFy+0ET8H29?=
 =?us-ascii?Q?bj6KX2EwjKoyi8JZRvOr6hN/9YViqqwUFw5DcERpEpt42yLwBxnQfVsqIzSX?=
 =?us-ascii?Q?TiSbFrA4lh2tDLnvA/E7r6N6y1rZL1Wb1p0E1cnreuAnZmJ1I344Jqi5qVAa?=
 =?us-ascii?Q?TkJHoyyHMsE+4WV0l2eY859SZlKwnx4Z6CKlq9S0Dmj18Yvd4qf9FFYMsW4z?=
 =?us-ascii?Q?u5pOO1YKELLSrhzdmDBtC1+WRyMzRtfZwMjTJiTUbIIfnFHnlqIrT5G9ijBd?=
 =?us-ascii?Q?4iJob5PVuOwhi6MlhqrMqLFYodAUclzmyQ0FfdS/pW5pSXuCtYA8GE31CPeS?=
 =?us-ascii?Q?YPkB1pXdmVDXbe7cGyZKPu7qaOwoHaIdg0c2ltvXsrm+y1glldNYF3hS+b44?=
 =?us-ascii?Q?ICwjdO+YuGrq99FpZ0zBIOv+/DjG9ySnNjLIqm0Oe+lC/gXVZVg2Y+UlNaNn?=
 =?us-ascii?Q?k6oN3j6fWTJaMbf7zWTlP16oao8LPfAm6mgSgM/awCqR0AuqYXrspxFVHkDu?=
 =?us-ascii?Q?udlZksh58a2mKubfzZKNFF7f9wzOolMyBZdqDbHHFmjbWXjCKhaC/7KMoWpd?=
 =?us-ascii?Q?fxKVySJNEfhDRFQZe74wjSbYoFrh87XJlnloQkJBCrX6kM5tln8JeGgYbCGh?=
 =?us-ascii?Q?fatXFOzIfkrJvtlIGWqsDrcb7tq8NUCYdNtIpIt+9m81sfjdcsExu3Qu+bkV?=
 =?us-ascii?Q?M3BXSI+vULEzkqPnftZfbqtVxUst3KddstH1gmmc5kyp+mZxqFlgWoASRArG?=
 =?us-ascii?Q?3+iblwMZEnhsmJzjv7El/CxjWbA/+PH6X83qp/Cm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4651bb16-7bc1-4c01-5c6b-08db26e3aec5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 12:32:33.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76r2BIGGCdKxh/6D8elq6zpngETeKpW1h7ZwPouwAp7yDaBtBONv4hnIfg0wkaVTW9tGUsc6BFeIsClliVytkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index ca195e6d8f37..88913869ae9c 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -34,7 +34,7 @@ eqos: ethernet@5b050000 {
 	};
 
 	usbotg2: usb@5b0e0000 {
-		compatible = "fsl,imx8dxl-usb", "fsl,imx7ulp-usb";
+		compatible = "fsl,imx8dxl-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
 		reg = <0x5b0e0000 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
@@ -63,7 +63,7 @@ clk_dummy: clock-dummy {
 
 	usbmisc2: usbmisc@5b0e0200 {
 		#index-cells = <1>;
-		compatible = "fsl,imx7ulp-usbmisc";
+		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
 		reg = <0x5b0e0200 0x200>;
 	};
 
-- 
2.37.1

