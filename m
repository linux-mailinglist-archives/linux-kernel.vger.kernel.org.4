Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ED972EE46
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbjFMVwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjFMVwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:52:09 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48047B8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:52:07 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f9a81da5d7so92411cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686693127; x=1689285127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JArSp3KOZfDk0T3BlWpL2SI3E0Iekw9ms5ihIkc+nFM=;
        b=31VfF2rFtQfd+eGV2VUbMAsXwWlGzpXbb7LC2L2mALkilUk8ewlPBJrGoguowu4ix/
         BlS9gmQVXqEP/dbFDpGlJcfrB2TodNldcnVoeakyZZzEpd9WVV9fIS16ruNS99ulYoBU
         ++KADeo8f7ECZJUuIl3gou/Zg3oO2oS2pb+kkT1ICbqfqsVqKXrVNNMaYcXFWMJI5glB
         ZJeNgqxqrk8bwgn7G4/7vMh3rSIzrfDuW7oXPdDNW953RaQit1xEqQybSjl+qdR+IbLm
         G2IzonA25YTzuA2PXkiMjCeHUdBIZfZlfOOIzG0RA7Tcox76V/5zUrmjB34wI9FlC985
         hjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686693127; x=1689285127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JArSp3KOZfDk0T3BlWpL2SI3E0Iekw9ms5ihIkc+nFM=;
        b=PurhCYM8OBIU5crwCx1iwN5awdzhfSMscxMmD2e30TkhihaSX/MykMHDpYDIrPsjdu
         AyzeY6P5gVJIqq9XliQXrZ1kHCypIeAe4K3e65xhsLlCOKAieBkl44GWHw/FwXbl6muN
         Jp23Fvx93hXvo3RW8UxSQxHTa+ItjyFhctSzEortZeBulrRDk8FbnvuaiMAR/1mkmYgU
         FOpMEl+rA8cTMD5ZioatSgIDNEH1KnTH4U5TrFpT8oRxFWEqcrswau1CXb9IgqjCa47D
         jZUsjr2AjwhiQgCbO+Nwi9zhjSVvY+ffRMHDuKKcXrhCTg4D7UgGy5EgaJJD75r5Ppj9
         5eBw==
X-Gm-Message-State: AC+VfDyLp3y0rnbJnlqfm1duL670BXCj5L5ju772McRWp9jJchRY/A0F
        +b2B7iilOWQXMDrUtf3yqVd7v+I5JI8F5IH8tCk5ZbWsGo71v9Z3zs8=
X-Google-Smtp-Source: ACHHUZ6eqyrWpd9ZQfes1o6bBidPoYDZBxY9968p6UI796rpR/4U/pX8S0FmE+Y1UVdWq+F9ajxp87Cz5qH9ngxFpkc=
X-Received: by 2002:a05:622a:315:b0:3f9:a770:7279 with SMTP id
 q21-20020a05622a031500b003f9a7707279mr9489qtw.9.1686693127027; Tue, 13 Jun
 2023 14:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230423223210.126948-1-maskray@google.com> <CAFP8O3LksO-4JAoRnx9ND0E9rRyqb6xsUsGtBVQXOsaYxLmhBQ@mail.gmail.com>
In-Reply-To: <CAFP8O3LksO-4JAoRnx9ND0E9rRyqb6xsUsGtBVQXOsaYxLmhBQ@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Tue, 13 Jun 2023 14:51:56 -0700
Message-ID: <CAFP8O3JSaZ6D=nGoVu+-_t2HZBLX7M8wggALWKNWH=PnubY8yA@mail.gmail.com>
Subject: Re: [PATCH] riscv: replace deprecated scall with ecall
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
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

On Thu, May 11, 2023 at 3:41=E2=80=AFPM Fangrui Song <maskray@google.com> w=
rote:
>
> On Sun, Apr 23, 2023 at 3:32=E2=80=AFPM Fangrui Song <maskray@google.com>=
 wrote:
> >
> > scall is a deprecated alias for ecall. ecall is used in several places,
> > so there is no assembler compatibility concern.
> >
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > ---
> >  arch/riscv/kernel/entry.S             | 4 ++--
> >  arch/riscv/kernel/vdso/rt_sigreturn.S | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 99d38fdf8b18..2f51935612d1 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -191,7 +191,7 @@ handle_syscall:
> >         REG_S a0, PT_ORIG_A0(sp)
> >         /*
> >          * Advance SEPC to avoid executing the original
> > -        * scall instruction on sret
> > +        * ecall instruction on sret
> >          */
> >         addi s2, s2, 0x4
> >         REG_S s2, PT_EPC(sp)
> > @@ -603,6 +603,6 @@ END(excp_vect_table)
> >  #ifndef CONFIG_MMU
> >  ENTRY(__user_rt_sigreturn)
> >         li a7, __NR_rt_sigreturn
> > -       scall
> > +       ecall
> >  END(__user_rt_sigreturn)
> >  #endif
> > diff --git a/arch/riscv/kernel/vdso/rt_sigreturn.S b/arch/riscv/kernel/=
vdso/rt_sigreturn.S
> > index 0573705eac76..10438c7c626a 100644
> > --- a/arch/riscv/kernel/vdso/rt_sigreturn.S
> > +++ b/arch/riscv/kernel/vdso/rt_sigreturn.S
> > @@ -11,6 +11,6 @@ ENTRY(__vdso_rt_sigreturn)
> >         .cfi_startproc
> >         .cfi_signal_frame
> >         li a7, __NR_rt_sigreturn
> > -       scall
> > +       ecall
> >         .cfi_endproc
> >  ENDPROC(__vdso_rt_sigreturn)
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >
>
> Ping:)
>
>
> --
> =E5=AE=8B=E6=96=B9=E7=9D=BF

Ping^2 :)
