Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC705EC01B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiI0Ktj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiI0KtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:49:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4927E115470
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:49:23 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664275761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M0Oct6wfnG8hz2H5aHcY9EbvNf7uNtw1xpb054RCO8w=;
        b=eru3KZ7jmqHf0jwEF0TLfVWiuvTIVIzbTvDd8qaIymjvHShsSm6P+NXe/J8WaqaftzzfAC
        ShuReTbfsiWizU3lCKlCJVJA5u6UvF9RCi4TBcRPBLWUhUqE4kTdJ+BUl+U9zb1n6YRYsc
        MFbciMGpG1us7ZBn4OIqPo3RXG3o7TEspu0yu/cGs0XqsGlINUOigWOWeO3By1rQ4vUWE0
        WrMH+V6kkIpr8JWVM4rUTEUWV6Vc1cMxMP1b1WhbGXzj4nld9mTq4duRMeO46nWxTKTzZ9
        fcwFchjOMIAYzgMYykABGBc3wP0mIhNNju3YUn7YeLEYmIv2TnDqteiMeucsZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664275761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M0Oct6wfnG8hz2H5aHcY9EbvNf7uNtw1xpb054RCO8w=;
        b=TIFq5ccH5hVTspA3oFzA5r405DSsZdUmDg6IxGfkfl8PYrgk/gvWhXr1L2xt0dQNjC9bVy
        vI9D7N99NI249XCg==
To:     linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2 v4] Init the hashed pointer from a worker.
Date:   Tue, 27 Sep 2022 12:49:10 +0200
Message-Id: <20220927104912.622645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a mini series to initialize the random value, needed for the %p
format argument, upfront during boot instead on demand. The latter is
problematic on PREEMPT_RT if the first user happens to be in an atomic
region.

v3=E2=80=A6v4:
    - Added a __read_mostly.
    - Added Jason's Acked-by for 2/2 after talking to him at Plumbers.
      While we were discussion several ways of tackling this differently
      and the possible problems/ side effects that this may cause we
      happen to notice that the current way of doing things is also a
      problem if the first printk("%p\n") user happens to be in NMI
      context.
      Therefore I leave it to the vsprintf/ printk maintainer to decide
      if this is -stable material or not. I'm not aware of any NMI code
      path using %p but then it is not officially forbidden.
      Assuming unknown_nmi_error() contains %p format the string, then
      the backtrace at the end of the email will be printed.

v2=E2=80=A6v3:
    - schedule a worker every two seconds if the RNG core is not ready.
    https://lore.kernel.org/all/YueeIgPGUJgsnsAh@linutronix.de

v1=E2=80=A6v2:
   - Remove the static_branch_likely() as suggested by Petr Mladek.
   - Jason wasn't onboard with fiddling in random core to get the job
     done. Instead a worker is scheduled from an initcall and
     get_random_bytes_wait() is used to get the date once it is
     available.
   https://lore.kernel.org/all/20220729154716.429964-1-bigeasy@linutronix.d=
e/

v1:
   https://lore.kernel.org/all/YuOf6qu453dOkR+S@linutronix.de/

Before the series after adding "%p" to unknown_nmi_error() and
triggering a NMI:
| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| WARNING: inconsistent lock state
| 6.0.0-rc7+ #6 Not tainted
| --------------------------------
| inconsistent {INITIAL USE} -> {IN-NMI} usage.
| swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
| ffffffff82aea4f0 (input_pool.lock){..-.}-{2:2}, at: extract_entropy.const=
prop.0+0x76/0x240
| {INITIAL USE} state was registered at:
| irq event stamp: 37104
| hardirqs last  enabled at (37103): [<ffffffff81cc8e80>] default_idle_call=
+0x20/0x90
| hardirqs last disabled at (37104): [<ffffffff81cbbb2b>] exc_nmi+0x7b/0x120
| softirqs last  enabled at (37098): [<ffffffff810f3a8c>] __irq_exit_rcu+0x=
8c/0xb0
| softirqs last disabled at (37085): [<ffffffff810f3a8c>] __irq_exit_rcu+0x=
8c/0xb0
|=20
| other info that might help us debug this:
|  Possible unsafe locking scenario:
|=20
|        CPU0
|        ----
|   lock(input_pool.lock);
|   <Interrupt>
|     lock(input_pool.lock);
|=20
|  *** DEADLOCK ***
|=20
| no locks held by swapper/0/0.
|=20
| stack backtrace:
| CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.0-rc7+ #6
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian=
-1.16.0-4 04/01/2014
| Call Trace:
|  <NMI>
|  dump_stack_lvl+0x4c/0x63
|  lock_acquire.cold+0x43/0x48
|  _raw_spin_lock_irqsave+0x33/0x50
|  extract_entropy.constprop.0+0x76/0x240
|  crng_reseed+0x20/0xf0
|  crng_make_state+0x51/0x2b0
|  _get_random_bytes.part.0+0x47/0x150
|  default_pointer+0x3e9/0x420
|  vsnprintf+0x1a8/0x550
|  vprintk_store+0x13e/0x4c0
|  vprintk+0x2e/0x50
|  _printk+0x53/0x6e
|  default_do_nmi+0x224/0x290
|  exc_nmi+0xf1/0x120
|  end_repeat_nmi+0x16/0x67
| RIP: 0010:default_idle+0xb/0x10
=E2=80=A6
|  </NMI>
|  <TASK>
|  default_idle_call+0x51/0x90
|  do_idle+0x201/0x270
|  cpu_startup_entry+0x14/0x20
|  rest_init+0xe5/0x170
|  arch_call_rest_init+0x5/0xa
|  start_kernel+0x68c/0x6b5
|  secondary_startup_64_no_verify+0xe0/0xeb
|  </TASK>
| ------------[ cut here ]------------
| WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/core.c:60 irq_fpu_usable+0x=
34/0x40
| Modules linked in:
| CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.0-rc7+ #6
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian=
-1.16.0-4 04/01/2014
| RIP: 0010:irq_fpu_usable+0x34/0x40
=E2=80=A6
| Call Trace:
|  <NMI>
|  blake2s_compress+0x1b/0xa0
|  blake2s_final+0x3c/0x60
|  extract_entropy.constprop.0+0x8d/0x240
|  crng_reseed+0x20/0xf0
|  crng_make_state+0x51/0x2b0
|  _get_random_bytes.part.0+0x47/0x150
|  default_pointer+0x3e9/0x420
|  vsnprintf+0x1a8/0x550
|  vprintk_store+0x13e/0x4c0
|  vprintk+0x2e/0x50
|  _printk+0x53/0x6e
|  default_do_nmi+0x224/0x290
|  exc_nmi+0xf1/0x120
|  end_repeat_nmi+0x16/0x67
| RIP: 0010:default_idle+0xb/0x10
=E2=80=A6
|  </NMI>
|  <TASK>
|  default_idle_call+0x51/0x90
|  do_idle+0x201/0x270
|  cpu_startup_entry+0x14/0x20
|  rest_init+0xe5/0x170
|  arch_call_rest_init+0x5/0xa
|  start_kernel+0x68c/0x6b5
|  secondary_startup_64_no_verify+0xe0/0xeb
|  </TASK>
| irq event stamp: 37104
| hardirqs last  enabled at (37103): [<ffffffff81cc8e80>] default_idle_call=
+0x20/0x90
| hardirqs last disabled at (37104): [<ffffffff81cbbb2b>] exc_nmi+0x7b/0x120
| softirqs last  enabled at (37098): [<ffffffff810f3a8c>] __irq_exit_rcu+0x=
8c/0xb0
| softirqs last disabled at (37085): [<ffffffff810f3a8c>] __irq_exit_rcu+0x=
8c/0xb0
| ---[ end trace 0000000000000000 ]---
| Uhhuh. NMI received for unknown reason 30 on CPU 0 / 00000000f8da9c8a.
| Dazed and confused, but trying to continue

Sebastian

