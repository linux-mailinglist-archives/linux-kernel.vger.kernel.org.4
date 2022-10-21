Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5261D607D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJURWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJURWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:22:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0DB1057ED;
        Fri, 21 Oct 2022 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666372967; x=1697908967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hiKQ3oIktklV1vHjiz+vB7ubyfgWLiWjIb8F6Hr86iY=;
  b=OlVICzGsVobQ1nhALeC+CbqrBoZMx/Y988VzSoDDpBn+lBRlrDL7WKTT
   tSbNMdKQMf2nsV7iz76aejKXRvFWw+FUkQ3iMhuHMcfw7HZRLeRSRHGAh
   eVbtH8eXwjUg71FnsHVUjKqLpTKmErY/v0J2Gj7BDzJ0bKZoPx77/zGh6
   26vlx/xWGO+zvgKMPFqjJKGT0aZEs41nUuXzvHdVT/HecAu++gy0GfHe7
   LSAK9Cwu7/8RWRVP/fL0SQVOfRW8NRiHrMLWBrIeI49Od1pFbhOEaUN45
   BzfWsf57bwkQCqRT14uD2mJ3xvoyC32SlP9X1gJb7Mwkpr8U2lnT+x4pI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308743773"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="308743773"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 10:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="699435925"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="699435925"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by fmsmga004.fm.intel.com with SMTP; 21 Oct 2022 10:22:42 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 21 Oct 2022 20:22:41 +0300
Date:   Fri, 21 Oct 2022 20:22:41 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <Y1LVYaPCCP3BBS4g@intel.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114649.055452969@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220822114649.055452969@infradead.org>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 01:18:22PM +0200, Peter Zijlstra wrote:
> +#ifdef CONFIG_LOCKDEP
> +	/*
> +	 * It's dangerous to freeze with locks held; there be dragons there.
> +	 */
> +	if (!(state & __TASK_FREEZABLE_UNSAFE))
> +		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> +#endif

We now seem to be hitting this sporadically in the intel gfx CI.

I've spotted it on two machines so far:
https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12270/shard-tglb7/igt@gem_ctx_isolation@preservation-s3@vcs0.html
https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_109950v1/shard-snb5/igt@kms_flip@flip-vs-suspend-interruptible@a-vga1.html

Here's the full splat. Looks a bit funny since the
WARN()->printk()->console_lock() itself trips lockdep:

<6>[   59.998117] PM: suspend entry (s2idle)
<6>[   59.999878] Filesystems sync: 0.001 seconds
<6>[   60.000881] Freezing user space processes ... 
<4>[   60.001059] ------------[ cut here ]------------
<4>[   60.001071] ======================================================
<4>[   60.001071] WARNING: possible circular locking dependency detected
<4>[   60.001072] 6.1.0-rc1-CI_DRM_12270-ga9d18ead9885+ #1 Not tainted
<4>[   60.001073] ------------------------------------------------------
<4>[   60.001073] rtcwake/1152 is trying to acquire lock:
<4>[   60.001074] ffffffff82735198 ((console_sem).lock){..-.}-{2:2}, at: down_trylock+0xa/0x30
<4>[   60.001082] 
                  but task is already holding lock:
<4>[   60.001082] ffff888111a708e0 (&p->pi_lock){-.-.}-{2:2}, at: task_call_func+0x34/0xe0
<4>[   60.001088] 
                  which lock already depends on the new lock.

<4>[   60.001089] 
                  the existing dependency chain (in reverse order) is:
<4>[   60.001089] 
                  -> #1 (&p->pi_lock){-.-.}-{2:2}:
<4>[   60.001091]        lock_acquire+0xd3/0x310
<4>[   60.001094]        _raw_spin_lock_irqsave+0x33/0x50
<4>[   60.001097]        try_to_wake_up+0x6b/0x610
<4>[   60.001098]        up+0x3b/0x50
<4>[   60.001099]        __up_console_sem+0x5c/0x70
<4>[   60.001102]        console_unlock+0x1bc/0x1d0
<4>[   60.001104]        do_con_write+0x654/0xa20
<4>[   60.001108]        con_write+0xa/0x20
<4>[   60.001110]        do_output_char+0x119/0x1e0
<4>[   60.001113]        n_tty_write+0x20f/0x490
<4>[   60.001114]        file_tty_write.isra.29+0x17d/0x320
<4>[   60.001117]        do_iter_readv_writev+0xdb/0x140
<4>[   60.001120]        do_iter_write+0x6c/0x1a0
<4>[   60.001121]        vfs_writev+0x97/0x290
<4>[   60.001123]        do_writev+0x63/0x110
<4>[   60.001125]        do_syscall_64+0x37/0x90
<4>[   60.001128]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4>[   60.001130] 
                  -> #0 ((console_sem).lock){..-.}-{2:2}:
<4>[   60.001131]        validate_chain+0xb3d/0x2000
<4>[   60.001132]        __lock_acquire+0x5a4/0xb70
<4>[   60.001133]        lock_acquire+0xd3/0x310
<4>[   60.001134]        _raw_spin_lock_irqsave+0x33/0x50
<4>[   60.001136]        down_trylock+0xa/0x30
<4>[   60.001137]        __down_trylock_console_sem+0x25/0xb0
<4>[   60.001139]        console_trylock+0xe/0x70
<4>[   60.001140]        vprintk_emit+0x13c/0x380
<4>[   60.001142]        _printk+0x53/0x6e
<4>[   60.001145]        report_bug.cold.2+0x10/0x52
<4>[   60.001147]        handle_bug+0x3f/0x70
<4>[   60.001148]        exc_invalid_op+0x13/0x60
<4>[   60.001150]        asm_exc_invalid_op+0x16/0x20
<4>[   60.001152]        __set_task_frozen+0x58/0x80
<4>[   60.001156]        task_call_func+0xc2/0xe0
<4>[   60.001157]        freeze_task+0x84/0xe0
<4>[   60.001159]        try_to_freeze_tasks+0xac/0x260
<4>[   60.001160]        freeze_processes+0x56/0xb0
<4>[   60.001162]        pm_suspend.cold.7+0x1d9/0x31c
<4>[   60.001164]        state_store+0x7b/0xe0
<4>[   60.001165]        kernfs_fop_write_iter+0x121/0x1c0
<4>[   60.001169]        vfs_write+0x34c/0x4e0
<4>[   60.001170]        ksys_write+0x57/0xd0
<4>[   60.001172]        do_syscall_64+0x37/0x90
<4>[   60.001174]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4>[   60.001176] 
                  other info that might help us debug this:

<4>[   60.001176]  Possible unsafe locking scenario:

<4>[   60.001176]        CPU0                    CPU1
<4>[   60.001176]        ----                    ----
<4>[   60.001177]   lock(&p->pi_lock);
<4>[   60.001177]                                lock((console_sem).lock);
<4>[   60.001178]                                lock(&p->pi_lock);
<4>[   60.001179]   lock((console_sem).lock);
<4>[   60.001179] 
                   *** DEADLOCK ***

<4>[   60.001180] 7 locks held by rtcwake/1152:
<4>[   60.001180]  #0: ffff888105e99430 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x57/0xd0
<4>[   60.001184]  #1: ffff88810a048288 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xee/0x1c0
<4>[   60.001191]  #2: ffff888100c58538 (kn->active#155){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xf7/0x1c0
<4>[   60.001194]  #3: ffffffff8264db08 (system_transition_mutex){+.+.}-{3:3}, at: pm_suspend.cold.7+0xfa/0x31c
<4>[   60.001197]  #4: ffffffff82606098 (tasklist_lock){.+.+}-{2:2}, at: try_to_freeze_tasks+0x63/0x260
<4>[   60.001201]  #5: ffffffff8273aed8 (freezer_lock){....}-{2:2}, at: freeze_task+0x27/0xe0
<4>[   60.001204]  #6: ffff888111a708e0 (&p->pi_lock){-.-.}-{2:2}, at: task_call_func+0x34/0xe0
<4>[   60.001207] 
                  stack backtrace:
<4>[   60.001207] CPU: 2 PID: 1152 Comm: rtcwake Not tainted 6.1.0-rc1-CI_DRM_12270-ga9d18ead9885+ #1
<4>[   60.001210] Hardware name: Intel Corporation Tiger Lake Client Platform/TigerLake U DDR4 SODIMM RVP, BIOS TGLSFWI1.R00.3197.A00.2005110542 05/11/2020
<4>[   60.001211] Call Trace:
<4>[   60.001211]  <TASK>
<4>[   60.001212]  dump_stack_lvl+0x56/0x7f
<4>[   60.001215]  check_noncircular+0x132/0x150
<4>[   60.001217]  validate_chain+0xb3d/0x2000
<4>[   60.001220]  __lock_acquire+0x5a4/0xb70
<4>[   60.001222]  lock_acquire+0xd3/0x310
<4>[   60.001223]  ? down_trylock+0xa/0x30
<4>[   60.001226]  ? vprintk_emit+0x13c/0x380
<4>[   60.001228]  _raw_spin_lock_irqsave+0x33/0x50
<4>[   60.001230]  ? down_trylock+0xa/0x30
<4>[   60.001231]  down_trylock+0xa/0x30
<4>[   60.001233]  __down_trylock_console_sem+0x25/0xb0
<4>[   60.001234]  console_trylock+0xe/0x70
<4>[   60.001235]  vprintk_emit+0x13c/0x380
<4>[   60.001237]  _printk+0x53/0x6e
<4>[   60.001240]  ? __set_task_frozen+0x58/0x80
<4>[   60.001241]  report_bug.cold.2+0x10/0x52
<4>[   60.001244]  handle_bug+0x3f/0x70
<4>[   60.001245]  exc_invalid_op+0x13/0x60
<4>[   60.001247]  asm_exc_invalid_op+0x16/0x20
<4>[   60.001250] RIP: 0010:__set_task_frozen+0x58/0x80
<4>[   60.001252] Code: f7 c5 00 20 00 00 74 06 40 f6 c5 03 74 3a 81 e5 00 40 00 00 75 16 8b 15 a2 b9 71 01 85 d2 74 0c 8b 83 60 09 00 00 85 c0 74 02 <0f> 0b c7 43 18 00 80 00 00 b8 00 80 00 00 5b 5d c3 cc cc cc cc 31
<4>[   60.001254] RSP: 0018:ffffc9000335fcf0 EFLAGS: 00010002
<4>[   60.001255] RAX: 0000000000000001 RBX: ffff888111a70040 RCX: 0000000000000000
<4>[   60.001256] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff888111a70040
<4>[   60.001257] RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000fffffffe
<4>[   60.001258] R10: 0000000001e6f6b9 R11: 00000000934a4c67 R12: 0000000000000246
<4>[   60.001259] R13: ffffffff811653e0 R14: 0000000000000000 R15: ffff888111a70040
<4>[   60.001260]  ? __set_task_special+0x40/0x40
<4>[   60.001263]  task_call_func+0xc2/0xe0
<4>[   60.001265]  freeze_task+0x84/0xe0
<4>[   60.001267]  try_to_freeze_tasks+0xac/0x260
<4>[   60.001270]  freeze_processes+0x56/0xb0
<4>[   60.001272]  pm_suspend.cold.7+0x1d9/0x31c
<4>[   60.001274]  state_store+0x7b/0xe0
<4>[   60.001276]  kernfs_fop_write_iter+0x121/0x1c0
<4>[   60.001278]  vfs_write+0x34c/0x4e0
<4>[   60.001281]  ksys_write+0x57/0xd0
<4>[   60.001284]  do_syscall_64+0x37/0x90
<4>[   60.001285]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4>[   60.001288] RIP: 0033:0x7fb4705521e7
<4>[   60.001289] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
<4>[   60.001290] RSP: 002b:00007ffe3efac3d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
<4>[   60.001291] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fb4705521e7
<4>[   60.001292] RDX: 0000000000000004 RSI: 0000559af7969590 RDI: 000000000000000b
<4>[   60.001293] RBP: 0000559af7969590 R08: 0000000000000000 R09: 0000000000000004
<4>[   60.001293] R10: 0000559af60922a6 R11: 0000000000000246 R12: 0000000000000004
<4>[   60.001294] R13: 0000559af7967540 R14: 00007fb47062e4a0 R15: 00007fb47062d8a0
<4>[   60.001296]  </TASK>
<4>[   60.001634] WARNING: CPU: 2 PID: 1152 at kernel/freezer.c:129 __set_task_frozen+0x58/0x80
<4>[   60.001641] Modules linked in: fuse snd_hda_codec_hdmi i915 x86_pkg_temp_thermal coretemp mei_pxp mei_hdcp kvm_intel wmi_bmof snd_hda_intel kvm snd_intel_dspcfg prime_numbers snd_hda_codec cdc_ether ttm e1000e irqbypass snd_hwdep crct10dif_pclmul usbnet drm_buddy crc32_pclmul mii ghash_clmulni_intel snd_hda_core drm_display_helper ptp i2c_i801 pps_core mei_me drm_kms_helper i2c_smbus snd_pcm syscopyarea mei sysfillrect sysimgblt intel_lpss_pci fb_sys_fops video wmi
<4>[   60.001717] CPU: 2 PID: 1152 Comm: rtcwake Not tainted 6.1.0-rc1-CI_DRM_12270-ga9d18ead9885+ #1
<4>[   60.001723] Hardware name: Intel Corporation Tiger Lake Client Platform/TigerLake U DDR4 SODIMM RVP, BIOS TGLSFWI1.R00.3197.A00.2005110542 05/11/2020
<4>[   60.001729] RIP: 0010:__set_task_frozen+0x58/0x80
<4>[   60.001735] Code: f7 c5 00 20 00 00 74 06 40 f6 c5 03 74 3a 81 e5 00 40 00 00 75 16 8b 15 a2 b9 71 01 85 d2 74 0c 8b 83 60 09 00 00 85 c0 74 02 <0f> 0b c7 43 18 00 80 00 00 b8 00 80 00 00 5b 5d c3 cc cc cc cc 31
<4>[   60.001744] RSP: 0018:ffffc9000335fcf0 EFLAGS: 00010002
<4>[   60.001747] RAX: 0000000000000001 RBX: ffff888111a70040 RCX: 0000000000000000
<4>[   60.001751] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff888111a70040
<4>[   60.001757] RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000fffffffe
<4>[   60.001763] R10: 0000000001e6f6b9 R11: 00000000934a4c67 R12: 0000000000000246
<4>[   60.001769] R13: ffffffff811653e0 R14: 0000000000000000 R15: ffff888111a70040
<4>[   60.001776] FS:  00007fb47043e740(0000) GS:ffff8884a0300000(0000) knlGS:0000000000000000
<4>[   60.001784] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   60.001789] CR2: 00007f3903c603d8 CR3: 000000010a25a003 CR4: 0000000000770ee0
<4>[   60.001795] PKRU: 55555554
<4>[   60.001798] Call Trace:
<4>[   60.001801]  <TASK>
<4>[   60.001804]  task_call_func+0xc2/0xe0
<4>[   60.001809]  freeze_task+0x84/0xe0
<4>[   60.001815]  try_to_freeze_tasks+0xac/0x260
<4>[   60.001821]  freeze_processes+0x56/0xb0
<4>[   60.001826]  pm_suspend.cold.7+0x1d9/0x31c
<4>[   60.001832]  state_store+0x7b/0xe0
<4>[   60.001837]  kernfs_fop_write_iter+0x121/0x1c0
<4>[   60.001843]  vfs_write+0x34c/0x4e0
<4>[   60.001850]  ksys_write+0x57/0xd0
<4>[   60.001855]  do_syscall_64+0x37/0x90
<4>[   60.001860]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4>[   60.001866] RIP: 0033:0x7fb4705521e7
<4>[   60.001870] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
<4>[   60.001884] RSP: 002b:00007ffe3efac3d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
<4>[   60.001892] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fb4705521e7
<4>[   60.001898] RDX: 0000000000000004 RSI: 0000559af7969590 RDI: 000000000000000b
<4>[   60.001904] RBP: 0000559af7969590 R08: 0000000000000000 R09: 0000000000000004
<4>[   60.001910] R10: 0000559af60922a6 R11: 0000000000000246 R12: 0000000000000004
<4>[   60.001917] R13: 0000559af7967540 R14: 00007fb47062e4a0 R15: 00007fb47062d8a0
<4>[   60.001925]  </TASK>
<4>[   60.001928] irq event stamp: 8712
<4>[   60.001931] hardirqs last  enabled at (8711): [<ffffffff81b73784>] _raw_spin_unlock_irqrestore+0x54/0x70
<4>[   60.001941] hardirqs last disabled at (8712): [<ffffffff81b7352b>] _raw_spin_lock_irqsave+0x4b/0x50
<4>[   60.001950] softirqs last  enabled at (8348): [<ffffffff81e0031e>] __do_softirq+0x31e/0x48a
<4>[   60.001957] softirqs last disabled at (8341): [<ffffffff810c1b08>] irq_exit_rcu+0xb8/0xe0
<4>[   60.001969] ---[ end trace 0000000000000000 ]---
<4>[   60.003326] (elapsed 0.002 seconds) done.
<6>[   60.003332] OOM killer disabled.
<6>[   60.003334] Freezing remaining freezable tasks ... (elapsed 0.006 seconds) done.
<6>[   60.010062] printk: Suspending console(s) (use no_console_suspend to debug)
<6>[   60.041543] e1000e: EEE TX LPI TIMER: 00000011
<6>[   60.368938] ACPI: EC: interrupt blocked

-- 
Ville Syrjälä
Intel
