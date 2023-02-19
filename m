Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8369BE36
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 03:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBSClg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 21:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBSCl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 21:41:28 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA67112051;
        Sat, 18 Feb 2023 18:41:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PK8v60GP2z4f3pBy;
        Sun, 19 Feb 2023 10:41:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7utQjPFjPmleDw--.7604S8;
        Sun, 19 Feb 2023 10:41:24 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 06/17] block, bfq: correct bfq_max_budget and bfq_min_budget
Date:   Sun, 19 Feb 2023 18:42:58 +0800
Message-Id: <20230219104309.1511562-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
References: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7utQjPFjPmleDw--.7604S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Jry5Zw15WF1UWrW3tr47Jwb_yoW8JrW5pa
        4qqw10gF17JrZxXrs7K3WUX3W5twsxZF4kKr1YqrWjyF4IyF1ayF18Zw18X3WfKrWIyry5
        X3sru34DXa12kaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For case that user set a max_budget, we should use bfq_max_budget
set by user instead of bfq_default_max_budget when budgets_assigned
is not enough to compulte auto-tuning max_budget.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5b08711cbaf6..b32bae5259d5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1458,7 +1458,8 @@ static int bfq_bfqq_budget_left(struct bfq_queue *bfqq)
  */
 static int bfq_max_budget(struct bfq_data *bfqd)
 {
-	if (bfqd->budgets_assigned < bfq_stats_min_budgets)
+	if (bfqd->budgets_assigned < bfq_stats_min_budgets &&
+			bfqd->bfq_user_max_budget == 0)
 		return bfq_default_max_budget;
 	else
 		return bfqd->bfq_max_budget;
@@ -1470,7 +1471,8 @@ static int bfq_max_budget(struct bfq_data *bfqd)
  */
 static int bfq_min_budget(struct bfq_data *bfqd)
 {
-	if (bfqd->budgets_assigned < bfq_stats_min_budgets)
+	if (bfqd->budgets_assigned < bfq_stats_min_budgets &&
+			bfqd->bfq_user_max_budget == 0)
 		return bfq_default_max_budget / 32;
 	else
 		return bfqd->bfq_max_budget / 32;
-- 
2.30.0

