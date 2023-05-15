Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EF470410A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245739AbjEOWig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjEOWib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:38:31 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE4DDBC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:38:22 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 770773F797;
        Tue, 16 May 2023 00:38:20 +0200 (CEST)
Date:   Tue, 16 May 2023 00:38:19 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/8] drm/msm/dpu: test DPU_PINGPONG_DSC bit before
 assign DSC ops to PINGPONG
Message-ID: <y37celsdtzqlyfvpg6ctkjv53keflykj36l7hd6gxsf7f4suzx@d6ywqy6fyutc>
References: <1684185928-24195-1-git-send-email-quic_khsieh@quicinc.com>
 <1684185928-24195-4-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684185928-24195-4-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You forgot to address the title suggestion "before assign" isn't proper
English.

Copying from v8 review:

    "Guard PINGPONG DSC ops behind DPU_PINGPONG_DSC bit"

On 2023-05-15 14:25:23, Kuogee Hsieh wrote:
> 
> DPU < 7.0.0 has DPU_PINGPONG_DSC feature bit set to indicate it requires
> both dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() to be
> executed to complete DSC configuration if DSC hardware block is present.
> Hence test DPU_PINGPONG_DSC feature bit and assign DSC related functions
> to the ops of PINGPONG block accordingly if DPU_PINGPONG_DSC bit is set.
> 
> changes in v6:
> -- split patches, this patch has function handles DPU_PINGPONG_DSC bit
> 
> changes in v9:
> -- remove un condition assign dsc related functions to pingpong ops

Remember that in the DRM subsystem, these horrible changelogs are
allowed as part of the commit message.  I already disagree with that,
and as pointed out by Dmitry this particular one is unreadable.  I
typically see them through as noise, but this one could use a rewrite.
I won't bother suggesting the right wording yet again though.

> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

For the contents:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> index 79e4576..437d9e6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> @@ -291,9 +291,12 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
>  		c->ops.get_line_count = dpu_hw_pp_get_line_count;
>  		c->ops.disable_autorefresh = dpu_hw_pp_disable_autorefresh;
>  	}
> -	c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> -	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> -	c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
> +
> +	if (test_bit(DPU_PINGPONG_DSC, &features)) {
> +		c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> +		c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> +		c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
> +	}
>  
>  	if (test_bit(DPU_PINGPONG_DITHER, &features))
>  		c->ops.setup_dither = dpu_hw_pp_setup_dither;
> -- 
> 2.7.4
> 
