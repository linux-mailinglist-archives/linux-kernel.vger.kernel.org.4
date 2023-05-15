Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709E4702DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbjEONTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242153AbjEONTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:19:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56850213D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24e25e2808fso11438619a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684156725; x=1686748725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqadHapDxpeqihp1W5tQfDBPl6INO7/UDDkBv5UKJVo=;
        b=IeSw9vO+5tUCyqhG3uAeGFw3l+kw0p1+xquqjvHnxWcTDJpp+QiZkleh9ZA4o1vRFP
         LFFQ9RUFpkMznTFDy38B1W2fNinp8wPwPa1vtTRBHgSp5UQx6f2PLig0LbQE8kmt6nO2
         QHifAX+73dgUs5UZCtQTdz+QmY/BG7O+cWyKNZ2SpAwB1jo34DRBYtzAt9oEuDSXwuyH
         FZBXRiFYlwH9i0Q+eZJosITIX0uZu/Fe1ibGzExVWrN66H/hxtWiiRn3gHzxcuvN2BUN
         iAM0kqw3LiFeiTNOMvkWinAY0QaMmwaZK+eQhVvcwmAFnAs1R0wdpBUmHRoT/A04NjMv
         2I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156725; x=1686748725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqadHapDxpeqihp1W5tQfDBPl6INO7/UDDkBv5UKJVo=;
        b=WVCw7CGITLrwLkGgjuwyoYSwhhH8OSV5562xvRf3n086cn9fEn2C6TH46HeDh2Uifb
         TYk1eIVvMd4bV1OSI7PLvdk3TQ4rFkOSF+eSsk6cET8ryDGOSdi6FzLL3XQUahKKs1wQ
         sHnC9Y9KWnXkVXmmeHHuTSOK9dCGK/QlgZ+JvCDXMYdyjf5UB0pbfxPzgxeHPUPKoGFH
         yQNJMcBBt6qCjX/as+cGuyGgwPN33jIxZPDw2iiVXlJb8HcxEXq6poqTUGgJ9+CM3tXL
         x+UQ53CudBTww2X4ulE5r700eNbS+A1S98CSP7XD+HMQAnWaitAyxrB9gj5CfaMCO3zk
         K5dA==
X-Gm-Message-State: AC+VfDyFragYkG8oeBKcTtypEK540yy4qdY1R/JcDZNu3NSlOglkdFHi
        CkOaJHVoBIpFty9WHTCah0+wSg==
X-Google-Smtp-Source: ACHHUZ7AvLcqhLLRsd3AKclUfZSzUVQ/4fh1rVvWJLa4GbZzqy5/Ip9c+kJ3AEJMnFSgRXXWzKoXXg==
X-Received: by 2002:a17:90a:1fca:b0:250:d293:5d9d with SMTP id z10-20020a17090a1fca00b00250d2935d9dmr18534359pjz.43.1684156724763;
        Mon, 15 May 2023 06:18:44 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm14190014pjb.6.2023.05.15.06.18.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 06:18:44 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 07/10] maple_tree: Add mas_wr_new_end() to calculate new_end accurately
Date:   Mon, 15 May 2023 21:17:54 +0800
Message-Id: <20230515131757.60035-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
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
index ce695adc670ec..20082ef8c396c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4301,6 +4301,20 @@ static inline bool mas_wr_replace(struct ma_wr_state *wr_mas)
 	return false;
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
@@ -4356,25 +4370,22 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 
 static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 {
-	unsigned char node_slots;
-	unsigned char node_size;
 	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end;
 
 	/* Attempt to direct replace */
 	if (mas_wr_replace(wr_mas))
 		return;
 
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

