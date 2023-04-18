Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FC36E5962
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjDRGZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDRGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:25:18 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FE11BDA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:25:16 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 266405FD5B;
        Tue, 18 Apr 2023 09:25:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681799115;
        bh=nfgD8CjAt52uLbsRtpG0YlGKoerIw5fnKcSwfy+g/JE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Du1ijEM7jXPQlYLuCqUkwMDR9U6uHlm6GPfjO87RePxjdfiJ3HQcQMppmp9vOJMtF
         xxWMiFe5HXJ+lG5kzPeyi5gj8ZGjqGKoNtjfjzvqGESrMKLf2uhwaj4AN68AtkxZD+
         NZvOVJx1Rwgnsc/pqJ9JXd9y55I3ivJkOHeOwp03gKMw6KteyWXpcX/UoVO5D7oDsu
         DSpS8ifEQvhW3Vg5pfxkgCMeCZ9ps3vSLX/fyIEbti8oxad6yNwA3Ag6Um9OOMLOfn
         17xdFTei6ZJBk+cPmnXN/ZGWsmujHQwqIgJqlB+MRUmLSvo9dFHza6kce8z8LBEcOe
         BmtLDmjOOYRgQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 18 Apr 2023 09:25:15 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [RFC PATCH v1 4/5] zram: add fold sysfs knob
Date:   Tue, 18 Apr 2023 09:25:02 +0300
Message-ID: <20230418062503.62121-5-avromanov@sberdevices.ru>
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

Allow zram to fold identical zsmalloc objects into single one:

echo 1 > /sys/block/zramX/fold

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 drivers/block/zram/zram_drv.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e290d6d97047..06a614d1643d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1184,6 +1184,25 @@ static ssize_t compact_store(struct device *dev,
 	return len;
 }
 
+#ifdef CONFIG_ZSMALLOC_FOLD
+static ssize_t fold_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram)) {
+		up_read(&zram->init_lock);
+		return -EINVAL;
+	}
+
+	zs_fold(zram->mem_pool);
+	up_read(&zram->init_lock);
+
+	return len;
+}
+#endif
+
 static ssize_t io_stat_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -2313,6 +2332,9 @@ static DEVICE_ATTR_RW(writeback_limit_enable);
 static DEVICE_ATTR_RW(recomp_algorithm);
 static DEVICE_ATTR_WO(recompress);
 #endif
+#ifdef CONFIG_ZSMALLOC_FOLD
+static DEVICE_ATTR_WO(fold);
+#endif
 
 static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_disksize.attr,
@@ -2339,6 +2361,9 @@ static struct attribute *zram_disk_attrs[] = {
 #ifdef CONFIG_ZRAM_MULTI_COMP
 	&dev_attr_recomp_algorithm.attr,
 	&dev_attr_recompress.attr,
+#endif
+#ifdef CONFIG_ZSMALLOC_FOLD
+	&dev_attr_fold.attr,
 #endif
 	NULL,
 };
-- 
2.38.1

