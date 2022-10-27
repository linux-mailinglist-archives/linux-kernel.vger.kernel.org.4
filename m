Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A1160FA24
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiJ0OKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiJ0OKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:10:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CFC74E14;
        Thu, 27 Oct 2022 07:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A134AB8266E;
        Thu, 27 Oct 2022 14:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40885C433C1;
        Thu, 27 Oct 2022 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666879846;
        bh=YEvvqV4DLQUASQJDH1GR32IoiZ+66FB2c7Ozz8bsVUg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q3nDo5qi2AhrwQ8dQbwQHiuBC6Ir0zwWXGvvffJA/wtzFHGNmu1hslHzlJoDmpCtl
         79oJIJ1zLHRtupUmAT90n4o+X725kPXXuolCZ20vCyAdEA8BCR7UfHXDAuDARw85La
         aKTkT8MIPmldst3v9y5hKBueuAZ7xfDxAzKRN4NF/7vfiSgnmWDAcZBaFXrDqaDoSP
         49ANJGrJ1Oldb+FqYzxTgYoITqtP8hai1ZOSlSHDiuKTog/O0oLao3VXazAG6hgf5Q
         Y5NdPTK4n095lrUY4utYLfhss5ADxIfTmw8yQvM3bqn37iBb/wAOtlBVB7v85Vps+U
         LFkfWkt8EjJpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DB7C05C0622; Thu, 27 Oct 2022 07:10:45 -0700 (PDT)
Date:   Thu, 27 Oct 2022 07:10:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, tglx@linutronix.de, pmladek@suse.com
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <20221027141045.GX5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
 <87pmeoawwe.fsf@jogness.linutronix.de>
 <20221019191418.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <20221019220537.GA1234896@lothringen>
 <20221020222718.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <87r0z1gy51.fsf@jogness.linutronix.de>
 <20221021184152.GO5600@paulmck-ThinkPad-P17-Gen-1>
 <87y1t5zqzz.fsf@jogness.linutronix.de>
 <20221024134727.GV5600@paulmck-ThinkPad-P17-Gen-1>
 <874jvpehod.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jvpehod.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:37:46AM +0206, John Ogness wrote:
> Hi Paul,
> 
> I am running some tests using srcunmisafe.2022.10.21a and I am hitting
> the WARN_ONCE in srcu_check_nmi_safety():
> 
> [    1.836703][    T1] rcu: Hierarchical SRCU implementation.
> [    1.836707][    T1] rcu:     Max phase no-delay instances is 1000.
> [    1.836844][   T15] ------------[ cut here ]------------
> [    1.836846][   T15] CPU 0 old state 1 new state 2
> [    1.836885][   T15] WARNING: CPU: 0 PID: 15 at kernel/rcu/srcutree.c:652 srcu_check_nmi_safety+0x79/0x90
> [    1.836897][   T15] Modules linked in:
> [    1.836903][   T15] CPU: 0 PID: 15 Comm: pr/bkl Not tainted 6.1.0-rc1+ #9
> [    1.836909][   T15] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [    1.836912][   T15] RIP: 0010:srcu_check_nmi_safety+0x79/0x90
> [    1.836919][   T15] Code: d3 80 3d 9f 76 d3 01 00 75 e5 55 8b b0 c8 01 00 00 44 89 c1 48 c7 c7 d0 1f 87 82 c6 05 850
> [    1.836923][   T15] RSP: 0000:ffffc90000083e98 EFLAGS: 00010282
> [    1.836929][   T15] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [    1.836933][   T15] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000ffffffff
> [    1.836936][   T15] RBP: ffffc90000083e98 R08: 0000000000000000 R09: 0000000000000001
> [    1.836940][   T15] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [    1.836943][   T15] R13: ffffc90000013d70 R14: ffff888004073900 R15: 0000000000000000
> [    1.836946][   T15] FS:  0000000000000000(0000) GS:ffff888019600000(0000) knlGS:0000000000000000
> [    1.836951][   T15] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.836954][   T15] CR2: ffff888003c01000 CR3: 0000000002c22001 CR4: 0000000000370ef0
> [    1.836962][   T15] Call Trace:
> [    1.836964][   T15]  <TASK>
> [    1.836970][   T15]  console_bkl_kthread_func+0x27a/0x590
> [    1.836981][   T15]  ? _raw_spin_unlock_irqrestore+0x3c/0x60
> [    1.836998][   T15]  ? console_fill_outbuf+0x210/0x210
> [    1.837003][   T15]  kthread+0x108/0x130
> [    1.837012][   T15]  ? kthread_complete_and_exit+0x20/0x20
> [    1.837025][   T15]  ret_from_fork+0x1f/0x30
> [    1.837059][   T15]  </TASK>
> [    1.837062][   T15] irq event stamp: 71
> [    1.837065][   T15] hardirqs last  enabled at (73): [<ffffffff81106f99>] vprintk_store+0x1b9/0x5e0
> [    1.837070][   T15] hardirqs last disabled at (74): [<ffffffff811071fb>] vprintk_store+0x41b/0x5e0
> [    1.837075][   T15] softirqs last  enabled at (0): [<ffffffff8107ce22>] copy_process+0x952/0x1dd0
> [    1.837081][   T15] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.837085][   T15] ---[ end trace 0000000000000000 ]---
> [    1.945054][   T12] Callback from call_rcu_tasks_rude() invoked.
> 
> My code is calling srcu_read_lock_nmisafe() from task context, in a
> dedicated kthread. I am using DEFINE_STATIC_SRCU() to define/initialize
> the srcu struct.
> 
> What does the warning imply?

The warning is claiming that this srcu_struct was passed to
srcu_read_lock() at some point and is now being passed to
srcu_read_lock_nmisafe().

In other words, you have an srcu_read_lock() or srcu_read_unlock()
somewhere that needs to instead be srcu_read_lock_nmisafe() or
srcu_read_unlock_nmisafe().

							Thanx, Paul
