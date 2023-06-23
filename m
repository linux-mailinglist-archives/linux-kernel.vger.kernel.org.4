Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA15173B1E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjFWHmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjFWHmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:42:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BB5273F;
        Fri, 23 Jun 2023 00:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnzShAbj9jOJosl67bNuU6yN/j+qqQfC9rLQ8T+tJdWnfJTqi8IpgEGzoZ0U+vfD/vVv76STWhlCLmu9CFUfq0dCXC557ouXo2YR98L95wPErtsb39XJZGmGNC5htnN+YQTFB1HAFwj11lyIhpaB/+XdjrTKlXSUrG5aD92dDwtZKn9U6NZtZxMPU1DCYNGod1UHG7JjNcqdtQsxoW0J5+hUCHSYSt4wNtDI7NAtpabapFGUB5cBhBBWIw8mgnBO3Z4PRPTLJbKVftd74YT6D44mpKGDRP+J8r2tD27/2zxrfB0XT5ABv0UsFwrS5IsF2TpOqbwArXt+ogWS1elyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8OoMy6NT2MnY99JjceKOZ9IyTrApvR8V/eFj2JrOIU=;
 b=DPM6EW+giv+gWBdWgArwW9AW4qAz2PixjjwQxthi5seoefqQyABAd7q3n0B6bDG/GQorEBpgEF888iFi+Zz+X12mKTBRFJZ5xhMIWxXxlk+J5FYFvPMO1JTVQiyNcsd42f7b+c45VjUPp2pIKhhmWZQajuyI2ZFQxVeeeGZJB91fAEomzLGuLqG2tFWsl/Dvt4MWV+NtfACV/ULRA0W4mZD7VCwa2WnXEktpQ6OLvYt7IGpzpQZqbGmlLnMsge3aDE06aWcVYcLX1stalMyycQOmWXV8tkA8p9q2R1E/RS/O9PC2haEGS30pDRaI97QT4mlizbBT1fLYP+Ck2WnC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8OoMy6NT2MnY99JjceKOZ9IyTrApvR8V/eFj2JrOIU=;
 b=NSDIU2XUtR7Dj8lc0BSJ2NtSgJc9ql4vVDsGPJVg9dOjLjQGN5xxbUvZW0BbsTBFjKxr1mKKhUd9vWQ7DiGZOe6Q6pxNKj2TdI9oi/MVPV3SSrzcn6skJ5AbSKZz1nvDSjr6ozE2x3++KaKSmo3Z4vXyE8QUc1Pt5hjQWl70L84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:41:44 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:44 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 07/13] net: phy: nxp-c45-tja11xx: add TJA1120 support
Date:   Fri, 23 Jun 2023 10:41:17 +0300
Message-Id: <20230623074123.152931-8-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VI1PR04MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d5977e-40ca-4788-2fff-08db73bd4af7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NS2pjQoOPsTm8cojinaqYeHo23OWu3lRAM+9syPhcRU3lcQqbu6K4pp6v+d2ohLLt/EC/fjt+fojc60U8DBdaR9E+3Hj1Rmy62lYSswnG0mbHqdWEaxElIfYP+V/rv+gLpokm5jkaWr7DKkNV6aLAItZCjlJWjt2QxtPqzsADZv0aVLA2eZOfO2lUfZ11QbqiL2TT7GE0dQOsqPisMi6tMGY0vYhvl+f/3GUihDEX286ouFTJRD3bBI9+wM+SspUAoASFHgbOqdAfsDVsvx895xakXfkvtDV9uU3pTxGkKwVE3xHCtUiQWwOpVx29k4J0PaV+YbdJdDxS61IkUuvRfr1ZqUd+uvY2fyu1p3XhRK0vTVTNDEQ2FL0zKpvokOeB6QRVK6AQEvMupOdbGUDFDeddOQnEWXqB8nqJOCMiZYsKQ/Inver5sPS1RfefgU6rClNzV4F/4NCztW60gvx10B3I7Fyreq2lcGWvCs9KV3Bt9agODSwIbY2nVaqIRjhxNUemD+BRVmPT4XuPO8kQqneVjJE1NIwTPycwlI5PtyH53M6Rb1z8dOMO0lc4NkHaUHwRRIDku1W4/N0ovOMv1jBGYH4xwpDp+PDc5urFPluch7GAaLxWp19vM2tdE07
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(8936002)(8676002)(5660300002)(7416002)(38350700002)(38100700002)(2906002)(478600001)(6486002)(186003)(6666004)(2616005)(86362001)(52116002)(66476007)(6512007)(1076003)(66556008)(66946007)(83380400001)(26005)(6506007)(316002)(41300700001)(4326008)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t6r5hSfGCDfFcZXnqEww7avXYMyjjExNrKCkFEe+Ht74JqwLwHNWWcwfB9FX?=
 =?us-ascii?Q?K8IJkaL32Kl5LLtEgu/LD2Uc45OEfirbyijWiyp/6MAgWT0E5U7dV1tWZ1NT?=
 =?us-ascii?Q?urp8jMOrojv8UJkrThcKm4Dr9/Xwdjjt7mMj2o+nFwp9nQCTNSuIVUbOQW0F?=
 =?us-ascii?Q?iDa/jatLERGp6TUdcYuyCZ+ASCDP+ownVmsfvRaL/6/C5DgGc9FAidvfHRnE?=
 =?us-ascii?Q?rTezJkimAk371S1wOFH1aaZ9wACbMBqIqR4G7AUFvXn96sS0EWN8UjIDppxW?=
 =?us-ascii?Q?xy1M9ai00BbQHQsGyCmoF9bUbzYjdyKqEVkpLC6fz3xl/uNjFmZ3Z7P4yo2Q?=
 =?us-ascii?Q?gnWZtLj9treE+wkYUe8Sj4Y+7FTrczEMbHvK+MKXBngq60MNdamnjlA8Cqs2?=
 =?us-ascii?Q?OibIhIRRUuh1YwfBILRd3b2sjs24J1q7zr1vAqNhz7zOJ1jQyzJceDlWCKie?=
 =?us-ascii?Q?OfoQNdWpZzdaviGizpdmUEsGYpDp8To3Qbc2y/CH0vb32R76JygHWC2YX4HB?=
 =?us-ascii?Q?AkwRCE2wRudcxQetNj6FbdoS98ABO7SSLio8NNWvnHMEo1yEcBTRGVqMu8J3?=
 =?us-ascii?Q?cch8jOgkAA2PkNm+Bd6O+Ix4r3dkhXPy08r1HD/slKU16e38ru5uEwRyiujm?=
 =?us-ascii?Q?N5H1gfrf6UudJFAo8l/ArJUpJRZxm2O5l6lSgHYX1JZD9mcph0dz9Nzvwt2k?=
 =?us-ascii?Q?MVVKyMH9tnoALTjjrwlX6Gmnu+Nr7jwp9OJ4w7H2+9CpCaez4bei76/1ZIuZ?=
 =?us-ascii?Q?txiQtSmlb6g00Yx/svsbX6tzEjhGoVIs/8P/vvft5AeOmSP33BRxm2OPNiAf?=
 =?us-ascii?Q?Dqf4hln2z0n8bqYpxKzZi1OQD2mWV1BFUqy4e+lA3ZasR/0O4cYD20lIaBaI?=
 =?us-ascii?Q?w7NbLoYtWYRuWSUBaIAC6Cq0CAyqg1fj3yIoS/KjFWNCLLaj84VtcKwgpDsS?=
 =?us-ascii?Q?CWV2IQCqYgl7nG2LoqDmGIBFCsni4fouCmckIkYmjLGu9jfjz3DZKTMf4xo+?=
 =?us-ascii?Q?5TQnfNtHAS6diut990ZB/FSQIr3w9aJV87y0cFpTjqfQIOkIi8KRcgimFYtb?=
 =?us-ascii?Q?FRzwTmXnYSnmF+NEH5EhAajVHQqvNp5IJ/dnxNwrvoEMG6fUaq5nyZRI7fRN?=
 =?us-ascii?Q?Qo/LKDbCQ7YKeBgsdPwxOYSfVD1U/ZovQSUA51eV4tUcdNhCDJRbAW2Vf+p0?=
 =?us-ascii?Q?UsBHRTG0vi2qsfcoRhutlEWlg/rr7N6VwEKNulKXpQo69oZxufTB6dUenLtf?=
 =?us-ascii?Q?OUA3qbt2WB1eJqHrr11OOJA7V5x9WfijcO5w1mGSpZLpZKgMAGtgcF27Wgal?=
 =?us-ascii?Q?sjtOGwTZ2k4DRr2E5jusuH9Ir+llWaeiEpkVciNJB9HOat+M+em/HV5YEoNq?=
 =?us-ascii?Q?E1cQbGa7XQiRAKhAL8vjgr9GIhn+Z97EcGKgjDkSNK6O9s99D0PeIA1PToue?=
 =?us-ascii?Q?B32EHF3w1adztk6LuQdxBIcr0Ivq7Bc4G0N1rq0J14p6q2soOhQdXxKCNWk1?=
 =?us-ascii?Q?lJ+RJIw/zqeY3rYewSjd4LAUNJhge8RtJcH2YVOm5YRgTaiDJXTm7pnpkElz?=
 =?us-ascii?Q?fEV/K3cyhNRCLk1BPGuyZvdFPKigZhjwZEs0Ugd4SIAG0OnzuaRXUm3LCUUB?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d5977e-40ca-4788-2fff-08db73bd4af7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:44.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dr0jLjpaXV+DJ6DlaVFxfqfa4wkBQZsB0BX1U4M+nxoISkMyye0TbnUgpPVHMKkkLIeBDVoSFJ4I/WoU1PE2Pq4tmxr67RCbgWpil7ua9WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905
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

