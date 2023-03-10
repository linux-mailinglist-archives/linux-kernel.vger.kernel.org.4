Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB386B431B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjCJOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjCJOKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:10:12 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E57D136C9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:09:40 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y11so5685893plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678457379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7DPt8nqxS2DR8+B+9WtRvCdWF3m9pKFBEKjw2IVbrY=;
        b=Vt7HmeQi/0l9PcitJbwAwTNB69hO/ue7yLU7cQTTmP4tGVuY+aE3gFyEMp8I6M+gd9
         0vRhsPgpGy9FkvxG682ngJXJVQ8h7Q+tFj6pxUci1n4a90DrWTeC+BFdbqiLiR1QES06
         8Zh5WuLrsn2iRx4YmU07ySYLIt08ka0rV7cMvePtiLF2pelRlbmHOFUpl1w4eow+HBzM
         1NSEFkEOZT3RNO0m7kXJqqJiUWLffAlSDZDnSXEMmqRGz4ZspmHHeTzNUzH/X/BrtwDi
         vCxlaVIW0PhyKotrrKPuxWcz0ee1nfXSCt0hEtD0rmaCWbI22gsK/jKBS2RXZ0mSAr6Y
         Ikqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678457379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7DPt8nqxS2DR8+B+9WtRvCdWF3m9pKFBEKjw2IVbrY=;
        b=Vx3HGjECv2DuG1LaETBWTWhoVHa1Hc1It+JCh3tJeTFIjG7P5u9mtMkn4FKw6P6Dpu
         zRqxtxVdlcqkIorH/5VdauxiK76fc/N8JOEeYDxy1Mumul5SvpBhHoOAvtTygzO2tcgT
         7Jn60yWRLpYak3SZ+358WFBi+ITHHD0YoG/CS/NIcVdb7Q4hPpAzJNhDfwgRTDEWAS4s
         DU6UQjHzAI7adsrhFLq90XDm898q3nPYOIE7wZRKqxk6PxVY3pJ6pwzpRhv05UIzR8aC
         pC5up7gjbhVywnFWfnQ5YwjQGfWkbTRzvVLPrrLc5rcvlzK3rsTuXCrgEYQ5yKE3l149
         oItQ==
X-Gm-Message-State: AO0yUKXsU0T93pawUVqooJyKL5KWbqf1cXvm6v/a9mFoI9VW1BaGL3uF
        FAWi92M7fQmUoaZUJXtJkFfo1g==
X-Google-Smtp-Source: AK7set9df5/U3LQZqScgLIUjh/W7HucX2b8VJSDwe4PpGG5DxpP24J4aztf92cED6W3fDEZYoI0TUA==
X-Received: by 2002:a17:90b:4f42:b0:236:76cb:99d2 with SMTP id pj2-20020a17090b4f4200b0023676cb99d2mr27006601pjb.8.1678457379677;
        Fri, 10 Mar 2023 06:09:39 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id fu11-20020a17090ad18b00b002375c356b0csm6753pjb.19.2023.03.10.06.09.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Mar 2023 06:09:39 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 2/4] maple_tree: Simplify mas_wr_node_walk()
Date:   Fri, 10 Mar 2023 22:08:45 +0800
Message-Id: <20230310140848.94485-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code of mas_wr_node_walk() without changing functionality,
and improve readability.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b3164266cfde..4d15202a0692 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2251,9 +2251,7 @@ static inline struct maple_enode *mte_node_or_none(struct maple_enode *enode)
 static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
-	unsigned char count;
-	unsigned char offset;
-	unsigned long index, min, max;
+	unsigned char count, offset;
 
 	if (unlikely(ma_is_dense(wr_mas->type))) {
 		wr_mas->r_max = wr_mas->r_min = mas->index;
@@ -2266,34 +2264,12 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
 	count = wr_mas->node_end = ma_data_end(wr_mas->node, wr_mas->type,
 					       wr_mas->pivots, mas->max);
 	offset = mas->offset;
-	min = mas_safe_min(mas, wr_mas->pivots, offset);
-	if (unlikely(offset == count))
-		goto max;
-
-	max = wr_mas->pivots[offset];
-	index = mas->index;
-	if (unlikely(index <= max))
-		goto done;
-
-	if (unlikely(!max && offset))
-		goto max;
 
-	min = max + 1;
-	while (++offset < count) {
-		max = wr_mas->pivots[offset];
-		if (index <= max)
-			goto done;
-		else if (unlikely(!max))
-			break;
-
-		min = max + 1;
-	}
+	while (offset < count && mas->index > wr_mas->pivots[offset])
+		offset++;
 
-max:
-	max = mas->max;
-done:
-	wr_mas->r_max = max;
-	wr_mas->r_min = min;
+	wr_mas->r_max = offset < count ? wr_mas->pivots[offset] : mas->max;
+	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, offset);
 	wr_mas->offset_end = mas->offset = offset;
 }
 
-- 
2.20.1

