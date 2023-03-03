Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A8B6A91BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCCHbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCCHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:31:41 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75F83C7B6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:31:39 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 132so914137pgh.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJN4vQ0bDt9mp9ZIcGCUIy6xbfFhJeCXLnKUnVtISUQ=;
        b=BraWG+bYowp5bBIS+PtIYQF9Rpx33u9GNrykqtbmeWA6S6s4w1E5GxGPFXzBgM55Vb
         AHS1hwM0Iu+sWFlALS1u15V9RuJ4TL2Xg+HZKBEW6jfMKUIEJ45Z32ZfLrwkkc25i1Uw
         6xNkDv6D+iW6Zzf19xw4IgYO1f5MjYoI/q3wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJN4vQ0bDt9mp9ZIcGCUIy6xbfFhJeCXLnKUnVtISUQ=;
        b=Gvz2jID4H1qOmPaxDq4TEejP4cxBAFQgA+QpkSyYhhYq9Hga0XDqLICAI42u/danW4
         g0b+mLiXkkQsa4dI5NwikxDJ743mOQnSJ3HQbJis5zE6gpNfG7Hla38miupItp3FtQHe
         HOGPL5yjBaFgyFf3VDEvKcpX9xqt0Wf2GtZrHTLhoFQslHmBl0qoJzNnAT/0znMCMrBl
         6f2z8xc+54GOAj9yZ69EURCp6IzS6Wy0y7DvliYzl1O/lvSm9kGUwA+JiEI1wSKvaHE6
         WgcDpOUM3Zks4Iy+iDsDTkiTLLABNBs1xi8Yq0lcEQXOXrtbH4jtSzYZFG3F6QPajipt
         M+jw==
X-Gm-Message-State: AO0yUKXxoT150bsCA86HMf9B5UHtW410jIDbpBeIEpktRSxrCGTumzWH
        hcIAqfyZmMOXvkjTIWIwgewrvA==
X-Google-Smtp-Source: AK7set+MG8sg99gbwmv4ChCLIROydfYD4dg6WLUwYOTSp1GoDMJXVYpVbhjFtk4IbuYTEwXHoy1SUg==
X-Received: by 2002:aa7:9f84:0:b0:5e5:6452:223f with SMTP id z4-20020aa79f84000000b005e56452223fmr1171701pfr.8.1677828699061;
        Thu, 02 Mar 2023 23:31:39 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:badf:7e3e:d3f9:4956])
        by smtp.gmail.com with ESMTPSA id c18-20020aa781d2000000b005a8b4dcd21asm933439pfn.15.2023.03.02.23.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 23:31:38 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 1/4] zsmalloc: remove insert_zspage() ->inuse optimization
Date:   Fri,  3 Mar 2023 16:31:27 +0900
Message-Id: <20230303073130.1950714-2-senozhatsky@chromium.org>
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

This optimization has no effect. It only ensures that
when a zspage was added to its corresponding fullness
list, its "inuse" counter was higher or lower than the
"inuse" counter of the zspage at the head of the list.
The intention was to keep busy zspages at the head, so
they could be filled up and moved to the ZS_FULL
fullness group more quickly. However, this doesn't work
as the "inuse" counter of a zspage can be modified by
obj_free() but the zspage may still belong to the same
fullness list. So, fix_fullness_group() won't change
the zspage's position in relation to the head's "inuse"
counter, leading to a largely random order of zspages
within the fullness list.

For instance, consider a printout of the "inuse"
counters of the first 10 zspages in a class that holds
93 objects per zspage:

 ZS_ALMOST_EMPTY:  36  67  68  64  35  54  63  52

As we can see the zspage with the lowest "inuse" counter
is actually the head of the fullness list.

Remove this pointless "optimisation".

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3aed46ab7e6c..1cd180caff76 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -753,32 +753,19 @@ static enum fullness_group get_fullness_group(struct size_class *class,
 }
 
 /*
- * Each size class maintains various freelists and zspages are assigned
- * to one of these freelists based on the number of live objects they
- * have. This functions inserts the given zspage into the freelist
- * identified by <class, fullness_group>.
+ * This function adds the given zspage to the fullness list identified
+ * by <class, fullness_group>.
  */
 static void insert_zspage(struct size_class *class,
 				struct zspage *zspage,
 				enum fullness_group fullness)
 {
-	struct zspage *head;
-
 	class_stat_inc(class, fullness, 1);
-	head = list_first_entry_or_null(&class->fullness_list[fullness],
-					struct zspage, list);
-	/*
-	 * We want to see more ZS_FULL pages and less almost empty/full.
-	 * Put pages with higher ->inuse first.
-	 */
-	if (head && get_zspage_inuse(zspage) < get_zspage_inuse(head))
-		list_add(&zspage->list, &head->list);
-	else
-		list_add(&zspage->list, &class->fullness_list[fullness]);
+	list_add(&zspage->list, &class->fullness_list[fullness]);
 }
 
 /*
- * This function removes the given zspage from the freelist identified
+ * This function removes the given zspage from the fullness list identified
  * by <class, fullness_group>.
  */
 static void remove_zspage(struct size_class *class,
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

