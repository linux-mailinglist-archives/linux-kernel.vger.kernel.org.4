Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E701C74AE8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjGGKLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjGGKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:11:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3124B213B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:11:30 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-66767d628e2so1305793b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688724689; x=1691316689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEWeKyXLPJ0PG2fEoqETtxFILv9OUYojo6yQ5hMHc4U=;
        b=B8xF1e++nc2JK5igG1lRrToeULOMcAypzITpfCyb3DCd4SKc70mSmGIhGIi/STBaBr
         gBsxzOdvx9mkBv/Ex6hKK5zFJLPo95GXk/dAhn3EvyNMXS4KXlpYbQAoQ9fjheogI6Bd
         u+/ETK4yU9jnqi6x5oy7p3rJOucDfsIw8f6c5CvVIesOTy+HlQ+llHxs1OrSz0U264RF
         R1pkWyCFzpZSWlkDZcJgTmZtvNoALV4dfXycYb71T5oLvbJxWn8lWTG2UxBThp9YYMd2
         Y/sZsvhpeX4GTDWL0T5EOc5HamZodxSPwyC07+vfSEzCLmJCLFRA+UFBnLZti3OkntdU
         i1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688724689; x=1691316689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEWeKyXLPJ0PG2fEoqETtxFILv9OUYojo6yQ5hMHc4U=;
        b=fo28FktJzUCi4v1pauGlg+w/HbwBCCY7BoyK1WLmTz1DyJJpQSINMPzXGxDImstl5c
         cH7CXQmZa+W7jsMAQ74BpqGY+ozgKKHS1d9lOhScHwNfHpGrIXCSuIIhRGhO81ivrbGS
         +BoWZno+PNEILXDCNozCuWZNOtBfh3/ad8zybPmmuhF1mcnurj1m5AN99z/PlOu62poA
         Cx6zkEzenD1pps2DNutXKJQW4dBuIRQWWwKFcVzLXe6iSS7EdsMuOa47c7m/rwebwwaL
         0x+V4neltST5BK8KlEJP9Ep5suzla/W11uBCY6DSE/wCTLQCNn4wLOMhTROvat+h3FSZ
         Bn6g==
X-Gm-Message-State: ABy/qLYirOLzroGpTRDj5z6bmT/qpxDUCJUipzYd++vdH58xLlxnm2F6
        9DHVKFZWNnZ7Gei3DPbx08qoPg==
X-Google-Smtp-Source: APBJJlFWSdBdYSs8R5cKFkzoi15V1LLf8Zsq8gk3QkxoL0LpEY7Lxuhz5qgh7k49XyEoJowJcAMYbA==
X-Received: by 2002:a05:6a00:1acd:b0:678:5629:fd43 with SMTP id f13-20020a056a001acd00b006785629fd43mr4104877pfv.9.1688724689568;
        Fri, 07 Jul 2023 03:11:29 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b0068288aaf23esm2602549pfv.100.2023.07.07.03.11.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jul 2023 03:11:29 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [RESEND PATCH 6/8] maple_tree: update mt_validate()
Date:   Fri,  7 Jul 2023 18:10:55 +0800
Message-Id: <20230707101057.29326-7-zhangpeng.00@bytedance.com>
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

Instead of using mas_first_entry() to find the leftmost leaf, use a
simple loop instead. Remove an unneeded check for root node. To make
the error message more accurate, check pivots first and then slots,
because checking slots depend on the node limit pivot to break the loop.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e84a042b6d84..3aede7deaa26 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7260,21 +7260,22 @@ void mt_validate(struct maple_tree *mt)
 	if (!mas_searchable(&mas))
 		goto done;
 
-	mas_first_entry(&mas, mas_mn(&mas), ULONG_MAX, mte_node_type(mas.node));
+	while (!mte_is_leaf(mas.node))
+		mas_descend(&mas);
+
 	while (!mas_is_none(&mas)) {
 		MAS_WARN_ON(&mas, mte_dead_node(mas.node));
-		if (!mte_is_root(mas.node)) {
-			end = mas_data_end(&mas);
-			if (MAS_WARN_ON(&mas,
-					(end < mt_min_slot_count(mas.node)) &&
-					(mas.max != ULONG_MAX))) {
-				pr_err("Invalid size %u of %p\n", end,
-				       mas_mn(&mas));
-			}
+		end = mas_data_end(&mas);
+		if (MAS_WARN_ON(&mas,
+				(end < mt_min_slot_count(mas.node)) &&
+				(mas.max != ULONG_MAX))) {
+			pr_err("Invalid size %u of %p\n", end,
+				mas_mn(&mas));
 		}
+
 		mas_validate_parent_slot(&mas);
-		mas_validate_child_slot(&mas);
 		mas_validate_limits(&mas);
+		mas_validate_child_slot(&mas);
 		if (mt_is_alloc(mt))
 			mas_validate_gaps(&mas);
 		mas_dfs_postorder(&mas, ULONG_MAX);
-- 
2.20.1

