Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DFA740ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjF1IKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjF1IFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:05:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C6419B1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:04:12 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso3873679276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687939452; x=1690531452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8I7ZZT06jrIJroiCeY6eBIpR5P5K4jSqkyyySmW3xI=;
        b=OA+Jjuyz7hYDsggc8y/xtAxeS0GILvR6GdLQxEv+Pj4AfHnD4vC7+YU6HDJzHdxiSM
         klCun0l5ReNEzceWWxecaDG9Sb+j++54KEp12A3WSYo7TioS3ZRHzZUIBGtYd5mwwZMl
         tDsmPFCJS4e1rM2mqwiyyC8WPga3VkrPt/A9ABYlRERRYQH/47d/DXYOmdspLYZfqYfu
         9Yuy5VALYTz9S81M3fD/3P+GkQBixbNY0ChyZJnYsK8H/KlAkxSfVuJ63J4HQ91mXfMR
         j9McCkLO/Ddv77LHInLUmTwavSEAyeFfvJBXcAM9Ic7MVXXs+LHdkDuLPDGRHoy0r+ZR
         hE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939452; x=1690531452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8I7ZZT06jrIJroiCeY6eBIpR5P5K4jSqkyyySmW3xI=;
        b=ReGQ9M7fcMiDK3iR2UYJLxcQyAyNi41RtScHpK3X5CZVioKN4nUyLyZAoSDH6YlAjx
         2+FZuR4/+vbzUEuQ6tPjigZR0jCIM71S5+6fiwujig4mzP1GkEkUDKJMYcXrnHRyhtq9
         zNSTxLKPt78f+ho4SKtLa06BmV/bxxKXAE47YerMrEfo1fJC+qBjJHgPGZfhoEBUnWBQ
         JplL3nb+QCV+nQcMIB0m4nekW97CUsLsMm0cL4yHrGA/tEEAs6JN5DGxsERZ5iK47Mho
         PAhKbWaEdadLM5pMt3aGfmfSH4Eo9AjKysSW6ENHRX609KsCvhFT+Qu5hVvHocK6eiEU
         yW8Q==
X-Gm-Message-State: AC+VfDzVJMJ1mfZD+H66I5HT5Efro2jlhXb02iGs/Ww6eHR5TjOJGY5M
        KhVCq1yLELWAUagObe2nNv+BBqBBRPGV89BvTtuXWQ==
X-Google-Smtp-Source: ACHHUZ7p1BvjmM5/N4UfcgB+uJA4Wvbbz5hy0eN+ZhFEnki+h46GuQ6T2BniuMUzs+bIQ6Q1mK8/7w==
X-Received: by 2002:a05:6a20:4422:b0:129:f768:27a4 with SMTP id ce34-20020a056a20442200b00129f76827a4mr7356161pzb.41.1687937841300;
        Wed, 28 Jun 2023 00:37:21 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001b8021fbcd2sm4836988plb.280.2023.06.28.00.37.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Jun 2023 00:37:20 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 4/4] maple_tree: add a fast path case in mas_wr_slot_store()
Date:   Wed, 28 Jun 2023 15:36:57 +0800
Message-Id: <20230628073657.75314-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230628073657.75314-1-zhangpeng.00@bytedance.com>
References: <20230628073657.75314-1-zhangpeng.00@bytedance.com>
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

When expanding a range in two directions, only partially overwriting the
previous and next ranges, the number of entries will not be increased, so
we can just update the pivots as a fast path. However, it may introduce
potential risks in RCU mode, because it updates two pivots. We only
enable it in non-RCU mode.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 56b9b5be28c8..db3be8274660 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4167,23 +4167,35 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char offset = mas->offset;
+	void __rcu **slots = wr_mas->slots;
 	bool gap = false;
 
-	if (wr_mas->offset_end - offset != 1)
-		return false;
-
-	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
-	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
+	gap |= !mt_slot_locked(mas->tree, slots, offset);
+	gap |= !mt_slot_locked(mas->tree, slots, offset + 1);
 
-	if (mas->index == wr_mas->r_min) {
-		/* Overwriting the range and over a part of the next range. */
-		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
-		wr_mas->pivots[offset] = mas->last;
-	} else {
-		/* Overwriting a part of the range and over the next range */
-		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
+	if (wr_mas->offset_end - offset == 1) {
+		if (mas->index == wr_mas->r_min) {
+			/* Overwriting the range and a part of the next one */
+			rcu_assign_pointer(slots[offset], wr_mas->entry);
+			wr_mas->pivots[offset] = mas->last;
+		} else {
+			/* Overwriting a part of the range and the next one */
+			rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
+			wr_mas->pivots[offset] = mas->index - 1;
+			mas->offset++; /* Keep mas accurate. */
+		}
+	} else if (!mt_in_rcu(mas->tree)) {
+		/*
+		 * Expand the range, only partially overwriting the previous and
+		 * next ranges
+		 */
+		gap |= !mt_slot_locked(mas->tree, slots, offset + 2);
+		rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
 		wr_mas->pivots[offset] = mas->index - 1;
+		wr_mas->pivots[offset + 1] = mas->last;
 		mas->offset++; /* Keep mas accurate. */
+	} else {
+		return false;
 	}
 
 	trace_ma_write(__func__, mas, 0, wr_mas->entry);
-- 
2.20.1

