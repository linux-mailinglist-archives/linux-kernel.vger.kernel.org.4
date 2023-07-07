Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313AE74AE94
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjGGKMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjGGKMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:12:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB53268C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:11:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-557790487feso1231181a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 03:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688724692; x=1691316692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaVLJjip61EeAZP607ZyqgslEXeB0JVkPTMnfDPq3fs=;
        b=j7/AtuKsMBfQml5gsk08AByvKeWMYp3cLlXFl0h5wiOOFzwno2s4JDdbZz1gMZegRg
         rUPpYnw3sChLJYJ5e3QUubyJfUOyVs4Sxfwp3gXSItOXsfbv7HJPaQbn6gAbTh/ZPqaV
         ekyATJifF5X1WMznSIRLogfSQIfzoA/6iKyuIUHQvX/pYsVQrksJXosKt1koWCPqLmr/
         8lGymmUdBB5ALohe7dC4q04z2Xn9QetC+T7YC6d2v8+plOlEBZZAh9rLk8KoAk+MzKt1
         xlBw08hirYh31Bb63VHYl8VtCkX8xxXIzIIfEDitAobM42DMTBKpybRaYKHBMuVy8Mty
         vQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688724692; x=1691316692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaVLJjip61EeAZP607ZyqgslEXeB0JVkPTMnfDPq3fs=;
        b=LWfzTa9bu8By4zFz1kpi5sGW39BobkJK4ZJ6Z4BUUPZJfMuuYCJ8CjKtZiVYnegSbl
         PgWmfvI+T7HcekcFTW087fbKEHZxyOYNR4dAFAUMonar/pyFHwmPQLEzAA43gmBCmKjp
         Y8EwiTtxgPi6dxcMMFg3PgFBovnR3hCpALk//v7WKpwZudyW1LaKyfTZ2ANEVO5rI5Kx
         Bg7C1R86T6jxvTb9RWSsnOeVIWOv6Ntloeg6MIpQVUfKkJCNAdjdobhfpZolvu1xgodX
         pBmIKF/Wx3u/evNIyUoRNJg+uYTdg4xwTcC0ET40MOSk3dkIQPQU02h6WtgrTYGPlEpO
         +0mA==
X-Gm-Message-State: ABy/qLbT6wzoB+yUue3QUoYTjPLyOnXMTVyW1rdGKIo62GcizE+dtHpD
        vWk3p6jp7/kTw3yo7mS8aDKUQQ==
X-Google-Smtp-Source: APBJJlGcNKKZKkWKc1iP3UjBr/HMi0EvrSAMn7bPU1cexh4uo9XIVJnNzuQXc9KlBQEaQksmKfv7+Q==
X-Received: by 2002:a05:6a20:8c1a:b0:12e:7fc9:5c44 with SMTP id j26-20020a056a208c1a00b0012e7fc95c44mr3641814pzh.14.1688724692583;
        Fri, 07 Jul 2023 03:11:32 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b0068288aaf23esm2602549pfv.100.2023.07.07.03.11.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jul 2023 03:11:32 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [RESEND PATCH 7/8] maple_tree: replace mas_logical_pivot() with mas_safe_pivot()
Date:   Fri,  7 Jul 2023 18:10:56 +0800
Message-Id: <20230707101057.29326-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
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

Replace mas_logical_pivot() with mas_safe_pivot() and drop
mas_logical_pivot() since it won't be used anymore. We can do this since
now all nodes will have node limit pivot (if it is not full node).

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3aede7deaa26..8c08bfdc99cf 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -728,33 +728,6 @@ mas_safe_min(struct ma_state *mas, unsigned long *pivots, unsigned char offset)
 	return mas->min;
 }
 
-/*
- * mas_logical_pivot() - Get the logical pivot of a given offset.
- * @mas: The maple state
- * @pivots: The pointer to the maple node pivots
- * @offset: The offset into the pivot array
- * @type: The maple node type
- *
- * When there is no value at a pivot (beyond the end of the data), then the
- * pivot is actually @mas->max.
- *
- * Return: the logical pivot of a given @offset.
- */
-static inline unsigned long
-mas_logical_pivot(struct ma_state *mas, unsigned long *pivots,
-		  unsigned char offset, enum maple_type type)
-{
-	unsigned long lpiv = mas_safe_pivot(mas, pivots, offset, type);
-
-	if (likely(lpiv))
-		return lpiv;
-
-	if (likely(offset))
-		return mas->max;
-
-	return lpiv;
-}
-
 /*
  * mte_set_pivot() - Set a pivot to a value in an encoded maple node.
  * @mn: The encoded maple node
@@ -2202,7 +2175,7 @@ static noinline_for_kasan void mas_store_b_node(struct ma_wr_state *wr_mas,
 		goto b_end;
 
 	/* Handle new range ending before old range ends */
-	piv = mas_logical_pivot(mas, wr_mas->pivots, offset_end, wr_mas->type);
+	piv = mas_safe_pivot(mas, wr_mas->pivots, offset_end, wr_mas->type);
 	if (piv > mas->last) {
 		if (piv == ULONG_MAX)
 			mas_bulk_rebalance(mas, b_node->b_end, wr_mas->type);
@@ -4934,7 +4907,7 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
 	min = mas_safe_min(mas, pivots, offset);
 	data_end = ma_data_end(node, type, pivots, mas->max);
 	for (; offset <= data_end; offset++) {
-		pivot = mas_logical_pivot(mas, pivots, offset, type);
+		pivot = mas_safe_pivot(mas, pivots, offset, type);
 
 		/* Not within lower bounds */
 		if (mas->index > pivot)
@@ -7007,7 +6980,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 
 	gaps = ma_gaps(node, mt);
 	for (i = 0; i < mt_slot_count(mte); i++) {
-		p_end = mas_logical_pivot(mas, pivots, i, mt);
+		p_end = mas_safe_pivot(mas, pivots, i, mt);
 
 		if (!gaps) {
 			if (!mas_get_slot(mas, i))
-- 
2.20.1

