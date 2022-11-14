Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6663E628B23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiKNVLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiKNVLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:11:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D06B79
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:11:49 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id n20so10846127ejh.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nYM63RRvqlC+PbmanyesAjjHnH9NOqGbj+n/5jkMu0U=;
        b=f6dGIMl/KDjY03GU6eHJICav9uByHOVeuMW5WTXsr/PPVzAO2OVCrNu3ZCYaiWIXQC
         xddtEHYtvDDIjNVmfmQu7E8l8/gRZfKcaEjXgcRTZTgugEbXu+NbNtCF5jDwvbV1zA4B
         R8ogtQrLOKDOxW3o/ArmlL52u2IMNNZtB0amA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYM63RRvqlC+PbmanyesAjjHnH9NOqGbj+n/5jkMu0U=;
        b=0nEWY7xhf2kzDQlnvKz8PegJ8cF4F05SRk+3E16h8n/hPSF2rmUEYVuJPSB0cQ9GzI
         Plpk060rLNCg5GpsWc9BTldVwWA0n5qO1YcyE2gH/0Tgw2P6lkr0mx2Q9JT+bEXSvsKj
         6MSThcuOybvkS9TXtaFm0iFStQGnmq2MvRDMISO5bIZDQqtByamIplGWYVCLgDe1LrYz
         BQlZuiVFlZrpv3BVFyyHyA3Sm8NOIdi/TFINXG+owSU7/sYjWKjYw7P23imoqfauL0m8
         UH/a3QItqTGUokpA4pH5DZnCAuczeC8R/panoJpIQLiyVxJZ8Di5tMKHT689TDeWStuW
         VyUQ==
X-Gm-Message-State: ANoB5pna9LLH6ZmDfiJ09msU75GWkTVRcnkQuTA1WyoBbGoPzIti4t3E
        FSFUQcWxWBs/5QocDpB6Fg+089gGny7UyQeX
X-Google-Smtp-Source: AA0mqf5rWeOopfOibPMaOJDO5Kg//8kmRW/Hn7BcE+eKohTjBb6qc1D2likXGW9k/VX/Rr08JvvKvg==
X-Received: by 2002:a17:906:fb8f:b0:7ab:1b4c:ac6e with SMTP id lr15-20020a170906fb8f00b007ab1b4cac6emr11998458ejb.669.1668460307321;
        Mon, 14 Nov 2022 13:11:47 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id l27-20020a170906079b00b0073022b796a7sm4662907ejc.93.2022.11.14.13.11.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 13:11:45 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id v1so20636219wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:11:44 -0800 (PST)
X-Received: by 2002:a05:6000:1376:b0:236:7741:fa7b with SMTP id
 q22-20020a056000137600b002367741fa7bmr8968202wrz.138.1668460304144; Mon, 14
 Nov 2022 13:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20221114205055.1547497-1-robdclark@gmail.com>
In-Reply-To: <20221114205055.1547497-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Nov 2022 13:11:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XbYYxP4kFBeGP3AGOwvbc8qNn746qpcZ8zVPc8re0o5Q@mail.gmail.com>
Message-ID: <CAD=FV=XbYYxP4kFBeGP3AGOwvbc8qNn746qpcZ8zVPc8re0o5Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/a6xx: Fix speed-bin detection vs probe-defer
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Nov 14, 2022 at 12:50 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> If we get an error (other than -ENOENT) we need to propagate that up the
> stack.  Otherwise if the nvmem driver hasn't probed yet, we'll end up
> end up claiming that we support all the OPPs which is not likely to be
> true (and on some generations impossible to be true, ie. if there are
> conflicting OPPs).
>
> v2: Update commit msg, gc unused label, etc
>
> Fixed: fe7952c629da ("drm/msm: Add speed-bin support to a618 gpu")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 7fe60c65a1eb..6ae77e88060f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1941,7 +1941,7 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
>
>  static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
>  {
> -       u32 supp_hw = UINT_MAX;
> +       u32 supp_hw;
>         u32 speedbin;
>         int ret;
>
> @@ -1953,15 +1953,13 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
>         if (ret == -ENOENT) {
>                 return 0;
>         } else if (ret) {
> -               DRM_DEV_ERROR(dev,
> -                             "failed to read speed-bin (%d). Some OPPs may not be supported by hardware",
> -                             ret);
> -               goto done;
> +               dev_err_probe(dev, ret,
> +                             "failed to read speed-bin. Some OPPs may not be supported by hardware");
> +               return ret;

Both before and after this change, I think you're missing a "\n" at
the end of your error string?

If you want to get even fancier, dev_err_probe is designed to run
"braceless" and returns "ret" as its return value. This you could do:

if (ret == -ENOENT)
  return ret;
else if (ret)
  return dev_err_probe(dev, ret, ...)

After adding the "\n" then either with the extra fanciness or as you have it:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
