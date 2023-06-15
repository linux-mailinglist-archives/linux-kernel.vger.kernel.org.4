Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BCF731286
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245063AbjFOIoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbjFOIne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:43:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB802272E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6664a9f0b10so1173531b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686818592; x=1689410592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6we1XLVpJvFDKToAtCSdGG7AESFIveH8POVJHK7ygw=;
        b=KJqooEgRb2iG8G1YEwQaqnb6yEyBC3iktDlEuCSBmlCh99KVdbC4uXKwyOEWcJ/vOP
         DIqo86HSGslqIkVliO7JkAyqCgamZvnuTKyKqN4AbrShWmLI8k5Ca37sxCWu0JtQEQ9K
         ol0WmAJ3q9Y2U4SIj4Vx039gw/b6Hns2IJDVLd99kDe5nheMueLD1C9GADpQ7Xqq0y6S
         992BUsR57Tu/AIwGg5EIyEIr7FlnvDWdZ2OGQBBbIBiKEp1+lnu066CqqEsTMIn7mRCo
         +ag3+4ZmKY4vks40xwKEB5VEbwCyTezKBcyE443UrMi+13WctUK8zwBk/BSkby+dhEDv
         8kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818592; x=1689410592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6we1XLVpJvFDKToAtCSdGG7AESFIveH8POVJHK7ygw=;
        b=bc5ABhnFyhlOcqd13CCHb187oq2NuOVzxsK7fMg3GeveopdSKeYgcnPA8fNFPc6mJd
         uxm13k2ISkNx5y4IT9pq7LQqOF0yCde3VBHJDgfVwk/eHyJlrU5cKnGh7h1wMby/rkQE
         gQ/9oqa2Frq9yCTOu7OsLZ7SxNvQOB/6tn+MkzLZIytjq++SornS1f9gMauP/rPAGHEl
         bSIjFJRQUETiB42/Gb9gN55CdzPqLcrXOq4ESD05UmnXkiUd9ZvbbGjqeKkmKOgLye7t
         EITQzZ/LXc4uDm4BnRFgrG0RhkUtB9JBQTwVKloFe/o1YYxA40iwtLf+xfueLRxGc8m/
         1Nig==
X-Gm-Message-State: AC+VfDyRhkEGQ1qLNc8NeB62NQphULL1i1oc6XrWKX2EHMIZOWsuAsOA
        1fAwyjzLo3y3DlCqB77I+rgizA==
X-Google-Smtp-Source: ACHHUZ7OxUHpAAt4DVa7Yj5aKyir5I7RaKxitjppVwOvFNh7V119bUWSksBzFLFq7Hpwse3+/gV1zQ==
X-Received: by 2002:a05:6a20:8419:b0:10b:bad9:1d31 with SMTP id c25-20020a056a20841900b0010bbad91d31mr3987449pzd.26.1686818592167;
        Thu, 15 Jun 2023 01:43:12 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i21-20020aa78b55000000b0064fe06fe712sm11139783pfd.129.2023.06.15.01.43.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 01:43:11 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 1/4] maple_tree: add test for mas_wr_modify() fast path
Date:   Thu, 15 Jun 2023 16:42:58 +0800
Message-Id: <20230615084301.97701-2-zhangpeng.00@bytedance.com>
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

Add tests for all cases of mas_wr_append() and mas_wr_slot_store().

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c | 65 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 15d7b7bce7d6..9403472af3d7 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1159,6 +1159,71 @@ static noinline void __init check_ranges(struct maple_tree *mt)
 	MT_BUG_ON(mt, !mt_height(mt));
 	mtree_destroy(mt);
 
+	/* Check in-place modifications */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	/* Append to the start of last range */
+	mt_set_non_kernel(50);
+	for (i = 0; i <= 500; i++) {
+		val = i * 5 + 1;
+		val2 = val + 4;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	/* Append to the last range without touching any boundaries */
+	for (i = 0; i < 10; i++) {
+		val = val2 + 5;
+		val2 = val + 4;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	/* Append to the end of last range */
+	val = val2;
+	for (i = 0; i < 10; i++) {
+		val += 5;
+		MT_BUG_ON(mt, mtree_test_store_range(mt, val, ULONG_MAX,
+						     xa_mk_value(val)) != 0);
+	}
+
+	/* Overwriting the range and over a part of the next range */
+	for (i = 10; i < 30; i += 2) {
+		val = i * 5 + 1;
+		val2 = val + 5;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	/* Overwriting a part of the range and over the next range */
+	for (i = 50; i < 70; i += 2) {
+		val2 = i * 5;
+		val = val2 - 5;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	/*
+	 * Expand the range, only partially overwriting the previous and
+	 * next ranges
+	 */
+	for (i = 100; i < 130; i += 3) {
+		val = i * 5 - 5;
+		val2 = i * 5 + 1;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	/*
+	 * Expand the range, only partially overwriting the previous and
+	 * next ranges, in RCU mode
+	 */
+	mt_set_in_rcu(mt);
+	for (i = 150; i < 180; i += 3) {
+		val = i * 5 - 5;
+		val2 = i * 5 + 1;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	MT_BUG_ON(mt, !mt_height(mt));
+	mt_validate(mt);
+	mt_set_non_kernel(0);
+	mtree_destroy(mt);
+
 	/* Test rebalance gaps */
 	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
 	mt_set_non_kernel(50);
-- 
2.20.1

