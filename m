Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7914270B44E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjEVFHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEVFHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:07:22 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4103B92
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d18d772bdso4779279b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684732041; x=1687324041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryAjJK/jvO3d1/ZbH/fm/OkRmr2azDVw5I6QoB1NED8=;
        b=E+sf9AoJVl+JV6FsfkR4Ym5XfHy/qlWHgn7H3ghjaIqtwrmDk4FnwTgtCboieHks5a
         7Xju63Rz4/hQXtTjifn3Q9wRx22XGUz+pCJWITfM6TaSYKsoLU1m7GIB/8cxEfraWRhS
         8ce7qTdNdx0Rx5AX64dHcGo1GeiRMKueARhVfIFMquyHtvURi2LrwtmBx+f+ZN0H25Jn
         IR5e5SLGTGTpYPbpRZriNanszs4xQ2Sv8FTZCoWCx2LI56hrA+MREB3TjANB0qTaIm9G
         tPlFNj6QITqQQlWtPss9HM0QZsSkFNpWPI7R91rjhIRzTZw+TQz16JYxWv25eGrOJKY7
         bY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732041; x=1687324041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryAjJK/jvO3d1/ZbH/fm/OkRmr2azDVw5I6QoB1NED8=;
        b=RCIMWIQanMhBxLoFfdlRs8zUsn1UkmRFfDs118LbHTO3R9pLLEaI3m2ybO7gZmFzJa
         osF43nTUfViaV/VmIbd+BB+K9GaQM8zpRf3upgfwpZFsiZrkesD30Or0H8lZqL4ni6tp
         DCsLdqVaXhz06KzHDjH4syW8adAEPn1WyERmgWjs08aBQGQ2BEfnhwPpGvsuTOsFGcGI
         mRV+cZx+yrs6FBls0hE68PBVGR04NJuaLd2xn7j01ljtLMgAc0mbFPG3s/4ysAJdyDip
         DYQ2EVFg4xyrtU7wBYAjWEK6yRTW22Sqm864TPrvjXrsTZtaAvf3F67CO6AdrWed4xPD
         0VWQ==
X-Gm-Message-State: AC+VfDwZVtRviMV5YFnwbRC4fdc/b1T5cYoPleZE/yorgMIuH7j/qG9M
        Ky3AaDW68IKqpiRC3AMSiUJWog==
X-Google-Smtp-Source: ACHHUZ6Xjaki5a0wpYv6HPrx9PPhoRm0BZ5h3RO2p2wQiWSIZBHDnR5shbpMqf2VKAtyiIKtmnXE3Q==
X-Received: by 2002:a05:6a00:845:b0:634:7ba3:d140 with SMTP id q5-20020a056a00084500b006347ba3d140mr13038011pfk.15.1684732040942;
        Sun, 21 May 2023 22:07:20 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b0063b5776b073sm3247519pfh.117.2023.05.21.22.07.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 22:07:20 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 01/10] maple_tree: Rework mtree_alloc_{range,rrange}()
Date:   Mon, 22 May 2023 13:06:47 +0800
Message-Id: <20230522050656.96215-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mas_empty_area{_rev}() to refactor mtree_alloc_{range,rrange}()

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
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

