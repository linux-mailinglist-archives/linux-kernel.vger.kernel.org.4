Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923275B3A55
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiIIOCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiIIOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7A598747;
        Fri,  9 Sep 2022 07:00:33 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732032;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q40rtG18u8jATsEwUZwL2Axv+e19RXXOpHw8VAcQiHo=;
        b=oxm+VkpJVL2wKC67xWvNT1lovJJseqVyYxheEXBw5r4Xzn92nMSVo/dG9ZmWUfyYfaF7iq
        rOB4uzCFPBh02egS+/Aw9F4mln5CbJLBDhnUKdJMP9jmLMjg9AMD4aheF0QEppiCXPqVwT
        s2Ypm638R5LSRD1ienFH8x41e5e8lUiV3XaJsydEt69mrmtjt39ePqQ2LCesZk8VyuQNM9
        7holmGi1wIODquoyDhJfrOaG7o5ND1d4NbXbzeS/V5pQwmdqaYtR0b2hHR7tfrq3khmeYl
        b3PR8EsGx916QNQSJfLGsm2bxnW11xsKT4QVQATZvRXPXoKx1oDTugjx2lA2Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732032;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q40rtG18u8jATsEwUZwL2Axv+e19RXXOpHw8VAcQiHo=;
        b=W+fjxeXatrJNKNigIr6JeQifs9VKz8enfdIdR8LVqcV6WM9RDfMHYNasWv0CPLDSpP+pfI
        YT/BEGuHBYvl2vBg==
From:   "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] kernfs: Skip kernfs_drain_open_files() more aggressively
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220828050440.734579-5-tj@kernel.org>
References: <20220828050440.734579-5-tj@kernel.org>
MIME-Version: 1.0
Message-ID: <166273203091.401.5901314524913352515.tip-bot2@tip-bot2>
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

Commit-ID:     bdb2fd7fc56e197a63c0b0e7e07d25d5e20e7c72
Gitweb:        https://git.kernel.org/tip/bdb2fd7fc56e197a63c0b0e7e07d25d5e20e7c72
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Sat, 27 Aug 2022 19:04:35 -10:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:08:44 +02:00

kernfs: Skip kernfs_drain_open_files() more aggressively

Track the number of mmapped files and files that need to be released and
skip kernfs_drain_open_file() if both are zero, which are the precise
conditions which require draining open_files. The early exit test is
factored into kernfs_should_drain_open_files() which is now tested by
kernfs_drain_open_files()'s caller - kernfs_drain().

This isn't a meaningful optimization on its own but will enable future
stand-alone kernfs_deactivate() implementation.

v2: Chengming noticed that on->nr_to_release was leaking after ->open()
    failure. Fix it by telling kernfs_unlink_open_file() that it's called
    from the ->open() fail path and should dec the counter. Use kzalloc() to
    allocate kernfs_open_node so that the tracking fields are correctly
    initialized.

Cc: Chengming Zhou <zhouchengming@bytedance.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20220828050440.734579-5-tj@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c             |  3 +-
 fs/kernfs/file.c            | 65 ++++++++++++++++++++++++------------
 fs/kernfs/kernfs-internal.h |  1 +-
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 1cc88ba..8ae44db 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -489,7 +489,8 @@ static void kernfs_drain(struct kernfs_node *kn)
 		rwsem_release(&kn->dep_map, _RET_IP_);
 	}
 
-	kernfs_drain_open_files(kn);
+	if (kernfs_should_drain_open_files(kn))
+		kernfs_drain_open_files(kn);
 
 	down_write(&root->kernfs_rwsem);
 }
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 7060a2a..9ab6c92 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -23,6 +23,8 @@ struct kernfs_open_node {
 	atomic_t		event;
 	wait_queue_head_t	poll;
 	struct list_head	files; /* goes through kernfs_open_file.list */
+	unsigned int		nr_mmapped;
+	unsigned int		nr_to_release;
 };
 
 /*
@@ -527,6 +529,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 
 	rc = 0;
 	of->mmapped = true;
+	of_on(of)->nr_mmapped++;
 	of->vm_ops = vma->vm_ops;
 	vma->vm_ops = &kernfs_vm_ops;
 out_put:
@@ -562,7 +565,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 
 	if (!on) {
 		/* not there, initialize a new one */
-		on = kmalloc(sizeof(*on), GFP_KERNEL);
+		on = kzalloc(sizeof(*on), GFP_KERNEL);
 		if (!on) {
 			mutex_unlock(mutex);
 			return -ENOMEM;
@@ -574,6 +577,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	}
 
 	list_add_tail(&of->list, &on->files);
+	if (kn->flags & KERNFS_HAS_RELEASE)
+		on->nr_to_release++;
 
 	mutex_unlock(mutex);
 	return 0;
@@ -584,6 +589,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
  *
  *	@kn: target kernfs_node
  *	@of: associated kernfs_open_file
+ *	@open_failed: ->open() failed, cancel ->release()
  *
  *	Unlink @of from list of @kn's associated open files. If list of
  *	associated open files becomes empty, disassociate and free
@@ -593,7 +599,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
  *	None.
  */
 static void kernfs_unlink_open_file(struct kernfs_node *kn,
-				 struct kernfs_open_file *of)
+				    struct kernfs_open_file *of,
+				    bool open_failed)
 {
 	struct kernfs_open_node *on;
 	struct mutex *mutex;
@@ -606,8 +613,16 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 		return;
 	}
 
-	if (of)
+	if (of) {
+		if (kn->flags & KERNFS_HAS_RELEASE) {
+			WARN_ON_ONCE(of->released == open_failed);
+			if (open_failed)
+				on->nr_to_release--;
+		}
+		if (of->mmapped)
+			on->nr_mmapped--;
 		list_del(&of->list);
+	}
 
 	if (list_empty(&on->files)) {
 		rcu_assign_pointer(kn->attr.open, NULL);
@@ -734,7 +749,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	return 0;
 
 err_put_node:
-	kernfs_unlink_open_file(kn, of);
+	kernfs_unlink_open_file(kn, of, true);
 err_seq_release:
 	seq_release(inode, file);
 err_free:
@@ -766,6 +781,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 		 */
 		kn->attr.ops->release(of);
 		of->released = true;
+		of_on(of)->nr_to_release--;
 	}
 }
 
@@ -782,7 +798,7 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 		mutex_unlock(mutex);
 	}
 
-	kernfs_unlink_open_file(kn, of);
+	kernfs_unlink_open_file(kn, of, false);
 	seq_release(inode, filp);
 	kfree(of->prealloc_buf);
 	kfree(of);
@@ -790,25 +806,30 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-void kernfs_drain_open_files(struct kernfs_node *kn)
+bool kernfs_should_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
-	struct kernfs_open_file *of;
-	struct mutex *mutex;
-
-	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
-		return;
+	bool ret;
 
 	/*
-	 * lockless opportunistic check is safe below because no one is adding to
-	 * ->attr.open at this point of time. This check allows early bail out
-	 * if ->attr.open is already NULL. kernfs_unlink_open_file makes
-	 * ->attr.open NULL only while holding kernfs_open_file_mutex so below
-	 * check under kernfs_open_file_mutex_ptr(kn) will ensure bailing out if
-	 * ->attr.open became NULL while waiting for the mutex.
+	 * @kn being deactivated guarantees that @kn->attr.open can't change
+	 * beneath us making the lockless test below safe.
 	 */
-	if (!rcu_access_pointer(kn->attr.open))
-		return;
+	WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
+
+	rcu_read_lock();
+	on = rcu_dereference(kn->attr.open);
+	ret = on && (on->nr_mmapped || on->nr_to_release);
+	rcu_read_unlock();
+
+	return ret;
+}
+
+void kernfs_drain_open_files(struct kernfs_node *kn)
+{
+	struct kernfs_open_node *on;
+	struct kernfs_open_file *of;
+	struct mutex *mutex;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_locked(kn);
@@ -820,13 +841,17 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
 
-		if (kn->flags & KERNFS_HAS_MMAP)
+		if (of->mmapped) {
 			unmap_mapping_range(inode->i_mapping, 0, 0, 1);
+			of->mmapped = false;
+			on->nr_mmapped--;
+		}
 
 		if (kn->flags & KERNFS_HAS_RELEASE)
 			kernfs_release_file(kn, of);
 	}
 
+	WARN_ON_ONCE(on->nr_mmapped || on->nr_to_release);
 	mutex_unlock(mutex);
 }
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 3ae214d..fc5821e 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -157,6 +157,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
  */
 extern const struct file_operations kernfs_file_fops;
 
+bool kernfs_should_drain_open_files(struct kernfs_node *kn);
 void kernfs_drain_open_files(struct kernfs_node *kn);
 
 /*
