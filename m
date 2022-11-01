Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D796146DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiKAJfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKAJex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391AC19002;
        Tue,  1 Nov 2022 02:34:33 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1lGX6lj2zmVYP;
        Tue,  1 Nov 2022 17:34:28 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:30 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 19/20] block, bfq: remove unnecessary local variable __bfqq in bfq_setup_merge
Date:   Tue, 1 Nov 2022 17:34:16 +0800
Message-ID: <20221101093417.10540-20-shikemeng@huawei.com>
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

We could traversal bfqq->new_bfqq list without a local variable easily and
intuitively. So remove unnecessary local variable __bfqq.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d3f4d995f84a..589ab59abcf5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2741,7 +2741,6 @@ static struct bfq_queue *
 bfq_setup_merge(struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
 {
 	int process_refs, new_process_refs;
-	struct bfq_queue *__bfqq;
 
 	/*
 	 * If there are no process references on the new_bfqq, then it is
@@ -2753,10 +2752,9 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
 		return NULL;
 
 	/* Avoid a circular list and skip interim queue merges. */
-	while ((__bfqq = new_bfqq->new_bfqq)) {
-		if (__bfqq == bfqq)
+	while ((new_bfqq = new_bfqq->new_bfqq)) {
+		if (new_bfqq == bfqq)
 			return NULL;
-		new_bfqq = __bfqq;
 	}
 
 	process_refs = bfqq_process_refs(bfqq);
-- 
2.30.0

