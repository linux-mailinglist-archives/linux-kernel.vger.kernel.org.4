Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103DB661FEA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjAIIXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbjAIIV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:21:59 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C40112AB6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:21:23 -0800 (PST)
Received: from SoMainline.org (unknown [89.205.227.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id CB6EE3EEA9;
        Mon,  9 Jan 2023 09:21:19 +0100 (CET)
Date:   Mon, 9 Jan 2023 09:21:18 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] drm/msm/dpu: Remove num_enc from topology struct
 in favour of num_dsc
Message-ID: <20230109082118.v2abyucljztsflxj@SoMainline.org>
References: <20221221231943.1961117-1-marijn.suijten@somainline.org>
 <20221221231943.1961117-7-marijn.suijten@somainline.org>
 <42b45762-7fb9-2694-9fab-039ee09e4709@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42b45762-7fb9-2694-9fab-039ee09e4709@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-09 01:31:57, Dmitry Baryshkov wrote:
> On 22/12/2022 01:19, Marijn Suijten wrote:
> > Downstream calls this num_enc yet the DSC patches introduced a new
> > num_dsc struct member, leaving num_enc effectively unused.
> > 
> > Fixes: 7e9cc175b159 ("drm/msm/disp/dpu1: Add support for DSC in topology")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 9 ++++-----
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 4 ++--
> >   drivers/gpu/drm/msm/msm_drv.h               | 2 --
> >   3 files changed, 6 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > index 9c6817b5a194..a158cd502d38 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > @@ -579,19 +579,18 @@ static struct msm_display_topology dpu_encoder_get_topology(
> >   			topology.num_dspp = topology.num_lm;
> >   	}
> >   
> > -	topology.num_enc = 0;
> >   	topology.num_intf = intf_count;
> >   
> >   	if (dpu_enc->dsc) {
> > -		/* In case of Display Stream Compression (DSC), we would use
> > -		 * 2 encoders, 2 layer mixers and 1 interface
> > +		/*
> > +		 * In case of Display Stream Compression (DSC), we would use
> > +		 * 2 DSC encoders, 2 layer mixers and 1 interface
> >   		 * this is power optimal and can drive up to (including) 4k
> >   		 * screens
> >   		 */
> > -		topology.num_enc = 2;
> >   		topology.num_dsc = 2;
> > -		topology.num_intf = 1;
> >   		topology.num_lm = 2;
> > +		topology.num_intf = 1;
> 
> Unless there is a reason, please move num_intf assignment back while 
> preparing v3.

The assignment was reordered to match the order described in the comment
right above, such that this reads more naturally.  Not sure if it's
worth sending that as a separate fix, or drop it entirely.

> With that fixed:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

<snip>
