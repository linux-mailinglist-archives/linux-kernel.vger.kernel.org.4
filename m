Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088CA7247F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjFFPj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjFFPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:39:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FA1100
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2ABB62AD8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13140C433A0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686065964;
        bh=ovUux+gNZ6WkiYRvYoozBQRwom9AqZCGCUzsFPEjJWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rUx0U2s4MssWRmGdM+grxj/QNy6gaLkS91hFr71N99INNbwD3FprmUkm/4CgIur5H
         3DripYqFRhg+imLMn1vAkFGBue8Ckr3efA9zRgpEM3mMoPWZHkkMkMVtjGMvxqKnNK
         VLgNIKOpq1zT273ikM+DjVfo8zkI1+6KJ3eMIzLrF8ruVPW8wJ/4rFCcPPJpk76egI
         V84K3r2yZEtdxoukJHfMB7y8xftqMeyIldl9HkL92bNWdLfzez9jPZDs77d4z3C4Dz
         7/iSZlIJnQPHCrug7cVnb2GcG0M7EoKckw+ShIUg3b/T0uxspLW+smq0oYP3vYK+xH
         2lm70QJ3iIhhw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b1bdfe51f8so39824691fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 08:39:23 -0700 (PDT)
X-Gm-Message-State: AC+VfDymEaE4WzxzQ+4fUM6ic9Fuwa29c8mZOPAJjeWK/uOtHhtg+3Qp
        lXx8sWsYbk5vEIHDSaiZ4Ir1g1kM5/+XdVlYdQ8=
X-Google-Smtp-Source: ACHHUZ7e7+hApTXimnjkd0SmnT/bYyxIY+uQub2q4K9KPxUu4KpyHpywzkgVbCGqJHdwKsogZ1q45/oZP5yOA7t9XlI=
X-Received: by 2002:a05:651c:2318:b0:2b1:c149:6e6b with SMTP id
 bi24-20020a05651c231800b002b1c1496e6bmr2808812ljb.15.1686065961995; Tue, 06
 Jun 2023 08:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <cover.1686063086.git.thomas.lendacky@amd.com> <0d5f3d9a20b5cf361945b7ab1263c36586a78a42.1686063086.git.thomas.lendacky@amd.com>
In-Reply-To: <0d5f3d9a20b5cf361945b7ab1263c36586a78a42.1686063086.git.thomas.lendacky@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 6 Jun 2023 17:39:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEiS26Ax884Ta7Gfknu_VDaY=fjVScGq93sfS6GO3kHyQ@mail.gmail.com>
Message-ID: <CAMj1kXEiS26Ax884Ta7Gfknu_VDaY=fjVScGq93sfS6GO3kHyQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] x86/efi: Safely enable unaccepted memory in UEFI
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 at 16:52, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> From: Dionna Glaze <dionnaglaze@google.com>
>
> The UEFI v2.9 specification includes a new memory type to be used in
> environments where the OS must accept memory that is provided from its
> host. Before the introduction of this memory type, all memory was
> accepted eagerly in the firmware. In order for the firmware to safely
> stop accepting memory on the OS's behalf, the OS must affirmatively
> indicate support to the firmware. This is only a problem for AMD
> SEV-SNP, since Linux has had support for it since 5.19. The other
> technology that can make use of unaccepted memory, Intel TDX, does not
> yet have Linux support, so it can strictly require unaccepted memory
> support as a dependency of CONFIG_TDX and not require communication with
> the firmware.
>
> Enabling unaccepted memory requires calling a 0-argument enablement
> protocol before ExitBootServices. This call is only made if the kernel
> is compiled with UNACCEPTED_MEMORY=y
>
> This protocol will be removed after the end of life of the first LTS
> that includes it, in order to give firmware implementations an
> expiration date for it. When the protocol is removed, firmware will
> strictly infer that a SEV-SNP VM is running an OS that supports the
> unaccepted memory type. At the earliest convenience, when unaccepted
> memory support is added to Linux, SEV-SNP may take strict dependence in
> it. After the firmware removes support for the protocol, this patch
> should be reverted.
>
>   [tl: address some checkscript warnings]
>
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 36 +++++++++++++++++++++++++
>  include/linux/efi.h                     |  3 +++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 8d17cee8b98e..e2193dbe1f66 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -26,6 +26,17 @@ const efi_dxe_services_table_t *efi_dxe_table;
>  u32 image_offset __section(".data");
>  static efi_loaded_image_t *image = NULL;
>
> +typedef union sev_memory_acceptance_protocol sev_memory_acceptance_protocol_t;
> +union sev_memory_acceptance_protocol {
> +       struct {
> +               efi_status_t (__efiapi * allow_unaccepted_memory)(
> +                       sev_memory_acceptance_protocol_t *);
> +       };
> +       struct {
> +               u32 allow_unaccepted_memory;
> +       } mixed_mode;
> +};
> +
>  static efi_status_t
>  preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
>  {
> @@ -310,6 +321,29 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
>  #endif
>  }
>
> +static void setup_unaccepted_memory(void)
> +{
> +       efi_guid_t mem_acceptance_proto = OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID;
> +       sev_memory_acceptance_protocol_t *proto;
> +       efi_status_t status;
> +
> +       if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> +               return;
> +
> +       /*
> +        * Enable unaccepted memory before calling exit boot services in order
> +        * for the UEFI to not accept all memory on EBS.
> +        */
> +       status = efi_bs_call(locate_protocol, &mem_acceptance_proto, NULL,
> +                            (void **)&proto);
> +       if (status != EFI_SUCCESS)
> +               return;
> +
> +       status = efi_call_proto(proto, allow_unaccepted_memory);
> +       if (status != EFI_SUCCESS)
> +               efi_err("Memory acceptance protocol failed\n");
> +}
> +
>  static const efi_char16_t apple[] = L"Apple";
>
>  static void setup_quirks(struct boot_params *boot_params,
> @@ -908,6 +942,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>
>         setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
>
> +       setup_unaccepted_memory();
> +
>         status = exit_boot(boot_params, handle);
>         if (status != EFI_SUCCESS) {
>                 efi_err("exit_boot() failed!\n");
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 9864f9c00da2..8c5abcf70a05 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -437,6 +437,9 @@ void efi_native_runtime_setup(void);
>  #define DELLEMC_EFI_RCI2_TABLE_GUID            EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
>  #define AMD_SEV_MEM_ENCRYPT_GUID               EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
>
> +/* OVMF protocol GUIDs */
> +#define OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID       EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
> +
>  typedef struct {
>         efi_guid_t guid;
>         u64 table;
> --
> 2.40.1
>
