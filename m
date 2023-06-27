Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B9974013D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjF0QcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjF0Qbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:31:52 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA283AB2;
        Tue, 27 Jun 2023 09:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsdFI4WgKG1K0dMUhUvBoHC02NZTtlIKKZ1ephCpx8UJXvcuXwhfSfwpgdzZyVg6urISqMEttbpDSsAOWhgQgHJ5Kfo2HtDvSiaNivQTOFtxjVu/4I5ceVd02LnOI3W/hnv3DltY3PLTpN6ge+fCxlo8PIIwt1cxoQ5Pul7p2ppGqSF6xx9+iDnCWAR0AK1LqIEbIx0Xr5bJk5ddr9weoydl+6bXxzTHYE560T4LGoMppXJqb33jepQ7TuBujjXclz9jX08BawKgJL+7ilfrMgTlElNXSvPEc8UfuZzrKT7LyJM5MaBUrnR0yW77t59mtlKVP69ydfadxd9IfN1LlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb/bNxr5qDDU+4/yXYImJYFMcP2Sz2XQqYzvM23C2LE=;
 b=VqRSvDvC1iiiyYMHhDXBE1WHaGyFZoalw9iFWucrmnomFsLfOAfdNr+PtsKpanadthH2PG8ytpzs6yamEMEUQXifIfEDTsSSDDRs2qrmvi7s6wJYAvdgW60EPLh1zhSyBNq8H6+xcxLRKjxOZmzuPlvgZuDC+gL9xGJ4X0FYLP2ucxU00Ij0Xy86c4ZbBOBkY/9cEJQUtqHe8ZKZ1jE4FSXYeXOIpWiV8gmQYxCT2A9GL9BapKztlg/4iSwIvpGDz0kqly0Wd+29RuooZA5ICqvZoE2NG7b34TDoaVqKsfvUoe+hTkMXINPls5zoOf/RmArQl9cF2bTYMUUOMAf3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb/bNxr5qDDU+4/yXYImJYFMcP2Sz2XQqYzvM23C2LE=;
 b=coOSJRjMAJKLMV7nE3FyIftZimQoO0TnvhQMqHHe9TQq6WKA4Pn0EulkOjtZAFd8R295IxsqV8DNUbUmouLJkmIkFY5hMAWUgqKojvbZOW7DRqH3xjMINMsiWDwn9rQkcRdlXkKoSWz9XFkYD53nDozoWVhFLKhJF1Sw0LGxpbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB7314.eurprd04.prod.outlook.com (2603:10a6:20b:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 16:31:30 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 16:31:30 +0000
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
Subject: [PATCH v2 net 2/3] net: mscc: ocelot: don't keep PTP configuration of all ports in single structure
Date:   Tue, 27 Jun 2023 19:31:13 +0300
Message-Id: <20230627163114.3561597-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627163114.3561597-1-vladimir.oltean@nxp.com>
References: <20230627163114.3561597-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM8PR04MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: ba184ade-b452-49d1-c94a-08db772bf68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAeL96Z/Sc53Y4+p2ZaZszJf4nDihwHCgtxL5F3BaAxn62EQ1UiogeK2dTwDXOuMkc160Cwdbdj2OuSC6k/BgagXLEsPuaYJtgcUkTw/wxTWKUXv0zDF5eLnRgE7ybN2m7lVagYVfnCJGvEIBK3EgE5bJUfuU1cz3MqnESgKhH8AKRUhIq/d70sLl8zDUFIwoPPLzA4/6G8oMpvZ82g7oswuamEhkPr9XGSlP+0PyhYSBbniUch55aEmGlyDVlkZZBgUrzva0XNIhpDRikxQ9dETc616ERg2oeiA0Ko9heZRA92Ns6K84wGdD4lEwz9e1o5F0yXzpLciahbVBvkf926eQDbBVS4PD4yNsLLrFHpgt6f8pMlvi0xBetAKY57H2oGGwzzjvfIUKvQevDc4OHoZT2R4AekVkn0eNyFZ4tE8mw5ebNUqmhwdh18sgeXy5lRbZDDJbA1k0CrhwOWy+/fE9F8JIhy+OHKmXCp6nz1uY60vWdZzhyKnDxSahN9vBl2bJhV4yKPAGgnzI7Jvs49EjJ+DDYWf6Dnu/CVRWQ5tiDVPug8upgZYwlcxTYUdYTR0/mzqyOZz0ampy4kdyCJc/7pubJ2R/WPW7xcvt0M9EY3Eb2CkxMVy9kiEkE7Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6512007)(1076003)(44832011)(7416002)(66556008)(4326008)(6916009)(66946007)(478600001)(316002)(36756003)(8936002)(66476007)(5660300002)(8676002)(2906002)(86362001)(54906003)(41300700001)(26005)(52116002)(6486002)(186003)(6506007)(38100700002)(6666004)(38350700002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jqUyazhrVOiGUdN1c/3zlIIIediC9rRsxnln/IhgIO6noi6UX0poPxtLRhWn?=
 =?us-ascii?Q?FvzwuuTZ7tUvMC+dBi9cK8c/2yHifiCQdSbinCa4ypseQGXgZfq9SelZ3Fik?=
 =?us-ascii?Q?nq9vep4GVhxmCM7N/aNNNNUed/uGR5xzz/I5WCo/s2LDzA+1mAtY1nQ1PMvs?=
 =?us-ascii?Q?otDOK/8+NYn2/SG6acCjRXhnr9yA4AFzeKiVeAuQiIhyPKKkYnF7kAhTg+CT?=
 =?us-ascii?Q?NZZlF3NmjF3kRkOljNR6LpJ6v5y6ZazM4OibYhX7w+tFEa6R49vrQ6bUg4cM?=
 =?us-ascii?Q?p5KnMdiMQNFOba4FY6EHXsTyS/Jgwp3c6mBBIRBwNguEEqrM6Pg/AdRPKymf?=
 =?us-ascii?Q?wIIWJfQHv8wObx3cod8DNV8K95Cz84tWDTB4O5UGFlUafZVZgDyXC6S1LWeC?=
 =?us-ascii?Q?4pVaoVnZ5lCTP71EK24AY8nfdUxtA6My0W3yAi+oczNzJYtMu5mg0R6mfxSE?=
 =?us-ascii?Q?7nRx2fQwU4gX8SYBWJxpet0J87ViNMp/vksGl8zoigded5TUwLTHDNGyYf09?=
 =?us-ascii?Q?R1gIBqkKHIFur53aupLu9rYjqrQYaR+jiBiutuiLMBXMGIm+3kSZsK0o4LM5?=
 =?us-ascii?Q?7ohwI/1ywzjrhLskXsmCmkPk59+AYZlxUZo9tKahUbtBETZx3Z021UyN48y1?=
 =?us-ascii?Q?ra6uLOtmv+MTDLVMYpp/avsNAyyXgyCs+KK5Vfqv5szNGWOya1hNlL4YMB/V?=
 =?us-ascii?Q?uYMezljagS52uoH5eU9wsiXXbVYYtcMa6F7O/Eg3mmzPjlWoUFDLJD4Cb1V5?=
 =?us-ascii?Q?Gd3X2VJLoB0rzofOqL7WNi88tJsfh9wTFhA0JgFOaWhhcPsxgzikVQSlKsPi?=
 =?us-ascii?Q?26/AzbjbUJZxsLm8HyFgJNtfufA3+xRSzZTJc4eV+2fQUnSLEGKGkUu5EXjD?=
 =?us-ascii?Q?hyWjGmizCB9DlJIad0Hqoh8CRH1eEk5QsdBChHUW4PTgVr54UkcGqRLFEeOY?=
 =?us-ascii?Q?EVdPLMp3ElAMbz2j+4PbF2GeGlD0zRZtquVTm2sxVS3LC/Mb061QFuSdtXbL?=
 =?us-ascii?Q?kSVlpoS50ec96nj19p5KxRmNuSlEG8DHnUnLNgvjsC8zLOm0G169P4CUzdIs?=
 =?us-ascii?Q?pgGyVOmxC/jtwk3T2O3aZ3ndJyl7E7RA/I2sXPLYOUqE8IIpQJUDTTIZB1JB?=
 =?us-ascii?Q?5Dqybamv+3vo7gsX0AgIZGtJz9aqIHtDOo9yDju96bq7DwItmRZQxNIe1fZ4?=
 =?us-ascii?Q?GKbo3OGuYgSpIVKDt5G0do0AP3FAncATxmJmQ+K0W4IbI94pE3T421OLRree?=
 =?us-ascii?Q?qv2VmuMaBNi5W++9RyaD/g9qLm4QPLhOGZ3kJ1xAA/V4xqLafuuRH42a4U4z?=
 =?us-ascii?Q?mmugve4pjeZfrESoW7BBzDYAJSKpMIj7vCY6CebN0lut0Fy7LcFLjtfnhoGx?=
 =?us-ascii?Q?VF/BJxj8EYXjL8xw0WDnq8NmckA+P+5HM6kTednQIbi2nmWcA150W9kEQ7n1?=
 =?us-ascii?Q?gvxZBMDWpNx1s5KSbl5lKNgK3YPzxU8Nr0dpmiAnSviBrVGEI+Ip06NwbKUS?=
 =?us-ascii?Q?Au/htsj49Js44o3KooIuum/X2Oh1tWvNDBa4OQ2UdpialOEi0e3gQ98AvoIM?=
 =?us-ascii?Q?siG3Me2Y5sAAHbja3nE30XXOlJXlAcqS+dUfHL5oKaO5xs1Y3GAX1v3crLvG?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba184ade-b452-49d1-c94a-08db772bf68b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 16:31:30.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCCNk85RPUMmvFjBasjC8y71TcU7JSooedj345AwrpWUEy5erHL8Uh6vfTYIoVSKLdwItuMw0WurM1zM9FLs8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
common structure, so replace the hwtstamp_config with a mask of trapped
protocols saved per port. We also have the ptp_cmd to distinguish
between one-step and two-step PTP timestamping, so with those 2 bits of
information we can fully reconstruct a descriptive struct
hwtstamp_config for each port, during the SIOCGHWTSTAMP ioctl.

Fixes: 4e3b0468e6d7 ("net: mscc: PTP Hardware Clock (PHC) support")
Fixes: 96ca08c05838 ("net: mscc: ocelot: set up traps for PTP packets")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: replace the ocelot_port->ptp_rx_filters (bit mask of UAPI enum
hwtstamp_rx_filters) with the hardware-specific trap_proto (bit mask of
enum ocelot_proto). This makes it easier for the next patch to
distinguish between L2 and L4 PTP (not easy when saving the UAPI format).

 drivers/net/ethernet/mscc/ocelot.c     |  1 -
 drivers/net/ethernet/mscc/ocelot_ptp.c | 61 +++++++++++++++++---------
 include/soc/mscc/ocelot.h              | 10 +++--
 3 files changed, 48 insertions(+), 24 deletions(-)

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
index 673bfd70867a..cb32234a5bf1 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -439,8 +439,12 @@ static int ocelot_ipv6_ptp_trap_del(struct ocelot *ocelot, int port)
 static int ocelot_setup_ptp_traps(struct ocelot *ocelot, int port,
 				  bool l2, bool l4)
 {
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
 	int err;
 
+	ocelot_port->trap_proto &= ~(OCELOT_PROTO_PTP_L2 |
+				     OCELOT_PROTO_PTP_L4);
+
 	if (l2)
 		err = ocelot_l2_ptp_trap_add(ocelot, port);
 	else
@@ -464,6 +468,11 @@ static int ocelot_setup_ptp_traps(struct ocelot *ocelot, int port,
 	if (err)
 		return err;
 
+	if (l2)
+		ocelot_port->trap_proto |= OCELOT_PROTO_PTP_L2;
+	if (l4)
+		ocelot_port->trap_proto |= OCELOT_PROTO_PTP_L4;
+
 	return 0;
 
 err_ipv6:
@@ -474,10 +483,38 @@ static int ocelot_setup_ptp_traps(struct ocelot *ocelot, int port,
 	return err;
 }
 
+static int ocelot_traps_to_ptp_rx_filter(unsigned int proto)
+{
+	if ((proto & OCELOT_PROTO_PTP_L2) && (proto & OCELOT_PROTO_PTP_L4))
+		return HWTSTAMP_FILTER_PTP_V2_EVENT;
+	else if (proto & OCELOT_PROTO_PTP_L2)
+		return HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+	else if (proto & OCELOT_PROTO_PTP_L4)
+		return HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+
+	return HWTSTAMP_FILTER_NONE;
+}
+
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
+	cfg.rx_filter = ocelot_traps_to_ptp_rx_filter(ocelot_port->trap_proto);
+
+	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
 EXPORT_SYMBOL(ocelot_hwstamp_get);
 
@@ -509,8 +546,6 @@ int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	mutex_lock(&ocelot->ptp_lock);
-
 	switch (cfg.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
@@ -531,28 +566,14 @@ int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
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
-
-	if (l2 && l4)
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-	else if (l2)
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
-	else if (l4)
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
-	else
-		cfg.rx_filter = HWTSTAMP_FILTER_NONE;
 
-	/* Commit back the result & save it */
-	memcpy(&ocelot->hwtstamp_config, &cfg, sizeof(cfg));
-	mutex_unlock(&ocelot->ptp_lock);
+	cfg.rx_filter = ocelot_traps_to_ptp_rx_filter(ocelot_port->trap_proto);
 
 	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index cb8fbb241879..22aae505c813 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -730,6 +730,11 @@ enum macaccess_entry_type {
 	ENTRYTYPE_MACv6,
 };
 
+enum ocelot_proto {
+	OCELOT_PROTO_PTP_L2 = BIT(0),
+	OCELOT_PROTO_PTP_L4 = BIT(1),
+};
+
 #define OCELOT_QUIRK_PCS_PERFORMS_RATE_ADAPTATION	BIT(0)
 #define OCELOT_QUIRK_QSGMII_PORTS_MUST_BE_UP		BIT(1)
 
@@ -775,6 +780,8 @@ struct ocelot_port {
 	unsigned int			ptp_skbs_in_flight;
 	struct sk_buff_head		tx_skbs;
 
+	unsigned int			trap_proto;
+
 	u16				mrp_ring_id;
 
 	u8				ptp_cmd;
@@ -868,12 +875,9 @@ struct ocelot {
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

