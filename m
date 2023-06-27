Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ECD73F513
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjF0HJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjF0HJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:09:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626011BCF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:09:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-313e1c27476so2431802f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687849762; x=1690441762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLHLCzTSc3N5T11ch7RbVwNiToMIPKfqegBEVT2Bdxg=;
        b=Y2XpaTpqkxHTut99adctD3UL3X3TTo4BtWjOF1T62bC+140DkeTNyZ26iZTaHvHxZI
         i+LfkMg2+mpwrHB55cukR2fPDOBdqlHBFvDpu+v//+vbaaQB/R9S5WBQEAsV7L8tB/vG
         nWfF/4Wd94Pe5qeJNjUUFQ2k3gkX6xN87UhcquFcI4TLsXHagFnbnr6QMshrfWW+A+vZ
         AvTr1szEZsMpobX1uEpPO9ddUPKA/YDRkNKWyBtWoKcWIC1ocoErM4tBdybaoflwRoYs
         ibKgxqrC3cO+bUBnvisTt5yYhwJ9AtQAVuGozY9t7fM/1wlE/5+SP9W0KopLvVJtspWR
         RQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687849762; x=1690441762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLHLCzTSc3N5T11ch7RbVwNiToMIPKfqegBEVT2Bdxg=;
        b=acdX7GMY6WGCyy0HnVrTA6rE1jV8nmT9H2laqBgxGJOhwJd++bHBt3OenNhUblBV5G
         PcYz2wKNUQOD3h+fYv+7JcO3VWyqeSZeJzifgeDVC0jiL9ZM0CO95lfqU+tNsuaVBAo0
         29FeUoy8P5dU2CDZFiUoJlhaKkOK+f2tQ2Kxg5s9KDYOpv7B/4FvLwwWIVKbdlgl18Re
         nu8IHWklUHKggc8cy7kMB/PZaAEpQutTk2zE4vs8mxLMtKJPE+A2E46c9ttFNlSJRj+K
         EgTvcIz/pwfmIrOrjnbhl+z1/6eNwj07TIxTp546EDDlYxTnEBps2YeGlBU78XpNdvri
         iMpA==
X-Gm-Message-State: AC+VfDxMMlFQO+S1Ifqf8Fwzz3MaIM3QIjft4sGRN61lrzOz2YWAgxts
        F8dIlH7WufE+m8s7+0s8nyI5lBbiYnlphYgOyAuDVw==
X-Google-Smtp-Source: ACHHUZ6cc924CDGf7hOH0PaM3DmcJrQG/nF7GfEYvy2/r0yRr0cQXXB7dEoU8jSQRicJk7yy8NNDql/dq7FpO6us7PM=
X-Received: by 2002:a5d:61c9:0:b0:313:f5ea:44f7 with SMTP id
 q9-20020a5d61c9000000b00313f5ea44f7mr3065621wrv.35.1687849761763; Tue, 27 Jun
 2023 00:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
 <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
 <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
 <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com>
 <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com>
 <CAEEQ3wn2n48TpNQ3MuvrRH4zzg28SaiOswunPeZ01jFm-TbJ5w@mail.gmail.com>
 <CAMj1kXHgaLD43jx0f6hn_j209LGT_4G+w5XEGaYB9znV5p9tdA@mail.gmail.com>
 <CAP6exYJRE8iM63SX3hQP9_5aKYcnN5x0KOAtZOgeEWU5bwLEBA@mail.gmail.com>
 <CAEEQ3wn2zHUZP8gs8ezCczQLdQJqU6MqAgpcG0YeDW2aYTz0TA@mail.gmail.com>
 <CAMj1kXFn7+W=ZGNcSLL6p383SbA8=wstutJ85+qvXzt2G66Seg@mail.gmail.com>
 <CAEEQ3wnXJVBLdqW6GRFuCKuBtr38uKHz7E2+P8TAv1_+b6kBKA@mail.gmail.com>
 <CAMj1kXFAsG0nH+2OcG3CBZYqKg=hCRHp8wAmVBFy9vNx6rWgOQ@mail.gmail.com> <CAEEQ3wkT_2GbdsjfA_VA+LeyCzdeQ+Bh+admyVjz7rE3cSWSxA@mail.gmail.com>
In-Reply-To: <CAEEQ3wkT_2GbdsjfA_VA+LeyCzdeQ+Bh+admyVjz7rE3cSWSxA@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Tue, 27 Jun 2023 15:09:10 +0800
Message-ID: <CAEEQ3wkhQJ8G-AsFBMYLFcS=rxSkPojWNLGki470WQ3XJLHoAA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ron minnich <rminnich@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        =?UTF-8?B?6Z+m5Lic?= <weidong.wd@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

1. Regarding the definition of DTS FFI nodes, according to your
suggestion, we plan to make the following modifications=EF=BC=9A

/ {
...
    ffi_cfg {
        acpi_tbl {
            root_pinter =3D ; //u64
            ...
        };
        smbios_tbl {
            root_pinter =3D ; //u64
            ...
        };
    };
    ...
};

2. Let's move on to the discussion: should we put code under arch/risc-v/?

On Mon, Jun 26, 2023 at 6:19=E2=80=AFPM =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyun=
hui@bytedance.com> wrote:
>
> Hi Ard, Mark,
>
> On Mon, Jun 26, 2023 at 4:23=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
>
> > DT support for SMBIOS can live in generic code, but the binding has to
> > be sane. As I suggested before, it probably makes sense to supplant
> > the entrypoint rather than just carry its address - this means a 'reg'
> > property with base and size to describe the physical region, and at
> > least major/minor/docrev fields to describe the version.
>
> Regarding dts node binding, our current definition is as follows:
> /dts
> {
> ...
> cfgtables {
> acpi_phy_ptr =3D 0000000000000000; //u64
> smbios_phy_ptr =3D 0000000000000000; //u64
> ...
> }
> ...
> }
>
> x86 only gave a root_pointer entry address
> u64 x86_default_get_root_pointer(void)
> {
>        return boot_params.acpi_rsdp_addr;
> }
>
> Regarding the naming of the binding above, Mark,  do you have any suggest=
ions?
>
>
> > For the ACPI side, you should just implement
> > acpi_arch_get_root_pointer() under arch/riscv, and wire it up in
> > whichever way you want. But please check with the RISC-V maintainers
> > if they are up for this, and whether they want to see this mechanism
> > contributed to one of the pertinent specifications.
>
> You suggest putting SMBIOS in general code instead of ACPI, why?
> From the perspective of firmware information passing, they are a class.
>
> SMBIOS and ACPI are not related to ARCH, nor is DTS to obtain firmware
> information,
>
> Why do you have to put part of the ACPI code under arch/risc-v/?
> The scope of the previous discussion was limited to RISC-V because of
> historical reasons such as the binding with EFI on ARM64. We will only
> enable this function on RISC-V in subsequent patches.
>
> The realization of the FFI scheme itself is irrelevant to the arch.
>
> Thanks=EF=BC=8C
> Yunhui
