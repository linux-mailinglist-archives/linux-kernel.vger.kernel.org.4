Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E426146DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiKAJfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiKAJew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8434419283;
        Tue,  1 Nov 2022 02:34:33 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1lBX0NsGzpW59;
        Tue,  1 Nov 2022 17:31:00 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:31 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 20/20] block, bfq: remove unncessary process_ref check for merged queue in bfq_setup_merge
Date:   Tue, 1 Nov 2022 17:34:17 +0800
Message-ID: <20221101093417.10540-21-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221101093417.10540-1-shikemeng@huawei.com>
References: <20221101093417.10540-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we already check process_refs of original new_bfqq is not zero. The
later new_bfqq maybe the merged queue of original new_bfqq which inherit
the process_refs of original new_bfqq which is not zero, so process_refs
of merged queue will not be zero.
Remove unncessary check for merged queue and remove new_process_refs
which will not be used.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 589ab59abcf5..0736577bfbfe 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2740,7 +2740,7 @@ static struct bfq_queue *bfq_find_close_cooperator(struct bfq_data *bfqd,
 static struct bfq_queue *
 bfq_setup_merge(struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
 {
-	int process_refs, new_process_refs;
+	int process_refs;
 
 	/*
 	 * If there are no process references on the new_bfqq, then it is
@@ -2758,12 +2758,11 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
 	}
 
 	process_refs = bfqq_process_refs(bfqq);
-	new_process_refs = bfqq_process_refs(new_bfqq);
 	/*
 	 * If the process for the bfqq has gone away, there is no
 	 * sense in merging the queues.
 	 */
-	if (process_refs == 0 || new_process_refs == 0)
+	if (process_refs == 0)
 		return NULL;
 
 	/*
-- 
2.30.0

