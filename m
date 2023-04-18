Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67396E5E33
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDRKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDRKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E037281
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DF746251E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2725C4339B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681812422;
        bh=IpqtBKzf9jd+Nljizkl4Xo1RGy4fY1Qyg0ocePb4XCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YiVTapmEjZox/MkVlLHf3hSUi1pPj2iQjM/6AVBM5JAhLu28lIzlYizDa9Hb9DHme
         hyL5Xlg98dTWCGfqzkix5sWpnbzpoYBQRTDMumn1AUKLWUC201CUVmqcIIzl0RmPGX
         yc2SIyozycabtRv54QU4E5ZBpuduW9VhzFMdy6JpJG+qP6NHx2KbcrPp6JJFecMrvS
         M1oblKTGhuadWqUJIPbn4QNts1yGxuZ/kwJhmyeaBkkqiGa5nAyi/LSEW7nCl0Pnmx
         IcTq3tMIkXxIkxqTIP3M3IlI4aesZtICYq1tkpPvhnORKKOq32v5eIennKw6rsICW4
         OK1AU4mwu0Ftw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2a8bbea12d7so17536431fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:07:02 -0700 (PDT)
X-Gm-Message-State: AAQBX9ehIhuvzFa24+niNqwPEB2ZlqQM3CwLIuU7oiGRheVcF4d56Re8
        U14SZVfo13uVw5FNV2I7OqqCVME+67wp/80fHEs=
X-Google-Smtp-Source: AKy350b0kGxD66QXlx0N0+stzhTUHhDNwP/XTLdsSrqKNMK6HYltyv8D8s2FK2o0lFmOBrJ/WRmXsh4Z9gAH4PIQ7Q0=
X-Received: by 2002:ac2:5691:0:b0:4eb:3f84:808b with SMTP id
 17-20020ac25691000000b004eb3f84808bmr3016739lfr.3.1681812420640; Tue, 18 Apr
 2023 03:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230307140522.2311461-1-ardb@kernel.org> <20230307140522.2311461-35-ardb@kernel.org>
 <775d92fc-9195-88bf-4a1c-51b74185c07d@arm.com>
In-Reply-To: <775d92fc-9195-88bf-4a1c-51b74185c07d@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 18 Apr 2023 12:06:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGJSnoLj=eyQJnSthuuyRHSKTD1+RpyMu33ps3Sp6cb+Q@mail.gmail.com>
Message-ID: <CAMj1kXGJSnoLj=eyQJnSthuuyRHSKTD1+RpyMu33ps3Sp6cb+Q@mail.gmail.com>
Subject: Re: [PATCH v3 34/60] arm64: head: Move early kernel mapping routines
 into C code
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
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

On Tue, 18 Apr 2023 at 11:31, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 07/03/2023 14:04, Ard Biesheuvel wrote:
> > The asm version of the kernel mapping code works fine for creating a
> > coarse grained identity map, but for mapping the kernel down to its
> > exact boundaries with the right attributes, it is not suitable. This is
> > why we create a preliminary RWX kernel mapping first, and then rebuild
> > it from scratch later on.
> >
> > So let's reimplement this in C, in a way that will make it unnecessary
> > to create the kernel page tables yet another time in paging_init().
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
>
> > [...]
>
> > diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
> > new file mode 100644
> > index 0000000000000000..b573c964c7d88d1b
> > --- /dev/null
> > +++ b/arch/arm64/kernel/pi/map_kernel.c
> > @@ -0,0 +1,171 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright 2023 Google LLC
> > +// Author: Ard Biesheuvel <ardb@google.com>
> > +
> > +#include <linux/init.h>
> > +#include <linux/libfdt.h>
> > +#include <linux/linkage.h>
> > +#include <linux/types.h>
> > +#include <linux/sizes.h>
> > +#include <linux/string.h>
> > +
> > +#include <asm/memory.h>
> > +#include <asm/pgalloc.h>
> > +#include <asm/pgtable.h>
> > +#include <asm/tlbflush.h>
> > +
> > +#include "pi.h"
> > +
> > +extern const u8 __eh_frame_start[], __eh_frame_end[];
> > +
> > +extern void idmap_cpu_replace_ttbr1(void *pgdir);
> > +
> > +static void map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
> > +                     void *start, void *end, pgprot_t prot,
> > +                     bool may_use_cont, int root_level)
> > +{
> > +     map_range(pgd, ((u64)start + va_offset) & ~PAGE_OFFSET,
> > +               ((u64)end + va_offset) & ~PAGE_OFFSET, (u64)start,
> > +               prot, root_level, (pte_t *)pg_dir, may_use_cont, 0);
>
> I don't understand what you are doing with ~PAGE_OFFSET here. Is this intended
> to be page alignment with PAGE_MASK? I'm guessing not, because you would want to
> forward align the end address in that case.
>

start + va_offset will produce an address that has leading 1 bits set
in positions that do not contribute to the translation. In order to
index the page tables correctly, those bits need to be cleared.

> > +}
> > +
> > +static void unmap_segment(pgd_t *pg_dir, u64 va_offset, void *start,
> > +                       void *end, int root_level)
> > +{
> > +     map_segment(pg_dir, NULL, va_offset, start, end, __pgprot(0),
> > +                 false, root_level);
> > +}
> > +
>
> > [...]
>
> > diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
> > new file mode 100644
> > index 0000000000000000..61cbd6e82418c033
> > --- /dev/null
> > +++ b/arch/arm64/kernel/pi/map_range.c
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright 2023 Google LLC
> > +// Author: Ard Biesheuvel <ardb@google.com>
> > +
> > +#include <linux/types.h>
> > +#include <linux/sizes.h>
> > +
> > +#include <asm/memory.h>
> > +#include <asm/pgalloc.h>
> > +#include <asm/pgtable.h>
> > +
> > +#include "pi.h"
> > +
> > +/**
> > + * map_range - Map a contiguous range of physical pages into virtual memory
> > + *
> > + * @pte:             Address of physical pointer to array of pages to
> > + *                   allocate page tables from
> > + * @start:           Virtual address of the start of the range
> > + * @end:             Virtual address of the end of the range (exclusive)
> > + * @pa:                      Physical address of the start of the range
> > + * @level:           Translation level for the mapping
> > + * @tbl:             The level @level page table to create the mappings in
> > + * @may_use_cont:    Whether the use of the contiguous attribute is allowed
> > + * @va_offset:               Offset between a physical page and its current mapping
> > + *                   in the VA space
> > + */
> > +void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
> > +                   int level, pte_t *tbl, bool may_use_cont, u64 va_offset)
>
> va_offset is always 0 (because the memory at *pte is id-mapped). Can it be
> dropped? Or perhaps you are using this function later, once the memory is no
> longer id-mapped?
>

It will be used later.
