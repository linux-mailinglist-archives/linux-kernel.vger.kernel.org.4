Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307C36C80B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjCXPIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjCXPIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:08:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EA9B476
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:08:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 999D21FEF6;
        Fri, 24 Mar 2023 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679670487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTv6SvvIvX7fxYYTYVatFyDn7CcVQUadTYgQv2mfSeA=;
        b=ZNMilDFDL4C2KoKEeR6kB/NBrBYU9VUdZMlyJflXssyrKJSCGlV+rxyrXLoKHn1F5xh0Hs
        YfxPNGHPYyuJsRQihP/L0hoj66uAZykFKyXFwi+zEixIKRvlMTQ2Rs2h4nuQZyCrholvgK
        aIqHknVLeynznYiV+qBtpx8Tmb2snjo=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 037972C141;
        Fri, 24 Mar 2023 15:08:06 +0000 (UTC)
Date:   Fri, 24 Mar 2023 16:08:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: Change of behaviour when console=null and ttynull driver is used
Message-ID: <ZB281JxlZtKSkJoJ@alley>
References: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
 <ZBRiRu7hlwxSKHBg@alley>
 <CABDcavYLQ63V81z5JiOxZ6hXMj=M+PQpfDLPk6AQynLGwuYTKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABDcavYLQ63V81z5JiOxZ6hXMj=M+PQpfDLPk6AQynLGwuYTKQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I need an advice whether to revert the commit 3cffa06aeef7ece30f
("printk/console: Allow to disable console output by using
console="" or console=null").

On Wed 2023-03-22 09:33:32, Guillermo Rodriguez Garcia wrote:
> Hi Petr,
> 
> El vie, 17 mar 2023 a las 13:51, Petr Mladek (<pmladek@suse.com>) escribió:
> >
> > On Thu 2023-03-16 11:29:26, Guillermo Rodriguez Garcia wrote:
> > > Hi all,
> > >
> > > We have several embedded systems where pass console= or console=null
> > > in production to disable the console.
> > >
> > > Later we check for this in user space: in our inittab we check if fd0
> > > is "associated with a terminal" (test -t 0); if so, we are in
> > > development mode and we open a debug shell; otherwise (console
> > > disabled) we just start the application.
> > >
> > > Recently [1] this behaviour has changed and now if we pass console= or
> > > console=null, the new ttynull driver is used. This breaks the check we
> > > were doing (test -t 0 always true now).
> > >
> > > [1]: https://lore.kernel.org/lkml/X%2FcDG%2FxCCzSWW2cd@alley/t/
> >
> > This is actually exactly the problem that the change tried to solve.
> > Some systems failed to boot when there was no console and they tried
> > to write something at stdout.
> 
> Well, I did not have any problem before this change.
> 
> I understand that some systems had a problem (many others didn't, and
> setting console= or console=null has been standard practice for a long
> time). Since this change in behaviour could (and did) break things in
> user space, perhaps it should have been made opt-in...

Historically, a single and invalid console=<name> kernel parameter
might cause that no console gets registered. As a result, there
is no stdin/stdout/stderr for the init process.

From the code perspective, the <name> is considered a preferred
console. No console is registered by default because there is
the preferred console. But an invalid <name> never matches.

The non-existing stdin/stdout/stderr caused Oopses reported during boot, see
https://lore.kernel.org/all/20200309052915.858-1-shreyas.joshi@biamp.com/
https://lore.kernel.org/all/20201006065907.GA528@jagdpanzerIV.localdomain/

It would have been great to debug the root of the Oopses.
But it was not trivial. And it looked like the fallback
to ttynull made sense even if the kernel did not crash:

1. The init process might expect a working stdin/stderr/stdout.
   The POSIX standard says:

    At program start-up, three streams are predefined and need not be
    opened explicitly: standard input (for reading conventional input),
    standard output (for writing conventional output), and standard error
    (for writing diagnostic output). When opened, the standard error
    stream is not fully buffered; the standard input and standard output
    streams are fully buffered if and only if the stream can be determined
    not to refer to an interactive device.

2. Also the comment in init/main.c is rather clear:

    /* Open /dev/console, for stdin/stdout/stderr, this should never fail */
   void __init console_on_rootfs(void)


This is why we implemented the fallback to ttynull. But it causes
regressions on Chromebooks. They use:

   + console="" to disable consoles on production systems.
     (better performance, nobody reads the console anyway).

   + "test -f 0" to detect whether the Chromebook is in
     debugging mode.

The regression is:

   + "test -f 0" does not longer work.

   + ttynull delays reboot on busybox by 20-25sec from unknown
     reasons

From this POV, the commit breaks userspace and should be reverted.

On the other hand, I think that having stdin/stdout/stderr
might be required by POSIX.

Also note that the commit was accepted in v5.11-rc1. So the regression
is 2 years old. The revert might be seen as a regression as well.


My opinion:

I would prefer to keep the commit because it goes in the right
direction. And the revert would cause regression for the original
reporter.

The regression did not reach normal users. Chromebook developers
reverted it in their tree, see
https://lore.kernel.org/all/055bbf1a-8eb7-7f77-5ea8-31d2ecaf1d4b@roeck-us.net/
So, we could find a better solution for them.

What is your opinion, please?


> > > Is there a way to get the previous behaviour? If not, is there an easy
> > > way for userspace to detect whether the console device is a "real" tty
> > > or ttynull (other than trying to parse the kernel boot args, which
> > > would be a bit fragile).
> >
> > A solution would be to check that /proc/consoles has ttynull as the
> > only registred console, for example:
> >
> > grep -q ttynull /proc/consoles && test `cat /proc/consoles | wc -l` -eq 1
> >
> > Would this work for you, please?
> 
> I was trying to avoid something like this as it feels like userspace
> now needs to have too much knowledge of what the kernel is doing
> internally, however I guess this is the best option.

Fair enough. It is true the "ttynull" is an implementation detail.

I wonder if the console is the only detail that might be used
to detect if the system is in debug mode.

> The suggested check seems to work but now I am seeing a different
> (related?) issue: when I try to reboot from the console (using
> busybox's reboot command), the system reboots normally if I am using a
> "normal" console (e.g. console=ttyXXX), however when using
> console=ttynull, the command takes 20-25 seconds to complete. I am not
> sure why this would happen; if I understand correctly, for userspace
> ttynull is just like a regular tty driver, so why would there be a
> difference?

This looks like a timeout. It is hard to say who is waiting on what.
Anyway, the ttynull driver is super trivial, see
drivers/tty/ttynull.c.

Best Regards,
Petr
