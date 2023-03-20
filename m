Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0278F6C1407
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjCTNw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCTNw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:52:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 738F3768B;
        Mon, 20 Mar 2023 06:52:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9FD5FEC;
        Mon, 20 Mar 2023 06:53:38 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED1F43F71E;
        Mon, 20 Mar 2023 06:52:52 -0700 (PDT)
Date:   Mon, 20 Mar 2023 13:52:47 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexey Klimov <alexey.klimov@linaro.org>
Cc:     peterz@infradead.org, draszik@google.com, peter.griffin@linaro.org,
        willmcvicker@google.com, mingo@kernel.org, ulf.hansson@linaro.org,
        tony@atomide.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        alim.akhtar@samsung.com, regressions@lists.linux.dev,
        avri.altman@wdc.com, bvanassche@acm.org, klimova@google.com
Subject: Re: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait()
 and slow-stuck reboots
Message-ID: <ZBhlL4tqSUi/c3qk@FVFF77S0Q05N.cambridge.arm.com>
References: <20230314230004.961993-1-alexey.klimov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314230004.961993-1-alexey.klimov@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:00:04PM +0000, Alexey Klimov wrote:
> #regzbot introduced: 0c5ffc3d7b15
> #regzbot title: CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait() and slow-stuck reboots
> 
> The upstream changes are being merged into android-mainline repo and at some
> point we started to observe kernel panics on reboot or long reboot times.

Where can I find the android-mainline repo, and which specific branch/commit
from that repo is being merged in?

> The merge commit is 1f2d9ffc7a5f Merge tag 'sched-core-2023-02-20' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.
> Before, the reboot usually took significantly less than 15 seconds and after merge the reboot time fall in the range of 60-100 seconds.
> At some point watchdog-like functionality or softdog start to worry about the system stuck somewhere nd panic the system.
> 
> The delay is found to be in device's ->shutdown() methods called from kernel_restart():
> void kernel_restart_prepare(char *cmd)
> {
> 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
> 	system_state = SYSTEM_RESTART;
> 	usermodehelper_disable();
> 	device_shutdown();	<---- here
> }
> 
> The driver in question is ufshcd and its ufshcd_wl_shutdown() shutdown method. It often blocks on scsi_device_quiesce() and upon manual checking it seems that it sleeps on blk_mq_freeze_queue_wait()/wait_event() in blk_freeze_queue():
> 
> scsi_device_quiesce(struct scsi_device *sdev)
> {
> 	...
> 	blk_mq_freeze_queue(q);
> 	...
> }
> 	||
> 	V
> void blk_freeze_queue(struct request_queue *q)
> {
> 	/*
> 	 * In the !blk_mq case we are only calling this to kill the
> 	 * q_usage_counter, otherwise this increases the freeze depth
> 	 * and waits for it to return to zero.  For this reason there is
> 	 * no blk_unfreeze_queue(), and blk_freeze_queue() is not
> 	 * exported to drivers as the only user for unfreeze is blk_mq.
> 	 */
> 	blk_freeze_queue_start(q);
> 	blk_mq_freeze_queue_wait(q);	<--- sleeps on wait_event() here
> }
> 
> Or in other words:
> 
> [   34.785050][    C4] sysrq: Show Blocked State
> [   34.785132][    C4] task:init            state:D stack:9680  pid:1     ppid:0      flags:0x04000008
> [   34.785301][    C4] Call trace:
> [   34.785360][    C4]  __switch_to+0x180/0x308
> [   34.785452][    C4]  __schedule+0x61c/0x9f0
> [   34.785530][    C4]  schedule+0x84/0xf4
> [   34.785602][    C4]  blk_mq_freeze_queue_wait+0x78/0xbc
> [   34.785707][    C4]  blk_freeze_queue+0x74/0x8c
> [   34.785850][    C4]  blk_mq_freeze_queue+0x18/0x2c
> [   34.786033][    C4]  scsi_device_quiesce+0x54/0xec
> [   34.786216][    C4]  ufshcd_wl_shutdown+0x98/0xc0
> [   34.786396][    C4]  device_shutdown+0x1a8/0x264
> [   34.786572][    C4]  kernel_restart+0x48/0x11c
> [   34.786742][    C4]  __arm64_sys_reboot+0x1a8/0x27c
> [   34.786927][    C4]  invoke_syscall+0x60/0x130
> [   34.787096][    C4]  el0_svc_common+0xbc/0x100
> [   34.787266][    C4]  do_el0_svc+0x38/0xc4
> [   34.787420][    C4]  el0_svc+0x34/0xc4
> [   34.787563][    C4]  el0t_64_sync_handler+0x8c/0xfc
> [   34.787749][    C4]  el0t_64_sync+0x1a4/0x1a8
> 
> 
> However, bisect pointed to 0c5ffc3d7b15 cpuidle, dt: Push RCU-idle into driver
> 
> ->BAD 924aed1646bf cpuidle, cpu_pm: Remove RCU fiddling from cpu_pm_{enter,exit}()
> ->BAD a01353cf1896 cpuidle: Fix ct_idle_*() usage
> ->BAD (doesn't compile, needs one missing header file) 0c5ffc3d7b15 cpuidle, dt: Push RCU-idle into driver
> ->good c3d42418dca5 cpuidle, OMAP4: Push RCU-idle into driver
> 
> Looks like adding CPUIDLE_FLAG_RCU_IDLE flag to idle driver caused this behaviour.
> The minimal change that is required for this system to avoid the regression
> would be one liner that removes the flag (below).
> 
> But if it is a real regression, then other idle drivers if used will likely
> cause this regression too withe same ufshcd driver. There is also a suspicion
> that CPUIDLE_FLAG_RCU_IDLE just revealed or uncovered some other problem.
> 
> Any thoughts on this? Some missing __cpuidle or noinstr annotations?

As Peter has suggested in another reply, this might not be an *upstream*
regression, but rather an interaction with those out-of-tree patches. If you
can provide a pointer to the branch above that, it'll make it much easier to
figure out what's going on.

The code in mainline is unfortunately convoluted, but it doesn't look to be
obviously wrong.

FWIW, I've just tried v6.3-rc3 on Juno R2 in a few configurations (ACPI, DT,
with PROVE_LOCKING=y and DEBUG_LOCKDEP=y, with PSCI_CHECKER=y) and I'm not
seeing similar issues. So either I'm not tickling the same code path, or
something else is involved.

Thanks,
Mark.
