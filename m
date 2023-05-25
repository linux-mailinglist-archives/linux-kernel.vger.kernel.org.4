Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C379711743
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbjEYTU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243727AbjEYTUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:20:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D72A210C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:15:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510d1972d5aso4503095a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1685042012; x=1687634012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQFtlRq4aJTYhV0eQW9iMfrGDr0aZKTMQmG9jztszkI=;
        b=WFN8CXQQKEUo5pr5H5nyGxvmeQuV1Jk7efuIsYORcmzzqaTaHNKbYWCXRyY8uXJS7h
         SIWYI990XHy37kDvlNNiIXNo2IRLIrxDmJJ//vLfpzUCmhYlNtktr3N/mFgf8w3qvbZ8
         xe3lUg/Mer15loSxSdC0EdoIBoBfjL7L/7lOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685042012; x=1687634012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQFtlRq4aJTYhV0eQW9iMfrGDr0aZKTMQmG9jztszkI=;
        b=Vc62m3m4Ar+plBVwYkXz2wHmAEq8UZFkTxLoqXDt8rOa6Q6N+m3W2FiDUPLLx1bTS1
         3EY6Q3Q383a3afO6e6sa1v3hBnJqAhStboezqMojnCCxKTNDUMWzaszN0Qvf2dq+jvEZ
         oM/ZTooVAWikbS4GyLkQVCPlLlFrPsZXHgyekPUT6wEvo3OsFro6ooDO2mpQ4EhlWZ/9
         Q1ASpq8xHhxt4+ut/DL3hDerDb63/9qT5J5abj5rwZR/5QKZ1et3ktx4FbLgfv4SuG3i
         UECZP26qwZhiWay09cq8Eoh3yRz+0FHV+fk2mwQgIFrK+B9A4BXOGrYc5zcLQ12PCZCv
         ImOg==
X-Gm-Message-State: AC+VfDwwIXkurf6aSBIOWMJEM6lI17c7mnOn6BA+gEGgPsvZ54wKI84t
        aYAy63CmVzOyr3Z3H7IMLNdEhFEqffMX447kHqaxX1RFytGwixk=
X-Google-Smtp-Source: ACHHUZ4SiUCJDYi/eHZ7lZZIC387i25yihp4ohxzNlmqxJ4xLZFOa3yBjwJHhlwwLzLBC3jP8srlTLLSOJgyvbffquI=
X-Received: by 2002:a2e:9a91:0:b0:2af:22a0:81ec with SMTP id
 p17-20020a2e9a91000000b002af22a081ecmr1249470lji.27.1685039871757; Thu, 25
 May 2023 11:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
 <CAOnJCULpa-TJuG=TtCDOxOdUviZzWheLE-GMiU1r7GWaKn0nuQ@mail.gmail.com>
 <20230525-guacamole-swimmer-68048a73baac@wendy> <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
 <20230525-postnasal-monopoly-98adb96ffaa1@wendy> <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
 <20230525-shrapnel-precut-26500fca4a48@wendy> <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
 <20230525-citric-waged-a2f78d27eb0c@wendy> <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
 <20230525-flaring-trading-f2bf0713ae26@spud>
In-Reply-To: <20230525-flaring-trading-f2bf0713ae26@spud>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 25 May 2023 11:37:40 -0700
Message-ID: <CAOnJCUK_EgX-En1QNS8yX1WA1nj8w2kpvXMQcvgWuR3dvzEQYw@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alex@ghiti.fr>, robh@kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
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

On Thu, May 25, 2023 at 11:22=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> Hey Atish,
>
> On Thu, May 25, 2023 at 10:39:44AM -0700, Atish Patra wrote:
> > > How about the below?
>
> > Instead of disabling hibernate support why not revert the patch
> > 3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> > which doesn't add any "measured" value at this point.
> > However, keeping the hibernation feature on and disabling linear
> > mapping will get more testing on hibernation.
> > While disabling hibernation and keeping the above patch which
> > doesn't have any value at all.
> >
> > We don't have a regression at this point. So either approach will work =
though.
>
> I favoured this approach so that we do not release a kernel in which
> hibernate works for these versions of OpenSBI and then stops working in
> the future when we shore up how communicating this is supposed to work.
> It allows us to fix the problem "properly" in slow-time, instead of
> racing against v6.4's release.
>

Fair enough.

> I happened to be talking to Palmer and he suggested making it depend on
> NONPORTABLE:
> |> config NONPORTABLE
> |>      bool "Allow configurations that result in non-portable kernels"
> |>      help
> |>        RISC-V kernel binaries are compatible between all known systems
> |>        whenever possible, but there are some use cases that can only b=
e
> |>        satisfied by configurations that result in kernel binaries that=
 are
> |>        not portable between systems.
> |>
> |>        Selecting N does not guarantee kernels will be portable to all =
known
> |>        systems.  Selecting any of the options guarded by NONPORTABLE w=
ill
> |>        result in kernel binaries that are unlikely to be portable betw=
een
> |>        systems.
> |>
> |>        If unsure, say N.
>
> I actually think that that makes more sense, as it may actually be fine
> to use hibernation depending on what your SBI implementation does.
>

That works too.

> > If we choose to go this route, some thoughts about the commit message.
> > > -- >8 --
> > > From 1d4381290a1600eff9b29b8ace6be73955d9726c Mon Sep 17 00:00:00 200=
1
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > Date: Thu, 25 May 2023 15:09:08 +0100
> > > Subject: [PATCH] RISC-V: mark hibernation as broken
> > >
> > > Hibernation support depends on firmware marking its reserved
> > > regions as not mappable by Linux. As things stand, the de-facto SBI
> >
> > either not mappable or no save/restore capable (as We still have not
> > concluded which way we want to go in)
>
> s/mappable/accessible/? Sounds like a good catch all?
>

Yeah.

> >
> > > implementation (OpenSBI) does not do this, and other implementations =
may
> > > not do so either, resulting in kernel panics during hibernation ([1],
> > > [2]).
> > >
> >
> > we should probably add more context in the commit message.
> > How about adding something along these lines:
> >
> > As things stand, the latest version of de-facto SBI
> > implementation(OpenSBI) doesn't
> > do this any more to allow 1G huge page mappings by kernel. Other SBI
> > implementations are probably
> > doing the same. Until the commit 3335068 ("riscv: Use PUD/P4D/PGD
> > pages for the linear mapping"),
> > the first 2MB region of DRAM (where the typically firmware resides)
> > was not mappable by kernel. However,
> > enabling that mapping resulted in the kernel panics during hibernation
> > ([1], [2]) as the hibernation process
> > tries to save/restore any mapped region even though it is marked as res=
erved.
>
> SGTM, I could go with that.
>
> > > Disable support for hibernation until such time that an SBI
> > > implementation independent way to communicate what regions are reserv=
ed
> > > has been agreed upon.
> > >
> >
> > Anybody who wants to test the hibernation feature must revert the
> > above mentioned patch along with turning on
> > the config.
>
> This goes away with the use of non-portable, although I would work
> mention of the config option into the commit message.
>

Any testing of hibernation still needs to revert the patch until we
have the proper fix.

> Thanks,
> Conor.
>
> > > Reported-by: Song Shuai <suagrfillet@gmail.com>
> > > Link: https://lore.kernel.org/all/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF_vhB+=
vm_1dHJxPNi75YDQ_Q@mail.gmail.com/ [1]
> > > Reported-by: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > > Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ITXwaKf=
A6z8
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  arch/riscv/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 13f058490608..b2495192f35a 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -801,7 +801,7 @@ menu "Power management options"
> > >  source "kernel/power/Kconfig"
> > >
> > >  config ARCH_HIBERNATION_POSSIBLE
> > > -       def_bool y
> > > +       def_bool n
> > >
> > >  config ARCH_HIBERNATION_HEADER
> > >         def_bool HIBERNATION
>


--=20
Regards,
Atish
