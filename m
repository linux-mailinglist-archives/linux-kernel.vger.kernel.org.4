Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039566F4199
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjEBK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjEBK2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:28:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5549F59DA
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:27:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 13713222D0;
        Tue,  2 May 2023 10:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683023225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCyc2xZoho/avdYY6/wusEY7DFkr2ZdiyJYZWZEOf7Q=;
        b=o6y5VzLkLzxIz5UpyRfV9Il3A5pFs6U45Bqqnz9LRJ/mIM3fTseyuvtgSUgGUouQIfUW9v
        2wd4w3RdJdeBceBfxkZNphHNOl2wADoNN2cxajr2kKcY5tgRiYeDAuzaPbs/BxhTdUUx8Z
        +8uacEceEVankuYXtQ5Y7kH8CEYPTuE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 51D7F2C141;
        Tue,  2 May 2023 10:27:04 +0000 (UTC)
Date:   Tue, 2 May 2023 12:27:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     calumlikesapplepie@gmail.com
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com,
        mj@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH v5 2/2] printk: console: Remove sysrq exception
Message-ID: <ZFDld5skJaxxEuEu@alley>
References: <cover.1682427812.git.chris@chrisdown.name>
 <4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris@chrisdown.name>
 <ZEp9dXwHCYNPidjC@alley>
 <9531fc38cfebb5b4587967f6ec73d983fd9325ce.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9531fc38cfebb5b4587967f6ec73d983fd9325ce.camel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2023-04-30 19:00:42, calumlikesapplepie@gmail.com wrote:
> > > --- a/drivers/tty/sysrq.c
> > > +++ b/drivers/tty/sysrq.c
> > > @@ -101,12 +102,26 @@ __setup("sysrq_always_enabled",
> > > sysrq_always_enabled_setup);
> > >  static void sysrq_handle_loglevel(int key)
> > >  {
> > >         int i;
> > > +       int cookie;
> > > +       int warned = 0;
> > > +       struct console *con;
> > >  
> > >         i = key - '0';
> > >         console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
> > >         pr_info("Loglevel set to %d\n", i);
> > >         console_loglevel = i;
> > > +
> > > +       cookie = console_srcu_read_lock();
> > > +       for_each_console_srcu(con) {
> > > +               if (!warned && per_console_loglevel_is_set(con)) {
> > > +                       warned = 1;
> > > +                       pr_warn("Overriding per-console loglevel
> > > from sysrq\n");
> > > +               }
> > > +               con->level = -1;
> > 
> > Please, use WRITE_ONCE(con->level, -1) to make sure that it will be
> > atomic.
> > 
> > READ_ONCE()/WRITE_ONCE() should always be used when the values
> > are read/written using RCU synchronization. Otherwise the compiler
> > might do some optimizations and read/write bytes separately.
> > 
> 
> I would argue we remove this whole logic, and just go to a nice and
> simple printk at KERN_EMERG priority.  Why add interactions with the
> SRCU subsystem in code that we need to run even in the event of some
> massive SRCU bug?  This code will be both infrequently tested and make
> a bad day worse if it's problematic.

Any bug in SRCU should not break this sysrq code.
console_srcu_read_lock()/unlock() are non-blocking operations.

The problem might be in a path calling synchronize_srcu()
but it is not sysrq case, definitely.

> > > +       }
> > > +       console_srcu_read_unlock(cookie);
> > >  }
> > 
> > Also we should safe/set/restore "ignore_per_console_loglevel"
> > in __handle_sysrq(). It already does the same with
> > "console_loglevel".
> > 
> > __handle_sysrq() increases the loglevel to show all
> > messages printed by the sysrq handler on all consoles.
> > Many handlers print some information that might be useful
> > for debugging.
> 
> Actually, it doesn't!  Be kinda cool if it did, but there is a
> legitimate reason for it not to: some sysrq messages, like the list of
> all processes in the system, are extremely long, and so you might want
> to print them to a file but not every console.  Instead, it prints
> exactly one message with the increased log level visibility: an info-
> priority message that states the "action message" of the sysrq, before
> returning to the default log level.

Ah, I forgot and misread the code. It really prints only the single
line with updated console loglevel.

> In other words: magic sysrq messages are printed to every console,
> because they are deemed to be important emergencies that no user should
> miss, even if they told the kernel it better be actively on fire if it
> wants to talk. Cool.  However, they are not marked as emergency
> priority.  Instead, they're marked as info priority, but do a dance
> with kernel log level to ensure they get printed everywhere.

I have different theory why it works this way, see below.


> So I dove into git history, only to find that the log-level shifting code was
> added with the initial import from bitkeeper.
[...]
> Sysrq.c does not exist in the previous kernel version.
>
> https://mirrors.edge.kernel.org/pub/linux/kernel/v2.1/linux-2.1.43.tar.gz

It seems that the original code actually printed all messages with
the updated console_loglevel.

It was modified to printk only the first line or help by:

commit 2433aae9cbfbe77b5c5af11e6174d390e06053a6
Author: linus1 <torvalds@athlon.transmeta.com>
Date:   Sun Sep 23 11:00:00 2001 -0600

    v2.4.10.1 -> v2.4.10.2
    
      - me/Al Viro: fix bdget() oops with block device modules that don't
      clean up after they exit
      - Alan Cox: continued merging (drivers, license tags)
      - David Miller: sparc update, network fixes
      - Christoph Hellwig: work around broken drivers that add a gendisk more
      than once
      - Jakub Jelinek: handle more ELF loading special cases
      - Trond Myklebust: NFS client and lockd reclaimer cleanups/fixes
      - Greg KH: USB updates
      - Mikael Pettersson: sparate out local APIC / IO-APIC config options

, see
https://github.com/mpe/linux-fullhistory/commit/2433aae9cbfbe77b5c5af11e6174d390e06053a6

I do not see any explanation for this. I guess that the too long
output caused some problems.

> No, I could not find the email where this patch was first submitted. 
> It may not exist on the internet; it certainly doesn't in the parts
> where Google looks.
> 
> Now, printk did support priority levels at this point: without the
> emails discussing the patch, therefore, it's impossible to say why
> Martin decided all those years ago to use this technique.  It's
> probably a moot point anyways.

I agree that it is pretty questionable. I am not sure about
the exact motivation.

Well, sysrq is primary used when the system is not responsive.
It is good to know that it is being handled by printing
the first line at least. And it is handy when it does this
out of box.

IMHO, the debug output is not printed because it might be too
much for slow consoles. It might actually be an advantage to
distinguish the log level of the various messages. It allows
to filter the messages on the console.

Note that the console loglevel could be set by sysrq-0 .. 9.

One use case might be to print the debug messages into
the internal log buffer and then trigger crash to
produce crash dump. It would allow to see the log even
when it is not shown to the console. And the log might
be much easier way than digging the information from
the various structures in the crashdump.

> The fact that sysrq messages behave in this way isn't well documented,
> and is definitely harmful.  Users might (rightfully) assume that if
> they set the log level to 1, they will not see any messages that are
> not of EMERGENCY or ALERT priority.

sysrq does not know in which state the system is. It might be
called even on a normally running system. Will the EMERGENCY
or ALERT be correct in that case?

> If your system experiences a sysrq, either you have some weird backup
> software that is using the wrong interface

Is there any backup system doing this? Or is it just some wild theory?

> , or someone with extremely
> privileged access to your system believes that there is something so
> fundamentally wrong with your system that they need to bypass the
> entirety of userspace and much of the kernel to get something done.

My understanding is that sysrq is primary used when userspace
does not longer work. IMHO, the original use-case was to
trigger it from the keyboard.

> Either of those situations are at least as important as a typo in a
> password for sudo; which is given a CRITICAL priority.  
>
> Lets not add a pile of code in order to maintain a behavior that no
> sane userspace will be depending on, and which might even be causing
> bugs in sane userspaces.  Like, for instance, systemd-journald deciding
> not to write out journals when I instruct my kernel to do an emergency
> sync.

Honestly, I am not sure what would be your preferred behavior.
It might be because I am not a native speaker. And the mail is
really long.

Is the problem that systemd-journald did not write the log?
Or is the problem that it did eat 15% CPU?

Eating 15% CPU looks like a bug. The fact that it did not write
anything might be because of the OOM situation. Most things get
blocked when there is no memory.

What exact sysrq behavior would you suggest, please?


> > 4. Add ignore_per_console_loglevel parameter, use it
> >    in per_console_loglevel_is_set(), do_syslog(),
> >    and __handle_sysrq().
> 
> In other words: sysrq's use of the printk subsystem in this way is
> unique, and thus almost certainly a bad idea.

sysrq is very old interface. Various people might expect different
behavior depending on the use case. It might be impossible to
make all people happy.

Changing the default behavior a significant way might be seen as a regression.
Especially, printing all messages with EMERGENCY loglevel looks like
a pretty bad idea because it would prevent any filtering on the
console level.

My feeling is that your primary problem is somewhere else,
systemd-journald or OOM behavior.

Best Regards,
Petr
