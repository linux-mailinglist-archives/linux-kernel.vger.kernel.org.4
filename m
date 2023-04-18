Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E7C6E59AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDRGwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDRGwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:52:03 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF1DB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:52:01 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id az21so4924701uab.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681800721; x=1684392721;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hp0XNqgOxN0jHiEBMPLnuKYmXYYKQTsCxDFskt07CVU=;
        b=Pp8k3hDa2pau1c/gvwXJvkERahosmKokvAvgeiv8Phgk1fbZKvWxADo1l/qIPmTyZr
         dvag6n9re1LHwa0DeYS5AUW7JeeDcwkqOCYQ2+eoCSZZ+4OKsa9VGXEHrqs1cRcIyCXM
         0sxvE6iHKd5DpDXA2GFZpnhre7uLb0eDnwtPpAfT2qqohUngoBtmTID+kORmF7AmJQT2
         yGO2On+cqn3kDm9MADRuTTOlJarB7IufCISmcjMH3dfppbyqnCILE/uy0edSIhYYLz+7
         sqzCHcPRYvfmFPpJPKEZR+cueqrdi9X+pNztvHucd1l04bN1odZYfyQpyOa3gjb/Qp2S
         dgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681800721; x=1684392721;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hp0XNqgOxN0jHiEBMPLnuKYmXYYKQTsCxDFskt07CVU=;
        b=dl25m3aEezCM0YgjwrN0cCkdH3LqSxJ6tFkEXKm3KXPIK2U0Kz5ssSiAEaOsNhnWTS
         u26ajIgthjVpbK3U9Rcs8KVXpOozoOPkQu9yi4vm1G6BrmEtkQu8ejS5KMYZ5c8v7+08
         I3l0p4RsWIKdgNVcelRY/6RFuyIGegkSFGWvWWbCB7ju1mTXaPp66/zQS04/v6ulbLMC
         5wjhTP+ZPpddEqP7nC2JgUiae1nKmllAN2WZZXTKpWevOcEtG0wDapQz2J/dnrXdJhZC
         yVwM/5BE9GafwXfvRLWUduhrVzTINtYxA4XtAvkgwT9xIGY5EQunmy0QKioIJnSZgFKb
         ys7Q==
X-Gm-Message-State: AAQBX9c+ut7aVaZvoGSs/3vYPQS3VsHKjq/KuvZHBkhqS1xW1ZSDe2sa
        oYnbDECsbOIRT+bmkHUAm8ZjiIzLt6ZECH09FNLGEQ==
X-Google-Smtp-Source: AKy350bmuiyr34tY79AiuQxdtg7ydQY7130Ec6+48bFCUANsJGQnWWSyTq+RB5GJWeKuygCc9+5yI+LNZ5k0TKYwEYk=
X-Received: by 2002:a1f:6045:0:b0:440:3223:61d4 with SMTP id
 u66-20020a1f6045000000b00440322361d4mr5516929vkb.3.1681800720628; Mon, 17 Apr
 2023 23:52:00 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Apr 2023 12:21:49 +0530
Message-ID: <CA+G9fYv70wipaANT2Yau4xjfVHx1muyV-Eae8F8atoAV4cJHxw@mail.gmail.com>
Subject: next: armv7: kernel BUG at mm/slub.c:4240! - PC is at __kmem_cache_create+0x580/0x588
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel crash noticed on armv7 running Linux next-20230418.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.3.0-rc7-next-20230417 (tuxmake@tuxmake)
(Debian clang version 16.0.1
(++20230404073039+c3591d714b49-1~exp1~20230404193157.68), Debian LLD
16.0.1) #1 SMP @1681755305
[    0.000000] CPU: ARMv7 Processor [414fc0f0] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: linux,dummy-virt
[    0.000000] random: crng init done
[    0.000000] OF: fdt: Ignoring memory range 0x100000000 - 0x140000000
[    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 64 MiB at 0xfb800000
[    0.000000] Zone ranges:
[    0.000000]   DMA      empty
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000040000000-0x00000000ffffefff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000ffffefff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000ffffefff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 17 pages/cpu s37076 r8192 d24364 u69632
[    0.000000] pcpu-alloc: s37076 r8192 d24364 u69632 alloc=17*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1
[    0.000000] Kernel command line: console=ttyAMA0,115200 rootwait
root=/dev/vda debug verbose console_msg_format=syslog earlycon
<5>[    0.000000] Unknown kernel command line parameters \"verbose\",
will be passed to user space.
<6>[    0.000000] Dentry cache hash table entries: 1024 (order: 0,
4096 bytes, linear)
<6>[    0.000000] Inode-cache hash table entries: 1024 (order: 0, 4096
bytes, linear)
<6>[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 786431
<6>[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
<6>[    0.000000] Memory: 3016344K/3145724K available (19456K kernel
code, 2715K rwdata, 9148K rodata, 2048K init, 497K bss, 63844K
reserved, 65536K cma-reserved, 2293756K highmem)
<4>[    0.000000] swapper: page allocation failure: order:0,
mode:0x0(), nodemask=(null)
<4>[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
6.3.0-rc7-next-20230417 #1
<4>[    0.000000] Hardware name: Generic DT based system
<4>[    0.000000]  unwind_backtrace from show_stack+0x28/0x2c
<4>[    0.000000]  show_stack from dump_stack_lvl+0x60/0x78
<4>[    0.000000]  dump_stack_lvl from warn_alloc+0x110/0x198
<4>[    0.000000]  warn_alloc from __alloc_pages_slowpath+0xbd0/0xc58
<4>[    0.000000]  __alloc_pages_slowpath from __alloc_pages+0x240/0x26c
<4>[    0.000000]  __alloc_pages from new_slab+0x180/0x554
<4>[    0.000000]  new_slab from __kmem_cache_create+0x1e8/0x588
<4>[    0.000000]  __kmem_cache_create from create_boot_cache+0x9c/0xc4
<4>[    0.000000]  create_boot_cache from kmem_cache_init+0x8c/0x150
<4>[    0.000000]  kmem_cache_init from mm_core_init+0x34/0x44
<4>[    0.000000]  mm_core_init from start_kernel+0x18c/0x3b4
<4>[    0.000000]  start_kernel from 0x0
<4>[    0.000000] Mem-Info:
<4>[    0.000000] active_anon:0 inactive_anon:0 isolated_anon:0
<4>[    0.000000]  active_file:0 inactive_file:0 isolated_file:0
<4>[    0.000000]  unevictable:0 dirty:0 writeback:0
<4>[    0.000000]  slab_reclaimable:0 slab_unreclaimable:0
<4>[    0.000000]  mapped:0 shmem:0 pagetables:0
<4>[    0.000000]  sec_pagetables:0 bounce:0
<4>[    0.000000]  kernel_misc_reclaimable:0
<4>[    0.000000]  free:754086 free_pcp:0 free_cma:0
<4>[    0.000000] 0 total pagecache pages
<4>[    0.000000] 0 pages in swap cache
<4>[    0.000000] Free swap  = 0kB
<4>[    0.000000] Total swap = 0kB
<4>[    0.000000] 786431 pages RAM
<4>[    0.000000] 786431 pages HighMem/MovableOnly
<4>[    0.000000] 32345 pages reserved
<4>[    0.000000] 16384 pages cma reserved
<4>[    0.000000] ------------[ cut here ]------------
<2>[    0.000000] kernel BUG at mm/slub.c:4240!
<0>[    0.000000] Internal error: Oops - BUG: 0 [#1] SMP ARM
<4>[    0.000000] Modules linked in:
<4>[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
6.3.0-rc7-next-20230417 #1
<4>[    0.000000] Hardware name: Generic DT based system
<4>[    0.000000] PC is at __kmem_cache_create+0x580/0x588
<4>[    0.000000] LR is at __alloc_pages_slowpath+0xbd0/0xc58
<4>[    0.000000] pc : [<c0553608>]    lr : [<c05380fc>]    psr: 600000d3
<4>[    0.000000] sp : c2201f50  ip : 00000058  fp : c2201f70
<4>[    0.000000] r10: 10c5387d  r9 : c24daa20  r8 : c24d43d8
<4>[    0.000000] r7 : c24daa2c  r6 : c210a1f8  r5 : 00002000  r4 : c210a1f8
<4>[    0.000000] r3 : c2201d08  r2 : 00000000  r1 : 00000000  r0 : 00000000
<4>[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA
ARM  Segment none
<4>[    0.000000] Control: 10c5387d  Table: 4020406a  DAC: 00000051
<1>[    0.000000] Register r0 information: NULL pointer
<1>[    0.000000] Register r1 information: NULL pointer
<1>[    0.000000] Register r2 information: NULL pointer
<1>[    0.000000] Register r3 information: non-slab/vmalloc memory
<1>[    0.000000] Register r4 information: non-slab/vmalloc memory
<1>[    0.000000] Register r5 information: non-paged memory
<1>[    0.000000] Register r6 information: non-slab/vmalloc memory
<1>[    0.000000] Register r7 information: non-slab/vmalloc memory
<1>[    0.000000] Register r8 information: non-slab/vmalloc memory
<1>[    0.000000] Register r9 information: non-slab/vmalloc memory
<1>[    0.000000] Register r10 information: non-paged memory
<1>[    0.000000] Register r11 information: non-slab/vmalloc memory
<1>[    0.000000] Register r12 information: non-paged memory
<0>[    0.000000] Process swapper (pid: 0, stack limit = 0x(ptrval))
<0>[    0.000000] Stack: (0xc2201f50 to 0xc2202000)
<0>[    0.000000] 1f40:                                     c2210c60
00000020 c1cdc50a c210a1f8
<0>[    0.000000] 1f60: 00002000 48000000 c210a1f8 10c5387d c2201f88
c2031b70 c24d43d4 c210a17c
<0>[    0.000000] 1f80: 00000000 c24daa2c c2201fb8 c2034054 00000000
00000000 000b81a6 00000000
<0>[    0.000000] 1fa0: 00000000 c2209f05 00000001 ffffffff 48000000
414fc0f0 c2201fc0 c202f080
<0>[    0.000000] 1fc0: c2201ff0 c20009a4 ffffffff ffffffff 00000000
c2000ca4 c2102a6c 00000000
<0>[    0.000000] 1fe0: c2000420 00000051 10c0387d 10c5387d 00000000
00000000 00000000 00000000
<0>[    0.000000]  __kmem_cache_create from create_boot_cache+0x9c/0xc4
<0>[    0.000000]  create_boot_cache from kmem_cache_init+0x8c/0x150
<0>[    0.000000]  kmem_cache_init from mm_core_init+0x34/0x44
<0>[    0.000000]  mm_core_init from start_kernel+0x18c/0x3b4
<0>[    0.000000]  start_kernel from 0x0
<0>[    0.000000] Code: e3100801 1affff5b eaffff62 e7f001f2 (e7f001f2)
<4>[    0.000000] ---[ end trace 0000000000000000 ]---
<0>[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
<0>[    0.000000] ---[ end Kernel panic - not syncing: Attempted to
kill the idle task! ]---


Details:
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230417/testrun/16276245/suite/boot/test/clang-16-lkftconfig/details/
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230417/testrun/16276245/suite/boot/test/clang-16-lkftconfig/log


--
Linaro LKFT
https://lkft.linaro.org
