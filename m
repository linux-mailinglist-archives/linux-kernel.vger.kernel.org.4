Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620BD6873CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjBBD1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjBBD1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:27:43 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D37C7A4AD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:27:41 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id cr11so292946pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 19:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NEs5w/Zuj5wi2jqaUcX6USJbxYIAIBIiduwj0besJYU=;
        b=Er9p4ruloeDgtE97PWkkgGUfOMgTWGb33ZGTtzso4x+xbGjyvYTtB3szmIC5iY+gBG
         UbGbF09HlC+/NT099w43eGqGvM7SaOjhHEx2E+B/4Qo+GJ3uVcOEi+suPTokZ1cjQmJQ
         RJ9Oo/9PhDsk7TZRoChqnxAAn5ryxPkfP9pALXBwvS5IJjpQPy7t7It5+O/yKXhqZC87
         dysYwdK1TiMwAqv2CWWfpGVG4lgeJPKyLairBIs9nAkhR5XD8Zaz8Js/V4QwFhexldP/
         10aqJe4HAkgjE04U4wPDH6KVqghzg9hKbVnVLrnen+qxt96CiPDpj50GrT5iT5t7NWR5
         SBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEs5w/Zuj5wi2jqaUcX6USJbxYIAIBIiduwj0besJYU=;
        b=dPbXphw4LGFJMHJkIWirGn6w0wXGBZOTbEJkZmcMCudZYj0hdnSwMakZFljK8z7cd7
         uTk9QkcQ4lgdVqJHuXv8i+hrEOefMY09ZnfYBz6u0wn8bBKHXKefEaVZLZ4ghJhOQKNN
         YRl+Ul+9p1Bxl/wyQKuXAkY130VCQOhO2QQcbOWzbA74I703mBh4RIycqMnOOywXVCFY
         hw5EjI+g3Mmam0QKCGcrax8jdVHsjE8wOJ2OiKJYtDKkowqHmTnweaYgACqPqq8HQs0A
         g5BFfFFotyPDwN/8E2MqGPWLGxIaEI/RTABc1ZNVGHxZymmdmH3SteArO78PRA1BahKv
         Y4OQ==
X-Gm-Message-State: AO0yUKXdNbFHLVW1BubUDWyrXlMDhFHnOh9/Txx2LPWhMKj9KNn2ltJh
        jpebUniXNM4Bw3y2HV7q5e0NRpxzR2d9pbDFH6HQ4A==
X-Google-Smtp-Source: AK7set822feNK2aygLQhxg0zxiYQdkrAh7n34aKi0XQ7S7HdOj1+Gw0U91RA9yWTIGj9Fw8fujtqKQHV5HIhDmdGVxs=
X-Received: by 2002:a65:408d:0:b0:4de:7028:d2fc with SMTP id
 t13-20020a65408d000000b004de7028d2fcmr825133pgp.122.1675308460516; Wed, 01
 Feb 2023 19:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJ=0neiZ4wkPiMqJMT4E1O_xO0uLrTmEGUcnZMqxkw4UQ@mail.gmail.com>
 <CAGETcx8Xy5OzsbW3123esxsbQJq-SqDkP1S5g2mmwzoCz4shtQ@mail.gmail.com>
 <20230125190926.GA2697290-robh@kernel.org> <505fc434-c31f-726e-b1cb-0bbfd5f83490@linaro.org>
 <CAGETcx-f9vy7MDB2vFWP9CL26UY7W65oJArvhzksCu8QG6Y4nw@mail.gmail.com> <CAA8EJpo-mFxq+eGW=YaMxea+zi2Z64QWocuO36aNsM7Wmtu3sA@mail.gmail.com>
In-Reply-To: <CAA8EJpo-mFxq+eGW=YaMxea+zi2Z64QWocuO36aNsM7Wmtu3sA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Feb 2023 19:27:03 -0800
Message-ID: <CAGETcx-koZH3U7fHXErxOHESdvLME1O+2hs2j-OixoYcmmpMgQ@mail.gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 8:41 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 27 Jan 2023 at 01:12, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Jan 26, 2023 at 2:51 PM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On 25/01/2023 21:09, Rob Herring wrote:
> > > > On Tue, Jan 24, 2023 at 06:12:15PM -0800, Saravana Kannan wrote:
> > > >> On Wed, Jan 18, 2023 at 5:35 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > >>>
> > > >>> On Wed, Jan 18, 2023 at 3:11 AM Dmitry Baryshkov
> > > >>> <dmitry.baryshkov@linaro.org> wrote:
> > > >>>>
> > > >>>> Do not create device link for clock controllers. Some of the clocks
> > > >>>> provided to the device via OF can be the clocks that are just parents to
> > > >>>> the clocks provided by this clock controller. Clock subsystem already
> > > >>>> has support for handling missing clock parents correctly (clock
> > > >>>> orphans). Later when the parent clock is registered, clocks get
> > > >>>> populated properly.
> > > >>>>
> > > >>>> An example of the system where this matters is the SDM8450 MTP board
> > > >>>> (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
> > > >>>> clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
> > > >>>> dispcc itself provides clocks to both PHYs, to the PHY parent device,
> > > >>>> etc. With just dsi0_phy in place devlink is able to break the
> > > >>>> dependency, but with two PHYs, dispcc doesn't get probed at all, thus
> > > >>>> breaking display support.
> > > >>>>
> > > >>>> Cc: Bjorn Andersson <andersson@kernel.org>
> > > >>>> Cc: Stephen Boyd <sboyd@kernel.org>
> > > >>>> Cc: Saravana Kannan <saravanak@google.com>
> > > >>>> Cc: Abel Vesa <abel.vesa@linaro.org>
> > > >>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > >>>> ---
> > > >>>>
> > > >>>> This patch has been posted a year ago in January 2022 ([1]). Since that time
> > > >>>> Saravana failed to produce patches to assist in debugging the issue
> > > >>>> ([2]) or to fix the issue ([3]). The issue we observe has been described
> > > >>>> by Abel at ([4]). As we work on adding support for Dual DSI
> > > >>>> configurations, the issue becomes more and more important, since binding
> > > >>>> the whole display subsystem fails.
> > > >>
> > > >> I did send out a patch series[1] to try and fix this. Heck I even
> > > >> talked about this in LPC 2022. So I don't think it's accurate to say I
> > > >> didn't help debug this or fix this. There's some email thread in lore
> > > >> where Abel gave more details and I figured out the issue and we didn't
> > > >> need any more debugging. And then I sent out [1]. Sorry I missed you
> > > >> in the cc lise for [1] -- I try to keep track of everyone to cc but
> > > >> things slip through the cracks sometimes. But at the same time, it's
> > > >> easy to check for emails from me before saying I didn't help or didn't
> > > >> send out fixes :)
> > > >>
> > > >> If you do try to give [1] a shot, there are a bunch of bugs that
> > > >> people pointed out for which I gave fixes on top of [1] in the
> > > >> replies. I was supposed to work on v2 over the holidays, but that
> > > >> didn't happen because of stuff outside my control.
> > > >>
> > > >>> That's ample time to fix this, so I intend to apply this. But I'll
> > > >>> give it a few days for comments.
> > > >>
> > > >> Rob, I'd recommend not applying this because it'll fix it for Dmitry
> > > >> but break someone else's use case. That's the whole reason it takes me
> > > >> a while to send out patches -- it's easy to fix it for a subset of
> > > >> devices, but fixing something without breaking someone else is harder
> > > >> (I still believe it's doable) and it takes a while to test them on all
> > > >> the devices I want to test before sending them out.
> > >
> > > This case is really simple, I think. Clock controllers (and
> > > clock-core-framework) are prepared to handle clock orphans properly.
> > > Moreover they have been supposed to work in such way for quite a while.
> > > In other words, I don't think we should save them from this
> > > -EPROBE_DEFERRED.
> >
> > A clock controller can depend on other clock controllers for non clock
> > tree reasons. For example, it might need a clock ON to access its
> > registers. So, while the CCF can handle orphans properly, that's not
> > the only dependency. Also, fw_devlink is not just about probing
> > either. It also has to do with proper sync_state() callbacks.
>
> Just a question, please excuse if I'm misunderstanding it. Does
> fw_devlink created this way also impose any runtime PM dependencies?
>
> >
> > Also, I already fixed the issue you are referring to while not
> > breaking the conditions I'm referring to. So, I don't know why you are
> > so opposed to that. See Abel's Tested-by here:
> > https://lore.kernel.org/lkml/YvonlAwXAoXTUTZe@linaro.org/
> >
> > > Thus I think it is better to let them continue doing their job of
> > > handling probe deferrals on their own, at least for the time being.
> >
> > I'm pretty sure your patch will break other Qualcomm platforms because
> > they depend on sync_state() callbacks to boot up properly when
> > all/most of their drivers are built as modules.
>
> Qualcomm platforms did not use sync state for clock controllers. Only
> for the icc drivers.
>
> >
> > > And
> > > then, when your patches are finished, we can think about reenabling
> > > current behaviour. As a reminder, currently, all Qualcomm platforms
> > > trying to use double DSI configuration are broken and have to use
> > > fw_devlink= kernel params.
> >
> > I'm/was working on sending out the v2 when I got your email. Hold
> > tight please. It shouldn't take too long.
>
> I'll give v2 a test next week, thank you!

Nudge... I rushed out the series for you.

-Saravana
