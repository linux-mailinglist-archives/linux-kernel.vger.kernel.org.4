Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9046D66BE46
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjAPMza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjAPMy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:54:56 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD701E9E3;
        Mon, 16 Jan 2023 04:52:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NwX3v4KHkz4f3wYY;
        Mon, 16 Jan 2023 20:52:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7uuMSMVjYH02Bw--.361S3;
        Mon, 16 Jan 2023 20:52:29 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.cz, axboe@kernel.dk
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huaweicloud.com
Subject: [PATCH v3 1/5] sbitmap: remove unnecessary calculation of alloc_hint in __sbitmap_get_shallow
Date:   Tue, 17 Jan 2023 04:50:55 +0800
Message-Id: <20230116205059.3821738-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230116205059.3821738-1-shikemeng@huaweicloud.com>
References: <20230116205059.3821738-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7uuMSMVjYH02Bw--.361S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF48WFyxXr1xZw17AF1kXwb_yoW8Jw1kpr
        4jgFy7K3sYv348ur1UKFWqyFy3Ga1qk3sxGa4fWw4fuF4UKa4fGr1kKFWSqF13CFy5AFs2
        va1Sqr1UWr45X3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR3PE3UUUUU
        =
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to alloc_hint in the loop in __sbitmap_get_shallow() are mostly
pointless and equivalent to setting alloc_hint to zero (because
SB_NR_TO_BIT() considers only low sb->shift bits from alloc_hint). So
simplify the logic.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/sbitmap.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 1fcede228fa2..462873a4337c 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -243,6 +243,7 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 	int nr = -1;
 
 	index = SB_NR_TO_INDEX(sb, alloc_hint);
+	alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
 
 	for (i = 0; i < sb->map_nr; i++) {
 again:
@@ -250,7 +251,7 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 					min_t(unsigned int,
 					      __map_depth(sb, index),
 					      shallow_depth),
-					SB_NR_TO_BIT(sb, alloc_hint), true);
+					alloc_hint, true);
 		if (nr != -1) {
 			nr += index << sb->shift;
 			break;
@@ -260,13 +261,9 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 			goto again;
 
 		/* Jump to next index. */
-		index++;
-		alloc_hint = index << sb->shift;
-
-		if (index >= sb->map_nr) {
+		alloc_hint = 0;
+		if (++index >= sb->map_nr)
 			index = 0;
-			alloc_hint = 0;
-		}
 	}
 
 	return nr;
-- 
2.30.0

