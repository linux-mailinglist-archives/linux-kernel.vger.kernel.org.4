Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70268E732
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 05:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjBHEhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 23:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBHEhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 23:37:46 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91BE515C91
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 20:37:42 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8CxPusUJ+NjotYPAA--.30920S3;
        Wed, 08 Feb 2023 12:37:40 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxK74SJ+NjZM0sAA--.19986S3;
        Wed, 08 Feb 2023 12:37:38 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
Subject: Re: [PATCH v2 0/5] LoongArch: Add kernel relocation and KASLR support
To:     Xi Ruoyao <xry111@xry111.site>
References: <20230207142822.52172-1-xry111@xry111.site>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Message-ID: <70278d23-aa0e-19d9-796f-78c0fd06fee0@loongson.cn>
Date:   Wed, 8 Feb 2023 12:37:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230207142822.52172-1-xry111@xry111.site>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxK74SJ+NjZM0sAA--.19986S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZryUAry3KFW3XFWxCrW5trb_yoWrJFWUpF
        W5Zrn8Gr48GF1fZrsxt34rurn0ywn7C3WaqFsIkrySkr1agr1UA3W8tr9rXFyqqw4Fqr4I
        grs5Gw429a1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bOxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2
        zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_WwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0zRVWl
        kUUUUU=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao

On 02/07/2023 10:28 PM, Xi Ruoyao wrote:
> This patch series to support kernel relocation and KASLR (only 64bit).
>
> I've only tested new toolchains (CONFIG_AS_HAS_EXPLICIT_RELOCS=y)
> consisted of Binutils-2.40, and GCC-12.2 heavily patched to support new
> relocs.  Unfortunately I've purged my old toolchain installation (because
> it contained a buggy GCC-12.1 miscompiling some code).  Please test the
> configuration with old toolchain.
I tested it through QEMU.

Testing in the new toolchains is successful,
/ # dmesg | head
[    0.000000] Linux version 6.2.0-rc7+ (root@bogon) 
(loongarch64-unknown-linux-gnu-gcc (GCC) 13.0.0 20220906 (experimental), 
GNU ld (GNU Binutils) 2.39.50.20220906) #67 SMP PREEMPT Wed Feb  8 
09:42:49 CST 2023
/ # cat /proc/iomem | head
00000000-0fffffff : System RAM
   00000000-002c3fff : Reserved
   002c4000-008c3fff : Reserved
   02a50000-0399ffff : Kernel code
   039a0000-0426d9ff : Kernel data
   0426da00-0439ae37 : Kernel bss


But testing in the old toolchains failed, stuck in the following
position,
[    0.000000] Linux version 6.2.0-rc7+ (root@bogon) 
(loongarch64-unknown-linux-gnu-gcc (GCC) 12.1.0, GNU ld (GNU Binutils) 
2.38.50.20220519) #68 SMP PREEMPT Wed Feb  8 09:52:49 CST 2023
...
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[    0.000000] Constant clock event device register
[    0.000000] clocksource: Constant: mask: 0xffffffffffffffff 
max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000289] sched_clock: 64 bits at 100MHz, resolution 10ns, wraps 
every 4398046511100ns
[    0.000715] Constant clock source device register


In the case of "[Patch v2 2/5] LoongArch: use la.pcrel instenad of
la.abs for exception handlerS", the above failure will occur.

Patch2 may have certain problems when using the old toolchains.

Youling.

>
> Test results with CONFIG_RANDOMIZE_BASE=y on a 3A5000-7A2000-EVB:
>
> First boot:
>
> $ sudo cat /proc/iomem | grep Kernel
>   010e0000-018fffff : Kernel code
>   01900000-01e4b5ff : Kernel data
>   01e4b600-01f56e9f : Kernel bss
>
> Second boot:
>
> $ sudo cat /proc/iomem | grep Kernel
>   019a0000-021bffff : Kernel code
>   021c0000-0270b5ff : Kernel data
>   0270b600-02816e9f : Kernel bss
>
> Changes from v1:
>
> - Relocate the handlers instead of using a trampoline, to avoid
>   performance issue on NUMA systems.
> - Fix compiler warnings.
>
> Xi Ruoyao (2):
>   LoongArch: Use la.pcrel instead of la.abs when it's trivially possible
>   LoongArch: Use la.pcrel instead of la.abs for exception handlers
>
> Youling Tang (3):
>   LoongArch: Add JUMP_LINK_ADDR macro implementation to avoid using
>     la.abs
>   LoongArch: Add support for kernel relocation
>   LoongArch: Add support for kernel address space layout randomization
>     (KASLR)
>
>  arch/loongarch/Kconfig                  |  37 +++++
>  arch/loongarch/Makefile                 |   5 +
>  arch/loongarch/include/asm/page.h       |   6 +
>  arch/loongarch/include/asm/setup.h      |   6 +-
>  arch/loongarch/include/asm/stackframe.h |  13 +-
>  arch/loongarch/include/asm/uaccess.h    |   1 -
>  arch/loongarch/kernel/Makefile          |   2 +
>  arch/loongarch/kernel/entry.S           |   2 +-
>  arch/loongarch/kernel/genex.S           |  40 ++++-
>  arch/loongarch/kernel/head.S            |  30 +++-
>  arch/loongarch/kernel/relocate.c        | 211 ++++++++++++++++++++++++
>  arch/loongarch/kernel/setup.c           |   3 +
>  arch/loongarch/kernel/traps.c           | 138 +++++++++++++---
>  arch/loongarch/kernel/vmlinux.lds.S     |  11 +-
>  arch/loongarch/mm/tlb.c                 |  23 +--
>  arch/loongarch/mm/tlbex.S               |  72 +++++++-
>  arch/loongarch/power/suspend_asm.S      |   5 +-
>  17 files changed, 543 insertions(+), 62 deletions(-)
>  create mode 100644 arch/loongarch/kernel/relocate.c
>

