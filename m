Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227636169C6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiKBQxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiKBQxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:53:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40963A4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:53:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id be13so29228873lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPxGv8wDl4w8ahoplOhQMd1dCPYtr9jOxJwW5o2MsIE=;
        b=l6HIcJLgkB80HcNoeA4t7GKqsd1AkqaAwv+deUrwgkXF7t8o7H2pfphTbpswWEdoFI
         tSzCRKilrLK6B3bMGQCGBKUca3Iow4mdAkBRwm5s1s4anAVW3jAj2DnlQK5KC7ZmL9pH
         aexle6DYwX9fxtjOOX8dbrKNnIjjB2dTtXBSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPxGv8wDl4w8ahoplOhQMd1dCPYtr9jOxJwW5o2MsIE=;
        b=1GQ2qEOJK0b7cAr72lYlRLHM32UHrOQTMebmBqtf9XjvEoYkiqm2OYC1dfN0fBAYnl
         xU8l9U5LITu5i4j7Qq7zqvJncZ7bqAEvejwnVBQOnLRt1ypUunKyjdmkyvOi6N/uo16/
         DpF9+IkxL38CvhCDxjQyefrslZzYcTKZ/dLT5LMoA/j5hr8CZAoXk9wWJlr2mvyb5rwr
         UeXQrIXLi8fQw7RYLWJG92W+BbFRy/idPw15Nekgk5VnnrC6mRFPTOVIyQYmVE2KsjhC
         8c77gKwcFTQMNh2Dn6sGkIJ2yjrX2RcHRXA5Ul8WQEXMFkTn9fu82C7NP4kRyQNn9vkS
         VV+Q==
X-Gm-Message-State: ACrzQf1EMtvfsdR0NnAm7IhxTNcQWiWkd6bsnKNn4S/OCT/ywMZPfhj6
        Ok7PDW7M342J0LoQc1aMRcK/ufxsujWqOxi4SPZPZSRLtrs=
X-Google-Smtp-Source: AMsMyM5w3I0KGbLe8VyfpLrH9sUlNfnw91bVtg3q31LhJXN3Hkeh0cL++qPptZif2cxAGAR1LK7sVYr4q62LkgOz0GI=
X-Received: by 2002:a19:7518:0:b0:4a2:4593:6e14 with SMTP id
 y24-20020a197518000000b004a245936e14mr9544915lfe.82.1667408029730; Wed, 02
 Nov 2022 09:53:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Nov 2022 09:53:49 -0700
MIME-Version: 1.0
In-Reply-To: <Y2JL9/HFrb3E+CYY@hovoldconsulting.com>
References: <20221101233421.997149-1-swboyd@chromium.org> <Y2JL9/HFrb3E+CYY@hovoldconsulting.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 2 Nov 2022 09:53:49 -0700
Message-ID: <CAE-0n51Wuc6gVmsTOu4Nf4yx+6Wp-Oi3XZy06syhCMVmePWPEw@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gdsc: Remove direct runtime PM calls
To:     Johan Hovold <johan@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, patches@lists.linux.dev,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Hovold (2022-11-02 03:52:39)
> On Tue, Nov 01, 2022 at 04:34:21PM -0700, Stephen Boyd wrote:
> > We shouldn't be calling runtime PM APIs from within the genpd
> > enable/disable path for a couple reasons.
> >
> > First, this causes an AA lockdep splat because genpd can call into genpd
> > code again while holding the genpd lock.
> >
> > WARNING: possible recursive locking detected
> > 5.19.0-rc2-lockdep+ #7 Not tainted
> > --------------------------------------------
> > kworker/2:1/49 is trying to acquire lock:
> > ffffffeea0370788 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30
> >
> > but task is already holding lock:
> > ffffffeea03710a8 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30
> >
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >
> >        CPU0
> >        ----
> >   lock(&genpd->mlock);
> >   lock(&genpd->mlock);
> >
> >  *** DEADLOCK ***
> >
> >  May be due to missing lock nesting notation
>
> I've seen this splat on sc8280xp as well but haven't had time to look
> into it yet.

Ok. This patch should fix you.

>
> > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Cc: Johan Hovold <johan+linaro@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Taniya Das <quic_tdas@quicinc.com>
> > Cc: Satya Priya <quic_c_skakit@quicinc.com>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Reported-by: Stephen Boyd <swboyd@chromium.org>
>
> We typically don't add Reported-by tags for bugs we find and fix
> ourselves.

Heh, I didn't see anything like that in Documentation/ so it seems fine.
I debugged my problem and reported it.

>
> > Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/clk/qcom/gdsc.c | 64 ++++++-----------------------------------
> >  1 file changed, 8 insertions(+), 56 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > index 7cf5e130e92f..a775ce1b7d8a 100644
> > --- a/drivers/clk/qcom/gdsc.c
> > +++ b/drivers/clk/qcom/gdsc.c
>
> > @@ -495,14 +451,11 @@ static int gdsc_init(struct gdsc *sc)
> >               sc->pd.power_on = gdsc_enable;
> >
> >       ret = pm_genpd_init(&sc->pd, NULL, !on);
> > -     if (ret)
> > -             goto err_put_rpm;
> > +     if (!ret)
> > +             goto err_disable_supply;
>
> The logic should not be inverted here (and only happens to work
> currently when you have no regulator or the gdsc was off).

Ooh good catch! I was waffling on this line to shorten it a bit. I'll
resend.
