Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C571702DED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242244AbjEONUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbjEONT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:19:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC6F2710
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24dfc3c662eso8556481a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684156727; x=1686748727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZYylnYxW+ETURaA5WORPRH9YUugjQDKMo5It+GAwgw=;
        b=DPCRZ8PeVk1ENmOw52Z4ScPAKBiBTNsBCVNhldQbntOjXs6YxIBoJg714Omnu0afA0
         zLGyzQ1A5K2TjqjCmQzNeqSRW3COE5zPefIhvLUj/Crqmo8UwQUio/fNg0PgZcoBikON
         zVBn1YYEGaayJt5l73HdrrEcbmkQY77TbGi3x4JLLXEgnDL47DabM9MSP32oohkmterc
         GN47DENhqMPgATZtYIw24/XavgPj+Qgkwx07ymQGqty/GVBBeFDSpZj2AIWedhbl43SS
         JQkTuP1mYv/7GA3VbvoaGdzMSswSjyL84Y11OsgVsXxMg7pINKoAGiGJtOvgf780ZDTS
         A0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156727; x=1686748727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZYylnYxW+ETURaA5WORPRH9YUugjQDKMo5It+GAwgw=;
        b=S37jNbh/gHIKWepEuSTya+XBcWW5ovfcz+w/VAdKzLA8T8R+mfGF0sr8v9SUO+8F4D
         FCD5PwTTLZNDlkuoY4/CxHaiAvtoDqesOgsatvOnGZ8FRRzVAlI2kf2NkYnaZ4OEW21D
         FdMcxlO+UCW3+R8NbrA3sb7aXW4zllC8FW9bXlzK2ByNT/MmNOJv6nzeqhFEKDTtWBMH
         c0Xlyct21DsRS7Ws0VI0zhdHEP/CLZ8nKjTsz5UYk2Q7cBmYOtiZHGH+I3aaiQe4jY+h
         zlUVCW7VL4tre3yswimP7m3C6+B5xAQYuOMz8Pvb9GRM1AKNalkf5twX+paEcn2b/hDW
         TmcQ==
X-Gm-Message-State: AC+VfDz5kvSzuePcmaqLT5wpQkNARKmkW/JqCmVpEai1FNgjP196jIez
        SBxzrKJ64iUD5fSRNh8yQUqK7/bEssPdDlAg1QI=
X-Google-Smtp-Source: ACHHUZ5C3a8EuB22F2PmBbCR3ZqQP/cE8EemzucBxOnJ66cgYoelctIkw/FI/byhP2XlRFxSjJgcXQ==
X-Received: by 2002:a17:90b:3ec2:b0:250:ca6c:d7a8 with SMTP id rm2-20020a17090b3ec200b00250ca6cd7a8mr20083096pjb.29.1684156727502;
        Mon, 15 May 2023 06:18:47 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm14190014pjb.6.2023.05.15.06.18.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 06:18:47 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 08/10] maple_tree: Add comments and some minor cleanups to mas_wr_append()
Date:   Mon, 15 May 2023 21:17:55 +0800
Message-Id: <20230515131757.60035-9-zhangpeng.00@bytedance.com>
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

Add comment for mas_wr_append(), move mas_update_gap() into
mas_wr_append(), and other cleanups to make mas_wr_modify() cleaner.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 52 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 20082ef8c396c..538e49feafbe4 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4315,6 +4315,31 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 	return new_end;
 }
 
+/*
+ * mas_wr_append: Attempt to append
+ * @wr_mas: the maple write state
+ *
+ * Return: True if appended, false otherwise
+ *
+ * Case 1:
+ *                       r_min   r_max/end_piv
+ *                 +-------+-------+
+ * original range: |       |offset |
+ *                 +-------+-------+
+ *                             +---+
+ *      overwrite:             |   |
+ *                             +---+
+ *                           index last
+ * Case 2:
+ *                       r_min   r_max/end_piv
+ *                 +-------+-------+
+ * original range: |       |offset |
+ *                 +-------+-------+
+ *                         +---+
+ *      overwrite:         |   |
+ *                         +---+
+ *                       index last
+ */
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 {
 	unsigned char end = wr_mas->node_end;
@@ -4322,7 +4347,11 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char node_pivots = mt_pivots[wr_mas->type];
 
+	if (!(mas->offset == wr_mas->node_end))
+		return false;
+
 	if ((mas->index != wr_mas->r_min) && (mas->last == wr_mas->r_max)) {
+		/* Case 1 */
 		if (new_end < node_pivots)
 			wr_mas->pivots[new_end] = wr_mas->pivots[end];
 
@@ -4330,13 +4359,10 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
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
+		/* Case 2 */
 		if (new_end < node_pivots)
 			wr_mas->pivots[new_end] = wr_mas->pivots[end];
 
@@ -4346,10 +4372,13 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 
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
@@ -4385,12 +4414,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
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

