Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31D73D93A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFZIKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjFZIKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:10:16 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A576E7A;
        Mon, 26 Jun 2023 01:10:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqL9k1cbVz4f41Vn;
        Mon, 26 Jun 2023 16:10:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLPWR5lkQbNDMg--.19922S7;
        Mon, 26 Jun 2023 16:10:03 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, linan122@huawei.com, vishal.l.verma@intel.com,
        dan.j.williams@intel.com, ashok_raj@linux.intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v4 3/4] block/badblocks: fix badblocks loss when badblocks combine
Date:   Mon, 26 Jun 2023 16:09:12 +0800
Message-Id: <20230626080913.3493135-4-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626080913.3493135-1-linan666@huaweicloud.com>
References: <20230626080913.3493135-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLPWR5lkQbNDMg--.19922S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ur17tr4UuFWkKF1UtF1UKFg_yoW8CF18pw
        1fXw1agF18W3W093W8XF1UGF1093W7JF4UJ3y5J3W8WFyUAw1xKF1qqw1YvrW0qF4fXFn0
        vay8WryUXFWfC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU1BOJ7UUUUU==
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

badblocks will loss if set it as below:
  $ echo 1 1 > bad_blocks
  $ echo 3 1 > bad_blocks
  $ echo 1 4 > bad_blocks
  $ cat bad_blocks
    1 3

After the fix, in the same scenario, it will be:
  $ cat bad_blocks
    1 4

In badblocks_set(), if set a new badblocks, first find two existing
badblocks adjacent to it, named lo and hi. Then try to merge new with lo.
If merge success and there is an intersection between lo and hi, try to
combine lo and hi.

set 1 4
binary-search:
  lo: 1 1	|____|
  hi: 3 1		  |____|

merge with lo:
  lo: 1 4	|___________________|
  hi: 3 1		  |____|

combine lo and hi:
  result: 1 3	|______________|
			       | -> hi's end
			       |____| -> lost

Now, the end of combined badblocks must be hi's end. However, it should be
the larger one between lo and hi. Fix it.

Fixes: 9e0e252a048b ("badblocks: Add core badblock management code")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 7b1ad364e85c..c1745b76d8f1 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -267,16 +267,14 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 	if (sectors == 0 && hi < bb->count) {
 		/* we might be able to combine lo and hi */
 		/* Note: 's' is at the end of 'lo' */
-		sector_t a = BB_OFFSET(p[hi]);
-		int lolen = BB_LEN(p[lo]);
-		int hilen = BB_LEN(p[hi]);
-		int newlen = lolen + hilen - (s - a);
+		sector_t a = BB_OFFSET(p[lo]);
+		int newlen = max(s, BB_OFFSET(p[hi]) + BB_LEN(p[hi])) - a;
 
-		if (s >= a && newlen < BB_MAX_LEN) {
+		if (s >= BB_OFFSET(p[hi]) && newlen < BB_MAX_LEN) {
 			/* yes, we can combine them */
 			int ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
 
-			p[lo] = BB_MAKE(BB_OFFSET(p[lo]), newlen, ack);
+			p[lo] = BB_MAKE(a, newlen, ack);
 			memmove(p + hi, p + hi + 1,
 				(bb->count - hi - 1) * 8);
 			bb->count--;
-- 
2.39.2

