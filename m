Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61CD6D0ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjC3QNc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjC3QNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:13:30 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0433E3A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:13:04 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-545cb3c9898so288219307b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ASMwRAXSxQ56uzRQV9rpj0YNrKR/hLF/lFweUlSAcY=;
        b=yFftUyuEFnhd5imrtSqwj6kRE+XB0WLfBmQnXan3GFIhF7NCgb1P4kuIzlCwC2/8oG
         Eqwbbhccu/vFB5eHehHIjisVP3ERIhDX7fj8OtO12HipiMT4Co63ehOvttGRThY7Jps9
         rDns6TyZ3Vazlzg58RFa73wP30Abk2VCufJhfzecj7U2tKYiTb5/3i9owyqB3jRdGMPU
         a5O9Vmkaa9zFO2mSN2t536YkE9ibMiQCmtCEwmltz2fdLHtidRn7TtkE7B+jYjOGURb0
         4bzWm32vmbrWVH7hdWKrfi34etmnLHquwTWnOoH3nCUJme0SeQnWFoPfNZfK15kw0z10
         i9cg==
X-Gm-Message-State: AAQBX9ebbXgp7BR/gS/iF6jUqAJJdTrM2OTv0hEGnS56oBIxCVvgoiIz
        toPq/TbWg2RVdBw3PpU8P8rub8eDrebnSLf/
X-Google-Smtp-Source: AKy350ZdS7vE6864BG2lq5SPTQP6zIW/Pw9RAaNMc3MpAzN8OPUgfNa2VDT/tp141vGPjobf9hRYHg==
X-Received: by 2002:a81:52d2:0:b0:544:179f:528 with SMTP id g201-20020a8152d2000000b00544179f0528mr23538412ywb.32.1680192720297;
        Thu, 30 Mar 2023 09:12:00 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id bp3-20020a05690c068300b00545ce97d474sm2737838ywb.39.2023.03.30.09.11.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:11:59 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-545cb3c9898so288218247b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:11:59 -0700 (PDT)
X-Received: by 2002:a81:b65f:0:b0:545:611c:8d19 with SMTP id
 h31-20020a81b65f000000b00545611c8d19mr12055261ywk.4.1680192719618; Thu, 30
 Mar 2023 09:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230330060105.29460-1-rdunlap@infradead.org> <e1b6f12a-899b-4985-8725-556bcb5d0991@spud>
 <CAMuHMdW2r1f7C_BdXn9BnDktLwHjBA_0Kvq6OeLJ1sZ7azhqkg@mail.gmail.com> <b712f5c8-9486-8e4a-63cd-6b176572244f@infradead.org>
In-Reply-To: <b712f5c8-9486-8e4a-63cd-6b176572244f@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Mar 2023 18:11:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_=T9EB=rE_p9XO2-MtaV3jNkX76_PxYd9wi17NhaYHQ@mail.gmail.com>
Message-ID: <CAMuHMdX_=T9EB=rE_p9XO2-MtaV3jNkX76_PxYd9wi17NhaYHQ@mail.gmail.com>
Subject: Re: [PATCH] iommu: PGTABLE_LPAE is also for RISCV
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Thu, Mar 30, 2023 at 5:48 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 3/30/23 00:31, Geert Uytterhoeven wrote:
> > On Thu, Mar 30, 2023 at 8:25 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> >> On Wed, Mar 29, 2023 at 11:01:05PM -0700, Randy Dunlap wrote:
> >>> On riscv64, linux-next-20233030 (and for several days earlier),
> >>> there is a kconfig warning:
> >>>
> >>> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
> >>>   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
> >>>   Selected by [y]:
> >>>   - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
> >>>
> >>> and build errors:
> >>>
> >>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L140':
> >>> io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_io_pgtable_ops'
> >>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L168':
> >>> io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_io_pgtable_ops'
> >>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
> >>> ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable_ops'
> >>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
> >>> ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtable_ops'
> >>>
> >>> Add RISCV as an allowed ARCH dependency to fix these problems.
> >>>
> >>> Fixes: d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
> >>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>> Cc: Joerg Roedel <joro@8bytes.org>
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>> Cc: iommu@lists.linux.dev
> >>> Cc: Conor Dooley <conor@kernel.org>
> >>> Cc: linux-riscv@lists.infradead.org
> >>> ---
> >>>  drivers/iommu/Kconfig |    2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> >>> --- a/drivers/iommu/Kconfig
> >>> +++ b/drivers/iommu/Kconfig
> >>> @@ -32,7 +32,7 @@ config IOMMU_IO_PGTABLE
> >>>  config IOMMU_IO_PGTABLE_LPAE
> >>>       bool "ARMv7/v8 Long Descriptor Format"
> >>
> >> I'm probably missing something here, but why would we want to enable
> >> "ARMv7/v8 Long Descriptor Format" on RISC-V?
> >
> > Indeed, we should not enable it, unless compile-testing.
> >
> >> Would it not be better to make the Renesas depend on, rather than
> >> select the option? It does seem highly arch specific, and I feel like
> >> Geert previously mentioned that the RZ/Five (their RISC-V offering)
> >> didn't use it.
> >
> > I think the IPMMU_VMSA dependency should gain
> >
> >         depends on ARM || ARM64 || COMPILE_TEST
>
> so like this?
> Or did you mean to drop the ARCH_RENESAS part also?
>
>
>  config IPMMU_VMSA
>         bool "Renesas VMSA-compatible IPMMU"
> -       depends on ARCH_RENESAS || COMPILE_TEST
> +       depends on ARCH_RENESAS || ARM || ARM64 || COMPILE_TEST

No, you want "depends on (ARCH_RENESAS && (ARM || ARM64)) || COMPILE_TEST",
which is a bit hard to read.

Hence I really meant adding that line, i.e.:

     config IPMMU_VMSA
           bool "Renesas VMSA-compatible IPMMU"
           depends on ARCH_RENESAS || COMPILE_TEST
    +      depends on ARM || ARM64 || COMPILE_TEST

>
> The failing config file has ARCH_RENESAS=y.  After the change above, I still get:
>
> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>   Selected by [y]:
>   - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
-- 
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
