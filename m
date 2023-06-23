Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D956773BD53
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFWRDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjFWRD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:03:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBDD26B3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:03:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b539102474so5095475ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687539807; x=1690131807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGVbdq0PfdPRT7dxn3Byv/mEeTQHM8LBcocYU/UsfW8=;
        b=L8n5f0pJhHI9pFcRr/v1kGwoAAQO+wkzpaiveuPI7CIfVCCbHlffN4OnAZrSdqt6Wl
         O3Tw7TQjUwnqtEtGlu7cUkN3xdp0d9Me00Gl5PityqAPRhUn5dm35/qAS3VNLd0naprA
         1RW5V8V4eFjPTV6xFH4H3ZnW6rfAc8vNNg77R2S0oOWM2f+o01QzvC66/YCa5T+ISwoG
         wuX3RJcFzVm+TnXRebqTbbNx65gD7LcGcfo/aH1RAn7difklmt3yMvlw22iO3qxfSsyU
         9I0fF3eUKSVkCdNpS7zuOvUkDh4H3AnsQJAn8VftQnz7GcJAjNbYb/zdx6fEsxTwNhpt
         cCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687539807; x=1690131807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGVbdq0PfdPRT7dxn3Byv/mEeTQHM8LBcocYU/UsfW8=;
        b=LT1610lp4A/hWIPxEHPBo1U0n7V7zx516m1Qww8DpUmCzFGym2Y8QfEXGBJEmwfgT7
         0Og4B7nPRNs6cXfsw2Iic2zStVfRjy4FThAVhiu8KH+V8IFFO8Ju+/qulI/7LA96Bsjc
         FxTYbwC9WZexWw7pqcQg7EfmS092vKiSJVHZh8g3Gb59Ns5n5IkB4ocnxHiD+JQUb1q7
         5MaUEdSsTnCv1i/+8fNqKdmhZw780CQPBiQ7r/kzc/gl5Ce1w0uH7h2+MjKrmRJ2ygEK
         D1FwP7vLXPApwjvCLCmUWjuCir/4tYsBQF1qQtweccqZDrahSS/AE50pGwxH2pV7Z8PW
         F2oQ==
X-Gm-Message-State: AC+VfDxPpclbZ+qxAL64XWRrHOKZry1CW6NjM1gRF4otxr1n7atKPU3E
        rpZs75bWmco+AjKMaOUI1fCGX/AbEJs=
X-Google-Smtp-Source: ACHHUZ70raWdrpthTkLoDsElBp9EGBRlvIl2vWaEdMEjbRb/VN5DSrGDKT/T20qeMIO981voBs+F5Q==
X-Received: by 2002:a17:903:1210:b0:1ae:305f:e949 with SMTP id l16-20020a170903121000b001ae305fe949mr18403825plh.6.1687539806956;
        Fri, 23 Jun 2023 10:03:26 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:48fe:dc9f:b08a:e219])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001b045c9ababsm7429654plb.264.2023.06.23.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 10:03:25 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 23 Jun 2023 10:03:23 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] zsmalloc: small compaction improvements
Message-ID: <ZJXQW/EFNC5FVjkr@google.com>
References: <20230623044016.366793-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623044016.366793-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 01:40:00PM +0900, Sergey Senozhatsky wrote:
> Hi,
> 	A tiny series that can reduce the number of
> find_alloced_obj() invocations (which perform a linear
> scan of sub-page) during compaction. Inspired by Alexey
> Romanov's findings.
> 

Both patches looks good to me.

In this chance, can we have little more cleanup after these two patches?

From 3cfd4bb0bf395e271f270ee16cb08964ff785a3a Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Fri, 23 Jun 2023 09:45:33 -0700
Subject: [PATCH] zsmalloc: remove zs_compact_control

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
2.41.0.178.g377b9f9a00-goog

