Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A58670EBC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbjEXDOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbjEXDOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:14:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE4E6C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae4be0b1f3so3383935ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684898013; x=1687490013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8kX/CacLzRcOeiRpI7Mv6WmATX8iDuuhOGMVtT6UnI=;
        b=dAbDkk4GiJQU/jxOkINNRJlaXfIOp/R5R+HSQgwpzuH8eiNMPj5AcakWbxo//h8/ay
         vQ0LArP/qpZgWTAmJpZlCArJFNRl2XkUK6w2jHsLhelCYpaZdm9oTP1m/7V6YEkbfS/8
         HyO/Rgus3f3DcI+iFxoHe57XLFmEVK6IDB6Vuy/ehe8mv87fHmjcb1CG4LbntXuhzelG
         GUw90y//GDnqabcNqlyMLV9Tzj6SLCBwyqtaMmEYllBHBw4OjOeOTJWYzZMRR6xifs+6
         GsvQusvycib3LAyIrKaTtOVOZnKOODZ4jt/bPIFoElXPLkj5oRsu0mS/qZKKyYUhYo1G
         IsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684898013; x=1687490013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8kX/CacLzRcOeiRpI7Mv6WmATX8iDuuhOGMVtT6UnI=;
        b=Yobs4Xkeghtb0P7pwkgPSsDHpNu1/CqkV6kgg1ITKRjgrbefzbJ75GEa/D+TOLppJP
         x66o8YAq4P4zkAZUygiPBdjkPP2A72ITiM7/2yzMfTfkZwVo/iHgrZHGGmUNDIbr7JZT
         wfWQfzz+P+gLIq8Rga4QyYlZmjgD6WqCyvyJ9V54GUiAbo+fB2iQ4tmnmPpIXZi/34m+
         8ewGrGeuIC6I8wxyN9vq5dX8AmlGeGjcXtx7vDCaCzgh+xZjmGf6PjQ7FZqidxNCuCB0
         HGTsbCfc30vAhzqFAOJpOyLdVlo2ZTbjxah8gtAZt2i8VAGki+827YT79oIhg7dM44dv
         +JMQ==
X-Gm-Message-State: AC+VfDwIBzRKV3RK0V441hJhXnJf9MSPfaIVUa+Ss45fOg4gIQkaf9YL
        KuQWFNiQIN7UAQW9wJpE5mSwlg==
X-Google-Smtp-Source: ACHHUZ7Qafrtm+weGS2Jn5aesb3gc/ilDa4pwi9sRmaWBdjd8Jnm2LaKpeRgtRJCgYwRDpQ/lLrBkQ==
X-Received: by 2002:a17:902:ec86:b0:1a6:a8e5:9240 with SMTP id x6-20020a170902ec8600b001a6a8e59240mr17812527plg.4.1684898012832;
        Tue, 23 May 2023 20:13:32 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001ab061e352bsm7480769plr.195.2023.05.23.20.13.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 May 2023 20:13:32 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 07/10] maple_tree: Add comments and some minor cleanups to mas_wr_append()
Date:   Wed, 24 May 2023 11:12:44 +0800
Message-Id: <20230524031247.65949-8-zhangpeng.00@bytedance.com>
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

Add comment for mas_wr_append(), move mas_update_gap() into
mas_wr_append(), and other cleanups to make mas_wr_modify() cleaner.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 07c5c7afd415..676976a005e5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4311,6 +4311,12 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 	return new_end;
 }
 
+/*
+ * mas_wr_append: Attempt to append
+ * @wr_mas: the maple write state
+ *
+ * Return: True if appended, false otherwise
+ */
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 {
 	unsigned char end = wr_mas->node_end;
@@ -4318,34 +4324,30 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char node_pivots = mt_pivots[wr_mas->type];
 
-	if ((mas->index != wr_mas->r_min) && (mas->last == wr_mas->r_max)) {
-		if (new_end < node_pivots)
-			wr_mas->pivots[new_end] = wr_mas->pivots[end];
+	if (mas->offset != wr_mas->node_end)
+		return false;
 
-		if (new_end < node_pivots)
-			ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
+	if (new_end < node_pivots) {
+		wr_mas->pivots[new_end] = wr_mas->pivots[end];
+		ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
+	}
 
+	if (mas->last == wr_mas->r_max) {
+		/* Append to end of range */
 		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->entry);
-		mas->offset = new_end;
 		wr_mas->pivots[end] = mas->index - 1;
-
-		return true;
-	}
-
-	if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
-		if (new_end < node_pivots)
-			wr_mas->pivots[new_end] = wr_mas->pivots[end];
-
+		mas->offset = new_end;
+	} else {
+		/* Append to start of range */
 		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->content);
-		if (new_end < node_pivots)
-			ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
-
 		wr_mas->pivots[end] = mas->last;
 		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
-		return true;
 	}
 
-	return false;
+	if (!wr_mas->content || !wr_mas->entry)
+		mas_update_gap(mas);
+
+	return  true;
 }
 
 /*
@@ -4385,12 +4387,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 	if (new_end >= mt_slots[wr_mas->type])
 		goto slow_path;
 
-	if (wr_mas->entry && (wr_mas->node_end < mt_slots[wr_mas->type] - 1) &&
-	    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
-		if (!wr_mas->content || !wr_mas->entry)
-			mas_update_gap(mas);
+	/* Attempt to append */
+	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
 		return;
-	}
 
 	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
 		return;
-- 
2.20.1

