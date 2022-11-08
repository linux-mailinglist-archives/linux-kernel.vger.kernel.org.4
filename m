Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E534062087F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiKHExT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiKHEwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:52:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4D8326DE;
        Mon,  7 Nov 2022 20:52:33 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5wbm6s1szpWBX;
        Tue,  8 Nov 2022 12:48:52 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 12:52:31 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 07/10] block, bfq: remove redundant check in bfq_put_cooperator
Date:   Tue, 8 Nov 2022 12:52:21 +0800
Message-ID: <20221108045224.19092-8-shikemeng@huawei.com>
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

We have already avoided a circular list in bfq_setup_merge (see comments
in bfq_setup_merge() for details), so bfq_queue will not appear in it's
new_bfqq list. Just remove this check.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index be923be48647..cffc5ff66ee6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5339,8 +5339,6 @@ void bfq_put_cooperator(struct bfq_queue *bfqq)
 	 */
 	__bfqq = bfqq->new_bfqq;
 	while (__bfqq) {
-		if (__bfqq == bfqq)
-			break;
 		next = __bfqq->new_bfqq;
 		bfq_put_queue(__bfqq);
 		__bfqq = next;
-- 
2.30.0

