Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDDB6D41F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjDCK0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjDCK0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF99FB770
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F56A60B5F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B2EC433EF;
        Mon,  3 Apr 2023 10:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680517590;
        bh=MhlRGCvX3KgilKlmvbMbusJqaUk+wppIWs8KSSwxG+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3mvjVY6O3NlogVMp7Ouurp251Gvh2TGtFi7hLqZu0XkTopzHYEY3DbCjdSi0XwHH
         +LivAfHnQV+Bc6C9/OgcHsr0pDHrRrrDbEpn+zN7GqeghvEiMxmuiXfkGTtXw9sl1n
         RoCMDy2oYZTzUN4OPHoV+d6BKOemG/mLja8zc+cjUj7dFuZXiZPot18+lFnkLKcdhU
         OSZoZdYF/22rf/IIWla/hGKqRxSeipkbzYwNpFWx1h248+0AUhzzYJReRjLcXYQvpC
         dARVO8E1bmwg0yhUKGf6Z5qvFQcZz2mMqT+ikdc3tAAB5Y8nZuPpBK2Pvz3+PCQLtu
         tQVojwLeCk9Pg==
Date:   Mon, 3 Apr 2023 12:26:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Victor Hassan <victor@allwinnertech.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Message-ID: <ZCqp02hiCell/5AR@lothringen>
References: <20230328063629.108510-1-victor@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328063629.108510-1-victor@allwinnertech.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:36:29PM +0800, Victor Hassan wrote:
> If a broadcast timer is registered after the system switched to oneshot
> mode, a hang_task err could occur like that:
> 
> INFO: task kworker/u15:0:7 blocked for more than 120 seconds.
>       Tainted: G            E     5.15.41-android13-8-00002-xxx #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u16:0   state:D stack: 9808 pid:  7 ppid: 2 flags:0x00000008
> Workqueue: events_unbound deferred_probe_work_func.cfi_jt
> Call trace:
>  __switch_to+0y240/0x490
>  __schedule+0x620/0xafc
>  schedule+0x110/0x204
>  schedule_hrtimeout_range_clock+0x9c/0x118
>  usleep_range_state+0x150/0x1ac
>  _regulator_do_enable+0x528/0x878
>  set_machine_constraints+0x6a0/0xf2c
>  regulator_register+0x3ac/0x7ac
>  devm_regulator_register+0xbc/0x120
>  pmu_ext_regulator_probe+0xb0/0x1b4 [pmu_ext_regulator]
>  platform_probe+0x70/0x194
>  really_proe+0x320/0x68c
>  __driver_probe_device+0x204/0x260
>  driver_probe_device+0x48/0x1e0
> 
> When the new broadcast timer was registered after the system switched
> to oneshot mode, the broadcast timer was not used as periodic. If the
> oneshot mask was set incorrectly, all cores which did not enter cpu_idle
> state can't enter cpu_idle normally, causing the hrtimer mechanism to
> break.
> 
> This patch fixes the issue by moving the update action about oneshot
> mask to a more strict conditions. The tick_broadcast_setup_oneshot would
> be called in two typical condition, and they all will work.
> 
> 1. tick_handle_periodic -> tick_broadcast_setup_oneshot
> 
> The origin broadcast was periodic, so it can set the oneshot_mask bits
> for those waiting for periodic broadcast and program the broadcast timer
> to fire.
> 
> 2. tick_install_broadcast_device -> tick_broadcast_setup_oneshot
> 
> The origin broadcast was oneshot, so the cores which enter the cpu_idle
> already used the oneshot_mask bits. It is unnecessary to update the
> oneshot_mask.
> 
> Fixes: 9c336c9935cf ("tick/broadcast: Allow late registered device to enter oneshot mode")
> 
> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
> ---
>  kernel/time/tick-broadcast.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index 93bf2b4e47e5..fdbbba487978 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -1041,12 +1041,13 @@ static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
>  		 */
>  		cpumask_copy(tmpmask, tick_broadcast_mask);
>  		cpumask_clear_cpu(cpu, tmpmask);
> -		cpumask_or(tick_broadcast_oneshot_mask,
> -			   tick_broadcast_oneshot_mask, tmpmask);
>  
>  		if (was_periodic && !cpumask_empty(tmpmask)) {
>  			ktime_t nextevt = tick_get_next_period();
>  
> +			cpumask_or(tick_broadcast_oneshot_mask,
> +				   tick_broadcast_oneshot_mask, tmpmask);
> +

Good catch, it looks like one issue that can trigger is due to the resulting
ignored calls to tick_broadcast_exit(). Indeed if the cpu is already in
tick_broadcast_oneshot_mask then cpuidle won't call the exit.

Leading to such race:

* CPU 1 stop its tick, next event is in one hour
* CPU 0 registers new broadcast and sets CPU 1 in tick_broadcast_oneshot_mask
* CPU 1 runs into cpuidle_enter_state(), and tick_broadcast_enter() is ignored because
  the CPU is already in tick_broadcast_oneshot_mask
* CPU 1 goes to sleep
* CPU 0 runs the broadcast callback, sees that the next timer for CPU 1
  is in one hour, program the broadcast to that deadline
* CPU 1 gets an interrupt that enqueues a new timer expiring in the next jiffy
* CPU 1 don't call tick_broadcast_exit and thus don't remove itself from
  tick_broadcast_oneshot_mask
* CPU 1 re-enters in cpuidle_enter_state(), tick_broadcast_enter() is again
  ignored so the new timer isn't propagated to the broadcast.
* CPU 1 goes to sleep and won't be woken before one hour.


  Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


Thanks.




>  			clockevents_switch_state(bc, CLOCK_EVT_STATE_ONESHOT);
>  			tick_broadcast_init_next_event(tmpmask, nextevt);
>  			tick_broadcast_set_event(bc, cpu, nextevt);
> -- 
> 2.29.0
> 
