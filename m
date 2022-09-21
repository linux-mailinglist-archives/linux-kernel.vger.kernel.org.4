Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E675E555E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 23:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiIUVpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 17:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiIUVpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:45:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CF585A95
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 14:45:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u9so16764661ejy.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 14:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PP10F3Y0rcwOin699T+VT+YNy+4k2+MIHT3lRb8/XtU=;
        b=DVb2DSMUSaoIaMXwXn8381gqIGhbiZk1dU2tLaN03hgwXIkPycTAjZloAJx37anXce
         wcDZ1FnNC+1R63ywzRlviuAyah6fOjeEyu3J5L8JWhy6+fiDVQLM9EtMWPGXHoumuMSB
         D3Na/GE5zxxWxvgLXRj/Np1ERpCt7r+pZtXxov0blVxnqeb4ZiR5Ghbyfks+AzZ4o8GJ
         XTfovIAlyrI+MmcbjeE+YxqzubAeI4/O9W3fdoKcCWvfH2L2sNkN1ZpIOnlw4H9x9Clo
         8CuxCzPrqEsZwCDY4afGaLX6oP96w9RqwZLV+x0UHCjiaklMlbYM3YcWuEJY5ViUfOf+
         T8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PP10F3Y0rcwOin699T+VT+YNy+4k2+MIHT3lRb8/XtU=;
        b=MG9OAqDlygqDOSNyNyETPcO9L0q2eN9abKk3n4DjwzwcVT0AM+6qXIycIzLIotkM//
         VxsmnXUY0RQdc3lRTR/723Dz8jZ1WcLw3UCUFSAaLlzdHm23noeiDTRmXu8Fq/IrMtvm
         j8xADDB7l4QsoEkgZ9tfVifiIP73xE8hpO3dvS1PqzOGI54KP/BGOoGEBylBPa0DRwQO
         coPqaG5WLYdP3Hl0akWbrN75AxzaBficEMYJvfc2G2o0Ec9sELNZFgg4WqPo9blrITSz
         lHp+w5t4RpBiSJzVwDfAugTNnJzu57ybEU66/fZIAzFReUJTBeUOm+4wbtkNnxAn5eGz
         lzrQ==
X-Gm-Message-State: ACrzQf1AZ0JmRquDoVT4aSv/Lz6fob5Q9G0gQZscq92+P4fteLw+p9Tg
        iL0xTnG3wwqCb9BJobG6Cmn48LVR1cRYpk6Z+EY=
X-Google-Smtp-Source: AMsMyM4CcfYm0WYJOXpqSpj3F0bkBrNOmVgLu3b5ublR4Ns1GRyvUNIG4Tzl1k8iGgHH7q/RpTePv7je1EC8Q2yP75E=
X-Received: by 2002:a17:907:97d4:b0:781:c182:c45c with SMTP id
 js20-20020a17090797d400b00781c182c45cmr268765ejc.170.1663796739458; Wed, 21
 Sep 2022 14:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220921074841.382615-1-rppt@kernel.org> <CAGsJ_4yMOC5M9rnfgv9TXWAm2aMDUVOdDYvNjzqzu_oj9DBn8Q@mail.gmail.com>
 <Yysqq0/bxxSY9rcP@kernel.org>
In-Reply-To: <Yysqq0/bxxSY9rcP@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 22 Sep 2022 09:45:28 +1200
Message-ID: <CAGsJ_4xLZR1x-so3jnpYxDUWGGFA2LKTOskPESi7hiQw+FeMgQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: fold check for KFENCE into can_set_direct_map()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 3:16 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> Hi Barry,
>
> On Wed, Sep 21, 2022 at 09:00:28PM +1200, Barry Song wrote:
> > On Wed, Sep 21, 2022 at 8:26 PM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > KFENCE requires linear map to be mapped at page granularity, so that it
> > > is possible to protect/unprotect single pages, just like with
> > > rodata_full and DEBUG_PAGEALLOC.
> > >
> > > Instead of repating
> > >
> > >         can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE)
> > >
> > > make can_set_direct_map() handle the KFENCE case.
> > >
> > > This also prevents potential false positives in kernel_page_present()
> > > that may return true for non-present page if CONFIG_KFENCE is enabled.
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >  arch/arm64/mm/mmu.c      | 8 ++------
> > >  arch/arm64/mm/pageattr.c | 8 +++++++-
> > >  2 files changed, 9 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > index e7ad44585f40..c5065abec55a 100644
> > > --- a/arch/arm64/mm/mmu.c
> > > +++ b/arch/arm64/mm/mmu.c
> > > @@ -535,7 +535,7 @@ static void __init map_mem(pgd_t *pgdp)
> > >          */
> > >         BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
> > >
> > > -       if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> > > +       if (can_set_direct_map())
> > >                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> > >
> > >         /*
> > > @@ -1547,11 +1547,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
> > >
> > >         VM_BUG_ON(!mhp_range_allowed(start, size, true));
> > >
> > > -       /*
> > > -        * KFENCE requires linear map to be mapped at page granularity, so that
> > > -        * it is possible to protect/unprotect single pages in the KFENCE pool.
> > > -        */
> > > -       if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> > > +       if (can_set_direct_map())
> > >                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> > >
> > >         __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> > > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > > index 64e985eaa52d..d107c3d434e2 100644
> > > --- a/arch/arm64/mm/pageattr.c
> > > +++ b/arch/arm64/mm/pageattr.c
> > > @@ -21,7 +21,13 @@ bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED
> > >
> > >  bool can_set_direct_map(void)
> > >  {
> > > -       return rodata_full || debug_pagealloc_enabled();
> > > +       /*
> > > +        * rodata_full, DEBUG_PAGEALLOC and KFENCE require linear map to be
> > > +        * mapped at page granularity, so that it is possible to
> > > +        * protect/unprotect single pages.
> > > +        */
> > > +       return rodata_full || debug_pagealloc_enabled() ||
> > > +               IS_ENABLED(CONFIG_KFENCE);
> >
> > might be irrelevant, i wonder if rodata_full is too strict as
> > rodata_full is almost
> > always true since RODATA_FULL_DEFAULT_ENABLED is default true.
>
> Not sure I follow. If either of these conditions is true the linear map
> consists of base pages and it's possible to change attributes of each base
> page. Whenever linear map contains block mapping, page attributes cannot be
> modified.

Hi Mike,
My question is irrelevant with your patch. It is more of another
topic.  i understand
we need to protect read-only data of kernel, but it seems overly
defensive. We are
getting the whole linear mapping PTE-mapped.

/sys/kernel/debug# cat kernel_page_tables
0x0000000000000000-0xffff608000000000   17179705856G PGD
0xffff608000000000-0xffff60bf40000000         253G PUD
0xffff60bf40000000-0xffff60bf40200000           2M PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60bf40200000-0xffff60bf41800000          22M PMD       ro NX SHD
AF NG     BLK UXN    MEM/NORMAL
0xffff60bf41800000-0xffff60bf41890000         576K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL
0xffff60bf41890000-0xffff60c04022e000     4171384K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c04022e000-0xffff60c04022f000           4K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c04022f000-0xffff60c042a3c000       41012K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c042a3c000-0xffff60c042a3d000           4K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c042a3d000-0xffff60c043431000       10192K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c043431000-0xffff60c043432000           4K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c043432000-0xffff60c0448e8000       21208K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c0448e8000-0xffff60c0448e9000           4K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c0448e9000-0xffff60c0448ed000          16K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c0448ed000-0xffff60c0448ee000           4K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c0448ee000-0xffff60c044a6b000        1524K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c044a6b000-0xffff60c044a6c000           4K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c044a6c000-0xffff60c044a74000          32K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c044a74000-0xffff60c044a75000           4K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c044a75000-0xffff60c044aaa000         212K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c044aaa000-0xffff60c044aab000           4K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c044aab000-0xffff60c053000000      234836K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c053000000-0xffff60c080000000         720M PMD
0xffff60c080000000-0xffff610000000000         254G PUD
0xffff610000000000-0xffff800000000000          31T PGD
---[ Linear Mapping end ]---


For example, for the below,
0xffff60c04022e000-0xffff60c04022f000           4K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c04022f000-0xffff60c042a3c000       41012K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED

41012K PTE is really big, don't we have a chance to make it
block/cont-pte mapped by
some alignment tricks such as,

0xffff60c04022e000-0xffff60c04022f000           4K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c04022e000-0xffff60c040230000          4K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL-TAGGED
0xffff60c040230000-0xffff60c040400000-         4K PTE       CONT..
0xffff60c040400000-                                           2MB PMD.....

>
> And rodata_full might be false because
> CONFIG_RODATA_FULL_DEFAULT_ENABLED was disabled at build time.
>
> > >  }
> > >
> > >  static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
> > > --
> > > 2.35.3
> > >
> >
> > Thanks
> > Barry
>
> --
> Sincerely yours,
> Mike.

Thanks
Barry
