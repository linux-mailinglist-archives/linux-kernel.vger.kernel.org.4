Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EF9652B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 03:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiLUCwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 21:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUCwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:52:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E951A280;
        Tue, 20 Dec 2022 18:52:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7685B61698;
        Wed, 21 Dec 2022 02:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A91FC433D2;
        Wed, 21 Dec 2022 02:52:39 +0000 (UTC)
Date:   Tue, 20 Dec 2022 21:52:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-doc@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH v3 3/3] kexec: Introduce parameters load_limit_reboot
 and load_limit_panic
Message-ID: <20221220215237.7efc96b8@gandalf.local.home>
In-Reply-To: <CANiDSCtgkQKUN6BtCsYc1Yn5UxwsFsCnMrraxpjjpXEErhUyhA@mail.gmail.com>
References: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
        <20221114-disable-kexec-reset-v3-3-4ef4e929adf6@chromium.org>
        <20221220192208.4d0c934f@gandalf.local.home>
        <CANiDSCtgkQKUN6BtCsYc1Yn5UxwsFsCnMrraxpjjpXEErhUyhA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2022 02:22:57 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> > > +     kexec_core.load_limit_reboot=
> > > +     kexec_core.load_limit_panic=
> > > +                     [KNL]
> > > +                     This parameter specifies a limit to the number of times
> > > +                     a kexec kernel can be loaded.
> > > +                     Format: <int>
> > > +                     -1  = Unlimited.
> > > +                     int = Number of times kexec can be called.
> > > +
> > > +                     During runtime, this parameter can be modified with a  
> >  
> > > +                     value smaller than the current one (but not -1).  
> >
> > Perhaps state:
> >                         smaller positive value than the current one or if
> >                         current is currently -1.  
> 
> I find it a bit complicated..
> What about:
> 
>  During runtime this parameter can be modified with a more restrictive value

Sure. That's better than the original.


> > > +module_param_cb(load_limit_reboot, &load_limit_ops, &load_limit_reboot, 0644);
> > > +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec reboot kernel");
> > > +
> > > +module_param_cb(load_limit_panic, &load_limit_ops, &load_limit_panic, 0644);
> > > +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec panic kernel");  
> >
> > Wait, why the module params if this can not be a module?
> >
> > The kernel/kexec.c is decided via CONFIG_KEXEC_CORE which is bool. Either
> > builtin or not at all. No module selection possible.
> >
> > For kernel parameters, we should just use __setup(), right?  
> 
> Isn't __setup() only kernel parameter and then it cannot be updated on runtime?

Yes, but then we use sysctl.

> 
> What about using late_param_cb? and remove MODULE_PARAM_DESC ?
> 
> I think this is how these parameters work
> 
> $ ls /sys/module/kernel/parameters/
> consoleblank  crash_kexec_post_notifiers  ignore_rlimit_data
> initcall_debug  module_blacklist  panic  panic_on_warn  panic_print
> pause_on_oops

Well, I think those are more leftovers and not something we want to add to.

I believe sysctl is the better option, and a more common one:

$ ls /proc/sys/kernel/
acct                           perf_event_max_contexts_per_stack
acpi_video_flags               perf_event_max_sample_rate
auto_msgmni                    perf_event_max_stack
bootloader_type                perf_event_mlock_kb
bootloader_version             perf_event_paranoid
bpf_stats_enabled              pid_max
cad_pid                        poweroff_cmd
cap_last_cap                   print-fatal-signals
core_pattern                   printk
core_pipe_limit                printk_delay
core_uses_pid                  printk_devkmsg
ctrl-alt-del                   printk_ratelimit
dmesg_restrict                 printk_ratelimit_burst
domainname                     pty
firmware_config                random
ftrace_dump_on_oops            randomize_va_space
ftrace_enabled                 real-root-dev
hardlockup_all_cpu_backtrace   sched_autogroup_enabled
hardlockup_panic               sched_child_runs_first
hostname                       sched_deadline_period_max_us
hotplug                        sched_deadline_period_min_us
hung_task_all_cpu_backtrace    sched_energy_aware
hung_task_check_count          sched_rr_timeslice_ms
hung_task_check_interval_secs  sched_rt_period_us
hung_task_panic                sched_rt_runtime_us
hung_task_timeout_secs         sched_util_clamp_max
hung_task_warnings             sched_util_clamp_min
io_delay_type                  sched_util_clamp_min_rt_default
kexec_load_disabled            seccomp
keys                           sem
kptr_restrict                  sem_next_id
max_lock_depth                 shmall
max_rcu_stall_to_panic         shmmax
modprobe                       shmmni
modules_disabled               shm_next_id
msgmax                         shm_rmid_forced
msgmnb                         softlockup_all_cpu_backtrace
msgmni                         softlockup_panic
msg_next_id                    soft_watchdog
ngroups_max                    stack_tracer_enabled
nmi_watchdog                   sysctl_writes_strict
ns_last_pid                    sysrq
numa_balancing                 tainted
oops_all_cpu_backtrace         task_delayacct
osrelease                      threads-max
ostype                         timer_migration
overflowgid                    traceoff_on_warning
overflowuid                    tracepoint_printk
panic                          unknown_nmi_panic
panic_on_io_nmi                unprivileged_bpf_disabled
panic_on_oops                  usermodehelper
panic_on_rcu_stall             version
panic_on_unrecovered_nmi       watchdog
panic_on_warn                  watchdog_cpumask
panic_print                    watchdog_thresh
perf_cpu_time_max_percent      yama



> I could pass the flags and then check for flags & (KEXEC_ON_CRASH |
> KEXEC_FILE_ON_CRASH)... but not sure if it is better

It keeps the processing in a single place, which helps avoid bugs like this.

-- Steve
