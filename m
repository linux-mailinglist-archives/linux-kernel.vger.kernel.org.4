Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FA573FD05
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjF0Nmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0Nmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:42:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F6F2115;
        Tue, 27 Jun 2023 06:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN9rmj8OcB/MEK0o23lq0opBcEJnQISiaZypK/hC/Mi56GWHw2tzXyt49L3ZkHYGawgpYgapgV4oD8mKy4auMJ+ifrhdxjzguJZHus9QkaM7C7nVqdH5gONajI+aMWkavz1LibdjlIi8zK9RSGkq0PpkmEZeTFiU0t7S+RsjkXilznHRMTj1PlaCDFJg4QAroIWP1nfpFI4Sga+1Zp4mFl9lhdaMgiAN4Fqpk6gwnB7TYvu8EZwocC0RQT+3vJ6JAuu0Wv1Ua5dVbuDIXIxNkC1dwFWO/je9kYLt8cQ2DaJ8EmJRPJFMB8PwktznO0x6cUPx3U+cQ8yxVo7SOt3tuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ss1+zz6e5jPlAPIdVnMQIX1U02Lp6LOjhaErNFTYXrQ=;
 b=EOUYpWrbVgFfuBOt9QHjkUbYQ0SPbpHf1Hn9v0X+JzKjhOLHFvp3zK4Yjt1ZVPeipXYaY7aXEPpvgn14IIewsG4tNd/rpUNfvTzmsz0eOVBVonfJdrhlyttJizIGL8tqmWD36LoMlnGdWX2aYx5zuRXnW1TmbcfsFAbZU31435Dy6HXQckNiOH7sejGwa0l7eVLPpd9A3pGI8LRFkPX/IK2pF0rzJ+VLGJu7IZ1IFDnksTOhUWDrfo6niU1MAjnYm6q41e233ekACeEDvxxPdQi1rjcyfhDJB01F5xsZkRcIevFs4apbNUK/qx7eruwE88HlU29XeR0ZOvSdpyfwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ss1+zz6e5jPlAPIdVnMQIX1U02Lp6LOjhaErNFTYXrQ=;
 b=ZPpv4ICcL9JlhyTUTGw0GfZ6m6WuWD04w8ktT1NQ1ai6T0YveSZubEdOtb8BN6Fp8hPtZoT5hfAsyueb9sgdOYtJRXK8/RQ3Z0+/+1lTeLNO/iIZX9l4uQoxG3gtyaQs3TH/tcYSKadUdcZ1R7JwH/XR+MvPeR6QoWS9Rqbh9P4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 13:42:45 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 13:42:45 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Harini Katakam <harini.katakam@amd.com>
Subject: [PATCH v2 net-next] net: phy: mscc: fix packet loss due to RGMII delays
Date:   Tue, 27 Jun 2023 16:42:35 +0300
Message-Id: <20230627134235.3453358-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0163.eurprd09.prod.outlook.com
 (2603:10a6:800:120::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: b69c7f22-d9c4-4a94-7862-08db77146313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMVdWRfL3TZmhfMcNUJ/3lkQrcKHvF/aTRpNnYMQ3U2vY/cFsdQdAgsL/3UqIvKDSmhdvs+2LMu00vwCu0stwHCytcFvdkOqCydBvr45l4z2es0TTqzWYFHOzNDRyElz9svVzPSlaWopFveetR6OoTMELk1uVuku5W4Hn97NHxdxBTAo7aTj4chPYFDzrErMUyzUPNnUPO08aEkIFgMGNrELtroMIxtQEZh9SK4dZLU5wCco2zxWPlWTE4/oxEWjcYUXi6GBVg1jT1Mr0bNABFpXJv9zP/YkieQ63wTHVD2CYgAq/xfnSwfpISVZhpLw+A+ipSpzCZw7e5Y3EWCGzMxgtVlteCY4TmdROVk4RVCZ1ftyAKT7pF0MX/zITSMDWuFF5sIEzU38k+r9NqOxnGEp0EpIcN3XCjIPNxxyaC8LhwVX36rmG2FJLEij6nxhEWhyhBOQ3slQpx1cxyXsGIWxmfF5BCkRYxqEo9nDKEAcVuJaXYomm/Qt+o5ZVKt52I86n8YOy+Odgr0k+iWp4cARj16jSmPBIpETzFgbM/U1557DONQ82KNK1KDiG5AcAMKCeB22tE/ec1ha80n17Jw5lgvIPqZk9YnPYlrrptl58a3Zdtgjc7tpoXVKvjpU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(6512007)(1076003)(44832011)(7416002)(66476007)(66556008)(4326008)(6916009)(66946007)(478600001)(316002)(36756003)(8936002)(5660300002)(8676002)(2906002)(86362001)(54906003)(41300700001)(26005)(52116002)(6486002)(186003)(6506007)(38350700002)(38100700002)(6666004)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E7Mm9qhic4MX8PUK+cSjHIL9VeBt5+7YeGI7hpjfIh4yxtcIlEiToo5ttKcd?=
 =?us-ascii?Q?FHneUfiArjj4ASZP8CUlQCK0hmK0EDHjn0AgPnkHaKTV6WCTH0AvsUNWhoRW?=
 =?us-ascii?Q?POUdZHaQdPGLzF9ELTgmOo+outd+pVnepwneJ0JrVJhuwMfwm+ckBc/g9sTq?=
 =?us-ascii?Q?nAtyNg2Lb//huY0RBqnI5jLu/22kp5hrSYkMXaUaIvoHttfHFoaL6LiPzdue?=
 =?us-ascii?Q?xj7OpuIYJUTZ1n/8/H4lmMprXnLEutY7iOXUICyTF4C7kJ5WKekvbZWkzfNU?=
 =?us-ascii?Q?lLHKmC4wgJgCTJkHO+XMTieb6aXIsjFbTw1+aQ9BRgVBQ+AOw/jblDDmXWOP?=
 =?us-ascii?Q?nbSyywOz+iY9Ly7X5v4gmHibgWpkBwlAvqbWyfjHpxFZmeDtUmWvv8iuoFeH?=
 =?us-ascii?Q?lVE9XG5oJj8YOep6MNwLA8QNxH3Gwpu6mI1P9qCQlkljsTPimHCMsomrUgDE?=
 =?us-ascii?Q?r8Xz94vrloeAVy4sbY9fKpMWlFhjk+oMe+VgV2RNcX0V7beW4AKIK/FnMUXk?=
 =?us-ascii?Q?Plj579EjfRqePAp7gSweFIXQUMAjbkaxcZZghit1Y9uIJ2KyvDN3MVnBhcM7?=
 =?us-ascii?Q?aUDrMHo+Jo7qQ2hmOBu8bKIns9PApLDZpsrkq1rC6SU+rUsbzsmvrtivQxBc?=
 =?us-ascii?Q?wJk0b4WJHkfwt/vVQy2OxjtdFHR3VzZeJXHOMDXwXi7ZutrFaeS1Tl+p40WS?=
 =?us-ascii?Q?J/m9oH0tRFObuY8uBxe0Kkal1MQ8hPzoxKSiLhDEGdpluWfNwY7MhSIR+h31?=
 =?us-ascii?Q?zsfGp6u0YMN5D0fB4PCA55GTJb3AxxK4UzTI+iivL6B9wzeDB773jhpHzIX0?=
 =?us-ascii?Q?8YI18LGPRmNhrz4F5rA9pRZrn+CtJHd6xENsfkwtztttq3PI0/EqQDbU3BTL?=
 =?us-ascii?Q?VYa/Q32L+Bb5uvQY65gvo6qJFMLoBMM8s8mdyuInNPi53Vi0R4lrGOoh1JzS?=
 =?us-ascii?Q?luowhK8oKDxawSD3vsKCm6bweMymeirRUSq7trJjGE67a1vF8KApHdtJ7OkO?=
 =?us-ascii?Q?FAzVA8NigFLPmBpcsu0/ygGtT+IlxIZE+EWR20LBskF4GLOrzj5EmcUVA64u?=
 =?us-ascii?Q?Sie4FbavBWnJEXrkp6MR+aAWF0ZajykAx1L7sP4f8MwB9GYtsivfqZBMiNbr?=
 =?us-ascii?Q?xBjnNGV8cX9Ld/SckYWX3kpWccz0mckcNQ1p/yBgDF6vtLFu/Tl3vOzXzcQV?=
 =?us-ascii?Q?bmaPBHbaPMH7UgIHKhAscREn7+dxtICnhO+9p6s0bO0XV24juf4DPKoSW83N?=
 =?us-ascii?Q?aaKiSZS7NvWpKjONHHMRnzF8JVegHeRGzOvVrLf2MjmAHJ0zgaFb99tT7xa+?=
 =?us-ascii?Q?LHz3O1cKLpFuWBut/aYNbp/+tQTsroE8NoqKf3208plK1j/0v+qEPcu/XdZb?=
 =?us-ascii?Q?KEKLQzBfSGXoYMtaR29YBVkfbkmOBd/yjX/N+Gi+9O26sET6A6N3IAUmpRUI?=
 =?us-ascii?Q?oQ+Tg4NUguOlwsHqGCAMWUsAdjQWyCqYY7wSa3q1yusr8GYg0pJ/dPjLxYoQ?=
 =?us-ascii?Q?S3PuBzLiSxJtrSJMF6TPJTrIxstDSA5nK0VBxBg3ilEu6DgYnS1VYKTvaCc1?=
 =?us-ascii?Q?u8MxF5imdLFEhZVxUFOQ/nQKbc/Ps8Ikns8pIdl+q0rVQUWdYV36RfbB0rqm?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69c7f22-d9c4-4a94-7862-08db77146313
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 13:42:45.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHXso+Qz1gmcuw+36qzF2S3UFeqaFduuFudDIdMYnKLxKsusF+s7Ibtt3Kx6RyA0k5EvvrPhOoOQ7FWTuG6MRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8274
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two deadly typos break RX and TX traffic on the VSC8502 PHY using RGMII
if phy-mode = "rgmii-id" or "rgmii-txid", and no "tx-internal-delay-ps"
override exists. The negative error code from phy_get_internal_delay()
does not get overridden with the delay deduced from the phy-mode, and
later gets committed to hardware. Also, the rx_delay gets overridden by
what should have been the tx_delay.

Fixes: dbb050d2bfc8 ("phy: mscc: Add support for RGMII delay configuration")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Harini Katakam <harini.katakam@amd.com>
---
v1->v2: resend to net-next

 drivers/net/phy/mscc/mscc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 669a4a7a28ce..4171f01d34e5 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -563,9 +563,9 @@ static int vsc85xx_update_rgmii_cntl(struct phy_device *phydev, u32 rgmii_cntl,
 	if (tx_delay < 0) {
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID ||
 		    phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
-			rx_delay = RGMII_CLK_DELAY_2_0_NS;
+			tx_delay = RGMII_CLK_DELAY_2_0_NS;
 		else
-			rx_delay = RGMII_CLK_DELAY_0_2_NS;
+			tx_delay = RGMII_CLK_DELAY_0_2_NS;
 	}
 
 	reg_val |= rx_delay << rgmii_rx_delay_pos;
-- 
2.34.1

