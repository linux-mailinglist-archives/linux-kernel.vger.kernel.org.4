Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5172F68FEA7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBIE0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjBIEZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:25:52 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95D38B47
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 20:25:20 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id w13so406275ilv.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 20:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3JCdbvKeiUcH/OkexvFMP8KnMjvRlzLquNMe2eJDPM=;
        b=YbUbDyPLqiPzWst58OZ6HfyZTQdO47nm+/kxW34nvPdgReGLE8CZKTkEAsRznj1YyQ
         Jo+m685SMmEizOIuzU3KvveGYv2W8fURphN+KyHUCLe4XS+I7UPupca2pJiRF0aZ7TYT
         glzF7jMl7nHOvLmU1nRcYvPKovPfoTljGDOPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3JCdbvKeiUcH/OkexvFMP8KnMjvRlzLquNMe2eJDPM=;
        b=d48pXzUwy4yi+D4eSTz1jLLnQ26bGVaXQzQRWped2JmrJDEVDRIqIa1c8FBRBOKWBi
         gn65o46Kfik3alCr8vqMT/xOd/Kk6kRDrqn2J0y+Wlzd0iajag/vS7GUhle5gHFwfN54
         RL2emb2Ry7emQjP/Fc9e10M7MEjwkL+mv6ktS/hARJT+18ZfbqaSVG0DnahyNUQalLjH
         w6WBx2v09Frjel3gftbMgz8V+7EDRsrdy/HY3Z+az43X+tzhWtxad64kj6EbTJFkRCDj
         cHq61RtavFU3xbC9Qjoyv+85LPytTqkN/ii1rgXvDZn69bAXA4HdfPkkI0HoVYM7VPcU
         wiBw==
X-Gm-Message-State: AO0yUKXG9Z4fF/MbyQSlextPlEZc+Yvdb7bRtRipM2Qv0yjm9jXzbsW/
        QalAh8aSpp16JdVBhpENXvLFSbKZEj8GEa/ne+s=
X-Google-Smtp-Source: AK7set8XV7qjtRpTyOB0SQdPl/aKfT1kpk4AknbFQNPkuFIle+3jmukX5R5BCWP95TIPY6MihegR5g==
X-Received: by 2002:a05:6e02:2168:b0:313:eee4:1365 with SMTP id s8-20020a056e02216800b00313eee41365mr4955879ilv.4.1675916665010;
        Wed, 08 Feb 2023 20:24:25 -0800 (PST)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id x19-20020a029713000000b003c41434babdsm109783jai.92.2023.02.08.20.24.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 20:24:24 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id v15so388409ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 20:24:24 -0800 (PST)
X-Received: by 2002:a92:b513:0:b0:310:9276:5d29 with SMTP id
 f19-20020a92b513000000b0031092765d29mr5213990ile.76.1675916663704; Wed, 08
 Feb 2023 20:24:23 -0800 (PST)
MIME-Version: 1.0
References: <1675863724-28412-1-git-send-email-quic_kalyant@quicinc.com>
 <CAD=FV=WbzmF_Jkwrcm27eqXaqNhGq_D=8yfCKqELET+=+EaLAA@mail.gmail.com> <BN0PR02MB8142207261497BE76A6EA07096D99@BN0PR02MB8142.namprd02.prod.outlook.com>
In-Reply-To: <BN0PR02MB8142207261497BE76A6EA07096D99@BN0PR02MB8142.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Feb 2023 20:24:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XVaEzyZybZ3JmFnPQkSZyw-3UfD0Mupt_adnnJcYy_iQ@mail.gmail.com>
Message-ID: <CAD=FV=XVaEzyZybZ3JmFnPQkSZyw-3UfD0Mupt_adnnJcYy_iQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Reserve DSPPs based on user request
To:     Kalyan Thota <kalyant@qti.qualcomm.com>
Cc:     "Kalyan Thota (QUIC)" <quic_kalyant@quicinc.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robdclark@chromium.org" <robdclark@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "Vinod Polimera (QUIC)" <quic_vpolimer@quicinc.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "marijn.suijten@somainline.org" <marijn.suijten@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 8, 2023 at 8:16 PM Kalyan Thota <kalyant@qti.qualcomm.com> wrote:
>
> Hi Doug,
>
> Have you picked the core change to program dspp's  (below) ? the current series will go on top of it.
> https://patchwork.kernel.org/project/linux-arm-msm/patch/1671542719-12655-1-git-send-email-quic_kalyant@quicinc.com/

I didn't pick v11 of it like you link, but I did pick v12 of the same
patch. In my response I said that I picked 5 patches, this series plus
[1] where [1] is:

[1] https://lore.kernel.org/all/1674814487-2112-1-git-send-email-quic_kalyant@quicinc.com/


> Thanks,
> Kalyan
>
> >-----Original Message-----
> >From: Doug Anderson <dianders@chromium.org>
> >Sent: Wednesday, February 8, 2023 10:44 PM
> >To: Kalyan Thota (QUIC) <quic_kalyant@quicinc.com>
> >Cc: dri-devel@lists.freedesktop.org; linux-arm-msm@vger.kernel.org;
> >freedreno@lists.freedesktop.org; devicetree@vger.kernel.org; linux-
> >kernel@vger.kernel.org; robdclark@chromium.org; swboyd@chromium.org;
> >Vinod Polimera (QUIC) <quic_vpolimer@quicinc.com>;
> >dmitry.baryshkov@linaro.org; Abhinav Kumar (QUIC)
> ><quic_abhinavk@quicinc.com>; marijn.suijten@somainline.org
> >Subject: Re: [PATCH v3 0/4] Reserve DSPPs based on user request
> >
> >WARNING: This email originated from outside of Qualcomm. Please be wary of
> >any links or attachments, and do not enable macros.
> >
> >Hi,
> >
> >On Wed, Feb 8, 2023 at 5:42 AM Kalyan Thota <quic_kalyant@quicinc.com>
> >wrote:
> >>
> >> This series will enable color features on sc7280 target which has
> >> primary panel as eDP
> >>
> >> The series removes DSPP allocation based on encoder type and allows
> >> the DSPP reservation based on user request via CTM.
> >>
> >> The series will release/reserve the dpu resources when ever there is a
> >> topology change to suit the new requirements.
> >>
> >> Kalyan Thota (4):
> >>   drm/msm/dpu: clear DSPP reservations in rm release
> >>   drm/msm/dpu: add DSPPs into reservation upon a CTM request
> >>   drm/msm/dpu: avoid unnecessary check in DPU reservations
> >>   drm/msm/dpu: reserve the resources on topology change
> >>
> >>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  2 +
> >>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 58 ++++++++++++++++------
> >-------
> >>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  2 +
> >>  3 files changed, 37 insertions(+), 25 deletions(-)
> >
> >I tried out your changes, but unfortunately it seems like there's something wrong.
> >:( I did this:
> >
> >1. Picked your 5 patches to the chromeos-5.15 tree (this series plus [1])
> >
> >2. Put them on herobrine villager.
> >
> >3. Booted up with no external display plugged in.
> >
> >4. Tried to enable night light in the ChromeOS UI.
> >
> >5. Night light didn't turn on for the internal display.
> >
> >
> >I also tried applying them to the top of msm-next (had to resolve some small
> >conflicts). Same thing, night light didn't work.
> >
> >
> >I thought maybe this was because the Chrome browser hasn't been updated to
> >properly use atomic_check for testing for night light, so I hacked my herobrine
> >device tree to not mark "mdss_dp" as "okay". Now there's _only_ an eDP display.
> >Same thing, night light didn't work.
> >
> >
> >I could only get night light to work for the internal display if I plugged and
> >unplugged an external display in.
> >
> >
> >Is the above the behavior that's expected right now?
> >
> >
> >[1] https://lore.kernel.org/all/1674814487-2112-1-git-send-email-
> >quic_kalyant@quicinc.com/
