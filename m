Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D5F748268
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjGEKos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjGEKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:44:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88EE10CF;
        Wed,  5 Jul 2023 03:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+rU1679MwY3OZ5O4z8UPg1BcoDuhVPOoaHuNWAe/guEyngOY05XP6HvNVJ4oN34k7xrxqtLyECy0rMLPmn1WnGSQo4uRDRalfKrH6QCGRHjSVn27j5nh43ZHxQll7bM01UdTGd2kCbXZB6TMd5lBSAGGX3053Rz6fA0i9azLTcO0fZwTJmwCNIcOMzoinlPOR4WnTrBqT1gfGotj++bncGtB0hI2Hl6hK3NZhHhnY7yXANFGLtIGxhM5okosOd2GUBbjxXOWGwJuzCFP5iHhcmZE29CV9mE4CG4DH9Wbk+2IS/sDLgqCIDASkJ+QdOxyhhirKKp//GDsDKxtuyxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBPz7j0LflvGe/+o7Y5uEJUU07u0+Htbq/FRh6y5ajI=;
 b=EjK9M1TqY3diU0TpbUPUhhWKRAFCeBL7/EHpcNgHzXT32oLCPXwOXPY1rW9lzilBVa4h6iHn8LEhbxCjtdNIMmsCi/tvz86GR8yApmPWmz/pCagLAHtazYnAm/+Uk4o6t7TKjtQRLflZphJn1s4DI86goy3VZU3fC8/jnD21Txg4oofObsRcxWXvSnqoaKtWz/msdHUzDLsAqTluSSQEcCR4acWFsHvmKySQj/1DG9DeDS0s34M46UTrnoA7R43acC1k9fC28HRSEHG3PdhgDee8dnrWl+7sLEonU1QyAO9I+Xek9y64pCoOGizFOarUkjNwb/04c3t7s3agAiQaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBPz7j0LflvGe/+o7Y5uEJUU07u0+Htbq/FRh6y5ajI=;
 b=d4zBjCBYOEENBbbe2yhUJJ7Rz71GlXROctafqw/bsJrHYo8eJCcGSYH9jJaOMcJWRg8iLU9IOfs153MwXXyZyCFcD6Jq2IB1ZwVoCfZgwiRR43w7WZNwG/IXuyKfxezmVuoLCxkCdZkCVk7JSU1otl955iHuZ/ROQPMuV4frq3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7658.eurprd04.prod.outlook.com (2603:10a6:10:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 10:44:41 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 10:44:41 +0000
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
        linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: mscc: ocelot: extend ocelot->fwd_domain_lock to cover ocelot->tas_lock
Date:   Wed,  5 Jul 2023 13:44:20 +0300
Message-Id: <20230705104422.49025-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705104422.49025-1-vladimir.oltean@nxp.com>
References: <20230705104422.49025-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0066.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4b71da-bf59-46a0-30f2-08db7d44d649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTaAw7R2z1wDNStkOLsGNLnTx1tIdgp01jtC9vTPY73qXku+fFBw0N2tQNG/QyAJBuHvEvbW0ciTD4/EmywyzcwbqvjBHQZISK7KlWohi+i1Koa/LJWviX0cPzlCqEQgvX1NZ3zcXoMNU7eLcVK0wndeh3+OphLAbKZt+puMTHNX+vPhdEnkBAHG0ibSbIvF9bbk44YjkJY0zKOKblctbXo9zGdRmAQlTLZSiyZtCYbIpUNI2mAiR5reGVvghkK42+/YQJEsJ9KCuPS5XRykPdvpB97Ovo/QpDETH1hhP8Iu4qY15bYD6URffmUdkHzq8zqFRJ8/gj+9LCCllv4Ocm5p6cIb5TxosldY3OBiUymKAQpQlVoCqG7DX4SuiS6lfL0y6TkSw+0PWZf6eKC61lLJcHFhmXrqRZymiSZhfYiTOgV1Csxqits/DSVVangVVNg7bHn5feZOtLooQVbJOqYmQxNknU7MUlemG6SAiHZ2fT3eQ7JIh2WWqW3pjsRBRIDDGTIoTB2tkjZSuV97XwObjw8xq0oDGCCgVbERoXHDtKjBHKA/5zvtmhdYlwtHPygX3r8YZYGG2+W3zIknZnTGPQ0xQ6pjxMiS38oaNCShdvPsaOamS9TjUuie5pIt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(41300700001)(478600001)(6512007)(54906003)(86362001)(52116002)(38350700002)(38100700002)(6666004)(6486002)(4326008)(36756003)(316002)(83380400001)(6916009)(66946007)(66556008)(66476007)(2906002)(8936002)(8676002)(2616005)(5660300002)(186003)(7416002)(44832011)(6506007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e9Yck8awXRyqp+NXQZYsCjNpaBg2Fjcb5plxr9EzOiQJRnObybUmfQPucaUm?=
 =?us-ascii?Q?3LZu0qvIn/QUb9fmDGO7qm8WyUk31KkwM2oBNiR2HflcpBqQkbAfypppm8RO?=
 =?us-ascii?Q?8pWpcfTQCB2eyqYjcHBPJ3FOnvhtzlj4R+NcGnW/ko830La9BVt6FTL3rufQ?=
 =?us-ascii?Q?wJb7Lu3bgE2CU1vaKePX7mYG72vq0d0lbhPbchjnV4J6xw4R/eLl2f6bZqIV?=
 =?us-ascii?Q?QZd1oAMoFCX5/6KQOCi2szPFE5QC+9NXv345lx6Vvt3bz/OtMjPg4OxuS1c/?=
 =?us-ascii?Q?VBwshr7Tz03ehW2XUZNmaDXGA6Zqobt8fKR3s8U+oFzKinpVIraeMuqpfJo9?=
 =?us-ascii?Q?EvFIgbqoWtNUZ7/WyLL4s+6krKG1x1fO5k6shp72S4b/u3Qg74B2tGABeYnV?=
 =?us-ascii?Q?uQj5crRXCY3kzi/HKlVQV2AzNdhLXrrIZTLy/f/RKuUz4dsfPqnc7zpWNV7W?=
 =?us-ascii?Q?vrq1p+wxCfWV0af8sR06OpRkxg4wTvhgBjc61sszHNx0oMqzJvdZWLqkKtwM?=
 =?us-ascii?Q?xpWHUjL843IKUfunX8N5eDIWGwnWoTxxnLgCUcfDyliEO2hkTsKVOJ+AjKHB?=
 =?us-ascii?Q?2g9ylsZjKIa5WiXjH/n6SJH4CYah3TGDLXT+/T7s+Bcgv0RAtbBXsb5bpckJ?=
 =?us-ascii?Q?NopTvI+yV1heSwmZm0RqN5MnvGm0vjH2vQX7OKIDUmE7hRH1rVxFczmkukxH?=
 =?us-ascii?Q?zU/c6vVjIDQFJg5miCwQFwndkoETKnftNdgRObUFBxwhTnIyEP4pNyFZq2bz?=
 =?us-ascii?Q?rxunKJaFhkPWZXKsoFxz9Xow81QI8SsjOfTBGk37IWLyAcpa9y+Vvyhe4fPr?=
 =?us-ascii?Q?P6LFwdyyO5rVQPR1V2SVcfz1dACbOBI7r6spqjvZgJJvuJL2bnDX4YSqHCPT?=
 =?us-ascii?Q?YkcEqgY+iGnS0K2GdRINIWB+coC6YrAkOeugSv0K12gIb5AqE4V8n9xpW588?=
 =?us-ascii?Q?wD4h6p2UF1MNerbt6eAh3iUvlYlQxZbmYsipDmsycTWJ2tzrPP4PkK/CzT+u?=
 =?us-ascii?Q?nA9t2RA1xn11n8F7Dxy9QaxJY+XEYwcr9yk4/Wwy/A62gTvAvCeuXVoO3WuF?=
 =?us-ascii?Q?eHoVOR82hJObCMZW8hNxWnXj6YwCvU82d7rgwEKcVDZMzAPGPh+SmjfeN65H?=
 =?us-ascii?Q?u89U1EX48S1WQhZ+avWeWiGNkhp1239W5VZ822190swSlXBL6Mf8Bo1L0grP?=
 =?us-ascii?Q?sgXDOOJ41WdBIFidAzUU+cYBmRBE1rcwC5bvHd1OU6g6crs8spEOjLkVwzt9?=
 =?us-ascii?Q?qwsb6F335llm01zFx2uQ2aBFwIloJmVIdjBxZhwul5qlnmAYXIS9zOr3jteZ?=
 =?us-ascii?Q?v7msTkVM1yLc3QX5n3NXxIhz3Tvj3ZkaIIkzp3nJVfQR9Fv25UztQukC6xNm?=
 =?us-ascii?Q?8avIzJdgzTwZasCpoDEdQ0H9UsPXnGie5tGJmCJjw4bZXHUJQcNM5NTJvyR6?=
 =?us-ascii?Q?ZQOWLyXezhjiNJCkpNjBoY+YxeYAqb8qhvH+tIX/6ppxVb6hpQ65z2pHMbFT?=
 =?us-ascii?Q?l0e6OK8WSvnSrJeXgeDJo3lqlbK3TsIGQo9bul5njZDXpd8AGG0M1Z7witnH?=
 =?us-ascii?Q?XFuH7VTP/t10QiQeTJwFgP1HlsOKFHuUYrh5FU3+An4a2jlVMZ7fRN75NVlA?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4b71da-bf59-46a0-30f2-08db7d44d649
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 10:44:41.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sb3X/y+Kh6EJgZ6FVl1eGHqWNR0xKC8TXJiV/GkU0Dorhhi4xR7Qn01oJfC/5lmgzNFdagAhqExPbinf4rCPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future commit we will have to call vsc9959_tas_guard_bands_update()
from ocelot_port_update_active_preemptible_tcs(), and that will be
impossible due to the AB/BA locking dependencies between
ocelot->tas_lock and ocelot->fwd_domain_lock.

Just like we did in commit 3ff468ef987e ("net: mscc: ocelot: remove
struct ocelot_mm_state :: lock"), the only solution is to expand the
scope of ocelot->fwd_domain_lock for it to also serialize changes made
to the Time-Aware Shaper, because those will have to result in a
recalculation of cut-through TCs, which is something that depends on the
forwarding domain.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c         |  4 +--
 drivers/net/dsa/ocelot/felix_vsc9959.c | 36 ++++++++++++++++----------
 drivers/net/ethernet/mscc/ocelot.c     |  1 -
 drivers/net/ethernet/mscc/ocelot_mm.c  |  7 ++---
 include/soc/mscc/ocelot.h              |  8 +++---
 5 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 70c0e2b1936b..0c1207613aa4 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1790,12 +1790,12 @@ static int felix_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 
 	ocelot_port_set_maxlen(ocelot, port, new_mtu);
 
-	mutex_lock(&ocelot->tas_lock);
+	mutex_lock(&ocelot->fwd_domain_lock);
 
 	if (ocelot_port->taprio && felix->info->tas_guard_bands_update)
 		felix->info->tas_guard_bands_update(ocelot, port);
 
-	mutex_unlock(&ocelot->tas_lock);
+	mutex_unlock(&ocelot->fwd_domain_lock);
 
 	return 0;
 }
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index bb39fedd46c7..56b8bcac9690 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1217,7 +1217,7 @@ static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 	u8 tas_speed;
 	int tc;
 
-	lockdep_assert_held(&ocelot->tas_lock);
+	lockdep_assert_held(&ocelot->fwd_domain_lock);
 
 	taprio = ocelot_port->taprio;
 
@@ -1259,8 +1259,6 @@ static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 
 	vsc9959_tas_min_gate_lengths(taprio, min_gate_len);
 
-	mutex_lock(&ocelot->fwd_domain_lock);
-
 	for (tc = 0; tc < OCELOT_NUM_TC; tc++) {
 		u32 requested_max_sdu = vsc9959_tas_tc_max_sdu(taprio, tc);
 		u64 remaining_gate_len_ps;
@@ -1323,8 +1321,6 @@ static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 	ocelot_write_rix(ocelot, maxlen, QSYS_PORT_MAX_SDU, port);
 
 	ocelot->ops->cut_through_fwd(ocelot);
-
-	mutex_unlock(&ocelot->fwd_domain_lock);
 }
 
 static void vsc9959_sched_speed_set(struct ocelot *ocelot, int port,
@@ -1351,7 +1347,7 @@ static void vsc9959_sched_speed_set(struct ocelot *ocelot, int port,
 		break;
 	}
 
-	mutex_lock(&ocelot->tas_lock);
+	mutex_lock(&ocelot->fwd_domain_lock);
 
 	ocelot_rmw_rix(ocelot,
 		       QSYS_TAG_CONFIG_LINK_SPEED(tas_speed),
@@ -1361,7 +1357,7 @@ static void vsc9959_sched_speed_set(struct ocelot *ocelot, int port,
 	if (ocelot_port->taprio)
 		vsc9959_tas_guard_bands_update(ocelot, port);
 
-	mutex_unlock(&ocelot->tas_lock);
+	mutex_unlock(&ocelot->fwd_domain_lock);
 }
 
 static void vsc9959_new_base_time(struct ocelot *ocelot, ktime_t base_time,
@@ -1409,7 +1405,7 @@ static int vsc9959_qos_port_tas_set(struct ocelot *ocelot, int port,
 	int ret, i;
 	u32 val;
 
-	mutex_lock(&ocelot->tas_lock);
+	mutex_lock(&ocelot->fwd_domain_lock);
 
 	if (taprio->cmd == TAPRIO_CMD_DESTROY) {
 		ocelot_port_mqprio(ocelot, port, &taprio->mqprio);
@@ -1421,7 +1417,7 @@ static int vsc9959_qos_port_tas_set(struct ocelot *ocelot, int port,
 
 		vsc9959_tas_guard_bands_update(ocelot, port);
 
-		mutex_unlock(&ocelot->tas_lock);
+		mutex_unlock(&ocelot->fwd_domain_lock);
 		return 0;
 	} else if (taprio->cmd != TAPRIO_CMD_REPLACE) {
 		ret = -EOPNOTSUPP;
@@ -1504,7 +1500,7 @@ static int vsc9959_qos_port_tas_set(struct ocelot *ocelot, int port,
 	ocelot_port->taprio = taprio_offload_get(taprio);
 	vsc9959_tas_guard_bands_update(ocelot, port);
 
-	mutex_unlock(&ocelot->tas_lock);
+	mutex_unlock(&ocelot->fwd_domain_lock);
 
 	return 0;
 
@@ -1512,7 +1508,7 @@ static int vsc9959_qos_port_tas_set(struct ocelot *ocelot, int port,
 	taprio->mqprio.qopt.num_tc = 0;
 	ocelot_port_mqprio(ocelot, port, &taprio->mqprio);
 err_unlock:
-	mutex_unlock(&ocelot->tas_lock);
+	mutex_unlock(&ocelot->fwd_domain_lock);
 
 	return ret;
 }
@@ -1525,7 +1521,7 @@ static void vsc9959_tas_clock_adjust(struct ocelot *ocelot)
 	int port;
 	u32 val;
 
-	mutex_lock(&ocelot->tas_lock);
+	mutex_lock(&ocelot->fwd_domain_lock);
 
 	for (port = 0; port < ocelot->num_phys_ports; port++) {
 		ocelot_port = ocelot->ports[port];
@@ -1563,7 +1559,7 @@ static void vsc9959_tas_clock_adjust(struct ocelot *ocelot)
 			       QSYS_TAG_CONFIG_ENABLE,
 			       QSYS_TAG_CONFIG, port);
 	}
-	mutex_unlock(&ocelot->tas_lock);
+	mutex_unlock(&ocelot->fwd_domain_lock);
 }
 
 static int vsc9959_qos_port_cbs_set(struct dsa_switch *ds, int port,
@@ -1634,6 +1630,18 @@ static int vsc9959_qos_query_caps(struct tc_query_caps_base *base)
 	}
 }
 
+static int vsc9959_qos_port_mqprio(struct ocelot *ocelot, int port,
+				   struct tc_mqprio_qopt_offload *mqprio)
+{
+	int ret;
+
+	mutex_lock(&ocelot->fwd_domain_lock);
+	ret = ocelot_port_mqprio(ocelot, port, mqprio);
+	mutex_unlock(&ocelot->fwd_domain_lock);
+
+	return ret;
+}
+
 static int vsc9959_port_setup_tc(struct dsa_switch *ds, int port,
 				 enum tc_setup_type type,
 				 void *type_data)
@@ -1646,7 +1654,7 @@ static int vsc9959_port_setup_tc(struct dsa_switch *ds, int port,
 	case TC_SETUP_QDISC_TAPRIO:
 		return vsc9959_qos_port_tas_set(ocelot, port, type_data);
 	case TC_SETUP_QDISC_MQPRIO:
-		return ocelot_port_mqprio(ocelot, port, type_data);
+		return vsc9959_qos_port_mqprio(ocelot, port, type_data);
 	case TC_SETUP_QDISC_CBS:
 		return vsc9959_qos_port_cbs_set(ds, port, type_data);
 	default:
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 2fa833d041ba..56ccbd4c37fe 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -2927,7 +2927,6 @@ int ocelot_init(struct ocelot *ocelot)
 
 	mutex_init(&ocelot->mact_lock);
 	mutex_init(&ocelot->fwd_domain_lock);
-	mutex_init(&ocelot->tas_lock);
 	spin_lock_init(&ocelot->ptp_clock_lock);
 	spin_lock_init(&ocelot->ts_id_lock);
 
diff --git a/drivers/net/ethernet/mscc/ocelot_mm.c b/drivers/net/ethernet/mscc/ocelot_mm.c
index fb3145118d68..f3c0e6c32934 100644
--- a/drivers/net/ethernet/mscc/ocelot_mm.c
+++ b/drivers/net/ethernet/mscc/ocelot_mm.c
@@ -89,17 +89,14 @@ void ocelot_port_change_fp(struct ocelot *ocelot, int port,
 {
 	struct ocelot_mm_state *mm = &ocelot->mm[port];
 
-	mutex_lock(&ocelot->fwd_domain_lock);
+	lockdep_assert_held(&ocelot->fwd_domain_lock);
 
 	if (mm->preemptible_tcs == preemptible_tcs)
-		goto out_unlock;
+		return;
 
 	mm->preemptible_tcs = preemptible_tcs;
 
 	ocelot_port_update_active_preemptible_tcs(ocelot, port);
-
-out_unlock:
-	mutex_unlock(&ocelot->fwd_domain_lock);
 }
 
 static void ocelot_mm_update_port_status(struct ocelot *ocelot, int port)
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 22aae505c813..eb5f8914a66c 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -863,12 +863,12 @@ struct ocelot {
 	struct mutex			stat_view_lock;
 	/* Lock for serializing access to the MAC table */
 	struct mutex			mact_lock;
-	/* Lock for serializing forwarding domain changes */
+	/* Lock for serializing forwarding domain changes, including the
+	 * configuration of the Time-Aware Shaper, MAC Merge layer and
+	 * cut-through forwarding, on which it depends
+	 */
 	struct mutex			fwd_domain_lock;
 
-	/* Lock for serializing Time-Aware Shaper changes */
-	struct mutex			tas_lock;
-
 	struct workqueue_struct		*owq;
 
 	u8				ptp:1;
-- 
2.34.1

