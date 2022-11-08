Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2574620877
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiKHEwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiKHEwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:52:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDBA1BEB5;
        Mon,  7 Nov 2022 20:52:31 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5wgS5XbdzHvmS;
        Tue,  8 Nov 2022 12:52:04 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 12:52:27 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 01/10] block, bfq: correctly raise inject limit in bfq_choose_bfqq_for_injection
Date:   Tue, 8 Nov 2022 12:52:15 +0800
Message-ID: <20221108045224.19092-2-shikemeng@huawei.com>
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

Inject limit could be temporarily raised if current inject_limit is 0.
raised limit is saved in local variable "limit". The traverse below will
reset raised "limit" to bfqd->in_service_queue which is 0 for limit
raised condition and will invalidate the raised limit.

After passing bfqd->rq_in_driver >= limit check above, we can be sure
about two things in traverse:
1. Local variable "limit" is greater than 0 or bfqd->rq_in_driver >= limit
check is always met.
2. For normal case (else case for large request to non-rotational drives),
no need to check bfqd->rq_in_driver < limit again if local variable
"limit" is not changed.

Fix this by not overwriting local variable "limit" in traverse. As
metioned in first thing above that limit is greater than 0, so result of
min_t(unsigned int, 1, limit) is always 1. we can simply check whether
rq_in_driver is less than 1 for case of large request to non-rotational
drives and remove assignment to local variable "limit" in traverse. As
metioned in second thing above, in normal case no futher check is needed
if local variable "limit" is not chaged, so return directly in normal
case.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7ea427817f7f..b0bee8ab65e6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4707,12 +4707,10 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 			 */
 			if (blk_queue_nonrot(bfqd->queue) &&
 			    blk_rq_sectors(bfqq->next_rq) >=
-			    BFQQ_SECT_THR_NONROT)
-				limit = min_t(unsigned int, 1, limit);
-			else
-				limit = in_serv_bfqq->inject_limit;
-
-			if (bfqd->rq_in_driver < limit) {
+			    BFQQ_SECT_THR_NONROT &&
+			    bfqd->rq_in_driver >= 1)
+				continue;
+			else {
 				bfqd->rqs_injected = true;
 				return bfqq;
 			}
-- 
2.30.0

