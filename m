Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2425763C417
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiK2PrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiK2PrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:47:04 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3993B63B90;
        Tue, 29 Nov 2022 07:47:03 -0800 (PST)
Received: from localhost.localdomain (unknown [10.14.30.50])
        by mail-app4 (Coremail) with SMTP id cS_KCgBnaMxfKYZjT2esCA--.15899S7;
        Tue, 29 Nov 2022 23:46:59 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH v2 5/5] elevator: use bool instead of int as the return type of elv_iosched_allow_bio_merge
Date:   Tue, 29 Nov 2022 23:46:38 +0800
Message-Id: <0db0a0298758d60d0f4df8b7126ac6a381e5a5bb.1669736350.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1669736350.git.nickyc975@zju.edu.cn>
References: <cover.1669736350.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgBnaMxfKYZjT2esCA--.15899S7
X-Coremail-Antispam: 1UD129KBjvdXoWruFWrKw17WF1fZr1UWFW8Xrb_yoWDGFc_C3
        4Fkwn7uFyDCry5Ar42v3W2kFyvvan3XFyDur13Kr97Aa1qg3W8Aw1xZrsxJry8Wr4xW3W5
        G3ZFvF17KFnxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4
        vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
        wIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjfUFYFADUUUU
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgEJB1ZdtcpF+AABsF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have bool type now, update the old signature.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 8a5c171306f1..14e03632b5b5 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -57,7 +57,7 @@ static LIST_HEAD(elv_list);
  * Query io scheduler to see if the current process issuing bio may be
  * merged with rq.
  */
-static int elv_iosched_allow_bio_merge(struct request *rq, struct bio *bio)
+static bool elv_iosched_allow_bio_merge(struct request *rq, struct bio *bio)
 {
 	struct request_queue *q = rq->q;
 	struct elevator_queue *e = q->elevator;
@@ -65,7 +65,7 @@ static int elv_iosched_allow_bio_merge(struct request *rq, struct bio *bio)
 	if (e->type->ops.allow_merge)
 		return e->type->ops.allow_merge(q, rq, bio);
 
-	return 1;
+	return true;
 }
 
 /*
-- 
2.34.1

