Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77F7206C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjFBQE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjFBQE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:04:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB0BC;
        Fri,  2 Jun 2023 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=6T2J0Gv8y0l2pIuTyjrwgwYHikyeOTi38B9VMQ4I2Nc=; b=OYNGnBNp61YqfJLfV5Ye3PydBa
        kN84wCqGJkfutr/+9vDIVHx15Cn5uDj44t1lVwTADYMZPDjQtfigwAi8oUgR+Cen091xMqahKLvWO
        Da0EScO1fPYoN9Y1ByMoaGfGOU/L/0CeF6G/oDa+o3iMkoEZi1nOxzCWxbK14S50FVa25rb2i9byI
        IsRcW3pIsrdeMesgkaySHtVa3v8kxOq79eySVx9OLKw4EE2M4TDNU924onhUqCOuH+AdlrYzgK6fO
        J4mcOBwJCeAwXv0ORl+vZlQuebADI6jLhlTXqmmF30oegfsIe7Z/VvoYbH92fOVHzbNpbqnesgh41
        /y5J5cbA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q57GW-007KjW-1U;
        Fri, 02 Jun 2023 16:04:36 +0000
Date:   Fri, 2 Jun 2023 09:04:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <ZHoTFDkPIgglW0sU@bombadil.infradead.org>
References: <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
 <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org>
 <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 05:19:58PM +0200, David Hildenbrand wrote:
> On 31.05.23 18:57, Luis Chamberlain wrote:
> > On Wed, May 31, 2023 at 09:51:41AM +0200, David Hildenbrand wrote:
> > > On 30.05.23 18:22, Luis Chamberlain wrote:
> > > > On Mon, May 29, 2023 at 09:55:15PM -0400, Linus Torvalds wrote:
> > > > > On Mon, May 29, 2023 at 11:18 AM Johan Hovold <johan@kernel.org> wrote:
> > > > > > 
> > > > > > I took a closer look at some of the modules that failed to load and
> > > > > > noticed a pattern in that they have dependencies that are needed by more
> > > > > > than one device.
> > > > > 
> > > > > Ok, this is a "maybe something like this" RFC series of two patches -
> > > > > one trivial one to re-organize things a bit so that we can then do the
> > > > > real one which uses a filter based on the inode pointer to return an
> > > > > "idempotent return value" for module loads that share the same inode.
> > > > > 
> > > > > It's entirely untested, and since I'm on the road I'm going to not
> > > > > really be able to test it. It compiles for me, and the code looks
> > > > > fairly straightforward, but it's probably buggy.
> > > > > 
> > > > > It's very loosely based on Luis' attempt,  but it
> > > > >    (a) is internal to module loading
> > > > >    (b) uses a reliable cookie
> > > > >    (c) doesn't leave the cookie around randomly for later
> > > > >    (d) has seen absolutely no testing
> > > > > 
> > > > > Put another way: if somebody wants to play with this, please treat it
> > > > > as a starting point, not the final thing. You might need to debug
> > > > > things, and fix silly mistakes.
> > > > > 
> > > > > The idea is to just have a simple hash list of currently executing
> > > > > module loads, protected by a trivial spinlock. Every module loader
> > > > > adds itself to the right hash list, and if they were the *first* one
> > > > > (ie no other pending module loads for that inode), will actually do
> > > > > the module load.
> > > > > 
> > > > > Everybody who *isn't* the first one will just wait for completion and
> > > > > return the same error code that the first one returned.
> > > > 
> > > > That's also a hell much more snazzier MODULE_DEBUG_AUTOLOAD_DUPS if we
> > > > ever wanted to do something similar there if we wanted to also
> > > > join request_module() calls, instead of it hiding under debug.
> > > > 
> > > > > This is technically bogus. The first one might fail due to arguments.
> > > > 
> > > > For boot it's fine, as I can't think of boot wanting to support trying
> > > > to load a module with different arguments but who knows. But I can't
> > > > see it sensible to issue concurrent multiple requests for modules
> > > > with different arguments without waiting in userspace for the first
> > > > to fail.
> > > > 
> > > > Even post-boot, doing that sounds rather insane, but it would certainly
> > > > be a compromise and should probably be clearly documented. I think just
> > > > a comment acknolwedging that corner case seems sensible.
> > > > 
> > > > Because we won't be able to get the arguments until we process the
> > > > module, so it would be too late for this optimization on kread. So it is
> > > > why I had also stuck to the original feature being in kread, as then it
> > > > provides a uniq kread call and the caller is aware of it. But indeed I
> > > > had not considered the effects of arguments.
> > > > 
> > > > Lucas, any thoughts from modules kmod userspace perspective into
> > > > supporting anyone likely issuing concurrent modules requests with
> > > > differing arguments?
> > > > 
> > > > > So the cookie shouldn't be just the inode, it should be the inode and
> > > > > a hash of the arguments or something like that.
> > > > 
> > > > Personally I think it's a fine optimization without the arguments.
> > > > 
> > > > > But it is what it is,
> > > > > and apart from possible show-stopper bugs this is no worse than the
> > > > > failed "exclusive write deny" attempt. IOW - maybe worth trying?
> > > > 
> > > > The only thing I can think of is allowing threads other than the
> > > > first one to complete before the one that actually loaded the
> > > > module. I thought about this race for module auto-loading, see
> > > > the comment in kmod_dup_request_announce(), so that just
> > > > further delays the completion to other thread with a stupid
> > > > queue_work(). That seems more important for module auto-loading
> > > > duplicates than for boot finit_module() duplicates. But not sure
> > > > if odering matters in the end due to a preemtible kernel and maybe
> > > > that concern is hysteria.
> > > > 
> > > > > And if *that* didn't sell people on this patch series, I don't know
> > > > > what will. I should be in marketing! Two drink minimums, here I come!
> > > > 
> > > > Sold:
> > > > 
> > > > on 255 vcpus 0 duplicates found with this setup:
> > > > 
> > > > root@kmod ~ # cat /sys/kernel/debug/modules/stats
> > > >            Mods ever loaded       66
> > > >        Mods failed on kread       0
> > > > Mods failed on decompress       0
> > > >     Mods failed on becoming       0
> > > >         Mods failed on load       0
> > > >           Total module size       11268096
> > > >         Total mod text size       4149248
> > > >          Failed kread bytes       0
> > > >     Failed decompress bytes       0
> > > >       Failed becoming bytes       0
> > > >           Failed kmod bytes       0
> > > >    Virtual mem wasted bytes       0
> > > >            Average mod size       170729
> > > >       Average mod text size       62868
> > > > 
> > > > So:
> > > > 
> > > > Tested-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > 
> > > > In terms of bootup timing:
> > > > 
> > > > Before:
> > > > Startup finished in 41.653s (kernel) + 44.305s (userspace) = 1min 25.958s
> > > > graphical.target reached after 44.178s in userspace.
> > > > After:
> > > > Startup finished in 23.995s (kernel) + 40.350s (userspace) = 1min 4.345s
> > > > graphical.target reached after 40.226s in userspace.
> > > 
> > > I'll try grabbing the system where we saw the KASAN-related issues [1] and
> > > give it a churn with and without the two patches. Might take a bit (~1 day),
> > > unfortunately.
> > > 
> > > [1] https://lkml.kernel.org/r/20221013180518.217405-1-david@redhat.com
> > 
> > Great, don't forget:
> > 
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 82b0dcc1fe77..222015093eeb 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3066,7 +3066,7 @@ struct idempotent {
> >   #define IDEM_HASH_BITS 8
> >   static struct hlist_head idem_hash[1 << IDEM_HASH_BITS];
> > -static struct spinlock idem_lock;
> > +static DEFINE_SPINLOCK(idem_lock);
> >   static bool idempotent(struct idempotent *u, const void *cookie)
> >   {
> > 
> 
> Finally was able to run it on that ThinkSystem SR950 with 8 populated
> sockets -> 224 cores and 448 logical CPUs.
> 
> The KASAN vmap issues on that system were already no longer reproducible with your
> (Luis) previous work that's already in master.
> 
> I tested a !debug and debug config (both based on corresponding RHEL9 configs), comparing
> 929ed21dfdb6 ("master") with 929ed21dfdb6 + Linus' patches ("patched").
> 
> 
> Unfortunately, boot times vary a lot, and I did not figure out how to reduce
> the noise. I captured the "systemd-analyze blame" output as well.
> 
> 
> 1) !debug config (not enabling KASAN)
> 
> a) master
> 
> Startup finished in 32.225s (kernel) + 7.399s (initrd) + 20.378s (userspace) = 1min 3ms
> multi-user.target reached after 20.352s in userspace.
> Startup finished in 43.734s (kernel) + 7.288s (initrd) + 19.827s (userspace) = 1min 10.851s
> multi-user.target reached after 19.800s in userspace.
> Startup finished in 50.514s (kernel) + 7.171s (initrd) + 24.757s (userspace) = 1min 22.443s
> multi-user.target reached after 24.734s in userspace.
> Startup finished in 26.722s (kernel) + 7.249s (initrd) + 23.923s (userspace) = 57.895s
> multi-user.target reached after 23.892s in userspace.
> 
> b) patched
> 
> Startup finished in 36.318s (kernel) + 7.177s (initrd) + 21.383s (userspace) = 1min 4.879s
> multi-user.target reached after 21.355s in userspace.
> Startup finished in 36.318s (kernel) + 7.177s (initrd) + 21.383s (userspace) = 1min 4.879s
> multi-user.target reached after 21.355s in userspace.
> Startup finished in 1min 34.678s (kernel) + 7.239s (initrd) + 24.066s (userspace) = 2min 5.985s
> multi-user.target reached after 24.040s in userspace.
> Startup finished in 25.879s (kernel) + 7.144s (initrd) + 29.665s (userspace) = 1min 2.689s
> multi-user.target reached after 29.637s in userspace.
> 
> 
> 
> 2) debug config (enabling KASAN)
> 
> a) master
> 
> Startup finished in 2min 12.695s (kernel) + 25.058s (initrd) + 1min 13.012s (userspace) = 3min 50.765s
> multi-user.target reached after 1min 12.903s in userspace.
> Startup finished in 1min 45.400s (kernel) + 24.294s (initrd) + 1min 8.910s (userspace) = 3min 18.606s
> multi-user.target reached after 1min 8.786s in userspace.
> Startup finished in 2min 4.857s (kernel) + 24.715s (initrd) + 1min 5.088s (userspace) = 3min 34.660s
> multi-user.target reached after 1min 4.967s in userspace.
> Startup finished in 3min 20.400s (kernel) + 24.703s (initrd) + 1min 5.469s (userspace) = 4min 50.573s
> multi-user.target reached after 1min 5.344s in userspace.
> 
> b) patched
> 
> Startup finished in 2min 5.250s (kernel) + 25.049s (initrd) + 1min 1.961s (userspace) = 3min 32.262s
> multi-user.target reached after 1min 1.844s in userspace.
> Startup finished in 1min 52.524s (kernel) + 24.897s (initrd) + 1min 5.062s (userspace) = 3min 22.484s
> multi-user.target reached after 1min 4.916s in userspace.
> Startup finished in 9min 36.817s (kernel) + 24.859s (initrd) + 1min 18.657s (userspace) = 11min 20.335s
> multi-user.target reached after 1min 18.455s in userspace.
> Startup finished in 30min 20.715s (kernel) + 24.722s (initrd) + 1min 7.039s (userspace) = 31min 52.476s
> multi-user.target reached after 1min 6.907s in userspace.
> 
> 
> What concerns me a bit, is that on the patched kernel we seem to hit more cases where
> boot takes much longer (in both kernel configs).
> 
> I'll do some more runs/investigation to see if this is reproducible or just some system oddity.
> 
> Staring just at the udev settle time (systemd-analyze blame), it's very similar between both kernel
> versions.

Thanks for these tests, having MODULE_STATS enabled +

cat /sys/kernel/debug/modules/stats

would be of huge value, both on master and + patched.

  Luis
