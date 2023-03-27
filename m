Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA516CA84D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjC0O4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjC0Ozx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:55:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4986E3594;
        Mon, 27 Mar 2023 07:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNctJodj0pXxroQYwmjW2OHMJsp0oCNy2fjE8lBhiI/acRtqYREZ+lTXSDfBzKygfGm19oZsTrhj1WPgodR+lxC+XDr4nNaxWHSRDHQFv5W+laY7W3d+GZS+yvzLwW5uc7OAfYJ4PjYiNbvngmntaRfHOHCDP4FDpNzBswDDeMw95eM3AmJcNzxqk01JpIlsz+qQbvzq2k9D4ucmXEE7Oh+Ko4sjaDM1dmgQemmlR4JsuR/utWQQLpV7mVHzD7lROYyOprjwHFbJfpQGyC0vMK2A3LjTfByhLwu1ulBUPvqapePxBmloWZ6yMmXIcBXCarpHLd31ybeR9A/z4zupnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/y547Ie63MEjvwpzU7PrDCeWI5PL4KGcKYEz5uy3ko=;
 b=ceFIwagtRLb7S7LIeXnbDn01XL/P95gWGrot7Af7u2ZbqWIyUnpYwgCpFZ+2BewW7SkOizT8VI/aeHYRTq8fkDf0dqj8k50BP3A6du/CjqLOk2Hgdiwva6jPn0V2NhdKyXx8M72gJKDcbsph9KbN/eWE9jx8WZca9d2xexHSpuBrqg6gMYt6sXVWpvPKqPohZIiFjkka2MfbBms2kiTeQFl2WOqlK17fiIdRSffeV+bqr/3QAA02CUxhMGwkiSlXQd+zJiTLvA2tcuwrUfOjG/XEe3oKRBcB60OF0ztWQUUFrD2HRzlIQCYL6VwIngXsuul3X3S/zWYda2MgxTuxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/y547Ie63MEjvwpzU7PrDCeWI5PL4KGcKYEz5uy3ko=;
 b=azbARGh0t/WmV2oXme1mXAsFntff40D/xOs6KECR/f3+JqBlD90N4gCZXPOKH6ApAqet/TD3uGH/p/hJ86hYcyIlks/vJGEaIL4+LqLYYz62OAxEp++iwueUtq/7q4KSmfKtABfuo+7vCT5qawS2isQlQeG+zDhu1M0TmqMtMUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8640.eurprd04.prod.outlook.com (2603:10a6:102:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 14:55:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6222.029; Mon, 27 Mar 2023
 14:55:49 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v5 2/3] arm64: dts: imx8qxp: add cadence usb3 support
Date:   Mon, 27 Mar 2023 10:55:22 -0400
Message-Id: <20230327145523.3121810-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327145523.3121810-1-Frank.Li@nxp.com>
References: <20230327145523.3121810-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: 38dfb36e-aa84-4e79-d05d-08db2ed35a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyofuORkjMVgR+Ec+SnLryzpw0gU95mwyxZni5hhVuZSFb8MTDTpF/JZwESr56w4MXmYbJy/VElmZ6lcUX9a6/zK+sjAtHRRJeSl+cvwA/6Q5hL1hl1Jo1BYl1I++tHJjiiK7SJNU/Xtyq5sd4o0uIXoXBJCt/WQXL51bCJwsSJO+J+5sViSx2VIyY+nkFqrY/uq0KmOYwNJKnJKKpZyMPYskKBuvmpEFQiwgNcbSr+eu6vNzfzSK4Jeph1WbXd7n5pegJJ2grUCp1uZl7gypi90KdRZlS0fUhejCcwTxfBhVDI347uqwEGgVUDo8pojiewhoXB4HkpRYooqdUDN0ITXzHWApcRsUO/6FI+1AVgcn2OluP4s/DAhYoN0zFeaSYdWu491GKTrwMHZBMkaATZdEvHbshfMB6+G0l5XLxLKtG3m0sYpI/xDy64h0ehnCYARuscWIIgpgbmWP1M9KDA6snWZwnXdYLgPU03kthtCqxsLu84hXRYxJfMB+XtE6f2KjolCwCvHWZfOpJSwikcOkInwJrslBp+1EzLaXQcUrp9vLQv0gLXHEMhWT8th1/iuGesqhEn626lzXsYAhFA61gBOx/ddwaufw5FZR34B+JCfDn+hZskUNOI9BdDFVxRVlLJC6lwQGr139U2TWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(36756003)(86362001)(6512007)(6506007)(1076003)(26005)(186003)(2616005)(83380400001)(7416002)(8936002)(34206002)(6666004)(5660300002)(41300700001)(6486002)(52116002)(4326008)(38350700002)(2906002)(38100700002)(37006003)(316002)(66556008)(8676002)(66946007)(66476007)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OFjOFIGhtdm10UuJGWNOEhiI5S0Pqued8g58vGBXQUxy4aUC7+Az4rnO6UCu?=
 =?us-ascii?Q?ntth23AyZWm53LFb6g9qIYB901LMio4P1so1d7WzFo4TOwjT63tqbEYv4paP?=
 =?us-ascii?Q?MLGQhSpAcIuuJ/coXWgwhEkG7xZK6xakZSRtP0E3gw5Hd3mRAS1eSaFhbykv?=
 =?us-ascii?Q?ew+UlIeQimB0qBuyrqe/EGEPonzE5YCDu/9HWUzwB+VgmJq1mf9o9Ats5Cjr?=
 =?us-ascii?Q?rkxgrX5+f9DeamjFmL9O8eOtOXRKB1R/reU1kyBIsxi1oWsuDqVf/uWMZx/S?=
 =?us-ascii?Q?yqXuACVojFZITAZnx59mhh8B8m1Z6SS6xWBHl6iCfGahUbRgx5Dya0n2JAUr?=
 =?us-ascii?Q?TckBJb3ncu/D4qxh37kF+e2xxZNZ2IPkxxTTFBOQ6dCv5QQlM781jFYQQH85?=
 =?us-ascii?Q?38fDdI2x6ZmmBItgcUaS1bpv6zG+0DNMjQ59X8EkKdle8rmYHMRFSK4eVqSH?=
 =?us-ascii?Q?Fi8MgXg8Z7GGHiTrV6z3TQL69G0Whew8Z9x+8vIHMbeP4OObkFK3gvJgzFQg?=
 =?us-ascii?Q?BSzrvFNOFJwEfrg32VSD5zylySf4QuYWClj7XqO8VAtKFg03a1Vp3oOincnq?=
 =?us-ascii?Q?yv6OESQrVSpzqoIVXVnLEXitUQnpLjsJDbJvw3yDMPSMCWi939MOpFSqKRwt?=
 =?us-ascii?Q?Zp7i2msYee/CAvY80mRnkgcCE+Xd6SMo9gE/p8TIfDQmwukUhNxRnz8fT1o2?=
 =?us-ascii?Q?Q++WV6XzGiR8hp+fW+9Z+SipUmh8tl3ijHxuSUF35Mm5aVm/fYlDSnpKYV7k?=
 =?us-ascii?Q?fdp9TzN3FECnFx9bdm29tbc1HbQf7z7OwwHVgOQIP6Tu22Lnzv8ffuSqlpnK?=
 =?us-ascii?Q?s9MDmsyKCKvXwKMKGC1KXjqmaE6aTRv27dFjg5ccv3BGgm9lsQFfZVuRtUbt?=
 =?us-ascii?Q?F2/+KaYMuat7zYCpGcpzdRWSW1sozbLJ6B48CdHtYBoSXZ0iHimXUqiJOwA6?=
 =?us-ascii?Q?BNXI9SYUkBrLZm1hNBaxlhMw3/Up0saKrDJonEh9NUoiUWus4i0b7z4YA3SE?=
 =?us-ascii?Q?rINaCTd+XeqI2RCQmhNRrS619q/ADkp0hfadaGJTvtiZ1F6aRLGRv/lNDnZC?=
 =?us-ascii?Q?Wxk6IY0Fb/MYItH09NaV2QGbbcdTmZ+BdYqEhreGi1CdM2Qwp1K3iGHwR9GJ?=
 =?us-ascii?Q?oYAxHOcJveaQd2ckwv9aXu3TVYc40z19sxcbMWWjuLuK9OmeA6brLAk4FX8Q?=
 =?us-ascii?Q?VbKwurWWc2rCSidVnMQRkaZCy6iNDimWF1p1SCFr5H2cbwnmmwvNNxgi3GoV?=
 =?us-ascii?Q?czPrKCmvc9+9fMgwA5dVhv4+poSgKGE2pZQySwRmwEGMYQMDZmb8MnlF9wsh?=
 =?us-ascii?Q?OvW03HFD09O9BPyVL4cE89YGvZiX7S5j7En26LhyQEGHLG4kmGUgWVoh5Dcn?=
 =?us-ascii?Q?wBluJYU0qheOxBeDNF+VnV/+bZ+5GKya4rZ78ueNMwjBMtDHN1cMr7AaEcnj?=
 =?us-ascii?Q?1qs7VkZLBpooG4qIqAnBIR3Uv1UYvrsLrRrgLOkdqr1wb+XET7PyZ50Fc+2d?=
 =?us-ascii?Q?ivcRp/YiWpVcBLZpjMOnAmdiTcJFhXsRONxvfecXYK2ZOqw9aQdZDG8Lyh/5?=
 =?us-ascii?Q?SPZIQ4/c6I/akmIVTZ6haS7FxeUHZmO4bO0bHirZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dfb36e-aa84-4e79-d05d-08db2ed35a53
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 14:55:49.3334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxqWfbcgQIspw9JQVThKD1zdYTGwbyRaIncW1VSGFHSdoqU81O2pCmRA2/4T9sv05UnGwpuNg6FsVqBc89K99g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8640
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cadence usb3.0 controller in 8qxp and 8qm.
Add usb3 node at common connect subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
 - using shorter clock name according rob's feedback
Change from v3 to v4
 - none
Change from v2 to v3:
- Drop fixed frequency clock. See binding doc patch.
- move req as second property
Change from v1 to v2
- fix shawn's comments

 .../boot/dts/freescale/imx8-ss-conn.dtsi      | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 4852760adeee..b32c2e199c16 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -138,6 +138,53 @@ fec2: ethernet@5b050000 {
 		status = "disabled";
 	};
 
+	usbotg3: usb@5b110000 {
+		compatible = "fsl,imx8qm-usb3";
+		reg = <0x5b110000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		clocks = <&usb3_lpcg IMX_LPCG_CLK_1>,
+			 <&usb3_lpcg IMX_LPCG_CLK_0>,
+			 <&usb3_lpcg IMX_LPCG_CLK_7>,
+			 <&usb3_lpcg IMX_LPCG_CLK_4>,
+			 <&usb3_lpcg IMX_LPCG_CLK_5>;
+		clock-names = "lpm", "bus", "aclk", "ipg", "core";
+		assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
+		assigned-clock-rates = <250000000>;
+		power-domains = <&pd IMX_SC_R_USB_2>;
+		status = "disabled";
+
+		usbotg3_cdns3: usb@5b120000 {
+			compatible = "cdns,usb3";
+			reg = <0x5b130000 0x10000>,     /* memory area for HOST registers */
+			      <0x5b140000 0x10000>,   /* memory area for DEVICE registers */
+			      <0x5b120000 0x10000>;   /* memory area for OTG/DRD registers */
+			reg-names = "xhci", "dev", "otg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host", "peripheral", "otg", "wakeup";
+			phys = <&usb3_phy>;
+			phy-names = "cdns3,usb3-phy";
+			status = "disabled";
+		};
+	};
+
+	usb3_phy: usb-phy@5b160000 {
+		compatible = "nxp,salvo-phy";
+		reg = <0x5b160000 0x40000>;
+		clocks = <&usb3_lpcg IMX_LPCG_CLK_6>;
+		clock-names = "salvo_phy_clk";
+		power-domains = <&pd IMX_SC_R_USB_2_PHY>;
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
 	/* LPCG clocks */
 	sdhc0_lpcg: clock-controller@5b200000 {
 		compatible = "fsl,imx8qxp-lpcg";
@@ -234,4 +281,26 @@ usb2_lpcg: clock-controller@5b270000 {
 		clock-output-names = "usboh3_ahb_clk", "usboh3_phy_ipg_clk";
 		power-domains = <&pd IMX_SC_R_USB_0_PHY>;
 	};
+
+	usb3_lpcg: clock-controller@5b280000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5b280000 0x10000>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_6>, <IMX_LPCG_CLK_7>;
+		clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
+			 <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
+			 <&conn_ipg_clk>,
+			 <&conn_ipg_clk>,
+			 <&conn_ipg_clk>,
+			 <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
+		clock-output-names = "usb3_app_clk",
+				     "usb3_lpm_clk",
+				     "usb3_ipg_clk",
+				     "usb3_core_pclk",
+				     "usb3_phy_clk",
+				     "usb3_aclk";
+		power-domains = <&pd IMX_SC_R_USB_2_PHY>;
+	};
 };
-- 
2.34.1

