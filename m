Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6120C745749
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjGCIYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGCIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:24:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC122BB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:24:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc0981755so46140705e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688372645; x=1690964645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK9YJK54N6X6KANLQAKaW0JERmC99/mkew38T4D7Txw=;
        b=lCArJJna5LLyOPkgI58sEAU27L0ZiP4Ne872I/FQMplFNqtbW0R8UUGlyOt+Hb+pUn
         zI3WBAPsFMf318AzUzG17RX5zgxwKu/Pp3NgS3zikmLMia/whGzAKLIlOLkbW79G2LEa
         WXcdQxuV+biiJ0O7FVwNbQFPQJgRo9iioM5KrWvOy25xzLW4h3NclGEi5hYtRnEJp+GI
         8O0cspqvGI6GW59oD8b3Siu65v9ACpJ/NncLq88kl1G82AUPgVn3onR0JJc+miY4rhmC
         eQPLC+pXuTzx8bmSJrJrVC9lj2AWVlKwPmuaDp6iFtSZoeF4E4ByzDYvHV9eE9fKW8E6
         trfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688372645; x=1690964645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VK9YJK54N6X6KANLQAKaW0JERmC99/mkew38T4D7Txw=;
        b=HwU0QD01rIUT8aGYpgTvF+SmSE57LG6ww5mWJWa6ewjkWqiLADNVMMCflyDSqhpZ0R
         tsmINkFj0B1TxifhzAk5ABFS5uzgpWrL+uMbqwl0JL5iXdDvhXrh7+ub0gHXLdXD5KjC
         EHJOWUFpjVPrkMsvr/NMIvLGwIVnwOzoEpVtTSSB4XIHvu416afo+xOiuxltJXeDPiR9
         LODSQsvAoyk4dC+Q1Jg/aoiAvOTG4TyEw1isBqnLm/VemLzlkWWGOHGhaHQL7iZheFjP
         mEr4MlHgQyXDAlF8gciBaVCr7lhNrWPJa9Z8hLv/ce83JUtgM0HaI0ikLRdAEsPWpzK4
         aggA==
X-Gm-Message-State: ABy/qLYo4GnZQQALtB7z8HqKfU05/0Ts3kGgAghaKzjXOe0qXpRX3F5r
        q34NrK50HwX6KfWaRtxP2kPU1kvfZkMZxcYfXMvbDA==
X-Google-Smtp-Source: APBJJlF9ZTAYs0T0KFZt84N7iRTPRiRVEXyVf9NJt5DrHvQiO/09D955cqr5PIWdRYhIKMVO7VldzYBOhpO7/9ZSUdA=
X-Received: by 2002:adf:e747:0:b0:314:2f5b:2ce with SMTP id
 c7-20020adfe747000000b003142f5b02cemr4203439wrn.12.1688372645184; Mon, 03 Jul
 2023 01:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230702095735.860-2-cuiyunhui@bytedance.com>
 <20230702-collide-rumor-f0d915a4f1b2@spud>
In-Reply-To: <20230702-collide-rumor-f0d915a4f1b2@spud>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 3 Jul 2023 16:23:53 +0800
Message-ID: <CAEEQ3w=CMSMnYmfprYS4ydsA=EBJtLhQQHWky754EC-iifcYtg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/3] firmware: introduce FFI for SMBIOS entry.
To:     Conor Dooley <conor@kernel.org>
Cc:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,


> nit: please don't write your commit messages as bullet lists
Okay, thanks for your suggestion.

> > +FDT FIRMWARE INTERFACE (FFI)
> > +M:   Yunhui Cui cuiyunhui@bytedance.com
> > +S:   Maintained
> > +F:   drivers/firmware/ffi.c
> > +F:   include/linux/ffi.h
>
> Are you going to apply patches for this, or is someone else?
Yes,  it will be used by patch 3/3.

>
> >  EXTERNAL CONNECTOR SUBSYSTEM (EXTCON)
> >  M:   MyungJoo Ham <myungjoo.ham@samsung.com>
> >  M:   Chanwoo Choi <cw00.choi@samsung.com>
> > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > index b59e3041fd62..ea0149fb4683 100644
> > --- a/drivers/firmware/Kconfig
> > +++ b/drivers/firmware/Kconfig
> > @@ -303,6 +303,17 @@ config TURRIS_MOX_RWTM
> >         other manufacturing data and also utilize the Entropy Bit Gener=
ator
> >         for hardware random number generation.
> >
> > +config FDT_FW_INTERFACE
> > +       bool "An interface for passing firmware info through FDT"
> > +       depends on OF && OF_FLATTREE
> > +       default n
> > +       help
> > +         When some bootloaders do not support EFI, and the arch does n=
ot
> > +         support SMBIOS_ENTRY_POINT_SCAN_START, then you can enable th=
is option
> > +         to support the transfer of firmware information, such as smbi=
os tables.
>
> Could you express this dependency on !SMBIOS_ENTRY_POINT_SCAN_START in
> Kconfig & then simply the text to:
> "Enable this option to support the transfer of firmware information,
> such as smbios tables, for bootloaders that do not support EFI."
> since it would not even appear if the arch supports scanning for the
> entry point?
> If I was was a punter trying to configure my kernel in menuconfig or
> whatever, I should be able to decide based on the help text if I need
> this, not going grepping for #defines in headers.
Okay=EF=BC=8C I'll update on v3.


>
> >  static void __init dmi_scan_machine(void)
> > @@ -660,58 +686,22 @@ static void __init dmi_scan_machine(void)
> >       char __iomem *p, *q;
> >       char buf[32];
> >
> > +#ifdef CONFIG_FDT_FW_INTERFACE
> > +     if (dmi_sacn_smbios(ffi.smbios3, ffi.smbios))
>
> "dmi_sacn_smbios"
>
> > +             goto error;
> > +#endif
>
> Does this not mean that if FDT_FW_INTERFACE is enabled, but the platform
> wants to use EFI, it won't be able to? The `goto error;` makes this look
> mutually exclusive to my efi-unaware eyes.

If you have enabled FFI, then if something goes wrong, you should goto erro=
r.
Just like the origin code:
        if (efi_enabled(EFI_CONFIG_TABLES)) {
                if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
                        goto error;
        } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
                p =3D dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x1000=
0);
                if (p =3D=3D NULL)
                        goto error;
....
}

>
> >       if (efi_enabled(EFI_CONFIG_TABLES)) {
> > -             /*
> > -              * According to the DMTF SMBIOS reference spec v3.0.0, it=
 is
> > -              * allowed to define both the 64-bit entry point (smbios3=
) and
> > -              * the 32-bit entry point (smbios), in which case they sh=
ould
> > -              * either both point to the same SMBIOS structure table, =
or the
> > -              * table pointed to by the 64-bit entry point should cont=
ain a
> > -              * superset of the table contents pointed to by the 32-bi=
t entry
> > -              * point (section 5.2)
> > -              * This implies that the 64-bit entry point should have
> > -              * precedence if it is defined and supported by the OS. I=
f we
> > -              * have the 64-bit entry point, but fail to decode it, fa=
ll
> > -              * back to the legacy one (if available)
> > -              */
> > -             if (efi.smbios3 !=3D EFI_INVALID_TABLE_ADDR) {
> > -                     p =3D dmi_early_remap(efi.smbios3, 32);
> > -                     if (p =3D=3D NULL)
> > -                             goto error;
> > -                     memcpy_fromio(buf, p, 32);
> > -                     dmi_early_unmap(p, 32);
> > -
> > -                     if (!dmi_smbios3_present(buf)) {
> > -                             dmi_available =3D 1;
> > -                             return;
> > -                     }
> > -             }
> > -             if (efi.smbios =3D=3D EFI_INVALID_TABLE_ADDR)
> > +             if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
> >                       goto error;
> > -
> > -             /* This is called as a core_initcall() because it isn't
> > -              * needed during early boot.  This also means we can
> > -              * iounmap the space when we're done with it.
> > -              */
> > -             p =3D dmi_early_remap(efi.smbios, 32);
> > -             if (p =3D=3D NULL)
> > -                     goto error;
> > -             memcpy_fromio(buf, p, 32);
> > -             dmi_early_unmap(p, 32);
> > -
> > -             if (!dmi_present(buf)) {
> > -                     dmi_available =3D 1;
> > -                     return;
> > -             }
> > diff --git a/drivers/firmware/ffi.c b/drivers/firmware/ffi.c
> > new file mode 100644
> > index 000000000000..169802b4a7a8
> > --- /dev/null
> > +++ b/drivers/firmware/ffi.c
> > @@ -0,0 +1,36 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/libfdt.h>
> > +#include <linux/ffi.h>
> > +
> > +#define FFI_INVALID_TABLE_ADDR       (~0UL)
> > +
> > +struct ffi __read_mostly ffi =3D {
> > +     .smbios =3D FFI_INVALID_TABLE_ADDR,
> > +     .smbios3 =3D FFI_INVALID_TABLE_ADDR,
> > +};
>
> > +EXPORT_SYMBOL(ffi);
>
> > +// SPDX-License-Identifier: GPL-2.0-only
>
> Why not EXPORT_SYMBOL_GPL? But also, who is the user of this export?
Just like efi.

>
> > +
> > +void __init ffi_smbios_root_pointer(void)
> > +{
> > +     int cfgtbl, len;
> > +     fdt64_t *prop;
> > +
> > +     cfgtbl =3D fdt_path_offset(initial_boot_params, "/cfgtables");
>
> These DT properties need to be documented in a binding.
>
> > +     if (cfgtbl < 0) {
> > +             pr_info("firmware table not found.\n");
>
> Isn't it perfectly valid for a DT not to contain this table? This print
> should be, at the very least, a pr_debug().
>
> > +             return;
> > +     }
> > +     prop =3D fdt_getprop_w(initial_boot_params, cfgtbl, "smbios_phy_p=
tr", &len);
>
> Again, undocumented DT property. Please document them in a binding.
Okay, I'll add them into binding.


>
> > +     if (!prop || len !=3D sizeof(u64))
> > +             pr_info("smbios entry point not found.\n");
> > +     else
> > +             ffi.smbios =3D fdt64_to_cpu(*prop);
> > +
> > +     pr_info("smbios root pointer: %lx\n", ffi.smbios);
>
> ffi.smbios is not set if (!prop || len !=3D sizeof(u64)), looks like your
> "if" should return and the contents of the else become unconditional?
> Otherwise, this print seems wrong.
OK, I will optimize this logic and print.

>
> > +}
> > +
> > diff --git a/include/linux/ffi.h b/include/linux/ffi.h
> > new file mode 100644
> > index 000000000000..95298a805222
> > --- /dev/null
> > +++ b/include/linux/ffi.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _LINUX_FFI_H
> > +#define _LINUX_FFI_H
> > +
> > +extern struct ffi {
> > +     unsigned long smbios;  /* SMBIOS table (32 bit entry point) */
> > +     unsigned long smbios3;  /* SMBIOS table (64 bit entry point) */
> > +     unsigned long flags;
> > +
> > +} ffi;
> > +
> > +void ffi_smbios_root_pointer(void);
>
> Please provide a stub for !FDT_FW_INTERFACE so that we don't need
> ifdeffery at callsites.
OK, update it on v3.



Thanks,
Yunhui
