Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD703710DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbjEYOAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbjEYOAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:00:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D091A6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:00:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510ea8d0bb5so3758929a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1685023198; x=1687615198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPrIK19LKsIekBL7Exksia/ZXnGLEugBzMWwwv5N8PY=;
        b=wNs1Dd0fiUT91Vm7v3vikIO0L1KvCJsboGzq0ADBHCcoGPEZ4zpEwIlq2IhdnByCXf
         kW2WUhlIKMZfmrsNqXKAj6AMmZ+8iepaAWzdRJZ/MOp78LOEyFwYN84kDdGs23JIG9++
         6Pn+2/ts1wzfGKG8uV6q+a43VlyjLwzs2JgUckVji0vbjIbKn/VrsQSl6OEw9EkJLGk6
         3c+viiBEJz5lBBVoXe/NvrXyiWPFZd253iqON2EmnwVqFRENvzCktcXaEUZamxXK6n5F
         J3Un2kC+khnAyKESeVqOxn001SL41oivn/U4NOwQ98sMfgUAF3sBVEMk9OBdNBYkIpZU
         TFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023198; x=1687615198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPrIK19LKsIekBL7Exksia/ZXnGLEugBzMWwwv5N8PY=;
        b=VqBmNgINA0AiAlR5k2d9i7LcHjxgm8r+cMZppiObKowDHUv2WHjHdrVypm9dttXY+Z
         qa1gIMJ5uJec+VUEzAvsNXj3VY/sfw0VUaBk+BvTIc09wOW2MkhYuUJuh6JG9F+OxWDv
         6Umpx0b473TXiqUsUo61vaC4rfZEOZNP5EsBhyDWxZ8kdCp6Rt8uYTWJvVCB5tox2BaL
         PnIDibbNZ6vSjkwDGxbvbI8TVRJ1c0r4MN8BQEDCrq4f4xKYCQuNDtvDb3J25xFZwsZ3
         mSULW9AUbYH1NaQ7r+S1i56KhWqkAGUHS3ZhktrXQ0tw4HsgtbA0wFO1Gd3xbLvYiPSG
         qn+Q==
X-Gm-Message-State: AC+VfDyFKTSle79zVyhNLSGGIuqdTmvwU843ifEy84iJkrghKiI8TAK9
        jGbH9bnT3l1PZFJrqRRI5jReMMMddEn879W79y7SZg==
X-Google-Smtp-Source: ACHHUZ7lf7ik+P2YwcQcVNg1huYeLbeYnW5Lw15SXlyDhIMtug3qin18sNXDOjx/aNLoN0GoixYAkLROtI4uNjlZhXw=
X-Received: by 2002:a17:906:5d13:b0:96f:893:7f5 with SMTP id
 g19-20020a1709065d1300b0096f089307f5mr2182403ejt.26.1685023198318; Thu, 25
 May 2023 06:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230517-preacher-primer-f41020b3376a@wendy> <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr> <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
 <CAOnJCULpa-TJuG=TtCDOxOdUviZzWheLE-GMiU1r7GWaKn0nuQ@mail.gmail.com>
 <20230525-guacamole-swimmer-68048a73baac@wendy> <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
 <20230525-postnasal-monopoly-98adb96ffaa1@wendy> <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
 <20230525-shrapnel-precut-26500fca4a48@wendy>
In-Reply-To: <20230525-shrapnel-precut-26500fca4a48@wendy>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 25 May 2023 19:29:46 +0530
Message-ID: <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 7:26=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Thu, May 25, 2023 at 07:13:11PM +0530, Anup Patel wrote:
> > On Thu, May 25, 2023 at 7:08=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > >
> > > On Thu, May 25, 2023 at 06:51:28PM +0530, Anup Patel wrote:
> > >
> > > > > We should only rely on this node name for known bad versions of o=
pensbi
> > > > > IMO. Going forward, if something needs to be reserved for firmwar=
e, the
> > > > > firmware should make sure that it is reserved by using the proper=
ty for
> > > > > that purpose :)
> > >
> > > > There is no issue with OpenSBI since it does the right thing by mar=
king
> > > > memory as reserved in the DT. This real issue is with the kernel ha=
ndling
> > > > of reserved memory for hibernate.
> > >
> > > I don't think we are talking about the same thing here. I meant the
> > > no-map property which OpenSBI does not set.
> >
> > Yes, we are talking about the same thing. It's not just OpenSBI not
> > setting no-map property in reserved memory node because other
> > SBI implementations would be doing the same thing (i.e. not setting
> > no-map property)
>
> Other SBI implementations doing the same thing doesn't make it any more
> correct though, right?

Like multiple folks suggested, we need DT binding for distinguishing
firmware reserved memory from other reserved memory. Until that
happens we should either mark hibernate support as experimental
or revert it.

Regards,
Anup

>
> > > > Like Atish mentioned, not just OpenSBI, there will be other entitie=
s
> > > > (like TSM) or some other M-mode firmware which will also reserve
> > > > memory in DT/ACPI so clearly kernel needs a SBI implementation
> > > > independent way of handling reserved memory for hibernate.
> > >
> > > > > > Another option is to use compatible string or label property to=
 indicate
> > > > > > that this memory region is not to be saved/restored during hibe=
rnation.
> > > > > > This can be documented in RISC-V DT bindings as well as the boo=
ting guide
> > > > > > doc that alex was talking about.
> > > > >
> > > > > Sure, a dt-binding for sbi reserved regions doesn't immediately s=
ound
> > > > > like an awful idea... But we still have to work around the borked
> > > > > firmware - be that disabling hibernation or using the mmode_resv =
node
> > > > > when we know that the version of OpenSBI is one of those with the
> > > > > problem.
> > >
> > > Did you skip over this? I was agreeing that defining a common binding=
 for
> > > sbi reserved regions was a good idea.
