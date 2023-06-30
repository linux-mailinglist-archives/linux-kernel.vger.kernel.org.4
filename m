Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EFD7444C7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjF3WUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjF3WU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:20:27 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AA0BC;
        Fri, 30 Jun 2023 15:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDRE2ABPPfff0DmNRi9h12HZY+lGEDzxjyB3dMoHPMrI0HiKt9SDdB4yaR+H5yBk21FfN3kTY/G6ZQI8wWiNVFa0pLxrOIzAEBUbZj6TwqGR1XJu5r9cxovuUDVXn7XimUrw8BkRrScoeuguiSOxPWLZwDD4uFRlW70dhnpxGqVWZlDeuD28aRPAxkdFutTc24xWWQPRst/vZBNnYUXDvrMcFpALzJ8CUiPNlW9HIFr0fkjgpZx4tcEqoUKFb6VWAzYJfru9mSO/eidAuMdzjrAa7Dv+UQvV+6k9D5keH2Z2Sr+QAKaeMTOoz13cayBNn0kJi/jBN3HTewwkL8Nfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNAU4tG4LDKaLE4dOcpQmzsvys6jZl+KhJmIziYWRfw=;
 b=MfiJvcIktXN6uxO6HNx5SIpsxiqoRpHbBg0zCbaqKIHIgQ+71WoBiDJlaiTI9SE5MeLV8Gs6/2u5TRywzfvY35IOi0JIWfafnLJRqClw0xXIdn+9fp4LR6N7MJjK5AYHzY3Ox9t0CYmbyepA8GHPXcvSdV3DY0zgb3p6MBLuMgE7nB5FVzn0eFuOnkVxVJHioEvNuV52OIQ3Z60B3E9jjuchToA5XCMnDrjbIw8vBriED+cA7R2NAieU6h1OEaMlFr2wXE5PfSnA5Lab+oo6XoHRIhichPigLDtvy44UljxRknidia2SPh/2WZ2Y3XTi8Inbg9Q8CZ0xqxlJce/ZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNAU4tG4LDKaLE4dOcpQmzsvys6jZl+KhJmIziYWRfw=;
 b=MAXuKwsTe0ZrCyS3rOS+xzYCga8OxspcEcXLtAj1jdP5Ia2RQgnjy8uBp0TlOjoJIp3Qc2DKJrWPJQ8eYp4u8lVAW86GGe3KIxAYCcFqcChHirgAXW7HWO8hRbdDOyL0yjJFf7TnsmkSX5lA3lVOpx+2LPEVrcIENhNRrMOIyWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 22:20:22 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 22:20:22 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: tag_sja1105: fix source port decoding in vlan_filtering=0 bridge mode
Date:   Sat,  1 Jul 2023 01:20:10 +0300
Message-Id: <20230630222010.1691671-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::13) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b312475-9ca8-4905-cb78-08db79b831e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRIsjJ61weVo75Kz3/zvC1vbltHSaR0tapymMc75wLsNHIZeBxI3WRl3nL7anPZGyARpjhVoLW6KTuPdlvRMzyX25LLL9FkDb+tY/wsh/OkSxanujE5WMu4gjR7nOZacNAPVwbWGjSZ5AW9bielwZ6R+3dke5+neTt5dYOS1vqM/Gxst015hvV+l0PiZGX9KinrZiFgd9aomS9PriY2tGu6jad37dEWWZtSBZO9g+hYrCGuXnCKztFx9xxEuHxiLKmRK65jUoGebGiMIppvgCz1tzE1QCsBpLCB6su6683kQJiVrO4clAM+FXpU7wua2wJYbdY7U/b+2A04kx/QhHbG5iVYPdZMHQDmgxoZa2tTlDadLlFB094QSVRw4n3GYkP4m/nLazPc5AVITV4TciE4KZ9XXG8t8q12bLS05xINz1iDmiMtwYWelN3QA7z9ZPP9KBXV3Rri7CptA3/CGhMj0L+EGm55nsScocwcr31PsMbp/BltAhLkPYaCtegDUADMzCUK/i+cxJ3Tmc491kQLruIf9uvejFrHMSc+wLTy0hmPUB2nccocSntbA1ZgpL8eXIBzySw/cy4AIYAxhZa2mgp2y9bgVXotTeOs14KDWTAglA24qzRvxXq16LfzK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(52116002)(6666004)(6486002)(83380400001)(2616005)(186003)(26005)(1076003)(6506007)(5660300002)(86362001)(8676002)(44832011)(36756003)(2906002)(66946007)(54906003)(66556008)(66476007)(38350700002)(38100700002)(8936002)(316002)(4326008)(6916009)(41300700001)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H8+PZ9QEC5QEWknLWLWfXvWXN7ksABjpknKKZHxbCcbazgWQpmL8VB36Pghp?=
 =?us-ascii?Q?HFp+M3BzlowIHkS8UTicHDPRfutDV2cGYDp4BRzpF1aMbNNZVMzcuMkSJLkY?=
 =?us-ascii?Q?YVyhH3d7hvEKIGg64CNVADtsCp5uQLRo+rTULobsVLaDJh2wb+n7xxc3kII4?=
 =?us-ascii?Q?CcWtfmjXCDpjPPvzfUWX4gpBru6LoQusyp2lfTX5HJyP0IjsVb1/gXWyBlbm?=
 =?us-ascii?Q?J5MFSZIlh+YlOHokAyW/9d0LmmANdQaz8STlqJ8tq1EC1mfAiTY8VPR5CWb3?=
 =?us-ascii?Q?otTcn38xwHfymigInIsdneGI+sQVz9oSGuSe9IbWlugaPZZR3TY4lF/dLyce?=
 =?us-ascii?Q?ek+6LgglW/jKA93bfJ47gOEamPcGtF0HlOg1ONTo2x+ayMqYqfhnLlDlDE6+?=
 =?us-ascii?Q?zV+gQXUnwCzgnj31z1Tx4bQ+PE17riQ4zD4wEc6S61r6aTkWEIOmYHkUtflj?=
 =?us-ascii?Q?I4IUbEuWz6A6jHgqGpdWsyvAaV3EVSPBRlIDwAx7o+eDnBDOqhSj5aqcfk1q?=
 =?us-ascii?Q?GVQsVWcUU8d/41F7T10vHV30lYFvL1LYXcgsBkNpxzpkL56jqmQbV3QIydbP?=
 =?us-ascii?Q?ZsjJRZtKsO855DSplj9CtPCYxHB7ehPsZ5rcu7QIQa7qNMZ2ZHcknzLzwBOY?=
 =?us-ascii?Q?K/SIUODUXaJil03NUtXzRylXu8/xQPnt8gtLFDVoY81YCF6evmgM5CWSxNqe?=
 =?us-ascii?Q?17lcQDafngSx8TTtNApxSQAkQF1g4BtJuTpQz+aOTvuCvx/1reOACNTK4bPb?=
 =?us-ascii?Q?6TpYlt7TzoZEYBS957RHjJOZQUfiepZyv7gGfgowzrE4A/x3cCqwu1pdCNZL?=
 =?us-ascii?Q?T1aciToih45Y2himVKZ6bMxFG1RPnlj0kIFU+soJNjkUrwRzUSbjJM2IAZ4m?=
 =?us-ascii?Q?T/UB6g6iy2tdCFUf6JzIZXxjC7NScg3Hu3zZ71BG3GTLtK4SZEoc+tYMspzW?=
 =?us-ascii?Q?cnOb+G0RaMzLoYtUC4YLFkzYjw5Esfrvh/wUp16fUX5pN8Ge/bv5vNhUm6N/?=
 =?us-ascii?Q?U+3WKwMZQy/WFJxeyAsjV3TNgqUaVcILnklSdF8ROcmbydyaiQoD0WB4VpNu?=
 =?us-ascii?Q?x4FV0hVqZVWg8oqFRy53E9HIrgTU+JN3FsKqvwGg5fYR86834sR1eHznYMYR?=
 =?us-ascii?Q?Se7uWrnIo/gVq5HTn4fU8PZhyMt7u11mTbP0YIB0gEXYDsnpG0CZHRtYmXgV?=
 =?us-ascii?Q?wOWyxRxs0Z5+yubZpbilNIDE0W/ecFD66XrnIM31Gb0iGVqpwk/mE7PK8/wz?=
 =?us-ascii?Q?rBsbCyHLTzw0hrrE1XCTGNHtbFxSdEJhRTx6gryLHuH0p2dtFlfL83ubAU1U?=
 =?us-ascii?Q?3JdFGXZ979WqbHPL2woW9bXw1SvV8ibPMoLGjZt6+m8QkyqekQ6dbgvWgdlf?=
 =?us-ascii?Q?ROM1A1HWKIfdYqpY8jbnj0rjGm09pSv37ShlL21z4pT4dwSUxKv/gQ9xbPWz?=
 =?us-ascii?Q?fiRMsaGHR/7Kf5HHlAwIx3M9qE34lCi3lot6GrSkZNWbKzpKgCqQaTcAqCQR?=
 =?us-ascii?Q?5qoSRpucqZS79jDRd/QjCt/+FtVKUPlILV1mOIznUuh335f7jrWFn2r/AMN9?=
 =?us-ascii?Q?PTUkRJcNbhZBxNqC+kPHQabkCCEL4mBDAxbRpa1W0d8QgSREzoqOJJ7i67f8?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b312475-9ca8-4905-cb78-08db79b831e3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 22:20:22.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrX/w2JwFJpP+Ph4XUhb1t/mg9v1xCzO4nWwqPsMIxtuFBfSwE/KOCTSfa+E6hkExUyS1ssqVkVlrINPks8JAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a regression introduced by the blamed commit, where pinging to
a VLAN-unaware bridge would fail with the repeated message "Couldn't
decode source port" coming from the tagging protocol driver.

When receiving packets with a bridge_vid as determined by
dsa_tag_8021q_bridge_join(), dsa_8021q_rcv() will decode:
- source_port = 0 (which isn't really valid, more like "don't know")
- switch_id = 0 (which isn't really valid, more like "don't know")
- vbid = value in range 1-7

Since the blamed patch has reversed the order of the checks, we are now
going to believe that source_port != -1 and switch_id != -1, so they're
valid, but they aren't.

The minimal solution to the problem is to only populate source_port and
switch_id with what dsa_8021q_rcv() came up with, if the vbid is zero,
i.e. the source port information is trustworthy.

Fixes: c1ae02d87689 ("net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_sja1105.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 796e4b88f63b..f480ffffa8c3 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -531,11 +531,14 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		 * if available. This allows us to not overwrite a valid source
 		 * port and switch ID with zeroes when receiving link-local
 		 * frames from a VLAN-unaware bridged port (non-zero vbid) or a
-		 * VLAN-aware bridged port (non-zero vid).
+		 * VLAN-aware bridged port (non-zero vid). Furthermore, the
+		 * tag_8021q source port information is only of trust when the
+		 * vbid is 0 (precise port). Otherwise, tmp_source_port and
+		 * tmp_switch_id will be zeroes.
 		 */
-		if (source_port == -1)
+		if (vbid == 0 && source_port == -1)
 			source_port = tmp_source_port;
-		if (switch_id == -1)
+		if (vbid == 0 && switch_id == -1)
 			switch_id = tmp_switch_id;
 	} else if (source_port == -1 && switch_id == -1) {
 		/* Packets with no source information have no chance of
-- 
2.34.1

