Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9DA69CBA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjBTNKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjBTNKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:10:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7429A1BAEA;
        Mon, 20 Feb 2023 05:10:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0998660E96;
        Mon, 20 Feb 2023 13:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FE0C433EF;
        Mon, 20 Feb 2023 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676898614;
        bh=2ikMx+J9iZA7Wuvdcg8nlqS+qWdzmIvw7PRlQ6iELBk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=T2gDurMxly1kyU1CfR1+ju0rANY+X2UEvtP+NpohSyD8xNI1sQ04rUNGdm4GlevX7
         YpOfHUSSvQOeSnhdmxrhLjpn08Fmg5idoP6+c1CNHX+TYsmOfTBYjZ1gUuPcEmHgUO
         H2hUraT4QQUKLo7c4aKkcVDScnkaWcV6qCsZPw6reL5w+CiQ5dKpI2o5SUaOJWjMik
         Az0ZWpX+dwwhr/WsnQuBuOuFSnwdtPZ+Y7AOmP2H9n2evDn5Ydzu4N8iiMYnIjMYLv
         aNJBZiFJPFZLrPBcIkW+FRMzajQb2FP6h9X7tleyPhmmzVnqehQHyFtWG1WtUKm0oC
         OrFxuAQk//5EQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 1/1] riscv: Allow to downgrade paging mode from the
 command line
In-Reply-To: <20230131151115.1972740-2-alexghiti@rivosinc.com>
References: <20230131151115.1972740-1-alexghiti@rivosinc.com>
 <20230131151115.1972740-2-alexghiti@rivosinc.com>
Date:   Mon, 20 Feb 2023 14:10:11 +0100
Message-ID: <87lekslbyk.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> Add 2 early command line parameters that allow to downgrade satp mode
> (using the same naming as x86):
> - "no5lvl": use a 4-level page table (down from sv57 to sv48)
> - "no4lvl": use a 3-level page table (down from sv57/sv48 to sv39)
>
> Note that going through the device tree to get the kernel command line
> works with ACPI too since the efi stub creates a device tree anyway with
> the command line.
>
> In KASAN kernels, we can't use the libfdt that early in the boot process
> since we are not ready to execute instrumented functions. So instead of
> using the "generic" libfdt, we compile our own versions of those functions
> that are not instrumented and that are prefixed so that they do not
> conflict with the generic ones. We also need the non-instrumented versions
> of the string functions and the prefixed versions of memcpy/memmove.
>
> This is largely inspired by commit aacd149b6238 ("arm64: head: avoid
> relocating the kernel twice for KASLR") from which I removed compilation
> flags that were not relevant to RISC-V at the moment (LTO, SCS, pie).
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +-
>  arch/riscv/kernel/Makefile                    |  2 +
>  arch/riscv/kernel/pi/Makefile                 | 34 ++++++++++++
>  arch/riscv/kernel/pi/cmdline_early.c          | 52 +++++++++++++++++++
>  arch/riscv/lib/memcpy.S                       |  2 +
>  arch/riscv/lib/memmove.S                      |  2 +
>  arch/riscv/mm/init.c                          | 36 ++++++++++---
>  7 files changed, 126 insertions(+), 7 deletions(-)
>  create mode 100644 arch/riscv/kernel/pi/Makefile
>  create mode 100644 arch/riscv/kernel/pi/cmdline_early.c
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..1d8fc66d2b0d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3578,7 +3578,10 @@
>  			emulation library even if a 387 maths coprocessor
>  			is present.
>=20=20
> -	no5lvl		[X86-64] Disable 5-level paging mode. Forces
> +	no4lvl		[RISCV] Disable 4-level and 5-level paging modes. Forces
> +			kernel to use 3-level paging instead.
> +
> +	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
>  			kernel to use 4-level paging instead.
>=20=20
>  	nofsgsbase	[X86] Disables FSGSBASE instructions.
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 4cf303a779ab..6756209f1ac6 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -89,3 +89,5 @@ obj-$(CONFIG_EFI)		+=3D efi.o
>  obj-$(CONFIG_COMPAT)		+=3D compat_syscall_table.o
>  obj-$(CONFIG_COMPAT)		+=3D compat_signal.o
>  obj-$(CONFIG_COMPAT)		+=3D compat_vdso/
> +
> +obj-y				+=3D pi/
> diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
> new file mode 100644
> index 000000000000..554e936ef0b6
> --- /dev/null
> +++ b/arch/riscv/kernel/pi/Makefile
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# This file was copied from arm64/kernel/pi/Makefile.
> +
> +KBUILD_CFLAGS	:=3D $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> +		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
> +		   $(call cc-option,-mbranch-protection=3Dnone) \
> +		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
> +		   -D__DISABLE_EXPORTS -ffreestanding \
> +		   -fno-asynchronous-unwind-tables -fno-unwind-tables \
> +		   $(call cc-option,-fno-addrsig)
> +
> +GCOV_PROFILE	:=3D n
> +KASAN_SANITIZE	:=3D n
> +KCSAN_SANITIZE	:=3D n
> +UBSAN_SANITIZE	:=3D n
> +KCOV_INSTRUMENT	:=3D n
> +
> +$(obj)/%.pi.o: OBJCOPYFLAGS :=3D --prefix-symbols=3D__pi_ \
> +			       --remove-section=3D.note.gnu.property \
> +			       --prefix-alloc-sections=3D.init
> +$(obj)/%.pi.o: $(obj)/%.o FORCE
> +	$(call if_changed,objcopy)
> +
> +$(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
> +	$(call if_changed_rule,cc_o_c)
> +
> +$(obj)/string.o: $(srctree)/lib/string.c FORCE
> +	$(call if_changed_rule,cc_o_c)
> +
> +$(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
> +	$(call if_changed_rule,cc_o_c)
> +
> +obj-y		:=3D cmdline_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-f=
dt_ro.pi.o
> +extra-y		:=3D $(patsubst %.pi.o,%.o,$(obj-y))
> diff --git a/arch/riscv/kernel/pi/cmdline_early.c b/arch/riscv/kernel/pi/=
cmdline_early.c
> new file mode 100644
> index 000000000000..5ae7b853fa66
> --- /dev/null
> +++ b/arch/riscv/kernel/pi/cmdline_early.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/libfdt.h>
> +#include <linux/string.h>
> +#include <asm/pgtable.h>
> +#include <asm/setup.h>
> +
> +static char early_cmdline[COMMAND_LINE_SIZE] __initdata;
> +
> +static char * __init get_early_cmdline(uintptr_t dtb_pa)
> +{
> +	const char *fdt_cmdline =3D NULL;
> +	unsigned int fdt_cmdline_size =3D 0;
> +	int chosen_node;
> +
> +	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
> +		chosen_node =3D fdt_path_offset((void *)dtb_pa, "/chosen");
> +		if (chosen_node >=3D 0) {
> +			fdt_cmdline =3D fdt_getprop((void *)dtb_pa, chosen_node,
> +						  "bootargs", NULL);

Alex and I have been running some more tests, and fdt_cmdline is missing
a NULL-check here.

We'll need a v5 to fix this!


Bj=C3=B6rn
