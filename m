Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB1D70636D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjEQI7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjEQI7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:59:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B901A5598
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:03 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53202149ae2so318977a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684313943; x=1686905943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sATgEzrR7h2S265Iki4mbf6UDAayTpXJc+pupXreNbo=;
        b=AhqU7dUps8kowzB+osQO8so6VQf0rmRE6E4zIjuNyIPM6ywkBKH1KWI+hwH6Hb8grH
         bCqQ1C89pxuZN6S/Qe2mlxhm/jIwJYn47SJ10Pr+CL6qSbZU4B9m8pibG8gDHXwaGqha
         BVt/etviuKp+jgzPJWFF1XHYRdgXwLWhKdMu/EIsq8iNLQAuAxCx+XmuV8f4Yk++dfHM
         zNgtI4hXPq6uzaYEDuOkU3GWF4osZuQlgfHh6H/lds1CnKY1wfGyfMt8sEPGBvtX5fXQ
         FZNAo6CIYaoCnSAF+GU3yXvBnGH5ReKVI1SptmJCddaenxpFVlVGwF3/6ZCTN1QOOPcH
         AItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313943; x=1686905943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sATgEzrR7h2S265Iki4mbf6UDAayTpXJc+pupXreNbo=;
        b=IbRD1eQTR4GfSrTHMYmeEpnSnuJzQqQNlb5nHTgwx73gkLyXYKpX58A1DkI6ZUwfwK
         MltgyrHf6h0XOldPE166IyZRoVumIo3P6Fje3jQmu9m1tLciPTLk1OcHtUGL5LoQJ+ct
         oADYIaVjeQq/B8vayfkuj/m8uzdviLwrFi6DJm44MnLbLPLUaxWruejJv/aEi4LNF+f9
         wfUapj5XiO49xx3eMQyuK5mY25lvOowM6KWZBBMHcPX44llaNDVkpyTkhcFwJe/aI06B
         b1Ywgq9iVW3CnvmUF1AVU/mXWPoVWuCdWM2jCUzqFTspWq79cCdBPQEbf4jz1zA2lk8l
         8h4g==
X-Gm-Message-State: AC+VfDy8Aat1oCvnUx9lSqmWqSZQXLAqKv+mzz+Afo441CkQq7POegf2
        tx1rb6MwhxEN3suOQmDbJni5KgvXwFde/76r758=
X-Google-Smtp-Source: ACHHUZ5pxBoy9i804S0WFEBY4chpbe7G9WMqboedp6zXSUYx96x0ZmEDxKvpxQw+xImuE9quMaS2dQ==
X-Received: by 2002:a05:6a21:3298:b0:103:6c36:46db with SMTP id yt24-20020a056a21329800b001036c3646dbmr32420717pzb.55.1684313943206;
        Wed, 17 May 2023 01:59:03 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m18-20020a63ed52000000b0052c9d1533b6sm15056765pgk.56.2023.05.17.01.59.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 May 2023 01:59:03 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 06/10] maple_tree: Add mas_wr_new_end() to calculate new_end accurately
Date:   Wed, 17 May 2023 16:58:05 +0800
Message-Id: <20230517085809.86522-7-zhangpeng.00@bytedance.com>
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

The previous new_end calculation is inaccurate, because it assumes that
two new pivots must be added (this is inaccurate), and sometimes it will
miss the fast path and enter the slow path. Add mas_wr_new_end() to
accurately calculate new_end to make the conditions for entering the
fast path more accurate.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f881bce1a9f6..3b9d227f3d7d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4294,6 +4294,20 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 	}
 }
 
+static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end = wr_mas->node_end + 2;
+
+	new_end -= wr_mas->offset_end - mas->offset;
+	if (wr_mas->r_min == mas->index)
+		new_end--;
+	if (wr_mas->end_piv == mas->last)
+		new_end--;
+
+	return new_end;
+}
+
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 {
 	unsigned char end = wr_mas->node_end;
@@ -4349,9 +4363,8 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 
 static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 {
-	unsigned char node_slots;
-	unsigned char node_size;
 	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end;
 
 	/* Direct replacement */
 	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
@@ -4361,17 +4374,15 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 		return;
 	}
 
-	/* Attempt to append */
-	node_slots = mt_slots[wr_mas->type];
-	node_size = wr_mas->node_end - wr_mas->offset_end + mas->offset + 2;
-	if (mas->max == ULONG_MAX)
-		node_size++;
-
-	/* slot and node store will not fit, go to the slow path */
-	if (unlikely(node_size >= node_slots))
+	/*
+	 * new_end exceeds the size of the maple node and cannot enter the fast
+	 * path.
+	 */
+	new_end = mas_wr_new_end(wr_mas);
+	if (new_end >= mt_slots[wr_mas->type])
 		goto slow_path;
 
-	if (wr_mas->entry && (wr_mas->node_end < node_slots - 1) &&
+	if (wr_mas->entry && (wr_mas->node_end < mt_slots[wr_mas->type] - 1) &&
 	    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
 		if (!wr_mas->content || !wr_mas->entry)
 			mas_update_gap(mas);
-- 
2.20.1

