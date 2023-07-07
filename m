Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723FA74AE90
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjGGKMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjGGKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:11:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B84226A8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:11:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e916b880so848703b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688724695; x=1691316695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY4TunAJnA6iguq2KmXgFYhvimBAhbgzT6svnqGIOfg=;
        b=TwikCOYRmU+nyw+rmp7MTLs8kn7oQmLYMUPlGa5onDJKbZD+caFPZZVqhYAO97Qaft
         QB6VUxVy1E8B8h4sze4YpSbZzy4Oq0Wi4aYOLBvH4+5bHA3REbmHK7K1Kro83eyWNXpD
         kjrtAO8mhRni83vhBplNMpN21fI0BmOMYJWKJCXYfaxGVMZ5jtGOlvcBSALSZYVzYoX1
         Y81STm8yu1BFJk0KgM5I2K6Xad67IwG4ysqFRtz1xDKDJiYVhBKg9JoibVdVYgUnVj9V
         hOA2JFfZQh5DZ42J7yvDlEVPaiv///gb1Eef6ncsfg45HBtheJ83ejYQNVbFHuWsQVnA
         H//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688724695; x=1691316695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yY4TunAJnA6iguq2KmXgFYhvimBAhbgzT6svnqGIOfg=;
        b=bol4kcupjS5O2x9VrT5oxmoO3oEtVuAnwTOKuS4z0uvqceL6TQU1+LOs+fvu7vz1MI
         x8GAtnk9T/TWAnfi3nUyTIdXPs/0nx4QuRvPegZpec0Qn2YFoM6jI8edf/oSe9PwFjjA
         kFBCnccBr1XpMgtl2Du1woTWfcQDnHZh2JmzeOK9eI/5YyQObkEPGu1CthQ28359F9SK
         VVqGPkk+LALnGMh1pi4RgUXGb7PGklAv3TbIlBWZ3dCioIXDrMU5T9l59VjEpr78Cxit
         TBzU1lFNLHV+/QOFe8RNZpWrLXNDdSy+GGCDo2xYVWnu2Hki6CS4HeQgFBpt5a//6YCz
         gDkg==
X-Gm-Message-State: ABy/qLbu+8OqGLrvouibjLYJrB0EFe6xlnU816DRmwLmgIqG664euRo6
        j0poHtQEzOff3qNPsr6SyxxneQ==
X-Google-Smtp-Source: APBJJlFjCMbAOzxsCyuIBwr6DxRyBFBt6k0SyguxrnyEO1kLu9Y/81oZNUcDOwMa+uQ985BVpNsqSw==
X-Received: by 2002:a05:6a00:1409:b0:66a:613f:87e1 with SMTP id l9-20020a056a00140900b0066a613f87e1mr4556377pfu.8.1688724695433;
        Fri, 07 Jul 2023 03:11:35 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b0068288aaf23esm2602549pfv.100.2023.07.07.03.11.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jul 2023 03:11:35 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [RESEND PATCH 8/8] maple_tree: drop mas_first_entry()
Date:   Fri,  7 Jul 2023 18:10:57 +0800
Message-Id: <20230707101057.29326-9-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
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

The internal function mas_first_entry() is no longer used, so drop it.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 72 ------------------------------------------------
 1 file changed, 72 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8c08bfdc99cf..ad6810ed3231 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6662,78 +6662,6 @@ static inline struct maple_enode *mas_get_slot(struct ma_state *mas,
 			offset);
 }
 
-
-/*
- * mas_first_entry() - Go the first leaf and find the first entry.
- * @mas: the maple state.
- * @limit: the maximum index to check.
- * @*r_start: Pointer to set to the range start.
- *
- * Sets mas->offset to the offset of the entry, r_start to the range minimum.
- *
- * Return: The first entry or MAS_NONE.
- */
-static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
-		unsigned long limit, enum maple_type mt)
-
-{
-	unsigned long max;
-	unsigned long *pivots;
-	void __rcu **slots;
-	void *entry = NULL;
-
-	mas->index = mas->min;
-	if (mas->index > limit)
-		goto none;
-
-	max = mas->max;
-	mas->offset = 0;
-	while (likely(!ma_is_leaf(mt))) {
-		MAS_WARN_ON(mas, mte_dead_node(mas->node));
-		slots = ma_slots(mn, mt);
-		entry = mas_slot(mas, slots, 0);
-		pivots = ma_pivots(mn, mt);
-		if (unlikely(ma_dead_node(mn)))
-			return NULL;
-		max = pivots[0];
-		mas->node = entry;
-		mn = mas_mn(mas);
-		mt = mte_node_type(mas->node);
-	}
-	MAS_WARN_ON(mas, mte_dead_node(mas->node));
-
-	mas->max = max;
-	slots = ma_slots(mn, mt);
-	entry = mas_slot(mas, slots, 0);
-	if (unlikely(ma_dead_node(mn)))
-		return NULL;
-
-	/* Slot 0 or 1 must be set */
-	if (mas->index > limit)
-		goto none;
-
-	if (likely(entry))
-		return entry;
-
-	mas->offset = 1;
-	entry = mas_slot(mas, slots, 1);
-	pivots = ma_pivots(mn, mt);
-	if (unlikely(ma_dead_node(mn)))
-		return NULL;
-
-	mas->index = pivots[0] + 1;
-	if (mas->index > limit)
-		goto none;
-
-	if (likely(entry))
-		return entry;
-
-none:
-	if (likely(!ma_dead_node(mn)))
-		mas->node = MAS_NONE;
-	return NULL;
-}
-
 /* Depth first search, post-order */
 static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 {
-- 
2.20.1

