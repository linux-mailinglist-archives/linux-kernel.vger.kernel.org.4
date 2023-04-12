Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798736DF0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDLJpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDLJpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:45:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AD7C903D;
        Wed, 12 Apr 2023 02:45:09 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8AxJDSFfTZk_SkbAA--.42819S3;
        Wed, 12 Apr 2023 17:44:37 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxWb2BfTZkdNUgAA--.34516S3;
        Wed, 12 Apr 2023 17:44:34 +0800 (CST)
Subject: Re: [PATCH V2] tools/perf: Add basic support for LoongArch
To:     Huacai Chen <chenhuacai@loongson.cn>
References: <20230410111823.2538831-1-chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
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
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <0a278ab5-751a-9433-3d1f-19a5a6b99d39@loongson.cn>
Date:   Wed, 12 Apr 2023 17:44:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230410111823.2538831-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxWb2BfTZkdNUgAA--.34516S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvAXoWfur4rZryxtFy8Jw4fGFyfWFg_yoW5Ww15Jo
        WxtF4vkr48GrZrZanxXw1Igay7ZF18CF42va45uws5AFyUAFyDWr9rCw1jqwsxuryktrs5
        GayYgay8Ja1xur1kn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUvv1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64
        kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc80
        4VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY2
        0_WwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r
        Wl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AK
        xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
        kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v2
        6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
        CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj4RuFApUUUU
        U
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai

On 04/10/2023 07:18 PM, Huacai Chen wrote:
> Add basic support for LoongArch, which is very similar to the MIPS
> version.
>
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Add libdw support.
>
>  .../loongarch/include/uapi/asm/perf_regs.h    | 40 +++++++++
>  .../arch/loongarch/include/uapi/asm/unistd.h  |  9 ++
>  tools/perf/Makefile.config                    | 12 ++-
>  tools/perf/arch/loongarch/Build               |  1 +
>  tools/perf/arch/loongarch/Makefile            | 28 +++++++
>  .../arch/loongarch/annotate/instructions.c    | 45 ++++++++++
>  .../loongarch/entry/syscalls/mksyscalltbl     | 61 ++++++++++++++
>  .../arch/loongarch/include/dwarf-regs-table.h | 16 ++++
>  tools/perf/arch/loongarch/include/perf_regs.h | 15 ++++
>  tools/perf/arch/loongarch/util/Build          |  5 ++
>  tools/perf/arch/loongarch/util/dwarf-regs.c   | 44 ++++++++++
>  tools/perf/arch/loongarch/util/perf_regs.c    |  6 ++
>  tools/perf/arch/loongarch/util/unwind-libdw.c | 56 +++++++++++++
>  .../arch/loongarch/util/unwind-libunwind.c    | 82 +++++++++++++++++++
>  tools/perf/check-headers.sh                   |  1 +
>  tools/perf/util/annotate.c                    |  8 ++
>  tools/perf/util/dwarf-regs.c                  |  7 ++
>  tools/perf/util/env.c                         |  2 +
>  tools/perf/util/genelf.h                      |  3 +
>  tools/perf/util/perf_regs.c                   | 76 +++++++++++++++++
>  tools/perf/util/syscalltbl.c                  |  4 +
>  21 files changed, 518 insertions(+), 3 deletions(-)
>  create mode 100644 tools/arch/loongarch/include/uapi/asm/perf_regs.h
>  create mode 100644 tools/arch/loongarch/include/uapi/asm/unistd.h
>  create mode 100644 tools/perf/arch/loongarch/Build
>  create mode 100644 tools/perf/arch/loongarch/Makefile
>  create mode 100644 tools/perf/arch/loongarch/annotate/instructions.c
>  create mode 100755 tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
>  create mode 100644 tools/perf/arch/loongarch/include/dwarf-regs-table.h
>  create mode 100644 tools/perf/arch/loongarch/include/perf_regs.h
>  create mode 100644 tools/perf/arch/loongarch/util/Build
>  create mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
>  create mode 100644 tools/perf/arch/loongarch/util/unwind-libdw.c
>  create mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
>
> diff --git a/tools/arch/loongarch/include/uapi/asm/perf_regs.h b/tools/arch/loongarch/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 000000000000..29d69c00fc7a
> --- /dev/null
> +++ b/tools/arch/loongarch/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _ASM_LOONGARCH_PERF_REGS_H
> +#define _ASM_LOONGARCH_PERF_REGS_H
> +
> +enum perf_event_loongarch_regs {
> +	PERF_REG_LOONGARCH_PC,

Why do we replace PERF_REG_LOONGARCH_PC with PERF_REG_LOONGARCH_R0
(although it is $zero) position (maybe refer to RISCV), but there are
many differences between LoongArch and RISCV, such as `struct
user_pt_regs` definition.

IMO, it may be better not to destroy $zero as much as possible, and to
keep it consistent with the definition in the libunwind tool.

PERF_REG_LOONGARCH_PC = 33.

> +	PERF_REG_LOONGARCH_R1,
> +	PERF_REG_LOONGARCH_R2,
> +	PERF_REG_LOONGARCH_R3,
> +	PERF_REG_LOONGARCH_R4,
> +	PERF_REG_LOONGARCH_R5,
> +	PERF_REG_LOONGARCH_R6,
> +	PERF_REG_LOONGARCH_R7,
> +	PERF_REG_LOONGARCH_R8,
> +	PERF_REG_LOONGARCH_R9,
> +	PERF_REG_LOONGARCH_R10,
> +	PERF_REG_LOONGARCH_R11,
> +	PERF_REG_LOONGARCH_R12,
> +	PERF_REG_LOONGARCH_R13,
> +	PERF_REG_LOONGARCH_R14,
> +	PERF_REG_LOONGARCH_R15,
> +	PERF_REG_LOONGARCH_R16,
> +	PERF_REG_LOONGARCH_R17,
> +	PERF_REG_LOONGARCH_R18,
> +	PERF_REG_LOONGARCH_R19,
> +	PERF_REG_LOONGARCH_R20,
> +	PERF_REG_LOONGARCH_R21,
> +	PERF_REG_LOONGARCH_R22,
> +	PERF_REG_LOONGARCH_R23,
> +	PERF_REG_LOONGARCH_R24,
> +	PERF_REG_LOONGARCH_R25,
> +	PERF_REG_LOONGARCH_R26,
> +	PERF_REG_LOONGARCH_R27,
> +	PERF_REG_LOONGARCH_R28,
> +	PERF_REG_LOONGARCH_R29,
> +	PERF_REG_LOONGARCH_R30,
> +	PERF_REG_LOONGARCH_R31,
> +	PERF_REG_LOONGARCH_MAX,
> +};
> +#endif /* _ASM_LOONGARCH_PERF_REGS_H */
> diff --git a/tools/arch/loongarch/include/uapi/asm/unistd.h b/tools/arch/loongarch/include/uapi/asm/unistd.h
> new file mode 100644
> index 000000000000..0c743344e92d
> --- /dev/null
> +++ b/tools/arch/loongarch/include/uapi/asm/unistd.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + */
> +
> +#define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_SYS_CLONE3
> +
> +#include <asm-generic/unistd.h>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 3519a0139026..c0a208f9b67b 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -38,7 +38,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
>        NO_SYSCALL_TABLE := 0
>      endif
>    else
> -    ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390 mips))
> +    ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390 mips loongarch))
>        NO_SYSCALL_TABLE := 0
>      endif
>    endif
> @@ -80,6 +80,12 @@ ifeq ($(SRCARCH),arm64)
>    LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
>  endif
>
> +ifeq ($(SRCARCH),loongarch)
> +  NO_PERF_REGS := 0
> +  CFLAGS += -I$(OUTPUT)arch/loongarch/include/generated
> +  LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
> +endif
> +
>  ifeq ($(SRCARCH),riscv)
>    NO_PERF_REGS := 0
>  endif
> @@ -107,7 +113,7 @@ endif
>  # Disable it on all other architectures in case libdw unwind
>  # support is detected in system. Add supported architectures
>  # to the check.
> -ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky riscv))
> +ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky riscv loongarch))
>    NO_LIBDW_DWARF_UNWIND := 1
>  endif
>
> @@ -129,7 +135,7 @@ endef
>  ifdef LIBUNWIND_DIR
>    LIBUNWIND_CFLAGS  = -I$(LIBUNWIND_DIR)/include
>    LIBUNWIND_LDFLAGS = -L$(LIBUNWIND_DIR)/lib
> -  LIBUNWIND_ARCHS = x86 x86_64 arm aarch64 debug-frame-arm debug-frame-aarch64
> +  LIBUNWIND_ARCHS = x86 x86_64 arm aarch64 debug-frame-arm debug-frame-aarch64 loongarch
>    $(foreach libunwind_arch,$(LIBUNWIND_ARCHS),$(call libunwind_arch_set_flags,$(libunwind_arch)))
>  endif
>
> diff --git a/tools/perf/arch/loongarch/Build b/tools/perf/arch/loongarch/Build
> new file mode 100644
> index 000000000000..e4e5f33c84d8
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/Build
> @@ -0,0 +1 @@
> +perf-y += util/
> diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
> new file mode 100644
> index 000000000000..c392e7af4743
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/Makefile
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0
> +ifndef NO_DWARF
> +PERF_HAVE_DWARF_REGS := 1
> +endif
> +PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
> +PERF_HAVE_JITDUMP := 1
> +
> +#
> +# Syscall table generation for perf
> +#
> +
> +out    := $(OUTPUT)arch/loongarch/include/generated/asm
> +header := $(out)/syscalls.c
> +incpath := $(srctree)/tools
> +sysdef := $(srctree)/tools/arch/loongarch/include/uapi/asm/unistd.h
> +sysprf := $(srctree)/tools/perf/arch/loongarch/entry/syscalls/
> +systbl := $(sysprf)/mksyscalltbl
> +
> +# Create output directory if not already present
> +_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +
> +$(header): $(sysdef) $(systbl)
> +	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
> +
> +clean::
> +	$(call QUIET_CLEAN, loongarch) $(RM) $(header)
> +
> +archheaders: $(header)
> diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/perf/arch/loongarch/annotate/instructions.c
> new file mode 100644
> index 000000000000..ab21bf122135
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/annotate/instructions.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Perf annotate functions.
> + *
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + */
> +
> +static
> +struct ins_ops *loongarch__associate_ins_ops(struct arch *arch, const char *name)
> +{
> +	struct ins_ops *ops = NULL;
> +
> +	if (!strncmp(name, "beqz", 4) ||
> +	    !strncmp(name, "bnez", 4) ||
> +	    !strncmp(name, "beq", 3) ||
> +	    !strncmp(name, "bne", 3) ||
> +	    !strncmp(name, "blt", 3) ||
> +	    !strncmp(name, "bge", 3) ||
> +	    !strncmp(name, "bltu", 4) ||
> +	    !strncmp(name, "bgeu", 4) ||
> +	    !strncmp(name, "bl", 2))
> +		ops = &call_ops;
> +	else if (!strncmp(name, "jirl", 4))
> +		ops = &ret_ops;
> +	else if (name[0] == 'b')
> +		ops = &jump_ops;
> +	else
> +		return NULL;
> +
> +	arch__associate_ins_ops(arch, name, ops);
> +
> +	return ops;
> +}
> +
> +static
> +int loongarch__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
> +{
> +	if (!arch->initialized) {
> +		arch->associate_instruction_ops = loongarch__associate_ins_ops;
> +		arch->initialized = true;
> +		arch->objdump.comment_char = '#';
> +	}
> +
> +	return 0;
> +}
> diff --git a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
> new file mode 100755
> index 000000000000..c52156f7204d
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Generate system call table for perf. Derived from
> +# powerpc script.
> +#
> +# Author(s):  Ming Wang <wangming01@loongson.cn>
> +# Author(s):  Huacai Chen <chenhuacai@loongson.cn>
> +# Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> +
> +gcc=$1
> +hostcc=$2
> +incpath=$3
> +input=$4
> +
> +if ! test -r $input; then
> +	echo "Could not read input file" >&2
> +	exit 1
> +fi
> +
> +create_table_from_c()
> +{
> +	local sc nr last_sc
> +
> +	create_table_exe=`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
> +
> +	{
> +
> +	cat <<-_EoHEADER
> +		#include <stdio.h>
> +		#include "$input"
> +		int main(int argc, char *argv[])
> +		{
> +	_EoHEADER
> +
> +	while read sc nr; do
> +		printf "%s\n" "	printf(\"\\t[%d] = \\\"$sc\\\",\\n\", $nr);"
> +		last_sc=$nr
> +	done
> +
> +	printf "%s\n" "	printf(\"#define SYSCALLTBL_LOONGARCH_MAX_ID %d\\n\", $last_sc);"
> +	printf "}\n"
> +
> +	} | $hostcc -I $incpath/include/uapi -o $create_table_exe -x c -
> +
> +	$create_table_exe
> +
> +	rm -f $create_table_exe
> +}
> +
> +create_table()
> +{
> +	echo "static const char *syscalltbl_loongarch[] = {"
> +	create_table_from_c
> +	echo "};"
> +}
> +
> +$gcc -E -dM -x c  -I $incpath/include/uapi $input	       \
> +	|sed -ne 's/^#define __NR_//p' \
> +	|sort -t' ' -k2 -n \
> +	|create_table
> diff --git a/tools/perf/arch/loongarch/include/dwarf-regs-table.h b/tools/perf/arch/loongarch/include/dwarf-regs-table.h
> new file mode 100644
> index 000000000000..4b2291034668
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/include/dwarf-regs-table.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * dwarf-regs-table.h : Mapping of DWARF debug register numbers into
> + * register names.
> + *
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifdef DEFINE_DWARF_REGSTR_TABLE
> +static const char * const loongarch_regstr_tbl[] = {
> +	"$0", "$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9",
> +	"$10", "$11", "$12", "$13", "$14", "$15", "$16", "$17", "$18", "$19",
> +	"$20", "$21", "$22", "$23", "$24", "$25", "$26", "$27", "$28", "%29",
Why `%29` instead of `$29`?


> +	"$30", "$31",
> +};
> +#endif
> diff --git a/tools/perf/arch/loongarch/include/perf_regs.h b/tools/perf/arch/loongarch/include/perf_regs.h
> new file mode 100644
> index 000000000000..7833c7dbd38d
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/include/perf_regs.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef ARCH_PERF_REGS_H
> +#define ARCH_PERF_REGS_H
> +
> +#include <stdlib.h>
> +#include <linux/types.h>
> +#include <asm/perf_regs.h>
> +
> +#define PERF_REGS_MAX PERF_REG_LOONGARCH_MAX
> +#define PERF_REG_IP PERF_REG_LOONGARCH_PC
> +#define PERF_REG_SP PERF_REG_LOONGARCH_R3
> +
> +#define PERF_REGS_MASK ((1ULL << PERF_REG_LOONGARCH_MAX) - 1)
> +
> +#endif /* ARCH_PERF_REGS_H */
> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
> new file mode 100644
> index 000000000000..d776125a2d06
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/util/Build
> @@ -0,0 +1,5 @@
> +perf-y += perf_regs.o
> +
> +perf-$(CONFIG_DWARF)     += dwarf-regs.o
> +perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
> +perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/loongarch/util/dwarf-regs.c b/tools/perf/arch/loongarch/util/dwarf-regs.c
> new file mode 100644
> index 000000000000..1ff4e8a7ad74
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/util/dwarf-regs.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dwarf-regs.c : Mapping of DWARF debug register numbers into register names.
> + *
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <stdio.h>
> +#include <errno.h> /* for EINVAL */
> +#include <string.h> /* for strcmp */
> +#include <dwarf-regs.h>
> +
> +struct pt_regs_dwarfnum {
> +	const char *name;
> +	unsigned int dwarfnum;
> +};
> +
> +static struct pt_regs_dwarfnum loongarch_gpr_table[] = {
> +	{"$0", 0}, {"$1", 1}, {"$2", 2}, {"$3", 3},
> +	{"$4", 4}, {"$5", 5}, {"$6", 6}, {"$7", 7},
> +	{"$8", 8}, {"$9", 9}, {"$10", 10}, {"$11", 11},
> +	{"$12", 12}, {"$13", 13}, {"$14", 14}, {"$15", 15},
> +	{"$16", 16}, {"$17", 17}, {"$18", 18}, {"$19", 19},
> +	{"$20", 20}, {"$21", 21}, {"$22", 22}, {"$23", 23},
> +	{"$24", 24}, {"$25", 25}, {"$26", 26}, {"$27", 27},
> +	{"$28", 28}, {"$29", 29}, {"$30", 30}, {"$31", 31},
> +	{NULL, 0}
> +};
Do you need to change it to the following:

#define GPR_DWARFNUM_NAME(num) {.name = __stringify($r##num), .dwarfnum 
= num}
#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}

static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
         GPR_DWARFNUM_NAME(0),
         GPR_DWARFNUM_NAME(1),
         GPR_DWARFNUM_NAME(2),
         GPR_DWARFNUM_NAME(3),
         GPR_DWARFNUM_NAME(4),
         GPR_DWARFNUM_NAME(5),
         GPR_DWARFNUM_NAME(6),
         GPR_DWARFNUM_NAME(7),
         GPR_DWARFNUM_NAME(8),
         GPR_DWARFNUM_NAME(9),
         GPR_DWARFNUM_NAME(10),
         GPR_DWARFNUM_NAME(11),
         GPR_DWARFNUM_NAME(12),
         GPR_DWARFNUM_NAME(13),
         GPR_DWARFNUM_NAME(14),
         GPR_DWARFNUM_NAME(15),
         GPR_DWARFNUM_NAME(16),
         GPR_DWARFNUM_NAME(17),
         GPR_DWARFNUM_NAME(18),
         GPR_DWARFNUM_NAME(19),
         GPR_DWARFNUM_NAME(20),
         GPR_DWARFNUM_NAME(21),
         GPR_DWARFNUM_NAME(22),
         GPR_DWARFNUM_NAME(23),
         GPR_DWARFNUM_NAME(24),
         GPR_DWARFNUM_NAME(25),
         GPR_DWARFNUM_NAME(26),
         GPR_DWARFNUM_NAME(27),
         GPR_DWARFNUM_NAME(28),
         GPR_DWARFNUM_NAME(29),
         REG_DWARFNUM_NAME(30),
         REG_DWARFNUM_NAME(31),
         REG_DWARFNUM_END,
};

At the same time, "$rx" is used in __perf_reg_name_loongarch and
loongarch_regstr_tbl, which is consistent with assembly.

> +
> +const char *get_arch_regstr(unsigned int n)
> +{
> +	n %= 32;
> +	return loongarch_gpr_table[n].name;
> +}
> +
> +int regs_query_register_offset(const char *name)
> +{
> +	const struct pt_regs_dwarfnum *roff;
> +
> +	for (roff = loongarch_gpr_table; roff->name != NULL; roff++)
> +		if (!strcmp(roff->name, name))
> +			return roff->dwarfnum;
> +	return -EINVAL;
> +}
> diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch/loongarch/util/perf_regs.c
> new file mode 100644
> index 000000000000..2833e101a7c6
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/util/perf_regs.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "../../../util/perf_regs.h"
> +
> +const struct sample_reg sample_reg_masks[] = {
> +	SMPL_REG_END
> +};
> diff --git a/tools/perf/arch/loongarch/util/unwind-libdw.c b/tools/perf/arch/loongarch/util/unwind-libdw.c
> new file mode 100644
> index 000000000000..a9415385230a
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/util/unwind-libdw.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2020-2023 Loongson Technology Corporation Limited */
> +
> +#include <elfutils/libdwfl.h>
> +#include "../../util/unwind-libdw.h"
> +#include "../../util/perf_regs.h"
> +#include "../../util/sample.h"
> +
> +bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +{
> +	struct unwind_info *ui = arg;
> +	struct regs_dump *user_regs = &ui->sample->user_regs;
> +	Dwarf_Word dwarf_regs[PERF_REG_LOONGARCH_MAX];
> +
> +#define REG(r) ({							\
> +	Dwarf_Word val = 0;						\
> +	perf_reg_value(&val, user_regs, PERF_REG_LOONGARCH_##r);	\
> +	val;								\
> +})
> +
> +	dwarf_regs[0]  = 0;
> +	dwarf_regs[1]  = REG(R1);
> +	dwarf_regs[2]  = REG(R2);
> +	dwarf_regs[3]  = REG(R3);
> +	dwarf_regs[4]  = REG(R4);
> +	dwarf_regs[5]  = REG(R5);
> +	dwarf_regs[6]  = REG(R6);
> +	dwarf_regs[7]  = REG(R7);
> +	dwarf_regs[8]  = REG(R8);
> +	dwarf_regs[9]  = REG(R9);
> +	dwarf_regs[10] = REG(R10);
> +	dwarf_regs[11] = REG(R11);
> +	dwarf_regs[12] = REG(R12);
> +	dwarf_regs[13] = REG(R13);
> +	dwarf_regs[14] = REG(R14);
> +	dwarf_regs[15] = REG(R15);
> +	dwarf_regs[16] = REG(R16);
> +	dwarf_regs[17] = REG(R17);
> +	dwarf_regs[18] = REG(R18);
> +	dwarf_regs[19] = REG(R19);
> +	dwarf_regs[20] = REG(R20);
> +	dwarf_regs[21] = REG(R21);
> +	dwarf_regs[22] = REG(R22);
> +	dwarf_regs[23] = REG(R23);
> +	dwarf_regs[24] = REG(R24);
> +	dwarf_regs[25] = REG(R25);
> +	dwarf_regs[26] = REG(R26);
> +	dwarf_regs[27] = REG(R27);
> +	dwarf_regs[28] = REG(R28);
> +	dwarf_regs[29] = REG(R29);
> +	dwarf_regs[30] = REG(R30);
> +	dwarf_regs[31] = REG(R31);
> +	dwfl_thread_state_register_pc(thread, REG(PC));
> +
> +	return dwfl_thread_state_registers(thread, 0, PERF_REG_LOONGARCH_MAX, dwarf_regs);
> +}
> diff --git a/tools/perf/arch/loongarch/util/unwind-libunwind.c b/tools/perf/arch/loongarch/util/unwind-libunwind.c
> new file mode 100644
> index 000000000000..f693167b86ef
> --- /dev/null
> +++ b/tools/perf/arch/loongarch/util/unwind-libunwind.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <errno.h>
> +#include <libunwind.h>
> +#include "perf_regs.h"
> +#include "../../util/unwind.h"
> +#include "util/debug.h"
> +
> +int libunwind__arch_reg_id(int regnum)
> +{
> +	switch (regnum) {
> +	case UNW_LOONGARCH64_R1:
> +		return PERF_REG_LOONGARCH_R1;
> +	case UNW_LOONGARCH64_R2:
> +		return PERF_REG_LOONGARCH_R2;
> +	case UNW_LOONGARCH64_R3:
> +		return PERF_REG_LOONGARCH_R3;
> +	case UNW_LOONGARCH64_R4:
> +		return PERF_REG_LOONGARCH_R4;
> +	case UNW_LOONGARCH64_R5:
> +		return PERF_REG_LOONGARCH_R5;
> +	case UNW_LOONGARCH64_R6:
> +		return PERF_REG_LOONGARCH_R6;
> +	case UNW_LOONGARCH64_R7:
> +		return PERF_REG_LOONGARCH_R7;
> +	case UNW_LOONGARCH64_R8:
> +		return PERF_REG_LOONGARCH_R8;
> +	case UNW_LOONGARCH64_R9:
> +		return PERF_REG_LOONGARCH_R9;
> +	case UNW_LOONGARCH64_R10:
> +		return PERF_REG_LOONGARCH_R10;
> +	case UNW_LOONGARCH64_R11:
> +		return PERF_REG_LOONGARCH_R11;
> +	case UNW_LOONGARCH64_R12:
> +		return PERF_REG_LOONGARCH_R12;
> +	case UNW_LOONGARCH64_R13:
> +		return PERF_REG_LOONGARCH_R13;
> +	case UNW_LOONGARCH64_R14:
> +		return PERF_REG_LOONGARCH_R14;
> +	case UNW_LOONGARCH64_R15:
> +		return PERF_REG_LOONGARCH_R15;
> +	case UNW_LOONGARCH64_R16:
> +		return PERF_REG_LOONGARCH_R16;
> +	case UNW_LOONGARCH64_R17:
> +		return PERF_REG_LOONGARCH_R17;
> +	case UNW_LOONGARCH64_R18:
> +		return PERF_REG_LOONGARCH_R18;
> +	case UNW_LOONGARCH64_R19:
> +		return PERF_REG_LOONGARCH_R19;
> +	case UNW_LOONGARCH64_R20:
> +		return PERF_REG_LOONGARCH_R20;
> +	case UNW_LOONGARCH64_R21:
> +		return PERF_REG_LOONGARCH_R21;
> +	case UNW_LOONGARCH64_R22:
> +		return PERF_REG_LOONGARCH_R22;
> +	case UNW_LOONGARCH64_R23:
> +		return PERF_REG_LOONGARCH_R23;
> +	case UNW_LOONGARCH64_R24:
> +		return PERF_REG_LOONGARCH_R24;
> +	case UNW_LOONGARCH64_R25:
> +		return PERF_REG_LOONGARCH_R25;
> +	case UNW_LOONGARCH64_R26:
> +		return PERF_REG_LOONGARCH_R26;
> +	case UNW_LOONGARCH64_R27:
> +		return PERF_REG_LOONGARCH_R27;
> +	case UNW_LOONGARCH64_R28:
> +		return PERF_REG_LOONGARCH_R28;
> +	case UNW_LOONGARCH64_R29:
> +		return PERF_REG_LOONGARCH_R29;
> +	case UNW_LOONGARCH64_R30:
> +		return PERF_REG_LOONGARCH_R30;
> +	case UNW_LOONGARCH64_R31:
> +		return PERF_REG_LOONGARCH_R31;
> +	case UNW_LOONGARCH64_PC:
> +		return PERF_REG_LOONGARCH_PC;
> +	default:
> +		pr_err("unwind: invalid reg id %d\n", regnum);
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index eacca9a874e2..9d6232f681ce 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -40,6 +40,7 @@ arch/x86/lib/x86-opcode-map.txt
>  arch/x86/tools/gen-insn-attr-x86.awk
>  arch/arm/include/uapi/asm/perf_regs.h
>  arch/arm64/include/uapi/asm/perf_regs.h
> +arch/loongarch/include/uapi/asm/perf_regs.h
>  arch/mips/include/uapi/asm/perf_regs.h
>  arch/powerpc/include/uapi/asm/perf_regs.h
>  arch/s390/include/uapi/asm/perf_regs.h
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index db475e44f42f..0cc7710f32da 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -149,6 +149,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
>  #include "arch/arm/annotate/instructions.c"
>  #include "arch/arm64/annotate/instructions.c"
>  #include "arch/csky/annotate/instructions.c"
> +#include "arch/loongarch/annotate/instructions.c"
>  #include "arch/mips/annotate/instructions.c"
>  #include "arch/x86/annotate/instructions.c"
>  #include "arch/powerpc/annotate/instructions.c"
> @@ -211,6 +212,13 @@ static struct arch architectures[] = {
>  			.comment_char = '#',
>  		},
>  	},
> +	{
> +		.name = "loongarch",
> +		.init = loongarch__annotate_init,
> +		.objdump = {
> +			.comment_char = '#',
> +		},
> +	},
>  };
>
>  static void ins__delete(struct ins_operands *ops)
> diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
> index 3fa4486742cd..69cfaa5953bf 100644
> --- a/tools/perf/util/dwarf-regs.c
> +++ b/tools/perf/util/dwarf-regs.c
> @@ -14,6 +14,10 @@
>  #define EM_AARCH64	183  /* ARM 64 bit */
>  #endif
>
> +#ifndef EM_LOONGARCH
> +#define EM_LOONGARCH	258 /* LoongArch */
> +#endif
> +
>  /* Define const char * {arch}_register_tbl[] */
>  #define DEFINE_DWARF_REGSTR_TABLE
>  #include "../arch/x86/include/dwarf-regs-table.h"
> @@ -25,6 +29,7 @@
>  #include "../arch/sparc/include/dwarf-regs-table.h"
>  #include "../arch/xtensa/include/dwarf-regs-table.h"
>  #include "../arch/mips/include/dwarf-regs-table.h"
> +#include "../arch/loongarch/include/dwarf-regs-table.h"
>
>  #define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n)] : NULL)
>
> @@ -56,6 +61,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine)
>  		return __get_dwarf_regstr(xtensa_regstr_tbl, n);
>  	case EM_MIPS:
>  		return __get_dwarf_regstr(mips_regstr_tbl, n);
> +	case EM_LOONGARCH:
> +		return __get_dwarf_regstr(loongarch_regstr_tbl, n);
>  	default:
>  		pr_err("ELF MACHINE %x is not supported.\n", machine);
>  	}
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 5b8cf6a421a4..0d5d40cb997b 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -435,6 +435,8 @@ static const char *normalize_arch(char *arch)
>  		return "mips";
>  	if (!strncmp(arch, "sh", 2) && isdigit(arch[2]))
>  		return "sh";
> +	if (!strncmp(arch, "loongarch", 9))
> +		return "loongarch";
>
>  	return arch;
>  }
> diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
> index 6af062d1c452..5f18d20ea903 100644
> --- a/tools/perf/util/genelf.h
> +++ b/tools/perf/util/genelf.h
> @@ -43,6 +43,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
>  #elif defined(__riscv) && __riscv_xlen == 64
>  #define GEN_ELF_ARCH	EM_RISCV
>  #define GEN_ELF_CLASS	ELFCLASS64
> +#elif defined(__loongarch__)
> +#define GEN_ELF_ARCH	EM_LOONGARCH
> +#define GEN_ELF_CLASS	ELFCLASS64
Defined as ELFCLASS64 only in 64-bit cases.

Thanks,
Youling.

>  #else
>  #error "unsupported architecture"
>  #endif
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 57a567ee2cea..56c94bedd9b7 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -28,6 +28,7 @@ uint64_t __weak arch__user_reg_mask(void)
>
>  #include "../../arch/arm/include/uapi/asm/perf_regs.h"
>  #include "../../arch/csky/include/uapi/asm/perf_regs.h"
> +#include "../../arch/loongarch/include/uapi/asm/perf_regs.h"
>  #include "../../arch/mips/include/uapi/asm/perf_regs.h"
>  #include "../../arch/powerpc/include/uapi/asm/perf_regs.h"
>  #include "../../arch/riscv/include/uapi/asm/perf_regs.h"
> @@ -236,6 +237,79 @@ static const char *__perf_reg_name_csky(int id)
>  	return NULL;
>  }
>
> +static inline const char *__perf_reg_name_loongarch(int id)
> +{
> +	switch (id) {
> +	case PERF_REG_LOONGARCH_PC:
> +		return "PC";
> +	case PERF_REG_LOONGARCH_R1:
> +		return "$1";
> +	case PERF_REG_LOONGARCH_R2:
> +		return "$2";
> +	case PERF_REG_LOONGARCH_R3:
> +		return "$3";
> +	case PERF_REG_LOONGARCH_R4:
> +		return "$4";
> +	case PERF_REG_LOONGARCH_R5:
> +		return "$5";
> +	case PERF_REG_LOONGARCH_R6:
> +		return "$6";
> +	case PERF_REG_LOONGARCH_R7:
> +		return "$7";
> +	case PERF_REG_LOONGARCH_R8:
> +		return "$8";
> +	case PERF_REG_LOONGARCH_R9:
> +		return "$9";
> +	case PERF_REG_LOONGARCH_R10:
> +		return "$10";
> +	case PERF_REG_LOONGARCH_R11:
> +		return "$11";
> +	case PERF_REG_LOONGARCH_R12:
> +		return "$12";
> +	case PERF_REG_LOONGARCH_R13:
> +		return "$13";
> +	case PERF_REG_LOONGARCH_R14:
> +		return "$14";
> +	case PERF_REG_LOONGARCH_R15:
> +		return "$15";
> +	case PERF_REG_LOONGARCH_R16:
> +		return "$16";
> +	case PERF_REG_LOONGARCH_R17:
> +		return "$17";
> +	case PERF_REG_LOONGARCH_R18:
> +		return "$18";
> +	case PERF_REG_LOONGARCH_R19:
> +		return "$19";
> +	case PERF_REG_LOONGARCH_R20:
> +		return "$20";
> +	case PERF_REG_LOONGARCH_R21:
> +		return "$21";
> +	case PERF_REG_LOONGARCH_R22:
> +		return "$22";
> +	case PERF_REG_LOONGARCH_R23:
> +		return "$23";
> +	case PERF_REG_LOONGARCH_R24:
> +		return "$24";
> +	case PERF_REG_LOONGARCH_R25:
> +		return "$25";
> +	case PERF_REG_LOONGARCH_R26:
> +		return "$26";
> +	case PERF_REG_LOONGARCH_R27:
> +		return "$27";
> +	case PERF_REG_LOONGARCH_R28:
> +		return "$28";
> +	case PERF_REG_LOONGARCH_R29:
> +		return "$29";
> +	case PERF_REG_LOONGARCH_R30:
> +		return "$30";
> +	case PERF_REG_LOONGARCH_R31:
> +		return "$31";
> +	default:
> +		break;
> +	}
> +	return NULL;
> +}
> +
>  static const char *__perf_reg_name_mips(int id)
>  {
>  	switch (id) {
> @@ -670,6 +744,8 @@ const char *perf_reg_name(int id, const char *arch)
>
>  	if (!strcmp(arch, "csky"))
>  		reg_name = __perf_reg_name_csky(id);
> +	else if (!strcmp(arch, "loongarch"))
> +		reg_name = __perf_reg_name_loongarch(id);
>  	else if (!strcmp(arch, "mips"))
>  		reg_name = __perf_reg_name_mips(id);
>  	else if (!strcmp(arch, "powerpc"))
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index a2e906858891..313eccef6cb4 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -38,6 +38,10 @@ static const char **syscalltbl_native = syscalltbl_arm64;
>  #include <asm/syscalls_n64.c>
>  const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
>  static const char **syscalltbl_native = syscalltbl_mips_n64;
> +#elif defined(__loongarch__)
> +#include <asm/syscalls.c>
> +const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
> +static const char **syscalltbl_native = syscalltbl_loongarch;
>  #endif
>
>  struct syscall {
>

