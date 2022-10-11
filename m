Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3745FAB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJKD1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJKD1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:27:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116127A750
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:27:18 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mmh1H5Rzlz1M8rj;
        Tue, 11 Oct 2022 11:22:43 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 11:25:26 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 11:25:25 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>,
        <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 6/6] ubifs: Reserve one leb for each journal head while doing budget
Date:   Tue, 11 Oct 2022 11:47:32 +0800
Message-ID: <20221011034732.45605-7-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221011034732.45605-1-chengzhihao1@huawei.com>
References: <20221011034732.45605-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBIFS calculates available space by c->main_bytes - c->lst.total_used
(which means non-index lebs' free and dirty space is accounted into
total available), then index lebs and four lebs (one for gc_lnum, one
for deletions, two for journal heads) are deducted.
In following situation, ubifs may get -ENOSPC from make_reservation():
 LEB 84: DATAHD   free 122880 used 1920  dirty 2176  dark 6144
 LEB 110:DELETION free 126976 used 0     dirty 0     dark 6144 (empty)
 LEB 201:gc_lnum  free 126976 used 0     dirty 0     dark 6144
 LEB 272:GCHD     free 77824  used 47672 dirty 1480  dark 6144
 LEB 356:BASEHD   free 0      used 39776 dirty 87200 dark 6144
 OTHERS: index lebs, zero-available non-index lebs

UBIFS calculates the available bytes is 6888 (How to calculate it:
126976 * 5[remain main bytes] - 1920[used] - 47672[used] - 39776[used] -
126976 * 1[deletions] - 126976 * 1[gc_lnum] - 126976 * 2[journal heads]
- 6144 * 5[dark] = 6888) after doing budget, however UBIFS cannot use
BASEHD's dirty space(87200), because UBIFS cannot find next BASEHD to
reclaim current BASEHD. (c->bi.min_idx_lebs equals to c->lst.idx_lebs,
the empty leb won't be found by ubifs_find_free_space(), and dirty index
lebs won't be picked as gced lebs. All non-index lebs has dirty space
less then c->dead_wm, non-index lebs won't be picked as gced lebs
either. So new free lebs won't be produced.). See more details in Link.

To fix it, reserve one leb for each journal head while doing budget.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216562
Fixes: 1e51764a3c2ac0 ("UBIFS: add new flash file system")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/budget.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
index 986e6e4081c7..d76eb7b39f56 100644
--- a/fs/ubifs/budget.c
+++ b/fs/ubifs/budget.c
@@ -209,11 +209,10 @@ long long ubifs_calc_available(const struct ubifs_info *c, int min_idx_lebs)
 	subtract_lebs += 1;
 
 	/*
-	 * The GC journal head LEB is not really accessible. And since
-	 * different write types go to different heads, we may count only on
-	 * one head's space.
+	 * Since different write types go to different heads, we should
+	 * reserve one leb for each head.
 	 */
-	subtract_lebs += c->jhead_cnt - 1;
+	subtract_lebs += c->jhead_cnt;
 
 	/* We also reserve one LEB for deletions, which bypass budgeting */
 	subtract_lebs += 1;
-- 
2.31.1

