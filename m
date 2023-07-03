Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34484745D39
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGCN1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjGCN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:27:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B3FE3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:27:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fba5a8af2cso45277955e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688390825; x=1690982825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ch0Zdn2eah8PqhuHuapNHzKo9dNMTzx4t7MOAgB9bHE=;
        b=JEljl7dtutPv1ZmMniNULgo5xKZiLmvIn7CfiX4r1Hi7NAOz1ya4l1DO5EpDyoMbi/
         vQ+EQjDpThGdMmNzQMBhDFMF34MHuLnF7lueTjnBS6sFW2OkWKppllSiwK58GrwlJ5F3
         dSbLyMuih+dExPtmLE/vVFXKWeVKBR5S1GWeg5MfbaVxEObMM+FusYRohyw2bWhiVJ3r
         hVE/ZzoUQZAxhc+8Df8Y8q9jfzhLxeNBd/CmlnLd8BlNWt2RQj/kkbpuOxEIKLJBcki7
         s0w2ZC+/ufxRduCiFRiQMKwmthHkxguR4aLZF83dH+/0FMGb3LtTv7PEeGPxOrPbN6lX
         6qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688390825; x=1690982825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ch0Zdn2eah8PqhuHuapNHzKo9dNMTzx4t7MOAgB9bHE=;
        b=HCmYs89tRWM8/snZVEO2m1qD8hKKLzC2e7cz03X3BxEilhtPXLFubhMsuhCdT6zwfr
         3UmqnV6Ctx19SB6GBJrmgSOZyr5Lz2KH5UlZ5o49xcfZXbaXSwwN/jj9lBNKb/7xXHOy
         jSstaizDyB+S1Ba4n06n8iQu9sxawDr8EnwcRRH1vcAaZxOuzctsKjntwIXz4J8slkuL
         2fAEPz2IP1jCv/g+LhixqlDfae/G5NbSLjTtlpCPULRdBoxKO8KiRdyvvnXiLqOb/o7V
         1VINSe+fgE3UXWNQhsUg8eGPWW30BYRcDfu/BwpeX7i9P2Ft0SQ+f9V4FkSxJMwsHVvb
         d49Q==
X-Gm-Message-State: AC+VfDw9WwbrfEehoYDX4Dk19KyT4+U82VmqsggqYSIbomn/n0FojZgQ
        pPINQMWquDCCdEeM9qgtXc74+gnaTD209oK/exGcNg==
X-Google-Smtp-Source: ACHHUZ6vbMWhn2vCoqguDXs/DsOPc8iovpI/n64CjZN1eD3CG+RwJ25ngGZ0BTHapVp31P2ONtJvb8N1hf1MfZjDrLo=
X-Received: by 2002:a05:600c:204b:b0:3fb:c217:722e with SMTP id
 p11-20020a05600c204b00b003fbc217722emr7467529wmg.33.1688390825022; Mon, 03
 Jul 2023 06:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230702095735.860-2-cuiyunhui@bytedance.com>
 <20230702-collide-rumor-f0d915a4f1b2@spud> <CAEEQ3w=CMSMnYmfprYS4ydsA=EBJtLhQQHWky754EC-iifcYtg@mail.gmail.com>
 <20230703-rebuff-smashing-6b2c6f80ba05@wendy> <CAEEQ3w=-1Zns_pZRSeM0+Wv46y6RttcT5jFy_ENnq--RptYp2g@mail.gmail.com>
 <20230703-patrol-paced-76cd5e24db6b@wendy>
In-Reply-To: <20230703-patrol-paced-76cd5e24db6b@wendy>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 3 Jul 2023 21:26:53 +0800
Message-ID: <CAEEQ3wmBSwn80kA_cnw766P4Q03tE6_TVtkndVeUsRrPqt0KyQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Jul 3, 2023 at 9:03=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> On Mon, Jul 03, 2023 at 08:41:30PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wro=
te:
> > On Mon, Jul 3, 2023 at 4:36=E2=80=AFPM Conor Dooley <conor.dooley@micro=
chip.com> wrote:
> > > On Mon, Jul 03, 2023 at 04:23:53PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94=
 wrote:
>
> > > > > > +FDT FIRMWARE INTERFACE (FFI)
> > > > > > +M:   Yunhui Cui cuiyunhui@bytedance.com
> > > > > > +S:   Maintained
> > > > > > +F:   drivers/firmware/ffi.c
> > > > > > +F:   include/linux/ffi.h
> > > > >
> > > > > Are you going to apply patches for this, or is someone else?
> > > > Yes,  it will be used by patch 3/3.
> > >
> > > That's not what I asked :(
> >
> > Sorry,  ok,  what do you want to ask?
>
> Who is going to apply patches for drivers/firmware/ffi*?

I'll update to v3:
F:   drivers/firmware/ffi*
F:   include/linux/ffi*
And I'll plan to maintain them.
But now,  I don't know how to apply the patches. Could you give some
suggestions?

>
> > > > > >  static void __init dmi_scan_machine(void)
> > > > > > @@ -660,58 +686,22 @@ static void __init dmi_scan_machine(void)
> > > > > >       char __iomem *p, *q;
> > > > > >       char buf[32];
> > > > > >
> > > > > > +#ifdef CONFIG_FDT_FW_INTERFACE
> > > > > > +     if (dmi_sacn_smbios(ffi.smbios3, ffi.smbios))
> > > > >
> > > > > "dmi_sacn_smbios"
> > > > >
> > > > > > +             goto error;
> > > > > > +#endif
> > > > >
> > > > > Does this not mean that if FDT_FW_INTERFACE is enabled, but the p=
latform
> > > > > wants to use EFI, it won't be able to? The `goto error;` makes th=
is look
> > > > > mutually exclusive to my efi-unaware eyes.
> > > >
> > > > If you have enabled FFI, then if something goes wrong, you should g=
oto error.
> > > > Just like the origin code:
> > > >         if (efi_enabled(EFI_CONFIG_TABLES)) {
> > > >                 if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
> > > >                         goto error;
> > > >         } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLB=
ACK)) {
> > > >                 p =3D dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START=
, 0x10000);
> > > >                 if (p =3D=3D NULL)
> > > >                         goto error;
> > >
> > > Does this not make FFI and EFI mutually exclusive Kconfig options?
> > > Suppose you are on a system that does not implement FFI, but does
> > > implement EFI - what's going to happen then?
> > > AFAICT, dmi_sacn_smbios(ffi.smbios3, ffi.smbios) will fail & you'll d=
o a
> > > `goto error` & skip the EFI code. What am I missing?
> >
> > Code is not intended to be mutually exclusive, get the correct value an=
d return,
> > The code is going to be changed to this:
> >
> > #ifdef CONFIG_FDT_FW_INTERFACE
>
> Ideally, these would be IS_ENABLED() instead of #ifdef - but if you copy
> what EFI does, then you don't need either, as there will always be an
> ffi_enabled() defined.

Okay=EF=BC=8C this can refer to the code of EFI. :)

>
> >         if (ffi_enabled(FFI_CONFIG_TABLES)) {
>
> I don't know what this function is, but this code seems like a step in
> the right direction.

Okay, I'll update it on v3.

>
> >                 if (!dmi_sacn_smbios(ffi.smbios3, ffi.smbios))
> >                         return;
> >         }
> > #endif
>
> Thanks,
> Conor.

Thanks,
Yunhui
