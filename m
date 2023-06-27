Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00E673F8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjF0Jmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjF0JmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:42:25 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A93C2691;
        Tue, 27 Jun 2023 02:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcXdwQjMWa/4Okx7SkjyyY+jq1ZOwx6T9kJqhrZb6OuPISk+RuGW1JQO/9T3bo8OQUeduKkHUJxs8tkQLI7xkEyVKiaSKt5eHw0NrGdDRDmv+5Y+K4a/e9dxtSk7LjoyiThkC35PRtNf8T6jRyUuPm7ZVgDZ2A4mCHF3DG4/Povj/ZHc+KdWq3x/vnCnZ26GOdChIp34VChbK1P9gAAPrDORrqFQf7qlxg5QoXYr9OMTpqYWJ2XSYsL8PPj7K9uMWF9UBrUCwe+vq/83voN1pFpeGnEzLRROHei7P0XlTnQ4gX+bZPTQn1rqkZBbqBaa0UhflhszhEKJXvJdyZIu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je1R3dawm0SCMBrKNkM3vgdMSIJLnZktkKd6KGNY/Ps=;
 b=AeL3ZXqFzAabULuwARjiWXvwz/AsWDEqYLj/xma3q7kX3aYhpeAO3P803RmDS/LMHRNhXgwXqPQDetZNRbIYaxQIZu2/ryPI+qrMFh9HFja+qwZ70VJDGF43rdxoCUoAnX/MFHWPlLvIfJWo7oOT/LK3caRI5FBFkHbkTB2F33ewSoF8Oy/jhvkVJv0ckM7cSZYDyHovLIYKdviaTshMNAlWBrdLKp8Wn79yKEUl0HeqbFIiv5K0EODMEi2TUcNBzf57H4oEqctrBzblOOImBxKMHdaBXw4a8F0Ld0T7N4LdH3fg56TrrqM4U0fUct8NASAw5XxTKGo7rF0RIgreiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je1R3dawm0SCMBrKNkM3vgdMSIJLnZktkKd6KGNY/Ps=;
 b=CYWYWiqAPjkpDqJsQOXlze3MvEs3TeGJZ8NvEivwkHolqTrwVY1tNM17D9xY18EMeV8P33vJ1me1UzMOamJnfiV21SoQv2vYJEkysEhKN8bJ1X1JXGQJ64Kk0S67OB5078agcSuA0iJ7AEqg12WqZmWIfyQ+flJcm1eJn03bWaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8649.eurprd04.prod.outlook.com (2603:10a6:20b:43c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:42:19 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:42:19 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 1/2] net: dsa: sja1105: always enable the INCL_SRCPT option
Date:   Tue, 27 Jun 2023 12:42:06 +0300
Message-Id: <20230627094207.3385231-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 6180281a-fc24-49e1-5983-08db76f2ccde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VgABiZ5l44s5pjKJUzndHt3e4thpgrCqDXK9n5Vq+a814TK4qrOHn7rojvGmaKCCFs+Mnqnbw/SKqTHyu5ymIlCzhQlMAeRj5htvTNa6Y2Wk+L3n5IwF5Gso3Df/wfvnqX7vDU3MKN22e1zrLMRrA08gZfUN1F5utLGqaxsGqNrk+LmW6T7RN0FM/++ZaE3vK/52Qbeh981pcO0Y+ejV0kZJ9InJfAHtF/nZTZUBRSx1khSwJHkd0gXjNuM/+Q7RX6EzgLmGW2umhvJzOP6VXOizXUa5tlqNDQ2V5+N89bveYulvkADrYCrv4xs5FS5BGEGoWuTL6GJT1JwgbKTGy+DnIv1X46v/bKssx890plWiCPDlBWTqb8jBEudQlatyDgMFUS770G9AAUkbAIkNEF0VGlLYjOPpI39ah/xwcBDyVUMftbeGrOu15UTXIcUW93fcEWpOtxFXsuraUWHH32OfN2IReNhgZXm/rCg8jJP2giiNsxfraRk1mH2msbbpJSXJ85F02X63oA6/dy8Ui2k4U5X5Yg9FGrlnTC80cvWN+Z4PSJ69Ci5W0jKp/6uV1OANA/fPO42LBttqpg0+giLGTaTv0CXbYiqS3N7U1EriBaymY2yFx8cqeVAYMPy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(1076003)(52116002)(6486002)(38100700002)(26005)(83380400001)(2616005)(6666004)(38350700002)(186003)(6506007)(6512007)(41300700001)(2906002)(86362001)(54906003)(478600001)(4326008)(316002)(66946007)(66476007)(6916009)(66556008)(44832011)(8936002)(36756003)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TPCikLw77vq6U+8T54ieBA2tlKwUXPPBi430jhC613siPb16qKkQgQRrj7L/?=
 =?us-ascii?Q?hR5SL4vRAjFEi3MebD+VKHoyyhcJA+6iQrj95oRTNVPqQ7mWZZQreH2UWmd3?=
 =?us-ascii?Q?6B8VtHt1K78pESKl2NVScOx/ExRDwgDa3pHH0nsjm8wte1jkgmT+utux1sAP?=
 =?us-ascii?Q?tzrjGuvghZrnJ9rYoT4a1jMnvx+KNDuGS7laBn/O/6iiewFGJYtHWgydQu2S?=
 =?us-ascii?Q?A11LxLPMOLc/4g/CBWotAqPPZqfFVWmmwV8DH8h7wPuuNff+EMxCg9vJdJNd?=
 =?us-ascii?Q?gc0bMBvghr/KAZ+Yn8g+lyTI1dOIsG80+ysIRjKWxqVjpf2gKEHGt02/lhVu?=
 =?us-ascii?Q?xtO2XZNWA7nw0sXQoHSaiVagPhqTIEaYmbApe91e/i2yC2dm09jMGj/w1aBc?=
 =?us-ascii?Q?QPQKQV9rGkO1KH+fYaTQG3FXICbTqZJKseIuQNyCB53Ob0ouk2YXPQ5PTtRz?=
 =?us-ascii?Q?F1Jsiyr2Yr7k6+loxy4A38yFgHbokI0xeMIrKOKhGdvaqHS7p9FeBjCWEXAO?=
 =?us-ascii?Q?zQkbOFmGq8/qMqN9PBqy2NBiG4Yr6yF4PXLYGmiJ6aCctR6cHPDEXYX1spjo?=
 =?us-ascii?Q?E3p9u/nuT0C+N7Gxzmqd+U9vRxv4BdqEWpTvPPc3dXHQ71O/xERSok+Zy3Mj?=
 =?us-ascii?Q?lP/2GwnjGqhpDYsQiVkUjw9PvaIRJcwOTWmXuCQKqppHGZNMkc10Nqp+okEL?=
 =?us-ascii?Q?Ef8Q7XXm7WJm3BefbOmjnlzxqklJ4IXrhIyvi7rO8QESyZ731kcOsGuSWxTU?=
 =?us-ascii?Q?ie8sY2ydsC6nwgvHtZoIPyTHZKMT07evjCBucP/IPlE3iNGvnc3NFt9MT2tI?=
 =?us-ascii?Q?etLvLADrqifO/t7RMrJ6ejIk2bhyaeeJOwCWGy0sMV+WQz8WqL7+kHlejfIw?=
 =?us-ascii?Q?ir3w1zlFYwNE/051eaDVXom+3XES+cadI4/eAQifnXMQikHtAdCGK96RPHrM?=
 =?us-ascii?Q?KPNf5DRPg17qTiSVTEopfhEcDNIy1RUEuObKh2UavD1oWkC4rpD+kMIsAN3S?=
 =?us-ascii?Q?Bfm7+i7coGOmhlSvkA/zxwKAGj8GzzlzZN4jO53XKNxYCJHqiS8CU9ia007A?=
 =?us-ascii?Q?GP70Ao7qgl3sf4mIQXAqSzWa14/oIf/PWKPzpFAkV0QmpaV8XDPdNgcMDHDY?=
 =?us-ascii?Q?vwVFob2a2Nmfo98Rk7wmEiHMns/W7B4HbSL/AiorBXuwQNtTTM16/qsfHi4Z?=
 =?us-ascii?Q?RqUbv7Iz0DsoDSCnfinIawKhZRIfWBQr4sx3b8uwVxXk1/4JvvIQpngheKPE?=
 =?us-ascii?Q?Zzv0ySAhHsyrIrKYCPuuP77AOngCxh4TNLzqTXliY+uVy4Mq2Ho00/8NCYjX?=
 =?us-ascii?Q?tzNaO9gvABAoRdrXfa7UvnIpOE5gv4Tt0YfyFEYc1V7Rg3MqCRPoJrI0CesB?=
 =?us-ascii?Q?8nz22BhcNy+j/dV/RxmVmAtm6fVuVYdaPMQKOiMpz+8QusEE4Pb4pNBvJPLd?=
 =?us-ascii?Q?+q/BcBk0oVaZZO86LJQ3b9MAsdjxcLWxTKtWqXXJqtZcGeHxDbKOyndeCeaP?=
 =?us-ascii?Q?B7kIPfeW+9WQGePYTrjfMaXN6lIoVPoLjSOVSGOWvtRYO6xvumSl1YojPTGR?=
 =?us-ascii?Q?Xm99z88JuA6O14BkJqIOlf9XvZgi24KJqcc3ImIoxbdsg0kLZl3bW6NLcEsm?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6180281a-fc24-49e1-5983-08db76f2ccde
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:42:19.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIzOKplKLkI6xwEcJv08vLsU98GsR7bEoEfA+VNP27Tn8P3/bAjTxlGOqvXued1Ns4z/yATRcIwIW7jzjoeLNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
v1->v2: none

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

