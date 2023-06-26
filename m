Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2975873E3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjFZPwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjFZPwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:52:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385A1F3;
        Mon, 26 Jun 2023 08:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgQ/M6fP6wgdux2HgyAIwOwizRPJwncEFMNw/Fn7EYdLFkqa6L/huuG1XIX107oNh+P4tTaUMkLV/NTRBmQ+oaQLopq1a5td1yBRX2NQKdQehpUyBm4maEW+rN35bV6Vt/4iYPq2yQBYUt7zpxMBG19Q1jI1e3uBlcQqBPO3AHqU8KHOTiwNwwMwTcgLzdoYbrLCBGZy3utV0065a23pNzBSakIT/NP6NC/GpfCEyBhoo3Ghxu9pOChTeH+WAE9dgzs8EBAl34BS+OgFroeieLi36WPDF2+0eC0fVHZJ3kK4I0GhNGTUMN/tBdik3GKtLqYisCShGZkJOfSDELd75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6isCo4W/qt2+deuKSmeCVxUyhhJQjnFMocv3q1kkiPM=;
 b=i+2h03x4novlmpjriuCtFeRmnyJUbe7F8rOi7GOU9JxpXJ3kO6Nt797LWou8xjt4kbOrM/mj5xBOlqNE7ZrS33O1WT4tTTMcfRqp3N71MXU04CCzoFoxWsK+jp/odFHaNkjhvjMEkq/konjm5eRjMHvjsnhrKVM3NRECgxOnNxhASwr0cQOgo5Enbp/Y9MyosSEAD+eafjN6vZPETMWozrqizFUMgQjXOC85nnRfnHzm+p+g/QdC4telp97bF1IeMQfFV4Ow+MXGjmkTY+ehVqV7vbf5dtAl11Chj4x3wrCVdwLCh9nDPsnsGjRme49mnlfpH7h9FT7iGKc0GTtdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6isCo4W/qt2+deuKSmeCVxUyhhJQjnFMocv3q1kkiPM=;
 b=BuP7KkP2s1t+YmjBUdNnmN3hR7evJjntjFBIrjxYetzo3vHBEVdoN7TvzpxRbBSGjvDo6pHqClar3tPTKZYBYHjbv3mOGOqggFHsNnP/kLrR07bZNrWLaK07qR/qyax+qhQ4EeARTlStbMn87GW8QsHq08V31tMUNCJ0oz/oICQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB9522.eurprd04.prod.outlook.com (2603:10a6:10:2f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 15:52:17 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 15:52:17 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] Fix PTP received on wrong port with bridged SJA1105 DSA
Date:   Mon, 26 Jun 2023 18:51:10 +0300
Message-Id: <20230626155112.3155993-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0003.eurprd03.prod.outlook.com
 (2603:10a6:205:2::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: c5629bdf-cefd-4d94-49c3-08db765d515a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuIdrbTHhsP53RHDnZomJt5IMqXbkTLw48LOmyntyQetDRm+sYGd23Fidz63BFz43XndgZjJbjtuc8w8tJZO52rKZixAYntdRwq1rGVbs+ejAzziGIvOddTJlX7D7gh1VaoCB9ljcpJZpPRiT7gG8iFExfyXihXRz+npgJrQGHVcDmVy2eh2/9RUo8OiDXWHPuHGbdzwxkY8PP7tOV4NfNf7RLEX5eRVj4EWuBm4QDgGrZhaGFg3W+CaDYm+LQvjHlM2YgANqhw6neNJxwXnqMdDiAQ31iV5h3bihRiAjuJm//6omynJ0mqKyGFKCGK/UCI+8BQNYEd68N56IwNoKRqPvWR749eHQjXVp82oyJRsU+i0ny55Yl3A0E2ah/xPZ6io+74ARP6rkDT4jouQrrW1CfbTvo8ppSsT8ZK+LubVvoDzmxxH3m0xMa3vDfatiCDWq2ob0Y9IY1qvoO1uLQdR9HVpLcSLBcUXX2AARj/EsTviFShnvDFFdAfmrF0ESgLcvMpdE7GBs4zbqSZ9BGKmmo+wAKHkAL0IAJ2KgKvxdURsTWdPAHekWpd9DC1z0Q40vaG5VdhylE5gO+LH5HMQkQIvaQrgbyoitl8Vs61tmdMJZqVWl+37XB8fY7Cu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(6512007)(1076003)(44832011)(66556008)(6916009)(66946007)(66476007)(4326008)(316002)(478600001)(8936002)(36756003)(8676002)(5660300002)(2906002)(86362001)(54906003)(41300700001)(6486002)(52116002)(6666004)(186003)(6506007)(26005)(38350700002)(38100700002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H6hSEWRVMdtYdhNR+hr+qTQk6wm7ZDpQF2gEr90l39O+Pzrehclyw9/2kri8?=
 =?us-ascii?Q?yenWmIVJXoFmQ2klxxg4UwG34f/TefX9QE6jEkvHVxgU+U2pWoVqcY3PlUFm?=
 =?us-ascii?Q?xy2K+0YxLrL550I2hXV/6O1Mc4QiZqmhKF8lzlQuv1JWIz+pcnBwK+wOJcsd?=
 =?us-ascii?Q?to23yGGKGpVSCOEkvbaAOGgJs+ANWUkEg1MmAWWhCUP/hm/biVIWLmPa20ZR?=
 =?us-ascii?Q?BkX6boONxC+hlL+g0FcUDHWGw0jKCjq2uklHR6Z3oS9EvxuAV/FzaIGUKCcq?=
 =?us-ascii?Q?cBUK6b4tiZ1/AuEZ6K4rfjC4oeuG7jnTb6tYmxnOpPRI5d6tZxQBsIMmtLsU?=
 =?us-ascii?Q?EUtyn97rEGpD6G5aS2bSceTx8QHUGVOP//IAyTomPscKyIOW+Gvkn+TnxeyQ?=
 =?us-ascii?Q?9xn8yE4F7f+agFzc+YcH2msQf6S+uIuYYOJBwyYBFyW30dfTRx94BhWyhHyp?=
 =?us-ascii?Q?7jlPMGozdWJZCzyBRmQBU0OAK3TfTJHkn6/L3WY8tNrdiuSToxLgipMivrZ2?=
 =?us-ascii?Q?T1zqRjbUlgjgYjqIysRn49wqXaHU4kfO4Yn6ao0O9lhgFh7c9+GMR72Lwi0y?=
 =?us-ascii?Q?vQTrjADSiyeWzJJfxhBF/SXOvmHsBbUIt2whJ3LNdMTyKDUyABKG0gLG8bTw?=
 =?us-ascii?Q?W3Cf1QXrgxKgrh/8BXuddtFP48B+cXPfia9TshVJ1nLiu9QddYcBY2FxQNAR?=
 =?us-ascii?Q?7c4JvHPIpQjUWEn0DzEWQWc38+C5md999Kdttl+yaBVUxWa7W+FNgTf9MgbI?=
 =?us-ascii?Q?btkkxLI0G2PSIncQqtkHB1/A/pbMl63uUB8zs7snl2E84Glki/ssXLDCjy1V?=
 =?us-ascii?Q?I6PQfsVJ/x4I9c9QIQNKLJrvzg9EW6XbConRYjJR2MhZkE5/0rQ1Sh3ov6l4?=
 =?us-ascii?Q?LdB1PqgI9ER0EEJTm6mfgad5nGRk/7f7KVLRhZbpsRUgmEPM3awJgZpfsGlr?=
 =?us-ascii?Q?xWWJkoWxeBFinN0x3au9e0KSRQGciqOKMt6QpvXf+PQ27AAzY7h/yTMUuvwe?=
 =?us-ascii?Q?T8iOi8W5LM/GtjCjdrWxmzhUN33Ux2tkGsTXMhdIytwCLUe9UGtq1HmZfTTv?=
 =?us-ascii?Q?2e42+HsquSkVl62WXvpqlTzFKO+aNQmkgUU5XzqfByK5A2/7GdpIicUqWSYc?=
 =?us-ascii?Q?TITIyFxktM6BgRtkiKTAG5oLqU8kvPsoeCO9z9ZIMrGH/fOZpzxZT8sOocTU?=
 =?us-ascii?Q?p+h3tiSmERAUxBIY8e83hiMIKIzoxFnV6Kgi+nZuuiDmHQzZ5A7xihtOBEty?=
 =?us-ascii?Q?fVR7aWdCiTTYUXBNnb7KwDr6Z/Ns0tjk5SZiTTbiD4JHZqXP7jYOadCItdKS?=
 =?us-ascii?Q?l6i+Llh6r/wcgMG999TeB8xWKAxuE2AJUjRRnXOFerOkhs50GxSi8KiUg5Jy?=
 =?us-ascii?Q?nyhbBdkbnfzo7qKxykSBjK4nn06UMQOxZG3ufd2AlplbcfzU54GDl3fjTxNd?=
 =?us-ascii?Q?dKfPPP+daDWDBg9rcrhyd2/5K2ryfhd9ljDGBj8DQlX6GREdYanAYoaHr8cE?=
 =?us-ascii?Q?UVxFFMybHyOLPWMVWLR1ZmON0idSFajlLnrXG0KcJnPZE6xETwnVI+EKIB12?=
 =?us-ascii?Q?a8fuYm/p7GfDzK2N6ntU8MgelSiF3unD5U+eMsHvN9RTEcr94bdI8Zkm7BTK?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5629bdf-cefd-4d94-49c3-08db765d515a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:52:17.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfxXKdFge37Vr3hHBOryNsFr8iRXZgu+MekrYlDboxGhJuf1jDt+jhXGo8i7R79r2jK3osC6nhiSJNaNQNTNSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the changes were made to tag_8021q to support imprecise RX for
bridged ports, the tag_sja1105 driver still prefers the source port
information deduced from the VLAN headers for link-local traffic, even
though the switch can theoretically do better and report the precise
source port.

The problem is that the tagger doesn't know when to trust one source of
information over another, because the INCL_SRCPT option (to "tag" link
local frames) is sometimes enabled and sometimes it isn't.

The first patch makes the switch provide the hardware tag for link local
traffic under all circumstances, and the second patch makes the tagger
always use that hardware tag as primary source of information for link
local packets.

Vladimir Oltean (2):
  net: dsa: sja1105: always enable the INCL_SRCPT option
  net: dsa: tag_sja1105: always prefer source port information from
    INCL_SRCPT

 drivers/net/dsa/sja1105/sja1105_main.c |  9 ++-----
 net/dsa/tag_sja1105.c                  | 35 ++++++++++++++++++--------
 2 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.34.1

