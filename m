Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82F76F6C56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjEDMuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjEDMtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:49:50 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE8C6A64;
        Thu,  4 May 2023 05:49:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QBttl1gWTz4f3v6S;
        Thu,  4 May 2023 20:49:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbHdqVNkzuf5Ig--.27873S7;
        Thu, 04 May 2023 20:49:36 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, linan122@huawei.com, vishal.l.verma@intel.com,
        dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 03/11] block/badblocks: fix badblocks loss when badblocks combine
Date:   Thu,  4 May 2023 20:48:20 +0800
Message-Id: <20230504124828.679770-4-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504124828.679770-1-linan666@huaweicloud.com>
References: <20230504124828.679770-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbHdqVNkzuf5Ig--.27873S7
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW8urW3AryDWw17Kry3urg_yoW8XrW5pw
        1fZwnIgr1IgFyv9F4UX3WDGF1Sg3Z7JF45Ga1Yqa48uFyDAw1xKF4vq3WYvrW0gF4xXF90
        va1rWryDZFyfG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
        C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
        vjDU0xZFpf9x07UKXd8UUUUU=
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

badblocks will loss if we set it as below:

  # echo 1 1 > bad_blocks
  # echo 3 1 > bad_blocks
  # echo 1 5 > bad_blocks
  # cat bad_blocks
    1 3

In badblocks_set(), if there is an intersection between p[lo] and p[hi],
we will combine them. The end of new badblocks is p[hi]'s end now. but
p[lo] may cross p[hi] and new end should be the larger of p[lo] and p[hi].

Fixes: 9e0e252a048b ("badblocks: Add core badblock management code")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 7e6ebe2ac12c..2c2ef8284a3f 100644
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
2.31.1

