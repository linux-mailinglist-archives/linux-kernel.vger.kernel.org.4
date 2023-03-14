Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F606B942D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjCNMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjCNMmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:42:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F6D97FE9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:42:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id ce7so9608064pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678797744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK+BKqU6HfXh7xMbbpXKGNWRO1+XUkCbhB/Ff11LzHc=;
        b=ioJxPaNMnP30bTwv1b4MqjbilZtnlKQ9m1hdLXAwZsIGL9l6MV5d4U/YSj+W/3nvNV
         Ku35QSwZHVI0wCWwz1lxNOn2pyfHnoDzp9HWWmr5MpAlXnIvsHuvDcKqSDSPIsFT7W8R
         wVHRLuCkrLHPYsENx47uJPNzAhK/PTrJYPmq8hYbjB5uLb9bEk6NqHk5MjthH0X2TVV4
         z5m81EIIf6x/uQXAB65ULJPGnSZx4SFKOioo7XNeZuBlpDoHpyfZqtpJ/vrQssKbNQsq
         nVNT5PABOsTqgFPrvIW3eSDPG7ApKweSPxEkSgE0b3UVV92ZUOizfBMzoJcKaTLRqJjE
         DDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678797744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK+BKqU6HfXh7xMbbpXKGNWRO1+XUkCbhB/Ff11LzHc=;
        b=YlS2jwTMM7GNkRhSQikiy7r+PtxojPi14WSV1PTe52W6wz+VmqUkYQInCxCLMDXtic
         CCAknwdFRuS65QcVwN9LXf4n5djTAA/2d9gy8MUmplIocDh6a4FGifmsR2lfdUyNJq53
         yMyKNFS1UQj7hFkOVygtl33HKuB22wtlEK0ALqDXd2iqTSpj4S2wFB8n99pDzRG+VAlJ
         eKwF3r1Dq3Ol94vrivqIFn3Ar32hRwtqP7tbhn+EsqFvbeSVLxWRsxx84btKErEJPJyf
         gtsnyRfxuKEE2z0/4T5m+ONaVx/YiFRLKFbwx2DV+d6rJTc9XGHkTv58pD2JGm4sXHc4
         qdqw==
X-Gm-Message-State: AO0yUKWgFdCQuAlDkvodazisZhYK/nYEpHP5JjWynhfT4oy5Unl9tJq7
        ry+9qga8FniA2cVDL73MbWE3Zg==
X-Google-Smtp-Source: AK7set/nDUsbru5ncTlCJv4TgTsvyXHPDS4DSbVvInYybh9jiXPMSrWHEU2CHjsLEfjfSOlWaZnt9w==
X-Received: by 2002:a62:1756:0:b0:625:13f3:9409 with SMTP id 83-20020a621756000000b0062513f39409mr3941069pfx.26.1678797744687;
        Tue, 14 Mar 2023 05:42:24 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7828b000000b005ded5d2d571sm1509385pfm.185.2023.03.14.05.42.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Mar 2023 05:42:24 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 3/3] maple_tree: Fix a potential concurrency bug in RCU mode
Date:   Tue, 14 Mar 2023 20:42:03 +0800
Message-Id: <20230314124203.91572-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
References: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
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

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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

