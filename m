Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C960EF03
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiJ0E1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiJ0E1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:27:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D15A62A88
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d24so230682pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT/Z4fhTkuAT6uqwfGOJvQ0sBMgcsQNCZVCxP8pxlBo=;
        b=N5K33E3z8EtL3Icy53kN5Y/g5Ea0lQ1Ab6ops7aLBNIS+jXKsvuIKf7pl/StQO4Sxi
         Tk2eabTStj0K/nNq7wkf19HB2NKmemzwv5wsGWC77OPM6noiXJ2I+dHJ0KiOK1Gup9o3
         5Gc4eP30PwzFxV3FVrn9FP0Y+2Rz5+04mAQvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aT/Z4fhTkuAT6uqwfGOJvQ0sBMgcsQNCZVCxP8pxlBo=;
        b=lPJdz6nuoIOe0QsxhcsYHYxOEEauGFoxV+S8SYeVu3R/3oczUZ70dh0siX916VyMUH
         6Nw9Ab8Dz/ueymXNbiCo8XOYFuZrX5PAFW+SFpBNEG69TuZLTIKfEDIT7BUFzq8nLBmz
         2AYP+pinwCuTBNkved8ACMUVzlNOVSI584WrSKIQfGY41DzZAyU1cNFr38Wj/cVwFP2n
         Aans19tPNaksjRxuGF/tdrFkf6a9NqTJ66CsrfLF8I8SVN9zCw9vHrCm2Tqyk3zXU3b6
         t9sqG/YDFyUXjgEl+Xaf1K2f/CC+Kb/FJ5MeIWRzK0PWMukSxdVxz/fR1dTeYSiqCJ0V
         UjQQ==
X-Gm-Message-State: ACrzQf126mjC5VpKyO7etHtYgXCmoRT5fhLRfoxCcBjtCQzKt2zgVx8Y
        Dg10TP0SXxTjftNkiABQ7Q2tCQ==
X-Google-Smtp-Source: AMsMyM64mQZiimWa8RxiZWxhQFGP3BD4EABEcOR3b5zGX9WlpvKLw+7QLjmGphKnAgGT50SjeoSrWw==
X-Received: by 2002:a17:90b:1950:b0:212:de19:b3ce with SMTP id nk16-20020a17090b195000b00212de19b3cemr7807059pjb.16.1666844833835;
        Wed, 26 Oct 2022 21:27:13 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:30f2:4501:65fa:df12])
        by smtp.gmail.com with ESMTPSA id w23-20020aa79557000000b00565c8634e55sm203140pfq.135.2022.10.26.21.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:27:13 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 7/9] zram: add pages_per_pool_page device attribute
Date:   Thu, 27 Oct 2022 13:26:49 +0900
Message-Id: <20221027042651.234524-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027042651.234524-1-senozhatsky@chromium.org>
References: <20221027042651.234524-1-senozhatsky@chromium.org>
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

