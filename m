Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B746167E225
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjA0Kqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjA0KqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:46:21 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AFE79224
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:46:06 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id e15so5446991ybn.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yEIvFhK3IIlErsVgToB5qFHQjVAAQfk7keFlobxxWmQ=;
        b=pbRiHizXgqKLgJi0SZFHnlopsAQ2dHzA++kqIfzVt60x7aFpDvVIK8jIuZ/e+bHQIr
         TsToNjrN77cQxH7RuLXAD01snstWf+mgyrY4tQ+Yji1eFenSGboymtMKPOgqLeX2HPBA
         1J8WDoPq0J9kfaNBUn0mNnj5oODs+1OdTCAnIFbpUROdGOnaAF7b1mqF4EjjgSk8FnX9
         3xe/ZNyWEnkMxPqOzBgDEu8sO/y+g0aQhoshBqQ1MuRJFoXw/rZahh+ggq0dorOvjrCo
         gKEskc21+60VDKHdlqowmvelAntxyM6fffX/JEcdB6p1UQFrNg43bvsgBe+So4DTpzyV
         v1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEIvFhK3IIlErsVgToB5qFHQjVAAQfk7keFlobxxWmQ=;
        b=SEWHuPNGd38zHDoNbEtE4BCwNqqO7ZwYNOCSda4zsOEXgHDRoVbpeED3nXW/075fkx
         IS7ElYSDTFt/Fe5L4/72DdD92eExQK4/sqrLT1PcTG4ATHEUoHi1ZREMGGCnVc4xIsak
         ljY8DMU1fX4z+XBQDfqE9Q8s2OWNwA1tJ8exuFd6O0NiDvQ9dhj6tXX1JTmZtQRwazR5
         0D/XVxXQeSxdLISpXIBsvAUd2YAnZY1OK165tQ+HvPkhKKMxnBMtc3uHG6augSHz7TQJ
         giQzt/o3aeOxLWUqwxo9kk44i/inGGIF+rvKbmaJrEp4Y2qOdIe6GmG7mK0uh1rmO0KW
         QPOw==
X-Gm-Message-State: AO0yUKXta48lMWVjP3FwRw/hhfNM7ePBvgXsRw/MSrQADISYkS9dj6cd
        I3kdkSAOR0XsfFrUjH8wvQjd2rqg/Dl3xYQuIw2uPg==
X-Google-Smtp-Source: AK7set8CEjnHi7EVPneHsLI4xDP7Wr4mxQeL1iOel0vamGF0k7QBKC5yCvd7idAVuR1tV91uJqvlYEJIbDj6l19NjRo=
X-Received: by 2002:a25:d84f:0:b0:80e:9132:a7fe with SMTP id
 p76-20020a25d84f000000b0080e9132a7femr88574ybg.516.1674816366185; Fri, 27 Jan
 2023 02:46:06 -0800 (PST)
MIME-Version: 1.0
References: <1674814545-9453-1-git-send-email-quic_kalyant@quicinc.com> <1674814545-9453-3-git-send-email-quic_kalyant@quicinc.com>
In-Reply-To: <1674814545-9453-3-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 27 Jan 2023 12:45:55 +0200
Message-ID: <CAA8EJprX-8fcoi3FBR7ZUOa2ehhCGEAngq2+UDdC64hHMraqfA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm/disp/dpu1: add dspps into reservation if
 there is a ctm request
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 at 12:15, Kalyan Thota <quic_kalyant@quicinc.com> wrote:
>
> Add dspp blocks into the topology for reservation, if there is a ctm
> request for that composition.

... rather than just allocating them for DSI encoders.

With this fixed (and one nit below):

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 9c6817b..8d76cb3 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -545,7 +545,8 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
>  static struct msm_display_topology dpu_encoder_get_topology(
>                         struct dpu_encoder_virt *dpu_enc,
>                         struct dpu_kms *dpu_kms,
> -                       struct drm_display_mode *mode)
> +                       struct drm_display_mode *mode,
> +                       struct drm_crtc_state *crtc_state)
>  {
>         struct msm_display_topology topology = {0};
>         int i, intf_count = 0;
> @@ -573,11 +574,9 @@ static struct msm_display_topology dpu_encoder_get_topology(
>         else
>                 topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
>
> -       if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI) {
> -               if (dpu_kms->catalog->dspp &&
> -                       (dpu_kms->catalog->dspp_count >= topology.num_lm))
> -                       topology.num_dspp = topology.num_lm;
> -       }
> +       if (dpu_kms->catalog->dspp && crtc_state->ctm &&

Could you please move the second condition to a separate line? Also
possibly it would be good to indent the conditions to the opening
parenthesis.

> +               (dpu_kms->catalog->dspp_count >= topology.num_lm))
> +               topology.num_dspp = topology.num_lm;
>
>         topology.num_enc = 0;
>         topology.num_intf = intf_count;
> @@ -643,7 +642,7 @@ static int dpu_encoder_virt_atomic_check(
>                 }
>         }
>
> -       topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode);
> +       topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state);
>
>         /* Reserve dynamic resources now. */
>         if (!ret) {
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
