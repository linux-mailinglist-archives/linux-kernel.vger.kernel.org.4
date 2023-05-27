Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2387F71338D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjE0I6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjE0I6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:58:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C38F124;
        Sat, 27 May 2023 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n+GV4mqY5PO+y28Ga5UeEH8byUiW40IwwmGZjwfXm+M=; b=nb/z7hsbJk8kAEklUDOiq/iL0V
        RPG36Y70bR/6WrqZkjDW7edEuJUwpqjPs+gD0lWnZmq5iZ6QSPAJRSqklWI95lI2vkyqrDGI2zZV1
        pQBlrVvCzG2QQNlA5/t+5MKju2OlAb/JaPulDZttSfBkO4Xkema7KUHEuGEZrqXUOCG7MqGK6QVFi
        TZJA5AX+DT/D94t9Zw5yRbYfViFU+bZatM5cMPLAYYO3k7zhWR65Rgu1kZdHy+gpUnF5GQxR6R1fW
        DSWHWSlpSqKy5WCeW9ZEfUw6HPvlkgsosphEVATePAqJ7PIdV0BPyYRb1ZpdrxhAKH8d6EfuwufXK
        x8AgAkyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2pkF-003i7k-HP; Sat, 27 May 2023 08:57:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76B21300155;
        Sat, 27 May 2023 10:57:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BD47212FC843; Sat, 27 May 2023 10:57:49 +0200 (CEST)
Date:   Sat, 27 May 2023 10:57:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 1/2] locking: Introduce __cleanup__ based guards
Message-ID: <20230527085749.GA35187@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <20230526205855.587341916@infradead.org>
 <20230526212454.GB4057254@hirez.programming.kicks-ass.net>
 <CAHk-=wgt=cq_fU33DCv0=xD30sH8eOGHsEQRJQi=2vtrWt7oPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgt=cq_fU33DCv0=xD30sH8eOGHsEQRJQi=2vtrWt7oPQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 02:54:40PM -0700, Linus Torvalds wrote:
> What's wrong with just writing it out:
> 
>     typedef struct fd guard_fdget_type_t;
>     static inline struct fd guard_fdget_init(int fd)
>     { return fdget(fd); }
>     static inline void guard_fdget_exit(struct fd fd)
>     { fdput(fd); }
> 

(wrong guard type, ptr_guard vs lock_guard) but yeah, I had this same
realization during breakfast. Clearly the brain had already left last
night.

Specifically, I think we want ptr_guard() here (and possibly fdnull for
__to_fd(0)) for things like do_sendfile() where a struct fd is
initialized late.

The below seems to compile...

--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/posix_types.h>
 #include <linux/errno.h>
+#include <linux/guards.h>
 
 struct file;
 
@@ -45,6 +46,13 @@ static inline void fdput(struct fd fd)
 		fput(fd.file);
 }
 
+typedef struct fd ptr_guard_fdput_t;
+
+static inline void ptr_guard_fdput_cleanup(struct fd *fdp)
+{
+	fdput(*fdp);
+}
+
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_raw(unsigned int fd);
 extern struct file *fget_task(struct task_struct *task, unsigned int fd);
@@ -58,6 +66,8 @@ static inline struct fd __to_fd(unsigned
 	return (struct fd){(struct file *)(v & ~3),v & 3};
 }
 
+#define fdnull	__to_fd(0)
+
 static inline struct fd fdget(unsigned int fd)
 {
 	return __to_fd(__fdget(fd));
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1180,7 +1180,8 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		  	   size_t count, loff_t max)
 {
-	struct fd in, out;
+	ptr_guard(fdput, in) = fdnull;
+	ptr_guard(fdput, out) = fdnull;
 	struct inode *in_inode, *out_inode;
 	struct pipe_inode_info *opipe;
 	loff_t pos;
@@ -1191,35 +1192,35 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	/*
 	 * Get input file, and verify that it is ok..
 	 */
-	retval = -EBADF;
 	in = fdget(in_fd);
 	if (!in.file)
-		goto out;
+		return -EBADF;
 	if (!(in.file->f_mode & FMODE_READ))
-		goto fput_in;
-	retval = -ESPIPE;
+		return -EBADF;
+
 	if (!ppos) {
 		pos = in.file->f_pos;
 	} else {
 		pos = *ppos;
 		if (!(in.file->f_mode & FMODE_PREAD))
-			goto fput_in;
+			return -ESPIPE;
 	}
+
 	retval = rw_verify_area(READ, in.file, &pos, count);
 	if (retval < 0)
-		goto fput_in;
+		return retval;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
 
 	/*
 	 * Get output file, and verify that it is ok..
 	 */
-	retval = -EBADF;
 	out = fdget(out_fd);
 	if (!out.file)
-		goto fput_in;
+		return -EBADF;
 	if (!(out.file->f_mode & FMODE_WRITE))
-		goto fput_out;
+		return -EBADF;
+
 	in_inode = file_inode(in.file);
 	out_inode = file_inode(out.file);
 	out_pos = out.file->f_pos;
@@ -1228,9 +1229,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);
 
 	if (unlikely(pos + count > max)) {
-		retval = -EOVERFLOW;
 		if (pos >= max)
-			goto fput_out;
+			return -EOVERFLOW;
 		count = max - pos;
 	}
 
@@ -1249,7 +1249,7 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	if (!opipe) {
 		retval = rw_verify_area(WRITE, out.file, &out_pos, count);
 		if (retval < 0)
-			goto fput_out;
+			return retval;
 		file_start_write(out.file);
 		retval = do_splice_direct(in.file, &pos, out.file, &out_pos,
 					  count, fl);
@@ -1278,11 +1278,6 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	if (pos > max)
 		retval = -EOVERFLOW;
 
-fput_out:
-	fdput(out);
-fput_in:
-	fdput(in);
-out:
 	return retval;
 }
 
