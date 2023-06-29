Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3974251F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjF2LqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:46:11 -0400
Received: from mail-vi1eur04on2048.outbound.protection.outlook.com ([40.107.8.48]:9541
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230036AbjF2LqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:46:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBBxiVBbGpRCSzodVP758LxAze/ezaOc6D0anzuf74RrpZKgzy8GkSBGg2YEqVgvZPa8TleZj+WJ8+zapYxRz/viI1rSy7V1glYPGIm7txpboJvNgHhIk14ufPyVa8CEiS7s9Sjicg70JetfJcekkZamJtxAhehystBppSVUq5RW93PrMUSVnYjTUHTTePFLDovqS/PeUaI4aVLsJTBykMI9GmB0Bw7bmqPxIIzrE7QfBDnjp+Cheg5QFFnMz/NFpk3VX8p03nVX+hm4fGio4d3l4TVR53gfITrcjuWnhSZELrVbwJqGaF4b5mYX1YoOGZtk5YfoZXFFBZtTXNXtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuFYQEqGKDFJ6gb75D+IWBBy0SBkjiZwmB/gDay+rRY=;
 b=MV3B+KL+ZbLAOvqwMKmWCdGVxCt/Pnl4wUzOjuLfjyIsXH48u6la2F4yMmiKcDiIH099URePcqUCMKIXMRaja2VCU6D1es8QonahI7RJnnrTdLJX0G117eG4lDMyciQ1rD1mimtS5Sa8Ho49ekw6fnewl1XGA/cC9AbWBZul6LjrkAe7A1/CP1hAjo9NpG7W3gHkNat/ATgzZNPgaHuAWx5EVnHwmZZy8zPoP+ToVGAjfUk93BtvHveKuDjyfKm3YQTuqjIybFm2gDGEOa7cwqDzPi64VPpvPsgvMBabdZC9S2bYRDPKjQgLhmMeFAruCo/Q/iU+pMQWfVK/kH6rDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuFYQEqGKDFJ6gb75D+IWBBy0SBkjiZwmB/gDay+rRY=;
 b=Wf7kbiJdVTae5AlmUTDeXwUD7Kp/isAxEL702XyIJJYs+NjROJyQi5Hm04939qp6xxD/js0/9K+ozd/xHUae9gGsl7tCdXTClg6SXvaYdyI329YXCjeAUV53+fJcxV+aMnc8zY1RW3cMsdHKQ5eagccWsuJ4nlvEHIIwj87b96M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB9318.eurprd04.prod.outlook.com (2603:10a6:102:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 11:46:04 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.036; Thu, 29 Jun 2023
 11:46:04 +0000
Date:   Thu, 29 Jun 2023 14:46:01 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: dsa: sja1105: always enable the
 INCL_SRCPT option
Message-ID: <20230629114601.guhv5l7jz6t4cmrw@skbuf>
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
 <20230627094207.3385231-2-vladimir.oltean@nxp.com>
 <f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com>
 <20230629101950.7s3kagwvkzlnu7ao@skbuf>
Content-Type: multipart/mixed; boundary="tw4u5cclrq56dhcx"
Content-Disposition: inline
In-Reply-To: <20230629101950.7s3kagwvkzlnu7ao@skbuf>
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: c93f4686-2ca8-4156-415e-08db78966b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m9/kdkKlB3SN6kr5F9VMWBf1pEngEW2raTYhmlz9NnZq20oVltA52NzMTNsrZHvGVM2BiH45FEZ+dznZsOKP+J8zd3m4xhMho2mlCw+cUJYwHqF3BrSULLC7dIB3wtxInuVvZA6lbh1U6pjunm2d5yuKhyBoq1MTDhJE8W9tg4TUM/M3j5g2iXS1zsSI6ps4egGQyp0CoX6wkmfGqu5PIQrMvc2pcBJrozS+kXy+5XM2doyIwzfQPUaE7K+K5WaKmXtQA81RFGgZyLo53sHOz8zzoJVcdH98zlqs0Dn9QLVcZRAzl73dUF9J9S9Y86VUt3qT5xsttNhmDqw3OsrAZbLykazPvdIcSse8bNJHXDwQ1PfO3ROuqZ8Gk7f/pO8YinRVyw0BBgmTBgyT6GAzVRvazblMaLPkvJ9uXPN2hJvbFO3ulRgWfb/V9cHFf9D8pGewlR8mS9Hz4XEOCxdaCiEplEE9Tt5aYijFr0w+Utgly6xwzFqR4Qb12OANe/AF4m5Z2U+WJRqw3jsGwDDkt5ExZS4oYDVhf8Zl0EK+0m58rXy1mb+vVH81ln4/AHoRpebGp+uZPhycCNDirzpqw6tMF6ehzTRbRz88g6btDCZxB2ipwuIOcYvzyyeVA7C8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(1076003)(44144004)(6666004)(54906003)(6486002)(83380400001)(9686003)(2906002)(26005)(6512007)(186003)(478600001)(6506007)(33716001)(5660300002)(44832011)(235185007)(4326008)(316002)(66946007)(38100700002)(8936002)(8676002)(66556008)(66476007)(86362001)(41300700001)(6916009)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8/5KPjkcPS63Q3hQC7QXhFtrFZBJ607GtoVuFDguxIH10h6fWp6AIs1W4TKi?=
 =?us-ascii?Q?xd8wiHNBSy0tVgTwktNuEeOP98naU/P15UIPnhFa2pseAusv7cwwUzo89Bda?=
 =?us-ascii?Q?29NDbUkRLevoGjxYAilqCTUjJifhtaK/zv+lu1raaZbHOiFHPZ2jJ2dl+Mtr?=
 =?us-ascii?Q?Albi1E9ZaCgcXStjnnQ3Mppw6gm8JeV4XdMABYeJzlfksgaywU8rT3lBaURR?=
 =?us-ascii?Q?Iko7bH3xYDD2xvPg/wYq804s2k66fW90A8ZqZkhFZgsBxUeVuKbM0xj0/A7K?=
 =?us-ascii?Q?wLzvmSz4C2AqhlHGvZQN5JuufksjhcAxC2KCjz1G4w5jtUgsCTJCiwA24HNd?=
 =?us-ascii?Q?XSiyvO2dkM4XKIxOtZsgDb/tb4n1X3jodlWyMmkdAu+YOsWwSLvsmlGqGyhw?=
 =?us-ascii?Q?v6tZ8FZ+X5xa9j0kTnyms/kQ86ral8zjUUdBidNmtJlKLDeAqjUn/jFRBpFu?=
 =?us-ascii?Q?Fvdkiosg60DbIPr3cJyOSLLMTfx1wOEdFShQ5Y6waClGIp9DGv1QDCsJuz5Z?=
 =?us-ascii?Q?M+myLkmlQb9CW2Y0VdHFs0ZGWzpKXIk5gmJu1XVziRzbMCwf83Gx9FXIOeRO?=
 =?us-ascii?Q?KcMThr0owSDwYUYv1FrFxPdmQjEMj9vW5U/82LTSNuV2rYvCac0avEhxnbwL?=
 =?us-ascii?Q?ERK2QKBLc7X6iy6DVRNJHDYhAd1U8Kc3hKeNOqSmVSQNIAPLMwZv9mMcIW32?=
 =?us-ascii?Q?ekmJaIqNDFCg96KbxB/vPQk0wBdsz4Xp0/ju0mID45j/3IzvBG9xwmv7r7q1?=
 =?us-ascii?Q?VAMu5PnreQQRVbI0V1UB8KKjt255WdSCKbL7bkzDozp4ZQqHJA5o3u7vBT18?=
 =?us-ascii?Q?htM7FhZnjOeK++1SFLb11fwHul7vg5ZHKanp6fnosUUWRfCxwVLr9HUH7kUX?=
 =?us-ascii?Q?YhBPMtUGto7HPlplbBhkzT/lFoVc4IyC1ZKVGlmLCo1U9XcSS2NMr7dHs8Cu?=
 =?us-ascii?Q?i6juNvKK37qFP3Nw+HSVhgZsLujGWwYAPFHCR68SHL81xp/RnKOKVlssOh4Y?=
 =?us-ascii?Q?hYvv1/iRAS3LPQFHhD8cEOQnJKti/piD58SnkslyRaYjz0MHEgwHJFAvXiXu?=
 =?us-ascii?Q?9VaolTtTJHNtrDuO9ctJsIZ48EayWv7BM3HI390MHmYljF/LCqLEZEiKbrl3?=
 =?us-ascii?Q?FvBUOdwqLoPLQ82bV451HgCx2u/fesfrGAQnfB6KJBvckn5NJO2Y/w1cIT/I?=
 =?us-ascii?Q?57QRmJ3s8o9DYI76VMWNe0D90hZMMSDPmm3R6oSXHP5SjMDJdTToTat38syI?=
 =?us-ascii?Q?vUf1LpOls+kxn+sMG6CGNz2rGUeCvpjEhURFSDgYuGVo2tRjkmWdD3lTgwgC?=
 =?us-ascii?Q?eiIPgmqssw0ZSwkRR8XpmDiFjK9IW+ektwGoNz3vUGplGLYMNpNVopm70o/B?=
 =?us-ascii?Q?q01ushSW2uPJc5VFCLKOq2ELlp3rs0gCWPj1jNLJLb/BkHnwA8tIznMTwBbY?=
 =?us-ascii?Q?UPXaSuyAgzZAckyWa1S3QCOfdch1EkE9Gsu/ZyR3F5yUNHcg2zmFy8PW9t72?=
 =?us-ascii?Q?7H3fmNtXGy2Cbbbhe/lbEtO8FJHH3RF9x81sAB8zAd2qbn9TjB+2T3vdKX6I?=
 =?us-ascii?Q?gkGpFq/9jA9Raro7FALBD3dL1wkNyAkMP3JbwYZDuUQ9yTrK2Ifm91ob7Ujz?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93f4686-2ca8-4156-415e-08db78966b52
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 11:46:04.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNQZP0UkXxakWiYWQqSeEkXO3v2J6GnUebpdjhWf9BwYTWCP/RB2VSBSswfTZS2hCqFiF+kKY8R/kWOR98c3rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9318
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--tw4u5cclrq56dhcx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2023 at 01:19:50PM +0300, Vladimir Oltean wrote:
> On Thu, Jun 29, 2023 at 11:36:38AM +0200, Paolo Abeni wrote:
> > > The big drawback with INCL_SRCPT is that it makes it impossible to
> > > distinguish between an original MAC DA of 01:80:C2:XX:YY:ZZ and
> > > 01:80:C2:AA:BB:ZZ, because the tagger just patches MAC DA bytes 3 and 4
> > > with zeroes. Only if PTP RX timestamping is enabled, the switch will
> > > generate a META follow-up frame containing the RX timestamp and the
> > > original bytes 3 and 4 of the MAC DA. Those will be used to patch up the
> > > original packet. Nonetheless, in the absence of PTP RX timestamping, we
> > > have to live with this limitation, since it is more important to have
> > > the more precise source port information for link-local traffic.
> > 
> > What if 2 different DSA are under the same linux bridge, so that the
> > host has to forward in S/W the received frames? (and DA is incomplete)
> > 
> > It looks like that such frames will never reach the relevant
> > destination?
> > 
> > Is such setup possible/relevant?
> > 
> > Thanks,
> > 
> > Paolo
> >
> 
> They will have an incorrect MAC DA, with all the consequences of that.
> 
> Given the fact that the incl_srcpt was enabled up until now for the
> vlan_filtering=1 bridge case only, this was already possible to see.
> However it was never reported to me as being a problem, unlike what
> is being fixed here.
> 
> I see no other escape than to unconditionally enable the send_meta
> options as well, so that the overwritten MAC DA bytes can always be
> reconstructed from the upcoming meta frames, even though the RX
> timestamp (main payload of those meta frames) may or may not be useful.
> Doing that might also have the benefit that it simplifies the code,
> removing the need for tagger_data->rxtstamp_set_state() and
> tagger_data->rxtstamp_get_state(), because with that simplification,
> the tagger will always expect meta frames.
> 
> Because of the lack of complaints, I was considering that as net-next
> material though.

This is the patch that would avoid that. Not sure whether I should
include it as part of the "net" series or if it's better to retarget
it to net-next. It has an interesting diffstat of "5 files changed,
7 insertions(+), 93 deletions(-)", so there's that.

The patch is attached because I'm trying not to post code that patchwork
would think it needs to process.

--tw4u5cclrq56dhcx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dsa-sja1105-always-enable-the-send_meta-options.patch"

From b450f96d8f313791909ac70a913a55fc65fdc1e8 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 29 Jun 2023 13:41:59 +0300
Subject: [PATCH] net: dsa: sja1105: always enable the send_meta options

incl_srcpt has the limitation, mentioned in commit "net: dsa: sja1105:
always enable the INCL_SRCPT option" (FIXME not yet merged), that frames
with a MAC DA of 01:80:c2:xx:yy:zz will be received as 01:80:c2:00:00:zz
unless PTP RX timestamping is enabled.

The incl_srcpt option was initially unconditionally enabled, then that
changed with commit 42824463d38d ("net: dsa: sja1105: Limit use of
incl_srcpt to bridge+vlan mode"), then again with "net: dsa: sja1105:
always enable the INCL_SRCPT option". Bottom line is that it needs to be
always enabled, otherwise the driver in the current form does not have a
more reliable source of information regarding source_port/switch_id for
link-local traffic (tag_8021q VLANs may be imprecise).

If we accept that PTP RX timestamping (and therefore, meta frame
generation) is always enabled in hardware, then that limitation could be
avoided, because meta frames do contain the original bytes from the MAC
DA of their associated link-local packet.

This change enables meta frame generation unconditionally, which
simplifies the switch control path (a switch reset is no longer required
on hwtstamping settings change) and the tagger data path (it no longer
needs to be informed whether to expect meta frames or not - it always
does).

Fixes: 8aa9ebccae87 ("net: dsa: Introduce driver for NXP SJA1105 5-port L2 switch")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105.h      |  2 +-
 drivers/net/dsa/sja1105/sja1105_main.c |  5 ++-
 drivers/net/dsa/sja1105/sja1105_ptp.c  | 48 +++-----------------------
 include/linux/dsa/sja1105.h            |  4 ---
 net/dsa/tag_sja1105.c                  | 41 ----------------------
 5 files changed, 7 insertions(+), 93 deletions(-)

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
index 92a626a05e82..7f041c8a4d7a 100644
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
@@ -802,10 +765,6 @@ static int sja1105_connect(struct dsa_switch *ds)
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


--tw4u5cclrq56dhcx--
