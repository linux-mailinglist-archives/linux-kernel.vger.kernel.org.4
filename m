Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A980A7298F4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbjFIMEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjFIMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:04:38 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9C11A2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:04:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso1328085b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686312277; x=1688904277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL1zyrCsP3IyIQZEOeNmddZJSl3qkO5SMTODoFeq2wM=;
        b=Gsx26ftx1CyOLFjHK1Iey0HHbvMHRqZFye9C373qPvnSfcCcMpNYFN2Z57E2PqB9am
         NbEYjnVKZUxWntdqaCW5M8xWUXHWcwX4lvW3/HiJV4NIyKczYExvZC58nr8Ty/u1q/UF
         kAyymqAnVU/kjJi3Qh1Yu4z6k9bJdZBbZRwTHkrzA41DfdmuJxRoVFdoz9bawNnffH2V
         sjePu9crSP9w9NvNlT6zn+KdBRotkeVlUEwamMNtmUlafxWjSPCt2iqDitqqcRKrZ7H6
         aXhB5+ydO++F08JoNLBn96lp/nHrJ19Sf1XX7PaxX3VNnjfplmFR4GjOuK03MtXxUjjt
         n/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312277; x=1688904277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL1zyrCsP3IyIQZEOeNmddZJSl3qkO5SMTODoFeq2wM=;
        b=C1vlNOW3iSM/ZAyd0Zogrv3Ist5Az7v7KGtD6owecNlYVMkGbG5JsWI7v1yA9hjoqA
         2aWI4ynETmGVmUAVXTAapgDORkpFygW8EWsn2nwebaD1SDnIU3E0q9VLR8obrCrkqibO
         bBiqijWcC+VFOqSCURyCIDzngG0isBLPxWAnWhJhXJRTybUQ96B7jtzLbsOw3QZliVMP
         nheqyI7i5k67CrLvb7BL954GRhKtEAup4X5pJTWBcciUPk+1GmUuE0bETbzxVxXi7/6a
         I7XjH2vyx+8kqYd27ThsCXHusA5oI6KhJ7pQDqlZ4e3m+rVVjTafm5K2/ElD44hR6nrs
         jFDA==
X-Gm-Message-State: AC+VfDwDmNJHb+4wS0rmwbs47rsNtilNVPksRVaPDfm/od4rtCHooJCw
        7HxM5RR3PqhPp8aQ7Set+J8vkA==
X-Google-Smtp-Source: ACHHUZ6F7zQNdvlQlu66gpRu8wSi/BuDCO9wkbiibbLKyy50iBdhniNxE0EEiDy15hFiNJ/jReow8w==
X-Received: by 2002:a05:6a00:21d0:b0:654:100f:bffc with SMTP id t16-20020a056a0021d000b00654100fbffcmr938338pfj.4.1686312277267;
        Fri, 09 Jun 2023 05:04:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id v12-20020a65568c000000b00514256c05c2sm2619168pgs.7.2023.06.09.05.04.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jun 2023 05:04:37 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 2/3] maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
Date:   Fri,  9 Jun 2023 20:03:46 +0800
Message-Id: <20230609120347.63936-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230609120347.63936-1-zhangpeng.00@bytedance.com>
References: <20230609120347.63936-1-zhangpeng.00@bytedance.com>
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

When the new range can be completely covered by the original last range
without touching the boundaries on both sides, two new entries can be
appended to the end as a fast path. We update the original last pivot at
the end, and the newly appended two entries will not be accessed before
this, so it is also safe in RCU mode.

This is useful for sequential insertion, which is what we do in
dup_mmap(). Enabling BENCH_FORK in test_maple_tree and just running
bench_forking() gives the following time-consuming numbers:

before:               after:
17,874.83 msec        15,738.38 msec

It shows about a 12% performance improvement for duplicating VMAs.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5ea211c3f186..a96eb646e839 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4269,10 +4269,10 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
  *
  * Return: True if appended, false otherwise
  */
-static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
+static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
+				 unsigned char new_end)
 {
 	unsigned char end = wr_mas->node_end;
-	unsigned char new_end = end + 1;
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char node_pivots = mt_pivots[wr_mas->type];
 
@@ -4284,16 +4284,27 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 		ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
 	}
 
-	if (mas->last == wr_mas->r_max) {
-		/* Append to end of range */
-		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->entry);
-		wr_mas->pivots[end] = mas->index - 1;
-		mas->offset = new_end;
+	if (new_end == wr_mas->node_end + 1) {
+		if (mas->last == wr_mas->r_max) {
+			/* Append to end of range */
+			rcu_assign_pointer(wr_mas->slots[new_end],
+					   wr_mas->entry);
+			wr_mas->pivots[end] = mas->index - 1;
+			mas->offset = new_end;
+		} else {
+			/* Append to start of range */
+			rcu_assign_pointer(wr_mas->slots[new_end],
+					   wr_mas->content);
+			wr_mas->pivots[end] = mas->last;
+			rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
+		}
 	} else {
-		/* Append to start of range */
+		/* Append to the range without touching any boundaries. */
 		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->content);
-		wr_mas->pivots[end] = mas->last;
-		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
+		wr_mas->pivots[end + 1] = mas->last;
+		rcu_assign_pointer(wr_mas->slots[end + 1], wr_mas->entry);
+		wr_mas->pivots[end] = mas->index - 1;
+		mas->offset = end + 1;
 	}
 
 	if (!wr_mas->content || !wr_mas->entry)
@@ -4340,7 +4351,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 		goto slow_path;
 
 	/* Attempt to append */
-	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
+	if (mas_wr_append(wr_mas, new_end))
 		return;
 
 	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
-- 
2.20.1

