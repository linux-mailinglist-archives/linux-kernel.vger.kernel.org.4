Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C3702DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbjEONTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbjEONTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:19:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C642737
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-250175762b8so11100748a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684156730; x=1686748730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RjXFpMPucyoGVPKV00U7wCkXQqL8U9B4PmEKn2WMSk=;
        b=g3X23mAk6kwEgqva0ZnSNN22eZiDL8T82so2num2UEwvQuEHuuabGkvETt7Q66yOlo
         7sCxUGlSRdfbawSg3H0s/f5vwrXh9sR2wEApaj6MSgjyAGwixK4D0O2KZEF4rn3SMhPa
         7odAfMZB0Nola4ha7jDUcXu/FzIHyu115GV8+4COEOE7VZVh9PVShj6IGKWcE/s5HgMV
         KcnfgrjKV4nHeILCPRy5qr06r+9wwiHpSwWOiSSOdk9njUM6w2RMr9csBkiWBy2Zh6OQ
         WZBKoSB8Mo2MD6Aozp/k5sI8+7i4+WxTVhsda+0VLxHL046q2kNIfpbtrRezaW6YALmf
         VZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156730; x=1686748730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RjXFpMPucyoGVPKV00U7wCkXQqL8U9B4PmEKn2WMSk=;
        b=GYh9yXhV+6yzCUSMzUMeCkj/SvLGyutkv4vxtynYbvLjr7fTCkNHTIThmhHo5YOWn1
         pRng1uwOvzQWFdTZvGc4l1mvHNCWL0wbC8sAJn9LsQYPZHoEKOy4ibDhC2Dt6ukgHb9u
         /SVnKnCES4ow8uwMDxvBWqU8jiMlV6Hu31OFg0XqmXfmnuM5vhL0BO1DoBu4sXWT4bmD
         8igv7zsjpQuL478vPPypnqvNA/Y39qsKf5uw6AeOynfhedimCACTTdhTnbEwp7SQfBr+
         6HLAs5qtxTuvxSp6D6Kl04C7boQcwuF+z+EcMU1bJdsimbAZd2flnaOhrtPeSrJRxlgN
         1xNg==
X-Gm-Message-State: AC+VfDzCOOJLiUE7BAIZX+YUCF4mvuxKwsvkRiSxDLaq1TdcgjPygvL5
        5J3U2xMoqfJszKrscOtrLEhTwQ==
X-Google-Smtp-Source: ACHHUZ5n5S0O2+y/OHwn/QDCzc28Z/yx4dDmMDqn2V1pFtwTJV3ORG2KtE90A+CWdcAodTDHpHLsbA==
X-Received: by 2002:a17:90a:cb93:b0:250:939f:70a0 with SMTP id a19-20020a17090acb9300b00250939f70a0mr24132189pju.14.1684156730303;
        Mon, 15 May 2023 06:18:50 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm14190014pjb.6.2023.05.15.06.18.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 06:18:50 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 09/10] maple_tree: Rework mas_wr_slot_store() to be cleaner and more efficient.
Date:   Mon, 15 May 2023 21:17:56 +0800
Message-Id: <20230515131757.60035-10-zhangpeng.00@bytedance.com>
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

The code of mas_wr_slot_store() is messy, make it clearer and concise,
and add comments. In addition, get whether the two gaps are empty to
avoid calling mas_update_gap() all the time.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 79 +++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 538e49feafbe4..d558e7bcb6da8 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4190,53 +4190,62 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
  * @wr_mas: the maple write state
  *
  * Return: True if stored, false otherwise
+ *
+ * Case 1:
+ *                       r_min   r_max    lmax
+ *                 +-------+-------+-------+
+ * original range: |       |offset | end   |
+ *                 +-----------------------+
+ *                         +-----------+
+ * overwrite:              |           |
+ *                         +-----------+
+ *                        index       last
+ *
+ * Case 2:
+ *                       r_min   r_max    lmax
+ *                 +-------+-------+-------+
+ * original range: |       |offest | end   |
+ *                 +-------+---------------+
+ *                             +-----------+
+ * overwrite:                  |           |
+ *                             +-----------+
+ *                           index        last
  */
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
-		return false;
-
-	if (offset == wr_mas->node_end - 1)
-		lmax = mas->max;
-	else
-		lmax = wr_mas->pivots[offset + 1];
-
-	/* going to overwrite too many slots. */
-	if (lmax < mas->last)
+	if (offset_end - offset != 1)
 		return false;
 
-	if (wr_mas->r_min == mas->index) {
-		/* overwriting two or more ranges with one. */
-		if (lmax == mas->last)
-			return false;
-
-		/* Overwriting all of offset and a portion of offset + 1. */
+	if (mas->index == wr_mas->r_min && mas->last < lmax) {
+		/* Case 1 */
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
+		/* Case 2 */
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
 
@@ -4418,7 +4427,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
 		return;
 
-	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
+	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
 		return;
 	else if (mas_wr_node_store(wr_mas))
 		return;
-- 
2.20.1

