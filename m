Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8217274D4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGJLkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjGJLkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:40:49 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B073EE1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:40:47 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-c4dd86f5d78so6351608276.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688989247; x=1691581247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0baWHvJEuymJsSf+7zXG5QpL6IwXsO62n0ON36eeSc=;
        b=Wrm7CvNA2UjxNAJnmdVa0vkA0kU1l1/NYs5RXPLkcHszVSMYyRpzLNrlp8JvNp8mUg
         SlaDSvhKer7MALbZO3YEnSRaYN4vD6A0DESoJJwm7veyC/JfATTN31yWpY+dFegdDg+q
         gSjR1wOkko8gIDmwgtTNpNWHDKQqz/6YUgKmlwjzOks25mJC4NebQ0H109vIb885OhkA
         xmvzdNGwAm2//+KmwLGD6UZQXJSRByfX2DIS+oAe61Ce6WckPFOjHnHDmEouSpR5kJXF
         EXuSZNQsWI2NHI33fRysIKGweGiYCnFnzPiU7rd4YamDVl7hiq6uN1cnKtEHB0se4Hs2
         G1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688989247; x=1691581247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0baWHvJEuymJsSf+7zXG5QpL6IwXsO62n0ON36eeSc=;
        b=akXQDD56evNQOIVcBv/qe36B5nKxo/mcL5m8u+6pH+sJTW+SdFkyTuQS9eXVZUK2+6
         yXuCH94xjE3H1EaJzOqPkpe1vWOdpbF6kR/74eD82RHsrbKDFTFjr/l0yNFgNUuwKx98
         DSqOlMafMOHOtq0rgYvNgZuyqsvFwwer9ExGfIz5s2BQDVq4hjIDysS8A5urEiAoWtlj
         QRTXR5sJ9xGHdQUePczql4o8xkP8ffnQGYkBGLR8C00a7ZmHmwq3GjUOLL1Iy1evBHwW
         +iIpr9VvnkKpFlnqkCTxF7HAEx03jOccpZxOUdaSb75y7jL0zsZqUAT+OWtTBVzpERyz
         Jlnw==
X-Gm-Message-State: ABy/qLb1OQL0vj9lREDlgsbV1rJCo8bOC/SCEQ9QWkHlK5RP+iL8HO6q
        WxiKC+5Pe7ejsdJA1wZeo6ZuKUqJmmefLw5gFJcF9w==
X-Google-Smtp-Source: APBJJlG43lphj5dSNPax0uxGnPOKxibjsrO5vULJkKbP8xMPCTSfJ/56PgpMjMUDYP+bStbBUVsCYNM5+WjZQrvIl+A=
X-Received: by 2002:a25:6905:0:b0:c4b:1a9f:90eb with SMTP id
 e5-20020a256905000000b00c4b1a9f90ebmr10256666ybc.7.1688989246886; Mon, 10 Jul
 2023 04:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230710095926.15614-1-frank.li@vivo.com> <20230710095926.15614-6-frank.li@vivo.com>
 <c628dff0-bb0c-f78d-7302-599c5329c977@linaro.org> <57b97b0a-6570-5085-dbac-a08089791876@vivo.com>
In-Reply-To: <57b97b0a-6570-5085-dbac-a08089791876@vivo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 10 Jul 2023 14:40:35 +0300
Message-ID: <CAA8EJpoQXe1bHf=EG=6Tt4gWz_4h-rkLHK92_mVQQmZCc4hq4g@mail.gmail.com>
Subject: Re: [PATCH v4 06/21] thermal/drivers/db8500: convert to use devm_request*_irq_probe()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 at 14:30, Yangtao Li <frank.li@vivo.com> wrote:
>
> Hi Dmitry,
>
> On 2023/7/10 19:25, Dmitry Baryshkov wrote:
>
> > On 10/07/2023 12:59, Yangtao Li wrote:
> >> There are more than 700 calls to devm_request_threaded_irq method and
> >> more than 1000 calls to devm_request_irq method. Most drivers only
> >> request one interrupt resource, and these error messages are basically
> >> the same. If error messages are printed everywhere, more than 2000 lin=
es
> >> of code can be saved by removing the msg in the driver.
> >>
> >> And tglx point out that:
> >>
> >>    If we actually look at the call sites of
> >>    devm_request_threaded_irq() then the vast majority of them print
> >> more or
> >>    less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
> >>
> >>       519 messages total (there are probably more)
> >>
> >>       352 unique messages
> >>
> >>       323 unique messages after lower casing
> >>
> >>           Those 323 are mostly just variants of the same patterns with
> >>           slight modifications in formatting and information provided.
> >>
> >>       186 of these messages do not deliver any useful information,
> >>           e.g. "no irq", "
> >>
> >>       The most useful one of all is: "could request wakeup irq: %d"
> >>
> >>    So there is certainly an argument to be made that this particular
> >>    function should print a well formatted and informative error messag=
e.
> >>
> >>    It's not a general allocator like kmalloc(). It's specialized and
> >> in the
> >>    vast majority of cases failing to request the interrupt causes the
> >>    device probe to fail. So having proper and consistent information w=
hy
> >>    the device cannot be used _is_ useful.
> >>
> >> So convert to use devm_request*_irq_probe() API, which ensure that all
> >> error handling branches print error information.
> >>
> >> In this way, when this function fails, the upper-layer functions can
> >> directly return an error code without missing debugging information.
> >> Otherwise, the error message will be printed redundantly or missing.
> >>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> >> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> >> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> >> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.co=
m>
> >> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> >> ---
> >>   drivers/thermal/db8500_thermal.c | 16 ++++++----------
> >>   drivers/thermal/qcom/lmh.c       |  7 +++----
> >
> > Please split LMH to a separate driver.
>
>
> Sorry for mixing these two patches together,
>
> can I add your Reviewed-by tag when the patch is resubmitted for the
> next version?

Yes, please add it to the LMH patch.

>
>
> Thx,
>
> Yangtao
>
> >
> >>   2 files changed, 9 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/thermal/db8500_thermal.c
> >> b/drivers/thermal/db8500_thermal.c
> >> index fca5c2c93bf9..0ef8fc2eb4a1 100644
> >> --- a/drivers/thermal/db8500_thermal.c
> >> +++ b/drivers/thermal/db8500_thermal.c
> >> @@ -164,25 +164,21 @@ static int db8500_thermal_probe(struct
> >> platform_device *pdev)
> >>       if (low_irq < 0)
> >>           return low_irq;
> >>   -    ret =3D devm_request_threaded_irq(dev, low_irq, NULL,
> >> +    ret =3D devm_request_threaded_irq_probe(dev, low_irq, NULL,
> >>           prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
> >> -        "dbx500_temp_low", th);
> >> -    if (ret < 0) {
> >> -        dev_err(dev, "failed to allocate temp low irq\n");
> >> +        "dbx500_temp_low", th, "temp low");
> >> +    if (ret < 0)
> >>           return ret;
> >> -    }
> >>         high_irq =3D platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
> >>       if (high_irq < 0)
> >>           return high_irq;
> >>   -    ret =3D devm_request_threaded_irq(dev, high_irq, NULL,
> >> +    ret =3D devm_request_threaded_irq_probe(dev, high_irq, NULL,
> >>           prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
> >> -        "dbx500_temp_high", th);
> >> -    if (ret < 0) {
> >> -        dev_err(dev, "failed to allocate temp high irq\n");
> >> +        "dbx500_temp_high", th, "temp high");
> >> +    if (ret < 0)
> >>           return ret;
> >> -    }
> >>         /* register of thermal sensor and get info from DT */
> >>       th->tz =3D devm_thermal_of_zone_register(dev, 0, th, &thdev_ops)=
;
> >> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
> >> index f6edb12ec004..48a14d7e8bf5 100644
> >> --- a/drivers/thermal/qcom/lmh.c
> >> +++ b/drivers/thermal/qcom/lmh.c
> >> @@ -207,11 +207,10 @@ static int lmh_probe(struct platform_device *pde=
v)
> >>         /* Disable the irq and let cpufreq enable it when ready to
> >> handle the interrupt */
> >>       irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
> >> -    ret =3D devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
> >> -                   IRQF_ONESHOT | IRQF_NO_SUSPEND,
> >> -                   "lmh-irq", lmh_data);
> >> +    ret =3D devm_request_irq_probe(dev, lmh_data->irq, lmh_handle_irq=
,
> >> +                     IRQF_ONESHOT | IRQF_NO_SUSPEND,
> >> +                     "lmh-irq", lmh_data, NULL);
> >>       if (ret) {
> >> -        dev_err(dev, "Error %d registering irq %x\n", ret,
> >> lmh_data->irq);
> >>           irq_domain_remove(lmh_data->domain);
> >>           return ret;
> >>       }
> >



--=20
With best wishes
Dmitry
