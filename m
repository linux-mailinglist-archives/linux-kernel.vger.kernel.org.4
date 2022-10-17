Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB076006C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiJQGbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJQGbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:31:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE3756BA0;
        Sun, 16 Oct 2022 23:31:19 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MrRrK6sLtzpWH0;
        Mon, 17 Oct 2022 14:28:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 14:31:17 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-block@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 3/3] blktrace: remove unnessary stop block trace in 'blk_trace_shutdown'
Date:   Mon, 17 Oct 2022 14:53:21 +0800
Message-ID: <20221017065321.2846017-4-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221017065321.2846017-1-yebin10@huawei.com>
References: <20221017065321.2846017-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As previous commit, '__blk_trace_remove' will stop block trace if
block trace's state is 'Blktrace_running'.
So remove unnessary stop block trace in 'blk_trace_shutdown'.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/blktrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 0d93a0110ab5..f33ec0f5750a 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -777,10 +777,8 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 void blk_trace_shutdown(struct request_queue *q)
 {
 	if (rcu_dereference_protected(q->blk_trace,
-				      lockdep_is_held(&q->debugfs_mutex))) {
-		__blk_trace_startstop(q, 0);
+				      lockdep_is_held(&q->debugfs_mutex)))
 		__blk_trace_remove(q);
-	}
 }
 
 #ifdef CONFIG_BLK_CGROUP
-- 
2.31.1

