Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D20073F58B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjF0HXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjF0HWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:22:50 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374252D62;
        Tue, 27 Jun 2023 00:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvzsLC2TROFVVQK2l+W2hKXnD7J64CON1mDo/9YCbVCYaaIgwzcalZ7Vwf+5vymYDkaiLhmmROGwScFeH8qAKGvHRTSC6Mnf2oKLjbmCT83GHZ01zmcCejM0+wUNU98iTWU5hzQzBSpWe81XQ067+yeV1GGZZWD/d1UqrmvR8IMx9VUG6jzYRCYLdx0hiGfPn+lRJQGKYJCIj2WmeO3wVDmnQprobukWgR16MpISAOqOZmLH4yQbQfsANhmJwcNS28jKGaSH7ASf4mjhaKydMjR/KOuSkvXQ9IwGV09hyz47xueaExErewc+VKHt0tsD6lNOlk52ggOY1eAwVJ1VsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TYf3RhJsN4JxynB2bPI2CrQCmJo+10Di484d1szIko=;
 b=E568vrrHEHzV9Qrazbd/5q1k82svLX4KCN9rImy3YkfUKrdzlPbt68WrwiXVGRsYVpjzNBl5UdiT4wsyVN14eutd2lnV3kYOaD77kJ5fu/A3Mj1rdTBrc+hN65DSExr3HbQRMIsTfqoNhtzIIjJha/MQlrbYhARCpKIw2nHzRljzn4CyFMsTz27oGDM+YIdzbSmUlObERcmoZMG3PTy6dJzWTN2IFyUhjPf7GkhDODxzHxHfT0GxsUDJK8UkxjMMaaDVIhWxW7RFpi/0nxvTul3wle4i//e4siav4h3Aeo6SFhY4oZfwnbFN/TlMZhTn7pOngAkCHSH2CVVH7Ps0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TYf3RhJsN4JxynB2bPI2CrQCmJo+10Di484d1szIko=;
 b=Cb87fywyKoKbHqOAVXAvwXbjHayACK2wRvcxRBpVLgcf6h5+gvSgu75CBtZqQKMTUZheOZdUHZW54xAlbe//e8Gh213iRQ+5FHt/GqqMrl3hOyrp5a/bjScb2JOzgUk/5LScKJCySKsHWxtN4MGR4+CtI5gt5iNcWOT3IRUDBV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:20:03 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:20:03 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 10/12] net: phy: nxp-c45-tja11xx: run cable test with the PHY in test mode
Date:   Tue, 27 Jun 2023 10:18:51 +0300
Message-Id: <20230627071853.106215-11-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7268b0b6-bc1d-456b-3b1b-08db76deecc4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaTOZs9BFOu4buqIvjQ0Nq15608tt4XiJdQePC2937/Osg7k2ozVpwsrIDW0HqXCF87dt0F5LBE8m6qRw37OC0T014rXj6iEHGy9h+hipGTdo1PwbyK7pz+g3/Jk2X0UaKA1tkUtZeDl1n1sAcvMJ7/6XT9LS1FCt5TOePSps4cBk0XYCcsAvjuyJosyNQicHA7CVNmVwBvfsOh31QMScL54ptr6vggDBMNok8vLQoSDKVzJvn5ZGRvpCVyx4I4r6a3+WTIjgrD6F1Xfvt6dhVdl1wk//byTpJ95uVvN9dCVaet6gEG8Fc5OXb9NJ9DmyfZ+GiTxnzDpaDP7PJl8VovmIx3lskU+wa8On4AVuH0LLzJU7iJ+vUttHoLeeiksVnPJYURxCx7TnyIxk8JkxPjPggbWBcVON1M94TJQEiEfKN5f/ObYBqju9LIiOru9BOWyPxMpvXLytF7ucpVA1Cg8eD63p2OwlzJfnZmCAkvrB/G7AcQS7IcQQZIjSX8tygu7IhEwAB7kYOH5Mxv5jpmQRE7iapE+SRpxScUdkRmTGZ4bI3inTtWYCfsuPzEnSULqTnjAHevdaGo+CnR8K2FNzsxBHgNrM8ys4rWjlP4rfBlHdTYcNCwRC16nI3E2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(38100700002)(8676002)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U9jfoof6UVaEGWl1D63/1Jv/ET5QgpXKVL+9v/uCWbI6YngsVdw/WdNz71iZ?=
 =?us-ascii?Q?shkfIKva6xByrfBhnScqOZZ6k/4BYvFVaUKoQuCUOCNMmfzg5QDw+t+OmBX7?=
 =?us-ascii?Q?uUampQvnbwY/KdYpZPGXCn3FFS3px9stbrCWwWes37o4NmGatPgUAVZ+Elwg?=
 =?us-ascii?Q?ZCkBVOqbFZ9Jy+7tpVz2GpsABFQ+0xa5j9NVheuJoVpiNUucO9cOeTxD+HR3?=
 =?us-ascii?Q?fSsiVRhVExNE0mz/uBB0T7I1E+n3gw/I4O9z/Q0GDNPXKWMR2N1P4pFTnDdv?=
 =?us-ascii?Q?XkkMGeT5YiLGLiW79ii7aGLt5i15Mp4wUeIRc8XZioJ/wBpbxcs3yoBwNVH1?=
 =?us-ascii?Q?BQ6Rb68/Zz5PnLUJl99PiB5Q8JLo4gtESXtXvU28ytRoe02XyBP/8Q+Ek3bV?=
 =?us-ascii?Q?5VINADklzyIz4Y7P1LEWqdOYaKxtiC/O/W8TQYjVekHv9CRUFLmyKdv2fhLW?=
 =?us-ascii?Q?op0XbX0ljsajyG/PGpfsAjyyxxdZZ8BBhkeAer5nI4PtG1lFLvYPZLx7rOc/?=
 =?us-ascii?Q?lwVD0Dqn0vCYUjupn5kBOwrTO4rS5yZaRZpr4n+yC1ObYKSsRmo717dNvx1S?=
 =?us-ascii?Q?yGkb84rvCF70YARKFoCpv0u0ZRpgieDWlU+qrDCyrrfclYzWybKWvW4nPm1F?=
 =?us-ascii?Q?Eh7zYdp08/uCxXBfHBTf77PMEWTNnjXw4xg36bIUvqH6K8Gj3CaNE6i34pbN?=
 =?us-ascii?Q?FOr1M60m3LGt9bycf3j3Mp2/luy6FVejHVeIFni6D2aYuWTEAvlT9WXPjqYl?=
 =?us-ascii?Q?upmM6uYfnAgpK03DoftMuDnBYKfOpicM0OPsZdibKFV38hBJ/nbyWjciRRoa?=
 =?us-ascii?Q?5NMHvQDrh9sEw4yxaMDeGVA/Z9fkKLqySrq4umq4BOo14WrQdCZf0pr0Wn1O?=
 =?us-ascii?Q?2yWFHaPXueIaiCIt9ZUqL0OHvxtgdDxuNZe3JwHDnVwHgI9B8mgkdrl+uD8/?=
 =?us-ascii?Q?RQJTsSQA5wPchCbQbTk/Ucl4PFJtYW7Leit/wZrAdCVhQ4pU4mSVDCg0WPZg?=
 =?us-ascii?Q?j9ONYarXOaFelhruNW6eTyHGCiruq9EgoWPYgzdkxiJROReOhFBvLs4ODa86?=
 =?us-ascii?Q?xfGQ5KWQirudv3hGQO++JIvRZxJ5Dyacz3kft0vH1jG+PTGcwHYy/EddK67y?=
 =?us-ascii?Q?8ucfsAph5ZxKXLlJJ7eeInPlQrsDkyz+fsBkfIpwAm+ix8wClm27T0dCYXQZ?=
 =?us-ascii?Q?q2Z/kVMerD+CMxF4fJZXdCxmW3i6VqS3Vfu/6zBE7QaSq0jWyN/3pOOwcyeB?=
 =?us-ascii?Q?ver0y6WBGERjCkbMSXNKkjVEoH3g3tU7ood2o4kgi3eJfP8ff4HgP8RKJ8kh?=
 =?us-ascii?Q?Ggb35wBnGiM1HcPWjZDXVOXvutgkk8ukh8viR9Bv2ch9V3h+kMbkvJleMyTo?=
 =?us-ascii?Q?QzkMUaHZ3PTKfuFlqR9Ph8//Ri43wt9qASONRVMqw84jnsRJCmucK8WVTuzb?=
 =?us-ascii?Q?caRkeN+nbNuqX2Z8o4TGPPMOzsLBa0S9UnsFXSbOQebwaKomjdVkjbNkd5y0?=
 =?us-ascii?Q?bFGxAn2gRwkAgUxlgVebUa1WM7yH3NtZaN0ekx1Ijs3jTdmrL3+RvhvurBhH?=
 =?us-ascii?Q?stwwpU6Q43epTWO5sVhHFRCymapz6wImMd0JP1FgIiVto96jKq9qJEO63l2V?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7268b0b6-bc1d-456b-3b1b-08db76deecc4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:20:03.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHlZHM+56nA3N6IJ6HZbHtp8UKbc2GlvEFqYlaO94tu+3SzpZS2YIPWubYn+2xSVpHLQqGUMvyZxOUzR7P2Fb1nIMMZnPOEQKHVE8PVdGF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For TJA1120, the enable bit for cable test is not writable if the PHY is
not in test mode.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index a826c845ee7d..8097ac8d6962 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -145,6 +145,7 @@
 
 #define VEND1_PORT_FUNC_ENABLES		0x8048
 #define PTP_ENABLE			BIT(3)
+#define PHY_TEST_ENABLE			BIT(0)
 
 #define VEND1_PORT_PTP_CONTROL		0x9000
 #define PORT_PTP_CONTROL_BYPASS		BIT(11)
@@ -1258,6 +1259,8 @@ static int nxp_c45_cable_test_start(struct phy_device *phydev)
 {
 	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(phydev);
 
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+			 VEND1_PORT_FUNC_ENABLES, PHY_TEST_ENABLE);
 	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
 				CABLE_TEST_ENABLE | CABLE_TEST_START);
 }
@@ -1299,6 +1302,8 @@ static int nxp_c45_cable_test_get_status(struct phy_device *phydev,
 
 	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
 			   CABLE_TEST_ENABLE);
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+			   VEND1_PORT_FUNC_ENABLES, PHY_TEST_ENABLE);
 
 	return nxp_c45_start_op(phydev);
 }
-- 
2.34.1

