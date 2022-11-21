Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C103632C82
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiKUTBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKUTA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:00:58 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BF9D0DE6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:00:54 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5AAED5FD0C;
        Mon, 21 Nov 2022 22:00:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669057252;
        bh=tnNz8FxhOymc0atH2o9EbaV/8E1YXEIwJHa+DOBrsk0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=I12Ib1ec30kbpfYQQCRwwiW7QAiyVT8QqxkF4X20EtrTbol1AsCOdKuU7ZBVrx+zb
         5LZJ10WNyFrLMOd+n+hzHmJrI2vxE5hjNubdX4Wb+78PKVvrEKc3uFBHhvGy7pGnUF
         Hvvt9a5tfWT0AxzFPYO6sqW5V3NUk83rVdnzCRsYVRqwrF3a7nK74UyMehvlRtBWlE
         OqYSX8Q4DrFyRFpGnWqxNLQgkfOLfMqoyYHM8ww1MCs39gbhwKA7hdFjHPio3ri86M
         eJPBa4VdeVZKFxh/M+/kDExUQ6lnKQA3YS5kIqCTFh+RyrIu7Z8JpMC8lHXCbvXYNU
         DFObnIRd8bBQQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 21 Nov 2022 22:00:52 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <ddrokosov@sberdevices.ru>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: [RFC PATCH v1 2/4] zram: add merge sysfs knob
Date:   Mon, 21 Nov 2022 22:00:18 +0300
Message-ID: <20221121190020.66548-3-avromanov@sberdevices.ru>
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

Allow zram to merge identical pages into signle one:

echo 1 > /sys/block/zramX/merge

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 drivers/block/zram/zram_drv.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 716c2f72805e..1dae3564cabd 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1197,6 +1197,30 @@ static ssize_t compact_store(struct device *dev,
 	return len;
 }
 
+static int zram_do_scan(struct zram *zram);
+
+static ssize_t merge_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	int ret;
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram)) {
+		up_read(&zram->init_lock);
+		return -EINVAL;
+	}
+
+	ret = zram_do_scan(zram);
+	if (ret != 0) {
+		up_read(&zram->init_lock);
+		return -ENOMEM;
+	}
+
+	up_read(&zram->init_lock);
+	return len;
+}
+
 static ssize_t io_stat_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -2569,6 +2593,7 @@ static const struct block_device_operations zram_devops = {
 };
 
 static DEVICE_ATTR_WO(compact);
+static DEVICE_ATTR_WO(merge);
 static DEVICE_ATTR_RW(disksize);
 static DEVICE_ATTR_RO(initstate);
 static DEVICE_ATTR_WO(reset);
@@ -2609,6 +2634,7 @@ static struct attribute *zram_disk_attrs[] = {
 #ifdef CONFIG_ZRAM_WRITEBACK
 	&dev_attr_bd_stat.attr,
 #endif
+	&dev_attr_merge.attr,
 	&dev_attr_debug_stat.attr,
 #ifdef CONFIG_ZRAM_MULTI_COMP
 	&dev_attr_recomp_algorithm.attr,
-- 
2.25.1

