Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E519B74C083
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 04:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGIC62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 22:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGIC61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 22:58:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFDCE45
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 19:58:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso14544915ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 19:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688871506; x=1691463506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvrbRcVf34QYRGEvOeb8o51NnBzvGljIM/+6H4RQmnw=;
        b=BPkvaOK838go+G1HrQkX+Mx/IWl3EGU9AzamBueyGmEcC/mlSfa4//V2xYwFAA+fiK
         nTURG163tncGV6yHgRR74VZHTH6SlBDQovphq34eEEMZtlCimq9fS+6s3tJmUdJr6Tmz
         CqawMCutSOUCunelVTVmJJKLy8XgSPG9MCKjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871506; x=1691463506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvrbRcVf34QYRGEvOeb8o51NnBzvGljIM/+6H4RQmnw=;
        b=bxiUFg22LsPt9eQNcHA2FR9mCukTw0EHlulTlaUM0brhpX6Eh80DOq/xX1G2Ajkzcp
         haXh68nrHANOR44IFrJY7JS6Q3pdhEeF/T5vLlboqLY2wx6m2RB7nMTxX/or04siSFnM
         HjR6p1QHZnPOgD8sZVwAxq9yD5pLl3V0ETbOSQUvu/0OcsyclaLUzxmyP0x5rrB6GXDN
         0IS7uek4R7bUT+AFuDiTAj1myseqJxUhi5o5BW3ymZizeH23cb9yMLbcJBr8ZY3zaFY+
         a+lxedxzzpK9N9Ef5iaPv0ARYFLmIoqqzxy3uBGMLytXFJ7bi+9ukt4qW7O1QB5YI8zh
         MQkQ==
X-Gm-Message-State: ABy/qLYLgpnUfOJXnqGYBJdZWmumBNhYqHua8HGdZuqvvu6s67ifZhVL
        f48yZvTgMGZ8y7fvA3b/SYCSGA==
X-Google-Smtp-Source: APBJJlEbpU/NZCFkTgjjdaIt5zrIa2eMKgYl6thtBD0RkTksPKzcNAdlx+T295cYcg2D75rapKC4og==
X-Received: by 2002:a17:902:b713:b0:1b8:903d:8dd0 with SMTP id d19-20020a170902b71300b001b8903d8dd0mr8567304pls.32.1688871505848;
        Sat, 08 Jul 2023 19:58:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:42f3:1eb:4d14:e45a])
        by smtp.gmail.com with ESMTPSA id m21-20020a170902bb9500b001b864add154sm5545981pls.154.2023.07.08.19.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:58:25 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zsmalloc: remove obj_tagged()
Date:   Sun,  9 Jul 2023 11:56:26 +0900
Message-ID: <20230709025817.3842416-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

obj_tagged() is not needed at this point, because objects can
only have one tag: OBJ_ALLOCATED_TAG. We needed obj_tagged()
for the zsmalloc LRU implementation, which has now been
removed. Simplify zsmalloc code and revert to the previous
implementation that was in place before the zsmalloc LRU series.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 84beadc088b8..32f5bc4074df 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -795,8 +795,8 @@ static unsigned long handle_to_obj(unsigned long handle)
 	return *(unsigned long *)handle;
 }
 
-static bool obj_tagged(struct page *page, void *obj, unsigned long *phandle,
-		int tag)
+static inline bool obj_allocated(struct page *page, void *obj,
+				 unsigned long *phandle)
 {
 	unsigned long handle;
 	struct zspage *zspage = get_zspage(page);
@@ -807,7 +807,7 @@ static bool obj_tagged(struct page *page, void *obj, unsigned long *phandle,
 	} else
 		handle = *(unsigned long *)obj;
 
-	if (!(handle & tag))
+	if (!(handle & OBJ_ALLOCATED_TAG))
 		return false;
 
 	/* Clear all tags before returning the handle */
@@ -815,11 +815,6 @@ static bool obj_tagged(struct page *page, void *obj, unsigned long *phandle,
 	return true;
 }
 
-static inline bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
-{
-	return obj_tagged(page, obj, phandle, OBJ_ALLOCATED_TAG);
-}
-
 static void reset_page(struct page *page)
 {
 	__ClearPageMovable(page);
@@ -1551,11 +1546,11 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 }
 
 /*
- * Find object with a certain tag in zspage from index object and
+ * Find alloced object in zspage from index object and
  * return handle.
  */
-static unsigned long find_tagged_obj(struct size_class *class,
-					struct page *page, int *obj_idx, int tag)
+static unsigned long find_alloced_obj(struct size_class *class,
+				      struct page *page, int *obj_idx)
 {
 	unsigned int offset;
 	int index = *obj_idx;
@@ -1566,7 +1561,7 @@ static unsigned long find_tagged_obj(struct size_class *class,
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
-		if (obj_tagged(page, addr + offset, &handle, tag))
+		if (obj_allocated(page, addr + offset, &handle))
 			break;
 
 		offset += class->size;
@@ -1580,16 +1575,6 @@ static unsigned long find_tagged_obj(struct size_class *class,
 	return handle;
 }
 
-/*
- * Find alloced object in zspage from index object and
- * return handle.
- */
-static unsigned long find_alloced_obj(struct size_class *class,
-					struct page *page, int *obj_idx)
-{
-	return find_tagged_obj(class, page, obj_idx, OBJ_ALLOCATED_TAG);
-}
-
 static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 			   struct zspage *dst_zspage)
 {
-- 
2.41.0.255.g8b1d071c50-goog

