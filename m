Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FADB632C83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiKUTBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiKUTA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:00:58 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D07D14DE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:00:55 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 685F35FD0B;
        Mon, 21 Nov 2022 22:00:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669057253;
        bh=Jfq1zJpfwKhtf8+eQ9bbzdVEJsOxLM5Fr/rR0X8sckA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=OGtIXGZ7jKOqoSNcA7M17LqsyQ/Qkt1PRc57ObvW2g1SEX9WCYomuEuOup16DXXUT
         JmcwD8OAYJpi4n6EgozgbVtASIUbgVi9D3+FJW2ei+s+17iPtElguhAaeClwCPXRHh
         LR57Q/ESeRfkkLsxvsHvbnMtCRMmzIGNf3Lnqzz+LUGqf+mgCJM57jfXyF5JEtbtzZ
         xjtRTUAg84mK+0fjqblfT1rG/eZqpEiXImtn2DIifMxNzApxvU+nUy/bnhbuCWknID
         glz0VTcrFOFlJHVXehQ2KMcgfWsIij3rf6iBQYcveVUosoZxz8W7dvhWzebT+jOjLm
         JmidHT7sC2Rvg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 21 Nov 2022 22:00:53 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <ddrokosov@sberdevices.ru>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: [RFC PATCH v1 3/4] zram: add pages_merged counter to mm_stat
Date:   Mon, 21 Nov 2022 22:00:19 +0300
Message-ID: <20221121190020.66548-4-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221121190020.66548-1-avromanov@sberdevices.ru>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/21 16:41:00 #20594217
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This counter shows how many identical compressed
pages have been processed by zram so far.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 Documentation/admin-guide/blockdev/zram.rst | 2 ++
 drivers/block/zram/zram_drv.c               | 8 ++++++--
 drivers/block/zram/zram_drv.h               | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index e4551579cb12..a1dd202efca1 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -209,6 +209,7 @@ compact           	WO	trigger memory compaction
 debug_stat        	RO	this file is used for zram debugging purposes
 backing_dev	  	RW	set up backend storage for zram to write out
 idle		  	WO	mark allocated slot as idle
+merge           	WO	trigger merge identical pages
 ======================  ======  ===============================================
 
 
@@ -267,6 +268,7 @@ line of text and contains the following stats separated by whitespace:
  pages_compacted  the number of pages freed during compaction
  huge_pages	  the number of incompressible pages
  huge_pages_since the number of incompressible pages since zram set up
+ pages_merged	  the number of identical pages merged into single one
  ================ =============================================================
 
 File /sys/block/zram<id>/bd_stat
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1dae3564cabd..7a267b37e5db 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1260,7 +1260,7 @@ static ssize_t mm_stat_show(struct device *dev,
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
 	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
+			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu %8llu\n",
 			orig_size << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.compr_data_size),
 			mem_used << PAGE_SHIFT,
@@ -1269,7 +1269,8 @@ static ssize_t mm_stat_show(struct device *dev,
 			(u64)atomic64_read(&zram->stats.same_pages),
 			atomic_long_read(&pool_stats.pages_compacted),
 			(u64)atomic64_read(&zram->stats.huge_pages),
-			(u64)atomic64_read(&zram->stats.huge_pages_since));
+			(u64)atomic64_read(&zram->stats.huge_pages_since),
+			(u64)atomic64_read(&zram->stats.pages_merged));
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1473,6 +1474,7 @@ static int zram_cmp_obj_and_merge(struct zram *zram, struct hlist_head *htable,
 				rb_node->cnt++;
 			}
 
+			atomic64_inc(&zram->stats.pages_merged);
 			atomic64_sub(obj_size, &zram->stats.compr_data_size);
 			zram_set_flag(zram, index, ZRAM_MERGED);
 			zram_set_flag(zram, node->index, ZRAM_MERGED);
@@ -1657,6 +1659,8 @@ static void zram_free_page(struct zram *zram, size_t index)
 		} else {
 			mutex_unlock(&zram_rbtree_mutex);
 		}
+
+		atomic64_dec(&zram->stats.pages_merged);
 	} else {
 		zs_free(zram->mem_pool, handle);
 	}
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 4a7151c94523..2afdbf76a1aa 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -88,6 +88,7 @@ struct zram_stats {
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
 	atomic64_t writestall;		/* no. of write slow paths */
 	atomic64_t miss_free;		/* no. of missed free */
+	atomic64_t pages_merged;	/* no. of pages, which merged into single one */
 #ifdef	CONFIG_ZRAM_WRITEBACK
 	atomic64_t bd_count;		/* no. of pages in backing device */
 	atomic64_t bd_reads;		/* no. of reads from backing device */
-- 
2.25.1

