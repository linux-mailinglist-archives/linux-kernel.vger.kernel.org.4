Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0C6A91C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCCHcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCCHbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:31:53 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C69E48E26
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:31:49 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s17so943759pgv.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mmQBxcW7ejWxn4u/9kaDGpuSUOVrknjbsls0Wrd7oQ=;
        b=kDqZjoYfdctRAdTqU0bk8va0TLut3cg+xNPzeKMEXmxSfnkUW0t8MPd7IZbuldVC2q
         FOlOZCbIVtUpKCU9LNrNP5wk0pFFIqdWENvaSq2cZ/4I5/vlAfa5bgI5MVDzHhkQ7D1+
         ZvuShnw/whNxLNAM78sHeZNXh9Zc2UpXJzE58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mmQBxcW7ejWxn4u/9kaDGpuSUOVrknjbsls0Wrd7oQ=;
        b=gCBoXYoUnFXtUBCGga/mB9oe0Vo6+klJN6F7W8xUoygXnpwJERW7Yzqjn++Vsfx4nO
         ztOLOi4BxXvR3+rPtd/t4hN3LVZZjWlLBd/mefJl5hvGdfSwV5J2K8A7+v8//WsDfaAP
         J1v1UTgW7pW/3wQYgTSr+6F+fCbsCNrSAOOs9oHZyP+aw2zpLL6SehWz1MczpS/nQCPc
         uqoFIj6t9HRbmej0cPm0ZJpCuVEZOZBoBhcFJzR/tsRLReS0Cckc46grM3i/DyVjKFxi
         l6+hTuZTZiYwdiKzzVihGsS2dYIT3XtH2HhJN9JDB5lVJRDPyUqRAwpkTfiOOUX3mJ+t
         275g==
X-Gm-Message-State: AO0yUKUbud1PT/TSQbTHyapBVtekasZK3VCQVIQdo1zKG2Fp7eJSI6lh
        7ZnxyVoVlqj5jqSHKIkzG0K0yA==
X-Google-Smtp-Source: AK7set95IKXsbDSABhjpYLGQU6qZ7FB8tuGqKxll1zoDEf9YglRFwASYw4TOOIRNu/lNrenPkdhAzA==
X-Received: by 2002:a62:7b45:0:b0:5a9:b4eb:d262 with SMTP id w66-20020a627b45000000b005a9b4ebd262mr1432036pfc.1.1677828708593;
        Thu, 02 Mar 2023 23:31:48 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:badf:7e3e:d3f9:4956])
        by smtp.gmail.com with ESMTPSA id c18-20020aa781d2000000b005a8b4dcd21asm933439pfn.15.2023.03.02.23.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 23:31:48 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 4/4] zsmalloc: show per fullness group class stats
Date:   Fri,  3 Mar 2023 16:31:30 +0900
Message-Id: <20230303073130.1950714-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230303073130.1950714-1-senozhatsky@chromium.org>
References: <20230303073130.1950714-1-senozhatsky@chromium.org>
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
 mm/zsmalloc.c | 50 +++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 141a3f69b642..5ee9a76b3446 100644
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
@@ -625,19 +623,19 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 	struct zs_pool *pool = s->private;
 	struct size_class *class;
 	int objs_per_zspage;
-	unsigned long class_almost_full, class_almost_empty;
 	unsigned long obj_allocated, obj_used, pages_used, freeable;
-	unsigned long total_class_almost_full = 0, total_class_almost_empty = 0;
 	unsigned long total_objs = 0, total_used_objs = 0, total_pages = 0;
 	unsigned long total_freeable = 0;
+	unsigned long inuse_totals[NR_FULLNESS_GROUPS] = {0, };
+	int fg;
 
-	seq_printf(s, " %5s %5s %11s %12s %13s %10s %10s %16s %8s\n",
-			"class", "size", "almost_full", "almost_empty",
+	seq_printf(s, " %5s %5s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %13s %10s %10s %16s %8s\n",
+			"class", "size", "10%", "20%", "30%", "40%",
+			"50%", "60%", "70%", "80%", "90%", "99%", "100%",
 			"obj_allocated", "obj_used", "pages_used",
 			"pages_per_zspage", "freeable");
 
 	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
-		int fg;
 
 		class = pool->size_class[i];
 
@@ -646,14 +644,12 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 
 		spin_lock(&pool->lock);
 
-		/*
-		 * Replecate old behaviour for almost_full and almost_empty
-		 * stats.
-		 */
-		for (fg = ZS_INUSE_RATIO_70; fg <= ZS_INUSE_RATIO_99; fg++)
-			class_almost_full = zs_stat_get(class, fg);
-		for (fg = ZS_INUSE_RATIO_10; fg < ZS_INUSE_RATIO_70; fg++)
-			class_almost_empty = zs_stat_get(class, fg);
+		seq_printf(s, " %5u %5u ", i, class->size);
+
+		for (fg = ZS_INUSE_RATIO_10; fg <= ZS_INUSE_RATIO_100; fg++) {
+			inuse_totals[fg] += zs_stat_get(class, fg);
+			seq_printf(s, "%8lu ", zs_stat_get(class, fg));
+		}
 
 		obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
 		obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
@@ -664,14 +660,10 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
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
@@ -679,10 +671,14 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 	}
 
 	seq_puts(s, "\n");
-	seq_printf(s, " %5s %5s %11lu %12lu %13lu %10lu %10lu %16s %8lu\n",
-			"Total", "", total_class_almost_full,
-			total_class_almost_empty, total_objs,
-			total_used_objs, total_pages, "", total_freeable);
+	seq_printf(s, " %5s %5s ", "Total", "");
+
+	for (fg = ZS_INUSE_RATIO_10; fg <= ZS_INUSE_RATIO_100; fg++)
+		seq_printf(s, "%8lu ", inuse_totals[fg]);
+
+	seq_printf(s, "%13lu %10lu %10lu %16s %8lu\n",
+		   total_objs, total_used_objs, total_pages, "",
+		   total_freeable);
 
 	return 0;
 }
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

