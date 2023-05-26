Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B271712CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243259AbjEZSsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjEZSsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:48:46 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F256F13D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:48:40 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2af1c884b08so14656821fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1685126919; x=1687718919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fFXLC7rXbzzICb4uWYgI+q3GvH1gbWqD9s+YhYheVk=;
        b=aP1Z4hqt95NdHijFJEYNYIfnCHGEBewM1z08G57qdP3ITGyEVNuWG/WbMXkcqYjxnf
         SDV+fEzgfPlE9dlUZEG7nuSlarOhFHk+T59T717oX5WqatKbZNhiH24N8ZDMu2LBqTEP
         Mio30kYaI27lIJMXhW3m4yQ29BgFYQ0nTcNYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126919; x=1687718919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fFXLC7rXbzzICb4uWYgI+q3GvH1gbWqD9s+YhYheVk=;
        b=UzSh1QWpAhLTffEyVmfbM5FU1lw/pQRai2S5EAjtbfRKZuoD8doNjnbGlh3d6/Bhzc
         Gklf8V4YakL41goe7YjWJM6uyQZ7gQ2xEjH/0/IqDmsHpUUXyLwtYp+OzVP1ZuwpYRaG
         RK/VRj3MkumgexyfLUS98RV+Lux3hLiuudRrAEUhX6FI0LT81/hr71rpq1kXZoC6kfqJ
         C2Gu9VWkQAdYRggcxNYu1Ax2vwCLnHGVWU8C/MTph6YrYuYVcQtCCbjyyAIO8ZhDc20M
         YsUJwEesPA4XO9YXZIZrO6w601gycVsxH1C1p1PQEtO3fdwoZXLskUSmi9NkPpRCpzXZ
         0PUA==
X-Gm-Message-State: AC+VfDzvfMakTXRxmH8Dux1PVSuD2mFL3Cg3MNQb+a+XfA4w2tNBo15S
        8OjJ18BNnKcfXl+fMKEH8mvSYfF83IahgeJ5QPaR
X-Google-Smtp-Source: ACHHUZ7OlOCOqDXJiLiAQrC+hrddLdgM783sV5O9CAZiFex9Fdl67PZ5PunW+TbhFECau3TLYHD0XSbkGkXl1esAO4c=
X-Received: by 2002:a2e:9d8b:0:b0:2af:2786:271d with SMTP id
 c11-20020a2e9d8b000000b002af2786271dmr723853ljj.21.1685126919013; Fri, 26 May
 2023 11:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230525-shrapnel-precut-26500fca4a48@wendy> <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
 <20230525-citric-waged-a2f78d27eb0c@wendy> <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
 <20230525-flaring-trading-f2bf0713ae26@spud> <CAOnJCUK_EgX-En1QNS8yX1WA1nj8w2kpvXMQcvgWuR3dvzEQYw@mail.gmail.com>
 <20230525-desecrate-imposing-d97ab34e06ad@spud> <CAOnJCUKfRv68Bh8ue=ZhMGxai9_UEHLpm3553g2c2NXh-RP-TQ@mail.gmail.com>
 <20230525-batting-botch-7e03393a2d97@spud> <CAHVXubiDezbwZO6X2btvgpq-XqHnxZjXzaMnSK2YrHc_ioLx8Q@mail.gmail.com>
 <20230526-steep-omen-a5a46a1086bf@spud> <f82e7d3d-a16d-593e-7513-753b5cbf28af@ghiti.fr>
 <CAAhSdy0_XqiB=1w3hnYkipPj1aF_D=z=MD2fKLxk6rb_iDdBow@mail.gmail.com> <CAHVXubj2oHJGwbfEukxRg58xHyVOieTdCa5wjHsR5XZ8rmxjgg@mail.gmail.com>
In-Reply-To: <CAHVXubj2oHJGwbfEukxRg58xHyVOieTdCa5wjHsR5XZ8rmxjgg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 26 May 2023 11:48:27 -0700
Message-ID: <CAOnJCU+2PHToCSWdauh5CarUa8iNcE4Ugv3gj=TiLVVoevU_iQ@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Anup Patel <anup@brainfault.org>, Alexandre Ghiti <alex@ghiti.fr>,
        Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>, robh@kernel.org,
        jeeheng.sia@starfivetech.com, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
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

On Fri, May 26, 2023 at 8:22=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> On Fri, May 26, 2023 at 5:17=E2=80=AFPM Anup Patel <anup@brainfault.org> =
wrote:
> >
> > On Fri, May 26, 2023 at 8:42=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr>=
 wrote:
> > >
> > >
> > > On 26/05/2023 16:59, Conor Dooley wrote:
> > > > On Fri, May 26, 2023 at 03:14:33PM +0200, Alexandre Ghiti wrote:
> > > >> Hi everyone,
> > > >>
> > > >> On Thu, May 25, 2023 at 11:24=E2=80=AFPM Conor Dooley <conor@kerne=
l.org> wrote:
> > > >>> On Thu, May 25, 2023 at 01:06:04PM -0700, Atish Patra wrote:
> > > >>>> On Thu, May 25, 2023 at 11:39=E2=80=AFAM Conor Dooley <conor@ker=
nel.org> wrote:
> > > >>>>> On Thu, May 25, 2023 at 11:37:40AM -0700, Atish Patra wrote:
> > > >>>>>
> > > >>>>>> Any testing of hibernation still needs to revert the patch unt=
il we
> > > >>>>>> have the proper fix.
> > > >>>>> "the patch" is what exactly? I assume you don't mean depending =
on
> > > >>>>> NONPORTABLE, since that is a Kconfig option.
> > > >>>> Nope. Sorry I meant the commit
> > > >>>>
> > > >>>> 3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> > > >>> Ah, if your SBI implementation is one of the affected ones, yeah.
> > > >>> If not, you can just set NONPORTABLE :)
> > > >> @Bj=C3=B6rn T=C3=B6pel emitted the idea of excluding from the hibe=
rnation all
> > > >> the memory nodes in the "/reserved-memory" node
> > > >> (https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/de=
vicetree/bindings/reserved-memory/reserved-memory.yaml):
> > > >> I have to admit that I don't see why it is not done by default by =
the
> > > >> kernel.
> > > > My understanding was that it was perfectly fine to use reserved mem=
ory
> > > > nodes to fence off some memory to use in device drivers etc, which =
then
> > > > may need to be saved/restored.
> > >
> > >
> > > Agreed, but I would say that it's up to the driver then to take care =
of
> > > that, see https://docs.kernel.org/driver-api/pm/notifiers.html
> >
> > I agree, it should be drivers responsibility to save/restore the dedica=
ted
> > reserved memory used by itself.
> >
> > Although, I think we should at least save/restore reserved memory
> > regions having "reusable" property set.
>

That would be certainly ideal. However, that piece of code has been
present for ages (last commit was in 2008!).
There may be a bunch of drivers written with this builtin assumption.

> Good point! I'll propose an RFC and gather feedback from the people in
> charge of the hibernation process.

Hopefully, it's not too bad.

>
> >
> > Regards,
> > Anup
> >
> > >
> > >
> > > >> Unless there is stuff in this node that needs to be "hibernated", =
I
> > > >> think that would be a very good solution since we would not rely o=
n
> > > >> the name of the "internal" nodes of "/reserved-memory" (i.e.
> > > >> "mmode_resv").
> > > >>
> > > >> I'm digging into why it is not done by default, just wanted to hav=
e
> > > >> your feedback before the week-end :)



--=20
Regards,
Atish
