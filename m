Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095FC6EADD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjDUPM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjDUPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B2413C16;
        Fri, 21 Apr 2023 08:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2058065161;
        Fri, 21 Apr 2023 15:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31CBC433D2;
        Fri, 21 Apr 2023 15:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682089974;
        bh=YxpowVHwsKeFgDfSN4DkprW9h6O8h9UyRh/INgZFhQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5TjJixiqGqbmI2F/94VhizZOx77gxuv7jWOSb6YCSISr8e7x5V7lE3URl+LlLgfF
         gJFeUEhWiiI9CPmZsAHPYWMYb+TJuYec0Ejv+XgWSphQe3ph01AHoz+VsHqItKXevB
         OQd0veR80QyuIlsy0eqg8XzV7CCslr7Qoeh6UXr0=
Date:   Fri, 21 Apr 2023 17:12:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     lucas.demarchi@intel.com, david@redhat.com,
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
Message-ID: <ZEKn89wPH19r2bM4@kroah.com>
References: <20230418204636.791699-1-mcgrof@kernel.org>
 <2023041951-evolution-unwitting-1791@gregkh>
 <ZEB6DmF+l3LVrpFI@bombadil.infradead.org>
 <ZEDOWi8ifghwmOjp@kroah.com>
 <ZEGopJ8VAYnE7LQ2@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEGopJ8VAYnE7LQ2@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 02:03:32PM -0700, Luis Chamberlain wrote:
> On Thu, Apr 20, 2023 at 07:32:10AM +0200, Greg KH wrote:
> > On Wed, Apr 19, 2023 at 04:32:30PM -0700, Luis Chamberlain wrote:
> > > > It's not "wasted", as it is returned when the module is determined to be
> > > > a duplicate.  Otherwise everyone will want this enabled as they think it
> > > > will actually save memory.
> > > 
> > > I'll change the language to be clear the issue is memory pressure early
> > > on boot. I'll also add a bit of language to help at least guide people
> > > to realize that the real value-add for this, ie, I'll have to mention we
> > > suspect issue is udev and not module auto-loading and that this however
> > > may still help find a few cases we can optimize for.
> > 
> > This isn't udev's "problem", all it is doing is what the kernel asked it
> > to do.  The kernel said "Here's a new device I found, load a module for
> > it please!"
> 
> If you believe that then the issue is still a kernel issue, and the
> second part to that sentence "load a module for it" was done without
> consideration of the implications, or without optimizations in mind.
> Given the implications were perhaps not well understood it is unfair
> for us to be hard on ourselves on that. But now we know, ideally if we
> could we *should* only issue a request for a module *once* during boot.

But there is no mapping between devices and modules other than what is
exported in the module info and that is up to userspace to handle.

> Where does the kernel actually say "load a module"?

The driver core says "hey a new device is now present!"

Userspace takes that message and calls kmod with the device information
which then determines what module to load by looking at the device
aliases.

> Isn't that just an implied gesture?

Yes.

> > And it's the kmod code here, not udev itself doing all of this.
> 
> Yes, IMHO kmod could and *should* be enhanced to share a loading context
> during boot so to avoid duplicates too and then udev would have to
> embrace such functionality. That's going to take time to propagate, as
> you can imagine.

udev is just the transport to kmod here, it's not in the job of
filtering duplicate messages.

> > Why not
> > just rate-limit it in userspace if your system can't handle 10's of
> > thousands of kmod calls all at once? I think many s390 systems did this
> > decades ago when they were controlling 10's of thousands of scsi devices
> > and were hit with "device detection storms" at boot like this.
> 
> Boot is a special context and in this particular case I agree userspace
> kmod could/should be extended to avoid duplicate module requests in that
> context. But likewise the kernel should only have to try to issue a
> request for a single module once, if it could easily do that.

Are you sure that this is happening at boot in a way that userspace
didn't just trigger it on its own after init started up?  That happens
as a "coldboot" walk of the device tree and all uevent are regenerated.
That is userspace asking for this, so there's nothing that the kernel
can do.

> This does beg the question, why force userspace to rate limit if we
> can do better in the kernel? Specially if *we're the ones*, as you say,
> that are hinting to userspace to shoot back loading modules for us and we
> know we're just going to drop duplicates?

Maybe error out of duplicate module loading earlier?  I don't know,
sorry.

> > What specific devices and bus types are the problem here for these systems?
> 
> My best assessment of the situation is that each CPU in udev ends up triggering
> a load of duplicate set of modules, not just one, but *a lot*. Not sure
> what heuristics udev uses to load a set of modules per CPU.

Again, finding which device and bus is causing the problem is going to
be key here to try to solve the issue.  Are you logging duplicate module
loads by name as well?

thanks,

greg k-h
