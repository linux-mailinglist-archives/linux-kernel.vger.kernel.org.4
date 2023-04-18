Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2A6E6CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjDRTOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjDRTOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:04 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E4EAF26
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:37 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id js7so10390143qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845216; x=1684437216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyoKJQkIW9YTYt09kObRpzKT5MnW6BvwQNuIxs7T4Tc=;
        b=aeYONsgPSzQQgWyb5FHu2pLc4enHXJiXdaQ/URnHTI4N+Nq62uPdJYSr8YJxsZo7DW
         gB6lifiemln0yXBoUpetZdAa+m3U7Murk1q9y6eEqAxekRgWZCiGw2kWjYInRjtT3eFT
         DkRD7r1ECPLst/vkbKvyzSRNiHJuj9OxC47RNcVmUl1WWTCQ+sn8Jx5NKLfVkdObtBW0
         S8SXnhzF5QsXyMf5O/UpkE9MPOzstc3gDLc3FhYxPAPxbgDfog2ZjfNGJa31r+oOo2GA
         REeMAyuiQFEJZ21mYaqXnYQUFwEa8R+Jwrb338SotrhcoLFx+tzMMjRnzYViLbYZJo1o
         t/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845216; x=1684437216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyoKJQkIW9YTYt09kObRpzKT5MnW6BvwQNuIxs7T4Tc=;
        b=gSxzYP80a+LKVPfxNmf+/4LwXi4BvH2v4EaT0q+vNBWgK+jt7DuqXvxGTktq+rl78A
         8mzf0E7VNMAzGZ4gYfctYHrxlU/kxy1lVaniRkSTC6vuDGXf9JYcYbKB/cRWKy/IEpHY
         53WBPhAzR9QPU6NmZycmYot5hNTVAi9kbKfiUDb3RE5spWbkm/30v0D65f9SFa6pgEXD
         Pm28fraKzJoHJYsWB9aLNHEa0lPgU9jJceJQ/RjY2C24yIB01y+jQw8c1gB2PrCWQtVr
         JGsrarAaJf8Z6ObrPeqgE2O6eus6pBZmPy8xFN3aR/hIgHXSEjP7JQlMGQbq2smwiC8z
         O+9g==
X-Gm-Message-State: AAQBX9ffRI7ST9aEfQD4Pb7qAdmlTKPmeNUtQ1tmKGQEQltc15NR3VZK
        WCsMujkOPdgUbKYXy/lIqS21LBegX80+pH/k2G8=
X-Google-Smtp-Source: AKy350awQ/PRfC/BhFkVKh85YOny0ld5DKS6bQHcNwzqu22Ols+1ZFQkDT9bbDkAlKwae5T6XGpjKg==
X-Received: by 2002:ad4:5762:0:b0:5ef:739a:1c46 with SMTP id r2-20020ad45762000000b005ef739a1c46mr16977002qvx.1.1681845216529;
        Tue, 18 Apr 2023 12:13:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id kr24-20020a0562142b9800b005eee320b5d7sm3844283qvb.63.2023.04.18.12.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:36 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 15/26] mm: compaction: simplify free block check in suitable_migration_target()
Date:   Tue, 18 Apr 2023 15:13:02 -0400
Message-Id: <20230418191313.268131-16-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free page blocks are now marked MIGRATE_FREE. Consult that directly.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a2280001eea3..b9eed0d43403 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1281,22 +1281,17 @@ static bool suitable_migration_source(struct compact_control *cc,
 static bool suitable_migration_target(struct compact_control *cc,
 							struct page *page)
 {
+	int mt = get_pageblock_migratetype(page);
+
 	/* If the page is a large free page, then disallow migration */
-	if (PageBuddy(page)) {
-		/*
-		 * We are checking page_order without zone->lock taken. But
-		 * the only small danger is that we skip a potentially suitable
-		 * pageblock, so it's not worth to check order for valid range.
-		 */
-		if (buddy_order_unsafe(page) >= pageblock_order)
-			return false;
-	}
+	if (mt == MIGRATE_FREE)
+		return false;
 
 	if (cc->ignore_block_suitable)
 		return true;
 
 	/* If the block is MIGRATE_MOVABLE or MIGRATE_CMA, allow migration */
-	if (is_migrate_movable(get_pageblock_migratetype(page)))
+	if (is_migrate_movable(mt))
 		return true;
 
 	/* Otherwise skip the block */
-- 
2.39.2

