Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299E06DA828
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 06:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjDGEKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 00:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDGEKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 00:10:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BF26E82
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 21:09:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ja10so39153655plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 21:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680840594; x=1683432594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bhWUm9eJrATUzUGu/SdqQI045fo0z6oxhiOFKc2Mv8=;
        b=ihB3MHeXkG035KRhU6cjwh5VirqAivcRwBk4ijiwvbkp9V0iXQyBBn4uq1bVHfiGxK
         3XTqKhnadMIO8SgpX+QjdyQkfqskuVf9n/kBh1yER20FWF3yvmwDXFi8dKGCrbtvS1vJ
         vDsgQ6B7smN5GKDMRjxbZd2xFlc59jireHwxgiVShEr7jerGcZ7NPjsUQtikK8/TI4SM
         L+xv/nvnWvQqBXXWCrEhpASQnsjEK1dbCeqUXZ/UqeL719UOcFd7GT1dHjDY9flWz3NZ
         bEyVjTl/OaTP/JxvvVn+KeRliAR0H0OmbXJWlrVxVPqJbDUyQwfsuvTDhNt6HrbXta0v
         WXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680840594; x=1683432594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bhWUm9eJrATUzUGu/SdqQI045fo0z6oxhiOFKc2Mv8=;
        b=ACSPfpNxlrV1yWwYj2aVuMfCFdRihyqwQmnK0mrODv73d4/es35d5HvClxj7OniZn5
         uyYJXoqbBMibpjrlcPzuBfXn3z6KmGBMBt/ONF/ja7sk6RZo1jx1y8vNs/nlzxTy8K7a
         DlKbxwew8OU6ws72O0R4M5SZGJW7bLzeR4IQhxeAhKHTnC/eduowN3HNuLPYWKfAzNjR
         0efU5Y6zQlAI/7Tg2Tncjw+cjOScps2dgHi3BHb+3o44nFamglmyDTq6MTWwFuJGcXsq
         qkJl0jkJGI7fBpYmoHNwPkEdDVXGH+a2Xvdawt4JRfCMTTzXLmH/z3h5Jq7Kmx+GMAvj
         8wRQ==
X-Gm-Message-State: AAQBX9d1xTEK/yZHqzyDup7jcqtLBmZpU0u8xbCAJ46QF7nYgdX+Mq8v
        GFq7kOrqOTcahlY40AMswnS8rw==
X-Google-Smtp-Source: AKy350Z5pcqynlW2RlTIEwDesMVxMdjZRI87FQURw6KVsC3HNCqKDxlubyLuA30cIAIlLWgGgDa4Ng==
X-Received: by 2002:a05:6a20:4c15:b0:da:53ca:8f26 with SMTP id fm21-20020a056a204c1500b000da53ca8f26mr1772163pzb.30.1680840594452;
        Thu, 06 Apr 2023 21:09:54 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78108000000b0062d7c0dc4f4sm2058010pfi.80.2023.04.06.21.09.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Apr 2023 21:09:54 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 1/2] maple_tree: Add a test case to check maple_alloc
Date:   Fri,  7 Apr 2023 12:07:17 +0800
Message-Id: <20230407040718.99064-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

Add a test case to check whether the number of maple_alloc structures is
actually equal to mas->alloc->total.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 tools/testing/radix-tree/maple.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 958ee9bdb316..26389e0dcfff 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -55,6 +55,28 @@ struct rcu_reader_struct {
 	struct rcu_test_struct2 *test;
 };
 
+static int get_alloc_node_count(struct ma_state *mas)
+{
+	int count = 1;
+	struct maple_alloc *node = mas->alloc;
+
+	if (!node || ((unsigned long)node & 0x1))
+		return 0;
+	while (node->node_count) {
+		count += node->node_count;
+		node = node->slot[0];
+	}
+	return count;
+}
+
+static void check_mas_alloc_node_count(struct ma_state *mas)
+{
+	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 1, GFP_KERNEL);
+	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 3, GFP_KERNEL);
+	MT_BUG_ON(mas->tree, get_alloc_node_count(mas) != mas->alloc->total);
+	mas_destroy(mas);
+}
+
 /*
  * check_new_node() - Check the creation of new nodes and error path
  * verification.
@@ -69,6 +91,8 @@ static noinline void check_new_node(struct maple_tree *mt)
 
 	MA_STATE(mas, mt, 0, 0);
 
+	check_mas_alloc_node_count(&mas);
+
 	/* Try allocating 3 nodes */
 	mtree_lock(mt);
 	mt_set_non_kernel(0);
-- 
2.20.1

