Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF0565AF6A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjABKSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjABKSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:18:17 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EDEF6F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:18:16 -0800 (PST)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B5BC23EE91;
        Mon,  2 Jan 2023 11:18:13 +0100 (CET)
Date:   Mon, 2 Jan 2023 11:18:12 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     phone-devel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kalyan Thota <quic_kalyant@quicinc.com>
Subject: Re: [RFC PATCH 3/7] drm/msm/dpu: Disable MDP vsync source selection
 on DPU 5.0.0 and above
Message-ID: <20230102101812.2zo6z57mdhdjueqb@SoMainline.org>
References: <20221231215006.211860-1-marijn.suijten@somainline.org>
 <20221231215006.211860-4-marijn.suijten@somainline.org>
 <20221231215254.pqaegrmldufi7ugo@SoMainline.org>
 <853cbc6e-ae49-b2be-fb64-43f5171b74e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <853cbc6e-ae49-b2be-fb64-43f5171b74e8@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-02 10:30:58, Konrad Dybcio wrote:
> 
> 
> On 31.12.2022 22:52, Marijn Suijten wrote:
> > On 2022-12-31 22:50:02, Marijn Suijten wrote:
> >> Since hardware revision 5.0.0 the TE configuration moved out of the
> >> PINGPONG block into the INTF block, including vsync source selection
> >> that was previously part of MDP top.  Writing to the MDP_VSYNC_SEL
> >> register has no effect anymore and is omitted downstream via the
> >> DPU/SDE_MDP_VSYNC_SEL feature flag.  This flag is only added to INTF
> >> blocks used by hardware prior to 5.0.0.
> >>
> >> The code that writes to these registers in the INTF block will follow in
> >> subsequent patches.
> >>
> >> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> >> ---
> >>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 33 ++++++++++--
> >>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  1 +
> >>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c    | 52 +++++++++++++------
> >>  3 files changed, 66 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> index 39d4b293710c..1cfe94494135 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> @@ -407,7 +407,7 @@ static const struct dpu_mdp_cfg msm8998_mdp[] = {
> >>  	{
> >>  	.name = "top_0", .id = MDP_TOP,
> >>  	.base = 0x0, .len = 0x458,
> >> -	.features = 0,
> >> +	.features = BIT(DPU_MDP_VSYNC_SEL),
> >>  	.highest_bank_bit = 0x2,
> >>  	.clk_ctrls[DPU_CLK_CTRL_VIG0] = {
> >>  			.reg_off = 0x2AC, .bit_off = 0},
> >> @@ -436,7 +436,7 @@ static const struct dpu_mdp_cfg sdm845_mdp[] = {
> >>  	{
> >>  	.name = "top_0", .id = MDP_TOP,
> >>  	.base = 0x0, .len = 0x45C,
> >> -	.features = BIT(DPU_MDP_AUDIO_SELECT),
> >> +	.features = BIT(DPU_MDP_AUDIO_SELECT) | BIT(DPU_MDP_VSYNC_SEL),
> >>  	.highest_bank_bit = 0x2,
> >>  	.clk_ctrls[DPU_CLK_CTRL_VIG0] = {
> >>  			.reg_off = 0x2AC, .bit_off = 0},
> >> @@ -512,6 +512,31 @@ static const struct dpu_mdp_cfg sm6115_mdp[] = {
> >>  	},
> >>  };
> >>  
> >> +static const struct dpu_mdp_cfg sdm8150_mdp[] = {
> > 
> > Sometimes it is only possible to spot such things _after_ sending,
> > probably the thing that makes us human :)
> > 
> > sm8150_mdp*, not sdm.
> > 
> > - Marijn
> > 
> >> +	{
> >> +	.name = "top_0", .id = MDP_TOP,
> >> +	.base = 0x0, .len = 0x45C,
> >> +	.features = BIT(DPU_MDP_AUDIO_SELECT),
> >> +	.highest_bank_bit = 0x2,
> >> +	.clk_ctrls[DPU_CLK_CTRL_VIG0] = {
> >> +			.reg_off = 0x2AC, .bit_off = 0},
> Keeping the hex values lowercase would be nice.

Ack, this was copied verbatim from sdm845_mdp but will cleanup as we go.
Looks like this file has a mixed approach towards lower and uppercase,
when does the normalization patch land?

- Marijn
