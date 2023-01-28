Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B7967F4F1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 06:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjA1FeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 00:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjA1FeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 00:34:19 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD5E78AE0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:34:17 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so11398232lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PFc9Bqp/s6LvEU6NBrGeuzZwNhPu9cwcmp0caNBoEhE=;
        b=Ot+ovY9y7Ux8oySKcymjD4UAs0Qr99TGWW2Lz7aMoX5d8km9PHVfhjvpDzA0Ugy92k
         YvsKy01pv7EaEpl5PGi/WrmPFAw/ptHLRhGx+S+aXlKCNiez+1qIYhDvBskF9O105LQc
         rU9U6GCUPNHM8CGULSoctIzaDt6UdaJCLv2w86i/ZjFuVYlBm8Owd4+7H53iyA0NnMqR
         fQBsSvWsO22rFXA+frIOdvodZy/GWUMhSGO4w64+JkUPSIXMLE5uNJyiBIhtavV9ZxPc
         LVck/fXutsN8v5FkXEimIgGJ3XyIETpiHCRLhCDhNcm+GokpyYc7EeBM2RPJBYr4MZhz
         uKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PFc9Bqp/s6LvEU6NBrGeuzZwNhPu9cwcmp0caNBoEhE=;
        b=N9uCANl48A6J4aaFqICS8oUfqsRI+pentoI5azR9MReXeQFhI6w8620/TJh5jBgPkP
         NDi0yV2cDjgrzHXDpQvw+MVORLlLZknzalo82Y+iO/QpXjQ+qpFHf+LIrjrtUJ7pCWvz
         8MCulGTicVVEGZpreJuNnJHTWwxx4MoZwWcRBYzgZGDyx+w4f71ugShaf8nf9G8OzX5e
         gC3TBRDFGiStSuYhR/+Ua7vzAlykTkA4f3t3CHyvOeleEkZWqciYJr9pUe4facqe003g
         3Vtgy+ld5dN6oTrm9xVkJ1hcWQpbEfNZbLB3EOHdRGOf2cIG2k5O83twWUCol/P4J51p
         LtWw==
X-Gm-Message-State: AO0yUKV+/uZ93Ypn5Gk9Q5pcEBgfwNLhTL0/CUvUH9W5uMdYF7kN0zKZ
        6w1PcQdkcXkNLSS9pYy9gKKhkw==
X-Google-Smtp-Source: AK7set+RXPnlAwXB5x1FCe1rsbczE/1hYL1wZSNw+mZm6Po3PMaXEyP5mANKy9vxuoTe9u05F3yp2g==
X-Received: by 2002:a05:6512:3a8d:b0:4d8:5895:d7dc with SMTP id q13-20020a0565123a8d00b004d85895d7dcmr850341lfu.56.1674884055389;
        Fri, 27 Jan 2023 21:34:15 -0800 (PST)
Received: from [127.0.0.1] ([94.25.228.208])
        by smtp.gmail.com with ESMTPSA id c3-20020a196543000000b004cc7acfbd2bsm448531lfj.287.2023.01.27.21.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 21:34:14 -0800 (PST)
Date:   Sat, 28 Jan 2023 08:34:10 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
CC:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BRESEND_PATCH=5D_of=3A_property=3A_do_not_cre?= =?US-ASCII?Q?ate_clocks_device_link_for_clock_controllers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGETcx-=2O_ZMLGSZrF7Q9Of3pbnieWFRJvzjTe0EVfGpgFSPQ@mail.gmail.com>
References: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org> <CAL_JsqJ=0neiZ4wkPiMqJMT4E1O_xO0uLrTmEGUcnZMqxkw4UQ@mail.gmail.com> <CAGETcx8Xy5OzsbW3123esxsbQJq-SqDkP1S5g2mmwzoCz4shtQ@mail.gmail.com> <20230125190926.GA2697290-robh@kernel.org> <505fc434-c31f-726e-b1cb-0bbfd5f83490@linaro.org> <CAGETcx-f9vy7MDB2vFWP9CL26UY7W65oJArvhzksCu8QG6Y4nw@mail.gmail.com> <CAA8EJpo-mFxq+eGW=YaMxea+zi2Z64QWocuO36aNsM7Wmtu3sA@mail.gmail.com> <CAGETcx-=2O_ZMLGSZrF7Q9Of3pbnieWFRJvzjTe0EVfGpgFSPQ@mail.gmail.com>
Message-ID: <68B27FAF-5D14-476C-A22D-4615487EDEA6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2023 =D0=B3=2E 07:54:14 GMT+03:00, =
Saravana Kannan <saravanak@google=2Ecom> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>On Fri, Jan 27, 2023 at 8:41 PM Dmitry Baryshkov
><dmitry=2Ebaryshkov@linaro=2Eorg> wrote:
>>
>> On Fri, 27 Jan 2023 at 01:12, Saravana Kannan <saravanak@google=2Ecom> =
wrote:
>> >
>> > On Thu, Jan 26, 2023 at 2:51 PM Dmitry Baryshkov
>> > <dmitry=2Ebaryshkov@linaro=2Eorg> wrote:
>> > >
>> > > On 25/01/2023 21:09, Rob Herring wrote:
>> > > > On Tue, Jan 24, 2023 at 06:12:15PM -0800, Saravana Kannan wrote:
>> > > >> On Wed, Jan 18, 2023 at 5:35 AM Rob Herring <robh+dt@kernel=2Eor=
g> wrote:
>> > > >>>
>> > > >>> On Wed, Jan 18, 2023 at 3:11 AM Dmitry Baryshkov
>> > > >>> <dmitry=2Ebaryshkov@linaro=2Eorg> wrote:
>> > > >>>>
>> > > >>>> Do not create device link for clock controllers=2E Some of the=
 clocks
>> > > >>>> provided to the device via OF can be the clocks that are just =
parents to
>> > > >>>> the clocks provided by this clock controller=2E Clock subsyste=
m already
>> > > >>>> has support for handling missing clock parents correctly (cloc=
k
>> > > >>>> orphans)=2E Later when the parent clock is registered, clocks =
get
>> > > >>>> populated properly=2E
>> > > >>>>
>> > > >>>> An example of the system where this matters is the SDM8450 MTP=
 board
>> > > >>>> (see arch/arm64/boot/dts/qcom/sdm845-mtp=2Edts)=2E Here the di=
spcc uses
>> > > >>>> clocks provided by dsi0_phy and dsi1_phy device tree nodes=2E =
However the
>> > > >>>> dispcc itself provides clocks to both PHYs, to the PHY parent =
device,
>> > > >>>> etc=2E With just dsi0_phy in place devlink is able to break th=
e
>> > > >>>> dependency, but with two PHYs, dispcc doesn't get probed at al=
l, thus
>> > > >>>> breaking display support=2E
>> > > >>>>
>> > > >>>> Cc: Bjorn Andersson <andersson@kernel=2Eorg>
>> > > >>>> Cc: Stephen Boyd <sboyd@kernel=2Eorg>
>> > > >>>> Cc: Saravana Kannan <saravanak@google=2Ecom>
>> > > >>>> Cc: Abel Vesa <abel=2Evesa@linaro=2Eorg>
>> > > >>>> Signed-off-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eo=
rg>
>> > > >>>> ---
>> > > >>>>
>> > > >>>> This patch has been posted a year ago in January 2022 ([1])=2E=
 Since that time
>> > > >>>> Saravana failed to produce patches to assist in debugging the =
issue
>> > > >>>> ([2]) or to fix the issue ([3])=2E The issue we observe has be=
en described
>> > > >>>> by Abel at ([4])=2E As we work on adding support for Dual DSI
>> > > >>>> configurations, the issue becomes more and more important, sin=
ce binding
>> > > >>>> the whole display subsystem fails=2E
>> > > >>
>> > > >> I did send out a patch series[1] to try and fix this=2E Heck I e=
ven
>> > > >> talked about this in LPC 2022=2E So I don't think it's accurate =
to say I
>> > > >> didn't help debug this or fix this=2E There's some email thread =
in lore
>> > > >> where Abel gave more details and I figured out the issue and we =
didn't
>> > > >> need any more debugging=2E And then I sent out [1]=2E Sorry I mi=
ssed you
>> > > >> in the cc lise for [1] -- I try to keep track of everyone to cc =
but
>> > > >> things slip through the cracks sometimes=2E But at the same time=
, it's
>> > > >> easy to check for emails from me before saying I didn't help or =
didn't
>> > > >> send out fixes :)
>> > > >>
>> > > >> If you do try to give [1] a shot, there are a bunch of bugs that
>> > > >> people pointed out for which I gave fixes on top of [1] in the
>> > > >> replies=2E I was supposed to work on v2 over the holidays, but t=
hat
>> > > >> didn't happen because of stuff outside my control=2E
>> > > >>
>> > > >>> That's ample time to fix this, so I intend to apply this=2E But=
 I'll
>> > > >>> give it a few days for comments=2E
>> > > >>
>> > > >> Rob, I'd recommend not applying this because it'll fix it for Dm=
itry
>> > > >> but break someone else's use case=2E That's the whole reason it =
takes me
>> > > >> a while to send out patches -- it's easy to fix it for a subset =
of
>> > > >> devices, but fixing something without breaking someone else is h=
arder
>> > > >> (I still believe it's doable) and it takes a while to test them =
on all
>> > > >> the devices I want to test before sending them out=2E
>> > >
>> > > This case is really simple, I think=2E Clock controllers (and
>> > > clock-core-framework) are prepared to handle clock orphans properly=
=2E
>> > > Moreover they have been supposed to work in such way for quite a wh=
ile=2E
>> > > In other words, I don't think we should save them from this
>> > > -EPROBE_DEFERRED=2E
>> >
>> > A clock controller can depend on other clock controllers for non cloc=
k
>> > tree reasons=2E For example, it might need a clock ON to access its
>> > registers=2E So, while the CCF can handle orphans properly, that's no=
t
>> > the only dependency=2E Also, fw_devlink is not just about probing
>> > either=2E It also has to do with proper sync_state() callbacks=2E
>>
>> Just a question, please excuse if I'm misunderstanding it=2E Does
>> fw_devlink created this way also impose any runtime PM dependencies?
>
>If you set fw_devlink=3Drpm in the command line=2E The default is just "o=
n"=2E

So you plan to switch to rpm at some point?


