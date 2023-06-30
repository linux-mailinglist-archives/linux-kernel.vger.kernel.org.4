Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635DB743FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjF3Qlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjF3Qlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:41:45 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D2421E;
        Fri, 30 Jun 2023 09:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcUKWia64FdNE9IQ/+IStWf24aV+16UNHhhXrULihFvLih52YxUqbTLZRVzou++Wd5L/Z6ptlEuE6GaeHU92iBEWzBwpb3LPpQ6s0ZwbdBIKoSGcN48dn7U7Jb3iHFf/33wvHpQYNYqEN834DeXHVZK298ZONi/ytUzjWsK3UVW3gDrOimNo1VLYHbFgTbo1Jk9X24nN+s9mSR260zdXZxNGEMvjB2g8kE3hWxe0lJlY2/E+dGz9Te3wnFMzmZJvmRXlNeMH+vhfLAqWV+ZTAM3X/ludSnJlkydygZdam+lZLZzDqbnQe0fnLcTgrbj6YS7bOiDEh3ksxHDbRfUUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGI3Ph4oCibP0zHwVh/lsuMMAcY6BSA/FB8Xm+629wc=;
 b=MVs5BLocPIq1jtYOkpaVRFHC8bErozJiGQxkXeqm/qa8+6UQ0Le6AduOU+CmsXiRa1SwbZED6rTC8pNMh8y3svxMkXRYpz++35yajmXdaixCFyU2lcMnYLu4rw6e3fzQtlHh1A5V2GNmGJMLQO4Eg6g7KoFWE9nMvC9T2m0P+ZFHQmigZlyBE6NeRek6oKz1OzoT1lCySCrlAuafEpqHPg4p6gzcuHCqtS+OFK3Q+DAe/H8leK3Sby6+GvbNYj5zX1FhaXlXfTkbbD7T7sJvCaya9UftHjyzqDZT19QFsqwJVTgDkScKDheCKeXu6TjuncWR+SOJE+ZVnk1ECfYl4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGI3Ph4oCibP0zHwVh/lsuMMAcY6BSA/FB8Xm+629wc=;
 b=OKFHsfapCKBI5iOVhc3evBhZxYV2DITwSrbleyOC5BiFE/D4qs1KXwyuW9sX22shx0ljv7/1saUJknwnhPw5//5cAoMSEh75kDWBubRd1xaHtegy/uySrI8N3md6Qebntexr3FYl+YIJhQuZlfKGMTRuo3nCCGnIHpwrGShUrzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8343.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 16:41:29 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 16:41:28 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vlad Yasevich <vyasevic@redhat.com>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
Date:   Fri, 30 Jun 2023 19:41:18 +0300
Message-Id: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::20) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fd1bda-d648-4b26-3112-08db7988da02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsudGO+RyH8B/4lpbCy4gAk2iIwAkME6fLvtSScJ/2jnN/4SQ4uNNZNyABJthIgUC3I+++sA+fwTiUvNzOnjK6u3LRpQV03u8TX1RMiNZtficE60A3yH8ueh1nfnHnmIz9Simaif0rsODzDUOxM4V3dfkYVD+Uju5gD9PYuTapFjCTo6In0oc5y2INWZS1gyRnq77VPEvEYnJN8tl8qpoB9s4kSTHc8C7TFeUcCeegAAjmV8jpILmJSE7Hj4rb1O/xc6CA24CUH0njzio8DYhtWiHefK1MFfwjif+diOAB26sM8AlzxNYc+Ks1DWKoACZYMrl2trkOr1V8SjeMjkU5wXBNtjIfy+M3WQiA+77dDZTCY36B88TXixevN9i8c8kIC1NDaGNVzVGANWQaKlU6P68ohfr3NarP3yYp/LDmW6tV+7n3U0/mOqLKmSaOOFopWl8XqAWyBWEDOaLuqcRH1rtA5zA4SWlRU1xEZD2KnAWg0RV045rnrJhJRr1lZYJ0kDqRk6bVTsADbkD1WE+nZDX67VAsYaJXFYbRLlLM63AWIX7mX8DIUCsvkswt/wLnZ9YgWxmQas517YLKe7xURpyWgv/lpGU9vTNHLaZyZ7KgEb4NPSSTEJzHccF7j3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(54906003)(4326008)(8676002)(8936002)(5660300002)(36756003)(478600001)(6916009)(6486002)(66946007)(6666004)(66476007)(66556008)(52116002)(316002)(6512007)(41300700001)(38350700002)(38100700002)(186003)(2616005)(7416002)(6506007)(26005)(1076003)(44832011)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FdY6HpO6A8162vBUZI1zC07sUdescZkfUM9GW4NJD+wMxP6+aDg2GV/2K/i6?=
 =?us-ascii?Q?0SxPjiIGQuMr5wFoQulj9O9C3K1iiboikPz2P6EtWkmlxywwdR6rfstHlMZ0?=
 =?us-ascii?Q?wI8FrOBmccKSRCoWe9h+YjwbRHeY8fSWUUh6UjwHKQiVQg5sw9xrJsPFV5Bd?=
 =?us-ascii?Q?PfgoxQkU44uOk7hbMjDYRqN83vr023wTfAuZUFaDCpR/ezrNpo6aktKbSROK?=
 =?us-ascii?Q?dJ8LBMo08WBnHQhPAi6InO/wKMDrI4iym9XB86CoMvm0hv1KvcncNqQRAfb/?=
 =?us-ascii?Q?9tnIh++SXGoVyY9U/5UtmmvizvVqZ6CCdZwDX6uI/tXwR4NKHlCZKtZaw72W?=
 =?us-ascii?Q?8JqtmXAEgOoGkt5/+U8jkFHtVXw1EqT3B8NvqmlaTNagAHjc5nZX6YRzQPq8?=
 =?us-ascii?Q?MnopX2sd8bzfXXReHVtCjO+/LWDZ2HeYi7ZC539iAJc7qPctE0f6inFMjJJY?=
 =?us-ascii?Q?P3PU/2gnkFSW2QbZqRSN9TJHJgGDBtDiLU3+r5t3cNaeHEDNB0vjFp9PoRTf?=
 =?us-ascii?Q?WoLPYASv0oTMLBBnUNcRpbUy9UXzHCoPeGwvXGi0F7hzokZ4UlkWjoR0FtRk?=
 =?us-ascii?Q?FTp00BLO8XQmtsQPUSeo0UOPZ/GXXYsn3EDiqc1pC6ocSqH2a7GLWsG7dAU3?=
 =?us-ascii?Q?jE1btosVs0UCPpxKy5s7fCMPmKf/hIVtswthIQvhwqjNjYF0tSY1aRfUFWET?=
 =?us-ascii?Q?vq8aSqI3UCyjd+RV2wS29hXW6Nq8uaInOwDk/naO1WomO8UEIl7fJ0C05+YQ?=
 =?us-ascii?Q?K9QU4X0XiFXam5A/qd0mF/yBb3EANvuEoFiuNEDduywaLgSNmyRIg9mfviAE?=
 =?us-ascii?Q?qQ1BUFgNlau70YTsm28iB+eL9lKGQXEwNw6l0I+BVSkvgaWkbP1iq9Pq8DZt?=
 =?us-ascii?Q?Aozksn2qfTxht9U5r2qaQUB6RpuR4An+TtGsxlbsziCKlo3BqJ3MH+iLpkwy?=
 =?us-ascii?Q?11ItwyiD5amyomX+UTR2Uxs7hAzADH3ltrui7AR9coEOXGOL7PQSsMoInPeE?=
 =?us-ascii?Q?YBeEn8XtblhHnKVEB/Ma1B5+LZiayBpp7diPvyOw3YI3mBKXxMPv6AB1IVaW?=
 =?us-ascii?Q?Er3yd3Zz8VUFt4GGEb6KDJQgjfRK5MWahFaDFvJ0eNAhXB2Ypbn00PsURxDc?=
 =?us-ascii?Q?DiuLg4YBi1MlkQoQ+60U2zpdica2BCjbV0i3azaHJRAZ+pP0dnY1zoDX3E0i?=
 =?us-ascii?Q?VuVG9xdthH1p+15S8yzVcie3odc8ogUYZFdcdzgqWsvBwGLoSfy7ZbiLAbaJ?=
 =?us-ascii?Q?50/vvDr/+61qsRhAIj5Fz5p/iqt25zILkdAbTq9MWqIQE6QONZ/cx9aynW/n?=
 =?us-ascii?Q?Q5X5ND0RV4lSC5ih+GVwSOpO1OI3VzUfx9L9lzL7kKCaZlnbsurY64qD4LKK?=
 =?us-ascii?Q?STo2OLDGtvJTpWDlRUv6abFlgegz9g3wK0/ptZBd7K7YPP5ho7CZwyKnQTL+?=
 =?us-ascii?Q?SvTOKeUP0BNFJJ7NuFIRRM5p7DEb1tNlRPpKFJ1BO2EMO7wEBFJS6ph9kuPi?=
 =?us-ascii?Q?/w6E2uxz6Zr/W5rp+NWdVCE3RQqeDTwVIXfmUbZtwX1W8wGe33xZGO8Zj0vp?=
 =?us-ascii?Q?xo42TVUP20a8AG+lI5uAJGDjncmrEp3UGYrLw/lqbgNevHjoGGxr2cOMG+zE?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fd1bda-d648-4b26-3112-08db7988da02
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 16:41:28.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS1jBw7IPyxaBe2TBvUgL0B9scdeuaXAYZ1qZ/d5HDajFGav1BxnPioDPlOeM5Dm3zs8XUHiA5cYiyffkNanaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the synchronization rules for .ndo_get_stats() as seen in
Documentation/networking/netdevices.rst, acquiring a plain spin_lock()
should not be illegal, but the bridge driver implementation makes it so.

After running these commands, I am being faced with the following
lockdep splat:

$ ip link add link swp0 name macsec0 type macsec encrypt on && ip link set swp0 up
$ ip link add dev br0 type bridge vlan_filtering 1 && ip link set br0 up
$ ip link set macsec0 master br0 && ip link set macsec0 up

  ========================================================
  WARNING: possible irq lock inversion dependency detected
  6.4.0-04295-g31b577b4bd4a #603 Not tainted
  --------------------------------------------------------
  swapper/1/0 just changed the state of lock:
  ffff6bd348724cd8 (&br->lock){+.-.}-{3:3}, at: br_forward_delay_timer_expired+0x34/0x198
  but this lock took another, SOFTIRQ-unsafe lock in the past:
   (&ocelot->stats_lock){+.+.}-{3:3}

  and interrupts could create inverse lock ordering between them.

  other info that might help us debug this:
  Chain exists of:
    &br->lock --> &br->hash_lock --> &ocelot->stats_lock

   Possible interrupt unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&ocelot->stats_lock);
                                 local_irq_disable();
                                 lock(&br->lock);
                                 lock(&br->hash_lock);
    <Interrupt>
      lock(&br->lock);

   *** DEADLOCK ***

(details about the 3 locks skipped)

swp0 is instantiated by drivers/net/dsa/ocelot/felix.c, and this
only matters to the extent that its .ndo_get_stats64() method calls
spin_lock(&ocelot->stats_lock).

Documentation/locking/lockdep-design.rst says:

| A lock is irq-safe means it was ever used in an irq context, while a lock
| is irq-unsafe means it was ever acquired with irq enabled.

(...)

| Furthermore, the following usage based lock dependencies are not allowed
| between any two lock-classes::
|
|    <hardirq-safe>   ->  <hardirq-unsafe>
|    <softirq-safe>   ->  <softirq-unsafe>

Lockdep marks br->hash_lock as softirq-safe, because it is sometimes
taken in softirq context (for example br_fdb_update() which runs in
NET_RX softirq), and when it's not in softirq context it blocks softirqs
by using spin_lock_bh().

Lockdep marks ocelot->stats_lock as softirq-unsafe, because it never
blocks softirqs from running, and it is never taken from softirq
context. So it can always be interrupted by softirqs.

There is a call path through which a function that holds br->hash_lock:
fdb_add_hw_addr() will call a function that acquires ocelot->stats_lock:
ocelot_port_get_stats64(). This can be seen below:

ocelot_port_get_stats64+0x3c/0x1e0
felix_get_stats64+0x20/0x38
dsa_slave_get_stats64+0x3c/0x60
dev_get_stats+0x74/0x2c8
rtnl_fill_stats+0x4c/0x150
rtnl_fill_ifinfo+0x5cc/0x7b8
rtmsg_ifinfo_build_skb+0xe4/0x150
rtmsg_ifinfo+0x5c/0xb0
__dev_notify_flags+0x58/0x200
__dev_set_promiscuity+0xa0/0x1f8
dev_set_promiscuity+0x30/0x70
macsec_dev_change_rx_flags+0x68/0x88
__dev_set_promiscuity+0x1a8/0x1f8
__dev_set_rx_mode+0x74/0xa8
dev_uc_add+0x74/0xa0
fdb_add_hw_addr+0x68/0xd8
fdb_add_local+0xc4/0x110
br_fdb_add_local+0x54/0x88
br_add_if+0x338/0x4a0
br_add_slave+0x20/0x38
do_setlink+0x3a4/0xcb8
rtnl_newlink+0x758/0x9d0
rtnetlink_rcv_msg+0x2f0/0x550
netlink_rcv_skb+0x128/0x148
rtnetlink_rcv+0x24/0x38

the plain English explanation for it is:

The macsec0 bridge port is created without p->flags & BR_PROMISC,
because it is what br_manage_promisc() decides for a VLAN filtering
bridge with a single auto port.

As part of the br_add_if() procedure, br_fdb_add_local() is called for
the MAC address of the device, and this results in a call to
dev_uc_add() for macsec0 while the softirq-safe br->hash_lock is taken.

Because macsec0 does not have IFF_UNICAST_FLT, dev_uc_add() ends up
calling __dev_set_promiscuity() for macsec0, which is propagated by its
implementation, macsec_dev_change_rx_flags(), to the lower device: swp0.
This triggers the call path:

dev_set_promiscuity(swp0)
-> rtmsg_ifinfo()
   -> dev_get_stats()
      -> ocelot_port_get_stats64()

with a calling context that lockdep doesn't like (br->hash_lock held).

Normally we don't see this, because even though many drivers that can be
bridge ports don't support IFF_UNICAST_FLT, we need a driver that

(a) doesn't support IFF_UNICAST_FLT, *and*
(b) it forwards the IFF_PROMISC flag to another driver, and
(c) *that* driver implements ndo_get_stats64() using a softirq-unsafe
    spinlock.

Condition (b) is necessary because the first __dev_set_rx_mode() calls
__dev_set_promiscuity() with "bool notify=false", and thus, the
rtmsg_ifinfo() code path won't be entered.

The same criteria also hold true for DSA switches which don't report
IFF_UNICAST_FLT. When the DSA master uses a spin_lock() in its
ndo_get_stats64() method, the same lockdep splat can be seen.

I think the deadlock possibility is real, even though I didn't reproduce
it, and I'm thinking of the following situation to support that claim:

fdb_add_hw_addr() runs on a CPU A, in a context with softirqs locally
disabled and br->hash_lock held, and may end up attempting to acquire
ocelot->stats_lock.

In parallel, ocelot->stats_lock is currently held by a thread B (say,
ocelot_check_stats_work()), which is interrupted while holding it by a
softirq which attempts to lock br->hash_lock.

Thread B cannot make progress because br->hash_lock is held by A. Whereas
thread A cannot make progress because ocelot->stats_lock is held by B.

When taking the issue at face value, the bridge can avoid that problem
by simply making the ports promiscuous from a code path with a saner
calling context (br->hash_lock not held). A bridge port without
IFF_UNICAST_FLT is going to become promiscuous as soon as we call
dev_uc_add() on it (which we do unconditionally), so why not be
preemptive and make it promiscuous right from the beginning, so as to
not be taken by surprise.

With this, we've broken the links between code that holds br->hash_lock
or br->lock and code that calls into the ndo_change_rx_flags() or
ndo_get_stats64() ops of the bridge port.

Fixes: 2796d0c648c9 ("bridge: Automatically manage port promiscuous mode.")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br_if.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 3f04b40f6056..2450690f98cf 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -166,8 +166,9 @@ void br_manage_promisc(struct net_bridge *br)
 			 * This lets us disable promiscuous mode and write
 			 * this config to hw.
 			 */
-			if (br->auto_cnt == 0 ||
-			    (br->auto_cnt == 1 && br_auto_port(p)))
+			if ((p->dev->priv_flags & IFF_UNICAST_FLT) &&
+			    (br->auto_cnt == 0 ||
+			     (br->auto_cnt == 1 && br_auto_port(p))))
 				br_port_clear_promisc(p);
 			else
 				br_port_set_promisc(p);
-- 
2.34.1

