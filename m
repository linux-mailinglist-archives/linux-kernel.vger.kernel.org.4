Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45C670EBC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbjEXDOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbjEXDN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:13:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC21E5C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae79528d4dso4255745ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684898010; x=1687490010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sfx1V5T4mPIwVqP+RrJR35TgWmrm3iAxbhRMi/Gcd/w=;
        b=JB3kp4BJlOTs+7cy33BIr9gKo327JK5pA7ulU3SsjOpt3OCFJdJD7nK6aH5tKH88dJ
         rFNBih93HAFSgVUwvO50dFWu8MWGNidvUluFSfNOqUZpHn6gautW+XcY602ivtqiQmOd
         DHaviW5bqiNIiZr18jVVyRGEvqNQCnp2SPyV9uat+WK4D/AHQ4dwM2H04pC/D3F41xcv
         gUBrRudDRolPnEB+3e8vALOAFWlf6PovASzbMUtuHxm32FFhN4tq1uzAtRRQKIOo2+Fc
         En7/cwMNU5GHxKFqTz8+PyPf7Md0NP/OSjUlmMq5pNdNop7bHIIHzPJ4YWnVZKtXiwBL
         rHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684898010; x=1687490010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sfx1V5T4mPIwVqP+RrJR35TgWmrm3iAxbhRMi/Gcd/w=;
        b=CHV3LnFS7WufxRXJcpu4R1oGCX6bTiYFr7EEAIo5x22tCr0PtRrCcyOe03PnpEA4Y6
         xzXP/HVJdwUisfC7WAP3Pmuz8NQlTQoYXG//27NpsFTRS4PXbECf7F/0dMSFQ/QkL76+
         CXgWPKsmzWpbQJQzP6oqZVyktp8xMqp2oOIhYUvVRdHkdnCd/55wgBXcD884hX9zeOBj
         fi62S5BqP+A9GPA3J/26pLdTzzxJ3etzRKNBa6ehV4LipuXT6B+PNpYbwMicgCi+1xmm
         0i5UWVUku6D9OfNcnQNmdP18PuqqwGPZcXyJWUtAEH/tgihtsAB9hmwmpwEkoM/ApHRa
         12jw==
X-Gm-Message-State: AC+VfDxm6xkDTXqegm3gwG355X5oc8JrpeCtuDGelE6DCouwLv8rBgSa
        L6IQupuT7S6GYRmai2f4q25OUg==
X-Google-Smtp-Source: ACHHUZ6KdkbBdG/NhhrmPGJii84sxlUGH4WE/c+JtFzlhs/OksNqs2HD2kzrCPZt4nc2+TgevXB2ww==
X-Received: by 2002:a17:903:120b:b0:1a6:d15f:3ce1 with SMTP id l11-20020a170903120b00b001a6d15f3ce1mr19866697plh.34.1684898010071;
        Tue, 23 May 2023 20:13:30 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001ab061e352bsm7480769plr.195.2023.05.23.20.13.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 May 2023 20:13:29 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 06/10] maple_tree: Add mas_wr_new_end() to calculate new_end accurately
Date:   Wed, 24 May 2023 11:12:43 +0800
Message-Id: <20230524031247.65949-7-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
References: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e6e42e1ba44c..07c5c7afd415 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4296,6 +4296,21 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
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
@@ -4351,9 +4366,8 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 
 static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 {
-	unsigned char node_slots;
-	unsigned char node_size;
 	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end;
 
 	/* Direct replacement */
 	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
@@ -4363,17 +4377,15 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
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

