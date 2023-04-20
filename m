Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33416E9D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjDTVDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTVDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:03:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01D44220;
        Thu, 20 Apr 2023 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OCU+3NKZypWjNzha0I2pr7x2HXXmFt2xxO5XBEBLxjo=; b=0B4tP2YktV27diNVoFU6cFm1sC
        yZKz0gTuEgdWoxLZaCAJi6cMUIgdbTdoCOzECcqBQ6dDGY0bxD5RULDCSQlaa+XzH4mctAun4FMWq
        l+zIjUpE3RZoUzdP9VHoImpgbWA+MRQnXEmFWiVKPFo6RA4beqGzxUUss/pQJd2x9l+H6j40HcrFw
        qWg0t064U5V7WM7euqeuzeDuNxBe+9mNEYiRx/BdT1+c9KqdVn63X3GFO1UVcrmEJUlYNrYbWq2WZ
        F+jCjWpWwXfvYPjNqTj70FbcVe8Xo0GiW/sWLcZmkn3/vYEalJNqzL2lCkwybHoyL/DG1ZtRMNaVC
        KxUNTlyA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppbRE-008ztG-1P;
        Thu, 20 Apr 2023 21:03:32 +0000
Date:   Thu, 20 Apr 2023 14:03:32 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>, lucas.demarchi@intel.com
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
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
Message-ID: <ZEGopJ8VAYnE7LQ2@bombadil.infradead.org>
References: <20230418204636.791699-1-mcgrof@kernel.org>
 <2023041951-evolution-unwitting-1791@gregkh>
 <ZEB6DmF+l3LVrpFI@bombadil.infradead.org>
 <ZEDOWi8ifghwmOjp@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEDOWi8ifghwmOjp@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 07:32:10AM +0200, Greg KH wrote:
> On Wed, Apr 19, 2023 at 04:32:30PM -0700, Luis Chamberlain wrote:
> > > It's not "wasted", as it is returned when the module is determined to be
> > > a duplicate.  Otherwise everyone will want this enabled as they think it
> > > will actually save memory.
> > 
> > I'll change the language to be clear the issue is memory pressure early
> > on boot. I'll also add a bit of language to help at least guide people
> > to realize that the real value-add for this, ie, I'll have to mention we
> > suspect issue is udev and not module auto-loading and that this however
> > may still help find a few cases we can optimize for.
> 
> This isn't udev's "problem", all it is doing is what the kernel asked it
> to do.  The kernel said "Here's a new device I found, load a module for
> it please!"

If you believe that then the issue is still a kernel issue, and the
second part to that sentence "load a module for it" was done without
consideration of the implications, or without optimizations in mind.
Given the implications were perhaps not well understood it is unfair
for us to be hard on ourselves on that. But now we know, ideally if we
could we *should* only issue a request for a module *once* during boot.

Where does the kernel actually say "load a module"?

Isn't that just an implied gesture?

> And it's the kmod code here, not udev itself doing all of this.

Yes, IMHO kmod could and *should* be enhanced to share a loading context
during boot so to avoid duplicates too and then udev would have to
embrace such functionality. That's going to take time to propagate, as
you can imagine.

> Why not
> just rate-limit it in userspace if your system can't handle 10's of
> thousands of kmod calls all at once? I think many s390 systems did this
> decades ago when they were controlling 10's of thousands of scsi devices
> and were hit with "device detection storms" at boot like this.

Boot is a special context and in this particular case I agree userspace
kmod could/should be extended to avoid duplicate module requests in that
context. But likewise the kernel should only have to try to issue a
request for a single module once, if it could easily do that.

This does beg the question, why force userspace to rate limit if we
can do better in the kernel? Specially if *we're the ones*, as you say,
that are hinting to userspace to shoot back loading modules for us and we
know we're just going to drop duplicates?

We discussed the possibility to rate limit finit_module() in-kernel [0], but
that was early in this process as I investigated the root cause of the
duplicates. I didn't feel comfortable with such an approach then but now
I have a clearer rationale as to why I felt so uncomfortable with it.
Rate limiting can be a a bandaid, a ball park guess and if one can
understand the issue a bit better, you may not need to to rate limit.

My kludge-of-concept RFC patch which takes the concepts in this patch but
applies them to kread [1] is an attempt for us to see what that could look
like -- and it goes so far as to survive easily the otherwise pathological
stress test of say (assuming you have all deps loaded and don't have XFS
loaded for an existing mount already):

stress-ng --module 1 --module-name xfs

Given Dave's original reported issue should be fixed now by the patch
"module: avoid allocation if module is already present and ready", there
really is no rush in keeping a kludges around but this does be the
question to analyze this case a bit more carefully with the long term
in mind.

[0] https://lkml.kernel.org/r/CAHk-=wjsBkyD+y_zfif1MXWYEkvPt+TPLdVjP41573oKEOu4qA@mail.gmail.com
[1] https://lore.kernel.org/all/ZDmAvwi+KNvie+OI@bombadil.infradead.org/T/#md172510af8fdf7e0f76f6caafee9c99f7a8b6de7

> If you really think it's the kernel's fault, just slow down the kernel's
> device detection code for the specific bus that is having problems.
> We've worked hard to make the kernel boot really fast and device
> detection happen in parallel, maybe that wasn't a good idea for some
> systems and so they need to boot slower.  If so, then just turn off the
> parallel probing for the offending bus type.

I think it is counter productive to do that, it's not like we have not
identified the scaling issue or can't solve this.

> What specific devices and bus types are the problem here for these systems?

My best assessment of the situation is that each CPU in udev ends up triggering
a load of duplicate set of modules, not just one, but *a lot*. Not sure
what heuristics udev uses to load a set of modules per CPU.

Given the slopes of the graphs I have shown on how this scales per CPU [2]
we can project at what point in time this will again likely be an issue if
we don't avoid the duplicates in userspace through kmod or address dealing
with them as in my kludge-of-concept on kreads. Given the secondary vmalloc
is dealt with the patch "module: avoid allocation if module is already present
and ready" that leaves us only to deal with virtual memory pressure from the
kread. In-kernel we may be able to also see if we can use seq reads for the
initial kread and decompression. That remains to be seen, but it would
also be a way for this not cause possible boot failures.

[2] https://lore.kernel.org/all/ZDmAvwi+KNvie+OI@bombadil.infradead.org/T/#mf7f8412c3486f59a3e4cf02b65bf0c4f9ba60ef0

  Luis
