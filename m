Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77FC609894
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJXDPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJXDNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:13:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E32D75CC8;
        Sun, 23 Oct 2022 20:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEnlPrxLZR7rSdq3Xf2XTHzPNjdc2lMefYSiDp8y3OV5GRABOaG+Ole4+Qb1bMSvOY/ILJgsHxwTsxKaol6grCQi+rPV2x7eM8EKe3DfW2e905DAAXSF6fuewAgo0ddatU+RWEAAQhKXEElfl4PcSc55zaAYMfY+4ciQ8rUEu/Q8HsukEBsxgB8t/qvEBI4sn8G2Yzbsxb0DjXHaR8JltwTmpGMsULjTTUON84dmBjvyjBy5XSh+T1OtFYB+ZMJxy+yLyibuuIeUBLWkLGgZv85jf0/x06C93U4PXwWXNDzQwL0Uvr6/ChoX6EHiRWDhhBxoLoFo9x5jecJ4ubRvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b10whJRrtoyjpasSiFxHGpQixZAdxSNfXYz/TyCGF0k=;
 b=YAsD0fK4CP0t2UbvSbkW2Lq3jhYzsoscz+11ii2bMEz1EPl+7GRIA5EYQRplBmcB52JIuNhaPPdSfkIMAoE+efG6xERxG0DHNgvOnTttk84a6qGU+kbg/E+z+yzejWp17lAbG8o+qFqfPP9gdSu3uPuRA2gLeEwzLZdXmk4+7mSETqYn2xtzEgf3vEoqOUXZfsa5T5HHams1e8QcEcvgg8+AXWQJEhBkYl8HMQnVchI8QigUs4Xiy2SMdy9McxfPhwQ/BZ2pdRQh1c7TLIlPRltVutfrScAiSE6/GqtymtxfKzk0lDwrUonV7Iou2ylLenzkoqWNsWtgN7J29Az54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b10whJRrtoyjpasSiFxHGpQixZAdxSNfXYz/TyCGF0k=;
 b=l6iwK2YiAQqGAdLtV5ADi2I0r6uluO1/enV01HL8Hv4Ck5z+6+tw+qI8axycdY4Zd4oDQSYYPSh+S9V5QsYAgYc0qFH6OD++VlkiQ5QxucVWYJzaDDOIUhhFWBHh4bZv7Hb4iwsI5Qjoxd1fPmvb/iYMdJGIWBgUuDdMF+9sHnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 03:13:01 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:13:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 11/15] arm64: dts: imx8mn-evk: enable uart1
Date:   Mon, 24 Oct 2022 11:13:47 +0800
Message-Id: <20221024031351.4135651-12-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: c356d1db-dd1c-4311-b34e-08dab56da851
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1CpPFU+lKPg4djGE55kYO62HUxPrztVzPhlotUcMJ7D8U9N6I/T9xGuG9oHbR0NbTteya+z6qW13c9EsXEtS2jSIitbI2HhrrBCdjUQD0W8/zLw49RBw1IYGsx7r/ogn72ZKdwVMWKsjscjVcxRVaBY1S4Rn1e1pbTLdrE+ZvCqyOLDUG6E1fD6f9riu/vKM5d634DlU4EabZPBU3YISfVM590PO6h7LGkPx/CtjCeBCREHvhiD2QEdgz2YSslZDBSV8Ri8J3PsmPV5DiRPzGPy9BCttOE9Qka0ovJf9D3d49oTNj0aKObsQnPOTZq1usaQIMZeWJQj8XqQx6VBXY81z8lAqw+NEPUMPSRMFVM7NmSJfdxcEqfzIu5Ai/kqOWKWG6VhFj4AYgnUIuP5sqxPfqoUn3deu+FhmS6orjbDj6kYZXRE1IAPF05rFuC7M7thuVDP6AlPfHzO/Q35Ai3he7UAz3gROWMfW6yYec8Ry/+q0gLdYHHwLdr7evxwSCAjFAHxopX/cpTWPxBzhyGeoyBsFCjmckqDwLEHcgCqioi/7A9DmOP576EmbZbICdTUtan9HblMz7kSVVOnmM1VTFnfM+LHA/ScZksSIabn2cH8QiliSEhFxF0z6vjsXd55Dep6tBGPHnLJub86Wj3HcWajGe80KNPxvUb+XLJvLLtHY2DE9Gj0OEPxc1M6CUXiteaf93u7aLVWnaMTmVWtkYJc9n21O2su5vaCKGlRJLtFs6mZjnxMRINUIM+kMLWsGazbDPrgNd58v0d8C2gw3L7emQ9YBdNubDWlvy1yFLlb9FKlC0RS6h21DzAU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(186003)(38350700002)(38100700002)(83380400001)(8936002)(4326008)(2906002)(66556008)(66476007)(8676002)(66946007)(5660300002)(41300700001)(86362001)(316002)(2616005)(6506007)(52116002)(26005)(6512007)(6666004)(478600001)(1076003)(6486002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CsxNH1yXFRM9rxC51LoehtalC9uplg/9Y/fI51sfuH+0TLDQtzlFLIYkZyg3?=
 =?us-ascii?Q?xbK3lvAHu9nKV1AWjyZgvAWrTd3RXuastSBZX5KHQbrrMMxXLZyn4zPGctdF?=
 =?us-ascii?Q?2AVGj7sRPL/5WJhZs+DPvt6J2XQwK+FCCN7shlk+Oo48XlYBObgYgKIToiqH?=
 =?us-ascii?Q?8KuAupw+/eNmNQ6tNP9MXboC6RQfKawMwZklu5OE2ylTs36jPRJtx/iwnC+Y?=
 =?us-ascii?Q?UBnHAJSJPCIBGEHuCSzQzko4HMEwmYhZKZ6YHsVXi6kO0DJvcMV5m+cxiPVl?=
 =?us-ascii?Q?g2yetEbBtROAARKN2NqzAYZLZy2YplP63MSVoEnLM2IjjjYZbwb1ppcwpRut?=
 =?us-ascii?Q?vHLMypzXaeqtROenPjDzI3JjXf5u20ofHRQbvvAR+GFYLVXZQ16XVnEi+SUv?=
 =?us-ascii?Q?mVNypfksIsssHjySGs5taMWykXUbRMgzLTUUqZhw96reEonfg/1OXbdC3lsW?=
 =?us-ascii?Q?R9UKofz4LqMUziEHx9k7xrFJTUOuHH+Ls0ov6j9ImBA3Bx6fBHg7LE/Qmt4Q?=
 =?us-ascii?Q?+35TaXwSUSMcsCOwhd3XtqAPqtg8eJwDQmu+YGTtdY04Np0lQMrkOMJOyg8Z?=
 =?us-ascii?Q?RqwUDGBzSj1AI32qfHCgKj+4P5Ly4b1bPu2Jp+mfXRtukPN7bH88auqFrC36?=
 =?us-ascii?Q?BKCZuecIeaT1DTvoZzc7Z/JLFGs8qv2WAuzgvWavZ7us1Ab+F17go5JcZvXT?=
 =?us-ascii?Q?cghRp5QGWqWnOWtqzy5ueVCQ1Ewyhl0nSNaY27iQgpyVFad/mVZThhrqtG/p?=
 =?us-ascii?Q?TYNt8vPcIeV2kVa0SbN05T1o/7wMfPkknKY4Fdjdo+KNbqKb4TINogx2rD2o?=
 =?us-ascii?Q?K5larfrKFzRp5csW6dRJcshh78O5gQNz/HQlBfzpN8aGONcTgbbtUgS+zPoN?=
 =?us-ascii?Q?QXP8pnYisQUM9UWtxtgN/dGS4FPefdpkRC9zi2MfgHMtUhRBdbL80NbvDZbw?=
 =?us-ascii?Q?sZMA6tlCmrv5LtoZwDPrS4NiIePGOJSWWOc3MHSdjctwBc/KHrF4kLzb5pf1?=
 =?us-ascii?Q?ed+UPS6vINFmiYYkE8evmb4wlA8VRsAyEHkhSG5ttKyyOjIATbgNpkggkGNm?=
 =?us-ascii?Q?7NhMwaDTbbVi3n2z1cKnNGirnoaByC7TJsYTu33keVz4VuEBqcDGs6MfNMZN?=
 =?us-ascii?Q?wTAKYUVZcwGFgbTZZEhD0ty0DVdhSQm+STYEfWJZGhgVL+LAE1GTtOsXs+Ci?=
 =?us-ascii?Q?8fv49hmwNVZzaa81R5+xlz1B/dumMRwMjsMFPxWpxAlKDf44kul4bn7oYEHR?=
 =?us-ascii?Q?NqNweUIqmlw8fhmdVkXSxJ1w7OH9uXLZoP7QTAMLCXUDc0ydbkq6bjqc936E?=
 =?us-ascii?Q?INVDvfhNwb1Kl7jU3aVcxMeFP4+uk8V2U83qwee/CKS0I/fOxbY6BM17ZCMk?=
 =?us-ascii?Q?qSgfwDyLuCnDdDuL0VfxSFPA+J8nvXcEl10n0n0cdEnsxoprRkJ0z+2q2ZRc?=
 =?us-ascii?Q?DO9C7Bupi+lxKNsaCjx+2cFo+6Ol+KuAHaGXGKy9T2XkhtYwHgITaY7CbSgp?=
 =?us-ascii?Q?DiKlR5RKg8XXaMp7aVzA+EUEd7elu18bPUcBsQRTjRJ3xjslGLm6AIpnIbFB?=
 =?us-ascii?Q?zHezpqy7tWZe1I8xfCuCf19V4hIsG7eoKxqFk/kM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c356d1db-dd1c-4311-b34e-08dab56da851
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:13:00.9003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 700JbPl5Ysj1o5C4SZxQE7jV+PbPejA+vbK+aYxyJK32P5gMc+4zu37WG4MRI3qnJpRIkh6isgJaZPPkt5FcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable uart1 for BT usage

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index a37a165b40ec..f137eb406c24 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -247,6 +247,15 @@ &spdif1 {
 	status = "okay";
 };
 
+&uart1 { /* BT */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clk IMX8MN_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &uart2 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -440,6 +449,15 @@ MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
 		>;
 	};
 
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
+			MX8MN_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+			MX8MN_IOMUXC_UART3_RXD_UART1_DCE_CTS_B	0x140
+			MX8MN_IOMUXC_UART3_TXD_UART1_DCE_RTS_B	0x140
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-- 
2.37.1

