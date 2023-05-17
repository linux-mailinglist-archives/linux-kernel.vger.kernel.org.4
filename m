Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB9706375
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjEQJAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjEQI7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:59:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0054225
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5343c3daff0so312921a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684313949; x=1686905949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2NEt2xRNbAeMZlKbxLJ6YsB/xGL2Lb8EXzhG/zDA3k=;
        b=e3RVLiwnNDJjglhqaPR32b6FAYRWgjhUEJc1A7SpY9YkqYyI5oHyho43Tedkc5zwus
         aHgi1ZYqf7Cq4ND0XTOXDujMqiX5bzPJy2RZGibIBcrC/k5/aMp84AxWTf/aP2NCWhIR
         DyblUWcmvnVlSZKV9373659tbRllyKFikIOF1Wfpt8NGfxpcQs03vxNQpA/54vh1ICpj
         3Zad9u1jj7xtrGQSXDJwfJJMXsx5fPPJuqUZwLmDSF7zeZdf4rOhSEhSkNvecFV/UIdg
         t7/KJsstAhtGxvKIJXclrTbcZed6B0ndQUqrgy0QJJ0XpDY0DFK9iHTZbSnQnWRdjhrP
         E4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313949; x=1686905949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2NEt2xRNbAeMZlKbxLJ6YsB/xGL2Lb8EXzhG/zDA3k=;
        b=ktNTFQRppMFmBEIONQhWociQ6jpPjzRiHMJ1IO67RQvsDUG9UPUd0ernsjBrokJnRc
         B0aoe+KixCHfbmwdNAZ1tnwwbN+D1SSfV09VNS33z/llb7eDPIKZ1WXSv80cX2+w0gPi
         a02K5zCVMGuZJn4/d3qlqVyDDfZcQPURrwsnhskbDKaSDjENffey3zhZyvGAWVyruXMB
         lC1QL/yWNMgOo4UwlzqPxo2VCRBhg8WD7Kc8XygEOXk5dJbOPoRMFxtUSgCh1vPm9o99
         bGUpcGUEyyyL8vdzrcPt7ebIqcW/b0foRwGhSr0iSOPfR44WIPtjlm6k8cchLRXzq7cq
         KsrA==
X-Gm-Message-State: AC+VfDz3GrwzK1WUzGAYu2tq6clN1e6rIV9D0DaQiiNnYiWu0JXuNODL
        0eRYAE3CB5ao2cqGIbBd9E5MWA==
X-Google-Smtp-Source: ACHHUZ5b7PIeql3DsYG38mUQCLvjrV3k1K4DbQmsm4PKRgFsDr9YaB+sYp0r5E81HI1DCdL6LBOLFg==
X-Received: by 2002:a05:6a21:150f:b0:ef:7aa2:3cfd with SMTP id nq15-20020a056a21150f00b000ef7aa23cfdmr35267926pzb.50.1684313948739;
        Wed, 17 May 2023 01:59:08 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m18-20020a63ed52000000b0052c9d1533b6sm15056765pgk.56.2023.05.17.01.59.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 May 2023 01:59:08 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 08/10] maple_tree: Rework mas_wr_slot_store() to be cleaner and more efficient.
Date:   Wed, 17 May 2023 16:58:07 +0800
Message-Id: <20230517085809.86522-9-zhangpeng.00@bytedance.com>
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

The code of mas_wr_slot_store() is messy, make it clearer and concise,
and add comments. In addition, get whether the two gaps are empty to
avoid calling mas_update_gap() all the time.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 59 ++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bbe4c6f2858c..25a8b7d5d598 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4200,49 +4200,38 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
 static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
-	unsigned long lmax; /* Logical max. */
 	unsigned char offset = mas->offset;
+	unsigned char offset_end = wr_mas->offset_end;
+	unsigned long lmax = wr_mas->end_piv; /* Logical max. */
+	bool gap = false;
 
-	if ((wr_mas->r_max > mas->last) && ((wr_mas->r_min != mas->index) ||
-				  (offset != wr_mas->node_end)))
+	if (offset_end - offset != 1)
 		return false;
 
-	if (offset == wr_mas->node_end - 1)
-		lmax = mas->max;
-	else
-		lmax = wr_mas->pivots[offset + 1];
-
-	/* going to overwrite too many slots. */
-	if (lmax < mas->last)
-		return false;
-
-	if (wr_mas->r_min == mas->index) {
-		/* overwriting two or more ranges with one. */
-		if (lmax == mas->last)
-			return false;
-
-		/* Overwriting all of offset and a portion of offset + 1. */
+	if (mas->index == wr_mas->r_min && mas->last < lmax) {
+		/* Overwriting the range and over a part of the next range. */
+		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
+		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
 		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
 		wr_mas->pivots[offset] = mas->last;
-		goto done;
-	}
-
-	/* Doesn't end on the next range end. */
-	if (lmax != mas->last)
+	} else if (mas->index > wr_mas->r_min && mas->last == lmax) {
+		/* Overwriting a part of the range and over the next range */
+		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
+		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
+		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
+		wr_mas->pivots[offset] = mas->index - 1;
+		mas->offset++; /* Keep mas accurate. */
+	} else {
 		return false;
+	}
 
-	/* Overwriting a portion of offset and all of offset + 1 */
-	if ((offset + 1 < mt_pivots[wr_mas->type]) &&
-	    (wr_mas->entry || wr_mas->pivots[offset + 1]))
-		wr_mas->pivots[offset + 1] = mas->last;
-
-	rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
-	wr_mas->pivots[offset] = mas->index - 1;
-	mas->offset++; /* Keep mas accurate. */
-
-done:
 	trace_ma_write(__func__, mas, 0, wr_mas->entry);
-	mas_update_gap(mas);
+	/*
+	 * Only update gap when the new entry is empty or there is an empty
+	 * entry in the original two ranges.
+	 */
+	if (!wr_mas->entry || gap)
+		mas_update_gap(mas);
 	return true;
 }
 
@@ -4396,7 +4385,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
 		return;
 
-	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
+	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
 		return;
 	else if (mas_wr_node_store(wr_mas))
 		return;
-- 
2.20.1

