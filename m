Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E346960C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBNKao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjBNKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:30:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F67241C9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:30:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC04B614F8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E7BC433EF;
        Tue, 14 Feb 2023 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676370634;
        bh=9T6pAt8RK/wq+3Lfrzi3xrLApHJkjngyCRo3iZZ8lcM=;
        h=From:To:Cc:Subject:Date:From;
        b=FRujVgQdhII1Y1kLFdI49NShstvdPkwW9DJTqMSApgiaz2cPn7FjCjQsVcxy4228C
         Y2iGvCNYWUAVz2GoYmvgW2/ja59ZwxyVnyZ/BZ5onLQ07n19oJvl9EMTfpbNRn2xgq
         QEkw6+6Tsoyx5p198fWDYBUoQNdDInMJM93CtK3a8RafJ9ykweJIG58qK5MtdG6Xwh
         U9+1ikY/FV6uI+wm1uM8FqSnEwksPW9wwkTs3CdLV2cNxbQXAybJXpU5dvxK+b++fE
         KjkKPqFqmv32h6dHpqvqQmgppq5BrWQQ5lZ0JudInrsf0adg25t3Pl1T7cCZATr4/h
         jIv3FSv/RYIZQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Vernon Yang <vernon2gm@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] maple_tree: reduce stack usage with gcc-9 and earlier
Date:   Tue, 14 Feb 2023 11:30:24 +0100
Message-Id: <20230214103030.1051950-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-10 changed the way inlining works to be less aggressive, but
older versions run into an oversized stack frame warning whenever
CONFIG_KASAN_STACK is enabled, as that forces variables from
inlined callees to be non-overlapping:

lib/maple_tree.c: In function 'mas_wr_bnode':
lib/maple_tree.c:4320:1: error: the frame size of 1424 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Change the annotations on mas_store_b_node() and mas_commit_b_node()
to explicitly forbid inlining in this configuration, which is
the same behavior that newer versions already have.

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: kasan-dev@googlegroups.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/maple_tree.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5e9703189259..646297cae5d1 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -146,6 +146,13 @@ struct maple_subtree_state {
 	struct maple_big_node *bn;
 };
 
+#ifdef CONFIG_KASAN_STACK
+/* Prevent mas_wr_bnode() from exceeding the stack frame limit */
+#define noinline_for_kasan noinline_for_stack
+#else
+#define noinline_for_kasan inline
+#endif
+
 /* Functions */
 static inline struct maple_node *mt_alloc_one(gfp_t gfp)
 {
@@ -2107,7 +2114,7 @@ static inline void mas_bulk_rebalance(struct ma_state *mas, unsigned char end,
  *
  * Return: The actual end of the data stored in @b_node
  */
-static inline void mas_store_b_node(struct ma_wr_state *wr_mas,
+static noinline_for_kasan void mas_store_b_node(struct ma_wr_state *wr_mas,
 		struct maple_big_node *b_node, unsigned char offset_end)
 {
 	unsigned char slot;
@@ -3579,7 +3586,7 @@ static inline bool mas_reuse_node(struct ma_wr_state *wr_mas,
  * @b_node: The maple big node
  * @end: The end of the data.
  */
-static inline int mas_commit_b_node(struct ma_wr_state *wr_mas,
+static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
 			    struct maple_big_node *b_node, unsigned char end)
 {
 	struct maple_node *node;
-- 
2.39.1

