Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A42568FE1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjBIDtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjBIDta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:49:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9552B3A94;
        Wed,  8 Feb 2023 19:49:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2548B61870;
        Thu,  9 Feb 2023 03:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79866C433D2;
        Thu,  9 Feb 2023 03:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675914568;
        bh=OMDShK3ZLEAzpKl9+KDlCbHoVF2eSgngZXLwr1dLDcw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FMwlac1HdekzVVMOf7N9L9BNdKJ7COby3mk3y8K0y+QbfCiD3r+ImFi8ORVr4Kjcp
         T5pMYurNoD4tHz3ZBT1u7d28ZYe6Qr/4P/bz5gRLyTgxA9YLu+2bLZR+own83W33yZ
         C71zR/mSLgM/t+Vy2o+ciknr3JSevL7N8yZOGEofVf7FCUZRLz/LPIZYSMR+5cpDD8
         kGLXqulLoTF+tANhb/tuu454U/jjZ+roLR/tNsIV05MhG2qFBHk0vhSJl2LyLbMJqq
         pYw+Si3gvvPIoGypiDU8WSk4IpleSV+h0RSsY//V8+i5mJL0nvHSTktZ8fhZIIAWQq
         fBXLWCVohWwRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0CB4E5C099C; Wed,  8 Feb 2023 19:49:27 -0800 (PST)
Date:   Wed, 8 Feb 2023 19:49:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]  run rcutorture  BUG: unable to handle page fault for
 address: ffffffff84d05000
Message-ID: <20230209034927.GL2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <PH0PR11MB5880C80360BE924B60905CC0DAD99@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880C80360BE924B60905CC0DAD99@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 02:57:42AM +0000, Zhang, Qiang1 wrote:
> 
> Test based on the following branches:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  branch dev, arch X86_64 
> 
> 
> runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4" bootparams="nokaslr console=ttyS0 rcutorture.torture_type=rcu rcutorture.shuffle_interval=0 isolcpus=0,1 rcu_nocbs=0,1 nohz_full=0,1 rcutree.dump_tree=1 rcutorture.onoff_holdoff=30 rcutorture.onoff_interval=10" -d
> 
> [   39.392925] BUG: unable to handle page fault for address: ffffffff84d05000
> [   39.393244] #PF: supervisor read access in kernel mode
> [   39.393480] #PF: error_code(0x0000) - not-present page
> [   39.393715] PGD 3e19067 P4D 3e19067 PUD 3e1a063 PMD 800ffffffb3ff062
> [   39.394014] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> [   39.394231] CPU: 0 PID: 16 Comm: rcu_preempt Not tainted 6.2.0-rc1-yocto-standard+ #635
> [   39.394590] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.o4
> [   39.395085] RIP: 0010:do_raw_spin_trylock+0x70/0x120
> [   39.395320] Code: 81 c7 00 f1 f1 f1 f1 c7 40 04 04 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 45 e0 31 c0 e8 c8 0
> [   39.396143] RSP: 0018:ffff8880072d7b30 EFLAGS: 00010046
> [   39.396381] RAX: 0000000000000000 RBX: ffffffff84d05000 RCX: dffffc0000000000
> [   39.396703] RDX: 0000000000000003 RSI: 0000000000000004 RDI: ffffffff84d05000
> [   39.397027] RBP: ffff8880072d7ba8 R08: ffffffff811d74a0 R09: fffffbfff09a0a01
> [   39.397346] R10: ffffffff84d05003 R11: fffffbfff09a0a00 R12: 1ffff11000e5af66
> [   39.397669] R13: ffffffff84d05018 R14: ffffffff84d05000 R15: ffff8880072d7cd8
> [   39.397990] FS:  0000000000000000(0000) GS:ffff888035400000(0000) knlGS:0000000000000000
> [   39.398353] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   39.398615] CR2: ffffffff84d05000 CR3: 000000000a22c000 CR4: 00000000001506f0
> [   39.398936] Call Trace:
> [   39.399053]  <TASK>
> [   39.399156]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   39.399379]  ? trace_preempt_off+0x2a/0x110
> [   39.399576]  _raw_spin_lock+0x41/0x80
> [   39.399751]  ? schedule_timeout+0x242/0x580
> [   39.399945]  schedule_timeout+0x242/0x580
> [   39.400133]  ? __pfx_schedule_timeout+0x10/0x10
> [   39.400346]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   39.400567]  ? __pfx_process_timeout+0x10/0x10
> [   39.400776]  ? _raw_spin_unlock_irqrestore+0x46/0x80
> [   39.401006]  ? prepare_to_swait_event+0xb8/0x210
> [   39.401221]  rcu_gp_fqs_loop+0x60b/0xd50
> [   39.401405]  ? rcu_gp_init+0x89c/0x1250
> [   39.401587]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
> [   39.401793]  ? _raw_spin_unlock_irqrestore+0x46/0x80
> [   39.402022]  rcu_gp_kthread+0x2b7/0x620
> [   39.402201]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   39.402421]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   39.402625]  ? __kasan_check_read+0x11/0x20
> [   39.402818]  ? __kthread_parkme+0xe8/0x110
> [   39.403010]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   39.403213]  kthread+0x192/0x1d0
> [   39.403366]  ? __pfx_kthread+0x10/0x10
> [   39.403541]  ret_from_fork+0x2c/0x50
> [   39.403712]  </TASK>
> [   39.403818] Modules linked in:
> [   39.403972] CR2: ffffffff84d05000
> [   39.404128] ---[ end trace 0000000000000000 ]---
> [   39.404340] RIP: 0010:do_raw_spin_trylock+0x70/0x120
> [   39.404569] Code: 81 c7 00 f1 f1 f1 f1 c7 40 04 04 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 45 e0 31 c0 e8 c8 0
> [   39.405400] RSP: 0018:ffff8880072d7b30 EFLAGS: 00010046
> [   39.405639] RAX: 0000000000000000 RBX: ffffffff84d05000 RCX: dffffc0000000000
> [   39.405959] RDX: 0000000000000003 RSI: 0000000000000004 RDI: ffffffff84d05000
> [   39.406281] RBP: ffff8880072d7ba8 R08: ffffffff811d74a0 R09: fffffbfff09a0a01
> [   39.406602] R10: ffffffff84d05003 R11: fffffbfff09a0a00 R12: 1ffff11000e5af66
> [   39.406922] R13: ffffffff84d05018 R14: ffffffff84d05000 R15: ffff8880072d7cd8
> [   39.407245] FS:  0000000000000000(0000) GS:ffff888035400000(0000) knlGS:0000000000000000
> [   39.407607] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   39.407871] CR2: ffffffff84d05000 CR3: 000000000a22c000 CR4: 00000000001506f0
> [   39.408195] Kernel panic - not syncing: Fatal exception
> [   39.408450] Kernel Offset: disabled
> [   39.408615] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> After remove isolcpus=0,1 and nohz_full=0,1, there is no Oops.

That certainly isn't what we want the kernel to be doing!  ;-)

Could you please try bisecting?

							Thanx, Paul
