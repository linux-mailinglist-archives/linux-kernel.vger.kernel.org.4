Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC92647278
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiLHPHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLHPHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:07:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C77CA13CD;
        Thu,  8 Dec 2022 07:07:04 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 533F3337A0;
        Thu,  8 Dec 2022 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670512023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=pqZvqnA90o9ISBB/ssQWKoeLFxAEDiRIT0nh3FJDhRU=;
        b=GlCE1NtllOCZ9yfhIVBJLE4zIhXwqRj5CmW0ca70g9uhGzJIrMIta2xoreiBIstbZDBvBB
        qnqvvk98YwsjhyY8BpSMzN6wegVdkMEoH/GezSfj1iQp579EN2mShKnqLCL0kiMBRtviH5
        ImnP4igLtRFV9R+nsAJtkJnyw7veVs0=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D68802C143;
        Thu,  8 Dec 2022 15:07:02 +0000 (UTC)
Date:   Thu, 8 Dec 2022 16:06:59 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 6.2
Message-ID: <Y5H9k52WWXBmWuwZ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.2

========================================

- Add NMI-safe SRCU reader API. It uses atomic_inc() instead of
  this_cpu_inc() on strong load-store architectures.

- Introduce new console_list_lock to synchronize a manipulation of the list
  of registered consoles and their flags.

  It is a first step in removing the big-kernel-lock-like behavior of
  console_lock(). This semaphore still serializes console->write()
  calbacks against:

    - each other. It primary prevents potential races between early and
      proper console drivers using the same device.

   - suspend()/resume() callbacks and init() operations in some drivers.

   - various other operations in the tty/vt and framebufer susbsystems.
     It is likely that console_lock() serializes even operations that are
     not directly conflicting with the console->write() callbacks here.
     This is the most complicated big-kernel-lock aspect of
     the console_lock() that will be hard to untangle.

- Introduce new console_srcu lock that is used to safely iterate and
  access the registered console drivers under SRCU read lock.

  It is a prerequisite for introducing atomic console drivers and console
  kthreads. It will reduce the complexity of serialization against normal
  consoles and console_lock(). Also it should remove the risk of deadlock
  during critical situations, like Oops or panic, when only atomic consoles
  are registered.

- Check whether the console is registered instead of enabled on many
  locations. It was a historical leftover.

- Cleanly force a preferred console in xenfb code instead of a dirty hack.

- A lot of code and comment clean ups and improvements.

=========================================

Notes:

1. The NMI-safe SRCU read API code is merged from Paul's RCU tree.
   It is going to be part of Paul's pull request as well.

2. The major changes reached linux-next at Oct 22. The branch
   rework/console-list-lock has been rebased two times last
   week to get follow up fixes from RCU tree. They fixed issues
   with non-standard configurations.


IMHO, the biggest risk of these changes would be in introducing new
races or deadlocks because of the new locks.

Anyway, it should be step in the right direction. The big-kernel-lock
behavior of console_lock() is a constant source of problems. The SRCU
lock allows to iterate the list of consoles safely anytime. Also there
are many new lockdep asserts that would allow to catch and nail down
potential problems.

----------------------------------------------------------------
Andy Shevchenko (1):
      test_printf: Refactor fwnode_pointer() to make it more readable

Frederic Weisbecker (3):
      srcu: Warn when NMI-unsafe API is used in NMI
      srcu: Explain the reason behind the read side critical section on GP start
      srcu: Debug NMI safety even on archs that don't require it

John Ogness (40):
      rcu: Implement lockdep_rcu_enabled for !CONFIG_DEBUG_LOCK_ALLOC
      printk: Prepare for SRCU console list protection
      printk: register_console: use "registered" for variable names
      printk: move @seq initialization to helper
      printk: fix setting first seq for consoles
      um: kmsg_dump: only dump when no output console available
      tty: serial: kgdboc: document console_lock usage
      tty: tty_io: document console_lock usage
      proc: consoles: document console_lock usage
      printk: introduce console_list_lock
      console: introduce wrappers to read/write console flags
      um: kmsg_dumper: use srcu console list iterator
      kdb: use srcu console list iterator
      printk: console_flush_all: use srcu console list iterator
      printk: __pr_flush: use srcu console list iterator
      printk: console_is_usable: use console_srcu_read_flags
      printk: console_unblank: use srcu console list iterator
      printk: console_flush_on_panic: use srcu console list iterator
      printk: console_device: use srcu console list iterator
      console: introduce console_is_registered()
      serial_core: replace uart_console_enabled() with uart_console_registered()
      tty: nfcon: use console_is_registered()
      efi: earlycon: use console_is_registered()
      tty: hvc: use console_is_registered()
      tty: serial: earlycon: use console_is_registered()
      tty: serial: pic32_uart: use console_is_registered()
      tty: serial: samsung_tty: use console_is_registered()
      tty: serial: xilinx_uartps: use console_is_registered()
      usb: early: xhci-dbc: use console_is_registered()
      netconsole: avoid CON_ENABLED misuse to track registration
      printk, xen: fbfront: create/use safe function for forcing preferred
      tty: tty_io: use console_list_lock for list synchronization
      proc: consoles: use console_list_lock for list iteration
      tty: serial: kgdboc: use srcu console list iterator
      tty: serial: kgdboc: use console_list_lock for list traversal
      tty: serial: kgdboc: synchronize tty_find_polling_driver() and register_console()
      tty: serial: kgdboc: use console_list_lock to trap exit
      printk: relieve console_lock of list synchronization duties
      tty: serial: sh-sci: use setup() callback for early console
      printk: htmldocs: add missing description

Paul E. McKenney (9):
      srcu: Convert ->srcu_lock_count and ->srcu_unlock_count to atomic
      srcu: Create an srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe()
      srcu: Check for consistent per-CPU per-srcu_struct NMI safety
      srcu: Check for consistent global per-srcu_struct NMI safety
      arch/x86: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
      arch/arm64: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
      arch/loongarch: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
      arch/s390: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
      rcu: Make SRCU mandatory

Petr Mladek (1):
      Merge branch 'rework/console-list-lock' into for-linus

Thomas Gleixner (2):
      serial: kgdboc: Lock console list in probe function
      printk: Convert console_drivers list to hlist

Wang Honghui (1):
      printk: fix a typo of comment

Xu Panda (1):
      printk: use strscpy() to instead of strlcpy()

Zqiang (1):
      srcu: Make Tiny synchronize_srcu() check for readers

ye xingchen (1):
      vsprintf: replace in_irq() with in_hardirq()

 .clang-format                       |   1 +
 arch/Kconfig                        |   3 +
 arch/arm64/Kconfig                  |   1 +
 arch/loongarch/Kconfig              |   1 +
 arch/m68k/emu/nfcon.c               |   9 +-
 arch/s390/Kconfig                   |   1 +
 arch/um/kernel/kmsg_dump.c          |  24 +-
 arch/x86/Kconfig                    |   1 +
 drivers/firmware/efi/earlycon.c     |   8 +-
 drivers/net/netconsole.c            |  21 +-
 drivers/tty/hvc/hvc_console.c       |   4 +-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/earlycon.c       |   4 +-
 drivers/tty/serial/kgdboc.c         |  46 +++-
 drivers/tty/serial/pic32_uart.c     |   4 +-
 drivers/tty/serial/samsung_tty.c    |   2 +-
 drivers/tty/serial/serial_core.c    |  14 +-
 drivers/tty/serial/sh-sci.c         |  20 +-
 drivers/tty/serial/xilinx_uartps.c  |   2 +-
 drivers/tty/tty_io.c                |  18 +-
 drivers/usb/early/xhci-dbc.c        |   2 +-
 drivers/video/fbdev/xen-fbfront.c   |  12 +-
 fs/proc/consoles.c                  |  21 +-
 include/linux/console.h             | 129 +++++++++-
 include/linux/rcupdate.h            |   5 +
 include/linux/rcutiny.h             |   4 -
 include/linux/serial_core.h         |  10 +-
 include/linux/srcu.h                |  72 +++++-
 include/linux/srcutree.h            |   5 +-
 kernel/debug/kdb/kdb_io.c           |  18 +-
 kernel/printk/printk.c              | 498 ++++++++++++++++++++++++++++--------
 kernel/printk/printk_ringbuffer.c   |   2 +-
 kernel/rcu/Kconfig                  |  14 +-
 kernel/rcu/Kconfig.debug            |   3 -
 kernel/rcu/rcu.h                    |   8 +-
 kernel/rcu/rcutorture.c             |  11 +-
 kernel/rcu/srcutiny.c               |  10 +
 kernel/rcu/srcutree.c               | 100 ++++++--
 kernel/rcu/update.c                 |  18 +-
 lib/test_printf.c                   |  26 +-
 lib/vsprintf.c                      |   2 +-
 41 files changed, 899 insertions(+), 257 deletions(-)
