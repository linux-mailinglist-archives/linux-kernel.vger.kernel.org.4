Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3356CD77A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjC2KPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjC2KP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D94480
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A074361C35
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF22EC433D2;
        Wed, 29 Mar 2023 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680084924;
        bh=oLJgHbDdDrr+s5ptyAuzO1SNbf0Oju6Msn0laatr/hU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRiRfoV+Y3qfPNtePaFUCd89Q6F/P5BbYjgbOpVjX5XjDR8v3SmWnmPSnHCl5x7s0
         zDgmF9IibZbr30Helxq56C0B5W5EVDGopvaAP284u1sxcJBDblxb8nYsMXFXOfWW2Q
         P9FdJ5gEtBkr/RZDDVDrU/eblnBYeDmJ+OeH0Bxg=
Date:   Wed, 29 Mar 2023 12:15:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmci_host: fix a race condition in vmci_host_poll()
 causing GPF
Message-ID: <ZCQPuaps5rCtGAb2@kroah.com>
References: <ZCGFsdBAU4cYww5l@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCGFsdBAU4cYww5l@dragonet>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 09:01:53PM +0900, Dae R. Jeong wrote:
> During fuzzing, a general protection fault is observed in
> vmci_host_poll().
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000019: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
> RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
> <- omitting registers ->
> Call Trace:
>  <TASK>
>  lock_acquire+0x1a4/0x4a0 kernel/locking/lockdep.c:5672
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:162
>  add_wait_queue+0x3d/0x260 kernel/sched/wait.c:22
>  poll_wait include/linux/poll.h:49 [inline]
>  vmci_host_poll+0xf8/0x2b0 drivers/misc/vmw_vmci/vmci_host.c:174
>  vfs_poll include/linux/poll.h:88 [inline]
>  do_pollfd fs/select.c:873 [inline]
>  do_poll fs/select.c:921 [inline]
>  do_sys_poll+0xc7c/0x1aa0 fs/select.c:1015
>  __do_sys_ppoll fs/select.c:1121 [inline]
>  __se_sys_ppoll+0x2cc/0x330 fs/select.c:1101
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Example thread interleaving that causes the general protection fault
> is as follows:
> 
> CPU1 (vmci_host_poll)               CPU2 (vmci_host_do_init_context)
> -----                               -----
> // Read uninitialized context
> context = vmci_host_dev->context;
>                                     // Initialize context
>                                     vmci_host_dev->context = vmci_ctx_create();
>                                     vmci_host_dev->ct_type = VMCIOBJ_CONTEXT;
> 
> if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
>     // Dereferencing the wrong pointer
>     poll_wait(..., &context->host_context);
> }
> 
> In this scenario, vmci_host_poll() reads vmci_host_dev->context first,
> and then reads vmci_host_dev->ct_type to check that
> vmci_host_dev->context is initialized. However, since these two reads
> are not atomically executed, there is a chance of a race condition as
> described above.
> 
> To fix this race condition, read vmci_host_dev->context after checking
> the value of vmci_host_dev->ct_type so that vmci_host_poll() always
> reads an initialized context.
> 
> Reported-by: Dae R. Jeong <threeearcat@gmail.com>
> Fixes: 8bf503991f87 ("VMCI: host side driver implementation.")
> Signed-off-by: Dae R. Jeong <threeearcat@gmail.com>

If you author and sign-off on the patch, no need for a Reported-by: as
that is obvious :)

And how did you test this change?

thanks,

greg k-h
