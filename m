Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AD45B3A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiIIOCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiIIOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F1C9F74A;
        Fri,  9 Sep 2022 07:00:37 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtYXvAW96OQptFLFPBfzBp6CkQBMVtL5E6E3SMyjjMI=;
        b=vdy/G2MTRekHKXwz6DugsS+FL6tH23QGhp05T2nNnERqgkwcbsqQ0sd7Ef/Z4Kfg/gQWi5
        7J65ZcI0aMnWOik+yrz4o8QTEwt2KgG6XowJOsdxRgpF6uJGsSZ30j/ToMF4t9nYV2wa7E
        fll2iaix1JmsYWvhUYFdZSV/UJVto7UqnFeta275xvVW/G5tXnd+Cijb0jYScV8TIKqGAQ
        Nt60SXh4C67y2HMS/EwHc8KwvR+DhnPsVO6Y05/Qi3WQM/JwmiaTSyCzHB/KAXDOS79s3h
        BpauKSUImO8HDa9u8ixFGkKUg4X3xaqbPOGEdULRHrr3PJ18LR5O3xOzSbM9OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtYXvAW96OQptFLFPBfzBp6CkQBMVtL5E6E3SMyjjMI=;
        b=fTF8PomuCYNpro0Qm8eh00U8Q+bsuVWYANf8wD9jtzXNB7a5UJZlK0gXDvhUeOUmIOClS8
        YWfgs5cIdfMXK0Dw==
From:   "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] kernfs: Simply by replacing kernfs_deref_open_node()
 with of_on()
Cc:     Imran Khan <imran.f.khan@oracle.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220828050440.734579-2-tj@kernel.org>
References: <20220828050440.734579-2-tj@kernel.org>
MIME-Version: 1.0
Message-ID: <166273203440.401.9865519901772848692.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     3db48aca879db475844182a24d1760ee3d230627
Gitweb:        https://git.kernel.org/tip/3db48aca879db475844182a24d1760ee3d230627
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Sat, 27 Aug 2022 19:04:32 -10:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:08:43 +02:00

kernfs: Simply by replacing kernfs_deref_open_node() with of_on()

kernfs_node->attr.open is an RCU pointer to kernfs_open_node. However, RCU
dereference is currently only used in kernfs_notify(). Everywhere else,
either we're holding the lock which protects it or know that the
kernfs_open_node is pinned becaused we have a pointer to a kernfs_open_file
which is hanging off of it.

kernfs_deref_open_node() is used for the latter case - accessing
kernfs_open_node from kernfs_open_file. The lifetime and visibility rules
are simple and clear here. To someone who can access a kernfs_open_file, its
kernfs_open_node is pinned and visible through of->kn->attr.open.

Replace kernfs_deref_open_node() which simpler of_on(). The former takes
both @kn and @of and RCU deref @kn->attr.open while sanity checking with
@of. The latter takes @of and uses protected deref on of->kn->attr.open.

As the return value can't be NULL, remove the error handling in the callers
too.

This shouldn't cause any functional changes.

Cc: Imran Khan <imran.f.khan@oracle.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20220828050440.734579-2-tj@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/file.c | 56 ++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 43 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index b3ec343..32b16fe 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -57,31 +57,17 @@ static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
 }
 
 /**
- * kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
- *
- * @of: associated kernfs_open_file instance.
- * @kn: target kernfs_node.
- *
- * Fetch and return ->attr.open of @kn if @of->list is non empty.
- * If @of->list is not empty we can safely assume that @of is on
- * @kn->attr.open->files list and this guarantees that @kn->attr.open
- * will not vanish i.e. dereferencing outside RCU read-side critical
- * section is safe here.
- *
- * The caller needs to make sure that @of->list is not empty.
+ * of_on - Return the kernfs_open_node of the specified kernfs_open_file
+ * @of: taret kernfs_open_file
  */
-static struct kernfs_open_node *
-kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
+static struct kernfs_open_node *of_on(struct kernfs_open_file *of)
 {
-	struct kernfs_open_node *on;
-
-	on = rcu_dereference_check(kn->attr.open, !list_empty(&of->list));
-
-	return on;
+	return rcu_dereference_protected(of->kn->attr.open,
+					 !list_empty(&of->list));
 }
 
 /**
- * kernfs_deref_open_node_protected - Get kernfs_open_node corresponding to @kn
+ * kernfs_deref_open_node_locked - Get kernfs_open_node corresponding to @kn
  *
  * @kn: target kernfs_node.
  *
@@ -96,7 +82,7 @@ kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
  * The caller needs to make sure that kernfs_open_file_mutex is held.
  */
 static struct kernfs_open_node *
-kernfs_deref_open_node_protected(struct kernfs_node *kn)
+kernfs_deref_open_node_locked(struct kernfs_node *kn)
 {
 	return rcu_dereference_protected(kn->attr.open,
 				lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
@@ -207,12 +193,8 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
 static int kernfs_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of = sf->private;
-	struct kernfs_open_node *on = kernfs_deref_open_node(of, of->kn);
-
-	if (!on)
-		return -EINVAL;
 
-	of->event = atomic_read(&on->event);
+	of->event = atomic_read(&of_on(of)->event);
 
 	return of->kn->attr.ops->seq_show(sf, v);
 }
@@ -235,7 +217,6 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
 	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
 	const struct kernfs_ops *ops;
-	struct kernfs_open_node *on;
 	char *buf;
 
 	buf = of->prealloc_buf;
@@ -257,14 +238,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		goto out_free;
 	}
 
-	on = kernfs_deref_open_node(of, of->kn);
-	if (!on) {
-		len = -EINVAL;
-		mutex_unlock(&of->mutex);
-		goto out_free;
-	}
-
-	of->event = atomic_read(&on->event);
+	of->event = atomic_read(&of_on(of)->event);
 
 	ops = kernfs_ops(of->kn);
 	if (ops->read)
@@ -584,7 +558,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	struct mutex *mutex = NULL;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
-	on = kernfs_deref_open_node_protected(kn);
+	on = kernfs_deref_open_node_locked(kn);
 
 	if (on) {
 		list_add_tail(&of->list, &on->files);
@@ -629,7 +603,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 
-	on = kernfs_deref_open_node_protected(kn);
+	on = kernfs_deref_open_node_locked(kn);
 	if (!on) {
 		mutex_unlock(mutex);
 		return;
@@ -839,7 +813,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 		return;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
-	on = kernfs_deref_open_node_protected(kn);
+	on = kernfs_deref_open_node_locked(kn);
 	if (!on) {
 		mutex_unlock(mutex);
 		return;
@@ -874,11 +848,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
  */
 __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
 {
-	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
-	struct kernfs_open_node *on = kernfs_deref_open_node(of, kn);
-
-	if (!on)
-		return EPOLLERR;
+	struct kernfs_open_node *on = of_on(of);
 
 	poll_wait(of->file, &on->poll, wait);
 
