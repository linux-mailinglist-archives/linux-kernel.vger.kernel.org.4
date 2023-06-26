Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A93F73E398
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjFZPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjFZPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:40:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9691A4;
        Mon, 26 Jun 2023 08:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lB0WAresqtMb5W0NSgliWRCoPLDPIin/HstnkteNozwIcDEy5ft8FrdV784uWzWwDpL8tCl1Q2kSV91KhBh8naU7lZMqIyRrp7tkNzdhkVea0utd9W70bgg2bdRMU+JlpF8USbQpG7aDJ/SRHcTvfPWSxbxjbcr7QBuqPdt87Laf609lr7X4wR7S0F3EEvBmnO4+ojRqmoxK+7lvZpIUf59gaYXnklDMB/eE3CJWIeO6SzjbacBiJ4jHr6MX1nbS9+jQ7hjGH9FOrWqADqjNFY3L8v/xLLK/+vEf4jrnYSZX5L9WCpnFdvpVqPOOUkpMz9Wd47q3194zoNtfDziLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zStVAQGa1K36ouN3zyKPcZNh1UiuoisDOyxr4IMqIwI=;
 b=lES6UuI5bSdum/jjhZTeaSHodnKOZDZEcQxmesbvxoZt/KW/xfWFbgTkTmP2TeyFzoQHOlk7fK7HHnoTAUldrw83kOmP6R+7/nhXgZEG28kmtHurmEoX5QyT6VNN9Z2ZOF1qhOVRheMg/WgDu5K7+FTsH90DUSvahcv9h9gMdVrzUxOmwXBGkasiUASzlsnhVxqOD9ui2iXKyGM2uLAwVz4v4j6PtZxJqMiBpLSB9OPF3H1uPQt0C8cZowSC3K5oQDXd8DxDYY5MCZNu00wIIOP6ucQs2jDeQdoeEWCrYVnKWXcCDxW69Y3fp7LlQmwHiUid1tEHb0pnwALLufgnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zStVAQGa1K36ouN3zyKPcZNh1UiuoisDOyxr4IMqIwI=;
 b=eNSZA3GqMN9wf/TnWhovx+qPz1rk+/agdGll1DPkuTu4MGyDvKDL6KRRXZyLeSsARLmCpuYSRbPAw11wKbPI0MJVfbY3u1OrJgnWfJHJQYqFbVMcbvrzpDJwjRl4YyoNn1LxYqeSuZ9nZ6JEiHowKoMjL5l9un5R4Nc5nQe9A90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 15:40:20 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 15:40:20 +0000
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
Subject: [PATCH net 1/3] net: mscc: ocelot: don't report that RX timestamping is enabled by default
Date:   Mon, 26 Jun 2023 18:40:01 +0300
Message-Id: <20230626154003.3153076-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
References: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0121.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::38) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: da21f5e2-f627-4ed8-9ec7-08db765ba63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSCUD1zVW3pFPGG9JYhhuKIqADee8HkGypJlYyg7Xo+LUOLY3XQ2D+/m9Lx1fK8b4eQ8LTdKkr9MI3c+RtXQRzpBF6h9YPQIFmb0UNwfNMXqitfMX89ExCyINCxu5OYkVmOO5DfOncb85d93dJsWBg5dDnCsheRu91Bl8rKSZeREye5FB9lhLOKbSDCKQWUM7ltut9BdELWqZ3piVeX1zMrfpM0FkRf1mNfCHaKoo57F7rvKKNU7NRn0reTRpYeVyQVKgzrTVm4qfBQ5S/qjg+h8jCu6Ir9GTP39vxbA0lmzZP+0/0ZLltBrM3llGVsrvASMQOqflZp9iE9LTLw9HTptEOCD9b0wCh2l0dH3h44DZgzE+txAHo1BtoI4hR7z9fpYVGpVHGh3jq3MDh59GoZNpOPOkThTEQwOXp1CG5OInWQBpJrp3BPBHh3uGPVXA2dJuMwVezOCLIFadEynj0snlFqhzfEfLeq92LmcaXZeSldThrQBXNEIIgCchiIHMCmBc25LXHalfmTJag08YuqnIhTmbqEZMQUky7Gc00npNTwsI/qCJQjqb7iygVcD0l7rKsBSPPRqPFSwjxU/Lm1JYPM5Y0WQbpGg4Pauc4TjaTsCFd1vq3Cq5DftvFEX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(8676002)(66946007)(41300700001)(66476007)(316002)(66556008)(8936002)(4326008)(26005)(1076003)(6506007)(6512007)(186003)(6916009)(2616005)(54906003)(478600001)(6486002)(6666004)(52116002)(2906002)(5660300002)(7416002)(44832011)(38100700002)(38350700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zo9b7Cnljw2H6IUmF49DQaNjnbkx1ffbvmK8/8xBNbUvUz1EKvmcu8TmDGL7?=
 =?us-ascii?Q?OFXtk21Oe9PR5lxv6DSe8jjJPUClNeEvzd2bMyMrOoOo8SXCbsy6j8JorgI2?=
 =?us-ascii?Q?DK3XsJMdI43lk8ZURI1QEjyihpvV4L8/C29IBE9otXehgv5NVU6V02IltGAs?=
 =?us-ascii?Q?sHig6bwzGu02W33EFk9wQZCs5o6g8JANQx84QTnApFAe8PZZ4hDpgjkho5rS?=
 =?us-ascii?Q?Bv4i5VoQdxHB6TDkS+29QaE2qbJiTGfJShekqNlAy4N1y/EqdEL0n8FmObmu?=
 =?us-ascii?Q?emxREYrTGHHYzZmX7IMiIRxYZAbdxO7ADV38vfA8xACehweBDtdAIZHk2A7W?=
 =?us-ascii?Q?dyUrMx75Q/4iSJ0r8JTAKh1iO5UCj7t75Qr1Fex4Wt8tE2GqkBwgu9k69cd8?=
 =?us-ascii?Q?E7lKu+XlInGAZaDNMnnRtWDQrGRd28sPeO+LGUmK7CHpM0+cGK4Ndl/35+9G?=
 =?us-ascii?Q?nmsoaQHAnaK4hfo1UDJVTEvR32KAAwVoOglnv6yG0FtVNOT5KKaGJjAOKuoX?=
 =?us-ascii?Q?C5pViFwR1LEtuXy0pWR/aZ0sWmQMjzYQGFROb47RzwT8Ssbf8BQYH4zpLGxM?=
 =?us-ascii?Q?StjZjJt097UwtUJsgBBOhhj3BB3P+59wriOOMBwckWtIzWznQTd5h7YIOan9?=
 =?us-ascii?Q?xqBtuL0iRJr0CnhbP/PX79qeReTIcTaNM8WtPVtAKlA1AZaRbib7BG2gGofm?=
 =?us-ascii?Q?QKGlQy5QI9buLBO8ayThelzDCuqmBHJ6cg/XK9Dmt81z0HwwL84T6GOKtMXo?=
 =?us-ascii?Q?MRRhMu6hrCw5sKhx5fyo9xG+z/pHv569wVRusa9z01ejfezNBVVOq8AWb80b?=
 =?us-ascii?Q?mUHv+83loVr5VcKMrwpL75tYuqDfNnM9qN8XTcgjXK2Rt9A0oQdZLns67xYK?=
 =?us-ascii?Q?E4DAwNgpscGbFBokMh8/Rzem013jpm9J3mAO7zB6QVXtU3OAfPN2W1CVAqT9?=
 =?us-ascii?Q?ajBotxFuTt3gSjB0j6nKXgJxUpBjW8eQJkGFb284B17t6ia8iNRYFGmGoJr5?=
 =?us-ascii?Q?uZvIvrcvjkDtwqi03GlgJUg/niyr9m/Kw+wvidAdboB4mxWQuBCIpYeId+yU?=
 =?us-ascii?Q?alEOATIobMwO14aa82sX9iDu+P5IFxVrqLSHcmOiCdvT3wzS/3ekA4aNBXGZ?=
 =?us-ascii?Q?Z4mh4OC062MkRSYMyNcuKKuAYoPZAoabJHp1edNhTfE7s3JkKfJv1tnqYmDT?=
 =?us-ascii?Q?h0qobMU8f0imzkWwTqwENdEYtHcm+P7PzBqj4N+UxzGtE3EoWe2AtyLMIZfU?=
 =?us-ascii?Q?pWLKBsfV4yWTLcEJyFA96Ry/F1Gc4gFVmDL6Ly1AoYM8jUDfryiKn1n2WybA?=
 =?us-ascii?Q?7zNwtv8uTGp7iDIdbtBlGxSmEjCcUlUdrNage53iizK36y6UsBXB82KgBmyp?=
 =?us-ascii?Q?xaJ42mmwuMpv1gHOxvY/js62xQCcJvdyr1KFSYqKPosuDg0i08T25UPQjitY?=
 =?us-ascii?Q?Xlk0yXJLj/BYc7McpyVX/caScK2QORzDZds7rW2xS2KNgvXCMQHBxdAz4u0A?=
 =?us-ascii?Q?S1k++AW59vs9QqYy0UihPidQL2L7/VIGgJ6iZfSC2x/w4im/WZUNzvXMXlBA?=
 =?us-ascii?Q?0O589qzd1YoQGpva4jMFQIZ8EUmD9aMkf2BVHaC8vagMT293jNoX3gqVaaQK?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da21f5e2-f627-4ed8-9ec7-08db765ba63d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:40:20.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ov+PJz8nhHEUyUqGCUyED4+vTXQKXqQoA/mijUeXCPbnHdrRWXy2fQbw/U/uzgLkx3mgoeR3gJQ7JM8G+9Fxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTP RX timestamping should be enabled when the user requests it, not by
default. If it is enabled by default, it can be problematic when the
ocelot driver is a DSA master, and it sidesteps what DSA tries to avoid
through __dsa_master_hwtstamp_validate().

Additionally, after the change which made ocelot trap PTP packets only
to the CPU at ocelot_hwtstamp_set() time, it is no longer even true that
RX timestamping is enabled by default, because until ocelot_hwtstamp_set()
is called, the PTP traps are actually not set up. So the rx_filter field
of ocelot->hwtstamp_config reflects an incorrect reality.

Fixes: 96ca08c05838 ("net: mscc: ocelot: set up traps for PTP packets")
Fixes: 4e3b0468e6d7 ("net: mscc: PTP Hardware Clock (PHC) support")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_ptp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index 2180ae94c744..673bfd70867a 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -824,11 +824,6 @@ int ocelot_init_timestamp(struct ocelot *ocelot,
 
 	ocelot_write(ocelot, PTP_CFG_MISC_PTP_EN, PTP_CFG_MISC);
 
-	/* There is no device reconfiguration, PTP Rx stamping is always
-	 * enabled.
-	 */
-	ocelot->hwtstamp_config.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-
 	return 0;
 }
 EXPORT_SYMBOL(ocelot_init_timestamp);
-- 
2.34.1

