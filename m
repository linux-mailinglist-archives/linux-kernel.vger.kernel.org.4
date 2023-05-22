Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8243070B455
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjEVFIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjEVFHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:07:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF050A1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d2da69fdfso3786458b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684732050; x=1687324050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT/SFNbyjqRQKVOJvWMUTBqOO8oBgaqMrnpmlnOChNs=;
        b=EKjJchlGDXRmxJY8egKTtCPHJW2FBKY8xN7qIIKeMpGB4j4yfs4iePqfPdOGDGS203
         IQjvd34wUy4iqm1NNQJMsANpzDUtvuiVQo71ID6Ql5b/ZD31hFk8zHJpgjT9hmu5H5CG
         W8AKwWnNxPTTL+axxU+uEI/qffJlMjhfvrBTBD4nxKkPe9Lqh0j9uCLHAV37edea/+S6
         c/7Hxz7fmZF9O9S2PREteryTTvvviwB/5gf/KOkvxJ/j1jRMaiNomC+EdpaWZVIcIXEF
         ezrPNKmy3LltEsCoP28TpF/5IGnfNZZB7VItCs35pXc12CfQgdA9uAdfhOYdExojYMPD
         ahkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732050; x=1687324050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT/SFNbyjqRQKVOJvWMUTBqOO8oBgaqMrnpmlnOChNs=;
        b=H/rKLtyDMzHw0jhZcjOKlOWWxbZreU4oOKccakFV6jjmrJx86J/EFNmFl7dMnri2YA
         jDGicxy2R1wmD0ATZT0rX+ChC5xwkg24of1PtWtBI6F7aT351lkfVi0Tc+OQyyMf3w4e
         TJZ9DUkJhCUKjUUoAF7awpacK1dWbDQtNkUlKxCoXhKwptePZCvM/hVVKErQFLDkPtTC
         wjNQBk2o8W88WUuCtgVIzJwUY8a6JpCIrKNEADP22e2fiv3NMs2mjcJMwBz8gLHtcbsa
         +GQ6WAm4t25A4xy69YVqvhO7VeKoG5J+9yGrmVeKqIjGX3J7ddK+fY3oLLTuE2XhiT3B
         aRRg==
X-Gm-Message-State: AC+VfDzUO4n/on0GCu6ZroYNaJW8r3uc/uBepCKlaIUPXP2iaumOpfNt
        NAEblzfKwF0jX2DVAiWtJcl9RQ==
X-Google-Smtp-Source: ACHHUZ48HsI5YZd3LN1vDcUYC1K6qWTTr5aUygORmW+ZGTHv31Rrj+0oY+hVYu/YmeCBOpKh0r58EA==
X-Received: by 2002:a05:6a00:2185:b0:64d:46b2:9a58 with SMTP id h5-20020a056a00218500b0064d46b29a58mr7924134pfi.26.1684732050365;
        Sun, 21 May 2023 22:07:30 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b0063b5776b073sm3247519pfh.117.2023.05.21.22.07.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 22:07:30 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 04/10] maple_tree: Simplify mas_is_span_wr()
Date:   Mon, 22 May 2023 13:06:50 +0800
Message-Id: <20230522050656.96215-5-zhangpeng.00@bytedance.com>
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

Make the code for detecting spanning writes more concise.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3fe6a6685384..c47af84047a4 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3728,43 +3728,32 @@ static inline void mas_store_root(struct ma_state *mas, void *entry)
  */
 static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
 {
-	unsigned long max;
+	unsigned long max = wr_mas->r_max;
 	unsigned long last = wr_mas->mas->last;
-	unsigned long piv = wr_mas->r_max;
 	enum maple_type type = wr_mas->type;
 	void *entry = wr_mas->entry;
 
-	/* Contained in this pivot */
-	if (piv > last)
+	/* Contained in this pivot, fast path */
+	if (last < max)
 		return false;
 
-	max = wr_mas->mas->max;
-	if (unlikely(ma_is_leaf(type))) {
-		/* Fits in the node, but may span slots. */
+	if (ma_is_leaf(type)) {
+		max = wr_mas->mas->max;
 		if (last < max)
 			return false;
+	}
 
-		/* Writes to the end of the node but not null. */
-		if ((last == max) && entry)
-			return false;
-
+	if (last == max) {
 		/*
-		 * Writing ULONG_MAX is not a spanning write regardless of the
-		 * value being written as long as the range fits in the node.
+		 * The last entry of leaf node cannot be NULL unless it is the
+		 * rightmost node (writing ULONG_MAX), otherwise it spans slots.
+		 * If this is not leaf node, detect spanning store wr walk.
 		 */
-		if ((last == ULONG_MAX) && (last == max))
-			return false;
-	} else if (piv == last) {
-		if (entry)
-			return false;
-
-		/* Detect spanning store wr walk */
-		if (last == ULONG_MAX)
+		if (entry || last == ULONG_MAX)
 			return false;
 	}
 
-	trace_ma_write(__func__, wr_mas->mas, piv, entry);
-
+	trace_ma_write(__func__, wr_mas->mas, wr_mas->r_max, entry);
 	return true;
 }
 
-- 
2.20.1

