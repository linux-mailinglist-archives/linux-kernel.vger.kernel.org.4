Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5E768B896
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBFJ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBFJ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:26:16 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445C0211A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:26:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso3132813pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 01:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EYzqDYVAUxUcl5H7L0+RBCt9aPnrJa6Jn52QssbLoc=;
        b=esixuwoW1XXvVaRSq/qeOoODQJsPCnwslpXsBr3oCxI2fa6miNpo/FU3qkmcM/DARO
         WFg52ztwqqeZFRoFvpPRhE8Nr3izanJ0gAkXqXQuZeRAGgnqBFQpM3XENYcwKFYJW5ev
         J2YKroA6WQzb4iBi3qeaWXRsDCQKVhFsZCEps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EYzqDYVAUxUcl5H7L0+RBCt9aPnrJa6Jn52QssbLoc=;
        b=QrKl4DqFlXeIQiFEh3VbrXM8nDUZhGd3Nnz5tHGVnGTdl6HMjdEjkSgaCY68Jtu+Zj
         GqOZiVpvMVpc7JauU21whu4qe67+/wgKrKeTT37infzgOoFQhX32gWOY67Gy4SDjxNx3
         nk9gHmqCt1hQUf+FR6cIyvYz/dUUFnrb9Z888tiWhsGsWNhjCj9EOHnKxSCewfDfWT93
         wcw/ORtN9E9AQ+mbPZuyXq/7FdZgUb+UELSMcEVEqMJMCpXSCloynnfTLR2Qi34su6v6
         Heh5plOpZJB5aHUb35SlWpheEBi1nrMFgOaz0L+eUNLO41Ni7/GPq0b/wVJKnk1f0Asm
         Qvtw==
X-Gm-Message-State: AO0yUKUtpKLRVSpdxHZhyOz8wNkumgm7UQLyaP66xXHYKow1cWd4SY6W
        77dVpLZNUDfh3nkYY8udbEZNiQ==
X-Google-Smtp-Source: AK7set82/lVo4oVJUvptLjyzdH+UDUdDHjKosk+NiYryQgYiSP/6kn1HcleZQIM1e6R8tYxqNtU+VA==
X-Received: by 2002:a17:90b:3b4d:b0:22c:6bb1:55a4 with SMTP id ot13-20020a17090b3b4d00b0022c6bb155a4mr20256388pjb.45.1675675574750;
        Mon, 06 Feb 2023 01:26:14 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4a1b:4fdb:174d:8f36])
        by smtp.gmail.com with ESMTPSA id ga23-20020a17090b039700b00228f45d589fsm5663008pjb.29.2023.02.06.01.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 01:26:14 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/2] zsmalloc: remove insert_zspage() ->inuse optimization
Date:   Mon,  6 Feb 2023 18:25:58 +0900
Message-Id: <20230206092559.2722946-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230206092559.2722946-1-senozhatsky@chromium.org>
References: <20230206092559.2722946-1-senozhatsky@chromium.org>
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
2.39.1.519.gcb327c4b5f-goog

