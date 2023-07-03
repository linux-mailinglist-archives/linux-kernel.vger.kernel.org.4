Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B777465A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 00:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjGCWGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjGCWG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:06:28 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807A9E6A;
        Mon,  3 Jul 2023 15:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLYR6AL51cX4irynb0eUvn3Dtpisie2SoZETqpBWnnKVXyOzj+UhN8KYZ3+no8hVZKlzwIBpZL3BMEnljJcdjtok5TIC4QT+p9L4Ht9BCgvPipAWr5NKlSrRBjzAs9EJKx6QHOyNVza60aZkLnGQ1cPwrYNw9/YEUYwEP/dtx+E+ppeb0zD7MQDBWz87lO34sSNOmyfAFOzYQOks0TuITGu6VnziLCsq9x4yfX/9XyZZbb1JHPbkI8ckmebzFWbOAybu+kPekjocuQCGmyA47CtKYwXT4f4prBB672jYeFkrhL7YRcyrpUbQILI96VICxl9m+HgkDlvpXTiuFblAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvdBRoskhxA2eMwk6tr7e5DzME9uGaZvHmSipKZnDwY=;
 b=hLZFK3gJhe31X82f9sfOF5DZc3A8VB8w9ck7BbU5NKIce5QXjDdrluJ3x3xirgKv/uLVhin2/pjKhQkZuoTdHuapSHovDuje58YbEaw+UJiZRHCaqdb0cmIgjDhxKGBTI44N9mFF5Av+/HS/uPboH09E8jdDnfmwkZoy1T1wUgHPm8KyCcOTr/hwf4R30+j5wy8ksGL60kguDZZ3zmCoJGI5NFSu/7N26g0jqR8oRk8egVfYaufFadN2ZOl6r/VHHaaVLJDuevWQvFx4xYDvktAW3YW97SjzLlQtTBh/ewxPIfLWTOzvEX3lZ9hI/MP5WGbiohC+AJeULZeQU9PVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvdBRoskhxA2eMwk6tr7e5DzME9uGaZvHmSipKZnDwY=;
 b=hwVejBV+dbROHreFvsSP6N/VvFV8t89RtStkUFPlmQCvKDEPX4nNesiOY+xYeWcD2zWiJYv2gvQ4zlwwZFJz86A018JKrmD0Fej02NBGxFVJfzEOvjm0qWgVcMJpv+cJQWxwsmu3naGyLHqzKcylZ9NtJdvRhyBlneUmrcEyEWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 22:06:13 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 22:06:13 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v2 net 2/2] net: dsa: sja1105: always enable the send_meta options
Date:   Tue,  4 Jul 2023 01:05:45 +0300
Message-Id: <20230703220545.3172891-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703220545.3172891-1-vladimir.oltean@nxp.com>
References: <20230703220545.3172891-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0152.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::45) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: c725d43b-c2d6-4a83-5a99-08db7c11b6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANcJWHRfORnzt/yfpD6C6FTL08J+B3jg5b5mmVOz88vjGVFNULYvgrJn5TMg7ziwv+sELPtdRy5f3bsHaVPoX3dBYTUx4LjPiA3BxUXzNC8UsXHAYQzQ3bL/1MgEtg0EshbZcSZq0TMYkgYeYKDdClPo1m2K6aQP0I+126qXsZSOaLvNDfWjZ6Mg+WxloJoqXLYkePE22r9zjn85s/bMka0r4WeAEqCUx4CcmwCJUYMYimH0ZsLY5IhN+Vsu5/yRbDQRB0xhJ7kkQ5JmrX/khjD4edlJdF1dvvydFs8HP7wzaogUV+jH191BYx1h4AvdgNTidE+8IRhUvRboYRLiG+UZEJV9rQTMsvD3fd2hlhANXTeII51puPcvNtlok8K5rdCSNtvlSAdMkCO91Q0wJV6KZbsdhN5bSCQurY51fPeuhuqV4SI+LU7ZIbZor/KKWAnJoO4rLitSRIllJd7L6Samv1HX/GLwOr8nbxQM01ynozS2mwKEa0dLozqX0LTHerM1q95c3WYOXPyIQ69J9FSNp3ZQ/nAQI6wdgwJQjYQrb+mXZDIlKcTU8Wp2mcZjjdXs921S1XBfHZGDFkJNqokm/nXTY3LQHMohCMDW/pzV0BCh+Sr7OzPvQphXO4XP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(30864003)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(7416002)(36756003)(86362001)(186003)(2616005)(478600001)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(52116002)(316002)(6916009)(66476007)(4326008)(66946007)(66556008)(38350700002)(38100700002)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mkfFBAFqwcc1bZsAphx5kWswT4aTSDs0fHbtmHGtRpv5crM1tiRSf6BPBYRS?=
 =?us-ascii?Q?gsYnCeJkl+BNe7u6wozcTwS6rBeYrN9cAos0tN9nJC/y/ay9RbkLs+lxR2bC?=
 =?us-ascii?Q?ZOoCVCdgXV+HUg4UgmmvARjhOJpeM/cuWTnDSgK6e9U6hK4CQ4TlJrQeITab?=
 =?us-ascii?Q?Xpj9uCJ4l7iJsnnSxRyh3iN+EJEPN5J1pa7XnrWcU/Ff0rEwLexs0HxfsKAJ?=
 =?us-ascii?Q?wTYGZNjnfoD0DCwwnjzebmYeT0eV+mCz0x4KsMrHBk2Cxy8rBG4uXCOOe/vt?=
 =?us-ascii?Q?ckqEIDprhiORCMVyHSAKGLqk7fqlnGtUUok/Ke3YXZDg1xqEd5phA5P22z1I?=
 =?us-ascii?Q?CDu/Htb0zqAAEjLoE6DDrEEG5jM73z2k3FWN6YvFBblj1l88Ov6056HaX/xa?=
 =?us-ascii?Q?WIiC/o7M/I5FpT9C6b/3twWSKLp1OhQ8Cy3XvtFCz04BJbnaJ38oX8Qbk9Fg?=
 =?us-ascii?Q?yLq5TTdeBnZ5wIVCFADI8gkhtF7EuEeIK3K2Byu/Vy1AL+oUbqqjx+6mF+ZI?=
 =?us-ascii?Q?owEnz9H9VPSkdqdJEinQOOsycRDLEvOvxbZM5sFuIr0b8ZMX2MXVa7Zg8SVs?=
 =?us-ascii?Q?W8KethDvZmyRpYHWlFwmfqiiXjDVDF+yp7pldxfUF+bJt3ukNoA4pbPzLZHV?=
 =?us-ascii?Q?IXsTHRHTIt+ytNde91UCK0mZZKdzqi3415tRjtcRLQYbX55v13mPEy8f/qDp?=
 =?us-ascii?Q?kdfDKCNUYzpeZ3tmw9sghtNvqhAk133OnymPGKgGqypsIvkOqQLy/mxv58qg?=
 =?us-ascii?Q?R5mIap6TVjDmNqrVWCg4BKrlr+lJwBoejvqsnIw/H5HzgRmyMpni4wKJ6kVd?=
 =?us-ascii?Q?pufNFwS6ck1wyLd4FxXaoQQoC3BJCFSHvf0R1N5UzCttuutzrZRJ9scIKFig?=
 =?us-ascii?Q?xlxpbdxGEGxdWexdCBi3pdkTiomtF8rM+dzJclODOKi8WUDjdmn0smavgPmd?=
 =?us-ascii?Q?IjI3c0UEX1nFKcW73T9GxgxjaHkg6IQk7v7w+08gTAxNRE+uU5ftGDrvfJmG?=
 =?us-ascii?Q?YuBJBV68FCDatOAnyG4vfQ/tvlohR/BF4+qvF+Qa9ja4TiICYixnpaWYhdr8?=
 =?us-ascii?Q?+aegl65dQouKmelsbuGKzxs+4q4evmtKc40q4J6l+W+j0JQBSfd4RgtqCy+2?=
 =?us-ascii?Q?kJZPy923eSI/7V2/ZR7DriV57bMinaMppViNC4S7gcppbVuYyob+b2BIfVdC?=
 =?us-ascii?Q?m58ZU1Q2HiiI9HwYLSvigbvizPnJAvHjmTKU+GFh8J8iSWOom+taXbO2LkEY?=
 =?us-ascii?Q?+4ZtO4aulSN9axZNHpO54OOxC4S+42UGBmX4YM/WJW5rS8+erg1wZZN4TLjC?=
 =?us-ascii?Q?0AvVW/K+KBqTZ0zsvehQr8x+5bELHm9tcHJiLGGgD1FpNrDPidU92d9ytjlG?=
 =?us-ascii?Q?0WM837XVSCIzEBGiNHDelpid9Q9jCc4CSuDG75yBFhCD8TCzrekRC+0gEdT4?=
 =?us-ascii?Q?HcaTWEwZ8t+N14i89OFChrHXA7z+J5rZONCySS69cIloyCZfix6knDNG9XuB?=
 =?us-ascii?Q?9ugsyqctiRrj+hmRrPK5bR8jvu+DBaI3X4E2nNM0j1STQhJ4FSYWO37lfISx?=
 =?us-ascii?Q?ixPVVlPFaV+HumOb3+tT0fDEuZVOoWP2U4nJV4aXdoczKGPxs4d/Uomlms0B?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c725d43b-c2d6-4a83-5a99-08db7c11b6e3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 22:06:12.9450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPmMJ/igoBAEazy8wlGacf6SJvIpJyDsi0YdzEAiBGCvRu+0Zo+SAHgmZLGAZbY7Iq739sEHxn88lnBtxHHzVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

incl_srcpt has the limitation, mentioned in commit b4638af8885a ("net:
dsa: sja1105: always enable the INCL_SRCPT option"), that frames with a
MAC DA of 01:80:c2:xx:yy:zz will be received as 01:80:c2:00:00:zz unless
PTP RX timestamping is enabled.

The incl_srcpt option was initially unconditionally enabled, then that
changed with commit 42824463d38d ("net: dsa: sja1105: Limit use of
incl_srcpt to bridge+vlan mode"), then again with b4638af8885a ("net:
dsa: sja1105: always enable the INCL_SRCPT option"). Bottom line is that
it now needs to be always enabled, otherwise the driver does not have a
reliable source of information regarding source_port and switch_id for
link-local traffic (tag_8021q VLANs may be imprecise since now they
identify an entire bridging domain when ports are not standalone).

If we accept that PTP RX timestamping (and therefore, meta frame
generation) is always enabled in hardware, then that limitation could be
avoided and packets with any MAC DA can be properly received, because
meta frames do contain the original bytes from the MAC DA of their
associated link-local packet.

This change enables meta frame generation unconditionally, which also
has the nice side effects of simplifying the switch control path
(a switch reset is no longer required on hwtstamping settings change)
and the tagger data path (it no longer needs to be informed whether to
expect meta frames or not - it always does).

Fixes: 227d07a07ef1 ("net: dsa: sja1105: Add support for traffic through standalone ports")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v1->v2: regenerated slightly different patch context

 drivers/net/dsa/sja1105/sja1105.h      |  2 +-
 drivers/net/dsa/sja1105/sja1105_main.c |  5 ++-
 drivers/net/dsa/sja1105/sja1105_ptp.c  | 48 +++-----------------------
 include/linux/dsa/sja1105.h            |  4 ---
 net/dsa/tag_sja1105.c                  | 45 ------------------------
 5 files changed, 7 insertions(+), 97 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index fb1549a5fe32..dee35ba924ad 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -252,6 +252,7 @@ struct sja1105_private {
 	unsigned long ucast_egress_floods;
 	unsigned long bcast_egress_floods;
 	unsigned long hwts_tx_en;
+	unsigned long hwts_rx_en;
 	const struct sja1105_info *info;
 	size_t max_xfer_len;
 	struct spi_device *spidev;
@@ -289,7 +290,6 @@ struct sja1105_spi_message {
 /* From sja1105_main.c */
 enum sja1105_reset_reason {
 	SJA1105_VLAN_FILTERING = 0,
-	SJA1105_RX_HWTSTAMPING,
 	SJA1105_AGEING_TIME,
 	SJA1105_SCHEDULING,
 	SJA1105_BEST_EFFORT_POLICING,
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index dd154b2b9680..3529a565b4aa 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -867,11 +867,11 @@ static int sja1105_init_general_params(struct sja1105_private *priv)
 		.mac_fltres1 = SJA1105_LINKLOCAL_FILTER_A,
 		.mac_flt1    = SJA1105_LINKLOCAL_FILTER_A_MASK,
 		.incl_srcpt1 = true,
-		.send_meta1  = false,
+		.send_meta1  = true,
 		.mac_fltres0 = SJA1105_LINKLOCAL_FILTER_B,
 		.mac_flt0    = SJA1105_LINKLOCAL_FILTER_B_MASK,
 		.incl_srcpt0 = true,
-		.send_meta0  = false,
+		.send_meta0  = true,
 		/* Default to an invalid value */
 		.mirr_port = priv->ds->num_ports,
 		/* No TTEthernet */
@@ -2215,7 +2215,6 @@ static int sja1105_reload_cbs(struct sja1105_private *priv)
 
 static const char * const sja1105_reset_reasons[] = {
 	[SJA1105_VLAN_FILTERING] = "VLAN filtering",
-	[SJA1105_RX_HWTSTAMPING] = "RX timestamping",
 	[SJA1105_AGEING_TIME] = "Ageing time",
 	[SJA1105_SCHEDULING] = "Time-aware scheduling",
 	[SJA1105_BEST_EFFORT_POLICING] = "Best-effort policing",
diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
index 30fb2cc40164..a7d41e781398 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.c
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
@@ -58,35 +58,10 @@ enum sja1105_ptp_clk_mode {
 #define ptp_data_to_sja1105(d) \
 		container_of((d), struct sja1105_private, ptp_data)
 
-/* Must be called only while the RX timestamping state of the tagger
- * is turned off
- */
-static int sja1105_change_rxtstamping(struct sja1105_private *priv,
-				      bool on)
-{
-	struct sja1105_ptp_data *ptp_data = &priv->ptp_data;
-	struct sja1105_general_params_entry *general_params;
-	struct sja1105_table *table;
-
-	table = &priv->static_config.tables[BLK_IDX_GENERAL_PARAMS];
-	general_params = table->entries;
-	general_params->send_meta1 = on;
-	general_params->send_meta0 = on;
-
-	ptp_cancel_worker_sync(ptp_data->clock);
-	skb_queue_purge(&ptp_data->skb_txtstamp_queue);
-	skb_queue_purge(&ptp_data->skb_rxtstamp_queue);
-
-	return sja1105_static_config_reload(priv, SJA1105_RX_HWTSTAMPING);
-}
-
 int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 {
-	struct sja1105_tagger_data *tagger_data = sja1105_tagger_data(ds);
 	struct sja1105_private *priv = ds->priv;
 	struct hwtstamp_config config;
-	bool rx_on;
-	int rc;
 
 	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
 		return -EFAULT;
@@ -104,26 +79,13 @@ int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 
 	switch (config.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
-		rx_on = false;
+		priv->hwts_rx_en &= ~BIT(port);
 		break;
 	default:
-		rx_on = true;
+		priv->hwts_rx_en |= BIT(port);
 		break;
 	}
 
-	if (rx_on != tagger_data->rxtstamp_get_state(ds)) {
-		tagger_data->rxtstamp_set_state(ds, false);
-
-		rc = sja1105_change_rxtstamping(priv, rx_on);
-		if (rc < 0) {
-			dev_err(ds->dev,
-				"Failed to change RX timestamping: %d\n", rc);
-			return rc;
-		}
-		if (rx_on)
-			tagger_data->rxtstamp_set_state(ds, true);
-	}
-
 	if (copy_to_user(ifr->ifr_data, &config, sizeof(config)))
 		return -EFAULT;
 	return 0;
@@ -131,7 +93,6 @@ int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 
 int sja1105_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr)
 {
-	struct sja1105_tagger_data *tagger_data = sja1105_tagger_data(ds);
 	struct sja1105_private *priv = ds->priv;
 	struct hwtstamp_config config;
 
@@ -140,7 +101,7 @@ int sja1105_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr)
 		config.tx_type = HWTSTAMP_TX_ON;
 	else
 		config.tx_type = HWTSTAMP_TX_OFF;
-	if (tagger_data->rxtstamp_get_state(ds))
+	if (priv->hwts_rx_en & BIT(port))
 		config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
 	else
 		config.rx_filter = HWTSTAMP_FILTER_NONE;
@@ -413,11 +374,10 @@ static long sja1105_rxtstamp_work(struct ptp_clock_info *ptp)
 
 bool sja1105_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 {
-	struct sja1105_tagger_data *tagger_data = sja1105_tagger_data(ds);
 	struct sja1105_private *priv = ds->priv;
 	struct sja1105_ptp_data *ptp_data = &priv->ptp_data;
 
-	if (!tagger_data->rxtstamp_get_state(ds))
+	if (!(priv->hwts_rx_en & BIT(port)))
 		return false;
 
 	/* We need to read the full PTP clock to reconstruct the Rx
diff --git a/include/linux/dsa/sja1105.h b/include/linux/dsa/sja1105.h
index 159e43171ccc..c177322f793d 100644
--- a/include/linux/dsa/sja1105.h
+++ b/include/linux/dsa/sja1105.h
@@ -48,13 +48,9 @@ struct sja1105_deferred_xmit_work {
 
 /* Global tagger data */
 struct sja1105_tagger_data {
-	/* Tagger to switch */
 	void (*xmit_work_fn)(struct kthread_work *work);
 	void (*meta_tstamp_handler)(struct dsa_switch *ds, int port, u8 ts_id,
 				    enum sja1110_meta_tstamp dir, u64 tstamp);
-	/* Switch to tagger */
-	bool (*rxtstamp_get_state)(struct dsa_switch *ds);
-	void (*rxtstamp_set_state)(struct dsa_switch *ds, bool on);
 };
 
 struct sja1105_skb_cb {
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index ec48165673ed..ade3eeb2f3e6 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -58,11 +58,8 @@
 #define SJA1110_TX_TRAILER_LEN			4
 #define SJA1110_MAX_PADDING_LEN			15
 
-#define SJA1105_HWTS_RX_EN			0
-
 struct sja1105_tagger_private {
 	struct sja1105_tagger_data data; /* Must be first */
-	unsigned long state;
 	/* Protects concurrent access to the meta state machine
 	 * from taggers running on multiple ports on SMP systems
 	 */
@@ -392,10 +389,6 @@ static struct sk_buff
 
 		priv = sja1105_tagger_private(ds);
 
-		if (!test_bit(SJA1105_HWTS_RX_EN, &priv->state))
-			/* Do normal processing. */
-			return skb;
-
 		spin_lock(&priv->meta_lock);
 		/* Was this a link-local frame instead of the meta
 		 * that we were expecting?
@@ -431,12 +424,6 @@ static struct sk_buff
 
 		priv = sja1105_tagger_private(ds);
 
-		/* Drop the meta frame if we're not in the right state
-		 * to process it.
-		 */
-		if (!test_bit(SJA1105_HWTS_RX_EN, &priv->state))
-			return NULL;
-
 		spin_lock(&priv->meta_lock);
 
 		stampable_skb = priv->stampable_skb;
@@ -472,30 +459,6 @@ static struct sk_buff
 	return skb;
 }
 
-static bool sja1105_rxtstamp_get_state(struct dsa_switch *ds)
-{
-	struct sja1105_tagger_private *priv = sja1105_tagger_private(ds);
-
-	return test_bit(SJA1105_HWTS_RX_EN, &priv->state);
-}
-
-static void sja1105_rxtstamp_set_state(struct dsa_switch *ds, bool on)
-{
-	struct sja1105_tagger_private *priv = sja1105_tagger_private(ds);
-
-	if (on)
-		set_bit(SJA1105_HWTS_RX_EN, &priv->state);
-	else
-		clear_bit(SJA1105_HWTS_RX_EN, &priv->state);
-
-	/* Initialize the meta state machine to a known state */
-	if (!priv->stampable_skb)
-		return;
-
-	kfree_skb(priv->stampable_skb);
-	priv->stampable_skb = NULL;
-}
-
 static bool sja1105_skb_has_tag_8021q(const struct sk_buff *skb)
 {
 	u16 tpid = ntohs(eth_hdr(skb)->h_proto);
@@ -552,9 +515,6 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		 */
 		source_port = hdr->h_dest[3];
 		switch_id = hdr->h_dest[4];
-		/* Clear the DMAC bytes that were mangled by the switch */
-		hdr->h_dest[3] = 0;
-		hdr->h_dest[4] = 0;
 	} else if (is_meta) {
 		sja1105_meta_unpack(skb, &meta);
 		source_port = meta.source_port;
@@ -785,7 +745,6 @@ static void sja1105_disconnect(struct dsa_switch *ds)
 
 static int sja1105_connect(struct dsa_switch *ds)
 {
-	struct sja1105_tagger_data *tagger_data;
 	struct sja1105_tagger_private *priv;
 	struct kthread_worker *xmit_worker;
 	int err;
@@ -805,10 +764,6 @@ static int sja1105_connect(struct dsa_switch *ds)
 	}
 
 	priv->xmit_worker = xmit_worker;
-	/* Export functions for switch driver use */
-	tagger_data = &priv->data;
-	tagger_data->rxtstamp_get_state = sja1105_rxtstamp_get_state;
-	tagger_data->rxtstamp_set_state = sja1105_rxtstamp_set_state;
 	ds->tagger_data = priv;
 
 	return 0;
-- 
2.34.1

