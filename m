Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828C4731288
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbjFOIo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238198AbjFOInq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:43:46 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066DC294E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:22 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f9cf20da1dso26909091cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686818601; x=1689410601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k+8W6YpzHgSdUoJtesRB/pITjbosIv5ydX8Qu9f+Qw=;
        b=L9gTbOitjaiPVT1mPvKyA+1gkxVyHMUzILsZcki0A+ChBTywUw6NohiYLb1g1Ardc1
         kMAEK5cFZZyUlbGGsMPuTdcRTmS+qB9DFC4KgbL+jedtkpUufHaDhGxSORQtenv5dxno
         53zz55fJrTGOcwFkp3egUxDvqcto70rlu4gNyigvXcG/YlYSDa5Yehb8/c3sY9VPVH+W
         OTskE0Q7hvjBIGv50tIr95U8WiwV8dHyfjmjSvCSn45KdtpRTCdehu9SH6SLo2PF+1ik
         scfWicjFjDVMCw1azV116jpQLpvcldBAYY2FooqN0XwEDKBgjANfcgs0fzIgdXbiEPZC
         MxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818601; x=1689410601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k+8W6YpzHgSdUoJtesRB/pITjbosIv5ydX8Qu9f+Qw=;
        b=O+YOEd8r0emKqihGDHOVCAqPYxtVN0CTL8AvfpJDg4ZBAy89OJt9xQxk0u2SO1uQHy
         P0cdAoeyePlObMJoykylnMKUCgd3eVu6O45ZcOu6MtfS61gbLRvwmmLmvf1M4S7QBzen
         CPJkercWkhLBJ48YlQCl/okNfFnzEtgSR8JBRjczYI8TCKxPcJhRFpoY8Pq63MIMBD6L
         iNgfDuDlAF7Kh46gdpniUSHLeS4PpgmLfF7goSAck4SmFlOYt2HxN8UdV6qtcy5PrIPC
         Ek2jVHFwVeqnpvHLK0q3WxMrXqnUJ4yzns0SokZl2Y176LrWn7bihskPyAWB1C99XfRV
         yv8Q==
X-Gm-Message-State: AC+VfDzdsL5Urwf8CabMd0pj1y5CHBSJGrGzUC0uCMYWKH0oB1SjNOcl
        6WdZARNn99daq7+VqQNeDsEDeA==
X-Google-Smtp-Source: ACHHUZ56d5EfqOSVGPZP9YSkx1pVZ80Ypp/B7oY4uWraBWTQMEVsdq6dzt7z8dyRJ7J/IUMgpqTn6Q==
X-Received: by 2002:a05:622a:1a9d:b0:3f8:64ea:9f5c with SMTP id s29-20020a05622a1a9d00b003f864ea9f5cmr5909163qtc.35.1686818601115;
        Thu, 15 Jun 2023 01:43:21 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i21-20020aa78b55000000b0064fe06fe712sm11139783pfd.129.2023.06.15.01.43.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 01:43:20 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 4/4] maple_tree: add a fast path case in mas_wr_slot_store()
Date:   Thu, 15 Jun 2023 16:43:01 +0800
Message-Id: <20230615084301.97701-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
References: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
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
index da4af6743b30..bff6531fd0bc 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4100,23 +4100,35 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
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

