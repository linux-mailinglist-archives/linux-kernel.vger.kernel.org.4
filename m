Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21DF5E8706
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 03:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiIXBjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 21:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiIXBjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 21:39:17 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E840614594E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 18:39:14 -0700 (PDT)
Message-ID: <9b671fc8-ae48-0486-ada5-04cc8c63f814@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663983552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a2JkmKoUry4ovxXmuL+E163gFx1UPsFjlVihzTo9W7Q=;
        b=OQvSOzsQ7y6NWygitMF7BjyfLrET7v+dZXvfnA4hcvaI0fbLkMtFdZX2uHLhqBF8s5RR+/
        MOhD5Zox9joRqQLmOJV8rfxDBv8OAYzZMwjIANGx+MArwv7WMM2IAAGS+cJmgMW3bbhViD
        4K+7z6ydzntnbn9TrP+JRBnqrzEMbG8=
Date:   Fri, 23 Sep 2022 21:39:08 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v5 00/32] Printbufs
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220808024128.3219082-1-willy@infradead.org>
 <Yy1b9KzPycxTa8OW@alley>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
In-Reply-To: <Yy1b9KzPycxTa8OW@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 03:10, Petr Mladek wrote:
> It seems that the motivation for the pretty print is to allow
> printing more pretty/fancy multi-line debug messages. The API
> should be usable inside vsprintf.c and also outside.
> 
> 1. vsprintf() is very important core API. It is used (not only for)
>     when kernel wants to provide a human readable feedback, for
>     example, via printk(), trace_printk(), procfs, sysfs, debugfs.
> 
>     If a bug in vsprintf() blocks printk()/trace_printk() then
>     crash_dump might be the only way to debug the kernel.

All the more reason for that code to be written with safe APIs, wouldn't 
you say?

> 2. My experience with printk() is that external APIs are big source of
>     problems. Some of them are even solved by hacks, for example:
> 
>       + Console drivers have to check oops_in_progress before taking
>         port->lock to prevent a deadlock.
> 
>       + printk_deferred() or printk_once() have to be used by code that
>         might be called by printk().
> 
>      This patchset adds another external API.

We should differentiate between sprintf and printk.

sprintf is _just_ for formatting strings, it doesn't have the same 
concerns as printk re: locking the output buffer - or any locking 
concerns whatsover, it's a pure function that doesn't mutate outside 
system state.

This patch series is about introducing a safe common API for sprintf and 
other code that outputs to strings, and I'd also note that even Linus 
agreed on the need for such an API, because it gets rid of the separate 
stack-allocated buffers that have been a problem in the past.

There's no impact on printk. The extra feature that printbufs add - heap 
allocation - isn't used by printk.


>      The %pf feature allows writing crazy callbacks called inside
>      vsprintf()/printk() without any proper review and self-tests.

I came to similar conclusions about %pf after the discussion with Linus; 
that part has been dropped from the patch set for now.

I do think we can do it safely in the future, and in the meantime it 
_may_ be worthwhile for use in a much more limited - probably not, I'd 
rather hold off and do it right. But since it hasn't been in the patch 
set the last few times I posted it, let's leave this out of the discussion.

(I think the way to make it safe will be to output to a heap allocated 
buffer instead of the printk buffer directly; however, that's not an 
option currently because we'd need to plumb through a gfp flags 
parameter and obviously we're not going to do that to printk. However, 
we're looking at switching from gfp flags to the memalloc_*() API, which 
would make this work).

>      People would want to extend the pretty print API for a
>      profs/sysfs/debugfs use-case. They would take it easily.
>      There is a lower risk in this case because only a particular
>      file is affected, the API is called in a well defined context.
>      But it looks like a call for problems if we allow to call
>      the same complicated code also from vsprintf() or printk()
>      in any context.

Since %pf isn't getting added, this isn't a concern.

_But_, introducing a common API so that we can use the same code for 
outputting to the system console, or procfs, or debugfs, is precisely 
what this is all about! We've got a fair amount of code duplication 
(some of which this patch series addresses; see the hexdump patches) 
because of this lack of a common API - often messily, with subtle 
differences for absolutely no reason.

We _want_ common, reusable, generic code.

Without %pf, to use printbuf code for outputting to the console the 
standard approach is going to be something like

struct printbuf buf = PRINTBUF;

prt_foo(&buf, foo);
printk("%s\n", buf.buf);
printbuf_exit(&buf);

Obviously, this isn't the greatest ergonomic-wise, %pf would be better 
in that respect. But this is still quite a bit better than completely 
duplicated code - one for outputting to a seq_buf, another set for 
seq_file, another for printk()...

I also have a patch series in the works for a printbuf based replacement 
for seq_file - eliminating that API fragmentation as well. I've just 
been waiting for movement on this patch series...

> 3. Features usually complicate the code immediately or later.
> 
>     For example, the record based ring buffer complicated the printk()
>     code a lot. It introduced many regressions. Development of the
>     lockless variant was a real challenge. And it did not solve
>     everything. Peple still complain that pr_cont() is not reliable.
>     Multi-line output might be mixed, ...

I'm not seeing the complications this patch series introduces in its 
current form. There's heap allocation, which replaces open-coded output 
buffer allocation that's currently done all over the place. And there's 
tabstops and indenting; given the amount of columnar data presented in 
procfs and debugfs, I think those are reasonable additions.

In return, you get a whole ton of code that was previously using raw 
pointer arithmetic converted to safe APIs, and we have a start on 
standardizing a lot of different code on a common API.

And, the sprintf code ends up a whole lot more readable and easier to 
work on.

>     The pretty print API is actually designed for multi-line output.
>     But it will not help when used with printk() that uses 1k buffers
>     internally. And adding support for "unlimited" printk() messages
>     would be another challenge. It would bring new problems,
>     for example, one printk() caller might block others for too long, ...

I'm not seeing that this is a real difficulty, since we're not doing %pf 
at this time.

  - add a printk_string_as_lines(), which takes a string buffer (not a 
format string) and calls printk() on it one line at a time. This would 
be an easy way around the current 1k buffer.
  - or, if the printk code wants to keep the output lines together and 
not have them interspersed with other output, that should be easier when 
we're presenting you the output already formatted and all you need to do 
is memcpy().

Basically, we've got broad agreement that calling arbitrary 
pretty-printers from printk() context is a bad idea, so since we won't 
be doing that this looks like a non-issue to me as well.

>      A more detailed review of the patchset would help me to have
>      stronger opinion about it. I am not clever and experienced enough
>      to see all the consequences on the first look.

There's really not a lot in the way of functional changes, since %pf has 
been dropped - it's just refactoring and converting to common APIs, and 
it was pretty mechanical as far as refactorings go.

Besides what we've talked about, the other thing I was doing that might 
be worth discussing was working on separating the pretty-printers in 
vsprintf.c from the format string parsing code. What I was seeing was a 
lot of code mixing parsing of the format string, and I think that code 
would be _much_ easier to read and work on with the format string 
parsing confined to pointer(), and having it call pretty-printers with a 
normal function call interface with well-typed arguments.

I have additional patches finishing this work for around half of the 
pretty-printers in vsprintf.c, but you were complaining about the patch 
series growing, so I haven't posted them yet...

Anyways, I hope this addresses some concerns.

Cheers,
Kent
