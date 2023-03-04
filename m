Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200666AA7E5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 04:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCDDtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 22:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCDDtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:49:03 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B82E1C31A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:48:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so8082861pjg.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDa9Rt5gN+wqseziIq8dAlRWmwkEfGNI/W086ilXD04=;
        b=ma0hJFSMBbjPeOiDUGSPZH6UdO2Bu0ejhFXINdaxj+UMAC+rJPSDWse/UcI3XjdJB7
         XawTUDuCcYalqmSOEk5p0AaYQkVlIA52BdOk2CEjoo8NtEnudjtGwVlkDwdoKSwqAHFz
         nVpsbZEnKloellNxEGTwamXMjFp6+noHmgOSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDa9Rt5gN+wqseziIq8dAlRWmwkEfGNI/W086ilXD04=;
        b=jS4nx6okj8/2fVl9kQLHkkuSPjxWwePJywrDy3bPT/n+B+vV17mCHJcpdKOS6jEBzf
         8CcxGio0NacNvMS9lwmznd6ADKZgEGNF6TgeBkLt9b61huWN29BDHQH/NWzp5cszmcJb
         D9pELutA81uAwq0Q8cLerqCoMxbeBNFM2/p4XrAnmF31EfgfO4s9tm3d1j11+g7/hBbM
         bWmY9nj17F1PLX7T+XaZaEtOQrm4/mczETDeOJjDxxs4pZmxIjhOY/LE+gAPC3BwLCcB
         irCUAS/sRC4D2RWnT5pXB7ZUWIwF4hnWVzIWYsngqFvK2BcZxLuw2KAwDyj/b0jXlMaY
         36cQ==
X-Gm-Message-State: AO0yUKU4Xb46QIlnEwZVM1E167moqFI78rOVDnBm1FoDKMicnur/H04N
        Tn391TQMFsVSOg5Hgvcyu6sN8g==
X-Google-Smtp-Source: AK7set+fQINFAZ8pGr8zRqFr/P11wMfjLik9Ns7+gC6nbPtWNZv37U4HFsrWhKuOWZaethOn90CMKw==
X-Received: by 2002:a17:903:1249:b0:19a:ad90:4223 with SMTP id u9-20020a170903124900b0019aad904223mr4358621plh.48.1677901731582;
        Fri, 03 Mar 2023 19:48:51 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6ac2:6eee:5465:7ee6])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902c18600b00199025284b3sm2249204pld.151.2023.03.03.19.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 19:48:51 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 4/4] zsmalloc: show per fullness group class stats
Date:   Sat,  4 Mar 2023 12:48:35 +0900
Message-Id: <20230304034835.2082479-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230304034835.2082479-1-senozhatsky@chromium.org>
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
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

We keep the old fullness (3/4 threshold) reporting in
zs_stats_size_show(). Switch from allmost full/empty
stats to fine-grained per inuse ratio (fullness group)
reporting, which gives signicantly more data on classes
fragmentation.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 53 ++++++++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a61540afbb28..aea50e2aa350 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -172,9 +172,7 @@
 enum fullness_group {
 	ZS_INUSE_RATIO_0,
 	ZS_INUSE_RATIO_10,
-	/* NOTE: 5 more fullness groups here */
-	ZS_INUSE_RATIO_70	= 7,
-	/* NOTE: 2 more fullness groups here */
+	/* NOTE: 8 more fullness groups here */
 	ZS_INUSE_RATIO_99       = 10,
 	ZS_INUSE_RATIO_100,
 	NR_FULLNESS_GROUPS,
@@ -621,23 +619,22 @@ static unsigned long zs_can_compact(struct size_class *class);
 
 static int zs_stats_size_show(struct seq_file *s, void *v)
 {
-	int i;
+	int i, fg;
 	struct zs_pool *pool = s->private;
 	struct size_class *class;
 	int objs_per_zspage;
-	unsigned long class_almost_full, class_almost_empty;
 	unsigned long obj_allocated, obj_used, pages_used, freeable;
-	unsigned long total_class_almost_full = 0, total_class_almost_empty = 0;
 	unsigned long total_objs = 0, total_used_objs = 0, total_pages = 0;
 	unsigned long total_freeable = 0;
+	unsigned long inuse_totals[NR_FULLNESS_GROUPS] = {0, };
 
-	seq_printf(s, " %5s %5s %11s %12s %13s %10s %10s %16s %8s\n",
-			"class", "size", "almost_full", "almost_empty",
+	seq_printf(s, " %5s %5s %9s %9s %9s %9s %9s %9s %9s %9s %9s %9s %9s %13s %10s %10s %16s %8s\n",
+			"class", "size", "10%", "20%", "30%", "40%",
+			"50%", "60%", "70%", "80%", "90%", "99%", "100%",
 			"obj_allocated", "obj_used", "pages_used",
 			"pages_per_zspage", "freeable");
 
 	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
-		int fg;
 
 		class = pool->size_class[i];
 
@@ -645,16 +642,12 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 			continue;
 
 		spin_lock(&pool->lock);
-		class_almost_full = 0;
-		class_almost_empty = 0;
-		/*
-		 * Replicate old behaviour for almost_full and almost_empty
-		 * stats.
-		 */
-		for (fg = ZS_INUSE_RATIO_70; fg <= ZS_INUSE_RATIO_99; fg++)
-			class_almost_full += zs_stat_get(class, fg);
-		for (fg = ZS_INUSE_RATIO_10; fg < ZS_INUSE_RATIO_70; fg++)
-			class_almost_empty += zs_stat_get(class, fg);
+
+		seq_printf(s, " %5u %5u ", i, class->size);
+		for (fg = ZS_INUSE_RATIO_10; fg < NR_FULLNESS_GROUPS; fg++) {
+			inuse_totals[fg] += zs_stat_get(class, fg);
+			seq_printf(s, "%9lu ", zs_stat_get(class, fg));
+		}
 
 		obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
 		obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
@@ -665,14 +658,10 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		pages_used = obj_allocated / objs_per_zspage *
 				class->pages_per_zspage;
 
-		seq_printf(s, " %5u %5u %11lu %12lu %13lu"
-				" %10lu %10lu %16d %8lu\n",
-			i, class->size, class_almost_full, class_almost_empty,
-			obj_allocated, obj_used, pages_used,
-			class->pages_per_zspage, freeable);
+		seq_printf(s, "%13lu %10lu %10lu %16d %8lu\n",
+			   obj_allocated, obj_used, pages_used,
+			   class->pages_per_zspage, freeable);
 
-		total_class_almost_full += class_almost_full;
-		total_class_almost_empty += class_almost_empty;
 		total_objs += obj_allocated;
 		total_used_objs += obj_used;
 		total_pages += pages_used;
@@ -680,10 +669,14 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 	}
 
 	seq_puts(s, "\n");
-	seq_printf(s, " %5s %5s %11lu %12lu %13lu %10lu %10lu %16s %8lu\n",
-			"Total", "", total_class_almost_full,
-			total_class_almost_empty, total_objs,
-			total_used_objs, total_pages, "", total_freeable);
+	seq_printf(s, " %5s %5s ", "Total", "");
+
+	for (fg = ZS_INUSE_RATIO_10; fg < NR_FULLNESS_GROUPS; fg++)
+		seq_printf(s, "%9lu ", inuse_totals[fg]);
+
+	seq_printf(s, "%13lu %10lu %10lu %16s %8lu\n",
+		   total_objs, total_used_objs, total_pages, "",
+		   total_freeable);
 
 	return 0;
 }
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

