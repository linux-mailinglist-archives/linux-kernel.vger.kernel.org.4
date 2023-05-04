Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015B96F6C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjEDMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjEDMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:49:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929A26A7E;
        Thu,  4 May 2023 05:49:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QBttn0tW5z4f3v51;
        Thu,  4 May 2023 20:49:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbHdqVNkzuf5Ig--.27873S10;
        Thu, 04 May 2023 20:49:38 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, linan122@huawei.com, vishal.l.verma@intel.com,
        dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 06/11] block/badblocks: fix ack set fail in badblocks_set
Date:   Thu,  4 May 2023 20:48:23 +0800
Message-Id: <20230504124828.679770-7-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504124828.679770-1-linan666@huaweicloud.com>
References: <20230504124828.679770-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbHdqVNkzuf5Ig--.27873S10
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4xtrWrWrW8tF17JFWUArb_yoWkXrg_J3
        WFyFZ5Xrn5CFs8Cr1Yy3W0qrsY9F45Cr4kCw12qrn7XrsrtF1DJws8tr93Wrn5CFZrC390
        v34rXr9Iva4IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbvxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
        0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x0262
        8vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
        xhVjvjDU0xZFpf9x07UMa0PUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

If we try to set ack for a BB_MAX_LEN badblocks, it will return
0(success) but did not set ack at all in badblocks_set(). Check ack
before setting to fix it, and do not set badblocks already exist.

Fixes: 9e0e252a048b ("badblocks: Add core badblock management code")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 11e3a3ae2c72..c11eb869f2f3 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -219,18 +219,18 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 			if (e < s + sectors)
 				e = s + sectors;
 			if (e - a <= BB_MAX_LEN) {
-				p[lo] = BB_MAKE(a, e-a, ack);
 				s = e;
 			} else {
 				/* does not all fit in one range,
 				 * make p[lo] maximal
 				 */
-				if (BB_LEN(p[lo]) != BB_MAX_LEN)
-					p[lo] = BB_MAKE(a, BB_MAX_LEN, ack);
 				s = a + BB_MAX_LEN;
 			}
+			if (s - a != BB_LEN(p[lo]) || ack != BB_ACK(p[lo])) {
+				p[lo] = BB_MAKE(a, s - a, ack);
+				changed = true;
+			}
 			sectors = e - s;
-			changed = true;
 		}
 	}
 	if (sectors && hi < bb->count) {
-- 
2.31.1

