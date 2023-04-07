Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31146DA825
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 06:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjDGEKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 00:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDGEJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 00:09:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323646A4D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 21:09:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b5-20020a17090a6e0500b0023f32869993so539124pjk.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 21:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680840597; x=1683432597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Aui47sYym6eUyJHeRSbvJzsgj2hZgpPMPWCUjUt8JA=;
        b=btjxM/o5y/IqXBtaNZ/DMdaeS8q7W0fcBp996++PmoaYGUmmjxC5+4oxxfu8uCia4a
         z/9uPMy8aZ4wrmYFHh2isoSkOuu3PIg3rh383oHcggyXy6bZxTcORAPuWHS5LL/Al5r5
         tXN5pQdxmZ5pkQi7wWoAQom/VP4xuGT4xhjUe/dVi62TP9vf4COSlJGWAQTN8BpSyVKW
         KIKCIGH0wEmaOYsU5v7ipz4jT+4WhkeRS1iUYCLZo5dIJxNNUL7r1dnCoydWF9tqIer9
         2NURW97pKYXL+4qBdxTgPc1pPH1xF8JNcAsebHvKj73WL9Q0ZH2c9FKM600UDK0L7Qwj
         IYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680840597; x=1683432597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Aui47sYym6eUyJHeRSbvJzsgj2hZgpPMPWCUjUt8JA=;
        b=tR0pIhBp6QIh1PtXKOlbyQyy6fzzmgMpf3sGqBQhKbDZvSNLlVqtifX5z9FszZRQmb
         nz/x+I5R+8War3Wppbl0D5/y3BrZjKnFR+adyNyUpXS+yuRmBRvfqbIY6QL/nIofe/D4
         9P+s2F6U+2S13CFQRht1SgosBKKQwMazHdAxkOx3TLU8wgiVVIxJ4I2U8ZdG+gBrbcEF
         9Or65QTC4D6+ISPgKlSib+jQPglugGWB+wAQtesEU3i6J77zQwTCBSEEw7YYySBqrhSX
         ENQ459pAqdCtvRXs3l6WX4DJ3rFVCez2hCs6Cvx05AeR0OfANd6OVQbpL+RcOJ6f6LrL
         FfjQ==
X-Gm-Message-State: AAQBX9fdpX1qqe8Uh9NB0jqkgggwW/3qc8iq5Jhf+nnAIzHleRIlADtU
        sQJPLXOYAH1zK98oVQGifdPSJA==
X-Google-Smtp-Source: AKy350YkWXtm+VROzrrxuPlktSa0hkQnxbc7VvFkG/dSGtIFvCZEnuJ6s72HKtPIIwquDBJqY8RjhQ==
X-Received: by 2002:a05:6a20:38a2:b0:de:5082:c9ec with SMTP id n34-20020a056a2038a200b000de5082c9ecmr756627pzf.2.1680840597673;
        Thu, 06 Apr 2023 21:09:57 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78108000000b0062d7c0dc4f4sm2058010pfi.80.2023.04.06.21.09.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Apr 2023 21:09:57 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] maple_tree: Fix a potential memory leak, OOB access, or other unpredictable bug
Date:   Fri,  7 Apr 2023 12:07:18 +0800
Message-Id: <20230407040718.99064-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230407040718.99064-1-zhangpeng.00@bytedance.com>
References: <20230407040718.99064-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mas_alloc_nodes(), there is such a piece of code:
while (requested) {
	...
	node->node_count = 0;
	...
}
"node->node_count = 0" means to initialize the node_count field of the
new node, but the node may not be a new node. It may be a node that
existed before and node_count has a value, setting it to 0 will cause a
memory leak. At this time, mas->alloc->total will be greater than the
actual number of nodes in the linked list, which may cause many other
errors. For example, out-of-bounds access in mas_pop_node(), and
mas_pop_node() may return addresses that should not be used.
Fix it by initializing node_count only for new nodes.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: <stable@vger.kernel.org>
---
 lib/maple_tree.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 65fd861b30e1..9e25b3215803 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1249,26 +1249,18 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 	node = mas->alloc;
 	node->request_count = 0;
 	while (requested) {
-		max_req = MAPLE_ALLOC_SLOTS;
-		if (node->node_count) {
-			unsigned int offset = node->node_count;
-
-			slots = (void **)&node->slot[offset];
-			max_req -= offset;
-		} else {
-			slots = (void **)&node->slot;
-		}
-
+		max_req = MAPLE_ALLOC_SLOTS - node->node_count;
+		slots = (void **)&node->slot[node->node_count];
 		max_req = min(requested, max_req);
 		count = mt_alloc_bulk(gfp, max_req, slots);
 		if (!count)
 			goto nomem_bulk;
 
+		if (node->node_count == 0)
+			node->slot[0]->node_count = 0;
 		node->node_count += count;
 		allocated += count;
 		node = node->slot[0];
-		node->node_count = 0;
-		node->request_count = 0;
 		requested -= count;
 	}
 	mas->alloc->total = allocated;
-- 
2.20.1

