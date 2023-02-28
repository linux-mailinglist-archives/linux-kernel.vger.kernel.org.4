Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408E46A5BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjB1P0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjB1PZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:25:47 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F9D241E9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:25:26 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id b5so4199162iow.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BV1l+SBiwvGsmaocJDR98W2gYnTf5xsLjce1+ilKqc=;
        b=nkFRtBsFuFlVpeaMRqxmki4j1RygbpGqHZ4hilw0bzTwHCyAGa2WJW++AHxFSto91P
         yqe9ZY9165OHd5++VXtxVysrCTryVDC9+n6ywyt8LsGfCf8qWWo395Cf6EjloPKeiQ/Z
         qWcSgmtAmYDmTCAJNfEOd3Zy6wWv6G0UkqVRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BV1l+SBiwvGsmaocJDR98W2gYnTf5xsLjce1+ilKqc=;
        b=YRshY3wnTzQdj7jRxE/YfxAtTUV5cfilA3W5wNPkqimBO8dpxOze+KpeFm1py9z3rG
         kNd7LRQZhAd21R3BlHUiwnX+zs3sdtF01H6D3+fJazP9wZa2MR/tSA65QynWmGzV1YbD
         bSxGoMMSeYGnNFlaQRuWkLW8+BLSwmKBSyGG5I9RWK8R/urQYH4+7sSzBPnRW2esLKN1
         QL0FmJ86+eU6KAI/UZupW4+9EHr0XckBNWj9dN74hcrUrHbW+E8xWIUEs5kPD4isX4ND
         9/BfKy3Pja7Mj1R8aL+rK6NzbxMqjPftVtZb1qixG/Ou/X2eUiawXbIs064HQ6Jn6uZ3
         EMMQ==
X-Gm-Message-State: AO0yUKXPc6VLiAX6d8eiaTO80eDP0REn1Xi3z6Jua6DfK8xy354EjuTs
        ilKEnXOKu8nEH+/Tw3BOuEfY3xfbTGt4Dijd
X-Google-Smtp-Source: AK7set8cjCWsd8+uOxT+k7rapM1nk77MsriBGhAF/HPqO1R0X2pT88UYUBZPXggHzo4ynaTKAPHOBA==
X-Received: by 2002:a5d:8441:0:b0:74c:fe71:5808 with SMTP id w1-20020a5d8441000000b0074cfe715808mr2089669ior.6.1677597921569;
        Tue, 28 Feb 2023 07:25:21 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id p25-20020a5d8b99000000b007192441e5e6sm3208810iol.45.2023.02.28.07.25.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:25:21 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id f14so4180222iow.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:25:20 -0800 (PST)
X-Received: by 2002:a02:84ec:0:b0:3ec:dc1f:12dd with SMTP id
 f99-20020a0284ec000000b003ecdc1f12ddmr1419641jai.6.1677597920327; Tue, 28 Feb
 2023 07:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20230215071649.9078-1-quic_mkshah@quicinc.com>
 <20230227153848.auqs4e5hf2qmwmg2@ripper> <CAD=FV=UK9zyQ=Mg3BaVCwOGBG3G7rW2pdpMFtGptR88p8ce9kg@mail.gmail.com>
 <CAPDyKFouhMbFFMHeT5vEo_LUQWVe5wKpagx8HUtDpcV7LCa4zQ@mail.gmail.com>
In-Reply-To: <CAPDyKFouhMbFFMHeT5vEo_LUQWVe5wKpagx8HUtDpcV7LCa4zQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Feb 2023 07:25:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V+fdfjUbAtvmeG43Nk=J3=Td4RSCZajrsxu8n8ykmH0w@mail.gmail.com>
Message-ID: <CAD=FV=V+fdfjUbAtvmeG43Nk=J3=Td4RSCZajrsxu8n8ykmH0w@mail.gmail.com>
Subject: Re: [PATCH 0/1] Use PSCI OS initiated mode for sc7280
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>, swboyd@chromium.org,
        wingers@google.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com, Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 28, 2023 at 4:17=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Mon, 27 Feb 2023 at 17:10, Doug Anderson <dianders@chromium.org> wrote=
:
> >
> > Hi,
> >
> > On Mon, Feb 27, 2023 at 7:35=E2=80=AFAM Bjorn Andersson <andersson@kern=
el.org> wrote:
> > >
> > > On Wed, Feb 15, 2023 at 12:46:48PM +0530, Maulik Shah wrote:
> > > > This change adds power-domains for cpuidle states to use PSCI OS
> > > > initiated mode for sc7280.
> > > >
> > > > This change depends on external project changes [1] & [2] which are=
 under
> > > > review/discussion to add PSCI os-initiated support in Arm Trusted F=
irmware.
> > > >
> > > > I can update here once the dependency are in and change is ready to=
 merge.
> > > >
> > >
> > > Please do, I will drop this from the queue for now.
> >
> > I'm a bit confused about why we're doing this. There's always been a
> > question about exactly why we need OSI mode. As far as I can tell it
> > can't be for "correctness" reasons because we managed to ship sc7180
> > without OSI mode. ...so I guess somehow the argument is that OSI mode
> > is more performant in some cases? Are there actual numbers backing
> > this up, or is it all theoretical? Before making such a big change, it
> > would be good to actually understand what the motivation is and see
> > real data. This should be easy to collect since we currently have
> > things working without OSI and (presumably) you have OSI working. It
> > would also be good to document this motivation in the commit message
> > and/or cover letter.
>
> I certainly don't object to what you say here. Although, let me also
> share some more background to these suggested changes.
>
> As you know, for mobile platforms, Qcom have been using OS-initiated
> mode for years, but on Chromium platforms that has been limited to the
> default platform-coordinated mode. Whether that is a deliberate
> decision for the Chromium platforms or rather because the PSCI
> implementation in TF-A has been lacking OSI support, I don't know.
> Maybe you have some more insight to share around this?

You hit the reason exactly. Nobody on the ChromeOS team objected to
OSI, per say, but it was never supported in ARM Trusted Firmware. I
still don't have anything against OSI mode, but I just want to make
sure that the data is there and that we're not just arbitrarily
churning things. ;-)

I think sc7180's ship has sailed at this point. While we could update
the firmware for testing, I don't think we'd switch production sc7180
devices over to OSI. That means that we'll always need to support PC
mode for sc7180. Switching sc7280 over to OSI needs to be justified
given that we'll have to continue to support sc7180 with PC mode
anyway.


> Note that, Wing has been working on adding support for PSCI OSI mode
> to TF-A [1], which hopefully should land soon. In this regard, it
> seems like we are getting closer to finally being able to run some
> more in-depth tests, that should allow us to better compare the
> behaviour of the PSCI CPU-suspend modes - at least on some platforms.
> In fact, Maulik/Wing also presented their work around this topic,
> including some results around performance/energy tests at the last
> TF-A call [2]. I think some of that data could be shared in the commit
> message too.

Yup, I was mostly just asking for data like you provided to be in the
commit message.


> Kind regards
> Uffe
>
> [1]
> https://review.trustedfirmware.org/q/topic:psci-osi
>
> [2]
> https://www.trustedfirmware.org/meetings/tf-a-technical-forum
