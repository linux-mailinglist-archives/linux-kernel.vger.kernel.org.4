Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EFB6F2299
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 05:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347216AbjD2DM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 23:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjD2DMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 23:12:51 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D92D73
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 20:12:49 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so11898115276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 20:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682737968; x=1685329968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZPq6FD/3HdqkAS4gdiecZ5aV1KvKGTujZQ7g9Eep30=;
        b=bFmjAJXxy6pMgjln/PEg/IE4qffr3iiwOaftvquOqJDEeAk5e08MVLnBrv/3pMzIE3
         UUZ75M63FT5x1OkVeAUojMW+6uXRKA0zIGxxk5Z2fFxeOLjJCySORHFIGH1vUJynWFtR
         e2fKQdtDLmvdsPEeK3ac+xDetkOIPPNdU99vZMw8pxGyxUUsh1LguGeMnBcNqufPzJO1
         8TIVSR2iQryMhn8RPGKPDMAARaLuyF0Uhdhkb5bDaqqMynqm8pC87N3a7gmE4LMQIpj2
         6XkhegB5rrvxvrCRQHJFOoTdSWYwgodsE+VqukW5/gyZeNjkgwTkGga9DZikCYIAZJT0
         7OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682737968; x=1685329968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZPq6FD/3HdqkAS4gdiecZ5aV1KvKGTujZQ7g9Eep30=;
        b=bHe5j5QeBIFDMlJTaWQiTFqF+gfHlOXtTDPj8wwazYxVorVhOkZ975jP4h2Mlkc2Jt
         bLB0JYiLc09ZgRdIAkIXiBhfXDCNnTwOC6piz0q1k4rXBRDxHjPguMilbTnxC4LtOIYs
         vLzC3ks7IociK9HrHkYJUueEzN15U4QeMEGx4jUmoXVtkEz3oapuJeuHOONW+la/zBOM
         VxwudwyCKAblMNiMuRg6QrQ8s6EUJIZW00nOag0b6xKS/FBf4ZmFrVu116IkbcoFnlZN
         TDFX4Iu4ALBkC7tVmvpw8vRZXMJ4jf+/tcsdfngqotctloEWthcoQ55Lh9vmZrPU8b+D
         Fd5w==
X-Gm-Message-State: AC+VfDw/M5bJAxIlM2AZBdiB6uOKZm02vMgAb1jZa3SU4skFFNVYveYq
        hxlIK0AK7lHr7KG32uRiySNyI6ua1XVIo8aiy2eLWg==
X-Google-Smtp-Source: ACHHUZ5JBkowR4FYHJ45j/F+E6uXnfkS5GJ5kjJ+2PtHbQwKa11GayybRuy9sEXIRG6SM2/s0chaUKGVNrE40dHGjT8=
X-Received: by 2002:a81:189:0:b0:54f:6f2e:b3f5 with SMTP id
 131-20020a810189000000b0054f6f2eb3f5mr8251813ywb.13.1682737968434; Fri, 28
 Apr 2023 20:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <1682725511-18185-1-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJpqqhP1QL7TuW8JXeVFqukWggYmB1XU8OeB65fQA+jhLAg@mail.gmail.com> <ff60439f-9955-5e89-ee2c-17bc2b07d1e1@quicinc.com>
In-Reply-To: <ff60439f-9955-5e89-ee2c-17bc2b07d1e1@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 29 Apr 2023 06:12:37 +0300
Message-ID: <CAA8EJppr7zYGTJcR4EAB3eybCz0tY=t4Srf2QhLVc4Uu5ZqNtQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] add DSC 1.2 dpu supports
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2023 at 05:51, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 4/28/2023 7:46 PM, Dmitry Baryshkov wrote:
> > On Sat, 29 Apr 2023 at 02:45, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >>
> >> This series adds the DPU side changes to support DSC 1.2 encoder. This
> >> was validated with both DSI DSC 1.2 panel and DP DSC 1.2 monitor.
> >> The DSI and DP parts will be pushed later on top of this change.
> >> This seriel is rebase on [1], [2] and catalog fixes from [3].
> >>
> >> [1]: https://patchwork.freedesktop.org/series/116851/
> >> [2]: https://patchwork.freedesktop.org/series/116615/
> >> [3]: https://patchwork.freedesktop.org/series/112332/
> >>
> >> Abhinav Kumar (2):
> >>    drm/msm/dpu: add DSC 1.2 hw blocks for relevant chipsets
> >>    drm/msm/dpu: add dsc blocks for remaining chipsets in catalog
> >>
> >> Kuogee Hsieh (5):
> >>    drm/msm/dpu: add support for DSC encoder v1.2 engine
> >>    drm/msm/dpu: separate DSC flush update out of interface
> >>    drm/msm/dpu: add DPU_PINGPONG_DSC feature PP_BLK and PP_BLK_TE
> >>    drm/msm/dpu: save dpu topology configuration
> >>    drm/msm/dpu: calculate DSC encoder parameters dynamically
> >
> > Another generic comment: this patchset doesn't have discussed RM
> > changes to allocate DSC blocks in proper pairs as required by DCE.
> >
>
> We have already made that change. It will be pushed with the DP series
> because today DSC only support 2-2-1 so they will always be allocated in
> pairs.

Then there is no reason to touch the dpu_encoder in this series as the
topology is also known to be 2:2:1.

>
> >>
> >>   drivers/gpu/drm/msm/Makefile                       |   1 +
> >>   .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |  19 +-
> >>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |   8 +-
> >>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |  26 +-
> >>   .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  35 ++-
> >>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h |  26 +-
> >>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |   4 +-
> >>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |   2 +-
> >>   .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |   2 +-
> >>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  14 +
> >>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |   7 +
> >>   .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  16 +
> >>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  14 +
> >>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  14 +
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 102 ++++---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  35 ++-
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  36 ++-
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  22 +-
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  10 +
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |  14 +-
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     | 335 +++++++++++++++++++++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |   9 +-
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |   7 +-
> >>   23 files changed, 642 insertions(+), 116 deletions(-)
> >>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
> >>
> >> --
> >> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> >> a Linux Foundation Collaborative Project
> >>
> >
> >



-- 
With best wishes
Dmitry
