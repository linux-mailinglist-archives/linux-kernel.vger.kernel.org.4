Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4313B5F3A98
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJDA1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJDA06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:26:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEB81B9F4;
        Mon,  3 Oct 2022 17:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C0EEB80DC3;
        Tue,  4 Oct 2022 00:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D22C433D7;
        Tue,  4 Oct 2022 00:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664843215;
        bh=OA9gALTKKnHQ120A5UTTlN4CPGY9ult7j6PDay+Yy1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvlPoU8Qd1mJV9iVXVfw9hRnqYx5Er1VAytV/1aNisZe+s16mCe1PL2MzcnVKRXxT
         /MyXryezYGWaYGRXh+IRNOHf2aN5Al6WotSokibUKc2Zn6daKn6/LaLuvzDKtjuyVe
         HRweKcWOi85Mw9y8Uh3V0VTW+Tv1vT7gsu8YkBf9CbbqXcI69TsqR5/Z+/DDv4RRDV
         lJE61qV4IDqCf3xjFzRBq9Ihlt3332sGv/ozv12x98CnZiYQEt2n0Rz7Xv7tNdYYU8
         mQYe2KbEdYzpWFkUpNrdrZRrNiwSqFOBkzkQTlZeQpFAE2hfGpmYzW6ZHgP8P7UAPE
         yOX8EVzlxXYEA==
Date:   Mon, 3 Oct 2022 19:26:50 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
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
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/5] drm/msm/dsi: Remove useless math in DSC calculation
Message-ID: <20221004002650.joqwhmvzql55ospz@baldur>
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <20221001190807.358691-2-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001190807.358691-2-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 09:08:03PM +0200, Marijn Suijten wrote:
> Multiplying a value by 2 and adding 1 to it always results in a value
> that is uneven, and that 1 gets truncated immediately when performing
> integer division by 2 again.  There is no "rounding" possible here.
> 
> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 8e4bc586c262..e05bae647431 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1864,12 +1864,7 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>  	data = 2048 * (dsc->rc_model_size - dsc->initial_offset + num_extra_mux_bits);
>  	dsc->slice_bpg_offset = DIV_ROUND_UP(data, groups_total);
>  
> -	/* bpp * 16 + 0.5 */
> -	data = dsc->bits_per_pixel * 16;
> -	data *= 2;
> -	data++;
> -	data /= 2;
> -	target_bpp_x16 = data;
> +	target_bpp_x16 = dsc->bits_per_pixel * 16;
>  
>  	data = (dsc->initial_xmit_delay * target_bpp_x16) / 16;
>  	final_value =  dsc->rc_model_size - data + num_extra_mux_bits;
> -- 
> 2.37.3
> 
