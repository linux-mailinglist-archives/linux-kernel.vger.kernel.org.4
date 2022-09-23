Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BC05E7498
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiIWHK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIWHKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:10:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F5012384E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:10:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 86B8321A6C;
        Fri, 23 Sep 2022 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663917048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORsrL8e+8QbJVIe4BvhZ3VDvLBbB5qgP5KztMnQH7yw=;
        b=FYwaPeup555d+w356djmlgJcpK1vj/zXKLlXoCHvcqRbdOuVarhoVY+ZZMbbdV6yx2ST7W
        QSsCNbJ8C3jS43992/wtJLmCSfKjuzI+CTdKEE+mzvs+asmnx5MOmyFyosmB0UzdEH2QpW
        xRG9OaQeRPcxAhZaNEzpFUHTEhoHLPM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8622F2C14F;
        Fri, 23 Sep 2022 07:10:47 +0000 (UTC)
Date:   Fri, 23 Sep 2022 09:10:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
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
Subject: Re: [PATCH v5 00/32] Printbufs
Message-ID: <Yy1b9KzPycxTa8OW@alley>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-08-08 03:40:56, Matthew Wilcox (Oracle) wrote:
> [all this code is from Kent, I'm helping him out because he's having
> trouble with git send-email and OAUTH]
> 
> This should (hopefully) be the final iteration of this patch series.
> 
> Previous discussion:
> https://lore.kernel.org/linux-mm/20220620004233.3805-1-kent.overstreet@gmail.com/
> 
> Changes since v4:
> 
>  - %pf(%p) format extension has been dropped for now, since it turned out to be
>    a bit controversial. I think we're going to want it, but I'm leaving it for a
>    future patch series.
>  - There was a small off by one error in the patch converting
>    trace_events_synth. The original code using seq_buf had to calculate the size
>    of the string to allocate; since printbufs have native support for heap
>    allocating strings, the version of the patch in this series just uses that
>    for a nice cleanup.
> 
> What are printbufs, and why?
> ============================
> 
> Printbufs are like the existing seq_buf, with some differences and new features:
> 
>  - Heap allocation (optional)
>    
>    Currently, we have no standard mechanism for printing to a heap-allocated
>    string: code that needs to do this must calculate the size of the buffer to
>    allocate, which is tedious and error prone. IOW, this is a major ergonomic
>    improvement.
> 
>  - Indent level
> 
>    Any time we're printing structured multi-line data, proper indenting makes
>    the output considerably more readable. Printbufs have state for the current
>    indent level, controlled by printbuf_indent_add() and printbuf_indent_sub()
>    and obeyed by prt_newline().
> 
>    In the future this may work with just \n, pending work to do this without
>    performance regressions.
> 
>  - Tab stops
> 
>    Printing reports with nicely aligned columns is something we do a _lot_, and
>    printbufs make this a lot easier. After setting tabstops (byte offsets from
>    start of line), prt_tab() will output spaces up to the next tabstop, and
>    pr_tab_rjust() will right justify output since the previous output against
>    the next tabstap. 
> 
>    In the future this may work with just \t, pending work to do this without
>    performance regressions.

The more I think about this patchset the more doubts I have.

My first reaction was rather positive because

1. __prt_char(out, c)

	looks more safe and sane than repeating the following code
	pattern in vsprintf code

    if (buf < end)
	*buf = '0';
    ++buf;


2. printk("%pf", meaningful_function_name(ptr))

     is more user friendly, extendable. With a type check,
     it might be even more safe than

   printk("%pxyz", ptr);


3. pretty print API would allow to avoid some tricky use of
   temporary buffers in vsprintf code, for example, see
   https://lore.kernel.org/r/20220808024128.3219082-15-willy@infradead.org


What are the concerns?

It seems that the motivation for the pretty print is to allow
printing more pretty/fancy multi-line debug messages. The API
should be usable inside vsprintf.c and also outside.

1. vsprintf() is very important core API. It is used (not only for)
   when kernel wants to provide a human readable feedback, for
   example, via printk(), trace_printk(), procfs, sysfs, debugfs.

   If a bug in vsprintf() blocks printk()/trace_printk() then
   crash_dump might be the only way to debug the kernel.


2. My experience with printk() is that external APIs are big source of
   problems. Some of them are even solved by hacks, for example:

     + Console drivers have to check oops_in_progress before taking
       port->lock to prevent a deadlock.

     + printk_deferred() or printk_once() have to be used by code that
       might be called by printk().

    This patchset adds another external API.

    The %pf feature allows writing crazy callbacks called inside
    vsprintf()/printk() without any proper review and self-tests.

    People would want to extend the pretty print API for a
    profs/sysfs/debugfs use-case. They would take it easily.
    There is a lower risk in this case because only a particular
    file is affected, the API is called in a well defined context.
    But it looks like a call for problems if we allow to call
    the same complicated code also from vsprintf() or printk()
    in any context.


3. Features usually complicate the code immediately or later.

   For example, the record based ring buffer complicated the printk()
   code a lot. It introduced many regressions. Development of the
   lockless variant was a real challenge. And it did not solve
   everything. Peple still complain that pr_cont() is not reliable.
   Multi-line output might be mixed, ...

   The pretty print API is actually designed for multi-line output.
   But it will not help when used with printk() that uses 1k buffers
   internally. And adding support for "unlimited" printk() messages
   would be another challenge. It would bring new problems,
   for example, one printk() caller might block others for too long, ...


Any opinion is really appreciated.

Best Regards,
Petr


PS: I am sorry that I did not react on this patchset for months. I was
    overloaded, sick twice, and had vacation.

    A more detailed review of the patchset would help me to have
    stronger opinion about it. I am not clever and experienced enough
    to see all the consequences on the first look.
