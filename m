Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65FB63FE21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiLBCbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiLBCbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:31:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AD2CCFEC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:31:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9601262180
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130C6C433C1;
        Fri,  2 Dec 2022 02:31:27 +0000 (UTC)
Date:   Thu, 1 Dec 2022 21:31:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [BUG] lockdep splat using mmio tracer
Message-ID: <20221201213126.620b7dd3@gandalf.local.home>
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

I hit this while testing ftrace on an x86 32 bit VM (I've just started
converting my tests to run on a VM, which is find new found bugs).

[ 1111.130669] ================================   
[ 1111.130670] WARNING: inconsistent lock state   
[ 1111.130672] 6.1.0-rc6-test-00020-gbc591e45c100-dirty #245 Not tainted
[ 1111.130674] --------------------------------   
[ 1111.130675] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[ 1111.130676] kworker/0:0/3433 [HC1[1]:SC0[0]:HE0:SE1] takes:
[ 1111.130679] d3dc2b90 (kmmio_lock){....}-{2:2}, at: kmmio_die_notifier+0x70/0x140
[ 1111.130690] {INITIAL USE} state was registered at:
[ 1111.130691]   lock_acquire+0xa2/0x2b0
[ 1111.130696]   _raw_spin_lock_irqsave+0x36/0x60 
[ 1111.130701]   register_kmmio_probe+0x43/0x210  
[ 1111.130704]   mmiotrace_ioremap+0x188/0x1b0
[ 1111.130706]   __ioremap_caller.constprop.0+0x257/0x340
[ 1111.130711]   ioremap_wc+0x12/0x20
[ 1111.130713]   ttm_bo_vmap+0x1d7/0x1f0 [ttm]
[ 1111.130722]   qxl_bo_vmap_locked+0x75/0xa0 [qxl]
[ 1111.130728]   qxl_draw_dirty_fb+0x2a2/0x440 [qxl]
[ 1111.130733]   qxl_framebuffer_surface_dirty+0xfb/0x1d0 [qxl]
[ 1111.130737]   drm_fb_helper_damage_work+0x181/0x350 [drm_kms_helper]
[ 1117.130757]   process_one_work+0x21a/0x4e0
[ 1111.130759]   worker_thread+0x14e/0x3a0
[ 1111.130761]   kthread+0xea/0x110
[ 1111.130765]   ret_from_fork+0x1c/0x28
[ 1111.130767] irq event stamp: 263958
[ 1111.130768] hardirqs last  enabled at (263957): [<d3a0e292>] _raw_spin_unlock_irq+0x22/0x50
[ 1111.130773] hardirqs last disabled at (263958): [<d3a022bd>] exc_page_fault+0x2d/0x280
[ 1111.130777] softirqs last  enabled at (263522): [<d3783201>] neigh_managed_work+0xa1/0xb0
[ 1111.130782] softirqs last disabled at (263518): [<d3783183>] neigh_managed_work+0x23/0xb0
[ 1111.130786]
[ 1111.130786] other info that might help us debug this:
[ 1111.130786]  Possible unsafe locking scenario: 
[ 1111.130786]
[ 1111.130787]        CPU0
[ 1111.130787]        ----
[ 1111.130788]   lock(kmmio_lock);
[ 1111.130789]   <Interrupt>
[ 1111.130790]     lock(kmmio_lock);
[ 1111.130791]
[ 1111.130791]  *** DEADLOCK ***
[ 1111.130791]
[ 1111.130791] 7 locks held by kworker/0:0/3433:  
[ 1111.130797]  #0: c100d4a8 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1ac/0x4e0
[ 1111.130803]  #1: c8391f44 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x1ac/0x4e0
[ 1111.130808]  #2: c8391e94 (crtc_ww_class_acquire){+.+.}-{0:0}, at: qxl_framebuffer_surface_dirty+0x77/0x1d0 [qxl]
[ 1111.130815]  #3: c18502b8 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock+0x67/0x200 [drm]
[ 1111.130863]  #4: c7d1e8dc (reservation_ww_class_acquire){+.+.}-{0:0}, at: qxl_release_reserve_list+0x46/0x120 [qxl]
[ 1111.130871]  #5: c1bd52f4 (reservation_ww_class_mutex){+.+.}-{3:3}, at: ttm_eu_reserve_buffers+0x2e5/0x4d0 [ttm]
[ 1111.130880]  #6: d3e385ac (rcu_read_lock){....}-{1:2}, at: kmmio_handler+0x37/0x2e0
[ 1111.130886]
[ 1111.130886] stack backtrace:
[ 1111.130887] CPU: 0 PID: 3433 Comm: kworker/0:0 Not tainted 6.1.0-rc6-test-00020-gbc591e45c100-dirty #245
[ 1111.130890] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 1111.130892] Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
[ 1111.130909] Call Trace:
[ 1111.130911]  dump_stack_lvl+0x4c/0x5f
[ 1111.130915]  dump_stack+0xd/0x10
[ 1111.130918]  print_usage_bug.part.0+0x16c/0x177
[ 1111.130924]  lock_acquire.cold+0x31/0x37
[ 1111.130927]  ? kmmio_die_notifier+0x70/0x140   
[ 1111.130935]  ? get_ins_imm_val+0xf0/0xf0
[ 1111.130938]  _raw_spin_lock+0x2a/0x40
[ 1111.130942]  ? kmmio_die_notifier+0x70/0x140   
[ 1111.130945]  kmmio_die_notifier+0x70/0x140
[ 1111.130948]  ? arm_kmmio_fault_page+0xa0/0xa0  
[ 1111.130951]  atomic_notifier_call_chain+0x75/0x120
[ 1111.130955]  notify_die+0x44/0x90
[ 1111.130959]  exc_debug+0xd0/0x2a0
[ 1111.130965]  ? exc_int3+0x100/0x100
[ 1111.130968]  handle_exception+0x133/0x133
[ 1111.130970] EIP: qxl_draw_dirty_fb+0x2ae/0x440 [qxl]
[ 1111.130975] Code: 1c 85 db 75 a3 8b 45 d8 8d 55 e8 c7 45 e8 00 00 00 00 c7 45 ec 00 00 00 00 e8 4e d8 ff ff 85 c0 75 86 8b 75 e8 8b 5d 14 89 1e <8b> 5d cc c7 46 10 00 00 00 00 c7 46 14 00 00 00 00 c7 46 08 00 00
[ 1111.130978] EAX: 00000000 EBX: 00000001 ECX: d3090bc0 EDX: 00000001
[ 1111.130980] ESI: f7cd3000 EDI: 00000138 EBP: c8391e44 ESP: c8391dec
[ 1111.130981] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000146
[ 1111.130984]  ? iomem_map_sanity_check+0xf0/0x100
[ 1111.130990]  ? sysvec_kvm_posted_intr_nested_ipi+0xb/0xa0
[ 1111.130994]  ? exc_int3+0x100/0x100
[ 1111.130998]  ? exc_int3+0x100/0x100
[ 1111.131002]  ? qxl_draw_dirty_fb+0x2ae/0x440 [qxl]
[ 1111.131011]  qxl_framebuffer_surface_dirty+0xfb/0x1d0 [qxl]
[ 1111.131022]  ? qxl_create_plane+0xd0/0xd0 [qxl]
[ 1111.131026]  drm_fb_helper_damage_work+0x181/0x350 [drm_kms_helper]
[ 1111.131046]  process_one_work+0x21a/0x4e0
[ 1111.131052]  worker_thread+0x14e/0x3a0
[ 1111.131056]  kthread+0xea/0x110
[ 1111.131059]  ? process_one_work+0x4e0/0x4e0
[ 1111.131062]  ? kthread_complete_and_exit+0x20/0x20
[ 1111.131066]  ret_from_fork+0x1c/0x28

I never hit this before, but then again, mmio tracer is showing output on
the VM which it did not do on the baremetal machine.

-- Steve
