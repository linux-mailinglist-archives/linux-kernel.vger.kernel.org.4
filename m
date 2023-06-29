Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE37742809
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjF2OPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:15:22 -0400
Received: from mail-am6eur05on2065.outbound.protection.outlook.com ([40.107.22.65]:38400
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232055AbjF2OPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:15:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQq/qezPCRwD8c+iL7fb9pkYYFL8GLhvVorhv64iPjjGnpppH3gUzmBcODM6U6322CiXZLRL3bdsgFWejSr5lTRtRI7/p6toIZTijgZgnMoqB6hqwC1ulEfnkeHCAE08HdhAtqWwOy3v8qtppfX/Y3tfFDNmMRqiMZg+4dmU3ju9bPX6kccx8x8+XTKOpbhZ8ERkk1qEDSvdC8O9338wQPHOez0TKtN7yv38b58wzcpT+T4maLQGHFvs4ASEfzwIs4OAcxkJdxsjESqJNSXvf8ZzSt7dG/RVLyl7HwF+9YZohJha7DSLDcm92uo4B52txoLR3j635w1xe0YUohMrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhuU291lBXUp4DmewWV1ifadzxE/ywSgzsAY4gNKsXs=;
 b=A6UlqhQFMvH+UeApbkakXUzK4m0XzZ6YhxrCL2gPvHydVxQeiCoyWbVl2pr4TogG9+A+QVeqgwkxp9QpN5P6XXeRN3E5veGX1OLTr/n2bQnn/OnCHNvhucozkAJ32c1D2H5zQEx5H5Wje5TJWDyBlY7K9PdFNQJjAlxugjk0oFOrAj5zpkvV8jycHQbADRPVrNSGGlClJzNstVUygaX5eCU9mCL2VctW+dt8D8vwuNjVh6jQj4cY0V81Zfr17HVwlZQmW9HEVBPWD4wC8gPkrVf6aL9gz3EXzXCjeWMrwKVl6g/Mln3WJjmWJabuqyejK3s/l4MQlxQHwRnAEjS8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhuU291lBXUp4DmewWV1ifadzxE/ywSgzsAY4gNKsXs=;
 b=FOdHJlew/lJS26mrS+h80I3zrNHPHjwFfcCWWcMZkXjBFU/yUe9BXGvMOAwofQAR1mmgaargQd4PVf60MqMHBUdbhwa0qhIitic6I+ig9WFmGAgkOlnE2RYmpOcHUHtV5DtzAW4DXWRAJvbuvLmuRPGiWrZk5fJVo9O136gpGl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8406.eurprd04.prod.outlook.com (2603:10a6:102:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 14:15:06 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.036; Thu, 29 Jun 2023
 14:15:06 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: dsa: sja1105: always enable the send_meta options
Date:   Thu, 29 Jun 2023 17:14:53 +0300
Message-Id: <20230629141453.1112919-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
References: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 6deb52db-38d5-480b-d4c4-08db78ab3d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lh3Lhaea/CGj7NTZizjkC1hkrx2gZJAu9GlJYMjo7HoJ+Ghy7xbvaO7LNShxRUArIh6GjvtHfUGBkOxAOWSoiEnwPTLvtI3zVdV3YtZgrG+yg4PqkirTohljx6ItQv2IgKbGrG3HISCs64SWXrivqJYNA1V82D1j6qNmPwEsfhprqU9ST/zOJlUH0nsposzJyCYatRkPKX6aZhzP/AWkby7SQdeYXxtWoggf/z2iEhPDuUUbW6SVKU12im+1V1Ab+VVOld1cniWPd34OPw70+50EowvtTFmuh68u844hMoBmdTmUEJSr6tESvdGm7QnY07XuS5ubIEyGmT07Jii9sxXUO+S/q5YCwQZJesezsiilB49zPM9rJNRrEBF8inwMDVUWh7w2zM2Nt2G9Yff+kb0s/bIAWVFvczH9h1j/BR8HqK1zyTleC8oWN7l3pHBNsxfc5hkbiOcKRIRhOEq6c4dxUpSRVxf+FG+FAQrVTpnrD3+Rfh6QSPrk0ScRXA3bu6nB7HcpDgObET7UJGR+PnTy1NcucVIw1VXOMLQFCoRqu5Unsba6pMIJWLH8E3W9i6vZ2S1F7GFqw0UOhaHA4vKH2qvpwDxZItwyGAc7pyxUs++Pmv0IA9F6OkBJI5Ie
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(1076003)(6666004)(54906003)(6486002)(52116002)(83380400001)(2906002)(26005)(2616005)(6512007)(186003)(478600001)(6506007)(5660300002)(44832011)(30864003)(36756003)(4326008)(38350700002)(316002)(66946007)(38100700002)(8936002)(8676002)(66556008)(66476007)(86362001)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6//fyg36wn9DE6TQoHJKie5iYNNYyBLH1RSlKxiBvdA0wPz4VN7pPvi1fs0D?=
 =?us-ascii?Q?Zx083T8Pq+D/9ZZxmGuONDbsiX0h381fF70kUVZyqKVG9+2uCzeUvkU12Or1?=
 =?us-ascii?Q?7wdCEzvFCd4vKGmfFgiqPx6WZPiTiUL2aC0Fes9hRIHM3a15+9zLllsiG8GZ?=
 =?us-ascii?Q?OrAYQKDokymD2VMkkv8yb127u7P1cCQQJm29b6rwx2D5GgyuSfGWLF/cMxlX?=
 =?us-ascii?Q?ihSC30Q4lhH04j8RRAtniluMProP/3T2f/8zyfpz9rtW+l0deQvh/0dpLywg?=
 =?us-ascii?Q?C15gTvdU5p4pcZF2zjz3qLI7+gBX+F492Rmuci4k4o+WlAJk5PqUENplM8Bx?=
 =?us-ascii?Q?ixzmNMXI7D2zbLSkgApwzxR6BM0VCV8Rd25FeSCp8Tf5jULy6/V6kmptXVls?=
 =?us-ascii?Q?EElEHOIWO1wU4vyz7nVQWuP+rV+PQzRQHKj2EFALqYXNdSRSD5Xk+zoapw5E?=
 =?us-ascii?Q?tka2npM60Qeg0SA/JuWAMZntsPhjVZ3ib6xdXQfiw0R+46F9ztAqEH2Ce85z?=
 =?us-ascii?Q?MeAx2nJ+ZkXLxrdfChTLLEwyJseOCqD6KGpqW1BqcvgvBhlK/DxMtRqy/7ic?=
 =?us-ascii?Q?BR/cKpmG5/iapvSwSRia9yP9eW0/remCGINN7+UYnVOPcdhhrGM7wkIZMIIv?=
 =?us-ascii?Q?9DSBwxmEmipZ3fIcSCmXGaURcxNHFJ4F+ZNdklptkRRFNIGdy3AleyIOYo59?=
 =?us-ascii?Q?9E9DRRzGwfZUmjc0199ri/rIfk5LXB7h0NzFfH2z9pNq4/YXYLcqQ1nz9dTR?=
 =?us-ascii?Q?qNRv0qTYLmcL/OmKxn8iBSyznJbrphClZRFXPono71B23k8sAMtBymRdJ3P0?=
 =?us-ascii?Q?AeRKrFfvxSX7GlsqWvuKiinEFd10zDlMM7/yl77VFR44Ju67o1YoidpKimW0?=
 =?us-ascii?Q?fySJRyBsFZiGvRZV0CfHEUAHUlESBUduuXRrIRfT8AIglikrIW3nADsgx4T6?=
 =?us-ascii?Q?4XjH+j3YJetbsDY81xNNvBOsGIU+Oopoq0dNcRcVTQ54t3izetb15NDYIWpg?=
 =?us-ascii?Q?U9KgI4FGDi0550mFoRzDvlmerX9Nts30/Q/jVyaBRlXkNJI1SXlBEso7CdCG?=
 =?us-ascii?Q?IHUba18niiX9H388Xq8lO+OS0cmx2QG8FxER0iwRvmgnxALI/xkkAL0bOqm5?=
 =?us-ascii?Q?NbB4g78khA7dth2nqZZEm9EtmEXEjlI21mTJBuUYFKF+5Nm5NhB7B66DExby?=
 =?us-ascii?Q?rwTYSMy7u5znDneyS6sksQDwqAskbHanAi3QU/tK8erO8GRRVpd5b47IGVqw?=
 =?us-ascii?Q?BHDRdNx1q1Yqje01EMq0pt8yBfUtgrLoI30TS/S4Ij4kK2PdddE6NBZORDj0?=
 =?us-ascii?Q?63ZxLTAytQIZXJ6fqzgbS2FuXeYNIg5GrMk8t5FEFarVUidvVIhKuOvLDi5r?=
 =?us-ascii?Q?cMDT7TmFLrMh1+mYrbQSsuzF5ArFfYUJVKrnEQ/ddiheVyGpPp0zTjZYPrDn?=
 =?us-ascii?Q?osKshn5hFS0NR1dPiexks1Tz2TANh49sSCMXjky0TKCkeKDIF285sRGB3IEg?=
 =?us-ascii?Q?dA6zmH91qvnpQhgFluk8mhX1jypK86uP1q9nVXADoM1LIZn3pCodPsLPGX53?=
 =?us-ascii?Q?JUyDaTU3LZvAtIPBPr5kLDxBYA6WEVF1aAc1+wyAMDUlG0XAx3rrrNbCzOHg?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deb52db-38d5-480b-d4c4-08db78ab3d22
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 14:15:06.4885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ25Ru+5swCJt4U8/CuFA3unVlihe787H2HA5BKdfiIf9rlRjj4XB9B9HVAIkwyfAELctvRhMxxc2kBkXfIdVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8406
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
---
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
index cdbadae923dc..0e21a789ca4a 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -870,11 +870,11 @@ static int sja1105_init_general_params(struct sja1105_private *priv)
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
@@ -2218,7 +2218,6 @@ static int sja1105_reload_cbs(struct sja1105_private *priv)
 
 static const char * const sja1105_reset_reasons[] = {
 	[SJA1105_VLAN_FILTERING] = "VLAN filtering",
-	[SJA1105_RX_HWTSTAMPING] = "RX timestamping",
 	[SJA1105_AGEING_TIME] = "Ageing time",
 	[SJA1105_SCHEDULING] = "Time-aware scheduling",
 	[SJA1105_BEST_EFFORT_POLICING] = "Best-effort policing",
diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
index f47ad55a811a..0bb99ee5ebf9 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.c
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
@@ -61,35 +61,10 @@ enum sja1105_ptp_clk_mode {
 #define SJA1105_PTPEGR_SLEEP_US		50
 #define SJA1105_PTPEGR_TIMEOUT_US	1000000
 
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
@@ -107,26 +82,13 @@ int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 
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
@@ -134,7 +96,6 @@ int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 
 int sja1105_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr)
 {
-	struct sja1105_tagger_data *tagger_data = sja1105_tagger_data(ds);
 	struct sja1105_private *priv = ds->priv;
 	struct hwtstamp_config config;
 
@@ -143,7 +104,7 @@ int sja1105_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr)
 		config.tx_type = HWTSTAMP_TX_ON;
 	else
 		config.tx_type = HWTSTAMP_TX_OFF;
-	if (tagger_data->rxtstamp_get_state(ds))
+	if (priv->hwts_rx_en & BIT(port))
 		config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
 	else
 		config.rx_filter = HWTSTAMP_FILTER_NONE;
@@ -419,11 +380,10 @@ static long sja1105_rxtstamp_work(struct ptp_clock_info *ptp)
 
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
index 226191ec654b..9d23f5e93269 100644
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
@@ -782,7 +742,6 @@ static void sja1105_disconnect(struct dsa_switch *ds)
 
 static int sja1105_connect(struct dsa_switch *ds)
 {
-	struct sja1105_tagger_data *tagger_data;
 	struct sja1105_tagger_private *priv;
 	struct kthread_worker *xmit_worker;
 	int err;
@@ -802,10 +761,6 @@ static int sja1105_connect(struct dsa_switch *ds)
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

