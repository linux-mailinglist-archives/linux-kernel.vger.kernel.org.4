Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7652D6A0162
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjBWDFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjBWDFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:05:11 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ACD4608A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:10 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id il18-20020a17090b165200b0023127b2d602so10605909pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiCIpL03JBPiX3r0aUEMNZiww2WahzTmtx5CHsJtG58=;
        b=FukfwasNWu2Rzz92i5So8JtB90Utw+Izt47hiVM88qDg1BDIfH+2JocdZt1RMXn+V/
         4dm6ceSVu9mc/bdHNTCeWGCNCPyvnKlp70VGAgY9rIQj+GssKAweQyHmVuNintyLSZId
         fBGzg7ROy/QxWOcEJqobjmpM/xp/ZJgkisuco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiCIpL03JBPiX3r0aUEMNZiww2WahzTmtx5CHsJtG58=;
        b=7Lyxr/U7UABOniLA0EmZhxTIiyoziUUQSku6lGsBs763jorhg4fWr1H3BD0lh4ye7/
         WQThZS3bEbGfRY4neg1g2HynFzC5/dXQUdjgqiHpVV/BdJZj9jDcYLIg0X1OfVr48N8P
         QriE6n+MkBnoBZn/KOKzMWeOtwzyYcgpCkLIGBaEen/0QhiSDrWgd9k8HNSnHl/QpB/a
         GaYcA0lXmXpsvSvuluriw0CZn5CmTlQESNvxfC4nsb1sj1bYGOEEV0YIiKiieGevqVcL
         BdvraAUkWfBuVig1Eo6KBC9dmW42+MpcAih5G4ZkxvNnMLQ08BcY24b+nIyCwrjdab/f
         merQ==
X-Gm-Message-State: AO0yUKXdMR0u3Kq4pHWPCRUeW0cyGGNL7ngTF6kFXMRtZCEhr+XczmRF
        u9YARJJTVncLY8lx8t61Cyzd9vmEEgyGLw20
X-Google-Smtp-Source: AK7set8sb4kTJVjexH2DXpQTOdukrnurX2LTxpUBToPlcF9kX7HONNbD7HTaLTBbcSMjfIIg4eb4VA==
X-Received: by 2002:a17:903:284:b0:19a:9797:1631 with SMTP id j4-20020a170903028400b0019a97971631mr10850314plr.3.1677121509605;
        Wed, 22 Feb 2023 19:05:09 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6de2:9e85:b508:57b8])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b0019926c77577sm608520plb.90.2023.02.22.19.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 19:05:09 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 4/6] zsmalloc: rework compaction algorithm
Date:   Thu, 23 Feb 2023 12:04:49 +0900
Message-Id: <20230223030451.543162-5-senozhatsky@chromium.org>
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

The zsmalloc compaction algorithm has the potential to
waste some CPU cycles, particularly when compacting pages
within the same fullness group. This is due to the way it
selects the head page of the fullness list for source and
destination pages, and how it reinserts those pages during
each iteration. The algorithm may first use a page as a
migration destination and then as a migration source,
leading to an unnecessary back-and-forth movement of
objects.

Consider the following fullness list:

PageA PageB PageC PageD PageE

During the first iteration, the compaction algorithm will
select PageA as the source and PageB as the destination.
All of PageA's objects will be moved to PageB, and then
PageA will be released while PageB is reinserted into the
fullness list.

PageB PageC PageD PageE

During the next iteration, the compaction algorithm will
again select the head of the list as the source and destination,
meaning that PageB will now serve as the source and PageC as
the destination. This will result in the objects being moved
away from PageB, the same objects that were just moved to PageB
in the previous iteration.

To prevent this avalanche effect, the compaction algorithm
should not reinsert the destination page between iterations.
By doing so, the most optimal page will continue to be used
and its usage ratio will increase, reducing internal
fragmentation. The destination page should only be reinserted
into the fullness list if:
- It becomes full
- No source page is available.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 82 ++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1a92ebe338eb..eacf9e32da5c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1786,15 +1786,14 @@ struct zs_compact_control {
 	int obj_idx;
 };
 
-static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
-				struct zs_compact_control *cc)
+static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
+			   struct zs_compact_control *cc)
 {
 	unsigned long used_obj, free_obj;
 	unsigned long handle;
 	struct page *s_page = cc->s_page;
 	struct page *d_page = cc->d_page;
 	int obj_idx = cc->obj_idx;
-	int ret = 0;
 
 	while (1) {
 		handle = find_alloced_obj(class, s_page, &obj_idx);
@@ -1807,10 +1806,8 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		}
 
 		/* Stop if there is no more space */
-		if (zspage_full(class, get_zspage(d_page))) {
-			ret = -ENOMEM;
+		if (zspage_full(class, get_zspage(d_page)))
 			break;
-		}
 
 		used_obj = handle_to_obj(handle);
 		free_obj = obj_malloc(pool, get_zspage(d_page), handle);
@@ -1823,8 +1820,6 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 	/* Remember last position in this iteration */
 	cc->s_page = s_page;
 	cc->obj_idx = obj_idx;
-
-	return ret;
 }
 
 static struct zspage *isolate_src_zspage(struct size_class *class)
@@ -2228,57 +2223,56 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	 * as well as zpage allocation/free
 	 */
 	spin_lock(&pool->lock);
-	while ((src_zspage = isolate_src_zspage(class))) {
-		/* protect someone accessing the zspage(i.e., zs_map_object) */
-		migrate_write_lock(src_zspage);
-
-		if (!zs_can_compact(class))
-			break;
-
-		cc.obj_idx = 0;
-		cc.s_page = get_first_page(src_zspage);
-
-		while ((dst_zspage = isolate_dst_zspage(class))) {
-			migrate_write_lock_nested(dst_zspage);
-
+	while (1) {
+		if (!dst_zspage) {
+			dst_zspage = isolate_dst_zspage(class);
+			if (!dst_zspage)
+				goto out;
+			migrate_write_lock(dst_zspage);
 			cc.d_page = get_first_page(dst_zspage);
-			/*
-			 * If there is no more space in dst_page, resched
-			 * and see if anyone had allocated another zspage.
-			 */
-			if (!migrate_zspage(pool, class, &cc))
-				break;
+		}
 
+		if (!zs_can_compact(class)) {
 			putback_zspage(class, dst_zspage);
 			migrate_write_unlock(dst_zspage);
-			dst_zspage = NULL;
-			if (spin_is_contended(&pool->lock))
-				break;
+			goto out;
 		}
 
-		/* Stop if we couldn't find slot */
-		if (dst_zspage == NULL)
-			break;
+		src_zspage = isolate_src_zspage(class);
+		if (!src_zspage) {
+			putback_zspage(class, dst_zspage);
+			migrate_write_unlock(dst_zspage);
+			goto out;
+		}
 
-		putback_zspage(class, dst_zspage);
-		migrate_write_unlock(dst_zspage);
+		migrate_write_lock_nested(src_zspage);
+
+		cc.obj_idx = 0;
+		cc.s_page = get_first_page(src_zspage);
+		migrate_zspage(pool, class, &cc);
 
 		if (putback_zspage(class, src_zspage) == ZS_INUSE_RATIO_0) {
 			migrate_write_unlock(src_zspage);
 			free_zspage(pool, class, src_zspage);
 			pages_freed += class->pages_per_zspage;
-		} else
+		} else {
 			migrate_write_unlock(src_zspage);
-		spin_unlock(&pool->lock);
-		cond_resched();
-		spin_lock(&pool->lock);
-	}
+		}
 
-	if (src_zspage) {
-		putback_zspage(class, src_zspage);
-		migrate_write_unlock(src_zspage);
-	}
+		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
+		    || spin_is_contended(&pool->lock)) {
+			putback_zspage(class, dst_zspage);
+			migrate_write_unlock(dst_zspage);
+			dst_zspage = NULL;
+		}
 
+		if (!dst_zspage) {
+			spin_unlock(&pool->lock);
+			cond_resched();
+			spin_lock(&pool->lock);
+		}
+	}
+out:
 	spin_unlock(&pool->lock);
 
 	return pages_freed;
-- 
2.39.2.637.g21b0678d19-goog

