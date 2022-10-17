Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1E8600F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJQMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiJQMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:34:39 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77465DFA4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:34:37 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1324e7a1284so13039450fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quCyfdRc6tIT0zkDOcC6ee9+htrU7/TQvjp1TfRbe/8=;
        b=cHNnaXBRB3NzehxZhSiJBdZfsT6gJWVgoQCOwEB+DQtsk/52BOedaOKXBe2uaD3R8L
         sN9Lj0o9RLztRPs/FqZ/J6OLSLoK32AJgbO2Cw6nkAZnoLnFvLQQSAqAVMTOvXmJu4db
         qrOdJ97p1GQOcr2Nc/MfJvd+oJkBiGSyNmymFptWwiXrc2cBV81N3oe4eeMmjspyHDyv
         A38P5ImYFWhSfMyET+Vks3F7+ZvDblQUwkoIg1OKO/LgDm2AUD8lwFHcp1PKIhM29TLm
         vz6hNPYMx/jEF7XMSSyc3ldXCt8JqiW4yrNWlFfNWwNrmRZn9ayrIzWsov2ADHKc4etp
         G7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quCyfdRc6tIT0zkDOcC6ee9+htrU7/TQvjp1TfRbe/8=;
        b=3v01pgQxow6h0wggE8k1VDNBoDWmkrhlR3XcgQ5GCMJwG6qrR0a5D4qXb0DaIYevil
         AQKomLNzvnLmQYmTGOsUtuvVTd53tMBEfpj7hcA4o1nYqVn0mv+Iqph7EQhfx0oMhxw9
         u1AYjDP8dESf4peieWUucMino6y0tM6IwkivQgHTEX8UthlsEZD/unBgZ2J+Fn30Tt+O
         97qRH2HYg6M8XBi2gsMx1VoyRrIRCiHt1y9UMQlBVGG9heS3qaFRQP1AHKp6t0SBzeaA
         CqHVIK7PegWURl9nQiyV8hGV9sxUuNYbvWT/No6NmSBT/DqPP+vs36oSeNCzbhRWNyFI
         +HCw==
X-Gm-Message-State: ACrzQf24S7ho1WfkiNX8+U+X8Wceh83C+fpL6ItxphP1ngL68pyqJj6O
        8sEeZE3MNmkJo6+FNCORRK8=
X-Google-Smtp-Source: AMsMyM5XpK9ZX6EaC1kxasQN9WaOG5i6ajc5ehqPM6h6fNElYg1N5JdgyARt38xqCJwubAGJR6HPMQ==
X-Received: by 2002:a05:6871:b06:b0:136:c445:82d0 with SMTP id fq6-20020a0568710b0600b00136c44582d0mr14887433oab.146.1666010076509;
        Mon, 17 Oct 2022 05:34:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d21-20020a9d4f15000000b0066193fe498bsm4807324otl.28.2022.10.17.05.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:34:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 17 Oct 2022 05:34:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Guo Ren <guoren@linux.alibaba.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: Linux 6.1-rc1
Message-ID: <20221017123434.GA1062543@roeck-us.net>
References: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 04:01:33PM -0700, Linus Torvalds wrote:
> You all know the drill: it's Sunday afternoon, the two weeks of merge
> window are over, and now we're supposed to start calming things down.
> 
[ ... ]

> Please get the testing started,
> 

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 490 pass: 420 fail: 70
Failed tests:
	<all big endian mips tests>
	<all riscv tests>

---
The following patches are needed to fix the problems reported below.

Revert "net: fix cpu_max_bits_warn() usage in netif_attrmask_next{,_and}"
Revert "mfd: syscon: Remove repetition of the regmap_get_val_endian()"
RISC-V: KVM: Fix compilation without RISCV_ISA_ZICBOM
powerpc/64s: make linear_map_hash_lock a raw spinlock
powerpc/64s: make HPTE lock and native_tlbie_lock irq-safe
powerpc/64s: Add lockdep for HPTE lock
powerpc: fix reschedule bug in KUAP-unlocked user copy
powerpc/64s: Fix hash__change_memory_range preemption warning
powerpc/64s: Disable preemption in hash lazy mmu mode

---
Build failures

Building riscv:defconfig ... failed
--------------
Error log:
ERROR: modpost: "riscv_cbom_block_size" [arch/riscv/kvm/kvm.ko] undefined!

Caused by commit afd5dde9a186 ("RISC-V: KVM: Provide UAPI for Zicbom block
size"). Suggested fix is at
https://patchwork.kernel.org/project/linux-riscv/patch/20221013134217.1850349-1-ajones@ventanamicro.com/
Last time I checked (10/14) it was still under discussion.

Cc: Andrew Jones <ajones@ventanamicro.com>
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>

================

Runtime failures / warnings

powerpc
-------

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is .__apply_to_page_range+0x734/0xa20
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-12130-g73344a3f6793 #1
Hardware name: PowerMac3,1 PPC970FX 0x3c0301 PowerMac
Call Trace:
[c0000000056075b0] [c000000001085308] .dump_stack_lvl+0xa4/0x100 (unreliable)
[c000000005607640] [c0000000010ba384] .check_preemption_disabled+0x144/0x150
[c0000000056076e0] [c000000000371464] .__apply_to_page_range+0x734/0xa20
[c000000005607820] [c00000000006e21c] .change_memory_attr+0xfc/0x160
[c0000000056078b0] [c0000000002ce778] .bpf_prog_select_runtime+0x78/0x220
[c000000005607950] [c000000000de3a68] .bpf_prepare_filter+0xa18/0xa80
[c000000005607a10] [c000000000de3b6c] .bpf_prog_create+0x9c/0x110
[c000000005607aa0] [c00000000205e0c4] .ptp_classifier_init+0x44/0x78
[c000000005607b30] [c00000000205d260] .sock_init+0xd8/0xf8
[c000000005607bb0] [c000000000010e28] .do_one_initcall+0xa8/0x528
[c000000005607ca0] [c00000000200501c] .kernel_init_freeable+0x3c8/0x478
[c000000005607d90] [c0000000000116bc] .kernel_init+0x2c/0x1c0
[c000000005607e10] [c00000000000ca3c] .ret_from_kernel_thread+0x58/0x60

Not a new problem (seen as far back as v5.15.y), but fixed by:
    "powerpc/64s: Disable preemption in hash lazy mmu mode"
    "powerpc/64s: Fix hash__change_memory_range preemption warning"
    "powerpc: fix reschedule bug in KUAP-unlocked user copy"

at:
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013151647.1857994-1-npiggin@gmail.com/
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013151647.1857994-2-npiggin@gmail.com/
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013151647.1857994-3-npiggin@gmail.com/

================================
WARNING: inconsistent lock state
6.0.0-12130-g73344a3f6793 #1 Tainted: G                 N
--------------------------------
inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
swapper/0/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
c000000002734de8 (native_tlbie_lock){+.?.}-{2:2}, at: .native_hpte_updateboltedpp+0x1a4/0x600
{IN-SOFTIRQ-W} state was registered at:
  .lock_acquire+0x20c/0x520
  ._raw_spin_lock+0x4c/0x70
  .native_hpte_invalidate+0x62c/0x840

Fixed by:
    "powerpc/64s: Add lockdep for HPTE lock"
    "powerpc/64s: make HPTE lock and native_tlbie_lock irq-safe"
    "powerpc/64s: make linear_map_hash_lock a raw spinlock:

at
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013230710.1987253-1-npiggin@gmail.com/
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013230710.1987253-2-npiggin@gmail.com/
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013230710.1987253-3-npiggin@gmail.com/

mips, sparc64
-------------

All big endian mips tests fail to reset after boot. The problem is
caused by commit 72a95859728a ("mfd: syscon: Remove repetition of the
regmap_get_val_endian()").

Cc: Hector Martin <marcan@marcan.st>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>

---
The riscv build failure is hiding a new runtime warning, seen with
32-bit and 64-bit riscv boot tests after the fix for the build problem
was applied.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at include/linux/cpumask.h:110 __netif_set_xps_queue+0x194/0x976
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-12199-g277163563de8 #1
Hardware name: riscv-virtio,qemu (DT)
epc : __netif_set_xps_queue+0x194/0x976
ra : __netif_set_xps_queue+0x3b0/0x976
epc : c089a664 ra : c089a880 sp : c2515c60
gp : c1d8e760 tp : c2578040 t0 : c364f980
t1 : 00000000 t2 : 00001fff s0 : c2515cd0
s1 : c2515ce4 a0 : c364f940 a1 : 00000000
a2 : c364f940 a3 : 00000000 a4 : c364f950
a5 : c364f890 a6 : 00000003 a7 : 00000000
s2 : 00000001 s3 : c1d382c0 s4 : 00000000
s5 : 00000000 s6 : 00000000 s7 : c364f880
s8 : 00000000 s9 : 00000001 s10: 00000001
s11: 00000000 t3 : 00000018 t4 : 7fd38a0e
t5 : 00000007 t6 : c3639470
status: 00000120 badaddr: 00000000 cause: 00000003
[<c074548a>] virtnet_set_affinity+0x13a/0x1a2
[<c07478de>] virtnet_probe+0x884/0xfdc
[<c063ce9a>] virtio_dev_probe+0x1d6/0x354
[<c0683d6e>] really_probe+0x82/0x214
[<c0683f58>] __driver_probe_device+0x58/0xa2
[<c0683fd2>] driver_probe_device+0x30/0xaa
[<c0684596>] __driver_attach+0x56/0x11c
[<c0681f26>] bus_for_each_dev+0x52/0x90
[<c06837c0>] driver_attach+0x1a/0x22
[<c068331a>] bus_add_driver+0x148/0x1b6
[<c0684d70>] driver_register+0x52/0xea
[<c063c924>] register_virtio_driver+0x1a/0x28
[<c0c2428e>] virtio_net_driver_init+0x7a/0xa6
[<c0002824>] do_one_initcall+0x5e/0x2e2
[<c0c01130>] kernel_init_freeable+0x298/0x306
[<c0aa0ac2>] kernel_init+0x1e/0x10e
[<c0003ad8>] ret_from_exception+0x0/0x10
irq event stamp: 106012
hardirqs last  enabled at (106011): [<c0aa9284>] _raw_spin_unlock_irqrestore+0x54/0x62
hardirqs last disabled at (106012): [<c0007534>] __trace_hardirqs_off+0xc/0x14
softirqs last  enabled at (105764): [<c0886392>] napi_get_frags_check+0x0/0x50
softirqs last disabled at (105758): [<c0886392>] napi_get_frags_check+0x0/0x50
---[ end trace 0000000000000000 ]---

This is is caused (triggered ? exposed ?) by commit 854701ba4c39
("net: fix cpu_max_bits_warn() usage in netif_attrmask_next{,_and}").

A revert for this patch is at:

https://lore.kernel.org/netdev/166582921612.1299.769135677399153914.git-patchwork-notify@kernel.org/T/#m0111a76380626b2f91e072ecdd5827578d5cbf60

This revert has been applied to the net tree.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Guo Ren <guoren@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>
