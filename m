Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1168A6A0164
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjBWDFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjBWDFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:05:31 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B621248E01
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id ky4so12450915plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvL3mMUiF6TzdAKKcnyDSGCQ6fTbHMRv58umlvVWhug=;
        b=To5SpBeXwNb1lYh6OtMcdA7YXbEuqfheT/FB+PL18Ki7W7SwW3kIj63xK421vOkft8
         /Pk58+kjibDmqthKvSgleL1UrM3fGkIT+Ishh6Lj7spySCW5r10AOqyEFNCPUqfajtN/
         z+lLB16S5+B2UtABxWkJ1FFeWDsRq0a98+46w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvL3mMUiF6TzdAKKcnyDSGCQ6fTbHMRv58umlvVWhug=;
        b=HTPdOvUGisF+NKnVrMv57s8X5ViIevfjuME0u0YSgK2nIs89OHb0eDyQdfek73y6dY
         eXlPagG6LgGXji84K6uj1QJdYK8J6/2wma/B6C6SzxbPm9YpsaeX4X6hxbRiauR48im9
         XmZ1ngR5ipyiEkW8ZSgld0RHrJKOkotIcN8HtkBd/2+PkP8AB8ieWxpeWlsfSQuAFmJC
         M60lZKqvaQHRc6kGbR/agCJqxkOH5mlqTC8kS8Wkc4GhXzHkuD8Z73BC81qysVJrM4Sg
         Ri6fkNk305PmWPOSGzUhamSENrRjk+x+QjVPDJALvUB08Y5qrYhJSUptLIdC3FNydXr0
         lXrQ==
X-Gm-Message-State: AO0yUKWJKL5fYLXfb2eYggMpat5pEhlp09ufPsKBMtY6rQkDVvuZZT5Q
        y8JxsYBzOIyKS0rD58BJOtCVWQ==
X-Google-Smtp-Source: AK7set9GwcRpldktMmwsyDxV1U87D3miMVOwqhHkQYQzpgN7J9gWBZIAlMDN1gc6G/18tFmaOpi/mw==
X-Received: by 2002:a17:90b:4a4d:b0:233:9fff:888e with SMTP id lb13-20020a17090b4a4d00b002339fff888emr11273419pjb.39.1677121514958;
        Wed, 22 Feb 2023 19:05:14 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6de2:9e85:b508:57b8])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b0019926c77577sm608520plb.90.2023.02.22.19.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 19:05:14 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 6/6] zram: show zsmalloc objs_moved stat in mm_stat
Date:   Thu, 23 Feb 2023 12:04:51 +0900
Message-Id: <20230223030451.543162-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230223030451.543162-1-senozhatsky@chromium.org>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend zram mm_show with new objs_moved zs_pool_stats.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 1 +
 drivers/block/zram/zram_drv.c               | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index e4551579cb12..699cdbf27e37 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -267,6 +267,7 @@ line of text and contains the following stats separated by whitespace:
  pages_compacted  the number of pages freed during compaction
  huge_pages	  the number of incompressible pages
  huge_pages_since the number of incompressible pages since zram set up
+ objs_moved       The number of objects moved during pool compaction
  ================ =============================================================
 
 File /sys/block/zram<id>/bd_stat
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aa490da3cef2..3194e9254c6f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1221,7 +1221,7 @@ static ssize_t mm_stat_show(struct device *dev,
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
 	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
+			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu %8llu\n",
 			orig_size << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.compr_data_size),
 			mem_used << PAGE_SHIFT,
@@ -1230,7 +1230,8 @@ static ssize_t mm_stat_show(struct device *dev,
 			(u64)atomic64_read(&zram->stats.same_pages),
 			atomic_long_read(&pool_stats.pages_compacted),
 			(u64)atomic64_read(&zram->stats.huge_pages),
-			(u64)atomic64_read(&zram->stats.huge_pages_since));
+			(u64)atomic64_read(&zram->stats.huge_pages_since),
+			(u64)atomic64_read(&pool_stats.objs_moved));
 	up_read(&zram->init_lock);
 
 	return ret;
-- 
2.39.2.637.g21b0678d19-goog

