Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7A173199E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbjFONLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbjFONLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:11:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648B226B1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b4f95833c7so12705665ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686834651; x=1689426651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh1upVsLkWtnKrYRXZBQpn/CVX3v0vcX/4UFjQ1Vcrw=;
        b=PnvoyOBWI0174VERzdCx/bjEaYkDquh7yUGjQ50/UMkljqo5RjJXjL/cpgyU0TzpL0
         eH4VXPKnzVaqjcP0gOrMx+1QHFabhbbyvY/b0lpA7NNL3TpSSbiM5VkBsMKRfz9VcWo2
         lFwoUO7O78+d9CNvG3CfhEJFuWdZ8b1+UY+22FceCZ1Z5L8AhIi7hCMxeK3Nv8H36S9l
         rpau8waC19HwkB9lNxumaKNM/lwcYVUZc1+ee++CYY+F7cyGfZ46ler+HLrq1LcRvZAN
         eQsUxGjTPIwUCUuGKYO2Lmqr+uiqKzT6QsnoYFz+N2wYgGq3hiijfpQwjmPzO1Qqg6X7
         no0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834651; x=1689426651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rh1upVsLkWtnKrYRXZBQpn/CVX3v0vcX/4UFjQ1Vcrw=;
        b=FPjfkBK4VscN6vbOSofvMw2Qw4FD1Kehmudr4zvuVhzHroHobCxBsS5vEtfrR8T6pp
         en2esUDEdONuqo7iRVScA9lW1Z4UDFnq44FPd5salKoe8LlxAbmJGeGKnpnn3QUKftdv
         ZaAlivtHoKwJI8J19zWGRc/1L2tHa2wfkQ7c25vF9fZ2hh08QMwqNynAO+GWz00XNFCI
         kF9ihrIgts0H6OHBPv1daHPDCPVkH5IxHKOIhxB3DDN++FUH1OscON8JQJbLPYUTz2pF
         BzwOJASeFASmsRWbJC4FFkfU60UdC4zMoMQpgjdRCYBWF7wtKNIgIbvnnKNF4lgV+HFo
         Ul8g==
X-Gm-Message-State: AC+VfDw9Zj4+JRxytXvRCC5uvjhhEfHzqa2PuQD87HYDluwZlRTM5KRK
        f/vBkHcaIRVkTV390pYUjsnoGl9/yfFA2Xv5/XE=
X-Google-Smtp-Source: ACHHUZ6kYlTrHFDEkqjnopSe0wt5bMIuHrwtTI/7vuPr5aH9vc14N6FGbaSoQP1LNTuYXmE9OOVpYg==
X-Received: by 2002:a17:902:7042:b0:1af:fd3a:2b7d with SMTP id h2-20020a170902704200b001affd3a2b7dmr12733721plt.48.1686834650878;
        Thu, 15 Jun 2023 06:10:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b001a804b16e38sm14036019plr.150.2023.06.15.06.10.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 06:10:50 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 7/8] maple_tree: replace mas_logical_pivot() with mas_safe_pivot()
Date:   Thu, 15 Jun 2023 21:08:58 +0800
Message-Id: <20230615130859.21858-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
References: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
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

Replace mas_logical_pivot() with mas_safe_pivot() and drop
mas_logical_pivot() since it won't be used anymore. We can do this since
now all nodes will have node limit pivot (if it is not full node).

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index becb4c224e57..4c9f40322f5f 100644
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
@@ -4911,7 +4884,7 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
 	min = mas_safe_min(mas, pivots, offset);
 	data_end = ma_data_end(node, type, pivots, mas->max);
 	for (; offset <= data_end; offset++) {
-		pivot = mas_logical_pivot(mas, pivots, offset, type);
+		pivot = mas_safe_pivot(mas, pivots, offset, type);
 
 		/* Not within lower bounds */
 		if (mas->index > pivot)
@@ -7003,7 +6976,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 
 	gaps = ma_gaps(node, mt);
 	for (i = 0; i < mt_slot_count(mte); i++) {
-		p_end = mas_logical_pivot(mas, pivots, i, mt);
+		p_end = mas_safe_pivot(mas, pivots, i, mt);
 
 		if (!gaps) {
 			if (!mas_get_slot(mas, i))
-- 
2.20.1

