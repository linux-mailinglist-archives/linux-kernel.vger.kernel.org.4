Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C17298FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbjFIMFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240295AbjFIMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:05:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F01D1A2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:04:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-653f9c7b3e4so1324755b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686312280; x=1688904280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThxP1hd6NEaJLYq/dTfUmO4X1zEOytHqUc71DH0irxQ=;
        b=kMMLpjBwxBk6nSkMVj2MvpBmf13W42BxXy8TzuQQLpO1GcgdjEnhCRcGYOseOwBWN9
         p2PamcOYR13FsRJBqxk/qPIzItSO1QQIWMo7G3dN+QyrlK9Grk8SkdJxDikiQeP4Es7U
         y+z7xVJIbraUjhaDT0+yEkT8TIBWpFLDTvMhgkiXeO+iqB/LcWp6nufUcz+Vwh06+eIv
         K1H3DsHCciHA0j6sg69MIn40X2CsiibTE9IiJuYta8HibBzJWhjRYVzwj1oYEJHlu8Ws
         TnEQvPGQulRU6wMKpNfJX3UD6UnfTmez4XNWpUcZFQHLg6hAQILHJUG+xr9h8u8nRftx
         jFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312280; x=1688904280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThxP1hd6NEaJLYq/dTfUmO4X1zEOytHqUc71DH0irxQ=;
        b=Dl+2NqHRATFZ4s9UL6qmw2GGHCCnrv1+oB2dDxJJzV3SVsQrUueuV603jE8dVSadfw
         aaLtigw4aL1WgvgVLJF2WwNe+BDCh2SnPl8n+KoEFfx69h7hwtAlhc/fLlW47trZjzez
         JU0HGfAw2v4vyYXNzP6c7nIwV8YprAqNH5ag9T3k25jZ6+x5Ia5hmiEZmbn3oT++VeVh
         bJiLZAu6ZRLHqRCk4NW2MpRfO6jQX2Pgqw8kSRBZuYKWULD2ahGd/6dTnox064ZoZojP
         O89si2Pn/UM2Hwi9/BUFuPJcSIC9tikftqBq4njgjNqWoJnWUmuLZCZAw8hQT0Wo7jSY
         vCAA==
X-Gm-Message-State: AC+VfDx6JKAjmfnagYmh1HAE41zAGpqkQ5f+5/vrCgXTP+tWvjbAD78Q
        f0BFxT0SJl95posDMad9n+iCjg==
X-Google-Smtp-Source: ACHHUZ5VTTHHjw53wUTNz1vUMTc24VjUz/r/h9LU8ikZx7DTRD/CLTI0AgOZICIklb1Pe/GoYz6dvw==
X-Received: by 2002:a05:6a20:1445:b0:111:2f20:d48f with SMTP id a5-20020a056a20144500b001112f20d48fmr803105pzi.53.1686312280069;
        Fri, 09 Jun 2023 05:04:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id v12-20020a65568c000000b00514256c05c2sm2619168pgs.7.2023.06.09.05.04.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jun 2023 05:04:39 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 3/3] maple_tree: add a fast path case in mas_wr_slot_store()
Date:   Fri,  9 Jun 2023 20:03:47 +0800
Message-Id: <20230609120347.63936-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230609120347.63936-1-zhangpeng.00@bytedance.com>
References: <20230609120347.63936-1-zhangpeng.00@bytedance.com>
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

When expanding a range in two directions, only partially overwriting the
previous and next ranges, the number of entries will not be increased, so
we can just update the pivots as a fast path. However, it may introduce
potential risks in RCU mode (although it may pass the test), because it
updates two pivots. We only enable it in non-RCU mode for now.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a96eb646e839..d3072858c280 100644
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

