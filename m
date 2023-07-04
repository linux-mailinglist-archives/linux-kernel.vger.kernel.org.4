Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CBB746843
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 06:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGDEHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 00:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGDEHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:07:19 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2046.outbound.protection.outlook.com [40.107.255.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9689CC7;
        Mon,  3 Jul 2023 21:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krAROz2I6/PlXa9Kho0S4qllBiJ29OZ13lOgzlou27nKaSFcViys2NZbIWgPqwxZnvEIXu5cN44sYIwRdLAhZGrbFuo+6+65aKr2NY8FiQ3ycao4wimXjddW6BValBqETBwZLRwnMjT0/KYSsdSj2ok7CWO7YOmQzc6t1xTiJUdnLq4qz+f6TN8Jr6y4HaCSNqxPkLuAhk1Q24RhFU3Msfh9n4gzGRWrW9RPQWFRY4mdY0cbDkPcT6Frxh9usrhAPO2ynz2aRQ5coWOCj5vX5PplkRUQfQtrOMVIfB6JpL70c569zLkGwak7h7UUtE0jh50SIO5cBMNNJcsCOWqACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3kzsNdUuFULS5MjBJUwq/3njUEPkRkeFodN+EVAdv8=;
 b=gujry8A52MjPhmZ63kyJ335QsiiYqBBcdMNFtijj5fK7vaUzMswshxxsfQQ/hW20zgXuHNuSGqYx3CZUYMlioJQ02ankJVLq93JIussRm1Lpkt5ifWnFjJ3mM/YCatg/+5xlkS2c0bpdFFVC55B8K+TAg1aEwYCeSdiydYfoFs4XbfSmJErcXUd2/M7SrxbsShumsemAZ2FEFkQJb2CZ9lxYmySXo/z1bHUYVnoGhWaQzV8MOl7ZzI2ACNQyvXVfkz0cot5z+/nj4wRCdKOxeZwNIcaCC3QVdaNPK+M0O6xwtmz/NhVPIVJ5KZd+sAckz4N7oEWrQLwYengXdL6e2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3kzsNdUuFULS5MjBJUwq/3njUEPkRkeFodN+EVAdv8=;
 b=kf3Dh3MuRJ8RVoee6oGY8CmvwyOld287B1kYq1Ufre3mkb4cI1b5TLVWPRozpJWjKFwyLVOOiZm6NmRMZ1Eij/umqCZ6PHEHUc27SL4KKgFJgfOawHdjfQEfeVQoTwhg8cnvW1h6/lRs+PZm6UnCdBdaqiMQ1sFahUTHrHXbNAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by KL1PR02MB5234.apcprd02.prod.outlook.com (2603:1096:820:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 04:07:14 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::2e7:47a3:69c4:9e8e]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::2e7:47a3:69c4:9e8e%3]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 04:07:13 +0000
From:   lipeifeng@oppo.com
To:     lipeifeng@oppo.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshiming@oppo.com, guojian@oppo.com
Subject: [PATCH] block: mq-deadline: rename sort_list to sort_rb
Date:   Tue,  4 Jul 2023 12:06:26 +0800
Message-Id: <20230704040626.24899-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0233.apcprd06.prod.outlook.com
 (2603:1096:4:ac::17) To TY0PR02MB5600.apcprd02.prod.outlook.com
 (2603:1096:400:1b8::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|KL1PR02MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1cc1ce-5c0e-4f05-634d-08db7c442567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeDu2Az4gcoRQsAlN7DSvNtFOktHCQdMjgKKesR75V0ZbVlNIfIQT4hUvSb/M8XZZc5rm6FRC8+Hf8D5i9qgzVyhAzuzFITCAaB5bF4cJBvLZ/DX7q0F3CThWi9MWOIiDKZ4HBVqxuMaZzgt6CHBWps27BUxksOnDTYRvrpn+4G6VVGkAi/mQcVGJQEHJY860zPnbVt/cMbonfX3rJd7EIdalsktC4O6Af9mseevKcIsarlqvPC0c/ERCBGnXBZC8Nc5Y5y8vzoOn3NaZ85bOfFb9kxz22hpWTWZREwc24SSTmQm12I6Ozr2p5WpquRTXv1X0XeGqK5piVYD/yaYsexbpxjr+eVp1urZQr4MjERIm56qFJDN7XdZeRI+vIt0PYtt7m1Q4MnyaSI79geLdECQDG/BU08xrbCxNkGDROJEC3DBq+fl5pIUE0JiYy26CVj76+7BoL6qxQXiaYm1XyFQLV15mrl5rpCBW3P68Xh+2XaRMVX77xGRsx2N+tvOJyAJp2GeMEQlbP90mCk9mbJDoqGXqsEJ9rCz1cnoZ3tkxg6k/iyHAg34Rg1sntXLGioodH7gqv8vhJH/5NFOMAfpU4j16U9m8KyA5Tckrpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(2906002)(9686003)(478600001)(26005)(41300700001)(6666004)(86362001)(6486002)(52116002)(8676002)(8936002)(5660300002)(36756003)(316002)(66476007)(38350700002)(66556008)(66946007)(4326008)(38100700002)(1076003)(6512007)(6506007)(2616005)(186003)(83380400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nfkPDIVu/akiRPM5g9dO4eiSRde15hKzTLmvNLXK2HUlMHxbhQCkg3n8sJrv?=
 =?us-ascii?Q?rtO73yWuHyLt5GcCDBUfvGZhdpxjW3WXnu1JyOnHs/9K/4rc6N9oUDYG9MzD?=
 =?us-ascii?Q?OYXuvLZXyYzgOM+WlgUK532WPnhG7YVW6nfpRndW+6FZ02y+su14UAlkVM2Q?=
 =?us-ascii?Q?Hu8Do6xdtWMr5ISQZg6QhGLMk+YEBNaG+Ug0g+n52HqD/3G++UzKZsF2mvEW?=
 =?us-ascii?Q?2aVlSv6Kgn/mBg7BtI5f382P7kdHWjpErVtpmfQg+9Pp7dXsUftpB91M5DS+?=
 =?us-ascii?Q?YHowm7wip6w+cR3ZNvTy3h0WeftyyYPWCBITMXNeEURhTbBGqiGnnzoUjFvm?=
 =?us-ascii?Q?q+LrTDRd/9OMn60Jrrb8lAVbGuZuZyOGugxcLQcRTPXWfovZxZE1pHO0ViBr?=
 =?us-ascii?Q?zHF5QtB4KVzQZAWcRFJqoJqSvnxt2pOIOqfHJFf2vEJ2GsQWJK8Zi2zLR5q/?=
 =?us-ascii?Q?zGt/gVH0eN8xJzPp63hGJBVYvRfWQ4ca/wsAU8c9wfUcCHBBX3/ftx6etwZ8?=
 =?us-ascii?Q?yeoV7YoJvKHFGt93kkqmeJR0rt61Bljpq4ZP6DgtI6FOcXOx03Nh8acx+kSv?=
 =?us-ascii?Q?q0METlTiaS5CCYt6ah5wqRKbctjjzC8DyrU5vVxB62sccAEGaxUp/+EMWd1H?=
 =?us-ascii?Q?p/RyMMBu3afWCKs2kEVPOTgAkiCFXfgQCHCzVx9+rrurlRxsp3rL1pmJ71OE?=
 =?us-ascii?Q?dbWbTxmDYRodyKp01FH1VbhBpCqRwSzhbfMKbwCJ0Ujd0lYAT9POKCAYnmgO?=
 =?us-ascii?Q?Wd5D8rrUdgn8yD6xBIgqvccLOKExlewMOYkbKToreM5saz0UAvIet52vWrfy?=
 =?us-ascii?Q?l5fICZlUsFg2yPRtUgs3l6tE9Nh8O+RqNTwIxLFlc9BzH/6DDTZXn89WdzBE?=
 =?us-ascii?Q?BoEhuhYPj/mwvKa8AOKHeVUitaUl3phvg4rM31VGrWL1ESZz+edisGYPZkmz?=
 =?us-ascii?Q?W/Ka+6R5po7j0+Prk2+2YdPNiB/GPX3gg0LSA9mmZuC3idWJHeZpPo0cm+lq?=
 =?us-ascii?Q?VH9O27gTP/+3VAq8RvloM3+Uk/CfQOoRm6LKThgdx/Tj6CI+fTpYPJsdX3DF?=
 =?us-ascii?Q?t5pE5445izOIGscgM7/rbJFLgyY1s4jxTH5h6oCNoYKIYjkkjtqc0L7cQapc?=
 =?us-ascii?Q?FpZM3fSRDI3vFOly+sQhy9mYI7Abu53lzpfmYBcjUiJpufN+UDvHrEvNopXI?=
 =?us-ascii?Q?6k9yaLoCoqoaF6bj5wFrNpFsJoNuUPTH39gSn1Efv46iO7Nsvo1qMExuK08T?=
 =?us-ascii?Q?+MmnHT8NRkTAId9/QhuPoKRCuwPq05Eq5AqpgfQZzeM72XTlr05e3UriXvK7?=
 =?us-ascii?Q?rWee2oHjc9RneEt4TnvxqgM+X6ZZcOPZRKPFHGPp6BI9b7Nc45uw82f7rCtg?=
 =?us-ascii?Q?zs7zXUXlPhLRYd7h7+uegomZ0aPA6SAz9+O1+rL1+aNBcg1nvsuY1DYcIEO9?=
 =?us-ascii?Q?6zbYleQ4awIbH8SO9xDEYYDUYcJLM8GDp8lTPKzJJuaVpjFrEz8W6HUHXu5u?=
 =?us-ascii?Q?v1jmBL0h1Twa40xbWc14/5xfHNzdRZOYwvgwfXZEnTndF5y+0lLrJz7rJEAf?=
 =?us-ascii?Q?5ZANK+VP8HVvnXCQLOwOz/zKe0yfZKs1a/FkUN49?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1cc1ce-5c0e-4f05-634d-08db7c442567
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5600.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 04:07:13.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBnqxpOy4WVXh7JzMdVNFBn3JZwYvZdUptg0a2Do6uBlY/I+BIZmxcBYOcW3Ax9S865ss45MPw6TCVcXOaF2jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB5234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lipeifeng <lipeifeng@oppo.com>

Mq-deadline would store request in list:fifo_list and
rb_tree:sort_list, and sort_list should be renamed to
sort_rb which is beneficial for understanding.

Signed-off-by: lipeifeng <lipeifeng@oppo.com>
---
 block/mq-deadline.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6aa5daf7ae32..b3757b7a6780 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -68,11 +68,11 @@ struct io_stats_per_prio {
 
 /*
  * Deadline scheduler data per I/O priority (enum dd_prio). Requests are
- * present on both sort_list[] and fifo_list[].
+ * present on both sort_rb[] and fifo_list[].
  */
 struct dd_per_prio {
 	struct list_head dispatch;
-	struct rb_root sort_list[DD_DIR_COUNT];
+	struct rb_root sort_rb[DD_DIR_COUNT];
 	struct list_head fifo_list[DD_DIR_COUNT];
 	/* Position of the most recently dispatched request. */
 	sector_t latest_pos[DD_DIR_COUNT];
@@ -116,7 +116,7 @@ static const enum dd_prio ioprio_class_to_prio[] = {
 static inline struct rb_root *
 deadline_rb_root(struct dd_per_prio *per_prio, struct request *rq)
 {
-	return &per_prio->sort_list[rq_data_dir(rq)];
+	return &per_prio->sort_rb[rq_data_dir(rq)];
 }
 
 /*
@@ -163,7 +163,7 @@ deadline_latter_request(struct request *rq)
 static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 				enum dd_data_dir data_dir, sector_t pos)
 {
-	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
+	struct rb_node *node = per_prio->sort_rb[data_dir].rb_node;
 	struct request *rq, *res = NULL;
 
 	if (!node)
@@ -477,7 +477,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	 */
 
 	if (!list_empty(&per_prio->fifo_list[DD_READ])) {
-		BUG_ON(RB_EMPTY_ROOT(&per_prio->sort_list[DD_READ]));
+		BUG_ON(RB_EMPTY_ROOT(&per_prio->sort_rb[DD_READ]));
 
 		if (deadline_fifo_request(dd, per_prio, DD_WRITE) &&
 		    (dd->starved++ >= dd->writes_starved))
@@ -494,7 +494,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 
 	if (!list_empty(&per_prio->fifo_list[DD_WRITE])) {
 dispatch_writes:
-		BUG_ON(RB_EMPTY_ROOT(&per_prio->sort_list[DD_WRITE]));
+		BUG_ON(RB_EMPTY_ROOT(&per_prio->sort_rb[DD_WRITE]));
 
 		dd->starved = 0;
 
@@ -711,8 +711,8 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 		INIT_LIST_HEAD(&per_prio->dispatch);
 		INIT_LIST_HEAD(&per_prio->fifo_list[DD_READ]);
 		INIT_LIST_HEAD(&per_prio->fifo_list[DD_WRITE]);
-		per_prio->sort_list[DD_READ] = RB_ROOT;
-		per_prio->sort_list[DD_WRITE] = RB_ROOT;
+		per_prio->sort_rb[DD_READ] = RB_ROOT;
+		per_prio->sort_rb[DD_WRITE] = RB_ROOT;
 	}
 	dd->fifo_expire[DD_READ] = read_expire;
 	dd->fifo_expire[DD_WRITE] = write_expire;
@@ -752,7 +752,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 	if (!dd->front_merges)
 		return ELEVATOR_NO_MERGE;
 
-	__rq = elv_rb_find(&per_prio->sort_list[bio_data_dir(bio)], sector);
+	__rq = elv_rb_find(&per_prio->sort_rb[bio_data_dir(bio)], sector);
 	if (__rq) {
 		BUG_ON(sector != blk_rq_pos(__rq));
 
-- 
2.34.1

