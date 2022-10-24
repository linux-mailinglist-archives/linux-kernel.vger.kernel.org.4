Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6252060B32C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiJXQ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiJXQzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:55:13 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C561AE290;
        Mon, 24 Oct 2022 08:36:03 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id j130so11415944ybj.9;
        Mon, 24 Oct 2022 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WrYoOZbKFCccOrtXPnngnmJRm0Dj9ejvdDDgWvdIOc4=;
        b=j2U/GyYCVlBhA/+vasoTYYyganc6QSHUuLmYGE461nM2B2j7L8BHyYJbCAxBhVG1XX
         acQEn8DfB15lQQ3cUHrYLqtiRlayPkTmfzIFDmBmW5dcYFdLQND9nnxZTdvKCr6uWVWP
         lQ/YxKxb8xTwyqrUVGSy4HmT9X8ii3nCf4v54hhleQEB63NKf+9vkZs57xlDOQZ3auCn
         ShBrinqTkg3S34wjdreAKCRKmFJec1d+fPErUSGV0Dis+Q+dbROR4jlIeogJ8DkVUOal
         yrAtF7Ri5T52VTE5VHwBXhGCANjLxUew9ZeBxt+lQ/waEnuFDltPYahUmXVQ3BlssTh+
         nQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrYoOZbKFCccOrtXPnngnmJRm0Dj9ejvdDDgWvdIOc4=;
        b=Ki97YgnAKB9oYIxqBm8AShP4AaV1ZOoYo54Ofuk6aAssCesp4QZT9ijd4Ykxbf7pJC
         akBINcoFmqxL04GpGdsehkMrsXSCWw7WTuFDFnen9SzftYl2U1OKMxOrguBCMR65FdYv
         SuHtoFCIT/eSP52CJx9ayEeEp7w0OvSN47hICZ28ethJDyPsM93hjXR/eOx9zGgfElYc
         USpGu1zjoCOHcLyKITnQVNRQcp9S6rBSGaAqXYPnfiVzl1VVXWaqjvjI69x9mCTCymw1
         7fRgZUvztZXF+uBfGia69s9TQ5q0wvRXDNGGYuYhco2qbmw1v4h5dvWux0owzxTRvq8j
         NbeA==
X-Gm-Message-State: ACrzQf0shYZWjlkTDWvvxREwx7ADzEatUo9RY6Hsl65wCd1Y0+zjpjfE
        S+FiBtZhVJHN+TSbZ4n3+E7CUkI9nx7kHQbQFeXZxmRf
X-Google-Smtp-Source: AMsMyM6EvysaHiUabvYs4baVZTymhfLHCC/g/dii9bVMJWWAuOyZVdmdE7eqTdRMvsDXi3jbZf8C43NqJDJvCUeug1s=
X-Received: by 2002:a9d:7859:0:b0:661:b842:80d2 with SMTP id
 c25-20020a9d7859000000b00661b84280d2mr16537790otm.328.1666623706022; Mon, 24
 Oct 2022 08:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220913085320.8577-1-johan+linaro@kernel.org>
 <YymCll02tRIMb+9Z@hovoldconsulting.com> <Y1I77HYeOkx1fz1E@hovoldconsulting.com>
 <139426b9-0e5b-e4c3-27c6-584ab48517c2@quicinc.com> <Y1Z4HrEcLDhe6gQr@hovoldconsulting.com>
In-Reply-To: <Y1Z4HrEcLDhe6gQr@hovoldconsulting.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 24 Oct 2022 08:01:55 -0700
Message-ID: <CAF6AEGuMFCSN2YtXiPmzL_4t82PPp_-K6DB+UHtScygD8PCQHw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] drm/msm: probe deferral fixes
To:     Johan Hovold <johan@kernel.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 4:34 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Oct 21, 2022 at 09:05:52AM -0700, Abhinav Kumar wrote:
> > Hi Johan
> >
> > On 10/20/2022 11:27 PM, Johan Hovold wrote:
> > > On Tue, Sep 20, 2022 at 11:06:30AM +0200, Johan Hovold wrote:
> > >> On Tue, Sep 13, 2022 at 10:53:10AM +0200, Johan Hovold wrote:
> > >>> The MSM DRM driver is currently broken in multiple ways with respect to
> > >>> probe deferral. Not only does the driver currently fail to probe again
> > >>> after a late deferral, but due to a related use-after-free bug this also
> > >>> triggers NULL-pointer dereferences.
> > >>>
> > >>> These bugs are not new but have become critical with the release of
> > >>> 5.19 where probe is deferred in case the aux-bus EP panel driver has not
> > >>> yet been loaded.
> > >>>
> > >>> The underlying problem is lifetime issues due to careless use of
> > >>> device-managed resources.
> > >>
> > >> Any chance of getting this merged for 6.1?
> > >
> > > Is anyone picking these up as fixes for 6.1-rc as we discussed?
> > >
> > > Johan
> >
> > All of these except the last two ( as discussed ) have landed in the
> > -fixes tree
> >
> > https://gitlab.freedesktop.org/drm/msm/-/commit/6808abdb33bf90330e70a687d29f038507e06ebb
>
> Ah, perfect, thanks.
>
> When do you expect to send these on so that they end up in linux-next
> and eventually Linus's tree?

I'll send a -fixes PR this week

> Note that it looks like something happened with the commit messages when
> you applied these. Specifically, the Fixes tags appears to now have a
> line break in them and there's also some random whitespace before your
> SoB:
>
>         Fixes: c3bf8e21
>
>          ("drm/msm/dp: Add eDP support via aux_bus")

naw, that is just some problem with gitlab's html generation, the
actual patch is fine ;-)

BR,
-R

>         Cc: stable@vger.kernel.org      # 5.19
>         Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>         Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>         Tested-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>         Reviewed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>         Patchwork: https://patchwork.freedesktop.org/patch/502667/
>         Link: https://lore.kernel.org/r/20220913085320.8577-8-johan+linaro@kernel.org
>
>
>         Signed-off-by: Abhinav Kumar's avatarAbhinav Kumar <quic_abhinavk@quicinc.com>
>
> It's possible just the gitlab UI that's messed up, but perhaps you can
> double check before they hit linux-next, which should complain about
> this otherwise.
>
> Johan
