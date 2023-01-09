Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01F2661CC0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjAIDjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjAIDjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:39:11 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF872BC18
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:39:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n12so7462458pjp.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 19:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJf7dha5k2JA9z4OES9HOIhzl7+lcnfFyGyI5I7+NCk=;
        b=XjU2WoqBTvgShhdfuAbe+bCsbpszVIl+NO3iYTEPFSxxWxCQmQ0Sc02kQvqBLet9LA
         78GlE/1M9AvlvigUsXRKDG2MKRXDr0Kadg8EX9IXlzjW9ZFkPPsFjLtq7PE9YrHnH0+C
         weFW+9evp3q545nBXO0snJPIvzB+qEb8Gz3qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJf7dha5k2JA9z4OES9HOIhzl7+lcnfFyGyI5I7+NCk=;
        b=m/d8XVYvKF+icUkVHte/GmiEOJNDvuPcuB13QWoIWzpYSPe++CdHVtoFlCE1shrXja
         yIBI480vMkkkZKwfspSfPpG65YInzVandUnYccrsRAnPD1t0wENh6ZuwSpfSAPkmrFr9
         GiS4RmUZ2tbYychxDQc6dZTEEpuDp15bv8NJr2dtX3tBQ44tLIe+uFHHfORwtSZb9sE1
         gJYhgi6nJ0m2Q4s49idwd1Dup68SUKonRxzD3ZMgLexdBZzuVNEvep96md7Fx4I7g2N+
         qnN3wj3o7HFcTjR9FjCjYhLx5IfHVQXzK8wdWVnCikeGJeM9YiDRwxPGIsScFz2yhKrG
         6UTA==
X-Gm-Message-State: AFqh2kr+y5tcA7qlIr0dBKRYDryPToB3SGCa1pZt21SfwNLbyzzIbCrA
        HBSEd+vaGLOS5OTat4T+qQ2q8Q==
X-Google-Smtp-Source: AMrXdXudxT6l1K3qFdscG3iOXMYQPHFdnQlKnpz72FQuGvE58k91OPIVpRStqcuSy21PbOJv/Y8mFA==
X-Received: by 2002:a17:902:b78c:b0:193:1fc5:f611 with SMTP id e12-20020a170902b78c00b001931fc5f611mr6023821pls.38.1673235550467;
        Sun, 08 Jan 2023 19:39:10 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5ec1:f8d2:ce47:7ddc])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00189529ed580sm4896685plg.60.2023.01.08.19.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:39:09 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/4] zsmalloc: rework zspage chain size selection
Date:   Mon,  9 Jan 2023 12:38:35 +0900
Message-Id: <20230109033838.2779902-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109033838.2779902-1-senozhatsky@chromium.org>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
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

