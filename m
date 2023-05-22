Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F56B70B456
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjEVFIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjEVFIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:08:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42E9115
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d18d772bdso4779421b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684732056; x=1687324056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZz+uQjmpOdIMxeiaJgwUz4BoyhUknFLXJa8Z3V7HsI=;
        b=jgMP8vdBmcOPewxDkJjBZQcf60lixgiNyhCEEOeGGUIpPNqCfsdnSzzeIL2MICM/0R
         dmJuRkdPDnNnSfKA/dr8EkxfvxBIxP3R4j2iiulIlRGcVDmX8Lct+JSE/lMFq5EGDBJD
         MKnUiIMoKHSCObK01IPby8K5It8XOEKZYIVlGoZ/mgPiqAD4vHLsmTpUhZE3oIODEi3b
         gvn0IAyhVkAuotI9HrMW1aiOaWcC/Lor8mMrbNnXu6jNXIDwgJtEi3y5StnbZsqWkZvM
         nF9BxiVrMtuDUA0UL2yAdW5NJdF+KXKc+Ue8A0yBVtprddy7h6bpFr1gPiOXTD9l0MZY
         9rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732056; x=1687324056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZz+uQjmpOdIMxeiaJgwUz4BoyhUknFLXJa8Z3V7HsI=;
        b=iinADj8hceVEp03t2foPuDVS8n5iGfDTSgyovYln1eWWFcppkJUkM/bV95Yya965KP
         mV+av3+5JebbS8hUUipAxFKgXmzOl94r6Ch/3KLpXiWwmcwr3t8x/By4+nbWWUDgD0tz
         X6T67AewR/IZIB349wqY4st8KMk0mY+CzudU+H6xE/HeFSabj90MN2K9+UD7WwxoXyre
         x7hwcMZikGLBN77HFbq+8IzVqB5XopgNPYuFjrmR0cQNjkcJfoJ6pewe6zTxG1JXomSi
         cm5kDOg8YfgCmQy2gB07RcAm9X7DM3gjdD9/V6fueziaCBCDV1kP4FXtpQ7rupn5lgxO
         915A==
X-Gm-Message-State: AC+VfDzbOYj4vy2xkchV5jznkziTczNr8CBBWhqvG5+VvQAtTtEOu6X7
        Sx6ayzA9AOyE0maMEt59CAvS63NIiV/lXXc1qTE=
X-Google-Smtp-Source: ACHHUZ7kqirc8A3D4h9wAwED0RDK5kYc00X56oQezZL6FCZscI345O1qs97um4cy07jU4YV8E3R45A==
X-Received: by 2002:a05:6a20:440b:b0:10b:e88f:598f with SMTP id ce11-20020a056a20440b00b0010be88f598fmr916141pzb.51.1684732056314;
        Sun, 21 May 2023 22:07:36 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b0063b5776b073sm3247519pfh.117.2023.05.21.22.07.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 22:07:36 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 06/10] maple_tree: Add mas_wr_new_end() to calculate new_end accurately
Date:   Mon, 22 May 2023 13:06:52 +0800
Message-Id: <20230522050656.96215-7-zhangpeng.00@bytedance.com>
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

The previous new_end calculation is inaccurate, because it assumes that
two new pivots must be added (this is inaccurate), and sometimes it will
miss the fast path and enter the slow path. Add mas_wr_new_end() to
accurately calculate new_end to make the conditions for entering the
fast path more accurate.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 562507979a4b..0550a07355d7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4297,6 +4297,21 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
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
+
+	if (wr_mas->end_piv == mas->last)
+		new_end--;
+
+	return new_end;
+}
+
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 {
 	unsigned char end = wr_mas->node_end;
@@ -4352,9 +4367,8 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 
 static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 {
-	unsigned char node_slots;
-	unsigned char node_size;
 	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end;
 
 	/* Direct replacement */
 	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
@@ -4364,17 +4378,15 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
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

