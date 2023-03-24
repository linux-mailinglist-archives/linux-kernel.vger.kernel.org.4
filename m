Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5566C867A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjCXUAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjCXUAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:00:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C961EBFE;
        Fri, 24 Mar 2023 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=135fv2f4kM2qso2NGzM8eNW0zX5oqguesMQfHWAJojU=; b=BqOlIbPEM48OJumyLLa/yNGycP
        MiyWKa/DAo5tHhP3X4u/7Q0h0EVk/8NCvoZnTHGWIxVxpbrNPkH3jUmxHU8eU01LKzQ0Yp9aFCtzl
        rWJGik+pSQd1P0bUfum1+cjnZyDLRAwz1KjsOyxGdUTe5MwTDMPV4CfIxBZTrjhOOydKWklsz1H/H
        XYZPZiFd7mJMiHEfHo2nyXUhaDMmkLt8LO8Vzb0bIoZkeJl3M/436fIqJCAOZsXtd+a1CvkmRaIvP
        iUuE42mr6lgYsXagFskU67wNBtqjaPzj7g8T1aXGAXLncTvimMM/Rlwas0l2rchYLTHVIGXLWkBWv
        tfs0oFXg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfnZv-005UVz-0b;
        Fri, 24 Mar 2023 19:59:59 +0000
Date:   Fri, 24 Mar 2023 12:59:59 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZB4BP0ZgxNirBNOJ@bombadil.infradead.org>
References: <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
 <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
 <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 12:11:07PM -0700, Linus Torvalds wrote:
> On Fri, Mar 24, 2023 at 10:54 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > +/*
> > + * This clutch ensures we only allow a certain number concurrent threads at a
> 
> kludge, not clutch.
> 
> And it's much worse than a kludge. It's just wrong and disgusting.

I wasn't happy with it either...

> > +               pr_warn_ratelimited("kread_concurrent_max (%u) close to 0 (max_loads: %u), throttling...",
> > +                                   atomic_read(&kread_concurrent_max),
> > +                                   MAX_KREAD_CONCURRENT);
> 
> This is also wrong, since it's not kernel_read_file() that is the
> problem, but whatever broken caller.
> 
> Yeah, yeah, in practice it's presumably always just finit_module()
> doing kernel_read_file_from_fd(), but it's still *completely* wrong to
> just say "function X is throttling" when "X" isn't the problem, and
> doesn't tell what the _real_ problem is.

True.

> I really think this all needs some core fixing at the module layer,
> not these kinds of horrific hacks.

On the modules side of things we can be super defensive on the second
vmalloc allocation defensive [0] but other than this the initial kread
also needs care too.

To address the kread abuse within finit_module we could just move the
kludge to the modules side of things until each free happens as in the
below alternative. That just means any easy user interfacing call with
kernel_read*() would likely have to be as careful. Untested below.

[0] https://lkml.kernel.org/r/20230319214926.1794108-4-mcgrof@kernel.org

  Luis

From 3c3f7e597ab35b4482ccb4064bb897eefa449071 Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Fri, 24 Mar 2023 12:51:44 -0700
Subject: [PATCH] module: kludge

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 45 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 145e15f19576..a96de989532a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -62,6 +62,16 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
 
+#define MAX_INITMOD_CONCURRENT 50
+static atomic_t initmod_concurrent_max = ATOMIC_INIT(MAX_INITMOD_CONCURRENT);
+static DECLARE_WAIT_QUEUE_HEAD(initmod_wq);
+
+/*
+ * How much time to wait for *all*  MAX_INITMOD_CONCURRENT threads running
+ * at the same time without returning.
+ */
+#define MAX_INITMOD_ALL_BUSY_TIMEOUT 5
+
 /*
  * Mutex protects:
  * 1) List of modules (also safely readable with preempt_disable),
@@ -3015,6 +3025,30 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 	return load_module(&info, uargs, 0);
 }
 
+static int module_kread_concurrent(void)
+{
+	int err;
+
+	if (atomic_dec_if_positive(&initmod_concurrent_max) < 0) {
+		pr_warn_ratelimited("finit_module: initkmod_concurrent_max (%u) close to 0 (max_loads: %u), throttling...",
+				    atomic_read(&initmod_concurrent_max),
+				    MAX_INITMOD_CONCURRENT);
+		err = wait_event_killable_timeout(initmod_wq,
+						  atomic_dec_if_positive(&initmod_concurrent_max) >= 0,
+						  MAX_INITMOD_ALL_BUSY_TIMEOUT * HZ);
+		if (!err) {
+			pr_warn_ratelimited("finit_module: loading module cannot be processed, kernel busy with %d threads loading modules now for more than %d seconds",
+					    MAX_INITMOD_CONCURRENT, MAX_INITMOD_ALL_BUSY_TIMEOUT);
+			return -ETIME;
+		} else if (err == -ERESTARTSYS) {
+			pr_warn_ratelimited("finit_module: sigkill sent for load_module giving up");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 {
 	struct load_info info = { };
@@ -3033,6 +3067,10 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_COMPRESSED_FILE))
 		return -EINVAL;
 
+	err = module_kread_concurrent();
+	if (err)
+		return err;
+
 	len = kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
 				       READING_MODULE);
 	if (len < 0)
@@ -3048,7 +3086,12 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		info.len = len;
 	}
 
-	return load_module(&info, uargs, flags);
+	err = load_module(&info, uargs, flags);
+
+	atomic_inc(&initmod_concurrent_max);
+	wake_up(&initmod_wq);
+
+	return err;
 }
 
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
-- 
2.39.2

