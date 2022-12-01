Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC5763E91F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLAEzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLAEy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:54:57 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABE89FEE2;
        Wed, 30 Nov 2022 20:54:56 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NN3cg6K3SzHwN6;
        Thu,  1 Dec 2022 12:53:39 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 1 Dec
 2022 12:54:11 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huaweicloud.com>, <linfeilong@huawei.com>,
        <liuzhiqiang@huawei.com>
Subject: [PATCH 2/5] sbitmap: remove unnecessary calculation of alloc_hint in __sbitmap_get_shallow
Date:   Thu, 1 Dec 2022 12:54:05 +0800
Message-ID: <20221201045408.21908-3-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221201045408.21908-1-shikemeng@huawei.com>
References: <20221201045408.21908-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We calculate allow_hint in next word as following:

/* low sb->shift bit of alloc_hint will be 0 after this shift */
alloc_hint = index << sb->shift;

/* get low sb->shift bit of alloc_hit */
SB_NR_TO_BIT(sb, alloc_hint)

So alloc_hit in next word will always be zero. Simpfy alloc_hit calculation
in __sbitmap_get_shallow according to the alloc_hit calculation in
__sbitmap_get.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 lib/sbitmap.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index e40759bcf821..791edf5ea4ca 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -243,6 +243,7 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 	int nr = -1;
 
 	index = SB_NR_TO_INDEX(sb, alloc_hint);
+	alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
 
 	for (i = 0; i < sb->map_nr; i++) {
 again:
@@ -250,7 +251,7 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 					min_t(unsigned int,
 					      __map_depth(sb, index),
 					      shallow_depth),
-					SB_NR_TO_BIT(sb, alloc_hint), true);
+					alloc_hint, true);
 		if (nr != -1) {
 			nr += index << sb->shift;
 			break;
@@ -260,13 +261,9 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 			goto again;
 
 		/* Jump to next index. */
-		index++;
-		alloc_hint = index << sb->shift;
-
-		if (index >= sb->map_nr) {
+		alloc_hint = 0;
+		if (++index >= sb->map_nr)
 			index = 0;
-			alloc_hint = 0;
-		}
 	}
 
 	return nr;
-- 
2.30.0

