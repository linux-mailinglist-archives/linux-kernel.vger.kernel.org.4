Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A670B457
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjEVFIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjEVFID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:08:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCC5106
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d5f65a2f7so626681b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684732059; x=1687324059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDMhWhfLT89+67MaNw9E+3uh4JNyHlNzHsoiSP1QJPc=;
        b=YlZq8QeeFnwwN2PMnEu5ygiKTeL4TXc//yTBc0oVeHrSXzMJ8uRzfTDuP/PHlcM7UW
         hB9faQCix3KctJUaLZtd2UmZWfZ8Mfvt+myVSFtECmxjw+131ONog441mxQnYKz6dX/G
         FSnXiGW4od/KD+uyoierDNkcRBeklQL4FdrVA4CEWtOQ4uiJsFFsNHRgKdBvfALKLTVg
         DiFw3TJH9fb+KQulmNmJ1EB91in05l8bU2ap+Q70ZEOc1OoIOwCQuPhzBfcNlI7ADW01
         xedz/T1eaNokKIMlAOtxmDXSzEUaUcieUHu/oXtk7OoUM6aiztzo2QZUarBT18g6KS/c
         Kp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732059; x=1687324059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDMhWhfLT89+67MaNw9E+3uh4JNyHlNzHsoiSP1QJPc=;
        b=OgCE1yb/wuEeJg2NbMKGX4WKxvsaGKQTNz3fQwRGcoFJF8LOj/lrBLl2Y5gmAMnklf
         UIAGXUojAE00ru+10iH3fwODX3xk2R67ZwjzjA2fwBs3ktBgJ6+yvBZ32tkVLA3MOiuL
         IVp/RvrVrtd2Ok+1Ec4w6HQSHbT950fFB1l+Csmwlt37xCQAAPkMJOenUxa9VBcwQY1o
         N82lIhiFvyLO3K7Qc+nQpjtk8A6oNVPZKAl1NOD8VErqivPj3e8OkIdiX0JUTgkgMYHC
         og490p+Ovqp82VpeJqhxD974yB9PDjjeb2inzsCLt9tFTYLoPROkbGTd5nrbr/ozBN0j
         KFPA==
X-Gm-Message-State: AC+VfDxVLyYF1AgIqZZZSmO94Y1uEggBnnDZQC9OFowS1vL8w6bJS8yX
        Pq444I2XzRxyqICvFr6kpk7SL62oufNGqcnjwkk=
X-Google-Smtp-Source: ACHHUZ4G3ndXt0xInsw23oUAUWy0+eARJcOZ0g5BmWYjBmghjVZs6D0v9IRLXKJFPEcYPqYrYeIEyA==
X-Received: by 2002:a05:6a00:845:b0:64a:f730:154c with SMTP id q5-20020a056a00084500b0064af730154cmr13394825pfk.13.1684732059192;
        Sun, 21 May 2023 22:07:39 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b0063b5776b073sm3247519pfh.117.2023.05.21.22.07.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 22:07:39 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 07/10] maple_tree: Add comments and some minor cleanups to mas_wr_append()
Date:   Mon, 22 May 2023 13:06:53 +0800
Message-Id: <20230522050656.96215-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
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
 lib/maple_tree.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0550a07355d7..afbfdcdde5db 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4312,6 +4312,12 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
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
@@ -4319,34 +4325,30 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
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
@@ -4386,12 +4388,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
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

