Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942F074C6E8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 20:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGISAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGISAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 14:00:14 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F29114
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 11:00:12 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c5c8d00ced3so4488991276.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688925611; x=1691517611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u4DBsm9V7fTDvKx918DKQDmxOgvOJF74sUuwO0ox2Ec=;
        b=vxRgIcDZCdKysN9u5e/P0Mk+1qTauAmLbQGUgHGKEnTrrVjVfF8aRQgXNkdpwNKtso
         z8OW1HHfk+BP9+3b0NYGgmo1cqC1dNep8cPJs0DCf5IEpOOl2YUrPVFZ3c6yFCuGZy4i
         SVHYFmCtbVn9/s2hoZJ49WHlQH59W90pfh9lA/eb/+pugtDqnZJc/0IJahTTiqaY4Vzk
         1WrlPZDLO5SgPrk6xtqbFrFD6MccqYfdC9JgfnhpS9uXoCHuwqdGVsGecaY9zjvID2l4
         PyqhTrEHJkApgYxcRt6QgGsaPi7YlwCJmtJ/KwTYz07w+dIONIm5ui/y8eKvNjaOtX+M
         Syrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688925611; x=1691517611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4DBsm9V7fTDvKx918DKQDmxOgvOJF74sUuwO0ox2Ec=;
        b=BJtrFYXxN9viumqyfqn+MLgEYjt3VdhTGz8d3pm5ou/Km0nBjvZgZU4aoIw8ZnhUn/
         R8Zak3SRTmdw7Zkm+/etjhkZH+SFtgtIdkdlmrw7F4ww4AlcnvZx+Am182/BGTAC0awD
         NRGDQc7l/yP5nZqUCuu15c7U5ypsQz/oH7eWTc8nASN9H2j3De+wE3Z5vXpF1659CCe8
         k0kO76IIf4tFb2+tbsAzbUjZ4icW8Rs/WOx9yBnhcJCcAA8cYwu/CPbZuRDikw1vxBKc
         +FQTeAqz4GFAih29AqfPDoj+9Lx1JH/RdpoYHlqpPi7+WctEh8T9jWxS9nfLKGZCV0Et
         Vaow==
X-Gm-Message-State: ABy/qLYWhFbTnMzMFrX3PWgAt1oZgojbhhIFSh11JksgkVoiAE4Ggxmn
        xiIyfoe1OyLa5p65BQA0Lp+e5hcj0QxL+VqeBZLWlw==
X-Google-Smtp-Source: APBJJlEWXBHCrZHA3JCHjoudX7Ecgk5TDBCrrA3oUgTtzhr9PEaNnulSiA1S6XZKAEopv26+3p9AtmwqEhS9liy+4l4=
X-Received: by 2002:a81:92d3:0:b0:579:f8f2:b5b5 with SMTP id
 j202-20020a8192d3000000b00579f8f2b5b5mr9459703ywg.41.1688925611714; Sun, 09
 Jul 2023 11:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <1688773943-3887-1-git-send-email-quic_khsieh@quicinc.com>
 <1688773943-3887-2-git-send-email-quic_khsieh@quicinc.com>
 <fc5501cf-c335-81f7-1ad7-26fdc1b6922d@linaro.org> <72cb729b-a9d3-3e5b-c70a-0761f47a6779@quicinc.com>
In-Reply-To: <72cb729b-a9d3-3e5b-c70a-0761f47a6779@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 9 Jul 2023 21:00:00 +0300
Message-ID: <CAA8EJpqKVBKRpFs=sS2rwrJpDP22sNrd00kCYm-b_ZB96O=s5g@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v1 1/5] drm/msm/dp: remove pm_runtime_xxx()
 from dp_power.c
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_sbillaka@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, quic_jesszhan@quicinc.com,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2023 at 20:22, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 7/7/2023 5:06 PM, Dmitry Baryshkov wrote:
> > On 08/07/2023 02:52, Kuogee Hsieh wrote:
> >> Since both pm_runtime_resume() and pm_runtime_suspend() are not
> >> populated at dp_pm_ops. Those pm_runtime_get/put() functions within
> >> dp_power.c will not have any effects in addition to increase/decrease
> >> power counter.
> >
> > Lie.
> >
>
> Even if the commit text is incorrect, review comments like this are not
> helping the patch nor the author and will just get ignored anyway.

The review comment might be overreacting, excuse me. I was really
impressed by the commit message, which contradicts the basic source
code. pm_runtime_get() does a lot more than just increasing the power
counter.

> >> Also pm_runtime_xxx() should be executed at top
> >> layer.
> >
> > Why?
> >
>
> I guess he meant to centralize this around dp_display.c. Will elaborate
> while posting the next rev.
>
> >>
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/dp/dp_power.c | 9 ---------
> >>   1 file changed, 9 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_power.c
> >> b/drivers/gpu/drm/msm/dp/dp_power.c
> >> index 5cb84ca..ed2f62a 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_power.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_power.c
> >> @@ -152,8 +152,6 @@ int dp_power_client_init(struct dp_power *dp_power)
> >>       power = container_of(dp_power, struct dp_power_private, dp_power);
> >> -    pm_runtime_enable(power->dev);
> >> -
> >>       return dp_power_clk_init(power);
> >>   }
> >> @@ -162,8 +160,6 @@ void dp_power_client_deinit(struct dp_power
> >> *dp_power)
> >>       struct dp_power_private *power;
> >>       power = container_of(dp_power, struct dp_power_private, dp_power);
> >> -
> >> -    pm_runtime_disable(power->dev);
> >>   }
> >>   int dp_power_init(struct dp_power *dp_power)
> >> @@ -173,11 +169,7 @@ int dp_power_init(struct dp_power *dp_power)
> >>       power = container_of(dp_power, struct dp_power_private, dp_power);
> >> -    pm_runtime_get_sync(power->dev);
> >> -
> >>       rc = dp_power_clk_enable(dp_power, DP_CORE_PM, true);
> >> -    if (rc)
> >> -        pm_runtime_put_sync(power->dev);
> >>       return rc;
> >>   }
> >> @@ -189,7 +181,6 @@ int dp_power_deinit(struct dp_power *dp_power)
> >>       power = container_of(dp_power, struct dp_power_private, dp_power);
> >>       dp_power_clk_enable(dp_power, DP_CORE_PM, false);
> >> -    pm_runtime_put_sync(power->dev);
> >>       return 0;
> >>   }
> >



-- 
With best wishes
Dmitry
