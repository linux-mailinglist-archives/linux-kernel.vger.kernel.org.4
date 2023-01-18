Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1A670F49
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjARBCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjARBB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:01:59 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3111049946
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:52:23 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id dw9so32756804pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkttQsu9CYNbqVs+SWUxgP6kf/grlmJh2/+ItE14A1E=;
        b=Eev0f7aYKnrE4GRG70azP9o2tu74O+ZYXgQ9BucWkBQ5FM/5i2gw0n6a0ytPEDUY34
         NqCPhdY234pdbdl4KdLymrKkyHnTuyOC86MzD6DdZt33oz5vpXX+EX/zKeRe6sWnT8ce
         vxnYh7s6VkjLzd/SF89wzvvgAShJ9gBGQOGmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkttQsu9CYNbqVs+SWUxgP6kf/grlmJh2/+ItE14A1E=;
        b=0kf8Bt90TPPmcZWdhhjwTm66nDvlnuciIax6rE/ZjIHJGiHL9PI7nKE+/gqUAA2dQz
         WI7odLwN/e8/12USRMrTh3pkNaG25BV6SccgjnFxgTbY5CWQxT6BlvMIDa4A3uduF9Z0
         wE3tyc0wuPvoZvqXmVeED5zLsJU/p6Mt1dH9UqUCnKx1lRKDLcTF7GixuNu90ycuSHUk
         Tg7BF+nrNTi6yYD8itfbOBw2mwlQQ03+z68n1m1RxtZH2YFOtiFTRO+T0bMkHCNZj1Pg
         aqVN6xcUWQbsj+e3ijELdV/1oi/AdbQsa/OvuzRwT2ygv1nmfev40U9xQALjhRCqZFMN
         DN1g==
X-Gm-Message-State: AFqh2kr8JdjW65b9WJws6TbtvTt5y6mDYl/ldqivB2QTaHMTIdoqJ5mu
        N9dEnSHhvWYW1qAjgWNYh/LGaQ==
X-Google-Smtp-Source: AMrXdXsY7AyOsWXIqG+pfml6Gremcjag/qdnrV8bvDCBrr5vs4Og1jMyl/Drqe0slS2JWAsgBo6Y/A==
X-Received: by 2002:a05:6a20:6f06:b0:ad:5cde:8f05 with SMTP id gt6-20020a056a206f0600b000ad5cde8f05mr4157965pzb.37.1674003142135;
        Tue, 17 Jan 2023 16:52:22 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:10f3:73a5:7e44:adbf])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b00192f4fbdeb5sm8351461ple.102.2023.01.17.16.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:52:21 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 1/4] zsmalloc: rework zspage chain size selection
Date:   Wed, 18 Jan 2023 09:52:07 +0900
Message-Id: <20230118005210.2814763-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230118005210.2814763-1-senozhatsky@chromium.org>
References: <20230118005210.2814763-1-senozhatsky@chromium.org>
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

Computers are bad at division. We currently decide the best
zspage chain size (max number of physical pages per-zspage)
by looking at a `used percentage` value. This is not enough
as we lose precision during usage percentage calculations
For example, let's look at size class 208:

pages per zspage       wasted bytes         used%
       1                   144               96
       2                    80               99
       3                    16               99
       4                   160               99

Current algorithm will select 2 page per zspage configuration,
as it's the first one to reach 99%. However, 3 pages per zspage
waste less memory.

Change algorithm and select zspage configuration that has
lowest wasted value.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 56 +++++++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6aafacd664fc..effe10fe76e9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -802,42 +802,6 @@ static enum fullness_group fix_fullness_group(struct size_class *class,
 	return newfg;
 }
 
-/*
- * We have to decide on how many pages to link together
- * to form a zspage for each size class. This is important
- * to reduce wastage due to unusable space left at end of
- * each zspage which is given as:
- *     wastage = Zp % class_size
- *     usage = Zp - wastage
- * where Zp = zspage size = k * PAGE_SIZE where k = 1, 2, ...
- *
- * For example, for size class of 3/8 * PAGE_SIZE, we should
- * link together 3 PAGE_SIZE sized pages to form a zspage
- * since then we can perfectly fit in 8 such objects.
- */
-static int get_pages_per_zspage(int class_size)
-{
-	int i, max_usedpc = 0;
-	/* zspage order which gives maximum used size per KB */
-	int max_usedpc_order = 1;
-
-	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
-		int zspage_size;
-		int waste, usedpc;
-
-		zspage_size = i * PAGE_SIZE;
-		waste = zspage_size % class_size;
-		usedpc = (zspage_size - waste) * 100 / zspage_size;
-
-		if (usedpc > max_usedpc) {
-			max_usedpc = usedpc;
-			max_usedpc_order = i;
-		}
-	}
-
-	return max_usedpc_order;
-}
-
 static struct zspage *get_zspage(struct page *page)
 {
 	struct zspage *zspage = (struct zspage *)page_private(page);
@@ -2318,6 +2282,24 @@ static int zs_register_shrinker(struct zs_pool *pool)
 				 pool->name);
 }
 
+static int calculate_zspage_chain_size(int class_size)
+{
+	int i, min_waste = INT_MAX;
+	int chain_size = 1;
+
+	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
+		int waste;
+
+		waste = (i * PAGE_SIZE) % class_size;
+		if (waste < min_waste) {
+			min_waste = waste;
+			chain_size = i;
+		}
+	}
+
+	return chain_size;
+}
+
 /**
  * zs_create_pool - Creates an allocation pool to work from.
  * @name: pool name to be created
@@ -2362,7 +2344,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
 		if (size > ZS_MAX_ALLOC_SIZE)
 			size = ZS_MAX_ALLOC_SIZE;
-		pages_per_zspage = get_pages_per_zspage(size);
+		pages_per_zspage = calculate_zspage_chain_size(size);
 		objs_per_zspage = pages_per_zspage * PAGE_SIZE / size;
 
 		/*
-- 
2.39.0.314.g84b9a713c41-goog

