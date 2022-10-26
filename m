Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75B60DF94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiJZLbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiJZLae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:30:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787363AE5D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so1820456pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT/Z4fhTkuAT6uqwfGOJvQ0sBMgcsQNCZVCxP8pxlBo=;
        b=PEXB9400YJgrNIKIbuMPW5DJZ23hEezyDssKRTAzHdBfEGRoNYv61tFk5sPh9u9LZB
         UmuRibWhoyaZqjdPjwLjUsgUxDr1AZy3km0Wmbuz/mkPvzP+Egd8E9h2e6AK5sPjA6pM
         KOme3SNEaFZ4JFG5Zj/kIuo/mNuJPW0c/jWQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aT/Z4fhTkuAT6uqwfGOJvQ0sBMgcsQNCZVCxP8pxlBo=;
        b=hMox/6rzqfHeWVe6+cua+ZGLXeYl9dPi37b1C24xX9HWFQXaEQfPMwFyGg5/mEXyOM
         agavfsWxwugvrdvFnJojDIyGXFhB5QwEPoiuc3Up8aLOLW/jrljH36XOqwhUsLXTEJQj
         qJXjLQznY4KNWluuNC6goDZpc375PNTKFpooUwldquywxQrZwUDqnewYEA1bypVAUk45
         wnlQfWdC4JTdk/58pHnz8tCOIiM/Rc1veS9eWkaCG6nOkld994o8Pk0L62WVjv34y0Rl
         CyGxawsn24YlgIIsNhV9AA+84P4WAJOGgc53r5PByodngnR/X8IYEogUTYN+mg8R9/DD
         8ECw==
X-Gm-Message-State: ACrzQf2H1hmE/e7v3v9/1koS0iWzbYB9A3CWK/qR7ueeTdFuMN/Ytx+o
        477VH5jlH8YeFjozcKBoluiw6Q==
X-Google-Smtp-Source: AMsMyM65lQWcdY1GRCZiFV+e7hmD7bxw4SxJccZ6E0WPQ0NgzAs46f1Zgdpb2wZ/sRCii0KuaBJ8hg==
X-Received: by 2002:a17:90b:1d08:b0:212:de5d:e9e5 with SMTP id on8-20020a17090b1d0800b00212de5de9e5mr3704791pjb.239.1666783827887;
        Wed, 26 Oct 2022 04:30:27 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:749c:f7f5:1a8e:d0be])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b005627868e27esm2814919pfb.127.2022.10.26.04.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:30:27 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 7/9] zram: add pages_per_pool_page device attribute
Date:   Wed, 26 Oct 2022 20:29:31 +0900
Message-Id: <20221026112933.4122957-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221026112933.4122957-1-senozhatsky@chromium.org>
References: <20221026112933.4122957-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new sysfs knob that allows user-space to set
zsmalloc pages per-zspage limit value on per-device
basis.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 44 ++++++++++++++++++++++++++++++++++-
 drivers/block/zram/zram_drv.h |  2 ++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bec02f636bce..cf9d3474b80c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1180,6 +1180,45 @@ static ssize_t mm_stat_show(struct device *dev,
 	return ret;
 }
 
+static ssize_t pages_per_pool_page_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	u32 val;
+	struct zram *zram = dev_to_zram(dev);
+
+	down_read(&zram->init_lock);
+	val = zram->pages_per_pool_page;
+	up_read(&zram->init_lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t pages_per_pool_page_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u32 val;
+
+	if (kstrtou32(buf, 10, &val))
+		return -EINVAL;
+
+	if (val < ZS_MIN_PAGES_PER_ZSPAGE || val > ZS_MAX_PAGES_PER_ZSPAGE)
+		return -EINVAL;
+
+	down_read(&zram->init_lock);
+	if (init_done(zram)) {
+		up_read(&zram->init_lock);
+		return -EINVAL;
+	}
+
+	zram->pages_per_pool_page = val;
+	up_read(&zram->init_lock);
+
+	return len;
+}
+
 #ifdef CONFIG_ZRAM_WRITEBACK
 #define FOUR_K(x) ((x) * (1 << (PAGE_SHIFT - 12)))
 static ssize_t bd_stat_show(struct device *dev,
@@ -1248,7 +1287,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 		return false;
 
 	zram->mem_pool = zs_create_pool(zram->disk->disk_name,
-					ZS_DEFAULT_PAGES_PER_ZSPAGE);
+					zram->pages_per_pool_page);
 	if (!zram->mem_pool) {
 		vfree(zram->table);
 		return false;
@@ -2174,6 +2213,7 @@ static DEVICE_ATTR_RW(writeback_limit_enable);
 static DEVICE_ATTR_RW(recomp_algorithm);
 static DEVICE_ATTR_WO(recompress);
 #endif
+static DEVICE_ATTR_RW(pages_per_pool_page);
 
 static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_disksize.attr,
@@ -2201,6 +2241,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_recomp_algorithm.attr,
 	&dev_attr_recompress.attr,
 #endif
+	&dev_attr_pages_per_pool_page.attr,
 	NULL,
 };
 
@@ -2238,6 +2279,7 @@ static int zram_add(void)
 		goto out_free_idr;
 	}
 
+	zram->pages_per_pool_page = ZS_DEFAULT_PAGES_PER_ZSPAGE;
 	zram->disk->major = zram_major;
 	zram->disk->first_minor = device_id;
 	zram->disk->minors = 1;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 9d6fcfdf7aa7..bdfc9bf0bdd5 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -120,6 +120,8 @@ struct zram {
 	 */
 	u64 disksize;	/* bytes */
 	const char *comp_algs[ZRAM_MAX_ZCOMPS];
+
+	u32 pages_per_pool_page;
 	/*
 	 * Pages that compress to sizes equal or greater than this are stored
 	 * uncompressed in memory.
-- 
2.38.0.135.g90850a2211-goog

