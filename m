Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C987C70A1AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjESVVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjESVVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:21:33 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10853E5F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:20:54 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A98823F92F;
        Fri, 19 May 2023 23:20:47 +0200 (CEST)
Date:   Fri, 19 May 2023 23:20:46 +0200
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
Subject: Re: [PATCH v2 1/4] drm/msm/dsi: Adjust pclk rate for compression
Message-ID: <u4x2vldkzsokfcpbkz3dtwcllbdk4ljcz6kzuaxt5frx6g76o5@uku6abewvye7>
References: <20230405-add-dsc-support-v2-0-1072c70e9786@quicinc.com>
 <20230405-add-dsc-support-v2-1-1072c70e9786@quicinc.com>
 <79b468f5-8f2e-175b-5bce-1b3ea5127628@quicinc.com>
 <i4bemmveyvowfy7dogetoygaflfttpe26dpg7bbimrzf53wv3w@o3odsno4pb2w>
 <d4e78b24-a3f1-37a3-11c1-92631b3e7c45@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e78b24-a3f1-37a3-11c1-92631b3e7c45@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-19 12:04:00, Jessica Zhang wrote:
<snip>
> >>> +	/* If DSC is enabled, divide hdisplay by compression ratio */
> >>> +	if (dsc) {
> >>> +		int new_hdisplay = DIV_ROUND_UP(mode->hdisplay * msm_dsc_get_bpp_int(dsc),
> >>> +				dsc->bits_per_component * 3);
> >>> +		int fps = DIV_ROUND_UP(pclk_rate, mode->htotal * mode->vtotal);
> >>
> >> Should've used drm_mode_vrefresh() here... Will spin a v3 with that
> >> change (along with any additional comments)
> > 
> > Perhaps unsigned long on some of these?  Overall the computations and
> > multi-lines look rather cluttered, perhaps (parts of) this is/are a
> > prime candidate to go into the new helpers?
> 
> Hi Marijn,
> 
> Sorry for the late reply, wanted to get the MSM DSC helpers series 
> settled first before addressing these changes.

No hurry and no worry, that is exactly why I requested this to be split
across multiple series so that we can make progress on that in isolation
(or rather, make progress on the first series in the chain before
iterating on the next).  On the other hand Dmitry made the right remark
that it does cause contention for some patches that only become relevant
in future series... but that's mostly down to how the patches are
distributed across series.

> Sounds good, I'll put these calculations in a separate 
> dsi_adjust_compressed_pclk() helper.

Not sure if "adjust" carries the meaning, but I'll leave it to you to
come up with an initial revision and then we can discuss.  I am mostly
curious if there are generic (DSI) timing rules that apply DRM-wide, or
if these would be MSM-specific.

Otherwise assigning them to properly named local variables is the
perfect way to self-document the code.

> > Note that I cannot get the 4k mode working at 60Hz on one of my panels
> > (30Hz works with minor corruption), regardless of this patch.  See also:
> > https://gitlab.freedesktop.org/drm/msm/-/issues/24#note_1900031
> As discussed elsewhere, we suspect that this is unrelated to DSC 
> specifically and might be an issue with the upstream driver not taking 
> transfer time into account with calculating pclk_rate.
> 
> We will look into this as a separate issue.

Yes that is very likely, but it is still a good idea to take into
account when looking into adjusting DSC timing: can we do that in any
sensible way without first accounting for transfer time?

<snip>
> >>>    	dsi_calc_pclk(msm_host, is_bonded_dsi);
> >>>    
> >>> -	pclk_bpp = (u64)dsi_get_pclk_rate(msm_host->mode, is_bonded_dsi) * bpp;
> >>> +	pclk_bpp = (u64)dsi_get_pclk_rate(msm_host->mode, msm_host->dsc, is_bonded_dsi) * bpp;
> > 
> > Let's rebase on top of "drm/msm/dsi: simplify pixel clk rate handling"
> > [1] to clean this up.
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20230118130031.2345941-1-dmitry.baryshkov@linaro.org/
> 
> I've looked into this patch and have made a comment on it. Just have 
> some reservations about it as it changes the functionality of a clk 
> handler op.
> 
> I will hold off on rebasing and wait for that thread to resolve first.

Looks like the resolution was to drop it, but we should still first
apply the following hunk from it so that this line in your patch can be
skipped entirely.

    -	pclk_bpp = (u64)dsi_get_pclk_rate(msm_host->mode, is_bonded_dsi) * bpp;
    +	pclk_bpp = msm_host->pixel_clk_rate * bpp;

- Marijn
