Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C7F73C6F2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 07:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjFXFbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 01:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjFXFbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 01:31:34 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D0326AB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:31:33 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7624af57b21so124706385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687584692; x=1690176692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWxKMGlhVIOcwxYZSkni1ma+NCE3p+LmC8CwV158uoQ=;
        b=Tkj6/aDLrxhyMZp9C0Bu7YwtXXituRwejp04Q9FvaCfS63ZOBmOGbRv0zf+BfnHFn3
         Dm3Y+hAKYvuBGfNyxiguJGE5Drz60p9JekBkkqhLQ2R6o3wYXZ5geKHjrtuZ9xwR6qDB
         5A84oWan6OPS9WS8PXeYJtB6IXqRpOLT3EcjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687584692; x=1690176692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWxKMGlhVIOcwxYZSkni1ma+NCE3p+LmC8CwV158uoQ=;
        b=F2tamE+g276Mp0qZKiCzE0g0EHGZA40c9zqmXp5CCTRJQp7OgtS7+zWAm2ejC37VOe
         5Ey7w1f4chulEf7qqwuBoWR4jJT4cyn/B1AjPxZ/aS4q5HstrX43UN5dwDYLEBexv19J
         J/rs6BTf6Wbb1pzR70mNExcoBJ2UlzCbue9KGjf+WNmSfMXY+Tu0y5yAnxClHxnPwkZ9
         tzkxjMDkXw7iUk76KtLP8VY+1l5hsX721osgVR7XaThH02AwFYvvPsJrGx5Wntey3Q9h
         qKlN4jvQCA5te9TQrVpokQzarYJbNm64o8ivi49fXMhDby6q8HY+75lKzObI7hOqLPYW
         EjPA==
X-Gm-Message-State: AC+VfDx3fYn1p6bn6ltboSjKHz63N2/emZWH4fm/xZXuV1RJTPkFJfVj
        TafERVXL+A4SZ3FRcmQQMB5gkQ==
X-Google-Smtp-Source: ACHHUZ6cpRSLnEvIdQL6C5yzq2Jz418DRJ8c8EEo6m/ckQabR2EwOmEVP4W9pYHLeacaP+WSoxKr7w==
X-Received: by 2002:a05:620a:4451:b0:763:dfe8:7be6 with SMTP id w17-20020a05620a445100b00763dfe87be6mr12050561qkp.20.1687584692322;
        Fri, 23 Jun 2023 22:31:32 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:d7fc:8a97:4a18:6a18])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a0c1000b002563e8a0225sm567069pjs.48.2023.06.23.22.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 22:31:32 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 3/3] zsmalloc: remove zs_compact_control
Date:   Sat, 24 Jun 2023 14:12:16 +0900
Message-ID: <20230624053120.643409-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230624053120.643409-1-senozhatsky@chromium.org>
References: <20230624053120.643409-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minchan Kim <minchan@kernel.org>

__zs_compact always putback src_zspage into class list after
migrate_zspage. Thus, we don't need to keep last position of
src_zspage any more. Let's remove it.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 4a84f7877669..84beadc088b8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1590,25 +1590,14 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	return find_tagged_obj(class, page, obj_idx, OBJ_ALLOCATED_TAG);
 }
 
-struct zs_compact_control {
-	/* Source spage for migration which could be a subpage of zspage */
-	struct page *s_page;
-	/* Destination page for migration which should be a first page
-	 * of zspage. */
-	struct page *d_page;
-	 /* Starting object index within @s_page which used for live object
-	  * in the subpage. */
-	int obj_idx;
-};
-
-static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
-			   struct zs_compact_control *cc)
+static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
+			   struct zspage *dst_zspage)
 {
 	unsigned long used_obj, free_obj;
 	unsigned long handle;
-	struct page *s_page = cc->s_page;
-	struct page *d_page = cc->d_page;
-	int obj_idx = cc->obj_idx;
+	int obj_idx = 0;
+	struct page *s_page = get_first_page(src_zspage);
+	struct size_class *class = pool->size_class[src_zspage->class];
 
 	while (1) {
 		handle = find_alloced_obj(class, s_page, &obj_idx);
@@ -1621,24 +1610,20 @@ static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		}
 
 		used_obj = handle_to_obj(handle);
-		free_obj = obj_malloc(pool, get_zspage(d_page), handle);
+		free_obj = obj_malloc(pool, dst_zspage, handle);
 		zs_object_copy(class, free_obj, used_obj);
 		obj_idx++;
 		record_obj(handle, free_obj);
 		obj_free(class->size, used_obj);
 
 		/* Stop if there is no more space */
-		if (zspage_full(class, get_zspage(d_page)))
+		if (zspage_full(class, dst_zspage))
 			break;
 
 		/* Stop if there are no more objects to migrate */
-		if (zspage_empty(get_zspage(s_page)))
+		if (zspage_empty(src_zspage))
 			break;
 	}
-
-	/* Remember last position in this iteration */
-	cc->s_page = s_page;
-	cc->obj_idx = obj_idx;
 }
 
 static struct zspage *isolate_src_zspage(struct size_class *class)
@@ -2013,7 +1998,6 @@ static unsigned long zs_can_compact(struct size_class *class)
 static unsigned long __zs_compact(struct zs_pool *pool,
 				  struct size_class *class)
 {
-	struct zs_compact_control cc;
 	struct zspage *src_zspage = NULL;
 	struct zspage *dst_zspage = NULL;
 	unsigned long pages_freed = 0;
@@ -2031,7 +2015,6 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			if (!dst_zspage)
 				break;
 			migrate_write_lock(dst_zspage);
-			cc.d_page = get_first_page(dst_zspage);
 		}
 
 		src_zspage = isolate_src_zspage(class);
@@ -2040,9 +2023,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 
 		migrate_write_lock_nested(src_zspage);
 
-		cc.obj_idx = 0;
-		cc.s_page = get_first_page(src_zspage);
-		migrate_zspage(pool, class, &cc);
+		migrate_zspage(pool, src_zspage, dst_zspage);
 		fg = putback_zspage(class, src_zspage);
 		migrate_write_unlock(src_zspage);
 
-- 
2.41.0.162.gfafddb0af9-goog

