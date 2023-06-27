Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBB173F581
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjF0HWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjF0HVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:55 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9D2726;
        Tue, 27 Jun 2023 00:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaiUMfRO/Zsyw+Jjk+pi1LxwPBZgds9AvvgZTB5cLJTCV1C9RyifhYZ41cjVNcKSrEgCrbNoAW4lPfOBFBJklYeHOLWKCoyvvcxmnYm4aWdU7aIvZJ9No0fOBaQzgeuO9Pccxl62edvWQONHZf5BlTDeCwh0nDFFQnz7aNhnvxuQQsmuIkzNjSVUU8qm+yeeF8cki+CKko32QxoVfNWieup231LrmfOiMD7sfcqFOstEfh+XXUmwyQMoHRUMy/TwLQIOgU9wDtV6+6YK+136goQ2nlCvVYXdspfU2nfVe6vSWaMpuPxwV84hy55VEhQhK7/MzBadPMXspYjJTS5uhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgKnePFJq0TnZ0nhvn5vdN5BPu9wwPhwqUorfcxNVuQ=;
 b=PBqFdoSRZa6X9zKfMnbGnuUYH4CIffV4JFLgigw2eTZqptVhhfe684lEBY9sSkoEDRwB5RJmL30AAHZvYbDPZnebnv61l6HAT9a4kGNmq3Ywk0D/yynY2HpLtLYL/yQKCOrHwTqRIO1rSx1no7xqO6affB0knObfGQwFLoWtL/B4Fa8hBhxxrjz+pGQevoEYQcOPUS9Y5s6KzEIsNcMYLAOfOlMTaPGxNYjKNrH+NW7Y0EO01H2yrEup9wWqiqNdYIWvisOr9YEyoWMbPLQdrg6vkCOykfZkooYzUoBxZczWkLWzQzpbwHwtJcuWMJqxomgBWstmqHsUMTWWKrHvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgKnePFJq0TnZ0nhvn5vdN5BPu9wwPhwqUorfcxNVuQ=;
 b=A1S03DNA2dcsaEKb8jW9wH2tRmVImZMnbzyKU5MX8xishfst8yW3VaE1hyzIbCOyzH+T+SoTBK0Fc9x0KgnGWuX8OnyqBRVxWNe/AFAOP/XXv4Hj2FlKA1y3SnkEGwEONgLchUBcbwio80vPYE1guZlcfGqTZWkwSU1i2++7zpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:19:59 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:19:59 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 06/12] net: phy: nxp-c45-tja11xx: add TJA1120 support
Date:   Tue, 27 Jun 2023 10:18:47 +0300
Message-Id: <20230627071853.106215-7-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM9PR04MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 982ef01b-dc4c-4620-eb6f-08db76deea4e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTG7aMnXiZekGQ+CsY+13WEX8P9Q4nuxKYaiYwD4WkpvBIiO7aOnq1+F+Kmlz5T+r8aNw/x3QduzBGsNQPvnrgWsaVCT0YaETfN/4uRxHrEjpnpMj2nyyS/pDfdcgPWfKn9+0JnlvChGf8hwXNdeYsEU29b4t2M5A482IGdNuE9iJ1wuUlbH7XmO8IIXIaTibnHBI4AhE8qXFGvDc6nJi10nJjqnLRi82g+G1vpuDP28gGtk6+lM4JALqw6LNxmUCWPZpIYgOcYLg1NLYdwpMk9xtfOLB2lG3E2H8GMdaLLoM+xHDRH336iMUPPlJdJ4NTPZzIKUMCrZa3DJqniXeKB8A911/6dL/j4j0AvzvEHxs6siOnA/OQC/y5g7H9lbfsrPQUDyviqSMehrU9r1LgmaiA2nfsqG3Db9nXzWvJVKMv/8C64Z9+kAyMJILczMKeVvRJjR3TScBJd71t3SOt6mTTneup9IA+pwVQ1ETrLvn9ByevLnStqnPbYJFSoNFpXJaYoohgV8gL6pOEDtPpCc06e9HYHV3wgEnHva8y7VP513XE4JC8tVzVPTGNeEKBi8DP9+c9ihAi6krrYft1qMdkofPTVeFv6M0sTKjZ6s8PxSOE390+lwFnlKUv2Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(83380400001)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(38100700002)(8676002)(66574015)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gs2ba0LrfYeohBL1QyfrG1di4pfQGnNVZD1dzqEHJN0s7E7LKkcOOrnDmVte?=
 =?us-ascii?Q?OvEhHmWntl5x8kIu8O2yrdFWUlA5xJgL/F8mlC53Mx5TDi9bGj+aXcvYa8jE?=
 =?us-ascii?Q?ntCyKANg4M0T8LKnLkkfhAeqxOvWoOWp9wXxocErU0aHuVUYSnB0uIYo2lJG?=
 =?us-ascii?Q?jiraZUdXFPE1To3j/2s5OhsFwCt4Z6ocdB1ra49ZXfnYQ4Lu2tSTzVX0SKhp?=
 =?us-ascii?Q?o0LyTPVrqjKkQwFp+iBOVZLhUPMLoN0NpPyzGI0yHyNd57Qab15Ai4P8zwv7?=
 =?us-ascii?Q?zi5HS9mzxeykLb61Co6MHcY0rLJSc4aHG0OkFJwz3aQ2PH077/IVZu4VVWxC?=
 =?us-ascii?Q?2OmfcFSsZgHYEzqza12WYQth2I3dK5NymQD7LF+X7uLmwsXeobvf6A0me+Nt?=
 =?us-ascii?Q?EnphgC4gbHzcBInhtddsy/OJmJIt7z8sGdoBrKD7Hnw1rxQGjgES4Spn3hf7?=
 =?us-ascii?Q?UMvwdhknQsx1CxU65Jd4dK+wnUCfwCrNMed90pq8MDFZkDUmDr81CNTHI2Fe?=
 =?us-ascii?Q?HhfIkibN+UYuZw8Cd4V0KzmqiB5miG7n++PHUWdz718JgptYKRWTxGPV5H4t?=
 =?us-ascii?Q?xilPPQ4EGZ7glBfNluRPn+13THSxoM1tiZBH/kU1HQwhC8TPGb52memdJwtW?=
 =?us-ascii?Q?HKtp4Z6mriQnrZzgPPYtSKKHzj09qdWCrZB9bEhQqu1d66IhONAmgeRiObSs?=
 =?us-ascii?Q?dIRyCjx48nEJqkMmceJox+Q+IHZJZcEri8k+mlPHhVNJL6zWn2Dr6wVgpwG6?=
 =?us-ascii?Q?brhUW+bD4URe/F/yeUH1U2KaLCzpzhiRykGYKGWtQZglAYPLuGFBKD+jTTo5?=
 =?us-ascii?Q?3eNy7/jnRk+w+I58wIqYyi+6ey6dkXUFzZhtcn77EAeL8C5ejB0j1V3lEBmi?=
 =?us-ascii?Q?Qil2wLnWCqFkQiXxP26DHbm7/cInLqhEnQlW2+EXgCLcIN+avIlM6aDNBhGK?=
 =?us-ascii?Q?B9kK6u71RHXuTmP6T0V+SGs2UVi+2hx08+K0dZl3bNx7ydrKtWY5ooO9Ib4l?=
 =?us-ascii?Q?ytg7PKRUocOuE2l+3wrjTzXekIWle5VlAAdDAdleoCURCiwtxZlu4uTG/eqe?=
 =?us-ascii?Q?Sr2ih99U76FZlArvndHrnJgkgNK2kk66wa2ZNwtYft3B5+lNsijxQkG4B8Uz?=
 =?us-ascii?Q?G87eNO7Pg64OqT2n5p3gM5b3T/S0ARwMMG2k3oAPZnKINMnr1Bd17KDNtJzV?=
 =?us-ascii?Q?meecHYBqRKeFeeVBZUEZp0jI7GSiM5QVtUtiAACcDx0QCgfFiACDVuO3nJAj?=
 =?us-ascii?Q?ZNLo6wSCwUZoO9Ur0l6rxFq5izz8+ye95y7HsCOc8r22sFQwU2lCMDAiTa8t?=
 =?us-ascii?Q?plmLlRSO6c6o16b9Fbn9+jIzdDAMuiyHu6bGU6rTd5InSwoSjX3RxM6t76Ja?=
 =?us-ascii?Q?F2zR7oDQytyx/p9gQI2B6Q3tsGIiqcKDq1y2iGbFtCHdIiskhvzRaZSPcgoE?=
 =?us-ascii?Q?zOlf+iDxcxvFFVtROd3r55ZZV9iniPnclZ0WLj56z/p35QDk5PCsbbocViqI?=
 =?us-ascii?Q?/gPYmWFPwuv/3WydhWTbSyfT0T+DNP8B/eOxnRY8WurlRfpQpUoqVhssMs14?=
 =?us-ascii?Q?uD9QTecfeCgLvbnbLsUk5tYaTEYjQjfgZqeBvtjBDYrSO6Bv9wLL1Q7zfiTT?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982ef01b-dc4c-4620-eb6f-08db76deea4e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:59.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSjHkBl8x5ArQoOfPil/CGcmX+f4ib66+mK8eaEO8yOiAuSFkWCmNC4kZd2mtj3JjK1Cs6eWKXHztQKGDDDJZKEBQdr4f9vBj50H8aVdXRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TJA1120 driver entry and its driver_data.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/Kconfig           |   2 +-
 drivers/net/phy/nxp-c45-tja11xx.c | 159 ++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a40269c17597..aaed6d73f9f5 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -300,7 +300,7 @@ config NXP_C45_TJA11XX_PHY
 	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Enable support for NXP C45 TJA11XX PHYs.
-	  Currently supports only the TJA1103 PHY.
+	  Currently supports the TJA1103 and TJA1120 PHYs.
 
 config NXP_TJA11XX_PHY
 	tristate "NXP TJA11xx PHYs support"
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 11fb5a4f47fb..47decf2677e1 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -18,12 +18,17 @@
 #include <linux/net_tstamp.h>
 
 #define PHY_ID_TJA_1103			0x001BB010
+#define PHY_ID_TJA_1120			0x001BB031
 
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
 #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
 #define DEVICE_CONTROL_CONFIG_ALL_EN	BIT(13)
 
+#define VEND1_DEVICE_CONFIG		0x0048
+
+#define TJA1120_VEND1_EXT_TS_MODE	0x1012
+
 #define VEND1_PHY_IRQ_ACK		0x80A0
 #define VEND1_PHY_IRQ_EN		0x80A1
 #define VEND1_PHY_IRQ_STATUS		0x80A2
@@ -76,6 +81,14 @@
 #define MII_BASIC_CONFIG_RMII		0x5
 #define MII_BASIC_CONFIG_MII		0x4
 
+#define VEND1_SYMBOL_ERROR_CNT_XTD	0x8351
+#define EXTENDED_CNT_EN			BIT(15)
+#define VEND1_MONITOR_STATUS		0xAC80
+#define MONITOR_RESET			BIT(15)
+#define VEND1_MONITOR_CONFIG		0xAC86
+#define LOST_FRAMES_CNT_EN		BIT(9)
+#define ALL_FRAMES_CNT_EN		BIT(8)
+
 #define VEND1_SYMBOL_ERROR_COUNTER	0x8350
 #define VEND1_LINK_DROP_COUNTER		0x8352
 #define VEND1_LINK_LOSSES_AND_FAILURES	0x8353
@@ -94,6 +107,10 @@
 #define VEND1_RX_TS_INSRT_CTRL		0x114D
 #define TJA1103_RX_TS_INSRT_MODE2	0x02
 
+#define TJA1120_RX_TS_INSRT_CTRL	0x9012
+#define TJA1120_RX_TS_INSRT_EN		BIT(15)
+#define TJA1120_TS_INSRT_MODE		BIT(4)
+
 #define VEND1_EGR_RING_DATA_0		0x114E
 #define VEND1_EGR_RING_CTRL		0x1154
 
@@ -110,6 +127,7 @@
 #define PORT_PTP_CONTROL_BYPASS		BIT(11)
 
 #define PTP_CLK_PERIOD_100BT1		15ULL
+#define PTP_CLK_PERIOD_1000BT1		8ULL
 
 #define EVENT_MSG_FILT_ALL		0x0F
 #define EVENT_MSG_FILT_NONE		0x00
@@ -929,6 +947,27 @@ static const struct nxp_c45_phy_stats tja1103_hw_stats[] = {
 		NXP_C45_REG_FIELD(0xAFD1, MDIO_MMD_VEND1, 0, 9), },
 };
 
+static const struct nxp_c45_phy_stats tja1120_hw_stats[] = {
+	{ "phy_symbol_error_cnt_ext",
+		NXP_C45_REG_FIELD(0x8351, MDIO_MMD_VEND1, 0, 14) },
+	{ "tx_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA1, MDIO_MMD_VEND1, 0, 8), },
+	{ "tx_frames",
+		NXP_C45_REG_FIELD(0xACA0, MDIO_MMD_VEND1, 0, 16), },
+	{ "rx_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA3, MDIO_MMD_VEND1, 0, 8), },
+	{ "rx_frames",
+		NXP_C45_REG_FIELD(0xACA2, MDIO_MMD_VEND1, 0, 16), },
+	{ "tx_lost_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA5, MDIO_MMD_VEND1, 0, 8), },
+	{ "tx_lost_frames",
+		NXP_C45_REG_FIELD(0xACA4, MDIO_MMD_VEND1, 0, 16), },
+	{ "rx_lost_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA7, MDIO_MMD_VEND1, 0, 8), },
+	{ "rx_lost_frames",
+		NXP_C45_REG_FIELD(0xACA6, MDIO_MMD_VEND1, 0, 16), },
+};
+
 static int nxp_c45_get_sset_count(struct phy_device *phydev)
 {
 	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
@@ -1511,6 +1550,101 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.ptp_enable = tja1103_ptp_enable,
 };
 
+static void tja1120_counters_enable(struct phy_device *phydev)
+{
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_SYMBOL_ERROR_CNT_XTD,
+			 EXTENDED_CNT_EN);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_MONITOR_STATUS,
+			 MONITOR_RESET);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_MONITOR_CONFIG,
+			 ALL_FRAMES_CNT_EN | LOST_FRAMES_CNT_EN);
+}
+
+static void tja1120_ptp_init(struct phy_device *phydev)
+{
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, TJA1120_RX_TS_INSRT_CTRL,
+		      TJA1120_RX_TS_INSRT_EN | TJA1120_TS_INSRT_MODE);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, TJA1120_VEND1_EXT_TS_MODE,
+		      TJA1120_TS_INSRT_MODE);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_CONFIG,
+			 PTP_ENABLE);
+}
+
+static void tja1120_ptp_enable(struct phy_device *phydev, bool enable)
+{
+	if (enable)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 VEND1_PORT_FUNC_ENABLES,
+				 PTP_ENABLE);
+	else
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   VEND1_PORT_FUNC_ENABLES,
+				   PTP_ENABLE);
+}
+
+static const struct nxp_c45_regmap tja1120_regmap = {
+	.vend1_ptp_clk_period	= 0x1020,
+	.vend1_event_msg_filt	= 0x9010,
+	.pps_enable		=
+		NXP_C45_REG_FIELD(0x1006, MDIO_MMD_VEND1, 4, 1),
+	.pps_polarity		=
+		NXP_C45_REG_FIELD(0x1006, MDIO_MMD_VEND1, 5, 1),
+	.ltc_lock_ctrl		=
+		NXP_C45_REG_FIELD(0x1006, MDIO_MMD_VEND1, 2, 1),
+	.ltc_read		=
+		NXP_C45_REG_FIELD(0x1000, MDIO_MMD_VEND1, 1, 1),
+	.ltc_write		=
+		NXP_C45_REG_FIELD(0x1000, MDIO_MMD_VEND1, 2, 1),
+	.vend1_ltc_wr_nsec_0	= 0x1040,
+	.vend1_ltc_wr_nsec_1	= 0x1041,
+	.vend1_ltc_wr_sec_0	= 0x1042,
+	.vend1_ltc_wr_sec_1	= 0x1043,
+	.vend1_ltc_rd_nsec_0	= 0x1048,
+	.vend1_ltc_rd_nsec_1	= 0x1049,
+	.vend1_ltc_rd_sec_0	= 0x104A,
+	.vend1_ltc_rd_sec_1	= 0x104B,
+	.vend1_rate_adj_subns_0	= 0x1030,
+	.vend1_rate_adj_subns_1	= 0x1031,
+	.irq_egr_ts_en		=
+		NXP_C45_REG_FIELD(0x900A, MDIO_MMD_VEND1, 1, 1),
+	.irq_egr_ts_status	=
+		NXP_C45_REG_FIELD(0x900C, MDIO_MMD_VEND1, 1, 1),
+	.domain_number		=
+		NXP_C45_REG_FIELD(0x9061, MDIO_MMD_VEND1, 8, 8),
+	.msg_type		=
+		NXP_C45_REG_FIELD(0x9061, MDIO_MMD_VEND1, 4, 4),
+	.sequence_id		=
+		NXP_C45_REG_FIELD(0x9062, MDIO_MMD_VEND1, 0, 16),
+	.sec_1_0		=
+		NXP_C45_REG_FIELD(0x9065, MDIO_MMD_VEND1, 0, 2),
+	.sec_4_2		=
+		NXP_C45_REG_FIELD(0x9065, MDIO_MMD_VEND1, 2, 3),
+	.nsec_15_0		=
+		NXP_C45_REG_FIELD(0x9063, MDIO_MMD_VEND1, 0, 16),
+	.nsec_29_16		=
+		NXP_C45_REG_FIELD(0x9064, MDIO_MMD_VEND1, 0, 14),
+	.vend1_ext_trg_data_0	= 0x1071,
+	.vend1_ext_trg_data_1	= 0x1072,
+	.vend1_ext_trg_data_2	= 0x1073,
+	.vend1_ext_trg_data_3	= 0x1074,
+	.vend1_ext_trg_ctrl	= 0x1075,
+	.cable_test		= 0x8360,
+	.cable_test_valid	=
+		NXP_C45_REG_FIELD(0x8361, MDIO_MMD_VEND1, 15, 1),
+	.cable_test_result	=
+		NXP_C45_REG_FIELD(0x8361, MDIO_MMD_VEND1, 0, 3),
+};
+
+static const struct nxp_c45_phy_data tja1120_phy_data = {
+	.regmap = &tja1120_regmap,
+	.stats = tja1120_hw_stats,
+	.n_stats = ARRAY_SIZE(tja1120_hw_stats),
+	.ptp_clk_period = PTP_CLK_PERIOD_1000BT1,
+	.counters_enable = tja1120_counters_enable,
+	.ptp_init = tja1120_ptp_init,
+	.ptp_enable = tja1120_ptp_enable,
+};
+
 static struct phy_driver nxp_c45_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
@@ -1536,12 +1670,37 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
 	},
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
+		.name			= "NXP C45 TJA1120",
+		.get_features		= nxp_c45_get_features,
+		.driver_data		= &tja1120_phy_data,
+		.probe			= nxp_c45_probe,
+		.soft_reset		= nxp_c45_soft_reset,
+		.config_aneg		= genphy_c45_config_aneg,
+		.config_init		= nxp_c45_config_init,
+		.config_intr		= nxp_c45_config_intr,
+		.handle_interrupt	= nxp_c45_handle_interrupt,
+		.read_status		= genphy_c45_read_status,
+		.suspend		= genphy_c45_pma_suspend,
+		.resume			= genphy_c45_pma_resume,
+		.get_sset_count		= nxp_c45_get_sset_count,
+		.get_strings		= nxp_c45_get_strings,
+		.get_stats		= nxp_c45_get_stats,
+		.cable_test_start	= nxp_c45_cable_test_start,
+		.cable_test_get_status	= nxp_c45_cable_test_get_status,
+		.set_loopback		= genphy_c45_loopback,
+		.get_sqi		= nxp_c45_get_sqi,
+		.get_sqi_max		= nxp_c45_get_sqi_max,
+		.remove			= nxp_c45_remove,
+	},
 };
 
 module_phy_driver(nxp_c45_driver);
 
 static struct mdio_device_id __maybe_unused nxp_c45_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120) },
 	{ /*sentinel*/ },
 };
 
-- 
2.34.1

