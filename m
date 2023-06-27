Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AD173F571
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjF0HVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjF0HVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:23 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FE2297C;
        Tue, 27 Jun 2023 00:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBLK/n5fFcKS9YutzotuE64sUeHjciINKLDYdZUuceIW7FqRcSId5gomTBscPZVacb8rJYkxJsAAbT1o93xlebTfOoVlosYHTjU85jRkK3wBQjyoAqHhB+UtaaCcAXpzk1mA6GoK98/GxXRZgPVPOYnB61cXgPXicc07vdrRxXhLvs1/bAaYD8BgK7lKaaNn4VGaAnMo7iMrS43Rb7G30ETRX9ptXrWbGc3tSqX6l/dLLFaUc6DidxHmkoVBtbQGXqnXoaikD3w7EXb/z2E3aa0vcV4A29I7FMdwkQ6HPAdO3NPhjYDsJZ9DUlGd21AK90dv7iOdaJ3QrxN/EWgT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A3TvpPDx6Lw//TvQlhQQhKB3sizd62BWefxoGC1ffI=;
 b=Mz5DvUa9X2RjY9d5ggZxEfjh+lrfVd6hB5kDQCDfTZpn0fVEI2W0bqlWxIoW0zVF6BHmXGadKJI6/ymOBh64H5qQOSHqDVKpm2eove6RI5QZUDgv6ofpNLGZHMKhAmcevSJ6+HPnfNHNxyp8B5FqqjptglssY3y3bZnjKx/8rds3Yv465PP3dKR1VqhQuSg0+h/DV3LnYl2+PCkLI/ivR7F6JGxtg8bxXaqzylsZ/PMhpVarI18Oy+HPGuH4GQ+Cmy7jDcdceI1vleE74aMI8VZCKywYDk4iUGJQE0GtiNfOmjCnZ6o+brs61cIJmKfYTET6uluDY3gDtp3WcL0O7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A3TvpPDx6Lw//TvQlhQQhKB3sizd62BWefxoGC1ffI=;
 b=FVs4xf89ecvHRc4rRf9C2LLA3lVs21aFLQggh4uMqz/n/ocWqQwQ99MUGB0hEabTXCyhzfJNwvapOi/cK3xkybPbLe6+8vuUqpsLLJXYDPJZMmFPIHlxlIDJcanuVmdpQEpgFAUorBFBSSWz2BaTt//fNOHxmTn/Fs0Z5ZYdSIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:19:57 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:19:57 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 04/12] net: phy: c45: detect 100BaseT1 and 1000BaseT1 PMA abilites
Date:   Tue, 27 Jun 2023 10:18:45 +0300
Message-Id: <20230627071853.106215-5-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5c86d571-5a42-407b-a5ee-08db76dee916
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UuqOOwEw5k9wFA/J3Hp2zORDqXONApvpWimyQQYEe7j1uVhbD+dsDcS275N+K6TQX1qgXC0Md/TWpHczPQYh0Zn/2ImI5Je+IVsJxSI5MdS/HrGRUQmfT6sweFSL35D3B4A5qWGPQsXVBgPMTnLu/9bUz6Jc6MzaP+graXKufVcN9ZpjoRH/dfH15/xY6VdCKhXLPFdBBOvXXOeT7qIYRzvJ98cPx0U7rqkHZyDv/TbrtIqlpEmHVrbcVh1p23exk4C0vY4fk55HObRjc0njUu2pCo5m+X8kL4OjhTr2uf4RFmDytXErf3dhPN/8ZlVjCDN4vtx8wY1qpnceeraeEHYnl0G4OH04I1OpmIVSqjNmK/wBrHG9osuQMfWiG8mVZit86mKX8+t8vBECOQyR1GWW+Yx/HXfhKINO9AxVzUGWdJqQDK4YiA+qojVNWbY3Ag2/dT6sdv3qQO3Na/rDjyvLVwbjCDZw3v4MeeT2YpulW8vBpjxQ2DXKkw2cO52gx10vhvMyz1TmgD3PVNigUUk6EstZTP00tijDrXsOH6JHZv0XkB+9Xo68LZuzkxNhQTLURkoqQRE+f40LkDV1r9ROuy9fUobPfwMYzkA7m7KesAM3IPtNUPOC56sbP4+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(83380400001)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(38100700002)(8676002)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d9rUTenTgBzrTPHYcOX1GojaBQhAhhZxSh+nooUyGdjGjxhe/ViIO3+LBYsf?=
 =?us-ascii?Q?dr8MgSEU/X5IEMLX47ovhWQ8onxQS24pdaThWkZia6AMykKY+BuRTqvLfDFo?=
 =?us-ascii?Q?1qgPP1wWlM1MzgP62n4LyQKGt7JI34Ft8EYvje01/gk3e7btJPtZbGf7osV7?=
 =?us-ascii?Q?sn13iyTapmIc1pOoWqklund/8RHiDyTdhnekyAt8HWVaaTmMO9WCXsTqCekO?=
 =?us-ascii?Q?Mr3JSh+ZeiHvJOQ/yqfWCPST1UXVWqvzTkxhD6+pb1IkCvMuqa2wB7s7sFJ7?=
 =?us-ascii?Q?SS0CZGqSiguIs/OymNxqFBV52Xn5ExcIwCjJX5IsDAEDXi3qQKMYkKXp/kkr?=
 =?us-ascii?Q?+hVd8i5w5TEu2sHa9QN0e+M5/zLNBJhwmR+EeGKwPQP7vJ9dM9sSeUAmBzo6?=
 =?us-ascii?Q?DW7uGdzVjo0iXUzyPHWBD5ouqxrnFMnrL8LbntWLJVkalOImTO1sscQDBx8Y?=
 =?us-ascii?Q?q9vUvwVLm63hlNz5xYoo3Y6XBlOB8NAZt2NczUxtiYTH2fBrDHYAPU/kDyEv?=
 =?us-ascii?Q?faAKE+N92Et/bzayapBU3yX91oqcW1v6XHYx6il9mQzFA3DjkKeXi7zGNGLD?=
 =?us-ascii?Q?2xQCdUZap/zkOazg0tEwFU2OHkmRvu9j+2dJ19696ihYjZmai1KbLSZNepnn?=
 =?us-ascii?Q?88xHpNhSLahwMfDu2s2IRt0LRclyi57gMhJIczCpoYY2IJt66iOo3Tc9WGTG?=
 =?us-ascii?Q?cUKBqZ7jsBbklNz/34AlxQEDXbrwPB4pdC440FYqkQa2WKi3XGBR0CpGTyfq?=
 =?us-ascii?Q?56uUrM3Q4g3up9UY43wqNjYcEJ9To/2zE78cLN7oRRtbDa2CbKuNlgwYVP43?=
 =?us-ascii?Q?lAcLfKYen2Ln8ClP+XDcdIVGevSWHRgO2fWvJWRan2bWMxkdd+56i6UNSiJ/?=
 =?us-ascii?Q?ikji6X8yF2rXOKhuEJKl83EkANSOB4pkc9fLxgpZOmeyWElT0PxLQqJggapu?=
 =?us-ascii?Q?dA0suVWvOocwt5jX8DgGaR0m+8dUIG2IoWQXpMLjkvTrQG7F/rsVTj30QloG?=
 =?us-ascii?Q?zaoINo1qKf1y+UIPHkKCF7+KJJvW3KdSUic14d77cBGmU/Qk/yk48ZuUz7th?=
 =?us-ascii?Q?pJ+KNIylSl/6voCNYPjAuilcrl6lVWOY5iQuCA6SW9p/vP2NRtXnrFmqllzK?=
 =?us-ascii?Q?7J9RxP04vNhw8URqJDmI9LBd4JQx+HTITJ5sBqfpfDRZpL6W2X+C2522+P8w?=
 =?us-ascii?Q?3MkCB2FwZQfC1cRs+ZPyGddvlua+W6/5ok6YbteWV7WZ7zvYjAu62IwTtd14?=
 =?us-ascii?Q?LcxF8S4Ftcy0RA66IMYF4qaDeyxKYC2Ut+Q9yxFFbaQXLApygVA6XHGFLXSD?=
 =?us-ascii?Q?P9Fi+tv9kHP5WVy1AWM7JTtyCK/pscaqGvBMHMJ3GOUy/coIjddkGWoZ+43L?=
 =?us-ascii?Q?hcxBWX08bULeC5y0MLfW7r5dbpTpCzgKrOcoTS6ShDDZzkfpuGk9vf3ip0aD?=
 =?us-ascii?Q?v0IHXmQuRgdxuWSmWTVo9QDtuTQy3LAEIX0/zmk39dZNLEsfL3YTw19X5t19?=
 =?us-ascii?Q?0XprLQfQ/dP9WYEPKoJdu9MQF7BinQ6RE/1u1aG7A+QnC2morElHMkh6CJYg?=
 =?us-ascii?Q?v++Ys/VoGR1W0lb55mN+aD+BnsPFi1ouk2m/Dv7dm/dMAf3DvOAqgXqAZtfZ?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c86d571-5a42-407b-a5ee-08db76dee916
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:57.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k995iFH/hbuoWoRve+QlRmuSf444wsx0EFxBH43mZuKwGkUBP8RwGzgR1bnjzoiJwtj2M3fnU+1zTbtUXGM4STAm3f30QBk8LmfrxBaIrpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect 100BaseT1 and 1000BaseT1 PMA abilites using dedicated bits.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phy-c45.c | 8 ++++++++
 include/uapi/linux/mdio.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index fee514b96ab1..1017aeb0599b 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -976,6 +976,14 @@ int genphy_c45_pma_read_abilities(struct phy_device *phydev)
 					 phydev->supported,
 					 val & MDIO_PMA_PMD_BT1_B10L_ABLE);
 
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+					 phydev->supported,
+					 val & MDIO_PMA_PMD_BT1_B100_ABLE);
+
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT,
+					 phydev->supported,
+					 val & MDIO_PMA_PMD_BT1_B1000_ABLE);
+
 			val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_STAT);
 			if (val < 0)
 				return val;
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b826598d1e94..82ed363f5268 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -332,6 +332,8 @@
 #define MDIO_PCS_10T1L_CTRL_RESET	0x8000	/* PCS reset */
 
 /* BASE-T1 PMA/PMD extended ability register. */
+#define MDIO_PMA_PMD_BT1_B100_ABLE	0x0001	/* 100BASE-T1 Ability */
+#define MDIO_PMA_PMD_BT1_B1000_ABLE	0x0002	/* 1000BASE-T1 Ability */
 #define MDIO_PMA_PMD_BT1_B10L_ABLE	0x0004	/* 10BASE-T1L Ability */
 
 /* BASE-T1 auto-negotiation advertisement register [15:0] */
-- 
2.34.1

