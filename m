Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC74711282
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbjEYRkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbjEYRkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:40:07 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FDD19C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:39:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af2db78b38so9335841fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1685036396; x=1687628396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvotGdSeJEkge/b3ttPXelgK85DYS8pQFKgHga3n2Gg=;
        b=L7s7f6E/roTH2qqgoVMKc9eoLjSfY0CTExLwLbLMz9L9WKDU4qNU4wPFiLZGPzGXKT
         qNv051C65wDRnArtGqPKM8t+QVH+MkRzjMvkGQ3Wlv6nqQPNB6hmt9JP7bHNegHJkMw9
         y/P4aO0V555E+WaHY0x/OTi/en+RY03zmtcd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685036396; x=1687628396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvotGdSeJEkge/b3ttPXelgK85DYS8pQFKgHga3n2Gg=;
        b=kmCOizcNjlmVeSKt8FS+2wRiLXGHcQB3dpa5CpnRAvravAonJAVc3MCN0VLbHT47zL
         ekB2mIOQIhVVCO0sZI+FZrOgfqdWt4lVpmEMyYgE49c3QLcU0QjNIqW3kM/DYd5GnMrI
         twnuZt8tbYmcNdwzeq6nAAHSnpokhPWoAdQAuWS5+AnxfWE7oT23RubHoiF84PT1PNvA
         c2XaXmo2LLlvAfISv3+f3ZFjbvS8EHPrJNjUrOrUxe14ShyDsEjqI0z2njHbn+uT8hjJ
         gsN7o8lc5CzdWYNHaF088oxs2H/heXPO2DaOd3par5QZYEULalzWL1hAtFIyXipU3jf/
         LInQ==
X-Gm-Message-State: AC+VfDyH8k/8NIQyw7QIP9b+BB9YLkjEZvA0UNzXHeMi0tF1ZBFmtu4M
        nyQ3jq2ntMyHkifhtbbrnHkPRure9IR7gi1C00ds
X-Google-Smtp-Source: ACHHUZ4asHjlRHQo9glk94sftK3Yhg4i4wdzARQcQ2m9eykg4+/R+RNtCbER9ZlasWSTbQ0fkuULO9/hWVZ/oEYfn/k=
X-Received: by 2002:a05:651c:116:b0:2aa:474f:16e with SMTP id
 a22-20020a05651c011600b002aa474f016emr1095376ljb.30.1685036396440; Thu, 25
 May 2023 10:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr> <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
 <CAOnJCULpa-TJuG=TtCDOxOdUviZzWheLE-GMiU1r7GWaKn0nuQ@mail.gmail.com>
 <20230525-guacamole-swimmer-68048a73baac@wendy> <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
 <20230525-postnasal-monopoly-98adb96ffaa1@wendy> <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
 <20230525-shrapnel-precut-26500fca4a48@wendy> <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
 <20230525-citric-waged-a2f78d27eb0c@wendy>
In-Reply-To: <20230525-citric-waged-a2f78d27eb0c@wendy>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 25 May 2023 10:39:44 -0700
Message-ID: <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Anup Patel <anup@brainfault.org>,
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

On Thu, May 25, 2023 at 7:21=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Thu, May 25, 2023 at 07:29:46PM +0530, Anup Patel wrote:
> > On Thu, May 25, 2023 at 7:26=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > >
> > > On Thu, May 25, 2023 at 07:13:11PM +0530, Anup Patel wrote:
> > > > On Thu, May 25, 2023 at 7:08=E2=80=AFPM Conor Dooley <conor.dooley@=
microchip.com> wrote:
> > > > >
> > > > > On Thu, May 25, 2023 at 06:51:28PM +0530, Anup Patel wrote:
> > > > >
> > > > > > > We should only rely on this node name for known bad versions =
of opensbi
> > > > > > > IMO. Going forward, if something needs to be reserved for fir=
mware, the
> > > > > > > firmware should make sure that it is reserved by using the pr=
operty for
> > > > > > > that purpose :)
> > > > >
> > > > > > There is no issue with OpenSBI since it does the right thing by=
 marking
> > > > > > memory as reserved in the DT. This real issue is with the kerne=
l handling
> > > > > > of reserved memory for hibernate.
> > > > >
> > > > > I don't think we are talking about the same thing here. I meant t=
he
> > > > > no-map property which OpenSBI does not set.
> > > >
> > > > Yes, we are talking about the same thing. It's not just OpenSBI not
> > > > setting no-map property in reserved memory node because other
> > > > SBI implementations would be doing the same thing (i.e. not setting
> > > > no-map property)
> > >
> > > Other SBI implementations doing the same thing doesn't make it any mo=
re
> > > correct though, right?
> >
> > Like multiple folks suggested, we need DT binding for distinguishing
> > firmware reserved memory from other reserved memory.
>
> And I have agreed with multiple times!
>
> > Until that
> > happens we should either mark hibernate support as experimental
> > or revert it.
>
> That works for me. How about the below?
>

Instead of disabling hibernate support why not revert the patch
3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
which doesn't add any "measured" value at this point.
However, keeping the hibernation feature on and disabling linear
mapping will get more
testing on hibernation. While disabling hibernation and keeping the above p=
atch
which doesn't have any value at all.

We don't have a regression at this point. So either approach will work thou=
gh.

If we choose to go this route, some thoughts about the commit message.
> -- >8 --
> From 1d4381290a1600eff9b29b8ace6be73955d9726c Mon Sep 17 00:00:00 2001
> From: Conor Dooley <conor.dooley@microchip.com>
> Date: Thu, 25 May 2023 15:09:08 +0100
> Subject: [PATCH] RISC-V: mark hibernation as broken
>
> Hibernation support depends on firmware marking its reserved
> regions as not mappable by Linux. As things stand, the de-facto SBI

either not mappable or no save/restore capable (as We still have not
concluded which way we want to go in)

> implementation (OpenSBI) does not do this, and other implementations may
> not do so either, resulting in kernel panics during hibernation ([1],
> [2]).
>

we should probably add more context in the commit message.
How about adding something along these lines:

As things stand, the latest version of de-facto SBI
implementation(OpenSBI) doesn't
do this any more to allow 1G huge page mappings by kernel. Other SBI
implementations are probably
doing the same. Until the commit 3335068 ("riscv: Use PUD/P4D/PGD
pages for the linear mapping"),
the first 2MB region of DRAM (where the typically firmware resides)
was not mappable by kernel. However,
enabling that mapping resulted in the kernel panics during hibernation
([1], [2]) as the hibernation process
tries to save/restore any mapped region even though it is marked as reserve=
d.


> Disable support for hibernation until such time that an SBI
> implementation independent way to communicate what regions are reserved
> has been agreed upon.
>

Anybody who wants to test the hibernation feature must revert the
above mentioned patch along with turning on
the config.

> Reported-by: Song Shuai <suagrfillet@gmail.com>
> Link: https://lore.kernel.org/all/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF_vhB+vm_1=
dHJxPNi75YDQ_Q@mail.gmail.com/ [1]
> Reported-by: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ITXwaKfA6z8
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 13f058490608..b2495192f35a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -801,7 +801,7 @@ menu "Power management options"
>  source "kernel/power/Kconfig"
>
>  config ARCH_HIBERNATION_POSSIBLE
> -       def_bool y
> +       def_bool n
>
>  config ARCH_HIBERNATION_HEADER
>         def_bool HIBERNATION
> --
> 2.39.2
>


--
Regards,
Atish
