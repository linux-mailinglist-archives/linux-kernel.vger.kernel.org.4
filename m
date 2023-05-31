Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31380717CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjEaJ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjEaJ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:59:08 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907D71B1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:58:44 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685527116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtT/YiPGcEdmTG9OAN3DQ5AumhKObXT9/Vj+qIl0WEg=;
        b=PlSv9IPmuSHjdrKvEPl7w4TEiIOKkc/t+uD+8kCUMyQjVkWRlPkNzabQJ7hHCOKGaBYK7W
        bUUNx1CrZkZITlDuz0x6psukNLY7bBJ0k/0MQR2aKvy2s33NxB3JNm4Ms6dXTNpvioEckI
        QgaCfDLB4ZAFsh5XY9kozVeBEH/jkVw=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 5/8] fs: introduce struct super_operations::destroy_super() callback
Date:   Wed, 31 May 2023 09:57:39 +0000
Message-Id: <20230531095742.2480623-6-qi.zheng@linux.dev>
In-Reply-To: <20230531095742.2480623-1-qi.zheng@linux.dev>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <tkhai@ya.ru>

The patch introduces a new callback, which will be called
asynchronous from delayed work.

This will allows to make ::nr_cached_objects() safe
to be called on destroying superblock in next patches,
and to split unregister_shrinker() into two primitives.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/super.c         | 3 +++
 include/linux/fs.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 2ce54561e82e..4e9d08224f86 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -170,6 +170,9 @@ static void destroy_super_work(struct work_struct *work)
 	list_lru_destroy(&s->s_dentry_lru);
 	list_lru_destroy(&s->s_inode_lru);
 
+	if (s->s_op->destroy_super)
+		s->s_op->destroy_super(s);
+
 	for (i = 0; i < SB_FREEZE_LEVELS; i++)
 		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
 	kfree(s);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0b54ac1d331b..30b46d0facfc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1910,6 +1910,7 @@ struct super_operations {
 	int (*drop_inode) (struct inode *);
 	void (*evict_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
+	void (*destroy_super) (struct super_block *);
 	int (*sync_fs)(struct super_block *sb, int wait);
 	int (*freeze_super) (struct super_block *);
 	int (*freeze_fs) (struct super_block *);
-- 
2.30.2

