Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7C5FC2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJLJSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJLJS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:18:29 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B956ABCB8C;
        Wed, 12 Oct 2022 02:18:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MnRq113vZzl6Hb;
        Wed, 12 Oct 2022 17:16:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgAnKMpehkZjlH+ZAA--.8980S8;
        Wed, 12 Oct 2022 17:18:25 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        linan122@huawei.com
Subject: [PATCH v2 4/4] blk-iocost: read 'ioc->params' inside 'ioc->lock' in ioc_timer_fn()
Date:   Wed, 12 Oct 2022 17:40:35 +0800
Message-Id: <20221012094035.390056-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221012094035.390056-1-yukuai1@huaweicloud.com>
References: <20221012094035.390056-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnKMpehkZjlH+ZAA--.8980S8
X-Coremail-Antispam: 1UD129KBjvJXoWrtw1rJrykKw43CF4rGFykKrg_yoW8JryfpF
        WYg34DK3y5Ar4avrWIga92qa4kCayvgr18Zr47X3yrAFy7tr1I93WDCr4Y9F1xAFZayrZ8
        Xrs3trWFvr1rKrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

'ioc->params' is updated in ioc_refresh_params(), which is proteced by
'ioc->lock', however, ioc_timer_fn() read params outside the lock.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5acc5f13bbd6..f01359906c83 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2203,8 +2203,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 	LIST_HEAD(surpluses);
 	int nr_debtors, nr_shortages = 0, nr_lagging = 0;
 	u64 usage_us_sum = 0;
-	u32 ppm_rthr = MILLION - ioc->params.qos[QOS_RPPM];
-	u32 ppm_wthr = MILLION - ioc->params.qos[QOS_WPPM];
+	u32 ppm_rthr;
+	u32 ppm_wthr;
 	u32 missed_ppm[2], rq_wait_pct;
 	u64 period_vtime;
 	int prev_busy_level;
@@ -2215,6 +2215,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 	/* take care of active iocgs */
 	spin_lock_irq(&ioc->lock);
 
+	ppm_rthr = MILLION - ioc->params.qos[QOS_RPPM];
+	ppm_wthr = MILLION - ioc->params.qos[QOS_WPPM];
 	ioc_now(ioc, &now);
 
 	period_vtime = now.vnow - ioc->period_at_vtime;
-- 
2.31.1

