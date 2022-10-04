Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FF35F4BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiJDWX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJDWXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:23:24 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936776C104
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:23:21 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B67C43F21A;
        Wed,  5 Oct 2022 00:23:18 +0200 (CEST)
Date:   Wed, 5 Oct 2022 00:23:17 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Marek Vasut <marex@denx.de>,
        freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Subject: Re: [Freedreno] [PATCH 1/5] drm/msm/dsi: Remove useless math in DSC
 calculation
Message-ID: <20221004222317.6or3w6vwgyd3yy6z@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Marek Vasut <marex@denx.de>,
        freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <20221001190807.358691-2-marijn.suijten@somainline.org>
 <7ded0eb3-ef99-1979-ffb6-c639288bd863@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ded0eb3-ef99-1979-ffb6-c639288bd863@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-04 07:33:49, Abhinav Kumar wrote:
> 
> 
> On 10/1/2022 12:08 PM, Marijn Suijten wrote:
> > Multiplying a value by 2 and adding 1 to it always results in a value
> > that is uneven, and that 1 gets truncated immediately when performing
> > integer division by 2 again.  There is no "rounding" possible here.
> > 
> > Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >   drivers/gpu/drm/msm/dsi/dsi_host.c | 7 +------
> >   1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > index 8e4bc586c262..e05bae647431 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > @@ -1864,12 +1864,7 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
> >   	data = 2048 * (dsc->rc_model_size - dsc->initial_offset + num_extra_mux_bits);
> >   	dsc->slice_bpg_offset = DIV_ROUND_UP(data, groups_total);
> >   
> > -	/* bpp * 16 + 0.5 */
> > -	data = dsc->bits_per_pixel * 16;
> > -	data *= 2;
> > -	data++;
> > -	data /= 2;
> > -	target_bpp_x16 = data;
> > +	target_bpp_x16 = dsc->bits_per_pixel * 16;
> >   
> Since this patch is titled, "remove useless math", even the 
> target_bpp_x16 math looks redundant to me,
> 
> first we do
> 
> target_bpp_x16 = dsc->bits_per_pixel * 16;
> 
> then in the next line we do
> 
> data = (dsc->initial_xmit_delay * target_bpp_x16) / 16;
> 
> the *16 and /16 will cancel out here.
> 
> Instead we can just do
> 
> data = (dsc->initial_xmit_delay * dsc->drm->bits_per_pixel) ?

Thanks, good catch!  I might have been so focused on explaining the
effect of this patch and uselessness of the proposed `+ 0.5` rounding
here that I missed this intermediate variable now becoming redundant as
well.

Corrected for v2!

- Marijn

> >   	data = (dsc->initial_xmit_delay * target_bpp_x16) / 16;
> >   	final_value =  dsc->rc_model_size - data + num_extra_mux_bits;
