Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCD664D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjAJUsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjAJUsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:48:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98C15F5E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:48:07 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so1587715wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPENSPtBBp9MErNIRXr7Ew4TPic8Sj4rJgGorCZ/iwk=;
        b=LYOz69rF4b0m07DxaLGyCVLg/aBPs/nz+tyz6oYyQVrtkDYvN+xRaa2JF69Xox9DoT
         /SXdWhKpFKJE98GqcNTr47RmTTlCsTROlFoC16soRdEag+ctU+BqMmY0NquYkwoIgvst
         xEYPRGp/02TlykswJRMzdkhBA5VjXktby+zXfVsvbnsU74PQZddBGpoB4t7TQrKDMT+9
         bEj2mTDtvH/IDxIAH++w5UN+4PIt0opXB40lMvHJhaRw1HBV8iKyWGz2QNXJG7q809i0
         7DNAluYsg88LaIs28rSOS5MgI9ER3nLRWuVBFsUsK52fFrp0El76KLJROz6lLf4djRb/
         6drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPENSPtBBp9MErNIRXr7Ew4TPic8Sj4rJgGorCZ/iwk=;
        b=Lfe3SJ4V6O08KgMgCCUz7XcugDl3EroGxVKTZwYFwVmeNbYfqrytMEkPCQDyiK6u5S
         2r859djmVgoRNuc2MGcGLjMMgnYhcChMi7cuvHrdWz5BLA/HO6vlYQrUVlikGHtil+p4
         kpl36FlmGt7FYlVmM95y6NyPpVi9fEaIjCaDW8a9GQa/PXifrlgqBE3LDEddqxzhb10T
         dpX/8M0jSrmy1DUmCPagqWOL22g1MmmkgIazM9H8m8HWtoZXYfnusdvOW//Awhf0pEBd
         gZs7FIi+VUxfZnFk1iA8tHDTLgpM7m8WqTZ8QViLoNvkh33IZtmHGy690PJXbO3nTT8B
         eQXA==
X-Gm-Message-State: AFqh2krSxFrRaexsfHToml50003N2umX7xp3Dg0lo2K4u3XG5OG2iUbT
        l1JTty0OHcVi8xtdl7laNiEBxg==
X-Google-Smtp-Source: AMrXdXuULHwIlQJl1ezipKJT1VKBCnMNU4jieqVIsKH6S9K+SNRQV0vdWhbcy9JxvFEHd304nqJQwQ==
X-Received: by 2002:a05:600c:34ce:b0:3cf:614e:b587 with SMTP id d14-20020a05600c34ce00b003cf614eb587mr53730810wmq.26.1673383686354;
        Tue, 10 Jan 2023 12:48:06 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b003d998412db6sm22252997wmn.28.2023.01.10.12.48.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2023 12:48:05 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] riscv: elf: add .riscv.attributes parsing
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230110201841.2069353-1-vineetg@rivosinc.com>
Date:   Tue, 10 Jan 2023 20:48:03 +0000
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        palmer@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <01AF458D-1EDC-47D1-A902-A686E2DF26AF@jrtc27.com>
References: <20230110201841.2069353-1-vineetg@rivosinc.com>
To:     Vineet Gupta <vineetg@rivosinc.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2023, at 20:18, Vineet Gupta <vineetg@rivosinc.com> wrote:
>=20
> This implements the elf loader hook to parse RV specific
> .riscv.attributes section. This section is inserted by compilers
> (gcc/llvm) with build related information such as -march organized as
> tag/value attribute pairs.
>=20
> It identifies the various attribute tags (and corresponding values) as
> currently specified in the psABI specification.
>=20
> This patch only implements the elf parsing mechanics, leaving out the
> recording/usage of the attributes to subsequent patches.
>=20
> Reported-by: kernel test robot <lkp@intel.com>  # code under =
CONFIG_COMPAT
> Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>

This code is full of buffer overruns and uninitialised reads in the
presence of malicious files, and fails to check the version, vendor and
sub-subsection tag.

You also should handle more than one sub-subsection even if tools =
don=E2=80=99t
emit it today.

You also have an unaligned access for reading the sub-subsection=E2=80=99s=
 data
length (maybe that=E2=80=99s ok in kernel land, but worth making sure).

Jess

> ---
> arch/riscv/Kconfig           |   1 +
> arch/riscv/include/asm/elf.h |  11 +++
> arch/riscv/kernel/Makefile   |   1 +
> arch/riscv/kernel/elf-attr.c | 150 +++++++++++++++++++++++++++++++++++
> 4 files changed, 163 insertions(+)
> create mode 100644 arch/riscv/kernel/elf-attr.c
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..f7e0ab05a2d2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -12,6 +12,7 @@ config 32BIT
>=20
> config RISCV
> 	def_bool y
> +	select ARCH_BINFMT_ELF_STATE
> 	select ARCH_CLOCKSOURCE_INIT
> 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && =
MIGRATION
> 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> diff --git a/arch/riscv/include/asm/elf.h =
b/arch/riscv/include/asm/elf.h
> index e7acffdf21d2..7ab8bd0ec330 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -116,6 +116,17 @@ do {							=
\
> 		*(struct user_regs_struct *)regs;	\
> } while (0);
>=20
> +struct arch_elf_state {
> +};
> +
> +#define INIT_ARCH_ELF_STATE {}
> +
> +extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
> +			    bool is_interp, struct arch_elf_state =
*state);
> +
> +extern int arch_check_elf(void *ehdr, bool has_interpreter, void =
*interp_ehdr,
> +			  struct arch_elf_state *state);
> +
> #ifdef CONFIG_COMPAT
>=20
> #define SET_PERSONALITY(ex)					\
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 4cf303a779ab..eff6d845ac9d 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -50,6 +50,7 @@ obj-y	+=3D riscv_ksyms.o
> obj-y	+=3D stacktrace.o
> obj-y	+=3D cacheinfo.o
> obj-y	+=3D patch.o
> +obj-y	+=3D elf-attr.o
> obj-y	+=3D probes/
> obj-$(CONFIG_MMU) +=3D vdso.o vdso/
>=20
> diff --git a/arch/riscv/kernel/elf-attr.c =
b/arch/riscv/kernel/elf-attr.c
> new file mode 100644
> index 000000000000..148d720f97de
> --- /dev/null
> +++ b/arch/riscv/kernel/elf-attr.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-24 Rivos Inc.
> + */
> +
> +#include <linux/binfmts.h>
> +#include <linux/elf.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "rv-elf-attr: " fmt
> +
> +#define PT_RISCV_ATTRIBUTES		0x70000003
> +
> +#define RV_ATTR_TAG_stack_align		4
> +#define RV_ATTR_TAG_arch		5
> +#define RV_ATTR_TAG_unaligned_access	6
> +
> +#define RV_ATTR_SEC_SZ			SZ_1K
> +
> +static void rv_elf_attr_int(u64 tag, u64 val)
> +{
> +}
> +
> +static void rv_elf_attr_str(u64 tag, const char *str)
> +{
> +}
> +
> +static u64
> +decode_uleb128(unsigned char **dpp)
> +{
> +	unsigned char *bp =3D *dpp;
> +	unsigned char byte;
> +	unsigned int shift =3D 0;
> +	u64 result =3D 0;
> +
> +	while (1) {
> +		byte =3D *bp++;
> +		result |=3D (byte & 0x7f) << shift;
> +		if ((byte & 0x80) =3D=3D 0)
> +			break;
> +		shift +=3D 7;
> +	}
> +	*dpp =3D bp;
> +	return result;
> +}
> +
> +/*
> + * Parse .riscv.attributes elf section to get the various compile =
time
> + * attributes such as -march, unaligned access and so no.
> + */
> +static int rv_parse_elf_attributes(struct file *f, const struct =
elf_phdr *phdr,
> +				   struct arch_elf_state *state)
> +{
> +	unsigned char buf[RV_ATTR_SEC_SZ];
> +	unsigned char *p;
> +	ssize_t n;
> +	int ret =3D 0;
> +	loff_t pos;
> +
> +	pr_debug("Section .riscv.attributes found\n");
> +
> +	/* Assume a reasonable size for now */
> +	if (phdr->p_filesz > sizeof(buf))
> +		return -ENOEXEC;
> +
> +	memset(buf, 0, RV_ATTR_SEC_SZ);
> +	pos =3D phdr->p_offset;
> +	n =3D kernel_read(f, &buf, phdr->p_filesz, &pos);
> +
> +	if (n < 0)
> +		return -EIO;
> +
> +	p =3D buf;
> +	p++;				/* format-version (1B) */
> +
> +	while ((p - buf) < n) {
> +
> +		unsigned char *vendor_start;
> +		u32 len;
> +
> +		/*
> +		 * Organized as "vendor" sub-section(s).
> +		 * Current only 1 specified "riscv"
> +		 */
> +
> +		p +=3D 4;			/* sub-section length =
(4B) */
> +		while (*p++ !=3D '\0')	/* vendor name string */
> +			;
> +		p++;			/* Tag_File (1B) */
> +		len =3D *(u32 *)p;	/* data length (4B) */
> +		p +=3D 4;
> +
> +		len -=3D 5;		/* data length includes Tag and =
self length */
> +		vendor_start =3D p;
> +		while ((p - vendor_start) < len) {
> +
> +			u64 tag =3D decode_uleb128(&p);
> +			unsigned char *val_str;
> +			u64 val_n;
> +
> +			switch (tag) {
> +			case RV_ATTR_TAG_stack_align:
> +				val_n =3D decode_uleb128(&p);
> +				break;
> +
> +			case RV_ATTR_TAG_unaligned_access:
> +				val_n =3D decode_uleb128(&p);
> +				pr_debug("Tag_RISCV_unaligned_access =
=3D%llu\n", val_n);
> +				rv_elf_attr_int(tag, val_n);
> +				break;
> +
> +			case RV_ATTR_TAG_arch:
> +				val_str =3D p;
> +				while (*p++ !=3D '\0')
> +					;
> +				pr_debug("Tag_RISCV_arch =3D[%s]\n", =
val_str);
> +				rv_elf_attr_str(tag, val_str);
> +				break;
> +
> +			default:
> +				val_n =3D decode_uleb128(&p);
> +				pr_debug("skipping Unrecognized Tag =
[%llu]=3D%llu\n", tag, val_n);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Hook invoked from common elf loader to parse any arch specific elf =
segments
> + */
> +int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
> +		     bool is_interp, struct arch_elf_state *state)
> +{
> +	struct elf_phdr *phdr =3D _phdr;
> +	int ret =3D 0;
> +
> +	if (phdr->p_type =3D=3D PT_RISCV_ATTRIBUTES && !is_interp)
> +		ret =3D rv_parse_elf_attributes(elf, phdr, state);
> +
> +	return ret;
> +}
> +
> +int arch_check_elf(void *_ehdr, bool has_interpreter, void =
*_interp_ehdr,
> +		   struct arch_elf_state *state)
> +{
> +	return 0;
> +}
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

