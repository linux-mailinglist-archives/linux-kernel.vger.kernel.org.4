Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3446C62087B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiKHExE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiKHEwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:52:38 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E221C413;
        Mon,  7 Nov 2022 20:52:31 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5wgk1SlFzmVhW;
        Tue,  8 Nov 2022 12:52:18 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 12:52:29 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 03/10] block, bfq: initialize bfqq->decrease_time_jif correctly
Date:   Tue, 8 Nov 2022 12:52:17 +0800
Message-ID: <20221108045224.19092-4-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221108045224.19092-1-shikemeng@huawei.com>
References: <20221108045224.19092-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, decrease_time_jif is initialized to 0 and will be updated in
function bfq_reset_inject_limit and bfq_update_inject_limit while these
two functions are called when jiffies pasts decrease_time_jif with some
extra time or think-time state changes. If jiffies is slightly larger
than MAX_JIFFY_OFFSET, it will take a long time to meet the first
condition. The second condition is heavily relies on process behavior. To
be more specific:

Function bfq_update_inject_limit maybe triggered when jiffies pasts
decrease_time_jif + msecs_to_jiffies(10) in bfq_add_request by setting
bfqd->wait_dispatch to true.

Function bfq_reset_inject_limit are called in two conditions:
1. jiffies pasts bfqq->decrease_time_jif + msecs_to_jiffies(1000) in
function bfq_add_request.
2. jiffies pasts bfqq->decrease_time_jif + msecs_to_jiffies(100) or
bfq think-time state change from short to long.

In worst case that jiffies is slightly larger than MAX_JIFFY_OFFSET
and think-time state never changes, the service injection may be not
triggered for a long time.

Fix this by initializing bfqq->decrease_time_jif to current jiffies
to trigger service injection soon when service injection conditions
are met.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fc71181a7e5d..01fa16047eb5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5557,6 +5557,8 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	/* first request is almost certainly seeky */
 	bfqq->seek_history = 1;
+
+	bfqq->decrease_time_jif = jiffies;
 }
 
 static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
-- 
2.30.0

