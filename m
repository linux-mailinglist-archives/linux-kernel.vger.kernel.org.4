Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930E76A015F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjBWDFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjBWDFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:05:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB77113CD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:01 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso498770pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w1cKhAAphXJ2vOUap7qolI6gnUUf7d9gByR138SJog=;
        b=CmpbZQ5mXsvkYH52sH4fUdQAKboV5mAC+PL5L2EQo9+52dN8FTsKfuwkHN31kEURgt
         zJmYtdNdQZoFlGbZMbVJxlfCAiCY1teEF6fHg9QB2ulPwRSIVYrc1aMPXJGQEnc5XvNi
         xpv0MPmkAscsnxtGgUib+qZbsAdfI51mc7cf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w1cKhAAphXJ2vOUap7qolI6gnUUf7d9gByR138SJog=;
        b=M6nc92R02u6p6MpfoEiRLFtaVIfe5kWUD35V+OVKi7KmZOqwo4tP6baWJYZuki7ZOW
         ca1PfXYbBHtxEs/Y7u5Fi7PFcq6KGWuin5K6LiawyLnomUvXIRX/k5vFuzyA/PvGFoOr
         Ls7k0qbe7q6VXFOnQBVO8MPOKkGBUoJTFjN6rPkjrUyb1EbaFVLVESyygtUQR1WDY6bZ
         b8Aj/Z5HuACQT2IN+NYuo99LjsxAftI9Arult8McPOv9WJFhZtWGYl1Qji22jGqdgc4L
         cgXKqBJQVLcD3U4Luk6krvF8dwmT3Aj3rlOURcoS2VsTFSy9X/u70L+1Cg3WofN6lcSD
         s6bA==
X-Gm-Message-State: AO0yUKXuJpwyw8Yol5v0IbVKqDmY16xxHmagLBVfmorHfGuHfb8Ay+e0
        kwdxlG7OMV/NR+NDYFNrZoBzPA==
X-Google-Smtp-Source: AK7set/dsMOb60qr+5+6Ogrh8xQz946tMFAG3MvgpCazePEMrr3hTDtUIcO7lCYLWoHiifUoUwS7ew==
X-Received: by 2002:a17:902:7243:b0:19c:bcbc:a3dc with SMTP id c3-20020a170902724300b0019cbcbca3dcmr685857pll.25.1677121501195;
        Wed, 22 Feb 2023 19:05:01 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6de2:9e85:b508:57b8])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b0019926c77577sm608520plb.90.2023.02.22.19.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 19:05:00 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/6] zsmalloc: remove insert_zspage() ->inuse optimization
Date:   Thu, 23 Feb 2023 12:04:46 +0900
Message-Id: <20230223030451.543162-2-senozhatsky@chromium.org>
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

This optimization has no effect. It only ensures that
when a page was added to its corresponding fullness
list, its "inuse" counter was higher or lower than the
"inuse" counter of the page at the head of the list.
The intention was to keep busy pages at the head, so
they could be filled up and moved to the ZS_FULL
fullness group more quickly. However, this doesn't work
as the "inuse" counter of a page can be modified by
obj_free() but the page may still belong to the same
fullness list. So, fix_fullness_group() won't change
the page's position in relation to the head's "inuse"
counter, leading to a largely random order of pages
within the fullness list.

For instance, consider a printout of the "inuse"
counters of the first 10 pages in a class that holds
93 objects per zspage:

 ZS_ALMOST_EMPTY:  36  67  68  64  35  54  63  52

As we can see the page with the lowest "inuse" counter
is actually the head of the fullness list.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3aed46ab7e6c..b57a89ed6f30 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -753,37 +753,24 @@ static enum fullness_group get_fullness_group(struct size_class *class,
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
-				struct zspage *zspage,
-				enum fullness_group fullness)
+			  struct zspage *zspage,
+			  enum fullness_group fullness)
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
-				struct zspage *zspage,
-				enum fullness_group fullness)
+			  struct zspage *zspage,
+			  enum fullness_group fullness)
 {
 	VM_BUG_ON(list_empty(&class->fullness_list[fullness]));
 
-- 
2.39.2.637.g21b0678d19-goog

