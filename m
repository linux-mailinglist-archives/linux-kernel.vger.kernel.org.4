Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE48A6AE7E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCGREO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCGRDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:03:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B8B8C0C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:59:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC686B81997
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71346C433EF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678208336;
        bh=QOccuqyoecJXuzLFr64abtqtJlMP/90ITrzf9vPh3WU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=teZRI+nPK3avKPiOn3gi2+HAGWt9xHkwj8RD2+96iELWSARFZgd4krktfctiIUPQn
         GLZYbI+xz9S38MbEnPnQV038FGMxAjRepZMRCsm92chHmFH6oGw36dShdbHpP1Oco8
         9zpfuYSLLkyoMFQoW3Zrpa/H8YqhW4MXwRfDJ1iqO7zdUlrPS6K6iab/XYPYoJeI4D
         MhW15z3EHe58f1iViamski85j0JlsNJUc9ukm8kTyfdBNB5sQeC7ZTstQnVkhLZjSm
         aIbhsPM5KVHU7PDmOl+LkvojT8oSKMJDOYbHfcKNNzlHlj7em/TgKLBEUek5BleIfV
         kKwpyTJHWl4tQ==
Received: by mail-lf1-f47.google.com with SMTP id s20so17922364lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:58:56 -0800 (PST)
X-Gm-Message-State: AO0yUKVRg+zzhwHZgR7jUvhIRx0YIcWxLQlHEA7/q3ZrM5IGQ6XJTZgd
        By15H/4muZPvi1sMJ0pLh8B92HNdBYe6QRsVqXg=
X-Google-Smtp-Source: AK7set8F/KClfie7nYbAUjeUl9xD2UDV+UmcCAQo60DIfSy9oWe9x3SFXsRWPJN62MHqdafop7Fse/IP8iL3ODKl4HY=
X-Received: by 2002:ac2:5de1:0:b0:4dd:af74:fe17 with SMTP id
 z1-20020ac25de1000000b004ddaf74fe17mr4626199lfq.7.1678208334469; Tue, 07 Mar
 2023 08:58:54 -0800 (PST)
MIME-Version: 1.0
References: <20230307140522.2311461-1-ardb@kernel.org> <20230307140522.2311461-10-ardb@kernel.org>
 <8e931b7c-3c10-10f7-5d59-546b1a9d5735@arm.com>
In-Reply-To: <8e931b7c-3c10-10f7-5d59-546b1a9d5735@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Mar 2023 17:58:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEdTBAmB_GznxcrWd0j1dvg6e9Q6kovAh6P9XZvOXxKbw@mail.gmail.com>
Message-ID: <CAMj1kXEdTBAmB_GznxcrWd0j1dvg6e9Q6kovAh6P9XZvOXxKbw@mail.gmail.com>
Subject: Re: [PATCH v3 09/60] arm64: mm: Reclaim unused vmemmap region for
 vmalloc use
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 at 17:42, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 07/03/2023 14:04, Ard Biesheuvel wrote:
> > The vmemmap array is statically sized based on the maximum supported
> > size of the virtual address space, but it is located inside the upper VA
> > region, which is statically sized based on the *minimum* supported size
> > of the VA space. This doesn't matter much when using 64k pages, which is
> > the only configuration that currently supports 52-bit virtual
> > addressing.
>
> As I understand it, the vmemmap section only holds struct pages, and the number
> of struct pages in the system is surely a function of PA size, not VA size? So
> why is the region sized based on VA size?
>

We do not implement CONFIG_HIGHMEM on arm64, and so the addressable PA
range is bounded by the size of the linear map (and in some cases,
DRAM starts outside of the VA addressable range entirely, e.g., on AMD
Seattle with 38-bit VAs). Also, the start of the linear map (i.e.,
PAGE_OFFSET) does not correspond with PA 0x0, it is based on the
physical placement of system memory, and it is randomized in some
cases as well. This is why we have

#define vmemmap  ((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))

This means btw that we could reclaim even more vmemmap space, i.e.,
nothing below phys_to_page(memblock_start_of_DRAM()) will ever be
used, but there are some intricacies with section rounding etc which
make this a bit tricky.

The main reason for this patch is to free up 15/16 of the vmemmap
region when using LPA2 and 4k pages, so that the resulting VA space
layout is identical to 48-bits/4k pages, making LPA2 support enabled a
reasonable default.



> >
> > However, upcoming LPA2 support will change this picture somewhat, as in
> > that case, the vmemmap array will take up more than 25% of the upper VA
> > region when using 4k pages. Given that most of this space is never used
> > when running on a system that does not support 52-bit virtual
> > addressing, let's reclaim the unused vmemmap area in that case.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 3eff06c5d0eb73c7..2259898e8c3d990a 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -18,11 +18,15 @@
> >   * VMALLOC range.
> >   *
> >   * VMALLOC_START: beginning of the kernel vmalloc space
> > - * VMALLOC_END: extends to the available space below vmemmap, PCI I/O space
> > - *   and fixed mappings
> > + * VMALLOC_END: extends to the available space below vmemmap
> >   */
> >  #define VMALLOC_START                (MODULES_END)
> > +#if VA_BITS == VA_BITS_MIN
> >  #define VMALLOC_END          (VMEMMAP_START - SZ_8M)
> > +#else
> > +#define VMEMMAP_UNUSED_NPAGES        ((_PAGE_OFFSET(vabits_actual) - PAGE_OFFSET) >> PAGE_SHIFT)
> > +#define VMALLOC_END          (VMEMMAP_START + VMEMMAP_UNUSED_NPAGES * sizeof(struct page) - SZ_8M)
> > +#endif
> >
> >  #define vmemmap                      ((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
> >
>
