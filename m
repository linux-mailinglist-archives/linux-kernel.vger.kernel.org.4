Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8236E4277
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjDQIWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjDQIWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:22:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF3640F4;
        Mon, 17 Apr 2023 01:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B02A96201A;
        Mon, 17 Apr 2023 08:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E976CC4339E;
        Mon, 17 Apr 2023 08:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681719741;
        bh=B72hDKC8PTL/V7c1GV3jjBpQai4jWltPrAaMankVKlQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DhV9J/aGe5t51Of7xqgiIFgrW70e28ihJ2ovpKQYF8GZvx5ORQj/FbH80xAjZoDvW
         X2fcaZDxIoTSs27aU8LfgMbI9RrVBaj1mwQxqOF7gsiH8IGzaHikNp25bZU8VkKZC1
         Ugp6NKpxCFpp3xkRrSG1wXxCnEU3xJIuJqDvw1QUjEjmRMaffOkiYo3IVI4pSi/CVY
         wA69iRGDTHmAgC71OZQQFlH/uT5Qbzf5ioXmYq3+NfSdeKJkKEMbho8DEEEDlI6yEB
         LuxPRENsL7ImKHKPka0aOZF5gzfh1tiTzWMkH++bex/tx6i6EtLAKu9MRDXrbB7XRm
         hAFLbQF/ZBZGA==
Received: by mail-ej1-f41.google.com with SMTP id ud9so61723241ejc.7;
        Mon, 17 Apr 2023 01:22:20 -0700 (PDT)
X-Gm-Message-State: AAQBX9cyOIIaA1LSkl4DqY7bC2mJoM4NQk8tizviNs2OD7SUO+7Cu8tA
        IlPV29ZibUMxX+V26ttAtELGjIWNW98xUc9OYew=
X-Google-Smtp-Source: AKy350ZgpHLVBkptZQwvl733kA1nGIBpXTepdFumKly5QtJM1o7Ps0Hv7B5NhAIInn7/iCzUplZ+XrSbBj90cxG3vAs=
X-Received: by 2002:a17:907:6e24:b0:94f:8aff:c8ab with SMTP id
 sd36-20020a1709076e2400b0094f8affc8abmr710047ejc.10.1681719738879; Mon, 17
 Apr 2023 01:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230410111823.2538831-1-chenhuacai@loongson.cn> <0a278ab5-751a-9433-3d1f-19a5a6b99d39@loongson.cn>
In-Reply-To: <0a278ab5-751a-9433-3d1f-19a5a6b99d39@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 17 Apr 2023 16:22:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5sxLDS7+MOaC_Y+gd-=Qrog7gzidKDkYa=DWC2Ci_5_Q@mail.gmail.com>
Message-ID: <CAAhV-H5sxLDS7+MOaC_Y+gd-=Qrog7gzidKDkYa=DWC2Ci_5_Q@mail.gmail.com>
Subject: Re: [PATCH V2] tools/perf: Add basic support for LoongArch
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Ming Wang <wangming01@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Youling,

On Wed, Apr 12, 2023 at 5:44=E2=80=AFPM Youling Tang <tangyouling@loongson.=
cn> wrote:
>
> Hi, Huacai
>
> On 04/10/2023 07:18 PM, Huacai Chen wrote:
> > Add basic support for LoongArch, which is very similar to the MIPS
> > version.
> >
> > Signed-off-by: Ming Wang <wangming01@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > V2: Add libdw support.
> >
> >  .../loongarch/include/uapi/asm/perf_regs.h    | 40 +++++++++
> >  .../arch/loongarch/include/uapi/asm/unistd.h  |  9 ++
> >  tools/perf/Makefile.config                    | 12 ++-
> >  tools/perf/arch/loongarch/Build               |  1 +
> >  tools/perf/arch/loongarch/Makefile            | 28 +++++++
> >  .../arch/loongarch/annotate/instructions.c    | 45 ++++++++++
> >  .../loongarch/entry/syscalls/mksyscalltbl     | 61 ++++++++++++++
> >  .../arch/loongarch/include/dwarf-regs-table.h | 16 ++++
> >  tools/perf/arch/loongarch/include/perf_regs.h | 15 ++++
> >  tools/perf/arch/loongarch/util/Build          |  5 ++
> >  tools/perf/arch/loongarch/util/dwarf-regs.c   | 44 ++++++++++
> >  tools/perf/arch/loongarch/util/perf_regs.c    |  6 ++
> >  tools/perf/arch/loongarch/util/unwind-libdw.c | 56 +++++++++++++
> >  .../arch/loongarch/util/unwind-libunwind.c    | 82 +++++++++++++++++++
> >  tools/perf/check-headers.sh                   |  1 +
> >  tools/perf/util/annotate.c                    |  8 ++
> >  tools/perf/util/dwarf-regs.c                  |  7 ++
> >  tools/perf/util/env.c                         |  2 +
> >  tools/perf/util/genelf.h                      |  3 +
> >  tools/perf/util/perf_regs.c                   | 76 +++++++++++++++++
> >  tools/perf/util/syscalltbl.c                  |  4 +
> >  21 files changed, 518 insertions(+), 3 deletions(-)
> >  create mode 100644 tools/arch/loongarch/include/uapi/asm/perf_regs.h
> >  create mode 100644 tools/arch/loongarch/include/uapi/asm/unistd.h
> >  create mode 100644 tools/perf/arch/loongarch/Build
> >  create mode 100644 tools/perf/arch/loongarch/Makefile
> >  create mode 100644 tools/perf/arch/loongarch/annotate/instructions.c
> >  create mode 100755 tools/perf/arch/loongarch/entry/syscalls/mksyscallt=
bl
> >  create mode 100644 tools/perf/arch/loongarch/include/dwarf-regs-table.=
h
> >  create mode 100644 tools/perf/arch/loongarch/include/perf_regs.h
> >  create mode 100644 tools/perf/arch/loongarch/util/Build
> >  create mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c
> >  create mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
> >  create mode 100644 tools/perf/arch/loongarch/util/unwind-libdw.c
> >  create mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
> >
> > diff --git a/tools/arch/loongarch/include/uapi/asm/perf_regs.h b/tools/=
arch/loongarch/include/uapi/asm/perf_regs.h
> > new file mode 100644
> > index 000000000000..29d69c00fc7a
> > --- /dev/null
> > +++ b/tools/arch/loongarch/include/uapi/asm/perf_regs.h
> > @@ -0,0 +1,40 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _ASM_LOONGARCH_PERF_REGS_H
> > +#define _ASM_LOONGARCH_PERF_REGS_H
> > +
> > +enum perf_event_loongarch_regs {
> > +     PERF_REG_LOONGARCH_PC,
>
> Why do we replace PERF_REG_LOONGARCH_PC with PERF_REG_LOONGARCH_R0
> (although it is $zero) position (maybe refer to RISCV), but there are
> many differences between LoongArch and RISCV, such as `struct
> user_pt_regs` definition.
This comes from arch/loongarch/include/uapi/asm/perf_regs.h, and I
think the root cause is RISC-V, the trouble is we shouldn't change
UAPI now.

>
> IMO, it may be better not to destroy $zero as much as possible, and to
> keep it consistent with the definition in the libunwind tool.
>
> PERF_REG_LOONGARCH_PC =3D 33.
If PERF_REG_LOONGARCH_PC is 33 in libunwind, I think we can only
change libunwind now.

>
> > +     PERF_REG_LOONGARCH_R1,
> > +     PERF_REG_LOONGARCH_R2,
> > +     PERF_REG_LOONGARCH_R3,
> > +     PERF_REG_LOONGARCH_R4,
> > +     PERF_REG_LOONGARCH_R5,
> > +     PERF_REG_LOONGARCH_R6,
> > +     PERF_REG_LOONGARCH_R7,
> > +     PERF_REG_LOONGARCH_R8,
> > +     PERF_REG_LOONGARCH_R9,
> > +     PERF_REG_LOONGARCH_R10,
> > +     PERF_REG_LOONGARCH_R11,
> > +     PERF_REG_LOONGARCH_R12,
> > +     PERF_REG_LOONGARCH_R13,
> > +     PERF_REG_LOONGARCH_R14,
> > +     PERF_REG_LOONGARCH_R15,
> > +     PERF_REG_LOONGARCH_R16,
> > +     PERF_REG_LOONGARCH_R17,
> > +     PERF_REG_LOONGARCH_R18,
> > +     PERF_REG_LOONGARCH_R19,
> > +     PERF_REG_LOONGARCH_R20,
> > +     PERF_REG_LOONGARCH_R21,
> > +     PERF_REG_LOONGARCH_R22,
> > +     PERF_REG_LOONGARCH_R23,
> > +     PERF_REG_LOONGARCH_R24,
> > +     PERF_REG_LOONGARCH_R25,
> > +     PERF_REG_LOONGARCH_R26,
> > +     PERF_REG_LOONGARCH_R27,
> > +     PERF_REG_LOONGARCH_R28,
> > +     PERF_REG_LOONGARCH_R29,
> > +     PERF_REG_LOONGARCH_R30,
> > +     PERF_REG_LOONGARCH_R31,
> > +     PERF_REG_LOONGARCH_MAX,
> > +};
> > +#endif /* _ASM_LOONGARCH_PERF_REGS_H */
> > diff --git a/tools/arch/loongarch/include/uapi/asm/unistd.h b/tools/arc=
h/loongarch/include/uapi/asm/unistd.h
> > new file mode 100644
> > index 000000000000..0c743344e92d
> > --- /dev/null
> > +++ b/tools/arch/loongarch/include/uapi/asm/unistd.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> > + */
> > +
> > +#define __ARCH_WANT_SYS_CLONE
> > +#define __ARCH_WANT_SYS_CLONE3
> > +
> > +#include <asm-generic/unistd.h>
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 3519a0139026..c0a208f9b67b 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -38,7 +38,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
> >        NO_SYSCALL_TABLE :=3D 0
> >      endif
> >    else
> > -    ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390 mips))
> > +    ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390 mips loong=
arch))
> >        NO_SYSCALL_TABLE :=3D 0
> >      endif
> >    endif
> > @@ -80,6 +80,12 @@ ifeq ($(SRCARCH),arm64)
> >    LIBUNWIND_LIBS =3D -lunwind -lunwind-aarch64
> >  endif
> >
> > +ifeq ($(SRCARCH),loongarch)
> > +  NO_PERF_REGS :=3D 0
> > +  CFLAGS +=3D -I$(OUTPUT)arch/loongarch/include/generated
> > +  LIBUNWIND_LIBS =3D -lunwind -lunwind-loongarch64
> > +endif
> > +
> >  ifeq ($(SRCARCH),riscv)
> >    NO_PERF_REGS :=3D 0
> >  endif
> > @@ -107,7 +113,7 @@ endif
> >  # Disable it on all other architectures in case libdw unwind
> >  # support is detected in system. Add supported architectures
> >  # to the check.
> > -ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky =
riscv))
> > +ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky =
riscv loongarch))
> >    NO_LIBDW_DWARF_UNWIND :=3D 1
> >  endif
> >
> > @@ -129,7 +135,7 @@ endef
> >  ifdef LIBUNWIND_DIR
> >    LIBUNWIND_CFLAGS  =3D -I$(LIBUNWIND_DIR)/include
> >    LIBUNWIND_LDFLAGS =3D -L$(LIBUNWIND_DIR)/lib
> > -  LIBUNWIND_ARCHS =3D x86 x86_64 arm aarch64 debug-frame-arm debug-fra=
me-aarch64
> > +  LIBUNWIND_ARCHS =3D x86 x86_64 arm aarch64 debug-frame-arm debug-fra=
me-aarch64 loongarch
> >    $(foreach libunwind_arch,$(LIBUNWIND_ARCHS),$(call libunwind_arch_se=
t_flags,$(libunwind_arch)))
> >  endif
> >
> > diff --git a/tools/perf/arch/loongarch/Build b/tools/perf/arch/loongarc=
h/Build
> > new file mode 100644
> > index 000000000000..e4e5f33c84d8
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/Build
> > @@ -0,0 +1 @@
> > +perf-y +=3D util/
> > diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loong=
arch/Makefile
> > new file mode 100644
> > index 000000000000..c392e7af4743
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/Makefile
> > @@ -0,0 +1,28 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +ifndef NO_DWARF
> > +PERF_HAVE_DWARF_REGS :=3D 1
> > +endif
> > +PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET :=3D 1
> > +PERF_HAVE_JITDUMP :=3D 1
> > +
> > +#
> > +# Syscall table generation for perf
> > +#
> > +
> > +out    :=3D $(OUTPUT)arch/loongarch/include/generated/asm
> > +header :=3D $(out)/syscalls.c
> > +incpath :=3D $(srctree)/tools
> > +sysdef :=3D $(srctree)/tools/arch/loongarch/include/uapi/asm/unistd.h
> > +sysprf :=3D $(srctree)/tools/perf/arch/loongarch/entry/syscalls/
> > +systbl :=3D $(sysprf)/mksyscalltbl
> > +
> > +# Create output directory if not already present
> > +_dummy :=3D $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> > +
> > +$(header): $(sysdef) $(systbl)
> > +     $(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef)=
 > $@
> > +
> > +clean::
> > +     $(call QUIET_CLEAN, loongarch) $(RM) $(header)
> > +
> > +archheaders: $(header)
> > diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/=
perf/arch/loongarch/annotate/instructions.c
> > new file mode 100644
> > index 000000000000..ab21bf122135
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/annotate/instructions.c
> > @@ -0,0 +1,45 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Perf annotate functions.
> > + *
> > + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> > + */
> > +
> > +static
> > +struct ins_ops *loongarch__associate_ins_ops(struct arch *arch, const =
char *name)
> > +{
> > +     struct ins_ops *ops =3D NULL;
> > +
> > +     if (!strncmp(name, "beqz", 4) ||
> > +         !strncmp(name, "bnez", 4) ||
> > +         !strncmp(name, "beq", 3) ||
> > +         !strncmp(name, "bne", 3) ||
> > +         !strncmp(name, "blt", 3) ||
> > +         !strncmp(name, "bge", 3) ||
> > +         !strncmp(name, "bltu", 4) ||
> > +         !strncmp(name, "bgeu", 4) ||
> > +         !strncmp(name, "bl", 2))
> > +             ops =3D &call_ops;
> > +     else if (!strncmp(name, "jirl", 4))
> > +             ops =3D &ret_ops;
> > +     else if (name[0] =3D=3D 'b')
> > +             ops =3D &jump_ops;
> > +     else
> > +             return NULL;
> > +
> > +     arch__associate_ins_ops(arch, name, ops);
> > +
> > +     return ops;
> > +}
> > +
> > +static
> > +int loongarch__annotate_init(struct arch *arch, char *cpuid __maybe_un=
used)
> > +{
> > +     if (!arch->initialized) {
> > +             arch->associate_instruction_ops =3D loongarch__associate_=
ins_ops;
> > +             arch->initialized =3D true;
> > +             arch->objdump.comment_char =3D '#';
> > +     }
> > +
> > +     return 0;
> > +}
> > diff --git a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl b/to=
ols/perf/arch/loongarch/entry/syscalls/mksyscalltbl
> > new file mode 100755
> > index 000000000000..c52156f7204d
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
> > @@ -0,0 +1,61 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Generate system call table for perf. Derived from
> > +# powerpc script.
> > +#
> > +# Author(s):  Ming Wang <wangming01@loongson.cn>
> > +# Author(s):  Huacai Chen <chenhuacai@loongson.cn>
> > +# Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> > +
> > +gcc=3D$1
> > +hostcc=3D$2
> > +incpath=3D$3
> > +input=3D$4
> > +
> > +if ! test -r $input; then
> > +     echo "Could not read input file" >&2
> > +     exit 1
> > +fi
> > +
> > +create_table_from_c()
> > +{
> > +     local sc nr last_sc
> > +
> > +     create_table_exe=3D`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
> > +
> > +     {
> > +
> > +     cat <<-_EoHEADER
> > +             #include <stdio.h>
> > +             #include "$input"
> > +             int main(int argc, char *argv[])
> > +             {
> > +     _EoHEADER
> > +
> > +     while read sc nr; do
> > +             printf "%s\n" " printf(\"\\t[%d] =3D \\\"$sc\\\",\\n\", $=
nr);"
> > +             last_sc=3D$nr
> > +     done
> > +
> > +     printf "%s\n" " printf(\"#define SYSCALLTBL_LOONGARCH_MAX_ID %d\\=
n\", $last_sc);"
> > +     printf "}\n"
> > +
> > +     } | $hostcc -I $incpath/include/uapi -o $create_table_exe -x c -
> > +
> > +     $create_table_exe
> > +
> > +     rm -f $create_table_exe
> > +}
> > +
> > +create_table()
> > +{
> > +     echo "static const char *syscalltbl_loongarch[] =3D {"
> > +     create_table_from_c
> > +     echo "};"
> > +}
> > +
> > +$gcc -E -dM -x c  -I $incpath/include/uapi $input           \
> > +     |sed -ne 's/^#define __NR_//p' \
> > +     |sort -t' ' -k2 -n \
> > +     |create_table
> > diff --git a/tools/perf/arch/loongarch/include/dwarf-regs-table.h b/too=
ls/perf/arch/loongarch/include/dwarf-regs-table.h
> > new file mode 100644
> > index 000000000000..4b2291034668
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/include/dwarf-regs-table.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * dwarf-regs-table.h : Mapping of DWARF debug register numbers into
> > + * register names.
> > + *
> > + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> > + */
> > +
> > +#ifdef DEFINE_DWARF_REGSTR_TABLE
> > +static const char * const loongarch_regstr_tbl[] =3D {
> > +     "$0", "$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9",
> > +     "$10", "$11", "$12", "$13", "$14", "$15", "$16", "$17", "$18", "$=
19",
> > +     "$20", "$21", "$22", "$23", "$24", "$25", "$26", "$27", "$28", "%=
29",
> Why `%29` instead of `$29`?
Sorry, this is a typo.

>
>
> > +     "$30", "$31",
> > +};
> > +#endif
> > diff --git a/tools/perf/arch/loongarch/include/perf_regs.h b/tools/perf=
/arch/loongarch/include/perf_regs.h
> > new file mode 100644
> > index 000000000000..7833c7dbd38d
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/include/perf_regs.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef ARCH_PERF_REGS_H
> > +#define ARCH_PERF_REGS_H
> > +
> > +#include <stdlib.h>
> > +#include <linux/types.h>
> > +#include <asm/perf_regs.h>
> > +
> > +#define PERF_REGS_MAX PERF_REG_LOONGARCH_MAX
> > +#define PERF_REG_IP PERF_REG_LOONGARCH_PC
> > +#define PERF_REG_SP PERF_REG_LOONGARCH_R3
> > +
> > +#define PERF_REGS_MASK ((1ULL << PERF_REG_LOONGARCH_MAX) - 1)
> > +
> > +#endif /* ARCH_PERF_REGS_H */
> > diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loo=
ngarch/util/Build
> > new file mode 100644
> > index 000000000000..d776125a2d06
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/util/Build
> > @@ -0,0 +1,5 @@
> > +perf-y +=3D perf_regs.o
> > +
> > +perf-$(CONFIG_DWARF)     +=3D dwarf-regs.o
> > +perf-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> > +perf-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > diff --git a/tools/perf/arch/loongarch/util/dwarf-regs.c b/tools/perf/a=
rch/loongarch/util/dwarf-regs.c
> > new file mode 100644
> > index 000000000000..1ff4e8a7ad74
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/util/dwarf-regs.c
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * dwarf-regs.c : Mapping of DWARF debug register numbers into registe=
r names.
> > + *
> > + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <stdio.h>
> > +#include <errno.h> /* for EINVAL */
> > +#include <string.h> /* for strcmp */
> > +#include <dwarf-regs.h>
> > +
> > +struct pt_regs_dwarfnum {
> > +     const char *name;
> > +     unsigned int dwarfnum;
> > +};
> > +
> > +static struct pt_regs_dwarfnum loongarch_gpr_table[] =3D {
> > +     {"$0", 0}, {"$1", 1}, {"$2", 2}, {"$3", 3},
> > +     {"$4", 4}, {"$5", 5}, {"$6", 6}, {"$7", 7},
> > +     {"$8", 8}, {"$9", 9}, {"$10", 10}, {"$11", 11},
> > +     {"$12", 12}, {"$13", 13}, {"$14", 14}, {"$15", 15},
> > +     {"$16", 16}, {"$17", 17}, {"$18", 18}, {"$19", 19},
> > +     {"$20", 20}, {"$21", 21}, {"$22", 22}, {"$23", 23},
> > +     {"$24", 24}, {"$25", 25}, {"$26", 26}, {"$27", 27},
> > +     {"$28", 28}, {"$29", 29}, {"$30", 30}, {"$31", 31},
> > +     {NULL, 0}
> > +};
> Do you need to change it to the following:
>
> #define GPR_DWARFNUM_NAME(num) {.name =3D __stringify($r##num), .dwarfnum
> =3D num}
> #define REG_DWARFNUM_END {.name =3D NULL, .dwarfnum =3D 0}
>
> static const struct pt_regs_dwarfnum regdwarfnum_table[] =3D {
>          GPR_DWARFNUM_NAME(0),
>          GPR_DWARFNUM_NAME(1),
>          GPR_DWARFNUM_NAME(2),
>          GPR_DWARFNUM_NAME(3),
>          GPR_DWARFNUM_NAME(4),
>          GPR_DWARFNUM_NAME(5),
>          GPR_DWARFNUM_NAME(6),
>          GPR_DWARFNUM_NAME(7),
>          GPR_DWARFNUM_NAME(8),
>          GPR_DWARFNUM_NAME(9),
>          GPR_DWARFNUM_NAME(10),
>          GPR_DWARFNUM_NAME(11),
>          GPR_DWARFNUM_NAME(12),
>          GPR_DWARFNUM_NAME(13),
>          GPR_DWARFNUM_NAME(14),
>          GPR_DWARFNUM_NAME(15),
>          GPR_DWARFNUM_NAME(16),
>          GPR_DWARFNUM_NAME(17),
>          GPR_DWARFNUM_NAME(18),
>          GPR_DWARFNUM_NAME(19),
>          GPR_DWARFNUM_NAME(20),
>          GPR_DWARFNUM_NAME(21),
>          GPR_DWARFNUM_NAME(22),
>          GPR_DWARFNUM_NAME(23),
>          GPR_DWARFNUM_NAME(24),
>          GPR_DWARFNUM_NAME(25),
>          GPR_DWARFNUM_NAME(26),
>          GPR_DWARFNUM_NAME(27),
>          GPR_DWARFNUM_NAME(28),
>          GPR_DWARFNUM_NAME(29),
>          REG_DWARFNUM_NAME(30),
>          REG_DWARFNUM_NAME(31),
>          REG_DWARFNUM_END,
> };
>
> At the same time, "$rx" is used in __perf_reg_name_loongarch and
> loongarch_regstr_tbl, which is consistent with assembly.
OK, I will use the "$rx" format, but I don't want to use macros.

Huacai
>
> > +
> > +const char *get_arch_regstr(unsigned int n)
> > +{
> > +     n %=3D 32;
> > +     return loongarch_gpr_table[n].name;
> > +}
> > +
> > +int regs_query_register_offset(const char *name)
> > +{
> > +     const struct pt_regs_dwarfnum *roff;
> > +
> > +     for (roff =3D loongarch_gpr_table; roff->name !=3D NULL; roff++)
> > +             if (!strcmp(roff->name, name))
> > +                     return roff->dwarfnum;
> > +     return -EINVAL;
> > +}
> > diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/ar=
ch/loongarch/util/perf_regs.c
> > new file mode 100644
> > index 000000000000..2833e101a7c6
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/util/perf_regs.c
> > @@ -0,0 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "../../../util/perf_regs.h"
> > +
> > +const struct sample_reg sample_reg_masks[] =3D {
> > +     SMPL_REG_END
> > +};
> > diff --git a/tools/perf/arch/loongarch/util/unwind-libdw.c b/tools/perf=
/arch/loongarch/util/unwind-libdw.c
> > new file mode 100644
> > index 000000000000..a9415385230a
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/util/unwind-libdw.c
> > @@ -0,0 +1,56 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (C) 2020-2023 Loongson Technology Corporation Limited */
> > +
> > +#include <elfutils/libdwfl.h>
> > +#include "../../util/unwind-libdw.h"
> > +#include "../../util/perf_regs.h"
> > +#include "../../util/sample.h"
> > +
> > +bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +{
> > +     struct unwind_info *ui =3D arg;
> > +     struct regs_dump *user_regs =3D &ui->sample->user_regs;
> > +     Dwarf_Word dwarf_regs[PERF_REG_LOONGARCH_MAX];
> > +
> > +#define REG(r) ({                                                    \
> > +     Dwarf_Word val =3D 0;                                            =
 \
> > +     perf_reg_value(&val, user_regs, PERF_REG_LOONGARCH_##r);        \
> > +     val;                                                            \
> > +})
> > +
> > +     dwarf_regs[0]  =3D 0;
> > +     dwarf_regs[1]  =3D REG(R1);
> > +     dwarf_regs[2]  =3D REG(R2);
> > +     dwarf_regs[3]  =3D REG(R3);
> > +     dwarf_regs[4]  =3D REG(R4);
> > +     dwarf_regs[5]  =3D REG(R5);
> > +     dwarf_regs[6]  =3D REG(R6);
> > +     dwarf_regs[7]  =3D REG(R7);
> > +     dwarf_regs[8]  =3D REG(R8);
> > +     dwarf_regs[9]  =3D REG(R9);
> > +     dwarf_regs[10] =3D REG(R10);
> > +     dwarf_regs[11] =3D REG(R11);
> > +     dwarf_regs[12] =3D REG(R12);
> > +     dwarf_regs[13] =3D REG(R13);
> > +     dwarf_regs[14] =3D REG(R14);
> > +     dwarf_regs[15] =3D REG(R15);
> > +     dwarf_regs[16] =3D REG(R16);
> > +     dwarf_regs[17] =3D REG(R17);
> > +     dwarf_regs[18] =3D REG(R18);
> > +     dwarf_regs[19] =3D REG(R19);
> > +     dwarf_regs[20] =3D REG(R20);
> > +     dwarf_regs[21] =3D REG(R21);
> > +     dwarf_regs[22] =3D REG(R22);
> > +     dwarf_regs[23] =3D REG(R23);
> > +     dwarf_regs[24] =3D REG(R24);
> > +     dwarf_regs[25] =3D REG(R25);
> > +     dwarf_regs[26] =3D REG(R26);
> > +     dwarf_regs[27] =3D REG(R27);
> > +     dwarf_regs[28] =3D REG(R28);
> > +     dwarf_regs[29] =3D REG(R29);
> > +     dwarf_regs[30] =3D REG(R30);
> > +     dwarf_regs[31] =3D REG(R31);
> > +     dwfl_thread_state_register_pc(thread, REG(PC));
> > +
> > +     return dwfl_thread_state_registers(thread, 0, PERF_REG_LOONGARCH_=
MAX, dwarf_regs);
> > +}
> > diff --git a/tools/perf/arch/loongarch/util/unwind-libunwind.c b/tools/=
perf/arch/loongarch/util/unwind-libunwind.c
> > new file mode 100644
> > index 000000000000..f693167b86ef
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/util/unwind-libunwind.c
> > @@ -0,0 +1,82 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <errno.h>
> > +#include <libunwind.h>
> > +#include "perf_regs.h"
> > +#include "../../util/unwind.h"
> > +#include "util/debug.h"
> > +
> > +int libunwind__arch_reg_id(int regnum)
> > +{
> > +     switch (regnum) {
> > +     case UNW_LOONGARCH64_R1:
> > +             return PERF_REG_LOONGARCH_R1;
> > +     case UNW_LOONGARCH64_R2:
> > +             return PERF_REG_LOONGARCH_R2;
> > +     case UNW_LOONGARCH64_R3:
> > +             return PERF_REG_LOONGARCH_R3;
> > +     case UNW_LOONGARCH64_R4:
> > +             return PERF_REG_LOONGARCH_R4;
> > +     case UNW_LOONGARCH64_R5:
> > +             return PERF_REG_LOONGARCH_R5;
> > +     case UNW_LOONGARCH64_R6:
> > +             return PERF_REG_LOONGARCH_R6;
> > +     case UNW_LOONGARCH64_R7:
> > +             return PERF_REG_LOONGARCH_R7;
> > +     case UNW_LOONGARCH64_R8:
> > +             return PERF_REG_LOONGARCH_R8;
> > +     case UNW_LOONGARCH64_R9:
> > +             return PERF_REG_LOONGARCH_R9;
> > +     case UNW_LOONGARCH64_R10:
> > +             return PERF_REG_LOONGARCH_R10;
> > +     case UNW_LOONGARCH64_R11:
> > +             return PERF_REG_LOONGARCH_R11;
> > +     case UNW_LOONGARCH64_R12:
> > +             return PERF_REG_LOONGARCH_R12;
> > +     case UNW_LOONGARCH64_R13:
> > +             return PERF_REG_LOONGARCH_R13;
> > +     case UNW_LOONGARCH64_R14:
> > +             return PERF_REG_LOONGARCH_R14;
> > +     case UNW_LOONGARCH64_R15:
> > +             return PERF_REG_LOONGARCH_R15;
> > +     case UNW_LOONGARCH64_R16:
> > +             return PERF_REG_LOONGARCH_R16;
> > +     case UNW_LOONGARCH64_R17:
> > +             return PERF_REG_LOONGARCH_R17;
> > +     case UNW_LOONGARCH64_R18:
> > +             return PERF_REG_LOONGARCH_R18;
> > +     case UNW_LOONGARCH64_R19:
> > +             return PERF_REG_LOONGARCH_R19;
> > +     case UNW_LOONGARCH64_R20:
> > +             return PERF_REG_LOONGARCH_R20;
> > +     case UNW_LOONGARCH64_R21:
> > +             return PERF_REG_LOONGARCH_R21;
> > +     case UNW_LOONGARCH64_R22:
> > +             return PERF_REG_LOONGARCH_R22;
> > +     case UNW_LOONGARCH64_R23:
> > +             return PERF_REG_LOONGARCH_R23;
> > +     case UNW_LOONGARCH64_R24:
> > +             return PERF_REG_LOONGARCH_R24;
> > +     case UNW_LOONGARCH64_R25:
> > +             return PERF_REG_LOONGARCH_R25;
> > +     case UNW_LOONGARCH64_R26:
> > +             return PERF_REG_LOONGARCH_R26;
> > +     case UNW_LOONGARCH64_R27:
> > +             return PERF_REG_LOONGARCH_R27;
> > +     case UNW_LOONGARCH64_R28:
> > +             return PERF_REG_LOONGARCH_R28;
> > +     case UNW_LOONGARCH64_R29:
> > +             return PERF_REG_LOONGARCH_R29;
> > +     case UNW_LOONGARCH64_R30:
> > +             return PERF_REG_LOONGARCH_R30;
> > +     case UNW_LOONGARCH64_R31:
> > +             return PERF_REG_LOONGARCH_R31;
> > +     case UNW_LOONGARCH64_PC:
> > +             return PERF_REG_LOONGARCH_PC;
> > +     default:
> > +             pr_err("unwind: invalid reg id %d\n", regnum);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > index eacca9a874e2..9d6232f681ce 100755
> > --- a/tools/perf/check-headers.sh
> > +++ b/tools/perf/check-headers.sh
> > @@ -40,6 +40,7 @@ arch/x86/lib/x86-opcode-map.txt
> >  arch/x86/tools/gen-insn-attr-x86.awk
> >  arch/arm/include/uapi/asm/perf_regs.h
> >  arch/arm64/include/uapi/asm/perf_regs.h
> > +arch/loongarch/include/uapi/asm/perf_regs.h
> >  arch/mips/include/uapi/asm/perf_regs.h
> >  arch/powerpc/include/uapi/asm/perf_regs.h
> >  arch/s390/include/uapi/asm/perf_regs.h
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index db475e44f42f..0cc7710f32da 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -149,6 +149,7 @@ static int arch__associate_ins_ops(struct arch* arc=
h, const char *name, struct i
> >  #include "arch/arm/annotate/instructions.c"
> >  #include "arch/arm64/annotate/instructions.c"
> >  #include "arch/csky/annotate/instructions.c"
> > +#include "arch/loongarch/annotate/instructions.c"
> >  #include "arch/mips/annotate/instructions.c"
> >  #include "arch/x86/annotate/instructions.c"
> >  #include "arch/powerpc/annotate/instructions.c"
> > @@ -211,6 +212,13 @@ static struct arch architectures[] =3D {
> >                       .comment_char =3D '#',
> >               },
> >       },
> > +     {
> > +             .name =3D "loongarch",
> > +             .init =3D loongarch__annotate_init,
> > +             .objdump =3D {
> > +                     .comment_char =3D '#',
> > +             },
> > +     },
> >  };
> >
> >  static void ins__delete(struct ins_operands *ops)
> > diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.=
c
> > index 3fa4486742cd..69cfaa5953bf 100644
> > --- a/tools/perf/util/dwarf-regs.c
> > +++ b/tools/perf/util/dwarf-regs.c
> > @@ -14,6 +14,10 @@
> >  #define EM_AARCH64   183  /* ARM 64 bit */
> >  #endif
> >
> > +#ifndef EM_LOONGARCH
> > +#define EM_LOONGARCH 258 /* LoongArch */
> > +#endif
> > +
> >  /* Define const char * {arch}_register_tbl[] */
> >  #define DEFINE_DWARF_REGSTR_TABLE
> >  #include "../arch/x86/include/dwarf-regs-table.h"
> > @@ -25,6 +29,7 @@
> >  #include "../arch/sparc/include/dwarf-regs-table.h"
> >  #include "../arch/xtensa/include/dwarf-regs-table.h"
> >  #include "../arch/mips/include/dwarf-regs-table.h"
> > +#include "../arch/loongarch/include/dwarf-regs-table.h"
> >
> >  #define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n=
)] : NULL)
> >
> > @@ -56,6 +61,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned=
 int machine)
> >               return __get_dwarf_regstr(xtensa_regstr_tbl, n);
> >       case EM_MIPS:
> >               return __get_dwarf_regstr(mips_regstr_tbl, n);
> > +     case EM_LOONGARCH:
> > +             return __get_dwarf_regstr(loongarch_regstr_tbl, n);
> >       default:
> >               pr_err("ELF MACHINE %x is not supported.\n", machine);
> >       }
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index 5b8cf6a421a4..0d5d40cb997b 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -435,6 +435,8 @@ static const char *normalize_arch(char *arch)
> >               return "mips";
> >       if (!strncmp(arch, "sh", 2) && isdigit(arch[2]))
> >               return "sh";
> > +     if (!strncmp(arch, "loongarch", 9))
> > +             return "loongarch";
> >
> >       return arch;
> >  }
> > diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
> > index 6af062d1c452..5f18d20ea903 100644
> > --- a/tools/perf/util/genelf.h
> > +++ b/tools/perf/util/genelf.h
> > @@ -43,6 +43,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, vo=
id *debug, int nr_debug_ent
> >  #elif defined(__riscv) && __riscv_xlen =3D=3D 64
> >  #define GEN_ELF_ARCH EM_RISCV
> >  #define GEN_ELF_CLASS        ELFCLASS64
> > +#elif defined(__loongarch__)
> > +#define GEN_ELF_ARCH EM_LOONGARCH
> > +#define GEN_ELF_CLASS        ELFCLASS64
> Defined as ELFCLASS64 only in 64-bit cases.
>
> Thanks,
> Youling.
>
> >  #else
> >  #error "unsupported architecture"
> >  #endif
> > diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> > index 57a567ee2cea..56c94bedd9b7 100644
> > --- a/tools/perf/util/perf_regs.c
> > +++ b/tools/perf/util/perf_regs.c
> > @@ -28,6 +28,7 @@ uint64_t __weak arch__user_reg_mask(void)
> >
> >  #include "../../arch/arm/include/uapi/asm/perf_regs.h"
> >  #include "../../arch/csky/include/uapi/asm/perf_regs.h"
> > +#include "../../arch/loongarch/include/uapi/asm/perf_regs.h"
> >  #include "../../arch/mips/include/uapi/asm/perf_regs.h"
> >  #include "../../arch/powerpc/include/uapi/asm/perf_regs.h"
> >  #include "../../arch/riscv/include/uapi/asm/perf_regs.h"
> > @@ -236,6 +237,79 @@ static const char *__perf_reg_name_csky(int id)
> >       return NULL;
> >  }
> >
> > +static inline const char *__perf_reg_name_loongarch(int id)
> > +{
> > +     switch (id) {
> > +     case PERF_REG_LOONGARCH_PC:
> > +             return "PC";
> > +     case PERF_REG_LOONGARCH_R1:
> > +             return "$1";
> > +     case PERF_REG_LOONGARCH_R2:
> > +             return "$2";
> > +     case PERF_REG_LOONGARCH_R3:
> > +             return "$3";
> > +     case PERF_REG_LOONGARCH_R4:
> > +             return "$4";
> > +     case PERF_REG_LOONGARCH_R5:
> > +             return "$5";
> > +     case PERF_REG_LOONGARCH_R6:
> > +             return "$6";
> > +     case PERF_REG_LOONGARCH_R7:
> > +             return "$7";
> > +     case PERF_REG_LOONGARCH_R8:
> > +             return "$8";
> > +     case PERF_REG_LOONGARCH_R9:
> > +             return "$9";
> > +     case PERF_REG_LOONGARCH_R10:
> > +             return "$10";
> > +     case PERF_REG_LOONGARCH_R11:
> > +             return "$11";
> > +     case PERF_REG_LOONGARCH_R12:
> > +             return "$12";
> > +     case PERF_REG_LOONGARCH_R13:
> > +             return "$13";
> > +     case PERF_REG_LOONGARCH_R14:
> > +             return "$14";
> > +     case PERF_REG_LOONGARCH_R15:
> > +             return "$15";
> > +     case PERF_REG_LOONGARCH_R16:
> > +             return "$16";
> > +     case PERF_REG_LOONGARCH_R17:
> > +             return "$17";
> > +     case PERF_REG_LOONGARCH_R18:
> > +             return "$18";
> > +     case PERF_REG_LOONGARCH_R19:
> > +             return "$19";
> > +     case PERF_REG_LOONGARCH_R20:
> > +             return "$20";
> > +     case PERF_REG_LOONGARCH_R21:
> > +             return "$21";
> > +     case PERF_REG_LOONGARCH_R22:
> > +             return "$22";
> > +     case PERF_REG_LOONGARCH_R23:
> > +             return "$23";
> > +     case PERF_REG_LOONGARCH_R24:
> > +             return "$24";
> > +     case PERF_REG_LOONGARCH_R25:
> > +             return "$25";
> > +     case PERF_REG_LOONGARCH_R26:
> > +             return "$26";
> > +     case PERF_REG_LOONGARCH_R27:
> > +             return "$27";
> > +     case PERF_REG_LOONGARCH_R28:
> > +             return "$28";
> > +     case PERF_REG_LOONGARCH_R29:
> > +             return "$29";
> > +     case PERF_REG_LOONGARCH_R30:
> > +             return "$30";
> > +     case PERF_REG_LOONGARCH_R31:
> > +             return "$31";
> > +     default:
> > +             break;
> > +     }
> > +     return NULL;
> > +}
> > +
> >  static const char *__perf_reg_name_mips(int id)
> >  {
> >       switch (id) {
> > @@ -670,6 +744,8 @@ const char *perf_reg_name(int id, const char *arch)
> >
> >       if (!strcmp(arch, "csky"))
> >               reg_name =3D __perf_reg_name_csky(id);
> > +     else if (!strcmp(arch, "loongarch"))
> > +             reg_name =3D __perf_reg_name_loongarch(id);
> >       else if (!strcmp(arch, "mips"))
> >               reg_name =3D __perf_reg_name_mips(id);
> >       else if (!strcmp(arch, "powerpc"))
> > diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.=
c
> > index a2e906858891..313eccef6cb4 100644
> > --- a/tools/perf/util/syscalltbl.c
> > +++ b/tools/perf/util/syscalltbl.c
> > @@ -38,6 +38,10 @@ static const char **syscalltbl_native =3D syscalltbl=
_arm64;
> >  #include <asm/syscalls_n64.c>
> >  const int syscalltbl_native_max_id =3D SYSCALLTBL_MIPS_N64_MAX_ID;
> >  static const char **syscalltbl_native =3D syscalltbl_mips_n64;
> > +#elif defined(__loongarch__)
> > +#include <asm/syscalls.c>
> > +const int syscalltbl_native_max_id =3D SYSCALLTBL_LOONGARCH_MAX_ID;
> > +static const char **syscalltbl_native =3D syscalltbl_loongarch;
> >  #endif
> >
> >  struct syscall {
> >
>
