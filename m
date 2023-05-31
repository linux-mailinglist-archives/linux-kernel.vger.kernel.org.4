Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855A871889F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjEaRkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjEaRjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:39:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BD2F2;
        Wed, 31 May 2023 10:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9z88lKlYHBs/GhaM6ZGU1+q11tBXbguT3xiGiVtjchpbOdAVDx6NDXh8xibV2lkpIEcECFJf0EMUP9Wv2vBM3mljBwzupXikVa5ShAiftLttBSH8cA1sf+85ryZcIE2ZUTrpZVfdeYp2CvHsVdaxzDwS+bz7L7JNiAM/V1f7niZ/W5Uz082k2hRGo40wRrMNX6D3oHVMUniOahhthUblNJ8cOYM+mzDqTSlLXkWJAib1/QJv+6hzsON8uXhMD9YcBHmzYGgR2R6y291KSv2n9qg0u2zmW1T23QQM2QEW/Q2SmFaMvQFOyRMBz/uRtJCoMljUaVg3rPdOwtJCkKbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXbdk2K45vsjE10Ud3k19fgs/8bgShOPBxRnB3axMrA=;
 b=C+tAbvGM3/DvNqAA7I9GyI0Cr1QDm7wTjBki9VwkvckagnCRo6St2bcy84GK3jb/OEQwCJAaTl+7G++sYA9YmCaF13SyFQRuC1iNbc9iZwBeMnWHRrCT656vZUPZN+fWurvzJ3tki2qeLgK6uvJ32Khd9GDn5j8EocQwb5M9KnNfI/IfmBtOkz0x+ySoqXTV9Fp9pIdb4We21xowDUmREzI1lg6bDtsqLibJPDq2A7Jpnn2Tz2Xq9iVFpMg6p7+iVLjXn23B7lnglgFrGZdBZChpV5R0FLqZb+IOpaf7mKnxB25pr5fuPSPzy9czY/S1DZTnJkdGKa+f3im0hWqOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXbdk2K45vsjE10Ud3k19fgs/8bgShOPBxRnB3axMrA=;
 b=nHuOEl/PJWt0K2/10JyhHoaZz6DMw8RUBGNnpvdfZ1WEeKiD3skXfc9Y0OZZpax54Y68x+RE8Qv6akdYN5FdOujOKXQ5fU9GKxzi4HGAlibk8pu+AqEBKQvIJJ2NkwH+P4o/VGVsSE6sNehHhNAMgWNsmb8ldB+A0CkaCzRN3jU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 17:39:47 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::47e4:eb1:e83c:fa4a]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::47e4:eb1:e83c:fa4a%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 17:39:47 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 5/5] net/sched: taprio: dump class stats for the actual q->qdiscs[]
Date:   Wed, 31 May 2023 20:39:28 +0300
Message-Id: <20230531173928.1942027-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531173928.1942027-1-vladimir.oltean@nxp.com>
References: <20230531173928.1942027-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0104.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::30) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 5736c57b-a037-41a0-7983-08db61fe0735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 483xk2p9slvyJ6DLZ9jWL+BHN9wBSSppKQvss3Hn+18ICe4mbl2cCy2sYscNY5dRFaIn5NE7TJrOyR+DhZuJIA2nrQwTruBGlgGzQd2fCXPpg1oWqGeUlwkOhmBfKFpA222InnLIxGndXfwliigWba0IC4+uxNb/NqeoBqFLnPAiEdWkD788QMogCsPNDCrXQ04jgiUWBFP7T9mUolW8eYjPjUjXgkdrbo6KsaK9emKta0IZ0LBq3lf2hQlduEpnIBpj2uCU/wbzj9UuSS+G+kcvQozXOWXZcR300X8OThuVEuc3INGZFqU6Pcw9UbVOyD85Zp3mBDn7GkwzaYlbEK1eI14de04ZFtcGL1mqCjl6lUzcN85KrDP66okSMfeVXTqTdyHC2OL77QuMbvrBgsUJT6zCKE2+Fmn76Pigh+URImkNlaOJlNqJ3xLWghHbODrjp3aE2616mhgsntdDZJk54/HwaVeSpl2Cda6+baviS4HtLox8cMy29DkQ2VIorJr0KgsqP6GxWzvwsMsn2aSP19ToX1mBGxLOWFSfpe7G/hyqTgvAxur704DxfyUqufNrRNiwA0TMi7/tZA14W7A7FuMUOVYQ0mvenWXsAsax/DPnyeCyF9sJU088FH2p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(2616005)(83380400001)(2906002)(186003)(6666004)(6916009)(4326008)(6486002)(66556008)(52116002)(66946007)(316002)(66476007)(54906003)(478600001)(26005)(7416002)(6512007)(5660300002)(1076003)(6506007)(44832011)(8936002)(8676002)(41300700001)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2is0X1YsdOpldAR79p1DGt76Iyhrh//wm9XVR456YsLf4MuLdTmsyxMYxLk7?=
 =?us-ascii?Q?nh8ERThGax4pFOrlhvtRdqc9gJGn1FcNBalvw5f8mobgadKYqs76ypV91yZl?=
 =?us-ascii?Q?ddpgQh1UgEkWpav2VceosnNN8eIjAsT4XOnbfsS19viDKgXcEt44B0otUNsA?=
 =?us-ascii?Q?XbXxWvwRPHS9zkpRHAnCsTeQyxV5XWNfKoeAOBp0rTDNVQQ8dE589stB9R3C?=
 =?us-ascii?Q?5lJNhX0mVvy/ZMIAePJQeQupmDnXyNaZvKB6kKsXtTiu/BEGv1GwvHhLkodi?=
 =?us-ascii?Q?jDTjmaBCdPFG9tV4Dl1uIxV/bCmJRbkb2E/LS0Nwr+MoyTyHm4F5MRN520yb?=
 =?us-ascii?Q?PyCWW1WbHOeQFQBi4J0MHZ3dindYO/iyfZVorq4HR75KIDLe6Mm7o0GPAmlE?=
 =?us-ascii?Q?0hSriRbyvPPOu3OxFcGkvPflSmyjrtyvTm4/r7JUgZJtjVhqk41Y7f8V9Oar?=
 =?us-ascii?Q?GtgnOrgxCeE0l7k7ELfWUQVfqqnM3n3Ax3D6zY4PYY+DOHvJDWwSYl9NUtIN?=
 =?us-ascii?Q?CiSEC43zVEw1SBuguBRN0hRX6a7T/AZsBB2LD3QPosUceNVy1/pqh4LhcxJW?=
 =?us-ascii?Q?Hn56yxjpbLEJQI/uBsshS86UxVMuROzWWjZNWTylDSLTcwI2jm8FKsfPMEBK?=
 =?us-ascii?Q?yGZU/bAK0i6VbKaxly+ytbV6OANJ2F6xDUinndjT78aeal6ctBQQvPPHGPiQ?=
 =?us-ascii?Q?qo/TnOXrNuqMK5lBwwVaOwtr+9nstnLVc4h5Cl6EMyXrUTONOvvRXc5Ev5A3?=
 =?us-ascii?Q?KrSV7ckSvt2GvATtMJxBA7RN4yi/Mlp4s7UzHxW6KdjFBsIJAdAMcBS7tgjl?=
 =?us-ascii?Q?W4jHEQazCb3b+aoNn/2+yq0cJgG0Kv0e9JtV7fVNFre+XQSD8LC/klglRDM3?=
 =?us-ascii?Q?xOJf4sWDOiLI/9swgJFipTcS5YrTkDPevJjSlhqNIE9YfEoNMbKaI0SljaOS?=
 =?us-ascii?Q?BK3O2RWX+opDb3X+IEijfG5iW7CSITDyxFhP/SI5usFImd1oqR9GDp8ii8nE?=
 =?us-ascii?Q?IeUOYnWgCwktLToK95S/+jyv6L9jfhtnRwO2QJW4+uU1QuDw1vqTp9F+OUbK?=
 =?us-ascii?Q?qdwRZpAxI3/MYsb6VwQCwLSwiwvgY+0vyaker3z4NMKsZHZ5DIsJwwemwoK8?=
 =?us-ascii?Q?K/gGEBex0gIp4vzWidQzXwgiZuWy5bhAP8+m56ZtULso6s3GsHAtx/ZI6tC6?=
 =?us-ascii?Q?DA79VEtfYlL95KTBQgj72MRMkn595bP/ik6I1g4ZEgqalg3RkIew/FODGMXD?=
 =?us-ascii?Q?8/pJ61Xt/BeHHyvZwEYNysbEXDm7ZqHHa/c+rVOu0HRRzYkokfhYTjHWxW0e?=
 =?us-ascii?Q?FXm/MvLMFIO+boHXvc8D7/hpBghP0ubYtcjbenNg+KJXxI5MDdp9Ug71zWBa?=
 =?us-ascii?Q?iyAphCSSCr1f+3xWueshnvtkC3LNmPPTNbCjHEQDQ6jagXjFQBB3NLLCnhwv?=
 =?us-ascii?Q?QpWqje0mf7Dt5GLZzKyMgkWedGvME0P9VoLetEmTv0x03m6/YADO+zXoTtT6?=
 =?us-ascii?Q?TSdrzU24MLFc+uGp5pm/4cDmgvXfFWE6QGRBpZWJwJI1rGH9lceKfpfWy+27?=
 =?us-ascii?Q?i7ojjclSsoXqQBM8mIjxFpefzK9Kvr5A2j/DFG1+oDlGVyXaBh+iaAiaeikt?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5736c57b-a037-41a0-7983-08db61fe0735
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 17:39:47.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gV86eZZznbF2a5abegSr6GcXWiMCyyD/lhDditCaSgFd0fYDhu4Nvv7f29M9eb9CM9cfJ0a8Q12y1ndvvK1Ktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes a difference for the software scheduling mode, where
dev_queue->qdisc_sleeping is the same as the taprio root Qdisc itself,
but when we're talking about what Qdisc and stats get reported for a
traffic class, the root taprio isn't what comes to mind, but q->qdiscs[]
is.

To understand the difference, I've attempted to send 100 packets in
software mode through traffic class 0 (they are in the Qdisc's backlog),
and recorded the stats before and after the change.

Here is before:

$ tc -s class show dev eth0
class taprio 8001:1 root leaf 8001:
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 9400b 100p requeues 0
 Window drops: 0
class taprio 8001:2 root leaf 8001:
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 9400b 100p requeues 0
 Window drops: 0
class taprio 8001:3 root leaf 8001:
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 9400b 100p requeues 0
 Window drops: 0
class taprio 8001:4 root leaf 8001:
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 9400b 100p requeues 0
 Window drops: 0
class taprio 8001:5 root leaf 8001:
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 9400b 100p requeues 0
 Window drops: 0
class taprio 8001:6 root leaf 8001:
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 9400b 100p requeues 0
 Window drops: 0
class taprio 8001:7 root leaf 8001:
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 9400b 100p requeues 0
 Window drops: 0
class taprio 8001:8 root leaf 8001:
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 9400b 100p requeues 0
 Window drops: 0

and here is after:

class taprio 8001:1 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 9400b 100p requeues 0
 Window drops: 0
class taprio 8001:2 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Window drops: 0
class taprio 8001:3 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Window drops: 0
class taprio 8001:4 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Window drops: 0
class taprio 8001:5 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Window drops: 0
class taprio 8001:6 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Window drops: 0
class taprio 8001:7 root leaf 8010:
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Window drops: 0
class taprio 8001:8 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Window drops: 0

The most glaring (and expected) difference is that before, all class
stats reported the global stats, whereas now, they really report just
the counters for that traffic class.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/sched/sch_taprio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index cc7ff98e5e86..23b98c3af8b2 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2452,11 +2452,11 @@ static unsigned long taprio_find(struct Qdisc *sch, u32 classid)
 static int taprio_dump_class(struct Qdisc *sch, unsigned long cl,
 			     struct sk_buff *skb, struct tcmsg *tcm)
 {
-	struct netdev_queue *dev_queue = taprio_queue_get(sch, cl);
+	struct Qdisc *child = taprio_leaf(sch, cl);
 
 	tcm->tcm_parent = TC_H_ROOT;
 	tcm->tcm_handle |= TC_H_MIN(cl);
-	tcm->tcm_info = dev_queue->qdisc_sleeping->handle;
+	tcm->tcm_info = child->handle;
 
 	return 0;
 }
@@ -2466,8 +2466,7 @@ static int taprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	__releases(d->lock)
 	__acquires(d->lock)
 {
-	struct netdev_queue *dev_queue = taprio_queue_get(sch, cl);
-	struct Qdisc *child = dev_queue->qdisc_sleeping;
+	struct Qdisc *child = taprio_leaf(sch, cl);
 	struct tc_taprio_qopt_offload offload = {
 		.cmd = TAPRIO_CMD_TC_STATS,
 		.tc_stats = {
-- 
2.34.1

