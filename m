Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C615F45CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJDOlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJDOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:41:20 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0540D13F5D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:41:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e20so2524712ybh.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=z41duvCKMloCMs7/yS+eYyEb+WVImktYvIerwjQ5evI=;
        b=j6jR0OTmSljAbwsij5gsdUL+4ZFD75ZNHeSNzLJ6oPjvuO064edahqdHCjca2FVoNE
         BMIHxdhPWGZSeyUjkE1RHfGXRB1XY9mBdsQfsg8uEzypRG2oXvwJJoxkKG1IpkFp+9Vt
         GB2IpJ0heualwYLJrYc4+9+qsVEaYfxxVwtG4s6CPJMrVT3z67fuJVcjqBlA7iF/Tvmq
         169kZ+gBTNZftLrhpsg1ijx/7QF/AcuUd6OcGh1vUK0r5nE/7O6Z+j4DRK85NvpKEiM+
         r/M3ChmBXywKUVwIWfnXmH9FcDntC5jTRgrPSDSEn/mZh9kSoOL/A0e2vegGLeFvFokX
         5m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=z41duvCKMloCMs7/yS+eYyEb+WVImktYvIerwjQ5evI=;
        b=yXEvJSTsNp+VoergTC5tHLCeVsOsPMjGWm8MyHPdp5PzrtK+mPdzivkpH4UPqW8/WL
         ZcrWrQsbrpo+VIcaO5HPxl0R+8x63fr5DCPfl8ziw3l7xOVNyPons33sM9zDf/biT6V2
         /LpCtsdnrH14pHcVWG/HO3JIin12470VLvEhPqiBLflUNaXIbuPjbdm8TAPNS+Dny13S
         ftq/aMjVNeTvHzEcIkaDroSxGwoYLOf0bgWWw88QQzjdUjoMr7BFY9IL6U5cm3cKINuB
         liS+OliWDSpvIvzJCfFkUUmMH+IDM4+dKmH4y043msPxb7H9LBl2g/iNZV02TrZ1K79/
         LYng==
X-Gm-Message-State: ACrzQf1bip7/lOSsf6EEtrT5tCMd7vcKnm2bdMhNFTpYf7k/Gbz+r1yp
        CMDXd+zYPYo+mZ18Kzk5DeRmhULN2tWrYiaFIxP+IQ==
X-Google-Smtp-Source: AMsMyM6iglxo2rnyStaDCkTZCnJHAIs8F74+vN9/msLvrF4RKqOOdLEukISP12dZ8dOsqZ63qavPJSynh+H9LBTCOZ4=
X-Received: by 2002:a25:2e4e:0:b0:6bc:ac92:a4df with SMTP id
 b14-20020a252e4e000000b006bcac92a4dfmr26652384ybn.153.1664894478194; Tue, 04
 Oct 2022 07:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <20221001190807.358691-6-marijn.suijten@somainline.org> <20221001202313.fkdsv5ul4v6akhc3@SoMainline.org>
In-Reply-To: <20221001202313.fkdsv5ul4v6akhc3@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 4 Oct 2022 17:41:07 +0300
Message-ID: <CAA8EJpricAKmrtqGJx_ngqyqCWjc2rbrOcsE5QaH5qKaHP7-2g@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/dsc: Prevent negative BPG offsets from shadowing
 adjacent bitfields
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Lyude Paul <lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 at 23:23, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2022-10-01 21:08:07, Marijn Suijten wrote:
> > msm's dsi_host specifies negative BPG offsets which fill the full 8 bits
> > of a char thanks to two's complement: this however results in those bits
> > bleeding into the next parameter when the field is only expected to
> > contain 6-bit wide values.
> > As a consequence random slices appear corrupted on-screen (tested on a
> > Sony Tama Akatsuki device with sdm845).
> >
> > Use AND operators to limit all values that constitute the RC Range
> > parameter fields to their expected size.
> >
> > Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >  drivers/gpu/drm/display/drm_dsc_helper.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/display/drm_dsc_helper.c b/drivers/gpu/drm/display/drm_dsc_helper.c
> > index c869c6e51e2b..2e7ef242685d 100644
> > --- a/drivers/gpu/drm/display/drm_dsc_helper.c
> > +++ b/drivers/gpu/drm/display/drm_dsc_helper.c
> > @@ -243,11 +243,11 @@ void drm_dsc_pps_payload_pack(struct drm_dsc_picture_parameter_set *pps_payload,
> >        */
> >       for (i = 0; i < DSC_NUM_BUF_RANGES; i++) {
> >               pps_payload->rc_range_parameters[i] =
> > -                     cpu_to_be16((dsc_cfg->rc_range_params[i].range_min_qp <<
> > +                     cpu_to_be16(((dsc_cfg->rc_range_params[i].range_min_qp & 0x1f) <<
> >                                    DSC_PPS_RC_RANGE_MINQP_SHIFT) |
> > -                                 (dsc_cfg->rc_range_params[i].range_max_qp <<
> > +                                 ((dsc_cfg->rc_range_params[i].range_max_qp & 0x1f) <<
> >                                    DSC_PPS_RC_RANGE_MAXQP_SHIFT) |
> > -                                 (dsc_cfg->rc_range_params[i].range_bpg_offset));
> > +                                 (dsc_cfg->rc_range_params[i].range_bpg_offset & 0x3f));
>
> Pre-empting the reviews: I was contemplating whether to use FIELD_PREP
> here, given that it's not yet used anywhere else in this file.  For that
> I'd remove the existing _SHIFT definitions and replace them with:
>
>         #define DSC_PPS_RC_RANGE_MINQP_MASK             GENMASK(15, 11)
>         #define DSC_PPS_RC_RANGE_MAXQP_MASK             GENMASK(10, 6)
>         #define DSC_PPS_RC_RANGE_BPG_OFFSET_MASK        GENMASK(5, 0)
>
> And turn this section of code into:
>
>         cpu_to_be16(FIELD_PREP(DSC_PPS_RC_RANGE_MINQP_MASK,
>                                dsc_cfg->rc_range_params[i].range_min_qp) |
>                     FIELD_PREP(DSC_PPS_RC_RANGE_MAXQP_MASK,
>                                dsc_cfg->rc_range_params[i].range_max_qp) |
>                     FIELD_PREP(DSC_PPS_RC_RANGE_BPG_OFFSET_MASK,
>                                dsc_cfg->rc_range_params[i].range_bpg_offset));
>
> Is that okay/recommended?

This is definitely easier to review. However if you do not want to use
FIELD_PREP, it would be better to split this into a series of `data |=
something` assignments terminated with the rc_range_parameters[i]
assignment.

>
> - Marijn
>
> >       }
> >
> >       /* PPS 88 */
> > --
> > 2.37.3
> >



-- 
With best wishes
Dmitry
