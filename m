Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4EB74B3F0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjGGPPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGGPPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:15:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E591124
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:15:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so10493a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688742924; x=1691334924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YXbXsbvOMlSuicNXAF0XnpxUQZnLmXnnBQdiqFD9L8=;
        b=t4S/cANiXbmvMjg9+iRh0/IUjvHNBWpdExMO3qEfwLtAOxOu8i17aSOIbYffXTeRTu
         OKp74t6UeZyQ3Wu2VuHtLDul06uY5qxhbyGNBqKHAqvm6OgOJZIQUNsVx1M8qFVaJOHT
         /YYQlBdOuzxN7OQeG4vY/nNpG8q6mBdk6pJlZWQ29wMjSVXFQwG3rVORMAh+nlTabczn
         z9teO4aBAJ8L6IN6oLsO3pmjHYF/97RkDx0KYPy7J1ttsyo0K7nJHdwPkIkLBlPrFUN2
         j62yOPvI5e+b5qsy1uPFPp3l20a6nrKrS8qyTf2jy9GaTo/AJH6Tj0sfAbQ4EL4esZo4
         YEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688742924; x=1691334924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YXbXsbvOMlSuicNXAF0XnpxUQZnLmXnnBQdiqFD9L8=;
        b=RHmKs9bih8oMOfOXNXUYj/1UXHJ67v1N0hbp7pET85EpD6kcZAwgjkBgecrPXjqfdT
         6RsdMmh0x/IV8X2o4LY6wdBCs+aOD9E+ni9w+L+EW6dpCFAeu+H0ThCosYtAM7/6N8Ov
         rBb0z8jtnmpiXm43oKS+476oXuG12Za0TOe1pU1mdDnulBYmgoqF4+8OYzREv78mP1ot
         isV51vwmETUSZxXu59ERzHJUNTN4qoKug4M6K2VFFvcGre1zLcIAAoAxfD77YHPEriCs
         4OQN3FP5NmX/PPy9/GdneG8v5rktMtlq0C8DPabDjHTp1KaoSLjv5UZtjLrUoje/aOqk
         WlzQ==
X-Gm-Message-State: ABy/qLaxis2ZJQMtvSJsQNLab/8RwoJoFsTp6CYAMxYD4SgeF6QWe1aR
        iXZ9U3i/lTdAeb3dtJbostjiNLGL4qtjbYeToAmioQ==
X-Google-Smtp-Source: APBJJlHqjh/fZar1rgohrt2gtrlPwgYw4AjqLbpsFPgJk65Dv3UNdqDGvcGVoreA/B+W4gTpmze0/YcfamzATkg2Vfk=
X-Received: by 2002:a50:d682:0:b0:514:92e4:ab9f with SMTP id
 r2-20020a50d682000000b0051492e4ab9fmr74276edi.7.1688742923708; Fri, 07 Jul
 2023 08:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230704050744.1196293-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=WNLcw2JbMf7tfob2KgjB8eXTC0p1J4OYnQL4k3Mz3mgA@mail.gmail.com> <CAHwB_NJbtvXNCFj5=NMBXWCt1S1_WrgGij2Kqdr1omno66kVUw@mail.gmail.com>
In-Reply-To: <CAHwB_NJbtvXNCFj5=NMBXWCt1S1_WrgGij2Kqdr1omno66kVUw@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 7 Jul 2023 08:15:11 -0700
Message-ID: <CAD=FV=W5adfzPkP6dJGwfGO+mcbTdg8v9A0Sd4-FozF+W7nSrA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Add avdd/avee delay for Starry-himax83102-j02
 and Starry-ili9882t panel
To:     cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        airlied@gmail.com, hsinyi@google.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 6, 2023 at 6:20=E2=80=AFPM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Hi,
>
> On Fri, Jul 7, 2023 at 3:32=E2=80=AFAM Doug Anderson <dianders@google.com=
> wrote:
> >
> > Hi,
> >
> > On Mon, Jul 3, 2023 at 10:07=E2=80=AFPM Cong Yang
> > <yangcong5@huaqin.corp-partner.google.com> wrote:
> > >
> > > From power on/off sequence for panel data sheet[1], T2 timing VSP to =
VSN
> > > needs 1ms delay when power on, and VSN to VSP also needs 1ms delay wh=
en
> > > power off. Some pmic may not be able to adjust the delay internally, =
so
> > > let's add a delay between avdd/avee regulator gpio to meet the timing=
 of
> > > panel.
> >
> > Unless I'm mistaken, all of this is best handled via regulator
> > constraints in the device tree. See the file:
> >
> > Documentation/devicetree/bindings/regulator/regulator.yaml
> >
> > Specifically, any delays related to actually ramping up / down the
> > regulator can be specified in the device tree. Nominally, you could
> > argue that the 1 ms delay actually _does_ belong in the driver, but
> > IMO the 1 ms number there is really just there because someone thought
> > it was weird to specify a delay of 0 ms. Given that you already need
> > remp delays in the device tree, it feels OK to me to just include the
> > 1 ms there.
>
> The regulator device tree has only the power on attribute
> "regulator-enable-ramp-delay",
> not has power off attribute. The regulator delay looks more like the
> HW voltage requirement
> of the power ic itself, and I just want to meet the panel spec
> requirement. I add regulator-enable-ramp-delay
> in dts he can also meet my requirement, but I have no way to control
> the power off delays.

Hmmm, I guess the fact that the delay needed can be different for
different boards / PMICs still makes me think that the delay doesn't
belong in the panel driver. Different boards using the same panel
would need different delays, right?

So, thinking more...

You're saying that you _can_ specify the enable delay in the device
tree, but not the disable one, right? However, the timing diagram you
provided doesn't seem to show the "disable" part. Since that's the
part we're talking about now, could you provide a more complete timing
diagram? Can you also talk to the panel vendor and confirm that the "1
ms" actually matters or if they just put that there to ensure
ordering? In other words, is it simply important that VDD1 gets to
~90% before you turn on VSP, or do they truly need a full 1 ms delay?

Can you provide any more details about the power IC you're using? Is
it just a discrete PMIC with a GPIO enable, or is it something
fancier? Correct me if I'm confused (entirely possible!), but I think
some PMICs have a feature where they can turn on "active discharge" so
that they ramp down more quickly when they're disabled. Any chance
your PMIC has this?

In general the fact that nobody has added
"regulator-disable-ramp-delay" to the regulator framework already
means that the problem you're facing isn't really a common problem.
There are lots of devices out there that have more than one regulator
but I don't see examples where drivers need to delay between turning
all their regulators off. Are you positive that this is something that
you really need to worry about?

The above is a bit rambling (sorry!), but I guess the summary is:

1. Please confirm that the panel driver truly needs 1 ms between
regulators enabled.

2. Please provide the power sequence diagram for disable. If there's a
1 ms delay between regulators being disabled then please confirm.

3. If the 1 ms delay isn't truly needed then we can just drop this patch, r=
ight?

4. IMO if the panel itself truly requires 1 ms between regulators
being enabled and/or disabled, it would be OK to put the 1 ms delay in
the driver but it feels wrong to be accounting for ramp time in the
driver. This should be specified in the device tree.

5. If we really need to account for the ramp down time, it would at
least be good to submit a regulator framework patch proposing a way to
specify this. We'd have to figure out how to make this work since I'd
imagine that most regulator consumers don't care that much about ramp
down time. Mark would be the real person to get advice from, but
perhaps an API call like "regulator_wait_discharged(percent)" that a
client could call?


-Doug
