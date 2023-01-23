Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273DC677A19
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjAWL0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjAWL03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:26:29 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29A23325
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:26:26 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v13so14131263eda.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dk7P1QywQbNtE+0rDcvLNJKuu1z/a4RDBN+E+f0/ZKk=;
        b=ykJIcBW1BPhT7BdB05U5sx4es1cetVd+5BV+Nl5e/thVZrQ+telAAL9W6z2C/UPbl1
         2nMpDhquQVAhmfkUTyJL+YYZDzSIBfwHa2WJvLWSNz1Psd2Dn4StVvenvcnbI6ncTHiJ
         odfXF4m/F7DXPbIC+A02c8V3i2czi3Zkg4s4JatICzDLl2XFKRh1Z6suSeHpdAjSqfJy
         DXrs3PfEuG+KBix4JVSQ7phfR9a9AnDHeG/1LGYpYjMi2c8vYyvk/qyAl32k6YfHKz1g
         JfVHkBpUuPkUD504Yp5UtUnMlV+dI9Q86TEjxNufqAEWIt6zNWnOsgeFIiVtvxQXxQT0
         HUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dk7P1QywQbNtE+0rDcvLNJKuu1z/a4RDBN+E+f0/ZKk=;
        b=XR13nU5ifP4XfLOx/itoc6IVcIYxje4ih6bzIshUvUjsoNOJ0spuUFdAWu9sEItEAM
         TAQLCaBcAERy4FC28LIy1/EQkkbiIY4Wov/lFmg8Zgf18FV37+gWYwssHSf3szokyygi
         51vpc+gcyc0kUXbP+vBbwDit84enGeRKh2QyQF8wm+VUi2izKgY6q1/fxw4BNaMLee2H
         NVOe3K0ubxMnGlV2y+FH4Y3UeOiAmEHR3z6DnJqWcTId44SkXzZ+STZOQIfG7nXJvjet
         IbzO46vEXTBj8K3ZFpeWWDJmTy9BLnDEQjAuy1njLI/rHB2wprByF7wi4tyVJcISurgu
         cCmg==
X-Gm-Message-State: AFqh2kqlJdg8xzZdLZyFa4YyqiJj66gzIibttaYfyw+v64noieIQY10m
        GDrILik9AraF4HTGiqHOpoG6hy74h/dQF1S2zNTqgg==
X-Google-Smtp-Source: AMrXdXtabGh5wECrTafgVLlqDXQs/X9TenE+zk3v7B0YePpSATv2Dras3vg5zb0Ma+fkrMCOuSq1IPHIB28ZUIiKyLY=
X-Received: by 2002:aa7:c659:0:b0:48e:c2a8:d395 with SMTP id
 z25-20020aa7c659000000b0048ec2a8d395mr2718527edr.76.1674473185160; Mon, 23
 Jan 2023 03:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20230123105135.814154-1-alexghiti@rivosinc.com>
In-Reply-To: <20230123105135.814154-1-alexghiti@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 23 Jan 2023 16:56:14 +0530
Message-ID: <CAAhSdy06M8cP+mfvgHPMfEO8r0tO3C4YEJ80sTp2w4F1X75aTA@mail.gmail.com>
Subject: Re: [PATCH resend v3] riscv: Allow to downgrade paging mode from the
 command line
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 4:21 PM Alexandre Ghiti <alexghiti@rivosinc.com> wr=
ote:
>
> Add 2 early command line parameters that allow to downgrade satp mode
> (using the same naming as x86):
> - "no5lvl": use a 4-level page table (down from sv57 to sv48)
> - "no4lvl": use a 3-level page table (down from sv57/sv48 to sv39)
>
> Note that going through the device tree to get the kernel command line
> works with ACPI too since the efi stub creates a device tree anyway with
> the command line.
>
> Also, as those params are treated very early in the boot process and we
> use standard device tree functions that may be kasan instrumented, we
> only enable them for !KASAN configurations.
>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>
> v3:
> - Massage commit log to make no4lvl clearer, as asked by Conor
> - Add a note to kernel-parameters.txt regarding the impossibility to use
>   those parameters when KASAN is enabled, as suggested by Conor
> - Add RB from Bj=C3=B6rn
>
> v2:
> - Honor CMDLINE_EXTEND and CMDLINE_FORCE as noticed by Bj=C3=B6rn
>
>  .../admin-guide/kernel-parameters.txt         |  9 ++-
>  arch/riscv/mm/init.c                          | 72 +++++++++++++++++--
>  2 files changed, 74 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..fd647412ec91 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3578,8 +3578,15 @@
>                         emulation library even if a 387 maths coprocessor
>                         is present.
>
> -       no5lvl          [X86-64] Disable 5-level paging mode. Forces
> +       no4lvl          [RISCV] Disable 4-level and 5-level paging modes.=
 Forces
> +                       kernel to use 3-level paging instead.
> +                       Note: On RISC-V, this can't be used when KASAN is
> +                       enabled.
> +
> +       no5lvl          [X86-64,RISCV] Disable 5-level paging mode. Force=
s
>                         kernel to use 4-level paging instead.
> +                       Note: On RISC-V, this can't be used when KASAN is
> +                       enabled.
>
>         nofsgsbase      [X86] Disables FSGSBASE instructions.
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 478d6763a01a..10f99fa74368 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -746,17 +746,77 @@ static void __init disable_pgtable_l4(void)
>         satp_mode =3D SATP_MODE_39;
>  }
>
> +#ifndef CONFIG_KASAN
> +static __init bool match_noXlvl(const char *cmdline)
> +{
> +       if (strstr(cmdline, "no5lvl")) {
> +               disable_pgtable_l5();
> +       } else if (strstr(cmdline, "no4lvl")) {
> +               disable_pgtable_l5();
> +               disable_pgtable_l4();
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static int __init print_no4lvl(char *p)
> +{
> +       pr_info("Disabled 4-level and 5-level paging");
> +       return 0;
> +}
> +early_param("no4lvl", print_no4lvl);
> +
> +static int __init print_no5lvl(char *p)
> +{
> +       pr_info("Disabled 5-level paging");
> +       return 0;
> +}
> +early_param("no5lvl", print_no5lvl);
> +#endif
> +
>  /*
>   * There is a simple way to determine if 4-level is supported by the
>   * underlying hardware: establish 1:1 mapping in 4-level page table mode
>   * then read SATP to see if the configuration was taken into account
>   * meaning sv48 is supported.
>   */
> -static __init void set_satp_mode(void)
> +static __init void set_satp_mode(uintptr_t dtb_pa)
>  {
>         u64 identity_satp, hw_satp;
>         uintptr_t set_satp_mode_pmd =3D ((unsigned long)set_satp_mode) & =
PMD_MASK;
> -       bool check_l4 =3D false;
> +
> +#ifndef CONFIG_KASAN
> +       /*
> +        * The below fdt functions are kasan instrumented, since at this =
point
> +        * there is no mapping for the kasan shadow memory, this can't be=
 used
> +        * when kasan is enabled.
> +        */
> +       int chosen_node;
> +       unsigned int fdt_cmdline_size =3D 0;
> +
> +       if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
> +               chosen_node =3D fdt_path_offset((void *)dtb_pa, "/chosen"=
);
> +               if (chosen_node >=3D 0) {
> +                       const char *fdt_cmdline;
> +
> +                       fdt_cmdline =3D fdt_getprop((void *)dtb_pa, chose=
n_node,
> +                                                 "bootargs", NULL);
> +                       if (fdt_cmdline) {
> +                               if (match_noXlvl(fdt_cmdline))
> +                                       return;
> +                               fdt_cmdline_size =3D strlen(fdt_cmdline);
> +                       }
> +               }
> +       }
> +
> +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
> +           IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
> +           fdt_cmdline_size =3D=3D 0 /* CONFIG_CMDLINE_FALLBACK */) {
> +               if (match_noXlvl(CONFIG_CMDLINE))
> +                       return;
> +       }
> +#endif
>
>         create_p4d_mapping(early_p4d,
>                         set_satp_mode_pmd, (uintptr_t)early_pud,
> @@ -775,7 +835,8 @@ static __init void set_satp_mode(void)
>  retry:
>         create_pgd_mapping(early_pg_dir,
>                            set_satp_mode_pmd,
> -                          check_l4 ? (uintptr_t)early_pud : (uintptr_t)e=
arly_p4d,
> +                          pgtable_l5_enabled ?
> +                               (uintptr_t)early_p4d : (uintptr_t)early_p=
ud,
>                            PGDIR_SIZE, PAGE_TABLE);
>
>         identity_satp =3D PFN_DOWN((uintptr_t)&early_pg_dir) | satp_mode;
> @@ -786,9 +847,8 @@ static __init void set_satp_mode(void)
>         local_flush_tlb_all();
>
>         if (hw_satp !=3D identity_satp) {
> -               if (!check_l4) {
> +               if (pgtable_l5_enabled) {
>                         disable_pgtable_l5();
> -                       check_l4 =3D true;
>                         memset(early_pg_dir, 0, PAGE_SIZE);
>                         goto retry;
>                 }
> @@ -979,7 +1039,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  #endif
>
>  #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
> -       set_satp_mode();
> +       set_satp_mode(dtb_pa);
>  #endif
>
>         kernel_map.va_pa_offset =3D PAGE_OFFSET - kernel_map.phys_addr;
> --
> 2.37.2
>
