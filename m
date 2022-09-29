Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD55EF9F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiI2QNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiI2QNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:13:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2881D73DA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:13:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a13so2681798edj.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=V7QLJZSIzhY9dr2OFvy6n8FCoALGEpJ2vGDHHoAqT/I=;
        b=U5nWZ+zCnE6ObM1a1HTcsz5fUlLj7t9tsv+E5+LhXtnz9e4+xVV3xDQOTnsLxYF47t
         2ZD30c3FM7IESBJDjIyKdNG1CIQ3oPQsfMBa45Rch5e+Fgg7012WK4guAP0mWiXKAOHg
         TK5WpXxFwsqpDoq6d1yO9pR9vCsxPFGrv9CUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=V7QLJZSIzhY9dr2OFvy6n8FCoALGEpJ2vGDHHoAqT/I=;
        b=elC779aLCivt+ijc6g7wDkaf6HH+L8KmfKT4WjVYzWsaO2jrmqPrb7q9kKnR7ARrUk
         52rzKe4pYgTKBKahKxljYmo+L4zEtB20WOYyhpk0036BcF6jNaluxiyn3ygNVNJjDsiu
         51zWABc+aTWXuUxoWFwkOzoB+QtGWKBp4nQ5vLQWdmd44HKvY+64K/Wf1iiockpB+s51
         hDq8eYb4cHq7ej+Qgm2SQAsRkiLauwbrCq61Q3IZJO72cILOJIsA0m7sDqC0mNoRe0u7
         svgR3CXXtisBn9CxvapyFpIXRkTFyUlGaSXgPAT43FSfcaQ11tJA+lv6j4WBRZNy/WTr
         PpmA==
X-Gm-Message-State: ACrzQf0P8lKe5OZX4/ZqWzgPAPAesPrbuBOq9RrScgTVNmlj9blhM7DR
        EAAhB3MeTDYBA+22gsG7uHrpZSDXtA6Zg0VC
X-Google-Smtp-Source: AMsMyM4AcdMP0+8QT7NAqg2uFRAGSjoDIPLsxjJmnCbcw+LuJyajruBVVIBm4oGqGx3aLY8OJrECxQ==
X-Received: by 2002:aa7:d8cc:0:b0:457:f8be:d5c4 with SMTP id k12-20020aa7d8cc000000b00457f8bed5c4mr4174576eds.261.1664468020269;
        Thu, 29 Sep 2022 09:13:40 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id qw29-20020a1709066a1d00b0073dddffbe70sm4249558ejc.224.2022.09.29.09.13.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 09:13:38 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id v28so2973189wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:13:38 -0700 (PDT)
X-Received: by 2002:a05:6000:168c:b0:226:f4c2:d6db with SMTP id
 y12-20020a056000168c00b00226f4c2d6dbmr2895434wrd.659.1664468017868; Thu, 29
 Sep 2022 09:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <1663157784-22232-1-git-send-email-quic_kalyant@quicinc.com>
In-Reply-To: <1663157784-22232-1-git-send-email-quic_kalyant@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Sep 2022 09:13:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UT-GmAOYrCBRU0bhGeXU=pOGDbk=Jq7JEk40tyEH0zLA@mail.gmail.com>
Message-ID: <CAD=FV=UT-GmAOYrCBRU0bhGeXU=pOGDbk=Jq7JEk40tyEH0zLA@mail.gmail.com>
Subject: Re: [v5] drm/msm/disp/dpu1: add support for dspp sub block flush in sc7280
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     y@qualcomm.com, dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 14, 2022 at 5:16 AM Kalyan Thota <quic_kalyant@quicinc.com> wrote:
>
> Flush mechanism for DSPP blocks has changed in sc7280 family, it
> allows individual sub blocks to be flushed in coordination with
> master flush control.
>
> Representation: master_flush && (PCC_flush | IGC_flush .. etc )
>
> This change adds necessary support for the above design.
>
> Changes in v1:
> - Few nits (Doug, Dmitry)
> - Restrict sub-block flush programming to dpu_hw_ctl file (Dmitry)
>
> Changes in v2:
> - Move the address offset to flush macro (Dmitry)
> - Seperate ops for the sub block flush (Dmitry)
>
> Changes in v3:
> - Reuse the DPU_DSPP_xx enum instead of a new one (Dmitry)
>
> Changes in v4:
> - Use shorter version for unsigned int (Stephen)
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  5 +++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  4 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c     | 35 ++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h     | 10 ++++++--
>  5 files changed, 50 insertions(+), 6 deletions(-)

Breadcrumbs: though this is tagged in the subject as v5 I think the
newest version is actually "resend v4" [1] which just fixes the
Signed-off-by.

[1] https://lore.kernel.org/r/1663825463-6715-1-git-send-email-quic_kalyant@quicinc.com
