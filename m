Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902FE682451
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjAaGKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjAaGKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:10:51 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42823B3EA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 22:10:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VaVVaz._1675145432;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VaVVaz._1675145432)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 14:10:44 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     agk@redhat.com
Cc:     snitzer@kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] dm integrity: Remove the unused variable bi_sector
Date:   Tue, 31 Jan 2023 14:09:41 +0800
Message-Id: <20230131060941.36690-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable bi_sector is not effectively used, so delete it.

drivers/md/dm-integrity.c:1738:13: warning: variable 'bi_sector' set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3895
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/md/dm-integrity.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 1388ee35571e..c62c21aadf32 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1735,7 +1735,6 @@ static void integrity_metadata(struct work_struct *w)
 		}
 
 		if (unlikely(dio->op == REQ_OP_DISCARD)) {
-			sector_t bi_sector = dio->bio_details.bi_iter.bi_sector;
 			unsigned bi_size = dio->bio_details.bi_iter.bi_size;
 			unsigned max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : HASH_MAX_DIGESTSIZE;
 			unsigned max_blocks = max_size / ic->tag_size;
@@ -1752,13 +1751,7 @@ static void integrity_metadata(struct work_struct *w)
 					goto error;
 				}
 
-				/*if (bi_size < this_step_blocks << (SECTOR_SHIFT + ic->sb->log2_sectors_per_block)) {
-					printk("BUGG: bi_sector: %llx, bi_size: %u\n", bi_sector, bi_size);
-					printk("BUGG: this_step_blocks: %u\n", this_step_blocks);
-					BUG();
-				}*/
 				bi_size -= this_step_blocks << (SECTOR_SHIFT + ic->sb->log2_sectors_per_block);
-				bi_sector += this_step_blocks << ic->sb->log2_sectors_per_block;
 			}
 
 			if (likely(checksums != checksums_onstack))
-- 
2.20.1.7.g153144c

