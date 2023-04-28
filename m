Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0566A6F1DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbjD1SXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjD1SXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:23:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FC63AB6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:22:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24736790966so257454a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682706179; x=1685298179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCXFgHTQkhGNXWoZ3xgGPjRCF21ZxsY2Kpx25NkwE7I=;
        b=37QW+YM5ZvLWyFN633kNBmscdBSvcmas7VB5Raw2VZNEqMmGbhaxHx/n8eK+hFMsAU
         coO+yXuTZ6AamdroeVCBaIVUTlQZr9sJaUfaXtC7QqhaCAuYqKwBGtKjV+UFX4Fwxvti
         GreR6LuzSIANGEB/TvVCHjR9HMHFO9NDy4d0Ts8vZBrXmEZ66I57o7Cb490Hr9QSd+D0
         /VFlGx5urbr3o756p9cTHEZmWayVPwFbplmLo5PLixDa5vZQs4C1wGee2YGBMVkHBP/j
         p6L+L5vhfpQ1XkVI5FEcXjgVkPNPSTQPBss767VG+P4JVqv4lJbzSz2UPLhiuAcZP7Bj
         Jnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682706179; x=1685298179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCXFgHTQkhGNXWoZ3xgGPjRCF21ZxsY2Kpx25NkwE7I=;
        b=YaFJJ/JM/torqj9uexhfy2LJuWtgi+pGjdjY7R2ebU+sAUO9rCiRaZeVgTW+CSU625
         pRNxAYTbV1vProTMuT1AsZw7YVBQMeuUSwN8YdEgSFVSF5dC6MGw7wqZ+gE5LHXKmXGp
         SjbORPgjyYeHOqsS3pF9sz+/dfYHojE1m0P9azPlhLdRN3oijEcSawZWVtPG5BRsb/ad
         KGGRKHgxVq/2gy84mK3DJijQnY7Vlla4YnHqZwOcNcxXPL2AEAofSgflt7JHaaztQ+fX
         5ki2NTQJwc36oYNDUSyhOP2v9H8QA4t1aRfbIv0+mcGLgfaxsi2ccrQEsAfdndaAh3OQ
         HOzQ==
X-Gm-Message-State: AC+VfDw9OjTYkPYEBnNSX+Eu5l2iX0wcDTdJ9PYt9V1zutQEq1TtTVrU
        SZaetCVXxdRNQMa6GuCsH2e+ObalXLpgp/9/SEI8lw==
X-Google-Smtp-Source: ACHHUZ4su9NNY3iNaycbxWy0TCjcpsgD9PZ9Eikcv5o3Pczho3O2wTJCBPTe5d5bOHtrKjxssDCiw7oIN7ya5sn5V/M=
X-Received: by 2002:a17:90a:bc92:b0:247:4c28:39a3 with SMTP id
 x18-20020a17090abc9200b002474c2839a3mr6515404pjr.16.1682706179241; Fri, 28
 Apr 2023 11:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230428-awx-v1-1-1f490286ba62@google.com> <CAMj1kXHskJLA7yfy1j4rLYPjscK6bsW0CGjmhpNYg5fuirwinA@mail.gmail.com>
In-Reply-To: <CAMj1kXHskJLA7yfy1j4rLYPjscK6bsW0CGjmhpNYg5fuirwinA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 28 Apr 2023 11:22:48 -0700
Message-ID: <CAKwvOdkpbZeG_W9kNHn4hadrkhrMCWjdEAq8rMUYi9rog3iz4A@mail.gmail.com>
Subject: Re: [PATCH] arm64: kernel: remove SHF_WRITE|SHF_EXECINSTR from .idmap.text
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Fangrui Song <maskray@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 11:17=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> Hi Nick,
>
> On Fri, 28 Apr 2023 at 19:09, <ndesaulniers@google.com> wrote:
> >
> > commit d54170812ef1 ("arm64: fix .idmap.text assertion for large kernel=
s")
> > modified some of the section assembler directives that declare
> > .idmap.text to be SHF_ALLOC instead of
> > SHF_ALLOC|SHF_WRITE|SHF_EXECINSTR.
> >
> > This patch fixes up the remaining stragglers that were left behind.
> >
> > Because .idmap.text is merged into .text,
>
> Nit: this is no longer the case: the ID map code is never executed via
> the kernel mapping, so we moved it into a special .rodata.text section
> that contains all generated code that should not have an executable
> mapping by default, but only when it gets copied and/or mapped into a
> different executable region.

Ah, sorry, I see IDMAP_TEXT is being placed in .rodata.text in
arch/arm64/kernel/vmlinux.lds.S, so it's just the synthetic .got then
that's affecting .text. So Fangrui's patch is meant to address that.
https://lore.kernel.org/linux-arm-kernel/20230428050442.180913-1-maskray@go=
ogle.com/

In that case, I'll drop this paragraph starting with "Because"; I
misspelled symbolizing anyways.

>
> This doesn't impact the correctness of the patch, so with this
> paragraph clarified:
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>
>
> > LLD will retain the
> > SHF_EXECINSTR on .text, in addition to the synthetic .got.  This doesn'=
t
> > matter to the kernel loader, but syzkaller is having trouble symboling
> > such sections. Clean this up while we additionally fix up syzkaller. Ad=
d
> > Fixes tag so that this doesn't precede related change in stable.
> >
> > Fixes: d54170812ef1 ("arm64: fix .idmap.text assertion for large kernel=
s")
> > Reported-by: Greg Thelen <gthelen@google.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/arm64/kernel/cpu-reset.S | 2 +-
> >  arch/arm64/kernel/sleep.S     | 2 +-
> >  arch/arm64/mm/proc.S          | 6 +++---
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-rese=
t.S
> > index 6b752fe89745..c87445dde674 100644
> > --- a/arch/arm64/kernel/cpu-reset.S
> > +++ b/arch/arm64/kernel/cpu-reset.S
> > @@ -14,7 +14,7 @@
> >  #include <asm/virt.h>
> >
> >  .text
> > -.pushsection    .idmap.text, "awx"
> > +.pushsection    .idmap.text, "a"
> >
> >  /*
> >   * cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2)
> > diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> > index 2ae7cff1953a..2aa5129d8253 100644
> > --- a/arch/arm64/kernel/sleep.S
> > +++ b/arch/arm64/kernel/sleep.S
> > @@ -97,7 +97,7 @@ SYM_FUNC_START(__cpu_suspend_enter)
> >         ret
> >  SYM_FUNC_END(__cpu_suspend_enter)
> >
> > -       .pushsection ".idmap.text", "awx"
> > +       .pushsection ".idmap.text", "a"
> >  SYM_CODE_START(cpu_resume)
> >         mov     x0, xzr
> >         bl      init_kernel_el
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index 91410f488090..c2cb437821ca 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -167,7 +167,7 @@ alternative_else_nop_endif
> >  SYM_FUNC_END(cpu_do_resume)
> >  #endif
> >
> > -       .pushsection ".idmap.text", "awx"
> > +       .pushsection ".idmap.text", "a"
> >
> >  .macro __idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
> >         adrp    \tmp1, reserved_pg_dir
> > @@ -201,7 +201,7 @@ SYM_FUNC_END(idmap_cpu_replace_ttbr1)
> >
> >  #define KPTI_NG_PTE_FLAGS      (PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_=
FLAGS)
> >
> > -       .pushsection ".idmap.text", "awx"
> > +       .pushsection ".idmap.text", "a"
> >
> >         .macro  kpti_mk_tbl_ng, type, num_entries
> >         add     end_\type\()p, cur_\type\()p, #\num_entries * 8
> > @@ -400,7 +400,7 @@ SYM_FUNC_END(idmap_kpti_install_ng_mappings)
> >   * Output:
> >   *     Return in x0 the value of the SCTLR_EL1 register.
> >   */
> > -       .pushsection ".idmap.text", "awx"
> > +       .pushsection ".idmap.text", "a"
> >  SYM_FUNC_START(__cpu_setup)
> >         tlbi    vmalle1                         // Invalidate local TLB
> >         dsb     nsh
> >
> > ---
> > base-commit: 22b8cc3e78f5448b4c5df00303817a9137cd663f
> > change-id: 20230428-awx-c73f4bde79c4
> >
> > Best regards,
> > --
> > Nick Desaulniers <ndesaulniers@google.com>
> >



--=20
Thanks,
~Nick Desaulniers
