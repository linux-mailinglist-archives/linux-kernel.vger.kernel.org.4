Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E756DFB47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDLQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55719B9;
        Wed, 12 Apr 2023 09:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E045262E8B;
        Wed, 12 Apr 2023 16:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6C0C433EF;
        Wed, 12 Apr 2023 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681316719;
        bh=9BRGVY84Mm7DSgLjIFsrtE+7D4sPwCpDRpavPnsD3QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PihAhKadnnKOAL+Arqm9GNj+O2GIOLDbnHOMYqRoSxlQ0Nc2o8ApIUSVU+jlQNLvn
         lVL4bydR0mVeIjjeffGTO2010J70wGRlQLNlwvJw0F82JnZL9uFuYszdpvpLsGBYyb
         7+Yl/M9zn9gujLN09yYzZc+Mvd1TF/n2shd6nJxoTOimvkQsb6CG6NniaKh6vl+TWA
         QEOxc238gtVGponsR47i3xxphb+NXqYL6ZUuRP/H1VmCWh3IQ7PWho/qfpPe7YeAtt
         I8CLLsKFUemUWD1YSGM6PDsZttb0XeCgDEAZYExMtiIghRZ7W4qkQImtuAhF0QwC8y
         QIIv0HiAksk7A==
Date:   Wed, 12 Apr 2023 09:25:17 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20230412162517.gji52t34zlvcu5bh@treble>
References: <20230327120017.6bb826d7@canb.auug.org.au>
 <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
 <20230411215518.u2fgi7napfcwyuce@treble>
 <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
 <20230412001400.yraku5fwsjdchxvk@treble>
 <20230412114400.GB628377@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412114400.GB628377@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 01:44:00PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 11, 2023 at 05:14:00PM -0700, Josh Poimboeuf wrote:
> 
> > Peter, what do you think, should we make track uaccess state across
> > function boundaries?
> 
> So IIRC the goal was to explicitly dis-allow that. You want minimal code
> executed with STAC and hence disallow calling stuff.

I guess I was wondering if we could make an exception for calls to
static IPA-optimized functions, so we wouldn't have to scramble to "fix"
compiler optimizations.

But for now, yeah let's just keep it simple.

Jens, can you confirm this works?  I added __noclone instead of removing
static.

---8<---

From: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] iov_iter: Mark copy_compat_iovec_from_user() noinline

After commit 6376ce56feb6 ("iov_iter: import single vector iovecs as
ITER_UBUF"), GCC does an inter-procedural compiler optimization which
moves the user_access_begin() out of copy_compat_iovec_from_user() and
into its callers:

  lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x0: redundant UACCESS disable
  lib/iov_iter.o: warning: objtool: iovec_from_user.part.0+0xc7: call to copy_compat_iovec_from_user.part.0() with UACCESS enabled
  lib/iov_iter.o: warning: objtool: __import_iovec+0x21d: call to copy_compat_iovec_from_user.part.0() with UACCESS enabled

Enforce the "no UACCESS enable across function boundaries" rule by
disabling cloning for copy_compat_iovec_from_user().

Fixes: 6376ce56feb6 ("iov_iter: import single vector iovecs as ITER_UBUF")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
https://lkml.kernel.org/lkml/20230327120017.6bb826d7@canb.auug.org.au
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 lib/iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 274014e4eafe..48aa9fd99267 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1698,7 +1698,7 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 }
 EXPORT_SYMBOL(dup_iter);
 
-static int copy_compat_iovec_from_user(struct iovec *iov,
+static __noclone int copy_compat_iovec_from_user(struct iovec *iov,
 		const struct iovec __user *uvec, unsigned long nr_segs)
 {
 	const struct compat_iovec __user *uiov =
-- 
2.39.2

