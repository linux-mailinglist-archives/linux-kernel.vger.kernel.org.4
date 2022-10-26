Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563BB60DEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiJZKcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJZKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:32:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40C7A286D;
        Wed, 26 Oct 2022 03:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666780357; x=1698316357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l0wUVBEnhXZ6fRlPL3Q2Z/5X5anQUewU9kTtEHEvwhQ=;
  b=J/Y0poWeDLC9BSqM7XRgbQeYdcCrSlw7Tlq+CcJhDBtJH1efth0f6f48
   CfLLlVw0Fu4/ef+jNUyhp0dLruod3u5o2dB8hQj5fy0FcHRtkeKp4ssxW
   vO53tMadfivzmjLugksilQCJR1VAxhb3Lpf6AWLyOivJhN0ghsc99CI/0
   bRuAUs2U4ZVIGA6r8GNeyozz02FLXZwMGW5yzsITZTkoZ2B1W7DG99KC8
   Oxl6Uazdf8SF5mgruYoMk7arbs1ce9cJnGP4BLOXCdvkn8gp7IlLJcAze
   2lWZRmROx7Rw5ABgfkPOkr+DtqfhOlIh/iQ2cSymyQiYG07osuIOjO4I/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="306642317"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="306642317"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 03:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="634440985"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="634440985"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by fmsmga007.fm.intel.com with SMTP; 26 Oct 2022 03:32:32 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 26 Oct 2022 13:32:31 +0300
Date:   Wed, 26 Oct 2022 13:32:31 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <Y1kMv1GpKwOSIt8f@intel.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114649.055452969@infradead.org>
 <Y1LVYaPCCP3BBS4g@intel.com>
 <Y1drd2gzxUJWdz5F@intel.com>
 <Y1e/Kd+1UQqeSwzY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1e/Kd+1UQqeSwzY@hirez.programming.kicks-ass.net>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:49:13PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 25, 2022 at 07:52:07AM +0300, Ville Syrjälä wrote:
> > On Fri, Oct 21, 2022 at 08:22:41PM +0300, Ville Syrjälä wrote:
> > > On Mon, Aug 22, 2022 at 01:18:22PM +0200, Peter Zijlstra wrote:
> > > > +#ifdef CONFIG_LOCKDEP
> > > > +	/*
> > > > +	 * It's dangerous to freeze with locks held; there be dragons there.
> > > > +	 */
> > > > +	if (!(state & __TASK_FREEZABLE_UNSAFE))
> > > > +		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> > > > +#endif
> > > 
> > > We now seem to be hitting this sporadically in the intel gfx CI.
> > > 
> > > I've spotted it on two machines so far:
> > > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12270/shard-tglb7/igt@gem_ctx_isolation@preservation-s3@vcs0.html
> > > https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_109950v1/shard-snb5/igt@kms_flip@flip-vs-suspend-interruptible@a-vga1.html
> > 
> > Sadly no luck in reproducing this locally so far. In the meantime
> > I added the following patch into our topic/core-for-CI branch in
> > the hopes of CI stumbling on it again and dumping a bit more data:
> > 
> > --- a/kernel/freezer.c
> > +++ b/kernel/freezer.c
> > @@ -125,8 +125,16 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
> >  	/*
> >  	 * It's dangerous to freeze with locks held; there be dragons there.
> >  	 */
> > -	if (!(state & __TASK_FREEZABLE_UNSAFE))
> > -		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> > +	if (!(state & __TASK_FREEZABLE_UNSAFE)) {
> > +		static bool warned = false;
> > +
> > +		if (!warned && debug_locks && p->lockdep_depth) {
> > +			debug_show_held_locks(p);
> > +			WARN(1, "%s/%d holding locks while freezing\n",
> > +			     p->comm, task_pid_nr(p));
> > +			warned = true;
> > +		}
> > +	}
> >  #endif
> >  
> >  	WRITE_ONCE(p->__state, TASK_FROZEN);
> 
> That seems reasonable. But note that this constraint isn't new; the
> previous freezer had much the same constraint but perhaps it wasn't
> triggered for mysterious raisins. see the previous
> try_to_freeze_unsafe() function.

Looks like we caught one with the extra debugs now.

Short form looks to be this:
<4>[  355.437846] 1 lock held by rs:main Q:Reg/359:
<4>[  355.438418]  #0: ffff88844693b758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x1b/0x30
<4>[  355.438432] rs:main Q:Reg/359 holding locks while freezing

Based on a quick google that process seems to be some rsyslog thing.


Here's the full splat with the console_lock mess included:
<6>[  355.437502] Freezing user space processes ... 
<4>[  355.437846] 1 lock held by rs:main Q:Reg/359:

<4>[  355.437865] ======================================================
<4>[  355.437866] WARNING: possible circular locking dependency detected
<4>[  355.437867] 6.1.0-rc2-CI_DRM_12295-g3844a56a0922+ #1 Tainted: G     U            
<4>[  355.437870] ------------------------------------------------------
<4>[  355.437871] rtcwake/6211 is trying to acquire lock:
<4>[  355.437872] ffffffff82735198 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0xa/0x30
<4>[  355.437883] 
                  but task is already holding lock:
<4>[  355.437885] ffff88810d0908e0 (&p->pi_lock){-.-.}-{2:2}, at: task_call_func+0x34/0xe0
<4>[  355.437893] 
                  which lock already depends on the new lock.

<4>[  355.437894] 
                  the existing dependency chain (in reverse order) is:
<4>[  355.437895] 
                  -> #1 (&p->pi_lock){-.-.}-{2:2}:
<4>[  355.437899]        lock_acquire+0xd3/0x310
<4>[  355.437903]        _raw_spin_lock_irqsave+0x33/0x50
<4>[  355.437907]        try_to_wake_up+0x6b/0x610
<4>[  355.437911]        up+0x3b/0x50
<4>[  355.437914]        __up_console_sem+0x5c/0x70
<4>[  355.437917]        console_unlock+0x1bc/0x1d0
<4>[  355.437920]        con_font_op+0x2e2/0x3a0
<4>[  355.437925]        vt_ioctl+0x4f5/0x13b0
<4>[  355.437930]        tty_ioctl+0x233/0x8e0
<4>[  355.437934]        __x64_sys_ioctl+0x71/0xb0
<4>[  355.437938]        do_syscall_64+0x3a/0x90
<4>[  355.437943]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4>[  355.437948] 
                  -> #0 ((console_sem).lock){-.-.}-{2:2}:
<4>[  355.437952]        validate_chain+0xb3d/0x2000
<4>[  355.437955]        __lock_acquire+0x5a4/0xb70
<4>[  355.437958]        lock_acquire+0xd3/0x310
<4>[  355.437960]        _raw_spin_lock_irqsave+0x33/0x50
<4>[  355.437965]        down_trylock+0xa/0x30
<4>[  355.437968]        __down_trylock_console_sem+0x25/0xb0
<4>[  355.437971]        console_trylock+0xe/0x70
<4>[  355.437974]        vprintk_emit+0x13c/0x380
<4>[  355.437977]        _printk+0x53/0x6e
<4>[  355.437981]        lockdep_print_held_locks+0x5c/0xab
<4>[  355.437985]        __set_task_frozen+0x6d/0xb0
<4>[  355.437989]        task_call_func+0xc4/0xe0
<4>[  355.437993]        freeze_task+0x84/0xe0
<4>[  355.437997]        try_to_freeze_tasks+0xac/0x260
<4>[  355.438001]        freeze_processes+0x56/0xb0
<4>[  355.438005]        pm_suspend.cold.7+0x1d9/0x31c
<4>[  355.438008]        state_store+0x7b/0xe0
<4>[  355.438012]        kernfs_fop_write_iter+0x124/0x1c0
<4>[  355.438016]        vfs_write+0x34f/0x4e0
<4>[  355.438021]        ksys_write+0x57/0xd0
<4>[  355.438025]        do_syscall_64+0x3a/0x90
<4>[  355.438029]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4>[  355.438034] 
                  other info that might help us debug this:

<4>[  355.438035]  Possible unsafe locking scenario:

<4>[  355.438036]        CPU0                    CPU1
<4>[  355.438037]        ----                    ----
<4>[  355.438037]   lock(&p->pi_lock);
<4>[  355.438040]                                lock((console_sem).lock);
<4>[  355.438042]                                lock(&p->pi_lock);
<4>[  355.438044]   lock((console_sem).lock);
<4>[  355.438046] 
                   *** DEADLOCK ***

<4>[  355.438047] 7 locks held by rtcwake/6211:
<4>[  355.438049]  #0: ffff888104d11430 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x57/0xd0
<4>[  355.438058]  #1: ffff88810e6bac88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xee/0x1c0
<4>[  355.438066]  #2: ffff8881001c0538 (kn->active#167){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xf7/0x1c0
<4>[  355.438074]  #3: ffffffff8264db08 (system_transition_mutex){+.+.}-{3:3}, at: pm_suspend.cold.7+0xfa/0x31c
<4>[  355.438082]  #4: ffffffff82606098 (tasklist_lock){.+.+}-{2:2}, at: try_to_freeze_tasks+0x63/0x260
<4>[  355.438090]  #5: ffffffff8273aed8 (freezer_lock){....}-{2:2}, at: freeze_task+0x27/0xe0
<4>[  355.438098]  #6: ffff88810d0908e0 (&p->pi_lock){-.-.}-{2:2}, at: task_call_func+0x34/0xe0
<4>[  355.438105] 
                  stack backtrace:
<4>[  355.438107] CPU: 0 PID: 6211 Comm: rtcwake Tainted: G     U             6.1.0-rc2-CI_DRM_12295-g3844a56a0922+ #1
<4>[  355.438110] Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0385.2020.0519.1558 05/19/2020
<4>[  355.438112] Call Trace:
<4>[  355.438114]  <TASK>
<4>[  355.438116]  dump_stack_lvl+0x56/0x7f
<4>[  355.438121]  check_noncircular+0x132/0x150
<4>[  355.438125]  ? validate_chain+0x247/0x2000
<4>[  355.438131]  validate_chain+0xb3d/0x2000
<4>[  355.438138]  __lock_acquire+0x5a4/0xb70
<4>[  355.438144]  lock_acquire+0xd3/0x310
<4>[  355.438147]  ? down_trylock+0xa/0x30
<4>[  355.438154]  ? vprintk_emit+0x13c/0x380
<4>[  355.438158]  _raw_spin_lock_irqsave+0x33/0x50
<4>[  355.438163]  ? down_trylock+0xa/0x30
<4>[  355.438167]  down_trylock+0xa/0x30
<4>[  355.438171]  __down_trylock_console_sem+0x25/0xb0
<4>[  355.438175]  console_trylock+0xe/0x70
<4>[  355.438178]  vprintk_emit+0x13c/0x380
<4>[  355.438183]  ? __set_task_special+0x40/0x40
<4>[  355.438187]  _printk+0x53/0x6e
<4>[  355.438195]  lockdep_print_held_locks+0x5c/0xab
<4>[  355.438199]  ? __set_task_special+0x40/0x40
<4>[  355.438203]  __set_task_frozen+0x6d/0xb0
<4>[  355.438208]  task_call_func+0xc4/0xe0
<4>[  355.438214]  freeze_task+0x84/0xe0
<4>[  355.438219]  try_to_freeze_tasks+0xac/0x260
<4>[  355.438226]  freeze_processes+0x56/0xb0
<4>[  355.438230]  pm_suspend.cold.7+0x1d9/0x31c
<4>[  355.438235]  state_store+0x7b/0xe0
<4>[  355.438241]  kernfs_fop_write_iter+0x124/0x1c0
<4>[  355.438247]  vfs_write+0x34f/0x4e0
<4>[  355.438255]  ksys_write+0x57/0xd0
<4>[  355.438261]  do_syscall_64+0x3a/0x90
<4>[  355.438266]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4>[  355.438271] RIP: 0033:0x7fcfa44d80a7
<4>[  355.438275] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
<4>[  355.438278] RSP: 002b:00007ffd72160e28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
<4>[  355.438281] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007fcfa44d80a7
<4>[  355.438284] RDX: 0000000000000007 RSI: 000055dd45bf4590 RDI: 000000000000000b
<4>[  355.438286] RBP: 000055dd45bf4590 R08: 0000000000000000 R09: 0000000000000007
<4>[  355.438288] R10: 000055dd441d22a6 R11: 0000000000000246 R12: 0000000000000007
<4>[  355.438290] R13: 000055dd45bf2540 R14: 00007fcfa45b34a0 R15: 00007fcfa45b28a0
<4>[  355.438298]  </TASK>
<4>[  355.438418]  #0: ffff88844693b758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x1b/0x30
<4>[  355.438429] ------------[ cut here ]------------
<4>[  355.438432] rs:main Q:Reg/359 holding locks while freezing
<4>[  355.438439] WARNING: CPU: 0 PID: 6211 at kernel/freezer.c:134 __set_task_frozen+0x86/0xb0
<4>[  355.438447] Modules linked in: snd_hda_intel i915 mei_hdcp mei_pxp drm_display_helper drm_kms_helper vgem drm_shmem_helper snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_pcm prime_numbers ttm drm_buddy syscopyarea sysfillrect sysimgblt fb_sys_fops fuse x86_pkg_temp_thermal coretemp kvm_intel btusb btrtl btbcm btintel kvm irqbypass bluetooth crct10dif_pclmul crc32_pclmul ecdh_generic ghash_clmulni_intel ecc e1000e mei_me i2c_i801 ptp mei i2c_smbus pps_core lpc_ich video wmi [last unloaded: drm_kms_helper]
<4>[  355.438521] CPU: 0 PID: 6211 Comm: rtcwake Tainted: G     U             6.1.0-rc2-CI_DRM_12295-g3844a56a0922+ #1
<4>[  355.438526] Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0385.2020.0519.1558 05/19/2020
<4>[  355.438530] RIP: 0010:__set_task_frozen+0x86/0xb0
<4>[  355.438536] Code: 83 60 09 00 00 85 c0 74 2a 48 89 df e8 ac 02 9b 00 8b 93 38 05 00 00 48 8d b3 48 07 00 00 48 c7 c7 a0 62 2b 82 e8 ee c1 9a 00 <0f> 0b c6 05 51 75 e3 02 01 c7 43 18 00 80 00 00 b8 00 80 00 00 5b
<4>[  355.438541] RSP: 0018:ffffc900012cbcf0 EFLAGS: 00010086
<4>[  355.438546] RAX: 0000000000000000 RBX: ffff88810d090040 RCX: 0000000000000004
<4>[  355.438550] RDX: 0000000000000004 RSI: 00000000fffff5de RDI: 00000000ffffffff
<4>[  355.438553] RBP: 0000000000000000 R08: 0000000000000000 R09: c0000000fffff5de
<4>[  355.438557] R10: 00000000002335f8 R11: ffffc900012cbb88 R12: 0000000000000246
<4>[  355.438561] R13: ffffffff81165430 R14: 0000000000000000 R15: ffff88810d090040
<4>[  355.438565] FS:  00007fcfa43c7740(0000) GS:ffff888446800000(0000) knlGS:0000000000000000
<4>[  355.438569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  355.438582] CR2: 00007fceb380f6b8 CR3: 0000000117c5c004 CR4: 00000000003706f0
<4>[  355.438586] Call Trace:
<4>[  355.438589]  <TASK>
<4>[  355.438592]  task_call_func+0xc4/0xe0
<4>[  355.438600]  freeze_task+0x84/0xe0
<4>[  355.438607]  try_to_freeze_tasks+0xac/0x260
<4>[  355.438616]  freeze_processes+0x56/0xb0
<4>[  355.438622]  pm_suspend.cold.7+0x1d9/0x31c
<4>[  355.438629]  state_store+0x7b/0xe0
<4>[  355.438637]  kernfs_fop_write_iter+0x124/0x1c0
<4>[  355.438644]  vfs_write+0x34f/0x4e0
<4>[  355.438655]  ksys_write+0x57/0xd0
<4>[  355.438663]  do_syscall_64+0x3a/0x90
<4>[  355.438670]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4>[  355.438676] RIP: 0033:0x7fcfa44d80a7
<4>[  355.438681] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
<4>[  355.438685] RSP: 002b:00007ffd72160e28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
<4>[  355.438690] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007fcfa44d80a7
<4>[  355.438695] RDX: 0000000000000007 RSI: 000055dd45bf4590 RDI: 000000000000000b
<4>[  355.438698] RBP: 000055dd45bf4590 R08: 0000000000000000 R09: 0000000000000007
<4>[  355.438702] R10: 000055dd441d22a6 R11: 0000000000000246 R12: 0000000000000007
<4>[  355.438706] R13: 000055dd45bf2540 R14: 00007fcfa45b34a0 R15: 00007fcfa45b28a0
<4>[  355.438716]  </TASK>
<4>[  355.438718] irq event stamp: 7462
<4>[  355.438721] hardirqs last  enabled at (7461): [<ffffffff81b73764>] _raw_spin_unlock_irqrestore+0x54/0x70
<4>[  355.438729] hardirqs last disabled at (7462): [<ffffffff81b7350b>] _raw_spin_lock_irqsave+0x4b/0x50
<4>[  355.438736] softirqs last  enabled at (7322): [<ffffffff81e0031e>] __do_softirq+0x31e/0x48a
<4>[  355.438742] softirqs last disabled at (7313): [<ffffffff810c1b58>] irq_exit_rcu+0xb8/0xe0
<4>[  355.438749] ---[ end trace 0000000000000000 ]---
<4>[  355.440204] (elapsed 0.002 seconds) done.
<6>[  355.440210] OOM killer disabled.
<6>[  355.440212] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.

-- 
Ville Syrjälä
Intel
