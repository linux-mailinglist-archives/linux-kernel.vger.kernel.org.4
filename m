Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDE2620688
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiKHCRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiKHCR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:27 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F72CDFB;
        Mon,  7 Nov 2022 18:17:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2UF8Szfh7PA8ie0tOCvfDm1sbstjyz+El3Nq/VG6cSVsWU25cbvHKOiEW9gJPjFE60Dt3qQs42/obgikmXB3D4B2+SJDL//yGwFPcSP9CeLZe73/I6EEgKMnuDtqBp/KFpl12t96z4bxFmAOhI7HmbsL0chffwZQtTXkMTroChXnAKAgdU/Ie/49+mRSPGqLahUDUOVUCyED7U3DOyWILSMNyP72pFE2ee0o0jJffB32M44qou5pMKPFO6Sz0EfjFNH/8oenpT/Xxjrc3jQtTLeDJ1dtyoe9g5JZXmW5Q8/fpO2zwGBlv589a+ksbsuKizkURwulTkd9JIv/alM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp2YYOSAdZyP2Ed0cVr3XmjW1UCXA/Ikw+0NhZenzck=;
 b=GHWfSg4ityQyMLMwwUMdu/KWnq8P05SxfxGaw6FBSwt5XuYRoHBTjT28WLJ8TrkZ75Idmq7gpz7ndKygrMIAYlzrfmnvWa1Jx8nxefW8s9umLRf4nYYMLWiUQpebg69Ui19SVAR7ZVEnftR8xI8tqYp1bPyzFDhuf6Li2Jz6vgdzG1Mx/Ry4g4SIIdR2KFa4rpRjb+bt5pcYpGSp9O+rEAXzsdUjv4KOjs4zdJqBPX60xn7aA2e9m0J6Nswh6blCpi8hTEoI/xjpzxO4PUiWQ+HDRv0PgQ8F8po7spUOA0bX2rJnF5rdPDl7ITKo7ED2Yghpsu3oNiN09wWhfIY7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp2YYOSAdZyP2Ed0cVr3XmjW1UCXA/Ikw+0NhZenzck=;
 b=b8PQ0Ud6HL181MkHE/sj6pDjK0xp1dUr6WuZJ1duw9UCGOvnXtACioZ4Y/gHgqUDbJCtzyXrKoi3KKsweg15qlHnu1CfAZKFuc/drrhaCLjL2GpA7a131jx3s4mTeyp4PbOixR9a2RwQUMF1tSlgf0RzeS5SDflRyDZ4C76JWIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:17:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:17:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V3 04/14] arm64: dts: imx8mp-evk: enable uart1/3 ports
Date:   Tue,  8 Nov 2022 10:18:10 +0800
Message-Id: <20221108021820.1854971-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
References: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea2a54f-125c-4428-d8d8-08dac12f5d11
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VxEyK9ukRihj3Y5yQH+XUL50c4XlghwyyAraC/5CajVpHMJQz8wt1nZP5Og6ebWN94eXcDEf6CwWpi69/lCApx6g3YEDeps7x6v3SnsLz2AFDC729srTa/Pw5qWVmvSD2lghL9MdQ2aUd9y0gHwTSIOM9OnKqSrjVw1oDN1LPO+1Mb+nbmn2b8UzKYtHUGHBOXZOG1t6TxeERfGiX4WL1anvJdr0dUJ1gjQAV52PJZK1p8IdZ0FWH7GQCUm4n8ZVeeA3YdgUTX/uvJIUWqLoLMJKco8DAEBxvDZysOs7XNB9WJVgqjXA/f5sfmNCqlIVuJ82vLZkkfDr2eJnmLm27PESGuYYbPwZbj9ixsyE8NxaHmyWw8+2wPj6n4ihzFkzNrPecyeBhi1UhFj/oFvkaMK1yyPMAacxSPJ0I7KOcsgCiN91okWvGMZDRvZBoJ6SzfQWOHwDlCtTn8591jXytrr84Ej0na/Ua5b4rgFdp+VGPj8DEFQj1qbhRGgRYsfymbgV/P770/LGSfTRdBBUznYAbieRWvY7sWBZfLF5sR+rJbMguKHAxB4noSzeO/G6ePz3dvD12Ok0y9pmOA6qnosx/6Rjzw3bOMEgIlxmePaOfp6ymmQT8oaUl4VZzp/IB3A0Lgt2A9DP913R1jxJky+LHnywvpSvrH0Z5pZ29R+JjKliDKEZYIKWMUblP0+Xw2i5VHkFEFThKh9rXAiHuhnmYUIKvIhqUClGV+GtZpO9Th3eJ24DdhWHGgNXRtB/YUqsFQ2TSyz1+Qj5ZHlXKhyvT8V1FZ18uPgR4/hi5IXjRIRGP483O61+mB4pBay
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(1076003)(5660300002)(8936002)(7416002)(54906003)(41300700001)(6486002)(2906002)(86362001)(478600001)(316002)(8676002)(4326008)(66556008)(66946007)(26005)(186003)(83380400001)(52116002)(2616005)(6512007)(38350700002)(66476007)(6666004)(38100700002)(6506007)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4t+W9b96Yg3zmQqZHU6bLhVrlwIp63i07/B2h0kopnqfFZ8gucSqb7AFcNKT?=
 =?us-ascii?Q?N6CWNw+Y+0BlJoXyguXaRLDH3jPYcMvLDVp4XZ2vklMpP2+lkenq10d1JYRB?=
 =?us-ascii?Q?uzWwJJpjp11QJwHCh5jfDvTqVMO/T585wMIRQF1EE4qBW4gp7VVQxAXQfOuh?=
 =?us-ascii?Q?mHKoPAlzK1S+oMLfkM+Vxbwx9k6Gv9ZEBkj4aoLUDQAlyU1a3cabcXMsb1NF?=
 =?us-ascii?Q?0SMArsp2FnNr7ilyib2+blaZwUER+kWLxBTxTMXfPr9U1o19uxnJBQ0eRZHv?=
 =?us-ascii?Q?InQ6M5kPPDiyG3kouZ4SDAnkYrJtxel/IfbkpJR5F4JunuAmFpJz5NBPanSZ?=
 =?us-ascii?Q?iE3qdzkkoCbz5WoTdjYp5SU4lWWz1ZIRakc7EnkV3t5EfZjiBufggv3Bfyfb?=
 =?us-ascii?Q?nLtfqMmy//aADaI612I3p2bW9raX6oSKsAPGvz36izdWClMuoBrEsWr+3o+l?=
 =?us-ascii?Q?nC45gyVNYLWqYL5zS1Bbhl5P5+92pFMv9rdvCypu0DExvnOEOfbbxuRjopry?=
 =?us-ascii?Q?UV423ehS8O83gHa+NbDprVNuWUnFAjJ3cwDWcEptW+mS2UWR+8gQAs6apioY?=
 =?us-ascii?Q?5iiaohRnC9cyh34Q5xbuLxpYoLKq6YfOoUCio3KbMnnTfneOhfPXqI4Q5tMA?=
 =?us-ascii?Q?qm0DLHOVyv9cnoTDSmcE7AVPkzgS6PIXtRD9mP9miyPtNI5ETYRP7V7IEpIz?=
 =?us-ascii?Q?jYuTPqy2PBZlvvLpNtXmyFRSvZYtDuQIlE0JWbGWF/yUFUa1VDnABWUU8ST1?=
 =?us-ascii?Q?31+O39OcLKXpsAIaiZIC5Vu9NI/k9UNCvRDH2ci1K6mmvpmu1iYogueArC3M?=
 =?us-ascii?Q?cvM51kfBNG5ucIES7e/0LZMa5IhrvavPnUMVt6geL4YF+ctzvL1k3vDTXae1?=
 =?us-ascii?Q?tgtz1W0uVCvOyKKUMnKW+R9sHNxfwB7WUt9mChAnS1/XaBVaga2TmexsjmDh?=
 =?us-ascii?Q?0TTIW+x5PJOzeGanOw34Dy4Vjr+MB4zRsrIdANftQBFydJBPu+IcOJmtF84j?=
 =?us-ascii?Q?1tWEHB4FRw6LezrJLu5F2BT21f2BTIAQ0QJz/XKvbI/M0NBpExSMrVNMdkgF?=
 =?us-ascii?Q?ECu9d/RQ5r2v5zdiymd+/pjg8xJwlMXpKRULaGdtnU/SV78oiBXcsp2tZ9yQ?=
 =?us-ascii?Q?6AeKO9jNkVWSjH2Jh2h+qJUt4VK2ShCouTNvaMyiqwBOD0cpXurdzDasBYX/?=
 =?us-ascii?Q?Veyjer3aAv/YMdxtgOz/jppe9bdLp7aHl93JDtWCxQcs7MkeF7ecmKlxq0wI?=
 =?us-ascii?Q?uL8aGGTDguUQySccWiDtVfgpDwxevY/w3Cm6JqePoOi4F7TqHuIXKxsBBC61?=
 =?us-ascii?Q?el+RPLGL43f4/8dI2afhjfKlxmEToQabT+ziGdMXeUkOhPO000o6qwoII0DB?=
 =?us-ascii?Q?DENPxBQ77Nml+KRGKZ04c3Qh+r1RT5oXbGiy7VAQB/cWcXkBu4TH9eJd4Dtf?=
 =?us-ascii?Q?kmUyZ/82ll4xqRPgHNFL9XCDo7XoXt+GFLs1x537Jh/rcA+oKvNl+7d3/2GS?=
 =?us-ascii?Q?yH4jNIGnV+fU29h8v0GsGnk+1ju1IFaTKGVcc7B9ARPH/Yz/9axk2Hferez7?=
 =?us-ascii?Q?ENnZxZl4dBgdw8c0MzyJwv5HVd5eRTnUgLQENupW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea2a54f-125c-4428-d8d8-08dac12f5d11
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:17:19.8076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIm9Ig/IQhYNOlZqQjOGkXRjeN5MnMAw7WF3W47b8rtRT6oi2/lc6P3hVIMvUgueCcygFvcG2QXvtKm31ynobg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable uart1/3 ports for evk board.
Configure the clock to source from IMX8MP_SYS_PLL1_80M, because the uart
could only support max 1.5M buadrate if using OSC_24M as clock source.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index e323e6f4b7e5..29472502d547 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -412,6 +412,15 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&uart1 { /* BT */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &uart2 {
 	/* console */
 	pinctrl-names = "default";
@@ -434,6 +443,15 @@ &usb_dwc3_1 {
 	status = "okay";
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clk IMX8MP_CLK_UART3>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &usdhc2 {
 	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
 	assigned-clock-rates = <400000000>;
@@ -609,6 +627,15 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
 		>;
 	};
 
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
+			MX8MP_IOMUXC_UART3_RXD__UART1_DCE_CTS	0x140
+			MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS	0x140
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
@@ -622,6 +649,15 @@ MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x10
 		>;
 	};
 
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX		0x140
+			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX		0x140
+			MX8MP_IOMUXC_ECSPI1_SS0__UART3_DCE_RTS		0x140
+			MX8MP_IOMUXC_ECSPI1_MISO__UART3_DCE_CTS		0x140
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
-- 
2.37.1

