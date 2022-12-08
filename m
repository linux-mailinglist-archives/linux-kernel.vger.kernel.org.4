Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342F7647147
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiLHODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLHOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:02:48 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2250165D2;
        Thu,  8 Dec 2022 06:02:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NSbSp23Jnz4f3nTH;
        Thu,  8 Dec 2022 22:02:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgBXAbB77pFjF4YRBw--.33249S3;
        Thu, 08 Dec 2022 22:02:37 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: [PATCH 1/4] sbitmap: remove unnecessary calculation of alloc_hint in __sbitmap_get_shallow
Date:   Fri,  9 Dec 2022 06:01:44 +0800
Message-Id: <20221208220147.3315388-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221208220147.3315388-1-shikemeng@huaweicloud.com>
References: <20221208220147.3315388-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXAbB77pFjF4YRBw--.33249S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8JF18AF4xKFy5Kw4fuFg_yoW8Gw18pr
        4jgF9rK3sYvFy8ur4UKFykAFy3G398G3sxJa4Sgw4fur18K3Z3Gr4kKFWaqr13uFW7AFZ2
        ya1xXr1UuF1jqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIksgUUUUU
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

