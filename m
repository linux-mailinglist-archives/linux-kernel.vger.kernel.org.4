Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1763742805
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjF2OPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:15:12 -0400
Received: from mail-am6eur05on2065.outbound.protection.outlook.com ([40.107.22.65]:38400
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232251AbjF2OPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:15:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELRwB5a3NShznqWhlmdr99V5/QinxhecMVhMf/erSDnRTJzzFaJCKdd5hTdhUP9s/XP7k65FItx3kAPbqVLI0AqdHgSZnD8hEfElRDw4VstOASvxo9k4Wqw54oJavx1Y1lgLcxmAM+YxAqv5FJGjGxgy95tUFYJ7DpJAS0uvQ/7c6F137pfBydFuFjgnaaq8DGH3mgcGiUkASrg4iRJHYIvyEukOSBqHMol5V8paikFJhd5YVn+ZFxC5mz/um7+LDvM0T15K2EbfX+KK70PdiOcYyPTbYxNLgQU5bTIFeqcX3Wv4iUkpf2o5AfLuDvWnv5cU2uuIKsNl/8zA1vxFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9uWXx5U6NJv9IJ4mulwa0UJoWk5HRI+kACPTEIAsE0=;
 b=aZ3OjGz9FzBHXoDJB5Hi2zgOeV8dJWxsnbcD0QsbhzOwb4J+QYhGEt2/TDdpaHYdKArIoc4gBfw9ntrMgBYRQSKcPpx+UjIPxggg0cWZlQMmexrxQG+KXMynp3HdMFW3kJwuYyKx9wsD6qV0CF+QVkA4Gb1+53e3fj8CVik7lecjwh15o1qonnWTzgt60aLLqNkNcH0b73tIGoJ8/AkBid+HxXCTra5NkwmOSqLuenN0/ioZ7JA/AzGOySNIog6YA9BhsMgHpUl4Lp1GPwJDd04D6gxsvvazO/elEujGDtjEgYKUD5/Nh8nI094ojwvM3zJEmvdkCgwiXDiXDmrAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9uWXx5U6NJv9IJ4mulwa0UJoWk5HRI+kACPTEIAsE0=;
 b=K814XH6kIiLKbPylmLeW+noiSwP2vuo2S+jO1InXZoPuNQA+GS3Lr23GDCvcwciBLzlAHA54ojRYdjv49Qcy679NA93iwFWz85xG+2pX26OiPJ+QUlxUA390K0Vun3IyXIPUhqksvD/ir2kGTy9qLm+iRAt8VnW+GsnWBJr0xTE=
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
Subject: [PATCH net 0/2] Fix mangled link-local MAC DAs with SJA1105 DSA
Date:   Thu, 29 Jun 2023 17:14:51 +0300
Message-Id: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e65408-0d1c-4269-5828-08db78ab3c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5BRzQacdUK2HH+zeAIkKx2BBb4ga0IXZJYgHbBblYqGVI5HtbknnvXwXyZrjXxBzGe0FewoEpwaF2hNH29vZaKHfZUhPQLIRjFzA6WrjsT/1bbUWGzY2qkupiuxt5f7P6TNZIItVeEBvlIhY6z8IlK9vF2YcBRAlkdcgoRDQEojCZYW4W9XPe0KIvtoUVlm+l486+3IsUabnwx+NNksKqp1wppTZ5m/7Co6V+eB7s8ELyw0yOS1eWZ5kDJwGE1gj1c3MbLP1KSclXCbJapJqadcfpvOY770lRPNtSoni/k8Rs6C23/SToRxR4GSPCkSxOdan4IcwieHOPtqjWP0NpzSqzVbScLmSY4ieKXwNEHTehNRzA+ASV2l7DkJ0yOQZY2nokOnsNnZSYQD+sTNvQp/rQBgsr1XoJrh6wbPNEuZkteq02Tzb3SIufwgcBxxZTY0/1BeqkuKZwY8e8q8V82XSkYGPPCqejspJ81O/5tvUEHlX4rt5jm1w0JSZdvQvWaq9UpyGYBFnamjq/cuMWOv0r/HKfGTQSp9LXuvlUs7SdyQMrgzE4g00tEqXwm48Ptaz+ywL5vzYXn7tviGJpFJ7yj1SO4PQ7P9UGh4PwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(1076003)(966005)(6666004)(54906003)(6486002)(52116002)(83380400001)(2906002)(26005)(2616005)(6512007)(186003)(478600001)(6506007)(5660300002)(44832011)(36756003)(4326008)(38350700002)(316002)(66946007)(38100700002)(8936002)(8676002)(66556008)(66476007)(86362001)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o/7mQbN2s7py8cfozXJHYLFo308/HtqV+GsWVPDt3E50o5URAJYsXZHLMSIu?=
 =?us-ascii?Q?jphTiC4HJmxdXhbDdi1jeBRfOPm7iqnUu+a/I+3Rg3zjHw+4YglftJjsdZNV?=
 =?us-ascii?Q?4eQ855PXnnqjxq4ngcsUla4grQ15Iy7t4mXZF/kVex4mJXIT6HIIe+9CV6CV?=
 =?us-ascii?Q?pZ+ubni2c92ZSh+LG4HQurOKu7z5Sl7DA1I/FFrRVMoBvx6OiyiwM5asQqG0?=
 =?us-ascii?Q?HYT68DkrJl3ftRioW5Y9ZbU/OoE8nQ2iSh9e0MAzSF+SjO9R+obxqGZiImjB?=
 =?us-ascii?Q?QncvaZgY/lGQbCgyuRxFA6/x4vtqvtBX3251gVdSEwvo5NOulmq6PvyLzOc7?=
 =?us-ascii?Q?CVGueOUbpXC3JALyy/UfZNCsJd3jRNiQviiU7wIEJlo1VhWxYk/qb82mP0Bm?=
 =?us-ascii?Q?AklkytLXUUMZDeC8UaOQHqh2IQAMUj0I+55epHCso2BMH8iw1WAXLGDQMftr?=
 =?us-ascii?Q?EpYrMJn45RfMOqpLtLn7/AS5bKU1KW7ntnqGZN8vX3EQEC36jtjBUbIKxslR?=
 =?us-ascii?Q?CrJ2D27wrp52mQPXhW5g0yXrh/gPktsWIF7y90pbPqtxY9Vbf/75Hw1lpNKU?=
 =?us-ascii?Q?1DwZr3a7Fx+ZLzjnwNkDKcQpRqIW6I/3IW97+3IKQ8bPO/Bne1mj83ixlscq?=
 =?us-ascii?Q?fMVE7pIOPyH7KoxjpQLyjBoV0sCYrlxa2ZwM6i7Zon3KJ0j/joAyEC+60QNn?=
 =?us-ascii?Q?/itPlNcgIrlE0Rdg2BE+kqaT9O++WQcoQ6dMZ5urGi5FeSM1JxML+Q6I/Rsh?=
 =?us-ascii?Q?B7gw53AkArJola42SmGPi1d/NRji6LcR5Zgdd45ouJ9sH7vBN4EyssNLa8kC?=
 =?us-ascii?Q?bP4vp52cs1EyELcsQ8zVLuMdI6UKzuLfFJ57imLhNSHzw07XAzXmv5vqik5M?=
 =?us-ascii?Q?6PswVYFABsPBKzt8476rV9gy6LrynCS++ycxSIW9fovcvDbPT9WDlzzVm1lc?=
 =?us-ascii?Q?5CA5WScXqHayqKNEO+U7LQxc0snDkz2l87QuIdnNOzAiZbnRdSXp7KiIjdpr?=
 =?us-ascii?Q?Lzd5bF/58Ao8ztp4sWgIRjyxUyWtDJmt1OLMwzC47SqsftYo17z7ULTEfN/A?=
 =?us-ascii?Q?d+NTXCCg7DSsY4KPZmisKs572y/NfvwB9+M3rIxjD4ah5sWXMwP51ZTdvMIE?=
 =?us-ascii?Q?fRVYX5M8XcMEqo3Hyr7KRSeaQAS6VtFxPvYlRWRwWQa5W9kroyqLZhU1jNyh?=
 =?us-ascii?Q?8g80RLgiicv/UxXGYyoXgkm63TyLQOlTRdiJWIyNir+SNhq+y00EWqjtqBqP?=
 =?us-ascii?Q?Ci44cQUbSmQd6FXwKpa8vMXqExPc2P4CYEfsZ3VYEtj+evRAyE/w2jZOajyT?=
 =?us-ascii?Q?T77X4uOMgipE+xHXBIa6yKf7NOQXgkd5YJ+UUe0eqlOPR9cf7yStVd9gCkf8?=
 =?us-ascii?Q?ZJ5o9nJnf813KHF7TLNyEKrfrTuHn40RTlrtbXZpsb0eZKXzUvJ5+a/+sdrT?=
 =?us-ascii?Q?2OpHumw5EdidHEVWKUmDZR4lWJoBJItb1vBbTwNR5+caAFksnSWlqR1Tg+JS?=
 =?us-ascii?Q?Kv6ERFeh7KljfLEy7bjeMRsSLNYlt13HV6R5cz1670te6nbY955RX7+/BQfq?=
 =?us-ascii?Q?WhyuEdjuE79IHbnNVz770FWTlCLbmIJzL+sFthkzoFBoXkuBPcnPRX+HUJJC?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e65408-0d1c-4269-5828-08db78ab3c40
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 14:15:05.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/GLNK4EjzQZB8TfWrcKxt2QeMZV1kWt2bF47FWwUoAWlUU7Q07nj77udtpS1j2d1m9NnBfM6KItccP+LKfipg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8406
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SJA1105 hardware tagging protocol is weird and will put DSA
information (source port, switch ID) in the MAC DA of the packets sent
to the CPU, and then send some additional (meta) packets which contain
the original bytes from the previous packet's MAC DA.

The tagging protocol driver contains logic to handle this, but the meta
frames are optional functionality, and there are configurations when
they aren't received (no PTP RX timestamping). Thus, the MAC DA from
packets sent to the stack is not correct in all cases.

Also, during testing it was found that the MAC DA patching procedure was
incorrect.

The investigation comes as a result of this discussion with Paolo:
https://lore.kernel.org/netdev/f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com/

Vladimir Oltean (2):
  net: dsa: tag_sja1105: fix MAC DA patching from meta frames
  net: dsa: sja1105: always enable the send_meta options

 drivers/net/dsa/sja1105/sja1105.h      |  2 +-
 drivers/net/dsa/sja1105/sja1105_main.c |  5 ++-
 drivers/net/dsa/sja1105/sja1105_ptp.c  | 48 +++----------------------
 include/linux/dsa/sja1105.h            |  4 ---
 net/dsa/tag_sja1105.c                  | 49 ++------------------------
 5 files changed, 9 insertions(+), 99 deletions(-)

-- 
2.34.1

