Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC26627524
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbiKNEDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiKNEC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:02:58 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8408012D3D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:02:57 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m6so9942728pfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZVouTJdT6m/9WEf41/GvLl8YStUJpgeqkaMfyjFk98=;
        b=bPhj18ns1d9UqFc4xmE6cjMX7LPa5LT1Hs30thmFJRKAZ2UZU4MVVJU3qTa3O+g93+
         T50wxxrdI2E77j4L26SXMiuGz6X5hbZvhKxq6vctBd/7aWw5tV1Z5dL862gA6LY/D3Gy
         GivwAD995KjW4xNlyqwcyKFrZU9dKwrb+FIao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZVouTJdT6m/9WEf41/GvLl8YStUJpgeqkaMfyjFk98=;
        b=a5Ebdo/Z1InHTlva9bcLw0b3n61kgnd8jKxLXRX5A/bljvGwTafs1GLFOvaoHYccf9
         DgkvfhAJmnXLdpydd96lzadQYYt2VhWx78vrERYQZ1Td0GtP7D9Dm6GmEn5gntRPQnoH
         M/S7ItCIMKnomVYCaPJrDgzpf+BdneH4GCfqLUpqgT6c4YUmJDXnP2ajFv8qMEwJ9D21
         1h4VJL7zLdhJiNucyMUw3WKQarlffmYBNJiph31EvHhkhr7cTFLw4d+U2HHqnL68usZe
         Jv3AWU25zcPPEv4FvrWA854y5CRh2CNlNB4C4pTUF/eHa97Y8sAURm3J1/oMYkPRtNm7
         W58g==
X-Gm-Message-State: ANoB5pnqchXgV3DAstkQJqZ7UEkU4tnZvNV5qU4WxRUXEpnXuXGIBfsB
        Ol/HTrkOmQ/SNzvtuyHCCmSjjQ==
X-Google-Smtp-Source: AA0mqf7dHYQAXiJUo77CJ3XYezvkEz26h0Kg4ieqiv54LqBBcz84X6DKscefko4d01n0uAd/dzDWoQ==
X-Received: by 2002:a63:4e13:0:b0:46f:c465:5848 with SMTP id c19-20020a634e13000000b0046fc4655848mr10330801pgb.148.1668398577047;
        Sun, 13 Nov 2022 20:02:57 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:68f5:86c0:dcaa:df5])
        by smtp.gmail.com with ESMTPSA id t184-20020a625fc1000000b00562ef28aac6sm5476625pfb.185.2022.11.13.20.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 20:02:56 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:02:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     yang.yang29@zte.com.cn
Cc:     Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] zram: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <Y3G9649G6j99N/F2@google.com>
References: <202211141141400847357@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211141141400847357@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/14 11:41), yang.yang29@zte.com.cn wrote:
[..]
>  static ssize_t max_comp_streams_store(struct device *dev,
> @@ -1191,8 +1191,7 @@ static ssize_t io_stat_show(struct device *dev,
>  	ssize_t ret;
> 
>  	down_read(&zram->init_lock);
> -	ret = scnprintf(buf, PAGE_SIZE,
> -			"%8llu %8llu %8llu %8llu\n",
> +	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8llu\n",
>  			(u64)atomic64_read(&zram->stats.failed_reads),
>  			(u64)atomic64_read(&zram->stats.failed_writes),
>  			(u64)atomic64_read(&zram->stats.invalid_io),

sysfs_emit() params need to be realigned to match (.

> @@ -1222,8 +1221,7 @@ static ssize_t mm_stat_show(struct device *dev,
>  	orig_size = atomic64_read(&zram->stats.pages_stored);
>  	max_used = atomic_long_read(&zram->stats.max_used_pages);
> 
> -	ret = scnprintf(buf, PAGE_SIZE,
> -			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
> +	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
>  			orig_size << PAGE_SHIFT,
>  			(u64)atomic64_read(&zram->stats.compr_data_size),
>  			mem_used << PAGE_SHIFT,

Ditto.

> @@ -1247,8 +1245,7 @@ static ssize_t bd_stat_show(struct device *dev,
>  	ssize_t ret;
> 
>  	down_read(&zram->init_lock);
> -	ret = scnprintf(buf, PAGE_SIZE,
> -		"%8llu %8llu %8llu\n",
> +	ret = sysfs_emit(buf, "%8llu %8llu %8llu\n",
>  			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
>  			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
>  			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));

Ditto.

> @@ -1266,9 +1263,7 @@ static ssize_t debug_stat_show(struct device *dev,
>  	ssize_t ret;
> 
>  	down_read(&zram->init_lock);
> -	ret = scnprintf(buf, PAGE_SIZE,
> -			"version: %d\n%8llu %8llu\n",
> -			version,
> +	ret = sysfs_emit(buf, "version: %d\n%8llu %8llu\n", version,
>  			(u64)atomic64_read(&zram->stats.writestall),
>  			(u64)atomic64_read(&zram->stats.miss_free));

Ditto.

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 01ab32f2897e..430933b73c1b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1192,10 +1192,10 @@ static ssize_t io_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8llu\n",
-			(u64)atomic64_read(&zram->stats.failed_reads),
-			(u64)atomic64_read(&zram->stats.failed_writes),
-			(u64)atomic64_read(&zram->stats.invalid_io),
-			(u64)atomic64_read(&zram->stats.notify_free));
+			 (u64)atomic64_read(&zram->stats.failed_reads),
+			 (u64)atomic64_read(&zram->stats.failed_writes),
+			 (u64)atomic64_read(&zram->stats.invalid_io),
+			 (u64)atomic64_read(&zram->stats.notify_free));
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1222,15 +1222,15 @@ static ssize_t mm_stat_show(struct device *dev,
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
 	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
-			orig_size << PAGE_SHIFT,
-			(u64)atomic64_read(&zram->stats.compr_data_size),
-			mem_used << PAGE_SHIFT,
-			zram->limit_pages << PAGE_SHIFT,
-			max_used << PAGE_SHIFT,
-			(u64)atomic64_read(&zram->stats.same_pages),
-			atomic_long_read(&pool_stats.pages_compacted),
-			(u64)atomic64_read(&zram->stats.huge_pages),
-			(u64)atomic64_read(&zram->stats.huge_pages_since));
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
@@ -1246,9 +1246,9 @@ static ssize_t bd_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = sysfs_emit(buf, "%8llu %8llu %8llu\n",
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1264,8 +1264,8 @@ static ssize_t debug_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = sysfs_emit(buf, "version: %d\n%8llu %8llu\n", version,
-			(u64)atomic64_read(&zram->stats.writestall),
-			(u64)atomic64_read(&zram->stats.miss_free));
+			 (u64)atomic64_read(&zram->stats.writestall),
+			 (u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);
 
 	return ret;
