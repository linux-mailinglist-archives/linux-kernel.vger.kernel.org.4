Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DD067F514
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 06:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjA1F43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 00:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjA1F40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 00:56:26 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633327E6AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:56:25 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso9752129pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=078JXI0aD01ymwFx0uG5jk0C6dS/LJ4okQ9GXwoX1pA=;
        b=DGzDMlRHjWZDRyZn3N21eR747hrRin2fj/I3R47WcI8xji3d5bjYl79K74tB3dGDBE
         FhQbsqoTeG+0nY8Oq9GrJuPDe/ehotXlsxaTg62GFpogdXQGbRGBG6OL9tGf24Oc2UZ1
         5c63xeJ0OUVPae9vFQXTtsNS1ps2hikHl50EoeuWspm4/4K85MECmAsFiV3j0vL/xOfk
         XlbuIxO1DtRJsi+CQ/uSt1rm1XGHCOrBqpxqgUl+rkvs7BZoEIrByFCjhamZJOzVeQiY
         QylDpUaTaIwh38AItcRxBsx2zXxplS7RPs5VYyABIDG8dS6rVbu+NW2c1Q3vz2GuWcxR
         +7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=078JXI0aD01ymwFx0uG5jk0C6dS/LJ4okQ9GXwoX1pA=;
        b=PeTL1bdSA/+XBWioPyh4Nbjf+NZeoc1mlcElZknThWyTMu3jo0wzEdW9hUtvDFRglb
         9LQe2SJnBs4f7h5sTdEpGxRHzDK6fGgyE16tgZAz+8UPJO1T4qTGQonfbF2F6mIF1Qz9
         0HkGwobdvEXmmq23GLJXYAsykytzQM+cO486HHU8hR9ZzQp56ceCTUt15CHDfBk5c4jQ
         K5Un7L0uGWD8qXXkA7dznDwOgrcWH+0uU+t9v9uKFGX+SnN+enUsOaCPcaaB/OMWvih9
         3LfEJh+63WGrZ4Rt06Z0cGuapGV9NmOrCzH1bHb3nIs+zdGcGR9Yv8JsJ9IWC30a9Vtx
         moTQ==
X-Gm-Message-State: AFqh2komsSZAxXo0GoSW5NOeacDGsjAQtwYWXjviG3CGcONfRD8GThuA
        oDSAbynF2tjWWaGvSZO9KGBViLW57NpaP/8k74xQ7lfu9ePgMPQz
X-Google-Smtp-Source: AMrXdXv2fe2Gj+3fkQ/N55tfxGCVG32i8qIsw2ipEF1qQYXn9XjrPPBk5ZSiM6lcrTEJ+BIkDz6H6oBEgjEpybF5e90=
X-Received: by 2002:a17:90a:1a03:b0:228:7eed:e756 with SMTP id
 3-20020a17090a1a0300b002287eede756mr6884737pjk.166.1674885384492; Fri, 27 Jan
 2023 21:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJ=0neiZ4wkPiMqJMT4E1O_xO0uLrTmEGUcnZMqxkw4UQ@mail.gmail.com>
 <CAGETcx8Xy5OzsbW3123esxsbQJq-SqDkP1S5g2mmwzoCz4shtQ@mail.gmail.com>
 <20230125190926.GA2697290-robh@kernel.org> <505fc434-c31f-726e-b1cb-0bbfd5f83490@linaro.org>
 <CAGETcx-f9vy7MDB2vFWP9CL26UY7W65oJArvhzksCu8QG6Y4nw@mail.gmail.com>
 <CAA8EJpo-mFxq+eGW=YaMxea+zi2Z64QWocuO36aNsM7Wmtu3sA@mail.gmail.com>
 <CAGETcx-=2O_ZMLGSZrF7Q9Of3pbnieWFRJvzjTe0EVfGpgFSPQ@mail.gmail.com> <68B27FAF-5D14-476C-A22D-4615487EDEA6@linaro.org>
In-Reply-To: <68B27FAF-5D14-476C-A22D-4615487EDEA6@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Jan 2023 21:55:47 -0800
Message-ID: <CAGETcx-sWZz8GWdhUqsXb9EKkKeiOi53SJrLUJGTOG1q9mZG0w@mail.gmail.com>
Subject: Re: [RESEND PATCH] of: property: do not create clocks device link for
 clock controllers
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 9:34 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> 28 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2023 =D0=B3. 07:54:14 GMT+03:00, =
Saravana Kannan <saravanak@google.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >On Fri, Jan 27, 2023 at 8:41 PM Dmitry Baryshkov
> ><dmitry.baryshkov@linaro.org> wrote:
> >>
> >> On Fri, 27 Jan 2023 at 01:12, Saravana Kannan <saravanak@google.com> w=
rote:
> >> >
> >> > On Thu, Jan 26, 2023 at 2:51 PM Dmitry Baryshkov
> >> > <dmitry.baryshkov@linaro.org> wrote:
> >> > >
> >> > > On 25/01/2023 21:09, Rob Herring wrote:
> >> > > > On Tue, Jan 24, 2023 at 06:12:15PM -0800, Saravana Kannan wrote:
> >> > > >> On Wed, Jan 18, 2023 at 5:35 AM Rob Herring <robh+dt@kernel.org=
> wrote:
> >> > > >>>
> >> > > >>> On Wed, Jan 18, 2023 at 3:11 AM Dmitry Baryshkov
> >> > > >>> <dmitry.baryshkov@linaro.org> wrote:
> >> > > >>>>
> >> > > >>>> Do not create device link for clock controllers. Some of the =
clocks
> >> > > >>>> provided to the device via OF can be the clocks that are just=
 parents to
> >> > > >>>> the clocks provided by this clock controller. Clock subsystem=
 already
> >> > > >>>> has support for handling missing clock parents correctly (clo=
ck
> >> > > >>>> orphans). Later when the parent clock is registered, clocks g=
et
> >> > > >>>> populated properly.
> >> > > >>>>
> >> > > >>>> An example of the system where this matters is the SDM8450 MT=
P board
> >> > > >>>> (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispc=
c uses
> >> > > >>>> clocks provided by dsi0_phy and dsi1_phy device tree nodes. H=
owever the
> >> > > >>>> dispcc itself provides clocks to both PHYs, to the PHY parent=
 device,
> >> > > >>>> etc. With just dsi0_phy in place devlink is able to break the
> >> > > >>>> dependency, but with two PHYs, dispcc doesn't get probed at a=
ll, thus
> >> > > >>>> breaking display support.
> >> > > >>>>
> >> > > >>>> Cc: Bjorn Andersson <andersson@kernel.org>
> >> > > >>>> Cc: Stephen Boyd <sboyd@kernel.org>
> >> > > >>>> Cc: Saravana Kannan <saravanak@google.com>
> >> > > >>>> Cc: Abel Vesa <abel.vesa@linaro.org>
> >> > > >>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> > > >>>> ---
> >> > > >>>>
> >> > > >>>> This patch has been posted a year ago in January 2022 ([1]). =
Since that time
> >> > > >>>> Saravana failed to produce patches to assist in debugging the=
 issue
> >> > > >>>> ([2]) or to fix the issue ([3]). The issue we observe has bee=
n described
> >> > > >>>> by Abel at ([4]). As we work on adding support for Dual DSI
> >> > > >>>> configurations, the issue becomes more and more important, si=
nce binding
> >> > > >>>> the whole display subsystem fails.
> >> > > >>
> >> > > >> I did send out a patch series[1] to try and fix this. Heck I ev=
en
> >> > > >> talked about this in LPC 2022. So I don't think it's accurate t=
o say I
> >> > > >> didn't help debug this or fix this. There's some email thread i=
n lore
> >> > > >> where Abel gave more details and I figured out the issue and we=
 didn't
> >> > > >> need any more debugging. And then I sent out [1]. Sorry I misse=
d you
> >> > > >> in the cc lise for [1] -- I try to keep track of everyone to cc=
 but
> >> > > >> things slip through the cracks sometimes. But at the same time,=
 it's
> >> > > >> easy to check for emails from me before saying I didn't help or=
 didn't
> >> > > >> send out fixes :)
> >> > > >>
> >> > > >> If you do try to give [1] a shot, there are a bunch of bugs tha=
t
> >> > > >> people pointed out for which I gave fixes on top of [1] in the
> >> > > >> replies. I was supposed to work on v2 over the holidays, but th=
at
> >> > > >> didn't happen because of stuff outside my control.
> >> > > >>
> >> > > >>> That's ample time to fix this, so I intend to apply this. But =
I'll
> >> > > >>> give it a few days for comments.
> >> > > >>
> >> > > >> Rob, I'd recommend not applying this because it'll fix it for D=
mitry
> >> > > >> but break someone else's use case. That's the whole reason it t=
akes me
> >> > > >> a while to send out patches -- it's easy to fix it for a subset=
 of
> >> > > >> devices, but fixing something without breaking someone else is =
harder
> >> > > >> (I still believe it's doable) and it takes a while to test them=
 on all
> >> > > >> the devices I want to test before sending them out.
> >> > >
> >> > > This case is really simple, I think. Clock controllers (and
> >> > > clock-core-framework) are prepared to handle clock orphans properl=
y.
> >> > > Moreover they have been supposed to work in such way for quite a w=
hile.
> >> > > In other words, I don't think we should save them from this
> >> > > -EPROBE_DEFERRED.
> >> >
> >> > A clock controller can depend on other clock controllers for non clo=
ck
> >> > tree reasons. For example, it might need a clock ON to access its
> >> > registers. So, while the CCF can handle orphans properly, that's not
> >> > the only dependency. Also, fw_devlink is not just about probing
> >> > either. It also has to do with proper sync_state() callbacks.
> >>
> >> Just a question, please excuse if I'm misunderstanding it. Does
> >> fw_devlink created this way also impose any runtime PM dependencies?
> >
> >If you set fw_devlink=3Drpm in the command line. The default is just "on=
".
>
> So you plan to switch to rpm at some point?

Ideally, but it's a loooong way off. I need to fix all the issues
people are pointing out right now before I try to go for that being
the default.

-Saravana
