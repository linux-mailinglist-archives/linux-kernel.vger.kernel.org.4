Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66E6718898
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEaRj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjEaRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:39:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAA4126;
        Wed, 31 May 2023 10:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4sp4uf6fvXxKKhZa9I1f1NssXn3h2tBO4TxuraPb6tTVn6k03gvwWwh58P5xIPnI/WB4COTPJKo9WktFgDnlcezfNNpLspAXboRWkIp4VFEouPnxb6jCW1szEvOTkI9YTj04ertGFggvNX5Do1DXLInefWEeNp2atlekp1gQtinCbccgKMCLDWsaHl/YeWJERWSDG4NC08F8exrEickshi2AKOo7xjVGNkUTqQPY0OhszDxz9py3ErZFpe+C7DhMK8bRoeqgFYoZmdqHgAQ9WjeG9xgu9a9ygtqkFcLrg9be+rcoIcwiItERnYijaqMFEeG/YFWmD63XnomXjCKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+NnOWzbxJHD6HQCG3aosuF8S27pqBRZN6+CHoAK7RI=;
 b=JU3ROboTG4uwcWzx/YtMuJFMlzWpG5Tti4CanO6PXcQ7QYSxx9yDs0xhe9E8vXsOLp3sGnqfw3IoCXfgJStvP5IJIWuAc5vPXBIRlz6FsKLB6KFYIpzL6H52o4/ZGTn/O+F6syY+Ey9kVhocF81kEdZqxIqCDNUzq+iK0Sli2QA9R62RHqY5al8506X0hsnCMugsVRhCyEghKn49MnnTjQ6StmH27GyP+ZamEPjQbN0oqZ5G3ssbUBnQelkkkYda5xfylUP/ukZxLIXf/dl8NOnW2BrDQsCdQ0JXwZ190sqc9TmiihuVrYytJAYJmM+NSsvLp+y8U4EXz4FtJtoHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+NnOWzbxJHD6HQCG3aosuF8S27pqBRZN6+CHoAK7RI=;
 b=FUbEG/ZZRPbHyKa/z8SEDOdcQPCZt0DyKUhIiMpVPh4HnilkmIFSUN/OD3TQk9KwZgCpXYgxzF3wIuo8uKBb4AQ3bmA3m/emDFi1958aXEF8yV3WkuIeEyF2IU1lrdsTXciveAMWJJoThaeAEYbXYi8hJK2io5MvUZ7ej7KEtSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 17:39:46 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::47e4:eb1:e83c:fa4a]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::47e4:eb1:e83c:fa4a%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 17:39:46 +0000
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
Subject: [PATCH net-next 4/5] net/sched: taprio: delete misleading comment about preallocating child qdiscs
Date:   Wed, 31 May 2023 20:39:27 +0300
Message-Id: <20230531173928.1942027-5-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 05455462-aad9-4000-8207-08db61fe069a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRf5uDQ0nmZtL6I2Vk+T8ghx0TZh5KU4F/2OW52FKQqN2GOM29DilC/tXFVe+gyCYGuFvMcOO7dykltnnSHkHFoiA+1ql43e1PFA/uOoh3srn+kdYTX2JJlhtK6H/qxPrfs0zrmST+IRxM8+fzub9FeSHHe2y92pTsUXMQD00asz9F7sFcV2RBvSAwk0NbR2/rb83eZG7Q/3DnRrCiVKMLJhA9rvqLT/mEqm7VavMABquHw9s22MLEzepQqKWffPPAAYPCKf8OGvhMBd/+KUF77ET/fnRBg7SZyAP+PigbzT1MzDc5Ji40d/+pXOOQX6OeFQ8IntRgGsokASxC3G73YTqvaIFWzmdeGRpAlH6XswQPLfKy6zFeCxH5lZLvi4Bp6M6wFP43AtwBNXA8q5REUogkQW4cmVdu1Aff1YGJ5TqUkdnEd3lCejwzmwKqGniUbbPROf/ywFAzTSqEv2+gXQ9bd8LSyxhPOYJlzCakWoy7earPdK3E5p0blhiqOfyzShWerg1cqgoYlEQRBs/B5kopGkQ56cZSKSe/j1LWiU/dbecQJJh/tqgSgzndPlqcRFZucPfTu/yTBxGwFOWCZgU6FnpB/gmX6F2GB6BU+/OBA2ZlD4m9AkpcdWnK6Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(2616005)(83380400001)(2906002)(186003)(6666004)(6916009)(4326008)(6486002)(66556008)(52116002)(66946007)(316002)(66476007)(54906003)(478600001)(26005)(7416002)(6512007)(5660300002)(1076003)(6506007)(44832011)(8936002)(8676002)(41300700001)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hqt6eno75ZWlYicS9HZlNgCVWeT/5E/bsAS9jvmfUDJqEteGl+SwOV1gb8a5?=
 =?us-ascii?Q?uVrY7vNIUqGPDHsx4OCppoEXPH4aNNhK//Ox13OMJw1nSRtihnANjZe5zR1z?=
 =?us-ascii?Q?gOwNdTmF0wDYzKkEHoKXdRdIZNGH80ILHgKLNdewkFUpmaDNtDEX4rDZP01h?=
 =?us-ascii?Q?aC2tYmHRFknjrWlhziV4GuRnmj0AF//UZZQ5MB8IpY+rmaKIpra4iNCIA6Nb?=
 =?us-ascii?Q?aWqmmGnVwdHYq8ABg1q9B/10gThy3Fa6ktmzfknUw8/EEf/R1oG068ZR/3OR?=
 =?us-ascii?Q?JItngzQiqcxAQiU8LLTYsl4EEKOBUXpQxhTC9sRyTCdE3ZNYh1LGdIWph/kC?=
 =?us-ascii?Q?yAZhxF+D8ku5OP3qkRAYxRTXqaXVjnEutCVKs6phODY9NFMmSpxStiU7tg1f?=
 =?us-ascii?Q?0tNxvZf5xXNWoR+nIy0GHGDwdtXU5y+GfFqX1lAtsX3X+fx6+AZ5gADC4GjD?=
 =?us-ascii?Q?S9hrMrsXsOInoDbZ0eVohshVu7o5Z5iekx4ox7HYk0HQuyBK/AAGB3y84d4s?=
 =?us-ascii?Q?yu5kpOaBHUcIstNrb3CY50iF0pZeRRtI0mNczQT1OfLwOxqChKcXwDdBknbH?=
 =?us-ascii?Q?ld2NLZ02IlD9VnGGXy+5oNP1JpTPBaL3TfdqhNX8V4kYwT1YiBC9UnbxUuTH?=
 =?us-ascii?Q?HqD0wM5wIHfHpZ8b7k92Iix+eipXPZQoXcQCduzYnzRRJUfk3dFt0N2n5yll?=
 =?us-ascii?Q?W3Ldi6rSK6iqR17ofMqCrurFXi5QlVvin2sPfsb6n3872EIpRiMDXkNWsG0s?=
 =?us-ascii?Q?oIxM3WbYBe8etETZY/1jg/se3/EPvZTlkys7auLjWUyqPYhJrv65EgsaDEG0?=
 =?us-ascii?Q?Q0B9mV3tMl9L2PBfAy4pd1GjbHRgA9hLbpsITsmdTw5rkTNeRZqvVxO/AUX7?=
 =?us-ascii?Q?HxrEQCpEV8dYLxGDITbEEB8vO5rQGAj0Gl6r218IKmUbC/0JBHSoyPxg901o?=
 =?us-ascii?Q?luQ4LED2lxV7TFOdw2J39EMsdbfigmgMd6DwVxqmyBGf07kxbTEy12peSW2F?=
 =?us-ascii?Q?+5eB+yBPJC/0js5aWTyBMuiEjnzxfJU12qodrMn0hvQHUNL5ddM1lWLgMHqZ?=
 =?us-ascii?Q?4reOf89ZfiQelWI+6ifyQpID2yk1F3hcyDVCMDx1yrtBxfBNyE3W9gx7rrgs?=
 =?us-ascii?Q?DDgJtGNIZzT1CxA1H0SUCYrzKit4pVAcD9g+9wDQOfT/M/AIjay/yatpniXg?=
 =?us-ascii?Q?GNW8DNaGAPm26BaxfsRCEoINkVj0qLMk6+X4//RYA6f3bQG71Tkann81HQmM?=
 =?us-ascii?Q?vbooRjk6xz6vAfrs4Z6o1uJzF+JtLeRa7YCB8KG+tAWXKNsyqBBNpSeGp5sW?=
 =?us-ascii?Q?amrJZ2V4lDi4cX7ICacD+C21HUtjT0pEUYMD+/AeIZIDj5ZZ6MtIC/tiPWxI?=
 =?us-ascii?Q?cEtAHNUkxgKIiWyFL+CUYJOOBUuq96md3lt6WbvO2nXRzDkXczSxk1F0urZC?=
 =?us-ascii?Q?ws2bX+g9gUfH1cKFuK5NXgeOQeHz+hIhvLCdARpYoQDdGeCtCV/CE11xA0sZ?=
 =?us-ascii?Q?xPcifEOQ/Yz3R/P1JQDS9BVnQdWqLsv8Ic4zdUJMyWsR6i/tRLZD6YbssxRc?=
 =?us-ascii?Q?v/TZAWSrNNZoclBytm0PhKCJsKpJkglX0r1V3uKlkCJQWz+HoihVo8GRVBK+?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05455462-aad9-4000-8207-08db61fe069a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 17:39:46.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDNGHYNOfCMaoYeB+uFutYfsq6tsAb+QHhlXQDYfnfz4X36UmNoQ0BLSrXAeXLzEk+U3At9WC0ec2E3xAdLECA==
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

As mentioned in commit af7b29b1deaa ("Revert "net/sched: taprio: make
qdisc_leaf() see the per-netdev-queue pfifo child qdiscs"") - unlike
mqprio, taprio doesn't use q->qdiscs[] only as a temporary transport
between Qdisc_ops :: init() and Qdisc_ops :: attach().

Delete the comment, which is just stolen from mqprio, but there, the
usage patterns are a lot different, and this is nothing but confusing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/sched/sch_taprio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 263306fe38d8..cc7ff98e5e86 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2084,11 +2084,8 @@ static int taprio_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EOPNOTSUPP;
 	}
 
-	/* pre-allocate qdisc, attachment can't fail */
-	q->qdiscs = kcalloc(dev->num_tx_queues,
-			    sizeof(q->qdiscs[0]),
+	q->qdiscs = kcalloc(dev->num_tx_queues, sizeof(q->qdiscs[0]),
 			    GFP_KERNEL);
-
 	if (!q->qdiscs)
 		return -ENOMEM;
 
-- 
2.34.1

