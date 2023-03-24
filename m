Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018D26C83D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCXRzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCXRzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:55:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF01ADE5;
        Fri, 24 Mar 2023 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hu73elvv0tFkfQ4u9mxaw6WBqJ3lxONcSdBvxNIoNwE=; b=fRQdikpdwzvk/XSeweAT7ns59U
        ZHcveOSHFxUDb6xiaR9rzotjiSowTLvquasOKGzJZzJZNJkai7eAC9+CDmaSA5Vio8PeRmXdguG5n
        5k5mSLeAabArtLntYF+aECxPK5esuDF9pEXCdXGf2m9JgNSUOnaixpYn0I3aq/YuzCZBDfkpEixSH
        kWhZhOGyKDUpJlAd4u7cw/7DRBc044TS/0ccxjSjbRN41P5EN5X68mLqq4No1ST/XZTixpQQchRhu
        kKtDg1Dgy2DYQ87LhMirP4U/hKEvjk6QAF3OaFdUXmQMe1fe4yIeYGgxzvnFpFt3hwxqf64PJ8Rc0
        r/21ZYtQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pflcd-005ADo-1Q;
        Fri, 24 Mar 2023 17:54:39 +0000
Date:   Fri, 24 Mar 2023 10:54:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
References: <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
 <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
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

On Fri, Mar 24, 2023 at 10:27:14AM +0100, David Hildenbrand wrote:
> On 21.03.23 20:32, David Hildenbrand wrote:
> > On 20.03.23 22:27, Luis Chamberlain wrote:
> > > On Mon, Mar 20, 2023 at 02:23:36PM -0700, Luis Chamberlain wrote:
> > > > On Mon, Mar 20, 2023 at 10:15:23PM +0100, David Hildenbrand wrote:
> > > > > Not able to reproduce with 20230319-module-alloc-opts so far (2 tries).
> > > > 
> > > > Oh wow, so to clarify, it boots OK?
> > > > 
> > > 
> > > Now that we know that tree works, I'm curious also now if you can
> > > confirm just re-ordering the patches still works (it should)
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts-adjust
> > > 
> > 
> > So far no vmap errors booting the debug/kasan kernel (2 tries).

<-- snip -->

> > I think we primarily only care about systemd-udev-settle.service.
> > 
> > That is fastest without the rcu patch (~6s), compared to with the rcu
> > patch (~6.5s) and with stock (~7.5s -- 8s).
> > 
> > Looks like dracut-initqueue also might be a bit faster with your changes, but
> > maybe it's mostly noise (would have to do more runs).
> > 
> > So maybe drop that rcu patch? But of course, there could be other scenarios where it's
> > helpful ...

Yes I confirm the RCU patch does not help at all now also using
stress-ng.

> Are there any other things you would like me to measure/test? I'll have to
> hand back that test machine soonish.

Yes please test the below. Perhaps its not the final form we want, but
it *does* fix OOM'ing when thrashing with stress-ng now with the module
option and even with 100 threads brings down max memory consumption by
259 MiB. The reason is that we also vmalloc during each finit_read_file()
for each module as well way before we even do layout_and_allocate(), and
so obviously if we fix the module path but not this path this will eventually
catch up with us as. I'm not at all happy with the current approach given
ideally we'd bump the counter when the user is done with the file, but we
don't yet have any tracking of that for users, they just vfree the memory
itself. And so this is just trying to catch heavy immediate abuse on the
caller to fend off abuse of vmalloc uses in a lightway manner.

There's gotta be a better way to do this, but its just an idea I have so far.
If we *want* to keep tabs until the user is done, we have to just modify
most users of these APIs and intrudce our own free. I don't think we're
in a rush to fix this so maybe that's the better approach.

And so I've managed to reproduce the issues you found now with my new stress-ng
module stressor as well.

https://github.com/ColinIanKing/stress-ng.git

Even though you have 400 CPUs with stress-ng we can likely reproduce it
with (use a module not loaded on your system):

./stress-ng --module 100 --module-name xfs

Without the patch below using 400 threads still OOMs easily due to the
kread issue. Max threads allowed are 8192.

From ec5099b15bb74f154319034547184e81e4ad8ba0 Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Fri, 24 Mar 2023 10:35:41 -0700
Subject: [PATCH] fs/kernel_read_file: add a clutch

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/kernel_read_file.c | 52 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 5d826274570c..2d55abe73b21 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -1,10 +1,52 @@
 // SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "kread: " fmt
+
 #include <linux/fs.h>
 #include <linux/fs_struct.h>
 #include <linux/kernel_read_file.h>
 #include <linux/security.h>
 #include <linux/vmalloc.h>
 
+/*
+ * This clutch ensures we only allow a certain number concurrent threads at a
+ * time allocating space concurrently and they must all finish within the
+ * timeout specified.  Anything more we know we're thrashing.
+ */
+#define MAX_KREAD_CONCURRENT 20
+static atomic_t kread_concurrent_max = ATOMIC_INIT(MAX_KREAD_CONCURRENT);
+static DECLARE_WAIT_QUEUE_HEAD(kread_wq);
+
+/*
+ * How many seconds to wait for *all*  MAX_KREAD_CONCURRENT threads running
+ * at the same time without returning.
+ */
+#define MAX_KREAD_ALL_BUSY_TIMEOUT 1
+
+static int kernel_read_check_concurrent(void)
+{
+	int ret;
+
+	if (atomic_dec_if_positive(&kread_concurrent_max) < 0) {
+		pr_warn_ratelimited("kread_concurrent_max (%u) close to 0 (max_loads: %u), throttling...",
+				    atomic_read(&kread_concurrent_max),
+				    MAX_KREAD_CONCURRENT);
+		ret = wait_event_killable_timeout(kread_wq,
+						  atomic_dec_if_positive(&kread_concurrent_max) >= 0,
+						  MAX_KREAD_ALL_BUSY_TIMEOUT * HZ);
+		if (!ret) {
+			pr_warn_ratelimited("reading cannot be processed, kernel busy with %d threads reading files now for more than %d seconds",
+					    MAX_KREAD_CONCURRENT, MAX_KREAD_ALL_BUSY_TIMEOUT);
+			return -ETIME;
+		} else if (ret == -ERESTARTSYS) {
+			pr_warn_ratelimited("sigkill sent for kernel read, giving up");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * kernel_read_file() - read file contents into a kernel buffer
  *
@@ -68,10 +110,14 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
 		goto out;
 	}
 
+	ret = kernel_read_check_concurrent();
+	if (ret)
+		goto out;
+
 	whole_file = (offset == 0 && i_size <= buf_size);
 	ret = security_kernel_read_file(file, id, whole_file);
 	if (ret)
-		goto out;
+		goto out_allow_new_read;
 
 	if (file_size)
 		*file_size = i_size;
@@ -117,7 +163,9 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
 			*buf = NULL;
 		}
 	}
-
+out_allow_new_read:
+	atomic_inc(&kread_concurrent_max);
+	wake_up(&kread_wq);
 out:
 	allow_write_access(file);
 	return ret == 0 ? copied : ret;
-- 
2.39.2

