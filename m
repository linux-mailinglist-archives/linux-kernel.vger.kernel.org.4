Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847C471294B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243981AbjEZPXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbjEZPXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:23:01 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7BA198
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:22:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30aa76048fbso563605f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685114578; x=1687706578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm0BztWeWOmSQyeDDYBVgxkYKsdv3ZjzePzlrRRXGLo=;
        b=ItxSceabl815FbWyIm+ZIKMnJoKMo2E0buhhE2Ou7PcOYfbNkW+ndTa7bOwj8NCysX
         7Wi6trkIznJYsoDVz/ujsnU6j0lTesYq0ibj9hdvGrUpqLgiV8kyxf4LIIAYLaeHgVXN
         sGEdvqipKnyTiimg+oNAK2qtS8edxgGthQjeoJC59N3CS/QkxwsHNok1c43FwjDgbmTN
         KCZaDrPZV4NUHzzmmjemc64mPu5ZMZIolW8p0M87+GOjNBRraA1NWpoSxvE0cimA6Tn6
         QOWIEJJCcFtY/PvmDqzeBqScttP/QkPxgu31i0uya5BhYiEMsRUH/Li9jW5zjfnpwKlR
         iBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685114578; x=1687706578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xm0BztWeWOmSQyeDDYBVgxkYKsdv3ZjzePzlrRRXGLo=;
        b=XPnAsokLbio1rPOh0Ne/XxcbwQYKmN661ckcbX2CgsHxmHnKSOsYjt++2LyYZJRewg
         xPHAmiO8g7xuu9INWOqmpDdWtlLDIWmBddWCCgTzM3OeNbX3m8x81Oe1ncfnnrHi+Xw1
         2rqUS0KdgQaYUfkBnosU/BtE9hCBiKPtprE2LR0CHzBbfFQqMVFlEW4Qlp2JAGXdmAlw
         FAMA18MuicI29vTexHErG8QvQwxvGkfec9X0o4Qzh3nrHjQjYF0iYsF2xeOa0CrxXkeW
         nwjBkO+p/COYHVJucWAWb1QPOR3PPOlveiLrt5YPghskFXjdHqSpJKiL3iQ6fPsNl23A
         KcaA==
X-Gm-Message-State: AC+VfDxJQUy3lyjohPDgEXzmpzDXl/f3Y1vgMQPnFebq11hoGY4fp8Jt
        QAoUeyjXiZv9dY7EELlew5PSe+aLuh8LN61cs8QcgA==
X-Google-Smtp-Source: ACHHUZ61QWWYN5nYT1QLRB6g7Ao0U+3BXvCyZL/2rjs5jWs+Ay7wIyU4jmrWZW+vt6O/oDtOyS18YVFVzkDfK+5yx+E=
X-Received: by 2002:adf:e990:0:b0:306:42bb:53be with SMTP id
 h16-20020adfe990000000b0030642bb53bemr1829219wrm.10.1685114577926; Fri, 26
 May 2023 08:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230525-shrapnel-precut-26500fca4a48@wendy> <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
 <20230525-citric-waged-a2f78d27eb0c@wendy> <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
 <20230525-flaring-trading-f2bf0713ae26@spud> <CAOnJCUK_EgX-En1QNS8yX1WA1nj8w2kpvXMQcvgWuR3dvzEQYw@mail.gmail.com>
 <20230525-desecrate-imposing-d97ab34e06ad@spud> <CAOnJCUKfRv68Bh8ue=ZhMGxai9_UEHLpm3553g2c2NXh-RP-TQ@mail.gmail.com>
 <20230525-batting-botch-7e03393a2d97@spud> <CAHVXubiDezbwZO6X2btvgpq-XqHnxZjXzaMnSK2YrHc_ioLx8Q@mail.gmail.com>
 <20230526-steep-omen-a5a46a1086bf@spud> <f82e7d3d-a16d-593e-7513-753b5cbf28af@ghiti.fr>
 <CAAhSdy0_XqiB=1w3hnYkipPj1aF_D=z=MD2fKLxk6rb_iDdBow@mail.gmail.com>
In-Reply-To: <CAAhSdy0_XqiB=1w3hnYkipPj1aF_D=z=MD2fKLxk6rb_iDdBow@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Fri, 26 May 2023 17:22:47 +0200
Message-ID: <CAHVXubj2oHJGwbfEukxRg58xHyVOieTdCa5wjHsR5XZ8rmxjgg@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Anup Patel <anup@brainfault.org>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 5:17=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Fri, May 26, 2023 at 8:42=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> >
> > On 26/05/2023 16:59, Conor Dooley wrote:
> > > On Fri, May 26, 2023 at 03:14:33PM +0200, Alexandre Ghiti wrote:
> > >> Hi everyone,
> > >>
> > >> On Thu, May 25, 2023 at 11:24=E2=80=AFPM Conor Dooley <conor@kernel.=
org> wrote:
> > >>> On Thu, May 25, 2023 at 01:06:04PM -0700, Atish Patra wrote:
> > >>>> On Thu, May 25, 2023 at 11:39=E2=80=AFAM Conor Dooley <conor@kerne=
l.org> wrote:
> > >>>>> On Thu, May 25, 2023 at 11:37:40AM -0700, Atish Patra wrote:
> > >>>>>
> > >>>>>> Any testing of hibernation still needs to revert the patch until=
 we
> > >>>>>> have the proper fix.
> > >>>>> "the patch" is what exactly? I assume you don't mean depending on
> > >>>>> NONPORTABLE, since that is a Kconfig option.
> > >>>> Nope. Sorry I meant the commit
> > >>>>
> > >>>> 3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> > >>> Ah, if your SBI implementation is one of the affected ones, yeah.
> > >>> If not, you can just set NONPORTABLE :)
> > >> @Bj=C3=B6rn T=C3=B6pel emitted the idea of excluding from the hibern=
ation all
> > >> the memory nodes in the "/reserved-memory" node
> > >> (https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/devi=
cetree/bindings/reserved-memory/reserved-memory.yaml):
> > >> I have to admit that I don't see why it is not done by default by th=
e
> > >> kernel.
> > > My understanding was that it was perfectly fine to use reserved memor=
y
> > > nodes to fence off some memory to use in device drivers etc, which th=
en
> > > may need to be saved/restored.
> >
> >
> > Agreed, but I would say that it's up to the driver then to take care of
> > that, see https://docs.kernel.org/driver-api/pm/notifiers.html
>
> I agree, it should be drivers responsibility to save/restore the dedicate=
d
> reserved memory used by itself.
>
> Although, I think we should at least save/restore reserved memory
> regions having "reusable" property set.

Good point! I'll propose an RFC and gather feedback from the people in
charge of the hibernation process.

>
> Regards,
> Anup
>
> >
> >
> > >> Unless there is stuff in this node that needs to be "hibernated", I
> > >> think that would be a very good solution since we would not rely on
> > >> the name of the "internal" nodes of "/reserved-memory" (i.e.
> > >> "mmode_resv").
> > >>
> > >> I'm digging into why it is not done by default, just wanted to have
> > >> your feedback before the week-end :)
