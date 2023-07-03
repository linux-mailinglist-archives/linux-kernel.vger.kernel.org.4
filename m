Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB423745C67
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjGCMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCMmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:42:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46426E50
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:41:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-314319c0d3eso1858318f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688388102; x=1690980102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AGxwNUjKxcvq08XKdRsahxIcvVXNpWEkg6pqQGD6zU=;
        b=BbSt4hjXBwONEDa7zXvrHRT0uVXBeaHJIWpwA/Sbx9Frc80ZMol0f9+/kaI1poXc96
         aADhst3A1wlJYJe+olPomfQQqek2wrTGOhND6M2k9LoecbAljXGXQ0PtOkA6TcQSzMeF
         DiwjbK2ERD4ZjDPcz9VxqYDOPvanbunT1K9mkh6pIGiWzspUrzYQEWzZxXSm1t7QWfVy
         hWxoo9A7pNPj3plGkEotzzGJJF4IUyeqi9kRMuuDg7kYlIEFPqCMY7EhbBYjwecODbqT
         TqOxUB96EA7aRqc/FzVi/0SfP3yXnHSHavf26m0ZJTCZwcTUUAbcvbmQolNGnHXrbum0
         JKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388102; x=1690980102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AGxwNUjKxcvq08XKdRsahxIcvVXNpWEkg6pqQGD6zU=;
        b=C5hSFEsoVQ7d1HV0fBaOtKcpEuOSDiy4BnwXiT5cFYj4N8f6+U2FBx3AZmZnvBw5Ua
         2jQUKtTjf2FCTx5DLwj8jQoL0rdgLdIFikLgJhw8iEgTHU+8p2gtmoGN95R0dsnVrZLx
         e+tdTNJi3eXmSYIkj4rbJsylbx19z/MhJiIDcSFTdTOCDfLrokA2jEKyxQeKE9Et+nIN
         AUrFHwojKSMnsXPzlgtbdbercwgyUVObDIoCvcQAYkye9cfo0PHZGV0A3ZEEE2vn4lC6
         mdFUyvJpcVcTw5GGlFY1niV+sVgwVLuruSxhVf5lfxzZdUn5+pPEBH1F/NNNlfs+hvZO
         VE7g==
X-Gm-Message-State: ABy/qLbfjTgtFxz5cvUwMSbP+oq+6qbC7Df57Pk6HuaOyhaq5hnAFVBT
        tmCDljP7hk5oLQzlYcr0aNYp16tk5xXRmcfTcfeksg==
X-Google-Smtp-Source: APBJJlHwEFEOp97X32p7BSMdems3qgIY3JAiwErRmm2e4MdbvZBcKVK5r08BHi5cEZBeroi6ftxDg/yDXab1xPh/moI=
X-Received: by 2002:a05:6000:1188:b0:313:df09:ad04 with SMTP id
 g8-20020a056000118800b00313df09ad04mr8454996wrx.57.1688388101639; Mon, 03 Jul
 2023 05:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230702095735.860-2-cuiyunhui@bytedance.com>
 <20230702-collide-rumor-f0d915a4f1b2@spud> <CAEEQ3w=CMSMnYmfprYS4ydsA=EBJtLhQQHWky754EC-iifcYtg@mail.gmail.com>
 <20230703-rebuff-smashing-6b2c6f80ba05@wendy>
In-Reply-To: <20230703-rebuff-smashing-6b2c6f80ba05@wendy>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 3 Jul 2023 20:41:30 +0800
Message-ID: <CAEEQ3w=-1Zns_pZRSeM0+Wv46y6RttcT5jFy_ENnq--RptYp2g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/3] firmware: introduce FFI for SMBIOS entry.
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, ardb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thanks for your comments.

On Mon, Jul 3, 2023 at 4:36=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> Hey,
>
> On Mon, Jul 03, 2023 at 04:23:53PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wro=
te:
> >
> > > nit: please don't write your commit messages as bullet lists
> > Okay, thanks for your suggestion.
> >
> > > > +FDT FIRMWARE INTERFACE (FFI)
> > > > +M:   Yunhui Cui cuiyunhui@bytedance.com
> > > > +S:   Maintained
> > > > +F:   drivers/firmware/ffi.c
> > > > +F:   include/linux/ffi.h
> > >
> > > Are you going to apply patches for this, or is someone else?
> > Yes,  it will be used by patch 3/3.
>
> That's not what I asked :(

Sorry,  ok,  what do you want to ask?



> > > >  EXTERNAL CONNECTOR SUBSYSTEM (EXTCON)
> > > >  M:   MyungJoo Ham <myungjoo.ham@samsung.com>
> > > >  M:   Chanwoo Choi <cw00.choi@samsung.com>
> > > > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > > > index b59e3041fd62..ea0149fb4683 100644
> > > > --- a/drivers/firmware/Kconfig
> > > > +++ b/drivers/firmware/Kconfig
> > > > @@ -303,6 +303,17 @@ config TURRIS_MOX_RWTM
> > > >         other manufacturing data and also utilize the Entropy Bit G=
enerator
> > > >         for hardware random number generation.
> > > >
> > > > +config FDT_FW_INTERFACE
> > > > +       bool "An interface for passing firmware info through FDT"
> > > > +       depends on OF && OF_FLATTREE
> > > > +       default n
> > > > +       help
> > > > +         When some bootloaders do not support EFI, and the arch do=
es not
> > > > +         support SMBIOS_ENTRY_POINT_SCAN_START, then you can enabl=
e this option
> > > > +         to support the transfer of firmware information, such as =
smbios tables.
> > >
> > > Could you express this dependency on !SMBIOS_ENTRY_POINT_SCAN_START i=
n
> > > Kconfig & then simply the text to:
> > > "Enable this option to support the transfer of firmware information,
> > > such as smbios tables, for bootloaders that do not support EFI."
> > > since it would not even appear if the arch supports scanning for the
> > > entry point?
> > > If I was was a punter trying to configure my kernel in menuconfig or
> > > whatever, I should be able to decide based on the help text if I need
> > > this, not going grepping for #defines in headers.
> > Okay=EF=BC=8C I'll update on v3.
> >
> >
> > >
> > > >  static void __init dmi_scan_machine(void)
> > > > @@ -660,58 +686,22 @@ static void __init dmi_scan_machine(void)
> > > >       char __iomem *p, *q;
> > > >       char buf[32];
> > > >
> > > > +#ifdef CONFIG_FDT_FW_INTERFACE
> > > > +     if (dmi_sacn_smbios(ffi.smbios3, ffi.smbios))
> > >
> > > "dmi_sacn_smbios"
> > >
> > > > +             goto error;
> > > > +#endif
> > >
> > > Does this not mean that if FDT_FW_INTERFACE is enabled, but the platf=
orm
> > > wants to use EFI, it won't be able to? The `goto error;` makes this l=
ook
> > > mutually exclusive to my efi-unaware eyes.
> >
> > If you have enabled FFI, then if something goes wrong, you should goto =
error.
> > Just like the origin code:
> >         if (efi_enabled(EFI_CONFIG_TABLES)) {
> >                 if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
> >                         goto error;
> >         } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)=
) {
> >                 p =3D dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x=
10000);
> >                 if (p =3D=3D NULL)
> >                         goto error;
>
> Does this not make FFI and EFI mutually exclusive Kconfig options?
> Suppose you are on a system that does not implement FFI, but does
> implement EFI - what's going to happen then?
> AFAICT, dmi_sacn_smbios(ffi.smbios3, ffi.smbios) will fail & you'll do a
> `goto error` & skip the EFI code. What am I missing?

Code is not intended to be mutually exclusive, get the correct value and re=
turn,
The code is going to be changed to this:

#ifdef CONFIG_FDT_FW_INTERFACE
        if (ffi_enabled(FFI_CONFIG_TABLES)) {
                if (!dmi_sacn_smbios(ffi.smbios3, ffi.smbios))
                        return;
        }
#endif

>
> > > >       if (efi_enabled(EFI_CONFIG_TABLES)) {
> > > > -             /*
> > > > -              * According to the DMTF SMBIOS reference spec v3.0.0=
, it is
> > > > -              * allowed to define both the 64-bit entry point (smb=
ios3) and
> > > > -              * the 32-bit entry point (smbios), in which case the=
y should
> > > > -              * either both point to the same SMBIOS structure tab=
le, or the
> > > > -              * table pointed to by the 64-bit entry point should =
contain a
> > > > -              * superset of the table contents pointed to by the 3=
2-bit entry
> > > > -              * point (section 5.2)
> > > > -              * This implies that the 64-bit entry point should ha=
ve
> > > > -              * precedence if it is defined and supported by the O=
S. If we
> > > > -              * have the 64-bit entry point, but fail to decode it=
, fall
> > > > -              * back to the legacy one (if available)
> > > > -              */
> > > > -             if (efi.smbios3 !=3D EFI_INVALID_TABLE_ADDR) {
> > > > -                     p =3D dmi_early_remap(efi.smbios3, 32);
> > > > -                     if (p =3D=3D NULL)
> > > > -                             goto error;
> > > > -                     memcpy_fromio(buf, p, 32);
> > > > -                     dmi_early_unmap(p, 32);
> > > > -
> > > > -                     if (!dmi_smbios3_present(buf)) {
> > > > -                             dmi_available =3D 1;
> > > > -                             return;
> > > > -                     }
> > > > -             }
> > > > -             if (efi.smbios =3D=3D EFI_INVALID_TABLE_ADDR)
> > > > +             if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
> > > >                       goto error;
> > > > -
> > > > -             /* This is called as a core_initcall() because it isn=
't
> > > > -              * needed during early boot.  This also means we can
> > > > -              * iounmap the space when we're done with it.
> > > > -              */
> > > > -             p =3D dmi_early_remap(efi.smbios, 32);
> > > > -             if (p =3D=3D NULL)
> > > > -                     goto error;
> > > > -             memcpy_fromio(buf, p, 32);
> > > > -             dmi_early_unmap(p, 32);
> > > > -
> > > > -             if (!dmi_present(buf)) {
> > > > -                     dmi_available =3D 1;
> > > > -                     return;
> > > > -             }
> > > > diff --git a/drivers/firmware/ffi.c b/drivers/firmware/ffi.c
> > > > new file mode 100644
> > > > index 000000000000..169802b4a7a8
> > > > --- /dev/null
> > > > +++ b/drivers/firmware/ffi.c
> > > > @@ -0,0 +1,36 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > +
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_fdt.h>
> > > > +#include <linux/libfdt.h>
> > > > +#include <linux/ffi.h>
> > > > +
> > > > +#define FFI_INVALID_TABLE_ADDR       (~0UL)
> > > > +
> > > > +struct ffi __read_mostly ffi =3D {
> > > > +     .smbios =3D FFI_INVALID_TABLE_ADDR,
> > > > +     .smbios3 =3D FFI_INVALID_TABLE_ADDR,
> > > > +};
> > >
> > > > +EXPORT_SYMBOL(ffi);
> > >
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > >
> > > Why not EXPORT_SYMBOL_GPL? But also, who is the user of this export?
> > Just like efi.
>
> I don't really understand how that is an answer to the questions.

I checked, the code is executed as the system starts, either Y or N, M
will not appear, and the same is true for ffi's user DMI.
So no need for EXPORT.

>
> > > > +
> > > > +void __init ffi_smbios_root_pointer(void)
> > > > +{
> > > > +     int cfgtbl, len;
> > > > +     fdt64_t *prop;
> > > > +
> > > > +     cfgtbl =3D fdt_path_offset(initial_boot_params, "/cfgtables")=
;
> > >
> > > These DT properties need to be documented in a binding.
> > >
> > > > +     if (cfgtbl < 0) {
> > > > +             pr_info("firmware table not found.\n");
> > >
> > > Isn't it perfectly valid for a DT not to contain this table? This pri=
nt
> > > should be, at the very least, a pr_debug().
> > >
> > > > +             return;
> > > > +     }
> > > > +     prop =3D fdt_getprop_w(initial_boot_params, cfgtbl, "smbios_p=
hy_ptr", &len);
> > >
> > > Again, undocumented DT property. Please document them in a binding.
> > Okay, I'll add them into binding.
> >
> >
> > >
> > > > +     if (!prop || len !=3D sizeof(u64))
> > > > +             pr_info("smbios entry point not found.\n");
> > > > +     else
> > > > +             ffi.smbios =3D fdt64_to_cpu(*prop);
> > > > +
> > > > +     pr_info("smbios root pointer: %lx\n", ffi.smbios);
> > >
> > > ffi.smbios is not set if (!prop || len !=3D sizeof(u64)), looks like =
your
> > > "if" should return and the contents of the else become unconditional?
> > > Otherwise, this print seems wrong.
>
> > OK, I will optimize this logic and print.
>
> It's not an optimisation. If the if branch of your code is taken, it
> currently will do
>         pr_info("smbios entry point not found.\n");
>         pr_info("smbios root pointer: %lx\n", ffi.smbios);
> which makes no sense...

Yeah, I got it, that's what I mean by "optimize".

>
> Thanks,
> Conor.
>

Thanks,
Yunhui
