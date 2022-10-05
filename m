Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D335F5AA1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 21:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJETcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 15:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiJETb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 15:31:58 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1645F78220
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 12:31:55 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 63so21499467ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pNtNncR0wpG+RZXZr5KeeJhXaAoqohkUyg5Z94mN40s=;
        b=eze16KyzdJ5hwJ2phuh1n3FB+XyFgZfEOKeoxcX86f8I4EsycFU0JzP6v64Z9I7hwM
         luAR1jmz4nZ0lYx6P+TN4JE4xM5GA1jl4RhGpNZQMa29n9eOmAcWnmzmfRDDQdNwHiiP
         O8C2MeRIDJm27WzWNXQSciNu0lXJPOik22kTXE/+VW/jbhw5SGoAjOPau9aGDSfZWL2g
         yZ63Pe9JvG8zgT0tmhdhBvMXGjOK2fcjiaxmp4N7GwFnY1+M67rO4c8BLep86Rs7DV/h
         GBLefRqpEmw/W5Emf7k2pBk4r0jjg68jqBKGoa6ji/QfheMWW5hyr73hB9AkDGuJlnxJ
         ImLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pNtNncR0wpG+RZXZr5KeeJhXaAoqohkUyg5Z94mN40s=;
        b=WkawmcHbjoUHZznoZB02cK4nXaK3FcaXgs6uNYU4/WTB+h/aM5NhfG5+DfEJs7UZWq
         wkW/73QmTJataLRmRwt9YftF8HPSbdSSREMP2jWqv9OrNi8lT3cqkNs1FqQAjfgW//ir
         jFgOu908B1XRvg+cVrgpMYZlTIsqTGI3XHoPenXOexHvEVQDSxhzbijhUb5qLpuLCyfO
         AI7xHmLYey8H9akPOUtg1JtnmwHv5vcU/LaVbPHz56PVylbTSuIDWbnZ50V68Xtagn8I
         ahc1XSGx/kKrJY1qFXk14LkCkjAdAJCX9tfkIvgXOQum5VkP+fOzhn9YDBGGgk9TyI7Y
         JSqw==
X-Gm-Message-State: ACrzQf3+bIICKc/JZ5ZHBaC3sKC42jzHUwleu3qKUwFg4rFq3kTZpMXu
        txQzaTOwXgBdjMe6fl7vMlBFpgPWahtLCxOGPeti8Q==
X-Google-Smtp-Source: AMsMyM7CcJKKTb5CQJ62Px6sdKcviE/zaAzyLJdaB+lxId5akeMpt+XTMLRld1K+DLepysr5m0r1h7WGBGRvkIxIwtg=
X-Received: by 2002:a5b:c:0:b0:6bd:f84c:b63e with SMTP id a12-20020a5b000c000000b006bdf84cb63emr1449786ybp.275.1664998314594;
 Wed, 05 Oct 2022 12:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221005181657.784375-1-marijn.suijten@somainline.org> <20221005181657.784375-6-marijn.suijten@somainline.org>
In-Reply-To: <20221005181657.784375-6-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 5 Oct 2022 22:31:43 +0300
Message-ID: <CAA8EJpr=0w0KReqNW2jP8DzvXLgo_o6bKmwMOed2sXb6d8HKhg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drm/msm/dsi: Account for DSC's bits_per_pixel
 having 4 fractional bits
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
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
        David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 at 21:17, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> drm_dsc_config's bits_per_pixel field holds a fractional value with 4
> bits, which all panel drivers should adhere to for
> drm_dsc_pps_payload_pack() to generate a valid payload.  All code in the
> DSI driver here seems to assume that this field doesn't contain any
> fractional bits, hence resulting in the wrong values being computed.
> Since none of the calculations leave any room for fractional bits or
> seem to indicate any possible area of support, disallow such values
> altogether.
>
> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index f42794cdd4c1..4717d49d76be 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -33,7 +33,7 @@
>
>  #define DSI_RESET_TOGGLE_DELAY_MS 20
>
> -static int dsi_populate_dsc_params(struct drm_dsc_config *dsc);
> +static int dsi_populate_dsc_params(struct msm_dsi_host *msm_host, struct drm_dsc_config *dsc);
>
>  static int dsi_get_version(const void __iomem *base, u32 *major, u32 *minor)
>  {
> @@ -908,6 +908,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>         u32 va_end = va_start + mode->vdisplay;
>         u32 hdisplay = mode->hdisplay;
>         u32 wc;
> +       int ret;
>
>         DBG("");
>
> @@ -943,7 +944,9 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>                 /* we do the calculations for dsc parameters here so that
>                  * panel can use these parameters
>                  */
> -               dsi_populate_dsc_params(dsc);
> +               ret = dsi_populate_dsc_params(msm_host, dsc);
> +               if (ret)
> +                       return;
>
>                 /* Divide the display by 3 but keep back/font porch and
>                  * pulse width same
> @@ -1769,7 +1772,7 @@ static char bpg_offset[DSC_NUM_BUF_RANGES] = {
>         2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -12, -12, -12, -12
>  };
>
> -static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
> +static int dsi_populate_dsc_params(struct msm_dsi_host *msm_host, struct drm_dsc_config *dsc)
>  {
>         int mux_words_size;
>         int groups_per_line, groups_total;
> @@ -1780,6 +1783,12 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>         int data;
>         int final_value, final_scale;
>         int i;
> +       u16 bpp = dsc->bits_per_pixel >> 4;
> +
> +       if (dsc->bits_per_pixel & 0xf) {
> +               DRM_DEV_ERROR(&msm_host->pdev->dev, "DSI does not support fractional bits_per_pixel\n");
> +               return -EINVAL;
> +       }
>
>         dsc->rc_model_size = 8192;
>         dsc->first_line_bpg_offset = 12;
> @@ -1801,7 +1810,7 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>         }
>
>         dsc->initial_offset = 6144; /* Not bpp 12 */
> -       if (dsc->bits_per_pixel != 8)
> +       if (bpp != 8)
>                 dsc->initial_offset = 2048;     /* bpp = 12 */
>
>         mux_words_size = 48;            /* bpc == 8/10 */
> @@ -1824,14 +1833,14 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>          * params are calculated
>          */
>         groups_per_line = DIV_ROUND_UP(dsc->slice_width, 3);
> -       dsc->slice_chunk_size = DIV_ROUND_UP(dsc->slice_width * dsc->bits_per_pixel, 8);
> +       dsc->slice_chunk_size = DIV_ROUND_UP(dsc->slice_width * bpp, 8);

I'd still prefer if we can get closer to drm_dsc_compute_rc_parameters().
The mentioned function has the following code:

vdsc_cfg->slice_chunk_size = DIV_ROUND_UP(vdsc_cfg->slice_width *

vdsc_cfg->bits_per_pixel,
                                                          (8 * 16));

In fact, could you please take a look if we can switch to using this
function and drop our code?

>
>         /* rbs-min */
>         min_rate_buffer_size =  dsc->rc_model_size - dsc->initial_offset +
> -                               dsc->initial_xmit_delay * dsc->bits_per_pixel +
> +                               dsc->initial_xmit_delay * bpp +
>                                 groups_per_line * dsc->first_line_bpg_offset;
>
> -       hrd_delay = DIV_ROUND_UP(min_rate_buffer_size, dsc->bits_per_pixel);
> +       hrd_delay = DIV_ROUND_UP(min_rate_buffer_size, bpp);
>
>         dsc->initial_dec_delay = hrd_delay - dsc->initial_xmit_delay;
>
> @@ -1854,7 +1863,7 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>         data = 2048 * (dsc->rc_model_size - dsc->initial_offset + num_extra_mux_bits);
>         dsc->slice_bpg_offset = DIV_ROUND_UP(data, groups_total);
>
> -       data = dsc->initial_xmit_delay * dsc->bits_per_pixel;
> +       data = dsc->initial_xmit_delay * bpp;
>         final_value =  dsc->rc_model_size - data + num_extra_mux_bits;
>         dsc->final_offset = final_value;
>
> --
> 2.38.0
>


-- 
With best wishes
Dmitry
