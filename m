Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC40B6D723E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbjDECBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjDECB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:01:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE33ABC;
        Tue,  4 Apr 2023 19:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=bnij7B0KBrBY34+9pqfeC1+5qwU+6Gl1IMo8qKh3a0w=; b=sLskrmc3H71rRgY//Xwu9rGo7X
        aP4mZe/iMJJUITsQCbgmmLjhL0J5B6WIAdIFTVxffAeFdNIiHKUHzc35OnXRMQJGMs/HbiIkmbQbA
        Oi/LUv26ON/XEbYsGEbrNZJ7Tk+ohjnsLW32+jHrRkkB3aTjqwoz/ub8m7KmvZHXNeloOE7Fr0mzh
        vijvMUpKsKJGjjgL+yiEAjlaI5bX0lqfmbMRVkYfJXpnZzptixH4lBIRWIAKWimLFodTQFXGseosL
        7djeMmKOIhVXuLOaejB3zI9u3BAdUbcDP64LJ5cQ6lX6DT1H/iLMrqbjtQ5Ts9n9h1sUg9B4LP2s2
        ZZl4whzA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjsSi-0038fI-1W;
        Wed, 05 Apr 2023 02:01:24 +0000
Date:   Tue, 4 Apr 2023 19:01:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jim.cromie@gmail.com
Cc:     Song Liu <song@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with
 module_memory")
Message-ID: <ZCzWdLOg1i2p1Q67@bombadil.infradead.org>
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
 <ZCaE71aPvvQ/L05L@bombadil.infradead.org>
 <CAPhsuW6P5AYVKMk=G1bEUz5PGZKmTJwtgQBmE-P4iAo7dOr5yA@mail.gmail.com>
 <ZCs6jpo1nYe1Wm08@bombadil.infradead.org>
 <CAJfuBxzGJvrJo9nTXxZ3xZ7QmdSb6YxBw-bojZjQTpACBeK_sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfuBxzGJvrJo9nTXxZ3xZ7QmdSb6YxBw-bojZjQTpACBeK_sQ@mail.gmail.com>
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

On Tue, Apr 04, 2023 at 07:38:41PM -0600, jim.cromie@gmail.com wrote:
> On Mon, Apr 3, 2023 at 2:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Fri, Mar 31, 2023 at 05:27:04PM -0700, Song Liu wrote:
> > > On Fri, Mar 31, 2023 at 12:00 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > >
> > > > On Thu, Mar 30, 2023 at 04:45:43PM -0600, jim.cromie@gmail.com wrote:
> > > > > hi Luis, etal
> > > > >
> > > > > kmemleak is reporting 19 leaks during boot
> > > > >
> > > > > because the hexdumps appeared to have module-names,
> > > > > and Ive been hacking nearby, and see the same names
> > > > > every time I boot my test-vm, I needed a clearer picture
> > > > > Jason corroborated and bisected.
> > > > >
> > > > > the 19 leaks split into 2 groups,
> > > > > 9 with names of builtin modules in the hexdump,
> > > > > all with the same backtrace
> > > > > 9 without module-names (with a shared backtrace)
> > > > > +1 wo name-ish and a separate backtrace
> > > >
> > > > Song, please take a look.
> > >
> > > I will look into this next week.
> >
> > I'm thinking this may be it, at least this gets us to what we used to do
> > as per original Catalinas' 4f2294b6dc88d ("kmemleak: Add modules
> > support") and right before Song's patch.
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 6b6da80f363f..3b9c71fa6096 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2240,7 +2240,10 @@ static int move_module(struct module *mod, struct load_info *info)
> >                  * which is inside the block. Just mark it as not being a
> >                  * leak.
> >                  */
> > -               kmemleak_ignore(ptr);
> > +               if (type == MOD_INIT_TEXT)
> > +                       kmemleak_ignore(ptr);
> > +               else
> > +                       kmemleak_not_leak(ptr);
> >                 if (!ptr) {
> >                         t = type;
> >                         goto out_enomem;
> >
> > We used to use the grey area for the TEXT but the original commit
> > doesn't explain too well why we grey out init but not the others. Ie
> > why kmemleak_ignore() on init and kmemleak_not_leak() on the others.
> >
> > Catalinas, any thoughts / suggestions? Should we just stick to
> > kmemleak_not_leak() for both now?
> >
> >   Luis
> 
> So I have mixed results.
> 
> your patch fixed the 19 leaks on my worktree / branch where I found them.
> 
> on top of
> ac3b43283923 module: replace module_layout with module_memory
> 
> it fixed the (same) 19, but gets a few new ones.
> whats weird is that once they report, they disappear from
> /sys/kernel/debug/kmemleak

I think I missed the MOD_INIT_DATA and MOD_INIT_RODATA. Can you try the
patch below instead:

From 6890bd43866c40e1b58a832361812cdc5d965e4c Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 4 Apr 2023 18:52:47 -0700
Subject: [PATCH] module: fix kmemleak annotations for non init ELF sections

Commit ac3b43283923 ("module: replace module_layout with module_memory")
reworked the way to handle memory allocations to make it clearer. But it
lost in translation how we handle kmemleak_ignore() or kmemleak_not_leak()
for these sections.

Fix this and clarify the comments a bit more.

Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
Reported-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5cc21083af04..fe0f3b8fd3a8 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2233,11 +2233,23 @@ static int move_module(struct module *mod, struct load_info *info)
 		ptr = module_memory_alloc(mod->mem[type].size, type);
 
 		/*
-		 * The pointer to this block is stored in the module structure
-		 * which is inside the block. Just mark it as not being a
-		 * leak.
+		 * The pointer to these blocks of memory are stored on the module
+		 * structure and we keep that around so long as the module is
+		 * around. We only free that memory when we unload the module.
+		 * Just mark them as not being a leak then. The .init* ELF
+		 * sections *do* get freed after boot so we treat them slightly
+		 * differently and only grey them out as they work as typical
+		 * memory allocations which *do* get eventually get freed.
 		 */
-		kmemleak_ignore(ptr);
+		switch (type) {
+		case MOD_INIT_TEXT: /* fallthrough */
+		case MOD_INIT_DATA: /* fallthrough */
+		case MOD_INIT_RODATA: /* fallthrough */
+			kmemleak_ignore(ptr);
+			break;
+		default:
+			kmemleak_not_leak(ptr);
+		}
 		if (!ptr) {
 			t = type;
 			goto out_enomem;
-- 
2.39.2

