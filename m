Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7A96A74FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCAUPz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Mar 2023 15:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjCAUPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:15:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5A84FA91
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:15:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2214DB8113A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 20:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF60C433AE;
        Wed,  1 Mar 2023 20:15:19 +0000 (UTC)
Date:   Wed, 1 Mar 2023 15:15:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Message-ID: <20230301151516.6df3dcbc@gandalf.local.home>
In-Reply-To: <Y/9dv1FglalcIVnQ@localhost.localdomain>
References: <20220822164404.57952727@gandalf.local.home>
        <Y/9dv1FglalcIVnQ@localhost.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 15:14:23 +0100
Frederic Weisbecker <frederic@kernel.org> wrote:

> Le Mon, Aug 22, 2022 at 04:44:04PM -0400, Steven Rostedt a écrit :
> > My tests are failing because of this splat:
> > 
> > [   16.073659] ------------[ cut here ]------------
> > [   16.074407] bus: 'platform': add driver acpi-ged
> > [   16.074424] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> > [   16.074424] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5506 check_flags+0x114/0x1d0
> > [   16.083020] bus: 'acpi': add driver ac
> > [   16.074424] Modules linked in:
> > [   16.074424] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.0-rc2-test+ #18
> > [   16.096856] bus: 'acpi': add driver button
> > [   16.074424] Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
> > [   16.074424] RIP: 0010:check_flags+0x114/0x1d0
> > [   16.103642] bus: 'acpi': __driver_probe_device: matched device PNP0C0C:00 with driver button
> > [   16.074424] Code: ff ff e8 ef 0a aa ff 85 c0 74 21 44 8b 0d bc 56 c6 00 45 85 c9 75 15 48 c7 c6 c7 e8 37 b9 48 c7 c7 a0 96 36 b9 e8 54 c9 f9 ff <0f> 0b 48 c7 c7 b0 fc 37 b9 e8 2e 20 fa ff eb 99 85 c0 0f 85 38 ff
> > [   16.074424] RSP: 0000:ffffffffb9603d28 EFLAGS: 00010082
> > [   16.114488] bus: 'acpi': really_probe: probing driver button with device PNP0C0C:00
> > [   16.074424] 
> > [   16.074424] RAX: 0000000000000000 RBX: ffffffffb96d6c20 RCX: 0000000000000000
> > [   16.074424] RDX: 0000000000000000 RSI: ffffffffb81171da RDI: 0000000000000001
> > [   16.126499] device: 'input0': device_add
> > [   16.074424] RBP: ffffffffb9603d28 R08: 0000000000000000 R09: 0000000000000001
> > [   16.074424] R10: 0000000000000000 R11: 0000000000000030 R12: ffffffffb961aa80
> > [   16.074424] R13: ffffffffb961b3f0 R14: 0000000000000000 R15: ffffffffb9758878
> > [   16.153763] PM: Adding info for No Bus:input0
> > [   16.074424] FS:  0000000000000000(0000) GS:ffff961b55c00000(0000) knlGS:0000000000000000
> > [   16.074424] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   16.166543] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> > [   16.074424] CR2: ffff961b5edff000 CR3: 00000000b1612001 CR4: 00000000001706f0
> > [   16.074424] Call Trace:
> > [   16.074424]  <TASK>
> > [   16.175153] device: 'wakeup15': device_add
> > [   16.074424]  lock_is_held_type+0x6f/0x130
> > [   16.186284]  rcu_read_lock_sched_held+0x4a/0x90
> > [   16.186284]  trace_rcu_dyntick+0x3a/0xe0
> > [   16.186284]  ct_kernel_enter.constprop.0+0x66/0xa0
> > [   16.186284]  ct_idle_exit+0xd/0x30
> > [   16.186284]  cpuidle_enter_state+0x28a/0x310  
> 
> I'm surprised because ct_cpuidle_exit() calls lockdep_hardirqs_off().
> And in fact we shouldn't even need to disable IRQS from
> ct_idle_exit() anymore because cpuidle_enter_state() already does it.
> 
> So I must be missing something...

Perhaps because ct_cpuidle_exit() does not exist in 6.2?

I'm guessing that needs to be backported?

a01353cf1896e ("cpuidle: Fix ct_idle_*() usage")

-- Steve


-- Steve
