Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67930716920
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjE3QWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjE3QWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:22:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DBC8F;
        Tue, 30 May 2023 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=OKvaapgeQMVDtYwYP0fBPFm+b6Rfi1ryNmTUaP7iQd0=; b=jTnn1rrBV+YMYu5T2aj651h2R/
        Vx4nklA8RxnZo62s6kTDE1whWTxD24y9rWU8ncWTY7jEMMSJg+TDW/nteJczKkJ4ZYzuevfdcV3kp
        mCNx0GHGNAH48YKLTqFayax0hWKZuIDEr6n6+V/3AZb+LhdX+V4/iWsdSV0oBX+WoLuyP0fb0j25B
        opY7MM14lNwIs6xGPsv9JclUpqfFL8tscWxl1pzTPTURDLsnJp3FZFDu6MtQJGMeiIfv4IecGlpGe
        kUqWQR432rVMANb+DDuG4EWc8u5VrRcEDftWkQIN/vWU0epPt4WtRtPAALeCzrdP/TFpAKRDxxM5B
        TZPHg1vg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q426w-00EYNG-0V;
        Tue, 30 May 2023 16:22:14 +0000
Date:   Tue, 30 May 2023 09:22:14 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
References: <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
 <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
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

On Mon, May 29, 2023 at 09:55:15PM -0400, Linus Torvalds wrote:
> On Mon, May 29, 2023 at 11:18 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > I took a closer look at some of the modules that failed to load and
> > noticed a pattern in that they have dependencies that are needed by more
> > than one device.
> 
> Ok, this is a "maybe something like this" RFC series of two patches -
> one trivial one to re-organize things a bit so that we can then do the
> real one which uses a filter based on the inode pointer to return an
> "idempotent return value" for module loads that share the same inode.
> 
> It's entirely untested, and since I'm on the road I'm going to not
> really be able to test it. It compiles for me, and the code looks
> fairly straightforward, but it's probably buggy.
> 
> It's very loosely based on Luis' attempt,  but it
>  (a) is internal to module loading
>  (b) uses a reliable cookie
>  (c) doesn't leave the cookie around randomly for later
>  (d) has seen absolutely no testing
> 
> Put another way: if somebody wants to play with this, please treat it
> as a starting point, not the final thing. You might need to debug
> things, and fix silly mistakes.
> 
> The idea is to just have a simple hash list of currently executing
> module loads, protected by a trivial spinlock. Every module loader
> adds itself to the right hash list, and if they were the *first* one
> (ie no other pending module loads for that inode), will actually do
> the module load.
> 
> Everybody who *isn't* the first one will just wait for completion and
> return the same error code that the first one returned.

That's also a hell much more snazzier MODULE_DEBUG_AUTOLOAD_DUPS if we
ever wanted to do something similar there if we wanted to also
join request_module() calls, instead of it hiding under debug.

> This is technically bogus. The first one might fail due to arguments.

For boot it's fine, as I can't think of boot wanting to support trying
to load a module with different arguments but who knows. But I can't
see it sensible to issue concurrent multiple requests for modules
with different arguments without waiting in userspace for the first
to fail.

Even post-boot, doing that sounds rather insane, but it would certainly
be a compromise and should probably be clearly documented. I think just
a comment acknolwedging that corner case seems sensible.

Because we won't be able to get the arguments until we process the
module, so it would be too late for this optimization on kread. So it is
why I had also stuck to the original feature being in kread, as then it
provides a uniq kread call and the caller is aware of it. But indeed I
had not considered the effects of arguments.

Lucas, any thoughts from modules kmod userspace perspective into
supporting anyone likely issuing concurrent modules requests with
differing arguments?

> So the cookie shouldn't be just the inode, it should be the inode and
> a hash of the arguments or something like that.

Personally I think it's a fine optimization without the arguments.

> But it is what it is,
> and apart from possible show-stopper bugs this is no worse than the
> failed "exclusive write deny" attempt. IOW - maybe worth trying?

The only thing I can think of is allowing threads other than the
first one to complete before the one that actually loaded the
module. I thought about this race for module auto-loading, see
the comment in kmod_dup_request_announce(), so that just
further delays the completion to other thread with a stupid
queue_work(). That seems more important for module auto-loading
duplicates than for boot finit_module() duplicates. But not sure
if odering matters in the end due to a preemtible kernel and maybe
that concern is hysteria.

> And if *that* didn't sell people on this patch series, I don't know
> what will. I should be in marketing! Two drink minimums, here I come!

Sold:

on 255 vcpus 0 duplicates found with this setup:

root@kmod ~ # cat /sys/kernel/debug/modules/stats
         Mods ever loaded       66
     Mods failed on kread       0
Mods failed on decompress       0
  Mods failed on becoming       0
      Mods failed on load       0
        Total module size       11268096
      Total mod text size       4149248
       Failed kread bytes       0
  Failed decompress bytes       0
    Failed becoming bytes       0
        Failed kmod bytes       0
 Virtual mem wasted bytes       0
         Average mod size       170729
    Average mod text size       62868

So:

Tested-by: Luis Chamberlain <mcgrof@kernel.org>

In terms of bootup timing:

Before:
Startup finished in 41.653s (kernel) + 44.305s (userspace) = 1min 25.958s        
graphical.target reached after 44.178s in userspace.                             
                                                                                 
After:                                                                           
Startup finished in 23.995s (kernel) + 40.350s (userspace) = 1min 4.345s         
graphical.target reached after 40.226s in userspace. 

So other than the brain farts above, I think this is pretty sexy.

  Luis
