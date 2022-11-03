Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B8F618565
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiKCQzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiKCQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:55:49 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8DCB7EE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:55:47 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a15so2969095ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfNKvOanyjhHXBelrkaChFOyOSO1zGtjsNg5Ut58HCY=;
        b=l8L5GV5CeR9wDYO+5JynTcHeJOpgCRiyXIH0gjfjyzpIYPBguREKcqoOHAxE9yxwcp
         lsTsT2CcIczlSniwSfhfBeCvg+XNVj5J7fyDcwS2HIuZeNMJ9hxfjr88MBOgvMH/BTaV
         nVU7d3mVSTMTgAT4Cw4Wh4IOS3OEw8YEr61m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfNKvOanyjhHXBelrkaChFOyOSO1zGtjsNg5Ut58HCY=;
        b=F/VlTI+L17Djqh9FRuNav7mKobghuTVjUn/+BkK/72dg3LyAuxtBLyUQOaun/m0LUm
         wLwL1+0Eil9dth75Q+c3tcchfYf72h1eQVSDJ06/gJatIJCvyyAu+BvM1B/1M2Dv7eg+
         hwRCrp1uj6P8snEAS2T3r7ntW2S5iM/Ce6jPsb8bdKgap9vyyCGZ0wqQR8otg/j/gNrn
         CaYIhXn5RVksqTtXBH7DVr+f0P9gi7eTWWLvyO+fuMWMd7C7LiMZG7a82DlrxDn3+T0T
         AUQP3L5aQ9Lws1AU/6Svs+X19NWmBF3wY+bi8KCleNBfcqhlO77U4iG8wGAHcbUa/wo4
         Zwhg==
X-Gm-Message-State: ACrzQf3RdNH/JTTpdMWGr9Wovqynoef38DachAeJxShCfmZ6tXwbGJE2
        FP/psm8shjNzJ+cb/OLyv+7yNlQxEuDIsHTS4j3rYQ==
X-Google-Smtp-Source: AMsMyM7F6w1WR1rSV9GSlSeTP7m094zPjzqZZijj6DLJBRqC4jr2/5t8eFRsP4KqYMeT2vVp5eZ7kbdeNtIZBiT0/mg=
X-Received: by 2002:a05:651c:222c:b0:26b:dec5:a4f0 with SMTP id
 y44-20020a05651c222c00b0026bdec5a4f0mr12924242ljq.359.1667494545853; Thu, 03
 Nov 2022 09:55:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Nov 2022 09:55:45 -0700
MIME-Version: 1.0
In-Reply-To: <Y2PQrRkGTEE40m4Q@hovoldconsulting.com>
References: <20221102170717.1262547-1-swboyd@chromium.org> <Y2PQrRkGTEE40m4Q@hovoldconsulting.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Nov 2022 09:55:45 -0700
Message-ID: <CAE-0n52zxYSdbQg5VqVQ9gboZy2BSgJUgJ5orvNkzrz-3-81SA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: qcom: gdsc: Remove direct runtime PM calls
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Hovold (2022-11-03 07:31:09)
> On Wed, Nov 02, 2022 at 10:07:17AM -0700, Stephen Boyd wrote:
> > We shouldn't be calling runtime PM APIs from within the genpd
> > enable/disable path for a couple reasons.
> >
> > First, this causes an AA lockdep splat because genpd can call into genpd
> > code again while holding the genpd lock.
> >
> > WARNING: possible recursive locking detected
>
> > Second, this confuses runtime PM on CoachZ for the camera devices by
> > causing the camera clock controller's runtime PM usage_count to go
> > negative after resuming from suspend. This is because runtime PM is
> > being used on the clock controller while runtime PM is disabled for the
> > device.
> >
> > The reason for the negative count is because a GDSC is represented as a
> > genpd and each genpd that is attached to a device is resumed during the
> > noirq phase of system wide suspend/resume (see the noirq suspend ops
> > assignment in pm_genpd_init() for more details). The camera GDSCs are
> > attached to camera devices with the 'power-domains' property in DT.
> > Every device has runtime PM disabled in the late system suspend phase
> > via __device_suspend_late(). Runtime PM is not usable until runtime PM
> > is enabled in device_resume_early(). The noirq phases run after the
> > 'late' and before the 'early' phase of suspend/resume. When the genpds
> > are resumed in genpd_resume_noirq(), we call down into gdsc_enable()
> > that calls pm_runtime_resume_and_get() and that returns -EACCES to
> > indicate failure to resume because runtime PM is disabled for all
> > devices.
>
> Probably worth mentioning the fact that those runtime PM calls
> unconditionally failing during resume means that the GDSCs are never
> even enabled.
>
> Seems like the PM runtime usage counters would still be balanced after
> this though as they are decremented also on failure during suspend (i.e.
> domain remains off and no usage counter is incremented during resume).
>

I'm seeing negative usage counts.

> But this is clearly just very broken.
>
> > Upon closer inspection, calling runtime PM APIs like this in the GDSC
> > driver doesn't make sense. It was intended to make sure the GDSC for the
> > clock controller providing other GDSCs was enabled, specifically the
> > MMCX GDSC for the display clk controller on SM8250 (sm8250-dispcc), so
> > that GDSC register accesses succeeded. That will already happen because
> > we make the 'dev->pm_domain' a parent domain of each GDSC we register in
> > gdsc_register() via pm_genpd_add_subdomain(). When any of these GDSCs
> > are accessed, we'll enable the parent domain (in this specific case
> > MMCX).
> >
> > We also remove any getting of runtime PM during registration, because
> > when a genpd is registered it increments the count on the parent if the
> > genpd itself is already enabled. And finally, the runtime PM state of
> > the clk controller registering the GDSC shouldn't matter to the
> > subdomain setup. Therefore we always assign 'dev' unconditionally so
> > when GDSCs are removed we properly unlink the GDSC from the clk
> > controller's pm_domain.
>
> This last bit makes no sense as 'dev' was only used for the runtime PM
> management and should be removed by this patch.

Oh sheesh, the name 'gdsc_register()' really throws me off. I think it's
one gdsc being registered, but it's actually plural gdscs, sigh. I will
fix it.
