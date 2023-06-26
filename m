Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E964A73E3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjFZPw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjFZPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:52:22 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2044.outbound.protection.outlook.com [40.107.247.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F17125;
        Mon, 26 Jun 2023 08:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2EdbOObkKr+RBpRrzrjOkRG9c0cq/JCTfN4Wa0SfyjRuSYUnnPJJD06Y9GQ+gMgYwjdefPPKG+qtR7dddLSjI5Bp4Lhd6Vv3VpXF0eghBdiZwaA3Llh7azF+cr1ERrBmLdfD9nRQvMKbVDmbWtDleUuymuaWhmq/fPVNc7Z3hbiP0z9HP+8NP1WLKrF7Po3wPm25qR5nSEnSli5pFbeyPkW+fnwtCgO9FNK9mvWKrEWOaETDjwKfzECZcoTx6WM8y+y2Tne7pw5AUyriYiJvHGcH+4HTETdpiUrRMIi03RYVcNbUiKYaL1gFLiFzMYm9w6C7mNeIZrrxEm/CpVUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31N/a26VP6Op0BEowgQqMdG4BNE/nqcH5Cbyd5rgUVk=;
 b=kil036e0JIvnE9/TpQZTb5yPv7kbFw+bwB98rptcLoigxOOYXk57Y1Ob0BBL8Q7VKGgkGK2P6PU7xe4X6znXfhpqHGguZTsrNNYAXb6uA3nRpRYfwo5BVwMxzlQZpzbwP7ShgZpyPDVcGgrRCqIENZutF0GZQeJ/WHfmM6WTEvYkN+0H1xXInBRqQJG79VAQvFvmm6epRIKDus4Tz4tGJKQy5wWa1dovoBgmw/fecSKVUEe66AaW+SuId5wOyU5TvAKXLzH+Yk5kndNj987aHH7aMn2O9hzyTAqICQfI1MHHttRBkNeM5mNOtg1PKbybBsNT8wX0dZ8z5Uf8HG6gnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31N/a26VP6Op0BEowgQqMdG4BNE/nqcH5Cbyd5rgUVk=;
 b=IcWScJNrBqNSP/z7bKuyLwdZ/zU2XU/QAlfPy7bqyk5t4tKQU0Ri+VibzvCS/Sqnvod/eKwKaBsMqsCf+eg0/HVsaeSXIpApqoDAuvFbcAYzG2bdftVAt6HRXrIkzI65OIHk2hzVv4iZy1HjsDX939g2buaGyRyAcT/yq67O9e4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9475.eurprd04.prod.outlook.com (2603:10a6:10:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 15:52:18 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 15:52:18 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: dsa: sja1105: always enable the INCL_SRCPT option
Date:   Mon, 26 Jun 2023 18:51:11 +0300
Message-Id: <20230626155112.3155993-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626155112.3155993-1-vladimir.oltean@nxp.com>
References: <20230626155112.3155993-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0003.eurprd03.prod.outlook.com
 (2603:10a6:205:2::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: bc132ff2-4448-4301-428c-08db765d51d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lo5Jrl3MNX0Cg3qwadIQXWKj24DBAGq2cHitXpCSA0nfEPfFb/8O/C9S9+F9C07GOf7WD9Lfww8AKbDH6S/wQXsZf/gOR09eDr1hjApbU4yK+zYz/UYKcUkQzUnrfPQHydzDqY6K1MWbwB91tfgeJ8DJaJ21fFMTnl7+rrl9+C505wq5fVAf41EiPMiXcADImygv8/fPu8hlcrb8iSIVH7KDj78lWyoD5SU3QLh/fFiTRCRTgYNed9RcNyJ/Gjt6h/WucLjdkulLuFIw8DheSMycgnH+kTtg75mg0C45CuMK/Wf0F/4IGHEpi4dLbqpcDC9tf2mnTs1n56sP6UoKmSHMwvuJPsalrd3NlAqhT5iu3Z8NldSYDUmbY5cTrmjjXGR/rxFr+TR6FpIkGAWM2t9k4IwWFz3bU57FJj2uv/cSQqrNehM9X7lzMhX1XjumK3FEyqqDdMT0ZKi2LsGFJZXQVMLxLlqroNjLT/imdytMPEL9NlhJUqBIKYiXwXUcM9so0lylX6DISSNKO2rtR8vhaa7rh12QE1Lc/oxyh/HpR+fdQ0EuzoA+6A4Aq3kkxvtcPsmYn0xBTFzZDafKHewxlXOJ+zllWt4fiUOO0cV12UgqHquo3b3PM0nYVA7/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(26005)(2906002)(186003)(1076003)(38350700002)(38100700002)(2616005)(6512007)(6506007)(44832011)(5660300002)(83380400001)(8936002)(41300700001)(66556008)(66476007)(66946007)(36756003)(8676002)(6666004)(52116002)(54906003)(478600001)(4326008)(316002)(86362001)(6486002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xw9AGW42WcyRhWs+jO+0pIVxzv08hQODM5WYijGFInENblFkmtLjBb5rDVhp?=
 =?us-ascii?Q?4nojZqaJiBGdmbTv9N4v17769gA27tAYZel4Jx2XobWWgolrLgM7RC4RlKrP?=
 =?us-ascii?Q?DnTByv4LGACrV9AMi9ff6UhaH4kSJH+bwBFGWhbEuyNRy/R0hGv9p3jggc6A?=
 =?us-ascii?Q?UQwIITBbRxSpHaRwspqKIsuzLqwuJoIO3OXDvOUGTGELCa2GoRpdAQTCWpgx?=
 =?us-ascii?Q?cfHe2lUvwRx3HEmgPracz8MgWNSHyDi6Rz90y9e/XzgxTdfjelHeCUgJw1Yo?=
 =?us-ascii?Q?blz94xbfG4PwQH16OjLZ+4FsU9EkmrQ71cPvamLqm1toog6lRu4suH5JbiEn?=
 =?us-ascii?Q?zQbNKxWbvL69fmAdbaaOSPDIsknpEBnK/lyoQwpuRMlDKFROWJSXJxXiVFUT?=
 =?us-ascii?Q?s8Y6z4zJDvVbWMj6+Gaccd+nmaQtgn6XdCgFjLxnCwQU4Mn2QW4wpZfHPgzW?=
 =?us-ascii?Q?qr9F5Da45p1WDAy1eD9FitNpTlq+pkUyIealz9FHTE1gyg7cQsucuwXbck7U?=
 =?us-ascii?Q?IgI0kS2VQNEQbhlQKNBAUNswZxDItRxbELNmHPdLBnIXTdrs+ZS5Lbx8+wpP?=
 =?us-ascii?Q?pB0wgO1U/poZVvjssOPl6WYQX0mR3KNlLHvPwecfSrSgxugXyXWf1h74Trs6?=
 =?us-ascii?Q?pzldyJC1w3GMPTjGqXum/Q10xrkIDSSEoajLqw45cCoP8HpzaQX4OZQQrpaS?=
 =?us-ascii?Q?ROY1h0mZuLXgLoPcZBBvAB0BmDpnUyw27EXhA05x10C9NfHrdNEPRh5dQ5Wv?=
 =?us-ascii?Q?4ZNUtLPz8/tm24a4AZo7i+NrlDYGM7DwsbAfxk2Xm1PbrtwBQEFXme0tIav3?=
 =?us-ascii?Q?BiM484sXT4de+NGw0zcGJ3DpoRuXdVzOv/uFXUcSybwvgLSdcSjG9QnnyJg3?=
 =?us-ascii?Q?Pgus1mZfUL/hkNedZT7OLukv0Br6WAUNUbudFmvXqLJKye+LjJPmD5dKGF75?=
 =?us-ascii?Q?QzqXPW1FnBBI/b9X4gKC1Q2wEcFz0vvRmf0j8PfZNafCdeWkzmjD2ja1idT8?=
 =?us-ascii?Q?ENNN3HcBcXpBqCY1p8vRr2IP7q7ZgaIkOk2fL/dDFfqYFwQEeKLwvS6hYF+3?=
 =?us-ascii?Q?6NTLnu4Kh+T/ZwyIQ6M5uYfBY26MyN6Hz/TATplnUJY8mL8XsbYpk5G1w2QO?=
 =?us-ascii?Q?CRnrmqhatc7H/TtN0cs+Qx0nWfzfgNuzRuL8wzv+DWAKIR3jM0IWiBysHLA3?=
 =?us-ascii?Q?HbUQyeTiNYl7zOJfHSMIsJ00Oo055l7QWqaUC6+RUbW2/25l9vr9KUJP/eFu?=
 =?us-ascii?Q?YZDe1UnanOKroCZRThkAiJ/xqPYyAkUhQ3Bb0KA5xR07fm4ybdP0eIUNDchb?=
 =?us-ascii?Q?gq7Npbmb/ugTxokaakazwBRrH1ZIsoyPhHEspWmkEPdasqLfHqrnbBLguU+c?=
 =?us-ascii?Q?CRWzhf8vsLysjRXomO61RG6JqFRBIR57VOpaHQn1obGDtLAxvW65ZbQhpU8A?=
 =?us-ascii?Q?Mr9XOOBwJtFxu0ynBrLt3/CtwE4L4gDpnSLME0zxgTehI1qt/Z249+yw+8u1?=
 =?us-ascii?Q?PS0ANqyY2GTHazXa6WcwDQcsLBldrBV9CLF5atuMOaD4LPY7oE0Oy7exM1un?=
 =?us-ascii?Q?vmEPYR1mkz+BBnkg7Sa+VJGpevHVQYrUAzqM99PB9VK7svdE2pH8kXL4ViUF?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc132ff2-4448-4301-428c-08db765d51d6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:52:18.2281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uU+0k4rqWRwPoxSxQzO6YqhiqIn5wVHCYRr82U7x6i3L2phkiicI2mcljVatts5XTZJjieTHtbZ/Fj/wtEC7TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9475
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link-local traffic on bridged SJA1105 ports is sometimes tagged by the
hardware with source port information (when the port is under a VLAN
aware bridge).

The tag_8021q source port identification has become more loose
("imprecise") and will report a plausible rather than exact bridge port,
when under a bridge (be it VLAN-aware or VLAN-unaware). But link-local
traffic always needs to know the precise source port.

Modify the driver logic (and therefore: the tagging protocol itself) to
always include the source port information with link-local packets,
regardless of whether the port is standalone, under a VLAN-aware or
VLAN-unaware bridge. This makes it possible for the tagging driver to
give priority to that information over the tag_8021q VLAN header.

The big drawback with INCL_SRCPT is that it makes it impossible to
distinguish between an original MAC DA of 01:80:C2:XX:YY:ZZ and
01:80:C2:AA:BB:ZZ, because the tagger just patches MAC DA bytes 3 and 4
with zeroes. Only if PTP RX timestamping is enabled, the switch will
generate a META follow-up frame containing the RX timestamp and the
original bytes 3 and 4 of the MAC DA. Those will be used to patch up the
original packet. Nonetheless, in the absence of PTP RX timestamping, we
have to live with this limitation, since it is more important to have
the more precise source port information for link-local traffic.

Fixes: d7f9787a763f ("net: dsa: tag_8021q: add support for imprecise RX based on the VBID")
Fixes: 91495f21fcec ("net: dsa: tag_8021q: replace the SVL bridging with VLAN-unaware IVL bridging")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index a55a6436fc05..dd154b2b9680 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -866,11 +866,11 @@ static int sja1105_init_general_params(struct sja1105_private *priv)
 		.hostprio = 7,
 		.mac_fltres1 = SJA1105_LINKLOCAL_FILTER_A,
 		.mac_flt1    = SJA1105_LINKLOCAL_FILTER_A_MASK,
-		.incl_srcpt1 = false,
+		.incl_srcpt1 = true,
 		.send_meta1  = false,
 		.mac_fltres0 = SJA1105_LINKLOCAL_FILTER_B,
 		.mac_flt0    = SJA1105_LINKLOCAL_FILTER_B_MASK,
-		.incl_srcpt0 = false,
+		.incl_srcpt0 = true,
 		.send_meta0  = false,
 		/* Default to an invalid value */
 		.mirr_port = priv->ds->num_ports,
@@ -2405,11 +2405,6 @@ int sja1105_vlan_filtering(struct dsa_switch *ds, int port, bool enabled,
 	general_params->tpid = tpid;
 	/* EtherType used to identify outer tagged (S-tag) VLAN traffic */
 	general_params->tpid2 = tpid2;
-	/* When VLAN filtering is on, we need to at least be able to
-	 * decode management traffic through the "backup plan".
-	 */
-	general_params->incl_srcpt1 = enabled;
-	general_params->incl_srcpt0 = enabled;
 
 	for (port = 0; port < ds->num_ports; port++) {
 		if (dsa_is_unused_port(ds, port))
-- 
2.34.1

