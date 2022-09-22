Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90935E60E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiIVLZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiIVLZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:25:15 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C5DAE236;
        Thu, 22 Sep 2022 04:25:13 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYCZF3PMLzHpmX;
        Thu, 22 Sep 2022 19:23:01 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:25:12 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 19:25:11 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yukuai1@huaweicloud.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v3 1/5] wbt: don't show valid wbt_lat_usec in sysfs while wbt is disabled
Date:   Thu, 22 Sep 2022 19:35:54 +0800
Message-ID: <20220922113558.1085314-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922113558.1085314-1-yukuai3@huawei.com>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if wbt is initialized and then disabled by
wbt_disable_default(), sysfs will still show valid wbt_lat_usec, which
will confuse users that wbt is still enabled.

This patch shows wbt_lat_usec as zero and forbid to set it while wbt
is disabled.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reported-and-tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
---
 block/blk-sysfs.c | 9 ++++++++-
 block/blk-wbt.c   | 7 +++++++
 block/blk-wbt.h   | 5 +++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e1f009aba6fd..1955bb6a284d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -467,10 +467,14 @@ static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
 
 static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
 {
+	u64 lat;
+
 	if (!wbt_rq_qos(q))
 		return -EINVAL;
 
-	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
+	lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
+
+	return sprintf(page, "%llu\n", lat);
 }
 
 static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
@@ -493,6 +497,9 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 			return ret;
 	}
 
+	if (wbt_disabled(q))
+		return -EINVAL;
+
 	if (val == -1)
 		val = wbt_default_latency_nsec(q);
 	else if (val >= 0)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index a9982000b667..68851c2c02d2 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -422,6 +422,13 @@ static void wbt_update_limits(struct rq_wb *rwb)
 	rwb_wake_all(rwb);
 }
 
+bool wbt_disabled(struct request_queue *q)
+{
+	struct rq_qos *rqos = wbt_rq_qos(q);
+
+	return !rqos || RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT;
+}
+
 u64 wbt_get_min_lat(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 7e44eccc676d..e42465ddcbb6 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -94,6 +94,7 @@ void wbt_enable_default(struct request_queue *);
 
 u64 wbt_get_min_lat(struct request_queue *q);
 void wbt_set_min_lat(struct request_queue *q, u64 val);
+bool wbt_disabled(struct request_queue *);
 
 void wbt_set_write_cache(struct request_queue *, bool);
 
@@ -125,6 +126,10 @@ static inline u64 wbt_default_latency_nsec(struct request_queue *q)
 {
 	return 0;
 }
+static inline bool wbt_disabled(struct request_queue *q)
+{
+	return true;
+}
 
 #endif /* CONFIG_BLK_WBT */
 
-- 
2.31.1

