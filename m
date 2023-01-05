Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C13865E523
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjAEFfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjAEFfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:35:30 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABACC37265
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 21:35:29 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w203so7936723pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 21:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHS7GwecdRuxXk3+Zc4WVXvP35qWQPtvOh3gevBpM+A=;
        b=b6rJqUBUXZ6Q+Bgt7gJ5/kTxgMlrEP1hR1HsAaFEIJOVqcYGEqzmgqaayIu44OklLY
         aKr7mCHk9NuWDdeZ/sLDjprbzjTysci4voRXkScpJ9J7O3UQJDwMi88MSEXKhAd31MRX
         IkgpaAnfci6cSUtZQFzoqH74BOPlvcbzaXSNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHS7GwecdRuxXk3+Zc4WVXvP35qWQPtvOh3gevBpM+A=;
        b=ySD4Hu3Nk5iTpym+vHItdty2npWhr6iYSH5qYbhvINfg2Kan7JKa+7YijKRrvxEiy0
         MjkbvDjnYiCoom+iGcF8ENxfrNECJNYPQ6q4SNsbymwXLgcCOz+6al+Z/AHT8eIxTh9i
         fEfh9DOMMe3h0T6FA9c/cmVrcq4rgvn6DKUL5vdEe0HJyXP6Pe7Vf9V2AWyuvTLP8D2w
         CWrZ4RbObOizS64NRRTxJiXujeeY2nV2BFhuANwJ/SubS4zpeGHyrnCSU6OSIMan+Kj3
         8bMQSUrBiJ2WY9xZZCHfvMSmpLLVU5J5PB9+f0mLhol2YmW/ow+kycEBK96WGmbVI7PT
         YngQ==
X-Gm-Message-State: AFqh2kqfJndxu3nhN5uUSxSaHrXo5x0IbWrTK+e8K5ioDdsN0qn8O4+p
        5rfV7TRrn4D3Q+dbMsAcc470Bet2QRvev+z0
X-Google-Smtp-Source: AMrXdXvCZQaKMjk2imZtfP2WyTYli30IFBbctSlFI2dnkGh9PE8CQrY3FcAiS28OhT3LjTERiI6OGw==
X-Received: by 2002:a05:6a00:84c:b0:581:1ee0:75a with SMTP id q12-20020a056a00084c00b005811ee0075amr43961009pfk.32.1672896929190;
        Wed, 04 Jan 2023 21:35:29 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:da84:4bce:bb29:7dea])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b00577c5915138sm2036855pfi.128.2023.01.04.21.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 21:35:28 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/4] zsmalloc: rework zspage chain size selection
Date:   Thu,  5 Jan 2023 14:35:07 +0900
Message-Id: <20230105053510.1819862-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230105053510.1819862-1-senozhatsky@chromium.org>
References: <20230105053510.1819862-1-senozhatsky@chromium.org>
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
---
 mm/zsmalloc.c | 56 +++++++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9445bee6b014..959126e708a3 100644
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
@@ -2321,6 +2285,24 @@ static int zs_register_shrinker(struct zs_pool *pool)
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
@@ -2365,7 +2347,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
 		if (size > ZS_MAX_ALLOC_SIZE)
 			size = ZS_MAX_ALLOC_SIZE;
-		pages_per_zspage = get_pages_per_zspage(size);
+		pages_per_zspage = calculate_zspage_chain_size(size);
 		objs_per_zspage = pages_per_zspage * PAGE_SIZE / size;
 
 		/*
-- 
2.39.0.314.g84b9a713c41-goog

