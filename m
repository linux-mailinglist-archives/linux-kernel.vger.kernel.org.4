Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0385A6E4E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDQQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:11:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC744BC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B4436123C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 16:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8342C433A0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 16:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681747875;
        bh=C4EGbHWRWvbf1Co/9B86Lo/bmJDEE5g2SO9siCbNkcA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m3EUMWk2gKUfej1jQKjBD/waFLtLWtvn0ZCztXNqxWO3VRimLxys92V2GQ2DoNPDs
         J5bbAqDmYjYthQXTW1XU7wxuPS2NiDUEQy7aHR5cF3s6aaod2nPLzIdk6DU8LPHQRm
         gUOZiMVmmHuGH9s9avzdks+dvV7PgXV/zXrl+RVFmQToJo8Gjg3rBRF3B4z8GrRiGz
         6G+USir5uSXdgeCBszktP4ymZchO7e+dyxoH1DCPvZDWR+d+i/dZn6hd+zYukBiRTV
         oRTwgSI/XqulsUikDBOpdPWSZP7d0//JXxpqNi/G/OlgPe30VNija/NOEQzIdWvyVj
         JysAw1FjlUDkg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-187878a90e6so17113156fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:11:15 -0700 (PDT)
X-Gm-Message-State: AAQBX9dKMZgEUlfEktld4MbElqdGUeqarLVlE4L2DqoEEt8IAwWP/tvZ
        riHWscHqYxz+GaSFwBujfJw8mTKqA08THefkFFE=
X-Google-Smtp-Source: AKy350Z0Qauj1+D1n9LpMZ1r8hascCEjjvhVPYFUauMtAXJilCinMriJ3O3D6Dd3u59Q2IxyGH83TIJPbUzNQH9Doso=
X-Received: by 2002:a05:6870:7006:b0:17e:71a3:e509 with SMTP id
 u6-20020a056870700600b0017e71a3e509mr7324868oae.8.1681747874979; Mon, 17 Apr
 2023 09:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230307140522.2311461-1-ardb@kernel.org> <20230307140522.2311461-33-ardb@kernel.org>
 <e932c4c4-c0a5-76f0-20ee-1d0155d5b79e@arm.com>
In-Reply-To: <e932c4c4-c0a5-76f0-20ee-1d0155d5b79e@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Apr 2023 18:11:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXErE+kOPL=A3mOhZN66O12dQdJ60hN=vu0z6+YqqgPDMQ@mail.gmail.com>
Message-ID: <CAMj1kXErE+kOPL=A3mOhZN66O12dQdJ60hN=vu0z6+YqqgPDMQ@mail.gmail.com>
Subject: Re: [PATCH v3 32/60] arm64: head: allocate more pages for the kernel mapping
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

On Mon, 17 Apr 2023 at 17:48, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 07/03/2023 14:04, Ard Biesheuvel wrote:
> > In preparation for switching to an early kernel mapping routine that
> > maps each segment according to its precise boundaries, and with the
> > correct attributes, let's allocate some extra pages for page tables for
> > the 4k page size configuration. This is necessary because the start and
> > end of each segment may not be aligned to the block size, and so we'll
> > need an extra page table at each segment boundary.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/kernel-pgtable.h | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> > index 4d13c73171e1e360..50b5c145358a5d8e 100644
> > --- a/arch/arm64/include/asm/kernel-pgtable.h
> > +++ b/arch/arm64/include/asm/kernel-pgtable.h
> > @@ -80,7 +80,7 @@
> >                       + EARLY_PGDS((vstart), (vend), add)     /* each PGDIR needs a next level page table */  \
> >                       + EARLY_PUDS((vstart), (vend), add)     /* each PUD needs a next level page table */    \
> >                       + EARLY_PMDS((vstart), (vend), add))    /* each PMD needs a next level page table */
> > -#define INIT_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR, _end, EARLY_KASLR))
> > +#define INIT_DIR_SIZE (PAGE_SIZE * (EARLY_PAGES(KIMAGE_VADDR, _end, EARLY_KASLR) + EARLY_SEGMENT_EXTRA_PAGES))
> >
> >  /* the initial ID map may need two extra pages if it needs to be extended */
> >  #if VA_BITS < 48
> > @@ -101,6 +101,15 @@
> >  #define SWAPPER_TABLE_SHIFT  PMD_SHIFT
> >  #endif
> >
> > +/* The number of segments in the kernel image (text, rodata, inittext, initdata, data+bss) */
> > +#define KERNEL_SEGMENT_COUNT 5
> > +
> > +#if SWAPPER_BLOCK_SIZE > SEGMENT_ALIGN
> > +#define EARLY_SEGMENT_EXTRA_PAGES (KERNEL_SEGMENT_COUNT + 1)
>
> I'm guessing the block size for 4K pages is PMD, so you need these extra pages
> to define PTEs for the case where the section start/end addresses are not on
> exact 2MB boundaries? But in that case, isn't it possible that you would need 2
> extra PTE tables per segment - one for the start and one for the end?
>

The end of one segment is the start of another, so we need one at the
start, plus one each for each segment end.
