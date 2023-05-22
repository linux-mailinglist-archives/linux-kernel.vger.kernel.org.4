Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB4770B453
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjEVFHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjEVFHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:07:46 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A9C139
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d2981e3abso2786899b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684732062; x=1687324062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKVnArPifyAdGV9PIImrukiWg2xfu85fuVT0WT/x1lU=;
        b=fw0PRf8Q3oQzgqHErNvDCU259xWd4Me2ceXFQD8pISEEcIEQZmk7bW7OJ3mBQ0eywD
         v7wNxQOQTVF4JZf9ON/6V5aCR3dkMK/NNESMj6wazF1zAw2gwqe+5A9004QgW40Jn8wf
         NRquXTchX9dImyrXbMIRvklOEHCfUofQg2xsBQ54kLTzcXz6ITsMt/ENw3oUKSUkw01t
         ZugU1Bcs0+eIsKfAO0I/jngb59O1PU0WvWi6+TwcGR4tuPzFQajmv63m1xEB1W3F+6HZ
         hJT0pSolSpSQKQ/rqzJP5/QiQVzYL5TvoE5uUy4y/Z8Tftr+0PeYqUwLgjtERfdeYo2D
         hh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732062; x=1687324062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKVnArPifyAdGV9PIImrukiWg2xfu85fuVT0WT/x1lU=;
        b=YkHAQKkrIhbRchqIDv+mhrGgjazsDKT/H+VmppM25/dszObTIJWbdKaW3917ZqxFS0
         OhfEEV6SHBABVKYuQwNRNPYn9PISv1kXIY3cZmMdaB4330hh2DY6nuKbeVq+mXTpyUz0
         JVXNwoSEkXNlu4hAD9ekzNQV4nSQlvqXz6mQMwV85xD2Q8yrMKPoLUZN8LGWmqKjt+10
         HMwh50KBALyQY3ZTHa4ptJWJfVXyJunJwVgvtjN4pFi6qW5JaiGq8jQLZqy1+yIC/kEH
         GkBfcRI2YnakyUExKxgAR0DOMtWbUjXc7H2VqNIdmqQDv/7kg+GSkzDMJWzKCrILU4O2
         R5WA==
X-Gm-Message-State: AC+VfDxLm7CHQ654RDO9xPhT/zjCGRUBK8J2g5sAZqq8ukxlhxtnhgDI
        UUzwdpx/cO61Pqkvg0/wus7UkQ==
X-Google-Smtp-Source: ACHHUZ4ZdOhjPoifK2FNOzw1Dpvr4gjGQyxiMVErjYNnHLBNabOF7Yl4YngE2n94wMJZLny9Vh53Og==
X-Received: by 2002:a05:6a20:3956:b0:107:17f6:940b with SMTP id r22-20020a056a20395600b0010717f6940bmr11393229pzg.41.1684732061987;
        Sun, 21 May 2023 22:07:41 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b0063b5776b073sm3247519pfh.117.2023.05.21.22.07.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 22:07:41 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 08/10] maple_tree: Rework mas_wr_slot_store() to be cleaner and more efficient.
Date:   Mon, 22 May 2023 13:06:54 +0800
Message-Id: <20230522050656.96215-9-zhangpeng.00@bytedance.com>
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

The code of mas_wr_slot_store() is messy, make it clearer and concise,
and add comments. In addition, get whether the two gaps are empty to
avoid calling mas_update_gap() all the time.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 53 +++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index afbfdcdde5db..1fc872f7683c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4203,49 +4203,34 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
 static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
-	unsigned long lmax; /* Logical max. */
 	unsigned char offset = mas->offset;
+	bool gap = false;
 
-	if ((wr_mas->r_max > mas->last) && ((wr_mas->r_min != mas->index) ||
-				  (offset != wr_mas->node_end)))
+	if (wr_mas->offset_end - offset != 1)
 		return false;
 
-	if (offset == wr_mas->node_end - 1)
-		lmax = mas->max;
-	else
-		lmax = wr_mas->pivots[offset + 1];
-
-	/* going to overwrite too many slots. */
-	if (lmax < mas->last)
-		return false;
-
-	if (wr_mas->r_min == mas->index) {
-		/* overwriting two or more ranges with one. */
-		if (lmax == mas->last)
-			return false;
+	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
+	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
 
-		/* Overwriting all of offset and a portion of offset + 1. */
+	if (mas->index == wr_mas->r_min) {
+		/* Overwriting the range and over a part of the next range. */
 		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
 		wr_mas->pivots[offset] = mas->last;
-		goto done;
+	} else {
+		/* Overwriting a part of the range and over the next range */
+		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
+		wr_mas->pivots[offset] = mas->index - 1;
+		mas->offset++; /* Keep mas accurate. */
 	}
 
-	/* Doesn't end on the next range end. */
-	if (lmax != mas->last)
-		return false;
-
-	/* Overwriting a portion of offset and all of offset + 1 */
-	if ((offset + 1 < mt_pivots[wr_mas->type]) &&
-	    (wr_mas->entry || wr_mas->pivots[offset + 1]))
-		wr_mas->pivots[offset + 1] = mas->last;
-
-	rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
-	wr_mas->pivots[offset] = mas->index - 1;
-	mas->offset++; /* Keep mas accurate. */
-
-done:
 	trace_ma_write(__func__, mas, 0, wr_mas->entry);
-	mas_update_gap(mas);
+	/*
+	 * Only update gap when the new entry is empty or there is an empty
+	 * entry in the original two ranges.
+	 */
+	if (!wr_mas->entry || gap)
+		mas_update_gap(mas);
+
 	return true;
 }
 
@@ -4392,7 +4377,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
 		return;
 
-	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
+	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
 		return;
 	else if (mas_wr_node_store(wr_mas))
 		return;
-- 
2.20.1

