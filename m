Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4491645E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLGQBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiLGQB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:01:29 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E623E0BE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:01:28 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r18so16729715pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 08:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d1kIptz7lKS34gKJ86GNyP5WqgoufGO1GV/3C71h5+Y=;
        b=Zv+M3sdOTc2OaYw1U1lD9VTedffjOCXGlzUX5YnRjqpDj/9mhaAVkhtuzC+ogifVNu
         p1S/8EKd2QORb28ZpoA3LQnVibjwCkCNAAb9dr9XCl2C4l+Lt3Z6K4ir7sm+3mW4x/85
         6pBJiFAc5UE0fruWDoMsAuJxxN5FRe4wKarL0lpXgBiZNMb0+WQ3q6mYx9fH+BVE9sXN
         gbcBsoVcq0qongaEmXQHvGOHZ7fI+IIGnay3mc2RIntIRbvuzxhNHt+9sR/XJZeaoNbC
         fkZqCAqy2kkWqJJLUpz0hIpe2AeBemrvPLy50G6cklmneX0nbRZt8TDVpi+8T7V/GUDd
         oNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1kIptz7lKS34gKJ86GNyP5WqgoufGO1GV/3C71h5+Y=;
        b=VafLhWN0fa/X/sA/ST/0mXgDJtgGdzldyvB65Jc1Df4MzdFuAZU25g3cxLnt+/TfNx
         W0HCztjMQqtn4UIAVC6TA+TLQSfVqaoLDaw3LgSJNmsZMQNaP0Z8KvuBADo3hk2E5jQT
         Z0YTIE6BODQKd3zIOuZuaZA40RnV+NDRoYuBTaXGKYSxvzn/QJwK6xiJlxXUtVtjOSeB
         WFq1GA7Q4g0HsoYY9cr2eiW6sfFeda59QfffZTc1n7ch3dOzHS30g3F/JXPLQV7+JcDk
         pyEjERCr1NrwO12V4EJQpxVc8YILmmK+iSEZ12V26vv2PMBkO2MCQ+yODDyDPvlqaqe6
         YONg==
X-Gm-Message-State: ANoB5plK6nyqeU3CJ5bTmcuWyxnJw0wXHSFunJVhSoiVTHK4F+fkwVDE
        JjOj7r3gAdB4AXKswZ+ZKwkx1v/cbOCOp2VAUGkUrg==
X-Google-Smtp-Source: AA0mqf6sjup+AAww0D1CxABtpTEw5G9veD+P+n64BdJc1XGnX7DToNoJVds9RCkhIAyxzhqjXASkgW/44ET/nN1v+Fo=
X-Received: by 2002:aa7:951d:0:b0:577:3e5e:7a4 with SMTP id
 b29-20020aa7951d000000b005773e5e07a4mr8456102pfp.57.1670428887514; Wed, 07
 Dec 2022 08:01:27 -0800 (PST)
MIME-Version: 1.0
References: <1664960824-20951-1-git-send-email-quic_akhilpo@quicinc.com> <20221201225705.46r2m35ketvzipox@builder.lan>
In-Reply-To: <20221201225705.46r2m35ketvzipox@builder.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 17:00:51 +0100
Message-ID: <CAPDyKFofsqcoFbYt-9BcisbPdreLGqAAMWorqHi0_D1kwCdYhg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] clk/qcom: Support gdsc collapse polling using
 'reset' interface
To:     Bjorn Andersson <andersson@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 at 23:57, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Oct 05, 2022 at 02:36:58PM +0530, Akhil P Oommen wrote:
> >
>
> @Ulf, Akhil has a power-domain for a piece of hardware which may be
> voted active by multiple different subsystems (co-processors/execution
> contexts) in the system.
>
> As such, during the powering down sequence we don't wait for the
> power-domain to turn off. But in the event of an error, the recovery
> mechanism relies on waiting for the hardware to settle in a powered off
> state.
>
> The proposal here is to use the reset framework to wait for this state
> to be reached, before continuing with the recovery mechanism in the
> client driver.

I tried to review the series (see my other replies), but I am not sure
I fully understand the consumer part.

More exactly, when and who is going to pull the reset and at what point?

>
> Given our other discussions on quirky behavior, do you have any
> input/suggestions on this?
>
> > Some clients like adreno gpu driver would like to ensure that its gdsc
> > is collapsed at hardware during a gpu reset sequence. This is because it
> > has a votable gdsc which could be ON due to a vote from another subsystem
> > like tz, hyp etc or due to an internal hardware signal. To allow
> > this, gpucc driver can expose an interface to the client driver using
> > reset framework. Using this the client driver can trigger a polling within
> > the gdsc driver.
>
> @Akhil, this description is fairly generic. As we've reached the state
> where the hardware has settled and we return to the client, what
> prevents it from being powered up again?
>
> Or is it simply a question of it hitting the powered-off state, not
> necessarily staying there?

Okay, so it's indeed the GPU driver that is going to assert/de-assert
the reset at some point. Right?

That seems like a reasonable approach to me, even if it's a bit
unclear under what conditions that could happen.

[...]

Kind regards
Uffe
