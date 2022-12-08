Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12AE6470F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLHNmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiLHNlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:41:49 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF7998574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:41:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 4so1568150pli.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 05:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nsVDMGdrrcenDbAQ2t+1J/nqCclkhOqEn3pqIwRUG2w=;
        b=uQy/0f7YV2jnlbCc1jSFqVrE4lbQvl+RRAJkhOLwNKMTRwuan4cjvWkayuWGs0R8oL
         vnygiP558bf0VxQTsmO1gMaSyfuPFtroV61zbBi/whfupcirDxi2CZL1YSNKEfXqDE+T
         5piNZUnqR67+TNZqTfGGTQsSVyDTmdMKrUSaB/GcKRURw0DdMy1ZRW3zLz+Mm9NTRcz4
         dXo/Fy6vLBQU6ntaMD3EpYjq2lVYXCLz0x7AANz9QfcsPOPKY33HoqaaBT3zcY9lcMkH
         yXHm35VDMvBDL6KcyGNoNfTrflmO5iPsaeb9inrWk2puhSN2S/QjoIr7Dnn/InlZbwtU
         f9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsVDMGdrrcenDbAQ2t+1J/nqCclkhOqEn3pqIwRUG2w=;
        b=F4XwZ2Ad+4YHTTdwhuQrDrtCzhlKBJ7VNJmdL48IEsFPSaZ4ohkOE9p4fsMuY1MT18
         qkRvvT2QkqeBqJmgBzaPOiVm7NQx39wnKTPes2b7N0TvDf3O/vavn2ainf1Pw2f32DDu
         bP9c2OhQrJMLLQd3nWPWgQGCx7+ddTTHHbE1p6tPgENpdpzZywyUArGN8TDREYAlIDe+
         R0paj52efdjrVfNkRc6I8G0NO15/gMiVXfjVAKgm6zV0SGVapLac6pvEUXrInoQkEbXC
         cTFysGcBLG20595/nFNpatWeCSK7RyXC81exuXI6FcdimWh5zIIZpe3tlDyyWs3qS6p/
         E1Zw==
X-Gm-Message-State: ANoB5pkJzodbG9DcoXSkxnOdQmGLc3xmoerG7vagYHs1cWfku180ln3v
        Szv1BEt334W3rvNNOWmrEmjPJt5OLCxwsTzispeMKw==
X-Google-Smtp-Source: AA0mqf7MdR24OCVzRBWFHBA1Ih0rv9hUVtp5dojJr48004Fk2Ur1P7IRRT950dIzOhONwDL/P4n1lllvwgn2ibEO+gk=
X-Received: by 2002:a17:903:40c6:b0:189:f799:676e with SMTP id
 t6-20020a17090340c600b00189f799676emr6120063pld.148.1670506892322; Thu, 08
 Dec 2022 05:41:32 -0800 (PST)
MIME-Version: 1.0
References: <1664960824-20951-1-git-send-email-quic_akhilpo@quicinc.com>
 <20221201225705.46r2m35ketvzipox@builder.lan> <CAPDyKFofsqcoFbYt-9BcisbPdreLGqAAMWorqHi0_D1kwCdYhg@mail.gmail.com>
 <20221207165457.kwdwwiycbwjpogxl@builder.lan>
In-Reply-To: <20221207165457.kwdwwiycbwjpogxl@builder.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Dec 2022 14:40:55 +0100
Message-ID: <CAPDyKFpYgYkDdJ79xxkwr-Mqnj5CoBrV+ZZe6Xz4hGLNR4zUVw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] clk/qcom: Support gdsc collapse polling using
 'reset' interface
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        krzysztof.kozlowski@linaro.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022 at 17:55, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Dec 07, 2022 at 05:00:51PM +0100, Ulf Hansson wrote:
> > On Thu, 1 Dec 2022 at 23:57, Bjorn Andersson <andersson@kernel.org> wrote:
> > >
> > > On Wed, Oct 05, 2022 at 02:36:58PM +0530, Akhil P Oommen wrote:
> > > >
> > >
> > > @Ulf, Akhil has a power-domain for a piece of hardware which may be
> > > voted active by multiple different subsystems (co-processors/execution
> > > contexts) in the system.
> > >
> > > As such, during the powering down sequence we don't wait for the
> > > power-domain to turn off. But in the event of an error, the recovery
> > > mechanism relies on waiting for the hardware to settle in a powered off
> > > state.
> > >
> > > The proposal here is to use the reset framework to wait for this state
> > > to be reached, before continuing with the recovery mechanism in the
> > > client driver.
> >
> > I tried to review the series (see my other replies), but I am not sure
> > I fully understand the consumer part.
> >
> > More exactly, when and who is going to pull the reset and at what point?
> >
> > >
> > > Given our other discussions on quirky behavior, do you have any
> > > input/suggestions on this?
> > >
> > > > Some clients like adreno gpu driver would like to ensure that its gdsc
> > > > is collapsed at hardware during a gpu reset sequence. This is because it
> > > > has a votable gdsc which could be ON due to a vote from another subsystem
> > > > like tz, hyp etc or due to an internal hardware signal. To allow
> > > > this, gpucc driver can expose an interface to the client driver using
> > > > reset framework. Using this the client driver can trigger a polling within
> > > > the gdsc driver.
> > >
> > > @Akhil, this description is fairly generic. As we've reached the state
> > > where the hardware has settled and we return to the client, what
> > > prevents it from being powered up again?
> > >
> > > Or is it simply a question of it hitting the powered-off state, not
> > > necessarily staying there?
> >
> > Okay, so it's indeed the GPU driver that is going to assert/de-assert
> > the reset at some point. Right?
> >
> > That seems like a reasonable approach to me, even if it's a bit
> > unclear under what conditions that could happen.
> >
>
> Generally the disable-path of the power-domain does not check that the
> power-domain is actually turned off, because the status might indicate
> that the hardware is voting for the power-domain to be on.

Is there a good reason why the HW needs to vote too, when the GPU
driver is already in control?

Or perhaps that depends on the running use case?

>
> As part of the recovery of the GPU after some fatal fault, the GPU
> driver does something which will cause the hardware votes for the
> power-domain to be let go, and then the driver does pm_runtime_put().

Okay. That "something", sounds like a device specific setting for the
corresponding gdsc, right?

So somehow the GPU driver needs to manage that setting, right?

>
> But in this case the GPU driver wants to ensure that the power-domain is
> actually powered down, before it does pm_runtime_get() again. To ensure
> that the hardware lost its state...

I see.

>
> The proposal here is to use a reset to reach into the power-domain
> provider and wait for the hardware to be turned off, before the GPU
> driver attempts turning the power-domain on again.
>
>
> In other words, there is no reset. This is a hack to make a normally
> asynchronous pd.power_off() to be synchronous in this particular case.

Alright, assuming I understood your clarifications above correctly
(thanks!), I think I have got a much better picture now.

Rather than abusing the reset interface, I think we should manage this
through the genpd's power on/off notifiers (GENPD_NOTIFY_OFF). The GPU
driver should register its corresponding device for them
(dev_pm_genpd_add_notifier()).

The trick however, is to make the behaviour of the power-domain for
the gdsc (the genpd->power_off() callback) conditional on whether the
HW is configured to vote or not. If the HW can vote, it should not
poll for the state - and vice versa when the HW can't vote.

Would this work?

Kind regards
Uffe
