Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCC15FAE30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJKIOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJKINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:13:39 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2F48A1E2;
        Tue, 11 Oct 2022 01:13:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MmpQJ40rBzKGH3;
        Tue, 11 Oct 2022 16:11:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgA3N8msJUVjAYFiAA--.27549S9;
        Tue, 11 Oct 2022 16:13:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 5/5] blk-iocost: read 'ioc->params' inside 'ioc->lock' in ioc_timer_fn()
Date:   Tue, 11 Oct 2022 16:35:47 +0800
Message-Id: <20221011083547.1831389-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221011083547.1831389-1-yukuai1@huaweicloud.com>
References: <20221011083547.1831389-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3N8msJUVjAYFiAA--.27549S9
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1rJrykKw1xZF1ktrWxCrg_yoWkKFc_ur
        9Yq34vgryxGasxWFs09an0vw42qws5tr43KF15WFW7Z3WDJFsayw1xGr97Cr47ua47Wa45
        GayDWrZxJrWkWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbTkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
        IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

'ioc->params' is updated in ioc_refresh_params(), which is proteced by
'ioc->lock', however, ioc_timer_fn() read params outside the lock.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 32e7e416d67c..acb10ba49da9 100644
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

