Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD59698167
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBOQzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjBOQzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:55:12 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABE9BBAB;
        Wed, 15 Feb 2023 08:55:06 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t5so16323507oiw.1;
        Wed, 15 Feb 2023 08:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxTIM0Z77B+VpFNyPp51sSWbXIgznMdIqIbsVlCHHK4=;
        b=E9Dc593FSyqIpFhHFRCDjsumEcz1W89zYm1mRqZ8ZpXUXpqdgCxow7upg39VzCI+Ce
         l7OR/oc9RB5nzAVo7zZ/FNmmP3GA2l767khsioJrO7t8mB33Ue6Fi+urofSjEFsKcTNp
         lvrcvWbX67TmJKhOpFKm897U1beS+vAzWswptxdonEuErDonRdUOm5X6tsLwPS7YoBy7
         p4VQsN8Cm0jSpKNbcOshd0fyIv1wZjq9ku6TvOTY3oCQuazufCHdk7xrL6E+tb7/goHO
         ZGtg6yydQUClT4agYS7gcLu+RTWoPktaZV6vRLu3DPlebrplKxnBN2ZefkNwtbtOKsWQ
         kdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxTIM0Z77B+VpFNyPp51sSWbXIgznMdIqIbsVlCHHK4=;
        b=ljbfl1UNnyB6g1ULOH85fmrR96UrP3WimJ2iQv4AnfrWLmeV30cpBJPIgETHOCH2rB
         YYZBxHZ0Ah2pYWqMURQYwJfgNBoIh6tRLRR03P/LptnzA6k/xhtXMA/C8eptPb2gjnKm
         bdlWbvQ2oSn3ka81QuRZW4kiRYpJLeEbW7S9tawzcz+la3Lbnh63/51Qwvc0IOSU14pH
         t+f9UZrYJrdJITRcQKJzll/iVBvDJ/GQyskFXzPinM3KNtxdd1E+LyCWs9E9vsxKBGsp
         2Zt0Ph7xuK5+UazBkHY8LLBpVAqe8NkioiRb3RwuZgBKYhc3XHutviNpd/mJPax+938g
         dpVg==
X-Gm-Message-State: AO0yUKWhnnJmAy81ctzOjQBUDP6pCoI7og8MiroWsy/EJJxt0v4uqqdN
        AupViY3N2lZ2JbW/VPitHzk=
X-Google-Smtp-Source: AK7set/LCnlyHEPnc4fWE8OddynVl/yQcTpFHkpQjQQDnn1Nv8VEyzrmARzVmLU7aoPvsLkfooQp0w==
X-Received: by 2002:a05:6808:351:b0:37d:5743:441f with SMTP id j17-20020a056808035100b0037d5743441fmr1209881oie.21.1676480105125;
        Wed, 15 Feb 2023 08:55:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dq3-20020a056808428300b0037d8148cf04sm4585288oib.46.2023.02.15.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:55:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Feb 2023 08:55:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] arch: Remove Itanium (IA-64) architecture
Message-ID: <20230215165501.GA3786546@roeck-us.net>
References: <20230215100008.2565237-1-ardb@kernel.org>
 <20230215100008.2565237-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215100008.2565237-2-ardb@kernel.org>
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

On Wed, Feb 15, 2023 at 11:00:04AM +0100, Ard Biesheuvel wrote:
> Itanium is the original architecture for which EFI was developed, and
> the way Linux supports it deviates significantly from other
> architectures.
> 
> So it is anyone's guess whether the ongoing maintenance and developement
> of the EFI subsystem has regressed Itanium or not - QEMU no longer
> implements support for it, and so there is zero test coverage using
> actual hardware.
> 
> Note that the Intel firmware team themselves already removed all IA-64
> support from the Tianocore/EDK2 reference implementation of EFI in 2018,
> so let's follow suit, and drop IA-64 from Linux as well.
> 
> Acked-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/core-api/cpu_hotplug.rst               |    6 -
>  Documentation/ia64/aliasing.rst                      |  246 ---
>  Documentation/ia64/efirtc.rst                        |  144 --
>  Documentation/ia64/err_inject.rst                    | 1067 ---------
>  Documentation/ia64/features.rst                      |    3 -
>  Documentation/ia64/fsys.rst                          |  303 ---
>  Documentation/ia64/ia64.rst                          |   49 -
>  Documentation/ia64/index.rst                         |   19 -
>  Documentation/ia64/irq-redir.rst                     |   80 -
>  Documentation/ia64/mca.rst                           |  198 --
>  Documentation/ia64/serial.rst                        |  165 --
>  MAINTAINERS                                          |   11 -
>  arch/Kconfig                                         |    1 -
>  arch/ia64/Kbuild                                     |    3 -
>  arch/ia64/Kconfig                                    |  410 ----
>  arch/ia64/Kconfig.debug                              |   55 -
>  arch/ia64/Makefile                                   |   82 -
>  arch/ia64/configs/bigsur_defconfig                   |  102 -
>  arch/ia64/configs/generic_defconfig                  |  206 --
>  arch/ia64/configs/gensparse_defconfig                |  184 --
>  arch/ia64/configs/tiger_defconfig                    |  169 --
>  arch/ia64/configs/zx1_defconfig                      |  148 --
>  arch/ia64/hp/common/Makefile                         |   10 -
>  arch/ia64/hp/common/aml_nfw.c                        |  232 --
>  arch/ia64/hp/common/sba_iommu.c                      | 2147 ------------------
>  arch/ia64/include/asm/Kbuild                         |    5 -
>  arch/ia64/include/asm/acenv.h                        |   49 -
>  arch/ia64/include/asm/acpi-ext.h                     |   17 -
>  arch/ia64/include/asm/acpi.h                         |  110 -
>  arch/ia64/include/asm/agp.h                          |   27 -
>  arch/ia64/include/asm/asm-offsets.h                  |    1 -
>  arch/ia64/include/asm/asm-prototypes.h               |   30 -
>  arch/ia64/include/asm/asmmacro.h                     |  136 --
>  arch/ia64/include/asm/atomic.h                       |  223 --
>  arch/ia64/include/asm/barrier.h                      |   79 -
>  arch/ia64/include/asm/bitops.h                       |  453 ----
>  arch/ia64/include/asm/bug.h                          |   19 -
>  arch/ia64/include/asm/bugs.h                         |   20 -
>  arch/ia64/include/asm/cache.h                        |   30 -
>  arch/ia64/include/asm/cacheflush.h                   |   33 -
>  arch/ia64/include/asm/checksum.h                     |   63 -
>  arch/ia64/include/asm/clocksource.h                  |   11 -
>  arch/ia64/include/asm/cmpxchg.h                      |   16 -
>  arch/ia64/include/asm/cpu.h                          |   23 -
>  arch/ia64/include/asm/cputime.h                      |   21 -
>  arch/ia64/include/asm/current.h                      |   18 -
>  arch/ia64/include/asm/cyclone.h                      |   16 -
>  arch/ia64/include/asm/delay.h                        |   89 -
>  arch/ia64/include/asm/device.h                       |   14 -
>  arch/ia64/include/asm/div64.h                        |    1 -
>  arch/ia64/include/asm/dma-mapping.h                  |   16 -
>  arch/ia64/include/asm/dma.h                          |   17 -
>  arch/ia64/include/asm/dmi.h                          |   15 -
>  arch/ia64/include/asm/early_ioremap.h                |   11 -
>  arch/ia64/include/asm/efi.h                          |   13 -
>  arch/ia64/include/asm/elf.h                          |  233 --
>  arch/ia64/include/asm/emergency-restart.h            |    6 -
>  arch/ia64/include/asm/esi.h                          |   30 -
>  arch/ia64/include/asm/exception.h                    |   23 -
>  arch/ia64/include/asm/export.h                       |    3 -
>  arch/ia64/include/asm/extable.h                      |   12 -
>  arch/ia64/include/asm/fb.h                           |   24 -
>  arch/ia64/include/asm/fpswa.h                        |   74 -
>  arch/ia64/include/asm/ftrace.h                       |   28 -
>  arch/ia64/include/asm/futex.h                        |  109 -
>  arch/ia64/include/asm/gcc_intrin.h                   |   13 -
>  arch/ia64/include/asm/hardirq.h                      |   27 -
>  arch/ia64/include/asm/hugetlb.h                      |   34 -
>  arch/ia64/include/asm/hw_irq.h                       |  167 --
>  arch/ia64/include/asm/idle.h                         |    8 -
>  arch/ia64/include/asm/intrinsics.h                   |   13 -
>  arch/ia64/include/asm/io.h                           |  274 ---
>  arch/ia64/include/asm/iommu.h                        |   22 -
>  arch/ia64/include/asm/iosapic.h                      |  106 -
>  arch/ia64/include/asm/irq.h                          |   37 -
>  arch/ia64/include/asm/irq_regs.h                     |    1 -
>  arch/ia64/include/asm/irq_remapping.h                |    5 -
>  arch/ia64/include/asm/irqflags.h                     |   95 -
>  arch/ia64/include/asm/kdebug.h                       |   45 -
>  arch/ia64/include/asm/kexec.h                        |   46 -
>  arch/ia64/include/asm/kprobes.h                      |  116 -
>  arch/ia64/include/asm/kregs.h                        |  166 --
>  arch/ia64/include/asm/libata-portmap.h               |    9 -
>  arch/ia64/include/asm/linkage.h                      |   19 -
>  arch/ia64/include/asm/local.h                        |    1 -
>  arch/ia64/include/asm/mca.h                          |  185 --
>  arch/ia64/include/asm/mca_asm.h                      |  245 ---
>  arch/ia64/include/asm/meminit.h                      |   59 -
>  arch/ia64/include/asm/mman.h                         |   18 -
>  arch/ia64/include/asm/mmiowb.h                       |   17 -
>  arch/ia64/include/asm/mmu.h                          |   14 -
>  arch/ia64/include/asm/mmu_context.h                  |  194 --
>  arch/ia64/include/asm/mmzone.h                       |   35 -
>  arch/ia64/include/asm/module.h                       |   35 -
>  arch/ia64/include/asm/module.lds.h                   |   14 -
>  arch/ia64/include/asm/msidef.h                       |   43 -
>  arch/ia64/include/asm/native/inst.h                  |  119 -
>  arch/ia64/include/asm/native/irq.h                   |   20 -
>  arch/ia64/include/asm/native/patchlist.h             |   24 -
>  arch/ia64/include/asm/nodedata.h                     |   63 -
>  arch/ia64/include/asm/numa.h                         |   83 -
>  arch/ia64/include/asm/page.h                         |  214 --
>  arch/ia64/include/asm/pal.h                          | 1827 ---------------
>  arch/ia64/include/asm/param.h                        |   18 -
>  arch/ia64/include/asm/parport.h                      |   20 -
>  arch/ia64/include/asm/patch.h                        |   28 -
>  arch/ia64/include/asm/pci.h                          |   66 -
>  arch/ia64/include/asm/percpu.h                       |   53 -
>  arch/ia64/include/asm/pgalloc.h                      |   64 -
>  arch/ia64/include/asm/pgtable.h                      |  520 -----
>  arch/ia64/include/asm/processor.h                    |  663 ------
>  arch/ia64/include/asm/ptrace.h                       |  146 --
>  arch/ia64/include/asm/sal.h                          |  919 --------
>  arch/ia64/include/asm/sections.h                     |   33 -
>  arch/ia64/include/asm/serial.h                       |   17 -
>  arch/ia64/include/asm/shmparam.h                     |   13 -
>  arch/ia64/include/asm/signal.h                       |   33 -
>  arch/ia64/include/asm/smp.h                          |  103 -
>  arch/ia64/include/asm/sn/intr.h                      |   15 -
>  arch/ia64/include/asm/sn/sn_sal.h                    |  124 --
>  arch/ia64/include/asm/sparsemem.h                    |   28 -
>  arch/ia64/include/asm/spinlock.h                     |  265 ---
>  arch/ia64/include/asm/spinlock_types.h               |   22 -
>  arch/ia64/include/asm/string.h                       |   22 -
>  arch/ia64/include/asm/switch_to.h                    |   71 -
>  arch/ia64/include/asm/syscall.h                      |   65 -
>  arch/ia64/include/asm/thread_info.h                  |  131 --
>  arch/ia64/include/asm/timex.h                        |   47 -
>  arch/ia64/include/asm/tlb.h                          |   50 -
>  arch/ia64/include/asm/tlbflush.h                     |  128 --
>  arch/ia64/include/asm/topology.h                     |   56 -
>  arch/ia64/include/asm/types.h                        |   32 -
>  arch/ia64/include/asm/uaccess.h                      |  265 ---
>  arch/ia64/include/asm/uncached.h                     |    9 -
>  arch/ia64/include/asm/unistd.h                       |   38 -
>  arch/ia64/include/asm/unwind.h                       |  234 --
>  arch/ia64/include/asm/user.h                         |   53 -
>  arch/ia64/include/asm/ustack.h                       |   12 -
>  arch/ia64/include/asm/uv/uv.h                        |   30 -
>  arch/ia64/include/asm/uv/uv_hub.h                    |  315 ---
>  arch/ia64/include/asm/uv/uv_mmrs.h                   |  825 -------
>  arch/ia64/include/asm/vermagic.h                     |   15 -
>  arch/ia64/include/asm/vga.h                          |   26 -
>  arch/ia64/include/asm/vmalloc.h                      |    4 -
>  arch/ia64/include/asm/xor.h                          |   30 -
>  arch/ia64/include/asm/xtp.h                          |   46 -
>  arch/ia64/include/uapi/asm/Kbuild                    |    2 -
>  arch/ia64/include/uapi/asm/auxvec.h                  |   14 -
>  arch/ia64/include/uapi/asm/bitsperlong.h             |    9 -
>  arch/ia64/include/uapi/asm/break.h                   |   23 -
>  arch/ia64/include/uapi/asm/byteorder.h               |    7 -
>  arch/ia64/include/uapi/asm/cmpxchg.h                 |  159 --
>  arch/ia64/include/uapi/asm/fcntl.h                   |   15 -
>  arch/ia64/include/uapi/asm/fpu.h                     |   67 -
>  arch/ia64/include/uapi/asm/gcc_intrin.h              |  619 ------
>  arch/ia64/include/uapi/asm/ia64regs.h                |  101 -
>  arch/ia64/include/uapi/asm/intel_intrin.h            |  162 --
>  arch/ia64/include/uapi/asm/intrinsics.h              |   86 -
>  arch/ia64/include/uapi/asm/mman.h                    |   17 -
>  arch/ia64/include/uapi/asm/param.h                   |   30 -
>  arch/ia64/include/uapi/asm/posix_types.h             |    9 -
>  arch/ia64/include/uapi/asm/ptrace.h                  |  248 ---
>  arch/ia64/include/uapi/asm/ptrace_offsets.h          |  269 ---
>  arch/ia64/include/uapi/asm/resource.h                |    8 -
>  arch/ia64/include/uapi/asm/rse.h                     |   67 -
>  arch/ia64/include/uapi/asm/setup.h                   |   25 -
>  arch/ia64/include/uapi/asm/sigcontext.h              |   71 -
>  arch/ia64/include/uapi/asm/siginfo.h                 |   28 -
>  arch/ia64/include/uapi/asm/signal.h                  |   98 -
>  arch/ia64/include/uapi/asm/stat.h                    |   52 -
>  arch/ia64/include/uapi/asm/statfs.h                  |   21 -
>  arch/ia64/include/uapi/asm/swab.h                    |   35 -
>  arch/ia64/include/uapi/asm/types.h                   |   32 -
>  arch/ia64/include/uapi/asm/ucontext.h                |   13 -
>  arch/ia64/include/uapi/asm/unistd.h                  |   22 -
>  arch/ia64/include/uapi/asm/ustack.h                  |   13 -
>  arch/ia64/install.sh                                 |   30 -
>  arch/ia64/kernel/.gitignore                          |    3 -
>  arch/ia64/kernel/Makefile                            |   46 -
>  arch/ia64/kernel/Makefile.gate                       |   29 -
>  arch/ia64/kernel/acpi-ext.c                          |  101 -
>  arch/ia64/kernel/acpi.c                              |  911 --------
>  arch/ia64/kernel/asm-offsets.c                       |  289 ---
>  arch/ia64/kernel/audit.c                             |   63 -
>  arch/ia64/kernel/brl_emu.c                           |  217 --
>  arch/ia64/kernel/crash.c                             |  266 ---
>  arch/ia64/kernel/crash_dump.c                        |   27 -
>  arch/ia64/kernel/cyclone.c                           |  125 --
>  arch/ia64/kernel/dma-mapping.c                       |    9 -
>  arch/ia64/kernel/efi.c                               | 1360 ------------
>  arch/ia64/kernel/efi_stub.S                          |   87 -
>  arch/ia64/kernel/elfcore.c                           |   77 -
>  arch/ia64/kernel/entry.S                             | 1428 ------------
>  arch/ia64/kernel/entry.h                             |   83 -
>  arch/ia64/kernel/err_inject.c                        |  273 ---
>  arch/ia64/kernel/esi.c                               |  193 --
>  arch/ia64/kernel/esi_stub.S                          |   99 -
>  arch/ia64/kernel/fsys.S                              |  837 -------
>  arch/ia64/kernel/fsyscall_gtod_data.h                |   30 -
>  arch/ia64/kernel/ftrace.c                            |  196 --
>  arch/ia64/kernel/gate-data.S                         |    3 -
>  arch/ia64/kernel/gate.S                              |  380 ----
>  arch/ia64/kernel/gate.lds.S                          |  108 -
>  arch/ia64/kernel/head.S                              | 1168 ----------
>  arch/ia64/kernel/iosapic.c                           | 1137 ----------
>  arch/ia64/kernel/irq.c                               |  181 --
>  arch/ia64/kernel/irq.h                               |    3 -
>  arch/ia64/kernel/irq_ia64.c                          |  645 ------
>  arch/ia64/kernel/irq_lsapic.c                        |   45 -
>  arch/ia64/kernel/ivt.S                               | 1689 --------------
>  arch/ia64/kernel/kprobes.c                           |  911 --------
>  arch/ia64/kernel/machine_kexec.c                     |  163 --
>  arch/ia64/kernel/mca.c                               | 2111 ------------------
>  arch/ia64/kernel/mca_asm.S                           | 1123 ----------
>  arch/ia64/kernel/mca_drv.c                           |  796 -------
>  arch/ia64/kernel/mca_drv.h                           |  123 --
>  arch/ia64/kernel/mca_drv_asm.S                       |   56 -
>  arch/ia64/kernel/minstate.h                          |  251 ---
>  arch/ia64/kernel/module.c                            |  955 --------
>  arch/ia64/kernel/msi_ia64.c                          |  198 --
>  arch/ia64/kernel/numa.c                              |   73 -
>  arch/ia64/kernel/pal.S                               |  306 ---
>  arch/ia64/kernel/palinfo.c                           |  942 --------
>  arch/ia64/kernel/patch.c                             |  237 --
>  arch/ia64/kernel/pci-dma.c                           |   33 -
>  arch/ia64/kernel/perfmon_itanium.h                   |  116 -
>  arch/ia64/kernel/process.c                           |  610 -----
>  arch/ia64/kernel/ptrace.c                            | 2012 -----------------
>  arch/ia64/kernel/relocate_kernel.S                   |  321 ---
>  arch/ia64/kernel/sal.c                               |  400 ----
>  arch/ia64/kernel/salinfo.c                           |  646 ------
>  arch/ia64/kernel/setup.c                             | 1082 ---------
>  arch/ia64/kernel/sigframe.h                          |   26 -
>  arch/ia64/kernel/signal.c                            |  412 ----
>  arch/ia64/kernel/smp.c                               |  335 ---
>  arch/ia64/kernel/smpboot.c                           |  839 -------
>  arch/ia64/kernel/stacktrace.c                        |   40 -
>  arch/ia64/kernel/sys_ia64.c                          |  197 --
>  arch/ia64/kernel/syscalls/Makefile                   |   32 -
>  arch/ia64/kernel/syscalls/syscall.tbl                |  373 ----
>  arch/ia64/kernel/time.c                              |  462 ----
>  arch/ia64/kernel/topology.c                          |  410 ----
>  arch/ia64/kernel/traps.c                             |  612 ------
>  arch/ia64/kernel/unaligned.c                         | 1560 -------------
>  arch/ia64/kernel/uncached.c                          |  273 ---
>  arch/ia64/kernel/unwind.c                            | 2320 --------------------
>  arch/ia64/kernel/unwind_decoder.c                    |  460 ----
>  arch/ia64/kernel/unwind_i.h                          |  165 --
>  arch/ia64/kernel/vmlinux.lds.S                       |  225 --
>  arch/ia64/lib/Makefile                               |   48 -
>  arch/ia64/lib/checksum.c                             |  102 -
>  arch/ia64/lib/clear_page.S                           |   79 -
>  arch/ia64/lib/clear_user.S                           |  212 --
>  arch/ia64/lib/copy_page.S                            |  101 -
>  arch/ia64/lib/copy_page_mck.S                        |  188 --
>  arch/ia64/lib/copy_user.S                            |  613 ------
>  arch/ia64/lib/csum_partial_copy.c                    |   98 -
>  arch/ia64/lib/do_csum.S                              |  324 ---
>  arch/ia64/lib/flush.S                                |  120 -
>  arch/ia64/lib/idiv32.S                               |   86 -
>  arch/ia64/lib/idiv64.S                               |   83 -
>  arch/ia64/lib/io.c                                   |   51 -
>  arch/ia64/lib/ip_fast_csum.S                         |  148 --
>  arch/ia64/lib/memcpy.S                               |  304 ---
>  arch/ia64/lib/memcpy_mck.S                           |  659 ------
>  arch/ia64/lib/memset.S                               |  365 ---
>  arch/ia64/lib/strlen.S                               |  195 --
>  arch/ia64/lib/strncpy_from_user.S                    |   47 -
>  arch/ia64/lib/strnlen_user.S                         |   48 -
>  arch/ia64/lib/xor.S                                  |  181 --
>  arch/ia64/mm/Makefile                                |   11 -
>  arch/ia64/mm/contig.c                                |  208 --
>  arch/ia64/mm/discontig.c                             |  635 ------
>  arch/ia64/mm/extable.c                               |   24 -
>  arch/ia64/mm/fault.c                                 |  272 ---
>  arch/ia64/mm/hugetlbpage.c                           |  186 --
>  arch/ia64/mm/init.c                                  |  518 -----
>  arch/ia64/mm/ioremap.c                               |  123 --
>  arch/ia64/mm/numa.c                                  |   80 -
>  arch/ia64/mm/tlb.c                                   |  591 -----
>  arch/ia64/pci/Makefile                               |    5 -
>  arch/ia64/pci/fixup.c                                |   80 -
>  arch/ia64/pci/pci.c                                  |  576 -----
>  arch/ia64/scripts/check-gas                          |   16 -
>  arch/ia64/scripts/check-gas-asm.S                    |    2 -
>  arch/ia64/scripts/check-model.c                      |    1 -
>  arch/ia64/scripts/check-segrel.S                     |    5 -
>  arch/ia64/scripts/check-segrel.lds                   |   13 -
>  arch/ia64/scripts/check-serialize.S                  |    2 -
>  arch/ia64/scripts/check-text-align.S                 |    7 -
>  arch/ia64/scripts/toolchain-flags                    |   54 -
>  arch/ia64/scripts/unwcheck.py                        |   65 -
>  arch/ia64/uv/Makefile                                |   12 -
>  arch/ia64/uv/kernel/Makefile                         |   12 -
>  arch/ia64/uv/kernel/setup.c                          |  120 -
>  drivers/acpi/Kconfig                                 |    6 +-
>  drivers/acpi/numa/Kconfig                            |    4 +-
>  drivers/acpi/osl.c                                   |    2 +-
>  drivers/char/Kconfig                                 |    4 +-
>  drivers/char/Makefile                                |    1 -
>  drivers/char/agp/Kconfig                             |   16 +-
>  drivers/char/agp/Makefile                            |    2 -
>  drivers/char/agp/hp-agp.c                            |  550 -----
>  drivers/char/agp/i460-agp.c                          |  659 ------
>  drivers/char/hpet.c                                  |   30 -
>  drivers/char/hw_random/Kconfig                       |    2 +-
>  drivers/char/mem.c                                   |   12 -
>  drivers/char/mspec.c                                 |  295 ---
>  drivers/cpufreq/Kconfig                              |   11 -
>  drivers/cpufreq/Makefile                             |    1 -
>  drivers/cpufreq/ia64-acpi-cpufreq.c                  |  353 ---
>  drivers/firmware/Kconfig                             |   24 -
>  drivers/firmware/Makefile                            |    1 -
>  drivers/firmware/efi/Kconfig                         |    6 +-
>  drivers/firmware/efi/efi.c                           |   13 +-
>  drivers/firmware/pcdp.c                              |  135 --
>  drivers/firmware/pcdp.h                              |  108 -
>  drivers/gpu/drm/drm_ioc32.c                          |    4 +-
>  drivers/input/serio/i8042.h                          |    2 +-
>  drivers/iommu/Kconfig                                |    4 +-
>  drivers/iommu/intel/Kconfig                          |    2 +-
>  drivers/media/cec/platform/Kconfig                   |    2 +-
>  drivers/misc/Kconfig                                 |    2 +-
>  drivers/misc/sgi-gru/gru.h                           |    4 +-
>  drivers/misc/sgi-gru/gru_instructions.h              |   12 +-
>  drivers/misc/sgi-gru/grufile.c                       |   72 -
>  drivers/misc/sgi-gru/gruhandles.c                    |    6 -
>  drivers/misc/sgi-gru/grumain.c                       |    4 -
>  drivers/misc/sgi-xp/xp.h                             |    2 +-
>  drivers/misc/sgi-xp/xp_uv.c                          |   24 -
>  drivers/misc/sgi-xp/xpc_main.c                       |   31 -
>  drivers/misc/sgi-xp/xpc_uv.c                         |   85 -
>  drivers/net/ethernet/broadcom/tg3.c                  |    2 +-
>  drivers/net/ethernet/brocade/bna/bnad.h              |    1 -
>  drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c |    2 -
>  drivers/pci/vgaarb.c                                 |    2 +-
>  drivers/tty/serial/8250/Kconfig                      |    2 +-
>  drivers/tty/vt/keyboard.c                            |    2 +-
>  drivers/video/fbdev/Kconfig                          |    2 +-
>  drivers/watchdog/Kconfig                             |    2 +-
>  fs/Kconfig                                           |    2 +-
>  fs/afs/main.c                                        |    2 -
>  fs/xfs/xfs_ioctl32.h                                 |    2 +-
>  include/linux/acpi.h                                 |    9 +-
>  include/linux/efi.h                                  |    7 -
>  include/linux/mm.h                                   |    2 -
>  include/linux/moduleparam.h                          |    2 +-
>  include/trace/events/mmflags.h                       |    2 +-
>  init/Kconfig                                         |    2 +-
>  kernel/cpu.c                                         |    3 -
>  kernel/fork.c                                        |    2 +-
>  kernel/sched/core.c                                  |   29 +-
>  kernel/sysctl.c                                      |    9 -
>  lib/Kconfig.debug                                    |    2 +-
>  lib/decompress_unxz.c                                |    3 -
>  lib/xz/Kconfig                                       |    5 -
>  mm/mmap.c                                            |    6 +-
>  scripts/headers_install.sh                           |    1 -
>  tools/arch/ia64/include/asm/barrier.h                |   59 -
>  tools/arch/ia64/include/uapi/asm/bitsperlong.h       |    9 -
>  tools/arch/ia64/include/uapi/asm/mman.h              |    7 -
>  usr/include/Makefile                                 |    6 -
>  362 files changed, 45 insertions(+), 65193 deletions(-)
> 
> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
> index f75778d374884810..67eab9742753e8f8 100644
> --- a/Documentation/core-api/cpu_hotplug.rst
> +++ b/Documentation/core-api/cpu_hotplug.rst
> @@ -40,12 +40,6 @@ Command Line Switches
>    supplied here is lower than the number of physically available CPUs, then
>    those CPUs can not be brought online later.
>  
> -``additional_cpus=n``
> -  Use this to limit hotpluggable CPUs. This option sets
> -  ``cpu_possible_mask = cpu_present_mask + additional_cpus``
> -
> -  This option is limited to the IA64 architecture.
> -
>  ``possible_cpus=n``
>    This option sets ``possible_cpus`` bits in ``cpu_possible_mask``.
>  
> diff --git a/Documentation/ia64/aliasing.rst b/Documentation/ia64/aliasing.rst
> deleted file mode 100644
> index 36a1e1d4842b8139..0000000000000000
> diff --git a/Documentation/ia64/efirtc.rst b/Documentation/ia64/efirtc.rst
> deleted file mode 100644
> index fd832840830152b8..0000000000000000
> diff --git a/Documentation/ia64/err_inject.rst b/Documentation/ia64/err_inject.rst
> deleted file mode 100644
> index 900f71e93a29c5ae..0000000000000000
> diff --git a/Documentation/ia64/features.rst b/Documentation/ia64/features.rst
> deleted file mode 100644
> index d7226fdcf5f8c003..0000000000000000
> diff --git a/Documentation/ia64/fsys.rst b/Documentation/ia64/fsys.rst
> deleted file mode 100644
> index a702d2cc94b6300e..0000000000000000
> diff --git a/Documentation/ia64/ia64.rst b/Documentation/ia64/ia64.rst
> deleted file mode 100644
> index b725019a94927f72..0000000000000000
> diff --git a/Documentation/ia64/index.rst b/Documentation/ia64/index.rst
> deleted file mode 100644
> index 761f2154dfa27a30..0000000000000000
> diff --git a/Documentation/ia64/irq-redir.rst b/Documentation/ia64/irq-redir.rst
> deleted file mode 100644
> index 6bbbbe4f73efc487..0000000000000000
> diff --git a/Documentation/ia64/mca.rst b/Documentation/ia64/mca.rst
> deleted file mode 100644
> index 08270bba44a44313..0000000000000000
> diff --git a/Documentation/ia64/serial.rst b/Documentation/ia64/serial.rst
> deleted file mode 100644
> index 1de70c305a7911cd..0000000000000000
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39ff1a7176252700..b797093f60cd048f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9840,12 +9840,6 @@ F:	Documentation/driver-api/i3c
>  F:	drivers/i3c/
>  F:	include/linux/i3c/
>  
> -IA64 (Itanium) PLATFORM
> -L:	linux-ia64@vger.kernel.org
> -S:	Orphan
> -F:	Documentation/ia64/
> -F:	arch/ia64/
> -
>  IBM Operation Panel Input Driver
>  M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-input@vger.kernel.org
> @@ -15930,11 +15924,6 @@ L:	linux-i2c@vger.kernel.org
>  S:	Maintained
>  F:	drivers/i2c/muxes/i2c-mux-pca9541.c
>  
> -PCDP - PRIMARY CONSOLE AND DEBUG PORT
> -M:	Khalid Aziz <khalid@gonehiking.org>
> -S:	Maintained
> -F:	drivers/firmware/pcdp.*
> -
>  PCI DRIVER FOR AARDVARK (Marvell Armada 3700)
>  M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>  M:	Pali Rohár <pali@kernel.org>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 12e3ddabac9d3be0..774448a24c511f22 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1036,7 +1036,6 @@ config HAVE_ARCH_COMPAT_MMAP_BASES
>  config PAGE_SIZE_LESS_THAN_64KB
>  	def_bool y
>  	depends on !ARM64_64K_PAGES
> -	depends on !IA64_PAGE_SIZE_64KB
>  	depends on !PAGE_SIZE_64KB
>  	depends on !PARISC_PAGE_SIZE_64KB
>  	depends on PAGE_SIZE_LESS_THAN_256KB
> diff --git a/arch/ia64/Kbuild b/arch/ia64/Kbuild
> deleted file mode 100644
> index e77cc76d228cdb8c..0000000000000000
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> deleted file mode 100644
> index d7e4a24e8644cdec..0000000000000000
> diff --git a/arch/ia64/Kconfig.debug b/arch/ia64/Kconfig.debug
> deleted file mode 100644
> index 2ce008e2d1644b84..0000000000000000
> diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
> deleted file mode 100644
> index d553ab7022fe4088..0000000000000000
> diff --git a/arch/ia64/configs/bigsur_defconfig b/arch/ia64/configs/bigsur_defconfig
> deleted file mode 100644
> index 3e1337aceb37154d..0000000000000000
> diff --git a/arch/ia64/configs/generic_defconfig b/arch/ia64/configs/generic_defconfig
> deleted file mode 100644
> index f8033bacea89e491..0000000000000000
> diff --git a/arch/ia64/configs/gensparse_defconfig b/arch/ia64/configs/gensparse_defconfig
> deleted file mode 100644
> index ffebe6c503f5119c..0000000000000000
> diff --git a/arch/ia64/configs/tiger_defconfig b/arch/ia64/configs/tiger_defconfig
> deleted file mode 100644
> index 45f5d6e2da0afc6a..0000000000000000
> diff --git a/arch/ia64/configs/zx1_defconfig b/arch/ia64/configs/zx1_defconfig
> deleted file mode 100644
> index ed104550d0d519a2..0000000000000000
> diff --git a/arch/ia64/hp/common/Makefile b/arch/ia64/hp/common/Makefile
> deleted file mode 100644
> index 11a56ed3822905e0..0000000000000000
> diff --git a/arch/ia64/hp/common/aml_nfw.c b/arch/ia64/hp/common/aml_nfw.c
> deleted file mode 100644
> index 901df49461a058fd..0000000000000000
> diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
> deleted file mode 100644
> index 8ad6946521d88d63..0000000000000000
> diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
> deleted file mode 100644
> index f994c1daf9d424f1..0000000000000000
> diff --git a/arch/ia64/include/asm/acenv.h b/arch/ia64/include/asm/acenv.h
> deleted file mode 100644
> index 9d673cd4c2ad1eaf..0000000000000000
> diff --git a/arch/ia64/include/asm/acpi-ext.h b/arch/ia64/include/asm/acpi-ext.h
> deleted file mode 100644
> index eaa57583d1515a78..0000000000000000
> diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
> deleted file mode 100644
> index 87927eb824ccd9ed..0000000000000000
> diff --git a/arch/ia64/include/asm/agp.h b/arch/ia64/include/asm/agp.h
> deleted file mode 100644
> index 0261507dc2649fce..0000000000000000
> diff --git a/arch/ia64/include/asm/asm-offsets.h b/arch/ia64/include/asm/asm-offsets.h
> deleted file mode 100644
> index d370ee36a182ba51..0000000000000000
> diff --git a/arch/ia64/include/asm/asm-prototypes.h b/arch/ia64/include/asm/asm-prototypes.h
> deleted file mode 100644
> index a96689447a74c62f..0000000000000000
> diff --git a/arch/ia64/include/asm/asmmacro.h b/arch/ia64/include/asm/asmmacro.h
> deleted file mode 100644
> index 52619c517f099e54..0000000000000000
> diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
> deleted file mode 100644
> index 266c429b91372e93..0000000000000000
> diff --git a/arch/ia64/include/asm/barrier.h b/arch/ia64/include/asm/barrier.h
> deleted file mode 100644
> index 751cdd3534469da4..0000000000000000
> diff --git a/arch/ia64/include/asm/bitops.h b/arch/ia64/include/asm/bitops.h
> deleted file mode 100644
> index 1accb7842f588064..0000000000000000
> diff --git a/arch/ia64/include/asm/bug.h b/arch/ia64/include/asm/bug.h
> deleted file mode 100644
> index 66b37a5327654f87..0000000000000000
> diff --git a/arch/ia64/include/asm/bugs.h b/arch/ia64/include/asm/bugs.h
> deleted file mode 100644
> index 0d6b9bded56c6ba2..0000000000000000
> diff --git a/arch/ia64/include/asm/cache.h b/arch/ia64/include/asm/cache.h
> deleted file mode 100644
> index 2f1c70647068270f..0000000000000000
> diff --git a/arch/ia64/include/asm/cacheflush.h b/arch/ia64/include/asm/cacheflush.h
> deleted file mode 100644
> index 708c0fa5d975e4d3..0000000000000000
> diff --git a/arch/ia64/include/asm/checksum.h b/arch/ia64/include/asm/checksum.h
> deleted file mode 100644
> index f3026213aa32b9ef..0000000000000000
> diff --git a/arch/ia64/include/asm/clocksource.h b/arch/ia64/include/asm/clocksource.h
> deleted file mode 100644
> index 71a517751afa80c3..0000000000000000
> diff --git a/arch/ia64/include/asm/cmpxchg.h b/arch/ia64/include/asm/cmpxchg.h
> deleted file mode 100644
> index 94ef844298431ad0..0000000000000000
> diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
> deleted file mode 100644
> index db125df9e0888228..0000000000000000
> diff --git a/arch/ia64/include/asm/cputime.h b/arch/ia64/include/asm/cputime.h
> deleted file mode 100644
> index 7f28c3564d5d5080..0000000000000000
> diff --git a/arch/ia64/include/asm/current.h b/arch/ia64/include/asm/current.h
> deleted file mode 100644
> index 86fbcc88dff2155b..0000000000000000
> diff --git a/arch/ia64/include/asm/cyclone.h b/arch/ia64/include/asm/cyclone.h
> deleted file mode 100644
> index a481393647e9e32c..0000000000000000
> diff --git a/arch/ia64/include/asm/delay.h b/arch/ia64/include/asm/delay.h
> deleted file mode 100644
> index 0227ac586107652c..0000000000000000
> diff --git a/arch/ia64/include/asm/device.h b/arch/ia64/include/asm/device.h
> deleted file mode 100644
> index 918b198cd5bbe5ed..0000000000000000
> diff --git a/arch/ia64/include/asm/div64.h b/arch/ia64/include/asm/div64.h
> deleted file mode 100644
> index 6cd978cefb2850be..0000000000000000
> diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
> deleted file mode 100644
> index a5d9d788eede1f1d..0000000000000000
> diff --git a/arch/ia64/include/asm/dma.h b/arch/ia64/include/asm/dma.h
> deleted file mode 100644
> index eaed2626ffdad3c6..0000000000000000
> diff --git a/arch/ia64/include/asm/dmi.h b/arch/ia64/include/asm/dmi.h
> deleted file mode 100644
> index ecd9e0a0f5f98ee1..0000000000000000
> diff --git a/arch/ia64/include/asm/early_ioremap.h b/arch/ia64/include/asm/early_ioremap.h
> deleted file mode 100644
> index 934191b1e2e3eaa4..0000000000000000
> diff --git a/arch/ia64/include/asm/efi.h b/arch/ia64/include/asm/efi.h
> deleted file mode 100644
> index 6a4a50d8f19a50f7..0000000000000000
> diff --git a/arch/ia64/include/asm/elf.h b/arch/ia64/include/asm/elf.h
> deleted file mode 100644
> index 2ef5f9966ad18fe6..0000000000000000
> diff --git a/arch/ia64/include/asm/emergency-restart.h b/arch/ia64/include/asm/emergency-restart.h
> deleted file mode 100644
> index 108d8c48e42e8697..0000000000000000
> diff --git a/arch/ia64/include/asm/esi.h b/arch/ia64/include/asm/esi.h
> deleted file mode 100644
> index 56d1310af06e5489..0000000000000000
> diff --git a/arch/ia64/include/asm/exception.h b/arch/ia64/include/asm/exception.h
> deleted file mode 100644
> index 1d5df8116a31268b..0000000000000000
> diff --git a/arch/ia64/include/asm/export.h b/arch/ia64/include/asm/export.h
> deleted file mode 100644
> index ad18c65832520b84..0000000000000000
> diff --git a/arch/ia64/include/asm/extable.h b/arch/ia64/include/asm/extable.h
> deleted file mode 100644
> index 83eac6aa06390146..0000000000000000
> diff --git a/arch/ia64/include/asm/fb.h b/arch/ia64/include/asm/fb.h
> deleted file mode 100644
> index 5f95782bfa46d665..0000000000000000
> diff --git a/arch/ia64/include/asm/fpswa.h b/arch/ia64/include/asm/fpswa.h
> deleted file mode 100644
> index 2a0c23728b263935..0000000000000000
> diff --git a/arch/ia64/include/asm/ftrace.h b/arch/ia64/include/asm/ftrace.h
> deleted file mode 100644
> index a07a8e57545388a7..0000000000000000
> diff --git a/arch/ia64/include/asm/futex.h b/arch/ia64/include/asm/futex.h
> deleted file mode 100644
> index 1db26b432d8c146f..0000000000000000
> diff --git a/arch/ia64/include/asm/gcc_intrin.h b/arch/ia64/include/asm/gcc_intrin.h
> deleted file mode 100644
> index 83f230b23867c29b..0000000000000000
> diff --git a/arch/ia64/include/asm/hardirq.h b/arch/ia64/include/asm/hardirq.h
> deleted file mode 100644
> index ccde7c2ba00f350c..0000000000000000
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> deleted file mode 100644
> index 026ead47cd53bd8a..0000000000000000
> diff --git a/arch/ia64/include/asm/hw_irq.h b/arch/ia64/include/asm/hw_irq.h
> deleted file mode 100644
> index 5d267132f8cbbced..0000000000000000
> diff --git a/arch/ia64/include/asm/idle.h b/arch/ia64/include/asm/idle.h
> deleted file mode 100644
> index 97c55b97e0ba556a..0000000000000000
> diff --git a/arch/ia64/include/asm/intrinsics.h b/arch/ia64/include/asm/intrinsics.h
> deleted file mode 100644
> index 035b17fe12ef032e..0000000000000000
> diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
> deleted file mode 100644
> index 83a492c8d2985e27..0000000000000000
> diff --git a/arch/ia64/include/asm/iommu.h b/arch/ia64/include/asm/iommu.h
> deleted file mode 100644
> index eb0db20c9d4c0caa..0000000000000000
> diff --git a/arch/ia64/include/asm/iosapic.h b/arch/ia64/include/asm/iosapic.h
> deleted file mode 100644
> index a91aeb413e17b4c5..0000000000000000
> diff --git a/arch/ia64/include/asm/irq.h b/arch/ia64/include/asm/irq.h
> deleted file mode 100644
> index 0eccf33dfe8be99e..0000000000000000
> diff --git a/arch/ia64/include/asm/irq_regs.h b/arch/ia64/include/asm/irq_regs.h
> deleted file mode 100644
> index 3dd9c0b702704abf..0000000000000000
> diff --git a/arch/ia64/include/asm/irq_remapping.h b/arch/ia64/include/asm/irq_remapping.h
> deleted file mode 100644
> index 547a6e87018c4b61..0000000000000000
> diff --git a/arch/ia64/include/asm/irqflags.h b/arch/ia64/include/asm/irqflags.h
> deleted file mode 100644
> index 1dc30f12e545ad55..0000000000000000
> diff --git a/arch/ia64/include/asm/kdebug.h b/arch/ia64/include/asm/kdebug.h
> deleted file mode 100644
> index 4f7e6dc974bc97e3..0000000000000000
> diff --git a/arch/ia64/include/asm/kexec.h b/arch/ia64/include/asm/kexec.h
> deleted file mode 100644
> index 294b1e1ebd2d99df..0000000000000000
> diff --git a/arch/ia64/include/asm/kprobes.h b/arch/ia64/include/asm/kprobes.h
> deleted file mode 100644
> index 9e956768946cc84a..0000000000000000
> diff --git a/arch/ia64/include/asm/kregs.h b/arch/ia64/include/asm/kregs.h
> deleted file mode 100644
> index 44113b75e4ebbd57..0000000000000000
> diff --git a/arch/ia64/include/asm/libata-portmap.h b/arch/ia64/include/asm/libata-portmap.h
> deleted file mode 100644
> index 757f84e5dc6e83fa..0000000000000000
> diff --git a/arch/ia64/include/asm/linkage.h b/arch/ia64/include/asm/linkage.h
> deleted file mode 100644
> index 5178af560925e1ef..0000000000000000
> diff --git a/arch/ia64/include/asm/local.h b/arch/ia64/include/asm/local.h
> deleted file mode 100644
> index c11c530f74d02877..0000000000000000
> diff --git a/arch/ia64/include/asm/mca.h b/arch/ia64/include/asm/mca.h
> deleted file mode 100644
> index 05805249296cd523..0000000000000000
> diff --git a/arch/ia64/include/asm/mca_asm.h b/arch/ia64/include/asm/mca_asm.h
> deleted file mode 100644
> index e3ab1f41f1c3cf34..0000000000000000
> diff --git a/arch/ia64/include/asm/meminit.h b/arch/ia64/include/asm/meminit.h
> deleted file mode 100644
> index f1d5bf2ba847a135..0000000000000000
> diff --git a/arch/ia64/include/asm/mman.h b/arch/ia64/include/asm/mman.h
> deleted file mode 100644
> index 15cf100add0e7bd6..0000000000000000
> diff --git a/arch/ia64/include/asm/mmiowb.h b/arch/ia64/include/asm/mmiowb.h
> deleted file mode 100644
> index d67aab4ea3b4226d..0000000000000000
> diff --git a/arch/ia64/include/asm/mmu.h b/arch/ia64/include/asm/mmu.h
> deleted file mode 100644
> index f75f44f531c2e865..0000000000000000
> diff --git a/arch/ia64/include/asm/mmu_context.h b/arch/ia64/include/asm/mmu_context.h
> deleted file mode 100644
> index 06257e355d00761f..0000000000000000
> diff --git a/arch/ia64/include/asm/mmzone.h b/arch/ia64/include/asm/mmzone.h
> deleted file mode 100644
> index 767201f66c93e8df..0000000000000000
> diff --git a/arch/ia64/include/asm/module.h b/arch/ia64/include/asm/module.h
> deleted file mode 100644
> index 7271b9c5fc7605b7..0000000000000000
> diff --git a/arch/ia64/include/asm/module.lds.h b/arch/ia64/include/asm/module.lds.h
> deleted file mode 100644
> index eff68f362793ab85..0000000000000000
> diff --git a/arch/ia64/include/asm/msidef.h b/arch/ia64/include/asm/msidef.h
> deleted file mode 100644
> index 18d0e4226748d5bf..0000000000000000
> diff --git a/arch/ia64/include/asm/native/inst.h b/arch/ia64/include/asm/native/inst.h
> deleted file mode 100644
> index e0866239602916b6..0000000000000000
> diff --git a/arch/ia64/include/asm/native/irq.h b/arch/ia64/include/asm/native/irq.h
> deleted file mode 100644
> index aa74915f8aa21c16..0000000000000000
> diff --git a/arch/ia64/include/asm/native/patchlist.h b/arch/ia64/include/asm/native/patchlist.h
> deleted file mode 100644
> index f13e7675758cde3f..0000000000000000
> diff --git a/arch/ia64/include/asm/nodedata.h b/arch/ia64/include/asm/nodedata.h
> deleted file mode 100644
> index 2fb337b0e9b78648..0000000000000000
> diff --git a/arch/ia64/include/asm/numa.h b/arch/ia64/include/asm/numa.h
> deleted file mode 100644
> index c5c253cb9bd63ad8..0000000000000000
> diff --git a/arch/ia64/include/asm/page.h b/arch/ia64/include/asm/page.h
> deleted file mode 100644
> index 1b990466d5404e60..0000000000000000
> diff --git a/arch/ia64/include/asm/pal.h b/arch/ia64/include/asm/pal.h
> deleted file mode 100644
> index e6b652f9e45e2973..0000000000000000
> diff --git a/arch/ia64/include/asm/param.h b/arch/ia64/include/asm/param.h
> deleted file mode 100644
> index f0b786227c409132..0000000000000000
> diff --git a/arch/ia64/include/asm/parport.h b/arch/ia64/include/asm/parport.h
> deleted file mode 100644
> index 360ca9bf2f6f77dd..0000000000000000
> diff --git a/arch/ia64/include/asm/patch.h b/arch/ia64/include/asm/patch.h
> deleted file mode 100644
> index bd487ed22bf59715..0000000000000000
> diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
> deleted file mode 100644
> index fa8f545c24c957fa..0000000000000000
> diff --git a/arch/ia64/include/asm/percpu.h b/arch/ia64/include/asm/percpu.h
> deleted file mode 100644
> index f357b9bb3576a109..0000000000000000
> diff --git a/arch/ia64/include/asm/pgalloc.h b/arch/ia64/include/asm/pgalloc.h
> deleted file mode 100644
> index 0fb2b6291d58dc3a..0000000000000000
> diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
> deleted file mode 100644
> index 01517a5e677891b2..0000000000000000
> diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
> deleted file mode 100644
> index d1978e0040548fba..0000000000000000
> diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
> deleted file mode 100644
> index 402874489890aa35..0000000000000000
> diff --git a/arch/ia64/include/asm/sal.h b/arch/ia64/include/asm/sal.h
> deleted file mode 100644
> index 22749a201e92af3b..0000000000000000
> diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
> deleted file mode 100644
> index 8e0875cf60712648..0000000000000000
> diff --git a/arch/ia64/include/asm/serial.h b/arch/ia64/include/asm/serial.h
> deleted file mode 100644
> index 068be11583df425c..0000000000000000
> diff --git a/arch/ia64/include/asm/shmparam.h b/arch/ia64/include/asm/shmparam.h
> deleted file mode 100644
> index 43bd8324ab715059..0000000000000000
> diff --git a/arch/ia64/include/asm/signal.h b/arch/ia64/include/asm/signal.h
> deleted file mode 100644
> index 80f067f9b3ce85d3..0000000000000000
> diff --git a/arch/ia64/include/asm/smp.h b/arch/ia64/include/asm/smp.h
> deleted file mode 100644
> index aa92234c01422ee0..0000000000000000
> diff --git a/arch/ia64/include/asm/sn/intr.h b/arch/ia64/include/asm/sn/intr.h
> deleted file mode 100644
> index 3885a77b21dfda6d..0000000000000000
> diff --git a/arch/ia64/include/asm/sn/sn_sal.h b/arch/ia64/include/asm/sn/sn_sal.h
> deleted file mode 100644
> index d437aa43343b3489..0000000000000000
> diff --git a/arch/ia64/include/asm/sparsemem.h b/arch/ia64/include/asm/sparsemem.h
> deleted file mode 100644
> index 84e8ce387b698629..0000000000000000
> diff --git a/arch/ia64/include/asm/spinlock.h b/arch/ia64/include/asm/spinlock.h
> deleted file mode 100644
> index 0e5c1ad3239c48da..0000000000000000
> diff --git a/arch/ia64/include/asm/spinlock_types.h b/arch/ia64/include/asm/spinlock_types.h
> deleted file mode 100644
> index 14b8a161c1652215..0000000000000000
> diff --git a/arch/ia64/include/asm/string.h b/arch/ia64/include/asm/string.h
> deleted file mode 100644
> index 8b84df0dbfad025f..0000000000000000
> diff --git a/arch/ia64/include/asm/switch_to.h b/arch/ia64/include/asm/switch_to.h
> deleted file mode 100644
> index a5a4e09468fa91df..0000000000000000
> diff --git a/arch/ia64/include/asm/syscall.h b/arch/ia64/include/asm/syscall.h
> deleted file mode 100644
> index 2b02a3fb862ade3c..0000000000000000
> diff --git a/arch/ia64/include/asm/thread_info.h b/arch/ia64/include/asm/thread_info.h
> deleted file mode 100644
> index 21b257117e0a9940..0000000000000000
> diff --git a/arch/ia64/include/asm/timex.h b/arch/ia64/include/asm/timex.h
> deleted file mode 100644
> index 7ccc077a60bedd9c..0000000000000000
> diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
> deleted file mode 100644
> index a15fe0809aaed4d1..0000000000000000
> diff --git a/arch/ia64/include/asm/tlbflush.h b/arch/ia64/include/asm/tlbflush.h
> deleted file mode 100644
> index ceac10c4d6e2f3e1..0000000000000000
> diff --git a/arch/ia64/include/asm/topology.h b/arch/ia64/include/asm/topology.h
> deleted file mode 100644
> index 43567240b0d670f3..0000000000000000
> diff --git a/arch/ia64/include/asm/types.h b/arch/ia64/include/asm/types.h
> deleted file mode 100644
> index 5ddc7703de99c06c..0000000000000000
> diff --git a/arch/ia64/include/asm/uaccess.h b/arch/ia64/include/asm/uaccess.h
> deleted file mode 100644
> index 60adadeb3e9e50a2..0000000000000000
> diff --git a/arch/ia64/include/asm/uncached.h b/arch/ia64/include/asm/uncached.h
> deleted file mode 100644
> index 98f447fc77b7fac1..0000000000000000
> diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
> deleted file mode 100644
> index 9ba6110b10b9c063..0000000000000000
> diff --git a/arch/ia64/include/asm/unwind.h b/arch/ia64/include/asm/unwind.h
> deleted file mode 100644
> index c5bd4b3e3a364e5f..0000000000000000
> diff --git a/arch/ia64/include/asm/user.h b/arch/ia64/include/asm/user.h
> deleted file mode 100644
> index ec03d3ab87152fe4..0000000000000000
> diff --git a/arch/ia64/include/asm/ustack.h b/arch/ia64/include/asm/ustack.h
> deleted file mode 100644
> index 112d40a0fec20676..0000000000000000
> diff --git a/arch/ia64/include/asm/uv/uv.h b/arch/ia64/include/asm/uv/uv.h
> deleted file mode 100644
> index 48d4526bf4cd5af3..0000000000000000
> diff --git a/arch/ia64/include/asm/uv/uv_hub.h b/arch/ia64/include/asm/uv/uv_hub.h
> deleted file mode 100644
> index 809ddb6896db554a..0000000000000000
> diff --git a/arch/ia64/include/asm/uv/uv_mmrs.h b/arch/ia64/include/asm/uv/uv_mmrs.h
> deleted file mode 100644
> index fe0b8f05e1a8719c..0000000000000000
> diff --git a/arch/ia64/include/asm/vermagic.h b/arch/ia64/include/asm/vermagic.h
> deleted file mode 100644
> index 29c7424f4c25cec3..0000000000000000
> diff --git a/arch/ia64/include/asm/vga.h b/arch/ia64/include/asm/vga.h
> deleted file mode 100644
> index 64ce0b971a0a1df0..0000000000000000
> diff --git a/arch/ia64/include/asm/vmalloc.h b/arch/ia64/include/asm/vmalloc.h
> deleted file mode 100644
> index a2b51141ad2850c6..0000000000000000
> diff --git a/arch/ia64/include/asm/xor.h b/arch/ia64/include/asm/xor.h
> deleted file mode 100644
> index 6785f70d3208bc55..0000000000000000
> diff --git a/arch/ia64/include/asm/xtp.h b/arch/ia64/include/asm/xtp.h
> deleted file mode 100644
> index 5bf1d70ad860a091..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
> deleted file mode 100644
> index 3a1341e3535a8c71..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/auxvec.h b/arch/ia64/include/uapi/asm/auxvec.h
> deleted file mode 100644
> index 09969a5d2e0a9e60..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/bitsperlong.h b/arch/ia64/include/uapi/asm/bitsperlong.h
> deleted file mode 100644
> index 1146d55563db3773..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/break.h b/arch/ia64/include/uapi/asm/break.h
> deleted file mode 100644
> index 4ca110f0a94b7c94..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/byteorder.h b/arch/ia64/include/uapi/asm/byteorder.h
> deleted file mode 100644
> index f85d0faaaf34bca6..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/cmpxchg.h b/arch/ia64/include/uapi/asm/cmpxchg.h
> deleted file mode 100644
> index ca2e02685343844b..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/fcntl.h b/arch/ia64/include/uapi/asm/fcntl.h
> deleted file mode 100644
> index 7b95523efe5a8eb8..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/fpu.h b/arch/ia64/include/uapi/asm/fpu.h
> deleted file mode 100644
> index 0df392982ce8ab08..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/gcc_intrin.h b/arch/ia64/include/uapi/asm/gcc_intrin.h
> deleted file mode 100644
> index ecfa3eadb2176fbd..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/ia64regs.h b/arch/ia64/include/uapi/asm/ia64regs.h
> deleted file mode 100644
> index d7d10cec8b9f3386..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/intel_intrin.h b/arch/ia64/include/uapi/asm/intel_intrin.h
> deleted file mode 100644
> index dc1884dc54b5e843..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/intrinsics.h b/arch/ia64/include/uapi/asm/intrinsics.h
> deleted file mode 100644
> index a0e0a064f5b120ca..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/mman.h b/arch/ia64/include/uapi/asm/mman.h
> deleted file mode 100644
> index ce0cc3d7509e2b56..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/param.h b/arch/ia64/include/uapi/asm/param.h
> deleted file mode 100644
> index 123ab45940b46a3e..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/posix_types.h b/arch/ia64/include/uapi/asm/posix_types.h
> deleted file mode 100644
> index bded40f7defe5724..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/ptrace.h b/arch/ia64/include/uapi/asm/ptrace.h
> deleted file mode 100644
> index f52655b44414591d..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/ptrace_offsets.h b/arch/ia64/include/uapi/asm/ptrace_offsets.h
> deleted file mode 100644
> index 2847c18139ef8a13..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/resource.h b/arch/ia64/include/uapi/asm/resource.h
> deleted file mode 100644
> index d488d2b22ac40e6b..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/rse.h b/arch/ia64/include/uapi/asm/rse.h
> deleted file mode 100644
> index 6d260af571c5d42b..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/setup.h b/arch/ia64/include/uapi/asm/setup.h
> deleted file mode 100644
> index 8d13ce8fb03aede3..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/sigcontext.h b/arch/ia64/include/uapi/asm/sigcontext.h
> deleted file mode 100644
> index 1bb6f0f2bd73933e..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/siginfo.h b/arch/ia64/include/uapi/asm/siginfo.h
> deleted file mode 100644
> index 796af1ccaa7e4997..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/signal.h b/arch/ia64/include/uapi/asm/signal.h
> deleted file mode 100644
> index 63d574e802a209f0..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/stat.h b/arch/ia64/include/uapi/asm/stat.h
> deleted file mode 100644
> index 3265ed5aac0f429a..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/statfs.h b/arch/ia64/include/uapi/asm/statfs.h
> deleted file mode 100644
> index de3bae4f137debb9..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/swab.h b/arch/ia64/include/uapi/asm/swab.h
> deleted file mode 100644
> index 79f3fef1a05ea73c..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/types.h b/arch/ia64/include/uapi/asm/types.h
> deleted file mode 100644
> index 2000de474be63ce3..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/ucontext.h b/arch/ia64/include/uapi/asm/ucontext.h
> deleted file mode 100644
> index 46f51e535e049d60..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
> deleted file mode 100644
> index 013e0bcacc39e025..0000000000000000
> diff --git a/arch/ia64/include/uapi/asm/ustack.h b/arch/ia64/include/uapi/asm/ustack.h
> deleted file mode 100644
> index 703cc5f546ff63e5..0000000000000000
> diff --git a/arch/ia64/install.sh b/arch/ia64/install.sh
> deleted file mode 100755
> index 2d4b66a9f362c369..0000000000000000
> diff --git a/arch/ia64/kernel/.gitignore b/arch/ia64/kernel/.gitignore
> deleted file mode 100644
> index 0374827206e76167..0000000000000000
> diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
> deleted file mode 100644
> index ae9ff07de4abe419..0000000000000000
> diff --git a/arch/ia64/kernel/Makefile.gate b/arch/ia64/kernel/Makefile.gate
> deleted file mode 100644
> index 846867bff6d6565c..0000000000000000
> diff --git a/arch/ia64/kernel/acpi-ext.c b/arch/ia64/kernel/acpi-ext.c
> deleted file mode 100644
> index 42cd21480833668d..0000000000000000
> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> deleted file mode 100644
> index 96d13cb7c19f085c..0000000000000000
> diff --git a/arch/ia64/kernel/asm-offsets.c b/arch/ia64/kernel/asm-offsets.c
> deleted file mode 100644
> index be3b90fef2e9218b..0000000000000000
> diff --git a/arch/ia64/kernel/audit.c b/arch/ia64/kernel/audit.c
> deleted file mode 100644
> index ec61f20ca61f4627..0000000000000000
> diff --git a/arch/ia64/kernel/brl_emu.c b/arch/ia64/kernel/brl_emu.c
> deleted file mode 100644
> index 782c481d70529ea8..0000000000000000
> diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
> deleted file mode 100644
> index 76730f34685c4511..0000000000000000
> diff --git a/arch/ia64/kernel/crash_dump.c b/arch/ia64/kernel/crash_dump.c
> deleted file mode 100644
> index 4ef68e2aa7571793..0000000000000000
> diff --git a/arch/ia64/kernel/cyclone.c b/arch/ia64/kernel/cyclone.c
> deleted file mode 100644
> index 258d7b70c0f38534..0000000000000000
> diff --git a/arch/ia64/kernel/dma-mapping.c b/arch/ia64/kernel/dma-mapping.c
> deleted file mode 100644
> index cd0c166bfbc23ed0..0000000000000000
> diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
> deleted file mode 100644
> index 31149e41f9be0913..0000000000000000
> diff --git a/arch/ia64/kernel/efi_stub.S b/arch/ia64/kernel/efi_stub.S
> deleted file mode 100644
> index 1fd61b78fb290264..0000000000000000
> diff --git a/arch/ia64/kernel/elfcore.c b/arch/ia64/kernel/elfcore.c
> deleted file mode 100644
> index 8895df1215404791..0000000000000000
> diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
> deleted file mode 100644
> index 5eba3fb2e3115285..0000000000000000
> diff --git a/arch/ia64/kernel/entry.h b/arch/ia64/kernel/entry.h
> deleted file mode 100644
> index 6463dc316263c5b5..0000000000000000
> diff --git a/arch/ia64/kernel/err_inject.c b/arch/ia64/kernel/err_inject.c
> deleted file mode 100644
> index dd5bfed52031de81..0000000000000000
> diff --git a/arch/ia64/kernel/esi.c b/arch/ia64/kernel/esi.c
> deleted file mode 100644
> index 4df57c93e0a8c48d..0000000000000000
> diff --git a/arch/ia64/kernel/esi_stub.S b/arch/ia64/kernel/esi_stub.S
> deleted file mode 100644
> index 821e68d105987445..0000000000000000
> diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
> deleted file mode 100644
> index 2094f324901982e2..0000000000000000
> diff --git a/arch/ia64/kernel/fsyscall_gtod_data.h b/arch/ia64/kernel/fsyscall_gtod_data.h
> deleted file mode 100644
> index cc2861445965464b..0000000000000000
> diff --git a/arch/ia64/kernel/ftrace.c b/arch/ia64/kernel/ftrace.c
> deleted file mode 100644
> index d6360fd404ab21a8..0000000000000000
> diff --git a/arch/ia64/kernel/gate-data.S b/arch/ia64/kernel/gate-data.S
> deleted file mode 100644
> index b3ef1c72e132b44e..0000000000000000
> diff --git a/arch/ia64/kernel/gate.S b/arch/ia64/kernel/gate.S
> deleted file mode 100644
> index 9f235cd551abf047..0000000000000000
> diff --git a/arch/ia64/kernel/gate.lds.S b/arch/ia64/kernel/gate.lds.S
> deleted file mode 100644
> index 461c7e69d4656577..0000000000000000
> diff --git a/arch/ia64/kernel/head.S b/arch/ia64/kernel/head.S
> deleted file mode 100644
> index f22469f1c1fcccd5..0000000000000000
> diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
> deleted file mode 100644
> index 99300850abc193be..0000000000000000
> diff --git a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
> deleted file mode 100644
> index 275b9ea58c643e69..0000000000000000
> diff --git a/arch/ia64/kernel/irq.h b/arch/ia64/kernel/irq.h
> deleted file mode 100644
> index 4d16f3cbeb1d94d3..0000000000000000
> diff --git a/arch/ia64/kernel/irq_ia64.c b/arch/ia64/kernel/irq_ia64.c
> deleted file mode 100644
> index 46e33c5cb53dc662..0000000000000000
> diff --git a/arch/ia64/kernel/irq_lsapic.c b/arch/ia64/kernel/irq_lsapic.c
> deleted file mode 100644
> index 23bf4499a75d9937..0000000000000000
> diff --git a/arch/ia64/kernel/ivt.S b/arch/ia64/kernel/ivt.S
> deleted file mode 100644
> index d6d4229b28db8ba1..0000000000000000
> diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
> deleted file mode 100644
> index ca34e51e84b4b552..0000000000000000
> diff --git a/arch/ia64/kernel/machine_kexec.c b/arch/ia64/kernel/machine_kexec.c
> deleted file mode 100644
> index 4db9ca144fa5ee18..0000000000000000
> diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
> deleted file mode 100644
> index 92ede80d17fea68d..0000000000000000
> diff --git a/arch/ia64/kernel/mca_asm.S b/arch/ia64/kernel/mca_asm.S
> deleted file mode 100644
> index 0d6b8cf9d1d0627f..0000000000000000
> diff --git a/arch/ia64/kernel/mca_drv.c b/arch/ia64/kernel/mca_drv.c
> deleted file mode 100644
> index 23c203639a96823b..0000000000000000
> diff --git a/arch/ia64/kernel/mca_drv.h b/arch/ia64/kernel/mca_drv.h
> deleted file mode 100644
> index 45bc4e3ae14f23f8..0000000000000000
> diff --git a/arch/ia64/kernel/mca_drv_asm.S b/arch/ia64/kernel/mca_drv_asm.S
> deleted file mode 100644
> index 4428f57bee73565b..0000000000000000
> diff --git a/arch/ia64/kernel/minstate.h b/arch/ia64/kernel/minstate.h
> deleted file mode 100644
> index d6eab2a1084d2071..0000000000000000
> diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
> deleted file mode 100644
> index 8f62cf97f691aea5..0000000000000000
> diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
> deleted file mode 100644
> index 025e5133c860ce6d..0000000000000000
> diff --git a/arch/ia64/kernel/numa.c b/arch/ia64/kernel/numa.c
> deleted file mode 100644
> index 8a959f20662d55f7..0000000000000000
> diff --git a/arch/ia64/kernel/pal.S b/arch/ia64/kernel/pal.S
> deleted file mode 100644
> index 06d01a070aae24e6..0000000000000000
> diff --git a/arch/ia64/kernel/palinfo.c b/arch/ia64/kernel/palinfo.c
> deleted file mode 100644
> index b9ae093bfe3764c2..0000000000000000
> diff --git a/arch/ia64/kernel/patch.c b/arch/ia64/kernel/patch.c
> deleted file mode 100644
> index 7f21a8c57ed7c033..0000000000000000
> diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
> deleted file mode 100644
> index c90221733c6b91e0..0000000000000000
> diff --git a/arch/ia64/kernel/perfmon_itanium.h b/arch/ia64/kernel/perfmon_itanium.h
> deleted file mode 100644
> index dbd04028aafa42f1..0000000000000000
> diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
> deleted file mode 100644
> index 416305e550e28183..0000000000000000
> diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
> deleted file mode 100644
> index 4c41912c550f76bc..0000000000000000
> diff --git a/arch/ia64/kernel/relocate_kernel.S b/arch/ia64/kernel/relocate_kernel.S
> deleted file mode 100644
> index 527a7b896a6e5535..0000000000000000
> diff --git a/arch/ia64/kernel/sal.c b/arch/ia64/kernel/sal.c
> deleted file mode 100644
> index e4f0705c028253c3..0000000000000000
> diff --git a/arch/ia64/kernel/salinfo.c b/arch/ia64/kernel/salinfo.c
> deleted file mode 100644
> index bd3ba276e69c3ca9..0000000000000000
> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
> deleted file mode 100644
> index c0572804427275e7..0000000000000000
> diff --git a/arch/ia64/kernel/sigframe.h b/arch/ia64/kernel/sigframe.h
> deleted file mode 100644
> index 58a36ce6c26eec4b..0000000000000000
> diff --git a/arch/ia64/kernel/signal.c b/arch/ia64/kernel/signal.c
> deleted file mode 100644
> index 51cf6a7ec158ab68..0000000000000000
> diff --git a/arch/ia64/kernel/smp.c b/arch/ia64/kernel/smp.c
> deleted file mode 100644
> index e2cc59db86bc2dc7..0000000000000000
> diff --git a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
> deleted file mode 100644
> index d0e935cf2093af38..0000000000000000
> diff --git a/arch/ia64/kernel/stacktrace.c b/arch/ia64/kernel/stacktrace.c
> deleted file mode 100644
> index 6e583a6bd2f681bc..0000000000000000
> diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
> deleted file mode 100644
> index 6e948d015332abc0..0000000000000000
> diff --git a/arch/ia64/kernel/syscalls/Makefile b/arch/ia64/kernel/syscalls/Makefile
> deleted file mode 100644
> index d009f927a0482bc9..0000000000000000
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> deleted file mode 100644
> index 72c929d9902b9960..0000000000000000
> diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
> deleted file mode 100644
> index fa9c0ab8c6fc955b..0000000000000000
> diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
> deleted file mode 100644
> index 94a848b06f15a964..0000000000000000
> diff --git a/arch/ia64/kernel/traps.c b/arch/ia64/kernel/traps.c
> deleted file mode 100644
> index 53735b1d1be3a88c..0000000000000000
> diff --git a/arch/ia64/kernel/unaligned.c b/arch/ia64/kernel/unaligned.c
> deleted file mode 100644
> index 0acb5a0cd7ab17df..0000000000000000
> diff --git a/arch/ia64/kernel/uncached.c b/arch/ia64/kernel/uncached.c
> deleted file mode 100644
> index a0fec82c56b88e4b..0000000000000000
> diff --git a/arch/ia64/kernel/unwind.c b/arch/ia64/kernel/unwind.c
> deleted file mode 100644
> index 6bd64c35e691ae9e..0000000000000000
> diff --git a/arch/ia64/kernel/unwind_decoder.c b/arch/ia64/kernel/unwind_decoder.c
> deleted file mode 100644
> index 83f54f7929b5ea33..0000000000000000
> diff --git a/arch/ia64/kernel/unwind_i.h b/arch/ia64/kernel/unwind_i.h
> deleted file mode 100644
> index 1dd57ba443276a31..0000000000000000
> diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
> deleted file mode 100644
> index 9b265783be6a193d..0000000000000000
> diff --git a/arch/ia64/lib/Makefile b/arch/ia64/lib/Makefile
> deleted file mode 100644
> index 081fcba01dc0c0ae..0000000000000000
> diff --git a/arch/ia64/lib/checksum.c b/arch/ia64/lib/checksum.c
> deleted file mode 100644
> index d26517fe3500a1f7..0000000000000000
> diff --git a/arch/ia64/lib/clear_page.S b/arch/ia64/lib/clear_page.S
> deleted file mode 100644
> index 65b75085c8f46c23..0000000000000000
> diff --git a/arch/ia64/lib/clear_user.S b/arch/ia64/lib/clear_user.S
> deleted file mode 100644
> index a28f39d349ebeabb..0000000000000000
> diff --git a/arch/ia64/lib/copy_page.S b/arch/ia64/lib/copy_page.S
> deleted file mode 100644
> index 176f857c522e8a9d..0000000000000000
> diff --git a/arch/ia64/lib/copy_page_mck.S b/arch/ia64/lib/copy_page_mck.S
> deleted file mode 100644
> index d6fd56e4f1c1dcac..0000000000000000
> diff --git a/arch/ia64/lib/copy_user.S b/arch/ia64/lib/copy_user.S
> deleted file mode 100644
> index f681556c6b86d995..0000000000000000
> diff --git a/arch/ia64/lib/csum_partial_copy.c b/arch/ia64/lib/csum_partial_copy.c
> deleted file mode 100644
> index 917e3138b277c4ad..0000000000000000
> diff --git a/arch/ia64/lib/do_csum.S b/arch/ia64/lib/do_csum.S
> deleted file mode 100644
> index 6004dad2597c3e38..0000000000000000
> diff --git a/arch/ia64/lib/flush.S b/arch/ia64/lib/flush.S
> deleted file mode 100644
> index 8573d59c9ed17098..0000000000000000
> diff --git a/arch/ia64/lib/idiv32.S b/arch/ia64/lib/idiv32.S
> deleted file mode 100644
> index def92b708e6e1f20..0000000000000000
> diff --git a/arch/ia64/lib/idiv64.S b/arch/ia64/lib/idiv64.S
> deleted file mode 100644
> index a8ba3bd3d4d8cc54..0000000000000000
> diff --git a/arch/ia64/lib/io.c b/arch/ia64/lib/io.c
> deleted file mode 100644
> index c3e02462ed1694b8..0000000000000000
> diff --git a/arch/ia64/lib/ip_fast_csum.S b/arch/ia64/lib/ip_fast_csum.S
> deleted file mode 100644
> index dc9e6e6fe87695a4..0000000000000000
> diff --git a/arch/ia64/lib/memcpy.S b/arch/ia64/lib/memcpy.S
> deleted file mode 100644
> index 91a625fddbf0599e..0000000000000000
> diff --git a/arch/ia64/lib/memcpy_mck.S b/arch/ia64/lib/memcpy_mck.S
> deleted file mode 100644
> index cc4e6ac914b6c269..0000000000000000
> diff --git a/arch/ia64/lib/memset.S b/arch/ia64/lib/memset.S
> deleted file mode 100644
> index 07a8b92c64965e25..0000000000000000
> diff --git a/arch/ia64/lib/strlen.S b/arch/ia64/lib/strlen.S
> deleted file mode 100644
> index d66de596697441c8..0000000000000000
> diff --git a/arch/ia64/lib/strncpy_from_user.S b/arch/ia64/lib/strncpy_from_user.S
> deleted file mode 100644
> index 49eb81b69cd224f7..0000000000000000
> diff --git a/arch/ia64/lib/strnlen_user.S b/arch/ia64/lib/strnlen_user.S
> deleted file mode 100644
> index 4b684d4da10644db..0000000000000000
> diff --git a/arch/ia64/lib/xor.S b/arch/ia64/lib/xor.S
> deleted file mode 100644
> index 5413dafe6b2e0103..0000000000000000
> diff --git a/arch/ia64/mm/Makefile b/arch/ia64/mm/Makefile
> deleted file mode 100644
> index c03f63c62ac44785..0000000000000000
> diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
> deleted file mode 100644
> index 24901d8093015418..0000000000000000
> diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
> deleted file mode 100644
> index 73d0db36edb6002f..0000000000000000
> diff --git a/arch/ia64/mm/extable.c b/arch/ia64/mm/extable.c
> deleted file mode 100644
> index da477c11770b056b..0000000000000000
> diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
> deleted file mode 100644
> index ef78c2d66cdde243..0000000000000000
> diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
> deleted file mode 100644
> index 380d2f3966c98625..0000000000000000
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> deleted file mode 100644
> index fc4e4217e87ff5a0..0000000000000000
> diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
> deleted file mode 100644
> index 55fd3eb753ff94fe..0000000000000000
> diff --git a/arch/ia64/mm/numa.c b/arch/ia64/mm/numa.c
> deleted file mode 100644
> index 4c7b1f50e3b7d50c..0000000000000000
> diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
> deleted file mode 100644
> index ca060e7a2a466fc0..0000000000000000
> diff --git a/arch/ia64/pci/Makefile b/arch/ia64/pci/Makefile
> deleted file mode 100644
> index 81ea50eeb5271606..0000000000000000
> diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
> deleted file mode 100644
> index 2bcdd7d3a1adad58..0000000000000000
> diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
> deleted file mode 100644
> index 211757e34198a352..0000000000000000
> diff --git a/arch/ia64/scripts/check-gas b/arch/ia64/scripts/check-gas
> deleted file mode 100755
> index 787cf9b6b04a6837..0000000000000000
> diff --git a/arch/ia64/scripts/check-gas-asm.S b/arch/ia64/scripts/check-gas-asm.S
> deleted file mode 100644
> index 010e1d227e5dbeb1..0000000000000000
> diff --git a/arch/ia64/scripts/check-model.c b/arch/ia64/scripts/check-model.c
> deleted file mode 100644
> index e1d4e86e3d63b430..0000000000000000
> diff --git a/arch/ia64/scripts/check-segrel.S b/arch/ia64/scripts/check-segrel.S
> deleted file mode 100644
> index 65d6378adaaaa5fb..0000000000000000
> diff --git a/arch/ia64/scripts/check-segrel.lds b/arch/ia64/scripts/check-segrel.lds
> deleted file mode 100644
> index c385d246e45846e2..0000000000000000
> diff --git a/arch/ia64/scripts/check-serialize.S b/arch/ia64/scripts/check-serialize.S
> deleted file mode 100644
> index 0400c106806cd58d..0000000000000000
> diff --git a/arch/ia64/scripts/check-text-align.S b/arch/ia64/scripts/check-text-align.S
> deleted file mode 100644
> index 107fa1c88c2e115f..0000000000000000
> diff --git a/arch/ia64/scripts/toolchain-flags b/arch/ia64/scripts/toolchain-flags
> deleted file mode 100755
> index 12dff5c981cf1cf3..0000000000000000
> diff --git a/arch/ia64/scripts/unwcheck.py b/arch/ia64/scripts/unwcheck.py
> deleted file mode 100644
> index 9581742f0db23c21..0000000000000000
> diff --git a/arch/ia64/uv/Makefile b/arch/ia64/uv/Makefile
> deleted file mode 100644
> index aa9f91947c492341..0000000000000000
> diff --git a/arch/ia64/uv/kernel/Makefile b/arch/ia64/uv/kernel/Makefile
> deleted file mode 100644
> index 297196578d19d409..0000000000000000
> diff --git a/arch/ia64/uv/kernel/setup.c b/arch/ia64/uv/kernel/setup.c
> deleted file mode 100644
> index bb025486d7912d2f..0000000000000000
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ccbeab9500ecb003..92c0bdadf5283659 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -257,7 +257,7 @@ config ACPI_CPU_FREQ_PSS
>  config ACPI_PROCESSOR_CSTATE
>  	def_bool y
>  	depends on ACPI_PROCESSOR
> -	depends on IA64 || X86
> +	depends on X86
>  
>  config ACPI_PROCESSOR_IDLE
>  	bool
> @@ -281,9 +281,9 @@ config ACPI_CPPC_LIB
>  
>  config ACPI_PROCESSOR
>  	tristate "Processor"
> -	depends on X86 || IA64 || ARM64 || LOONGARCH
> +	depends on X86 || ARM64 || LOONGARCH
>  	select ACPI_PROCESSOR_IDLE
> -	select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
> +	select ACPI_CPU_FREQ_PSS if X86 || LOONGARCH
>  	select THERMAL
>  	default y
>  	help
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index 39b1f34c21dfd7a8..849c2bd820b93e90 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -2,8 +2,8 @@
>  config ACPI_NUMA
>  	bool "NUMA support"
>  	depends on NUMA
> -	depends on (X86 || IA64 || ARM64 || LOONGARCH)
> -	default y if IA64 || ARM64
> +	depends on (X86 || ARM64 || LOONGARCH)
> +	default y if ARM64
>  
>  config ACPI_HMAT
>  	bool "ACPI Heterogeneous Memory Attribute Table Support"
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 3269a888fb7a97a3..23bcb6d5cfeeb082 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -276,7 +276,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
>  	return NULL;
>  }
>  
> -#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
> +#if defined(CONFIG_ARM64)
>  /* ioremap will take care of cache attributes */
>  #define should_use_kmap(pfn)   0
>  #else
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 30fe9848dac1c1dc..02189b4756d01937 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -349,7 +349,7 @@ config DEVPORT
>  	  device is similar to /dev/mem, but for I/O ports.
>  
>  config HPET
> -	bool "HPET - High Precision Event Timer" if (X86 || IA64)
> +	bool "HPET - High Precision Event Timer" if X86
>  	default n
>  	depends on ACPI
>  	help
> @@ -378,7 +378,7 @@ config HPET_MMAP_DEFAULT
>  
>  config HANGCHECK_TIMER
>  	tristate "Hangcheck timer"
> -	depends on X86 || IA64 || PPC64 || S390
> +	depends on X86 || PPC64 || S390
>  	help
>  	  The hangcheck-timer module detects when the system has gone
>  	  out to lunch past a certain margin.  It can reboot the system
> diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> index 1b35d1724565ebfd..9f492f8a13acf71a 100644
> --- a/drivers/char/Makefile
> +++ b/drivers/char/Makefile
> @@ -8,7 +8,6 @@ obj-$(CONFIG_TTY_PRINTK)	+= ttyprintk.o
>  obj-y				+= misc.o
>  obj-$(CONFIG_ATARI_DSP56K)	+= dsp56k.o
>  obj-$(CONFIG_VIRTIO_CONSOLE)	+= virtio_console.o
> -obj-$(CONFIG_MSPEC)		+= mspec.o
>  obj-$(CONFIG_UV_MMTIMER)	+= uv_mmtimer.o
>  obj-$(CONFIG_IBM_BSR)		+= bsr.o
>  
> diff --git a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
> index 4f501e4842ab391d..c47eb7bf06d46b58 100644
> --- a/drivers/char/agp/Kconfig
> +++ b/drivers/char/agp/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  menuconfig AGP
>  	tristate "/dev/agpgart (AGP Support)"
> -	depends on ALPHA || IA64 || PARISC || PPC || X86
> +	depends on ALPHA || PARISC || PPC || X86
>  	depends on PCI
>  	help
>  	  AGP (Accelerated Graphics Port) is a bus system mainly used to
> @@ -109,20 +109,6 @@ config AGP_VIA
>  	  This option gives you AGP support for the GLX component of
>  	  X on VIA MVP3/Apollo Pro chipsets.
>  
> -config AGP_I460
> -	tristate "Intel 460GX chipset support"
> -	depends on AGP && IA64
> -	help
> -	  This option gives you AGP GART support for the Intel 460GX chipset
> -	  for IA64 processors.
> -
> -config AGP_HP_ZX1
> -	tristate "HP ZX1 chipset AGP support"
> -	depends on AGP && IA64
> -	help
> -	  This option gives you AGP GART support for the HP ZX1 chipset
> -	  for IA64 processors.
> -
>  config AGP_PARISC
>  	tristate "HP Quicksilver AGP support"
>  	depends on AGP && PARISC && 64BIT && IOMMU_SBA
> diff --git a/drivers/char/agp/Makefile b/drivers/char/agp/Makefile
> index 90ed8c789e4824fb..25834557e486538c 100644
> --- a/drivers/char/agp/Makefile
> +++ b/drivers/char/agp/Makefile
> @@ -14,9 +14,7 @@ obj-$(CONFIG_AGP_AMD)		+= amd-k7-agp.o
>  obj-$(CONFIG_AGP_AMD64)		+= amd64-agp.o
>  obj-$(CONFIG_AGP_ALPHA_CORE)	+= alpha-agp.o
>  obj-$(CONFIG_AGP_EFFICEON)	+= efficeon-agp.o
> -obj-$(CONFIG_AGP_HP_ZX1)	+= hp-agp.o
>  obj-$(CONFIG_AGP_PARISC)	+= parisc-agp.o
> -obj-$(CONFIG_AGP_I460)		+= i460-agp.o
>  obj-$(CONFIG_AGP_INTEL)		+= intel-agp.o
>  obj-$(CONFIG_INTEL_GTT)		+= intel-gtt.o
>  obj-$(CONFIG_AGP_NVIDIA)	+= nvidia-agp.o
> diff --git a/drivers/char/agp/hp-agp.c b/drivers/char/agp/hp-agp.c
> deleted file mode 100644
> index 84d9adbb62f6a7bb..0000000000000000
> diff --git a/drivers/char/agp/i460-agp.c b/drivers/char/agp/i460-agp.c
> deleted file mode 100644
> index 15b240ea4848f1b8..0000000000000000
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index ee71376f174b70db..3b2159416e624a6a 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -64,25 +64,6 @@
>  static DEFINE_MUTEX(hpet_mutex); /* replaces BKL */
>  static u32 hpet_nhpet, hpet_max_freq = HPET_USER_FREQ;
>  
> -/* This clocksource driver currently only works on ia64 */
> -#ifdef CONFIG_IA64
> -static void __iomem *hpet_mctr;
> -
> -static u64 read_hpet(struct clocksource *cs)
> -{
> -	return (u64)read_counter((void __iomem *)hpet_mctr);
> -}
> -
> -static struct clocksource clocksource_hpet = {
> -	.name		= "hpet",
> -	.rating		= 250,
> -	.read		= read_hpet,
> -	.mask		= CLOCKSOURCE_MASK(64),
> -	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> -};
> -static struct clocksource *hpet_clocksource;
> -#endif
> -
>  /* A lock for concurrent access by app and isr hpet activity. */
>  static DEFINE_SPINLOCK(hpet_lock);
>  
> @@ -907,17 +888,6 @@ int hpet_alloc(struct hpet_data *hdp)
>  
>  	hpetp->hp_delta = hpet_calibrate(hpetp);
>  
> -/* This clocksource driver currently only works on ia64 */
> -#ifdef CONFIG_IA64
> -	if (!hpet_clocksource) {
> -		hpet_mctr = (void __iomem *)&hpetp->hp_hpet->hpet_mc;
> -		clocksource_hpet.archdata.fsys_mmio = hpet_mctr;
> -		clocksource_register_hz(&clocksource_hpet, hpetp->hp_tick_freq);
> -		hpetp->hp_clocksource = &clocksource_hpet;
> -		hpet_clocksource = &clocksource_hpet;
> -	}
> -#endif
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index 3da8e85f8aae03c7..aa59b5c24c44c8df 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -37,7 +37,7 @@ config HW_RANDOM_TIMERIOMEM
>  
>  config HW_RANDOM_INTEL
>  	tristate "Intel HW Random Number Generator support"
> -	depends on (X86 || IA64) && PCI
> +	depends on X86 && PCI
>  	default HW_RANDOM
>  	help
>  	  This driver provides kernel-side support for the Random Number
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 83bf2a4dcb57ed84..efd29fb5417e1fd3 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -31,10 +31,6 @@
>  #include <linux/uaccess.h>
>  #include <linux/security.h>
>  
> -#ifdef CONFIG_IA64
> -# include <linux/efi.h>
> -#endif
> -
>  #define DEVMEM_MINOR	1
>  #define DEVPORT_MINOR	4
>  
> @@ -284,13 +280,6 @@ int __weak phys_mem_access_prot_allowed(struct file *file,
>  #ifdef pgprot_noncached
>  static int uncached_access(struct file *file, phys_addr_t addr)
>  {
> -#if defined(CONFIG_IA64)
> -	/*
> -	 * On ia64, we ignore O_DSYNC because we cannot tolerate memory
> -	 * attribute aliases.
> -	 */
> -	return !(efi_mem_attributes(addr) & EFI_MEMORY_WB);
> -#else
>  	/*
>  	 * Accessing memory above the top the kernel knows about or through a
>  	 * file pointer
> @@ -299,7 +288,6 @@ static int uncached_access(struct file *file, phys_addr_t addr)
>  	if (file->f_flags & O_DSYNC)
>  		return 1;
>  	return addr >= __pa(high_memory);
> -#endif
>  }
>  #endif
>  
> diff --git a/drivers/char/mspec.c b/drivers/char/mspec.c
> deleted file mode 100644
> index f8231e2e84beccec..0000000000000000
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2a84fc63371e2ea2..faaf36c2e9a62bb7 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -239,17 +239,6 @@ if PPC32 || PPC64
>  source "drivers/cpufreq/Kconfig.powerpc"
>  endif
>  
> -if IA64
> -config IA64_ACPI_CPUFREQ
> -	tristate "ACPI Processor P-States driver"
> -	depends on ACPI_PROCESSOR
> -	help
> -	This driver adds a CPUFreq driver which utilizes the ACPI
> -	Processor Performance States.
> -
> -	If in doubt, say N.
> -endif
> -
>  if MIPS
>  config BMIPS_CPUFREQ
>  	tristate "BMIPS CPUfreq Driver"
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 32a7029e25ed8103..12b5c8fd20eae57e 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -109,7 +109,6 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
>  ##################################################################################
>  # Other platform drivers
>  obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
> -obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
>  obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
>  obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
>  obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
> diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
> deleted file mode 100644
> index c6bdc455517f856b..0000000000000000
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e3041fd627585..a79579fea6f05ae5 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -77,30 +77,6 @@ config FIRMWARE_MEMMAP
>  
>        See also Documentation/ABI/testing/sysfs-firmware-memmap.
>  
> -config EFI_PCDP
> -	bool "Console device selection via EFI PCDP or HCDP table"
> -	depends on ACPI && EFI && IA64
> -	default y if IA64
> -	help
> -	  If your firmware supplies the PCDP table, and you want to
> -	  automatically use the primary console device it describes
> -	  as the Linux console, say Y here.
> -
> -	  If your firmware supplies the HCDP table, and you want to
> -	  use the first serial port it describes as the Linux console,
> -	  say Y here.  If your EFI ConOut path contains only a UART
> -	  device, it will become the console automatically.  Otherwise,
> -	  you must specify the "console=hcdp" kernel boot argument.
> -
> -	  Neither the PCDP nor the HCDP affects naming of serial devices,
> -	  so a serial console may be /dev/ttyS0, /dev/ttyS1, etc, depending
> -	  on how the driver discovers devices.
> -
> -	  You must also enable the appropriate drivers (serial, VGA, etc.)
> -
> -	  See DIG64_HCDPv20_042804.pdf available from
> -	  <http://www.dig64.org/specifications/> 
> -
>  config DMIID
>      bool "Export DMI identification via sysfs to userspace"
>      depends on DMI
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 28fcddcd688fc2fd..1d1eb671d805d099 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -8,7 +8,6 @@ obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
>  obj-$(CONFIG_DMI)		+= dmi_scan.o
>  obj-$(CONFIG_DMI_SYSFS)		+= dmi-sysfs.o
>  obj-$(CONFIG_EDD)		+= edd.o
> -obj-$(CONFIG_EFI_PCDP)		+= pcdp.o
>  obj-$(CONFIG_DMIID)		+= dmi-id.o
>  obj-$(CONFIG_INTEL_STRATIX10_SERVICE) += stratix10-svc.o
>  obj-$(CONFIG_INTEL_STRATIX10_RSU)     += stratix10-rsu.o
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 043ca31c114ebf2a..923b07690cbf0061 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -4,7 +4,7 @@ menu "EFI (Extensible Firmware Interface) Support"
>  
>  config EFI_ESRT
>  	bool
> -	depends on EFI && !IA64
> +	depends on EFI
>  	default y
>  
>  config EFI_VARS_PSTORE
> @@ -123,7 +123,7 @@ config EFI_BOOTLOADER_CONTROL
>  
>  config EFI_CAPSULE_LOADER
>  	tristate "EFI capsule loader"
> -	depends on EFI && !IA64
> +	depends on EFI
>  	help
>  	  This option exposes a loader interface "/dev/efi_capsule_loader" for
>  	  users to load EFI capsules. This driver requires working runtime
> @@ -224,7 +224,7 @@ config EFI_DISABLE_PCI_DMA
>  
>  config EFI_EARLYCON
>  	def_bool y
> -	depends on SERIAL_EARLYCON && !ARM && !IA64
> +	depends on SERIAL_EARLYCON && !ARM
>  	select FONT_SUPPORT
>  	select ARCH_USE_MEMREMAP_PROT
>  
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 1e0b016fdc2b1217..b30d5c3e03a9e7a4 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -144,7 +144,7 @@ static ssize_t systab_show(struct kobject *kobj,
>  	if (efi.smbios != EFI_INVALID_TABLE_ADDR)
>  		str += sprintf(str, "SMBIOS=0x%lx\n", efi.smbios);
>  
> -	if (IS_ENABLED(CONFIG_IA64) || IS_ENABLED(CONFIG_X86))
> +	if (IS_ENABLED(CONFIG_X86))
>  		str = efi_systab_show_arch(str);
>  
>  	return str - buf;
> @@ -737,7 +737,6 @@ int __init efi_systab_check_header(const efi_table_hdr_t *systab_hdr,
>  	return 0;
>  }
>  
> -#ifndef CONFIG_IA64
>  static const efi_char16_t *__init map_fw_vendor(unsigned long fw_vendor,
>  						size_t size)
>  {
> @@ -753,10 +752,6 @@ static void __init unmap_fw_vendor(const void *fw_vendor, size_t size)
>  {
>  	early_memunmap((void *)fw_vendor, size);
>  }
> -#else
> -#define map_fw_vendor(p, s)	__va(p)
> -#define unmap_fw_vendor(v, s)
> -#endif
>  
>  void __init efi_systab_report_header(const efi_table_hdr_t *systab_hdr,
>  				     unsigned long fw_vendor)
> @@ -853,11 +848,6 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
>  	return buf;
>  }
>  
> -/*
> - * IA64 has a funky EFI memory map that doesn't work the same way as
> - * other architectures.
> - */
> -#ifndef CONFIG_IA64
>  /*
>   * efi_mem_attributes - lookup memmap attributes for physical address
>   * @phys_addr: the physical address to lookup
> @@ -905,7 +895,6 @@ int efi_mem_type(unsigned long phys_addr)
>  	}
>  	return -EINVAL;
>  }
> -#endif
>  
>  int efi_status_to_err(efi_status_t status)
>  {
> diff --git a/drivers/firmware/pcdp.c b/drivers/firmware/pcdp.c
> deleted file mode 100644
> index 715a45442d1cfe64..0000000000000000
> diff --git a/drivers/firmware/pcdp.h b/drivers/firmware/pcdp.h
> deleted file mode 100644
> index e02540571c524c40..0000000000000000
> diff --git a/drivers/gpu/drm/drm_ioc32.c b/drivers/gpu/drm/drm_ioc32.c
> index 5d82891c32223e4d..4414d99e02ac658b 100644
> --- a/drivers/gpu/drm/drm_ioc32.c
> +++ b/drivers/gpu/drm/drm_ioc32.c
> @@ -945,11 +945,11 @@ static struct {
>  	DRM_IOCTL32_DEF(DRM_IOCTL_SG_ALLOC, compat_drm_sg_alloc),
>  	DRM_IOCTL32_DEF(DRM_IOCTL_SG_FREE, compat_drm_sg_free),
>  #endif
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> +#if defined(CONFIG_X86)
>  	DRM_IOCTL32_DEF(DRM_IOCTL_UPDATE_DRAW, compat_drm_update_draw),
>  #endif
>  	DRM_IOCTL32_DEF(DRM_IOCTL_WAIT_VBLANK, compat_drm_wait_vblank),
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> +#if defined(CONFIG_X86)
>  	DRM_IOCTL32_DEF(DRM_IOCTL_MODE_ADDFB2, compat_drm_mode_addfb2),
>  #endif
>  };
> diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
> index adb5173372d3ee6d..5f61672d55b73aaa 100644
> --- a/drivers/input/serio/i8042.h
> +++ b/drivers/input/serio/i8042.h
> @@ -19,7 +19,7 @@
>  #include "i8042-snirm.h"
>  #elif defined(CONFIG_SPARC)
>  #include "i8042-sparcio.h"
> -#elif defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_LOONGARCH)
> +#elif defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>  #include "i8042-acpipnpio.h"
>  #else
>  #include "i8042-io.h"
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 79707685d54a4f8f..013683ad7ecc9319 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -93,7 +93,7 @@ config IOMMU_DEBUGFS
>  choice
>  	prompt "IOMMU default domain type"
>  	depends on IOMMU_API
> -	default IOMMU_DEFAULT_DMA_LAZY if X86 || IA64
> +	default IOMMU_DEFAULT_DMA_LAZY if X86
>  	default IOMMU_DEFAULT_DMA_STRICT
>  	help
>  	  Choose the type of IOMMU domain used to manage DMA API usage by
> @@ -148,7 +148,7 @@ config OF_IOMMU
>  
>  # IOMMU-agnostic DMA-mapping layer
>  config IOMMU_DMA
> -	def_bool ARM64 || IA64 || X86
> +	def_bool ARM64 || X86
>  	select DMA_OPS
>  	select IOMMU_API
>  	select IOMMU_IOVA
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index b7dff5092fd21c06..44205ffdcb5cc149 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -11,7 +11,7 @@ config DMAR_DEBUG
>  
>  config INTEL_IOMMU
>  	bool "Support for Intel IOMMU using DMA Remapping Devices"
> -	depends on PCI_MSI && ACPI && (X86 || IA64)
> +	depends on PCI_MSI && ACPI && X86
>  	select DMA_OPS
>  	select IOMMU_API
>  	select IOMMU_IOVA
> diff --git a/drivers/media/cec/platform/Kconfig b/drivers/media/cec/platform/Kconfig
> index b672d3142eb795f4..ede81fe331b0de73 100644
> --- a/drivers/media/cec/platform/Kconfig
> +++ b/drivers/media/cec/platform/Kconfig
> @@ -99,7 +99,7 @@ config CEC_TEGRA
>  
>  config CEC_SECO
>  	tristate "SECO Boards HDMI CEC driver"
> -	depends on (X86 || IA64) || COMPILE_TEST
> +	depends on X86 || COMPILE_TEST
>  	depends on PCI && DMI
>  	select CEC_CORE
>  	select CEC_NOTIFIER
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 9947b7892bd5af61..2573dd21d0aa77d4 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -166,7 +166,7 @@ config ENCLOSURE_SERVICES
>  config SGI_XP
>  	tristate "Support communication between SGI SSIs"
>  	depends on NET
> -	depends on (IA64_SGI_UV || X86_UV) && SMP
> +	depends on X86_UV && SMP
>  	depends on X86_64 || BROKEN
>  	select SGI_GRU if X86_64 && SMP
>  	help
> diff --git a/drivers/misc/sgi-gru/gru.h b/drivers/misc/sgi-gru/gru.h
> index 3ad76cd18b4bb41a..6ae045037219a339 100644
> --- a/drivers/misc/sgi-gru/gru.h
> +++ b/drivers/misc/sgi-gru/gru.h
> @@ -30,9 +30,7 @@
>  /*
>   * Size used to map GRU GSeg
>   */
> -#if defined(CONFIG_IA64)
> -#define GRU_GSEG_PAGESIZE	(256 * 1024UL)
> -#elif defined(CONFIG_X86_64)
> +#if defined(CONFIG_X86_64)
>  #define GRU_GSEG_PAGESIZE	(256 * 1024UL)		/* ZZZ 2MB ??? */
>  #else
>  #error "Unsupported architecture"
> diff --git a/drivers/misc/sgi-gru/gru_instructions.h b/drivers/misc/sgi-gru/gru_instructions.h
> index 04d5170ac1497352..da5eb9edf9ecd6bd 100644
> --- a/drivers/misc/sgi-gru/gru_instructions.h
> +++ b/drivers/misc/sgi-gru/gru_instructions.h
> @@ -29,17 +29,7 @@ extern void gru_wait_abort_proc(void *cb);
>   * Architecture dependent functions
>   */
>  
> -#if defined(CONFIG_IA64)
> -#include <linux/compiler.h>
> -#include <asm/intrinsics.h>
> -#define __flush_cache(p)		ia64_fc((unsigned long)p)
> -/* Use volatile on IA64 to ensure ordering via st4.rel */
> -#define gru_ordered_store_ulong(p, v)					\
> -		do {							\
> -			barrier();					\
> -			*((volatile unsigned long *)(p)) = v; /* force st.rel */	\
> -		} while (0)
> -#elif defined(CONFIG_X86_64)
> +#if defined(CONFIG_X86_64)
>  #include <asm/cacheflush.h>
>  #define __flush_cache(p)		clflush(p)
>  #define gru_ordered_store_ulong(p, v)					\
> diff --git a/drivers/misc/sgi-gru/grufile.c b/drivers/misc/sgi-gru/grufile.c
> index 7ffcfc0bb58723fe..ab731678b0428b1f 100644
> --- a/drivers/misc/sgi-gru/grufile.c
> +++ b/drivers/misc/sgi-gru/grufile.c
> @@ -337,72 +337,6 @@ static unsigned long gru_chiplet_cpu_to_mmr(int chiplet, int cpu, int *corep)
>  	return mmr;
>  }
>  
> -#ifdef CONFIG_IA64
> -
> -static int gru_irq_count[GRU_CHIPLETS_PER_BLADE];
> -
> -static void gru_noop(struct irq_data *d)
> -{
> -}
> -
> -static struct irq_chip gru_chip[GRU_CHIPLETS_PER_BLADE] = {
> -	[0 ... GRU_CHIPLETS_PER_BLADE - 1] {
> -		.irq_mask	= gru_noop,
> -		.irq_unmask	= gru_noop,
> -		.irq_ack	= gru_noop
> -	}
> -};
> -
> -static int gru_chiplet_setup_tlb_irq(int chiplet, char *irq_name,
> -			irq_handler_t irq_handler, int cpu, int blade)
> -{
> -	unsigned long mmr;
> -	int irq = IRQ_GRU + chiplet;
> -	int ret, core;
> -
> -	mmr = gru_chiplet_cpu_to_mmr(chiplet, cpu, &core);
> -	if (mmr == 0)
> -		return 0;
> -
> -	if (gru_irq_count[chiplet] == 0) {
> -		gru_chip[chiplet].name = irq_name;
> -		ret = irq_set_chip(irq, &gru_chip[chiplet]);
> -		if (ret) {
> -			printk(KERN_ERR "%s: set_irq_chip failed, errno=%d\n",
> -			       GRU_DRIVER_ID_STR, -ret);
> -			return ret;
> -		}
> -
> -		ret = request_irq(irq, irq_handler, 0, irq_name, NULL);
> -		if (ret) {
> -			printk(KERN_ERR "%s: request_irq failed, errno=%d\n",
> -			       GRU_DRIVER_ID_STR, -ret);
> -			return ret;
> -		}
> -	}
> -	gru_irq_count[chiplet]++;
> -
> -	return 0;
> -}
> -
> -static void gru_chiplet_teardown_tlb_irq(int chiplet, int cpu, int blade)
> -{
> -	unsigned long mmr;
> -	int core, irq = IRQ_GRU + chiplet;
> -
> -	if (gru_irq_count[chiplet] == 0)
> -		return;
> -
> -	mmr = gru_chiplet_cpu_to_mmr(chiplet, cpu, &core);
> -	if (mmr == 0)
> -		return;
> -
> -	if (--gru_irq_count[chiplet] == 0)
> -		free_irq(irq, NULL);
> -}
> -
> -#elif defined CONFIG_X86_64
> -
>  static int gru_chiplet_setup_tlb_irq(int chiplet, char *irq_name,
>  			irq_handler_t irq_handler, int cpu, int blade)
>  {
> @@ -447,8 +381,6 @@ static void gru_chiplet_teardown_tlb_irq(int chiplet, int cpu, int blade)
>  	}
>  }
>  
> -#endif
> -
>  static void gru_teardown_tlb_irqs(void)
>  {
>  	int blade;
> @@ -514,12 +446,8 @@ static int __init gru_init(void)
>  	if (!gru_supported())
>  		return 0;
>  
> -#if defined CONFIG_IA64
> -	gru_start_paddr = 0xd000000000UL; /* ZZZZZZZZZZZZZZZZZZZ fixme */
> -#else
>  	gru_start_paddr = uv_read_local_mmr(UVH_RH_GAM_GRU_OVERLAY_CONFIG) &
>  				0x7fffffffffffUL;
> -#endif
>  	gru_start_vaddr = __va(gru_start_paddr);
>  	gru_end_paddr = gru_start_paddr + GRU_MAX_BLADES * GRU_SIZE;
>  	printk(KERN_INFO "GRU space: 0x%lx - 0x%lx\n",
> diff --git a/drivers/misc/sgi-gru/gruhandles.c b/drivers/misc/sgi-gru/gruhandles.c
> index 1d75d5e540bc992b..695316a83b01044f 100644
> --- a/drivers/misc/sgi-gru/gruhandles.c
> +++ b/drivers/misc/sgi-gru/gruhandles.c
> @@ -11,16 +11,10 @@
>  #include "grutables.h"
>  
>  /* 10 sec */
> -#ifdef CONFIG_IA64
> -#include <asm/processor.h>
> -#define GRU_OPERATION_TIMEOUT	(((cycles_t) local_cpu_data->itc_freq)*10)
> -#define CLKS2NSEC(c)		((c) *1000000000 / local_cpu_data->itc_freq)
> -#else
>  #include <linux/sync_core.h>
>  #include <asm/tsc.h>
>  #define GRU_OPERATION_TIMEOUT	((cycles_t) tsc_khz*10*1000)
>  #define CLKS2NSEC(c)		((c) * 1000000 / tsc_khz)
> -#endif
>  
>  /* Extract the status field from a kernel handle */
>  #define GET_MSEG_HANDLE_STATUS(h)	(((*(unsigned long *)(h)) >> 16) & 3)
> diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
> index 4eb4b94551390791..0f5b09e290c89981 100644
> --- a/drivers/misc/sgi-gru/grumain.c
> +++ b/drivers/misc/sgi-gru/grumain.c
> @@ -41,16 +41,12 @@ struct device *grudev = &gru_device;
>   */
>  int gru_cpu_fault_map_id(void)
>  {
> -#ifdef CONFIG_IA64
> -	return uv_blade_processor_id() % GRU_NUM_TFM;
> -#else
>  	int cpu = smp_processor_id();
>  	int id, core;
>  
>  	core = uv_cpu_core_number(cpu);
>  	id = core + UV_MAX_INT_CORES * uv_cpu_socket_number(cpu);
>  	return id;
> -#endif
>  }
>  
>  /*--------- ASID Management -------------------------------------------
> diff --git a/drivers/misc/sgi-xp/xp.h b/drivers/misc/sgi-xp/xp.h
> index f1336f43d3bd13ee..3185711beb0780f2 100644
> --- a/drivers/misc/sgi-xp/xp.h
> +++ b/drivers/misc/sgi-xp/xp.h
> @@ -16,7 +16,7 @@
>  
>  #include <linux/mutex.h>
>  
> -#if defined CONFIG_X86_UV || defined CONFIG_IA64_SGI_UV
> +#if defined CONFIG_X86_UV
>  #include <asm/uv/uv.h>
>  #endif
>  
> diff --git a/drivers/misc/sgi-xp/xp_uv.c b/drivers/misc/sgi-xp/xp_uv.c
> index 19fc7076af274f74..3faa7eadf679e3c2 100644
> --- a/drivers/misc/sgi-xp/xp_uv.c
> +++ b/drivers/misc/sgi-xp/xp_uv.c
> @@ -18,8 +18,6 @@
>  #include <asm/uv/uv_hub.h>
>  #if defined CONFIG_X86_64
>  #include <asm/uv/bios.h>
> -#elif defined CONFIG_IA64_SGI_UV
> -#include <asm/sn/sn_sal.h>
>  #endif
>  #include "../sgi-gru/grukservices.h"
>  #include "xp.h"
> @@ -99,17 +97,6 @@ xp_expand_memprotect_uv(unsigned long phys_addr, unsigned long size)
>  			"UV_MEMPROT_ALLOW_RW) failed, ret=%d\n", ret);
>  		return xpBiosError;
>  	}
> -
> -#elif defined CONFIG_IA64_SGI_UV
> -	u64 nasid_array;
> -
> -	ret = sn_change_memprotect(phys_addr, size, SN_MEMPROT_ACCESS_CLASS_1,
> -				   &nasid_array);
> -	if (ret != 0) {
> -		dev_err(xp, "sn_change_memprotect(,, "
> -			"SN_MEMPROT_ACCESS_CLASS_1,) failed ret=%d\n", ret);
> -		return xpSalError;
> -	}
>  #else
>  	#error not a supported configuration
>  #endif
> @@ -129,17 +116,6 @@ xp_restrict_memprotect_uv(unsigned long phys_addr, unsigned long size)
>  			"UV_MEMPROT_RESTRICT_ACCESS) failed, ret=%d\n", ret);
>  		return xpBiosError;
>  	}
> -
> -#elif defined CONFIG_IA64_SGI_UV
> -	u64 nasid_array;
> -
> -	ret = sn_change_memprotect(phys_addr, size, SN_MEMPROT_ACCESS_CLASS_0,
> -				   &nasid_array);
> -	if (ret != 0) {
> -		dev_err(xp, "sn_change_memprotect(,, "
> -			"SN_MEMPROT_ACCESS_CLASS_0,) failed ret=%d\n", ret);
> -		return xpSalError;
> -	}
>  #else
>  	#error not a supported configuration
>  #endif
> diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
> index b2c3c22fc13c1361..ea540b03a0f6e9b8 100644
> --- a/drivers/misc/sgi-xp/xpc_main.c
> +++ b/drivers/misc/sgi-xp/xpc_main.c
> @@ -1162,36 +1162,6 @@ xpc_die_deactivate(void)
>  static int
>  xpc_system_die(struct notifier_block *nb, unsigned long event, void *_die_args)
>  {
> -#ifdef CONFIG_IA64		/* !!! temporary kludge */
> -	switch (event) {
> -	case DIE_MACHINE_RESTART:
> -	case DIE_MACHINE_HALT:
> -		xpc_die_deactivate();
> -		break;
> -
> -	case DIE_KDEBUG_ENTER:
> -		/* Should lack of heartbeat be ignored by other partitions? */
> -		if (!xpc_kdebug_ignore)
> -			break;
> -
> -		fallthrough;
> -	case DIE_MCA_MONARCH_ENTER:
> -	case DIE_INIT_MONARCH_ENTER:
> -		xpc_arch_ops.offline_heartbeat();
> -		break;
> -
> -	case DIE_KDEBUG_LEAVE:
> -		/* Is lack of heartbeat being ignored by other partitions? */
> -		if (!xpc_kdebug_ignore)
> -			break;
> -
> -		fallthrough;
> -	case DIE_MCA_MONARCH_LEAVE:
> -	case DIE_INIT_MONARCH_LEAVE:
> -		xpc_arch_ops.online_heartbeat();
> -		break;
> -	}
> -#else
>  	struct die_args *die_args = _die_args;
>  
>  	switch (event) {
> @@ -1213,7 +1183,6 @@ xpc_system_die(struct notifier_block *nb, unsigned long event, void *_die_args)
>  	default:
>  		xpc_die_deactivate();
>  	}
> -#endif
>  
>  	return NOTIFY_DONE;
>  }
> diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
> index fff522d347e33f31..2f03a7080d965235 100644
> --- a/drivers/misc/sgi-xp/xpc_uv.c
> +++ b/drivers/misc/sgi-xp/xpc_uv.c
> @@ -24,34 +24,12 @@
>  #include <linux/slab.h>
>  #include <linux/numa.h>
>  #include <asm/uv/uv_hub.h>
> -#if defined CONFIG_X86_64
>  #include <asm/uv/bios.h>
>  #include <asm/uv/uv_irq.h>
> -#elif defined CONFIG_IA64_SGI_UV
> -#include <asm/sn/intr.h>
> -#include <asm/sn/sn_sal.h>
> -#endif
>  #include "../sgi-gru/gru.h"
>  #include "../sgi-gru/grukservices.h"
>  #include "xpc.h"
>  
> -#if defined CONFIG_IA64_SGI_UV
> -struct uv_IO_APIC_route_entry {
> -	__u64	vector		:  8,
> -		delivery_mode	:  3,
> -		dest_mode	:  1,
> -		delivery_status	:  1,
> -		polarity	:  1,
> -		__reserved_1	:  1,
> -		trigger		:  1,
> -		mask		:  1,
> -		__reserved_2	: 15,
> -		dest		: 32;
> -};
> -
> -#define sn_partition_id 0
> -#endif
> -
>  static struct xpc_heartbeat_uv *xpc_heartbeat_uv;
>  
>  #define XPC_ACTIVATE_MSG_SIZE_UV	(1 * GRU_CACHE_LINE_BYTES)
> @@ -113,7 +91,6 @@ xpc_get_gru_mq_irq_uv(struct xpc_gru_mq_uv *mq, int cpu, char *irq_name)
>  {
>  	int mmr_pnode = uv_blade_to_pnode(mq->mmr_blade);
>  
> -#if defined CONFIG_X86_64
>  	mq->irq = uv_setup_irq(irq_name, cpu, mq->mmr_blade, mq->mmr_offset,
>  			UV_AFFINITY_CPU);
>  	if (mq->irq < 0)
> @@ -121,40 +98,13 @@ xpc_get_gru_mq_irq_uv(struct xpc_gru_mq_uv *mq, int cpu, char *irq_name)
>  
>  	mq->mmr_value = uv_read_global_mmr64(mmr_pnode, mq->mmr_offset);
>  
> -#elif defined CONFIG_IA64_SGI_UV
> -	if (strcmp(irq_name, XPC_ACTIVATE_IRQ_NAME) == 0)
> -		mq->irq = SGI_XPC_ACTIVATE;
> -	else if (strcmp(irq_name, XPC_NOTIFY_IRQ_NAME) == 0)
> -		mq->irq = SGI_XPC_NOTIFY;
> -	else
> -		return -EINVAL;
> -
> -	mq->mmr_value = (unsigned long)cpu_physical_id(cpu) << 32 | mq->irq;
> -	uv_write_global_mmr64(mmr_pnode, mq->mmr_offset, mq->mmr_value);
> -#else
> -	#error not a supported configuration
> -#endif
> -
>  	return 0;
>  }
>  
>  static void
>  xpc_release_gru_mq_irq_uv(struct xpc_gru_mq_uv *mq)
>  {
> -#if defined CONFIG_X86_64
>  	uv_teardown_irq(mq->irq);
> -
> -#elif defined CONFIG_IA64_SGI_UV
> -	int mmr_pnode;
> -	unsigned long mmr_value;
> -
> -	mmr_pnode = uv_blade_to_pnode(mq->mmr_blade);
> -	mmr_value = 1UL << 16;
> -
> -	uv_write_global_mmr64(mmr_pnode, mq->mmr_offset, mmr_value);
> -#else
> -	#error not a supported configuration
> -#endif
>  }
>  
>  static int
> @@ -162,17 +112,6 @@ xpc_gru_mq_watchlist_alloc_uv(struct xpc_gru_mq_uv *mq)
>  {
>  	int ret;
>  
> -#if defined CONFIG_IA64_SGI_UV
> -	int mmr_pnode = uv_blade_to_pnode(mq->mmr_blade);
> -
> -	ret = sn_mq_watchlist_alloc(mmr_pnode, (void *)uv_gpa(mq->address),
> -				    mq->order, &mq->mmr_offset);
> -	if (ret < 0) {
> -		dev_err(xpc_part, "sn_mq_watchlist_alloc() failed, ret=%d\n",
> -			ret);
> -		return -EBUSY;
> -	}
> -#elif defined CONFIG_X86_64
>  	ret = uv_bios_mq_watchlist_alloc(uv_gpa(mq->address),
>  					 mq->order, &mq->mmr_offset);
>  	if (ret < 0) {
> @@ -180,9 +119,6 @@ xpc_gru_mq_watchlist_alloc_uv(struct xpc_gru_mq_uv *mq)
>  			"ret=%d\n", ret);
>  		return ret;
>  	}
> -#else
> -	#error not a supported configuration
> -#endif
>  
>  	mq->watchlist_num = ret;
>  	return 0;
> @@ -194,15 +130,8 @@ xpc_gru_mq_watchlist_free_uv(struct xpc_gru_mq_uv *mq)
>  	int ret;
>  	int mmr_pnode = uv_blade_to_pnode(mq->mmr_blade);
>  
> -#if defined CONFIG_X86_64
>  	ret = uv_bios_mq_watchlist_free(mmr_pnode, mq->watchlist_num);
>  	BUG_ON(ret != BIOS_STATUS_SUCCESS);
> -#elif defined CONFIG_IA64_SGI_UV
> -	ret = sn_mq_watchlist_free(mmr_pnode, mq->watchlist_num);
> -	BUG_ON(ret != SALRET_OK);
> -#else
> -	#error not a supported configuration
> -#endif
>  }
>  
>  static struct xpc_gru_mq_uv *
> @@ -786,7 +715,6 @@ xpc_get_partition_rsvd_page_pa_uv(void *buf, u64 *cookie, unsigned long *rp_pa,
>  	s64 status;
>  	enum xp_retval ret;
>  
> -#if defined CONFIG_X86_64
>  	status = uv_bios_reserved_page_pa((u64)buf, cookie, (u64 *)rp_pa,
>  					  (u64 *)len);
>  	if (status == BIOS_STATUS_SUCCESS)
> @@ -796,19 +724,6 @@ xpc_get_partition_rsvd_page_pa_uv(void *buf, u64 *cookie, unsigned long *rp_pa,
>  	else
>  		ret = xpBiosError;
>  
> -#elif defined CONFIG_IA64_SGI_UV
> -	status = sn_partition_reserved_page_pa((u64)buf, cookie, rp_pa, len);
> -	if (status == SALRET_OK)
> -		ret = xpSuccess;
> -	else if (status == SALRET_MORE_PASSES)
> -		ret = xpNeedMoreInfo;
> -	else
> -		ret = xpSalError;
> -
> -#else
> -	#error not a supported configuration
> -#endif
> -
>  	return ret;
>  }
>  
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 58747292521d8199..f219878c4b79655c 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -17001,7 +17001,7 @@ static u32 tg3_calc_dma_bndry(struct tg3 *tp, u32 val)
>  	    !tg3_flag(tp, PCI_EXPRESS))
>  		goto out;
>  
> -#if defined(CONFIG_PPC64) || defined(CONFIG_IA64) || defined(CONFIG_PARISC)
> +#if defined(CONFIG_PPC64) || defined(CONFIG_PARISC)
>  	goal = BOUNDARY_MULTI_CACHELINE;
>  #else
>  #if defined(CONFIG_SPARC64) || defined(CONFIG_ALPHA)
> diff --git a/drivers/net/ethernet/brocade/bna/bnad.h b/drivers/net/ethernet/brocade/bna/bnad.h
> index 627a93ce38ab07dd..10b1e534030e628d 100644
> --- a/drivers/net/ethernet/brocade/bna/bnad.h
> +++ b/drivers/net/ethernet/brocade/bna/bnad.h
> @@ -19,7 +19,6 @@
>  #include <linux/firmware.h>
>  #include <linux/if_vlan.h>
>  
> -/* Fix for IA64 */
>  #include <asm/checksum.h>
>  #include <net/ip6_checksum.h>
>  
> diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
> index de8d54b23f738523..2e1b2d9c0f54cbfc 100644
> --- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
> +++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
> @@ -234,9 +234,7 @@ static int nx_set_dma_mask(struct netxen_adapter *adapter)
>  	cmask = DMA_BIT_MASK(32);
>  
>  	if (NX_IS_REVISION_P2(adapter->ahw.revision_id)) {
> -#ifndef CONFIG_IA64
>  		mask = DMA_BIT_MASK(35);
> -#endif
>  	} else {
>  		mask = DMA_BIT_MASK(39);
>  		cmask = mask;
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index f80b6ec88dc301e0..a9c2aa0ea5751dc7 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -545,7 +545,7 @@ EXPORT_SYMBOL(vga_put);
>  
>  static bool vga_is_firmware_default(struct pci_dev *pdev)
>  {
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> +#if defined(CONFIG_X86)
>  	u64 base = screen_info.lfb_base;
>  	u64 size = screen_info.lfb_size;
>  	u64 limit;
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index b0f62345bc846dcb..fc4acb9e323b6922 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -216,7 +216,7 @@ config SERIAL_8250_EXTENDED
>  
>  config SERIAL_8250_MANY_PORTS
>  	bool "Support more than 4 legacy serial ports"
> -	depends on SERIAL_8250_EXTENDED && !IA64
> +	depends on SERIAL_8250_EXTENDED
>  	help
>  	  Say Y here if you have dumb serial boards other than the four
>  	  standard COM 1/2/3/4 ports. This may happen if you have an AST
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index be8313cdbac360ac..218dae88ad575a0e 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -1273,7 +1273,7 @@ static void kbd_bh(struct tasklet_struct *unused)
>  	}
>  }
>  
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_ALPHA) ||\
> +#if defined(CONFIG_X86) || defined(CONFIG_ALPHA) ||\
>      defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_SPARC) ||\
>      defined(CONFIG_PARISC) || defined(CONFIG_SUPERH) ||\
>      (defined(CONFIG_ARM) && defined(CONFIG_KEYBOARD_ATKBD) && !defined(CONFIG_ARCH_RPC))
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index b2bed599e6c6ea1c..834a2a615786d168 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -641,7 +641,7 @@ config FB_VESA
>  
>  config FB_EFI
>  	bool "EFI-based Framebuffer Support"
> -	depends on (FB = y) && !IA64 && EFI
> +	depends on (FB = y) && EFI
>  	select APERTURE_HELPERS
>  	select DRM_PANEL_ORIENTATION_QUIRKS
>  	select FB_CFB_FILLRECT
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0bc40b763b065210..fe51fb2bd4947c42 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1268,7 +1268,7 @@ config INTEL_MID_WATCHDOG
>  
>  config ITCO_WDT
>  	tristate "Intel TCO Timer/Watchdog"
> -	depends on (X86 || IA64) && PCI
> +	depends on X86 && PCI
>  	select WATCHDOG_CORE
>  	depends on I2C || I2C=n
>  	depends on MFD_INTEL_PMC_BXT || !MFD_INTEL_PMC_BXT
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 2685a4d0d353188b..11f5dd246fce4a68 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -234,7 +234,7 @@ config ARCH_SUPPORTS_HUGETLBFS
>  
>  config HUGETLBFS
>  	bool "HugeTLB file system support"
> -	depends on X86 || IA64 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
> +	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
>  	depends on (SYSFS || SYSCTL)
>  	help
>  	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
> diff --git a/fs/afs/main.c b/fs/afs/main.c
> index eae288c8d40a3b28..6425c81d07deac4d 100644
> --- a/fs/afs/main.c
> +++ b/fs/afs/main.c
> @@ -41,8 +41,6 @@ const char afs_init_sysname[] = "arm_linux26";
>  const char afs_init_sysname[] = "aarch64_linux26";
>  #elif defined(CONFIG_X86_32)
>  const char afs_init_sysname[] = "i386_linux26";
> -#elif defined(CONFIG_IA64)
> -const char afs_init_sysname[] = "ia64_linux26";
>  #elif defined(CONFIG_PPC64)
>  const char afs_init_sysname[] = "ppc64_linux26";
>  #elif defined(CONFIG_PPC32)
> diff --git a/fs/xfs/xfs_ioctl32.h b/fs/xfs/xfs_ioctl32.h
> index c14852362fceab4f..052d0e888c273a3a 100644
> --- a/fs/xfs/xfs_ioctl32.h
> +++ b/fs/xfs/xfs_ioctl32.h
> @@ -22,7 +22,7 @@
>  /*
>   * On intel, even if sizes match, alignment and/or padding may differ.
>   */
> -#if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
> +#if defined(CONFIG_X86_64)
>  #define BROKEN_X86_ALIGNMENT
>  #define __compat_packed __attribute__((packed))
>  #else
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 5e6a876e17ba0794..78753513bc5cb9a9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -270,7 +270,7 @@ void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
>  /* the following numa functions are architecture-dependent */
>  void acpi_numa_slit_init (struct acpi_table_slit *slit);
>  
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_LOONGARCH)
> +#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>  void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
>  #else
>  static inline void
> @@ -1090,15 +1090,8 @@ struct acpi_s2idle_dev_ops {
>  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>  void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>  #endif /* CONFIG_X86 */
> -#ifndef CONFIG_IA64
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>  #else
> -static inline void arch_reserve_mem_area(acpi_physical_address addr,
> -					  size_t size)
> -{
> -}
> -#endif /* CONFIG_X86 */
> -#else
>  #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
>  #endif
>  
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 98598bd1d2fa5208..bdc77cc74b1accf4 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -356,13 +356,10 @@ void efi_native_runtime_setup(void);
>   * where the UEFI SPEC breaks the line.
>   */
>  #define NULL_GUID				EFI_GUID(0x00000000, 0x0000, 0x0000,  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
> -#define MPS_TABLE_GUID				EFI_GUID(0xeb9d2d2f, 0x2d88, 0x11d3,  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>  #define ACPI_TABLE_GUID				EFI_GUID(0xeb9d2d30, 0x2d88, 0x11d3,  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>  #define ACPI_20_TABLE_GUID			EFI_GUID(0x8868e871, 0xe4f1, 0x11d3,  0xbc, 0x22, 0x00, 0x80, 0xc7, 0x3c, 0x88, 0x81)
>  #define SMBIOS_TABLE_GUID			EFI_GUID(0xeb9d2d31, 0x2d88, 0x11d3,  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>  #define SMBIOS3_TABLE_GUID			EFI_GUID(0xf2fd1544, 0x9794, 0x4a2c,  0x99, 0x2e, 0xe5, 0xbb, 0xcf, 0x20, 0xe3, 0x94)
> -#define SAL_SYSTEM_TABLE_GUID			EFI_GUID(0xeb9d2d32, 0x2d88, 0x11d3,  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
> -#define HCDP_TABLE_GUID				EFI_GUID(0xf951938d, 0x620b, 0x42ef,  0x82, 0x79, 0xa8, 0x4b, 0x79, 0x61, 0x78, 0x98)
>  #define UGA_IO_PROTOCOL_GUID			EFI_GUID(0x61a4d49e, 0x6f68, 0x4f1b,  0xb9, 0x22, 0xa8, 0x6e, 0xed, 0x0b, 0x07, 0xa2)
>  #define EFI_GLOBAL_VARIABLE_GUID		EFI_GUID(0x8be4df61, 0x93ca, 0x11d2,  0xaa, 0x0d, 0x00, 0xe0, 0x98, 0x03, 0x2b, 0x8c)
>  #define UV_SYSTEM_TABLE_GUID			EFI_GUID(0x3b13a7d4, 0x633e, 0x11dd,  0x93, 0xec, 0xda, 0x25, 0x56, 0xd8, 0x95, 0x93)
> @@ -831,10 +828,6 @@ static inline int efi_range_is_wc(unsigned long start, unsigned long len)
>  	return 1;
>  }
>  
> -#ifdef CONFIG_EFI_PCDP
> -extern int __init efi_setup_pcdp_console(char *);
> -#endif
> -
>  /*
>   * We play games with efi_enabled so that the compiler will, if
>   * possible, remove EFI-related code altogether.
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f13f20258ce9893c..97e4b34381a38625 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -347,8 +347,6 @@ extern unsigned int kobjsize(const void *objp);
>  # define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
>  #elif defined(CONFIG_PARISC)
>  # define VM_GROWSUP	VM_ARCH_1
> -#elif defined(CONFIG_IA64)
> -# define VM_GROWSUP	VM_ARCH_1
>  #elif defined(CONFIG_SPARC64)
>  # define VM_SPARC_ADI	VM_ARCH_1	/* Uses ADI tag for access control */
>  # define VM_ARCH_CLEAR	VM_SPARC_ADI
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 962cd41a2cb5aff1..99e4f1f718c705ce 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -276,7 +276,7 @@ struct kparam_array
>     read-only sections (which is part of respective UNIX ABI on these
>     platforms). So 'const' makes no sense and even causes compile failures
>     with some compilers. */
> -#if defined(CONFIG_ALPHA) || defined(CONFIG_IA64) || defined(CONFIG_PPC64)
> +#if defined(CONFIG_ALPHA) || defined(CONFIG_PPC64)
>  #define __moduleparam_const
>  #else
>  #define __moduleparam_const const
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 412b5a46374c036f..c00b48003f63d094 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -143,7 +143,7 @@ IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
>  #define __VM_ARCH_SPECIFIC_1 {VM_PAT,     "pat"           }
>  #elif defined(CONFIG_PPC)
>  #define __VM_ARCH_SPECIFIC_1 {VM_SAO,     "sao"           }
> -#elif defined(CONFIG_PARISC) || defined(CONFIG_IA64)
> +#elif defined(CONFIG_PARISC)
>  #define __VM_ARCH_SPECIFIC_1 {VM_GROWSUP,	"growsup"	}
>  #elif !defined(CONFIG_MMU)
>  #define __VM_ARCH_SPECIFIC_1 {VM_MAPPED_COPY,"mappedcopy"	}
> diff --git a/init/Kconfig b/init/Kconfig
> index 44e90b28a30f12e8..b62319d85b198fa7 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1775,7 +1775,7 @@ config KALLSYMS_ABSOLUTE_PERCPU
>  config KALLSYMS_BASE_RELATIVE
>  	bool
>  	depends on KALLSYMS
> -	default !IA64
> +	default y
>  	help
>  	  Instead of emitting them as absolute values in the native word size,
>  	  emit the symbol references in the kallsyms table as 32-bit entries,
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6c0a92ca6bb59c2c..14eddcc4d654f7ef 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1423,9 +1423,6 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
>  	if (!cpu_possible(cpu)) {
>  		pr_err("can't online cpu %d because it is not configured as may-hotadd at boot time\n",
>  		       cpu);
> -#if defined(CONFIG_IA64)
> -		pr_err("please check additional_cpus= boot parameter\n");
> -#endif
>  		return -EINVAL;
>  	}
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9f7fe354189785c2..6a2475d1442f0966 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2914,7 +2914,7 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
>  		if (!access_ok((void __user *)kargs->stack, kargs->stack_size))
>  			return false;
>  
> -#if !defined(CONFIG_STACK_GROWSUP) && !defined(CONFIG_IA64)
> +#if !defined(CONFIG_STACK_GROWSUP)
>  		kargs->stack += kargs->stack_size;
>  #endif
>  	}
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e838feb6adc50460..285f5c3c92f13476 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10144,9 +10144,9 @@ void normalize_rt_tasks(void)
>  
>  #endif /* CONFIG_MAGIC_SYSRQ */
>  
> -#if defined(CONFIG_IA64) || defined(CONFIG_KGDB_KDB)
> +#if defined(CONFIG_KGDB_KDB)
>  /*
> - * These functions are only useful for the IA64 MCA handling, or kdb.
> + * These functions are only useful for kdb.
>   *
>   * They can only be called when the whole system has been
>   * stopped - every CPU needs to be quiescent, and no scheduling
> @@ -10168,30 +10168,7 @@ struct task_struct *curr_task(int cpu)
>  	return cpu_curr(cpu);
>  }
>  
> -#endif /* defined(CONFIG_IA64) || defined(CONFIG_KGDB_KDB) */
> -
> -#ifdef CONFIG_IA64
> -/**
> - * ia64_set_curr_task - set the current task for a given CPU.
> - * @cpu: the processor in question.
> - * @p: the task pointer to set.
> - *
> - * Description: This function must only be used when non-maskable interrupts
> - * are serviced on a separate stack. It allows the architecture to switch the
> - * notion of the current task on a CPU in a non-blocking manner. This function
> - * must be called with all CPU's synchronized, and interrupts disabled, the
> - * and caller must save the original value of the current task (see
> - * curr_task() above) and restore that value before reenabling interrupts and
> - * re-starting the system.
> - *
> - * ONLY VALID WHEN THE WHOLE SYSTEM IS STOPPED!
> - */
> -void ia64_set_curr_task(int cpu, struct task_struct *p)
> -{
> -	cpu_curr(cpu) = p;
> -}
> -
> -#endif
> +#endif /* defined(CONFIG_KGDB_KDB) */
>  
>  #ifdef CONFIG_CGROUP_SCHED
>  /* task_group_lock serializes the addition/removal of task groups */
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 137d4abe3eda11a6..a2ae4f9c5c218acd 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1961,15 +1961,6 @@ static struct ctl_table kern_table[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  #endif
> -#ifdef CONFIG_IA64
> -	{
> -		.procname	= "unaligned-dump-stack",
> -		.data		= &unaligned_dump_stack,
> -		.maxlen		= sizeof (int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> -	},
> -#endif
>  #ifdef CONFIG_RT_MUTEXES
>  	{
>  		.procname	= "max_lock_depth",
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 02ee440f7be36cab..b2b8163f1e5e3494 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -816,7 +816,7 @@ config DEBUG_KMEMLEAK_AUTO_SCAN
>  
>  config DEBUG_STACK_USAGE
>  	bool "Stack utilization instrumentation"
> -	depends on DEBUG_KERNEL && !IA64
> +	depends on DEBUG_KERNEL
>  	help
>  	  Enables the display of the minimum amount of free stack which each
>  	  task has ever had available in the sysrq-T and sysrq-P debug output.
> diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
> index 9f4262ee33a5b9cb..33017d1eb3683302 100644
> --- a/lib/decompress_unxz.c
> +++ b/lib/decompress_unxz.c
> @@ -131,9 +131,6 @@
>  #ifdef CONFIG_ARM
>  #	define XZ_DEC_ARM
>  #endif
> -#ifdef CONFIG_IA64
> -#	define XZ_DEC_IA64
> -#endif
>  #ifdef CONFIG_SPARC
>  #	define XZ_DEC_SPARC
>  #endif
> diff --git a/lib/xz/Kconfig b/lib/xz/Kconfig
> index adce22ac18d660b1..aef086a6bf2f3d27 100644
> --- a/lib/xz/Kconfig
> +++ b/lib/xz/Kconfig
> @@ -19,11 +19,6 @@ config XZ_DEC_POWERPC
>  	default y
>  	select XZ_DEC_BCJ
>  
> -config XZ_DEC_IA64
> -	bool "IA-64 BCJ filter decoder" if EXPERT
> -	default y
> -	select XZ_DEC_BCJ
> -
>  config XZ_DEC_ARM
>  	bool "ARM BCJ filter decoder" if EXPERT
>  	default y
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 425a9349e610825f..62d7bb74c6d0f74e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1902,9 +1902,9 @@ static int acct_stack_growth(struct vm_area_struct *vma,
>  	return 0;
>  }
>  
> -#if defined(CONFIG_STACK_GROWSUP) || defined(CONFIG_IA64)
> +#if defined(CONFIG_STACK_GROWSUP)
>  /*
> - * PA-RISC uses this for its stack; IA64 for its Register Backing Store.
> + * PA-RISC uses this for its stack.
>   * vma is the last one with address > vma->vm_end.  Have to extend vma.
>   */
>  int expand_upwards(struct vm_area_struct *vma, unsigned long address)
> @@ -1994,7 +1994,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  	mas_destroy(&mas);
>  	return error;
>  }
> -#endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
> +#endif /* CONFIG_STACK_GROWSUP */
>  
>  /*
>   * vma is the first one with address < vma->vm_start.  Have to extend vma.
> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> index 4041881746adef21..9c009558e7286983 100755
> --- a/scripts/headers_install.sh
> +++ b/scripts/headers_install.sh
> @@ -76,7 +76,6 @@ arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
>  arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
>  arch/hexagon/include/uapi/asm/ptrace.h:CONFIG_HEXAGON_ARCH_VERSION
>  arch/hexagon/include/uapi/asm/user.h:CONFIG_HEXAGON_ARCH_VERSION
> -arch/ia64/include/uapi/asm/cmpxchg.h:CONFIG_IA64_DEBUG_CMPXCHG
>  arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
>  arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
>  arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
> diff --git a/tools/arch/ia64/include/asm/barrier.h b/tools/arch/ia64/include/asm/barrier.h
> deleted file mode 100644
> index 6fffe56827134385..0000000000000000
> diff --git a/tools/arch/ia64/include/uapi/asm/bitsperlong.h b/tools/arch/ia64/include/uapi/asm/bitsperlong.h
> deleted file mode 100644
> index 1146d55563db3773..0000000000000000
> diff --git a/tools/arch/ia64/include/uapi/asm/mman.h b/tools/arch/ia64/include/uapi/asm/mman.h
> deleted file mode 100644
> index 2a19bb1db4ab6076..0000000000000000
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index 07796df0a295b960..338c81f1fcf310e0 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -59,12 +59,6 @@ ifeq ($(SRCARCH),arc)
>  no-header-test += linux/bpf_perf_event.h
>  endif
>  
> -ifeq ($(SRCARCH),ia64)
> -no-header-test += asm/setup.h
> -no-header-test += asm/sigcontext.h
> -no-header-test += linux/if_bonding.h
> -endif
> -
>  ifeq ($(SRCARCH),powerpc)
>  no-header-test += linux/bpf_perf_event.h
>  endif
> -- 
> 2.39.1
> 
