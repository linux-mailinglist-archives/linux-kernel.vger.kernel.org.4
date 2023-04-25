Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BBE6EE0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjDYLGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjDYLF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:05:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70A65FDD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso6802593b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682420735; x=1685012735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+OVqkfyvyT9tLRaTTTVeLMx7p1ihu2PyK06f3NH+m4=;
        b=TvmnBK3T5BGsKLcDBxe8I1B94ng08H2tuzNDpEqZoy1+LctQIiW4WT3RZcb/tHl2on
         88ugTHoHu/LoNQs3vW+n1rhZKd/FtaELuBuuVd9rZJaB3jLXbc9nJVemoKn7pNdJPu7Z
         tyP3oAFD0+vym5HdffMKGu7KU5rXjbuZg3OIOmHOrpOLXiQYYysfM2OhZ1NIR8Q30bND
         9Vb81GryXrwM+H52qTtiRELs/L3RGJ2omGxGUOjbzntjCSK3Xs6nlbR+6Jx5RgRGdyZI
         lvvTm032rA91XCwcpNpNFMrfC2Q9p97isiUAo5q0FefmZnH99JIs+GggNcuX0YNXfn/I
         FG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420735; x=1685012735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+OVqkfyvyT9tLRaTTTVeLMx7p1ihu2PyK06f3NH+m4=;
        b=JucePTNgPflyDoXISeME0Ftfet3w98LZzkn7TfdFf7c+R8fszVdNkgtaZwHv7PQaJq
         8oVmqstOAHexCOsTh4LGvn+D3eYOtHHoyP6m5cH+GJSUWyZCLi4B6zwDNFfHIYIXHnI0
         6sKif6qP6QoFwdcEIJZluNwDbq6puHCHox/r//x+EA1R3JHS8dVJ5aMu3f0eeLdmRefX
         sfAu+R/Wcr/LqlM/oZ8tMc+xVLNZ655M7a0tR3fBs5yDj9JmxTR/WNUouAOj7Xc0N9fS
         yEgHC/wsJZeOLuTzKzp4FvWgJFH6xoVmLUS7XD6K/gnJj+dlWsYsy7/afTfqRJKgxjU4
         0ZYg==
X-Gm-Message-State: AAQBX9c4sUsRP8Q9zBJbXO9IXMz2qeu5W4+J4tmlAkt2q2l2HfvkN+I/
        05eOyzVA191u29/Jxz5WvyesGQ==
X-Google-Smtp-Source: AKy350ZbU0r0I/EfFW3YIvxct2GaWxziPDmRNWYLb0dmYuNj7cOPnbFSWn8Hszq0QOVVDQt4VGY4Vw==
X-Received: by 2002:a05:6a00:1401:b0:636:e52f:631e with SMTP id l1-20020a056a00140100b00636e52f631emr22180035pfu.1.1682420735189;
        Tue, 25 Apr 2023 04:05:35 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00158300b0063f3aac78b9sm4422169pfk.79.2023.04.25.04.05.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 04:05:34 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 3/9] maple_tree: Modify the allocation method of mtree_alloc_range/rrange()
Date:   Tue, 25 Apr 2023 19:05:05 +0800
Message-Id: <20230425110511.11680-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let mtree_alloc_range() and mtree_alloc_rrange() use mas_empty_area()
and mas_empty_area_rev() respectively for allocation to reduce code
redundancy. And after doing this, we don't need to maintain two logically
identical codes to improve maintainability.

In fact, mtree_alloc_range/rrange() has some bugs. For example, when
dealing with min equals to max (mas_empty_area/area_rev() has been fixed),
the allocation will fail.
There are still some other bugs in it, I saw it with my naked eyes, but
I didn't test it, for example:
When mtree_alloc_range()->mas_alloc()->mas_awalk(), we set mas.index = min,
mas.last = max - size. However, mas_awalk() requires mas.index = min,
mas.last = max, which may lead to allocation failures.

Right now no users are using these two functions so the bug won't trigger,
but this might trigger in the future.

Also use mas_store_gfp() instead of mas_fill_gap() as I don't see any
difference between them.

After doing this, we no longer need the three functions
mas_fill_gap(), mas_alloc(), and mas_rev_alloc().

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 45 ++++++++++++---------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index aa55c914818a0..294d4c8668323 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6362,32 +6362,20 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
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
-retry:
-	mas.offset = 0;
-	mas.index = min;
-	mas.last = max - size;
-	ret = mas_alloc(&mas, entry, size, startp);
-	if (mas_nomem(&mas, gfp))
-		goto retry;
-
+	ret = mas_empty_area(&mas, min, max, size);
+	if (!ret)
+		ret = mas_store_gfp(&mas, entry, gfp);
 	mtree_unlock(mt);
+	if (!ret)
+		*startp = mas.index;
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_range);
@@ -6398,29 +6386,20 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
+	MA_STATE(mas, mt, 0, 0);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(mt_is_reserved(entry)))
 		return -EINVAL;
 
-	if (min >= max)
-		return -EINVAL;
-
-	if (max < size - 1)
-		return -EINVAL;
-
-	if (!size)
-		return -EINVAL;
-
 	mtree_lock(mt);
-retry:
-	ret = mas_rev_alloc(&mas, min, max, entry, size, startp);
-	if (mas_nomem(&mas, gfp))
-		goto retry;
-
+	ret = mas_empty_area_rev(&mas, min, max, size);
+	if (!ret)
+		ret = mas_store_gfp(&mas, entry, gfp);
 	mtree_unlock(mt);
+	if (!ret)
+		*startp = mas.index;
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_rrange);
-- 
2.20.1

