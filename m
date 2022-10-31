Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E17C612FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJaFmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJaFlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:41:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16DFBF60
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so14961693pji.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Nf0+I2pfgnRZzXVFRfDlyfCUhznpUvJ315tu0OUOiI=;
        b=MbpTgPIBDUbHWkS+9YopOfHoRnV74v+JNz6BX6X//rBB/LmgPIElbp4GRlLTwjJzxc
         alebDGyAW4DJc/zlleAs/HRTGa9HptGICD/6ejNkUbdmk/vWUa3Ai/OhOrukv76eLsnd
         na8Fa3d+5bCIlVErli3M7VEvFks54n/u5Xz0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Nf0+I2pfgnRZzXVFRfDlyfCUhznpUvJ315tu0OUOiI=;
        b=Lkus3TW5xKpNSOeKIyA6vTZV3z4wN1OUee6JjV/gdRXM/CT93Q/O0n3/9WuxWz2px0
         g67+yjO31HhUIiuc2tdxAjvFYAvFrDNqR3kGWyiNCtfdbHrrWVJlfoxY+pjAWfS83C8a
         t9WnE3yh4JYKDmg2RYc3wD8JuNXiHJxTvFmMvIhEhmXAe8XGvNgm3sihWd7ey/NamrPa
         kfKogAEyOnl8vrD+VAW8/6ynJiHJHVvGjcvT7Lsttk/B+HorU5ITvOikeOphOy+g7fYm
         YgDKBebRYdgpjgGYdkICUOKc+oDgKg1a1oDa6w6mqY6mFGeIzB54tPEeLN0DbDreoHuP
         6stw==
X-Gm-Message-State: ACrzQf3h47NYJRH4lXqhtri/dHj0pan/RIaQ3lQ19+Mxdxf76b4cLuJk
        ZpPKFlDIOR2H6x6mYDEiGGWZXg==
X-Google-Smtp-Source: AMsMyM6aj/ay4NFqqeS6lMD0qg9sOyjXe4OVHq+CQp3TJTjjwqL7C30ANPBoUZZhZIHNH3n4pSp/5w==
X-Received: by 2002:a17:90b:1bca:b0:213:c9ce:dad4 with SMTP id oa10-20020a17090b1bca00b00213c9cedad4mr7600860pjb.205.1667194895001;
        Sun, 30 Oct 2022 22:41:35 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7616:afe0:ba6c:96f4])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b0056befcd7958sm3573308pfj.84.2022.10.30.22.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 22:41:34 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 7/9] zram: add pages_per_pool_page device attribute
Date:   Mon, 31 Oct 2022 14:41:06 +0900
Message-Id: <20221031054108.541190-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221031054108.541190-1-senozhatsky@chromium.org>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.38.1.273.g43a17bfeac-goog

