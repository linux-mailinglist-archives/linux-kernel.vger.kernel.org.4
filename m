Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDAE629820
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiKOMGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiKOMFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:05:51 -0500
X-Greylist: delayed 116593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 04:04:55 PST
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AE17645;
        Tue, 15 Nov 2022 04:04:55 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NBPxd6zL4z5BNRf;
        Tue, 15 Nov 2022 20:04:53 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NBPxc2PY2z501Qf;
        Tue, 15 Nov 2022 20:04:52 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl2.zte.com.cn with SMTP id 2AFC4igd026858;
        Tue, 15 Nov 2022 20:04:44 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 15 Nov 2022 20:04:47 +0800 (CST)
Date:   Tue, 15 Nov 2022 20:04:47 +0800 (CST)
X-Zmail-TransId: 2b066373805f52ffd351
X-Mailer: Zmail v1.0
Message-ID: <202211152004478289568@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <minchan@kernel.org>
Cc:     <ngupta@vflare.org>, <senozhatsky@chromium.org>, <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIHpyYW06IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AFC4igd026858
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63738065.000 by FangMail milter!
X-FangMail-Envelope: 1668513893/4NBPxd6zL4z5BNRf/63738065.000/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63738065.000/4NBPxd6zL4z5BNRf
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
---
change for v2
 - realign params of sysfs_emit().
---

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/block/zram/zram_drv.c | 61 ++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9d33801e8ba8..251a142a1f0e 100644
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
@@ -1191,12 +1191,11 @@ static ssize_t io_stat_show(struct device *dev,
 	ssize_t ret;

 	down_read(&zram->init_lock);
-	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8llu\n",
-			(u64)atomic64_read(&zram->stats.failed_reads),
-			(u64)atomic64_read(&zram->stats.failed_writes),
-			(u64)atomic64_read(&zram->stats.invalid_io),
-			(u64)atomic64_read(&zram->stats.notify_free));
+	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8llu\n",
+			 (u64)atomic64_read(&zram->stats.failed_reads),
+			 (u64)atomic64_read(&zram->stats.failed_writes),
+			 (u64)atomic64_read(&zram->stats.invalid_io),
+			 (u64)atomic64_read(&zram->stats.notify_free));
 	up_read(&zram->init_lock);

 	return ret;
@@ -1222,17 +1221,16 @@ static ssize_t mm_stat_show(struct device *dev,
 	orig_size = atomic64_read(&zram->stats.pages_stored);
 	max_used = atomic_long_read(&zram->stats.max_used_pages);

-	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
-			orig_size << PAGE_SHIFT,
-			(u64)atomic64_read(&zram->stats.compr_data_size),
-			mem_used << PAGE_SHIFT,
-			zram->limit_pages << PAGE_SHIFT,
-			max_used << PAGE_SHIFT,
-			(u64)atomic64_read(&zram->stats.same_pages),
-			atomic_long_read(&pool_stats.pages_compacted),
-			(u64)atomic64_read(&zram->stats.huge_pages),
-			(u64)atomic64_read(&zram->stats.huge_pages_since));
+	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
+			 orig_size << PAGE_SHIFT,
+			 (u64)atomic64_read(&zram->stats.compr_data_size),
+			 mem_used << PAGE_SHIFT,
+			 zram->limit_pages << PAGE_SHIFT,
+			 max_used << PAGE_SHIFT,
+			 (u64)atomic64_read(&zram->stats.same_pages),
+			 atomic_long_read(&pool_stats.pages_compacted),
+			 (u64)atomic64_read(&zram->stats.huge_pages),
+			 (u64)atomic64_read(&zram->stats.huge_pages_since));
 	up_read(&zram->init_lock);

 	return ret;
@@ -1247,11 +1245,10 @@ static ssize_t bd_stat_show(struct device *dev,
 	ssize_t ret;

 	down_read(&zram->init_lock);
-	ret = scnprintf(buf, PAGE_SIZE,
-		"%8llu %8llu %8llu\n",
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
+	ret = sysfs_emit(buf, "%8llu %8llu %8llu\n",
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
 	up_read(&zram->init_lock);

 	return ret;
@@ -1266,11 +1263,9 @@ static ssize_t debug_stat_show(struct device *dev,
 	ssize_t ret;

 	down_read(&zram->init_lock);
-	ret = scnprintf(buf, PAGE_SIZE,
-			"version: %d\n%8llu %8llu\n",
-			version,
-			(u64)atomic64_read(&zram->stats.writestall),
-			(u64)atomic64_read(&zram->stats.miss_free));
+	ret = sysfs_emit(buf, "version: %d\n%8llu %8llu\n", version,
+			 (u64)atomic64_read(&zram->stats.writestall),
+			 (u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);

 	return ret;
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
