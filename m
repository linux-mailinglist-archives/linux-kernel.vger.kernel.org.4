Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED860DFED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJZLpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiJZLpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:45:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93985AA33;
        Wed, 26 Oct 2022 04:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=1v05Evd/fgFRHniJFAuL6qKyLKCeLYseVqo6d1zZ8vA=; b=XQLfoQJibzGTEgFDcyw3rTTf3f
        wGGPojTZaONiB7oIHpEzRPQdX7Z8vVGafDq2VINLAJcDj5zilpR24Q89I0ng2jHRxACywG0JAauwB
        gNfhUiRQ0zKU/8+tCAVCFrTvIk+5bJ9a5eMX2cCqTjF/AmcjQpMFO7gG2jKeFdO6Ojuqczxu2kibm
        kPP40qoWWbmADbZYdQeLbOT2VK/Jdy20HnzddgGNHOyda/B/If3F2sHS+SWiJRfqTIrr8nhnaG3iq
        d62sV06M1tw99bqs/2PtjiKaPwgR4d4ZPbJdtvBHL1TcqzQkOt5vOLAhJZZb3fB3jL4m2iqk5pTbh
        3FtxaFlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oneoI-006ZvI-RL; Wed, 26 Oct 2022 11:43:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91D9D30010B;
        Wed, 26 Oct 2022 13:43:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55A0B2B54C7C2; Wed, 26 Oct 2022 13:43:00 +0200 (CEST)
Date:   Wed, 26 Oct 2022 13:43:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <Y1kdRNNfUeAU+FNl@hirez.programming.kicks-ass.net>
References: <20220822111816.760285417@infradead.org>
 <20220822114649.055452969@infradead.org>
 <Y1LVYaPCCP3BBS4g@intel.com>
 <Y1drd2gzxUJWdz5F@intel.com>
 <Y1e/Kd+1UQqeSwzY@hirez.programming.kicks-ass.net>
 <Y1kMv1GpKwOSIt8f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1kMv1GpKwOSIt8f@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 01:32:31PM +0300, Ville Syrjälä wrote:
> Short form looks to be this:
> <4>[  355.437846] 1 lock held by rs:main Q:Reg/359:
> <4>[  355.438418]  #0: ffff88844693b758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x1b/0x30
> <4>[  355.438432] rs:main Q:Reg/359 holding locks while freezing

> <4>[  355.438429] ------------[ cut here ]------------
> <4>[  355.438432] rs:main Q:Reg/359 holding locks while freezing
> <4>[  355.438439] WARNING: CPU: 0 PID: 6211 at kernel/freezer.c:134 __set_task_frozen+0x86/0xb0
> <4>[  355.438447] Modules linked in: snd_hda_intel i915 mei_hdcp mei_pxp drm_display_helper drm_kms_helper vgem drm_shmem_helper snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_pcm prime_numbers ttm drm_buddy syscopyarea sysfillrect sysimgblt fb_sys_fops fuse x86_pkg_temp_thermal coretemp kvm_intel btusb btrtl btbcm btintel kvm irqbypass bluetooth crct10dif_pclmul crc32_pclmul ecdh_generic ghash_clmulni_intel ecc e1000e mei_me i2c_i801 ptp mei i2c_smbus pps_core lpc_ich video wmi [last unloaded: drm_kms_helper]
> <4>[  355.438521] CPU: 0 PID: 6211 Comm: rtcwake Tainted: G     U             6.1.0-rc2-CI_DRM_12295-g3844a56a0922+ #1
> <4>[  355.438526] Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0385.2020.0519.1558 05/19/2020
> <4>[  355.438530] RIP: 0010:__set_task_frozen+0x86/0xb0
> <4>[  355.438536] Code: 83 60 09 00 00 85 c0 74 2a 48 89 df e8 ac 02 9b 00 8b 93 38 05 00 00 48 8d b3 48 07 00 00 48 c7 c7 a0 62 2b 82 e8 ee c1 9a 00 <0f> 0b c6 05 51 75 e3 02 01 c7 43 18 00 80 00 00 b8 00 80 00 00 5b
> <4>[  355.438541] RSP: 0018:ffffc900012cbcf0 EFLAGS: 00010086
> <4>[  355.438546] RAX: 0000000000000000 RBX: ffff88810d090040 RCX: 0000000000000004
> <4>[  355.438550] RDX: 0000000000000004 RSI: 00000000fffff5de RDI: 00000000ffffffff
> <4>[  355.438553] RBP: 0000000000000000 R08: 0000000000000000 R09: c0000000fffff5de
> <4>[  355.438557] R10: 00000000002335f8 R11: ffffc900012cbb88 R12: 0000000000000246
> <4>[  355.438561] R13: ffffffff81165430 R14: 0000000000000000 R15: ffff88810d090040
> <4>[  355.438565] FS:  00007fcfa43c7740(0000) GS:ffff888446800000(0000) knlGS:0000000000000000
> <4>[  355.438569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  355.438582] CR2: 00007fceb380f6b8 CR3: 0000000117c5c004 CR4: 00000000003706f0
> <4>[  355.438586] Call Trace:
> <4>[  355.438589]  <TASK>
> <4>[  355.438592]  task_call_func+0xc4/0xe0
> <4>[  355.438600]  freeze_task+0x84/0xe0
> <4>[  355.438607]  try_to_freeze_tasks+0xac/0x260
> <4>[  355.438616]  freeze_processes+0x56/0xb0
> <4>[  355.438622]  pm_suspend.cold.7+0x1d9/0x31c
> <4>[  355.438629]  state_store+0x7b/0xe0
> <4>[  355.438637]  kernfs_fop_write_iter+0x124/0x1c0
> <4>[  355.438644]  vfs_write+0x34f/0x4e0
> <4>[  355.438655]  ksys_write+0x57/0xd0
> <4>[  355.438663]  do_syscall_64+0x3a/0x90
> <4>[  355.438670]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Oh I think I see what's going on.

It's a very narrow race between schedule() and task_call_func().

  CPU0						CPU1

  __schedule()
    rq_lock();
    prev_state = READ_ONCE(prev->__state);
    if (... && prev_state) {
      deactivate_tasl(rq, prev, ...)
        prev->on_rq = 0;

						task_call_func()
						  raw_spin_lock_irqsave(p->pi_lock);
						  state = READ_ONCE(p->__state);
						  smp_rmb();
						  if (... || p->on_rq) // false!!!
						    rq = __task_rq_lock()

						  ret = func();

    next = pick_next_task();
    rq = context_switch(prev, next)
      prepare_lock_switch()
        spin_release(&__rq_lockp(rq)->dep_map...)



So while the task is on it's way out, it still holds rq->lock for a
little while, and right then task_call_func() comes in and figures it
doesn't need rq->lock anymore (because the task is already dequeued --
but still running there) and then the __set_task_frozen() thing observes
it's holding rq->lock and yells murder.

Could you please give the below a spin?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b54c7a..f519f44cd4c7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4200,6 +4200,37 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	return success;
 }
 
+static bool __task_needs_rq_lock(struct task_struct *p)
+{
+	unsigned int state = READ_ONCE(p->__state);
+
+	/*
+	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
+	 * the task is blocked. Make sure to check @state since ttwu() can drop
+	 * locks at the end, see ttwu_queue_wakelist().
+	 */
+	if (state == TASK_RUNNING || state == TASK_WAKING)
+		return true;
+
+	/*
+	 * Ensure we load p->on_rq after p->__state, otherwise it would be
+	 * possible to, falsely, observe p->on_rq == 0.
+	 *
+	 * See try_to_wake_up() for a longer comment.
+	 */
+	smp_rmb();
+	if (p->on_rq)
+		return true;
+
+#ifdef CONFIG_SMP
+	smp_rmb();
+	if (p->on_cpu)
+		return true;
+#endif
+
+	return false;
+}
+
 /**
  * task_call_func - Invoke a function on task in fixed state
  * @p: Process for which the function is to be invoked, can be @current.
@@ -4217,28 +4248,12 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 int task_call_func(struct task_struct *p, task_call_f func, void *arg)
 {
 	struct rq *rq = NULL;
-	unsigned int state;
 	struct rq_flags rf;
 	int ret;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 
-	state = READ_ONCE(p->__state);
-
-	/*
-	 * Ensure we load p->on_rq after p->__state, otherwise it would be
-	 * possible to, falsely, observe p->on_rq == 0.
-	 *
-	 * See try_to_wake_up() for a longer comment.
-	 */
-	smp_rmb();
-
-	/*
-	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
-	 * the task is blocked. Make sure to check @state since ttwu() can drop
-	 * locks at the end, see ttwu_queue_wakelist().
-	 */
-	if (state == TASK_RUNNING || state == TASK_WAKING || p->on_rq)
+	if (__task_needs_rq_lock(p))
 		rq = __task_rq_lock(p, &rf);
 
 	/*
