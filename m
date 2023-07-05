Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC51A748269
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjGEKou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjGEKor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:44:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1D5E63;
        Wed,  5 Jul 2023 03:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=no0rrri9gPW9IKXp6PL7VoDNz2eFWsEoX6BtKVht/8YDvVd6Mpb18kXbKyP8i+zKlo5qQGvyFHuz2Sd5AOXa8mqkk0IURUTCKg/VF+Z5uj8Y7HApi58Hez8jUtBDFQ1rpplj9sxYZMzEDE+Xu8zSy0pWRjbeEZGAZzB0uo2PPU4oErP66x4rPaiJ1swmamZmhUJepjHznWqvUXvXfbqEpsm0mJlTQ9S7+LdwQia4D/CniQxZnr+lfv8PleV9qjGjGsAZmr/LNeHc5tQsL+0ukundPlIZRg3jf1PmYn8vwXo4xOelwrJhaV1l/D5px/9oR4ZS+vjHkFzJQfhcmJbiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vjzePaioeTsDkh9vjTg1zeoZRJlJBcp/yfubCCw9Ns=;
 b=fm09asZsksxRB/BdvCVPl9+M3vQFYXC1XsVI+eIMTTojXUtjHgKNMIXMziCWLBdC4l4jCVobnxmN5eG1FCFXh5hlmSxry6GMa4WEhh149JsDGNtipKt3evtt4jajLT4s6Nyot1L4MiTY6KwisIH7k4Uj65DYecmvtReJ9cRjGfpd5Z2pLMtWyb3u+KRGUjXj51n2yjrlVcpOXQWTyca1aos8Wxl+ds6YbBmAU+MeX7YoaNQqEw4eGNRfAMa0i+83EyEmy0LHqFzgdaQw/HMGsPAdWc84W0zE+VByjy5kSUGf7a9UR6Xlaypi/RgVzTjZokabxi1fK1Nxxl4RjB6oKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vjzePaioeTsDkh9vjTg1zeoZRJlJBcp/yfubCCw9Ns=;
 b=pnogOtat1wY0GBKzZPspmhWeqKPNUNQadE083n077gA9RNy/NRFPbnnQXDahsoA+9mjyHyAdSAczJXXyd+U9rg0xc5v6HlkwgimhTEVPQRs4dk1dvtWYDcyq5KCnxZ9V/fNnJNXRUSsaV17+8YKb0H2DFJY5CyUKWCoeNNQtudQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7658.eurprd04.prod.outlook.com (2603:10a6:10:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 10:44:42 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 10:44:42 +0000
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
Subject: [PATCH net 2/3] net: dsa: felix: make vsc9959_tas_guard_bands_update() visible to ocelot->ops
Date:   Wed,  5 Jul 2023 13:44:21 +0300
Message-Id: <20230705104422.49025-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc0a1e53-e54f-43d9-3c0d-08db7d44d6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zpev193K449akDb2N9kN8sFmFW7unvvv7Q+GZt3eS3t4UzlvTt+AM5LmSXXS8dhlQJXx6alXIiZ1ok7tKl2Nm47w/UL4wA5Xr2z3axWmbq3g2nsmrVM4en+b6E8q7ljwGDFlTxwjSIobZKbSNPSE3xurJtF6GrsdKaL8cIXkNkeF0HL69Z2lOwPfm5SgQ52EH33zpMZxo1H9SeG3VHZuXgioz1GTWvWtaWftIEzwccl+yiQaZ+hWZxOcWgWGQ0aNM6Yq2+WiSyYyCkJiG9mGJ3tgtt9THgE7ChcsOX0IblA1WngZbMCiq1cKqdz15c5GqUZQoW+2nZ7UY+Kh+5mEA3wT16X2dVvBo4ddeW9VyEnTg2JfyLMong0qOVuIUrG62NivEo/bIb656/DJ3ZF6hBYGHJ31v4mQwliQN7ojmcYpzS1QniL18fYbQ9uZRehLkVeNzkIz8oHn5+wtKbYtI80j0L73th+gYbK2YKC0Iuhss/mT8diflKIgC+4rsOOcgSBzlfwPTAGFBjplvJqMm91rzUxD7fACyYCewj7gsI/madktmDCt+cBl7Q+0jqU6a3rRJa6wpnVp/USh/KlianjHogHBsZO9j/F6nVmXLm8/SE6XXWj+PXk9nmJvFv32
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(41300700001)(478600001)(6512007)(54906003)(86362001)(52116002)(38350700002)(38100700002)(6666004)(6486002)(4326008)(36756003)(316002)(83380400001)(6916009)(66946007)(66556008)(66476007)(2906002)(8936002)(8676002)(2616005)(5660300002)(186003)(7416002)(44832011)(6506007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U6kN95WUdoQaRfnPk9N1cG0MqnlWCthLsboOX5TzwvnzgH025iOVXfpRGyo9?=
 =?us-ascii?Q?5VaniIO5BYYYELzNIoMW1HNshXFFaVm7pL5UsO6nT2jmQwdiJKtvlIPp7FVD?=
 =?us-ascii?Q?e4fHYZgUXGGNGrlhhs1mNTCG0nZcDOag7GA9A2nD7ac8jNjNepLNp0YS3jJo?=
 =?us-ascii?Q?lX//XX1lRS7Tp3Gq/EOusSQgn7IhxQqkSwYBgEnYE6zjw1wfRZd8mpDgYWfi?=
 =?us-ascii?Q?Y753JRbQZzMy7XJhc7KB3e13lXBGu/rffgXfRBfzcm1714qcT6EQ4dA0VjBQ?=
 =?us-ascii?Q?ba3+O5GUraZpOvyvuuzH3eag0bFLHUd1pRCaPYaOR0Zi5pcFnTTdfcf+tEFu?=
 =?us-ascii?Q?T8+lP3tGWELSZ8YqSomiJVpkAC0FGpaccfLtXe68zE11Ppxi4OHVamurVE3/?=
 =?us-ascii?Q?M7gme8pmhiiI8medUZnyo2+ZcCdptK6y3KLk4CoWCwyTrpJ8OaY34yvfvUc8?=
 =?us-ascii?Q?TqcViDVVkO/dMiCocJEsoR5rZmMgabjjk7EznDwUQhKWm13T2m29CmUovx3L?=
 =?us-ascii?Q?zdfh7cBCUfiTC0rnegWudxl4iPeMPHza6nYLHbDipUsByyxF2QnEOnpHZlBb?=
 =?us-ascii?Q?pIfKG6va0xOaPJ4VofWV8jOFivprw+KnxJfM0s5S9GgcqdXtk1MBKeLJwLnu?=
 =?us-ascii?Q?glKYJ2HVb98bnO6gnZ4mf6Xw7k5eZy/WvWSU8tXY1uFVq46CO2kzvgwE+97Z?=
 =?us-ascii?Q?tN5U1/b6VmnEvbDQ3xIyi9VHSl0edMNvlTQue6Mg2SwVJWuiVTsk/40CKCno?=
 =?us-ascii?Q?HXP5X21vdRekFZNPLfszuZ3aanBiKLU7hBJEiqb2x1RvdnuduBnL45HgEw5L?=
 =?us-ascii?Q?XWgmROxWD0Or2jqLODK8qFrcN6p571kxqTSXem/nt/2xanO2wJs27ev/pwLZ?=
 =?us-ascii?Q?+jZmt0Mi6EGQonlsdEBD8gce7Q+bSikgZDRM7vg05zBo6+3EbtJic9NGogDl?=
 =?us-ascii?Q?E7U9tZK0tJfAon9pjzkTIsrbonpgwsxGkngq4K+Vo9M9krndpNJwt8z3+23m?=
 =?us-ascii?Q?6PTX4bd4eO6nv7aHOX/4Cq6m49uJ/MxI9WKsuczSQwjgriuDWECosyojNpD7?=
 =?us-ascii?Q?b0k55PoDdCG+ynGHfFFFLQ1q0303KpD4rYOPRkZKbNqfKTock2BvfTgOGU6+?=
 =?us-ascii?Q?eu5dCU6FXixz7eKcsENiGqI2uCRvNn1vCvJ8bIiHqmE05ut3Kq6BrpoL+j2T?=
 =?us-ascii?Q?xxURt3Cuk84UXz90C6ke8gMw4JHHcdejnO3J3j2vacWmK+5syfiR2gxZBDE7?=
 =?us-ascii?Q?/qR6oh26zigxq2753X1IlfmH15eBv5OZ4Ib6yeRXbw2hGG4SQW0IkbOUm+fM?=
 =?us-ascii?Q?H6WVEQpeOxhQrfzJz8gqyDIaM25dRd48tuKovsU64BgFlGfFM6KfmnK28556?=
 =?us-ascii?Q?kKnHOYO/7WHKwYC9tOq7v5G9pZTA5SHH6MVdfJS0YW66P73yYUqz0b/Pfeis?=
 =?us-ascii?Q?MydL1IhjYFeMsC9Xv8E2XgN4ADSYM0qcUNUXrwCQTlHkiun4u8G3B1b+UnHe?=
 =?us-ascii?Q?DeI/3iDZxGVPdO+XfvJcIf8cygDbf1HHcmepFaWBVtOeLJq3opXY6RRISaAN?=
 =?us-ascii?Q?lh7PqSzOeqJtexUCE1eHBGuUiM0P7kQpekvU4lLiEHj1QpMMyn/IB2HckJyi?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0a1e53-e54f-43d9-3c0d-08db7d44d6d8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 10:44:42.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWOioqcXfO2wSud8BaycCwvmEbKqpPMKPs38bteWHyw0xRZySJM0VKp/7kUFrTRWq5Fxr6tCBz17jSrZnx1FTQ==
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

In a future change we will need to make
ocelot_port_update_active_preemptible_tcs() call
vsc9959_tas_guard_bands_update(), but that is currently not possible,
since the ocelot switch lib does not have access to functions private to
the DSA wrapper.

Move the pointer to vsc9959_tas_guard_bands_update() from felix->info
(which is private to the DSA driver) to ocelot->ops (which is also
visible to the ocelot switch lib).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c         | 5 ++---
 drivers/net/dsa/ocelot/felix.h         | 1 -
 drivers/net/dsa/ocelot/felix_vsc9959.c | 2 +-
 include/soc/mscc/ocelot.h              | 1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 0c1207613aa4..dee43caee19e 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1786,14 +1786,13 @@ static int felix_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
 	struct ocelot *ocelot = ds->priv;
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
-	struct felix *felix = ocelot_to_felix(ocelot);
 
 	ocelot_port_set_maxlen(ocelot, port, new_mtu);
 
 	mutex_lock(&ocelot->fwd_domain_lock);
 
-	if (ocelot_port->taprio && felix->info->tas_guard_bands_update)
-		felix->info->tas_guard_bands_update(ocelot, port);
+	if (ocelot_port->taprio && ocelot->ops->tas_guard_bands_update)
+		ocelot->ops->tas_guard_bands_update(ocelot, port);
 
 	mutex_unlock(&ocelot->fwd_domain_lock);
 
diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index 96008c046da5..1d4befe7cfe8 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -57,7 +57,6 @@ struct felix_info {
 	void	(*mdio_bus_free)(struct ocelot *ocelot);
 	int	(*port_setup_tc)(struct dsa_switch *ds, int port,
 				 enum tc_setup_type type, void *type_data);
-	void	(*tas_guard_bands_update)(struct ocelot *ocelot, int port);
 	void	(*port_sched_speed_set)(struct ocelot *ocelot, int port,
 					u32 speed);
 	void	(*phylink_mac_config)(struct ocelot *ocelot, int port,
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 56b8bcac9690..d7caadd13f83 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -2599,6 +2599,7 @@ static const struct ocelot_ops vsc9959_ops = {
 	.cut_through_fwd	= vsc9959_cut_through_fwd,
 	.tas_clock_adjust	= vsc9959_tas_clock_adjust,
 	.update_stats		= vsc9959_update_stats,
+	.tas_guard_bands_update	= vsc9959_tas_guard_bands_update,
 };
 
 static const struct felix_info felix_info_vsc9959 = {
@@ -2624,7 +2625,6 @@ static const struct felix_info felix_info_vsc9959 = {
 	.port_modes		= vsc9959_port_modes,
 	.port_setup_tc		= vsc9959_port_setup_tc,
 	.port_sched_speed_set	= vsc9959_sched_speed_set,
-	.tas_guard_bands_update	= vsc9959_tas_guard_bands_update,
 };
 
 /* The INTB interrupt is shared between for PTP TX timestamp availability
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index eb5f8914a66c..a8c2817335b9 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -663,6 +663,7 @@ struct ocelot_ops {
 			      struct flow_stats *stats);
 	void (*cut_through_fwd)(struct ocelot *ocelot);
 	void (*tas_clock_adjust)(struct ocelot *ocelot);
+	void (*tas_guard_bands_update)(struct ocelot *ocelot, int port);
 	void (*update_stats)(struct ocelot *ocelot);
 };
 
-- 
2.34.1

