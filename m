Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E870EBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbjEXDOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbjEXDNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:13:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9E7E42
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53eee18a192so366307a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684897996; x=1687489996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8PHSao7q3toNyfgfjr7peVeEA2aTJ4gzpmYB1pZW+w=;
        b=lvWQ23BpbzUGv8Zz9/yKEZdWIMbq0jYsYpCHZ56cKx0kJhaKWwF205CnjY3IkxCCJr
         iu3xlmzbS5NbILPOR4ghiN6amtNLE7rfOQxfT9kCTsZrrsCJzDh4sAs/ZmKS1YVHNBDV
         sQRAARUoLgmmXZFaKaL2+iGAblKqu8h4nUjiL0a/LccDoj0hZJPvCS5mDR4hdvex/u29
         abdcRkd8015H8mVC8SwPJkU6PqpbrDecMAQ2ablZP0Mo3e/MNE1M7EHu0R3BYqQ3TyfM
         6Px2inQsZ8JWLtKaWJZJE7A+4FIV92vW425mtC8QbsKsDRhq5FEi00jIUGXn7tYZyiB2
         nglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684897996; x=1687489996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8PHSao7q3toNyfgfjr7peVeEA2aTJ4gzpmYB1pZW+w=;
        b=EogaJBohmdpMPEHUZ40snyEgV3lOUb/TfIYnDRPLah4/OJppaYodbHWdg4vlV4hOXr
         lOqPyaI/Glu6LWc9JrTspPLazpjxa1t7j0ErVy3by9ldzGS1iU2Y7L/h/bAcxKErSc9/
         iH4UgKmRfDJ8oIamQO8pUZ4wVNxiFESy32ZDnnWY2XWvFmK4LBqCVkW7o1CR5NRSv7o7
         bve/cqeMCo94QmLBbnNYaB7U6BnN4my2eHvwXknF3TUn6K+hSG2XGwOl+Qkcyuf7bljj
         OGF6ukjS5ZgD2kOPY9XgI90tUUG5QdJS6sgeb2Cy3yHdK6ths2D6A6iOBdsJnYkJO8AJ
         ajHA==
X-Gm-Message-State: AC+VfDxaljauu6F9nlhurcjsWmSsFd+Urp+M5GiraEL3XRGEAvqUi6f+
        bNC4m7zxoa6g22y4nove8fx5Ug==
X-Google-Smtp-Source: ACHHUZ7j0UxgU2ZOy6gHnTDqmqwnIXVHfKLzJA1Vobgw72Vp5WdQV0HuqrWnsJiyojh+PD4OhbkqaQ==
X-Received: by 2002:a17:902:ecd0:b0:1a1:b3bb:cd5b with SMTP id a16-20020a170902ecd000b001a1b3bbcd5bmr16741760plh.62.1684897995955;
        Tue, 23 May 2023 20:13:15 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001ab061e352bsm7480769plr.195.2023.05.23.20.13.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 May 2023 20:13:15 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 01/10] maple_tree: Rework mtree_alloc_{range,rrange}()
Date:   Wed, 24 May 2023 11:12:38 +0800
Message-Id: <20230524031247.65949-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
References: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mas_empty_area{_rev}() to refactor mtree_alloc_{range,rrange}()

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 57 +++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4eb220008f72..96d102d60b4e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6493,31 +6493,33 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, min);
+	MA_STATE(mas, mt, 0, 0);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(mt_is_reserved(entry)))
 		return -EINVAL;
 
-	if (min > max)
-		return -EINVAL;
-
-	if (max < size)
-		return -EINVAL;
-
-	if (!size)
-		return -EINVAL;
-
 	mtree_lock(mt);
 retry:
-	mas.offset = 0;
-	mas.index = min;
-	mas.last = max - size + 1;
-	ret = mas_alloc(&mas, entry, size, startp);
+	ret = mas_empty_area(&mas, min, max, size);
+	if (ret)
+		goto unlock;
+
+	mas_insert(&mas, entry);
+	/*
+	 * mas_nomem() may release the lock, causing the allocated area
+	 * to be unavailable, so try to allocate a free area again.
+	 */
 	if (mas_nomem(&mas, gfp))
 		goto retry;
 
+	if (mas_is_err(&mas))
+		ret = xa_err(mas.node);
+	else
+		*startp = mas.index;
+
+unlock:
 	mtree_unlock(mt);
 	return ret;
 }
@@ -6529,28 +6531,33 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size + 1);
+	MA_STATE(mas, mt, 0, 0);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(mt_is_reserved(entry)))
 		return -EINVAL;
 
-	if (min > max)
-		return -EINVAL;
-
-	if (max < size - 1)
-		return -EINVAL;
-
-	if (!size)
-		return -EINVAL;
-
 	mtree_lock(mt);
 retry:
-	ret = mas_rev_alloc(&mas, min, max, entry, size, startp);
+	ret = mas_empty_area_rev(&mas, min, max, size);
+	if (ret)
+		goto unlock;
+
+	mas_insert(&mas, entry);
+	/*
+	 * mas_nomem() may release the lock, causing the allocated area
+	 * to be unavailable, so try to allocate a free area again.
+	 */
 	if (mas_nomem(&mas, gfp))
 		goto retry;
 
+	if (mas_is_err(&mas))
+		ret = xa_err(mas.node);
+	else
+		*startp = mas.index;
+
+unlock:
 	mtree_unlock(mt);
 	return ret;
 }
-- 
2.20.1

