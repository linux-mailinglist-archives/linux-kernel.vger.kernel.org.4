Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B20749881
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjGFJbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjGFJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:31:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2CB1FC4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 02:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekHMFuCg7XyHH91/m2SetwbuXzPxoC+mTisEJARbZqu81c2T5JRgxSuXrzdz+BgreC1Zn2p3/8T4mKSzCEKIENQHt4ZNaMG94K9fAwzn16N2nSgUXMliKZeBsvim5JfPUcHpVTT80kcWX7+VK3I00+qoClTt5asjAmXlGbUNshnCOKMmdzcYBmg08MOg6XzCmBoh8UqvKJ5tyGm71s1m9uy5T79ylhtAQKBx4eWLf2hXGvqGgqsawt5GyaHBDqlHXv1L85e6LZRYdnuuIZ6ljNh3VZA06If/SS2LQRU3XDe0f6pvGe+Z0fNjiOM0PHv6TBPuGJDdYo23tlS9wZXOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r18usNiiUQ4Nkg74PvRZ2kKBvYpo1iKYTtIleikrz8Q=;
 b=chaPspdBTIwbOHGikVVBbFVbxPT687Z0qH6jIE5rLP0AFjEyzk1nJ5/EefU/iogR1/x7aFLPk9WRczkuK5r+iMp/iXTyiBaTXWpB5svvV5cHQAxVXxQlPs0pPjJ0UEM8dB+EexqdGyPFxptIEKelcTPrNxn3pK9xlIHY56egebMIXd2Q2zoHhVGeJwm83UAL45HStYV1XzDWuZMhcxsBnu+N5Ze8nq8gvgST5MBRXEAjHSLguMcROJG1OnPTqYGnRkHGbElS0K04I8vsNwdS9t23BV1j5VvzZXfp+4ai/wHR3RHPg9d0G1qwC66mPE0kdLyY6FKSD+rSZgGDcK2hmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r18usNiiUQ4Nkg74PvRZ2kKBvYpo1iKYTtIleikrz8Q=;
 b=Xex6HREyjWGAdTNUEg8qFTCo4xp+g7Exzl3HghPyNregI+rEEhkyXAYKEkvrfxR7Qolnv9ksrtFLfqupT7rK6c9jpRgrhV5uO63J8hBXIvZ9qKVb5C5CG5j5HA/A3fHbEbMZejwACjP9he6Drkldg41xPhKY8KGYVexZQ9fiN1a0hhnUKA4iKd64E/3R/vyB48IdGtnThAyhFo1sA5q+LhUwP+veqcncqBVFCfL+V02cYt1kMN4KRzoClTEJu5fodcctu+XU9iy87BYP7LHF7zYSAB9nVJbUM+S7HsG0aZVgtJ5c9jYMNFi3gbn6eXmNyGR2i38g4haZ02x6YveIhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com (2603:1096:400:272::6)
 by TY0PR06MB5077.apcprd06.prod.outlook.com (2603:1096:400:1bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 09:30:44 +0000
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019]) by TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 09:30:44 +0000
From:   Zehao Zhang <zhangzehao@vivo.com>
To:     agk@redhat.com, snitzer@kernel.org
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Zehao Zhang <zhangzehao@vivo.com>
Subject: [PATCH] dm: Convert to use time_after_eq macro
Date:   Thu,  6 Jul 2023 17:30:35 +0800
Message-Id: <20230706093035.35685-1-zhangzehao@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To TY0PR06MB5706.apcprd06.prod.outlook.com
 (2603:1096:400:272::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5706:EE_|TY0PR06MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 225a0f14-5230-4701-8ca6-08db7e03ac7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kN7+gGkk7zj8VDOt8SXXuZRaB5/gKkaHwXU07Q0T4ATDzM0GvAJZKcpRDiu+EbmPjmMojjY6Myia516X8Ct/HvPSKxjt2IRiaSybA78rfDIE5tPVx0QMjWavzW1U02wkQ07Uty0DDIR6wxhW+HF4BLE6VUuVfaYIGfP5wS7nZmA9Uif9BxR8El1QRUtwksHlgRQrwAksrXKb9EAOV1o6/v4y3Z5tvFx4fV7j/BXTQ07km0XuouT1djyUXOtWfXPh7h7EBt4PrVBc9tXUk1IJWTI3zxn/3F2iS9jjD11FBD5b0jeW7TVIUX84gaL9a224pFPKAOzOTsYIeAUGUA3FkHTRR3E6KM0FEUu9CNuhYuFhZ0MzPL23m8d72qtTEXI2LL/o3aUvgJQAvv79KDnUVvWE7JuLYnCSQAost8mb8Dlo6DA0nzEhlq9yqOlp8R1d+zmETbfGzi+kHEjqtHf9zBF05f/14KbeBXbCj0lltmDebsCPxYSYUP6eTcZOiwBL03GjnSaMathUOCT/DgtJ9s/ChD+cb2U/Pnd5sfjzx18kGMXuaLSLRN42YXV+AH4/s/6tytqpMKarGvMi/ZnwM+JIq12ZyyNHrSKqznYvTRUX6miaJCYR+LqhvhfWIj4P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5706.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(6506007)(41300700001)(38100700002)(6666004)(52116002)(83380400001)(1076003)(2616005)(107886003)(38350700002)(186003)(6512007)(86362001)(6486002)(316002)(478600001)(36756003)(66946007)(66476007)(4326008)(8936002)(66556008)(8676002)(2906002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/jh1mCth6K+7jgrMz8x+vkZJ5fJzVIDasiNVdcVlPPgMmdi7Z8uXqBEYL4iP?=
 =?us-ascii?Q?EwpDUL9Ff3U+9BCEAAmhmqeO5w9nTNWK4RDt0sEoByFDBPC+j3tvlVyIzvPz?=
 =?us-ascii?Q?X0ZVwStoT5e1tQtBW66gC335uhAJehIwrIofvoYHzX1isNoqbYwZ+Cy/hf0l?=
 =?us-ascii?Q?pWFFiWwmwO1vYhgw5paZEXPe2OsuF0kHC0eXwqMMcp6dqr8yd15dJgZWViMS?=
 =?us-ascii?Q?X4xcb+7st1eAdmMVJ0aNG1cGhvQw236u5XfP3tDF4pOFLeHPULoRxmgMInX4?=
 =?us-ascii?Q?hNWidYnhU8NJbGluXUDpRgzDTKkqX4xhQ1ZY9I8N4456flbdLD/eRCV+GKSC?=
 =?us-ascii?Q?hvHBPtGez5g1uTVNkXVZQpD5tKn4MjbRYbY94/rOrzBesMr1+D/5V2mEc9/W?=
 =?us-ascii?Q?2J1EKEleIxUWKMIKMptBhu/ncjBAm5hTj8xbUVYRwNJwHnRtoeEPKL6upN3b?=
 =?us-ascii?Q?Ic6C39ygTUCT6EL8cIbqygZDoi5fdzmB82/8W6hZd1PXVKkT7IKYCFoNFhmC?=
 =?us-ascii?Q?aE5OXc2B+rhUBKRyC4x4ONv73EPwCrPYznO2jV3j5IYendow3QG7XjNx4xMq?=
 =?us-ascii?Q?YCinC03XU6id98Zgz8Inij4lAFk10tJoxv95Lp7Ijs1ICDWHvGjNGDxW8+L5?=
 =?us-ascii?Q?ZjJrEuEd+71CrdkgGD6+r9orUrc8JTJp2v7ruWMNzOLi1pdQXhDgO8zcBG0P?=
 =?us-ascii?Q?AqVloipYlJtlchJ42NIEZF1oWpmjImXdQ3nc0Bf9/uXKhTZzelZH+MfMhAEi?=
 =?us-ascii?Q?5VSmy/YU43bjregkqhrr3rOO81B+2ajAbFWBy4sgAiQztXeBser7fZFK+vZP?=
 =?us-ascii?Q?mKE1t83qekLIh3LUDtkZXs6tAbMhosZCj7uVPYFJIc2lL6N9iIBQVz0T7YBP?=
 =?us-ascii?Q?zB7IcIBrx6c25JskUQq3i23NSub26MF2dqRAnbjfxrLlWmt/xbNDZ9pKhcaV?=
 =?us-ascii?Q?H30ELyan7W5A1vdj/UPuX/eqk0TsZcN2B3rLDo0S9jteK4RtWcbod0P+F1w/?=
 =?us-ascii?Q?futxEF25iCmLSJ/M8HRFJN6f2zybQXcwobhT0cylkvhhBV3N2O6GbQkGp2gz?=
 =?us-ascii?Q?N1foDKC9FALGMn6VJM4qHraprlB7r1A1tHxkhFPaHqXNeieiBSjc8hxXVShv?=
 =?us-ascii?Q?H7GXrDgNJY3ozNRUNZYddtfP+1w4ay6SlC5KrJfMJ6qwNT3w2NIRr59Bt5Ou?=
 =?us-ascii?Q?ZnsXv3IKkL6/UZBQxMz5cktm815jwfyu8NsVmcOZXTrtCJHF70v8meXlc3Ld?=
 =?us-ascii?Q?eNWi43h2LcHuowXEXjrDAuHutjSI0yWPjC+jSOFRGBqDTwrf8y4B3lbEFM/y?=
 =?us-ascii?Q?3zwEV2xnJibKtmty3qtvNrA1PvRbm+FAAKvCxqcBZMekIr4Pg6CKabfqd91g?=
 =?us-ascii?Q?HEdTb9YeeH03olanAl9AFU7aTYqixZtPJ0k3ZhhfK6pk11YHgwSolFukqz58?=
 =?us-ascii?Q?voBdVH0G2v3wdvr9XiJEQfdcQ69C78YqN3nKuB4yjagDTnXtRWdoQ3ZNvXPL?=
 =?us-ascii?Q?Ii1LXzwDawERlzFGgXRtPgZ/tYhRil+McUCI53bsg+yRBA+MChwPw3uKrBz8?=
 =?us-ascii?Q?9U2GzK3cJZcj0EpkVkOrMgDDVoF8c4g8pwysH1VM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225a0f14-5230-4701-8ca6-08db7e03ac7d
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5706.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 09:30:44.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlwDgWbKaP0968di9jvD9w6OXRBSmaHsb4yk/jV0thpKkmw52RB1raF35ef35K7mslrAb7X3XMjXb58SxCIokg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5077
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use time_after_eq macro instead of opening it for readability.

Signed-off-by: Zehao Zhang <zhangzehao@vivo.com>
---
 drivers/md/dm-writecache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 074cb785eafc..0527d328b6f4 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -16,6 +16,7 @@
 #include <linux/pfn_t.h>
 #include <linux/libnvdimm.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include "dm-io-tracker.h"
 
 #define DM_MSG_PREFIX "writecache"
@@ -1994,8 +1995,9 @@ static void writecache_writeback(struct work_struct *work)
 	while (!list_empty(&wc->lru) &&
 	       (wc->writeback_all ||
 		wc->freelist_size + wc->writeback_size <= wc->freelist_low_watermark ||
-		(jiffies - container_of(wc->lru.prev, struct wc_entry, lru)->age >=
-		 wc->max_age - wc->max_age / MAX_AGE_DIV))) {
+		(time_after_eq(jiffies,
+			container_of(wc->lru.prev, struct wc_entry, lru)->age +
+			(wc->max_age - wc->max_age / MAX_AGE_DIV))))) {
 
 		n_walked++;
 		if (unlikely(n_walked > WRITEBACK_LATENCY) &&
-- 
2.35.3

