Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715C574C997
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 03:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGJB17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 21:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGJB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 21:27:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E949CDF;
        Sun,  9 Jul 2023 18:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3DVhSVUbMFPNvVNnzcEKvam1n1m6eYEZOxaxbeWlLCRleRe2AqM2kSIqfGPW7xGB2qjU0wB/do/8tqEGRebpyBcnFVCqd018nlj/dEFn7Ot5+9MZVfPwnGYaHWWb3T7QNuzexCn9uZX8pOpsrUFioRL12OSQlxM8Aaq+l1w50NkGsLj+mNp1xcdHUYxyeMcdk5UujbzH/Ie6+UtjBQ1w1XbReGHJlX66ljYCk6UX4sFyDHEBBBk0e5MuPGbI/aS3q0CdiUKgnH2rqUdp5G5boGN1GOYqeh85ZkQQloA9b3M3I3yHuUtZqr5FVxI54/QayZIGvbnJN4O6enC4L7ZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfdMb1pHiUZBlKdOTCP1tHe3f2t5Qe1VMMFHAk2SFFw=;
 b=eFpsGfiCmICm6UkrSWnw9uJwm+FeWnGKjI8EaJd1eBq1kDzFiN1H+/ujwc7nraOYiEuir9gRtR1wtWFk3s6DpnPjHwKJ/yjFpmWBQWuvyCUUt3xyF5Hg0FsPUItv1RloksUjTCNx4Zsn7pMixkeXOzEqddGUBVJce5VDvKsPMXiZbJ5mGdItjeuNpb0U8+vyUj9T1epwst6dOuBHeOFbwVEx6ENiss7l82v3tJtCC+kqMMcFuNTHGTPZadxB6DLFILutXQ/+9JCdKYVP0Qq2T8Pm5l1Sp1Lw6/B6JpLhqf7LgLmrJcPsbaxpFNmECFcMR0xRuzPLe7K7MFUytYuzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfdMb1pHiUZBlKdOTCP1tHe3f2t5Qe1VMMFHAk2SFFw=;
 b=mi/CNJG3Or4HYGFC2JcKf96/cbSmSR9yrCEqqgxmqN4qUkdVJkufgo3XBG5rRgb8lCv0SsWGmxMMnBz4dtU6WFQa+6eRkP/C+Eq8C2FkuQ40/apoVx7we0MJw4gK7AQn20tsc79PoyiwEdCdlvsDHRa8QnrHEpnJHVc4ED3ZdA5re56nsMESuDTsEVwnfi6w2zUxN8dw1pX+Cw5zj+oeHCFkVwIEcuZNZwtU07IiZSxjx5Njy2IZxuhy5rSysCoqWvmw1Tx81jvdslzSmPx8cqHP+B6yjMxAFONIAJDeFa1L7U+drU6j9YtXI/gaVHsjYwY14v0MsqIoqJbB4MMTDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB6615.apcprd06.prod.outlook.com (2603:1096:101:172::11)
 by TYZPR06MB6619.apcprd06.prod.outlook.com (2603:1096:400:451::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 01:27:50 +0000
Received: from SEYPR06MB6615.apcprd06.prod.outlook.com
 ([fe80::c817:d237:dc0d:576]) by SEYPR06MB6615.apcprd06.prod.outlook.com
 ([fe80::c817:d237:dc0d:576%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 01:27:49 +0000
From:   Yang Rong <yangrong@vivo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com,
        Yang Rong <yangrong@vivo.com>
Subject: [PATCH] virtio_net: Use max() function for better coding conventions
Date:   Mon, 10 Jul 2023 09:20:51 +0800
Message-ID: <20230710012508.2119-1-yangrong@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To SEYPR06MB6615.apcprd06.prod.outlook.com
 (2603:1096:101:172::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6615:EE_|TYZPR06MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: a31e3e66-e27a-40e1-7665-08db80e4dec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tW9JILSYwx+RKZTRIjbCz3hNtOtlvu/0DCtQBKmgLNO1pn27RNrmmh7Ugvhwssvgtcfw/wCLD2jGsKp4MjhbM/KFlluLpWl+gFGu4SalQqmU3hQpQnDeaIShprTYx06uixd1OE0yJwxbISvQ92p3TG3WOo2M6hZJCn/+aPBqNHxD+GnvXpOQcNuC5AY3rOxa0cwu4mfDE3BkERjHqd9C/iKVJgdrACSw0zRSOsYYOcfMs227V3YHnSmCTD59KaNtyWcSW7apnGf7L6QqdknWUjYkRqLXQn8kyhGUOkszYLAKMDBH6nEIY92AytE9S95OLpb+6MRrRa1Wk0ndi02kwMHvIVrsocAPcWq799oH8pMOI6EipH6g7n+yhN74MFCqLXVqOPOPePSS7qTjsEsKuGVU21LtLmhzax8fEVNf6sZsP+54QpmU+aHYuXCmTSBKBibOZ9paDIdZGrZJcDW7UZNIVjSXJU6fkYefxyIEOy0Qi7EUlBY9KAH+/gdUd7XDlLEg1RWA/3wIfdbE/GojbJ1sXp2LYvF55EiYhY2RmxC6m6aL91HuKx7zeyvshG1Mi5CdaRYsZIY7JdXYFvJZJIRHhlsAv57xsHub0CQrJeShTV9Sp0BCTwk9uxh6igRoPgEIdijv12Y544J1aBwN9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6615.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(376002)(396003)(346002)(136003)(451199021)(186003)(26005)(1076003)(6506007)(2616005)(6512007)(107886003)(83380400001)(41300700001)(4744005)(4326008)(66476007)(316002)(2906002)(66556008)(5660300002)(7416002)(8676002)(8936002)(66946007)(478600001)(6486002)(52116002)(6666004)(110136005)(36756003)(921005)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IoZtjfFsQEqfSquzKY6ZFvu25svY++R3zUxFPhskIx2jpPTDqN3KO0UVnqEY?=
 =?us-ascii?Q?+WgwVmuymJG1yoDFJUqCDw23mYpQP71oLRc3P/YqDxGm6NLpUKwjaFJJyswR?=
 =?us-ascii?Q?0D59pA2Nx4nnK8ewM6dh+6Vm9ogjboEObSEc6TXuGZAoijNDbNYP/U+cgbwL?=
 =?us-ascii?Q?qs6WwcGOPJQlWtYf7yoQzHqh4mAljtLoC9V6/u6p3JMgJp2uKekXIUZIYqDT?=
 =?us-ascii?Q?FlzTLptqHD+ZOLeagNLr7GCBjFc7Ax9v6ZIu8f5ckW61H6kmGYYE4RvJY+x2?=
 =?us-ascii?Q?L7jDsloYR98jPHHizQWEIt3UaqW4Sbp88l7o5/5HsriTzONO5t+3lNs0IoEA?=
 =?us-ascii?Q?4i9+ynryLA6Ad3EuyfkUP/EFXKo3YCKSsIdfRfPcAYikYm8Cp9LKnUxFs9md?=
 =?us-ascii?Q?63MQ/o2jzsMipjg7A54B4tmuIiZOontB74QooVv+fImU9aUtKSEd7AMDDAwD?=
 =?us-ascii?Q?YeSvIbKrytl3EXApD69nk4TuZKw/L2ymFrZrVzzpuLuOobfNUyEo8AE0+brE?=
 =?us-ascii?Q?O+/XHflOtlE0wCd8HII3UXgtrLTAjPCYs9iugoFT3SjRiR4YXlSwjcqiw8ZB?=
 =?us-ascii?Q?Enaqb/Pl6rWjc7kdnxTwcqt863WYWSmLVJbdIvhBOXaQudDpPq9J+B+dx5Ba?=
 =?us-ascii?Q?QhHugw6wA0g2bYWpZ3rs3tJBFjRWJBqEQxqj/DpkiNyCyMNXYMBHyRmzcQSQ?=
 =?us-ascii?Q?bK621L1R9On4TXLjb7tCk2unSGAHZ2ir9vfrDqs7BQAeqF3kXrzbwt6eWagQ?=
 =?us-ascii?Q?YGEi486V9n0BuJLC3fWty6bOVcKpSJQx6gRtcVAI7uz/AHbJb8vM1bc0Mp7U?=
 =?us-ascii?Q?FzVtmtf14jkHsxQGJq+Sul9gY6/k7NdEq1wV4niVpqvPXMYPUzRnBiIynlGn?=
 =?us-ascii?Q?kTdWILVx3nrGhb/laNrP2RMK/3zoMJhEQ9+CXHZ0woFbI5DOuddGbdUMYfIT?=
 =?us-ascii?Q?RM9gadGA8/k9dELaG1l2nNX1UMxlqbat6GBYcThkNe31wdRoH7V04meqIrnr?=
 =?us-ascii?Q?GqmY2sLsYkZfhg6HFYZzB6a2+ztyo953kfF7nV1LvvKExfGmQrM+igJk77xi?=
 =?us-ascii?Q?h7k7BVCOOtKa8omnn1+v352o9tSq+f3m/xl2UUbEN1l7Yihs9MZ/wvGuwvS8?=
 =?us-ascii?Q?ip5AR/DBCcQ7q1IgVtCFJztcPy1/CkCJqIeXMRyUU26y4L/Qw/d2LPntOdk0?=
 =?us-ascii?Q?wxaCs/CytvD+BK+EXCuAA/OOQVaQj7pBPdGj4JYffJnhYrU8xkQIpHTiYGOE?=
 =?us-ascii?Q?LYyEbpLpsZZGbUuDyoH2VqoTjfg2HIY5/sSKQw7s/gZWmr8Xrsmeb5WV12Sb?=
 =?us-ascii?Q?e+SvqtZUaQNMD6350vvChtQtkboUDJtEj1ZoYvkag/VbyHaulgClhXMvOrvj?=
 =?us-ascii?Q?4lgbnqV1aobeBMlXza25vpboqyM+nWh6/c2asUO7incHR5WmhTfJWAsRS1R6?=
 =?us-ascii?Q?mAVF8i8P9GtfFmlQ0iUCevja+QA9v7BH+pFrY+Nb5Zdj5Ywn9XvlKcak7ulh?=
 =?us-ascii?Q?f3+TVcx157ZxBbydD6EpYXAAfusaXi+KB19k4z5j7UVrcQzA7WkmyWfONFYK?=
 =?us-ascii?Q?5k9gtZaeClJcCaWyddH2wzLjjVMdeexXjtDmVFCM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31e3e66-e27a-40e1-7665-08db80e4dec5
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6615.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 01:27:48.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vms4cGbwA57JZfk5jnDtEjxw/ms3wNuEkl4SogN+u+QfkbbFa6qNnGDFYl1BfhMP6d/ZBAqUrPLWxBVWodGyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6619
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is advisable to utilize the max() function in the virtio_net.c file, 
as it conforms better to programming conventions.

Signed-off-by: Yang Rong <yangrong@vivo.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 drivers/net/virtio_net.c

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9b3721424e71..5bb7da885f00
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -22,6 +22,7 @@
 #include <net/route.h>
 #include <net/xdp.h>
 #include <net/net_failover.h>
+#include <linux/minmax.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -1291,7 +1292,7 @@ static struct sk_buff *build_skb_from_xdp_buff(struct net_device *dev,
 	__skb_put(skb, data_len);
 
 	metasize = xdp->data - xdp->data_meta;
-	metasize = metasize > 0 ? metasize : 0;
+	metasize = max(metasize, 0);
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 
-- 
2.35.3

