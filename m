Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FA473F586
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjF0HXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjF0HWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:22:31 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB76D2735;
        Tue, 27 Jun 2023 00:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaZDL8L1oqYiVjkuqv8iLIUPG42JhkOL8eybJJzgcX8M79HFxh5GRtESE1kcZnJKsNBQL8ZVsP5dKqf9CuoVLMFvlc5AfBrgQY8Kawqnoj2wY4Jkw45UgDK818ZT3DFvSaRo6iOAl8++SjMNoFwV8fPQK7CkvubNA0YBZ1kunjur9GayIm0zp4XsvKwTkYR9Ge1ZSt+4llSXfQqeA8W7uG49lUwnAMY354eCMPBL7wVg8v6/vA8QBh373u/hNjx/DRVBkI0vfk8oiflst/U0XcchAFO2QFjx/93zUBoo9wx0KJBXUmGbhmjq2nYLZ0BhLyw+covFhnuC6uB2Vi2P5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9ZhOVvXQBX6vcdkyDC66zUtGeo3HwWNDGX91SbU7eA=;
 b=DaSWGSFDXWqdX8oVsnt9f+gb8k8oCW4T4ToOEITMCBsT7uhfN9sHhg5eVE9G6c9wY2fotXOFAsuP9z7ARNQ99SXd3iQCdXxSWh2OczPGvCf9UgvNFvbvX8TnYzu5KqWjQ2FhuDdMwN1CJXULO/RWw6BRH+5cUsCUJkqB1XU1kALu1vF1XosEDGcq6tIsNe3F/+KDzAT+pj+x7yXwXn2giCYv5wKqgLsvwyJtNMjpLEEP8c91a3jmRdoCKHAtjuM+0raOwvYdmvCYximoNisX+3R2zYiOBm59ak49J0lhtKpE4wGEfMBD8CF9kfEWHpWbXKUlE/cagvsLwAf7U42odQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9ZhOVvXQBX6vcdkyDC66zUtGeo3HwWNDGX91SbU7eA=;
 b=klXOurrvjOBsDOuw/mfLkPIbVYSEx7VL/eeCXXhnGPplMz5ZTXbdtKaYfKtJj7lYl6XgSxHwpvrMHLAsTVEs81BhkCR58Ky/yIZh5YxxoZssTu7Eqp9FxlewZhpBo2z3n3YtLouZXynJcJto+omKJVsQJLZG0ucRio6rp9SVAhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:20:01 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:20:01 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 08/12] net: phy: nxp-c45-tja11xx: read egress ts on TJA1120
Date:   Tue, 27 Jun 2023 10:18:49 +0300
Message-Id: <20230627071853.106215-9-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a547a8e6-e57e-45df-b9fe-08db76deeb90
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdkX/5KjlTqXFrmWQfiO0SM93MA/r8LSp7eI2MGpsDYJGgrqDw4wAf9bgaHkl7R0x+L7jXDrjHs9f3l5oUKo74SisATt2DvXlr5YN/KTI9Ky21fzp/2MJD9b/48I38FwkXuH9U4bAK/YQWmjxG5ZUMQzMkCJo3nWiVGfslVOe2OMLrFUUFFHOjFxfaUfPjT6R0WU38hGghnW3NBEHLs4hML7FbPVt/3ts4shumL2UbuLx969KCT9nngEgKE61Rn8izzodtcuXyDAPj0xnfImVs6h+kv8eez1VKYl88UrKG0z4ujF6oO64reCm6YWAPwMmSCLbXOuAGN/7ynWmRm/eSQPdZSPc7OlDwuGNGtSr8yJaL6o4/5Ic3eK8tUB4QyV8cIQWN0XLiZxqrrcpn9328Y2YjJSGl8T8rmd5sjB5oJp1tHbcFPbwl815DF/e9tOI5nBMo1xsiwPp5/WTdCPwd9RH+tJrcCGWryXmAyRFHHpJTfPsnpONYQqkjPY6Vsc7yWVI/D7dk00Y6cpS6iOv6EKoq+vlVmT2OCrcsnb8ZEmW23NSLqTpIuocAiiFmI2uzYwBE4uhdbGdpEY1u28rDfWe6BxOz2jGTIkmzWgylvC6aWGVJtVZY+64bm7qjiO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(83380400001)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(38100700002)(8676002)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WZLOMBEpI+n+HUkORrjdYgoTl34At+4NhB1tl9d++NhblNIBFhPYAGB9EOLX?=
 =?us-ascii?Q?pywbXE7ZSHGZd+auqJuvMoz6jPn/RH8allarku1qdsazUy2HPnLa7FwfpZUF?=
 =?us-ascii?Q?rkyLxFpZbdZLFOHYsAfTRqmZYGI8Ps7EmAXJBrG0PSnoL+hOeQjTfQS/4HX6?=
 =?us-ascii?Q?QXmSCihw8cqydqPf5dL0L2HkfY9TZKHjM2orv2NkXzrTy8ZQg0BUMvFoVl9T?=
 =?us-ascii?Q?TrL+mJeunzIN8AlJbe6TLPcS9sOre8l6F7mcwUCaBWQE507YlcCd46ELN92y?=
 =?us-ascii?Q?iAU+zakjCpe5/MdO3pj/829FdLn8qh2C8FfsScjiUWjNlpFolVQJIhhoxO81?=
 =?us-ascii?Q?ULErL84sB0WTYoVCmTw6AVZgTlC6XuVn1ck22WSs6/Rbb8bgSH8iC1KEeLmU?=
 =?us-ascii?Q?nTZ10pJGoJTWicHB925zulK/gZpx4X+mJNttDmInZokDeG6hQ0yHCt+KbMYt?=
 =?us-ascii?Q?buopvJCcSVmVHyqPv26QsgLncVXmbsjRI6HrHQ4j7Z9cru2BYl1mBfbApWg0?=
 =?us-ascii?Q?4jLo1R9gb1xjGpmI7J9jY6ldUB6zbH/trvEvE7mgfSCdkWF72L6eD17sEHIX?=
 =?us-ascii?Q?ft4XRRaz7445Y7r4UGCMq2qeCAzvhCq3CWzZS/DveqNVcah2XxtdLceVXV+f?=
 =?us-ascii?Q?YDsRhOtLVqTJFd98OIuexFIlYZxbZhhsKYuaI5sOPG0plF8dNdf+lsoHaxoQ?=
 =?us-ascii?Q?pWBuSHTb44inZqOQGitlI1GIR0gXd95RYHTdf2ot2IH6wLh6W82i08/qzPle?=
 =?us-ascii?Q?8Ol+xWfNHFfiYYw3v6P6hjiwMhBYJaLVC250gdlP0yNqg/znHTyidCDCu9Qq?=
 =?us-ascii?Q?IJb5jqJKbvxChr0kSpQZLMJuLAytOngZODCVB9w8kzRIsGqRRCfkEdbdPx6i?=
 =?us-ascii?Q?FP9rATijC343REpwO/q3bSvNWJ+aFKK2AGjqKDDS4jTa07OLc9AmtEmw9gdD?=
 =?us-ascii?Q?kKxHwgeC4uhyDU8g72kKV/HL4HYNw44NcZIQwseWkT/nf7zABo9gFGkAvo9X?=
 =?us-ascii?Q?pBo4slBV3hBjD5l7dxy4a0/gyv70xqnwbrM0Fhm1rok/cHpD4RuYz/Wpz3ne?=
 =?us-ascii?Q?UCcsHJ5BskTMUrtcTLvwCuQCWoXIjRwGyREZd8QIoa1dSUN8Idp0NZtTObsC?=
 =?us-ascii?Q?xHh4joyAaDcjBXuDb0oQFH9ZNm5gGTgntbuCRtts1MLvwljeEVuR4UzKXPQV?=
 =?us-ascii?Q?CRH/SklgIdLK7SpIluuypQaDieuXwcZuVkdR6Ww/nqcD3rDyiv68uzR7fY8f?=
 =?us-ascii?Q?y3gFOEpoMZ8H/Ss1THx4qM0AdUPprRUTfwdJT46j5B7gbjtr9CiloFW2FsGo?=
 =?us-ascii?Q?o36RyRrPkqdoXe6yhZVYXMXQ0TcT8/+G7gOdHZe1TVsRlyLMSew9X442WZ8v?=
 =?us-ascii?Q?zWyk9j6L+h/iM0DMWGd9o0Uz13e9LUMOFy/X8AXDBScKhCrRZHc5DuVUIQGP?=
 =?us-ascii?Q?+z73f2JWsiedmMjhh8+s34Gw8OvhS2TaDMdZPY1jp5E/gTTX60kiNs5Khg5b?=
 =?us-ascii?Q?2gACTncjpHuwSqAsb5Hi9HzwWTOQEEPRrzNyfNfLyRn07LGW1oUIdy6DbYPK?=
 =?us-ascii?Q?uIenLpOYxN7WnlzbEFy+mB0Ev7w/8qknFPWGRmWylRoZraQasZm0BotHdtGP?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a547a8e6-e57e-45df-b9fe-08db76deeb90
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:20:01.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGZ4CyBUoQSo3G7sum/0/dizO66p8x6Xiso5wZTHQJ4vMS8wMRUV9jB40bCxIz9K9Eo+CiadsWkMHZXgRMs0kJD4ctloQPe3AR6z7ejNQYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The egress timestamp FIFO/circular buffer work different on TJA1120 than
TJA1103.

For TJA1103 the new timestamp should be manually moved from the FIFO to
the hardware buffer before checking if the timestamp is valid.

For TJA1120 the hardware will move automatically the new timestamp
from the FIFO to the buffer and the user should check the valid bit, read
the timestamp and unlock the buffer by writing any of the buffer
registers(which are read only).

Another change for the TJA1120 is the behaviour of the EGR TS IRQ bit.
This bit was a self-clear bit for TJA1103, but now should be cleared
before reading the timestamp.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 110 +++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 62be1712167e..0567a366af37 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -29,6 +29,11 @@
 
 #define TJA1120_VEND1_EXT_TS_MODE	0x1012
 
+#define TJA1120_EGRESS_TS_DATA_S	0x9060
+#define TJA1120_EGRESS_TS_END		0x9067
+#define TJA1120_TS_VALID		BIT(0)
+#define TJA1120_MORE_TS			BIT(15)
+
 #define VEND1_PHY_IRQ_ACK		0x80A0
 #define VEND1_PHY_IRQ_EN		0x80A1
 #define VEND1_PHY_IRQ_STATUS		0x80A2
@@ -59,6 +64,12 @@
 #define VEND1_PORT_ABILITIES		0x8046
 #define PTP_ABILITY			BIT(3)
 
+#define VEND1_PORT_FUNC_IRQ_EN		0x807A
+#define PTP_IRQS			BIT(3)
+
+#define VEND1_PTP_IRQ_ACK		0x9008
+#define EGR_TS_IRQ			BIT(1)
+
 #define VEND1_PORT_INFRA_CONTROL	0xAC00
 #define PORT_INFRA_CONTROL_EN		BIT(14)
 
@@ -158,6 +169,8 @@
 
 #define NXP_C45_SKB_CB(skb)	((struct nxp_c45_skb_cb *)(skb)->cb)
 
+struct nxp_c45_phy;
+
 struct nxp_c45_skb_cb {
 	struct ptp_header *header;
 	unsigned int type;
@@ -243,7 +256,10 @@ struct nxp_c45_phy_data {
 	int n_stats;
 	u8 ptp_clk_period;
 	bool ext_ts_both_edges;
+	bool ack_ptp_irq;
 	void (*counters_enable)(struct phy_device *phydev);
+	bool (*get_egressts)(struct nxp_c45_phy *priv,
+			     struct nxp_c45_hwts *hwts);
 	void (*ptp_init)(struct phy_device *phydev);
 	void (*ptp_enable)(struct phy_device *phydev, bool enable);
 };
@@ -499,21 +515,11 @@ static void nxp_c45_get_extts(struct nxp_c45_phy *priv,
 		      regmap->vend1_ext_trg_ctrl, RING_DONE);
 }
 
-static bool nxp_c45_get_hwtxts(struct nxp_c45_phy *priv,
-			       struct nxp_c45_hwts *hwts)
+static void nxp_c45_read_egress_ts(struct nxp_c45_phy *priv,
+				   struct nxp_c45_hwts *hwts)
 {
 	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
 	struct phy_device *phydev = priv->phydev;
-	bool valid;
-	u16 reg;
-
-	mutex_lock(&priv->ptp_lock);
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EGR_RING_CTRL,
-		      RING_DONE);
-	reg = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EGR_RING_DATA_0);
-	valid = !!(reg & RING_DATA_0_TS_VALID);
-	if (!valid)
-		goto nxp_c45_get_hwtxts_out;
 
 	hwts->domain_number =
 		nxp_c45_read_reg_field(phydev, &regmap->domain_number);
@@ -527,12 +533,72 @@ static bool nxp_c45_get_hwtxts(struct nxp_c45_phy *priv,
 		nxp_c45_read_reg_field(phydev, &regmap->nsec_29_16) << 16;
 	hwts->sec = nxp_c45_read_reg_field(phydev, &regmap->sec_1_0);
 	hwts->sec |= nxp_c45_read_reg_field(phydev, &regmap->sec_4_2) << 2;
+}
+
+static bool nxp_c45_get_hwtxts(struct nxp_c45_phy *priv,
+			       struct nxp_c45_hwts *hwts)
+{
+	bool valid;
+	u16 reg;
 
+	mutex_lock(&priv->ptp_lock);
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EGR_RING_CTRL,
+		      RING_DONE);
+	reg = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EGR_RING_DATA_0);
+	valid = !!(reg & RING_DATA_0_TS_VALID);
+	if (!valid)
+		goto nxp_c45_get_hwtxts_out;
+
+	nxp_c45_read_egress_ts(priv, hwts);
 nxp_c45_get_hwtxts_out:
 	mutex_unlock(&priv->ptp_lock);
 	return valid;
 }
 
+static bool tja1120_egress_ts_is_valid(struct phy_device *phydev)
+{
+	bool valid;
+	u16 reg;
+
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1, TJA1120_EGRESS_TS_DATA_S);
+	valid = !!(reg & TJA1120_TS_VALID);
+
+	return valid;
+}
+
+static bool tja1120_get_hwtxts(struct nxp_c45_phy *priv,
+			       struct nxp_c45_hwts *hwts)
+{
+	struct phy_device *phydev = priv->phydev;
+	bool more_ts;
+	bool valid;
+	u16 reg;
+
+	mutex_lock(&priv->ptp_lock);
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1, TJA1120_EGRESS_TS_END);
+	more_ts = !!(reg & TJA1120_MORE_TS);
+	valid = tja1120_egress_ts_is_valid(phydev);
+	if (!valid) {
+		if (!more_ts)
+			goto tja1120_get_hwtxts_out;
+
+		/* Bug workaround for TJA1120 engineering samples: move the
+		 * new timestamp from the FIFO to the buffer.
+		 */
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      TJA1120_EGRESS_TS_END, TJA1120_TS_VALID);
+		valid = tja1120_egress_ts_is_valid(phydev);
+		if (!valid)
+			goto tja1120_get_hwtxts_out;
+	}
+	nxp_c45_read_egress_ts(priv, hwts);
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, TJA1120_EGRESS_TS_DATA_S,
+			   TJA1120_TS_VALID);
+tja1120_get_hwtxts_out:
+	mutex_unlock(&priv->ptp_lock);
+	return valid;
+}
+
 static void nxp_c45_process_txts(struct nxp_c45_phy *priv,
 				 struct nxp_c45_hwts *txts)
 {
@@ -571,6 +637,7 @@ static void nxp_c45_process_txts(struct nxp_c45_phy *priv,
 static long nxp_c45_do_aux_work(struct ptp_clock_info *ptp)
 {
 	struct nxp_c45_phy *priv = container_of(ptp, struct nxp_c45_phy, caps);
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(priv->phydev);
 	bool poll_txts = nxp_c45_poll_txts(priv->phydev);
 	struct skb_shared_hwtstamps *shhwtstamps_rx;
 	struct ptp_clock_event event;
@@ -582,7 +649,7 @@ static long nxp_c45_do_aux_work(struct ptp_clock_info *ptp)
 	u32 ts_raw;
 
 	while (!skb_queue_empty_lockless(&priv->tx_queue) && poll_txts) {
-		txts_valid = nxp_c45_get_hwtxts(priv, &hwts);
+		txts_valid = data->get_egressts(priv, &hwts);
 		if (unlikely(!txts_valid)) {
 			/* Still more skbs in the queue */
 			reschedule = true;
@@ -1111,13 +1178,16 @@ static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 		ret = IRQ_HANDLED;
 	}
 
-	/* There is no need for ACK.
-	 * The irq signal will be asserted until the EGR TS FIFO will be
-	 * emptied.
-	 */
 	irq = nxp_c45_read_reg_field(phydev, &data->regmap->irq_egr_ts_status);
 	if (irq) {
-		while (nxp_c45_get_hwtxts(priv, &hwts))
+		/* If ack_ptp_irq is false, the IRQ bit is self-clear and will
+		 * be cleared when the EGR TS FIFO is empty. Otherwise, the
+		 * IRQ bit should be cleared before reading the timestamp,
+		 */
+		if (data->ack_ptp_irq)
+			phy_write_mmd(phydev, MDIO_MMD_VEND1,
+				      VEND1_PTP_IRQ_ACK, EGR_TS_IRQ);
+		while (data->get_egressts(priv, &hwts))
 			nxp_c45_process_txts(priv, &hwts);
 
 		ret = IRQ_HANDLED;
@@ -1588,7 +1658,9 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.n_stats = ARRAY_SIZE(tja1103_hw_stats),
 	.ptp_clk_period = PTP_CLK_PERIOD_100BT1,
 	.ext_ts_both_edges = false,
+	.ack_ptp_irq = false,
 	.counters_enable = tja1103_counters_enable,
+	.get_egressts = nxp_c45_get_hwtxts,
 	.ptp_init = tja1103_ptp_init,
 	.ptp_enable = tja1103_ptp_enable,
 };
@@ -1684,7 +1756,9 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 	.n_stats = ARRAY_SIZE(tja1120_hw_stats),
 	.ptp_clk_period = PTP_CLK_PERIOD_1000BT1,
 	.ext_ts_both_edges = true,
+	.ack_ptp_irq = true,
 	.counters_enable = tja1120_counters_enable,
+	.get_egressts = tja1120_get_hwtxts,
 	.ptp_init = tja1120_ptp_init,
 	.ptp_enable = tja1120_ptp_enable,
 };
-- 
2.34.1

