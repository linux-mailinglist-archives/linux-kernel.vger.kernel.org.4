Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E37040F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245714AbjEOWYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243053AbjEOWYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:24:16 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F8AD870
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:24:03 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id AF8E11FA71;
        Tue, 16 May 2023 00:24:00 +0200 (CEST)
Date:   Tue, 16 May 2023 00:23:59 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/8] drm/msm/dpu: add DSC 1.2 hw blocks for relevant
 chipsets
Message-ID: <y2whfntyo2rbrg3taazjdw5sijle6k6swzl4uutcxm6tmuayh4@uxdur74uasua>
References: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
 <1683914423-17612-8-git-send-email-quic_khsieh@quicinc.com>
 <cmoqfe5nunreajdvu2vk3ztwkbjesivgejjoi2wmsxske5gq3q@lr25iuwmuevb>
 <ccef1e88-5c38-0759-523a-c957854697ef@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccef1e88-5c38-0759-523a-c957854697ef@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-15 15:03:46, Abhinav Kumar wrote:
> On 5/15/2023 2:21 PM, Marijn Suijten wrote:
> > On 2023-05-12 11:00:22, Kuogee Hsieh wrote:
> >>
> >> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>
> >> Add DSC 1.2 hardware blocks to the catalog with necessary sub-block and
> >> feature flag information.  Each display compression engine (DCE) contains
> >> dual hard slice DSC encoders so both share same base address but with
> >> its own different sub block address.
> > 
> > Can we have an explanation of hard vs soft slices in some commit message
> > and/or code documentation?
> > 
> 
> Not in this one. It wont look appropriate. I would rather remove "hard" 
> to avoid confusion.

That is totally fine, let's remove it instead.

<snip>
> >> +	DSC_BLK_1_2("dce_0", DSC_0, 0x80000, 0x100, 0, dsc_sblk_0),
> > 
> > Downstream says that the size is 0x10 (and 0x100 for the enc sblk, 0x10
> > for the ctl sblk).  This simply fills it up to the start of the enc sblk
> > so that we can see all registers in the dump?  After all only
> > DSC_CMN_MAIN_CNF is defined in the main register space, so 0x10 is
> > adequate.
> > 
> 
> .len today is always only for the dump. and yes even here we have only 
> 0x100 for the enc and 0x10 for the ctl.
> 
> +static const struct dpu_dsc_sub_blks dsc_sblk_0 = {
> +	.enc = {.base = 0x100, .len = 0x100},
> +	.ctl = {.base = 0xF00, .len = 0x10},
> +};
> 
> The issue here is that, the dpu snapshot does not handle sub_blk parsing 
> today. Its a to-do item. So for that reason, 0x100 was used here to 
> atleast get the full encoder dumps.

But then you don't see the ENC block?  It starts at 0x100 (or 0x200) so
then the length should be longer... it should in fact depend on even/odd
DCE then?

> 
> >> +	DSC_BLK_1_2("dce_0", DSC_1, 0x80000, 0x100, 0, dsc_sblk_1),
> > 
> > Should we add an extra suffix to the name to indicate which hard-slice
> > DSC encoder it is?  i.e. "dce_0_0" and "dce_0_1" etc?
> 
> Ok, that should be fine. We can add it.

Great, thanks!

> >> +	DSC_BLK_1_2("dce_1", DSC_2, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_0),
> >> +	DSC_BLK_1_2("dce_1", DSC_3, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_1),
> > 
> 
> > See comment below about loose BIT() in features.
> 
> Responded below.
> > 
> >> +};
> >> +
> >>   static const struct dpu_intf_cfg sm8350_intf[] = {
> >>   	INTF_BLK("intf_0", INTF_0, 0x34000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK,
> >>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
> >> @@ -215,6 +227,8 @@ const struct dpu_mdss_cfg dpu_sm8350_cfg = {
> >>   	.dspp = sm8350_dspp,
> >>   	.pingpong_count = ARRAY_SIZE(sm8350_pp),
> >>   	.pingpong = sm8350_pp,
> >> +	.dsc = sm8350_dsc,
> >> +	.dsc_count = ARRAY_SIZE(sm8350_dsc),
> > 
> > Count goes first **everywhere else**, let's not break consistency here.
> > 
> 
> the order of DSC entries is swapped for all chipsets. Please refer to 
> dpu_sc8180x_cfg, dpu_sm8250_cfg etc.

Thanks for confirming that this is not the case in a followup mail :)

> So if you are talking about consistency, this is actually consistent 
> with whats present in other chipsets.
> 
> If you are very particular about this, then once this lands, you can 
> change the order for all of them in another change.
> 
> Same answer for all swap comments.
<snip>
> >> +/*
> >> + * NOTE: Each display compression engine (DCE) contains dual hard
> >> + * slice DSC encoders so both share same base address but with
> >> + * its own different sub block address.
> >> + */
> >> +#define DSC_BLK_1_2(_name, _id, _base, _len, _features, _sblk) \
> > 
> > There are no address values here so this comment doesn't seem very
> > useful, and it is already duplicated on every DSC block array, where the
> > duplication is more visible.  Drop the comment here?
> > 
> 
> _base is the address. So base address. Does that clarify things?

This is referring to the NOTE: comment above.  There's _base as address
here, yes, but there's no context here that it'll be used in duplicate
fashion, unlike the SoC catalog files.  The request is to just drop it
here as it adds no value.

> >> +	{\
> >> +	.name = _name, .id = _id, \
> >> +	.base = _base, .len = _len, \
> > 
> > The len is always 0x100 (downstream says 0x10), should we hardcode it
> > here and drop _len?  We can always add it back if a future revision
> > starts changing it, but that's not the case currently.
> > 
> >> +	.features = BIT(DPU_DSC_HW_REV_1_2) | _features, \
> > 
> > We don't willy-nilly append bits like that: should there be global
> > feature flags?
> 
> So this approach is actually better. This macro is a DSC_1_2 macro so it 
> will have the 1.2 feature flag and other features like native_422 
> support of that encoder are ORed on top of it. Nothing wrong with this.

I agree it is better, but we seem to be very selective in whether to
stick to the "old" principles in DPU versus applying a new pattern that
isn't used elsewhere yet (i.e. your request to _not_ shuffle the order
of .dsc and .dsc_count assignment to match other .x and .x_count, and do
that in a future patch instead).  If we want to be consistent
everywhere, these should be #defines that we'll flatten out in a
followup if at all.

> > Or is this the start of a new era where we expand those defines in-line
> > and drop them altogether?  I'd much prefer that but we should first
> > align on this direction (and then also make the switch globally in a
> > followup).
> > 
> 
> Its case by case. No need to generalize.
> 
> In this the feature flag ORed with the base feature flag of DSC_1_2 
> makes it more clear.

- Marijn
