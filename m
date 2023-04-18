Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB586E5964
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjDRGZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDRGZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:25:20 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE50C119
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:25:18 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E48BC5FD61;
        Tue, 18 Apr 2023 09:25:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681799115;
        bh=NmVhwWOMVBSjx7NTACx4GB75SU5JQuvCsHOYaqd9NSk=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=jTbfDR0vCa8wixwiTa1ZFpFkcYWqDSz7h34TOHXoCMYZDLuRKplSEvBhjoRu8Bp2X
         a88zG+i0WWVmtaixqMqIxvxWdHXS1T2J8Z6dHypHepW+44ytxQU9BNZtP2TsYtFrez
         mOyGV4lU52paulufz9uU3v22khFsroHTNkP3pTB/fvVHgqtPSm6pDm/sqbdEQLc7B5
         FO9Y4d+YSDdd77SSg3fWoQr1VVQ2ORAly4jBUyRTMJvmBFvu/+HKBmq09CFFPPUz4I
         UJVFTGtMNWoQrCPNHGZ1W2feWtVHUtlINJxygGgn78j4caTZZBXFF9ewYNpTjvUyc2
         xlkq5twUOFAuw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 18 Apr 2023 09:25:15 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [RFC PATCH v1 5/5] zram: add pages_folded to stats
Date:   Tue, 18 Apr 2023 09:25:03 +0300
Message-ID: <20230418062503.62121-6-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230418062503.62121-1-avromanov@sberdevices.ru>
References: <20230418062503.62121-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/18 02:02:00 #21122658
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This counter show how many objects folded into single one
at the zsmalloc allocator level.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 Documentation/admin-guide/blockdev/zram.rst | 2 ++
 drivers/block/zram/zram_drv.c               | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index e4551579cb12..349f13a2d310 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -209,6 +209,7 @@ compact           	WO	trigger memory compaction
 debug_stat        	RO	this file is used for zram debugging purposes
 backing_dev	  	RW	set up backend storage for zram to write out
 idle		  	WO	mark allocated slot as idle
+fold			WO	trigger memory folding
 ======================  ======  ===============================================
 
 
@@ -267,6 +268,7 @@ line of text and contains the following stats separated by whitespace:
  pages_compacted  the number of pages freed during compaction
  huge_pages	  the number of incompressible pages
  huge_pages_since the number of incompressible pages since zram set up
+ pages_folded     the number of pages freed during folding
  ================ =============================================================
 
 File /sys/block/zram<id>/bd_stat
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 06a614d1643d..3012b297ade5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1242,7 +1242,7 @@ static ssize_t mm_stat_show(struct device *dev,
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
 	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
+			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu %8lu\n",
 			orig_size << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.compr_data_size),
 			mem_used << PAGE_SHIFT,
@@ -1251,7 +1251,8 @@ static ssize_t mm_stat_show(struct device *dev,
 			(u64)atomic64_read(&zram->stats.same_pages),
 			atomic_long_read(&pool_stats.pages_compacted),
 			(u64)atomic64_read(&zram->stats.huge_pages),
-			(u64)atomic64_read(&zram->stats.huge_pages_since));
+			(u64)atomic64_read(&zram->stats.huge_pages_since),
+			atomic_long_read(&pool_stats.pages_folded));
 	up_read(&zram->init_lock);
 
 	return ret;
-- 
2.38.1

