Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120F17100AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbjEXWTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbjEXWSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:18:48 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6504018D;
        Wed, 24 May 2023 15:18:43 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 882053F80E;
        Thu, 25 May 2023 00:18:39 +0200 (CEST)
Date:   Thu, 25 May 2023 00:18:38 +0200
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
Subject: Re: [PATCH v13 07/10] drm/msm/dpu: always clear every individual
 pending flush mask
Message-ID: <mrtwanyokuulcqnug233aszp2ziiw4yafbwwauaxpdpin2jupa@qshyrz54tart>
References: <1684800039-18231-1-git-send-email-quic_khsieh@quicinc.com>
 <1684800039-18231-8-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684800039-18231-8-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 17:00:36, Kuogee Hsieh wrote:
> There are two tiers of pending flush control, top levle and

levle -> level

> individual hardware block. Currently only the top level of
> flush mask is reset to 0 but the individual pending flush masks
> of particular hardware blocks are left at their previous values,
> eventually accumulating all possible bit values and typically
> flushing more than necessary.
> Reset all individual hardware blocks flush masks to 0 to avoid

block, drop -s, because masks is plural.

> individual hardware block be triggered accidentally.

be = from being

triggered = flushed?

(You just said "individual hardware block", it would be okay to refer to
that with just "Reset all individual hardware block flush masks to 0 to
avoid accidentally flushing them.")

> 
> Changes in V13:
> -- rewording commi ttext

commit text

> -- add an empty space line as suggested
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

So no fixes tag?

- Marijn

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index 69d0ea2..64c21e0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -100,6 +100,9 @@ static inline void dpu_hw_ctl_clear_pending_flush(struct dpu_hw_ctl *ctx)
>  	trace_dpu_hw_ctl_clear_pending_flush(ctx->pending_flush_mask,
>  				     dpu_hw_ctl_get_flush_register(ctx));
>  	ctx->pending_flush_mask = 0x0;
> +	ctx->pending_intf_flush_mask = 0;
> +	ctx->pending_wb_flush_mask = 0;
> +	ctx->pending_merge_3d_flush_mask = 0;
>  
>  	memset(ctx->pending_dspp_flush_mask, 0,
>  		sizeof(ctx->pending_dspp_flush_mask));
> -- 
> 2.7.4
> 
