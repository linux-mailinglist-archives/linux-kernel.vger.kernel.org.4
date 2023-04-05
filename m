Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210346D8A80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjDEWTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDEWTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F44198
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BED660B7D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 22:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7780DC433EF;
        Wed,  5 Apr 2023 22:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680733147;
        bh=zxlxo3iaQar70FgikF4NesdHyAsl+yJXkfdyIFnQO0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rV6TNkslixcDe6NTcITSlqeLRRi8Fr4OS11j1YU1QisFCbyFz2OZlRspHGw5udH0C
         ZE6qvDfgb2s3wAPLdCSbPmaB4T5Gj0Nb8E42KwYU+QnmswY7TfkOtX3Cj2zLz59VJQ
         QSw/ffucnEmy0tPoSNXwPRBrVcVwPUsv7/Yek/DZN0kEtAoC8cYp4PJzmC7kM0LHqz
         ngYHxYGyRVL65rfxrAoyFtthZ7NXDYH+j980f/ilB6e6rAGxpMGWh/iiM2WxU41Uzb
         OuT7KKAOBMQOCydPDn+nsR7KM1BaXyIWRQXZZYUa8+ZKxhRwrw1ZdJxEXQRCqAvBrm
         Nd+Es+dYtTlCw==
Date:   Thu, 6 Apr 2023 00:19:05 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in timer_wait_running
Message-ID: <ZC3z2UhQeXENKvrb@lothringen>
References: <000000000000566d5405ae2f6f70@google.com>
 <ZC3jDC6R/SGLk5vj@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC3jDC6R/SGLk5vj@elver.google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 11:07:24PM +0200, Marco Elver wrote:
> Up-to-date warning:
> 
>  | WARNING: CPU: 1 PID: 6695 at kernel/time/posix-timers.c:849 timer_wait_running+0x255/0x290 kernel/time/posix-timers.c:849
>  | Modules linked in:
>  | CPU: 1 PID: 6695 Comm: syz-executor.3 Not tainted 6.3.0-rc3-syzkaller-00338-gda8e7da11e4b #0
>  | Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
>  | RIP: 0010:timer_wait_running+0x255/0x290 kernel/time/posix-timers.c:849
>  | Code: 00 48 c7 c2 80 fe 4e 8a be 06 03 00 00 48 c7 c7 e0 fe 4e 8a c6 05 63 cb ed 0c 01 e8 85 77 ef ff e9 5b fe ff ff e8 2b 7d 0e 00 <0f> 0b e9 b2 fe ff ff e8 0f 8a 5f 00 e9 fe fd ff ff e8 25 8a 5f 00
>  | RSP: 0018:ffffc90003ecfd50 EFLAGS: 00010293
>  | RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>  | RDX: ffff888020e4ba80 RSI: ffffffff81746785 RDI: ffffffff8a4f0ad8
>  | RBP: ffff88807c696d38 R08: 0000000000000001 R09: 0000000000000001
>  | R10: fffffbfff1cef98a R11: 0000000000000021 R12: ffffc90003ecfdb0
>  | R13: 0000000000000000 R14: ffffffff8a4f0a60 R15: ffffc90003ecfdb0
>  | FS:  00007fae387fe700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
>  | CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  | CR2: 00007f0d105821b8 CR3: 000000002a283000 CR4: 00000000003526e0
>  | DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  | DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  | Call Trace:
>  |  <TASK>
>  |  do_timer_settime.part.0+0x119/0x1d0 kernel/time/posix-timers.c:929
>  |  do_timer_settime kernel/time/posix-timers.c:938 [inline]
>  |  __do_sys_timer_settime kernel/time/posix-timers.c:952 [inline]
>  |  __se_sys_timer_settime kernel/time/posix-timers.c:938 [inline]
>  |  __x64_sys_timer_settime+0x21d/0x310 kernel/time/posix-timers.c:938
>  |  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  |  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  |  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  | RIP: 0033:0x7fae3948c0f9
>  | Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>  | RSP: 002b:00007fae387fe168 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
>  | RAX: ffffffffffffffda RBX: 00007fae395ac050 RCX: 00007fae3948c0f9
>  | RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000000
>  | RBP: 00007fae394e7b39 R08: 0000000000000000 R09: 0000000000000000
>  | R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>  | R13: 00007fae396cfb1f R14: 00007fae387fe300 R15: 0000000000022000
>  |  </TASK>
> 
> I've seen this warning in the wild recently, and it's been around since
> 2020 according to syzbot.
> 
> The warning was added in ec8f954a40da8 ("posix-timers: Use a callback
> for cancel synchronization on PREEMPT_RT").
> 
> Why is it wrong for timer_wait_running to be NULL?

It appears to concern clock_posix_cpu which indeed doesn't implement
->timer_wait_running even though posix_cpu_timer_set() might return
TIMER_RETRY if the timer is about to fire.

Then on RT and if CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y then
timer_wait_running() must busy loop waiting for the task to complete
the task work.

We could arrange for doing the same thing as hrtimer_cancel_wait_running()
but for posix cpu timers, with taking a similar lock within
handle_posix_cpu_timers() that timer_wait_running() could sleep on and
inject its PI into.

Thomas, Anna-Maria, would that make sense?

Thanks.
