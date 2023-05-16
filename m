Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CF7704A40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjEPKPg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 May 2023 06:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjEPKPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:15:34 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0491984;
        Tue, 16 May 2023 03:15:31 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pyri0-003A6G-CI; Tue, 16 May 2023 12:15:08 +0200
Received: from p5b13aa61.dip0.t-ipconnect.de ([91.19.170.97] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pyrhz-001sti-Ur; Tue, 16 May 2023 12:15:08 +0200
Message-ID: <90ed85d877b6f43c5461987eee8c6fbc6e4f43bf.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] irqchip/jcore-aic: Fix missing allocation of IRQ
 descriptors
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-sh <linux-sh@vger.kernel.org>
Date:   Tue, 16 May 2023 12:15:07 +0200
In-Reply-To: <86cz30mvyy.wl-maz@kernel.org>
References: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
         <479a18513b9d8c6e8ccb96093a0f0dd7@kernel.org>
         <3c76bea5e45a5ae9ea58b3ff87f9971955a3a021.camel@physik.fu-berlin.de>
         <86zg6bmezz.wl-maz@kernel.org>
         <7e58646d7ae4cad32ae30e2e7b54806cc1272d63.camel@physik.fu-berlin.de>
         <86cz30mvyy.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.170.97
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-16 at 11:06 +0100, Marc Zyngier wrote:
> > It did still work which is why the previously suggested change was to make a
> > failing call to irq_alloc_descs() non-fatal. The boards still booted
> > up.
> 
> I don't get it. Either the descriptors are already allocated, and you
> don't need this call, or they were never allocated and this never
> worked. Which one is it?

I haven't tried it myself yet. The original report is that the kernel prints
a lot of backtraces for each IRQ descriptor not allocated but still works:

> SH generic board support: scanning for interrupt controllers
> Initializing J-Core AIC
> ------------[ cut here ]------------
> error: virq16 is not allocated
> WARNING: CPU: 0 PID: 0 at kernel/irq/irqdomain.c:571
> irq_domain_associate+0x120/0x178
> 
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2 #1
> PC is at irq_domain_associate+0x120/0x178
> PR is at irq_domain_associate+0x120/0x178
> PC  : 10049b90 SP  : 103bdec0 SR  : 400001f1
> R0  : 0000001e R1  : 1042d024 R2  : 1042d024 R3  : 00000028
> R4  : 00000001 R5  : 0006f1ff R6  : 00000008 R7  : 103bde04
> R8  : 1200c000 R9  : 00000010 R10 : 00000000 R11 : 00000010
> R12 : 10049a70 R13 : 103bfcac R14 : 1030a398
> MACH: 00000000 MACL: 00057fa8 GBR : 00000000 PR  : 10049b90
> 
> Call trace:
>  [<100496f0>] __irq_domain_add+0x80/0x1dc
>  [<10049cd2>] irq_domain_create_legacy+0x46/0x68
>  [<10049a70>] irq_domain_associate+0x0/0x178
>  [<104517da>] aic_irq_of_init+0x82/0xd8
>  [<1020ab90>] of_iomap+0x0/0x30
>  [<1031df1c>] _printk+0x0/0x24
>  [<1045630c>] of_irq_init+0xe4/0x228
>  [<100a5a10>] kfree+0x0/0x250
>  [<10042376>] vprintk_emit+0xde/0x1fc
>  [<1004239c>] vprintk_emit+0x104/0x1fc
>  [<10309940>] strlen+0x0/0x60
>  [<100424a6>] vprintk_default+0x12/0x20
>  [<10309940>] strlen+0x0/0x60
>  [<10002a2c>] arch_local_save_flags+0x0/0x8
>  [<1031df1c>] _printk+0x0/0x24
>  [<104456f8>] init_IRQ+0x14/0x28
>  [<10309940>] strlen+0x0/0x60
>  [<10002a2c>] arch_local_save_flags+0x0/0x8
>  [<1031df1c>] _printk+0x0/0x24
>  [<1044394c>] start_kernel+0x3b8/0x73c
>  [<1044320c>] unknown_bootoption+0x0/0x170
>  [<1000202a>] _stext+0x2a/0x34
> 
> Code:
>   10049b8a:  mov.l     10049bd8 <irq_domain_associate+0x168/0x178>, r4  !
> 10393da0 <0x10393da0>
>   10049b8c:  jsr       @r1
>   10049b8e:  mov       r11, r5
> ->10049b90:  trapa     #62
>   10049b92:  bra       10049b0e
>   10049b94:  mov       #-22, r12
>   10049b96:  mov.l     10049bd0 <irq_domain_associate+0x160/0x178>, r1  !
> 1031da2c <__warn_printk+0x0/0x38>
>   10049b98:  mov.l     10049bdc <irq_domain_associate+0x16c/0x178>, r4  !
> 10393dc0 <0x10393dc0>
>   10049b9a:  jsr       @r1
> 
> ---[ end trace 0000000000000000 ]---

Adding the call to irq_alloc_descs() addresses the problem.

> > > > > Is there any plan to modernise the port and get it to allocate
> > > > > irq_descs on demand, as we do on most architectures?
> > > > 
> > > > Yes, there are plans to modernize the port. We're first working on
> > > > upstreaming all kinds of patches that have been queuing up over the
> > > > time.
> > > 
> > > I'd rather you skip that step and focus on making it work as a modern
> > > architecture. This really looks like ARM circa 2007... :-/
> > 
> > We have a patch-set for switching it to device tree in the pipeline.
> 
> Again: why aren't we reviewing that instead of beating a long dead
> horse?

Because we're not there yet. I just picked up maintenance of the SuperH port and we
want to fix various bugs first before tackling the big changes to the architecture.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
