Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE25D65A931
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 07:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjAAGun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 01:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAAGul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 01:50:41 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F10E635F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 22:50:36 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jl4so19928215plb.8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 22:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LBCH4BHUo5M6JviH8BV7Ke1MiCzPMaqx5TQQY3KdvJI=;
        b=PKNqExVewppBtRUomaxG0OiaDj64Ecus9Nx3h0UM9d51aKtKOl+6jgyaUvymw9lRRQ
         GFWvQ3ng+UruMHsDGKMWdtMxI3PJ7L3AyZToBolr90CZVK217IwrzhDxnRpGOMmttGhV
         aK6XijCkCUUE2eZVexFRllhpCnD2Fb4ABVwaBJ8IencbyVfBwS2FI/xaUTVzBX5iYg0X
         4rqF3o7lNysczoGsftnW8K/ezUehfMBlFnWN6q5ChjdPlv6cOoCrZYvtvlOlRbspzMfH
         NuNl/MvpWGiH0cdqkBM/F4Y4GabyQwnAbKF+CGbMTj+dmRVtNCSBxaUxvHgGcZXWp4QG
         mJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBCH4BHUo5M6JviH8BV7Ke1MiCzPMaqx5TQQY3KdvJI=;
        b=73cTTpZh9wpb0RqmCaP5Dt+90c8U0nmmSW5DrsfEJzYnLFa2+pBVNc8jUh4sHvfPyl
         mrgkjH62RMARP1dhU42L3E+Hyt7xFaLrigOxVwILwcuLfUp+iIieIC5JSerPy+FAXLyE
         //p0oEYFuq9QxOaxG940agNisV8Xpgn+LfTZ8lCtJS8COQqSyIuMd9sbHyL7EF1WcNJJ
         A2YVaLYCoj1zsQt1aJFaK0fOpbx/CI4odLD8iEgRj+Vj1jHv3xOg9XXry1+8XZl02X2K
         YZ9fFQNyO7gARKx3fD1Xqltn9Uaxov3/G4Yx70KzpgY+Afz6BdR9UNQaIIDf7Y7TWUKq
         WfuQ==
X-Gm-Message-State: AFqh2krqBLYGzHjMwxASwl6noJEEQJaW/0MFL5XMgS7QT6iGpRYjCFkc
        UZlYyCjpPhReVr5Qs6o7wk5sZo5A/U15tA==
X-Google-Smtp-Source: AMrXdXtH+7Vh/0S4AWR4pEkbtCOVK386aDKiIgAnMCrVfjZ6WIkxYwJcFZRM5Nt8DoP4tjLvRWjCzQ==
X-Received: by 2002:a17:902:8f8a:b0:189:cbf6:9534 with SMTP id z10-20020a1709028f8a00b00189cbf69534mr36616722plo.0.1672555835394;
        Sat, 31 Dec 2022 22:50:35 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b0017f73caf588sm17753648plh.218.2022.12.31.22.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 22:50:34 -0800 (PST)
Date:   Sun, 1 Jan 2023 15:50:28 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [linus:master] [mm, slub]  0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y7EtNNzfxuiX/VEg@hyeyoo>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ASl+wY6T4lyYuGgs"
Content-Disposition: inline
In-Reply-To: <202212312021.bc1efe86-oliver.sang@intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ASl+wY6T4lyYuGgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 31, 2022 at 11:26:25PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed kernel_BUG_at_include/linux/mm.h due to commit (built with gcc-11):
> 
> commit: 0af8489b0216fa1dd83e264bef8063f2632633d7 ("mm, slub: remove percpu slabs with CONFIG_SLUB_TINY")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linux-next/master c76083fac3bae1a87ae3d005b5cb1cbc761e31d5]
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: default
> 	torture_type: tasks-tracing
> 
> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202212312021.bc1efe86-oliver.sang@intel.com
> 
> 

<snip>

> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-6.1.0-rc2-00014-g0af8489b0216 .config
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.


I was unable to reproduce in the same way as described above
because some files referenced in job-script couldn't be downloaded from
download.01.org/0day :(

So I just built rcutorture module as builtin
and I got weird spinlock bug on commit: 0af8489b0216
("mm, slub: remove percpu slabs with CONFIG_SLUB_TINY")

full dmesg added as attachment

[ 1387.564837][   T57] BUG: unable to handle page fault for address: c108f5f4
[ 1387.566649][   T57] #PF: supervisor write access in kernel mode
[ 1387.567965][   T57] #PF: error_code(0x0003) - permissions violation
[ 1387.569439][   T57] *pde = 010001e1 
[ 1387.570276][   T57] Oops: 0003 [#1] SMP
[ 1387.571149][   T57] CPU: 2 PID: 57 Comm: rcu_torture_rea Tainted: G S                 6.1.0-rc2-00010-g0af8489b0216 #2130 63d19ac2b985fca570c354d8750f489755de37ed
[ 1387.574673][   T57] EIP: kvm_kick_cpu+0x54/0x90
[ 1387.575802][   T57] Code: 2f c5 01 8b 04 9d e0 d4 4e c4 83 15 14 7b 2f c5 00 83 05 08 6d 2f c5 01 0f b7 0c 30 b8 05 00 00 00 83 15 0c 6d 2f c5 00 31 db <0f> 01 c1 83 05 10 6d 2f c5 01 8b 5d f8 8b 75 fc 83 15 14 6d 2f c5
[ 1387.580456][   T57] EAX: 00000005 EBX: 00000000 ECX: 00000003 EDX: c108f5a0
[ 1387.582071][   T57] ESI: c5153580 EDI: 00000046 EBP: c69cddf8 ESP: c69cddf0
[ 1387.583775][   T57] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010046
[ 1387.585643][   T57] CR0: 80050033 CR2: c108f5f4 CR3: 0776b000 CR4: 00350e90
[ 1387.587492][   T57] Call Trace:
[ 1387.588365][   T57]  __pv_queued_spin_unlock_slowpath+0x66/0x110
[ 1387.589898][   T57]  __pv_queued_spin_unlock+0x4b/0x60
[ 1387.591040][   T57]  __raw_callee_save___pv_queued_spin_unlock+0x9/0x10
[ 1387.592771][   T57]  do_raw_spin_unlock+0x49/0xa0
[ 1387.593805][   T57]  _raw_spin_unlock_irqrestore+0x53/0xd0
[ 1387.594927][   T57]  swake_up_one+0x4f/0x70
[ 1387.595739][   T57]  __rcu_report_exp_rnp+0x26b/0x470
[ 1387.596730][   T57]  rcu_report_exp_cpu_mult+0x82/0x2f0
[ 1387.597770][   T57]  rcu_qs+0xac/0x160
[ 1387.598503][   T57]  rcu_note_context_switch+0x31/0x1e0
[ 1387.599460][   T57]  __schedule+0xc5/0x770
[ 1387.600195][   T57]  __cond_resched+0x7a/0x100
[ 1387.600996][   T57]  stutter_wait+0x9e/0x2c0
[ 1387.601956][   T57]  rcu_torture_reader+0x162/0x3e0
[ 1387.603048][   T57]  ? rcu_torture_reader+0x3e0/0x3e0
[ 1387.604269][   T57]  ? __kthread_parkme+0xab/0xf0
[ 1387.605420][   T57]  kthread+0x167/0x1d0
[ 1387.606383][   T57]  ? rcu_torture_read_exit_child+0xa0/0xa0
[ 1387.607516][   T57]  ? kthread_exit+0x50/0x50
[ 1387.608517][   T57]  ret_from_fork+0x19/0x24
[ 1387.609548][   T57] Modules linked in:
[ 1387.610187][   T57] CR2: 00000000c108f5f4
[ 1387.610873][   T57] ---[ end trace 0000000000000000 ]---
[ 1387.611829][   T57] EIP: kvm_kick_cpu+0x54/0x90
[ 1387.612653][   T57] Code: 2f c5 01 8b 04 9d e0 d4 4e c4 83 15 14 7b 2f c5 00 83 05 08 6d 2f c5 01 0f b7 0c 30 b8 05 00 00 00 83 15 0c 6d 2f c5 00 31 db <0f> 01 c1 83 05 10 6d 2f c5 01 8b 5d f8 8b 75 fc 83 15 14 6d 2f c5
[ 1387.616715][   T57] EAX: 00000005 EBX: 00000000 ECX: 00000003 EDX: c108f5a0
[ 1387.618242][   T57] ESI: c5153580 EDI: 00000046 EBP: c69cddf8 ESP: c69cddf0
[ 1387.619912][   T57] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010046
[ 1387.621666][   T57] CR0: 80050033 CR2: c108f5f4 CR3: 0776b000 CR4: 00350e90
[ 1387.623128][   T57] Kernel panic - not syncing: Fatal exception
[ 1389.285045][   T57] Shutting down cpus with NMI
[ 1389.297949][   T57] Kernel Offset: disabled
[ 1389.299174][   T57] ---[ end Kernel panic - not syncing: Fatal exception ]---

--ASl+wY6T4lyYuGgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable

=1Bc=1B[?7l=1B[2J=1B[0mSeaBIOS (version 1.14.0-2)=0D


iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+BFF8B330+BFECB330 CA00=
=0D
Press Ctrl-B to configure iPXE (PCI 00:03.0)...=0D                         =
                                                      =0D


Booting from ROM..=1Bc=1B[?7l=1B[2J[    0.000000][    T0] Linux version 6.1=
=2E0-rc2-00010-g0af8489b0216 (hyeyoo@hyeyoo) (gcc-11 (Ubuntu 11.2.0-7ubuntu=
2) 11.2.0, GNU ld (GNU Binutils for Ubuntu) 2.37) #2130 SMP Sun Jan  1 15:1=
6:04 KST 2023=0D
[    0.000000][    T0] KERNEL supported cpus:=0D
[    0.000000][    T0]   Intel GenuineIntel=0D
[    0.000000][    T0]   Vortex Vortex86 SoC=0D
[    0.000000][    T0] CPU: vendor_id 'AuthenticAMD' unknown, using generic=
 init.=0D
[    0.000000][    T0] CPU: Your system may be unstable.=0D
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floati=
ng point registers'=0D
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE regist=
ers'=0D
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX regist=
ers'=0D
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x200: 'Protection=
 Keys User registers'=0D
[    0.000000][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  2=
56=0D
[    0.000000][    T0] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:   =
 8=0D
[    0.000000][    T0] x86/fpu: Enabled xstate features 0x207, context size=
 is 840 bytes, using 'compacted' format.=0D
[    0.000000][    T0] signal: max sigframe size: 3376=0D
[    0.000000][    T0] BIOS-provided physical RAM map:=0D
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbf=
f] usable=0D
[    0.000000][    T0] BIOS-e820: [mem 0x000000000009fc00-0x000000000009fff=
f] reserved=0D
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000f0000-0x00000000000ffff=
f] reserved=0D
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdeff=
f] usable=0D
[    0.000000][    T0] BIOS-e820: [mem 0x00000000bffdf000-0x00000000bffffff=
f] reserved=0D
[    0.000000][    T0] BIOS-e820: [mem 0x00000000feffc000-0x00000000fefffff=
f] reserved=0D
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffc0000-0x00000000fffffff=
f] reserved=0D
[    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x000000013ffffff=
f] usable=0D
[    0.000000][    T0] Notice: NX (Execute Disable) protection cannot be en=
abled: non-PAE kernel!=0D
[    0.000000][    T0] Hypervisor detected: KVM=0D
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00=0D
[    0.000004][    T0] kvm-clock: using sched offset of 400952663 cycles=0D
[    0.000006][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max=
_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns=0D
[    0.000012][    T0] tsc: Detected 3693.060 MHz processor=0D
[    0.000388][    T0] last_pfn =3D 0xbffdf max_arch_pfn =3D 0x100000=0D
[    0.000392][    T0] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT=
  UC- UC  =0D
[    0.001738][    T0] found SMP MP-table at [mem 0x000f5ca0-0x000f5caf]=0D
[    0.001788][    T0] RAMDISK: [mem 0x773d8000-0x7fffffff]=0D
[    0.001790][    T0] Allocated new RAMDISK: [mem 0x2e3d6000-0x36ffda19]=0D
[    0.020456][    T0] Move RAMDISK from [mem 0x773d8000-0x7ffffa19] to [me=
m 0x2e3d6000-0x36ffda19]=0D
[    0.020466][    T0] ACPI: Early table checksum verification disabled=0D
[    0.020473][    T0] ACPI: RSDP 0x00000000000F5C60 000014 (v00 BOCHS )=0D
[    0.020480][    T0] ACPI: RSDT 0x00000000BFFE1795 000034 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.020485][    T0] ACPI: FACP 0x00000000BFFE1631 000074 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.020490][    T0] ACPI: DSDT 0x00000000BFFDFDC0 001871 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.020493][    T0] ACPI: FACS 0x00000000BFFDFD80 000040=0D
[    0.020495][    T0] ACPI: APIC 0x00000000BFFE16A5 000090 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.020498][    T0] ACPI: HPET 0x00000000BFFE1735 000038 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.020501][    T0] ACPI: WAET 0x00000000BFFE176D 000028 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.020504][    T0] ACPI: Reserving FACP table memory at [mem 0xbffe1631=
-0xbffe16a4]=0D
[    0.020506][    T0] ACPI: Reserving DSDT table memory at [mem 0xbffdfdc0=
-0xbffe1630]=0D
[    0.020506][    T0] ACPI: Reserving FACS table memory at [mem 0xbffdfd80=
-0xbffdfdbf]=0D
[    0.020507][    T0] ACPI: Reserving APIC table memory at [mem 0xbffe16a5=
-0xbffe1734]=0D
[    0.020508][    T0] ACPI: Reserving HPET table memory at [mem 0xbffe1735=
-0xbffe176c]=0D
[    0.020509][    T0] ACPI: Reserving WAET table memory at [mem 0xbffe176d=
-0xbffe1794]=0D
[    0.020525][    T0] 2191MB HIGHMEM available.=0D
[    0.020526][    T0] 879MB LOWMEM available.=0D
[    0.020527][    T0]   mapped low ram: 0 - 36ffe000=0D
[    0.020528][    T0]   low ram: 0 - 36ffe000=0D
[    0.020535][    T0] Zone ranges:=0D
[    0.020536][    T0]   Normal   [mem 0x0000000000001000-0x0000000036ffdff=
f]=0D
[    0.020538][    T0]   HighMem  [mem 0x0000000036ffe000-0x00000000bffdeff=
f]=0D
[    0.020539][    T0] Movable zone start for each node=0D
[    0.020540][    T0] Early memory node ranges=0D
[    0.020541][    T0]   node   0: [mem 0x0000000000001000-0x000000000009ef=
ff]=0D
[    0.020542][    T0]   node   0: [mem 0x0000000000100000-0x00000000bffdef=
ff]=0D
[    0.020550][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x00000=
000bffdefff]=0D
[    0.023822][    T0] On node 0, zone Normal: 1 pages in unavailable range=
s=0D
[    0.026469][    T0] On node 0, zone Normal: 97 pages in unavailable rang=
es=0D
[    0.033027][    T0] Using APIC driver default=0D
[    0.033189][    T0] ACPI: PM-Timer IO Port: 0x608=0D
[    0.033193][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])=0D
[    0.033221][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000=
, GSI 0-23=0D
[    0.033224][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl =
dfl)=0D
[    0.033226][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high=
 level)=0D
[    0.033227][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)=0D
[    0.033229][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 hi=
gh level)=0D
[    0.033230][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 hi=
gh level)=0D
[    0.033232][    T0] ACPI: Using ACPI (MADT) for SMP configuration inform=
ation=0D
[    0.033233][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000=0D
[    0.033236][    T0] TSC deadline timer available=0D
[    0.033242][    T0] smpboot: Allowing 4 CPUs, 0 hotplug CPUs=0D
[    0.033262][    T0] kvm-guest: KVM setup pv remote TLB flush=0D
[    0.033265][    T0] kvm-guest: setup PV sched yield=0D
[    0.033277][    T0] [mem 0xc0000000-0xfeffbfff] available for PCI device=
s=0D
[    0.033279][    T0] Booting paravirtualized kernel on KVM=0D
[    0.033283][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 1910969940391419 ns=0D
[    0.033288][    T0] setup_percpu: NR_CPUS:8 nr_cpumask_bits:4 nr_cpu_ids=
:4 nr_node_ids:1=0D
[    0.034139][    T0] percpu: Embedded 351 pages/cpu s1407772 r0 d29924 u1=
437696=0D
[    0.034184][    T0] kvm-guest: PV spinlocks enabled=0D
[    0.034186][    T0] PV qspinlock hash table entries: 512 (order: 0, 4096=
 bytes, linear)=0D
[    0.034201][    T0] Built 1 zonelists, mobility grouping on.  Total page=
s: 784101=0D
[    0.034203][    T0] Kernel command line: console=3DttyS0 nokaslr numa=3D=
fake=3D4 page_owner=3Don mminit_loglevel=3D7 slub_max_order=3D0=0D
[    0.034356][    T0] Unknown kernel command line parameters "nokaslr numa=
=3Dfake=3D4", will be passed to user space.=0D
[    0.034391][    T0] random: crng init done=0D
[    0.034515][    T0] Dentry cache hash table entries: 131072 (order: 7, 5=
24288 bytes, linear)=0D
[    0.034520][    T0] Inode-cache hash table entries: 65536 (order: 6, 262=
144 bytes, linear)=0D
[    0.039432][    T0] allocated 47245320 bytes of page_ext=0D
[    0.039434][    T0] mem auto-init: stack:off, heap alloc:off, heap free:=
off=0D
[    0.039438][    T0] stackdepot hash table entries: 65536 (order: 6, 2621=
44 bytes, linear)=0D
[    0.039440][    T0] Initializing HighMem for node 0 (00036ffe:000bffdf)=
=0D
[    0.255783][    T0] Initializing Movable for node 0 (00000000:00000000)=
=0D
[    0.257032][    T0] Checking if this processor honours the WP bit even i=
n supervisor mode...Ok.=0D
[    0.257039][    T0] Memory: 2830080K/3145204K available (39873K kernel c=
ode, 10453K rwdata, 15080K rodata, 2656K init, 19064K bss, 315124K reserved=
, 0K cma-reserved, 2244484K highmem)=0D
[    0.257083][    T0] SLUB: HWalign=3D64, Order=3D0-0, MinObjects=3D0, CPU=
s=3D4, Nodes=3D1=0D
[    0.257413][    T0] Node 0, zone   Normal: page owner found early alloca=
ted 10 pages=0D
[    0.257431][    T0] Node 0, zone  HighMem: page owner found early alloca=
ted 0 pages=0D
[    0.257559][    T0] trace event string verifier disabled=0D
[    0.257722][    T0] Running RCU self tests=0D
[    0.257736][    T0] rcu: Hierarchical RCU implementation.=0D
[    0.257737][    T0] rcu: 	RCU lockdep checking is enabled.=0D
[    0.257738][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=3D8 to nr_cp=
u_ids=3D4.=0D
[    0.257740][    T0] 	Trampoline variant of Tasks RCU enabled.=0D
[    0.257742][    T0] 	Rude variant of Tasks RCU enabled.=0D
[    0.257743][    T0] 	Tracing variant of Tasks RCU enabled.=0D
[    0.257744][    T0] rcu: RCU calculated value of scheduler-enlistment de=
lay is 100 jiffies.=0D
[    0.257746][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr=
_cpu_ids=3D4=0D
[    0.261721][    T0] NR_IRQS: 2304, nr_irqs: 72, preallocated irqs: 16=0D
[    0.261974][    T0] rcu: srcu_init: Setting srcu_struct sizes based on c=
ontention.=0D
[    0.309659][    T0] printk: console [ttyS0] enabled=0D
[    0.309923][    T0] Lock dependency validator: Copyright (c) 2006 Red Ha=
t, Inc., Ingo Molnar=0D
[    0.310363][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8=0D
[    0.310612][    T0] ... MAX_LOCK_DEPTH:          48=0D
[    0.310865][    T0] ... MAX_LOCKDEP_KEYS:        8192=0D
[    0.311132][    T0] ... CLASSHASH_SIZE:          4096=0D
[    0.311398][    T0] ... MAX_LOCKDEP_ENTRIES:     32768=0D
[    0.311663][    T0] ... MAX_LOCKDEP_CHAINS:      65536=0D
[    0.311929][    T0] ... CHAINHASH_SIZE:          32768=0D
[    0.312205][    T0]  memory used by lock dependency info: 4061 kB=0D
[    0.312557][    T0]  memory used for stack traces: 2112 kB=0D
[    0.312849][    T0]  per task-struct memory footprint: 2112 bytes=0D
[    0.313179][    T0] ACPI: Core revision 20220331=0D
[    0.313558][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 19112604467 ns=0D
[    0.314154][    T0] APIC: Switch to symmetric I/O mode setup=0D
[    0.314455][    T0] Enabling APIC mode:  Flat.  Using 1 I/O APICs=0D
[    0.314780][    T0] kvm-guest: setup PV IPIs=0D
[    0.315763][    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1=
 pin2=3D-1=0D
[    0.316143][    T0] tsc: Marking TSC unstable due to TSCs unsynchronized=
=0D
[    0.316515][    T0] Calibrating delay loop (skipped) preset value.. 7386=
=2E12 BogoMIPS (lpj=3D3693060)=0D
[    0.316987][    T0] pid_max: default: 32768 minimum: 301=0D
[    0.317531][    T0] LSM: Security Framework initializing=0D
[    0.317821][    T0] landlock: Up and running.=0D
[    0.318055][    T0] LoadPin: ready to pin (currently not enforcing)=0D
[    0.318547][    T0] Mount-cache hash table entries: 2048 (order: 1, 8192=
 bytes, linear)=0D
[    0.318976][    T0] Mountpoint-cache hash table entries: 2048 (order: 1,=
 8192 bytes, linear)=0D
[    0.320037][    T0] x86/cpu: User Mode Instruction Prevention (UMIP) act=
ivated=0D
[    0.320436][    T0] mce: unknown CPU type - not enabling MCE support=0D
[    0.320518][    T0] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0=0D
[    0.320839][    T0] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0=
=0D
[    0.321194][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers an=
d __user pointer sanitization=0D
[    0.321512][    T0] Spectre V2 : Kernel not compiled with retpoline; no =
mitigation available!=0D
[    0.321514][    T0] Spectre V2 : Vulnerable=0D
[    0.322511][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Fil=
ling RSB on context switch=0D
[    0.322982][    T0] Spectre V2 : Enabling Restricted Speculation for fir=
mware calls=0D
[    0.323513][    T0] Spectre V2 : mitigation: Enabling conditional Indire=
ct Branch Prediction Barrier=0D
[    0.323995][    T0] Speculative Store Bypass: Mitigation: Speculative St=
ore Bypass disabled via prctl=0D
[    0.324511][    T0] MMIO Stale Data: Unknown: No mitigations=0D
[    0.325241][    T0] Freeing SMP alternatives memory: 40K=0D
[    0.325701][    T1] smpboot: CPU0: AuthenticAMD AMD Ryzen 9 5900X 12-Cor=
e Processor (family: 0x19, model: 0x21, stepping: 0x0)=0D
[    0.326509][    T1] cblist_init_generic: Setting adjustable number of ca=
llback queues.=0D
[    0.326514][    T1] cblist_init_generic: Setting shift to 2 and lim to 1=
=2E=0D
[    0.326931][    T1] cblist_init_generic: Setting shift to 2 and lim to 1=
=2E=0D
[    0.327343][    T1] cblist_init_generic: Setting shift to 2 and lim to 1=
=2E=0D
[    0.327564][    T1] Running RCU-tasks wait API self tests=0D
[    0.435625][    T1] Performance Events: no PMU driver, software events o=
nly.=0D
[    0.436197][    T1] rcu: Hierarchical SRCU implementation.=0D
[    0.436514][    T1] rcu: 	Max phase no-delay instances is 400.=0D
[    0.438238][    T1] NMI watchdog: Perf NMI watchdog permanently disabled=
=0D
[    0.438708][    T1] smp: Bringing up secondary CPUs ...=0D
[    0.439395][    T1] x86: Booting SMP configuration:=0D
[    0.439520][    T1] .... node  #0, CPUs:      #1=0D
[    0.054529][    T0] smpboot: CPU 1 Converting physical 0 to logical die =
1=0D
[    0.451921][    T1]  #2=0D
[    0.054529][    T0] smpboot: CPU 2 Converting physical 0 to logical die =
2=0D
[    0.463949][   T11] Callback from call_rcu_tasks_trace() invoked.=0D
[    0.464582][    T1]  #3=0D
[    0.054529][    T0] smpboot: CPU 3 Converting physical 0 to logical die =
3=0D
[    0.476576][    T1] smp: Brought up 1 node, 4 CPUs=0D
[    0.476842][    T1] smpboot: Max logical packages: 4=0D
[    0.477108][    T1] smpboot: Total of 4 processors activated (29544.48 B=
ogoMIPS)=0D
[    0.478017][    T1] devtmpfs: initialized=0D
[    0.478696][    T1] version magic: 0x4231322a=0D
[    0.481205][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1911260446275000 ns=0D
[    0.481524][    T1] futex hash table entries: 1024 (order: 4, 65536 byte=
s, linear)=0D
[    0.481988][    T1] pinctrl core: initialized pinctrl subsystem=0D
[    0.482310][    T1] pinctrl core: failed to create debugfs directory=0D
[    0.482894][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family=
=0D
[    0.484036][    T1] thermal_sys: Registered thermal governor 'step_wise'=
=0D
[    0.484039][    T1] thermal_sys: Registered thermal governor 'user_space=
'=0D
[    0.484438][    T1] cpuidle: using governor ladder=0D
[    0.485136][    T1] PCI: PCI BIOS revision 2.10 entry at 0xfd1d0, last b=
us=3D0=0D
[    0.485514][    T1] PCI: Using configuration type 1 for base access=0D
[    0.510154][    T1] kprobes: kprobe jump-optimization is enabled. All kp=
robes are optimized if possible.=0D
[    0.513790][    T1] HugeTLB: registered 4.00 MiB page size, pre-allocate=
d 0 pages=0D
[    0.514394][    T1] HugeTLB: 0 KiB vmemmap can be freed for a 4.00 MiB p=
age=0D
[    0.515443][    T1] cryptd: max_cpu_qlen set to 1000=0D
[    0.516103][    T1] gpio-f7188x: Unsupported Fintek device 0xffff=0D
[    0.516531][    T1] gpio-f7188x: Unsupported Fintek device 0xffff=0D
[    0.517344][    T1] ACPI: Added _OSI(Module Device)=0D
[    0.518520][    T1] ACPI: Added _OSI(Processor Device)=0D
[    0.518876][    T1] ACPI: Added _OSI(3.0 _SCP Extensions)=0D
[    0.519245][    T1] ACPI: Added _OSI(Processor Aggregator Device)=0D
[    0.523634][    T1] ACPI: 1 ACPI AML tables successfully acquired and lo=
aded=0D
[    0.526125][    T1] ACPI: Interpreter enabled=0D
[    0.526429][    T1] ACPI: PM: (supports S0 S5)=0D
[    0.526519][    T1] ACPI: Using IOAPIC for interrupt routing=0D
[    0.526865][    T1] PCI: Using host bridge windows from ACPI; if necessa=
ry, use "pci=3Dnocrs" and report a bug=0D
[    0.527479][    T1] PCI: Using E820 reservations for host bridge windows=
=0D
[    0.527886][    T1] ACPI: Enabled 2 GPEs in block 00 to 0F=0D
[    0.538914][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff=
])=0D
[    0.539353][    T1] acpi PNP0A03:00: _OSC: OS supports [Segments HPX-Typ=
e3]=0D
[    0.539515][    T1] acpi PNP0A03:00: PCIe port services disabled; not re=
questing _OSC control=0D
[    0.540001][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, c=
an't access extended PCI configuration space under this bridge.=0D
[    0.541534][    T1] acpi resource window ([0x140000000-0x1bfffffff] igno=
red, not CPU addressable)=0D
[    0.542592][    T1] PCI host bridge to bus 0000:00=0D
[    0.542960][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf=
7 window]=0D
[    0.543515][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]=0D
[    0.543524][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]=0D
[    0.543972][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0=
xfebfffff window]=0D
[    0.544795][   T10] Callback from call_rcu_tasks_rude() invoked.=0D
[    0.544411][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]=0D
[    0.544931][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=
=0D
[    0.546349][    T1] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100=
=0D
[    0.546918][    T1] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180=
=0D
[    0.549342][    T1] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]=0D
[    0.549955][    T1] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0=
x01f0-0x01f7]=0D
[    0.550405][    T1] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0=
x03f6]=0D
[    0.550514][    T1] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0=
x0170-0x0177]=0D
[    0.550934][    T1] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0=
x0376]=0D
[    0.551461][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=
=0D
[    0.551733][    T1] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed=
 by PIIX4 ACPI=0D
[    0.552297][    T1] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed=
 by PIIX4 SMB=0D
[    0.553684][    T1] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000=
=0D
[    0.557520][    T1] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffff=
ff pref]=0D
[    0.569520][    T1] pci 0000:00:02.0: reg 0x18: [mem 0xfebb0000-0xfebb0f=
ff]=0D
[    0.591522][    T1] pci 0000:00:02.0: reg 0x30: [mem 0xfeba0000-0xfebaff=
ff pref]=0D
[    0.592342][    T1] pci 0000:00:02.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]=0D
[    0.594709][    T1] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000=
=0D
[    0.608517][    T1] pci 0000:00:03.0: reg 0x10: [mem 0xfeb80000-0xfeb9ff=
ff]=0D
[    0.620534][    T1] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]=0D
[    0.686517][    T1] pci 0000:00:03.0: reg 0x30: [mem 0xfeb00000-0xfeb7ff=
ff pref]=0D
[    0.689517][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10=
=0D
[    0.690272][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10=
=0D
[    0.690814][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11=
=0D
[    0.691571][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11=
=0D
[    0.692206][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9=
=0D
[    0.694072][    T1] iommu: Default domain type: Translated =0D
[    0.694448][    T1] iommu: DMA domain TLB invalidation policy: lazy mode=
 =0D
[    0.695523][    T1] SCSI subsystem initialized=0D
[    0.695857][    T1] ACPI: bus type USB registered=0D
[    0.696170][    T1] usbcore: registered new interface driver usbfs=0D
[    0.696534][    T1] usbcore: registered new interface driver hub=0D
[    0.696879][    T1] usbcore: registered new device driver usb=0D
[    0.697390][    T1] cec: Failed to create debugfs cec dir=0D
[    0.698669][    T1] FPGA manager framework=0D
[    0.699350][    T1] PCI: Using ACPI for IRQ routing=0D
[    0.699660][    T1] dcdbas dcdbas: Dell Systems Management Base Driver (=
version 5.6.0-3.4)=0D
[    0.700364][    T1] clocksource: Switched to clocksource kvm-clock=0D
[    0.755598][    T9] Callback from call_rcu_tasks() invoked.=0D
[    0.779906][    T1] VFS: Disk quotas dquot_6.6.0=0D
[    0.780256][    T1] VFS: Dquot-cache hash table entries: 1024 (order 0, =
4096 bytes)=0D
[    0.780832][    T1] FS-Cache: Loaded=0D
[    0.781358][    T1] CacheFiles: Loaded=0D
[    0.781694][    T1] pnp: PnP ACPI init=0D
[    0.783150][    T1] pnp: PnP ACPI: found 6 devices=0D
[    0.819007][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns=0D
[    0.819835][    T1] intel_rapl_common: driver does not support CPU famil=
y 25 model 33=0D
[    0.820309][    T1] NET: Registered PF_INET protocol family=0D
[    0.820702][    T1] IP idents hash table entries: 16384 (order: 5, 13107=
2 bytes, linear)=0D
[    0.821502][    T1] tcp_listen_portaddr_hash hash table entries: 512 (or=
der: 2, 24576 bytes, linear)=0D
[    0.822023][    T1] Table-perturb hash table entries: 65536 (order: 6, 2=
62144 bytes, linear)=0D
[    0.822494][    T1] TCP established hash table entries: 8192 (order: 3, =
32768 bytes, linear)=0D
[    0.823083][    T1] TCP bind hash table entries: 8192 (order: 7, 786432 =
bytes, linear)=0D
[    0.823728][    T1] TCP: Hash tables configured (established 8192 bind 8=
192)=0D
[    0.824161][    T1] UDP hash table entries: 512 (order: 3, 57344 bytes, =
linear)=0D
[    0.824587][    T1] UDP-Lite hash table entries: 512 (order: 3, 57344 by=
tes, linear)=0D
[    0.825068][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family=0D
[    0.825860][    T1] RPC: Registered named UNIX socket transport module.=
=0D
[    0.826233][    T1] RPC: Registered udp transport module.=0D
[    0.826550][    T1] RPC: Registered tcp transport module.=0D
[    0.826841][    T1] RPC: Registered tcp NFSv4.1 backchannel transport mo=
dule.=0D
[    0.827226][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]=0D
[    0.827605][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff windo=
w]=0D
[    0.827972][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bff=
ff window]=0D
[    0.828377][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfff=
ff window]=0D
[    0.828909][    T1] pci 0000:00:01.0: PIIX3: Enabling Passive Release=0D
[    0.829260][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers=
=0D
[    0.829629][    T1] pci 0000:00:01.0: Activating ISA DMA hang workaround=
s=0D
[    0.830014][    T1] PCI: CLS 0 bytes, default 64=0D
[    0.830287][    T1] sta2x11_mfd_init=0D
[    0.830692][    T7] Unpacking initramfs...=0D
[    0.833441][   T50] cryptomgr_test (50) used greatest stack depth: 7128 =
bytes left=0D
[    0.833531][    T1] The force parameter has not been set to 1. The Iris =
poweroff handler will not be installed.=0D
[    0.834811][    T1] rcu-torture:--- Start of test: nreaders=3D3 nfakewri=
ters=3D4 stat_interval=3D60 verbose=3D1 test_no_idle_hz=3D1 shuffle_interva=
l=3D3 stutter=3D5 irqreader=3D1 fqs_duration=3D0 fqs_holdoff=3D0 fqs_stutte=
r=3D3 test_boost=3D1/0 test_boost_interval=3D7 test_boost_duration=3D4 shut=
down_secs=3D0 stall_cpu=3D0 stall_cpu_holdoff=3D10 stall_cpu_irqsoff=3D0 st=
all_cpu_block=3D0 n_barrier_cbs=3D0 onoff_interval=3D0 onoff_holdoff=3D0 re=
ad_exit_delay=3D13 read_exit_burst=3D16 nocbs_nthreads=3D0 nocbs_toggle=3D1=
000=0D
[    0.837004][    T1] rcu:  Start-test grace-period state: g-1159 f0x0=0D
[    0.837345][    T1] rcu_torture_write_types: Testing conditional GPs.=0D
[    0.837699][    T1] rcu_torture_write_types: Testing conditional expedit=
ed GPs.=0D
[    0.838090][    T1] rcu_torture_write_types: Testing conditional full-st=
ate GPs.=0D
[    0.838493][    T1] rcu_torture_write_types: Testing expedited GPs.=0D
[    0.838844][    T1] rcu_torture_write_types: Testing asynchronous GPs.=0D
[    0.839194][    T1] rcu_torture_write_types: Testing polling GPs.=0D
[    0.839540][    T1] rcu_torture_write_types: Testing polling full-state =
GPs.=0D
[    0.839916][    T1] rcu_torture_write_types: Testing polling expedited G=
Ps.=0D
[    0.840290][    T1] rcu_torture_write_types: Testing polling full-state =
expedited GPs.=0D
[    0.840726][    T1] rcu_torture_write_types: Testing normal GPs.=0D
[    0.841050][    T1] rcu-torture: Creating rcu_torture_writer task=0D
[    0.841657][   T52] rcu-torture: rcu_torture_writer task started=0D
[    0.841660][    T1] rcu-torture: Creating rcu_torture_fakewriter task=0D
[    0.842181][   T52] rcu-torture: GP expediting controlled from boot/sysf=
s for rcu.=0D
[    0.842820][    T1] rcu-torture: Creating rcu_torture_fakewriter task=0D
[    0.843566][   T53] rcu-torture: rcu_torture_fakewriter task started=0D
[    0.843783][    T1] rcu-torture: Creating rcu_torture_fakewriter task=0D
[    0.844502][   T54] rcu-torture: rcu_torture_fakewriter task started=0D
[    0.844883][    T1] rcu-torture: Creating rcu_torture_fakewriter task=0D
[    0.844893][   T55] rcu-torture: rcu_torture_fakewriter task started=0D
[    0.845989][    T1] rcu-torture: Creating rcu_torture_reader task=0D
[    0.846008][   T56] rcu-torture: rcu_torture_fakewriter task started=0D
[    0.846467][    T1] rcu-torture: Creating rcu_torture_reader task=0D
[    0.847179][   T57] rcu-torture: rcu_torture_reader task started=0D
[    0.847625][    T1] rcu-torture: Creating rcu_torture_reader task=0D
[    0.847644][   T58] rcu-torture: rcu_torture_reader task started=0D
[    0.848995][    T1] rcu-torture: Creating rcu_torture_stats task=0D
[    0.849002][   T59] rcu-torture: rcu_torture_reader task started=0D
[    0.850229][    T1] rcu-torture: Creating torture_shuffle task=0D
[    0.850246][   T60] rcu-torture: rcu_torture_stats task started=0D
[    0.854723][    T1] rcu-torture: Creating torture_stutter task=0D
[    0.854749][   T61] rcu-torture: torture_shuffle task started=0D
[    0.858792][   T63] rcu-torture: torture_stutter task started=0D
[    0.858810][    T1] rcu-torture: Creating rcu_torture_fwd_prog task=0D
[    0.859832][    T1] rcu-torture: Creating rcu_torture_read_exit task=0D
[    0.859847][   T64] rcu-torture: rcu_torture_fwd_progress task started=0D
[    0.861650][   T65] rcu-torture: rcu_torture_read_exit: Start of test=0D
[    0.862138][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[    1.394362][    T1] Initialise system trusted keyrings=0D
[    1.394744][    T1] Key type blacklist registered=0D
[    1.395125][    T1] workingset: timestamp_bits=3D14 max_order=3D20 bucke=
t_order=3D6=0D
[    1.396147][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher=0D
[    1.397619][    T1] ntfs: driver 2.1.32 [Flags: R/O DEBUG].=0D
[    1.397942][    T1] ntfs3: Max link count 4000=0D
[    1.398184][    T1] ntfs3: Enabled Linux POSIX ACLs support=0D
[    1.398492][    T1] ntfs3: Read-only LZX/Xpress compression included=0D
[    1.398859][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/=0D
[    1.399170][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.=0D
[    1.399472][    T1] QNX4 filesystem 0.2.3 registered.=0D
[    1.399760][    T1] qnx6: QNX6 filesystem 1.0.0 registered.=0D
[    1.400096][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:=0D
[    1.400830][    T1] orangefs_init: module version upstream loaded=0D
[    1.401203][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536=0D
[    1.405663][    T1] SGI XFS with ACLs, security attributes, scrub, repai=
r, no debug enabled=0D
[    1.406663][    T1] NILFS version 2 loaded=0D
[    1.406893][    T1] befs: version: 0.9.3=0D
[    1.408130][    T1] gfs2: GFS2 installed=0D
[    1.416244][    T1] Key type asymmetric registered=0D
[    1.416555][    T1] Asymmetric key parser 'x509' registered=0D
[    1.416880][    T1] Asymmetric key parser 'pkcs8' registered=0D
[    1.417238][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 246)=0D
[    1.417690][    T1] io scheduler mq-deadline registered=0D
[    1.417976][    T1] io scheduler kyber registered=0D
[    1.418245][    T1] io scheduler bfq registered=0D
[    1.420957][    T1] gpio_it87: no device=0D
[    1.421938][    T1] gpio_winbond: chip ID at 2e is ffff=0D
[    1.422229][    T1] gpio_winbond: not an our chip=0D
[    1.422499][    T1] gpio_winbond: chip ID at 4e is ffff=0D
[    1.422792][    T1] gpio_winbond: not an our chip=0D
[    1.423332][    T1] switchtec: loaded.=0D
[    1.423720][    T1] SPI driver hx8357 has no spi_device_id for himax,hx8=
369=0D
[    1.424644][    T1] rivafb_setup START=0D
[    1.424899][    T1] nvidiafb_setup START=0D
[    1.425203][    T1] VIA Graphics Integration Chipset framebuffer 2.4 ini=
tializing=0D
[    1.426542][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0=0D
[    1.426989][    T1] ACPI: button: Power Button [PWRF]=0D
[    1.501113][    T1] N_HDLC line discipline registered with maxframe=3D40=
96=0D
[    1.501483][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing disa=
bled=0D
[    1.502093][    T1] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A=0D
[    1.504412][    T1] MOXA Intellio family driver version 6.0k=0D
[    1.504967][    T1] SyncLink GT=0D
[    1.505158][    T1] SyncLink GT, tty major#235=0D
[    1.505427][    T1] SyncLink GT no devices found=0D
[    3.288449][    T7] Freeing initrd memory: 143520K=0D
[    3.289124][   T86] kworker/u8:1 (86) used greatest stack depth: 6536 by=
tes left=0D
[    3.289229][    T1] lp: driver loaded but no devices found=0D
[    3.290324][    T1] Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:5=
7 dwmw2 Exp $=0D
[    3.290860][    T1] ac.o: No PCI boards found.=0D
[    3.291158][    T1] ac.o: For an ISA board you must supply memory and ir=
q parameters.=0D
[    3.291826][    T1] Non-volatile memory driver v1.3=0D
[    3.292171][    T1] toshiba: not a supported Toshiba laptop=0D
[    3.293122][    T1] platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver=
 Initializing=0D
[    3.293666][    T1] platform pc8736x_gpio.0: no device found=0D
[    3.294089][    T1] smapi::smapi_init, ERROR invalid usSmapiID=0D
[    3.294483][    T1] mwave: tp3780i::tp3780I_InitializeBoardData: Error: =
SMAPI is not available on this machine=0D
[    3.295155][    T1] mwave: mwavedd::mwave_init: Error: Failed to initial=
ize board data=0D
[    3.295687][    T1] mwave: mwavedd::mwave_init: Error: Failed to initial=
ize=0D
[    3.296227][    T1] Hangcheck: starting hangcheck timer 0.9.1 (tick is 1=
80 seconds, margin is 60 seconds).=0D
[    3.296916][    T1] usbcore: registered new interface driver xillyusb=0D
[    3.297360][    T1] ACPI: bus type drm_connector registered=0D
[    3.298300][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0=0D
[    3.299049][    T1] SPI driver panel-innolux-ej030na has no spi_device_i=
d for innolux,ej030na=0D
[    3.299875][    T1] SPI driver nv3052c has no spi_device_id for leadtek,=
ltk035c5444t=0D
[    3.300437][    T1] SPI driver nt39016 has no spi_device_id for kingdisp=
lay,kd035g6-54nt=0D
[    3.301111][    T1] SPI driver db7430-panel has no spi_device_id for sam=
sung,lms397kf04=0D
[    3.301930][    T1] SPI driver ws2401-panel has no spi_device_id for sam=
sung,lms380kf01=0D
[    3.303558][    T1] [drm] Found bochs VGA, ID 0xb0c0.=0D
[    3.303832][    T1] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @=
 0xfebb0000.=0D
[    3.304907][    T1] [drm] Found EDID data blob.=0D
[    3.305401][    T1] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:=
00:02.0 on minor 1=0D
[    3.308072][    T1] bochs-drm 0000:00:02.0: [drm] fb0: bochs-drmdrmfb fr=
ame buffer device=0D
[    3.308664][    T1] usbcore: registered new interface driver gm12u320=0D
[    3.309046][    T1] SPI driver ili9163 has no spi_device_id for newhaven=
,1.8-128160EF=0D
[    3.309481][    T1] SPI driver ili9486 has no spi_device_id for waveshar=
e,rpi-lcd-35=0D
[    3.309908][    T1] SPI driver ili9486 has no spi_device_id for ozzmaker=
,piscreen=0D
[    3.310430][    T1] usbcore: registered new interface driver gud=0D
[    3.311132][    T1] parport_pc 00:03: reported by Plug and Play ACPI=0D
[    3.311627][    T1] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]=
=0D
[    3.403962][    T1] lp0: using parport0 (interrupt-driven).=0D
[    3.404346][    T1] lp0: console ready=0D
[    3.404777][    T1] parport_pc parport_pc.956: Unable to set coherent dm=
a mask: disabling DMA=0D
[    3.405773][    T1] parport_pc parport_pc.888: Unable to set coherent dm=
a mask: disabling DMA=0D
[    3.406724][    T1] parport_pc parport_pc.632: Unable to set coherent dm=
a mask: disabling DMA=0D
[    3.407917][    T1] ibmasm: IBM ASM Service Processor Driver version 1.0=
 loaded=0D
[    3.408400][    T1] dummy-irq: no IRQ given.  Use irq=3DN=0D
[    3.408943][    T1] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Ro=
dolfo Giometti=0D
[    3.409851][    T1] usbcore: registered new interface driver rtsx_usb=0D
[    3.410334][    T1] habanalabs: loading driver=0D
[    3.412216][    T1] snic:SNIC Driver is supported only for x86_64 platfo=
rms!=0D
[    3.412694][    T1] snic:Cisco SCSI NIC Driver, ver 0.0.1.18=0D
[    3.413101][    T1] snic:Trace Facility Enabled.=0D
[    3.413101][    T1]  Trace Buffer SZ 16 Pages.=0D
[    3.414604][    T1] Adaptec aacraid driver 1.2.1[50983]-custom=0D
[    3.415035][    T1] aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0=
=2E3 loaded=0D
[    3.415760][    T1] isci: Intel(R) C600 SAS Controller Driver - version =
1.2.0=0D
[    3.416315][    T1] Microchip SmartPQI Driver (v2.1.18-045)=0D
[    3.416752][    T1] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:=
01:03 EST 2006)=0D
[    3.417279][    T1] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:3=
5 EST 2006)=0D
[    3.417735][    T1] megasas: 07.719.03.00-rc1=0D
[    3.418020][    T1] mpt3sas version 43.100.00.00 loaded=0D
[    3.418629][    T1] 3ware Storage Controller device driver for Linux v1.=
26.02.003.=0D
[    3.419064][    T1] 3ware 9000 Storage Controller device driver for Linu=
x v2.26.02.014.=0D
[    3.419611][    T1] LSI 3ware SAS/SATA-RAID Controller device driver for=
 Linux v3.26.02.000.=0D
[    3.420728][    T1] nsp32: loading...=0D
[    3.420955][    T1] RocketRAID 3xxx/4xxx Controller driver v1.10.0=0D
[    3.421312][    T1] stex: Promise SuperTrak EX Driver version: 6.02.0000=
=2E01=0D
[    3.421866][    T1] VMware PVSCSI driver - version 1.0.7.0-k=0D
[    3.426713][    T1] scsi_debug:sdebug_driver_probe: scsi_debug: trim pol=
l_queues to 0. poll_q/nr_hw =3D (0/1)=0D
[    3.427238][    T1] scsi host0: scsi_debug: version 0191 [20210520]=0D
[    3.427238][    T1]   dev_size_mb=3D8, opts=3D0x0, submit_queues=3D1, st=
atistics=3D0=0D
[    3.429009][   T35] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug =
      0191 PQ: 0 ANSI: 7=0D
[    3.432040][    T1] SSFDC read-only Flash Translation layer=0D
[    3.432368][    T1] mtdoops: mtd device (mtddev=3Dname/number) must be s=
upplied=0D
[    3.432578][   T35] scsi 0:0:0:0: Attached scsi generic sg0 type 0=0D
[    3.432792][    T1] L440GX flash mapping: failed to find PIIX4 ISA bridg=
e, cannot continue=0D
[    3.433993][    T1] Ramix PMC551 PCI Mezzanine Ram Driver. (C) 1999,2000=
 Nortel Networks.=0D
[    3.434441][    T1] pmc551: not detected=0D
[    3.434908][    T1] Driver 'dfl-spi-altera' was unable to register with =
bus_type 'dfl' because the bus was not initialized.=0D
[    3.549960][    T1] parport0: AVR Butterfly=0D
[    3.550748][    T1] e1000: Intel(R) PRO/1000 Network Driver=0D
[    3.551120][    T1] e1000: Copyright (c) 1999-2006 Intel Corporation.=0D
[    3.765706][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11=0D
[    4.055076][    T1] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00=
:12:34:56=0D
[    4.055685][    T1] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network C=
onnection=0D
[    4.056949][    T1] VFIO - User Level meta-driver version: 0.3=0D
[    4.057771][    T1] parport0: cannot grant exclusive access for device k=
s0108=0D
[    4.058310][    T1] ks0108: ERROR: parport didn't register new device=0D
[    4.058809][    T1] cfag12864b: ERROR: ks0108 is not initialized=0D
[    4.059253][    T1] cfag12864bfb: ERROR: cfag12864b is not initialized=0D
[    4.060122][    T1] panel: could not claim access to parport0. Aborting.=
=0D
[    4.060740][    T1] panel: panel driver not yet registered=0D
[    4.061918][    T1] Warning! fotg210_hcd should always be loaded before =
uhci_hcd and ohci_hcd, not after=0D
[    4.062774][    T1] usbcore: registered new interface driver cdc_acm=0D
[    4.063248][    T1] cdc_acm: USB Abstract Control Model driver for USB m=
odems and ISDN adapters=0D
[    4.063953][    T1] usbcore: registered new interface driver usblp=0D
[    4.064425][    T1] usbcore: registered new interface driver cdc_wdm=0D
[    4.064798][    T1] usbcore: registered new interface driver usbtmc=0D
[    4.065158][    T1] usbcore: registered new interface driver mdc800=0D
[    4.065618][    T1] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MD=
C800 Digital Camera=0D
[    4.066272][    T1] usbcore: registered new interface driver microtekX6=
=0D
[    4.066860][    T1] usbcore: registered new interface driver belkin_sa=0D
[    4.067396][    T1] usbserial: USB Serial support registered for Belkin =
/ Peracom / GoHubs USB Serial Adapter=0D
[    4.068160][    T1] usbcore: registered new interface driver cp210x=0D
[    4.068675][    T1] usbserial: USB Serial support registered for cp210x=
=0D
[    4.069195][    T1] usbcore: registered new interface driver cyberjack=0D
[    4.069728][    T1] usbserial: USB Serial support registered for Reiner =
SCT Cyberjack USB card reader=0D
[    4.070458][    T1] usbcore: registered new interface driver cypress_m8=
=0D
[    4.070990][    T1] usbserial: USB Serial support registered for DeLorme=
 Earthmate USB=0D
[    4.071637][    T1] usbserial: USB Serial support registered for HID->CO=
M RS232 Adapter=0D
[    4.072303][    T1] usbserial: USB Serial support registered for Nokia C=
A-42 V2 Adapter=0D
[    4.072942][    T1] usbcore: registered new interface driver io_edgeport=
=0D
[    4.073481][    T1] usbserial: USB Serial support registered for Edgepor=
t 2 port adapter=0D
[    4.074096][    T1] usbserial: USB Serial support registered for Edgepor=
t 4 port adapter=0D
[    4.074735][    T1] usbserial: USB Serial support registered for Edgepor=
t 8 port adapter=0D
[    4.075360][    T1] usbserial: USB Serial support registered for EPiC de=
vice=0D
[    4.075922][    T1] usbcore: registered new interface driver empeg=0D
[    4.076412][    T1] usbserial: USB Serial support registered for empeg=0D
[    4.076836][    T1] usbcore: registered new interface driver f81534a_ctr=
l=0D
[    4.077217][    T1] usbcore: registered new interface driver f81232=0D
[    4.077722][    T1] usbserial: USB Serial support registered for f81232=
=0D
[    4.078255][    T1] usbserial: USB Serial support registered for f81534a=
=0D
[    4.078799][    T1] usbcore: registered new interface driver garmin_gps=
=0D
[    4.079313][    T1] usbserial: USB Serial support registered for Garmin =
GPS usb/tty=0D
[    4.079920][    T1] usbcore: registered new interface driver ipaq=0D
[    4.080417][    T1] usbserial: USB Serial support registered for PocketP=
C PDA=0D
[    4.080973][    T1] usbcore: registered new interface driver ir_usb=0D
[    4.081464][    T1] usbserial: USB Serial support registered for IR Dong=
le=0D
[    4.082026][    T1] usbcore: registered new interface driver iuu_phoenix=
=0D
[    4.082717][    T1] usbserial: USB Serial support registered for iuu_pho=
enix=0D
[    4.083273][    T1] usbcore: registered new interface driver keyspan=0D
[    4.083826][    T1] usbserial: USB Serial support registered for Keyspan=
 - (without firmware)=0D
[    4.084538][    T1] usbserial: USB Serial support registered for Keyspan=
 1 port adapter=0D
[    4.085172][    T1] usbserial: USB Serial support registered for Keyspan=
 2 port adapter=0D
[    4.085814][    T1] usbserial: USB Serial support registered for Keyspan=
 4 port adapter=0D
[    4.086433][    T1] usbcore: registered new interface driver keyspan_pda=
=0D
[    4.086973][    T1] usbserial: USB Serial support registered for Keyspan=
 PDA=0D
[    4.087564][    T1] usbserial: USB Serial support registered for Keyspan=
 PDA - (prerenumeration)=0D
[    4.088251][    T1] usbcore: registered new interface driver kl5kusb105=
=0D
[    4.088655][    T1] usbserial: USB Serial support registered for KL5KUSB=
105D / PalmConnect=0D
[    4.089112][    T1] usbcore: registered new interface driver mct_u232=0D
[    4.089588][    T1] usbserial: USB Serial support registered for MCT U23=
2=0D
[    4.090117][    T1] usbcore: registered new interface driver mxuport=0D
[    4.090632][    T1] usbserial: USB Serial support registered for MOXA UP=
ort=0D
[    4.091179][    T1] usbcore: registered new interface driver omninet=0D
[    4.091697][    T1] usbserial: USB Serial support registered for ZyXEL -=
 omni.net usb=0D
[    4.092309][    T1] usbcore: registered new interface driver opticon=0D
[    4.092820][    T1] usbserial: USB Serial support registered for opticon=
=0D
[    4.093348][    T1] usbcore: registered new interface driver qcaux=0D
[    4.093843][    T1] usbserial: USB Serial support registered for qcaux=0D
[    4.094371][    T1] usbcore: registered new interface driver safe_serial=
=0D
[    4.094927][    T1] usbserial: USB Serial support registered for safe_se=
rial=0D
[    4.095498][    T1] usbcore: registered new interface driver sierra=0D
[    4.096050][    T1] usbserial: USB Serial support registered for Sierra =
USB modem=0D
[    4.096662][    T1] usbcore: registered new interface driver usb_serial_=
simple=0D
[    4.097217][    T1] usbserial: USB Serial support registered for carelin=
k=0D
[    4.097752][    T1] usbserial: USB Serial support registered for zio=0D
[    4.098285][    T1] usbserial: USB Serial support registered for funsoft=
=0D
[    4.098886][    T1] usbserial: USB Serial support registered for flashlo=
ader=0D
[    4.099497][    T1] usbserial: USB Serial support registered for google=
=0D
[    4.100086][    T1] usbserial: USB Serial support registered for libtran=
sistor=0D
[    4.100726][    T1] usbserial: USB Serial support registered for vivopay=
=0D
[    4.101308][    T1] usbserial: USB Serial support registered for moto_mo=
dem=0D
[    4.101921][    T1] usbserial: USB Serial support registered for motorol=
a_tetra=0D
[    4.102575][    T1] usbserial: USB Serial support registered for nokia=0D
[    4.103100][    T1] usbserial: USB Serial support registered for novatel=
_gps=0D
[    4.103493][    T1] usbserial: USB Serial support registered for hp4x=0D
[    4.103860][    T1] usbserial: USB Serial support registered for suunto=
=0D
[    4.104226][    T1] usbserial: USB Serial support registered for siemens=
_mpi=0D
[    4.104630][    T1] usbcore: registered new interface driver spcp8x5=0D
[    4.104986][    T1] usbserial: USB Serial support registered for SPCP8x5=
=0D
[    4.105363][    T1] usbcore: registered new interface driver ssu100=0D
[    4.105724][    T1] usbserial: USB Serial support registered for Quatech=
 SSU-100 USB to Serial Driver=0D
[    4.106229][    T1] usbcore: registered new interface driver symbolseria=
l=0D
[    4.106620][    T1] usbserial: USB Serial support registered for symbol=
=0D
[    4.106991][    T1] usbcore: registered new interface driver visor=0D
[    4.107334][    T1] usbserial: USB Serial support registered for Handspr=
ing Visor / Palm OS=0D
[    4.107799][    T1] usbserial: USB Serial support registered for Sony Cl=
ie 5.0=0D
[    4.108191][    T1] usbserial: USB Serial support registered for Sony Cl=
ie 3.5=0D
[    4.108602][    T1] usbcore: registered new interface driver wishbone_se=
rial=0D
[    4.108992][    T1] usbserial: USB Serial support registered for wishbon=
e_serial=0D
[    4.109403][    T1] usbcore: registered new interface driver xsens_mt=0D
[    4.109771][    T1] usbserial: USB Serial support registered for xsens_m=
t=0D
[    4.110154][    T1] usbcore: registered new interface driver cypress_cy7=
c63=0D
[    4.110624][    T1] usbcore: registered new interface driver cytherm=0D
[    4.110983][    T1] usbcore: registered new interface driver emi26 - fir=
mware loader=0D
[    4.111413][    T1] usbcore: registered new interface driver emi62 - fir=
mware loader=0D
[    4.111852][    T1] usbcore: registered new device driver apple-mfi-fast=
charge=0D
[    4.112255][    T1] usbcore: registered new interface driver idmouse=0D
[    4.112624][    T1] usbcore: registered new interface driver iowarrior=0D
[    4.112992][    T1] usbcore: registered new interface driver usblcd=0D
[    4.113345][    T1] usbcore: registered new interface driver legousbtowe=
r=0D
[    4.113739][    T1] usbcore: registered new interface driver trancevibra=
tor=0D
[    4.114130][    T1] usbcore: registered new interface driver uss720=0D
[    4.114471][    T1] uss720: USB Parport Cable driver for Cables using th=
e Lucent Technologies USS720 Chip=0D
[    4.114989][    T1] uss720: NOTE: this is a special purpose driver to al=
low nonstandard=0D
[    4.115412][    T1] uss720: protocols (eg. bitbang) over USS720 usb to p=
arallel cables=0D
[    4.115842][    T1] uss720: If you just want to connect to a printer, us=
e usblp instead=0D
[    4.116289][    T1] usbcore: registered new interface driver usbsevseg=0D
[    4.116668][    T1] usbcore: registered new interface driver yurex=0D
[    4.117081][    T1] usbcore: registered new interface driver sisusb=0D
[    4.117449][    T1] usbcore: registered new device driver onboard-usb-hu=
b=0D
[    4.117993][    T1] dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, dri=
ver 02 May 2005=0D
[    4.118425][    T1] dummy_hcd dummy_hcd.0: Dummy host controller=0D
[    4.118917][    T1] dummy_hcd dummy_hcd.0: new USB bus registered, assig=
ned bus number 1=0D
[    4.119954][    T1] hub 1-0:1.0: USB hub found=0D
[    4.120238][    T1] hub 1-0:1.0: 1 port detected=0D
[    4.121464][    T1] SPI driver max3420-udc has no spi_device_id for maxi=
m,max3421-udc=0D
[    4.121996][    T1] zero gadget.0: Gadget Zero, version: Cinco de Mayo 2=
008=0D
[    4.122376][    T1] zero gadget.0: zero ready=0D
[    4.122826][    T1] gadgetfs: USB Gadget filesystem, version 24 Aug 2004=
=0D
[    4.123203][    T1] UDC core: g_serial: couldn't find an available UDC=0D
[    4.123640][    T1] UDC core: printer: couldn't find an available UDC=0D
[    4.124031][    T1] UDC core: g_acm_ms: couldn't find an available UDC=0D
[    4.124454][    T1] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU=
] at 0x60,0x64 irq 1,12=0D
[    4.125495][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1=0D
[    4.125836][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12=0D
[    4.126353][    T1] parport0: cannot grant exclusive access for device p=
arkbd=0D
[    4.150061][    T1] SPI driver ads7846 has no spi_device_id for ti,tsc20=
46=0D
[    4.150434][    T1] SPI driver ads7846 has no spi_device_id for ti,ads78=
43=0D
[    4.150817][    T1] SPI driver ads7846 has no spi_device_id for ti,ads78=
45=0D
[    4.151184][    T1] SPI driver ads7846 has no spi_device_id for ti,ads78=
73=0D
[    4.151732][   T40] input: AT Translated Set 2 keyboard as /devices/plat=
form/i8042/serio0/input/input1=0D
[    4.153051][    T1] SPI driver cyttsp-spi has no spi_device_id for cypre=
ss,cy8ctma340=0D
[    4.153471][    T1] SPI driver cyttsp-spi has no spi_device_id for cypre=
ss,cy8ctst341=0D
[    4.154250][    T1] mk712: device not present=0D
[    4.154589][    T1] usbcore: registered new interface driver usbtouchscr=
een=0D
[    4.155424][    T1] i2c_dev: i2c /dev entries driver=0D
[    4.155857][    T1] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0=
x700, revision 0=0D
[    4.159088][    T1] usbcore: registered new interface driver i2c-diolan-=
u2c=0D
[    4.159584][    T1] usbcore: registered new interface driver i2c-cp2615=
=0D
[    4.159968][    T1] i2c-parport: adapter type unspecified=0D
[    4.160301][    T1] usbcore: registered new interface driver RobotFuzz O=
pen Source InterFace, OSIF=0D
[    4.160837][    T1] usbcore: registered new interface driver i2c-tiny-us=
b=0D
[    4.161369][    T1] IR JVC protocol handler initialized=0D
[    4.161661][    T1] IR RC5(x/sz) protocol handler initialized=0D
[    4.161969][    T1] IR RC6 protocol handler initialized=0D
[    4.162249][    T1] IR RCMM protocol handler initialized=0D
[    4.162559][    T1] IR SANYO protocol handler initialized=0D
[    4.162857][    T1] IR Sharp protocol handler initialized=0D
[    4.163146][    T1] IR XMP protocol handler initialized=0D
[    4.163482][    T1] usbcore: registered new interface driver iguanair=0D
[    4.163862][    T1] usbcore: registered new interface driver imon=0D
[    4.164207][    T1] usbcore: registered new interface driver imon_raw=0D
[    4.164583][    T1] SPI driver ir-spi has no spi_device_id for ir-spi-le=
d=0D
[    4.164987][    T1] usbcore: registered new interface driver streamzap=0D
[    4.165351][    T1] usbcore: registered new interface driver ir_toy=0D
[    4.165717][    T1] usbcore: registered new interface driver ttusbir=0D
[    4.166087][    T1] usbcore: registered new interface driver ati_remote=
=0D
[    4.166455][    T1] Registered IR keymap rc-empty=0D
[    4.166766][    T1] rc rc0: rc-core loopback device as /devices/virtual/=
rc/rc0=0D
[    4.167251][    T1] rc rc0: lirc_dev: driver rc-loopback registered at m=
inor =3D 0, raw IR receiver, raw IR transmitter=0D
[    4.167887][    T1] input: rc-core loopback device as /devices/virtual/r=
c/rc0/input3=0D
[    4.168826][    T1] Driver for 1-wire Dallas network protocol.=0D
[    4.169219][    T1] usbcore: registered new interface driver DS9490R=0D
[    4.346595][   T81] usb 1-1: new high-speed USB device number 2 using du=
mmy_hcd=0D
[    4.484113][    T1] pc87360: PC8736x not detected, module not inserted=0D
[    4.515160][    T1] intel_powerclamp: CPU does not support MWAIT=0D
[    4.515717][    T1] cpufreq_nforce2: No nForce2 chipset=0D
[    4.519164][    T1] SPI driver leds_cr0014114 has no spi_device_id for c=
rane,cr0014114=0D
[    4.519763][    T1] SPI driver leds_el15203000 has no spi_device_id for =
crane,el15203000=0D
[    4.520322][    T1] SPI driver leds_spi_byte has no spi_device_id for ub=
nt,acb-spi-led=0D
[    4.521798][    T1] hid: raw HID events driver (C) Jiri Kosina=0D
[    4.525018][    T1] usbcore: registered new interface driver usbhid=0D
[    4.525357][    T1] usbhid: USB HID core driver=0D
[    4.525733][    T1] usbcore: registered new interface driver es2_ap_driv=
er=0D
[    4.526099][    T1] comedi: version 0.7.76 - http://www.comedi.org=0D
[    4.527644][    T1] usbcore: registered new interface driver dt9812=0D
[    4.528001][    T1] usbcore: registered new interface driver ni6501=0D
[    4.528353][    T1] usbcore: registered new interface driver usbdux=0D
[    4.528732][    T1] usbcore: registered new interface driver vmk80xx=0D
[    4.529781][    T1] dell_smbios: Unable to run on non-Dell system=0D
[    4.530110][    T1] hdaps: supported laptop not found!=0D
[    4.530400][    T1] hdaps: driver init failed (ret=3D-19)!=0D
[    4.531011][    T1] Driver 'dfl-emif' was unable to register with bus_ty=
pe 'dfl' because the bus was not initialized.=0D
[    4.531666][    T1] IDT PCI-E Non-Transparent Bridge Driver 2.0=0D
[    4.532143][    T1] SPI driver xlnx-slave-spi has no spi_device_id for x=
lnx,fpga-slave-serial=0D
[    4.533163][    T1] NET: Registered PF_INET6 protocol family=0D
[    4.534089][    T1] Segment Routing with IPv6=0D
[    4.534453][    T1] In-situ OAM (IOAM) with IPv6=0D
[    4.535005][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver=
=0D
[    4.535965][    T1] NET: Registered PF_PACKET protocol family=0D
[    4.536362][    T1] 9pnet: Installing 9P2000 support=0D
[    4.537968][    T1] mce: Unable to init MCE device (rc: -5)=0D
[    4.538456][    T1] IPI shorthand broadcast: enabled=0D
[    4.539386][    T1] sched_clock: Marking stable (4485310219, 53529074)->=
(4544895601, -6056308)=0D
[    4.540253][    T1] Loading compiled-in X.509 certificates=0D
[    4.542973][    T1] Key type encrypted registered=0D
[    4.543328][    T1] evm: Initialising EVM extended attributes:=0D
[    4.543785][    T1] evm: security.selinux (disabled)=0D
[    4.544136][    T1] evm: security.SMACK64 (disabled)=0D
[    4.544519][    T1] evm: security.SMACK64EXEC (disabled)=0D
[    4.544935][    T1] evm: security.SMACK64TRANSMUTE (disabled)=0D
[    4.545392][    T1] evm: security.SMACK64MMAP (disabled)=0D
[    4.545806][    T1] evm: security.apparmor (disabled)=0D
[    4.546177][    T1] evm: security.ima (disabled)=0D
[    4.546502][    T1] evm: security.capability=0D
[    4.546830][    T1] evm: HMAC attrs: 0x1=0D
[    4.547113][    T1] evm: Error registering secfs=0D
[    4.559141][    T1] UBI error: cannot create "ubi" debugfs directory, er=
ror -2=0D
[    4.559783][    T1] UBI error: cannot initialize UBI, error -2=0D
[    4.560258][    T1] RAS: Correctable Errors collector initialized.=0D
[    4.562187][    T1] Freeing unused kernel image (initmem) memory: 2656K=
=0D
[    4.568828][    T1] Write protecting kernel text and read-only data: 549=
56k=0D
[    4.569148][    T1] Run /init as init process=0D
[    4.573991][  T190] mount (190) used greatest stack depth: 5984 bytes le=
ft=0D
[    4.582099][  T193] mount (193) used greatest stack depth: 5884 bytes le=
ft=0D
[    4.602429][  T202] hostname (202) used greatest stack depth: 5808 bytes=
 left=0D
Starting syslogd: OK=0D
Starting klogd: OK=0D
Running sysctl: OK=0D
Initializing random number generator: FAIL=0D
Starting network: [    4.815998][  T228] ip (228) used greatest stack depth=
: 5292 bytes left=0D
OK=0D
[    4.830720][  T231] process 231 (getty) attempted a POSIX timer syscall =
while CONFIG_POSIX_TIMERS is not set=0D
=0D=0D
Welcome to Buildroot=0D
=0Dbuildroot login: [    5.884632][   T65] rcu-torture: rcu_torture_read_ex=
it: End of episode=0D
root=0D
# [   19.357547][   T65] rcu-torture: rcu_torture_read_exit: Start of episo=
de=0D
[   19.382758][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[   32.923558][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[   36.866196][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[   50.204568][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[   50.231495][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[   62.747571][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[   62.747613][   T60] rcu-torture: =0D
[   62.747929][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[   62.747941][   T60] rtc: b97a5dc1 ver: 3870 tfle: 0 rta: 3871 rtaf: 0 rt=
f: 3859 rtmbe: 0 rtmbkf: 0/3791 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt=
: 67093 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier: 0/0:0 read-exits:=
 64 nocb-toggles: 0:0=0D
[   62.749738][   T60] rcu-torture: Reader Pipe:  14136359 6565 0 0 0 0 0 0=
 0 0 0=0D
[   62.750255][   T60] rcu-torture: Reader Batch:  14123614 19310 0 0 0 0 0=
 0 0 0 0=0D
[   62.750859][   T60] rcu-torture: Free-Block Circulation:  3870 3869 3868=
 3867 3865 3864 3863 3862 3861 3859 0=0D
[   62.803988][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[   62.844049][   T64] rcu_torture_fwd_prog_cr Duration 51 barrier: 40 pend=
ing 2332 n_launders: 3996 n_launders_sa: 2331 n_max_gps: 100 n_max_cbs: 365=
3 cver 3 gps 11=0D
[   62.844739][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 92 jiffies): 1s/10: 7649:15=0D
[   63.579565][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[   63.899577][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[   67.889256][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[   81.244589][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[   81.322773][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[   85.467552][   T64] rcu_torture_fwd_prog_nr: 0 Duration 21564 cver 1397 =
gps 3186=0D
[   85.477771][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[   94.683554][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[   98.878967][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  112.219608][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  112.244947][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  124.187763][   T60] rcu-torture: rtc: 95a097f9 ver: 7773 tfle: 0 rta: 77=
74 rtaf: 0 rtf: 7764 rtmbe: 0 rtmbkf: 0/7597 rtbe: 0 rtbke: 0 rtbre: 0 rtbf=
: 0 rtb: 0 nt: 133791 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier: 0/0=
:0 read-exits: 128 nocb-toggles: 0:0=0D
[  124.188983][   T60] rcu-torture: Reader Pipe:  28865891 12621 0 0 0 0 0 =
0 0 0 0=0D
[  124.189449][   T60] rcu-torture: Reader Batch:  28840036 38476 0 0 0 0 0=
 0 0 0 0=0D
[  124.189988][   T60] rcu-torture: Free-Block Circulation:  7773 7772 7771=
 7770 7769 7768 7767 7766 7765 7764 0=0D
[  125.595547][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  129.880819][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  143.199610][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  143.211459][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  148.764308][   T64] rcu_torture_fwd_prog n_max_cbs: 3653=0D
[  148.764659][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[  148.765057][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[  148.822646][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  148.859499][   T64] rcu_torture_fwd_prog_cr Duration 48 barrier: 36 pend=
ing 1078 n_launders: 3046 n_launders_sa: 1078 n_max_gps: 100 n_max_cbs: 539=
9 cver 4 gps 12=0D
[  148.860878][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 86 jiffies): 1s/10: 8445:15=0D
[  149.917720][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[  156.635560][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  160.910597][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  169.199522][   T64] rcu_torture_fwd_prog_nr: 0 Duration 19274 cver 1084 =
gps 2337=0D
[  169.203548][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  174.235623][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  174.246525][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  185.627570][   T60] rcu-torture: rtc: 6676a49e ver: 11677 tfle: 0 rta: 1=
1678 rtaf: 0 rtf: 11666 rtmbe: 0 rtmbkf: 0/11410 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 199193 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 192 nocb-toggles: 0:0=0D
[  185.628467][   T60] rcu-torture: Reader Pipe:  47487019 18700 0 0 0 0 0 =
0 0 0 0=0D
[  185.628834][   T60] rcu-torture: Reader Batch:  47450547 55172 0 0 0 0 0=
 0 0 0 0=0D
[  185.629178][   T60] rcu-torture: Free-Block Circulation:  11677 11676 11=
674 11673 11672 11671 11669 11668 11667 11666 0=0D
[  187.675604][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  191.885763][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  205.212632][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  205.241551][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  218.587572][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  222.887759][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  230.684573][   T64] rcu_torture_fwd_prog n_max_cbs: 5399=0D
[  230.684797][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[  230.685055][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[  230.752870][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  230.802305][   T64] rcu_torture_fwd_prog_cr Duration 57 barrier: 49 pend=
ing 1833 n_launders: 4772 n_launders_sa: 1832 n_max_gps: 100 n_max_cbs: 345=
0 cver 5 gps 10=0D
[  230.804741][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 109 jiffies): 1s/10: 8222:14=0D
[  231.836618][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[  236.252558][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  236.265482][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  247.067790][   T60] rcu-torture: rtc: 96a6e0fa ver: 15479 tfle: 0 rta: 1=
5480 rtaf: 0 rtf: 15470 rtmbe: 0 rtmbkf: 0/14500 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 264000 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 256 nocb-toggles: 0:0=0D
[  247.068922][   T60] rcu-torture: Reader Pipe:  61400414 24556 0 0 0 0 0 =
0 0 0 0=0D
[  247.069410][   T60] rcu-torture: Reader Batch:  61352754 72216 0 0 0 0 0=
 0 0 0 0=0D
[  247.069899][   T60] rcu-torture: Free-Block Circulation:  15479 15478 15=
477 15476 15475 15474 15473 15472 15471 15470 0=0D
[  249.627564][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  253.929566][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  255.668556][   T64] rcu_torture_fwd_prog_nr: 0 Duration 23816 cver 1383 =
gps 3272=0D
[  255.680605][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  267.292546][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  267.304825][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  280.731632][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  284.898469][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  298.204555][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  298.233602][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  308.508176][   T60] rcu-torture: rtc: 852baa3e ver: 19609 tfle: 0 rta: 1=
9610 rtaf: 0 rtf: 19600 rtmbe: 0 rtmbkf: 0/17896 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 329697 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 320 nocb-toggles: 0:0=0D
[  308.509043][   T60] rcu-torture: Reader Pipe:  75783891 31604 0 0 0 0 0 =
0 0 0 0=0D
[  308.509346][   T60] rcu-torture: Reader Batch:  75723940 91555 0 0 0 0 0=
 0 0 0 0=0D
[  308.509666][   T60] rcu-torture: Free-Block Circulation:  19609 19608 19=
607 19606 19605 19604 19603 19602 19601 19600 0=0D
[  311.643552][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  315.897989][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  316.699800][   T64] rcu_torture_fwd_prog n_max_cbs: 3450=0D
[  316.700102][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[  316.700388][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[  316.739177][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  316.769676][   T64] rcu_torture_fwd_prog_cr Duration 31 barrier: 31 pend=
ing 1462 n_launders: 2959 n_launders_sa: 1461 n_max_gps: 100 n_max_cbs: 194=
5 cver 5 gps 9=0D
[  316.770369][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 62 jiffies): 1s/10: 4904:13=0D
[  317.788672][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[  329.243591][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  329.258583][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  339.293545][   T64] rcu_torture_fwd_prog_nr: 0 Duration 21498 cver 1551 =
gps 3581=0D
[  339.305596][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  342.619550][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  346.896413][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  360.219667][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  360.254579][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  369.947602][   T60] rcu-torture: rtc: 5ae9494e ver: 23450 tfle: 0 rta: 2=
3451 rtaf: 0 rtf: 23440 rtmbe: 0 rtmbkf: 0/20913 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 394847 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 384 nocb-toggles: 0:0=0D
[  369.948506][   T60] rcu-torture: Reader Pipe:  89758302 37513 0 0 0 0 0 =
0 0 0 0=0D
[  369.948938][   T60] rcu-torture: Reader Batch:  89688416 107399 0 0 0 0 =
0 0 0 0 0=0D
[  369.949288][   T60] rcu-torture: Free-Block Circulation:  23450 23449 23=
448 23447 23446 23445 23444 23443 23442 23440 0=0D
[  373.595561][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  377.892901][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  391.196676][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  391.226482][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  402.716677][   T64] rcu_torture_fwd_prog n_max_cbs: 1945=0D
[  402.716975][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[  402.717330][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[  402.768928][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  402.801062][   T64] rcu_torture_fwd_prog_cr Duration 39 barrier: 32 pend=
ing 5478 n_launders: 11916 n_launders_sa: 5477 n_max_gps: 100 n_max_cbs: 77=
58 cver 3 gps 10=0D
[  402.801704][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 72 jiffies): 1s/10: 19674:15=0D
[  403.804666][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[  404.571546][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  408.898722][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  422.237547][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  422.258168][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  424.870528][   T64] rcu_torture_fwd_prog_nr: 0 Duration 21054 cver 1248 =
gps 2895=0D
[  424.875551][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  431.387631][   T60] rcu-torture: rtc: 7649a5a1 ver: 27582 tfle: 0 rta: 2=
7583 rtaf: 0 rtf: 27571 rtmbe: 0 rtmbkf: 0/24163 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 460134 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 448 nocb-toggles: 0:0=0D
[  431.388567][   T60] rcu-torture: Reader Pipe:  105561984 43871 0 0 0 0 0=
 0 0 0 0=0D
[  431.389109][   T60] rcu-torture: Reader Batch:  105481803 124052 0 0 0 0=
 0 0 0 0 0=0D
[  431.389738][   T60] rcu-torture: Free-Block Circulation:  27582 27581 27=
580 27579 27578 27577 27575 27573 27572 27571 0=0D
[  435.611593][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  439.894053][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
=0D
# =0D
# =0D
# =0D
# [  453.340580][   T65] rcu-torture: rcu_torture_read_exit: Start of episo=
de=0D
[  453.349864][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  466.715584][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  470.898469][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  484.315624][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  484.325560][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  488.802553][   T64] rcu_torture_fwd_prog n_max_cbs: 7758=0D
[  488.802783][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[  488.803031][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[  488.944630][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  488.986025][   T64] rcu_torture_fwd_prog_cr Duration 72 barrier: 41 pend=
ing 2174 n_launders: 6366 n_launders_sa: 102 n_max_gps: 100 n_max_cbs: 7056=
 cver 9 gps 18=0D
[  488.986578][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 114 jiffies): 1s/10: 13422:21=0D
[  490.012556][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[  492.827574][   T60] rcu-torture: rtc: 3d8b2018 ver: 31618 tfle: 0 rta: 3=
1618 rtaf: 0 rtf: 31606 rtmbe: 0 rtmbkf: 0/27441 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 526391 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 512 nocb-toggles: 0:0=0D
[  492.828740][   T60] rcu-torture: Reader Pipe:  118729585 50554 0 0 0 0 0=
 0 0 0 0=0D
[  492.829186][   T60] rcu-torture: Reader Batch:  118638692 141447 0 0 0 0=
 0 0 0 0 0=0D
[  492.829601][   T60] rcu-torture: Free-Block Circulation:  31618 31617 31=
616 31615 31613 31612 31610 31609 31608 31606 0=0D
[  497.691593][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  500.356516][   T64] rcu_torture_fwd_prog_nr: 0 Duration 10331 cver 562 g=
ps 1287=0D
[  500.360566][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  501.916616][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  515.228591][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  515.236128][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  528.603566][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  532.907282][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  546.268555][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  546.297080][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  554.267614][   T60] rcu-torture: rtc: e5f7467c ver: 35676 tfle: 0 rta: 3=
5677 rtaf: 0 rtf: 35667 rtmbe: 0 rtmbkf: 0/30755 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 593990 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 576 nocb-toggles: 0:0=0D
[  554.268563][   T60] rcu-torture: Reader Pipe:  132644545 57177 0 0 0 0 0=
 0 0 0 0=0D
[  554.268946][   T60] rcu-torture: Reader Batch:  132540498 161224 0 0 0 0=
 0 0 0 0 0=0D
[  554.269368][   T60] rcu-torture: Free-Block Circulation:  35676 35675 35=
674 35673 35672 35671 35670 35669 35668 35667 0=0D
[  559.643585][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  562.459610][   T64] rcu_torture_fwd_prog n_max_cbs: 7056=0D
[  562.459950][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[  562.460386][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[  562.586882][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  562.639058][   T64] rcu_torture_fwd_prog_cr Duration 122 barrier: 52 pen=
ding 45603 n_launders: 64825 n_launders_sa: 0 n_max_gps: 100 n_max_cbs: 456=
05 cver 0 gps 8=0D
[  562.639599][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 175 jiffies): 1s/10: 57960:8 2s/10: 52470:3=0D
[  563.675563][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[  563.943659][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  573.691537][   T64] rcu_torture_fwd_prog_nr: 0 Duration 10012 cver 285 g=
ps 449=0D
[  573.698562][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  577.436682][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  577.462573][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  590.811566][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  594.915102][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  608.285539][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  608.322593][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  615.707583][   T60] rcu-torture: rtc: 6427cd30 ver: 39157 tfle: 0 rta: 3=
9158 rtaf: 0 rtf: 39148 rtmbe: 0 rtmbkf: 0/33590 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 660823 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 640 nocb-toggles: 0:0=0D
[  615.709088][   T60] rcu-torture: Reader Pipe:  144754337 62887 0 0 0 0 0=
 0 0 0 0=0D
[  615.709773][   T60] rcu-torture: Reader Batch:  144639626 177598 0 0 0 0=
 0 0 0 0 0=0D
[  615.710359][   T60] rcu-torture: Free-Block Circulation:  39157 39156 39=
155 39154 39153 39152 39151 39150 39149 39148 0=0D
[  621.659556][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  625.913387][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  636.187623][   T64] rcu_torture_fwd_prog n_max_cbs: 45605=0D
[  636.187951][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[  636.188290][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[  636.302754][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  636.405716][   T64] rcu_torture_fwd_prog_cr Duration 98 barrier: 103 pen=
ding 13037 n_launders: 16067 n_launders_sa: 1779 n_max_gps: 100 n_max_cbs: =
13882 cver 6 gps 11=0D
[  636.406276][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 201 jiffies): 1s/10: 17144:11 2s/10: 12805:10=0D
[  637.467591][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[  639.261549][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  639.297561][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  651.939529][   T64] rcu_torture_fwd_prog_nr: 0 Duration 14465 cver 419 g=
ps 702=0D
[  651.943546][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  652.827556][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  656.916874][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  670.236550][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  670.274406][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  677.147639][   T60] rcu-torture: rtc: e5f7467c ver: 42378 tfle: 0 rta: 4=
2379 rtaf: 0 rtf: 42367 rtmbe: 0 rtmbkf: 0/36177 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 725665 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 704 nocb-toggles: 0:0=0D
[  677.148593][   T60] rcu-torture: Reader Pipe:  159668023 68330 0 0 0 0 0=
 0 0 0 0=0D
[  677.148924][   T60] rcu-torture: Reader Batch:  159543651 192702 0 0 0 0=
 0 0 0 0 0=0D
[  677.149260][   T60] rcu-torture: Free-Block Circulation:  42378 42377 42=
376 42375 42374 42373 42371 42369 42368 42367 0=0D
[  683.740637][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  687.928759][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
=0D
# =0D
# [  701.339596][   T65] rcu-torture: rcu_torture_read_exit: Start of episo=
de=0D
[  701.370673][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  714.715588][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  718.107614][   T64] rcu_torture_fwd_prog n_max_cbs: 13882=0D
[  718.107902][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[  718.108212][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[  718.158717][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  718.200397][   T64] rcu_torture_fwd_prog_cr Duration 45 barrier: 41 pend=
ing 27639 n_launders: 6467 n_launders_sa: 686 n_max_gps: 100 n_max_cbs: 333=
24 cver 0 gps 10=0D
[  718.201030][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 87 jiffies): 1s/10: 39791:12=0D
[  718.919225][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  719.259645][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[  731.613533][   T64] rcu_torture_fwd_prog_nr: 0 Duration 12340 cver 330 g=
ps 587=0D
[  731.617576][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  732.252593][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  732.284588][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  738.587626][   T60] rcu-torture: rtc: d0a05544 ver: 45628 tfle: 0 rta: 4=
5629 rtaf: 0 rtf: 45615 rtmbe: 0 rtmbkf: 0/38838 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 790266 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 768 nocb-toggles: 0:0=0D
[  738.588755][   T60] rcu-torture: Reader Pipe:  173621003 73874 0 0 0 0 0=
 0 0 0 0=0D
[  738.589149][   T60] rcu-torture: Reader Batch:  173486760 208117 0 0 0 0=
 0 0 0 0 0=0D
[  738.589570][   T60] rcu-torture: Free-Block Circulation:  45628 45626 45=
625 45624 45623 45622 45619 45617 45616 45615 0=0D
[  745.627561][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  749.928558][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  763.293597][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  763.312616][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  776.667601][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  780.923479][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  791.835614][   T64] rcu_torture_fwd_prog n_max_cbs: 33324=0D
[  791.835899][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[  791.836206][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[  791.931738][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  792.008965][   T64] rcu_torture_fwd_prog_cr Duration 86 barrier: 77 pend=
ing 9858 n_launders: 11600 n_launders_sa: 565 n_max_gps: 100 n_max_cbs: 117=
58 cver 11 gps 18=0D
[  792.009736][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 164 jiffies): 1s/10: 17460:20 2s/10: 5898:3=0D
[  793.052581][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[  794.267579][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  794.340027][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  800.027607][   T60] rcu-torture: rtc: d6c66008 ver: 49199 tfle: 0 rta: 4=
9200 rtaf: 0 rtf: 49189 rtmbe: 0 rtmbkf: 0/41729 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 856948 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 832 nocb-toggles: 0:0=0D
[  800.029169][   T60] rcu-torture: Reader Pipe:  185516787 79930 0 0 0 0 0=
 0 0 0 0=0D
[  800.029667][   T60] rcu-torture: Reader Batch:  185371895 224822 0 0 0 0=
 0 0 0 0 0=0D
[  800.030109][   T60] rcu-torture: Free-Block Circulation:  49199 49198 49=
197 49196 49195 49194 49193 49192 49190 49189 0=0D
[  807.899612][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  811.958800][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  813.725538][   T64] rcu_torture_fwd_prog_nr: 0 Duration 20652 cver 501 g=
ps 885=0D
[  813.731591][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  825.307640][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  825.344608][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  838.684575][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  842.930663][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  856.347625][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  856.377787][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  861.467590][   T60] rcu-torture: rtc: 9e3d1d49 ver: 52925 tfle: 0 rta: 5=
2926 rtaf: 0 rtf: 52916 rtmbe: 0 rtmbkf: 0/44724 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 923645 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 896 nocb-toggles: 0:0=0D
[  861.468969][   T60] rcu-torture: Reader Pipe:  197584694 86209 0 0 0 0 0=
 0 0 0 0=0D
[  861.469682][   T60] rcu-torture: Reader Batch:  197428492 242411 0 0 0 0=
 0 0 0 0 0=0D
[  861.470325][   T60] rcu-torture: Free-Block Circulation:  52925 52924 52=
923 52922 52921 52920 52919 52918 52917 52916 0=0D
[  869.980614][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  873.932326][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  877.851579][   T64] rcu_torture_fwd_prog n_max_cbs: 11758=0D
[  877.851911][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[  877.852205][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[  877.950820][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  878.015259][   T64] rcu_torture_fwd_prog_cr Duration 86 barrier: 64 pend=
ing 6639 n_launders: 7023 n_launders_sa: 1305 n_max_gps: 100 n_max_cbs: 824=
3 cver 5 gps 16=0D
[  878.015805][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 151 jiffies): 1s/10: 11748:19 2s/10: 3518:4=0D
[  879.067599][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[  887.259710][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  887.336578][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  892.545538][   T64] rcu_torture_fwd_prog_nr: 0 Duration 13464 cver 341 g=
ps 560=0D
[  892.551484][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  900.955630][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  904.925316][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  918.492553][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  918.522843][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  922.907596][   T60] rcu-torture: rtc: 24d10813 ver: 55997 tfle: 0 rta: 5=
5998 rtaf: 0 rtf: 55988 rtmbe: 0 rtmbkf: 0/47209 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 986529 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier:=
 0/0:0 read-exits: 960 nocb-toggles: 0:0=0D
[  922.909055][   T60] rcu-torture: Reader Pipe:  212630928 91396 0 0 0 0 0=
 0 0 0 0=0D
[  922.909611][   T60] rcu-torture: Reader Batch:  212465760 256564 0 0 0 0=
 0 0 0 0 0=0D
[  922.910048][   T60] rcu-torture: Free-Block Circulation:  55997 55997 55=
996 55995 55994 55993 55992 55991 55990 55989 0=0D
[  931.931612][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  935.929476][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  949.276565][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  949.295762][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  955.675655][   T64] rcu_torture_fwd_prog n_max_cbs: 8243=0D
[  955.675950][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[  955.676343][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[  955.802922][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  955.869905][   T64] rcu_torture_fwd_prog_cr Duration 116 barrier: 67 pen=
ding 3265 n_launders: 8149 n_launders_sa: 438 n_max_gps: 100 n_max_cbs: 106=
10 cver 3 gps 17=0D
[  955.870752][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 184 jiffies): 1s/10: 11784:17 2s/10: 6975:2=0D
[  956.891608][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[  962.651616][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  966.947195][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  980.444585][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  980.470335][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[  981.841533][   T64] rcu_torture_fwd_prog_nr: 0 Duration 24945 cver 483 g=
ps 820=0D
[  981.851575][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[  984.347606][   T60] rcu-torture: rtc: d1aaf70d ver: 58705 tfle: 0 rta: 5=
8706 rtaf: 0 rtf: 58692 rtmbe: 0 rtmbkf: 0/49373 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 1049833 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier=
: 0/0:0 read-exits: 1024 nocb-toggles: 0:0=0D
[  984.348905][   T60] rcu-torture: Reader Pipe:  226283172 95629 0 0 0 0 0=
 0 0 0 0=0D
[  984.349433][   T60] rcu-torture: Reader Batch:  226110045 268756 0 0 0 0=
 0 0 0 0 0=0D
[  984.349990][   T60] rcu-torture: Free-Block Circulation:  58705 58704 58=
702 58701 58700 58699 58697 58696 58695 58692 0=0D
[  993.883557][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[  997.930917][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1011.355637][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1011.367205][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1024.923575][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1028.953250][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1042.268564][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1042.275284][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1045.788605][   T64] rcu_torture_fwd_prog n_max_cbs: 10610=0D
[ 1045.789065][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[ 1045.789416][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[ 1045.797620][   T60] rcu-torture: rtc: 95c46427 ver: 62528 tfle: 0 rta: 6=
2529 rtaf: 0 rtf: 62519 rtmbe: 0 rtmbkf: 0/52519 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 1114931 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier=
: 0/0:0 read-exits: 1088 nocb-toggles: 0:0=0D
[ 1045.798989][   T60] rcu-torture: Reader Pipe:  239877834 101975 0 0 0 0 =
0 0 0 0 0=0D
[ 1045.799413][   T60] rcu-torture: Reader Batch:  239691474 288335 0 0 0 0=
 0 0 0 0 0=0D
[ 1045.799841][   T60] rcu-torture: Free-Block Circulation:  62528 62527 62=
526 62525 62524 62523 62522 62521 62520 62519 0=0D
[ 1046.002835][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[ 1046.066369][   T64] rcu_torture_fwd_prog_cr Duration 77 barrier: 63 pend=
ing 4335 n_launders: 5668 n_launders_sa: 721 n_max_gps: 100 n_max_cbs: 5528=
 cver 6 gps 14=0D
[ 1046.067188][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 141 jiffies): 1s/10: 10432:22 2s/10: 764:1=0D
[ 1047.131586][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[ 1055.579703][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1059.979621][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1063.827537][   T64] rcu_torture_fwd_prog_nr: 0 Duration 16690 cver 329 g=
ps 591=0D
[ 1063.837575][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[ 1073.627610][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1073.638312][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1087.067560][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1090.944907][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1104.283699][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1104.317864][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1107.227650][   T60] rcu-torture: rtc: c90e97ce ver: 65803 tfle: 0 rta: 6=
5804 rtaf: 0 rtf: 65794 rtmbe: 0 rtmbkf: 0/55158 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 1179667 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier=
: 0/0:0 read-exits: 1152 nocb-toggles: 0:0=0D
[ 1107.228891][   T60] rcu-torture: Reader Pipe:  254957334 107271 0 0 0 0 =
0 0 0 0 0=0D
[ 1107.229370][   T60] rcu-torture: Reader Batch:  254760207 304398 0 0 0 0=
 0 0 0 0 0=0D
[ 1107.229883][   T60] rcu-torture: Free-Block Circulation:  65803 65802 65=
801 65800 65799 65798 65797 65796 65795 65794 0=0D
[ 1117.980623][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1121.954837][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1127.707545][   T64] rcu_torture_fwd_prog n_max_cbs: 5528=0D
[ 1127.707770][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[ 1127.708036][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[ 1127.814918][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[ 1127.857123][   T64] rcu_torture_fwd_prog_cr Duration 95 barrier: 42 pend=
ing 5527 n_launders: 13719 n_launders_sa: 1410 n_max_gps: 100 n_max_cbs: 12=
864 cver 6 gps 14=0D
[ 1127.857709][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 138 jiffies): 1s/10: 21056:14 2s/10: 5527:2=0D
[ 1128.859572][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[ 1135.261536][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1135.301723][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1142.367537][   T64] rcu_torture_fwd_prog_nr: 0 Duration 13486 cver 364 g=
ps 601=0D
[ 1142.373565][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[ 1148.763542][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1152.950765][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1166.301546][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1166.331265][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1168.667635][   T60] rcu-torture: rtc: 3d8b2018 ver: 69109 tfle: 0 rta: 6=
9110 rtaf: 0 rtf: 69099 rtmbe: 0 rtmbkf: 0/57818 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 1246251 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier=
: 0/0:0 read-exits: 1216 nocb-toggles: 0:0=0D
[ 1168.669023][   T60] rcu-torture: Reader Pipe:  266801324 112570 0 0 0 0 =
0 0 0 0 0=0D
[ 1168.669677][   T60] rcu-torture: Reader Batch:  266593993 319901 0 0 0 0=
 0 0 0 0 0=0D
[ 1168.670244][   T60] rcu-torture: Free-Block Circulation:  69109 69108 69=
107 69106 69105 69104 69102 69101 69100 69099 0=0D
[ 1179.675566][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1183.953236][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1197.340558][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1197.354245][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1205.532733][   T64] rcu_torture_fwd_prog n_max_cbs: 12864=0D
[ 1205.532957][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[ 1205.533211][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[ 1205.624619][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[ 1205.680208][   T64] rcu_torture_fwd_prog_cr Duration 84 barrier: 55 pend=
ing 5718 n_launders: 13146 n_launders_sa: 101 n_max_gps: 100 n_max_cbs: 256=
17 cver 5 gps 9=0D
[ 1205.680794][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 140 jiffies): 1s/10: 38763:11=0D
[ 1206.683638][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[ 1210.716598][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1214.953653][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1215.067532][   T64] rcu_torture_fwd_prog_nr: 0 Duration 8377 cver 78 gps=
 192=0D
[ 1215.079556][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[ 1228.379632][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1228.412617][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1230.107570][   T60] rcu-torture: rtc: b1e2aaaf ver: 72898 tfle: 0 rta: 7=
2899 rtaf: 0 rtf: 72888 rtmbe: 0 rtmbkf: 0/60881 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 1313750 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier=
: 0/0:0 read-exits: 1280 nocb-toggles: 0:0=0D
[ 1230.108482][   T60] rcu-torture: Reader Pipe:  280290667 118939 0 0 0 0 =
0 0 0 0 0=0D
[ 1230.108938][   T60] rcu-torture: Reader Batch:  280071335 338271 0 0 0 0=
 0 0 0 0 0=0D
[ 1230.109318][   T60] rcu-torture: Free-Block Circulation:  72898 72897 72=
896 72895 72894 72893 72892 72891 72890 72888 0=0D
[ 1241.755560][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
=0D
# =0D
# =0D
# [ 1245.956624][   T65] rcu-torture: rcu_torture_read_exit: End of episode=
=0D
[ 1259.292539][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1259.323685][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1272.667581][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1276.963622][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1279.259692][   T64] rcu_torture_fwd_prog n_max_cbs: 25617=0D
[ 1279.259925][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[ 1279.260180][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[ 1279.347482][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[ 1279.408212][   T64] rcu_torture_fwd_prog_cr Duration 72 barrier: 61 pend=
ing 7991 n_launders: 15426 n_launders_sa: 5938 n_max_gps: 100 n_max_cbs: 10=
183 cver 4 gps 11=0D
[ 1279.408985][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 134 jiffies): 1s/10: 25464:13 2s/10: 145:0=0D
[ 1280.411577][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[ 1288.605554][   T64] rcu_torture_fwd_prog_nr: 0 Duration 8189 cver 301 gp=
s 534=0D
[ 1288.613661][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[ 1290.267659][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1290.299427][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1291.547605][   T60] rcu-torture: rtc: 2bd26944 ver: 76565 tfle: 0 rta: 7=
6566 rtaf: 0 rtf: 76556 rtmbe: 0 rtmbkf: 0/63899 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 1379987 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier=
: 0/0:0 read-exits: 1344 nocb-toggles: 0:0=0D
[ 1291.548846][   T60] rcu-torture: Reader Pipe:  292909371 125004 0 0 0 0 =
0 0 0 0 0=0D
[ 1291.549212][   T60] rcu-torture: Reader Batch:  292679765 354610 0 0 0 0=
 0 0 0 0 0=0D
[ 1291.549784][   T60] rcu-torture: Free-Block Circulation:  76565 76564 76=
563 76562 76561 76560 76559 76558 76557 76556 0=0D
[ 1303.644599][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1307.971378][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1321.309238][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1321.342042][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1334.683555][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1338.961360][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1348.892610][   T64] rcu_torture_fwd_prog n_max_cbs: 10183=0D
[ 1348.892847][   T64] rcu_torture_fwd_prog: Starting forward-progress test=
 0=0D
[ 1348.893107][   T64] rcu_torture_fwd_prog_cr: Starting forward-progress t=
est 0=0D
[ 1349.000724][   T64] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[ 1349.103799][   T64] rcu_torture_fwd_prog_cr Duration 102 barrier: 103 pe=
nding 15090 n_launders: 14482 n_launders_sa: 991 n_max_gps: 100 n_max_cbs: =
15732 cver 9 gps 21=0D
[ 1349.104444][   T64] rcu_torture_fwd_cb_hist: Callback-invocation histogr=
am 0 (duration 205 jiffies): 1s/10: 14459:19 2s/10: 15755:15=0D
[ 1350.107572][   T64] rcu_torture_fwd_prog_nr: Starting forward-progress t=
est 0=0D
[ 1352.286555][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1352.317605][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1352.987638][   T60] rcu-torture: rtc: e312f6a8 ver: 80364 tfle: 0 rta: 8=
0365 rtaf: 0 rtf: 80353 rtmbe: 0 rtmbkf: 0/67001 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 1445780 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D1000) barrier=
: 0/0:0 read-exits: 1408 nocb-toggles: 0:0=0D
[ 1352.988582][   T60] rcu-torture: Reader Pipe:  304814561 131599 0 0 0 0 =
0 0 0 0 0=0D
[ 1352.988883][   T60] rcu-torture: Reader Batch:  304574702 371458 0 0 0 0=
 0 0 0 0 0=0D
[ 1352.989251][   T60] rcu-torture: Free-Block Circulation:  80364 80363 80=
361 80360 80359 80358 80357 80356 80354 80353 0=0D
[ 1365.659647][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1370.014587][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1371.695531][   T64] rcu_torture_fwd_prog_nr: 0 Duration 21577 cver 537 g=
ps 953=0D
[ 1371.705601][   T64] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrie=
r+0x0/0x5c0() 0=0D
[ 1383.452571][   T65] rcu-torture: rcu_torture_read_exit: Start of episode=
=0D
[ 1383.468925][   T65] rcu-torture: rcu_torture_read_exit: End of episode=0D
[ 1387.564837][   T57] BUG: unable to handle page fault for address: c108f5=
f4=0D
[ 1387.566649][   T57] #PF: supervisor write access in kernel mode=0D
[ 1387.567965][   T57] #PF: error_code(0x0003) - permissions violation=0D
[ 1387.569439][   T57] *pde =3D 010001e1 =0D
[ 1387.570276][   T57] Oops: 0003 [#1] SMP=0D
[ 1387.571149][   T57] CPU: 2 PID: 57 Comm: rcu_torture_rea Tainted: G S   =
              6.1.0-rc2-00010-g0af8489b0216 #2130 63d19ac2b985fca570c354d87=
50f489755de37ed=0D
[ 1387.574673][   T57] EIP: kvm_kick_cpu+0x54/0x90=0D
[ 1387.575802][   T57] Code: 2f c5 01 8b 04 9d e0 d4 4e c4 83 15 14 7b 2f c=
5 00 83 05 08 6d 2f c5 01 0f b7 0c 30 b8 05 00 00 00 83 15 0c 6d 2f c5 00 3=
1 db <0f> 01 c1 83 05 10 6d 2f c5 01 8b 5d f8 8b 75 fc 83 15 14 6d 2f c5=0D
[ 1387.580456][   T57] EAX: 00000005 EBX: 00000000 ECX: 00000003 EDX: c108f=
5a0=0D
[ 1387.582071][   T57] ESI: c5153580 EDI: 00000046 EBP: c69cddf8 ESP: c69cd=
df0=0D
[ 1387.583775][   T57] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS:=
 00010046=0D
[ 1387.585643][   T57] CR0: 80050033 CR2: c108f5f4 CR3: 0776b000 CR4: 00350=
e90=0D
[ 1387.587492][   T57] Call Trace:=0D
[ 1387.588365][   T57]  __pv_queued_spin_unlock_slowpath+0x66/0x110=0D
[ 1387.589898][   T57]  __pv_queued_spin_unlock+0x4b/0x60=0D
[ 1387.591040][   T57]  __raw_callee_save___pv_queued_spin_unlock+0x9/0x10=
=0D
[ 1387.592771][   T57]  do_raw_spin_unlock+0x49/0xa0=0D
[ 1387.593805][   T57]  _raw_spin_unlock_irqrestore+0x53/0xd0=0D
[ 1387.594927][   T57]  swake_up_one+0x4f/0x70=0D
[ 1387.595739][   T57]  __rcu_report_exp_rnp+0x26b/0x470=0D
[ 1387.596730][   T57]  rcu_report_exp_cpu_mult+0x82/0x2f0=0D
[ 1387.597770][   T57]  rcu_qs+0xac/0x160=0D
[ 1387.598503][   T57]  rcu_note_context_switch+0x31/0x1e0=0D
[ 1387.599460][   T57]  __schedule+0xc5/0x770=0D
[ 1387.600195][   T57]  __cond_resched+0x7a/0x100=0D
[ 1387.600996][   T57]  stutter_wait+0x9e/0x2c0=0D
[ 1387.601956][   T57]  rcu_torture_reader+0x162/0x3e0=0D
[ 1387.603048][   T57]  ? rcu_torture_reader+0x3e0/0x3e0=0D
[ 1387.604269][   T57]  ? __kthread_parkme+0xab/0xf0=0D
[ 1387.605420][   T57]  kthread+0x167/0x1d0=0D
[ 1387.606383][   T57]  ? rcu_torture_read_exit_child+0xa0/0xa0=0D
[ 1387.607516][   T57]  ? kthread_exit+0x50/0x50=0D
[ 1387.608517][   T57]  ret_from_fork+0x19/0x24=0D
[ 1387.609548][   T57] Modules linked in:=0D
[ 1387.610187][   T57] CR2: 00000000c108f5f4=0D
[ 1387.610873][   T57] ---[ end trace 0000000000000000 ]---=0D
[ 1387.611829][   T57] EIP: kvm_kick_cpu+0x54/0x90=0D
[ 1387.612653][   T57] Code: 2f c5 01 8b 04 9d e0 d4 4e c4 83 15 14 7b 2f c=
5 00 83 05 08 6d 2f c5 01 0f b7 0c 30 b8 05 00 00 00 83 15 0c 6d 2f c5 00 3=
1 db <0f> 01 c1 83 05 10 6d 2f c5 01 8b 5d f8 8b 75 fc 83 15 14 6d 2f c5=0D
[ 1387.616715][   T57] EAX: 00000005 EBX: 00000000 ECX: 00000003 EDX: c108f=
5a0=0D
[ 1387.618242][   T57] ESI: c5153580 EDI: 00000046 EBP: c69cddf8 ESP: c69cd=
df0=0D
[ 1387.619912][   T57] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS:=
 00010046=0D
[ 1387.621666][   T57] CR0: 80050033 CR2: c108f5f4 CR3: 0776b000 CR4: 00350=
e90=0D
[ 1387.623128][   T57] Kernel panic - not syncing: Fatal exception=0D
[ 1389.285045][   T57] Shutting down cpus with NMI=0D
[ 1389.297949][   T57] Kernel Offset: disabled=0D
[ 1389.299174][   T57] ---[ end Kernel panic - not syncing: Fatal exception=
 ]---=0D

--ASl+wY6T4lyYuGgs--
