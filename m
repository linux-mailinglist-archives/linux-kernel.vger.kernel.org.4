Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDC5706374
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjEQJAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjEQI7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:59:32 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DCF5275
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:06 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52c6f81193cso306501a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684313946; x=1686905946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOzzsH+HINl0nPqqyHkNJXvYfvo/GTpdTPT7077/sGQ=;
        b=LEpcP6Z2iO5V244pOZDVZ9PD/DssYhxM/g2Dgywp7L5+4So8fiBCWCs+ByEv4uwRGf
         Lsrr8ZnveVCkcBoJOY7slGzezuGunBr1hkrG0WbES9lRgR4WkaPW3WkN7INx7m+7bNLa
         b+SJ6BYMLFPicf7kxRDWbsSTeTmNlQfqx0iU2i51i1P6ZXGuBr0QlzliS3x6NlTf2MJy
         84wk5jYwGFVMpmaKVNv8+tkrtO5wnPxXEPT/COvyZcL1lvzf3LamcYd/jVgY6tFdIuJK
         KUFlZld0CYflLmPq/feOirZ1Up6XjBoz2hnunMuxMbHmjp6cuc8TyruCJLUKCE4dPmGy
         y0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313946; x=1686905946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOzzsH+HINl0nPqqyHkNJXvYfvo/GTpdTPT7077/sGQ=;
        b=lWyWZ5jrJDnBHtteuK+zIyh87/12K02L8f85iZ9ycqWMz+w5imY7uDBU9dY+qsk+jd
         TMQd/+QtvjUxIQsrcndQV3wgVuymgV1ZyV/sHRg0AgbBmuoZxI2srCc3AY2KjhUa6MK0
         k5inECxD6Zm7btMTAoLXHfZTZOfkBjykdYk5SBB7B4Ama/MEMBq1h16z4Mrvv4KVjHm6
         5YQ8Kopbpg/gZRYQgq/7E7YyqmSI1MnFuIx/5d+vROrlN1VK13+txFKlowrz4lfkZqZS
         oBiXSN6JAIlJv5JXzLuhgjzNAHZKv9di+sZ4oGfpt8dDJCl/NsSUJR1s15aNrVaxOKsr
         a6pQ==
X-Gm-Message-State: AC+VfDyAg64XIwdRiXtqr9x3AOaUZDdiglhPQb0qnNkKXgiyRUfrf+oD
        6my7gzAmZsUfuvIPZVZ+aam01w==
X-Google-Smtp-Source: ACHHUZ5sLjaykUSvrFlKay55p8VrWsxrTs0AGlQ0fIeJ8X1NfblBBaQJci8YRv4xfW3zFc3U6grQNQ==
X-Received: by 2002:a05:6a20:12cd:b0:106:70af:a5b9 with SMTP id v13-20020a056a2012cd00b0010670afa5b9mr10364681pzg.31.1684313945924;
        Wed, 17 May 2023 01:59:05 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m18-20020a63ed52000000b0052c9d1533b6sm15056765pgk.56.2023.05.17.01.59.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 May 2023 01:59:05 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 07/10] maple_tree: Add comments and some minor cleanups to mas_wr_append()
Date:   Wed, 17 May 2023 16:58:06 +0800
Message-Id: <20230517085809.86522-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
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

Add comment for mas_wr_append(), move mas_update_gap() into
mas_wr_append(), and other cleanups to make mas_wr_modify() cleaner.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3b9d227f3d7d..bbe4c6f2858c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4308,6 +4308,12 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
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
@@ -4315,7 +4321,11 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char node_pivots = mt_pivots[wr_mas->type];
 
+	if (!(mas->offset == wr_mas->node_end))
+		return false;
+
 	if ((mas->index != wr_mas->r_min) && (mas->last == wr_mas->r_max)) {
+		/* Append to end of range */
 		if (new_end < node_pivots)
 			wr_mas->pivots[new_end] = wr_mas->pivots[end];
 
@@ -4323,13 +4333,10 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 			ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
 
 		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->entry);
-		mas->offset = new_end;
 		wr_mas->pivots[end] = mas->index - 1;
-
-		return true;
-	}
-
-	if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
+		mas->offset = new_end;
+	} else if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
+		/* Append to start of range */
 		if (new_end < node_pivots)
 			wr_mas->pivots[new_end] = wr_mas->pivots[end];
 
@@ -4339,10 +4346,13 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 
 		wr_mas->pivots[end] = mas->last;
 		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
-		return true;
+	} else {
+		return false;
 	}
 
-	return false;
+	if (!wr_mas->content || !wr_mas->entry)
+		mas_update_gap(mas);
+	return  true;
 }
 
 /*
@@ -4382,12 +4392,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
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

