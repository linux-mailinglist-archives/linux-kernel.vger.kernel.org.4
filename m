Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96867F4D1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjA1Ey4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 23:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjA1Eyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:54:54 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5274680007
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:54:52 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso9886362pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ObgZJqkfXbaul8iomAcHjEWsLb4JiWzvLSbVQtBKOeo=;
        b=GUG5256oRfJCfG8UKX7hHPIJIKISN/4wdo9WcuaBbOlZ17fTSti+/BfPmBQwHwTmZj
         Z5TZnKhAmNfHDRgvgLiJWEIlC+FtatT/RPNcw9kugOe2o4FD/oeE7aGjgWXcxCdlyKTP
         Sul4PSpvTRMXggZPdPhVm9CUoo8CnPVd37hTH3zGr9hAKgDMZY0H9qfEXDadl8ym5Wiv
         k33UpTx+Yz5/eWk2y0j/134VTX0hAKYrHmEWGzur2I8WdLGLmFilgkYVQvFDJQh1xxr5
         r5uHHof+N7geW1eHL4FYc5K0OhHFnceW490kwJ0tHPELUGVJKn7QScqgUIzjt53KKJjE
         RW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObgZJqkfXbaul8iomAcHjEWsLb4JiWzvLSbVQtBKOeo=;
        b=R1ZnqK2reiWYJg+Gpr/x3mmxs6VI8lK9nMgVNU0jkeP5lwBNbPeD31AYZHaTzzvZ5a
         sc3sXQro52IqO8i4THgPbKGYhEzV9WK1UoPGBmfrGGcP5p5oo+NXAFy8kdRBI4IUNPN0
         uPYvjuKPfYmWvxdwoaKcabQh64J59ZXL+GWh2GxWFxKMyN75UeN+14UG3rbXy6UahzyO
         FNFzmgvvTd6Myb/JOnjxwphFcy/JC7A/2jmvj16hOzU9Eg/etg3ek9o/0grmfkcAKXsM
         qJd1JY3UfKQFUAZNKzSKZcnr2wmnin+NxJpbh1PlXpHazZqVnnHbwSZFyKF//s658tws
         lDYg==
X-Gm-Message-State: AO0yUKVl+Ojh/k6nn1GSWmOmRPBVEgx1CGEjxWLu4BV/W6Sq6ktsmGQt
        RPfRpdkjPpOmWoWfBGyAU3A1YR9f/EWEUSRWxVeoVuDjC5LtH0do
X-Google-Smtp-Source: AK7set/Wz1OexwcDdc44KCw94+Eb7qRVNXgQ1IqxaXRPV0yaKCAG6PaHLLsMIjFktaKVijK/0luph7ZIhNEE6tdOwrw=
X-Received: by 2002:a17:90a:64c5:b0:22b:ef05:ea5b with SMTP id
 i5-20020a17090a64c500b0022bef05ea5bmr2642665pjm.50.1674881691368; Fri, 27 Jan
 2023 20:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJ=0neiZ4wkPiMqJMT4E1O_xO0uLrTmEGUcnZMqxkw4UQ@mail.gmail.com>
 <CAGETcx8Xy5OzsbW3123esxsbQJq-SqDkP1S5g2mmwzoCz4shtQ@mail.gmail.com>
 <20230125190926.GA2697290-robh@kernel.org> <505fc434-c31f-726e-b1cb-0bbfd5f83490@linaro.org>
 <CAGETcx-f9vy7MDB2vFWP9CL26UY7W65oJArvhzksCu8QG6Y4nw@mail.gmail.com> <CAA8EJpo-mFxq+eGW=YaMxea+zi2Z64QWocuO36aNsM7Wmtu3sA@mail.gmail.com>
In-Reply-To: <CAA8EJpo-mFxq+eGW=YaMxea+zi2Z64QWocuO36aNsM7Wmtu3sA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Jan 2023 20:54:14 -0800
Message-ID: <CAGETcx-=2O_ZMLGSZrF7Q9Of3pbnieWFRJvzjTe0EVfGpgFSPQ@mail.gmail.com>
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

If you set fw_devlink=rpm in the command line. The default is just "on".

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

Thanks.

-Saravana
