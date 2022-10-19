Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB2604292
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJSLHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiJSLGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:06:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACED102502
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:35:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7FFD220417;
        Wed, 19 Oct 2022 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666172033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n4U4dUSfs3nvg0jmanTRfL/FHSIYGuV5TwF9lLslhoQ=;
        b=BeGWTtnbG+1FfXMbnLnl+AGs9Eu2X+3WuAHIzaCUs6sthZIkObF+ga2SQsUwZ8Xuk3OtKL
        lchvUQbm7u3kJF0imph5crov9x8vcC3pvoiePCFDxw1v6gnnOK5cZz0Q5Pu9h657etlA17
        ucDQFtWHdlGQAFD0FGMqIb0ylMnOboA=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F00BA2C142;
        Wed, 19 Oct 2022 09:33:52 +0000 (UTC)
Date:   Wed, 19 Oct 2022 11:33:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        John Haxby <john.haxby@oracle.com>
Subject: Re: [PATCH v2] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Message-ID: <Y0/EfVB7fRFXrz2c@alley>
References: <20221017194447.2579441-1-jane.chu@oracle.com>
 <Y026l2PZgvt+G6p0@smile.fi.intel.com>
 <71c9bce7-cd93-eb2f-5b69-de1a9ffe48b5@oracle.com>
 <Y05Yi7xJ3E8EjnTj@alley>
 <288a7aba-c647-b51f-bdb3-99a62449dbb3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288a7aba-c647-b51f-bdb3-99a62449dbb3@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-10-18 19:36:41, Jane Chu wrote:
> On 10/18/2022 12:40 AM, Petr Mladek wrote:
> > On Mon 2022-10-17 21:12:04, Jane Chu wrote:
> >> On 10/17/2022 1:27 PM, Andy Shevchenko wrote:
> >>> On Mon, Oct 17, 2022 at 01:44:47PM -0600, Jane Chu wrote:
> >>>> While debugging a separate issue, it was found that an invalid string
> >>>> pointer could very well contain a non-canical address, such as
> >>>
> >>> non-canical?
> >>
> >> Sorry, typo, will fix.
> >>
> >>>
> >>>> 0x7665645f63616465. In that case, this line of defense isn't enough
> >>>> to protect the kernel from crashing due to general protection fault
> >>>>
> >>>> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> >>>>                   return "(efault)";
> >>>>
> >>>> So run one more round of check via kern_addr_valid(). On architectures
> >>>> that provide meaningful implementation, this line of check effectively
> >>>> catches non-canonical pointers, etc.
> >>>
> >>> OK, but I don't see how this is useful in the form of returning efault here.
> >>> Ideally we should inform user that the pointer is wrong and how it's wrong.
> >>> But. It will crash somewhere else at some point, right?
> >> Broadly speaking, yes.  It's not a perfect line of defense, but again,
> >> the bug scenario is a "cat" of some sysfs attributes that leads to
> >> panic. Does it make sense for kernel to protect itself against panic
> >> triggered by a "cat" from user if it could?
> > 
> >  From my view, the check might be useful. I agree with Andy that the
> > broken pointer would cause crash later anyway. But the check
> > in vsprintf() would allow to see a message that the pointer was
> > wrong before the system crashes.
> > 
> > That said, this was much more important in the past when printk()
> > called vsprintf() under logbuf_lock. Nested printk() calls
> > were redirected to per-CPU buffers and eventually lost.
> > 
> > It works better now when printk() uses lockless ringbuffer and
> > vsprintf() is called twice there. The first call is used
> > to get the string length so that it could reserve the needed
> > space in the ring buffer. If vsprintf() crashes during the 1st call
> > then it would be possible to print the nested Oops messages.
> > 
> > 
> >> I mean that there
> >>> is no guarantee that kernel has protection in every single place against
> >>> dangling / invalid pointers. One way or another it will crash.
> >>>
> >>> That said, honestly I have no idea how this patch may be considered
> >>> anything but band-aid. OTOH, I don't see a harm. Perhaps others will
> >>> share their opinions.
> >>>
> >>
> >> 3+ years ago, commit 3e5903eb9cff7 ("vsprintf: Prevent crash when
> >> dereferencing invalid pointers") provided the similar level of
> >> protection as this patch.  But it was soon revised by commit
> >> 2ac5a3bf7042a ("vsprintf: Do not break early boot with probing
> >> addresses"), and that's why the string() utility no longer detects
> >> non-canonical string pointer.
> >>
> >> I only thought that kern_addr_valid() is less of a heavy hammer, and
> >> could be safely deployed.
> > 
> > Hmm, I see that kern_addr_valid() is available (defined) only on some
> > architectures. This patch would break build on architectures where it
> > is not defined.
> > 
> > Also it is used only when reading /proc/kcore. It means that it is not
> > tested during early boot. I wonder if it actually works during
> > the very early boot.
> > 
> > Result:
> > 
> > The patch is not usable as is.
> > 
> > IMHO, it is not worth the effort to get it working. Especially when
> > printk() should be able to show Oops inside vsprintf() these days.
> 
> Yes, kern_addr_valid() is used by read_kcore() which is architecturally 
> independent and applies everywhere, so does that imply that it is 
> defined in all architectures?

It is more complicated. fs/proc/kcore.c is built when
CONFIG_PROC_KCORE is set. It is defined in fs/proc/Kconfig as:

config PROC_KCORE
	bool "/proc/kcore support" if !ARM
	depends on PROC_FS && MMU

So, it is not built on ARM.

More importantly, kern_addr_valid() seems to be implemented only for x86_64.
It is always true (1) on all other architectures, see

$> git grep kern_addr_valid
arch/alpha/include/asm/pgtable.h:#define kern_addr_valid(addr)  (1)
arch/arc/include/asm/pgtable-bits-arcv2.h:#define kern_addr_valid(addr) (1)
arch/arm/include/asm/pgtable-nommu.h:#define kern_addr_valid(addr)      (1)
arch/arm/include/asm/pgtable.h:#define kern_addr_valid(addr)    (1)
[...]

Wait, it is actually always false (0) on x86 when SPARSEMEM is used,
see arch/x86/include/asm/pgtable_32.h:

#ifdef CONFIG_FLATMEM
#define kern_addr_valid(addr)	(1)
#else
#define kern_addr_valid(kaddr)	(0)
#endif


> I guess the early boot scenario is different in that, potentially unkind 
> users aren't involved, hence a broken kernel is broken and need a fix.

The important thing is that kern_addr_valid() must return valid
results even during early boot. Otherwise, vsprintf() would not work
during the early boot which is not expected.


> The scenario concerned here is with users could potentially exploit a 
> kernel issue with DOS attack.  Then we have the scenario that the kernel
> bug itself is confined, in that, had the sysfs not been accessed, the 
> OOB pointer won't be produced.  So in this case, "(efault)" is a lot 
> more desirable than panic.

Please, provide more details about the bug when invalid pointer was
passed. As Andy wrote, even if we catch the bad pointer in vsprintf(),
the kernel would most likely kernel crash anyway.

Best Regards,
Petr
