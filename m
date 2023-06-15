Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF1873199D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343860AbjFONLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241356AbjFONLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:11:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37CA2702
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b01d3bb571so45009565ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686834644; x=1689426644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bi6s0yfXuBjDVA++TIrUvyqPyk4i8//b9rD0tFMY+rQ=;
        b=XHxv1DODKYeQKwjzJy2jt+aDwBfZOEIQt0yctlrkqvR3AsFSf1ORSYqAly/zx/7VwZ
         WE5pC8UGcgZNqDWgJwiEsDt408rwNq/NyGormCqefHQz7iV/7MM+SPvUXcgj8DIwhdjM
         pdca/N3EZmE6EUlzP8ejwoyLpAGzBriRcJ0sZ40piq4tT04sS0ciN2/ZenkJeOM+P7Ig
         G51gduTFS2c7/RsbPS1J745FnYsdE+Lck2dn1qUXKvwp0gv2Tm588fL14wsSgM//puEw
         TH6gPvmuoROUn2NJ4SgKKQZxGmklUQUJUdHsGkpDt0dog3/OQShcgpNHl+zGO18WjK26
         ebrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834644; x=1689426644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi6s0yfXuBjDVA++TIrUvyqPyk4i8//b9rD0tFMY+rQ=;
        b=V0USobmeu2ufKnsXcj/ddyTGUKhMUdmY4r/gx20zunAOKtHgjX1ZgiV6sPitRQ/3EA
         Kl2xE5h8N/IYheiMJTZrBQhR6KoKFRAehBp9qFetNtEwDgU/2iu/CWzxNSXm392CxUzw
         t5gSe52pA+KbkE7KPHTbNntx46+XVyS12IxkYtJT9J6oCawfdGIhQd6NziMny9VBOS6H
         QekpDjfgvuz9P2aL95K9NKjtbhyZqTWeb7pS2+WqAu95tbl3MoST2iBzL+Mx5ejh3OK6
         fexx9/fKhVaO6J+g0QDLJr7jMrUb83K+DLeIAN7QmzqBfzGQHjMf7fJdxdlRYfHPrPMT
         7x1g==
X-Gm-Message-State: AC+VfDy9mCUlF9uW6/+0ml23WMymwfFFolTieqCVZ0DCV0ZjsALJYuV2
        WPQK1VTvdML0Ma0H/MsGwtmd3Q==
X-Google-Smtp-Source: ACHHUZ52MGd9EC/zQoRkcmWexYmu12qqZKGDLmgxc8TYFK9fADOrTtHJMU75US+EdruywsgRdY2x2A==
X-Received: by 2002:a17:902:ab1b:b0:1b5:26d4:517d with SMTP id ik27-20020a170902ab1b00b001b526d4517dmr140399plb.29.1686834644205;
        Thu, 15 Jun 2023 06:10:44 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b001a804b16e38sm14036019plr.150.2023.06.15.06.10.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 06:10:43 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 5/8] maple_tree: make mas_validate_limits() check root node and node limit
Date:   Thu, 15 Jun 2023 21:08:56 +0800
Message-Id: <20230615130859.21858-6-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
References: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
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

Update mas_validate_limits() to check root node, check node limit pivot
if there is enough room for it to exist and check data_end. Remove the
check for child existence as it is done in mas_validate_child_slot().

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d91e66ea223f..6c9b62e41605 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7144,26 +7144,15 @@ static void mas_validate_limits(struct ma_state *mas)
 	void __rcu **slots = ma_slots(mte_to_node(mas->node), type);
 	unsigned long *pivots = ma_pivots(mas_mn(mas), type);
 
-	/* all limits are fine here. */
-	if (mte_is_root(mas->node))
-		return;
-
 	for (i = 0; i < mt_slots[type]; i++) {
 		unsigned long piv;
 
 		piv = mas_safe_pivot(mas, pivots, i, type);
 
-		if (!piv && (i != 0))
-			break;
-
-		if (!mte_is_leaf(mas->node)) {
-			void *entry = mas_slot(mas, slots, i);
-
-			if (!entry)
-				pr_err("%p[%u] cannot be null\n",
-				       mas_mn(mas), i);
-
-			MT_BUG_ON(mas->tree, !entry);
+		if (!piv && (i != 0)) {
+			pr_err("Missing node limit pivot at %p[%u]",
+			       mas_mn(mas), i);
+			MAS_WARN_ON(mas, 1);
 		}
 
 		if (prev_piv > piv) {
@@ -7186,6 +7175,13 @@ static void mas_validate_limits(struct ma_state *mas)
 		if (piv == mas->max)
 			break;
 	}
+
+	if (mas_data_end(mas) != i) {
+		pr_err("node%p: data_end %u != the last slot offset %u\n",
+		       mas_mn(mas), mas_data_end(mas), i);
+		MT_BUG_ON(mas->tree, 1);
+	}
+
 	for (i += 1; i < mt_slots[type]; i++) {
 		void *entry = mas_slot(mas, slots, i);
 
-- 
2.20.1

