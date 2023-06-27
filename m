Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA36740139
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjF0QcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjF0Qbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:31:50 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F0C3AA5;
        Tue, 27 Jun 2023 09:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EynYh7VQD5QfKHGYyyHrrhWyJaEy1lZyEljD56cIJB/yQ5XNvpj07kbg0wPLcSrv7ZtKHF3//7LuMb9rP7VRAbUoFxUZjP72BulNSIS0/mTRPoL8enRxgGveeYbGMy3qVEYNIXPGilqQhTQPBkjCA12SYZglTnW4sZ7nz1zWjDLaO5QA2fCk5G6Z73u4bzD9cO7GTulvb0G5vbrNzfktIfsx5Wc9Ar+72yjPi2477lR65aGpe0ZugtbcRt68cApgIrojKQH4DQVrjOpmGKj3DO/gxv097m58VOb/tuQMOd5MDLObNctjV+LaJcn8kwfrUKlkv1EQJfFLTA6E2+Yr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACFnn+eysEYBw4xQas4l5AAvB09EpI4EX/FhhmIm4M8=;
 b=TzGkTSH+VC9Rer61gWy6lwxhBC3aA7Phzp1IaxjS2RcE/OgTlJkx3ezjrkNGYgLWOatkQoQPwsOQ0IaCiyoqH/aW6ENF55726yqjG5+5ZCNxbcwLwxQB/TKcKiheL2KFZr7KYDfaFHAh4MklKO6RrX23FscmZiV09mpMoo8XacJArMc3Yj6GXr0vvIsXy2vKBUIWJRsb6QA6Ch4JQeE+T/B8e2pa+x1MvY1qkQYlOdYYBQjhki1eLIWGHd6BGuzMFjLn4M56xxv8LTQ9DAIio6VtQyet2VPIkpTsmlRFCuLB/QyP7yg7gcLEtGj8Xkczhf7pPFwYcRi3WUdfcYrIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACFnn+eysEYBw4xQas4l5AAvB09EpI4EX/FhhmIm4M8=;
 b=FdjCugzOwObq26zI9HJQ5LoyPpYRcOEEoHnocUslvGdVpXp1zPFHPikCNRQQbYEEoG0402o0+hmH0F1/2xe8QgatmYURiiB2i3ppG+KG6cJx3a+UsdAbn+yyCbMJatSUNIJ1qIHVsNlCJChHD3fLx0pE9F9Q5gBJ4zPerx0WbmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB7314.eurprd04.prod.outlook.com (2603:10a6:20b:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 16:31:29 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 16:31:29 +0000
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
Subject: [PATCH v2 net 1/3] net: mscc: ocelot: don't report that RX timestamping is enabled by default
Date:   Tue, 27 Jun 2023 19:31:12 +0300
Message-Id: <20230627163114.3561597-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f34dd1f3-8945-491f-8463-08db772bf5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLYoQee3YFEjz+D+Gf6qGOXzxHPVoZx4rjNUcdd7diJ3yshrzchz4HpNti7IcGTfhHZbGb8mBWzTx2fLsW9EHny4E8RWGEMGdiqW3c8ccn0bsyb6x3q1feo0aLnD8bJ37cAF3bNWupHLy28AA73qFesUdRpDZfuljO9cX+yWE2IDa+HtEPmbsot8gGjdL1guqTcNvsBoBS7A7Y/eQFxGVfj5VFF8yvnU34pYTHDX+Vv1XUungfMkEjLzZTgUGt0clVBPO39aQR3bE5YNxXD+UoXNcqZtdzcRIKenght7zxoCQ3i6zjxVkeN+5o4Ukbp5zkFH47cUlzKvJwmaWe8AFqY2ThEr2hrILRcbVC+fGLyevdAcxnLFycLLhjtRltRfMD1XNK7Q1JA7Vkk6+kHKrtAeq+t8K68K2+pJ+fdm8CzJ0vEg/aim2IdhNpeaOxS6pSmKM/oTXKDqS2udTH70y+0fnMnuCCnD5DRTXEc0zApoaFWwT72Df6A7HrGOuorsgvoMqMMN7YC0WLEUHW6rHtfTzXX/kLR+RTWUKUJMyYSSPU31zLqATAx8r3qQYwFLKCVmvYWyqc0dxbS7xWlCaTKVhwB+WErhgqRdRZHcKs3TFDCJQoYtDGRHqpa5jMJd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6512007)(1076003)(44832011)(7416002)(66556008)(4326008)(6916009)(66946007)(478600001)(316002)(36756003)(8936002)(66476007)(5660300002)(8676002)(2906002)(86362001)(54906003)(41300700001)(26005)(52116002)(6486002)(186003)(6506007)(38100700002)(6666004)(38350700002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mJkfqYYSYGiI07u5iU08328E8CSd1oOL+C1MLCe5Cw9mUVcyqdOgNQKGSVzW?=
 =?us-ascii?Q?TcRpMlE214SXIGzLu6Z1sW64qYlJMVuq5djSchK3rwoC8/znD213vXWdguHj?=
 =?us-ascii?Q?Fo3OD6TwZ5fpcvmYVIVPlZ2OZNi8a8ir+446KZaLWgoYnq69hRIT8ncAWzUc?=
 =?us-ascii?Q?idzMUCmMVxHi5u2a3P3/EcpYcPCQfifz0PgU6viDX0i1jG6t7DfKMdfhPyqL?=
 =?us-ascii?Q?A6XekZKPZmRLlKg5itv58OkqGsDXB9orEjp7JYHmPRQjOmElT77c++m20LYu?=
 =?us-ascii?Q?HuGQtK0PY7LtsQyaw9e032cyl+d8TE7B/ziqYzg4tm3VLOBk/VtM0ytffSbQ?=
 =?us-ascii?Q?iRM2Ec8LubIMczkUQoWHV4BVdA2tX2PUIYK7KRgStoItjG50A49pPD3xdzrB?=
 =?us-ascii?Q?/45mBTXF191uVEK/C6gCuIyHOcpuDnfKCW5RoGbOfmY0EmZ+CGbFPs3rLU5E?=
 =?us-ascii?Q?9gvF1BZ05O5nR0DEcyvxNLlyuGFd9xsFsntnzHFV6d7IchnfurRt3hROfGtS?=
 =?us-ascii?Q?TktXjnzsjX++B+4OYOXto2ssUdg1Wd8F5WgKnEUOR8HebQL8LHWHus/scLQR?=
 =?us-ascii?Q?1dQIupopKtFIN6Gj3RYC0G3+VDyJWgDslTZFn00wuBCuHL4zISf4sMiMIsuk?=
 =?us-ascii?Q?e1doKy8zZauqHXygP3iboqK4hzNRiGdy3p7vYsx7h93saZMwlpaefagdNApE?=
 =?us-ascii?Q?4wYr9xb28557FtRbKZSr+extcI5j9nwKPVhHop6bI82oXBYNTjztaCeBuSgE?=
 =?us-ascii?Q?n7YyZQUVM41ASYuMt9U9XIkaB4i7ifgSRBpqIcR62pnDOf62LHOAxB3RoUsY?=
 =?us-ascii?Q?CVQRUPQzJy47aUlZqOOR8g6V/sMTs3NpXP4DlQvlOV9rchuipQlilfFStBe1?=
 =?us-ascii?Q?gR0uhWTg0iYq1yWfWz15oA30hOku9P2fx2Lm7xIOCtbgAPic5ircaCItXixg?=
 =?us-ascii?Q?OR3te0mWS7ydr8REgNVizZHJ491Yiwl726PTPeg5nZ0eLSC6HioM/aLkN5ia?=
 =?us-ascii?Q?sCcxt4xQ2UtXfwX/mBxyInDKxAuB86wQFTgiIPEe3j/lcMZZqlF6l1h1naNs?=
 =?us-ascii?Q?K3gRP2HyhnlgX+redRtaLxir1IHXXTJL5HlNiOz7ReoUAmIlU1fpC0WAifwd?=
 =?us-ascii?Q?PCmZgclZv1BKAdVF5LsMdvKaqeUy7W6Nu5iJqc9gajxk9O/FMBsF0ycGjyjF?=
 =?us-ascii?Q?kmbNLj/B/sc/3gyd0oZhwE4YfxlFQxAdgwZ95frD89TtKa8ZFQaA6KzcZuGF?=
 =?us-ascii?Q?QbrKrR9eK+LIyQmmQ4dbw1NpgLSxW9OHXHCQxqPam7wA8mp9MLt7tdm1Tb9t?=
 =?us-ascii?Q?qveFyLVvkEmJwE6ecQhZbwovP1Nbyauds64kZ6VapuHO0rM8Vj+zJycjuMPk?=
 =?us-ascii?Q?3VTZ6pmXUt49NKx7JXT49PUSqT9xwkWIBM1pUfUfgBfVV1AnAGTNR2+yf3TW?=
 =?us-ascii?Q?OmzAs1LnP/H6moujqhvzQJG/rDTeyYDy88R5bgQ3unBD69Jb7KANZyjEV0DG?=
 =?us-ascii?Q?TW8ZSPdbwKRiDCdNgQQO1WTSTorCiRP8ES8yhCXdcM3ad2TIl6LtlPtP+u4q?=
 =?us-ascii?Q?p8xFek3IeohFfQZdb+be76odArWFTXxhD7WkElLSYyEKlquZsAHc3C0esmor?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34dd1f3-8945-491f-8463-08db772bf5e2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 16:31:29.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seFwnY4ves/WEPlo73HcT8O9aCBHmKNM4MYTcLdC6XMEHH+xMXnpnt7nx85pEe2V13rcJwa/EULmrC1ERZHYRQ==
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
v1->v2: none

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

