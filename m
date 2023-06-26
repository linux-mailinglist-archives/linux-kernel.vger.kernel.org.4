Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106E73E39A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjFZPkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjFZPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:40:28 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EC710EB;
        Mon, 26 Jun 2023 08:40:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N88pso2D64hQdYydGEfpAp51Cf5mRoB3QBrg7jvLPPnRrWq78fEx0pWWNkhAoJTD5rPC0A4Kl6Ytej/Crue0B4qEEOw+u8HlcNZ3foMZgbj02ywvJvueog3qVGp5lhBQA5s7w9F36u8lrjfLCZEXD74Lk7b7JBAFUXcIG0I3H3eSfrbK5N+ZKfXLFPgCRbEqDrPfzHxgsJ+HavdtdfYmTaoMlLHw9V8ujpqiSXaUrbE+ru4/lhu6CWGTxo9OXICf0KyUljQgUDQSOo7m4/DVmEzCKULR7MhwYosn/47Pq+aTqIb3euYrWjcpaeQa5meeYzZsdY4/FKZBTDV0MPS7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzhDS9MgucPLdgQLjeJIB8Z0zSy5jUZ951m8iaO983E=;
 b=a1YbR8Pusmzyhw+lRdnDkiFHLeEVoyP1UDtRBu8zhmtM3ucekmwNFgvjXUp7BKSuz5En6PeQzVGG9n8GPZWMbuG3rW0FOBwd+s1fYDzZcIM0dSbcs9t3imrCbTghTEirpm6350jzmD5Jk5AqiB7WzuENCZAOUBgSQid0+Pia5cO+Q67mE9wYG8uRq/0EalzSQgIbo1I1M3dliXEFK2zJwrw+K7xrpFhQMU/bNr6mj+9dF9J6VmJ79iVTxB+UKkvQrj0j7Ia7BDnYfeDdd8Tzjjlee2WsgYKhsOviv7pTLBNkfRfzeufloEiF7Y1Xnvv2/eRH02F1JxSsQe4vE1HMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzhDS9MgucPLdgQLjeJIB8Z0zSy5jUZ951m8iaO983E=;
 b=ay/E/BwxvZSndReK7wVKemzBVjhGN0+QGIjy2QwlRMw1/06BPmsJMTIED5Z9FjMXNwGut3fNhpJHXItqdME+Dk6f8HMPkGAtapPKvYHcdcisZy9RZkQPL8zVjoGE5W+jrdk4TVWGUADPiy236UAhijAZXrw4VZTDJ0BiUjFFE4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 15:40:21 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 15:40:21 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: mscc: ocelot: don't keep PTP configuration of all ports in single structure
Date:   Mon, 26 Jun 2023 18:40:02 +0300
Message-Id: <20230626154003.3153076-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
References: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0121.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::38) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b56fe4-efcc-43b4-336c-08db765ba6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QiCMmlHZfzRhsbvg4Ei5zrOonRuS8ntOQQu//l2ieU284WboKDUdNOMQPNPnBO2RjEPykOiciZFn9KO1NsQocdOX5/GTciCm5ixH022pvi0a+0UVfUi5YjZAGaX2fc5upHLJ+KCau+yJX58T+uvRbDQ5ZxwmkaNXkBouDleC3pOOitW5zuBpnvFjnu7fnpU1Cuc5J8HcyvLk1m2GcUOX2d7OhfGXlsYDUMqWgMUATt4Nkl5J6yvZskg/6Lp/+RNlWOOe4XGrhGv/BGNzEUFaftTJDi6eNzqZW4Evy/tVeJ7sLBmUnPIyS4Hi0hVQAU/bRh4yS7DXD9I6bXaF/4YUGgjwQz5BVYO+iGqTgUAMOrkbKwk9V5JKuPnDw+0r7OgtoXmAhRW8orxfmKQJI5VMjPfLH0gByrKlX7EEoR876fjfRwm78TMaHo79CAO5VOhmMoVac66FmDXvpIzq3KbCcI/IgLH+SZEG3fJKNAdu2F8wIFymshridGeKTPlRHmtqjsiig9P9xNkTnKxbDadFQZ6a3ybKLF8MktOomKHZZQ2kxzoGrpZ7cgy+LNv7UVBFiJjBISi2EJvQGc2wMK6Hoip9jl7eqm8utQI1G7JnbRzbpFC6UID2AOZMYq7HRUKj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(8676002)(66946007)(41300700001)(66476007)(316002)(66556008)(8936002)(4326008)(26005)(1076003)(6506007)(6512007)(186003)(6916009)(2616005)(54906003)(478600001)(6486002)(6666004)(52116002)(2906002)(5660300002)(7416002)(44832011)(38100700002)(38350700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2gOytV5RTrf4qVKP/Wo51FIfbyOvNJngHtfvDzqW5P5RZgJj9ZYl0+t1fZOY?=
 =?us-ascii?Q?TaZxB8EuIbOFe6MLciKyzoDyv0ELHV4zW4XLz/z4hT2QX6uwzBOUhMzWpbIr?=
 =?us-ascii?Q?pUSTsvlyYzGMcAPa3IJ2Wlz2dwkVonUKfVY6dLlKLjaHEjPRELQbULFa6koc?=
 =?us-ascii?Q?7WGEDAJ4U2GB49so3vxDruB8EZkCVatoUjXAJrmMpuxSLU5VpIH44N+ZAI44?=
 =?us-ascii?Q?DpPj8XxcatbbRrzILVgLX5KgTE7A1OiIAr/RUk/SzG4z4yIut6TirfmxiWi3?=
 =?us-ascii?Q?cWD7OYtoVuulr8f0PrJ0RywwJr1Hx+ULjFE5ISZrF1FkKwU5CGTyBAyzuGXp?=
 =?us-ascii?Q?cZ0i5EYEGFLVEbS3Fn90wAwZJMbqDJYsASmIu9IL1nwiUGuO6JL6k0HBXex8?=
 =?us-ascii?Q?rHsHngXAC3mRZayuHmBD+91HUHdHSworf2vOWVTvjz2Fv/hVzdsSuKaSujxe?=
 =?us-ascii?Q?Pgxwg9jxGSXJxjlFtQFMa5HGCVe3BOAHfXtPVKSWNNrE2tZy5tFRbApzCBkJ?=
 =?us-ascii?Q?bUU5OuyERtel09tFVBN1HykP5MDf5Wa//AVV9B2hbjrYHk8W5LLRP2qB2+QF?=
 =?us-ascii?Q?X8447aNe0IibbRWqhZRZT4HAyphu17zioiRwmT3ZgGiOSyd4PWC/tIXb4hZ7?=
 =?us-ascii?Q?6luQ1jQdo4miWATLpAxCNfQJzpgbeO5ZxOIJmM3UZoNqBLYNAbF+qXPy25iV?=
 =?us-ascii?Q?VQ8Dh86LIGV7W8JzPlWK7mt9G4jSmP8O3YplUV8sjAETq/6fCgt3S1Nefd2Z?=
 =?us-ascii?Q?C4UErjASQhOwlPbkCXa0q9Fr1mtKJ5Tb1YJ2l9y1XdyGc8ByKC/HQlTDmDlI?=
 =?us-ascii?Q?y/fcYeCgmNigfMeHQK8lg4GEOAMxilIvvYTBIxwQvfUHhXNEwXNiAMBN6JnW?=
 =?us-ascii?Q?EtO5GRzsS2TNrVfs/u9BnffEeWRa3R3UfFar+VwhMQGTXlFoAQwRC+tcq8FX?=
 =?us-ascii?Q?1Ty3BH2zWspn13uRCWwvbjXZTNyOh/OkZw+lT3PxjTDKsvUHCz69fRgVcGZa?=
 =?us-ascii?Q?QfQEwVsbJpEBbMUfEsxNXuXwwUwyxaPTBTTSGAOSU8nlk6tfI9/Xq3vBgIhN?=
 =?us-ascii?Q?9cgfaia2wrloF7VYK4/OVtmMXnoXMg5D5+jC2dIChz0ahne5/BgfeE+E3v7X?=
 =?us-ascii?Q?gYVgGBCtFCfzEhf8FNGvhjsLUnU/AemHF0+YCl7fmNBoJnKqtREMCW7biW4C?=
 =?us-ascii?Q?14kTN8GF94glS86u7aubfCO5I7hqyA6CqBcapTe21m1USX6h+Sa6rLehPn3o?=
 =?us-ascii?Q?tv3Ywz8s1qUmQYqS1po1gSSX3Mef2ldivDUYyt8KfomcjT2IRchIl47W/P/Y?=
 =?us-ascii?Q?h2Yn9b8oauDLuMt2MpfopmTV2AssaBWz8K0cs4W6b1rdryBT4gProajaXH3y?=
 =?us-ascii?Q?+m7bKWoxhMnscTk6srEU6JRypQXbVv2fDwuu4n+vD+D1Dy/HltSg6qugUBJL?=
 =?us-ascii?Q?yRE26VvnTgb2kAkS/XJH4Ggj5mlYR1sZXltU9a96Ivbwfce89spboRtdqhoT?=
 =?us-ascii?Q?rGTCI0phvSXKmRJLCc+lThWNe3unOqLdiF1yTtN5xEob1G3c+LDqrOFhvfWw?=
 =?us-ascii?Q?MCir85xL7tsgdo0u4B4LjkKHnAaW3oZz/fEAlxD5yf1OluoQhYqmpaWqKnrg?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b56fe4-efcc-43b4-336c-08db765ba6d6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:40:21.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFAFu+MyB9awBcSvw4F1MEPDGMg4yNAhkvboF1PEMsp8ZYITGfk1Q2MJDbwQs1fC75vBhMIT+t4SuZPu4h3y1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future change, the driver will need to determine whether PTP RX
timestamping is enabled on a port (including whether traps were set up
on that port in particular) and that is currently not possible.

The driver supports different RX filters (L2, L4) and kinds of TX
timestamping (one-step, two-step) on its ports, but it saves all
configuration in a single struct hwtstamp_config that is global to the
switch. So, the latest timestamping configuration on one port
(including a request to disable timestamping) affects what gets reported
for all ports, even though the configuration itself is still individual
to each port.

The port timestamping configurations are only coupled because of the
common structure, so replace the hwtstamp_config with a ptp_rx_filter
saved per port. We also have the ptp_cmd to distinguish between one-step
and two-step PTP timestamping, so with those 2 bits of information we
can fully reconstruct a descriptive struct hwtstamp_config for each
port, during the SIOCGHWTSTAMP ioctl.

Fixes: 4e3b0468e6d7 ("net: mscc: PTP Hardware Clock (PHC) support")
Fixes: 96ca08c05838 ("net: mscc: ocelot: set up traps for PTP packets")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot.c     |  1 -
 drivers/net/ethernet/mscc/ocelot_ptp.c | 30 +++++++++++++++++---------
 include/soc/mscc/ocelot.h              |  5 ++---
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 1f5f00b30441..2fa833d041ba 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -2925,7 +2925,6 @@ int ocelot_init(struct ocelot *ocelot)
 		}
 	}
 
-	mutex_init(&ocelot->ptp_lock);
 	mutex_init(&ocelot->mact_lock);
 	mutex_init(&ocelot->fwd_domain_lock);
 	mutex_init(&ocelot->tas_lock);
diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index 673bfd70867a..d37637744bd3 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -476,8 +476,24 @@ static int ocelot_setup_ptp_traps(struct ocelot *ocelot, int port,
 
 int ocelot_hwstamp_get(struct ocelot *ocelot, int port, struct ifreq *ifr)
 {
-	return copy_to_user(ifr->ifr_data, &ocelot->hwtstamp_config,
-			    sizeof(ocelot->hwtstamp_config)) ? -EFAULT : 0;
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	struct hwtstamp_config cfg = {};
+
+	switch (ocelot_port->ptp_cmd) {
+	case IFH_REW_OP_TWO_STEP_PTP:
+		cfg.tx_type = HWTSTAMP_TX_ON;
+		break;
+	case IFH_REW_OP_ORIGIN_PTP:
+		cfg.tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
+		break;
+	default:
+		cfg.tx_type = HWTSTAMP_TX_OFF;
+		break;
+	}
+
+	cfg.rx_filter = ocelot_port->ptp_rx_filter;
+
+	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
 EXPORT_SYMBOL(ocelot_hwstamp_get);
 
@@ -509,8 +525,6 @@ int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	mutex_lock(&ocelot->ptp_lock);
-
 	switch (cfg.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
@@ -531,15 +545,12 @@ int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 		l4 = true;
 		break;
 	default:
-		mutex_unlock(&ocelot->ptp_lock);
 		return -ERANGE;
 	}
 
 	err = ocelot_setup_ptp_traps(ocelot, port, l2, l4);
-	if (err) {
-		mutex_unlock(&ocelot->ptp_lock);
+	if (err)
 		return err;
-	}
 
 	if (l2 && l4)
 		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
@@ -551,8 +562,7 @@ int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 		cfg.rx_filter = HWTSTAMP_FILTER_NONE;
 
 	/* Commit back the result & save it */
-	memcpy(&ocelot->hwtstamp_config, &cfg, sizeof(cfg));
-	mutex_unlock(&ocelot->ptp_lock);
+	ocelot_port->ptp_rx_filter = cfg.rx_filter;
 
 	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index cb8fbb241879..8fc6a07ab966 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -775,6 +775,8 @@ struct ocelot_port {
 	unsigned int			ptp_skbs_in_flight;
 	struct sk_buff_head		tx_skbs;
 
+	int				ptp_rx_filter;
+
 	u16				mrp_ring_id;
 
 	u8				ptp_cmd;
@@ -868,12 +870,9 @@ struct ocelot {
 	u8				mm_supported:1;
 	struct ptp_clock		*ptp_clock;
 	struct ptp_clock_info		ptp_info;
-	struct hwtstamp_config		hwtstamp_config;
 	unsigned int			ptp_skbs_in_flight;
 	/* Protects the 2-step TX timestamp ID logic */
 	spinlock_t			ts_id_lock;
-	/* Protects the PTP interface state */
-	struct mutex			ptp_lock;
 	/* Protects the PTP clock */
 	spinlock_t			ptp_clock_lock;
 	struct ptp_pin_desc		ptp_pins[OCELOT_PTP_PINS_NUM];
-- 
2.34.1

