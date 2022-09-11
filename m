Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E355F5B4CCB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiIKJCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 05:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIKJCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 05:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4771C111
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 02:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB0460F2C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26245C433D7;
        Sun, 11 Sep 2022 09:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662886950;
        bh=uOEDgwlYTWhTuNHd+gbkAqrFMBXSgUU0muhIEdRpjek=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=geEyC76PTrICuZjQyIWAIOmlRpGKIy/HQRB8rMmnjib1hDlG0g81jeYhkl8dX/PJN
         rqlM3b/LXaiY/0RRSTuaq6AXPrXI+dT52vBOS1DIJ4CCLCXeemlVrtLwl8/uy3Fcrb
         ZmG8YE6kqKDi729XQ2HekKzZYE8RURNv/9+EDXsu3psEdI7zvwxsI9f/RDc83wMIe3
         yRhG4A7SAYS7bHjFQXYSxApb9YlW31U5VehOLngcJTiBiwHQgC9wKWZIi3eW0vcVod
         kcG5jwCQOuMkM+629KaDtm4uRo4AxCBsZSoaU7oSNWaIEGgIlCEg8o4QAW1njM+hLZ
         OSSccdty3a61g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C46215C086C; Sun, 11 Sep 2022 02:01:55 -0700 (PDT)
Date:   Sun, 11 Sep 2022 02:01:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [patch RFC 00/29] printk: A new approach - WIP
Message-ID: <20220911090155.GK4315@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910221947.171557773@linutronix.de>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 12:27:31AM +0200, Thomas Gleixner wrote:

[ . . . ]

> The infrastructure we implemented comes with the following properties:
> 
>   - It shares the console list, but only for registration/unregistration
>     purposes. Consoles which are utilizing the new infrastructure are
>     ignored by the existing mechanisms and vice versa. This allows to
>     reuse as much code as possible and preserves the printk semantics
>     except for the threaded printing part.
> 
>   - The console list walk becomes SRCU protected to avoid any restrictions
>     on contexts

I am guessing that this means that you need an NMI-safe srcu_read_lock()
and srcu_read_unlock().  If my guess is correct, please let me know,
and I will create one for you.  (As it stands, these are NMI-safe on x86,
but not on architectures using the asm-generic variant of this_cpu_inc().

The result would be srcu_read_lock_nmi() and srcu_read_unlock_nmi()
or similar.  There would need to be something to prevent mixing of
srcu_read_lock() and srcu_read_lock_nmi().

Or are you somehow avoiding ever invoking either srcu_read_lock() or
srcu_read_unlock() from NMI context?

For example, are we simply living dangerously with NMI-based stack traces
as suggested below?  ;-)

>   - Consoles become stateful to handle handover and takeover in a graceful
>     way.
> 
>   - All console state operations rely solely on atomic*_try_cmpxchg() so
>     they work in any context.
> 
>   - Console locking is per console to allow friendly handover or "safe"
>     hostile takeover in emergency/panic situations. Console lock is not
>     relevant for consoles converted to the new infrastructure.
> 
>   - The core provides interfaces for console drivers to query whether they
>     can proceed and to denote 'unsafe' sections in the console state, which
>     is unavoidable for some console drivers.
> 
>     In fact there is not a single regular (non-early) console driver today
>     which is reentrancy safe under all circumstances, which enforces that
>     NMI context is excluded from printing directly. TBH, that's a sad state
>     of affairs.
> 
>     The unsafe state bit allows to make informed decisions in the core
>     code, e.g. to postpone printing if there are consoles available which
>     are safe to acquire. In case of a hostile takeover the unsafe state bit
>     is handed to the atomic write callback so that the console driver can
>     act accordingly.
>     
>   - Printing is delegated to a per console printer thread except for the
>     following situations:
> 
>        - Early boot
>        - Emergency printing (WARN/OOPS)
>        - Panic printing
> 
> The integration is complete, but without any fancy things, like locking all
> consoles when entering a WARN, print and unlock when done. Such things only
> make sense once all drivers are converted over because that conflicts with
> the way how the existing console lock mechanics work.
> 
> For testing we used the most simple driver: a hacked up version of the
> early uart8250 console as we wanted to concentrate on validating the core
> mechanisms of friendly handover and hostile takeovers instead of dealing
> with the horrors of port locks or whatever at the same time. That's the
> next challenge. Hack patch will be provided in a reply.
> 
> Here is sample output where we let the atomic and thread write functions
> prepend each line with the printing context (A=atomic, T=thread):
> 
> A[    0.394066] ... fixed-purpose events:   3
> A[    0.395130] ... event mask:             000000070000000f
> 
> End of early boot, thread starts
> 
> TA[    0.396821] rcu: Hierarchical SRCU implementation.
> 
> ^^ Thread starts printing and immediately raises a warning, so atomic
>    context at the emergency priority takes over and continues printing.
> 
>    This is a forceful, but safe takeover scenario as the WARN context
>    is obviously on the same CPU as the printing thread where friendly
>    is not an option.
> 
> A[    0.397133] rcu: 	Max phase no-delay instances is 400.
> A[    0.397640] ------------[ cut here ]------------
> A[    0.398072] WARNING: CPU: 0 PID: 13 at drivers/tty/serial/8250/8250_early.c:123 __early_serial8250_write.isra.0+0x80/0xa0
> ....
> A[    0.440131]  ret_from_fork+0x1f/0x30
> A[    0.441133]  </TASK>
> A[    0.441867] ---[ end trace 0000000000000000 ]---
> T[    0.443493] smp: Bringing up secondary CPUs ...
> 
> After the warning the thread continues printing.
> 
> ....
> 
> T[    1.916873] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
> T[    1.918719] md: Waiting for all devices to be available before autod
> 
> A[    1.918719] md: Waiting for all devices to be available before autodetect
> 
> System panics because it can't find a root file system. Panic printing
> takes over the console from the printer thread immediately and reprints
> the interrupted line.
> 
> This case is a friendly handover from the printing thread to the panic
> context because the printing thread was not running on the panic CPU, but
> handed over gracefully.
> 
> A[    1.919942] md: If you don't use raid, use raid=noautodetect
> A[    1.921030] md: Autodetecting RAID arrays.
> A[    1.921919] md: autorun ...
> A[    1.922686] md: ... autorun DONE.
> A[    1.923761] /dev/root: Can't open blockdev
> 
> So far the implemented state handling machinery holds up on the various
> handover and hostile takeover situations we enforced for testing.
> 
> Hostile takeover is nevertheless a special case. If the driver is in an
> unsafe region that's something which needs to be dealt with per driver.
> There is not much the core code can do here except of trying a friendly
> handover first and only enforcing it after a timeout or not trying to print
> on such consoles.
> 
> This needs some thought, but we explicitely did not implement any takeover
> policy into the core state handling mechanism as this is really a decision
> which needs to be made at the call site. See patch 28.
> 
> We are soliciting feedback on that approach and we hope that we can
> organize a BOF in Dublin on short notice.

Last I checked, there were still some slots open.

> The series is also available from git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git printk
> 
> The series has the following parts:
> 
>    Patches  1 - 5:   Cleanups
> 
>    Patches  6 - 12:  Locking and list conversion
> 
>    Patches 13 - 18:  Improved output buffer handling to prepare for
>    	      	     code sharing
> 
>    Patches 19 - 29:  New infrastructure implementation
> 
> Most of the preparatory patches 1-18 have probably a value on their own.
> 
> Don't be scared about the patch stats below. We added kernel doc and
> extensive comments to the code:
> 
>   kernel/printk/printk_nobkl.c: Code: 668 lines, Comments: 697 lines, Ratio: 1:1.043

When I reach stable AC, I will fire off some rcutorture tests.  From the
discussion above, it sounds like I should expect some boot-time warnings?
Or were those strictly printk-specific testing?

> Of course the code is trivial and straight forward as any other facility
> which has to deal with concurrency and the twist of being safe in any
> context. :)

;-) ;-) ;-)

							Thanx, Paul

> Comments welcome.
> 
> Thanks,
> 
> 	tglx
> ---
> [1] https://lore.kernel.org/lkml/87r11qp63n.ffs@tglx/
> ---
>  arch/parisc/include/asm/pdc.h  |    2 
>  arch/parisc/kernel/pdc_cons.c  |   53 -
>  arch/parisc/kernel/traps.c     |   17 
>  b/kernel/printk/printk_nobkl.c | 1564 +++++++++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/kgdboc.c    |    7 
>  drivers/tty/tty_io.c           |    6 
>  fs/proc/consoles.c             |   12 
>  fs/proc/kmsg.c                 |    2 
>  include/linux/console.h        |  375 +++++++++
>  include/linux/printk.h         |    9 
>  include/linux/syslog.h         |    3 
>  kernel/debug/kdb/kdb_io.c      |    7 
>  kernel/panic.c                 |   12 
>  kernel/printk/printk.c         |  485 ++++++++----
>  14 files changed, 2304 insertions(+), 250 deletions(-)
