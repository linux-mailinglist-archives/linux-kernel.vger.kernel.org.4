Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D4474366B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjF3IEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjF3IEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B682D50
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17CCB616D8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E92C433C0;
        Fri, 30 Jun 2023 08:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688112258;
        bh=BSxR6KsOVnaZSz9CJvy9FpmHQ1QZSEPtTTUPoyrhzUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HyZnletwUQC0CjLbUmX/6ryQjVObm9pYNhEbjBdB12oynBgrbqFDxscIpZRBBCI+y
         NzeswjREf+se0rIQOL362KruG3UoL1P6tcSK87PEoLC7VWtj6uPBlh+FNdxhJ4xHx+
         wFh0mJfdyrSCulE5S/dHsT4NgrB9dW32l3RKyH2s5klf7AK7WI5cbhZZjP7beFnXfN
         SvRlNFMfeeS8/btTOprqQdvjydIgnwQ8WWsuM4EkGsVrGQ+S6jhTUAhLEvIFHEj75r
         +B3kbxpnpPLbdW4q/GXJlfWC389/QO12mcdc2uKNxVrIt4Y0PY3hPc0zjF8//LMoPO
         IJHAvftXBpWuQ==
Date:   Fri, 30 Jun 2023 10:04:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pid: use flex array
Message-ID: <20230630-stiefel-rotor-7f2d13fc084f@brauner>
References: <20230628-pokal-puzzeln-5199c679b051@brauner>
 <CAHk-=wiBXJOzkez2Rd=cQ5ckttJq6OdYtArFmCtVQHyeuQBGrw@mail.gmail.com>
 <20230630-testphasen-orangen-0e54486a267d@brauner>
 <CAHk-=whJJbmfBk_8v_vFn1NdJ9O-AKCrjY+EArkzgFp9h-sKHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whJJbmfBk_8v_vFn1NdJ9O-AKCrjY+EArkzgFp9h-sKHA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 12:12:22AM -0700, Linus Torvalds wrote:
> On Thu, 29 Jun 2023 at 23:51, Christian Brauner <brauner@kernel.org> wrote:
> >
> > I have no preference for either syntax. Both work. But this is probably
> > more an objection to this being mixed in with the flex array change in
> > the first place.
> 
> Yes. I looked at it, and tried to figure out if it was related
> somehow, and decided that no, it can't possibly be, and must be just
> an unrelated change.

Yeah, I admit that I would've paid more attention to this detail if it
would've been in a fs/ codepath. So that's fully on me.

> 
> > I did react to that in the original review here:
> > https://lore.kernel.org/all/20230518-zuneigen-brombeeren-0a57cd32b1a7@brauner
> > but then I grepped for it and saw it done in a few other places already
> 
> Yeah, we do end up growing new uses of 'use 0 as a pointer' almost as
> quickly as we get rid of them.
> 
> We got rid of a couple just recently in commit dadeeffbe525 ("fbdev:
> hitfb: Use NULL for pointers"), but yes, a quick
> 
>     git grep '\*)0\>'
> 
> shows many more.
> 
> And some of them are even ok. I don't think it's always wrong,
> particularly if you then abstract it out.
> 
> So doing something like that
> 
>    #define PCI_IOBASE ((void __iomem *)0)
> 
> makes perfect sense. It's literally abstracting out something real (in
> this case yes, it looks like a NULL pointer, but it's actually a
> pointer with a strict type that just happens to have the value zero.
> 
> So that "NULL pointer with a type" concept makes sense, but it really
> should be abstracted out, not be in the middle of some random code.
> 
> And that's *particularly* true when we already have the exact
> abstraction for the situation that the code then uses (ie in this case
> that "struct_size_t()" thing). Writing it out - in an ugly form -
> using the disgusting traditional "constant integer zero can be cast to
> any pointer" thing - just makes me go "Eugghhh!".
> 
> I mean, if this ugly part was just a small detail in a l;arger patch,
> I probably would just have let it slide. It works. It is what it is.
> 
> But when three quarters of the patch was stuff I found questionable, I
> just couldn't stomach it.
> 
> I'm looking at some of the grep hits, and I'm going "ok, that's a C++
> programmer". I think there's a very real reason why so many of them
> are in bpf code and in the bpf tests.
> 
> C++ made a *huge* fundamental design mistake early on wrt NULL, and a
> generation of C++ programmers were poisoned by it and you had people
> who swore until they were blue that 0 and NULL had to be the same
> thing.
> 
> They were horribly and utterly wrong. But sometimes when it takes you
> three decades to admit that you were wrong all that time, it's just
> too painful to admit.
> 
> There are literally people who still can't admit to their mistake, and
> refuse to use NULL, and use either 0 or 'nullptr'.

I have to admit that I've never touched C++ in my life in any meaningful
way. It was C, Go, and then Rust...

I've grepped around a bit and I saw that the
struct_size((struct bla *)NULL, ...)
pattern seems to be used in most places that have similar needs. Not
sure if there's something nicer.

I gave this thing a stab myself since I have a few minutes and so Kees
doesn't have to do it. Authorship retained and dropped the ack. Is the
following more acceptable? 

From ee7cb2546ff47d02e284fd8461ae1c57fab8ca49 Mon Sep 17 00:00:00 2001
From: Kees Cook <keescook@chromium.org>
Date: Fri, 30 Jun 2023 09:46:17 +0200
Subject: [PATCH] pid: Replace struct pid 1-element array with flex-array

For pid namespaces, struct pid uses a dynamically sized array member,
"numbers". This was implemented using the ancient 1-element fake flexible
array, which has been deprecated for decades. Replace it with a C99
flexible array, refactor the array size calculations to use struct_size(),
and address elements via indexes. Note that the static initializer (which
defines a single element) works as-is, and requires no special handling.

Without this, CONFIG_UBSAN_BOUNDS (and potentially CONFIG_FORTIFY_SOURCE)
will trigger bounds checks:
https://lore.kernel.org/lkml/20230517-bushaltestelle-super-e223978c1ba6@brauner

Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jeff Xu <jeffxu@google.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Reported-by: syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com
[brauner: dropped unrelated changes and remove 0 with NULL cast]
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/pid.h    | 2 +-
 kernel/pid.c           | 7 +++++--
 kernel/pid_namespace.c | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index b75de288a8c2..653a527574c4 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -67,7 +67,7 @@ struct pid
 	/* wait queue for pidfd notifications */
 	wait_queue_head_t wait_pidfd;
 	struct rcu_head rcu;
-	struct upid numbers[1];
+	struct upid numbers[];
 };
 
 extern struct pid init_struct_pid;
diff --git a/kernel/pid.c b/kernel/pid.c
index f93954a0384d..8bce3aebc949 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -656,8 +656,11 @@ void __init pid_idr_init(void)
 
 	idr_init(&init_pid_ns.idr);
 
-	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
-			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+	init_pid_ns.pid_cachep = kmem_cache_create("pid",
+			struct_size((struct pid *)NULL, numbers, 1),
+			__alignof__(struct pid),
+			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT,
+			NULL);
 }
 
 static struct file *__pidfd_fget(struct task_struct *task, int fd)
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index b43eee07b00c..70a929784a5d 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -48,7 +48,7 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
 		return kc;
 
 	snprintf(name, sizeof(name), "pid_%u", level + 1);
-	len = sizeof(struct pid) + level * sizeof(struct upid);
+	len = struct_size((struct pid *)NULL, numbers, level + 1);
 	mutex_lock(&pid_caches_mutex);
 	/* Name collision forces to do allocation under mutex. */
 	if (!*pkc)
-- 
2.34.1

