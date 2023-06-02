Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B86771FB65
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjFBHyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjFBHya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:54:30 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFCC198
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:54:04 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-397f13944f2so1536804b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 00:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685692444; x=1688284444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k3FMdTRR6nTW2Kjg3j35z+e3Gvtk7et+Y9W5l7vMbdM=;
        b=C6of11iFU3UUYTGr2Ndf8tNfq5ggz43N2+NM+L6xQgx2Qv4tvsKd1Qe+n1V7x1AyNJ
         EsqbQlL7OSuCNiUl+S9dtMYcRAID3lSD4fVl/hgUGPK7usosEP4yikSKP/+Oy0frrFwI
         sM/g1pX9f6lHpC6D5xvY9eq7WiNMgIZgiNqg8wQTb5dRajGvDmnVg41SdunozLL2tAJV
         /Cqo0RibXvwtX0KbvkbmmuB8FHLZJwSU7Igea5jKE+sz9r06fIDtZ9pgaRE1hAct5CNh
         oHzfNXPPidCifSJnzTTPQp0SqY3i8z4dYks25DEwF3wruFCSXS9AY3mk6YpFgmj2YUfc
         tzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685692444; x=1688284444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3FMdTRR6nTW2Kjg3j35z+e3Gvtk7et+Y9W5l7vMbdM=;
        b=KcDPVD0HSQ9VFX9Msb/v/NJ2ZHsYOZ/2VDJ7AH/kD0K/BS4NZ1eISgOcrbMXkDh3se
         3f/h4COR5szni3Igi95608YiFboi1/kZg5tdBcfeHLug1WTdtuRL6Ha6eHzD30TW5m4W
         yIlr0z1XTKzDal9TO7UljNpxIHfTiX3OGvdak89grPstmUPyWmj8pjl6JcylBAWuJ2gG
         hTDAbaZGRPUNOAW/rSWuyAsxXg/TJ96H8ErwXCVfumHIwTiMuCjMTrr7XZ6i5twayp4J
         Gsb9XIxKsD/8irWYyDfmgojwNGFodcbfYYyUDKdrB9Zm1/EXrl6bz6rL8IcJbdMZOILQ
         ajcg==
X-Gm-Message-State: AC+VfDx4ipMMIQCrkKZFYI2hE2sR4FSjE0QUNio4a05u81XQVB3Ucqr+
        Rv/aB7lZu4+WKBEwpK3isi0Usw==
X-Google-Smtp-Source: ACHHUZ4xnyifp1i/lOUQpRDDpHJY3auju1JpIkojdO2Km+XGHfc8ThVSARl9WJQ3AFDlkps0PwoAMw==
X-Received: by 2002:a05:6808:2c6:b0:398:6008:f465 with SMTP id a6-20020a05680802c600b003986008f465mr1877942oid.4.1685692443997;
        Fri, 02 Jun 2023 00:54:03 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001ac94b33ab1sm636572pli.304.2023.06.02.00.54.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Jun 2023 00:54:03 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 1/2] maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
Date:   Fri,  2 Jun 2023 15:53:52 +0800
Message-Id: <20230602075353.5917-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

When the new range can be completely covered by the original last range
without touching the boundaries on both sides, two new entries can be
appended to the end as a fast path. We update the original last pivot at
the end, and the newly appended two entries will not be accessed before
this, so it is also safe in RCU mode.

This is useful for sequential insertion, which is what we do in
dup_mmap(). Enabling BENCH_FORK in test_maple_tree and just running
bench_forking() gives the following time-consuming numbers:

before:               after:
17,874.83 msec        15,738.38 msec

It shows about a 12% performance improvement for duplicating VMAs.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 7dd54afe66ed..cfd9fad308a2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4199,10 +4199,10 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
  *
  * Return: True if appended, false otherwise
  */
-static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
+static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
+				 unsigned char new_end)
 {
 	unsigned char end = wr_mas->node_end;
-	unsigned char new_end = end + 1;
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char node_pivots = mt_pivots[wr_mas->type];
 
@@ -4214,16 +4214,27 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 		ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
 	}
 
-	if (mas->last == wr_mas->r_max) {
-		/* Append to end of range */
-		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->entry);
-		wr_mas->pivots[end] = mas->index - 1;
-		mas->offset = new_end;
+	if (new_end == wr_mas->node_end + 1) {
+		if (mas->last == wr_mas->r_max) {
+			/* Append to end of range */
+			rcu_assign_pointer(wr_mas->slots[new_end],
+					   wr_mas->entry);
+			wr_mas->pivots[end] = mas->index - 1;
+			mas->offset = new_end;
+		} else {
+			/* Append to start of range */
+			rcu_assign_pointer(wr_mas->slots[new_end],
+					   wr_mas->content);
+			wr_mas->pivots[end] = mas->last;
+			rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
+		}
 	} else {
-		/* Append to start of range */
+		/* Append to the range without touching any boundaries. */
 		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->content);
-		wr_mas->pivots[end] = mas->last;
-		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
+		wr_mas->pivots[end + 1] = mas->last;
+		rcu_assign_pointer(wr_mas->slots[end + 1], wr_mas->entry);
+		wr_mas->pivots[end] = mas->index - 1;
+		mas->offset = end + 1;
 	}
 
 	if (!wr_mas->content || !wr_mas->entry)
@@ -4270,7 +4281,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 		goto slow_path;
 
 	/* Attempt to append */
-	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
+	if (mas_wr_append(wr_mas, new_end))
 		return;
 
 	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
-- 
2.20.1

