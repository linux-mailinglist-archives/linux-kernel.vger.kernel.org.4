Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703C474E58E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGKDzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjGKDzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:55:24 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDD3E69
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:20 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a412653335so689510b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689047719; x=1691639719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbarY+W3CHTFGsKxfdT0v+U7T4eLSEDHZXXVmyxXdNU=;
        b=iULxRDLCYTw8LCbKROb4TXPoBYnA1v18DTCUhinG5JOrzgwyPzolG/GbPjP0Ghw877
         ZeFhZ6pfEHNACpMhdSEdi8M0CIttf3djc5hRG285cAP0/TdP5VIo1CJhiMnrYxLq2Br4
         TEqxemWUZJVJquPT6NkviWia/MOosyK5GroVKnwfWkNPWYGHKqQef5iwhDlsHOTZiv5s
         zvAcmE2osWi2vEjvqYWeu+/GQVnyI/4GTgGh5h0cTmgsCE+9IIyvbxoaE62+oKyUht+O
         n1EFaO4uQsZ5zcdikocUiGLossOZB6cy46l+rMKDTASMmpejL7ZdcoSghLjWjYdkEzQq
         WZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047719; x=1691639719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbarY+W3CHTFGsKxfdT0v+U7T4eLSEDHZXXVmyxXdNU=;
        b=HDtyRLM+ItX9swBELfpOO6pEX0A+6ue0qj5rL8u+TIStq3KoLXsZcU3rN8qxK2Cnvd
         KK1XMpa99k7Sn8UUFtsJl0Puxk8/tlRCcOX9pRpPlociOUOEns4Rg2UZ1AfQUo1ttFP5
         wou+GsetwANiOvepCorh9CUXlSBwO+EwHsxj9LYr10cdyoALeBLNKrmb8mQbYhkvdg4c
         GxoG25JAlAZWsaDT4dMzpvE8Kn8JIDJN09gqAx2iJSOlNgiex/HenQz1wNOiiaWJsWqO
         uSXXfX8kqLNEaGPUntzUOfue53yd2477kZyHah1Xdtryxm/wxFyl+EbpeT06TGBtu+FA
         GfHA==
X-Gm-Message-State: ABy/qLYK6iltl0S5uU7jYxmyfoy3Fy+rK8NdfOz+l9MLvD4s0F61DF5m
        7wZIOZ7UEY7U0ACyGDWasRDc0Q==
X-Google-Smtp-Source: APBJJlGxjfe+8f0dueDM8FJVBeqmo8FaV87lH6hxyhw26brAOEDJLkiIqQISGZnXhuRl933BiJpaSQ==
X-Received: by 2002:a05:6358:5923:b0:135:43da:b16d with SMTP id g35-20020a056358592300b0013543dab16dmr13986782rwf.11.1689047719453;
        Mon, 10 Jul 2023 20:55:19 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001b872c17535sm688329plh.13.2023.07.10.20.55.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jul 2023 20:55:19 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 7/8] maple_tree: replace mas_logical_pivot() with mas_safe_pivot()
Date:   Tue, 11 Jul 2023 11:54:43 +0800
Message-Id: <20230711035444.526-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230711035444.526-1-zhangpeng.00@bytedance.com>
References: <20230711035444.526-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1ad11799e197..5eb5eede2727 100644
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

