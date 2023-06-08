Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A27284E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjFHQ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjFHQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6325730C5;
        Thu,  8 Jun 2023 09:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC13C63CFA;
        Thu,  8 Jun 2023 16:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B404C433D2;
        Thu,  8 Jun 2023 16:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686241553;
        bh=gOEUia+23UYhhwa16A6eyS6VdNPXXMmQSVwhbEsD84s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lzCmry9QiuxPqrwsGZrqdthRip7Go0OKBMwtFANwXeKva8k5G62VLixAMI6cTF2yn
         9jNx1oOLgySAVEs0wn+PI4fIO9tPzSKS2vMfkhL5h/q8Fy7w1vAyI/mUkslU8KJQZY
         DWHs1YB/P3Y21C3pgEIrKcA5qQo+moZzoStMtlIdSrp7NJZwj/dB5+ErA99/ePz5Gj
         2Z4VADBOLB7ApYPIqgHK17ciFlitaTAy2eytG+M1bDdDGlhTDh3EcOfHAqCfOVE0rE
         UOMybwBiJqrTDotk/tPJBL7+NVHz2OBS00v8sZzxaVDOrT//OiVfRQ7T/a431I3ctP
         UdS/E5ieRTKZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 06D40CE14DD; Thu,  8 Jun 2023 09:25:53 -0700 (PDT)
Date:   Thu, 8 Jun 2023 09:25:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Jain, Ayush" <ayush.jain3@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        sfr@canb.auug.org.au, rcu@vger.kernel.org,
        Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org,
        void@manifault.com
Subject: Re: Null pointer dereference during rcutorture test on linux-next
 from next-20230602
Message-ID: <05a8bdd2-6b0f-40d4-9706-4d65b74affe9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b8311fdc-2e71-f74f-159e-db7a86f27b9a@amd.com>
 <ff0dd6b8-884e-4bcb-b7d9-72a5a8940f0d@paulmck-laptop>
 <20230608083318.GG998233@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608083318.GG998233@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:33:18AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 07, 2023 at 12:24:12PM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 07, 2023 at 04:48:19PM +0530, Jain, Ayush wrote:
> > > Hello All,
> > > 
> > > Observed null pointer dereference during rcutorture test on linux-next tree
> > > from next-20230602.
> > > 
> > > Commit ID: commit bc708bbd8260ee4eb3428b0109f5f3be661fae46 (HEAD, tag: next-20230602)
> > > 
> > > Here I am attaching log trace
> > > 
> > > [12133.344278] rcu-torture: rcu_torture_read_exit: Start of test
> > > [12133.344282] rcu-torture: rcu_torture_read_exit: Start of episode
> > > [12138.350637] rcu-torture: rcu_torture_read_exit: End of episode
> > > [12143.419412] smpboot: CPU 1 is now offline
> > > [12143.427996] BUG: kernel NULL pointer dereference, address: 0000000000000128
> > > [12143.435777] #PF: supervisor read access in kernel mode
> > > [12143.441517] #PF: error_code(0x0000) - not-present page
> > > [12143.447256] PGD 0 P4D 0
> > > [12143.450087] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > [12143.454955] CPU: 68 PID: 978653 Comm: rcu_torture_rea Kdump: loaded Not tainted 6.4.0-rc5-next-20230606-1686061107994 #1
> > > [12143.467095] Hardware name: AMD Corporation Speedway/Speedway, BIOS RSW1009C 07/27/2018
> > > [12143.475934] RIP: 0010:__bitmap_and+0x18/0x70
> > > [12143.480713] Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 89 cb 49 89 f9 41 c1 eb 06 74 51 45 89 da 31 c0 45 31 c0 <48> 8b 3c c6 48 23 3c c2 49 89 3c c1 48 83 c0 01 49 09 f8 49 39 c2
> > > [12143.501675] RSP: 0018:ffffa3a90db70d90 EFLAGS: 00010046
> > > [12143.507510] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000080
> > > [12143.515468] RDX: ffff8a1ec17a1d68 RSI: 0000000000000128 RDI: ffff8a1e800429c0
> > > [12143.523425] RBP: ffff8a1ec17a1980 R08: 0000000000000000 R09: ffff8a1e800429c0
> > > [12143.531385] R10: 0000000000000002 R11: 0000000000000002 R12: ffff8a1e800429c0
> > > [12143.539352] R13: 0000000000000000 R14: 0000000000032580 R15: 0000000000000000
> > > [12143.547320] FS:  0000000000000000(0000) GS:ffff8a2dbf100000(0000) knlGS:0000000000000000
> > > [12143.556354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [12143.562770] CR2: 0000000000000128 CR3: 0000003089e50000 CR4: 00000000003506e0
> > > [12143.570729] Call Trace:
> > > [12143.573463]  <IRQ>
> > > [12143.575714]  ? __die+0x24/0x70
> > > [12143.579130]  ? page_fault_oops+0x82/0x150
> > > [12143.583615]  ? exc_page_fault+0x69/0x150
> > > [12143.588001]  ? asm_exc_page_fault+0x26/0x30
> > > [12143.592678]  ? __bitmap_and+0x18/0x70
> > > [12143.596768]  select_idle_cpu+0x84/0x3d0
> > > [12143.601059]  select_idle_sibling+0x1b7/0x500
> > > [12143.605831]  select_task_rq_fair+0x1b2/0x2e0
> > > [12143.610603]  select_task_rq+0x7a/0xc0
> > > [12143.614696]  try_to_wake_up+0xe8/0x550
> > > [12143.618885]  ? update_process_times+0x83/0x90
> > > [12143.623747]  ? __pfx_hrtimer_wakeup+0x10/0x10
> > > [12143.628615]  hrtimer_wakeup+0x22/0x30
> > > [12143.632706]  __hrtimer_run_queues+0x112/0x2b0
> > > [12143.637574]  hrtimer_interrupt+0x100/0x240
> > > [12143.642152]  __sysvec_apic_timer_interrupt+0x63/0x130
> > > [12143.647796]  sysvec_apic_timer_interrupt+0x71/0x90
> > > [12143.653149]  </IRQ>
> > > [12143.655493]  <TASK>
> > > [12143.657834]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> 
> I'm thikning this is because of ("sched/fair: Multi-LLC
> select_idle_sibling()") which I've already dropped from tip/sched/core
> (and should hopefully also dissapear from -next if it hasn't already).
> 
> Also see:
> 
>   https://lkml.kernel.org/r/20230605175636.GA4253@hirez.programming.kicks-ass.net

That sounds a lot easier than bisecting, thank you!

							Thanx, Paul
