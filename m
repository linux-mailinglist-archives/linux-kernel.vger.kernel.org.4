Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524ED745CD1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGCNE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGCNEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:04:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7740DE62
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:04:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc244d386so46638055e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688389492; x=1690981492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d6ih/kmwpjX+tH1Xu9YvN1lziwh3aCHo89EB9XkjqU=;
        b=RN6y0gy31NmpuKelrbC/HzNL00R0snetDTfDwY1NkrB1uDrkwdBiyYeFBGnwwNtRZp
         dtucuAkLDSvD/PdAfaeDTuT42i3tPpXFwJe0u+mD8f3E5mBbasbh3FFi3J1DkgmrzYzY
         UwV5lbmTyFELEuoYeVjuZzxJajX2wCwmjr76jeody1tPpDT/pfUvL0o2tlAflzBqniSA
         +gLa0Tx9s4FBhu0c/UrbUtEP5/G7KqW8oCdCgTkF1s7MrxhJYlzf+nVqu1lPBEqoLm/e
         AlIDv85bhTaTOyEs608kDyFGxGcqL/h5/X07iOm4XT2Tc1zWr0x5FqkUJFe/T03WQfj+
         M+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389492; x=1690981492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3d6ih/kmwpjX+tH1Xu9YvN1lziwh3aCHo89EB9XkjqU=;
        b=eee8wZgJbolOr3M8l9B5vEH2qTI3v6r4vtyuoCk3shZTpEUu99FVq74w0VUzuXQK2K
         dciLG2fzDT0UCnJC1Js/pzf5Hj86tO59SiplDUEkX2Sa+6ZsIDHymcJPBnyrfu2oy+2Y
         tuLgO51tKzMqA4htALI9pBFllrOOhALMqnOijYxA3V9Y25U/BZO53SUM5v3MnMyj3SGS
         vQSWarwh3eOgiGD5OYdmcXTnwb5rRlNcaM7xRuz+YA1055F295ldIvupH3PziD+TW98S
         I/O5qJqPuaJfc6IERJmJjbfVCvPHxABjyrNyPZIw9JHatIEpkeVkFwtUhiA93dxTi1F0
         Yjzw==
X-Gm-Message-State: AC+VfDwNODqud7xRUcAJeIzmIasi33afJqsDhCxTju/yJBRgtjfEbqK/
        /58qn8S2rtNS/wRUS+O2wefiesnrg4jSC/jz8E0f4g==
X-Google-Smtp-Source: ACHHUZ6t2qo8tIjShnZO9/FXBBpcQJeQTs/al+vYFLGivJfJj8gprGTPoGGfvUDO7fZ5igBLzHW1X8xoFUJPhsmtHAk=
X-Received: by 2002:a05:600c:3792:b0:3fb:c417:5e6 with SMTP id
 o18-20020a05600c379200b003fbc41705e6mr7953949wmr.23.1688389491911; Mon, 03
 Jul 2023 06:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230702-headway-dreamlike-d7ba39ac4910@spud>
 <CAEEQ3wnzf=iDDHJATo2vdVz-SDNYRGBEEb7sXUyGojgP4ZAgaA@mail.gmail.com>
 <20230703-glorified-headless-16e998608eaa@wendy> <CAEEQ3wnjYK+Jj9Ce_yEHPL_z3eYn4OKP85YLXnVeaPd+SA3DJw@mail.gmail.com>
 <20230703-handstand-prototype-733d702c946c@wendy>
In-Reply-To: <20230703-handstand-prototype-733d702c946c@wendy>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 3 Jul 2023 21:04:40 +0800
Message-ID: <CAEEQ3wkmX6N2b8fftixJ2Ev-DOc_VfbxQM9g66OpVLuL8mVZbA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
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
        weidong.wd@bytedance.com, alexghiti@rivosinc.com,
        sunilvl@ventanamicro.com
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

On Mon, Jul 3, 2023 at 8:20=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> On Mon, Jul 03, 2023 at 06:16:07PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wro=
te:
> > Hi Conor,
>
> > This needs to be confirmed with you:
>
> > Continue to follow the current code structure, patch 1/3 is placed in
> > arch/riscv/, and 2/3 is placed under driver/firmware?
>
> You do want the SMBIOS stuff to be cross architecture, right?
> If so, keeping the code as-is seems to make the most sense to me.

Okay, other arches may use FFI in the future. Keep the code as-is seems.

> > How about changing the commit log to the following?
> >
> > riscv: obtain ACPI RSDP from devicetree.
> >
> > On RISC-V, when using Coreboot to start, since Coreboot only supports
> > DTS but not EFI, and
> > RISC-V does not have a reserved address segment.
> > When the system enables ACPI, ACPI RSDP needs to be passed through DTS
>
> I would probably write something like:
>         On RISC-V, Coreboot does not support booting using EFI, only devi=
cetree
>         nor does RISC-V have a reserved address segment.
>         To allow using Coreboot on platforms that require ACPI, the ACPI =
RSDP
>         needs to be passed to supervisor mode software using devicetree.
>         Add support for parsing the "configtbls" devicetree node to find =
the
>         ACPI entry point and use wire up acpi_arch_get_root_pointer().
>         This feature is known as FDT Firmware Interface (FFI).

Great,  I have to learn from it.

> > > > > > +extern u64 acpi_rsdp;
> > > > >
> > > > > /stuff/linux/drivers/acpi/osl.c:178:22: error: redefinition of 'a=
cpi_rsdp' with a different type: 'unsigned long' vs 'u64' (aka 'unsigned lo=
ng long')
> > > > >
> > > > > Fails to build when Kexec is enabled.
> > > >
> > > > Rename my acpi_rsdp to arch_acpi_rsdp? WDYT?
> > >
> > > You could do s/arch/riscv/ either, that'd match what we prefix a lot =
of
> > > stuff with.
> >
> >  Sorry, I don't quite understand what you mean. Could you tell me in de=
tail?
>
> What I meant is that variables & functions in /arch/riscv are often
> prefixed with riscv_. I was saying that you could change "arch_acpi_rsdp"
> to "riscv_acpi_rsdp".

Oh, that's what it means, okay, I'll update it on v3.

>
> Thanks,
> Conor.

Thanks,
Yunhui
