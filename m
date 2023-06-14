Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4244730851
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbjFNTfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjFNTf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:35:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2647BD2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:35:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51898b0c1a1so1407094a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686771325; x=1689363325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU76vYQFaTOTVIoQqi0w79DumHDt6GCwn4u2KfUXZyQ=;
        b=T56qH18gNskhdK9yvmXZXFOr6RC3nIJm8TzWcd8EGJTQH3VXHA2i4a7qfvGXvC8Rh5
         c+GCKWtbRNW6S09q0quwgQppiX3U6ZR7aHp63uzZQa6yi5qtN6gj6RShQ/OV8aM4kOgr
         WK28j8vcysacwwi4D+dHODRkUFe11CCoa454A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686771325; x=1689363325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WU76vYQFaTOTVIoQqi0w79DumHDt6GCwn4u2KfUXZyQ=;
        b=DhONdHQWoh81qOXPXfkVpF3nA7v/iGRyWJnW3CdwhZ5eUisRccLTIxhqFxB62F0IMX
         Q1uhFQ4TnsmzqwHb2fiUqYht4LUgZWY/laz9qipS88XdAps/W01NxgMShPIQx0sWJjsl
         5B+uj/BVeF92qwdmx3PMWW9+tu4Y142fOPKdXmCYDEp8M9mhL7nLulzmhEX8nkw21GxQ
         UnTW7qqqhnVJD7XQXAgFWiGyKWSnee3g5EFoZlwMMgZIcI683w0zcAhCuFDOurqe98e1
         yDVTEwxRSJIMT4kWJbCzKfnNIUs0OZTPDWlG8IB6guqmj+ySjDVXN8NzIkwR3Zh2GNY7
         kSTg==
X-Gm-Message-State: AC+VfDyn+Z+rhqRuk6TB5fkoTntGy5Bn5eFkSsF/nZpHxYDTRv3HLREI
        hyNja5V7aADC4UYGdcFqxj6ai3Zf0XO6ns4EaFnl6Mjv
X-Google-Smtp-Source: ACHHUZ5nmaRsonL2E2fffXmAg7YGeWMmUSo9xOKcOMJSMBgo3lQyDqjvdt4st8a2C+KOtqFCe0DrXA==
X-Received: by 2002:a50:ef13:0:b0:514:80b9:793b with SMTP id m19-20020a50ef13000000b0051480b9793bmr10990200eds.19.1686771324973;
        Wed, 14 Jun 2023 12:35:24 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id d13-20020aa7d5cd000000b00510d110db58sm8003390eds.80.2023.06.14.12.35.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 12:35:22 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so1856a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:35:21 -0700 (PDT)
X-Received: by 2002:a50:9b57:0:b0:506:90c4:b63b with SMTP id
 a23-20020a509b57000000b0050690c4b63bmr15000edj.4.1686771321408; Wed, 14 Jun
 2023 12:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
 <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org> <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
 <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
 <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
 <CAMi1Hd1WCtNvNaY_kVMx5F8T0nMVHvsjk9LsSETCMWWQyaq_Vw@mail.gmail.com>
 <CAD=FV=W5Y_SHp0y2MEs8d1k255bm_PXdRYEmYei+g79pjnzYuA@mail.gmail.com>
 <CAMi1Hd2OeL940r7jq0=Z_oxE8MYVioy0YnJXQC_5e0vJONd2sQ@mail.gmail.com>
 <1bc79c48-7cba-476d-9a7e-5754a88fcdae@sirena.org.uk> <CAMi1Hd2BLB6H3QRLB5svRTkGoXaUeEsakNsmfCOjbDBcCEeqkA@mail.gmail.com>
 <CAD=FV=UKyjRNZG-ED2meUAR9aXdco+AbUTHiKixTzjCkaJbjTg@mail.gmail.com> <CAMi1Hd12S+bKyp=CHwoioYoojtFzaA1tey19BqAFi+4DeJR__w@mail.gmail.com>
In-Reply-To: <CAMi1Hd12S+bKyp=CHwoioYoojtFzaA1tey19BqAFi+4DeJR__w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Jun 2023 12:35:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XxWWxWB2zZwUdnRQkiiMbuC=Bx=ibRWG92nFzbXgHWHw@mail.gmail.com>
Message-ID: <CAD=FV=XxWWxWB2zZwUdnRQkiiMbuC=Bx=ibRWG92nFzbXgHWHw@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 14, 2023 at 12:03=E2=80=AFPM Amit Pundir <amit.pundir@linaro.or=
g> wrote:
>
> On Wed, 7 Jun 2023 at 04:59, Doug Anderson <dianders@chromium.org> wrote:
> >
> > From a black box perspective, I guess the things I could think of
> > would be to keep poking around with things that you control. Best
> > ideas I have:
> >
> > 1. Use "bisect" style techniques to figure out how much you really
> > need to move the "lvs" regulators. Try moving it halfway up the list.
> > If that works, move it closer to the bottom. If that doesn't work,
> > move it closer to the top. Eventually you'd find out which regulator
> > it's important to be before.
>
> Hi, I tried this bisect style technique to move lvs regulators up in
> the list gradually and I found that they need to be enabled atleast
> before ldo12 and the ldo regulators which follow the ldo12 in the
> list.

Super weird. I was hoping that something would jump out, but nothing
does. :( I don't understand how lvs1 / lvs2 could have any impact on
ldo12. :(


> > 2. Try adding some delays to some of the regulators with
> > "regulator-enable-ramp-delay" and/or "regulator-settling-time-us".
> > Without a scope, it'll be tricky to figure out exactly which
> > regulators might need delays, but you could at least confirm if the
> > "overkill" approach of having all the regulators have some delay
> > helps... I guess you could also try putting a big delay for "ldo26".
> > If that works, you could try moving it up (again using a bisect style
> > approach) to see where the delay matters?
>
> I tried this approach as well earlier today but I don't know how big
> "the big" delay can be. The device fails to boot if I add a settling
> time of as much as 2sec per each ldo and lvs regulator too. I didn't
> try increasing the delay further.

Yeah, 2 seconds is plenty big. If that doesn't fix it then it's not a
timing issue.

I guess with the above results, I'm still super confused about why the
async probe has any impact at all on this. It sounds like the
_ordering_ of the rpmh-regulators init matters but not the timing, and
I'd expect the ordering to be the same between normal probe and async
probe. Specifically, I think:

a) There is exactly one rpmh-regulator driver instance in your system, righ=
t?

b) Regulator initialization happens in rpmh_regulator_probe().

c) The rpmh_regulator_probe() function is itself synchronous. That is,
it sets up one regulator at a time and, I believe, nothing about the
behavior of rpmh_regulator_probe() changes for async vs. sync probe.

...so I'm left baffled...
