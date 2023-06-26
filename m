Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A725373E1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjFZOTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjFZOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:18:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7335A1720;
        Mon, 26 Jun 2023 07:18:15 -0700 (PDT)
Date:   Mon, 26 Jun 2023 16:16:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687789013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1L0etSR0RGYYlmnj1+miSkCX1XRBVH2gUqAUsxxz9Mk=;
        b=OF3BmZOBrB0ypWY3DNmKNl/q8XaC1wXzB6lyJdpjW/GpOqCQAeOTMujcqn0zkB3Sp1qOVV
        70EQW6YIsyXspUcPIBOQ6/7sXDVs1L9sCClcagSt/NBY0ox4LrHxvu7KMccxddSi5VdXKQ
        zYl/k90x+pJcnBxqtfIvLlFOa/pdbFNRik+6/xI++kHGhLyq2aIWAml1tI3hXWWKVp64Wj
        8LeT0HBR7Da7z4/pVmCkE9YV8gHwDdE/Vw5PkYHQTWM+rtdIqjyEd1eMMxhqIsUsO5bH64
        x3eVQUJV19ae4pJEjNe59AyOvWALPyRuZbL3M1M9vQLkZkAeyWyxwVd9Kfu7pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687789013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1L0etSR0RGYYlmnj1+miSkCX1XRBVH2gUqAUsxxz9Mk=;
        b=cao/ns+xdKNIIolBSJZjpZRzSm7F/xz6VYOXVFB6+EtYvnFZgz8/UJPTObh7ibif6Pici2
        JPXYjC9REenI41Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.4-rt6
Message-ID: <20230626141651.QqgQ4cvf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.4-rt6 patch set. 

Changes since v6.4-rt5:

  - Closing a bpf socket caused a RCU warning.

  - While updating the zonelist due to memory-hotplug, a lock was
    acquired in the wrong context followed by a "sleeping while atomic"
    warning. Addressing this issue required additionally a change to
    printk and lockdep's annotation for seqcount.

Known issues
     None

The delta patch against v6.4-rt5 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.4/incr/patch-6.4-rt5-rt6.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.4-rt6

The RT patch against v6.4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.4/older/patch-6.4-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.4/older/patches-6.4-rt6.tar.xz

Sebastian

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 3926e90279477..d778af83c8f36 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -512,8 +512,8 @@ do {									\
 
 static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	do_raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+	do_raw_write_seqcount_begin(s);
 }
 
 /**
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f1c8733f76b83..370a2cda6d854 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2781,28 +2781,31 @@ static void bpf_link_put_deferred(struct work_struct *work)
 	bpf_link_free(link);
 }
 
-/* bpf_link_put can be called from atomic context, but ensures that resources
- * are freed from process context
+/* bpf_link_put might be called from atomic context. It needs to be called
+ * from sleepable context in order to acquire sleeping locks during the process.
  */
 void bpf_link_put(struct bpf_link *link)
 {
 	if (!atomic64_dec_and_test(&link->refcnt))
 		return;
 
-	if (in_atomic()) {
-		INIT_WORK(&link->work, bpf_link_put_deferred);
-		schedule_work(&link->work);
-	} else {
-		bpf_link_free(link);
-	}
+	INIT_WORK(&link->work, bpf_link_put_deferred);
+	schedule_work(&link->work);
 }
 EXPORT_SYMBOL(bpf_link_put);
 
+static void bpf_link_put_direct(struct bpf_link *link)
+{
+	if (!atomic64_dec_and_test(&link->refcnt))
+		return;
+	bpf_link_free(link);
+}
+
 static int bpf_link_release(struct inode *inode, struct file *filp)
 {
 	struct bpf_link *link = filp->private_data;
 
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 	return 0;
 }
 
@@ -4778,7 +4781,7 @@ static int link_update(union bpf_attr *attr)
 	if (ret)
 		bpf_prog_put(new_prog);
 out_put_link:
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 	return ret;
 }
 
@@ -4801,7 +4804,7 @@ static int link_detach(union bpf_attr *attr)
 	else
 		ret = -EOPNOTSUPP;
 
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 	return ret;
 }
 
@@ -4871,7 +4874,7 @@ static int bpf_link_get_fd_by_id(const union bpf_attr *attr)
 
 	fd = bpf_link_new_fd(link);
 	if (fd < 0)
-		bpf_link_put(link);
+		bpf_link_put_direct(link);
 
 	return fd;
 }
@@ -4948,7 +4951,7 @@ static int bpf_iter_create(union bpf_attr *attr)
 		return PTR_ERR(link);
 
 	err = bpf_iter_new_fd(link);
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 
 	return err;
 }
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 5c1470bd60bcb..a324eaeb25333 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -39,13 +39,13 @@ void __printk_safe_exit(unsigned long *flags)
 
 void __printk_deferred_enter(void)
 {
-	WARN_ON_ONCE(!in_atomic());
+	cant_migrate();
 	this_cpu_inc(printk_context.recursion);
 }
 
 void __printk_deferred_exit(void)
 {
-	WARN_ON_ONCE(!in_atomic());
+	cant_migrate();
 	this_cpu_dec(printk_context.recursion);
 }
 
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e1..8fc605d806670 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421bedc12b7..440e9af67b48d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5808,19 +5808,17 @@ static void __build_all_zonelists(void *data)
 	unsigned long flags;
 
 	/*
-	 * Explicitly disable this CPU's interrupts before taking seqlock
-	 * to prevent any IRQ handler from calling into the page allocator
-	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
+	 * The zonelist_update_seq must be acquired with irqsave because the
+	 * reader can be invoked from IRQ with GFP_ATOMIC.
 	 */
-	local_irq_save(flags);
+	write_seqlock_irqsave(&zonelist_update_seq, flags);
 	/*
-	 * Explicitly disable this CPU's synchronous printk() before taking
-	 * seqlock to prevent any printk() from trying to hold port->lock, for
+	 * Also disable synchronous printk() to prevent any printk() from
+	 * trying to hold port->lock, for
 	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
 	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
 	 */
 	printk_deferred_enter();
-	write_seqlock(&zonelist_update_seq);
 
 #ifdef CONFIG_NUMA
 	memset(node_load, 0, sizeof(node_load));
@@ -5857,9 +5855,8 @@ static void __build_all_zonelists(void *data)
 #endif
 	}
 
-	write_sequnlock(&zonelist_update_seq);
 	printk_deferred_exit();
-	local_irq_restore(flags);
+	write_sequnlock_irqrestore(&zonelist_update_seq, flags);
 }
 
 static noinline void __init
