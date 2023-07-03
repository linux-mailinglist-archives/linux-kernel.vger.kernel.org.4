Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BFB745971
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjGCJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjGCJ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:57:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E89BB44A6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:53:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01EF01FB;
        Mon,  3 Jul 2023 02:52:40 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.27.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 024093F762;
        Mon,  3 Jul 2023 02:51:55 -0700 (PDT)
Date:   Mon, 3 Jul 2023 10:51:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: qemu-arm64: Unexpected kernel BRK exception at EL1 - WARNING:
 CPU: 3 PID: 0 at kernel/context_tracking.c:128 ct_kernel_exit.constprop
Message-ID: <ZKKaOeRj5Quf00S2@FVFF77S0Q05N>
References: <CA+G9fYsuc8D98BtW9rX0ahS9Rfqyn-5CALYWTy6fr_ypJqEErA@mail.gmail.com>
 <d41a6d08-981b-481b-9108-fe91afaa0f82@app.fastmail.com>
 <CA+G9fYt0Sh-0vFQSWjJz0di-vAc-Ke-bwjqyGM=d_M==x6OnOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYt0Sh-0vFQSWjJz0di-vAc-Ke-bwjqyGM=d_M==x6OnOg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 12:02:22PM +0530, Naresh Kamboju wrote:
> On Sun, 2 Jul 2023 at 13:56, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Jul 1, 2023, at 10:42, Naresh Kamboju wrote:
> >
> > > Links:
> > >  -
> > > https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-8686-ge55e5df193d2/testrun/17999853/suite/log-parser-test/tests/
> > >  -
> > > https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-8686-ge55e5df193d2/testrun/17999906/suite/log-parser-test/tests/
> >
> > I can't see which build artifacts correspond to the logs. Can you link to the
> > vmlinux file?
> 
> Here is the build artifacts location with kselftest merge configs.
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2Rum1V78RQJMftEanwtN28dApDO/

In your .config here, I note you have:

| CONFIG_UBSAN_TRAP=y

Considering that:

> [   56.149721] Internal error: BRK handler: 00000000f20003e8 [#1] PREEMPT SMP

This indicates "BRK 0x3e8" AKA "BRK 1000", which is what GCC's __builtin_trap()
uses (and will also be what CONFIG_UBSAN_TRAP uses).

Can you try this with CONFIG_UBSAN_TRAP=n ?

> [   56.150153] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
> sha512_ce sha512_arm64 cfg80211 bluetooth rfkill sch_fq_codel fuse drm
> [   56.151781] CPU: 0 PID: 438 Comm: seccomp_bpf Not tainted 6.4.0 #1
> [   56.152043] Hardware name: linux,dummy-virt (DT)
> [   56.152396] pstate: 41400005 (nZcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [   56.152667] pc : alloc_pid+0x3b4/0x3c8
> [   56.154243] lr : alloc_pid+0x140/0x3c8

Looking at objdump, that's:

| ffff8000800d73b0 <alloc_pid>:
| ...
| ffff8000800d7764:       d4207d00        brk     #0x3e8

... and addr2line fingers this as:

| [mark@lakrids:~/tmp-naresh-kamboju]% usekorg 10.3.0 aarch64-linux-addr2line -ife vmlinux ffff8000800d7764                          
| alloc_pid
| /builds/linux/kernel/pid.c:244

... which appears to be:

| 244                 pid->numbers[i].nr = nr;

Full objdump of the function below; as above I suspect this is UBSAN triggering
a __builtin_trap() on an out-of-range access.

Thanks,
Mark.


ffff8000800d73b0 <alloc_pid>:
ffff8000800d73b0:       d503201f        nop
ffff8000800d73b4:       d503201f        nop
ffff8000800d73b8:       d503233f        paciasp
ffff8000800d73bc:       a9b97bfd        stp     x29, x30, [sp, #-112]!
ffff8000800d73c0:       910003fd        mov     x29, sp
ffff8000800d73c4:       a9046bf9        stp     x25, x26, [sp, #64]
ffff8000800d73c8:       aa0003f9        mov     x25, x0
ffff8000800d73cc:       a90153f3        stp     x19, x20, [sp, #16]
ffff8000800d73d0:       928002b4        mov     x20, #0xffffffffffffffea        // #-22
ffff8000800d73d4:       a9025bf5        stp     x21, x22, [sp, #32]
ffff8000800d73d8:       aa0203f6        mov     x22, x2
ffff8000800d73dc:       f90033e1        str     x1, [sp, #96]
ffff8000800d73e0:       b9404320        ldr     w0, [x25, #64]
ffff8000800d73e4:       11000400        add     w0, w0, #0x1
ffff8000800d73e8:       eb16001f        cmp     x0, x22
ffff8000800d73ec:       54000102        b.cs    ffff8000800d740c <alloc_pid+0x5c>  // b.hs, b.nlast
ffff8000800d73f0:       aa1403e0        mov     x0, x20
ffff8000800d73f4:       a94153f3        ldp     x19, x20, [sp, #16]
ffff8000800d73f8:       a9425bf5        ldp     x21, x22, [sp, #32]
ffff8000800d73fc:       a9446bf9        ldp     x25, x26, [sp, #64]
ffff8000800d7400:       a8c77bfd        ldp     x29, x30, [sp], #112
ffff8000800d7404:       d50323bf        autiasp
ffff8000800d7408:       d65f03c0        ret
ffff8000800d740c:       f9401f20        ldr     x0, [x25, #56]
ffff8000800d7410:       52819801        mov     w1, #0xcc0                      // #3264
ffff8000800d7414:       940b4513        bl      ffff8000803a8860 <kmem_cache_alloc>
ffff8000800d7418:       f90037e0        str     x0, [sp, #104]
ffff8000800d741c:       b4001a60        cbz     x0, ffff8000800d7768 <alloc_pid+0x3b8>
ffff8000800d7420:       a90363f7        stp     x23, x24, [sp, #48]
ffff8000800d7424:       b9404333        ldr     w19, [x25, #64]
ffff8000800d7428:       b9000413        str     w19, [x0, #4]
ffff8000800d742c:       37f818d3        tbnz    w19, #31, ffff8000800d7744 <alloc_pid+0x394>
ffff8000800d7430:       f94037e0        ldr     x0, [sp, #104]
ffff8000800d7434:       f00183f8        adrp    x24, ffff800083156000 <boot_args>
ffff8000800d7438:       aa1903f4        mov     x20, x25
ffff8000800d743c:       91050318        add     x24, x24, #0x140
ffff8000800d7440:       90018577        adrp    x23, ffff800083183000 <event_workqueue_activate_work+0x58>
ffff8000800d7444:       a90573fb        stp     x27, x28, [sp, #80]
ffff8000800d7448:       8b33d015        add     x21, x0, w19, sxtw #4
ffff8000800d744c:       910182b5        add     x21, x21, #0x60
ffff8000800d7450:       b4000e56        cbz     x22, ffff8000800d7618 <alloc_pid+0x268>
ffff8000800d7454:       b9404320        ldr     w0, [x25, #64]
ffff8000800d7458:       f94033e1        ldr     x1, [sp, #96]
ffff8000800d745c:       4b130000        sub     w0, w0, w19
ffff8000800d7460:       b860783b        ldr     w27, [x1, x0, lsl #2]
ffff8000800d7464:       7100037f        cmp     w27, #0x0
ffff8000800d7468:       540014ed        b.le    ffff8000800d7704 <alloc_pid+0x354>
ffff8000800d746c:       b940cae0        ldr     w0, [x23, #200]
ffff8000800d7470:       910322fa        add     x26, x23, #0xc8
ffff8000800d7474:       6b1b001f        cmp     w0, w27
ffff8000800d7478:       5400146d        b.le    ffff8000800d7704 <alloc_pid+0x354>
ffff8000800d747c:       7100077f        cmp     w27, #0x1
ffff8000800d7480:       54000060        b.eq    ffff8000800d748c <alloc_pid+0xdc>  // b.none
ffff8000800d7484:       f9401a80        ldr     x0, [x20, #48]
ffff8000800d7488:       b40013e0        cbz     x0, ffff8000800d7704 <alloc_pid+0x354>
ffff8000800d748c:       f9402e9c        ldr     x28, [x20, #88]
ffff8000800d7490:       52800501        mov     w1, #0x28                       // #40
ffff8000800d7494:       aa1c03e0        mov     x0, x28
ffff8000800d7498:       97ff8a38        bl      ffff8000800b9d78 <ns_capable>
ffff8000800d749c:       72001c1f        tst     w0, #0xff
ffff8000800d74a0:       54000dc0        b.eq    ffff8000800d7658 <alloc_pid+0x2a8>  // b.none
ffff8000800d74a4:       52819800        mov     w0, #0xcc0                      // #3264
ffff8000800d74a8:       94580912        bl      ffff8000816d98f0 <idr_preload>
ffff8000800d74ac:       aa1803e0        mov     x0, x24
ffff8000800d74b0:       94589902        bl      ffff8000816fd8b8 <_raw_spin_lock_irq>
ffff8000800d74b4:       11000763        add     w3, w27, #0x1
ffff8000800d74b8:       2a1b03e2        mov     w2, w27
ffff8000800d74bc:       aa1403e0        mov     x0, x20
ffff8000800d74c0:       52810404        mov     w4, #0x820                      // #2080
ffff8000800d74c4:       d2800001        mov     x1, #0x0                        // #0
ffff8000800d74c8:       9457bd1e        bl      ffff8000816c6940 <idr_alloc>
ffff8000800d74cc:       2a0003fb        mov     w27, w0
ffff8000800d74d0:       3100701f        cmn     w0, #0x1c
ffff8000800d74d4:       d10006d6        sub     x22, x22, #0x1
ffff8000800d74d8:       12800200        mov     w0, #0xffffffef                 // #-17
ffff8000800d74dc:       1a80137b        csel    w27, w27, w0, ne  // ne = any
ffff8000800d74e0:       aa1803e0        mov     x0, x24
ffff8000800d74e4:       94589735        bl      ffff8000816fd1b8 <_raw_spin_unlock_irq>
ffff8000800d74e8:       52800020        mov     w0, #0x1                        // #1
ffff8000800d74ec:       94005a0f        bl      ffff8000800edd28 <preempt_count_sub>
ffff8000800d74f0:       d5384100        mrs     x0, sp_el0
ffff8000800d74f4:       f9400400        ldr     x0, [x0, #8]
ffff8000800d74f8:       b4000800        cbz     x0, ffff8000800d75f8 <alloc_pid+0x248>
ffff8000800d74fc:       37f8083b        tbnz    w27, #31, ffff8000800d7600 <alloc_pid+0x250>
ffff8000800d7500:       35001333        cbnz    w19, ffff8000800d7764 <alloc_pid+0x3b4>
ffff8000800d7504:       b90002bb        str     w27, [x21]
ffff8000800d7508:       51000673        sub     w19, w19, #0x1
ffff8000800d750c:       f90006b4        str     x20, [x21, #8]
ffff8000800d7510:       d10042b5        sub     x21, x21, #0x10
ffff8000800d7514:       f9402694        ldr     x20, [x20, #72]
ffff8000800d7518:       3100067f        cmn     w19, #0x1
ffff8000800d751c:       54fff9a1        b.ne    ffff8000800d7450 <alloc_pid+0xa0>  // b.any
ffff8000800d7520:       a94573fb        ldp     x27, x28, [sp, #80]
ffff8000800d7524:       9100235a        add     x26, x26, #0x8
ffff8000800d7528:       eb1a033f        cmp     x25, x26
ffff8000800d752c:       54000160        b.eq    ffff8000800d7558 <alloc_pid+0x1a8>  // b.none
ffff8000800d7530:       91021320        add     x0, x25, #0x84
ffff8000800d7534:       14000077        b       ffff8000800d7710 <alloc_pid+0x360>
ffff8000800d7538:       52800021        mov     w1, #0x1                        // #1
ffff8000800d753c:       b8210001        ldadd   w1, w1, [x0]
ffff8000800d7540:       340010c1        cbz     w1, ffff8000800d7758 <alloc_pid+0x3a8>
ffff8000800d7544:       11000422        add     w2, w1, #0x1
ffff8000800d7548:       2a010041        orr     w1, w2, w1
ffff8000800d754c:       36f80061        tbz     w1, #31, ffff8000800d7558 <alloc_pid+0x1a8>
ffff8000800d7550:       52800021        mov     w1, #0x1                        // #1
ffff8000800d7554:       941976c1        bl      ffff800080735058 <refcount_warn_saturate>
ffff8000800d7558:       f94037f5        ldr     x21, [sp, #104]
ffff8000800d755c:       52800023        mov     w3, #0x1                        // #1
ffff8000800d7560:       f001b2e2        adrp    x2, ffff800083736000 <buf.2+0x218>
ffff8000800d7564:       d0010001        adrp    x1, ffff8000820d9000 <kallsyms_seqs_of_names+0xb27c0>
ffff8000800d7568:       912a2042        add     x2, x2, #0xa88
ffff8000800d756c:       911dc021        add     x1, x1, #0x770
ffff8000800d7570:       b90002a3        str     w3, [x21]
ffff8000800d7574:       9100e2a0        add     x0, x21, #0x38
ffff8000800d7578:       b9000abf        str     wzr, [x21, #8]
ffff8000800d757c:       a9017ebf        stp     xzr, xzr, [x21, #16]
ffff8000800d7580:       f90012bf        str     xzr, [x21, #32]
ffff8000800d7584:       f90016bf        str     xzr, [x21, #40]
ffff8000800d7588:       9401171a        bl      ffff80008011d1f0 <__init_waitqueue_head>
ffff8000800d758c:       f9001abf        str     xzr, [x21, #48]
ffff8000800d7590:       aa1803e0        mov     x0, x24
ffff8000800d7594:       b9404334        ldr     w20, [x25, #64]
ffff8000800d7598:       945898c8        bl      ffff8000816fd8b8 <_raw_spin_lock_irq>
ffff8000800d759c:       b9402b20        ldr     w0, [x25, #40]
ffff8000800d75a0:       36f80c60        tbz     w0, #31, ffff8000800d772c <alloc_pid+0x37c>
ffff8000800d75a4:       d37c7e93        ubfiz   x19, x20, #4, #32
ffff8000800d75a8:       910182b4        add     x20, x21, #0x60
ffff8000800d75ac:       ab130293        adds    x19, x20, x19
ffff8000800d75b0:       540001a2        b.cs    ffff8000800d75e4 <alloc_pid+0x234>  // b.hs, b.nlast
ffff8000800d75b4:       d503201f        nop
ffff8000800d75b8:       b9800262        ldrsw   x2, [x19]
ffff8000800d75bc:       d1004273        sub     x19, x19, #0x10
ffff8000800d75c0:       f9400e60        ldr     x0, [x19, #24]
ffff8000800d75c4:       f94037e1        ldr     x1, [sp, #104]
ffff8000800d75c8:       9457be04        bl      ffff8000816c6dd8 <idr_replace>
ffff8000800d75cc:       f9400e61        ldr     x1, [x19, #24]
ffff8000800d75d0:       b9402820        ldr     w0, [x1, #40]
ffff8000800d75d4:       11000400        add     w0, w0, #0x1
ffff8000800d75d8:       b9002820        str     w0, [x1, #40]
ffff8000800d75dc:       eb13029f        cmp     x20, x19
ffff8000800d75e0:       54fffec9        b.ls    ffff8000800d75b8 <alloc_pid+0x208>  // b.plast
ffff8000800d75e4:       aa1803e0        mov     x0, x24
ffff8000800d75e8:       f94037f4        ldr     x20, [sp, #104]
ffff8000800d75ec:       945896f3        bl      ffff8000816fd1b8 <_raw_spin_unlock_irq>
ffff8000800d75f0:       a94363f7        ldp     x23, x24, [sp, #48]
ffff8000800d75f4:       17ffff7f        b       ffff8000800d73f0 <alloc_pid+0x40>
ffff8000800d75f8:       94587472        bl      ffff8000816f47c0 <preempt_schedule>
ffff8000800d75fc:       36fff83b        tbz     w27, #31, ffff8000800d7500 <alloc_pid+0x150>
ffff8000800d7600:       3100737f        cmn     w27, #0x1c
ffff8000800d7604:       93407f61        sxtw    x1, w27
ffff8000800d7608:       92800140        mov     x0, #0xfffffffffffffff5         // #-11
ffff8000800d760c:       9a801034        csel    x20, x1, x0, ne  // ne = any
ffff8000800d7610:       a94573fb        ldp     x27, x28, [sp, #80]
ffff8000800d7614:       14000018        b       ffff8000800d7674 <alloc_pid+0x2c4>
ffff8000800d7618:       52819800        mov     w0, #0xcc0                      // #3264
ffff8000800d761c:       945808b5        bl      ffff8000816d98f0 <idr_preload>
ffff8000800d7620:       aa1803e0        mov     x0, x24
ffff8000800d7624:       945898a5        bl      ffff8000816fd8b8 <_raw_spin_lock_irq>
ffff8000800d7628:       b9401680        ldr     w0, [x20, #20]
ffff8000800d762c:       52802582        mov     w2, #0x12c                      // #300
ffff8000800d7630:       b940cae3        ldr     w3, [x23, #200]
ffff8000800d7634:       52810404        mov     w4, #0x820                      // #2080
ffff8000800d7638:       6b02001f        cmp     w0, w2
ffff8000800d763c:       d2800001        mov     x1, #0x0                        // #0
ffff8000800d7640:       1a9f8442        csinc   w2, w2, wzr, hi  // hi = pmore
ffff8000800d7644:       aa1403e0        mov     x0, x20
ffff8000800d7648:       910322fa        add     x26, x23, #0xc8
ffff8000800d764c:       9457bceb        bl      ffff8000816c69f8 <idr_alloc_cyclic>
ffff8000800d7650:       2a0003fb        mov     w27, w0
ffff8000800d7654:       17ffffa3        b       ffff8000800d74e0 <alloc_pid+0x130>
ffff8000800d7658:       aa1c03e0        mov     x0, x28
ffff8000800d765c:       528002a1        mov     w1, #0x15                       // #21
ffff8000800d7660:       97ff89c6        bl      ffff8000800b9d78 <ns_capable>
ffff8000800d7664:       72001c1f        tst     w0, #0xff
ffff8000800d7668:       54fff1e1        b.ne    ffff8000800d74a4 <alloc_pid+0xf4>  // b.any
ffff8000800d766c:       a94573fb        ldp     x27, x28, [sp, #80]
ffff8000800d7670:       92800014        mov     x20, #0xffffffffffffffff        // #-1
ffff8000800d7674:       aa1803e0        mov     x0, x24
ffff8000800d7678:       94589890        bl      ffff8000816fd8b8 <_raw_spin_lock_irq>
ffff8000800d767c:       f94037e1        ldr     x1, [sp, #104]
ffff8000800d7680:       11000673        add     w19, w19, #0x1
ffff8000800d7684:       b9404320        ldr     w0, [x25, #64]
ffff8000800d7688:       91018035        add     x21, x1, #0x60
ffff8000800d768c:       6b00027f        cmp     w19, w0
ffff8000800d7690:       54000168        b.hi    ffff8000800d76bc <alloc_pid+0x30c>  // b.pmore
ffff8000800d7694:       d503201f        nop
ffff8000800d7698:       937c7e60        sbfiz   x0, x19, #4, #32
ffff8000800d769c:       11000673        add     w19, w19, #0x1
ffff8000800d76a0:       8b0002a2        add     x2, x21, x0
ffff8000800d76a4:       b8a06aa1        ldrsw   x1, [x21, x0]
ffff8000800d76a8:       f9400440        ldr     x0, [x2, #8]
ffff8000800d76ac:       9457bd11        bl      ffff8000816c6af0 <idr_remove>
ffff8000800d76b0:       b9404320        ldr     w0, [x25, #64]
ffff8000800d76b4:       6b13001f        cmp     w0, w19
ffff8000800d76b8:       54ffff02        b.cs    ffff8000800d7698 <alloc_pid+0x2e8>  // b.hs, b.nlast
ffff8000800d76bc:       b9402b21        ldr     w1, [x25, #40]
ffff8000800d76c0:       52b00000        mov     w0, #0x80000000                 // #-2147483648
ffff8000800d76c4:       6b00003f        cmp     w1, w0
ffff8000800d76c8:       54000041        b.ne    ffff8000800d76d0 <alloc_pid+0x320>  // b.any
ffff8000800d76cc:       b900173f        str     wzr, [x25, #20]
ffff8000800d76d0:       aa1803e0        mov     x0, x24
ffff8000800d76d4:       945896b9        bl      ffff8000816fd1b8 <_raw_spin_unlock_irq>
ffff8000800d76d8:       f9401f20        ldr     x0, [x25, #56]
ffff8000800d76dc:       f94037e1        ldr     x1, [sp, #104]
ffff8000800d76e0:       940b4c18        bl      ffff8000803aa740 <kmem_cache_free>
ffff8000800d76e4:       aa1403e0        mov     x0, x20
ffff8000800d76e8:       a94153f3        ldp     x19, x20, [sp, #16]
ffff8000800d76ec:       a9425bf5        ldp     x21, x22, [sp, #32]
ffff8000800d76f0:       a94363f7        ldp     x23, x24, [sp, #48]
ffff8000800d76f4:       a9446bf9        ldp     x25, x26, [sp, #64]
ffff8000800d76f8:       a8c77bfd        ldp     x29, x30, [sp], #112
ffff8000800d76fc:       d50323bf        autiasp
ffff8000800d7700:       d65f03c0        ret
ffff8000800d7704:       928002b4        mov     x20, #0xffffffffffffffea        // #-22
ffff8000800d7708:       a94573fb        ldp     x27, x28, [sp, #80]
ffff8000800d770c:       17ffffda        b       ffff8000800d7674 <alloc_pid+0x2c4>
ffff8000800d7710:       91021324        add     x4, x25, #0x84
ffff8000800d7714:       f9800091        prfm    pstl1strm, [x4]
ffff8000800d7718:       885f7c81        ldxr    w1, [x4]
ffff8000800d771c:       11000422        add     w2, w1, #0x1
ffff8000800d7720:       88037c82        stxr    w3, w2, [x4]
ffff8000800d7724:       35ffffa3        cbnz    w3, ffff8000800d7718 <alloc_pid+0x368>
ffff8000800d7728:       17ffff86        b       ffff8000800d7540 <alloc_pid+0x190>
ffff8000800d772c:       aa1803e0        mov     x0, x24
ffff8000800d7730:       945896a2        bl      ffff8000816fd1b8 <_raw_spin_unlock_irq>
ffff8000800d7734:       aa1903e0        mov     x0, x25
ffff8000800d7738:       92800174        mov     x20, #0xfffffffffffffff4        // #-12
ffff8000800d773c:       9403e163        bl      ffff8000801cfcc8 <put_pid_ns>
ffff8000800d7740:       17ffffcd        b       ffff8000800d7674 <alloc_pid+0x2c4>
ffff8000800d7744:       f00183f8        adrp    x24, ffff800083156000 <boot_args>
ffff8000800d7748:       9001857a        adrp    x26, ffff800083183000 <event_workqueue_activate_work+0x58>
ffff8000800d774c:       91050318        add     x24, x24, #0x140
ffff8000800d7750:       9103235a        add     x26, x26, #0xc8
ffff8000800d7754:       17ffff74        b       ffff8000800d7524 <alloc_pid+0x174>
ffff8000800d7758:       52800041        mov     w1, #0x2                        // #2
ffff8000800d775c:       9419763f        bl      ffff800080735058 <refcount_warn_saturate>
ffff8000800d7760:       17ffff7e        b       ffff8000800d7558 <alloc_pid+0x1a8>
ffff8000800d7764:       d4207d00        brk     #0x3e8
ffff8000800d7768:       92800174        mov     x20, #0xfffffffffffffff4        // #-12
ffff8000800d776c:       17ffff21        b       ffff8000800d73f0 <alloc_pid+0x40>
ffff8000800d7770:       d503201f        nop
ffff8000800d7774:       d503201f        nop

> [   56.154399] sp : ffff8000809b3960
> [   56.154539] x29: ffff8000809b3960 x28: 0000000001200000 x27: 0000000000000001
> [   56.155081] x26: ffffb7df5f7830c8 x25: ffff0000c5f18008 x24: ffffb7df5f756140
> [   56.155481] x23: ffffb7df5f783000 x22: 0000000000000000 x21: ffff0000c9ecc0b0
> [   56.155880] x20: ffff0000c5f18008 x19: 0000000000000001 x18: ffffb7df5e2c3280
> [   56.156210] x17: ffffb7df5c6d7418 x16: ffffb7df5c9a8b80 x15: ffffb7df5c9a8080
> [   56.156483] x14: ffffb7df5c9a7b48 x13: ffffb7df5dceb680 x12: ffffb7df5c62d204
> [   56.156761] x11: ffffb7df5c62d194 x10: a1f68cf70798a66b x9 : ffffb7df5c6d74f0
> [   56.157079] x8 : ffff8000809b3878 x7 : 0000000000000000 x6 : 0000000000000220
> [   56.157343] x5 : 0000000000000001 x4 : ffffb7df5f75f000 x3 : ffffb7df5f75f2e8
> [   56.157617] x2 : 0000000000000000 x1 : ffff0000c9031180 x0 : 0000000100000000
> [   56.158001] Call trace:
> [   56.158155]  alloc_pid+0x3b4/0x3c8
> [   56.158352]  copy_process+0xd20/0x1590
> [   56.158487]  kernel_clone+0x94/0x3f8
> [   56.158623]  __do_sys_clone+0x74/0xb8
> [   56.158883]  __arm64_sys_clone+0x2c/0x40
> [   56.159150]  invoke_syscall+0x8c/0x120
> [   56.159370]  el0_svc_common.constprop.0+0xf4/0x120
> [   56.159529]  do_el0_svc+0x44/0xb8
> [   56.159705]  el0_svc+0x30/0x98
> [   56.159884]  el0t_64_sync_handler+0x13c/0x158
> [   56.160053]  el0t_64_sync+0x190/0x198
> [   56.160343] Code: 17ffff74 52800041 9419763f 17ffff7e (d4207d00)
> [   56.160919] ---[ end trace 0000000000000000 ]---
> [   56.161210] note: seccomp_bpf[438] exited with irqs disabled
> [   56.161775] note: seccomp_bpf[438] exited with preempt_count 1
> [   56.169001] ------------[ cut here ]------------
> [   56.169423] WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:128
> ct_kernel_exit.constprop.0+0x108/0x120
> [   56.169952] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
> sha512_ce sha512_arm64 cfg80211 bluetooth rfkill sch_fq_codel fuse drm
> [   56.170978] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D
>    6.4.0 #1
> [   56.171408] Hardware name: linux,dummy-virt (DT)
> [   56.171708] pstate: 204003c5 (nzCv DAIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   56.172134] pc : ct_kernel_exit.constprop.0+0x108/0x120
> [   56.172354] lr : ct_idle_enter+0x10/0x20
> [   56.172617] sp : ffffb7df5f753d40
> [   56.172833] x29: ffffb7df5f753d40 x28: 00000000426120ac x27: 0000000000000000
> [   56.173255] x26: 0000000000000000 x25: ffffb7df5f76bd00 x24: 0000000000000000
> [   56.173675] x23: 0000000000000000 x22: ffffb7df5f75eba0 x21: ffffb7df5ecc9b78
> [   56.173963] x20: ffffb7df5f75eac0 x19: ffff0000ff573c60 x18: ffffb7df5e2c3280
> [   56.174260] x17: ffffb7df5dceaf80 x16: ffffb7df5c63b820 x15: ffffb7df5c623834
> [   56.174643] x14: ffffb7df5c6235ac x13: ffffb7df5c62d00c x12: ffffb7df5c6a85b4
> [   56.175266] x11: ffffb7df5c6a8544 x10: e1769a2bf2c5b3d9 x9 : ffffb7df5c7a1730
> [   56.175720] x8 : ffffb7df5f753ca8 x7 : 0000000000000000 x6 : 0000000000000001
> [   56.176028] x5 : 4000000000000002 x4 : ffff4821a08ac000 x3 : ffffb7df5f753d40
> [   56.176315] x2 : ffffb7df5ecc7c60 x1 : 4000000000000000 x0 : ffffb7df5ecc7c60
> [   56.176652] Call trace:
> [   56.176791]  ct_kernel_exit.constprop.0+0x108/0x120
> [   56.177073]  ct_idle_enter+0x10/0x20
> [   56.177238]  default_idle_call+0x44/0x168
> [   56.177398]  do_idle+0x244/0x2b8
> [   56.177565]  cpu_startup_entry+0x2c/0x40
> [   56.177722]  rest_init+0xfc/0x108
> [   56.177873]  arch_call_rest_init+0x18/0x20
> [   56.178128]  start_kernel+0x55c/0x6d8
> [   56.178290]  __primary_switched+0xbc/0xd0
> [   56.178560] ---[ end trace 0000000000000000 ]---
> 
> 
> 
> - Naresh
> 
> >
> >        Arnd
