Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DD56F8E1E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjEFCsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEFCsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:48:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2360421D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:48:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaec6f189cso16784105ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 19:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683341280; x=1685933280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IB1K/l9/1FqQriErcMqKq+JgBm37xydqS13nuO5aWY=;
        b=W9/AMeOlh/lAOx41PZNmzXw9cTtRfF3hF9Z6FPXosI17UzVAGVOhKYFkILWrD7FeqM
         /mWZLlEMfRFqD8tbJdnVbGZouCsE1yFOAJ7K8eQwFeEScnE9Pof7H0Yb3RWMhCJMDfov
         1Q5SNztBaOOvC24TsPrAob53VgnSoPrvq1MvswWcufbXXKHZvJ+JtTFOHg57BFctMY8+
         mjIOY7KYmK7NNYEo6dzLv0xyyKtanWRko7H914RlHSn8Ztk3q5n8LskYNd9jFb0Iou8G
         9eUfHXu8J+uq14NANWSm3ZFyHXhcZO5l9cevDhhjoGXwaWDwgW7/Vn1be0VqtDY6Nauo
         x+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683341280; x=1685933280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IB1K/l9/1FqQriErcMqKq+JgBm37xydqS13nuO5aWY=;
        b=bThC8piKrVgMrm0sPAz5Fx1pByh1rEy4QYMGK9CiLC8KFkrbmhbnH1KtJ7ZTZNHM+E
         D6smSFwDY/TJa4BMrttNanGWXT+qyIICpFa4j9Aw4/g9YmtyZLUrwLV6ubdpSks3a5YY
         +I/wcpYoWD81lHlmQM5CetPl+XwWnA7ZvxXVz6WDo5+lXuQCoynWudN8RsXuRNZMDPkQ
         o8weRZkQfdyvap7YiRB2IcbQXQTnYa8L2VnW4AwHy+AYgJkh4Or8olRfvxhZpu1IJLsB
         V+olFaA52fAS++fhSFM8ODKx7JBMr9dehivOGhwlrwUWOen5PRp3Z8skxRY/nL+EtiCC
         DpRg==
X-Gm-Message-State: AC+VfDyzPN58O8+VL7WOvAsk4JOt2oE0Dhck4jrxZi7qvfyYLtVI+hy0
        061qyQl4fOVy1eIRhyRDxXERoQ==
X-Google-Smtp-Source: ACHHUZ44+AOI9mWDA0VX65/ESLRXKLOnscfmWt0mUNuMW3DNnCeVUO4F9Z4ifghSDalvpZuia1FTVw==
X-Received: by 2002:a17:902:fa0f:b0:1a9:8ff5:af43 with SMTP id la15-20020a170902fa0f00b001a98ff5af43mr3207546plb.18.1683341280366;
        Fri, 05 May 2023 19:48:00 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902759100b001ab0672fc1fsm2421871pll.105.2023.05.05.19.47.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 May 2023 19:47:59 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2] maple_tree: Fix potential out-of-bounds access in mas_wr_end_piv()
Date:   Sat,  6 May 2023 10:47:52 +0800
Message-Id: <20230506024752.2550-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the write offset end bounds before using it as the offset into the
pivot array. This avoids a possible out-of-bounds access on the pivot
array if the write extends to the last slot in the node, in which case
the node maximum should be used as the end pivot.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 110a36479dced..5a49327444d76 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4263,11 +4263,13 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 
 static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
 {
-	while ((wr_mas->mas->last > wr_mas->end_piv) &&
-	       (wr_mas->offset_end < wr_mas->node_end))
-		wr_mas->end_piv = wr_mas->pivots[++wr_mas->offset_end];
+	while ((wr_mas->offset_end < wr_mas->node_end) &&
+	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
+		wr_mas->offset_end++;
 
-	if (wr_mas->mas->last > wr_mas->end_piv)
+	if (wr_mas->offset_end < wr_mas->node_end)
+		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
+	else
 		wr_mas->end_piv = wr_mas->mas->max;
 }
 
@@ -4424,7 +4426,6 @@ static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
 	}
 
 	/* At this point, we are at the leaf node that needs to be altered. */
-	wr_mas->end_piv = wr_mas->r_max;
 	mas_wr_end_piv(wr_mas);
 
 	if (!wr_mas->entry)
-- 
2.20.1

