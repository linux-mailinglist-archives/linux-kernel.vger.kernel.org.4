Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D2C70A1C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjESVdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjESVdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:33:10 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B244AFE;
        Fri, 19 May 2023 14:33:05 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 50AFE3F93A;
        Fri, 19 May 2023 23:33:03 +0200 (CEST)
Date:   Fri, 19 May 2023 23:33:02 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] msm/drm/dsi: Round up DSC hdisplay calculation
Message-ID: <aki3mrbsmpn4to74kx3p2sv2xv24ep5wnfu6yp4ehqncwamdmd@yfnpixtyet5n>
References: <20230405-add-dsc-support-v3-0-6e1d35a206b3@quicinc.com>
 <20230405-add-dsc-support-v3-1-6e1d35a206b3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-add-dsc-support-v3-1-6e1d35a206b3@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-19 14:17:26, Jessica Zhang wrote:
> Currently, when compression is enabled, hdisplay is reduced via integer
> division. This causes issues for modes where the original hdisplay is
> not a multiple of 3.

The "issue" probably being some kind of underflow, because the stream
size is too small compared to how much data we actually send?

> To fix this, use DIV_ROUND_UP to divide hdisplay.
> 
> Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
> Fixes: f3a99460406b ("drm/msm/dsi: update hdisplay calculation for dsi_timing_setup")
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Yes, downstream has as very clear:

    dsc->pclk_per_line =  DIV_ROUND_UP(total_bytes_per_intf, 3);

which is used for width_final in SDE, and this is one of the mandatory
fixes on a 1096-pixels-wide panel, which is not a multiple of 3.

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 9223d7ec5a73..18d38b90eb28 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -952,7 +952,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		 * pulse width same
>  		 */
>  		h_total -= hdisplay;
> -		hdisplay = msm_dsc_get_bytes_per_line(msm_host->dsc) / 3;
> +		hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);
>  		h_total += hdisplay;
>  		ha_end = ha_start + hdisplay;
>  	}
> 
> -- 
> 2.40.1
> 
