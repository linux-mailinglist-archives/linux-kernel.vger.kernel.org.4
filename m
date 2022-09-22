Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77DD5E6321
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiIVNFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiIVNEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:04:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15E85756C;
        Thu, 22 Sep 2022 06:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B77BB834B3;
        Thu, 22 Sep 2022 13:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB68C433D6;
        Thu, 22 Sep 2022 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663851888;
        bh=KaSg9G4h33gJKbfeaNf1KpNs5s0DJSyscXsrY/WEgjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBHCNR6U5k3BybJsK++GmcOCVODMwvYoLgxAt9XdBKXuwafv+X8z5jucsNKQKvyQo
         ShJkAIj2fP3gFWBmP++Nxj9ij+0kC5or0nXSUKs1sFD5VRuA/lQ7w1lX/KDAW8xp6q
         yZvT43L8I2n64FkWV9sdemk506ApnU7OASMQwWSY=
Date:   Thu, 22 Sep 2022 15:04:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     eadavis@sina.com
Cc:     linhaoguo86@gmail.com, balbi@kernel.org, john@metanate.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb/gadget: Annotate midi lock nesting
Message-ID: <YyxdbRhl7HGDDZZM@kroah.com>
References: <CAB7eexKfentLRraPRR8kwqY3NRN9WTTijLW8SrKwAPzOzouxDg@mail.gmail.com>
 <20220918035037.4160095-1-eadavis@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918035037.4160095-1-eadavis@sina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 11:50:37AM +0800, eadavis@sina.com wrote:
> From: Edward Adam Davis <eadavis@sina.com>
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.0.0-rc4+ #20 Not tainted
> --------------------------------------------
> kworker/0:1H/9 is trying to acquire lock:
> ffff888057ed9228 (&midi->transmit_lock){....}-{2:2}, at:
> f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683
> 
> but task is already holding lock:
> ffff888057ed9228 (&midi->transmit_lock){....}-{2:2}, at:
> f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&midi->transmit_lock);
>   lock(&midi->transmit_lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by kworker/0:1H/9:
>  #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
> arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
> arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
>  #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
> atomic_long_set include/linux/atomic/atomic-instrumented.h:1280
> [inline]
>  #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
> set_work_data kernel/workqueue.c:636 [inline]
>  #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
> set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
>  #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
> process_one_work+0x8b0/0x1650 kernel/workqueue.c:2260
>  #1: ffffc900003afdb0 ((work_completion)(&midi->work)){+.+.}-{0:0},
> at: process_one_work+0x8e4/0x1650 kernel/workqueue.c:2264
>  #2: ffff888057ed9228 (&midi->transmit_lock){....}-{2:2}, at:
> f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683
> 
> stack backtrace:
> CPU: 0 PID: 9 Comm: kworker/0:1H Not tainted 6.0.0-rc4+ #20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Workqueue: events_highpri f_midi_in_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_deadlock_bug kernel/locking/lockdep.c:2988 [inline]
>  check_deadlock kernel/locking/lockdep.c:3031 [inline]
>  validate_chain kernel/locking/lockdep.c:3816 [inline]
>  __lock_acquire.cold+0x152/0x3c3 kernel/locking/lockdep.c:5053
>  lock_acquire kernel/locking/lockdep.c:5666 [inline]
>  lock_acquire+0x1ab/0x580 kernel/locking/lockdep.c:5631
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
>  f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683
>  f_midi_complete+0x1bb/0x480 drivers/usb/gadget/function/f_midi.c:285
>  dummy_queue+0x84a/0xb20 drivers/usb/gadget/udc/dummy_hcd.c:736
>  usb_ep_queue+0xe8/0x3b0 drivers/usb/gadget/udc/core.c:288
>  f_midi_do_transmit drivers/usb/gadget/function/f_midi.c:658 [inline]
>  f_midi_transmit+0x7e4/0x1460 drivers/usb/gadget/function/f_midi.c:686
>  process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
>  worker_thread+0x623/0x1070 kernel/workqueue.c:2436
>  kthread+0x2e9/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>
> Use nested notation for the spin_lock to avoid this warning.
> 
> Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> ---
>  drivers/usb/gadget/function/f_midi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index fddf539008a9..ad745fbd549e 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -680,7 +680,8 @@ static void f_midi_transmit(struct f_midi *midi)
>  	if (!ep || !ep->enabled)
>  		goto drop_out;
>  
> -	spin_lock_irqsave(&midi->transmit_lock, flags);
> +	spin_lock_irqsave_nested(&midi->transmit_lock, flags, 
> +			SINGLE_DEPTH_NESTING);

This feels wrong (and you added a checkpatch warning at the same time.)

If this is correct, please document this really really well why this is
the correct solution and we just don't really have a lockdep issue here
with the code itself.

thanks,

greg k-h
