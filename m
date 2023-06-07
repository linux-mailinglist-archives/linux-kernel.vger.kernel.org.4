Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AB17269A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjFGTYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjFGTYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8921FDA;
        Wed,  7 Jun 2023 12:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD15763C4E;
        Wed,  7 Jun 2023 19:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBF9C433D2;
        Wed,  7 Jun 2023 19:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686165853;
        bh=TEjozzWwHE+wg1B7u7MgRLMA+nls5RrK8Yf8ia9fueU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IIAZ+ErYABx5Ryg4r3dpBcWEGF2aGYh2aHQvbqx0s30X4PANX2GMFstg6gAwAb0TU
         7gjETM9EEBuiVOCqud49fpiViiEb2ImCrCp2bgpqxTwWEs4g5boT5NPKuXeDM2H1A5
         +4xUA5tJHvhqt1OX5pwVufoKQSrjBO45EmOoYcOAx9Uhd4MET05rxJ/oYaAjy2zVzv
         0hX8d20mOi/DoYt3Dj7EfRL1JHrTiIm8gP9w9y02jwnn1YXTHSMcgpTftZKz72WAiA
         4hY010rbk7gUJrYV+wFudW2qaKxIVE2aceBgY7Tiqk5aKnsXruQlptbBBCw/vnaOTW
         D9RDqkTG4PUbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C451ECE0018; Wed,  7 Jun 2023 12:24:12 -0700 (PDT)
Date:   Wed, 7 Jun 2023 12:24:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Jain, Ayush" <ayush.jain3@amd.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        sfr@canb.auug.org.au, rcu@vger.kernel.org,
        Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, void@manifault.com
Subject: Re: Null pointer dereference during rcutorture test on linux-next
 from next-20230602
Message-ID: <ff0dd6b8-884e-4bcb-b7d9-72a5a8940f0d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b8311fdc-2e71-f74f-159e-db7a86f27b9a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8311fdc-2e71-f74f-159e-db7a86f27b9a@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 04:48:19PM +0530, Jain, Ayush wrote:
> Hello All,
> 
> Observed null pointer dereference during rcutorture test on linux-next tree
> from next-20230602.
> 
> Commit ID: commit bc708bbd8260ee4eb3428b0109f5f3be661fae46 (HEAD, tag: next-20230602)
> 
> Here I am attaching log trace
> 
> [12133.344278] rcu-torture: rcu_torture_read_exit: Start of test
> [12133.344282] rcu-torture: rcu_torture_read_exit: Start of episode
> [12138.350637] rcu-torture: rcu_torture_read_exit: End of episode
> [12143.419412] smpboot: CPU 1 is now offline
> [12143.427996] BUG: kernel NULL pointer dereference, address: 0000000000000128
> [12143.435777] #PF: supervisor read access in kernel mode
> [12143.441517] #PF: error_code(0x0000) - not-present page
> [12143.447256] PGD 0 P4D 0
> [12143.450087] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [12143.454955] CPU: 68 PID: 978653 Comm: rcu_torture_rea Kdump: loaded Not tainted 6.4.0-rc5-next-20230606-1686061107994 #1
> [12143.467095] Hardware name: AMD Corporation Speedway/Speedway, BIOS RSW1009C 07/27/2018
> [12143.475934] RIP: 0010:__bitmap_and+0x18/0x70
> [12143.480713] Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 89 cb 49 89 f9 41 c1 eb 06 74 51 45 89 da 31 c0 45 31 c0 <48> 8b 3c c6 48 23 3c c2 49 89 3c c1 48 83 c0 01 49 09 f8 49 39 c2
> [12143.501675] RSP: 0018:ffffa3a90db70d90 EFLAGS: 00010046
> [12143.507510] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000080
> [12143.515468] RDX: ffff8a1ec17a1d68 RSI: 0000000000000128 RDI: ffff8a1e800429c0
> [12143.523425] RBP: ffff8a1ec17a1980 R08: 0000000000000000 R09: ffff8a1e800429c0
> [12143.531385] R10: 0000000000000002 R11: 0000000000000002 R12: ffff8a1e800429c0
> [12143.539352] R13: 0000000000000000 R14: 0000000000032580 R15: 0000000000000000
> [12143.547320] FS:  0000000000000000(0000) GS:ffff8a2dbf100000(0000) knlGS:0000000000000000
> [12143.556354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12143.562770] CR2: 0000000000000128 CR3: 0000003089e50000 CR4: 00000000003506e0
> [12143.570729] Call Trace:
> [12143.573463]  <IRQ>
> [12143.575714]  ? __die+0x24/0x70
> [12143.579130]  ? page_fault_oops+0x82/0x150
> [12143.583615]  ? exc_page_fault+0x69/0x150
> [12143.588001]  ? asm_exc_page_fault+0x26/0x30
> [12143.592678]  ? __bitmap_and+0x18/0x70
> [12143.596768]  select_idle_cpu+0x84/0x3d0
> [12143.601059]  select_idle_sibling+0x1b7/0x500
> [12143.605831]  select_task_rq_fair+0x1b2/0x2e0
> [12143.610603]  select_task_rq+0x7a/0xc0
> [12143.614696]  try_to_wake_up+0xe8/0x550
> [12143.618885]  ? update_process_times+0x83/0x90
> [12143.623747]  ? __pfx_hrtimer_wakeup+0x10/0x10
> [12143.628615]  hrtimer_wakeup+0x22/0x30
> [12143.632706]  __hrtimer_run_queues+0x112/0x2b0
> [12143.637574]  hrtimer_interrupt+0x100/0x240
> [12143.642152]  __sysvec_apic_timer_interrupt+0x63/0x130
> [12143.647796]  sysvec_apic_timer_interrupt+0x71/0x90
> [12143.653149]  </IRQ>
> [12143.655493]  <TASK>
> [12143.657834]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [12143.663573] RIP: 0010:rcu_torture_read_lock+0x4/0x20 [rcutorture]
> [12143.670389] Code: 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 e9 12 5a f6 d7 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <0f> 1f 44 00 00 e8 b2 12 f6 d7 31 c0 e9 7b 9c a0 d8 66 66 2e 0f 1f
> [12143.691351] RSP: 0018:ffffa3a90e3ebc40 EFLAGS: 00000202
> [12143.697187] RAX: ffffffffc1dff0b0 RBX: 00000000ffffffff RCX: 0000000000000008
> [12143.705155] RDX: 0000000000000060 RSI: 0000000000000060 RDI: ffffa3a90e3ebccc
> [12143.713124] RBP: 0000000000000060 R08: 0000000000000060 R09: 0000000000000000
> [12143.721091] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000060
> [12143.729057] R13: 0000000000000008 R14: 0000000000000000 R15: ffffa3a90e3ebe20
> [12143.737027]  ? __pfx_rcu_torture_read_lock+0x10/0x10 [rcutorture]
> [12143.743845]  rcutorture_one_extend+0xc2/0x3a0 [rcutorture]
> [12143.749980]  rcu_torture_one_read+0x192/0x550 [rcutorture]
> [12143.756115]  ? update_load_avg+0x7e/0x740
> [12143.760593]  ? raw_spin_rq_lock_nested+0x15/0x30
> [12143.765749]  ? newidle_balance+0x26e/0x400
> [12143.770330]  ? __pfx_rcu_torture_reader+0x10/0x10 [rcutorture]
> [12143.776854]  rcu_torture_reader+0xcd/0x280 [rcutorture]
> [12143.782698]  ? __pfx_rcu_torture_timer+0x10/0x10 [rcutorture]
> [12143.789124]  kthread+0xe6/0x120
> [12143.792636]  ? __pfx_kthread+0x10/0x10
> [12143.796823]  ret_from_fork+0x2c/0x50
> [12143.800824]  </TASK>
> 
> Please let me know if any extra information is required.

Could you please let us know which rcutorture scenario this is and/or
what module parameters were supplied to modprobe (depending on how you
initiated the test)?  One way to do this is to post the full console
log somewhere, along with the .config.

At first glance, the wakeup path got a NULL cpumask pointer somehow.

Is bisection a possibility?  It would be very helpful.

							Thanx, Paul
