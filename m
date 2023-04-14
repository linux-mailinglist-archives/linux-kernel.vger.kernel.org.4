Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D68E6E2050
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDNKKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDNKKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:10:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720DA30F3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:10:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2DCDE219D6;
        Fri, 14 Apr 2023 10:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681467004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I0DHkXzassZNT6OdIarUCK853/h0PN4uGkM6RY81XU4=;
        b=huUAC+trlciO4/0xm6yn2r7s6Z+xD31tbe9Nxjf3dqsdHjp/dgrONHBGLItg+mT/myTfKF
        +eYX3HQGHaWwzIY9pfKFM3pyECl2KRNcHWD/9y8d+ZMC7OFPBjQRtSButSBYe96sF3cqeV
        1fbZNF6ZoEPdStQgJte3D41i+PLFQXw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2DC532C143;
        Fri, 14 Apr 2023 10:10:03 +0000 (UTC)
Date:   Fri, 14 Apr 2023 12:10:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH printk v1 16/18] kernel/panic: Add atomic write
 enforcement to warn/panic
Message-ID: <ZDkmenNlwfkTyFIp@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-17-john.ogness@linutronix.de>
 <ZDfUiB55jE25kmv5@alley>
 <87h6tk3rqe.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6tk3rqe.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-04-13 14:19:13, John Ogness wrote:
> On 2023-04-13, Petr Mladek <pmladek@suse.com> wrote:
> >> --- a/kernel/panic.c
> >> +++ b/kernel/panic.c
> >> @@ -329,6 +332,8 @@ void panic(const char *fmt, ...)
> >>  	if (_crash_kexec_post_notifiers)
> >>  		__crash_kexec(NULL);
> >>  
> >> +	cons_atomic_flush(NULL, true);
> >
> > Do we need to explicitly flush the messages here?
> 
> This is where the atomic printing actually starts (after the full dump
> has been inserted into the ringbuffer).
> 
> > cons_atomic_flush() is called also from vprintk_emit(). And there are
> > many messages printed with the PANIC priority above.
> 
> vprintk_emit() does not print in this case. From cons_atomic_flush():
> 
>         /*
>          * When in an elevated priority, the printk() calls are not
>          * individually flushed. This is to allow the full output to
>          * be dumped to the ringbuffer before starting with printing
>          * the backlog.
>          */
>         if (cpu_state->prio > NBCON_PRIO_NORMAL && printk_caller_wctxt)
>                 return;

OK, what is the motivation for this behavior, please?
Does it has any advantages?

> 
> > This makes an assumption that either printk() in PANIC context
> > does not try to show the messages immediately or that this
> > explicit console_atomic_flush() tries harder. I think
> > that both assumptions are wrong.
> 
> Both assumptions are correct, because until this point there has been no
> effort to print.

Honestly, this makes me nervous. It means that panic() messages will
not reach the console unless they are explicitly flushed.

First, it is error-prone because it requires calling
console_atomic_flush() in all relevant code paths on the right
locations.

Second, it expects that panic() code could never fail between
the explicit console_atomic_flush() calls. If it failed, it might
be pretty useful to see the last printed message.

Third, messages might get lost when there are too many. And it is
realistic. For example, see panic_print_sys_info() it might add
quite long reports.

I would really prefer to flush atomic consoles with every printk()
unless there is a really good reason not to do it.

Best Regards,
Petr
