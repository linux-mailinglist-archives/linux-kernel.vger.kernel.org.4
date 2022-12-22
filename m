Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667CA653EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbiLVLSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiLVLRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:17:50 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F49720189;
        Thu, 22 Dec 2022 03:17:49 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nd78829d7z4f3p60;
        Thu, 22 Dec 2022 19:17:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgB3a+nXPKRjMew+AQ--.3596S7;
        Thu, 22 Dec 2022 19:17:47 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: [PATCH RESEND v2 05/10] block, bfq: remove unnecessary dereference to get async_bfqq
Date:   Fri, 23 Dec 2022 03:16:36 +0800
Message-Id: <20221222191641.1643117-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3a+nXPKRjMew+AQ--.3596S7
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy3Gr1rWFW5Cw13Xry7ZFb_yoW3Zrc_A3
        W8KFn3AF48GFy3Cr4rAryjy3Z8KrWrX3WrGFyYqry5WFnFya1DAasFqr909a98Cay7Ga4a
        gr97ury7AF4j9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
        64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM2
        8EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0D
        M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0TqcUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The async_bfqq is assigned with bfqq->bic->bfqq[0], use it directly.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c3c4c83ee95f..ebcafe3c4c3b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4835,7 +4835,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		    icq_to_bic(async_bfqq->next_rq->elv.icq) == bfqq->bic &&
 		    bfq_serv_to_charge(async_bfqq->next_rq, async_bfqq) <=
 		    bfq_bfqq_budget_left(async_bfqq))
-			bfqq = bfqq->bic->bfqq[0];
+			bfqq = async_bfqq;
 		else if (bfqq->waker_bfqq &&
 			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
 			   bfqq->waker_bfqq->next_rq &&
-- 
2.30.0

