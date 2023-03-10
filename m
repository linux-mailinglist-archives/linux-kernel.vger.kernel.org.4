Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC06B4330
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjCJOLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjCJOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:10:38 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5795FE1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:09:43 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i10so5645504plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678457382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI1NTxNQsncsBuSARtQ7gY1qx/Kaxg/acZj9mrc75oo=;
        b=R7ouu0Wktvvy/0biANU6/CsFYdvyqaelWm1/tm2k3z1xn1E58V6YQdhsRRE48Ukl0D
         xouTlAcz47ET0Gx71OmdRdZ1QQB46Fe9vBCaiXaGfk/dAdNoNJMwJmdyFhZ7pV/S7KcT
         qq/41cVbpI0VXpk7WAC/xbEO208+6SIYdhxXL+q7/v3/pnmJ5yey3oRrE45ykNAf9O+h
         86/msFcANeTG0J4YQf4v66JfUdAcaAPu7V0w346WgpHPq+5Ozy9K7ywU+iLrHj5ieiIP
         /YBouzChgTtzGJRoD3jWioB/xzQHKJGT8lMCdNM7tcG+wvmYMAxcNNKEWgFrBZeD2ZvQ
         Cx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678457382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI1NTxNQsncsBuSARtQ7gY1qx/Kaxg/acZj9mrc75oo=;
        b=zMrA0KjZhywy9hJsjrPFZAPPusTMnhRrPsYpWJWpG2XW2QTOW4p6xVSu6SUVQqhxzL
         jc5mQifbArTBTlXhLGYSJsYwpPRkhcW+tAbbCTh/UpsvgK3KMLaGviVZrubRwwq0vKvM
         DL6VE+6IiSFGTnPFaHmsQnWVzndB9/5KrFiEKVGvyI5PJ1+PzB0hhRwAMltLYlN5tas1
         yNumFPQ0QbtQusO+Kd/Yp8U6P6t8p0tpTBITOWUmESWf2XOXgJP8PlFOWjdcAozhNMP5
         7wjD5qZTCZwfqy5AUATcEpnNERSkASTaa9hbfnJh9BvnQWBREdL8DQ1PVTk7G78sUMNy
         nhRA==
X-Gm-Message-State: AO0yUKUfgVNpBqgywap+I/9/f3Ihe6iyLyDaVd4RHESXBcNW5W2AQXWG
        mpaavTzcCkzpmsY/dW7GO3zoew==
X-Google-Smtp-Source: AK7set8Z8bAhdNtk0KoMAdSO1/VatXK5WhDtaRNgSmexkSBtrCjRc8k4A5zuJ+DkJF+bE84k83di4A==
X-Received: by 2002:a17:90b:33c4:b0:234:bf0:86bc with SMTP id lk4-20020a17090b33c400b002340bf086bcmr25736949pjb.31.1678457382536;
        Fri, 10 Mar 2023 06:09:42 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id fu11-20020a17090ad18b00b002375c356b0csm6753pjb.19.2023.03.10.06.09.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Mar 2023 06:09:42 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 3/4] maple_tree: Fix a potential concurrency bug in RCU mode
Date:   Fri, 10 Mar 2023 22:08:46 +0800
Message-Id: <20230310140848.94485-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a concurrency bug that may cause the wrong value to be loaded
when a CPU is modifying the maple tree.

CPU1:
mtree_insert_range()
  mas_insert()
    mas_store_root()
      ...
      mas_root_expand()
        ...
        rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
        ma_set_meta(node, maple_leaf_64, 0, slot);    <---IP

CPU2:
mtree_load()
  mtree_lookup_walk()
    ma_data_end();

When CPU1 is about to execute the instruction pointed to by IP,
the ma_data_end() executed by CPU2 may return the wrong end position,
which will cause the value loaded by mtree_load() to be wrong.

An example of triggering the bug:

Add mdelay(100) between rcu_assign_pointer() and ma_set_meta() in
mas_root_expand().

static DEFINE_MTREE(tree);
int work(void *p) {
	unsigned long val;
	for (int i = 0 ; i< 30; ++i) {
		val = (unsigned long)mtree_load(&tree, 8);
		mdelay(5);
		pr_info("%lu",val);
	}
	return 0;
}

mt_init_flags(&tree, MT_FLAGS_USE_RCU);
mtree_insert(&tree, 0, (void*)12345, GFP_KERNEL);
run_thread(work)
mtree_insert(&tree, 1, (void*)56789, GFP_KERNEL);

In RCU mode, mtree_load() should always return the value before or after
the data structure is modified, and in this example mtree_load(&tree, 8)
may return 56789 which is not expected, it should always return NULL.
Fix it by put ma_set_meta() before rcu_assign_pointer().

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4d15202a0692..de43ff19da72 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3635,10 +3635,9 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
 		slot++;
 	mas->depth = 1;
 	mas_set_height(mas);
-
+	ma_set_meta(node, maple_leaf_64, 0, slot);
 	/* swap the new root into the tree */
 	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
-	ma_set_meta(node, maple_leaf_64, 0, slot);
 	return slot;
 }
 
-- 
2.20.1

