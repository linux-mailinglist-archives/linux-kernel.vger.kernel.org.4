Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EF973B1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjFWHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjFWHmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:42:05 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AA826A1;
        Fri, 23 Jun 2023 00:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6HcOpHBk31oIT+DQWPtAav8vg4euxHmfv62PU12pJZQR1gkl4ZC77IeA93Bq5wgyLLN0eY1fQmpYVBgzh2u1eaAM00Cmr1zOa8eztVkc2rus8BsywYEBWt6zrOlkMhWi2f2v5VZ8Wsk0w/qrbldmIkgLTcURadJp78Df8NneNjP8cP0geiYYSYQfRa59TK8lBRo5yC8U91M/SyFgkwxlsJbt33rOYQldgOK/f7wgRyFpznpznqT0daKHHulIISrwxz7kg/Fv+C3USygZS9LRhwzcduusbTEadwEmgN5eIm0dGClcv6VQpjsAvnfRisFCmpGXbmkF3umKVxSSGiqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9ZhOVvXQBX6vcdkyDC66zUtGeo3HwWNDGX91SbU7eA=;
 b=h+er8KAiXGP8EPjqVR5SGqYa2XjuZ3mi+iuvCD3+BbuTrKr+ZI59EXP7cs1vskfLBhM+qwh1yTIc0vK1HhRdwAkmkzt1tbnqPcoqDVhyrOwUqi1gV9i3M2TWJsBQO3q8io99k31wQQLmgcLh3S6w2K37WNsHlC0SwMXF/t6tYuqrkpletuNVl5cKVSn8gBflKPPJcdMPh5j40/u1g7IJaq+NcDWx47T9bMAmVk2LC8sdIj9pR0kGTDWDHZ2e49IiEx8KunBJtVjYobfWu1Ak/RZvWpqbLFTFFK2iu5+XUNuTrHiBcj1rsqcRmPwPxJ8W8p0nAThSnX5llhdoJPDwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9ZhOVvXQBX6vcdkyDC66zUtGeo3HwWNDGX91SbU7eA=;
 b=M9oRJvg/0eATBSwL91/5YRJ1Q2vGDHglZEXgiTFpRQS/a+mjgzDtuWWV12opXq0f3NsIsyM68e9BpXbr+prqwtTBnJb81M6ugbPhgYPQcX/FdWIEV+OPq2nmAwX+56ViJQNDKfap5zr+UCUEEtv1VYPUCHsUk1R2viqZENxwy6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 07:41:46 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:46 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 09/13] net: phy: nxp-c45-tja11xx: read egress ts on TJA1120
Date:   Fri, 23 Jun 2023 10:41:19 +0300
Message-Id: <20230623074123.152931-10-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 41503a0a-f7c2-425d-1364-08db73bd4c2d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PK68sa6Se4ONglmM9CMGtoD454ojjZJlz7bRSQfuGjtmb0z4RxSJEvuWPSUG8oHzgBoBzhjcWtQ23c8uTTdyYA9Mc1ppxN38jg6yF+gtJtHT4m1ov6ofGu41suKVbCLX0LhThWFtPIWI21OOwM3fyLdkvvWqznqcJRYV3QDPgVb757lwziRSsQSVcv5X0YF4D8BmTsDc00LQDFcMZ8NOjHC8gUzof1zv3plRl5Ra/0Qu2UbshRgc9KTvoTpaRlDG8lfB+HbuUESdSiRCbUK88aR/bJ5ORUmRbySD4A68BSW0FGtO67/5pcxIpJhNuCM8azXjdsbO45YtGowwYvlenGpRww6rVD40pPlvJn7DWh2AuSJKmi7Iw6SMwSzjeSIwAKRJU+YsDXB031Oe7biJlTJNq5Jebqh4Esn5vpjQjsJb20dB6KfIiDy+OXyGFm6EMfUEbbcYAGww2HBGieEWoeJiYYZK+meSX9o9ZPDvG2olZMlwUASdqB9fHHiQsNA9b37xFCMZFuarMUlqRquEJx6cKYrJNqSsrPdzELrXZ2lC0ufhAYcMuLYQdwn7EytnbAG2ghiKJNonYK0fuEq3CsQskKLIGEahi/Ncqk+a/DYCLHsPUMoEGbKOOaw5gzSN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(41300700001)(8676002)(316002)(8936002)(6486002)(52116002)(66556008)(66946007)(4326008)(66476007)(86362001)(6666004)(478600001)(186003)(26005)(6512007)(6506007)(1076003)(83380400001)(2616005)(5660300002)(2906002)(7416002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2uPEftrv5RAdZGP+/ncWngiZqRzop6VTtU7iJ7JJVAbVheP0iyCEYvdj8GA?=
 =?us-ascii?Q?xOaJ/jmqRxFn2VdkSLy3nK1wt6NzmPC6IjLANknK4D0HwseRszfH17KKucrH?=
 =?us-ascii?Q?iHbKYXFUEK23l99YaFokNKHIXkNRq2uYagclhaLFs8LSQt90lkoJX9G3hQiT?=
 =?us-ascii?Q?H+2Qbc8evrvXj8JLiBsfjMeWmGBkB6faHyCIRQFUfE3rx3IPgcxxOcIM8yEq?=
 =?us-ascii?Q?bkZRrOpaTGGKM2BiwY0lQRMWxlS9TsBT922l3bsAYJPE7TYAm+ryNn8LU2HV?=
 =?us-ascii?Q?u9MqE9dng46OfFKzrsBjnANl9BLGdthg3SEg1qJzHJDG1DwPZDMSHzHq/IVK?=
 =?us-ascii?Q?C8uW4oEnpvRMigpgR46DT3H0iouvGBpF1/WJdQx5C5oOY4LQt4DsVbEWXHt7?=
 =?us-ascii?Q?iEmVoq4g4CLsZRzqC6C9HgmrHvlczMKlA19MCTf5OB9kZloZRDfkH7u70f45?=
 =?us-ascii?Q?UOwLQwrzmX7cFVl//8V9tsB4HRv5KqWkP5CvHFbemCzGYttpqD4H49GdwU4d?=
 =?us-ascii?Q?xZfefr78T1E+H6QKVbyBKwN+i2MGeUjMmhIRR6n9B1+1j0Luu5+ha+ecQ3Qm?=
 =?us-ascii?Q?CQxHbaKcWJpm2brhPImncA9NQusR5xC4vQ9mzTYBcskz6AfNWIswugmAV8NL?=
 =?us-ascii?Q?FJvvq3Udz40/Du9dXdfLI9PWNyzX5uURK+GMObRBBqL1CJHkyC1rGtpyB+/q?=
 =?us-ascii?Q?yUABy5tTN27PFEHNn8hWKWeZmqtyie7C9oO/QHxdXOiuhq+5ZxpKD+Z9kXiG?=
 =?us-ascii?Q?hkmyY8hUYnQfKYTshM7PyAecg15uGMbBygHfCySDH0l2z1njOdm0eLii7KSB?=
 =?us-ascii?Q?BK0dj223UVhkH1cFqyFKHNofw0CqmL/AgbG+6emkuE5JCHtj+39R1mezzZFc?=
 =?us-ascii?Q?xNHOc7qvvccYu9QihWx9g8IrvtIY5+EKil8Fh/69P8IYn0D0oYsXkjCddxaT?=
 =?us-ascii?Q?We4+xXvIeWbvmn1qDXyEDkePEqDO8VUvzKD8Gy4aDfQ4qZqbl98tJYAHyUFe?=
 =?us-ascii?Q?qT/X+wevswTEPxZ3ER2xdUj5CQ7pGm11npWg/BKp8Ua6sAwLspPFGp+8IaNa?=
 =?us-ascii?Q?PUaAH7I3JCvFP2cFxRxqNRX/Xv7q2Gqn2p3ynD/gbaq7XCsQAZZ2AlO/mMNI?=
 =?us-ascii?Q?QH30S/yex+Fw5Cu8E1kbsg7MT16E3URgzRtaRlkIIOIzn52YFB8rKWG+a2E4?=
 =?us-ascii?Q?DSPfDU45sZLsiFUzB31xiE8XBpua8Q+4F+S1HObrInn0IfEkT4bYss98wFj9?=
 =?us-ascii?Q?k8AWOIXieqPgY474CljTBwON+OVqgAot9xBpwc7amgmRLjbpODJDSccn7BGO?=
 =?us-ascii?Q?c40oAxOppK+dpIgJQge1mT6qp1n8IhEaadNku0m2MW8zHGOUJ4EUYgaMHaSi?=
 =?us-ascii?Q?i5zqyu/VyNpk3bqXxBzVlfiZ6Yi2bAoMGakrJGrLoFsrJnEyak7YEdYrvMar?=
 =?us-ascii?Q?QNPcVCOd/f5y82/uh5wjLua8jL+hOWjND+J02wIIf/nqVzVD/5RQUpM6sJEU?=
 =?us-ascii?Q?L1KRqRUp/t5+coQNbVEp9/5lCiINxOR9AwkFS5vXoTrOGyeUan9SUo22VleX?=
 =?us-ascii?Q?HYmU0Cn+5nh404mTeVcavrJ8NGFC1wwu2WPGeWBOcwK2yFZNW2jZsWhsXg6A?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41503a0a-f7c2-425d-1364-08db73bd4c2d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:46.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/yPFIvqrDVgktQop/1GYle5SYF35234f2kvD89ZGgOUERDZ9mBfEGL1QBqiSb3BvI5YG+OcbSvPZQzSi4D96OZo1I0pUsa5nD9vJw76s08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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

