Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CBA668713
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjALWjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjALWi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:38:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4D659324
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:38:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v2so8503051wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYOgRxVnVO9WiL8/xIYxULkQkHyZrlvgyKSvkvkG3+8=;
        b=MQbYuzhLsQu6MkS1jzHazC1VCHcVKtONrzMZyNtvDwHUObhi0tHazvoEfjn8/FwwSI
         OGID1S9c9sKgft0fh2n8uWZ84at5FnSaJqtbL85b1PnsUt/z4X0A6QevA3wNOyYX8gMl
         eGpPUq0ZuKa1GkZj5r0SsQk02t6XrbDdF67Y4/yMq+ef/NeAp9dJa5/ENEOgaX+Z9FCz
         MSTY+Kuqamhg/evlAX5ag+5lZe8PMz7ab87qpREAI758WC9CewvI+gW+H9DjVGAXA8pA
         x2L5dDJbPewhN+qyApGh1WKhMmohmT0Dbv5CN7ZE/yvWkJZ/rlKl1GvFTDTGXCknEg3O
         8vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYOgRxVnVO9WiL8/xIYxULkQkHyZrlvgyKSvkvkG3+8=;
        b=VM38GccuC5EkIKxDwCLloThkxUrLyp12n9GUCTcAdFSYRkRIqCpyKOTlX0xXoXAab8
         506pm+4woPzrBbq28O/FQ4PFq0kQa6ZpZV+WDFPAh9gawvIYSQ05Fcq99MmNC6szvgXa
         G7TdYDge1i+imEmjgsTaUydew6tn6nVUPzYKPPcOaBCgteIW+UufwyasgWYfrsmBLXNc
         YNLX3ztVV9TCV7jI4/p/WPqgn47pQZfAXY3vioV+vSdYxJzpGnpyE/LwuxkQ1yOABaBs
         c841b72AlPMxnR1BvO/5ZmkNiWtU1ZuwcIparapxOhOrUZMxwH1bcsbimGa3FH+caDNZ
         Kv1A==
X-Gm-Message-State: AFqh2kolWQQzeMXLE6AWhFHrF4nV5Nrrjp997hM2RiaK8LEaAILBeSZ1
        ZECJEeC/U08a4/SiI7lJTrevEg==
X-Google-Smtp-Source: AMrXdXsmISdu3qNJHjekfd3ZBDYw5rdWELoEhuuAzbzZiZuJI2p1mOfmiRfTWsVauytHmKnxrurYkw==
X-Received: by 2002:a05:6000:384:b0:297:175c:3cbd with SMTP id u4-20020a056000038400b00297175c3cbdmr36440247wrf.66.1673563133985;
        Thu, 12 Jan 2023 14:38:53 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id bw28-20020a0560001f9c00b002421888a011sm17124456wrb.69.2023.01.12.14.38.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2023 14:38:53 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2] riscv: elf: add .riscv.attributes parsing
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230112210622.2337254-1-vineetg@rivosinc.com>
Date:   Thu, 12 Jan 2023 22:38:52 +0000
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6A37757-DB22-44C6-A906-D68A0B8BD7A6@jrtc27.com>
References: <20230112210622.2337254-1-vineetg@rivosinc.com>
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

On 12 Jan 2023, at 21:06, Vineet Gupta <vineetg@rivosinc.com> wrote:
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
> Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
> ---
> Changes since v1 [1]
>  - Handling potential oob accesses due to against malformed elf =
contents
>  - Handling of multiple sub-subsections
>=20
> =
[1]https://lore.kernel.org/linux-riscv/20230110201841.2069353-1-vineetg@ri=
vosinc.com
>=20
> Given the current state of discussions, the intended Vector extension
> support would likely not need it, still posting the reworked v2 for
> logical conclusion and for posterity in case need comes up in future
> for something like CFI elf annotation.
> Maintainers/reviewers can decide whether to merge it.
> ---
> arch/riscv/Kconfig           |   1 +
> arch/riscv/include/asm/elf.h |  11 ++
> arch/riscv/kernel/Makefile   |   1 +
> arch/riscv/kernel/elf-attr.c | 232 +++++++++++++++++++++++++++++++++++
> 4 files changed, 245 insertions(+)
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
> index 000000000000..51bcee92dd5b
> --- /dev/null
> +++ b/arch/riscv/kernel/elf-attr.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Rivos Inc.
> + */
> +
> +#include <linux/binfmts.h>
> +#include <linux/elf.h>
> +#include <asm/unaligned.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "rv-elf-attr: " fmt
> +
> +#define PT_RISCV_ATTRIBUTES		0x70000003
> +
> +#define RV_ATTR_TAG_file		1
> +
> +#define RV_ATTR_TAG_stack_align		4
> +#define RV_ATTR_TAG_arch		5
> +#define RV_ATTR_TAG_unaligned_access	6
> +
> +#define RV_ATTR_VENDOR_RISCV		"riscv"
> +
> +#define RV_ATTR_SEC_SZ			SZ_1K
> +
> +static void rv_elf_attr_int(u32 tag, u32 val)
> +{
> +	pr_debug("Tag %x=3D%d\n", tag, val);
> +}
> +
> +static void rv_elf_attr_str(u32 tag, const unsigned char *str)
> +{
> +	pr_debug("Tag %x=3D[%s]\n", tag, str);
> +}
> +
> +/*
> + * Decode a ule128 encoded value.
> + */
> +static int
> +decode_uleb128_safe(unsigned char **dpp, u32 *val, const unsigned =
char *p_end)
> +{
> +	unsigned char *bp =3D *dpp;
> +	unsigned char byte;
> +	unsigned int shift =3D 0;
> +	u32 result =3D 0;
> +	int ok =3D 0;
> +
> +	while (bp < p_end) {
> +		byte =3D *bp++;
> +		result |=3D (byte & 0x7f) << shift;
> +		if ((byte & 0x80) =3D=3D 0) {
> +			ok =3D 1;
> +			break;

Why not just do the return here?

> +		}
> +		shift +=3D 7;
> +	}
> +	if (!ok)
> +		return -1;
> +	*dpp =3D bp;
> +	*val =3D result;
> +	return 0;
> +}
> +
> +/*
> + * Parse a single elf attribute.
> + */
> +static int rv_parse_elf_attr_safe(unsigned char **dpp, unsigned char =
*p_end)
> +{
> +	unsigned char *p =3D *dpp;
> +	unsigned char *str;
> +	u32 tag, val, s_len;
> +
> +	if (decode_uleb128_safe(&p, &tag, p_end))
> +		goto bad_attr;
> +
> +	switch (tag) {
> +	case RV_ATTR_TAG_stack_align:
> +		if (decode_uleb128_safe(&p, &val, p_end))
> +			goto bad_attr;
> +		rv_elf_attr_int(tag, val);
> +		break;
> +
> +	case RV_ATTR_TAG_unaligned_access:
> +		if (decode_uleb128_safe(&p, &val, p_end))
> +			goto bad_attr;
> +		rv_elf_attr_int(tag, val);
> +		break;
> +
> +	case RV_ATTR_TAG_arch:
> +		str =3D p;
> +		s_len =3D strnlen(p, p_end - p) + 1;
> +		p +=3D s_len;
> +		if (p > p_end)

Constructing such a p is UB, check s_len before instead.

> +			goto bad_attr;
> +		rv_elf_attr_str(tag, str);
> +		break;
> +
> +	default:
> +		if (decode_uleb128_safe(&p, &val, p_end))

=46rom the ratified spec:

  "RISC-V attributes have a string value if the tag number is odd and an =
integer value if the tag number is even."

> +			goto bad_attr;
> +		pr_debug("skipping Unrecognized Tag [%u]=3D%u\n", tag, =
val);
> +		break;
> +	}
> +
> +	*dpp =3D p;
> +	return 0;
> +bad_attr:
> +	return -ENOEXEC;
> +}
> +
> +/*
> + * Parse .riscv.attributes elf section.
> + */
> +static int rv_parse_elf_attributes(struct file *f, const struct =
elf_phdr *phdr,
> +				   struct arch_elf_state *state)
> +{
> +	unsigned char buf[RV_ATTR_SEC_SZ];
> +	unsigned char *p, *p_end;
> +	ssize_t n;
> +	int ret =3D 0;
> +	loff_t pos;
> +
> +	pr_debug("Section .riscv.attributes found\n");
> +
> +	/* Assume a reasonable size for now */
> +	if (phdr->p_filesz > sizeof(buf))
> +		goto bad_elf;
> +
> +	memset(buf, 0, RV_ATTR_SEC_SZ);

This will hide bugs from sanitisers...

> +	pos =3D phdr->p_offset;
> +	n =3D kernel_read(f, &buf, phdr->p_filesz, &pos);
> +
> +	if (n < 0)
> +		return -EIO;
> +
> +	p =3D buf;
> +	p_end =3D p + n;
> +
> +	/* sanity check format-version */
> +	if (*p++ !=3D 'A')

What if n is 0?

> +		goto bad_elf;
> +
> +	/*
> +	 * elf attribute section organized as Vendor sub-sections(s)
> +	 *   {sub-section length, vendor name, vendor data}
> +	 * Vendor data organized as sub-subsection(s)
> +	 *   {tag, sub-subsection length, attributes contents}
> +	 * Attribute contents organized as
> +	 *   {tag, value} pair(s).
> +	 */
> +	while ((p_end - p) >=3D 4) {
> +		int sub_len, vname_len;

u32?

> +
> +		sub_len =3D get_unaligned_le32(p);
> +		if (sub_len <=3D 4 || sub_len > n)

n is the total amount read in, not the remaining amount.

> +			goto bad_elf;
> +
> +		p +=3D 4;
> +		sub_len -=3D 4;
> +
> +		/* Vendor name string */
> +		vname_len =3D strnlen(p, sub_len) + 1;
> +		if (vname_len > sub_len)
> +			goto bad_elf;
> +
> +		/* skip non-mandatory sub-section for now */
> +		if (strncmp(p, RV_ATTR_VENDOR_RISCV, sub_len)) {
> +			p +=3D sub_len;
> +			continue;
> +		}
> +
> +		p +=3D vname_len;
> +		sub_len -=3D vname_len;
> +
> +		/* Vendor data: sub-subsections(s) */
> +		while (sub_len > 0) {
> +			u32 tag, content_len;
> +			unsigned char *sub_end, *sub_start =3D p;

Confusing naming for sub-subsection variables.

> +
> +			if (decode_uleb128_safe(&p, &tag, p_end))
> +				goto bad_elf;
> +
> +			if ((p_end - p) < 4)
> +				goto bad_elf;
> +
> +			content_len =3D get_unaligned_le32(p);
> +			if (content_len > sub_len)
> +				goto bad_elf;
> +
> +			p +=3D 4;
> +			sub_len -=3D content_len;
> +			sub_end =3D sub_start + content_len;
> +
> +			/* For now handle attributes relating to whole =
file */
> +			if (tag !=3D RV_ATTR_TAG_file) {
> +				p =3D sub_end;
> +				continue;
> +			}
> +
> +			/* Attribute(s): tag:value pairs */
> +			while (p < sub_end) {
> +				ret =3D rv_parse_elf_attr_safe(&p, =
p_end);
> +				if (ret)
> +					goto bad_elf;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +bad_elf:
> +	return -ENOEXEC;
> +}
> +
> +/*
> + * Hook invoked by generic elf loader to parse riscv specific elf =
segments.
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

