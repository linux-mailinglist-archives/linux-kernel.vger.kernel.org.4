Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E70260050D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJQCA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJQCAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:00:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4DB25C6B;
        Sun, 16 Oct 2022 19:00:18 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MrKrM38S7zJnTn;
        Mon, 17 Oct 2022 09:57:39 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 10:00:15 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shikemeng@huawei.com>
Subject: [PATCH 3/8] blk-iocost: Trace vtime_base_rate instead of vtime_rate
Date:   Mon, 17 Oct 2022 10:00:06 +0800
Message-ID: <20221017020011.25016-4-shikemeng@huawei.com>
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

Since commit ac33e91e2daca ("blk-iocost: implement vtime loss
compensation") rename original vtime_base to vtime_base_rate
and current vtime_base is original vtime_base with compensation.
The current rate showed in tracepoint is mixed with vtime_base
and vtime_base_rate:
1) In function ioc_adjust_base_vrate, the first trace_iocost_ioc_vrate_adj
shows vtime_base, the second trace_iocost_ioc_vrate_adj shows
vtime_base_rate.
2) In function iocg_activate shows vtime_base by calling
TRACE_IOCG_PATH(iocg_activate...
3) In function ioc_check_iocgs shows vtime_base by calling
TRACE_IOCG_PATH(iocg_idle...

Trace vtime_base_rate instead of vtime_rate as:
1) Before commit ac33e91e2daca ("blk-iocost: implement vtime loss
compensation"), the traced rate is without compensation, so still
show rate without compensation.
2) The vtime_base_rate is more stable while vtime_rate heavily depends on
excess budeget on current period which may change abruptly in next period.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-iocost.c            | 2 +-
 include/trace/events/iocost.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9214733bbc14..b0991b52e3dd 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -977,7 +977,7 @@ static void ioc_adjust_base_vrate(struct ioc *ioc, u32 rq_wait_pct,
 
 	if (!ioc->busy_level || (ioc->busy_level < 0 && nr_lagging)) {
 		if (ioc->busy_level != prev_busy_level || nr_lagging)
-			trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
+			trace_iocost_ioc_vrate_adj(ioc, vrate,
 						   missed_ppm, rq_wait_pct,
 						   nr_lagging, nr_shortages);
 
diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index 6d1626e7a4ce..af8bfed528fc 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -38,7 +38,7 @@ DECLARE_EVENT_CLASS(iocost_iocg_state,
 		__assign_str(cgroup, path);
 		__entry->now = now->now;
 		__entry->vnow = now->vnow;
-		__entry->vrate = now->vrate;
+		__entry->vrate = iocg->ioc->vtime_base_rate;
 		__entry->last_period = last_period;
 		__entry->cur_period = cur_period;
 		__entry->vtime = vtime;
@@ -160,7 +160,7 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 
 	TP_fast_assign(
 		__assign_str(devname, ioc_name(ioc));
-		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);
+		__entry->old_vrate = ioc->vtime_base_rate;
 		__entry->new_vrate = new_vrate;
 		__entry->busy_level = ioc->busy_level;
 		__entry->read_missed_ppm = missed_ppm[READ];
-- 
2.30.0

