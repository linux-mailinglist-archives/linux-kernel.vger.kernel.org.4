Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C1E66A9F5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjANHbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjANHbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:31:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD835A4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:31:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BF0AB80768
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 07:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C35C433D2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 07:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673681470;
        bh=zEyEzMqlR9KyjIqpVAhgLyRYglNdaJsA26MrOtE9Dz8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nXRz8j+f0p1JaChjx3A5gDMShA/DWBnCMHv+cAHzmI8SRkMphSvQ5OUERC7xDLXhv
         bWZCsJAEbcKmuB2UL5MzXug/JdC4oQTLAGshNwix+3eF+9ZaI3/VdsKWGjjurU34bN
         +ML+zr/YkOKjToLZ/GhE364bH/xAuzQawhVRPr4aCG/gCB29/WZJq0V/oI7BxLJOwd
         mVjyrfM49fExPKA8SlSkXYC3KbCNPWbGt6fOmQm8lGDaoe4YjNrgk1nqC6QaR1rKTT
         ZTRgYEL6gv/akSDCv//wPtmPn/lYRieAW4RoKndrOpRXgLcEuoLgf5bh7FhacSJrfY
         HCX1w8aGXrBKg==
Received: by mail-ed1-f42.google.com with SMTP id v10so32875595edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:31:10 -0800 (PST)
X-Gm-Message-State: AFqh2kqbNRnKUOmt6vok2YhtCB4d+PnE+9bCNss2r5IiuPeQIGXQEPoy
        Gs6n+Cr9MxQExfs1k0gTXcz7aEAJOueIsH5n044=
X-Google-Smtp-Source: AMrXdXumtWatGsNRrNeeJZMbpdNkJmS00RHh09gB7LnsHlrZX/t/R6X4a+Uf+qkNzyv1zoCZ8UNBGutl843iqS1GOuw=
X-Received: by 2002:aa7:c497:0:b0:49d:aca5:9ae0 with SMTP id
 m23-20020aa7c497000000b0049daca59ae0mr134972edq.106.1673681468792; Fri, 13
 Jan 2023 23:31:08 -0800 (PST)
MIME-Version: 1.0
References: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
 <1673255274-18238-3-git-send-email-tangyouling@loongson.cn>
 <c54bc8ac-fcc2-1cd4-56bc-167b094aec45@loongson.cn> <effce90b-f035-5502-4aa6-0f222406cd17@loongson.cn>
In-Reply-To: <effce90b-f035-5502-4aa6-0f222406cd17@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 14 Jan 2023 15:30:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6pq-CPg=co=HV=b-oupErK_+xjh3puHGAAE+Sbb1foew@mail.gmail.com>
Message-ID: <CAAhV-H6pq-CPg=co=HV=b-oupErK_+xjh3puHGAAE+Sbb1foew@mail.gmail.com>
Subject: Re: [PATCH 2/4] LoongArch: Add JUMP_LINK_ADDR macro implementation to
 avoid using la.abs
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Jinyang He <hejinyang@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

But JUMP_LINK_ADDR looks fine to me. :)

Huacai

On Sat, Jan 14, 2023 at 3:25 PM Youling Tang <tangyouling@loongson.cn> wrot=
e:
>
> Hi, Jinyang
>
> On 01/14/2023 02:40 PM, Jinyang He wrote:
> >
> > On 2023-01-09 17:07, Youling Tang wrote:
> >> Add JUMP_LINK_ADDR macro implementation to avoid using la.abs.
> >>
> >> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/stackframe.h |  8 ++++++++
> >>   arch/loongarch/kernel/head.S            | 10 ++++------
> >>   arch/loongarch/power/suspend_asm.S      |  5 ++---
> >>   3 files changed, 14 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/stackframe.h
> >> b/arch/loongarch/include/asm/stackframe.h
> >> index 96c94035b5d0..f538b3a6d680 100644
> >> --- a/arch/loongarch/include/asm/stackframe.h
> >> +++ b/arch/loongarch/include/asm/stackframe.h
> >> @@ -216,4 +216,12 @@
> >>       RESTORE_SP_AND_RET \docfi
> >>       .endm
> >>   +/* Jump to the virtual address of the link. */
> >> +    .macro JUMP_LINK_ADDR
> >
> > Hi, Youling
> >
> >
> > IMHO the JUMP_CACHE_ADDR is more suitable. And it not clear higt bits,
> > although the result always true currently. Lastly, this macro clobbers
> > t0 and t1, I'd suggest pass them in as args.
>
> Ok, I will modify it as follows=EF=BC=9A
>
>          .macro JUMP_CACHE_ADDR temp1 temp2
>          li.d    \temp1, CACHE_BASE
>          pcaddi  \temp2, 0
>          or      \temp1, \temp1, \temp2
>          jirl    zero, \temp1, 0xc
>          .endm
>
> There is also an alternative name "JUMP_DMW1_ADDR" for discussion.
>
> Thanks,
> Youling
>
> >
> >
> > Thanks,
> >
> > Jinyang
> >
> >> +    li.d    t0, CACHE_BASE
> >> +    pcaddi    t1, 0
> >> +    or    t0, t0, t1
> >> +    jirl    zero, t0, 0xc
> >> +    .endm
> >> +
> >>   #endif /* _ASM_STACKFRAME_H */
> >> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head=
.S
> >> index aa6181714ec3..e8a4bf9d7599 100644
> >> --- a/arch/loongarch/kernel/head.S
> >> +++ b/arch/loongarch/kernel/head.S
> >> @@ -52,9 +52,8 @@ SYM_CODE_START(kernel_entry)            # kernel
> >> entry point
> >>         /* We might not get launched at the address the kernel is
> >> linked to,
> >>          so we jump there.  */
> >> -    la.abs        t0, 0f
> >> -    jr        t0
> >> -0:
> >> +    JUMP_LINK_ADDR
> >> +
> >>       /* Enable PG */
> >>       li.w        t0, 0xb0        # PLV=3D0, IE=3D0, PG=3D1
> >>       csrwr        t0, LOONGARCH_CSR_CRMD
> >> @@ -106,9 +105,8 @@ SYM_CODE_START(smpboot_entry)
> >>       li.d        t0, CSR_DMW1_INIT    # CA, PLV0
> >>       csrwr        t0, LOONGARCH_CSR_DMWIN1
> >>   -    la.abs        t0, 0f
> >> -    jr        t0
> >> -0:
> >> +    JUMP_LINK_ADDR
> >> +
> >>       /* Enable PG */
> >>       li.w        t0, 0xb0        # PLV=3D0, IE=3D0, PG=3D1
> >>       csrwr        t0, LOONGARCH_CSR_CRMD
> >> diff --git a/arch/loongarch/power/suspend_asm.S
> >> b/arch/loongarch/power/suspend_asm.S
> >> index eb2675642f9f..596a682a7924 100644
> >> --- a/arch/loongarch/power/suspend_asm.S
> >> +++ b/arch/loongarch/power/suspend_asm.S
> >> @@ -78,9 +78,8 @@ SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL=
)
> >>       li.d        t0, CSR_DMW1_INIT    # CA, PLV0
> >>       csrwr        t0, LOONGARCH_CSR_DMWIN1
> >>   -    la.abs        t0, 0f
> >> -    jr        t0
> >> -0:
> >> +    JUMP_LINK_ADDR
> >> +
> >>       la.pcrel    t0, acpi_saved_sp
> >>       ld.d        sp, t0, 0
> >>       SETUP_WAKEUP
> >
>
