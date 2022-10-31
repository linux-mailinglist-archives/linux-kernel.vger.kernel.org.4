Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E45D613F09
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJaUb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJaUb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:31:27 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415FA5F8B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:31:26 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 29VKV6hV4048573
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 31 Oct 2022 13:31:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 29VKV6hV4048573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1667248267;
        bh=c263VmgtVCsjiKviQU513mPxKPOSGRvYwU7SRn3N690=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=slYSL8hW6b7gg8PHtmKIMmEH6VnZfo3Y2C6bI+Tl2bV02F7C1X/tBVdVPhH+lJwud
         zTDWjzPsNPpQdwnEOPBKVmmnWR/KNPb0yUQcJH6Pvr5PErb1V7mCA0/8CylvANTpmO
         gRacemRzNzo0q86XeWkYZcZUtRLXMubFxLiVFE+Ljv40NsKlgfWW7PBBA16cvSixe4
         yIR3grv5Dxqg9RbMg0smShvjJqACWBi9ML1/EkEWbO83gKqK427AAxxXNQvt2vg7Vr
         giobfuxrL3pauwLqcMrosWzB3poDLOdeMeS8AUcg9FRjzua6POkxIeR3QEll/0u9Z1
         sp8fmvNr2WkJw==
Date:   Mon, 31 Oct 2022 13:31:05 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_x86/boot=3A_robustify_calling_?= =?US-ASCII?Q?startup=5F=7B32=2C64=7D=28=29_from_the_decompressor_code?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221031151047.167288-2-alexandr.lobakin@intel.com>
References: <20221031151047.167288-1-alexandr.lobakin@intel.com> <20221031151047.167288-2-alexandr.lobakin@intel.com>
Message-ID: <454A126A-1E27-4A5C-9073-4E72D3D23B5A@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 31, 2022 8:10:46 AM PDT, Alexander Lobakin <alexandr=2Elobakin@i=
ntel=2Ecom> wrote:
>After commit ce697ccee1a8 ("kbuild: remove head-y syntax"), I
>started digging whether x86 is ready from removing this old cruft=2E
>Removing its objects from the list makes the kernel unbootable=2E
>This applies only to bzImage, vmlinux still works correctly=2E
>The reason is that with no strict object order determined by the
>linker arguments, not the linker script, startup_64 can be placed
>not right at the beginning of the kernel=2E
>Here's vmlinux=2Emap's beginning before removing:
>
>ffffffff81000000         vmlinux=2Eo:(=2Ehead=2Etext)
>ffffffff81000000                 startup_64
>ffffffff81000070                 secondary_startup_64
>ffffffff81000075                 secondary_startup_64_no_verify
>ffffffff81000160                 verify_cpu
>
>and after:
>
>ffffffff81000000         vmlinux=2Eo:(=2Ehead=2Etext)
>ffffffff81000000                 pvh_start_xen
>ffffffff81000080                 startup_64
>ffffffff810000f0                 secondary_startup_64
>ffffffff810000f5                 secondary_startup_64_no_verify
>
>Not a problem itself, but the self-extractor code has the address of
>that function hardcoded the beginning, not looking onto the ELF
>header, which always contains the address of startup_{32,64}()=2E
>
>So, instead of doing an "act of blind faith", just take the address
>from the ELF header and extract a relative offset to the entry
>point=2E The decompressor function already returns a pointer to the
>beginning of the kernel to the Asm code, which then jumps to it,
>so add that offset to the return value=2E
>This doesn't change anything for now, but allows to resign from the
>"head object list" for x86 and makes sure valid Kbuild or any other
>improvements won't break anything here in general=2E
>
>Signed-off-by: Alexander Lobakin <alexandr=2Elobakin@intel=2Ecom>
>---
> arch/x86/boot/compressed/head_32=2ES |  2 +-
> arch/x86/boot/compressed/head_64=2ES |  2 +-
> arch/x86/boot/compressed/misc=2Ec    | 16 +++++++++++-----
> 3 files changed, 13 insertions(+), 7 deletions(-)
>
>diff --git a/arch/x86/boot/compressed/head_32=2ES b/arch/x86/boot/compres=
sed/head_32=2ES
>index 3b354eb9516d=2E=2E56f9847e208b 100644
>--- a/arch/x86/boot/compressed/head_32=2ES
>+++ b/arch/x86/boot/compressed/head_32=2ES
>@@ -187,7 +187,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(=2ELrelocated)
> 	leal	boot_heap@GOTOFF(%ebx), %eax
> 	pushl	%eax			/* heap area */
> 	pushl	%esi			/* real mode pointer */
>-	call	extract_kernel		/* returns kernel location in %eax */
>+	call	extract_kernel		/* returns kernel entry point in %eax */
> 	addl	$24, %esp
>=20
> /*
>diff --git a/arch/x86/boot/compressed/head_64=2ES b/arch/x86/boot/compres=
sed/head_64=2ES
>index d33f060900d2=2E=2Eaeba5aa3d26c 100644
>--- a/arch/x86/boot/compressed/head_64=2ES
>+++ b/arch/x86/boot/compressed/head_64=2ES
>@@ -593,7 +593,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(=2ELrelocated)
> 	movl	input_len(%rip), %ecx	/* input_len */
> 	movq	%rbp, %r8		/* output target address */
> 	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
>-	call	extract_kernel		/* returns kernel location in %rax */
>+	call	extract_kernel		/* returns kernel entry point in %rax */
> 	popq	%rsi
>=20
> /*
>diff --git a/arch/x86/boot/compressed/misc=2Ec b/arch/x86/boot/compressed=
/misc=2Ec
>index cf690d8712f4=2E=2E96ae5af29f49 100644
>--- a/arch/x86/boot/compressed/misc=2Ec
>+++ b/arch/x86/boot/compressed/misc=2Ec
>@@ -277,7 +277,7 @@ static inline void handle_relocations(void *output, u=
nsigned long output_len,
> { }
> #endif
>=20
>-static void parse_elf(void *output)
>+static size_t parse_elf(void *output)
> {
> #ifdef CONFIG_X86_64
> 	Elf64_Ehdr ehdr;
>@@ -287,6 +287,7 @@ static void parse_elf(void *output)
> 	Elf32_Phdr *phdrs, *phdr;
> #endif
> 	void *dest;
>+	size_t off;
> 	int i;
>=20
> 	memcpy(&ehdr, output, sizeof(ehdr));
>@@ -295,16 +296,19 @@ static void parse_elf(void *output)
> 	   ehdr=2Ee_ident[EI_MAG2] !=3D ELFMAG2 ||
> 	   ehdr=2Ee_ident[EI_MAG3] !=3D ELFMAG3) {
> 		error("Kernel is not a valid ELF file");
>-		return;
>+		return 0;
> 	}
>=20
> 	debug_putstr("Parsing ELF=2E=2E=2E ");
>=20
> 	phdrs =3D malloc(sizeof(*phdrs) * ehdr=2Ee_phnum);
>-	if (!phdrs)
>+	if (!phdrs) {
> 		error("Failed to allocate space for phdrs");
>+		return 0;
>+	}
>=20
> 	memcpy(phdrs, output + ehdr=2Ee_phoff, sizeof(*phdrs) * ehdr=2Ee_phnum)=
;
>+	off =3D ehdr=2Ee_entry - phdrs->p_paddr;
>=20
> 	for (i =3D 0; i < ehdr=2Ee_phnum; i++) {
> 		phdr =3D &phdrs[i];
>@@ -328,6 +332,7 @@ static void parse_elf(void *output)
> 	}
>=20
> 	free(phdrs);
>+	return off;
> }
>=20
> /*
>@@ -356,6 +361,7 @@ asmlinkage __visible void *extract_kernel(void *rmode=
, memptr heap,
> 	const unsigned long kernel_total_size =3D VO__end - VO__text;
> 	unsigned long virt_addr =3D LOAD_PHYSICAL_ADDR;
> 	unsigned long needed_size;
>+	size_t off;
>=20
> 	/* Retain x86 boot parameters pointer passed from startup_32/64=2E */
> 	boot_params =3D rmode;
>@@ -456,14 +462,14 @@ asmlinkage __visible void *extract_kernel(void *rmo=
de, memptr heap,
> 	debug_putstr("\nDecompressing Linux=2E=2E=2E ");
> 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
> 			NULL, error);
>-	parse_elf(output);
>+	off =3D parse_elf(output);
> 	handle_relocations(output, output_len, virt_addr);
> 	debug_putstr("done=2E\nBooting the kernel=2E\n");
>=20
> 	/* Disable exception handling before booting the kernel */
> 	cleanup_exception_handling();
>=20
>-	return output;
>+	return output + off;
> }
>=20
> void fortify_panic(const char *name)

Put the entry points in dedicated sections and declare them explicitly in =
the linker script (the standard name for this section would be =2Einit, but=
 we presumably want =2Einit=2E32 and =2Einit=2E64 to keep 32- and 64-bit co=
de in separate sections=2E)
