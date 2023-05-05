Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179566F80E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjEEKjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjEEKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:39:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED1F18FC5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 03:39:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D5AF221E46;
        Fri,  5 May 2023 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683283178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d2YVdYUp91Yu/VzsHhbSR/05fc0zd4hXjN6F4vzqIRY=;
        b=lmKo4n25YZ/ti0alOz3SOUB/iT0uoNT3srnY9NKkhBL1QWLzVmIIIixYEeV0hiWd2m9zJZ
        4oaCaiBcqiv28CObRe2cnBr5cwoKjrWYYpdSHHAs1eyjoesRtl35OIabQxbPwPXTH0R2EL
        Styaqw5dZVMwiPvfp55aHeNn16NbzQ4=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 29ABA2C141;
        Fri,  5 May 2023 10:39:37 +0000 (UTC)
Date:   Fri, 5 May 2023 12:39:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     calumlikesapplepie@gmail.com
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com,
        mj@atrey.karlin.mff.cuni.cz
Message-ID: <ZFTc6Bh6DxSJ2ni0@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bcc: 
Subject: Re: [PATCH v5 2/2] printk: console: Remove sysrq exception
Reply-To: 
In-Reply-To: <bad7cc32729c153689a32ac5111eb2b7882963a6.camel@gmail.com>

Put back people and mailing lists into Cc.

On Tue 2023-05-02 21:37:52, calumlikesapplepie@gmail.com wrote:
> On Tue, 2023-05-02 at 12:27 +0200, Petr Mladek wrote:
> > On Sun 2023-04-30 19:00:42, calumlikesapplepie@gmail.com wrote:
> > It seems that the original code actually printed all messages with
> > the updated console_loglevel.
> > 
> > It was modified to printk only the first line or help by:
> > commit 2433aae9cbfbe77b5c5af11e6174d390e06053a6
> > Author: linus1 <torvalds@athlon.transmeta.com>
> > 
> >     v2.4.10.1 -> v2.4.10.2
> > 
> > , see
> > https://github.com/mpe/linux-fullhistory/commit/2433aae9cbfbe77b5c5af11e6174d390e06053a6
> > 
> > I do not see any explanation for this. I guess that the too long
> > output caused some problems.
> > 
> > IMHO, the debug output is not printed because it might be too
> > much for slow consoles. It might actually be an advantage to
> > distinguish the log level of the various messages. It allows
> > to filter the messages on the console.
> > 
> > sysrq does not know in which state the system is. It might be
> > called even on a normally running system. Will the EMERGENCY
> > or ALERT be correct in that case?
> 
> Based on the definitions laid out in /include/linux/kern_levels, I
> think the fact that a sysrq has been triggered is worthy of CRITICAL
> status, perhaps even ALERT.  Every example use case for a sysrq is of a
> system that is not running normally; while you can trigger it via
> software (/proc/sysrq-trigger ), that isn't really the intended use.
> 
> This is a system that is explicitly designed to be used for manual
> interaction with the lowest levels of the operating system by a
> superuser.  Most alerts are to get an admin's attention for a problem;
> when a sysrq occurs, the admin is paying attention and is trying to
> solve a problem.  In short, a critical situation already exists.

If admins trigger sysrq then they do not need to be alerted by
a console loglevel.

IMHO, the main motivation for the console_loglevel change was
to give the admin feedback that the system was living enough
to start processing the sysrq.

Anyway, I do not want to continue long philosophical discussions
about motivations and expectations. The most important thing
is how to solve your problem and do not break others.

> > > If your system experiences a sysrq, either you have some weird backup
> > > software that is using the wrong interface
> > 
> > Is there any backup system doing this? Or is it just some wild theory?
> 
> I wish it were a wild theory, but there does seem to be a system doing
> this.  Someone should probably ask them to stop.  Maybe the backup
> system is a custom design for this one company's servers, but it does
> exist.
> 
> https://support.binarylane.com.au/support/solutions/articles/11000107835-what-is-sysrq-emergency-sync
> 
> > > , or someone with extremely
> > > privileged access to your system believes that there is something so
> > > fundamentally wrong with your system that they need to bypass the
> > > entirety of userspace and much of the kernel to get something done.
> > 
> > My understanding is that sysrq is primary used when userspace
> > does not longer work. IMHO, the original use-case was to
> > trigger it from the keyboard.
> > 
> 
> Yup.  However, it can also be triggered by writing to procfs as a
> superuser.
> 
> > > Either of those situations are at least as important as a typo in a
> > > password for sudo; which is given a CRITICAL priority.  
> > > 
> > > Lets not add a pile of code in order to maintain a behavior that no
> > > sane userspace will be depending on, and which might even be causing
> > > bugs in sane userspaces.  Like, for instance, systemd-journald deciding
> > > not to write out journals when I instruct my kernel to do an emergency
> > > sync.
> > 
> > Honestly, I am not sure what would be your preferred behavior.
> > It might be because I am not a native speaker. And the mail is
> > really long.
> 
> it really is overly long, yeah.
> 
> > Is the problem that systemd-journald did not write the log?
> > Or is the problem that it did eat 15% CPU?
> 
> That the log was not written out to disk immediately, despite a
> critical situation existing.  However, this isn't a journald bug. 
> Journald is documented as being perfectly happy to cache logs for up to
> 5 minutes by default, unless a sufficiently high priority message is
> received.  

Will it actually help to print the initial sysrq message with
higher priority? Could you try it, please?

> > Eating 15% CPU looks like a bug. The fact that it did not write
> > anything might be because of the OOM situation. Most things get
> > blocked when there is no memory.

> In my experience, journald eating 15% of CPU when things are going boom
> is perfectly reasonable.  The OOM situation would be causing many
> failing allocations in userspace, which journald would be trying to
> process.  

journald might actually have problems to store new messages even
in memory unless it has pre-allocated a big enough buffer.

Another question is how quickly it could store the huge amount
of data on disk when many operations are blocked or slowed down
by the OOM situation.

> I initially didn't think it failed to write due to the OOM situation; I
> left the system sitting for five minutes, and several other operations
> happily completed (the atop log was written, for instance).  However,
> looking closer at the log, its clear that of that high CPU usage,
> almost none of it went to userspace: in fact, atop shows 0 seconds of
> USRCPU and 87.12 seconds of SYSCPU.  Atop has a far smaller virtual
> memory usage, and required less resident memory: thus, it seems likely
> it was able to squeeze in work where journalctl failed.
> 
> I suppose that, ultimately, the best solution to OOM causing problems
> is to avoid it occurring; I've installed systemd-oomd, to avoid this
> precise problem.  I'm sure there's some optimization to be made when
> the kernel starts thrashing swap: but that's all out of scope.  Even if
> this doesn't actually solve my specific problem, it will remove what I
> see as a wart.
> 
> > What exact sysrq behavior would you suggest, please?
> 
> Do not adjust console_loglevel to print out the single sysrq header
> line.  Instead, print that line out at an appropriate priority
> (KERN_CRIT, perhaps).  Print the remaining lines at their current
> priorities.

Could you please try if it really helps in your case?

> While I mentioned emergency priority previously, I did not realize that
> it could result in the kernel dumping immediately. 
> 
> At the very least, we should increase the priority of that printline,
> so it is less out of place.
> 
> > > > 4. Add ignore_per_console_loglevel parameter, use it
> > > >    in per_console_loglevel_is_set(), do_syslog(),
> > > >    and __handle_sysrq().
> > > 
> > > In other words: sysrq's use of the printk subsystem in this way is
> > > unique, and thus almost certainly a bad idea.
> > 
> > sysrq is very old interface. Various people might expect different
> > behavior depending on the use case. It might be impossible to
> > make all people happy.
> > 
> > Changing the default behavior a significant way might be seen as a regression.
> > Especially, printing all messages with EMERGENCY loglevel looks like
> > a pretty bad idea because it would prevent any filtering on the
> > console level.
> 
> That's true: however, its also an interface that is intentionally
> awkward and limiting to use.  The only sysrqs that even HAVE a use when
> a system is in normal operation (ie, not being played with by a kernel
> developer or actively freezing up) are those that change log levels,
> and the sync filesystem call.  All the others, if called on a system
> you are actually trying to do work with, will result in either
> meaningless debug information dumps more easily acquired through other
> means, or will actively disrupt whatever you're trying to do.
> 
> > My feeling is that your primary problem is somewhere else,
> > systemd-journald or OOM behavior.
> 
> Problably.

Let's first try if changing the loglevel actually helps.

Anyway, I suggest to avoid OOM in the first place. Maybe,
use cgroups for limiting the most hungry processes so that
they do not break the system.

Best Regards,
Petr
