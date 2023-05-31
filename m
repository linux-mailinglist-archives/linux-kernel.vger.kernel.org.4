Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B321717C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjEaJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjEaJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:58:55 -0400
Received: from out-7.mta0.migadu.com (out-7.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D13718F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:58:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685527108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E+T6MU8ntbBOvHLVHWyWd2NDGkscltn2p+HVjRapVkY=;
        b=aqACCvCWYJ0Y4210xFVIKOz1nuLZMkNqtH4dgIpFYFS1UqcYGGT2q8rSFyFjyZK7Pydu3w
        AuV1qecNPdxf4ytiJQpoRe0LH1oNWMkq+SrmRCO9rTKGu8v6q1BZVpGwerN8shJucy3Wif
        OiE0gEWmKmuhpBJRVVQpYf7vzkydq24=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 3/8] fs: move list_lru_destroy() to destroy_super_work()
Date:   Wed, 31 May 2023 09:57:37 +0000
Message-Id: <20230531095742.2480623-4-qi.zheng@linux.dev>
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

The patch makes s_dentry_lru and s_inode_lru be destroyed
later from the workqueue. This is preparation to split
unregister_shrinker(super_block::s_shrink) in two stages,
and to call finalize stage from destroy_super_work().

Note, that generic filesystem shrinker unregistration
is safe to be split in two stages right after this
patch, since super_cache_count() and super_cache_scan()
have a deal with s_dentry_lru and s_inode_lru only.

But there are two exceptions: XFS and SHMEM, which
define .nr_cached_objects() and .free_cached_objects()
callbacks. These two do not allow us to do the splitting
right after this patch. They touch fs-specific data,
which is destroyed earlier, than destroy_super_work().
So, we can't call unregister_shrinker_delayed_finalize()
from destroy_super_work() because of them, and next
patches make preparations to make this possible.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/super.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 8d8d68799b34..2ce4c72720f3 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -159,6 +159,11 @@ static void destroy_super_work(struct work_struct *work)
 							destroy_work);
 	int i;
 
+	WARN_ON(list_lru_count(&s->s_dentry_lru));
+	WARN_ON(list_lru_count(&s->s_inode_lru));
+	list_lru_destroy(&s->s_dentry_lru);
+	list_lru_destroy(&s->s_inode_lru);
+
 	for (i = 0; i < SB_FREEZE_LEVELS; i++)
 		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
 	kfree(s);
@@ -177,8 +182,6 @@ static void destroy_unused_super(struct super_block *s)
 	if (!s)
 		return;
 	up_write(&s->s_umount);
-	list_lru_destroy(&s->s_dentry_lru);
-	list_lru_destroy(&s->s_inode_lru);
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
@@ -287,8 +290,6 @@ static void __put_super(struct super_block *s)
 {
 	if (!--s->s_count) {
 		list_del_init(&s->s_list);
-		WARN_ON(s->s_dentry_lru.node);
-		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
 		security_sb_free(s);
 		put_user_ns(s->s_user_ns);
@@ -330,14 +331,6 @@ void deactivate_locked_super(struct super_block *s)
 		unregister_shrinker(&s->s_shrink);
 		fs->kill_sb(s);
 
-		/*
-		 * Since list_lru_destroy() may sleep, we cannot call it from
-		 * put_super(), where we hold the sb_lock. Therefore we destroy
-		 * the lru lists right now.
-		 */
-		list_lru_destroy(&s->s_dentry_lru);
-		list_lru_destroy(&s->s_inode_lru);
-
 		put_filesystem(fs);
 		put_super(s);
 	} else {
-- 
2.30.2

