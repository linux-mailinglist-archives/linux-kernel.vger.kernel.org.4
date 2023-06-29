Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FB9742808
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjF2OPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:15:17 -0400
Received: from mail-am6eur05on2065.outbound.protection.outlook.com ([40.107.22.65]:38400
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230119AbjF2OPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:15:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsjThUH2gO0ps22feBEmyfPG1SBekIv9in72pJJx/hxoXvIEdC+sBkZBcfLFWRVHKZpeyGLKrsZFL2Sht3gXSjQUPtMwnkmYaVKGjH+BQDGr2uYLKNvGHfNeC7/873sw3IdYOxVNE3J2sED4bW9U+LlMfFtom616gG7LR8q9AP0urjo4NtErIqPPYv6ZYu0hyHz0D3Rv1F4grL1zTwkH9qke/IQ0M0N5tiu0tDOfF61ln6auQIS1KwTF7nSflUnU1dg7NpOZ+CwDWiMcTslM+rOlcSUnY4NeYwmYaTMCe2JXJcMHqrcFbckyd0MHoqfOuVseSFqEoJ4WBYbpY3eYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwRW/0ave4ugQ6i9W4UpkELO70kPhm8D6SPMJpY66pE=;
 b=epoDsXsQo/OYIhYKM5hb0jcABicfTPBMuQ3gCTOT0yuXY2xZhiIpfpLY0FSn58crOwrVeoAynY0qhBx/V3MElQOs4Rh1nM3nCpI471+FOosX8EIkJ8RSz4L24uUn61x5fjHsO3j3nD+JWgQnCKk2A2FxPxnWWyaeVv2WN0Z1UojTwjSpwI0NJO2X+ATKyTiQafjPnBkrI78nMubD4Jc6IUlMLrFRuMkoTigoE4R85Hk015oKgecjf6AAEleWG73FEDsmkFFl8nTdf7xixKLK4ZdBMh2Z8Th3HeDrbMfWeisY06QTsoKJW9+C0s5pe1JPJhIxUT8iwOdaUPiStdaY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwRW/0ave4ugQ6i9W4UpkELO70kPhm8D6SPMJpY66pE=;
 b=MOs7CgqF4DiaLCh0ERcruVKKk/sWSTUB7ToIbqaJb3KqLDUaf5Z7G62unqAmt61zLc1S3BB3j9ZAjYUOuo43YjRj1ML8PSAW8PGwBSSdTD3tK9K1BgDJVRIN2cJ7VrR54Px7Y/nkpDY+lsKh/RJ4ggSzuY/lpzIZCjg/zfThk1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8406.eurprd04.prod.outlook.com (2603:10a6:102:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 14:15:05 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.036; Thu, 29 Jun 2023
 14:15:05 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: dsa: tag_sja1105: fix MAC DA patching from meta frames
Date:   Thu, 29 Jun 2023 17:14:52 +0300
Message-Id: <20230629141453.1112919-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
References: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 658c6069-d10b-4204-02f4-08db78ab3cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITR6Ed/7vj6gEvnaqcN2xx1Q3c0x+U95pl3pcSi9A2l3CXvGY/QX4lL8sgSn/9HYt59fUrPgNOQUL0Uv3UaQiq3cdMWMdDO9Gupi7mb1oPfm4/6zWu8QDu0Cl2+zOVv/ZTd60ZZM5HsUD2SitT6tEVHm6elst3wAoL6fYTVfjXeLOkMZ8IjUqXAlwRlrWGjccBvB3uBOdNMjMWKB8EqrhNyWLmQS346cj6P//Ze0/r8D+Jud8yeDqdzUkNONqNeaE8VvaY4v3wkGEyedK39K6byfn6ruSX4wViOsvjI0qKdcDQF18db1zY06+0KXYZ94BwT/2Q1PI0gYVDfFfRJV7HwW3CrvwSORd3Po4z63DxTyqPmXTa+lvMTuc0rPc412dqAuZjAORQskxq3HBYUpyJzAjJKoBFMknY5TsXOAtEjXzT3xWTp4AjaibJjsdYxt4Xx8+Q9gZ1qid9z7TCg5vXZhpN18ZDi0FUcqw4PO/WdtodIt9RbB5nXAlXoqSvlmbJ7liqKnjyYSzE61ovCwJDIF+Xs3pzJLzzuwocoD3DALaVLMwnn+UBjXYjJVqamFOKdwfI9f+qdo5AdiPTHPn8172ys6Y0smOKOUviv7rzP7BUifgCtEXJ22FLsVNgPD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(1076003)(6666004)(54906003)(6486002)(52116002)(83380400001)(2906002)(26005)(2616005)(6512007)(186003)(478600001)(6506007)(5660300002)(44832011)(36756003)(4326008)(38350700002)(316002)(66946007)(38100700002)(8936002)(8676002)(66556008)(66476007)(86362001)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SnbsXYc3iJmMk80uGT8k3R9ci43b3JpswAUnSZ/hZ6aQp0MsSb/lvEV5/f28?=
 =?us-ascii?Q?1OHed5EjX6zuF9CGqyJecvcuy5vLBibPdQjH3nhV8zEXr1k9ky72kJY2Xukv?=
 =?us-ascii?Q?cICvAZX4GKgI6d0R5bnqhJavMZO2UIyYG9hV0A6IauTL94cLU6Ok4DUiuqvY?=
 =?us-ascii?Q?8I0Oo6f37pGFzB6H2Bih8YPxs/Y6S5/IX8Pt9uEv+EljHIrTOVTcsL/1mRxi?=
 =?us-ascii?Q?moncTJ9a09EXfekzIN8UsrvNN3JHPVrH15yFm92mN6PBqq/3mvWye5lJDMoz?=
 =?us-ascii?Q?JC1pOJT5DQs4YFgQZh81ZbZcxOfK7mrvPq2aAbvZvpsXKjAw1VUABO6z46mI?=
 =?us-ascii?Q?VToEW06RZvpsY3wn+OHpriR46XT0oIqv+SECLWp043bN9FqkGcCSS7E0iqgx?=
 =?us-ascii?Q?6t0dqGFBqCCqNR3bZLcfPr7UFhvJUWqL1mMEdkJlGwKRJLwK9DS8PJuwosa0?=
 =?us-ascii?Q?thAr0rfGnXheoKrxkR5sz1q5hdBquoiGcVVSp33L/8N0Q0LsxurJEzvlZHGL?=
 =?us-ascii?Q?ZmgHrT93ZLLU/WMA9TTGFKV4oHTJme5g5pJsx1rc+Inma9bd2o1Rx2WMQaBX?=
 =?us-ascii?Q?NLSWPHQDVWVQIqld5YPCd3I7XjPOQ7vWE94LJm+GL8112IzA1r2mj+/Fgrg7?=
 =?us-ascii?Q?OUSUxYyjvZJ6uyBsdptN98kr9UyMJYGlLM9XHe1FVtEgiH2/liSS465wrn9h?=
 =?us-ascii?Q?fNXlzNOuyc4loVE6N8v71cWU+3U1MSPtbidkjFyZT1nU4g/jbT38eYiLAYwA?=
 =?us-ascii?Q?QoNq8s42oM5hl2HEkoUywStJtq7K6jM1m8YwxTZ+M00TbazU9t+NL+3lnzwp?=
 =?us-ascii?Q?tWM/LxppgPmhhhR8OY0tZR11gKYnl1pYrI2frw0POrlTK+x6sLZ01CJidvOD?=
 =?us-ascii?Q?yUIyzdyAFcg9w77HholPSIHp6VTGtYqogCPZrrHCGBKXXSOqkvxoUAPFP7M8?=
 =?us-ascii?Q?pzwE2KzMpedyX5f7HJztYH6CUTV8qsy3ZSYgO0oMPLTOLPpQXw58KROA75Ku?=
 =?us-ascii?Q?lwOLRoMjcGjOfadc38vtXctRnkZO4ZmjeEVrGs/Rpn2vg8A0ytWf1aiockF+?=
 =?us-ascii?Q?ecZHn5f39u/zDMaLVwKWJMqAPwt8Hvw9z1i3IHxhxa0WC2HS/GsmJtgUcvDp?=
 =?us-ascii?Q?O9Icf2Hdlxq+nFsEa8Sz6nokhP7A7LuON7KpoHeV1AKKQ8njt4VNpQB6p4/0?=
 =?us-ascii?Q?Xv5sL+XohHzxz0rzewu/HUmdwpr6uxBvJpMgOj5fltpaTXMPl5EK4E7puZBL?=
 =?us-ascii?Q?KUwkSH0JpjYku/SKY7IpQhv3qQLUKzYOm5s90QjkP5TstuPIuq19jMmx/nCA?=
 =?us-ascii?Q?ggWBx7zZXSuCzXNoDPcQUEtl58rn4nV46lNFa8jWMtZCVS8ueIkJu10c1rCG?=
 =?us-ascii?Q?y47k//23rJFy0KyQkgvoLbU9Sq3jX3Q8HmqNle/g79p37H4oDszVRpQ5EOxd?=
 =?us-ascii?Q?8cbFjoiPPC7+g7jybgtjVQcFR5ivD9Sf+BqawArSHVgyXw248Pis4bMUvjPW?=
 =?us-ascii?Q?dJlTAROd8mXnBHJOWY3i9xTkhx9TKxlvn0SUJG71Zp4GOikBphqz/pPs+MpA?=
 =?us-ascii?Q?xRH3FmTbbkgJIx+EtJbaQbOqTxFYqFh+NzUtcOu1h6yHnXk0bZNwMI+YVUhX?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658c6069-d10b-4204-02f4-08db78ab3cae
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 14:15:05.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIGvrZj2CL1u4DqX4yYIZkoPrzygngmKsDCgeAxbiXVxN8eK8csVyGeByM7ea5VYa4g/JbGyfcSAMs1fJqGeOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8406
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SJA1105 manual says that at offset 4 into the meta frame payload we
have "MAC destination byte 2" and at offset 5 we have "MAC destination
byte 1". These are counted from the LSB, so byte 1 is h_dest[ETH_HLEN-2]
aka h_dest[4] and byte 2 is h_dest[ETH_HLEN-3] aka h_dest[3].

The sja1105_meta_unpack() function decodes these the other way around,
so a frame with MAC DA 01:80:c2:11:22:33 is received by the network
stack as having 01:80:c2:22:11:33.

Fixes: e53e18a6fe4d ("net: dsa: sja1105: Receive and decode meta frames")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_sja1105.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 92a626a05e82..226191ec654b 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -118,8 +118,8 @@ static void sja1105_meta_unpack(const struct sk_buff *skb,
 	 * a unified unpacking command for both device series.
 	 */
 	packing(buf,     &meta->tstamp,     31, 0, 4, UNPACK, 0);
-	packing(buf + 4, &meta->dmac_byte_4, 7, 0, 1, UNPACK, 0);
-	packing(buf + 5, &meta->dmac_byte_3, 7, 0, 1, UNPACK, 0);
+	packing(buf + 4, &meta->dmac_byte_3, 7, 0, 1, UNPACK, 0);
+	packing(buf + 5, &meta->dmac_byte_4, 7, 0, 1, UNPACK, 0);
 	packing(buf + 6, &meta->source_port, 7, 0, 1, UNPACK, 0);
 	packing(buf + 7, &meta->switch_id,   7, 0, 1, UNPACK, 0);
 }
-- 
2.34.1

