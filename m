Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF67F6FBACF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjEHWFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjEHWFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:05:12 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25830525E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 15:05:03 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3C3393F33C;
        Tue,  9 May 2023 00:05:01 +0200 (CEST)
Date:   Tue, 9 May 2023 00:04:59 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v2 07/13] drm/msm/dpu: Add SM6350 support
Message-ID: <b5vjrv7vlsdz2yxvv24abqht3q75vyctrjt36yd5s6gguuv5db@tpiulp2uplvt>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-7-5def73f50980@linaro.org>
 <k25jg7cez2kimpxr4ztbdzjr2adq6a2vjknyvfe5frxujtogfg@vhfdyt45unv6>
 <91a390b2-db3d-90f4-a2e2-6ccb75303d04@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a390b2-db3d-90f4-a2e2-6ccb75303d04@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 15:11:44, Dmitry Baryshkov wrote:
> On 27/04/2023 18:37, Marijn Suijten wrote:
> > On 2023-04-21 00:31:16, Konrad Dybcio wrote:
> >> Add SM6350 support to the DPU1 driver to enable display output.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > 
> > After addressing the comments from Dmitry (CURSOR0->DMA1 and
> > CURSOR1->DMA2), this is:
> > 
> > Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> > 
> > See below for some nits.
> 
> [...]
> 
> >> +static const struct dpu_mdp_cfg sm6350_mdp[] = {
> >> +	{
> >> +	.name = "top_0", .id = MDP_TOP,
> >> +	.base = 0x0, .len = 0x494,
> >> +	.features = 0,
> >> +	.clk_ctrls[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
> >> +	.clk_ctrls[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x2ac, .bit_off = 8 },
> >> +	.clk_ctrls[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8 },
> >> +	.clk_ctrls[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x2c4, .bit_off = 8 },
> >> +	.clk_ctrls[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },
> >> +	},
> >> +};
> >> +
> >> +static const struct dpu_ctl_cfg sm6350_ctl[] = {
> >> +	{
> >> +	.name = "ctl_0", .id = CTL_0,
> >> +	.base = 0x1000, .len = 0x1dc,
> >> +	.features = BIT(DPU_CTL_ACTIVE_CFG),
> >> +	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 9),
> >> +	},
> >> +	{
> >> +	.name = "ctl_1", .id = CTL_1,
> >> +	.base = 0x1200, .len = 0x1dc,
> >> +	.features = BIT(DPU_CTL_ACTIVE_CFG),
> >> +	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 10),
> >> +	},
> >> +	{
> >> +	.name = "ctl_2", .id = CTL_2,
> >> +	.base = 0x1400, .len = 0x1dc,
> >> +	.features = BIT(DPU_CTL_ACTIVE_CFG),
> >> +	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 11),
> >> +	},
> >> +	{
> >> +	.name = "ctl_3", .id = CTL_3,
> >> +	.base = 0x1600, .len = 0x1dc,
> >> +	.features = BIT(DPU_CTL_ACTIVE_CFG),
> >> +	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 12),
> >> +	},
> >> +};
> >> +
> >> +static const struct dpu_sspp_cfg sm6350_sspp[] = {
> >> +	SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1f8, VIG_SC7180_MASK,
> >> +		 sc7180_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
> >> +	SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1f8, DMA_SDM845_MASK,
> >> +		 sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
> >> +	SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x1f8, DMA_CURSOR_SDM845_MASK,
> >> +		 sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR0),
> >> +	SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1f8, DMA_CURSOR_SDM845_MASK,
> >> +		 sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR1),
> >> +};
> >> +
> >> +static const struct dpu_lm_cfg sm6350_lm[] = {
> >> +	LM_BLK("lm_0", LM_0, 0x44000, MIXER_SDM845_MASK,
> >> +		&sc7180_lm_sblk, PINGPONG_0, LM_1, DSPP_0),
> >> +	LM_BLK("lm_1", LM_1, 0x45000, MIXER_SDM845_MASK,
> >> +		&sc7180_lm_sblk, PINGPONG_1, LM_0, 0),
> > 
> > These two entries are indented with two tabs and have one character too
> > many to align with the opening parenthesis on the previous line.  Can we
> > please settle on a single style, as this commit mostly uses tabs+spaces
> > to align with the opening parenthesis?
> > 
> > Dmitry vouched for `cino=(0` (when in unclosed parenthesis, align next
> > line with zero extra characters to the opening parenthesis), but I find
> > double tabs more convenient as it doesn't require reindenting when
> > changing the name of the macro (which happened too often in my INTF TE
> > series).
> 
> I mainly vote for 'cino=(0' for indenting conditions (where double tab 
> is confusing) and for function calls. I do not have a strong opinion 
> about macros expansions. We have been using double-tab there, which is 
> fine with me.

Agreed on both.  `cino=(0` looks nice but double-tab in the catalog has
been easier to work with.

> Another option (which I personally find more appealing, but it doesn't 
> play well with the current guidelines) is to have all macro arguments in 
> a single line. It makes it easier to compare things.

Single line would be superb especially for current array tables.
> 
> And another option would be to expand these macros up to some point. 
> Previous experience with clock and interconnect drivers showed that 
> expanding such multi-arg acros makes it _easier_ to handle the data. 
> Counterintuitive, but true.

Fully agree, as well as inlining some flag constants.

<snip>

- Marijn
