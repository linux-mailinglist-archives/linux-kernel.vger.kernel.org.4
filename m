Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C0F62750C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiKNDl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiKNDlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:41:55 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA9DFD5;
        Sun, 13 Nov 2022 19:41:54 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N9Zqh2y7zz1DF1;
        Mon, 14 Nov 2022 11:41:52 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4N9Zqc4tQLz9vSpk;
        Mon, 14 Nov 2022 11:41:48 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4N9ZqY18v1zdmYkm;
        Mon, 14 Nov 2022 11:41:45 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N9ZqT4Xpsz4xVnZ;
        Mon, 14 Nov 2022 11:41:41 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl2.zte.com.cn with SMTP id 2AE3fcEJ087398;
        Mon, 14 Nov 2022 11:41:38 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 14 Nov 2022 11:41:40 +0800 (CST)
Date:   Mon, 14 Nov 2022 11:41:40 +0800 (CST)
X-Zmail-TransId: 2b066371b8f4ffffffff83808b3c
X-Mailer: Zmail v1.0
Message-ID: <202211141141400847357@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <minchan@kernel.org>
Cc:     <ngupta@vflare.org>, <senozhatsky@chromium.org>, <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHpyYW06IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AE3fcEJ087398
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 6371B8FF.000 by FangMail milter!
X-FangMail-Envelope: 1668397312/4N9Zqh2y7zz1DF1/6371B8FF.000/10.35.20.121/[10.35.20.121]/mxde.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6371B8FF.000/4N9Zqh2y7zz1DF1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/block/zram/zram_drv.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 171eccc2249d..67aeb668f623 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -255,7 +255,7 @@ static ssize_t initstate_show(struct device *dev,
 	val = init_done(zram);
 	up_read(&zram->init_lock);

-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }

 static ssize_t disksize_show(struct device *dev,
@@ -263,7 +263,7 @@ static ssize_t disksize_show(struct device *dev,
 {
 	struct zram *zram = dev_to_zram(dev);

-	return scnprintf(buf, PAGE_SIZE, "%llu\n", zram->disksize);
+	return sysfs_emit(buf, "%llu\n", zram->disksize);
 }

 static ssize_t mem_limit_store(struct device *dev,
@@ -404,7 +404,7 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }

 static ssize_t writeback_limit_store(struct device *dev,
@@ -439,7 +439,7 @@ static ssize_t writeback_limit_show(struct device *dev,
 	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);

-	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
+	return sysfs_emit(buf, "%llu\n", val);
 }

 static void reset_bdev(struct zram *zram)
@@ -1020,7 +1020,7 @@ static void zram_debugfs_unregister(struct zram *zram) {};
 static ssize_t max_comp_streams_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", num_online_cpus());
+	return sysfs_emit(buf, "%d\n", num_online_cpus());
 }

 static ssize_t max_comp_streams_store(struct device *dev,
@@ -1191,8 +1191,7 @@ static ssize_t io_stat_show(struct device *dev,
 	ssize_t ret;

 	down_read(&zram->init_lock);
-	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8llu\n",
+	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8llu\n",
 			(u64)atomic64_read(&zram->stats.failed_reads),
 			(u64)atomic64_read(&zram->stats.failed_writes),
 			(u64)atomic64_read(&zram->stats.invalid_io),
@@ -1222,8 +1221,7 @@ static ssize_t mm_stat_show(struct device *dev,
 	orig_size = atomic64_read(&zram->stats.pages_stored);
 	max_used = atomic_long_read(&zram->stats.max_used_pages);

-	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
+	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
 			orig_size << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.compr_data_size),
 			mem_used << PAGE_SHIFT,
@@ -1247,8 +1245,7 @@ static ssize_t bd_stat_show(struct device *dev,
 	ssize_t ret;

 	down_read(&zram->init_lock);
-	ret = scnprintf(buf, PAGE_SIZE,
-		"%8llu %8llu %8llu\n",
+	ret = sysfs_emit(buf, "%8llu %8llu %8llu\n",
 			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
 			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
 			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
@@ -1266,9 +1263,7 @@ static ssize_t debug_stat_show(struct device *dev,
 	ssize_t ret;

 	down_read(&zram->init_lock);
-	ret = scnprintf(buf, PAGE_SIZE,
-			"version: %d\n%8llu %8llu\n",
-			version,
+	ret = sysfs_emit(buf, "version: %d\n%8llu %8llu\n", version,
 			(u64)atomic64_read(&zram->stats.writestall),
 			(u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);
@@ -2504,7 +2499,7 @@ static ssize_t hot_add_show(struct class *class,

 	if (ret < 0)
 		return ret;
-	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }
 static struct class_attribute class_attr_hot_add =
 	__ATTR(hot_add, 0400, hot_add_show, NULL);
-- 
2.15.2
