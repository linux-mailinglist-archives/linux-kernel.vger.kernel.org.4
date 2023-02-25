Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2AA6A2975
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 13:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBYMPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 07:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYMPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 07:15:31 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBCE16322
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 04:15:28 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:4d58:64da:92bc:9ef0])
        by andre.telenet-ops.be with bizsmtp
        id RQFP2900D0sc8Fi01QFPkr; Sat, 25 Feb 2023 13:15:24 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pVtS4-00A3bM-9F;
        Sat, 25 Feb 2023 13:15:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pVtSV-00DnVN-Ac;
        Sat, 25 Feb 2023 13:15:23 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] zram: Use atomic_long_read() to read atomic_long_t
Date:   Sat, 25 Feb 2023 13:15:23 +0100
Message-Id: <20230225121523.3288544-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit:

    drivers/block/zram/zram_drv.c: In function ‘mm_stat_show’:
    drivers/block/zram/zram_drv.c:1234:23: error: passing argument 1 of ‘atomic64_read’ from incompatible pointer type [-Werror=incompatible-pointer-types]
     1234 |    (u64)atomic64_read(&pool_stats.objs_moved));
	  |                       ^~~~~~~~~~~~~~~~~~~~~~
	  |                       |
	  |                       atomic_long_t * {aka struct <anonymous> *}
    In file included from ./include/linux/atomic.h:82,
		     from ./include/linux/mm_types_task.h:13,
		     from ./include/linux/mm_types.h:5,
		     from ./include/linux/buildid.h:5,
		     from ./include/linux/module.h:14,
		     from drivers/block/zram/zram_drv.c:18:
    ./include/linux/atomic/atomic-instrumented.h:644:33: note: expected ‘const atomic64_t *’ {aka ‘const struct <anonymous> *’} but argument is of type ‘atomic_long_t *’ {aka ‘struct <anonymous> *’}
      644 | atomic64_read(const atomic64_t *v)
	  |               ~~~~~~~~~~~~~~~~~~^

Fix this by using atomic_long_read() instead.

Reported-by; noreply@ellerman.id.au
Fixes: b7d89654a988a2a4 ("zram: show zsmalloc objs_moved stat in mm_stat")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3194e9254c6f3a04..8fff358c9cbace17 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1221,7 +1221,7 @@ static ssize_t mm_stat_show(struct device *dev,
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
 	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu %8llu\n",
+			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu %8lu\n",
 			orig_size << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.compr_data_size),
 			mem_used << PAGE_SHIFT,
@@ -1231,7 +1231,7 @@ static ssize_t mm_stat_show(struct device *dev,
 			atomic_long_read(&pool_stats.pages_compacted),
 			(u64)atomic64_read(&zram->stats.huge_pages),
 			(u64)atomic64_read(&zram->stats.huge_pages_since),
-			(u64)atomic64_read(&pool_stats.objs_moved));
+			atomic_long_read(&pool_stats.objs_moved));
 	up_read(&zram->init_lock);
 
 	return ret;
-- 
2.34.1

