Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9576E22B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDNL4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDNLz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:55:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E52AEA25D;
        Fri, 14 Apr 2023 04:55:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBB1F2F4;
        Fri, 14 Apr 2023 04:56:38 -0700 (PDT)
Received: from [10.57.19.162] (unknown [10.57.19.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2365E3F587;
        Fri, 14 Apr 2023 04:55:52 -0700 (PDT)
Message-ID: <9ee941ae-ae22-f14b-4e69-f81b29bbba4b@arm.com>
Date:   Fri, 14 Apr 2023 13:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [ANNOUNCE] v6.3-rc2-rt3
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230314170502.OHw1_FK3@linutronix.de>
 <20230314171231.jwtham4a@linutronix.de>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230314171231.jwtham4a@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sebastian,
The following appears between v6.3-rc2-rt2 and v6.3-rc2-rt3,
it is probably due to b111e33ae076 ("printk: Update John's printk series.")

=============================
[ BUG: Invalid wait context ]
6.3.0-rc5-rt8-gacb52bd349a2 #417 Not tainted
-----------------------------
swapper/0/1 is trying to lock:
ffff00097eea1180 (cpu){....}-{3:3}, at: __printk_safe_enter (kernel/printk/printk_safe.c:28 (discriminator 3))
other info that might help us debug this:
context-{5:5}
1 lock held by swapper/0/1:
#0: ffff80000ba77028 (rcu_tasks_rude.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic (kernel/rcu/tasks.h:233)
stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc5-rt8-gacb52bd349a2 #417
Hardware name: ARM Juno development board (r2) (DT)
Call trace:
dump_backtrace (arch/arm64/kernel/stacktrace.c:160)
show_stack (arch/arm64/kernel/stacktrace.c:167)
dump_stack_lvl (lib/dump_stack.c:107)
dump_stack (lib/dump_stack.c:114)
__lock_acquire (kernel/locking/lockdep.c:4710)
lock_acquire (./arch/arm64/include/asm/percpu.h:40)
__printk_safe_enter (./include/linux/local_lock_internal.h:30 (discriminator 3))
__down_trylock_console_sem (kernel/printk/printk.c:327)
console_trylock (kernel/printk/printk.c:2710 (discriminator 4))
vprintk_emit (kernel/printk/printk.c:1960)
vprintk_default (kernel/printk/printk.c:2367)
vprintk (kernel/printk/printk_safe.c:69)
_printk (kernel/printk/printk.c:2380)
cblist_init_generic (kernel/rcu/tasks.h:236)
rcu_init_tasks_generic (kernel/rcu/tasks.h:1142)
kernel_init_freeable (./arch/arm64/include/asm/jump_label.h:21)
kernel_init (init/main.c:1530)
ret_from_fork (arch/arm64/kernel/entry.S:871)

Regards,
Pierre

On 3/14/23 18:12, Sebastian Andrzej Siewior wrote:
> On 2023-03-14 18:05:04 [+0100], To Thomas Gleixner wrote:
>> Dear RT folks!
>>
>> I'm pleased to announce the v6.3-rc2-rt3 patch set.
>>
>> Changes since v6.3-rc2-rt2:
>>
>>    - The i915 and other driver using io_mapping_map_atomic_wc() function
>>      could deadlock. Reported by Richard Weinberger.
>>
>>    - A larger printk rework by John Ogness. This printk series is based
>>      on the latest work by John and most of the patches have been
>>      submitted for upstream review.
>>      As in the previous version the concept of an atomic console
>>      remained. That means a crash (BUG(), panic(), …) without a atomic
>>      console driver remains invisible on PREEMPT_RT. The only available
>>      atomic console driver is the 8250 UART and has been tested on X86.
>>
>> Known issues
>>       - Crystal Wood reported that a filesystem (XFS) may deadlock while
>>         flushing during schedule.
>>
>> The delta patch against v6.3-rc2-rt2 is appended below and can be found here:
>>   
>>       https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/incr/patch-6.3-rc2-rt2-rt3.patch.xz
>>
>> You can get this release via the git tree at:
>>
>>      git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.3-rc2-rt3
>>
>> The RT patch against v6.3-rc2 can be found here:
>>
>>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patch-6.3-rc2-rt3.patch.xz
>>
>> The split quilt queue is available at:
>>
>>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patches-6.3-rc2-rt3.tar.xz
> 
> This email didn't pass the size restriction on linux-rt-users@ so this
> is just a small ping that this release happened. The whole email is in
> the archive:
> 	https://lore.kernel.org/20230314170502.OHw1_FK3@linutronix.de
>   
> Sebastian
> 
