Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E873B1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjFWHnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjFWHn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:43:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ADF2960;
        Fri, 23 Jun 2023 00:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4i+jDxWS5ew7Z1CUkYZCp/X0qpuzh6Qjd/I8T296qcM/2Yey3+ti/nqqNrlrALzaOZSmL3PpLFgsINPcYx1dzHZMEzqANz2izUV7zEp0n950wcoCZ+xEIvQxwkbswGyu/Yr6X0UwvnSrGmkT9mogmi/nDBHiw9KzTJU12dUL94qgLydWYr8RqcNPF9LesQTakQZENdhFi8SET9kKVeFIHDNdri0D+nJYNDd6lKwGlDDnQF8JcLLONgOI+qb52c/DLaBpJ0jc3JxD1zVxkGp2CCdln3N0jCEfpTWR7NOe0XX5rUVGY7pubIXmUma3IB9nVPSbJc0V5Rs//oSYdeJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2g0fb1172GK4ABjgxvLY+znQ8tE7RtwzRD3BA0IOnA=;
 b=W6M3EFG4Xh0RpNCV7HW/Q8slDZny5RUNgng5teonz2JMkqWrdgA4yI0TNWfnsc9s7ppVl+Xh/jIguIFFb3JLvFQmm6pemQmmKcyTR0ZsNsZCbVLV3MWaMzwe+x3jxDJ6kIfGpLKs0k3Rn9zCa9NImtkfVhTYOouVXJEqTue0m1h04/p2z/D1GelqbuhVYpmc+/IarUog/9B1uSIA65v846kZqnXICcPk8jZ2BVdY4NIsNipINtwVQC803IRsN+p1R731iB+BTygdwDg266NW4F7crWxh1lV0BO0j8qKJjr6VxXwRli7Et/su8UB5Hdrn6TiMzSX7dZF2D7MfGqds6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2g0fb1172GK4ABjgxvLY+znQ8tE7RtwzRD3BA0IOnA=;
 b=CQT8QCtEsXka1nSrnI4u0B0I5QI7mLu802Mm7M/VSTp+j/Y7IVIAEsetKqudv2Z/XzTVg5AZWC4g+zJjxTHlPj+1piTTUoY+50+ox8ZtfhUAee3/IRqB0a0QjUopgYfCM0SRs2OHddTlE3NXE8tIOu1dZ7O2NRSq+vQKNYSj04A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:41:51 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:50 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 13/13] net: phy: nxp-c45-tja11xx: reset PCS if the link goes down
Date:   Fri, 23 Jun 2023 10:41:23 +0300
Message-Id: <20230623074123.152931-14-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VI1PR04MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c5c0a8-08bb-4fa0-da2b-08db73bd4e98
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5S45L2u/7kfM6z6RaCcFwdZcQ6SmwkGCtJdBWMJpP9HxKeuyr/sbikUJxp1Uv4jI8x6f165Dyb/BxG9VjPHVCGZdd/eXsv145SWK0Clz5Mcvbdog4dWOiBwrJ9S1UzXevsMAq/LkB3a+nmiInFcI96FCMsnRprdsQYzco81INQtICsCkIA8sszHpvS5tYsm5ZqcwlaKGufe3LIIiJ8EvXQPyjpT75S2+TwzMPudhf2UPC0tglUQ+MMZgFYwx87aVSAbDpq27qjvYmh6yh19b80h/AHS0ZPAeKfdPzbaJ3IR19aK8HZB4tCARqwEFA+jt+dibgBTUgAV0aMV+DM3689hgmDif1oyZUUNTpPQ6jgkA4nS/Ubkv6tsP5rUOl5YE25ntRqn+LAfQR2jZ8838Mvla4dF9WD2OzQmG4CJLTETUkwISUPeViwbIqkr1i6bX6iGa01z1DYTz2BaNcQ8+B2gbInWi8GVFxFH7S6hnR3Qd8So/b/QxiW3sKReaOK8rXQECUwuEgBnH9b0HghBGokCkvPwlXn8LEOK6hth+SxRIttUh/mMjUvf+sG7TFNm9wNwa2vHsh5aWtMS1zpxWeP802Es/VJVqV/vnM+YH7DB5JYeiWI8wMn/szb+7S+q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(8936002)(8676002)(5660300002)(7416002)(38350700002)(38100700002)(2906002)(478600001)(6486002)(186003)(6666004)(2616005)(86362001)(52116002)(66476007)(6512007)(1076003)(66556008)(66946007)(83380400001)(26005)(6506007)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ldTaOs6/fB7CT7v7DTpKXVZ7LASTL0YTchRxJZHpsmoCaDqfZAkbsynNY9SQ?=
 =?us-ascii?Q?BpWNuZLQuDKlQUWVQKRcF8MIPslD5cu5h5p8lPPxqpj4oc8ul+FuHbv0GlPQ?=
 =?us-ascii?Q?okAMEslAqkXGCGWFPPPtesnTh2FXIDOfkJqcVyx2lSVNcAByRsuh5zTzJ2Wi?=
 =?us-ascii?Q?E0Z7l6QnLLmRV1Ig1c47aULBi9zMIOpU79eSgm4AwL2hhfX7P+HBgdqrUb1L?=
 =?us-ascii?Q?xjoP0mJH0Mn8rIPhL/jVBgA/2xzC5ADxcEF2oUGQqeY/H2XiK4iR1l/6USaM?=
 =?us-ascii?Q?5Cs6KFCKh0YrxdaD8i79IIx58u5l48iLpQy30Qs4812Zy/85V3QrGAKhTEFO?=
 =?us-ascii?Q?npIw4jvMeQfdiAHOUmiWOzz0aKhUmQ7ifjo9dwd4rxhYxuXy1dREp8ojRlga?=
 =?us-ascii?Q?LbJQrcQQ0CrsEbW+1EP/n5c0dPbcxItuXkwU2Xzdtzo+r6dW7yA1ss4SvtO3?=
 =?us-ascii?Q?0Q33WT/+IlbA0S33XnpHGk8rZ8qhDIfY+W0jwLDQvJLtVgKE/bGBT+WjlLr1?=
 =?us-ascii?Q?ygpMnM7TBjZ4TnRMdDqD1HCnDa6vTl22gV1pXCU1EzMqO1/VUenkB1GId6o2?=
 =?us-ascii?Q?YTbLDojgbTYoQgdvoLV8rSE1yOvJ8nZ+V07yKoMPouHCkRtMfXH1ja0l67F4?=
 =?us-ascii?Q?QWzusSrPEnG0nFj35+e29aHqrNtWyOfdq5LHg/D/W7dN39EKP5nM3LLIUJsd?=
 =?us-ascii?Q?YK/Oj8/aVZ6SkbsAb0L/B4tJu6d6G7HX0+sAT6S1D/PGL2WCxcJ4pJLcZhdP?=
 =?us-ascii?Q?CdIN+76uX6Ynj11mFzPoeRAB6T9zPt50anRxWcUJs8nkOtNMeOGIYTkVlte5?=
 =?us-ascii?Q?CKukYCn7APRSW/QZHGMr9wE8GCAft2xJ5g/KyWii6W+siq3kaMMH4x3TcGjn?=
 =?us-ascii?Q?Mpq8gxqtqLcpiW34ar9Pm+eRY/mmB4JAGkwpTtCi8CYZHRz9YfLfvQ7j28NA?=
 =?us-ascii?Q?P93EUtPyzRxGzqSsrDmy/GO0mfWTki4+sU1rEhmTLT/V6bbU9GIDExOJCJrL?=
 =?us-ascii?Q?bdr2EhhbAVnuNPmFHVKWjcZEhl9EHA9DYxkEc2N+EyBNLe/SHg610PwOvk7G?=
 =?us-ascii?Q?nYwYkHyAL2E6GpxLu7LpnPTmd2y0uQWkIYFBvP9m8ESXXevk8UewIm/JVhYd?=
 =?us-ascii?Q?jrxrheBsRQykTtTPyIVTfxVUjSYmg9KCWLzO2/5SNfvBIq0EEEjvD3dE+p3L?=
 =?us-ascii?Q?39I1vRlXwgvuaU28/hizjeuxyuV6YsAyVKRzl86ADqdc/xUE9UADQxhEACQS?=
 =?us-ascii?Q?GePAQlZofSfuReMCRZpIWcXG3PC6M/1Qsw4LPfWpATP0bS1YvTrYVoBWXrb/?=
 =?us-ascii?Q?XMn4Wc9hWw1CmKI2sTfeS4Z6mqTjnkIkopMxcT1mRgMBZTk16RYfxO4Y/69t?=
 =?us-ascii?Q?Ow9t8AnYSoSdGMuJMJLK+OM2ZSfV1b3mcKc4owiDvF9KY+qjpRfzjfkiGAP+?=
 =?us-ascii?Q?FhkG+b6HtMKclj/hM0N1+g/H9uONxhaDbBFaWUKQsMDm8c01QSDeQSrx9BhC?=
 =?us-ascii?Q?+IOqPisIdWH6uFWNkSjkh164AwlaTtG+CII6yJEyti+gDKryaLZqa+g0tRL3?=
 =?us-ascii?Q?9LFqps4EuRIhFJ4xhkJJ4efYZRRTvLa8Cu0Jr98oGf3KLj29wxtjorLZBSI6?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c5c0a8-08bb-4fa0-da2b-08db73bd4e98
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:50.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qE+DSRjF7eD5KkMWKW7vjAHga6W39O+dJ+AOwdIy3CqVRYfl6NWdnvYM/aQR8ievNIfgpyTZDv7CPMskH/fi7OtlG0CaGB9seVVPr4ltiPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During PTP testing on early TJA1120 engineering samples I observed that
if the link is lost and recovered, the tx timestamps will be randomly
lost. To avoid this HW issue, the PCS should be reseted.

Resetting the PCS will break the link and we should reset the PCS on
LINK UP -> LINK DOWN transition, otherwise we will trigger and infinite
loop of LINK UP -> LINK DOWN events.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index c21c6aefc705..af3951e76a47 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -56,6 +56,9 @@
 #define VEND1_PHY_CONFIG		0x8108
 #define PHY_CONFIG_AUTO			BIT(0)
 
+#define TJA1120_EPHY_RESETS		0x810A
+#define EPHY_PCS_RESET			BIT(3)
+
 #define VEND1_SIGNAL_QUALITY		0x8320
 #define SQI_VALID			BIT(14)
 #define SQI_MASK			GENMASK(2, 0)
@@ -1371,6 +1374,19 @@ static int nxp_c45_get_sqi(struct phy_device *phydev)
 	return reg;
 }
 
+static void tja1120_link_change_notify(struct phy_device *phydev)
+{
+	/* Bug workaround for TJA1120 enegineering samples: fix egress
+	 * timestamps lost after link recovery.
+	 */
+	if (phydev->state == PHY_NOLINK) {
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 TJA1120_EPHY_RESETS, EPHY_PCS_RESET);
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   TJA1120_EPHY_RESETS, EPHY_PCS_RESET);
+	}
+}
+
 static int nxp_c45_get_sqi_max(struct phy_device *phydev)
 {
 	return MAX_SQI;
@@ -1932,6 +1948,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.config_intr		= tja1120_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
 		.read_status		= genphy_c45_read_status,
+		.link_change_notify	= tja1120_link_change_notify,
 		.suspend		= genphy_c45_pma_suspend,
 		.resume			= genphy_c45_pma_resume,
 		.get_sset_count		= nxp_c45_get_sset_count,
-- 
2.34.1

