Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2633173F58C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjF0HXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjF0HW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:22:58 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C560D30D6;
        Tue, 27 Jun 2023 00:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btgw8Vlo1ZeU6gxgWqEjDF/oGShTQNuQzXrneTOllse8e6KcUcMVlQ/7lWvwHc8U8cI2ZuFtb7a1aexdgMAswqWt2mLs9FgxTUJkLC1RGPdjSJiIi4CojlR4yO433/L8KfLIsnFoA/PnLqFQ/v3PpanyBnEt7Hn615yNUd7oa4CjM5Jc5qIEb4W7sxHHPJXOUo0lgjrSUcBU7L2qA39WRjgFdoDoQB8VhctZBJWGxy2FSaL6JS/oF+LuQi/feK9U8ZtoaLkhg3x9wBn8Y2QubrgjYrT9aNTEnpfgzazn71fUk/diQ4/sb7b39Jezjxw3Uftp2eGGiJgvVieh3HJZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0i+EqVPH+dSCRPnSwHsB1/280lgau8mOLLHBMZHOtw=;
 b=Igp+nLPFIukWuin40HA0OgCEhD10ep6Ovz9sG3CU72lJoqxyIa0GbkrAqYgjX4aAMh4NXAMpyujmyLYYq3ari3Y7sJK7+613W0KacMudfwW4GmZZ1zw8EP8NGD1sQty4xXvq4VJH0crxr5qQ1E46TjTJS4ngHrLBgsH80DAhVIA8u9NuDycuU5Wn5z8laoN0GIC/+urQLwNhgaimrLagIQ8mTHHtt8CP8C6Q+0KSjoYQnNMSp/Pc6/LlN7FIqGkmecLDTFnITqgtBEFTZ2fO8KFyp2ZzFS5Zh3MNF8uhuvRSDm/Pgp8UyYAhxGU8Oo+G3betYtAIz8MNmhhdhzrRPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0i+EqVPH+dSCRPnSwHsB1/280lgau8mOLLHBMZHOtw=;
 b=GZaMTv0sx8H0VyqxH/YJqCXejW0dzLXPLQHabR1w66L2F+HOAf7bLMJSXLzhx2ACVdj0PyQW+bLQZoKjJqY6ButweotHBjXesEcXVqDIx5xHvdWt2uwfxeckdGCISEdgoTTZBBpN3UdkOJYMJ9L72hzsRsZtvk8+IN3EHUa5fjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:20:04 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:20:04 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 11/12] net: phy: nxp-c45-tja11xx: read ext trig ts on TJA1120
Date:   Tue, 27 Jun 2023 10:18:52 +0300
Message-Id: <20230627071853.106215-12-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ebbf3a5a-d43a-4fe5-ca81-08db76deed5c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1g/AYg59gK7KaH7mGpc1nXHY95ayCb9DkMcbZaxTYwbyeOrHzoha/oMHt5B2000jA5yF8aZdwu2Bz+Z1P2cw9Y96UyEDvbPQSIxee8nlD8O42wuLHYRbq0RaZGXGRjw6ZQkNxazI+BUJulFWeHijDbCwYH6PfnWR4USfgv6IrL7qJo9DhGep8cMUv++U2Bq5iiYeb4IlIr4u9HvnQ8Iv8JHRvh6eIOncf1kZrEk646HdXAzKm4TDh/r37W4ukNlzzpCbuf8I95IlkRrGjPJkhdtPPLFBnuMFt3JdQrvzau5RXaZO7fW2kObOVdUpFgSqkZm73euvA/dw51TSxdEGEdJsEnFhPi8pNe8U5ZVstsL+f/dvCXA8pixG6ptg9bTMhBL4NWu7gfL5gSKig53SSYosUL5OH/FNU48y1ERVNahSHLPq/UZ2ZXBwGuA12jdpkjxiZCLrhkMs4WCusSX8/w3//jFjgNkylfmIRovHDhDOCurg5rUcJZ+ppb8lLSckiY90yLmChaN3UZKgRi8zF/RSkzpwYby1/J9jzqiudVbdnNArcUW+hvyUy5i6a+cIaCAQlKhkR5tds8v8goUp02D6Ihp/xEzmrbPMt5DokRPbyZ4oFHvAgIQ4TL7YDlJh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(83380400001)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(38100700002)(8676002)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U3pTC436sEVGEx5vytOCMBIPZPkXvDThbxLcn1EKnEAazD0A1Df3qs/ACNUC?=
 =?us-ascii?Q?fdVp11AJWLP78YkgQ6M4RI5x7GG/sgbqPuJjhkxwcoWZ2mNMqvA2kV4FDt3q?=
 =?us-ascii?Q?eWIcZLLGyiTjEDM+kYyvlWrjv1jMnXfDBBbiSRuxWx/IA+wpW/NyGZXBXyOX?=
 =?us-ascii?Q?fv6sUy8McuF6o3QpJ3Ehj6JIXAn5DtFOs9dr8MXUbUIT/jrxfEEpz6s7kBLW?=
 =?us-ascii?Q?NRPs5sb0OFqfwd8kjaJseAebcKOFayr8Gn6NYug4aCkyiwsAYSazO5qhCEW0?=
 =?us-ascii?Q?QqbV7qOpEcSPoio94KkyIIC5WoGLCFb5wG+T8XkBCZKDYguE1RSUuuV9xViJ?=
 =?us-ascii?Q?VNR/qpgmsVyjwkN6F0UHx9oQrj7qOxhafRrYlQvxlfuq+sEfagzvNotPCaon?=
 =?us-ascii?Q?AzieyurJ4GjvSgTOfjqTAFw4/Jm7cLROGqD1jMuVPmVek+gs2qpKDQWNTeaU?=
 =?us-ascii?Q?bQ4qZqibznDeI0dtOZqwgDBW07F/sf3mIwym8teT8NC5t1EGtLd9hnZiBJUB?=
 =?us-ascii?Q?2KzAByTF+uvn3/aL+tGvq/ILHNvX5MIOCRkzUl4L0di4oB2z5yihrlohfvgw?=
 =?us-ascii?Q?EN2GCAx1+V8kBcJDcRuSmkPj8fxI6bmL1UgQJfdgv6JN7s/wth3DiqoVgGS8?=
 =?us-ascii?Q?zL5yH0mnJaCD41NThjYRum5T8HTds8R5NDJ3E79zOgZD/NWHJ6B1DhokI41S?=
 =?us-ascii?Q?B/elHFM7tyiOoliGggF9xt/9wID/wXl2F94zpO6Ppg4B8svsAsG9kyCQz2na?=
 =?us-ascii?Q?cQcuuMRZ36f8KIDbYJOEuU05/SSYkI7Ein4NpSbIbTKOM4uiwC8XUToMmfFu?=
 =?us-ascii?Q?xjhkCxGA6p/YETWfSsI6YHQeV5szN1bJDo28GEjmiqXXazpjhrL80920MY5s?=
 =?us-ascii?Q?Q5XMa7GiEtRGAIaozlj4QNZkXpkkSr/Wh//yGboyma/mnTcFoQF2I8na+0nG?=
 =?us-ascii?Q?dR/SckvtDnTC7xUb2dpUOJe4VBI5yHbRyMfXNMoDAyd9ilHiUm5mWics0VLr?=
 =?us-ascii?Q?ADMK9gMQug9keEhHo/UuO/lPgNpelBYX97kzIRoUF3xTHJtHItI7inNAo+K5?=
 =?us-ascii?Q?1CxgU5xIHHdtPYyI5ndoUYbpfI8t1VB6n2ZnmVtpKCdSKVDOPwSoj19mIKrJ?=
 =?us-ascii?Q?WXfDSk/nDtfDYFFYlOFZO+nYk27WLcwh38tZ8nQ5WQW2sV+1RX1SxEuR7Huf?=
 =?us-ascii?Q?jtfSxKniLNVKdUeIK1OyyCE8o87d5QS7esN8Fy1MmNFuCLO4k+HcUa8j9uJZ?=
 =?us-ascii?Q?6s3HMWDRyNSuOK97KV6PcxsMdXyqMHErlSp999kb1pXWJsw8CfVRYgSCB1/A?=
 =?us-ascii?Q?zA36EqQdn/fy1XwHuI18tmR25UNxmgcZb3aXSFgJqf339kKLDhkNjCWqSZ0E?=
 =?us-ascii?Q?bnmnzHGLVPewROttNKmSkV2P/sdDyK1MVd4xpBTqvpELo2Ekg8XK1/dDg03+?=
 =?us-ascii?Q?f6XAC8NCzCF9H7PM3Iz4Kx546n/ODrR5dpP2fV0myy8VhzX7Kp7bzjOkSJMT?=
 =?us-ascii?Q?PJZT8oOge7hLn5BIPv2fh6I+qjY+VeCx+po+X7JomYJjWjT4nltUtWNe1USo?=
 =?us-ascii?Q?AKYCKesG3SKixT7CpOrVnFJqaSi31jwSGmbynkme5+r9HoYEI/ZnSLz+3wXw?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbf3a5a-d43a-4fe5-ca81-08db76deed5c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:20:04.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIrmRAwt0zUJ8M27gRSTp1+EYA1hMJVkOSCe9h8ofNW1q8wCx0eNYs48G8JyBtsDzUhhM2mEMuGz8Qv4amJTVl9B8qHCnTHhG/T7KDPJwfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On TJA1120, the external trigger timestamp now has a VALID bit. This
changes the logic and we can't use the TJA1103 procedure.

For TJA1103, we can always read a valid timestamp from the registers,
compare the new timestamp with the old timestamp and, if they are not the
same, an event occurred. This logic cannot be applied for TJA1120 because
the timestamp is 0 if the VALID bit is not set.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 64 ++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 8097ac8d6962..c21c6aefc705 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -34,6 +34,8 @@
 #define TJA1120_GLOBAL_INFRA_IRQ_STATUS	0x2C0C
 #define TJA1120_DEV_BOOT_DONE		BIT(1)
 
+#define TJA1120_VEND1_PTP_TRIG_DATA_S	0x1070
+
 #define TJA1120_EGRESS_TS_DATA_S	0x9060
 #define TJA1120_EGRESS_TS_END		0x9067
 #define TJA1120_TS_VALID		BIT(0)
@@ -269,6 +271,7 @@ struct nxp_c45_phy_data {
 	void (*counters_enable)(struct phy_device *phydev);
 	bool (*get_egressts)(struct nxp_c45_phy *priv,
 			     struct nxp_c45_hwts *hwts);
+	bool (*get_extts)(struct nxp_c45_phy *priv, struct timespec64 *extts);
 	void (*ptp_init)(struct phy_device *phydev);
 	void (*ptp_enable)(struct phy_device *phydev, bool enable);
 	void (*nmi_handler)(struct phy_device *phydev,
@@ -509,7 +512,7 @@ static bool nxp_c45_match_ts(struct ptp_header *header,
 	       header->domain_number  == hwts->domain_number;
 }
 
-static void nxp_c45_get_extts(struct nxp_c45_phy *priv,
+static bool nxp_c45_get_extts(struct nxp_c45_phy *priv,
 			      struct timespec64 *extts)
 {
 	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
@@ -524,6 +527,53 @@ static void nxp_c45_get_extts(struct nxp_c45_phy *priv,
 				      regmap->vend1_ext_trg_data_3) << 16;
 	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1,
 		      regmap->vend1_ext_trg_ctrl, RING_DONE);
+
+	return true;
+}
+
+static bool tja1120_extts_is_valid(struct phy_device *phydev)
+{
+	bool valid;
+	int reg;
+
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   TJA1120_VEND1_PTP_TRIG_DATA_S);
+	valid = !!(reg & TJA1120_TS_VALID);
+
+	return valid;
+}
+
+static bool tja1120_get_extts(struct nxp_c45_phy *priv,
+			      struct timespec64 *extts)
+{
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
+	struct phy_device *phydev = priv->phydev;
+	bool more_ts;
+	bool valid;
+	u16 reg;
+
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   regmap->vend1_ext_trg_ctrl);
+	more_ts = !!(reg & TJA1120_MORE_TS);
+
+	valid = tja1120_extts_is_valid(phydev);
+	if (!valid) {
+		if (!more_ts)
+			goto tja1120_get_extts_out;
+
+		/* Bug workaround for TJA1120 engineering samples: move the new
+		 * timestamp from the FIFO to the buffer.
+		 */
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      regmap->vend1_ext_trg_ctrl, RING_DONE);
+		valid = tja1120_extts_is_valid(phydev);
+		if (!valid)
+			goto tja1120_get_extts_out;
+	}
+
+	nxp_c45_get_extts(priv, extts);
+tja1120_get_extts_out:
+	return valid;
 }
 
 static void nxp_c45_read_egress_ts(struct nxp_c45_phy *priv,
@@ -656,12 +706,12 @@ static long nxp_c45_do_aux_work(struct ptp_clock_info *ptp)
 	bool reschedule = false;
 	struct timespec64 ts;
 	struct sk_buff *skb;
-	bool txts_valid;
+	bool ts_valid;
 	u32 ts_raw;
 
 	while (!skb_queue_empty_lockless(&priv->tx_queue) && poll_txts) {
-		txts_valid = data->get_egressts(priv, &hwts);
-		if (unlikely(!txts_valid)) {
+		ts_valid = data->get_egressts(priv, &hwts);
+		if (unlikely(!ts_valid)) {
 			/* Still more skbs in the queue */
 			reschedule = true;
 			break;
@@ -683,8 +733,8 @@ static long nxp_c45_do_aux_work(struct ptp_clock_info *ptp)
 	}
 
 	if (priv->extts) {
-		nxp_c45_get_extts(priv, &ts);
-		if (timespec64_compare(&ts, &priv->extts_ts) != 0) {
+		ts_valid = data->get_extts(priv, &ts);
+		if (ts_valid && timespec64_compare(&ts, &priv->extts_ts) != 0) {
 			priv->extts_ts = ts;
 			event.index = priv->extts_index;
 			event.type = PTP_CLOCK_EXTTS;
@@ -1724,6 +1774,7 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.ack_ptp_irq = false,
 	.counters_enable = tja1103_counters_enable,
 	.get_egressts = nxp_c45_get_hwtxts,
+	.get_extts = nxp_c45_get_extts,
 	.ptp_init = tja1103_ptp_init,
 	.ptp_enable = tja1103_ptp_enable,
 	.nmi_handler = tja1103_nmi_handler,
@@ -1838,6 +1889,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 	.ack_ptp_irq = true,
 	.counters_enable = tja1120_counters_enable,
 	.get_egressts = tja1120_get_hwtxts,
+	.get_extts = tja1120_get_extts,
 	.ptp_init = tja1120_ptp_init,
 	.ptp_enable = tja1120_ptp_enable,
 	.nmi_handler = tja1120_nmi_handler,
-- 
2.34.1

