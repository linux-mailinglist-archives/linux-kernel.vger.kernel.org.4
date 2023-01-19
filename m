Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC81674386
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjASUdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjASUdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:33:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0719D281
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:33:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so4394358wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdAmmI4ICU23WOdVeFQ7NCjQPDE/J3h/f1BUSvBcAXE=;
        b=R+o/6hgBBsFtOS3mqmnLYi15eDHL+Tsq5cSNZEJIOo2B3Jeaj5xYReMXybzBF4j7cc
         Qyl2DM3OCY4gclLzqLwXwQ11CbMqUOA8KUPTt012J4EblvzR6G2ORunDMHbX7kvHZUup
         h4cexaBkE9gNj9kjyxQUzMI+tPGxqHS9XRIK6lWsQh8ebvDSuCfJ+uZ6y7pFbixe4PNq
         OLUTUpgXk3O8190ELiOKEM6h1gJD01O0R24yeiHsEiqA29Huq0Z5rfmFclLh1NX5kwpG
         ZTGf78K4JnXH7DX4dvgk3vqeagMUm7JtSfSwSCuT0eGdhykJIr+lqf4HhrnmQwwcLVh5
         sv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdAmmI4ICU23WOdVeFQ7NCjQPDE/J3h/f1BUSvBcAXE=;
        b=R2HXnP8dM4VBGV6JIfYqnHHd6moHsu3YbvYvDgDX8Lf+gk6p6Gnd3t0Tc7l3eNbQU9
         XodraftfdxRLU7GBhikChowXRLmhPnKPC8qczd6Ei2rQLoTGogMgK/Vtkc9e9+GIKzuV
         yoo39XyIPsdBzcKL8r+pH38Z35LbZX+bNMwY4K2b7R12ppb4ABofjEv2c/oYtxGiQPMb
         h1r4XVNZVC4sUbBDNxFRs2HVmXlAJcthf1hc0ufmHT2ULpbnBdJ/MjO/ZbyNB4i8E1NF
         QRevp8ewNBaY9kxwMpMaxKPOSkhR7/KAjl3a8PHxGuvrzLsAyH61JvbGltiF8NCedY7o
         hoKg==
X-Gm-Message-State: AFqh2kqPTNMLWDklHpmfzfjR10YDMuPIKJ1/VmLAOXvdB2UOJGvwVogx
        3MeNzNPlBK+qcbcSx65At7lDuA==
X-Google-Smtp-Source: AMrXdXvzjL7PZC3ZEP3K0Xkd1bKVuFFxNGujLB+SfwP1KYwyVvGl6HvOKDY+9fqUjQqXgYqgaCiy0A==
X-Received: by 2002:a05:600c:6001:b0:3da:f80a:5e85 with SMTP id az1-20020a05600c600100b003daf80a5e85mr11365781wmb.26.1674160424289;
        Thu, 19 Jan 2023 12:33:44 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id z7-20020a1c4c07000000b003d9a86a13bfsm171434wmf.28.2023.01.19.12.33.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2023 12:33:43 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v3] riscv: elf: add .riscv.attributes parsing
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230119174357.3550008-1-vineetg@rivosinc.com>
Date:   Thu, 19 Jan 2023 20:33:43 +0000
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB6B06BB-C65F-41C2-8D9F-F916F3A706FA@jrtc27.com>
References: <c2177e4e-e97d-448a-73e7-c50622fdc4bb@rivosinc.com>
 <20230119174357.3550008-1-vineetg@rivosinc.com>
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

On 19 Jan 2023, at 17:43, Vineet Gupta <vineetg@rivosinc.com> wrote:
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
> Changes since v2 [2]
>  - Address Jessica's review comments.
>    Mostly robustify code some more, checking for end of buffer etc.
>=20
> Changes since v1 [1]
>  - Handling potential oob accesses due to against malformed elf =
contents
>  - Handling of multiple sub-subsections
>=20
> =
[1]https://lore.kernel.org/linux-riscv/20230110201841.2069353-1-vineetg@ri=
vosinc.com
> =
[2]https://lore.kernel.org/linux-riscv/20230112210622.2337254-1-vineetg@ri=
vosinc.com
>=20
> Given the current state of discussions, the intended Vector extension
> support would likely not need it, still posting the reworked v3 for
> logical conclusion and for posterity in case need comes up in future
> for something like CFI elf annotation.
> Maintainers/reviewers can decide whether to merge it.
> ---
> arch/riscv/Kconfig           |   1 +
> arch/riscv/include/asm/elf.h |  11 ++
> arch/riscv/kernel/Makefile   |   1 +
> arch/riscv/kernel/elf-attr.c | 239 +++++++++++++++++++++++++++++++++++
> 4 files changed, 252 insertions(+)
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
> index 000000000000..8df8f2eea42b
> --- /dev/null
> +++ b/arch/riscv/kernel/elf-attr.c
> @@ -0,0 +1,239 @@
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
> +static void rv_elf_attr_int(u64 tag, u64 val)
> +{
> +	pr_debug("Tag %llx=3D%llx\n", tag, val);
> +}
> +
> +static void rv_elf_attr_str(u64 tag, const unsigned char *str)
> +{
> +	pr_debug("Tag %llx=3D[%s]\n", tag, str);
> +}
> +
> +/*
> + * Decode a ule128 encoded value.
> + */
> +static int
> +decode_uleb128_safe(unsigned char **dpp, u64 *val, const unsigned =
char *p_end)
> +{
> +	unsigned char *bp =3D *dpp;
> +	unsigned char byte;
> +	unsigned int shift =3D 0;
> +	u64 result =3D 0;
> +
> +	while (bp < p_end) {
> +		byte =3D *bp++;
> +		result |=3D (byte & 0x7f) << shift;
> +		if ((byte & 0x80) =3D=3D 0) {
> +			*dpp =3D bp;
> +			*val =3D result;
> +			return 0;
> +		}
> +		shift +=3D 7;
> +	}
> +
> +	return -1;
> +}
> +
> +#define ELF_ATTR_TAG_EVEN(t)	(((t) % 2) ? false : true)

I don=E2=80=99t think you need a macro for "unsigned integer is even".

> +
> +/*
> + * Parse a single elf attribute.
> + */
> +static int rv_parse_elf_attr_safe(unsigned char **dpp, unsigned char =
*p_end)
> +{
> +	unsigned char *p =3D *dpp;
> +	unsigned char *str;
> +	u64 tag, val;
> +	u32 s_len;
> +
> +	if (decode_uleb128_safe(&p, &tag, p_end))
> +		goto bad_attr;
> +
> +	switch (tag) {
> +	case RV_ATTR_TAG_stack_align:
> +		if (decode_uleb128_safe(&p, &val, p_end))
> +			goto bad_attr;
> +		if (!ELF_ATTR_TAG_EVEN(tag))
> +			goto bad_attr;

Huh? You just checked it against a constant so you know exactly what it
is. This is just Static_assert(RV_ATTR_TAG_stack_align % 2 =3D=3D 0) but =
at
run time. And you know that=E2=80=99s going to be the case, because the =
spec is
self-consistent by design (wouldn=E2=80=99t be a worthwhile spec =
otherwise).

> +		rv_elf_attr_int(tag, val);
> +		break;
> +
> +	case RV_ATTR_TAG_unaligned_access:
> +		if (decode_uleb128_safe(&p, &val, p_end))
> +			goto bad_attr;
> +		if (!ELF_ATTR_TAG_EVEN(tag))
> +			goto bad_attr;
> +		rv_elf_attr_int(tag, val);
> +		break;
> +
> +	case RV_ATTR_TAG_arch:
> +		if (ELF_ATTR_TAG_EVEN(tag))
> +			goto bad_attr;
> +		str =3D p;
> +		s_len =3D strnlen(p, p_end - p) + 1;
> +		if ((p + s_len) > p_end)
> +			goto bad_attr;
> +		p +=3D s_len;
> +		rv_elf_attr_str(tag, str);
> +		break;
> +
> +	default:

The whole point of the even/odd split is so that when you *don=E2=80=99t* =
know
what the tag means you can still decode its value and thus know how to
skip past it. That is, *here* is where you need to be checking
even/odd, and deciding whether to treat it as a string or a ULEB128,
which is why I annotated *here* not one of the other case labels before.

> +		if (decode_uleb128_safe(&p, &val, p_end))
> +			goto bad_attr;
> +		pr_debug("skipping Unrecognized Tag [%llx]=3D%llx\n", =
tag, val);
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
> +	pos =3D phdr->p_offset;
> +	n =3D kernel_read(f, &buf, phdr->p_filesz, &pos);
> +
> +	if (n <=3D 0)
> +		return -EIO;

0 should be ENOEXEC not EIO? And surely in the < 0 case you want to be
forwarding on the exact error from kernel_read, not squashing it into
EIO?

> +
> +	p =3D buf;
> +	p_end =3D p + n;
> +
> +	/* sanity check format-version */
> +	if (*p++ !=3D 'A')
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
> +		u32 sub_len, vname_len;
> +
> +		sub_len =3D get_unaligned_le32(p);
> +		if (sub_len <=3D 4 || sub_len > (p_end - p))
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
> +			unsigned char *p_ss_end, *p_ss_start =3D p;
> +			u32 ss_len;
> +			u64 tag;
> +
> +			if (decode_uleb128_safe(&p, &tag, p_end))
> +				goto bad_elf;
> +
> +			if ((p_end - p) < 4)
> +				goto bad_elf;
> +
> +			ss_len =3D get_unaligned_le32(p);
> +			if (ss_len > sub_len)
> +				goto bad_elf;
> +
> +			p +=3D 4;
> +			sub_len -=3D ss_len;
> +			p_ss_end =3D p_ss_start + ss_len;
> +
> +			/* For now handle attributes relating to whole =
file */
> +			if (tag !=3D RV_ATTR_TAG_file) {
> +				p =3D p_ss_end;
> +				continue;
> +			}
> +
> +			/* Attribute(s): tag:value pairs */
> +			while (p < p_ss_end) {
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

Both the executable and its interpreter matter.

Jess

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

