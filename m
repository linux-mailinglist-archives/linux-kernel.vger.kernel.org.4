Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF373F583
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjF0HXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjF0HW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:22:29 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417CA2D7E;
        Tue, 27 Jun 2023 00:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4vqLekDfPz2xiWGPVPgFtUCksXFF8cRjUCg5LB1mbEycgJbfj5t/E5Jc0PovZLdWQVwJU+jCrZNhr7x9ras3iiFQb+T4EUS8LZbEo1Jm6lQFFlkd07hid3q5pbXRQ0xuShQIWyYeyEQ+48bXJ1ewZhdk1E6VKDaoE3IoyouZR1/lyx9P3g9uydB7KZUwgO6NEL83ypNrHrh9vnpE2ySzVEs0+KmVLEX9dmFjdSy8m+FH/Yp4LF6jMUZ0Nyi7Uoj3XeQ4TxkP4NXdhLP0jBpsOnBDSQZsxeBEy9OOf54Cth/LM1V2G2aT5KsXu5YKcvq4lEq+babXWWRhv7pRdvKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caG9w6+mScE8FYg4vaj8ykQMxUOnnCtAPYAtgRzJuas=;
 b=d/udJMPUnt1j8fsRhmsdjCxA9P5K/ctE/MxSdZLGiMbOAIS78W4+8l6LH44/OPIKaeVvBOSnbdas9vMEc2Xft/4kWcZg9yZlOdkTdr3lNvbFrS5V2lYnHeUtx65UpwZhfKqdNEKFvopqJ+v4oOkLAAiHeTQkxwiCNno0aP5xcDio3rcv1LKB53avedYW/gEiv8TEdBnfR8SzZm09/KQRfiQEypnKhBmNwlgGpavU69a2ElaRYi6DmhLG3taYRf4i7v5TJD6KTGowARwSaBb2BLla0Ao3xUGFHAgbVVYSD16ebBuIHo0ZyJZaCvqTFyV9XUvrSFvTO6yHCsh0GDPAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caG9w6+mScE8FYg4vaj8ykQMxUOnnCtAPYAtgRzJuas=;
 b=IGKZGMxRS7GW0UPcF0UeAc490CMtOUFTxi6yrDs5t4WxN4FfoNqRgCaIRlQaXMbSEjDQMzbCAf4QK0oLYJ1t2UxgCylUmI5xTBTtsK/P0DOMKbE9nn0RPLBaSp/AjLIeNJAFeqqbSkNvdhYUOFnvldLFvEBcbyOWiyGZdgLsygA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:20:00 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:20:00 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 07/12] net: phy: nxp-c45-tja11xx: enable LTC sampling on both ext_ts edges
Date:   Tue, 27 Jun 2023 10:18:48 +0300
Message-Id: <20230627071853.106215-8-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fc3d71f6-7022-46b8-a1a5-08db76deeaee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0P4vmTNNxfPugbieYm3rlgwdceHgWKscxesnQZoiCgWX/wXNT3AFETQgsgqU5Iidbq258HAIbecnpZfeuHz+6Qm5O3tAf2MykdbK7J2XtkEc7I2iMiLqMLX5kt2UHrGSRLHyPVmfBavslPEs8WN2d1i0KhXKnZAE1sqkN9Njy3tgGNsKRERphCsCvQTqWUjDLXTJkJFKd0Dwb9//lqcD4lCLMAWzmJ1Vb9ERVON4xRiCKAm2qFsT8ln57vn+7sMjur42uns5R6ibPXqEVTQeKIyyfTncFfzXPs/aE/l633RrwqqwmHfI4OCUOdILTxd1G58BZAlwrUlps47GHZ/P3GIYJUptnhOQFmVX+BGsriSlXMvIgTnL9JX8PymDu3q+C0os9OA9jyAmUwnGAxShXuoKRoRuKvWGKMgQtb3bpU5CEhilWkk+FMf3Y7mrzRXmcNaKsbyDoIuwGY9ASc3yc68wml4ekTkNIiBwuXLBe6U7u3NM6sOZipC2uvh8e3k144EqyMHE2kUD0huHfwI+7Xfkz8C0goy3pUZQ5C7pkT99cis5zP1ayVhs/ouh/ZCDx5WNGeq2WOYEqcLngf94ocbHGekTid9czM+oPm0qsf+j6dWRAis5097u3ux+108
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(83380400001)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(38100700002)(8676002)(66574015)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EhGbX3PyJHMsPhman47wiqc2/8JbUjshErPNJvDRhcy/BmtZKl8Cbjei6Pmn?=
 =?us-ascii?Q?dXYZh3hFVsDLKAcVgFUyp2QEY7MnesM/LRzPwzjkLPaHje0zpGGXK1PPPvBm?=
 =?us-ascii?Q?YZne0BIcVrDhCXxOPLkuQn0rr8qg2+N3KMTSz5YfGmJpDUJDyCwnF/EvkliN?=
 =?us-ascii?Q?+H8p1vYtCrgcRVhXUg3X4tEZGbPlVVfcpii6J3cT9cZN7VFUl53x9EvdMatq?=
 =?us-ascii?Q?IisPDvgUB9QPqZPef+4N2sXlADpbV0hP8hTpQ2lvjyt3Gm8+5DCR6KY1lC8y?=
 =?us-ascii?Q?Q7M7YF5nh3MNHMQZWRfEcto4OZTIBhFZqiT6vr6ln+CG5EZQQqS5z8Op8Ace?=
 =?us-ascii?Q?7DVIhHUgc3QgrKJbUCyE/A9OL/mX2dIF23ncmlrNNnH7b9VHkULbZf8Ui6bG?=
 =?us-ascii?Q?2uqrKJ1+IrhxQBBBU+81TZaA8tRoNMfuWdxQrVCr6o9kIQXaeZiwjKgNvaIE?=
 =?us-ascii?Q?VrJghfBbfbOeeT8f63P3k7s6/lhDMn8Xk81sMDAbTl8J3sn3Y1pjQZ3ABco6?=
 =?us-ascii?Q?BuqJsa4nS/gqKoyqtvEm0H2SHqFee2hu5HiUNnNWyOSzOBcPL6Pf1cn9/OKZ?=
 =?us-ascii?Q?+Z8y69fE0UUWF1BegvUN/BDjOdTNvbhjVfNr3F+4a9lA2SaTu6cSCqZeeHGs?=
 =?us-ascii?Q?3e0AsZ3lJ//OGkJ6qL7uG+K8zLAX8H6RYn6wMECe08rwHngznc2OMZf4w+zV?=
 =?us-ascii?Q?Ln7uzqASXK0PEul/e3f8v9U01XJGoi5nw2B31COz6k+xKv/sLgDWlc9FWHBC?=
 =?us-ascii?Q?PCwUiw27Fj2uUsK0+CU/7duGvjdfdL1mt2k94pL7Ual9NkQETkRcYQDuuL6+?=
 =?us-ascii?Q?43pRGLbYJpUdgWv4vIeDR8F/uQ4W2FSIbFiBs5LHjDGGk+pB3hcJRy2/9ZBS?=
 =?us-ascii?Q?z6OE04mEM8lp4WpFOyPNd/V9ALnYiYehPnva5cQt1uCvoS6hzNZZdpGnKESF?=
 =?us-ascii?Q?2L/EAMSZMJsdbAc/q3+ReLQpSEZztezHoIiDLrFbyOlc11Zq8/WfEaGGTtND?=
 =?us-ascii?Q?aS8pcS3caBuzUuUMraTOdGZfOjY+xIhOXQrabooWZtrXVzKgMEOwBM7Qh+oL?=
 =?us-ascii?Q?FCn1NqgAsxiZLzPRWy2H0hpvHuL9Pb0P6gesLlzSINtVjnECf4CiL3wv1Lx0?=
 =?us-ascii?Q?mx9AxKcdnHadgCrm4W9FC3InzHgA3FGCB5gIFRRGhSg5za8o5o81gQMeUNQ9?=
 =?us-ascii?Q?fM8sqbnmIyvyRHeSQmKsN3VcMmpGJgSDeEzCeYKDqgcIEK+dys170xDXZEJq?=
 =?us-ascii?Q?GEFtZqYgiEOcqQfQZAqWokv2rGybM/UPRg8v50DcOz+VYiAc/bd5DuKSHe2B?=
 =?us-ascii?Q?Yr5PS2ZvnoFTG/gRpIcNpFRURReP5Vp02knaV+gRc564YrQbj8rQbTWA8Qks?=
 =?us-ascii?Q?CucxpVPuwhbbjn4b5tdneIyHy/lwmiN+Ftu/0YiYoheWEVKKjGNa7eIuK9c4?=
 =?us-ascii?Q?dYxzf21g62y2T1lPSB2hyZL8Jo+XEJ2PZHVPabNPDQ5M4ELJHxFJl57WYHjq?=
 =?us-ascii?Q?XJtFaX3/eazYE30S3bhfslIZvxfAUGOhIidIjCsG2685K0j+6Svm0EBocuob?=
 =?us-ascii?Q?MPTpbVkL/n3Ib+LM0jt7Sf572A1uEoUZD5eQSE20eHOaeAJBz+4qGtxovT4R?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3d71f6-7022-46b8-a1a5-08db76deeaee
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:20:00.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmYuzr8osoW1dPzRRQOJltVoYGpyb30i2iKy7SApnZ8GM4C6MpUFH6afDd5uND80rbxNbhAYCtzn/dJn4UP2VozSdWV/PAFUiVwbphJhHhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external trigger configuration for TJA1120 has changed. The PHY
supports sampling of the LTC on rising and on falling edge.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 60 ++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 47decf2677e1..62be1712167e 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -101,6 +101,10 @@
 #define VEND1_PTP_CONFIG		0x1102
 #define EXT_TRG_EDGE			BIT(1)
 
+#define TJA1120_SYNC_TRIG_FILTER	0x1010
+#define PTP_TRIG_RISE_TS		BIT(3)
+#define PTP_TRIG_FALLING_TS		BIT(2)
+
 #define CLK_RATE_ADJ_LD			BIT(15)
 #define CLK_RATE_ADJ_DIR		BIT(14)
 
@@ -238,6 +242,7 @@ struct nxp_c45_phy_data {
 	const struct nxp_c45_phy_stats *stats;
 	int n_stats;
 	u8 ptp_clk_period;
+	bool ext_ts_both_edges;
 	void (*counters_enable)(struct phy_device *phydev);
 	void (*ptp_init)(struct phy_device *phydev);
 	void (*ptp_enable)(struct phy_device *phydev, bool enable);
@@ -684,9 +689,48 @@ static int nxp_c45_perout_enable(struct nxp_c45_phy *priv,
 	return 0;
 }
 
+static void nxp_c45_set_rising_or_falling(struct phy_device *phydev,
+					  struct ptp_extts_request *extts)
+{
+	if (extts->flags & PTP_RISING_EDGE)
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   VEND1_PTP_CONFIG, EXT_TRG_EDGE);
+
+	if (extts->flags & PTP_FALLING_EDGE)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 VEND1_PTP_CONFIG, EXT_TRG_EDGE);
+}
+
+static void nxp_c45_set_rising_and_falling(struct phy_device *phydev,
+					   struct ptp_extts_request *extts)
+{
+	/* PTP_EXTTS_REQUEST may have only the PTP_ENABLE_FEATURE flag set. In
+	 * this case external ts will be enabled on rising edge.
+	 */
+	if (extts->flags & PTP_RISING_EDGE ||
+	    extts->flags == PTP_ENABLE_FEATURE)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 TJA1120_SYNC_TRIG_FILTER,
+				 PTP_TRIG_RISE_TS);
+	else
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   TJA1120_SYNC_TRIG_FILTER,
+				   PTP_TRIG_RISE_TS);
+
+	if (extts->flags & PTP_FALLING_EDGE)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 TJA1120_SYNC_TRIG_FILTER,
+				 PTP_TRIG_FALLING_TS);
+	else
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   TJA1120_SYNC_TRIG_FILTER,
+				   PTP_TRIG_FALLING_TS);
+}
+
 static int nxp_c45_extts_enable(struct nxp_c45_phy *priv,
 				struct ptp_extts_request *extts, int on)
 {
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(priv->phydev);
 	int pin;
 
 	if (extts->flags & ~(PTP_ENABLE_FEATURE |
@@ -697,7 +741,8 @@ static int nxp_c45_extts_enable(struct nxp_c45_phy *priv,
 
 	/* Sampling on both edges is not supported */
 	if ((extts->flags & PTP_RISING_EDGE) &&
-	    (extts->flags & PTP_FALLING_EDGE))
+	    (extts->flags & PTP_FALLING_EDGE) &&
+	    !data->ext_ts_both_edges)
 		return -EOPNOTSUPP;
 
 	pin = ptp_find_pin(priv->ptp_clock, PTP_PF_EXTTS, extts->index);
@@ -711,13 +756,10 @@ static int nxp_c45_extts_enable(struct nxp_c45_phy *priv,
 		return 0;
 	}
 
-	if (extts->flags & PTP_RISING_EDGE)
-		phy_clear_bits_mmd(priv->phydev, MDIO_MMD_VEND1,
-				   VEND1_PTP_CONFIG, EXT_TRG_EDGE);
-
-	if (extts->flags & PTP_FALLING_EDGE)
-		phy_set_bits_mmd(priv->phydev, MDIO_MMD_VEND1,
-				 VEND1_PTP_CONFIG, EXT_TRG_EDGE);
+	if (data->ext_ts_both_edges)
+		nxp_c45_set_rising_and_falling(priv->phydev, extts);
+	else
+		nxp_c45_set_rising_or_falling(priv->phydev, extts);
 
 	nxp_c45_gpio_config(priv, pin, GPIO_EXTTS_OUT_CFG);
 	priv->extts = true;
@@ -1545,6 +1587,7 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.stats = tja1103_hw_stats,
 	.n_stats = ARRAY_SIZE(tja1103_hw_stats),
 	.ptp_clk_period = PTP_CLK_PERIOD_100BT1,
+	.ext_ts_both_edges = false,
 	.counters_enable = tja1103_counters_enable,
 	.ptp_init = tja1103_ptp_init,
 	.ptp_enable = tja1103_ptp_enable,
@@ -1640,6 +1683,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 	.stats = tja1120_hw_stats,
 	.n_stats = ARRAY_SIZE(tja1120_hw_stats),
 	.ptp_clk_period = PTP_CLK_PERIOD_1000BT1,
+	.ext_ts_both_edges = true,
 	.counters_enable = tja1120_counters_enable,
 	.ptp_init = tja1120_ptp_init,
 	.ptp_enable = tja1120_ptp_enable,
-- 
2.34.1

