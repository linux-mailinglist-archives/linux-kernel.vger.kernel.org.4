Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E141174F121
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjGKOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjGKOFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:05:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC068127;
        Tue, 11 Jul 2023 07:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AA3F61505;
        Tue, 11 Jul 2023 14:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09043C433C8;
        Tue, 11 Jul 2023 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689084349;
        bh=eQpT1Up302VIq5YjJenPPzwILjKJ/R7N7irZVDRMpYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiSXGJB1/DmuV2ZcN9TL2+Txp4Y1alpI18Lu71pbfaKPVBzndZB8adBT5eX91sOR4
         BOlQ/S615hLk2ClPyUrX0DM6z9+g8gz+5iwFhTa3dA/O+/Gvvx2v6aFbeR+oxvE0Uw
         vN56TttZ2+PBX1iM8t0CM5S9SWKytQOPvYmvHvlE=
Date:   Tue, 11 Jul 2023 16:05:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     quanyang.wang@windriver.com
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: etm3x: convert struct etm_drvdata's spinlock
 to raw_spinlock
Message-ID: <2023071134-mardi-lyricist-e5b0@gregkh>
References: <20230711070536.3944458-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711070536.3944458-1-quanyang.wang@windriver.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:05:36PM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> For PREEMPT_RT kernel, spinlock_t locks become sleepable. The functions
> etm_dying_cpu and etm_starting_cpu which call spin_lock/unlock run in
> an irq-disabled context, this will trigger the following calltrace:
> 
>     BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
>     in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 25, name: migration/1
>     preempt_count: 1, expected: 0
>     RCU nest depth: 0, expected: 0
>     1 lock held by migration/1/25:
>      #0: 82a7587c (&drvdata->spinlock){....}-{2:2}, at: etm_dying_cpu+0x28/0x54
>     Preemption disabled at:
>     [<801ec760>] cpu_stopper_thread+0x94/0x120
>     CPU: 1 PID: 25 Comm: migration/1 Not tainted 6.1.35-rt10-yocto-preempt-rt #30
>     Hardware name: Xilinx Zynq Platform
>     Stopper: multi_cpu_stop+0x0/0x174 <- __stop_cpus.constprop.0+0x48/0x88
>      unwind_backtrace from show_stack+0x18/0x1c
>      show_stack from dump_stack_lvl+0x58/0x70
>      dump_stack_lvl from __might_resched+0x14c/0x1c0
>      __might_resched from rt_spin_lock+0x4c/0x84
>      rt_spin_lock from etm_dying_cpu+0x28/0x54
>      etm_dying_cpu from cpuhp_invoke_callback+0x140/0x33c
>      cpuhp_invoke_callback from __cpuhp_invoke_callback_range+0xa4/0x104
>      __cpuhp_invoke_callback_range from take_cpu_down+0x7c/0xa8
>      take_cpu_down from multi_cpu_stop+0x15c/0x174
>      multi_cpu_stop from cpu_stopper_thread+0x9c/0x120
>      cpu_stopper_thread from smpboot_thread_fn+0x31c/0x360
>      smpboot_thread_fn from kthread+0x100/0x124
>      kthread from ret_from_fork+0x14/0x2c
> 
> Convert struct etm_drvdata's spinlock to raw_spinlock to fix it.

wait, why will a raw_spinlock fix this?  Why not fix the root problem
here, that of calling these locks inproperly in irq context?

How is changing to a raw_spinlock going to fix the above splat?

thanks,

greg k-h
