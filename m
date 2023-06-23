Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5573B1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjFWHmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjFWHmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:42:21 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784022955;
        Fri, 23 Jun 2023 00:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8LKSGx3QivaPJc27yciD08whPwfLAJroFrXDJjw+esk6sorGQ/11iwuS9IC8BrMxZyYWbkRc6nhPveU4RqNUxjFFHViG6r/nOHu2+ADOVwzQlMqPh1UhJjt7n4gRqMyQOEbO11IwYtAAP+tN3WHr75Gu7wldEbpWu0OkKapnzEFrCsthfkzo+e1BhYyc+Dr+TKPBqEbJBYAJ2XAW5tptm5RccgSXSNyvZa1WcseF43SZfAeScoRAW6ds+pbMbCTZokGjpUsDOs9GC/eLlbsHBcOE7eCgViyNOracc18zaCXORvnv+XprCWAFNx5oduE5ZWNc/5dPbGy6qMCcSR/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRKdQk4T78qqn0zSrv3cwexxZjrW5PhNRfs/03xKwEw=;
 b=iDSrWXSqaZ4B29dy0Er4Pt8Rrz77C/mdDwPj0IRdahjdvpyyAEhpMCuBxlF3XujVMoS8oPcKHONEjQIpeFmX450LTBvG1T+mINXuIdKy/9kquRmnJWEvNzz+mO/54mrrW2AISZ1WQi8e3fs7xImndJ7RTiGL6lj1ACSrEWMHpZTSw3ZhLj9/6hmOQPWu4F3NisiWMdyi6+8tuPA91HVUI3ZPl87QXGVSSyhTdOL47C+VU4uJSnl9GcqCUaoUyzHpdoQ5la2kkx6a1LstEujLz+x4TS7POj8Z5MWRJwdqIYkaz6Pj30GqbnC+lIZXrXR1g4Y26MQoWKKJsH/O5lOq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRKdQk4T78qqn0zSrv3cwexxZjrW5PhNRfs/03xKwEw=;
 b=QzKjiDFTQTMLr1okAuu2IvAv4oRMjYlzsWv3rfgIPyFTkjMl/EaIGHsDp5tYphZuJ5M6udXqtyppys3TtaNZx6dlYdU+YWF4YtF1Tgu/QrS3IERPfqdmZZQFP/1uAKv+IVnHcMmjueKf+In0xcF7QtgiUvczvdxNprdYDKwQSzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:41:45 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:45 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 08/13] net: phy: nxp-c45-tja11xx: enable LTC sampling on both ext_ts edges
Date:   Fri, 23 Jun 2023 10:41:18 +0300
Message-Id: <20230623074123.152931-9-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f24513a-3a7a-45d2-21ba-08db73bd4b92
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6w5IUChpzoN3ik1uLrEbzwl5vkL2QU8GJAY68lOOqTzAoNSxBxGW4KU8FMrF6f6gnH3VijJlqldkCQ25z6QUzGxkslWRQ8hmsvphg/O6Fn52KY8/wn2QDm/sFgBNpKxdHc9t7OLCBqpGoSrkKZgAs5BSTGO6Ub72IfIwpHiH0TGMP/PWGRgc5ZAn4kuBchTjLmSK7VkLDaem+p6BhW8wCJWRpKw6s4y1s03SsnJKB/SEA6tdxZ28Xu1eRgXZh5xgwM11CpiCIPG92zJfHg++zTGZDjw0UdAm1CWLzYnWccdDkk8968HR555N0er0ypdWuVIzxEj52bADGf0EV8x0NS4wRBBtD11Xv3eXJdVcxjtcgKsdWr9+P7efkGMZ/jD/zoUqHmpDn5jooVwa8FRfsB4AI/Lg7U5hkQE4eamTAUe+JyXLAe+aJ0BKD+wnQwhQwe31OtHpIENIdZMWutxCOgaUl9Sd/PEM/er/lJwSN9iebG1qGZ13O9PFH1b7b1mOvKZWqHtqzFsqKZ3xuT1M0lI+UYJRyn00r92+uljmXd9M1CcK6ShAbmcUggauzFDIZVTJixJNY913C5tOFKZA7EM07f+QwQrzeLAtX4ojekLJlLE9tg0Rj2u+ustEPNe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(8936002)(8676002)(5660300002)(7416002)(38350700002)(38100700002)(2906002)(478600001)(6486002)(186003)(6666004)(2616005)(86362001)(52116002)(66476007)(6512007)(1076003)(66556008)(66946007)(83380400001)(26005)(6506007)(316002)(41300700001)(4326008)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0e1L6SbjcK+LiJVCvPao1WRg9ErcZjNiujXDcOK9CYO/+pDsCIKhnSgbbXR5?=
 =?us-ascii?Q?ItY+D/LRmc5TCT5suFSJdYgHC9EuZdmN7e56WerESElgVSwyrD3piSNidQ+m?=
 =?us-ascii?Q?ggf39VMZIjVDIXOMTY8HjilNuP7DsMfEFQk+7y9PUTrsUWv5Ys2L+PFGaWOO?=
 =?us-ascii?Q?FLr6bPOpCHVFkNkPGv5AV/lGMdYQXEJkba9fAVUiiPNGdjGPU//+n51v5lzU?=
 =?us-ascii?Q?w0aRnJ1xH2+uBRqTpjDCvaM39mfJa3PIqBBoeXgdV4xMOEERCi0YgA6dzTQj?=
 =?us-ascii?Q?8eUGNLozpfqiTbR3qEMez5+sumKEl4Ex+glvvPsBJiyLyDPPeJ70s1Pw//Nx?=
 =?us-ascii?Q?ST/zRICiPzOwHjjpTOippEjdYqyXwRyXNBw4xLZwhV4BIjd/m+rcs4T2IjQI?=
 =?us-ascii?Q?B2LQRyep7CT8qTZbzcKywnCEbpucWxew2IbyGTLLQytD/O5EpSV8pyPvkRiB?=
 =?us-ascii?Q?wQEHtlYCL1/L3iaCtu+tvtqZSLM9JmLmVMLPnHwBDov4igcEZAKjsI7SKmpy?=
 =?us-ascii?Q?AHX+WPPvV8L2/YdOitIP/wryVMD8JzT/OWXevy9KQFq/uvEMeet8n5kSRP7J?=
 =?us-ascii?Q?IYKA2tm657TWRhafWsAhTSSdbkLgZYHHfhJX1P4yzBPaMz61zgSZPPuFoZxj?=
 =?us-ascii?Q?WOw4yjNo1Z1aTGEHySKmfyqlWV1usCzArQRewoNFqkSGEHeXjue4+6nZcfqj?=
 =?us-ascii?Q?NRdgTxaX+CoerB5A+cI2qWPHvyNf5QyRXsSm1V4+o2e87CRA1U6j89LS3+qm?=
 =?us-ascii?Q?7X32mFHx7qYuo52U7gReFKDgxiux/pdvZApJEcUpDUADjjS9PtD1ry6B8fp+?=
 =?us-ascii?Q?YEbQAxvfv1N+j3ilob/F9pIl9ZTO7cph9Q132/IhmifDpnzdi5ufGc/DuQ8h?=
 =?us-ascii?Q?2MqqYrL/HrVX1da5bl+tRcOc//D70uela4DYC4jTWqpQe7aiwsBZona0Y0aS?=
 =?us-ascii?Q?qLmRgqBF18KUuDxg0K3zzA+kC+uoBFsm6YsGJ5nBp3wlO0L++h8iOXq2BJ8c?=
 =?us-ascii?Q?1/HCBt8LfTG1o5Jik3K/ApAxammiYo29E9cRaApIw+EJz0r3BOgOF+Diw0rv?=
 =?us-ascii?Q?henDofFtvzwDe+Tuv3L010wbCoTdx7G3NqRPDpUVbf9hykiW2G5Sr3kmfR8w?=
 =?us-ascii?Q?Zc0LWs7D1qZkuHbzAwcrxuV1DKb6BBS/zCrMhU0evnVr5EOji2Lugt457+Vx?=
 =?us-ascii?Q?AFyUjopDnNks3Bmv82PyPNAolSH5mqD9HKUgSPtqkZyPC45UuKZkP6V8CzCW?=
 =?us-ascii?Q?/JVtWQRPlviMWxD0dBjWcDRYo5pBdXx+MzZzp8fe34TuSNrBVkBmuVn2k7DY?=
 =?us-ascii?Q?S3/dw1bNm+pNOHVRuNVb8YQ6EM33I2wbJoW9W+02z7WJCui12bbGsdVuv7vo?=
 =?us-ascii?Q?Ih3qgji8I+Xxwyyhr1iacvljyalwq4M+QCmEiVpoNGZNUn8F67VZ5IH3HxCF?=
 =?us-ascii?Q?Iq03UV3eEzvWDmEx/SHXoCTz1RAAgPvO4wyp6ixaQxQ7VgcxCTd/AGggaIct?=
 =?us-ascii?Q?tgyzbXzP9neYItU9/WcT1BtEgyJfDeiD0qmo+PmDlU+lU3HTbUvxOUOtLeJV?=
 =?us-ascii?Q?va/0O8rs0TK/bGB9oJqb0G+uaEnJlTjub3Lw13jb35JYgse36Ohf6Tnv5wXq?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f24513a-3a7a-45d2-21ba-08db73bd4b92
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:45.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4G5NLpJgTawoM10tifBCxZ0ud3ZnPeEFQjS0Tg97EhjSvGN8RQPEW1m/nSwN0osrgoAYFp7qmIGUwsh7ADsIXDNxvKXvg3tjrpVS7FCEWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external trigger configuration for TJA1120 has changed. The PHY
supports sampling of the LTC on rising and on falling edge.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
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

