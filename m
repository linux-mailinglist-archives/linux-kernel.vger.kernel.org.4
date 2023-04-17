Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034506E4A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjDQODX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDQODV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA50A5E8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:02:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9466961F70
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0336DC433D2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681740158;
        bh=/aj2kxjDjxMZXCp+hbUCCGeAdGkQJOc96BhIovT09SA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tuZeja+q33z5yeb+kKJNJXU2D6KZnbW7PVKQiuUbCq1vIwYZMVrxYnzQk9R4cOB/T
         cMxB+I+McTgSEX2YeFxJeguLury7bki94KQooIKCNg6QKi3BPZ3Iubn3jgxf5IdYjM
         w9OavINFRaEhKDj6ir+SoFeOOIg2GUWRcmW/sPTvHolv6xqhSgsEEE54vV2sLqvix+
         ze9IKKierYr2eEOQvZxJUUTxz9SGLKMiwGFt2O2EEPAAmPV2paZANdJpWDVRJAOJ5c
         I4a76zz4x2av0Ph1zhTgwGZnkcUshgt0TroXizBOmI1D9JhIpuky3+4wqiyLQRN7TC
         aS/5yKMYLFb3g==
Received: by mail-lj1-f181.google.com with SMTP id o8so5513995ljp.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:02:36 -0700 (PDT)
X-Gm-Message-State: AAQBX9dEx3kOADS/tHbgLGPmBbatsDry/HuL1a8my2ZSmBoinKKy8JFV
        7TDHIKh8acyXNdbAvB/godEynmKWHvxdkdGZiec=
X-Google-Smtp-Source: AKy350Y1uN3cUp2Py+tJ/p7xYYYlMlVRt/tDHSFKxNJUAZYTwNxd+mTdkOt5rVcsjd+GNhGaEUyKef693qlIscy2quI=
X-Received: by 2002:a2e:a177:0:b0:2a7:6a4a:8017 with SMTP id
 u23-20020a2ea177000000b002a76a4a8017mr4689366ljl.2.1681740155055; Mon, 17 Apr
 2023 07:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230307140522.2311461-1-ardb@kernel.org> <20230307140522.2311461-26-ardb@kernel.org>
 <37412bd5-9e73-024f-26ab-a351853bc846@arm.com>
In-Reply-To: <37412bd5-9e73-024f-26ab-a351853bc846@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Apr 2023 16:02:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEQ3YZ9NCQRjDbwjD3MS9BUJb8HbcoOeS7SVEFTWMurLQ@mail.gmail.com>
Message-ID: <CAMj1kXEQ3YZ9NCQRjDbwjD3MS9BUJb8HbcoOeS7SVEFTWMurLQ@mail.gmail.com>
Subject: Re: [PATCH v3 25/60] arm64: head: Clear BSS and the kernel page
 tables in one go
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 at 16:00, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 07/03/2023 14:04, Ard Biesheuvel wrote:
> > We will move the CPU feature overrides into BSS in a subsequent patch,
> > and this requires that BSS is zeroed before the feature override
> > detection code runs. So let's map BSS read-write in the ID map, and zero
> > it via this mapping.
> >
> > Since the kernel page tables are right next to it, and also zeroed via
> > the ID map, let's drop the separate clear_page_tables() function, and
> > just zero everything in one go.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/head.S | 33 +++++++-------------
> >  1 file changed, 11 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 0fa44b3188c1e204..ade0cb99c8a83a3d 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -177,17 +177,6 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
> >       ret
> >  SYM_CODE_END(preserve_boot_args)
> >
> > -SYM_FUNC_START_LOCAL(clear_page_tables)
> > -     /*
> > -      * Clear the init page tables.
> > -      */
> > -     adrp    x0, init_pg_dir
> > -     adrp    x1, init_pg_end
> > -     sub     x2, x1, x0
> > -     mov     x1, xzr
> > -     b       __pi_memset                     // tail call
> > -SYM_FUNC_END(clear_page_tables)
> > -
> >  /*
> >   * Macro to populate page table entries, these entries can be pointers to the next level
> >   * or last level entries pointing to physical memory.
> > @@ -386,9 +375,9 @@ SYM_FUNC_START_LOCAL(create_idmap)
> >
> >       map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
> >
> > -     /* Remap the kernel page tables r/w in the ID map */
> > +     /* Remap BSS and the kernel page tables r/w in the ID map */
> >       adrp    x1, _text
> > -     adrp    x2, init_pg_dir
> > +     adrp    x2, __bss_start
> >       adrp    x3, _end
> >       bic     x4, x2, #SWAPPER_BLOCK_SIZE - 1
> >       mov     x5, SWAPPER_RW_MMUFLAGS
> > @@ -489,14 +478,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
> >       mov     x0, x20
> >       bl      set_cpu_boot_mode_flag
> >
> > -     // Clear BSS
> > -     adr_l   x0, __bss_start
> > -     mov     x1, xzr
> > -     adr_l   x2, __bss_stop
> > -     sub     x2, x2, x0
> > -     bl      __pi_memset
> > -     dsb     ishst                           // Make zero page visible to PTW
> > -
> >  #if VA_BITS > 48
> >       adr_l   x8, vabits_actual               // Set this early so KASAN early init
> >       str     x25, [x8]                       // ... observes the correct value
> > @@ -780,6 +761,15 @@ SYM_FUNC_START_LOCAL(__primary_switch)
> >       adrp    x1, reserved_pg_dir
> >       adrp    x2, init_idmap_pg_dir
> >       bl      __enable_mmu
> > +
> > +     // Clear BSS
> > +     adrp    x0, __bss_start
> > +     mov     x1, xzr
> > +     adrp    x2, init_pg_end
> > +     sub     x2, x2, x0
> > +     bl      __pi_memset
> > +     dsb     ishst                           // Make zero page visible to PTW
>
> Is it possible to add an assert somewhere (or at the very least a comment in
> vmlinux.lds.S) to ensure that nothing gets inserted between the BSS and the page
> tables? It feels a bit fragile otherwise.
>

I'm not sure that matters. The contents are not covered by the loaded
image so they are undefined otherwise in any case.

> I also wonder what's the point in calling __pi_memset() from here? Why not just
> do it all in C?
>

That happens in one of the subsequent patches.
