Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694E960B45D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiJXRjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiJXRjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:39:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244EA48C9B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:14:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id b5so9051237pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9VjWrNf/YPNyhVI/eZNl14XBpdcpcyeDNi5KSdPpF8=;
        b=DFrjiwdNQ/wdO9nKOl8hS0v7J4HbfNZAVkr+2ftKxzzo+O9vReSREpw1NYFHbezRKn
         eBEwBH2umkuDsdKyeiDvfWjEGRH5JhiZsjtymd15Sgevf3KIL3zwgLkmB/+KZ0YUfKiA
         Ek3WOVt4CrLCmoyFBzoDGXdqxrFsXBd1kkZJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9VjWrNf/YPNyhVI/eZNl14XBpdcpcyeDNi5KSdPpF8=;
        b=pNaYHuoO/kCS2jEbKGE4oRz5vvhRV0hs2vAErxe5wZKorvRUzmWuS2h0sqldN85Lft
         7P24Wnx/w7PAwGdg8QUReIpyOC68wXQc+SYhYRVSuHukqCAJB8m8qsq09Dk6hfGYcSqw
         wx7qNHyNikVUuD6AQMvV5hgIyBKOFuVC6Gk5CPy3gdLiVtGyU1ITwdi2O7X/jdn1O3sD
         4SPhFdrTqpuQqewidq+BOfX3cUnhIjgFVZg1hM+sbtIngKU6aRXsMUTjndfy3MWks0+m
         oF7b6xsobWEkoQTfjJE+igayx0dA2iCPLbD3BqFcRHLDPdutmEFNOLsnGRTFBgKcygwr
         wDHA==
X-Gm-Message-State: ACrzQf1ZdrOIWlAKxYlXwFk3tKdIzU5FUHrZpbRPjJM7cqIuwKySUJUt
        78taaAq+jfBLqD9tFGRmFuBk0jvzRnB7BA==
X-Google-Smtp-Source: AMsMyM4pWXeIkQZMKXeLRzJlOTVBNKHApO1SSdt9yK/brvG4rWMIRgYyvbCaOua+m9Y+zJiQ9HhkdA==
X-Received: by 2002:a63:914b:0:b0:46e:dbd5:ae15 with SMTP id l72-20020a63914b000000b0046edbd5ae15mr11048144pge.94.1666627952967;
        Mon, 24 Oct 2022 09:12:32 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5f9c:c5bc:902f:3da4])
        by smtp.gmail.com with ESMTPSA id u70-20020a627949000000b0056b8726d2d3sm5162pfc.157.2022.10.24.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:12:32 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 3/6] zram: add pool_page_order device attribute
Date:   Tue, 25 Oct 2022 01:12:10 +0900
Message-Id: <20221024161213.3221725-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221024161213.3221725-1-senozhatsky@chromium.org>
References: <20221024161213.3221725-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new sysfs knob that allows user-space to set
zsmalloc page order value on per-device basis.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 43 ++++++++++++++++++++++++++++++++++-
 drivers/block/zram/zram_drv.h |  2 ++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e3ef542f9618..517dae4ff21c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1186,6 +1186,44 @@ static ssize_t mm_stat_show(struct device *dev,
 	return ret;
 }
 
+static ssize_t pool_page_order_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	u32 val;
+	struct zram *zram = dev_to_zram(dev);
+
+	down_read(&zram->init_lock);
+	val = zram->pool_page_order;
+	up_read(&zram->init_lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t pool_page_order_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u32 val;
+
+	if (kstrtou32(buf, 10, &val))
+		return -EINVAL;
+
+	if (val < ZS_MIN_PAGE_ORDER || val > ZS_MAX_PAGE_ORDER)
+		return -EINVAL;
+
+	down_read(&zram->init_lock);
+	if (init_done(zram)) {
+		up_read(&zram->init_lock);
+		return -EINVAL;
+	}
+
+	zram->pool_page_order = val;
+	up_read(&zram->init_lock);
+
+	return len;
+}
+
 #ifdef CONFIG_ZRAM_WRITEBACK
 #define FOUR_K(x) ((x) * (1 << (PAGE_SHIFT - 12)))
 static ssize_t bd_stat_show(struct device *dev,
@@ -1254,7 +1292,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 		return false;
 
 	zram->mem_pool = zs_create_pool(zram->disk->disk_name,
-					ZS_DEFAULT_PAGE_ORDER);
+					zram->pool_page_order);
 	if (!zram->mem_pool) {
 		vfree(zram->table);
 		return false;
@@ -2176,6 +2214,7 @@ static DEVICE_ATTR_RW(writeback_limit_enable);
 static DEVICE_ATTR_RW(recomp_algorithm);
 static DEVICE_ATTR_WO(recompress);
 #endif
+static DEVICE_ATTR_RW(pool_page_order);
 
 static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_disksize.attr,
@@ -2203,6 +2242,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_recomp_algorithm.attr,
 	&dev_attr_recompress.attr,
 #endif
+	&dev_attr_pool_page_order.attr,
 	NULL,
 };
 
@@ -2240,6 +2280,7 @@ static int zram_add(void)
 		goto out_free_idr;
 	}
 
+	zram->pool_page_order = ZS_DEFAULT_PAGE_ORDER;
 	zram->disk->major = zram_major;
 	zram->disk->first_minor = device_id;
 	zram->disk->minors = 1;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 09b9ceb5dfa3..076d5b17a954 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -120,6 +120,8 @@ struct zram {
 	 */
 	u64 disksize;	/* bytes */
 	const char *comp_algs[ZRAM_MAX_ZCOMPS];
+
+	u32 pool_page_order;
 	/*
 	 * zram is claimed so open request will be failed
 	 */
-- 
2.38.0.135.g90850a2211-goog

