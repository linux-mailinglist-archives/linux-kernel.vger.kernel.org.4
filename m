Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5A75F06B1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiI3IkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiI3IkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:40:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8EE4F39F;
        Fri, 30 Sep 2022 01:40:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 202781F88D;
        Fri, 30 Sep 2022 08:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664527199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yvMtSmGbUu03O8o8mZRaHkMNTqo368k0r4sUED/TlJ8=;
        b=IyayJPEEbLvzJ4Rc92dtdCpsLu/52+b8aMJMvDtsLBG1HhKYAb8GDlAMcmFhVxJCK1mZK3
        dJVgn+1MMxkClqD6SXEyZd+GsXxMSNDmZFRLj5HQy0+1ZCAtuwoFUZ+PBvc9tEddwFAu4H
        XS/oueVOcuhmQB+m58RQQ1F7+P3ttaM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 970C92C178;
        Fri, 30 Sep 2022 08:39:58 +0000 (UTC)
Date:   Fri, 30 Sep 2022 10:39:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk 10/18] kgbd: Pretend that console list walk is safe
Message-ID: <YzarXlj1NyFGTC08@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-11-john.ogness@linutronix.de>
 <CAD=FV=U3m_mVLpWna3pgi4=b7OCzUxmKh666g62zPNaB+6QHUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=U3m_mVLpWna3pgi4=b7OCzUxmKh666g62zPNaB+6QHUA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-09-28 16:32:15, Doug Anderson wrote:
> Hi,
> 
> On Fri, Sep 23, 2022 at 5:05 PM John Ogness <john.ogness@linutronix.de> wrote:
> >
> > From: Thomas Gleixner <tglx@linutronix.de>
> >
> > Provide a special list iterator macro for KGDB to allow unprotected list
> > walks and add a few comments to explain the hope based approach.
> >
> > Preperatory change for changing the console list to hlist and adding
> 
> s/Preperatory/Preparatory
> 
> > lockdep asserts to regular list walks.
> >
> > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > index af2aa76bae15..57a5fd27dffe 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -462,10 +462,13 @@ static void kgdboc_earlycon_pre_exp_handler(void)
> >          * we have no other choice so we keep using it.  Since not all
> >          * serial drivers might be OK with this, print a warning once per
> >          * boot if we detect this case.
> > +        *
> > +        * Pretend that walking the console list is safe...
> 
> To be fair, this is not quite as unsafe as your comment makes it
> sound. kgdb is a "stop the world" debugger and when this function is
> executing then all of the other CPUs in the system should have been
> rounded up and idle (or, perhaps, busy looping). Essentially as long
> as console list manipulation is always made in a way that each
> instruction keeps the list in a reasonable state then what kgdb is
> doing is actually "safe". Said another way: we could drop into the
> debugger at any point when a task is manipulating the console list,
> but once we're in the debugger and are executing the "pre_exp_handler"
> then all the other CPUs have been frozen in time.

The code in register_console()/unregister_console() seems to
manipulate the list in the right order. But the correctness
is not guaranteed because there are neither compiler nor
memory barriers.

That said, later patches add for_each_console_srcu(). IMHO,
the SRCU walk should be safe here.

> 
> >          */
> > -       for_each_console(con)
> > +       for_each_console_kgdb(con) {
> >                 if (con == kgdboc_earlycon_io_ops.cons)
> >                         return;
> > +       }
> >
> >         already_warned = true;
> >         pr_warn("kgdboc_earlycon is still using bootconsole\n");
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -558,7 +558,12 @@ static void kdb_msg_write(const char *msg, int msg_len)
> >                 cp++;
> >         }
> >
> > -       for_each_console(c) {
> > +       /*
> > +        * This is a completely unprotected list walk designed by the
> > +        * wishful thinking department. See the oops_in_progress comment
> > +        * below - especially the encourage section...
> 
> The reality is also a little less dire here than the comment suggests.
> IMO this is actually not the same as the "oops_in_progress" case that
> the comment refers to.
>
> Specifically, the "oops_in_progress" is referring to the fact that
> it's not uncommon to drop into the debugger when a serial driver (the
> same one you're using for kgdb) is holding its lock. Possibly it's
> printing something to the tty running on the UART dumping stuff out
> from the kernel's console. That's not great and I won't pretend that
> the kgdb design is amazing here, but...
>
> Just like above, I don't feel like iterating through the console list
> here without holding the lock is necessarily unsafe. Just like above,
> all the rest of the CPUs in the system are in a holding pattern and
> aren't actively executing any code. While we may have interrupted them
> at any given instruction, they won't execute any more instruction
> until we leave kgdb and resume running.

The atomic consoles might improve the situation. Well, the hand shake
will not really work because the current owner might be stopped.
But we will at least know that the port is not in a safe state.

Anyway, what about using the later added SRCU walk here?
After all, this is exactly what RCU is for, isn't it?

Best Regards,
Petr

