Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0463653C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiLVGfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiLVGfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:35:01 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27301E701;
        Wed, 21 Dec 2022 22:34:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nd0sp0gKQz4f3mKp;
        Thu, 22 Dec 2022 14:34:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDH5jCP+qNjzwckAQ--.30442S3;
        Thu, 22 Dec 2022 14:34:57 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jack@suse.cz, kbusch@kernel.org, shikemeng@huaweicloud.com
Subject: [PATCH RESEND v2 1/5] sbitmap: remove unnecessary calculation of alloc_hint in __sbitmap_get_shallow
Date:   Thu, 22 Dec 2022 22:33:49 +0800
Message-Id: <20221222143353.598042-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221222143353.598042-1-shikemeng@huaweicloud.com>
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDH5jCP+qNjzwckAQ--.30442S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8JF18AF4xKFy5Kw4fuFg_yoW8Gw18pr
        4jgF9rK3sYvFy8ur4UKFykAFy3G398G3sxJa4Sgw4fur18K3Z3Gr4kKFWaqr13uFW7AFZ2
        ya1xXr1UuF1jqa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR3PE3UUUUU
        =
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We calculate allow_hint in next word as following:

/* low sb->shift bit of alloc_hint will be 0 after this shift */
alloc_hint = index << sb->shift;

/* get low sb->shift bit of alloc_hit */
SB_NR_TO_BIT(sb, alloc_hint)

So alloc_hit in next word will always be zero. Simpfy alloc_hit calculation
in __sbitmap_get_shallow according to the alloc_hit calculation in
__sbitmap_get.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/sbitmap.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 586deb333237..cb5e03a2d65b 100644
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

