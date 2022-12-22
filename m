Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DC653F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbiLVLcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLVLca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:32:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14EAFCE8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:32:28 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h7so1325695wrs.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEBXIVv6fCp4z/FuVvmnezyiGO3AyeOyzQjufsBFPog=;
        b=2kH9njlvUa/elKLsltn//dyasR/vxrrmlbUBxFky5vZb6aF6QNSfck6qqs38Ue8+C9
         YQKPvvDhkVD0boUL4ghrJvZGH0xkmGVyd71QL6IfFM3uh05B/xRzcF9Nc1xwKRBOdk7t
         Zf1qDDdtKVln6KN5MGdftF3dvCLv28bPJwQ84MUDsPGnhmKEwrGe+n0fk7X4CKLh4Aex
         GcaSSbHnxe6DJRAEnV0yIgaroH521P91Zety8dM+SNeV7aeOTr4G2Ojub20HHT9B8x2c
         7pAD8yJuAmOdPgSt+3PAxp9QHi3zhKgCzjgulrOsV7IJ16w86sRMjwF0AYzwg31iiXw3
         lFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEBXIVv6fCp4z/FuVvmnezyiGO3AyeOyzQjufsBFPog=;
        b=t0ubc+TpQUr5KMwO3R4qdk7krdra3Uzlyvx45KGNvUUIHaLABaOXJol1GOv2Vxtj2K
         pUwy9qC3cK2nvjBqKYvBYvZomudPgwjpo2X2vRcBQyqXsh6ew9ktbShcvvlv4Wwwhrs/
         44Hzsn7BNRFrClbiiZTHOKtozvmhmcwZ2ta4aK8PfKCfZFF+4/7cV8nxwRFszI9A3jOx
         ibdkmbvfBy4Bwuc2/+yq0oxHcHqq5Eqpjd1b5Vo4yMCX/+KFHvP0YyVDYLQGLUZYoLj+
         c24ZnHYOQm7uaUpmGZwkDo/61nO0AUI3O5SZhUNMw8t5fV7Wi4P2T2lzZ7/Ig1h6+4OS
         v/6g==
X-Gm-Message-State: AFqh2kr9EWmG+8wYpD4x3e9eB9cc96NEOBjMij/hl+UKHcPVMC7mWyqb
        qk1jqJ1ihvXfJAehQDeZ2a0t2ByfZTiLW8M6Uu11qA==
X-Google-Smtp-Source: AMrXdXvc7/hBeBfs8lCbhqeTwY/tXfbfyO1xmyVSQBOvOwFWfTC5nAWb7HODyBWtcPmbRBZQKXO3SAVaY6eHQ4fwWq0=
X-Received: by 2002:adf:ce82:0:b0:242:122c:6672 with SMTP id
 r2-20020adfce82000000b00242122c6672mr174863wrn.330.1671708747522; Thu, 22 Dec
 2022 03:32:27 -0800 (PST)
MIME-Version: 1.0
References: <20221215081948.1256610-1-alexghiti@rivosinc.com> <Y6OIQ1OzjWRkYxHH@spud>
In-Reply-To: <Y6OIQ1OzjWRkYxHH@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 22 Dec 2022 12:32:16 +0100
Message-ID: <CAHVXubiyQ59GtVxryta=jMisS+fVA+ZiBgmMn+i-zjLsYh-H+w@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Allow to downgrade paging mode from the command line
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Wed, Dec 21, 2022 at 11:27 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Alex,
>
> On Thu, Dec 15, 2022 at 09:19:48AM +0100, Alexandre Ghiti wrote:
> > Add 2 early command line parameters called "no5lvl" and "no4lvl" (using
> > the same naming as x86) to allow a user to downgrade from sv57 (the
> > default mode if the hardware supports it) to sv48 or sv39.
>
> Pardon my innocence here, but does the "no4lvl" option not also allow
> downgrading from sv48 to sv39? If that's the case, I assume the message
> could be amended on application.

Yes it does, it actually sets satp_mode to sv39, I'll massage the
commit log in the v3 (if I need one for your comments below).

>
> > Note that going through the device tree to get the kernel command line
> > works with ACPI too since the efi stub creates a device tree anyway wit=
h
> > the command line.
> >
> > Also, as those params are treated very early in the boot process and we
> > use standard device tree functions that may be kasan instrumented, we
> > only enable them for !KASAN configurations.
>
> I don't have a suggestion for you, so I am just airing my thoughts
> really - are we likely to end up confusing people as it's not
> immediately obvious that these options do not work if KASAN is enabled?
> I know KASAN really isn't something you want in a production kernel,
> but should we be flagging the incompatibility somewhere that "users"
> would see?
> kernel-parameters.txt does usually seem to mention config options where
> relevant, and in the case of iommu.strict also mentions some arch
> specific behaviour. Should we mention it there then?

That's indeed a 'weird' restriction that we should mention, I'll see
if that can be done here, thanks.
Also note that I think there is something wrong with kasan outline
code generation that makes it fail to work whereas IMO it should, I'm
currently looking into this.

Thanks for your comments, always helpful,

Alex

>
> Thanks,
> Conor.
>
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >
> > v2:
> > - Honor CMDLINE_EXTEND and CMDLINE_FORCE as noticed by Bj=C3=B6rn
> >
> >  .../admin-guide/kernel-parameters.txt         |  5 +-
> >  arch/riscv/mm/init.c                          | 72 +++++++++++++++++--
> >  2 files changed, 70 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index a465d5242774..6741524aa980 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3548,7 +3548,10 @@
> >                       emulation library even if a 387 maths coprocessor
> >                       is present.
> >
> > -     no5lvl          [X86-64] Disable 5-level paging mode. Forces
> > +     no4lvl          [RISCV] Disable 4-level paging mode. Forces
> > +                     kernel to use 3-level paging instead.
> > +
> > +     no5lvl          [X86-64,RISCV] Disable 5-level paging mode. Force=
s
> >                       kernel to use 4-level paging instead.
> >
> >       nofsgsbase      [X86] Disables FSGSBASE instructions.
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index b56a0a75533f..d90fbe9ad494 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -746,17 +746,77 @@ static void __init disable_pgtable_l4(void)
> >       satp_mode =3D SATP_MODE_39;
> >  }
> >
> > +#ifndef CONFIG_KASAN
> > +static __init bool match_noXlvl(const char *cmdline)
> > +{
> > +     if (strstr(cmdline, "no5lvl")) {
> > +             disable_pgtable_l5();
> > +     } else if (strstr(cmdline, "no4lvl")) {
> > +             disable_pgtable_l5();
> > +             disable_pgtable_l4();
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static int __init print_no4lvl(char *p)
> > +{
> > +     pr_info("Disabled 4-level and 5-level paging");
> > +     return 0;
> > +}
> > +early_param("no4lvl", print_no4lvl);
> > +
> > +static int __init print_no5lvl(char *p)
> > +{
> > +     pr_info("Disabled 5-level paging");
> > +     return 0;
> > +}
> > +early_param("no5lvl", print_no5lvl);
> > +#endif
> > +
> >  /*
> >   * There is a simple way to determine if 4-level is supported by the
> >   * underlying hardware: establish 1:1 mapping in 4-level page table mo=
de
> >   * then read SATP to see if the configuration was taken into account
> >   * meaning sv48 is supported.
> >   */
> > -static __init void set_satp_mode(void)
> > +static __init void set_satp_mode(uintptr_t dtb_pa)
> >  {
> >       u64 identity_satp, hw_satp;
> >       uintptr_t set_satp_mode_pmd =3D ((unsigned long)set_satp_mode) & =
PMD_MASK;
> > -     bool check_l4 =3D false;
> > +
> > +#ifndef CONFIG_KASAN
> > +     /*
> > +      * The below fdt functions are kasan instrumented, since at this =
point
> > +      * there is no mapping for the kasan shadow memory, this can't be=
 used
> > +      * when kasan is enabled.
> > +      */
> > +     int chosen_node;
> > +     unsigned int fdt_cmdline_size =3D 0;
> > +
> > +     if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
> > +             chosen_node =3D fdt_path_offset((void *)dtb_pa, "/chosen"=
);
> > +             if (chosen_node >=3D 0) {
> > +                     const char *fdt_cmdline;
> > +
> > +                     fdt_cmdline =3D fdt_getprop((void *)dtb_pa, chose=
n_node,
> > +                                               "bootargs", NULL);
> > +                     if (fdt_cmdline) {
> > +                             if (match_noXlvl(fdt_cmdline))
> > +                                     return;
> > +                             fdt_cmdline_size =3D strlen(fdt_cmdline);
> > +                     }
> > +             }
> > +     }
> > +
> > +     if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
> > +         IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
> > +         fdt_cmdline_size =3D=3D 0 /* CONFIG_CMDLINE_FALLBACK */) {
> > +             if (match_noXlvl(CONFIG_CMDLINE))
> > +                     return;
> > +     }
> > +#endif
> >
> >       create_p4d_mapping(early_p4d,
> >                       set_satp_mode_pmd, (uintptr_t)early_pud,
> > @@ -775,7 +835,8 @@ static __init void set_satp_mode(void)
> >  retry:
> >       create_pgd_mapping(early_pg_dir,
> >                          set_satp_mode_pmd,
> > -                        check_l4 ? (uintptr_t)early_pud : (uintptr_t)e=
arly_p4d,
> > +                        pgtable_l5_enabled ?
> > +                             (uintptr_t)early_p4d : (uintptr_t)early_p=
ud,
> >                          PGDIR_SIZE, PAGE_TABLE);
> >
> >       identity_satp =3D PFN_DOWN((uintptr_t)&early_pg_dir) | satp_mode;
> > @@ -786,9 +847,8 @@ static __init void set_satp_mode(void)
> >       local_flush_tlb_all();
> >
> >       if (hw_satp !=3D identity_satp) {
> > -             if (!check_l4) {
> > +             if (pgtable_l5_enabled) {
> >                       disable_pgtable_l5();
> > -                     check_l4 =3D true;
> >                       memset(early_pg_dir, 0, PAGE_SIZE);
> >                       goto retry;
> >               }
> > @@ -979,7 +1039,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >  #endif
> >
> >  #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
> > -     set_satp_mode();
> > +     set_satp_mode(dtb_pa);
> >  #endif
> >
> >       kernel_map.va_pa_offset =3D PAGE_OFFSET - kernel_map.phys_addr;
> > --
> > 2.37.2
> >
> >
