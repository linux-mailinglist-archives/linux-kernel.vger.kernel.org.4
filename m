Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3526EB0B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjDURjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjDURi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:38:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179905251;
        Fri, 21 Apr 2023 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=83cA6hS5p8il1Pvz477y1iSqczx6/2niZ1ZvO9mOInU=; b=5DWNg+FvkpxGxt3IYM2eORT1PL
        Zp60z1q5JCCPmNXKchxXgzwrNzFo62kItrKepkTnh4dXOIbpvUMYkKyKzS2LPWO7UNBQB79Cn0f0m
        MEH8j7JgH4pi/AqG5QEx1vQ1TMKUXQ4e6SDo8P9r6rVLSPbaB5I+MqW0elDjCwdUesX6evXPuEuGl
        Ji/8MHpP/rewO7vbnDzFlyQQv+V3YU4tzznYYfXmDoMK6CJf3boPPrWHxKIbB6d89aaRQgdmEuXBz
        xR7PYWU3lQ13V6EXg5vdm0pi+1azRS0xVf1NJ6XvhM4f6lylU8hASw7iTPQMIJW4vkq4H2gJVSRN9
        tOGsIzyg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppuif-00BW8Y-1d;
        Fri, 21 Apr 2023 17:38:49 +0000
Date:   Fri, 21 Apr 2023 10:38:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, j.granados@samsung.com
Subject: Re: [PATCH] module: add debugging auto-load duplicate module support
Message-ID: <ZELKKVJ11LdFsBYo@bombadil.infradead.org>
References: <20230418204636.791699-1-mcgrof@kernel.org>
 <2023041951-evolution-unwitting-1791@gregkh>
 <ZEB6DmF+l3LVrpFI@bombadil.infradead.org>
 <ZEDOWi8ifghwmOjp@kroah.com>
 <ZEGopJ8VAYnE7LQ2@bombadil.infradead.org>
 <ZEKn89wPH19r2bM4@kroah.com>
 <bnhskcp6hy6liwlefyjcxumlnvmkmyvhvatkq7ve3kb2zecyxl@c3jq2apjqlcy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnhskcp6hy6liwlefyjcxumlnvmkmyvhvatkq7ve3kb2zecyxl@c3jq2apjqlcy>
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

On Fri, Apr 21, 2023 at 09:42:39AM -0700, Lucas De Marchi wrote:
> On Fri, Apr 21, 2023 at 05:12:51PM +0200, Greg KH wrote:
> > On Thu, Apr 20, 2023 at 02:03:32PM -0700, Luis Chamberlain wrote:
> > udev is just the transport to kmod here, it's not in the job of
> > filtering duplicate messages.
> 
> udev nowadays use *lib*kmod. It's udev who has the
> context it can operate on.
> 
> Also, those module loads will not use the path this patch is changing
> call_modprobe is not the path that triggers udev to load modules.
> /me confused

This patch prooves that module auto-loading (request_modue() calls) and
so the /sbin/modprobe calls are *not* the issue. That is why udev was
the next candidate consideration.

> What can be done from userspace in the udev path
> 
> 1) udev to do the ratelimit'ing. Define a time window,
> filter out uevents in systemd/src/udev/udev-builtin-kmod.c
> 
> 2) libkmod to do the ratelimit'ing with a similar approach, but udev
> needs to tell libkmod what is the window it wants to use
> 
> 3) libkmod to act on the context it has from the *kernel*. It used
> to be cheap with the call simply blocking early on the syscall in
> a mutex... or we didn't have that many calls. So libkmod
> simply calls [f]init_module() again regardless of the module's
> state being in a "coming" state.  Is this the case here?

I only got so far as to also confirm libkmod is used, so if libkmod
does that check then this is already done, but the issue I think is
that I think that the races are so much that you still get duplicates.
So even if the check is done there are so many parallel calls that
the check doesn't help as the module won't be loaded for a while.

> I haven't seen this data.

Just build a modules-next [0] kernel with the new CONFIG_MODULE_STATS
and after boot cat /sys/kernel/debug/modules/stats. Then increase
the number of CPUs on the system by 2 and try again. Then enable
the new MODULE_DEBUG_AUTOLOAD_DUPS which I just pushed to modules-next
and see how many duplicates you see. If you don't see many then that
means the other source for duplicates should be udev.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

> This is done to avoid a) the toctou implied and b) to
> provide the correct return for that call - libkmod can't know if the
> previous call will succeed or fail.

Just as with the kludge-of-concept I posted for kread [0], userspace
also should have similar issues in mapping module name to arbitrary
file names given:

  o a module can be in different paths and libkmod could for
     example at one point load a module in one path, then userspace
     removes it, and the next path is used.
  o module names may differ from the filename slightly (in the kernel
    we replace dash with "_", refer to KBUILD_MODNAME

So the only thing it could do is use the full path of the module used to
deter duplicates. Then, it could actually converge duplicate requests and
share the results just as my kludge-of-concept did.

[1] https://lore.kernel.org/all/ZDmAvwi+KNvie+OI@bombadil.infradead.org/T/#md172510af8fdf7e0f76f6caafee9c99f7a8b6de7

> libkmod only skips the call if the module is already in
> the live state.

It can do better, it can converge requests to avoid a kernel_read*()
from using vmalloc space. Note that this was not well known before,
but now it is clear.

I realize though that this could mean sharing a context between all
loads thoughs in udev, and such a change could take significant time
and review to complete.

If we *wanted* to do this in kernel instead, I have already shown it's
not hard.

> It seems systemd-udev also duplicates the check
> in src/shared/module-util.c:module_load_and_warn()

Evidence is showing that does not suffice for the races which are
currently possible.

> Note that libkmod already spares loading the module multiple times from
> disk as it uses a memory pool for the modules. It reuses one iff it
> comes from the same context (i.e. it's only udev involved and not a
> bunch of parallel calls to modprobe).

If a different context is used its not shared.

> 4) If all the calls are coming from the same context and it is udev...
> I'm not sure this is actually the problem - the udev's kmod builtin
> handler is single-threaded and will handle one request at a time.
> I don't see any data to confirm it's coming from a single source or
> multiple sources. Could you get a trace containing [f]init_module and
> the trace_module_request(), together with a verbose udev log?
> 
> If this is all coming from a synthetic use case with thousands of
> modprobe execs, I'm not sure there is much to do on the userspace side.

It's not synthetic, I rested simply increasing the number of CPUs on a
system, you can use kdevops for that if you want to try.

> > > > Why not
> > > > just rate-limit it in userspace if your system can't handle 10's of
> > > > thousands of kmod calls all at once? I think many s390 systems did this
> > > > decades ago when they were controlling 10's of thousands of scsi devices
> > > > and were hit with "device detection storms" at boot like this.
> > > 
> > > Boot is a special context and in this particular case I agree userspace
> > > kmod could/should be extended to avoid duplicate module requests in that
> 
> see above
> 
> > > context. But likewise the kernel should only have to try to issue a
> > > request for a single module once, if it could easily do that.
> > 
> > Are you sure that this is happening at boot in a way that userspace
> > didn't just trigger it on its own after init started up?  That happens
> > as a "coldboot" walk of the device tree and all uevent are regenerated.
> > That is userspace asking for this, so there's nothing that the kernel
> > can do.
> > 
> > > This does beg the question, why force userspace to rate limit if we
> > > can do better in the kernel? Specially if *we're the ones*, as you say,
> > > that are hinting to userspace to shoot back loading modules for us and we
> > > know we're just going to drop duplicates?
> > 
> > Maybe error out of duplicate module loading earlier?  I don't know,
> > sorry.
> 
> I still don't see what's the source of the problem from the data
> available. Is the kernel issuing multiple request_module()?

For the cases I saw it only accounted for *one* of the many duplicates.
So that's not it.

> Or is the
> kernel sending multiple udev event for userspace to map the alias to the
> module and load it?

That's what I suspect. Each CPU triggers tons of module loads.

> The mapping alias -> module currently belongs in
> userspace so if you are de-duplicating, it can't be only on the module
> name.

That's one way, but it can also do it on the path used too.

> > > > What specific devices and bus types are the problem here for these systems?
> > > 
> > > My best assessment of the situation is that each CPU in udev ends up triggering
> > > a load of duplicate set of modules, not just one, but *a lot*. Not sure
> > > what heuristics udev uses to load a set of modules per CPU.
> > 
> > Again, finding which device and bus is causing the problem is going to
> > be key here to try to solve the issue.  Are you logging duplicate module
> 
> agreed.
> 
> If the info I requested above is available on other threads, could you
> point me to those?
> 
> thanks
> Lucas De Marchi
> 
> > loads by name as well?

The above instructions on using modules-next will let you both see
what's going on.

  Luis
