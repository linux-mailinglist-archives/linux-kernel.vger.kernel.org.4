Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EFA74A1B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjGFP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGFP7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:59:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC649D;
        Thu,  6 Jul 2023 08:59:53 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366FgAa9030838;
        Thu, 6 Jul 2023 15:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jjAfeSlWgg+dGbiwYeBow8jF6nVRG2uJUdHPsfaGRHI=;
 b=q0IFs2Rczs+oBoivTwSre2ltXn8XEF9JFIsZhKRmT4uRW5Dkmqbsnw6C7N2RmpX1r4+I
 WSGAPQmuBZzsv/3gL49TQfx1bdmjRmuwq8MgaN8yNyZvF46q/cy3T1hgSjbxGzIR95eE
 QTCu+6M2QyQG8An3uvx9qg2OxpR9y+zZob/c0kPW2D2mzNBL0bwt6WD1+m/691y3Feu8
 w3FPCn8U3bXaH3oSTeGUPFGKb0LZK6JaoujYcrX55xmbEqnIy+dPpm1a1aS3x7KvOQEC
 8IBCPBmz1PAaOLOWq7w0yxegYExf9mRQiY9qDi69Ross4ZajvNmjnnyyK5OSMbCZMwPJ /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rp0fx0h7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 15:58:34 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 366FgS7Y000441;
        Thu, 6 Jul 2023 15:58:31 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rp0fx0h6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 15:58:31 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3669Hul0011059;
        Thu, 6 Jul 2023 15:58:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4tgxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 15:58:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 366FwOEu49348944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jul 2023 15:58:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A39772004E;
        Thu,  6 Jul 2023 15:58:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E971C2004B;
        Thu,  6 Jul 2023 15:58:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Jul 2023 15:58:22 +0000 (GMT)
Date:   Thu, 6 Jul 2023 17:58:21 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, kernel@xen0n.name, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org, peterz@infradead.org,
        frederic@kernel.org, akpm@linux-foundation.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        gregkh@linuxfoundation.org, tsi@tuyoix.net, bhe@redhat.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v4 12/13] s390/kexec: refactor for kernel/Kconfig.kexec
Message-ID: <ZKbknQoC1MkAjsqJ@tuxmaker.boeblingen.de.ibm.com>
References: <20230705142004.3605799-1-eric.devolder@oracle.com>
 <20230705142004.3605799-13-eric.devolder@oracle.com>
 <20230705154958.GA3643511@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705154958.GA3643511@dev-arch.thelio-3990X>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fRdpOUZjdtAMTOmk2K-csX7Bzx0RFgu9
X-Proofpoint-ORIG-GUID: iUrSZgVFrrjm2QXnS9jxUKUHl5MpwGXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1011 adultscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 08:49:58AM -0700, Nathan Chancellor wrote:
...
> I just bisected the following build failure visible with 'ARCH=s390
> allnoconfig' to this change as commit 842ce0e1dafa ("s390/kexec:
> refactor for kernel/Kconfig.kexec") in -next.
> 
>   arch/s390/kernel/machine_kexec.c:120:37: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
>     120 | static bool kdump_csum_valid(struct kimage *image)
>         |                                     ^~~~~~
>   arch/s390/kernel/machine_kexec.c:188:34: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
>     188 | int machine_kexec_prepare(struct kimage *image)
>         |                                  ^~~~~~
>   arch/s390/kernel/machine_kexec.c: In function 'machine_kexec_prepare':
>   arch/s390/kernel/machine_kexec.c:192:18: error: invalid use of undefined type 'struct kimage'
>     192 |         if (image->type == KEXEC_TYPE_CRASH)
>         |                  ^~
>   arch/s390/kernel/machine_kexec.c:192:28: error: 'KEXEC_TYPE_CRASH' undeclared (first use in this function); did you mean 'KEXEC_ON_CRASH'?
>     192 |         if (image->type == KEXEC_TYPE_CRASH)
>         |                            ^~~~~~~~~~~~~~~~
>         |                            KEXEC_ON_CRASH
>   arch/s390/kernel/machine_kexec.c:192:28: note: each undeclared identifier is reported only once for each function it appears in
>   arch/s390/kernel/machine_kexec.c:196:18: error: invalid use of undefined type 'struct kimage'
>     196 |         if (image->type != KEXEC_TYPE_DEFAULT)
>         |                  ^~
>   arch/s390/kernel/machine_kexec.c:196:28: error: 'KEXEC_TYPE_DEFAULT' undeclared (first use in this function); did you mean 'KEXEC_ARCH_DEFAULT'?
>     196 |         if (image->type != KEXEC_TYPE_DEFAULT)
>         |                            ^~~~~~~~~~~~~~~~~~
>         |                            KEXEC_ARCH_DEFAULT
>   In file included from arch/s390/include/asm/thread_info.h:31,
>                    from include/linux/thread_info.h:60,
>                    from arch/s390/include/asm/preempt.h:6,
>                    from include/linux/preempt.h:79,
>                    from arch/s390/include/asm/percpu.h:5,
>                    from include/linux/irqflags.h:18,
>                    from include/linux/rcupdate.h:26,
>                    from include/linux/rculist.h:11,
>                    from include/linux/pid.h:5,
>                    from include/linux/sched.h:14,
>                    from include/linux/ratelimit.h:6,
>                    from include/linux/dev_printk.h:16,
>                    from include/linux/device.h:15,
>                    from arch/s390/kernel/machine_kexec.c:9:
>   arch/s390/kernel/machine_kexec.c:200:48: error: invalid use of undefined type 'struct kimage'
>     200 |         reboot_code_buffer = page_to_virt(image->control_code_page);
>         |                                                ^~
>   arch/s390/include/asm/page.h:186:58: note: in definition of macro '__va'
>     186 | #define __va(x)                 ((void *)(unsigned long)(x))
>         |                                                          ^
>   arch/s390/include/asm/page.h:194:38: note: in expansion of macro 'pfn_to_phys'
>     194 | #define pfn_to_virt(pfn)        __va(pfn_to_phys(pfn))
>         |                                      ^~~~~~~~~~~
>   arch/s390/include/asm/page.h:199:33: note: in expansion of macro 'pfn_to_virt'
>     199 | #define page_to_virt(page)      pfn_to_virt(page_to_pfn(page))
>         |                                 ^~~~~~~~~~~
>   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
>      64 | #define page_to_pfn __page_to_pfn
>         |                     ^~~~~~~~~~~~~
>   arch/s390/kernel/machine_kexec.c:200:30: note: in expansion of macro 'page_to_virt'
>     200 |         reboot_code_buffer = page_to_virt(image->control_code_page);
>         |                              ^~~~~~~~~~~~
>   arch/s390/kernel/machine_kexec.c: At top level:
>   arch/s390/kernel/machine_kexec.c:207:35: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
>     207 | void machine_kexec_cleanup(struct kimage *image)
>         |                                   ^~~~~~
>   arch/s390/kernel/machine_kexec.c: In function '__do_machine_kexec':
>   arch/s390/kernel/machine_kexec.c:243:40: error: invalid use of undefined type 'struct kimage'
>     243 |         data_mover = page_to_phys(image->control_code_page);
>         |                                        ^~
>   arch/s390/include/asm/page.h:189:35: note: in definition of macro 'pfn_to_phys'
>     189 | #define pfn_to_phys(pfn)        ((pfn) << PAGE_SHIFT)
>         |                                   ^~~
>   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
>      64 | #define page_to_pfn __page_to_pfn
>         |                     ^~~~~~~~~~~~~
>   arch/s390/kernel/machine_kexec.c:243:22: note: in expansion of macro 'page_to_phys'
>     243 |         data_mover = page_to_phys(image->control_code_page);
>         |                      ^~~~~~~~~~~~
>   arch/s390/kernel/machine_kexec.c:244:36: error: invalid use of undefined type 'struct kimage'
>     244 |         entry = virt_to_phys(&image->head);
>         |                                    ^~
>   In file included from arch/s390/kernel/machine_kexec.c:27:
>   arch/s390/kernel/machine_kexec.c:252:40: error: invalid use of undefined type 'struct kimage'
>     252 |                    unsigned long, image->start,
>         |                                        ^~
>   arch/s390/include/asm/stacktrace.h:101:32: note: in definition of macro 'CALL_LARGS_2'
>     101 |         long arg2 = (long)(t2)(a2)
>         |                                ^~
>   arch/s390/include/asm/stacktrace.h:216:9: note: in expansion of macro 'CALL_LARGS_3'
>     216 |         CALL_LARGS_##nr(__VA_ARGS__);                                   \
>         |         ^~~~~~~~~~~
>   arch/s390/kernel/machine_kexec.c:250:9: note: in expansion of macro 'call_nodat'
>     250 |         call_nodat(3, void, (relocate_kernel_t)data_mover,
>         |         ^~~~~~~~~~
>   In file included from include/linux/irqflags.h:15:
>   arch/s390/kernel/machine_kexec.c:252:40: error: invalid use of undefined type 'struct kimage'
>     252 |                    unsigned long, image->start,
>         |                                        ^~
>   include/linux/typecheck.h:11:16: note: in definition of macro 'typecheck'
>      11 |         typeof(x) __dummy2; \
>         |                ^
>   arch/s390/include/asm/stacktrace.h:136:9: note: in expansion of macro 'CALL_TYPECHECK_2'
>     136 |         CALL_TYPECHECK_2(__VA_ARGS__);                                  \
>         |         ^~~~~~~~~~~~~~~~
>   arch/s390/include/asm/stacktrace.h:219:9: note: in expansion of macro 'CALL_TYPECHECK_3'
>     219 |         CALL_TYPECHECK_##nr(__VA_ARGS__);                               \
>         |         ^~~~~~~~~~~~~~~
>   arch/s390/kernel/machine_kexec.c:250:9: note: in expansion of macro 'call_nodat'
>     250 |         call_nodat(3, void, (relocate_kernel_t)data_mover,
>         |         ^~~~~~~~~~
>   include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
>      12 |         (void)(&__dummy == &__dummy2); \
>         |                         ^~
>   arch/s390/include/asm/stacktrace.h:134:9: note: in expansion of macro 'typecheck'
>     134 |         typecheck(t, a)
>         |         ^~~~~~~~~
>   arch/s390/include/asm/stacktrace.h:136:9: note: in expansion of macro 'CALL_TYPECHECK_2'
>     136 |         CALL_TYPECHECK_2(__VA_ARGS__);                                  \
>         |         ^~~~~~~~~~~~~~~~
>   arch/s390/include/asm/stacktrace.h:219:9: note: in expansion of macro 'CALL_TYPECHECK_3'
>     219 |         CALL_TYPECHECK_##nr(__VA_ARGS__);                               \
>         |         ^~~~~~~~~~~~~~~
>   arch/s390/kernel/machine_kexec.c:250:9: note: in expansion of macro 'call_nodat'
>     250 |         call_nodat(3, void, (relocate_kernel_t)data_mover,
>         |         ^~~~~~~~~~
>   arch/s390/kernel/machine_kexec.c: At top level:
>   arch/s390/kernel/machine_kexec.c:278:27: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
>     278 | void machine_kexec(struct kimage *image)
>         |                           ^~~~~~
>   arch/s390/kernel/machine_kexec.c: In function 'machine_kexec':
>   arch/s390/kernel/machine_kexec.c:280:18: error: invalid use of undefined type 'struct kimage'
>     280 |         if (image->type == KEXEC_TYPE_CRASH && !kdump_csum_valid(image))
>         |                  ^~
>   arch/s390/kernel/machine_kexec.c:280:28: error: 'KEXEC_TYPE_CRASH' undeclared (first use in this function); did you mean 'KEXEC_ON_CRASH'?
>     280 |         if (image->type == KEXEC_TYPE_CRASH && !kdump_csum_valid(image))
>         |                            ^~~~~~~~~~~~~~~~
>         |                            KEXEC_ON_CRASH
>   arch/s390/kernel/machine_kexec.c:280:66: error: passing argument 1 of 'kdump_csum_valid' from incompatible pointer type [-Werror=incompatible-pointer-types]
>     280 |         if (image->type == KEXEC_TYPE_CRASH && !kdump_csum_valid(image))
>         |                                                                  ^~~~~
>         |                                                                  |
>         |                                                                  struct kimage *
>   arch/s390/kernel/machine_kexec.c:120:45: note: expected 'struct kimage *' but argument is of type 'struct kimage *'
>     120 | static bool kdump_csum_valid(struct kimage *image)
>         |                              ~~~~~~~~~~~~~~~^~~~~
>   cc1: some warnings being treated as errors
> 
> I don't think this change is equivalent for s390, which had
> 
>   config KEXEC
>       def_bool y
>       select KEXEC_CORE
> 
> but it is now the equivalent of
> 
>   config KEXEC
>       bool "Enable kexec system call"
>       default y
> 
> which enables KEXEC by default but it also allows KEXEC to be disabled
> for s390 now, because it is a user-visible symbol, not one that is
> unconditionally enabled no matter what. If s390 can tolerate KEXEC being
> user selectable, then I assume the fix is just adjusting
> arch/s390/kernel/Makefile to only build the machine_kexec files when
> CONFIG_KEXEC_CORE is set:
> 
> diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
> index 6b2a051e1f8a..a06b39da95f0 100644
> --- a/arch/s390/kernel/Makefile
> +++ b/arch/s390/kernel/Makefile
> @@ -37,10 +37,10 @@ CFLAGS_unwind_bc.o	+= -fno-optimize-sibling-calls
>  obj-y	:= head64.o traps.o time.o process.o earlypgm.o early.o setup.o idle.o vtime.o
>  obj-y	+= processor.o syscall.o ptrace.o signal.o cpcmd.o ebcdic.o nmi.o
>  obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o cpufeature.o
> -obj-y	+= sysinfo.o lgr.o os_info.o machine_kexec.o
> +obj-y	+= sysinfo.o lgr.o os_info.o
>  obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
>  obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
> -obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
> +obj-y	+= nospec-branch.o ipl_vmparm.o unwind_bc.o
>  obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o
>  
>  extra-y				+= vmlinux.lds
> @@ -66,6 +66,7 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o
>  obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
>  
> +obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o machine_kexec_reloc.o
>  obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
>  obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o
>  
> 
> Otherwise, the prompt for KEXEC could be made conditional on some ARCH
> symbol so that architectures can opt out of it.

Hi Nathan,

Thanks a lot for looking into it!
With few modification the fix would looke like below.
It probably needs to be a pre-requisite for this series:


[PATCH] s390/kexec: make machine_kexec depend on CONFIG_KEXEC_CORE

Make machine_kexec.o and relocate_kernel.o depend on
CONFIG_KEXEC_CORE option as other architectures do.

Still generate machine_kexec_reloc.o unconditionally,
since arch_kexec_do_relocs() function is neded by the
decompressor.

Probably, #include <asm/kexec.h> could be be removed from
machine_kexec_reloc.c source as well, but that would revert
commit 155e6c706125 ("s390/kexec: add missing include to
machine_kexec_reloc.c").

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/kernel/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 8d7514c72bb8..0df2b88cc0da 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -37,9 +37,9 @@ CFLAGS_unwind_bc.o	+= -fno-optimize-sibling-calls
 obj-y	:= head64.o traps.o time.o process.o earlypgm.o early.o setup.o idle.o vtime.o
 obj-y	+= processor.o syscall.o ptrace.o signal.o cpcmd.o ebcdic.o nmi.o
 obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o cpufeature.o
-obj-y	+= sysinfo.o lgr.o os_info.o machine_kexec.o
+obj-y	+= sysinfo.o lgr.o os_info.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
-obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
+obj-y	+= entry.o reipl.o kdebugfs.o alternative.o
 obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
 obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o
 
@@ -63,6 +63,7 @@ obj-$(CONFIG_RETHOOK)		+= rethook.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
> Cheers,
> Nathan

Thanks!
