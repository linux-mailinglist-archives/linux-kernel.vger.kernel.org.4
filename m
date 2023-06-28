Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35371740D90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjF1Ju3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:50:29 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:54886 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjF1Jdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:33:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD7E561262;
        Wed, 28 Jun 2023 09:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD18C433CC;
        Wed, 28 Jun 2023 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687944824;
        bh=CrYGMFVkuZ18bbqqXmjfHXjWhRbYeT+J+BKK1daGGTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kOuXnRg1BENhX68oF4wUvOmW/QKYKiFbeB0wy5Ut2FxM4NX35vw0HSBU3KmtU25Oc
         dD2GnXVvObPqkTvkdH7Sm4c9s0P8eZa2vrfUMQlMnJr5eD1rOrOq5Se46/4/K4o6NH
         9UJlVx63Axich432Zg3l3EzUS3KMKanaVvVm3MzNM3uHSJBqv9YnS3FJuQTZWk0b4H
         MHT1zgheuTxilkJYVIJEkC2eKTdTkqy0Wv0g7hLWKSbB63HFEiy+Q2BmVACbpRl7CZ
         SLTLNlty4b8+YHM2M9KQVJxy8R9ZhO+Eqi+ESZ7RRwEDZljTsvl2/JZ/gZn0NZg/Qt
         kVGUOaZzCtibQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51d9865b7bdso3522204a12.1;
        Wed, 28 Jun 2023 02:33:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDzxyxtMBYm5YPkf6KF/9WDRLbGTCxMv+6oaTLuYQzdCJACGIZwi
        aVszGzVDwjDYymf6O8X4TCRKRUxH/htqq8NsXLQ=
X-Google-Smtp-Source: ACHHUZ7bRzRsDllhNLipd/qefy1r65bKvlwuhhM1+DNN01yuN/J3IxfKXTbbm1Hh31Dk7m5G6zYrn7LxlzhxhZiIySE=
X-Received: by 2002:a05:6402:755:b0:51a:4842:ecdc with SMTP id
 p21-20020a056402075500b0051a4842ecdcmr23379907edy.1.1687944823012; Wed, 28
 Jun 2023 02:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230625095644.3156349-1-kernel@xen0n.name> <20230625095644.3156349-2-kernel@xen0n.name>
In-Reply-To: <20230625095644.3156349-2-kernel@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 28 Jun 2023 17:33:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5hBes5R30mFBW7asX8wPWeSQ+J-=GypnoMoO=-CR3cNg@mail.gmail.com>
Message-ID: <CAAhV-H5hBes5R30mFBW7asX8wPWeSQ+J-=GypnoMoO=-CR3cNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] LoongArch: Calculate various sizes in the linker script
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 5:57=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> From: WANG Rui <wangrui@loongson.cn>
>
> Taking the address delta between symbols in different sections is not
> supported by the LLVM IAS. Instead, do this in the linker script, so
> the same data can be properly referenced in assembly.
>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>  arch/loongarch/kernel/efi-header.S  | 6 +++---
>  arch/loongarch/kernel/head.S        | 8 ++++----
>  arch/loongarch/kernel/vmlinux.lds.S | 7 +++++++
>  3 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/arch/loongarch/kernel/efi-header.S b/arch/loongarch/kernel/e=
fi-header.S
> index 8c1d229a2afa..5f23b85d78ca 100644
> --- a/arch/loongarch/kernel/efi-header.S
> +++ b/arch/loongarch/kernel/efi-header.S
> @@ -24,7 +24,7 @@
>         .byte   0x02                                    /* MajorLinkerVer=
sion */
>         .byte   0x14                                    /* MinorLinkerVer=
sion */
>         .long   __inittext_end - .Lefi_header_end       /* SizeOfCode */
> -       .long   _end - __initdata_begin                 /* SizeOfInitiali=
zedData */
> +       .long   _kernel_vsize                           /* SizeOfInitiali=
zedData */
>         .long   0                                       /* SizeOfUninitia=
lizedData */
>         .long   __efistub_efi_pe_entry - _head          /* AddressOfEntry=
Point */
>         .long   .Lefi_header_end - _head                /* BaseOfCode */
> @@ -79,9 +79,9 @@
>                 IMAGE_SCN_MEM_EXECUTE                   /* Characteristic=
s */
>
>         .ascii  ".data\0\0\0"
> -       .long   _end - __initdata_begin                 /* VirtualSize */
> +       .long   _kernel_vsize                           /* VirtualSize */
>         .long   __initdata_begin - _head                /* VirtualAddress=
 */
> -       .long   _edata - __initdata_begin               /* SizeOfRawData =
*/
> +       .long   _kernel_rsize                           /* SizeOfRawData =
*/
>         .long   __initdata_begin - _head                /* PointerToRawDa=
ta */
>
>         .long   0                                       /* PointerToReloc=
ations */
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 0d8180153ec0..53b883db0786 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -23,7 +23,7 @@ _head:
>         .word   MZ_MAGIC                /* "MZ", MS-DOS header */
>         .org    0x8
>         .dword  kernel_entry            /* Kernel entry point */
> -       .dword  _end - _text            /* Kernel image effective size */
> +       .dword  _kernel_asize           /* Kernel image effective size */
>         .quad   PHYS_LINK_KADDR         /* Kernel image load offset from =
start of RAM */
>         .org    0x38                    /* 0x20 ~ 0x37 reserved */
>         .long   LINUX_PE_MAGIC
> @@ -32,9 +32,9 @@ _head:
>  pe_header:
>         __EFI_PE_HEADER
>
> -SYM_DATA(kernel_asize, .long _end - _text);
> -SYM_DATA(kernel_fsize, .long _edata - _text);
> -SYM_DATA(kernel_offset, .long kernel_offset - _text);
> +SYM_DATA(kernel_asize, .long _kernel_asize);
> +SYM_DATA(kernel_fsize, .long _kernel_fsize);
> +SYM_DATA(kernel_offset, .long _kernel_offset);
>
>  #endif
>
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/=
vmlinux.lds.S
> index 0c7b041be9d8..79f238df029e 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -136,6 +136,13 @@ SECTIONS
>         DWARF_DEBUG
>         ELF_DETAILS
>
> +       /* header symbols */
> +       _kernel_asize =3D _end - _text;
> +       _kernel_fsize =3D _edata - _text;
> +       _kernel_offset =3D kernel_offset - _text;
When !CONFIG_EFI_STUB there is a build error, I fixed it when I applied.

Huacai
> +       _kernel_vsize =3D _end - __initdata_begin;
> +       _kernel_rsize =3D _edata - __initdata_begin;
> +
>         .gptab.sdata : {
>                 *(.gptab.data)
>                 *(.gptab.sdata)
> --
> 2.40.0
>
>
