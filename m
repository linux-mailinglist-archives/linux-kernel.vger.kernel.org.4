Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF0600511
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJQCAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJQCAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:00:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817FBDE2;
        Sun, 16 Oct 2022 19:00:18 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MrKrN0RsczJnTv;
        Mon, 17 Oct 2022 09:57:40 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 10:00:16 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shikemeng@huawei.com>
Subject: [PATCH 4/8] blk-iocost: Remove vrate member in struct ioc_now
Date:   Mon, 17 Oct 2022 10:00:07 +0800
Message-ID: <20221017020011.25016-5-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221017020011.25016-1-shikemeng@huawei.com>
References: <20221017020011.25016-1-shikemeng@huawei.com>
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

If we trace vtime_base_rate instead of vtime_rate, there is nowhere to
access now->vrate except function ioc_now using now->vrate locally.
Just clean it.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-iocost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b0991b52e3dd..761295ed9c5a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -556,7 +556,6 @@ struct ioc_now {
 	u64				now_ns;
 	u64				now;
 	u64				vnow;
-	u64				vrate;
 };
 
 struct iocg_wait {
@@ -1020,10 +1019,11 @@ static void ioc_adjust_base_vrate(struct ioc *ioc, u32 rq_wait_pct,
 static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 {
 	unsigned seq;
+	u64 vrate;
 
 	now->now_ns = ktime_get();
 	now->now = ktime_to_us(now->now_ns);
-	now->vrate = atomic64_read(&ioc->vtime_rate);
+	vrate = atomic64_read(&ioc->vtime_rate);
 
 	/*
 	 * The current vtime is
@@ -1036,7 +1036,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 	do {
 		seq = read_seqcount_begin(&ioc->period_seqcount);
 		now->vnow = ioc->period_at_vtime +
-			(now->now - ioc->period_at) * now->vrate;
+			(now->now - ioc->period_at) * vrate;
 	} while (read_seqcount_retry(&ioc->period_seqcount, seq));
 }
 
-- 
2.30.0

